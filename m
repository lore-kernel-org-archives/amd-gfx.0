From: Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: insist on 32-bit DMA for Cedar
Date: Thu, 22 Feb 2018 10:55:58 -0500
Message-ID: <CALk+eRcPH+g-eBMKWyO4FrPwuc_VLnp_w89WYKNE51=iV5Y=wg@mail.gmail.com>
References: <20180221234154.6877-1-bcrocker@redhat.com>
 <CADnq5_M8ZiV2b+LW5oKu0XSQOJvg9idvZ6eBOaHMJRPC2iMj3w@mail.gmail.com>
 <7d6a06dc-9e88-2427-ec6a-4f48b9aa8f6b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2003661887=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7d6a06dc-9e88-2427-ec6a-4f48b9aa8f6b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2003661887==
Content-Type: multipart/alternative; boundary="94eb2c065f48d17a590565cf1677"

--94eb2c065f48d17a590565cf1677
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex, Christian, et al.

Thanks for your rapid response!

I can certainly make the change PPC-only (#ifdef CONFIG_PPC64...) and I
think
that's the safest way to go right now.  It makes the patch very specific to
Cedar
on PowerPC64, so it doesn't break anything that may have come to depend on
Russell's and Alistair's changes, and my timetable for getting a fix in is
very short.

-- Ben



On Thu, Feb 22, 2018 at 2:25 AM, Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 22.02.2018 um 03:05 schrieb Alex Deucher:
>
>> On Wed, Feb 21, 2018 at 6:41 PM, Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
>>
>>> In radeon_device_init, set the need_dma32 flag for Cedar chips
>>> (e.g. FirePro 2270).  This fixes, or at least works around, a bug
>>> on PowerPC exposed by last year's commits
>>>
>>> 8e3f1b1d8255105f31556aacf8aeb6071b00d469 (Russell Currey)
>>>
>>> and
>>>
>>> 253fd51e2f533552ae35a0c661705da6c4842c1b (Alistair Popple)
>>>
>>> which enabled the 64-bit DMA iommu bypass.
>>>
>>> This caused the device to freeze, in some cases unrecoverably, and is
>>> the subject of several bug reports internal to Red Hat.
>>>
>> Can we make this ppc only?  40 bit DMA works fine on x86.
>>
>
> Yeah and at least when the dma_coherent allocator path is used it should
> work fine on PPC as well.
>
> So that is not really a driver bug, but a platform bug and we should thin=
k
> about reverting or at least disabling those two patches instead.
>
> Christian.
>
>
>> Alex
>>
>> Signed-off-by: Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/radeon/radeon_device.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/radeon/radeon_device.c
>>> b/drivers/gpu/drm/radeon/radeon_device.c
>>> index ffc10cadcf34..02538903830d 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_device.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_device.c
>>> @@ -1395,7 +1395,10 @@ int radeon_device_init(struct radeon_device *rde=
v,
>>>          if (rdev->flags & RADEON_IS_AGP)
>>>                  rdev->need_dma32 =3D true;
>>>          if ((rdev->flags & RADEON_IS_PCI) &&
>>> -           (rdev->family <=3D CHIP_RS740))
>>> +           (rdev->family <=3D CHIP_RS740 || rdev->family =3D=3D CHIP_C=
EDAR))
>>> +               rdev->need_dma32 =3D true;
>>> +       if ((rdev->flags & RADEON_IS_PCIE) &&
>>> +           (rdev->family =3D=3D CHIP_CEDAR))
>>>                  rdev->need_dma32 =3D true;
>>>
>>>          dma_bits =3D rdev->need_dma32 ? 32 : 40;
>>> --
>>> 2.13.6
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>

--94eb2c065f48d17a590565cf1677
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Alex, Christian, et al.<br><=
br></div>Thanks for your rapid response!<br><br></div>I can certainly make =
the change PPC-only (#ifdef CONFIG_PPC64...) and I think<br></div>that&#39;=
s the safest way to go right now.=C2=A0 It makes the patch very specific to=
 Cedar<br></div>on PowerPC64, so it doesn&#39;t break anything that may hav=
e come to depend on<br></div>Russell&#39;s and Alistair&#39;s changes, and =
my timetable for getting a fix in is very short.<br><br></div>-- Ben<br><br=
><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">On Thu, Feb 22, 2018 at 2:25 AM, Christian K=C3=B6nig <span dir=3D"ltr=
">&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank"=
>ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><span class=3D"">Am 22.02.2018 um 03:05 schrieb Alex Deucher=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Wed, Feb 21, 2018 at 6:41 PM, Ben Crocker &lt;<a href=3D"mailto:bcrocker=
@redhat.com" target=3D"_blank">bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
In radeon_device_init, set the need_dma32 flag for Cedar chips<br>
(e.g. FirePro 2270).=C2=A0 This fixes, or at least works around, a bug<br>
on PowerPC exposed by last year&#39;s commits<br>
<br>
8e3f1b1d8255105f31556aacf8aeb6<wbr>071b00d469 (Russell Currey)<br>
<br>
and<br>
<br>
253fd51e2f533552ae35a0c661705d<wbr>a6c4842c1b (Alistair Popple)<br>
<br>
which enabled the 64-bit DMA iommu bypass.<br>
<br>
This caused the device to freeze, in some cases unrecoverably, and is<br>
the subject of several bug reports internal to Red Hat.<br>
</blockquote>
Can we make this ppc only?=C2=A0 40 bit DMA works fine on x86.<br>
</blockquote>
<br></span>
Yeah and at least when the dma_coherent allocator path is used it should wo=
rk fine on PPC as well.<br>
<br>
So that is not really a driver bug, but a platform bug and we should think =
about reverting or at least disabling those two patches instead.<br>
<br>
Christian.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div class=3D"h5">
<br>
Alex<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Signed-off-by: Ben Crocker &lt;<a href=3D"mailto:bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" targe=
t=3D"_blank">bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>device.c | 5 ++++-<br>
=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_device.c b/drivers/gpu/drm/=
radeon/radeo<wbr>n_device.c<br>
index ffc10cadcf34..02538903830d 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_device.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_device.c<br>
@@ -1395,7 +1395,10 @@ int radeon_device_init(struct radeon_device *rdev,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;flags &amp; RADEON_IS_AGP)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;need=
_dma32 =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((rdev-&gt;flags &amp; RADEON_IS_PCI) =
&amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family &lt;=3D CHIP_RS7=
40))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family &lt;=3D CHIP_RS7=
40 || rdev-&gt;family =3D=3D CHIP_CEDAR))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;need_dma32=
 =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((rdev-&gt;flags &amp; RADEON_IS_PCIE) &amp;=
&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family =3D=3D CHIP_CEDA=
R))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;need=
_dma32 =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_bits =3D rdev-&gt;need_dma32 ? 32 : 4=
0;<br>
--<br>
2.13.6<br>
<br>
______________________________<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">dri-de=
vel-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org<wbr>g</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</blockquote></div></div>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
<br>
</blockquote></div><br></div>

--94eb2c065f48d17a590565cf1677--

--===============2003661887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2003661887==--
