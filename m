From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: FW: [PATCH] drm/ttm: fix ttm client driver (e.g. amdgpu) reload
 issue
Date: Thu, 6 Jun 2019 15:15:59 +0000
Message-ID: <BN6PR12MB1809F73FCA1AC3CA8B91CD1AF7170@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1559717076-25471-1-git-send-email-Monk.Liu@amd.com>
 <MN2PR12MB393308FE408E9E41EF0D615184160@MN2PR12MB3933.namprd12.prod.outlook.com>
 <8dbf96e5-056f-b2bb-b0d3-9376b92b0140@amd.com>
 <MN2PR12MB39334AC8143DDBC1AA7587E884160@MN2PR12MB3933.namprd12.prod.outlook.com>
 <bb88e890-84c4-5405-85c6-59f02d5a7a61@amd.com>,
 <1ef221b9-f29e-cbd2-488a-d5d0b349e45f@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1266127080=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1ef221b9-f29e-cbd2-488a-d5d0b349e45f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1266127080==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F73FCA1AC3CA8B91CD1AF7170BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F73FCA1AC3CA8B91CD1AF7170BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It's upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dbd4264112f93045704731850c5e4d85db981cd85
and in drm-next:
https://cgit.freedesktop.org/drm/drm/commit/?id=3Dbd4264112f93045704731850c=
5e4d85db981cd85
and in amd-staging-drm-next:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-staging-drm-next&=
id=3Dbd4264112f93045704731850c5e4d85db981cd85

Where are you seeing it missing?

Alex
________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, June 6, 2019 10:00 AM
To: Koenig, Christian; Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, A=
lexander
Subject: Re: FW: [PATCH] drm/ttm: fix ttm client driver (e.g. amdgpu) reloa=
d issue

It is part of amd-staging-drm-next and has Alex Signed-of by tag.

So it should definitely be upstream, Alex any idea why that patch isn't
in drm-next?

Christian.

Am 05.06.19 um 20:10 schrieb Koenig, Christian:
> Mhm, looks like that somehow got dropped during rebase.
>
> Going to dig up where that actually ended up tomorrow.
>
> Christian.
>
> Am 05.06.19 um 16:44 schrieb Liu, Monk:
>> Strange, I get the latest "drm-next" branch and didn't see the change la=
nded ....
>>
>> /Monk
>>
>> -----Original Message-----
>> From: Koenig, Christian
>> Sent: Wednesday, June 5, 2019 7:11 PM
>> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Re: FW: [PATCH] drm/ttm: fix ttm client driver (e.g. amdgpu) re=
load issue
>>
>> This should already be fixed by patch "drm/ttm: fix re-init of global st=
ructures".
>>
>> Christian.
>>
>> Am 05.06.19 um 09:29 schrieb Liu, Monk:
>>> -----Original Message-----
>>> From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>>> Sent: Wednesday, June 5, 2019 2:45 PM
>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Cc: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>>> Subject: [PATCH] drm/ttm: fix ttm client driver (e.g. amdgpu) reload
>>> issue
>>>
>>> need to clear bo glob and mem glob during their release otherwise their=
 member value would be wrongly used in the next glob init stage and lead to=
 wild pointer access problems:
