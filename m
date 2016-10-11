From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read
Date: Tue, 11 Oct 2016 12:19:14 +0000
Message-ID: <CY4PR12MB1768134851FB1F505F746843F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161010125128.18303-1-tom.stdenis@amd.com>
 <91da2060-e6d4-70c9-2ceb-69218e1058ba@vodafone.de>
 <CAAzXoRJKusZrvv7obpZ-0tR39pVmdc-7Y8prKCsRC6bchmsOcA@mail.gmail.com>
 <3c1d969b-0141-ef29-1e0f-5267d8a7cae9@vodafone.de>
 <CY4PR12MB1768813E554E6DB1A40F5848F7DB0@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <50dc12b3-a6bd-ed35-ac8f-e55909d184d2@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0754868406=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <50dc12b3-a6bd-ed35-ac8f-e55909d184d2-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0754868406==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768134851FB1F505F746843F7DA0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768134851FB1F505F746843F7DA0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


I agree with the crux of your argument but you can crash the system with ca=
refully timed read/writes from the GFX registers, or MC, or ... That's why =
the entries are root only.


The issue with locking excessively is you might change behaviour of somethi=
ng you're trying to debug because the kernel then has to wait on the lock (=
or you're waiting on the lock).  For instance, suppose you want to read DCE=
 registers and the kernel is doing some gfx/grbm related your DCE read will=
 either block the GFX activity or you're waiting on it which means the beha=
viour of the system could be different than from the case where you're not =
probing the registers.


The goal is to be as unobtrusive as possible.  Heck I often mmap the BAR so=
 I can read MMIO registers directly and not waste CPU cycles on syscalls.

The PM lock is because reading PGFSM registers during a powerup/down result=
s in a GPU hang, and we only take the GRBM lock when users want to read fro=
m specific banks.  For any other case we don't need a lock.  In the kernel =
they should be mutually exclusive.  The PM lock is only taken in PP when pe=
rforming a transition (or initializing the core) and I have yet to see a pl=
ace where PP/PM related code also grabs the grbm index lock.

I don't have strong feelings against your proposal but I do prefer not to t=
ake the locks when I don't need to.  Ultimately I'll leave the decision up =
to you and Alex.  I'd like to get the 2nd patch through though as it makes =
the write side of the mmio reg complimentary (e.g. bank selection/pm lock).

Cheers,
Tom

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, October 11, 2016 08:11
To: StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read


The only downside to taking the locks all the time is for 99% of debug read=
s it's unnecessary and in theory could lead to performance/behaviour proble=
ms.

Yeah, but performance isn't critical here and taking two locks compared to =
the rest of what we (IOCTL etc...) do is completely negligibly.


I've been using this on read for a while now and haven't noticed a problem.

My concern is rather that somebody tries to write to the PM regs on acciden=
t or purpose without taking the lock.

See, the kernel is usually responsible to keep people from doing stupid thi=
ngs with the hardware, even if those people are root and could do stupid th=
ings anyway. Well, you know what I mean?

Regards,
Christian.

Am 10.10.2016 um 22:21 schrieb StDenis, Tom:

The only downside to taking the locks all the time is for 99% of debug read=
s it's unnecessary and in theory could lead to performance/behaviour proble=
ms.


I've been using this on read for a while now and haven't noticed a problem.


Tom


________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org><mailto:deathsimple@vodafo=
ne.de>
Sent: Monday, October 10, 2016 09:49
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>
Cc: StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read

Would it hurt us to always take the looks (both the pm as well as grbm idx =
lock)?

I don't think that would be much of an issue and I would have a better feel=
ing with that.

Christian.

Am 10.10.2016 um 15:38 schrieb Tom St Denis:

that's kind of the point.  Its for debugging only.  Also reads can already =
lock

On Mon, Oct 10, 2016, 09:25 Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org<mail=
to:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
Mhm, that userspace controls if the lock is taken or not is a bit
problematic, on the other hand only root could access that.

Christian.

Am 10.10.2016 um 14:51 schrieb Tom St Denis:
> Add PG lock support as well as bank selection to
> the MMIO write function.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis@amd.c=
om>>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 +++++++++++++++++++++++=
+++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 04c4aee70452..a9d83c1d7a43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2637,10 +2637,45 @@ static ssize_t amdgpu_debugfs_regs_write(struct f=
ile *f, const char __user *buf,
>       struct amdgpu_device *adev =3D f->f_inode->i_private;
>       ssize_t result =3D 0;
>       int r;
> +     bool pm_pg_lock, use_bank;
> +     unsigned instance_bank, sh_bank, se_bank;
>
>       if (size & 0x3 || *pos & 0x3)
>               return -EINVAL;
>
> +     /* are we reading registers for which a PG lock is necessary? */
> +     pm_pg_lock =3D (*pos >> 23) & 1;
> +
> +     if (*pos & (1ULL << 62)) {
> +             se_bank =3D (*pos >> 24) & 0x3FF;
> +             sh_bank =3D (*pos >> 34) & 0x3FF;
> +             instance_bank =3D (*pos >> 44) & 0x3FF;
> +
> +             if (se_bank =3D=3D 0x3FF)
> +                     se_bank =3D 0xFFFFFFFF;
> +             if (sh_bank =3D=3D 0x3FF)
> +                     sh_bank =3D 0xFFFFFFFF;
> +             if (instance_bank =3D=3D 0x3FF)
> +                     instance_bank =3D 0xFFFFFFFF;
> +             use_bank =3D 1;
> +     } else {
> +             use_bank =3D 0;
> +     }
> +
> +     *pos &=3D 0x3FFFF;
> +
> +     if (use_bank) {
> +             if ((sh_bank !=3D 0xFFFFFFFF && sh_bank >=3D adev->gfx.conf=
ig.max_sh_per_se) ||
> +                 (se_bank !=3D 0xFFFFFFFF && se_bank >=3D adev->gfx.conf=
ig.max_shader_engines))
> +                     return -EINVAL;
> +             mutex_lock(&adev->grbm_idx_mutex);
> +             amdgpu_gfx_select_se_sh(adev, se_bank,
> +                                     sh_bank, instance_bank);
> +     }
> +
> +     if (pm_pg_lock)
> +             mutex_lock(&adev->pm.mutex);
> +
>       while (size) {
>               uint32_t value;
>
> @@ -2659,6 +2694,14 @@ static ssize_t amdgpu_debugfs_regs_write(struct fi=
le *f, const char __user *buf,
>               size -=3D 4;
>       }
>
> +     if (use_bank) {
> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff);
> +             mutex_unlock(&adev->grbm_idx_mutex);
> +     }
> +
> +     if (pm_pg_lock)
> +             mutex_unlock(&adev->pm.mutex);
> +
>       return result;
>   }
>





--_000_CY4PR12MB1768134851FB1F505F746843F7DA0CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Christian,</p>
<p><br>
</p>
<p>I agree with the crux of your argument but you can crash the system with=
 carefully timed read/writes from the GFX registers, or MC, or ... That's w=
hy the entries are root only.</p>
<p><br>
</p>
<p>The issue with locking excessively is you might change behaviour of some=
thing you're trying to debug because the kernel then has to wait on the loc=
k (or you're waiting on the lock). &nbsp;For instance, suppose you want to =
read DCE registers and the kernel is
 doing some gfx/grbm related your DCE read will either block the GFX activi=
ty or you're waiting on it which means the behaviour of the system could be=
 different than from the case where you're not probing the registers.</p>
<p><br>
</p>
<p>The goal is to be as unobtrusive as possible. &nbsp;Heck I often mmap th=
e BAR so I can read MMIO registers directly and not waste CPU cycles on sys=
calls.</p>
<div><br>
</div>
The PM lock is because reading PGFSM registers during a powerup/down result=
s in a GPU hang, and we only take the GRBM lock when users want to read fro=
m specific banks. &nbsp;For any other case we don't need a lock. &nbsp;In t=
he kernel they should be mutually exclusive.
 &nbsp;The PM lock is only taken in PP when performing a transition (or ini=
tializing the core) and I have yet to see a place where PP/PM related code =
also grabs the grbm index lock.
<div><br>
</div>
<div>I don't have strong feelings against your proposal but I do prefer not=
 to take the locks when I don't need to. &nbsp;Ultimately I'll leave the de=
cision up to you and Alex. &nbsp;I'd like to get the 2nd patch through thou=
gh as it makes the write side of the mmio
 reg complimentary (e.g. bank selection/pm lock).<br>
<div><br>
</div>
<div>Cheers,</div>
<div>Tom<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 11, 2016 08:11<br>
<b>To:</b> StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment r=
ead</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">
<blockquote type=3D"cite">
<p>The only downside to taking the locks all the time is for 99% of debug r=
eads it's unnecessary and in theory could lead to performance/behaviour pro=
blems.</p>
</blockquote>
Yeah, but performance isn't critical here and taking two locks compared to =
the rest of what we (IOCTL etc...) do is completely negligibly.
<br>
<br>
<blockquote type=3D"cite">
<p>I've been using this on read for a while now and haven't noticed a probl=
em.</p>
</blockquote>
My concern is rather that somebody tries to write to the PM regs on acciden=
t or purpose without taking the lock.<br>
<br>
See, the kernel is usually responsible to keep people from doing stupid thi=
ngs with the hardware, even if those people are root and could do stupid th=
ings anyway. Well, you know what I mean?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 10.10.2016 um 22:21 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">
<p>The only downside to taking the locks all the time is for 99% of debug r=
eads it's unnecessary and in theory could lead to performance/behaviour pro=
blems.</p>
<p><br>
</p>
<p>I've been using this on read for a while now and haven't noticed a probl=
em.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Calib=
ri, sans-serif" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">=
&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
<b>Sent:</b> Monday, October 10, 2016 09:49<br>
<b>To:</b> Tom St Denis; <a class=3D"moz-txt-link-abbreviated" href=3D"mail=
to:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment r=
ead</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">Would it hurt us to always take the looks (b=
oth the pm as well as grbm idx lock)?<br>
<br>
I don't think that would be much of an issue and I would have a better feel=
ing with that.<br>
<br>
Christian.<br>
<br>
Am 10.10.2016 um 15:38 schrieb Tom St Denis:<br>
</div>
<blockquote type=3D"cite">
<p dir=3D"ltr">that's kind of the point.&nbsp; Its for debugging only.&nbsp=
; Also reads can already lock</p>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Mon, Oct 10, 2016, 09:25 Christian K=F6nig &lt;<a href=
=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<=
br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=0A=
                  .8ex; border-left:1px #ccc solid; padding-left:1ex">