>>>
>>> 1) kobj.state_initialized is 1
>>> 2) ttm_bo_glob.bo_count isn't cleared and referenced via it
>>>       on member "swap_lru" would hit out of bound array accessing
>>>       bug
>>>
>>> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>     drivers/gpu/drm/ttm/ttm_bo.c     | 2 ++
>>>     drivers/gpu/drm/ttm/ttm_memory.c | 8 ++++++++
>>>     2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
>>> b/drivers/gpu/drm/ttm/ttm_bo.c index c7de667..6434eac 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -1604,6 +1604,8 @@ static void ttm_bo_global_kobj_release(struct kob=
ject *kobj)
>>>              container_of(kobj, struct ttm_bo_global, kobj);
>>>
>>>      __free_page(glob->dummy_read_page);
>>> +
>>> +   memset(glob, 0, sizeof(*glob));
>>>     }
>>>
>>>     static void ttm_bo_global_release(void) diff --git
>>> a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
>>> index 8617958..7128bbf 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_memory.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_memory.c
>>> @@ -229,9 +229,17 @@ static const struct sysfs_ops ttm_mem_global_ops =
=3D {
>>>      .store =3D &ttm_mem_global_store,
>>>     };
>>>
>>> +void ttm_mem_glob_kobj_release(struct kobject *kobj) {
>>> +   struct ttm_mem_global *glob =3D container_of(kobj, struct
>>> +ttm_mem_global, kobj);
>>> +
>>> +   memset(glob, 0, sizeof(*glob));
>>> +}
>>> +
>>>     static struct kobj_type ttm_mem_glob_kobj_type =3D {
>>>      .sysfs_ops =3D &ttm_mem_global_ops,
>>>      .default_attrs =3D ttm_mem_global_attrs,
>>> +   .release =3D ttm_mem_glob_kobj_release,
>>>     };
>>>
>>>     static bool ttm_zones_above_swap_target(struct ttm_mem_global *glob=
,
>>> --
>>> 2.7.4
>>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_BN6PR12MB1809F73FCA1AC3CA8B91CD1AF7170BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
It's upstream:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3Dbd4264112f93045704731850c5e4d85db981cd85" id=3D"LPlnk109861=
">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dbd4264112f93045704731850c5e4d85db981cd85</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
and in drm-next:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://cgit.freedesktop.org/drm/drm/commit/?id=3Dbd4264112f9304=
5704731850c5e4d85db981cd85" id=3D"LPlnk491710">https://cgit.freedesktop.org=
/drm/drm/commit/?id=3Dbd4264112f93045704731850c5e4d85db981cd85</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
and in amd-staging-drm-next:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-stagin=
g-drm-next&amp;id=3Dbd4264112f93045704731850c5e4d85db981cd85" id=3D"LPlnk78=
0545">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-staging-drm=
-next&amp;id=3Dbd4264112f93045704731850c5e4d85db981cd85</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Where are you seeing it missing?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 6, 2019 10:00 AM<br>
<b>To:</b> Koenig, Christian; Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deu=
cher, Alexander<br>
<b>Subject:</b> Re: FW: [PATCH] drm/ttm: fix ttm client driver (e.g. amdgpu=
) reload issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It is part of amd-staging-drm-next and has Alex Si=
gned-of by tag.<br>
<br>
So it should definitely be upstream, Alex any idea why that patch isn't <br=
>
in drm-next?<br>
<br>
Christian.<br>
<br>
Am 05.06.19 um 20:10 schrieb Koenig, Christian:<br>
&gt; Mhm, looks like that somehow got dropped during rebase.<br>
&gt;<br>
&gt; Going to dig up where that actually ended up tomorrow.<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 05.06.19 um 16:44 schrieb Liu, Monk:<br>
&gt;&gt; Strange, I get the latest &quot;drm-next&quot; branch and didn't s=
ee the change landed ....<br>
&gt;&gt;<br>
&gt;&gt; /Monk<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Koenig, Christian<br>
&gt;&gt; Sent: Wednesday, June 5, 2019 7:11 PM<br>
&gt;&gt; To: Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
&gt;&gt; Subject: Re: FW: [PATCH] drm/ttm: fix ttm client driver (e.g. amdg=
pu) reload issue<br>
&gt;&gt;<br>
&gt;&gt; This should already be fixed by patch &quot;drm/ttm: fix re-init o=
f global structures&quot;.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 05.06.19 um 09:29 schrieb Liu, Monk:<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; Sent: Wednesday, June 5, 2019 2:45 PM<br>
&gt;&gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; Cc: Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; Subject: [PATCH] drm/ttm: fix ttm client driver (e.g. amdgpu) =
reload<br>
&gt;&gt;&gt; issue<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; need to clear bo glob and mem glob during their release otherw=
ise their member value would be wrongly used in the next glob init stage an=
d lead to wild pointer access problems:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 1) kobj.state_initialized is 1<br>
&gt;&gt;&gt; 2) ttm_bo_glob.bo_count isn't cleared and referenced via it<br=
>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; on member &quot;swap_lru&q=
uot; would hit out of bound array accessing<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bug<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/ttm/ttm_bo.c&nbsp;&nbs=
p;&nbsp;&nbsp; | 2 &#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/ttm/ttm_memory.c | 8 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2 files changed, 10 insertions(&#43;)<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/ttm/ttm_bo.c index c7de667..6434eac 100644<b=
r>
&gt;&gt;&gt; --- a/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt;&gt;&gt; @@ -1604,6 &#43;1604,8 @@ static void ttm_bo_global_kobj_relea=
se(struct kobject *kobj)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; container_of(kobj, struct ttm_bo_global, kobj);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __free_page(glob-&gt;dummy_read_=
page);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; memset(glob, 0, sizeof(*glob));<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; static void ttm_bo_global_release(void=
) diff --git<br>
&gt;&gt;&gt; a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_m=
emory.c<br>
&gt;&gt;&gt; index 8617958..7128bbf 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/ttm/ttm_memory.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/ttm/ttm_memory.c<br>
&gt;&gt;&gt; @@ -229,9 &#43;229,17 @@ static const struct sysfs_ops ttm_mem=
_global_ops =3D {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .store =3D &amp;ttm_mem_global_s=
tore,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt; &#43;void ttm_mem_glob_kobj_release(struct kobject *kobj) {<br=
>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; struct ttm_mem_global *glob =3D container_of=
(kobj, struct<br>
&gt;&gt;&gt; &#43;ttm_mem_global, kobj);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; memset(glob, 0, sizeof(*glob));<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; static struct kobj_type ttm_mem_glob_k=
obj_type =3D {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sysfs_ops =3D &amp;ttm_mem_glob=
al_ops,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .default_attrs =3D ttm_mem_globa=
l_attrs,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; .release =3D ttm_mem_glob_kobj_release,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; static bool ttm_zones_above_swap_targe=
t(struct ttm_mem_global *glob,<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.7.4<br>
&gt;&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F73FCA1AC3CA8B91CD1AF7170BN6PR12MB1809namp_--

--===============1266127080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1266127080==--