Mhm, that userspace controls if the lock is taken or not is a bit<br class=
=3D"gmail_msg">
problematic, on the other hand only root could access that.<br class=3D"gma=
il_msg">
<br class=3D"gmail_msg">
Christian.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Am 10.10.2016 um 14:51 schrieb Tom St Denis:<br class=3D"gmail_msg">
&gt; Add PG lock support as well as bank selection to<br class=3D"gmail_msg=
">
&gt; the MMIO write function.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
 class=3D"gmail_msg" target=3D"_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=
=3D"gmail_msg">
&gt; ---<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 &#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br class=
=3D"gmail_msg">
&gt;&nbsp; &nbsp;1 file changed, 43 insertions(&#43;)<br class=3D"gmail_msg=
">
&gt;<br class=3D"gmail_msg">
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg">
&gt; index 04c4aee70452..a9d83c1d7a43 100644<br class=3D"gmail_msg">
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg=
">
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=
=3D"gmail_msg">
&gt; @@ -2637,10 &#43;2637,45 @@ static ssize_t amdgpu_debugfs_regs_write(s=
truct file *f, const char __user *buf,<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp;struct amdgpu_device *adev =3D f-&gt;f_inode=
-&gt;i_private;<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp;ssize_t result =3D 0;<br class=3D"gmail_msg"=
>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;int r;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;bool pm_pg_lock, use_bank;<br class=3D"gmail_=
msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;unsigned instance_bank, sh_bank, se_bank;<br =
class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp;if (size &amp; 0x3 || *pos &amp; 0x3)<br cla=
ss=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<=
br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;/* are we reading registers for which a PG lo=
ck is necessary? */<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;pm_pg_lock =3D (*pos &gt;&gt; 23) &amp; 1;<br=
 class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;if (*pos &amp; (1ULL &lt;&lt; 62)) {<br class=
=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;se_bank =3D (*pos=
 &gt;&gt; 24) &amp; 0x3FF;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sh_bank =3D (*pos=
 &gt;&gt; 34) &amp; 0x3FF;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;instance_bank =3D=
 (*pos &gt;&gt; 44) &amp; 0x3FF;<br class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (se_bank =3D=
=3D 0x3FF)<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;se_bank =3D 0xFFFFFFFF;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (sh_bank =3D=
=3D 0x3FF)<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;sh_bank =3D 0xFFFFFFFF;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (instance_bank=
 =3D=3D 0x3FF)<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;instance_bank =3D 0xFFFFFFFF;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;use_bank =3D 1;<b=
r class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;} else {<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;use_bank =3D 0;<b=
r class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;}<br class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;*pos &amp;=3D 0x3FFFF;<br class=3D"gmail_msg"=
>
&gt; &#43;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;if (use_bank) {<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((sh_bank !=3D=
 0xFFFFFFFF &amp;&amp; sh_bank &gt;=3D adev-&gt;gfx.config.max_sh_per_se) |=
|<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(se=
_bank !=3D 0xFFFFFFFF &amp;&amp; se_bank &gt;=3D adev-&gt;gfx.config.max_sh=
ader_engines))<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;return -EINVAL;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mutex_lock(&amp;a=
dev-&gt;grbm_idx_mutex);<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_gfx_select=
_se_sh(adev, se_bank,<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sh_bank,=
 instance_bank);<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;}<br class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;if (pm_pg_lock)<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mutex_lock(&amp;a=
dev-&gt;pm.mutex);<br class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp;while (size) {<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint32_t value;<=
br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; @@ -2659,6 &#43;2694,14 @@ static ssize_t amdgpu_debugfs_regs_write(st=
ruct file *f, const char __user *buf,<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;size -=3D 4;<br =
class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;if (use_bank) {<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_gfx_select=
_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mutex_unlock(&amp=
;adev-&gt;grbm_idx_mutex);<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;}<br class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp;if (pm_pg_lock)<br class=3D"gmail_msg">
&gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mutex_unlock(&amp=
;adev-&gt;pm.mutex);<br class=3D"gmail_msg">
&gt; &#43;<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp; &nbsp; &nbsp;return result;<br class=3D"gmail_msg">
&gt;&nbsp; &nbsp;}<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
</blockquote>
</div>
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768134851FB1F505F746843F7DA0CY4PR12MB1768namp_--

--===============0754868406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0754868406==--
