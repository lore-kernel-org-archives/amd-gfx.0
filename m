From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: How to gracefully handle pci remove
Date: Wed, 29 Aug 2018 18:52:18 +0000
Message-ID: <BN6PR12MB1809CE0660C2614CCD706774F7090@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <3460a3cb-91b9-3f3c-22af-d61b72a53454@amd.com>
 <02a4e04d-6f6d-ea00-5345-abbcc5b86176@amd.com>
 <CAKMK7uGEsERMvipQaC1_fY2AAmrJfANH4t3wOCZj83X=PpzNPA@mail.gmail.com>,
 <7e7f7ab2-0b39-0aeb-14b5-79a42999bc64@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0478569145=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7e7f7ab2-0b39-0aeb-14b5-79a42999bc64-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, =?iso-8859-1?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0478569145==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809CE0660C2614CCD706774F7090BN6PR12MB1809namp_"

--_000_BN6PR12MB1809CE0660C2614CCD706774F7090BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Take a look at what the udl drm driver does.  It's a usb display chip.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andrey G=
rodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 29, 2018 2:28:42 PM
To: Daniel Vetter; Noralf Tr=F8nnes
Cc: Dave Airlie; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ML dri-devel; Koenig, Chris=
tian
Subject: Re: How to gracefully handle pci remove

Actually, I've just spotted this drm_dev_unplug, does it make sense to
use it in our pci_driver.remove hook

instead of explicitly doing drm_dev_unregister and drm_dev_put(dev) ?

This way at least any following IOCTL will fail with ENODEV.

Andrey


On 08/29/2018 11:07 AM, Daniel Vetter wrote:
> On Wed, Aug 29, 2018 at 4:43 PM, Andrey Grodzovsky
> <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org> wrote:
>> Just another ping...
>>
>> Daniel, Dave - maybe you could give some advise on that ?
>>
>> P.S I tried with Intel card (i915) driver on 4.18.1 kernel to do the sam=
e to
>> get some reference point, but it just hanged.
> drm_device hot-unplug is defacto unsolved. We've only just started to
> fix the most obvious races around the refcounting of drm_device
> it'self, see the work from Noralf Tronnes around drm_dev_get/put.
>
> No one has even started to think about what it would take to correctly
> refcount a full-blown memory manager to handle hotunplug. I'd expect
> lots of nightmares. The real horror is that it's not just the
> drm_device, but also lots of things we're exporting: dma_buf,
> dma_fence, ... All of that must be handled one way or the other.
>
> So expect your kernel to Oops when you unplug a device.
>
> Wrt userspace handling this: Probably an even bigger question. No
> idea, and will depend upon what userspace you're running.
> -Daniel
>
>> Andrey
>>
>>
>>
>>
>> On 08/27/2018 12:04 PM, Andrey Grodzovsky wrote:
>>> Hi everybody , I am trying to resolve various problems I observe when
>>> logically removing AMDGPU device from pci - echo 1 >
>>> /sys/class/drm/card0/device/remove
>>>
>>> One of the problems I encountered was hitting WARNs  in
>>> amdgpu_gem_force_release. It complaints  about still open client FDs an=
d BOs
>>> allocations which is obvious since
>>>
>>> we didn't let user space clients know about the device removal and henc=
e
>>> they won't release allocations and won't close their FDs.
>>>
>>> Question - how other drivers handle this use case, especially eGPUs sin=
ce
>>> they indeed may be extracted in any moment, is there any way to notify =
Xorg
>>> and other clients about this so they may
>>>
>>> have a chance to release all their allocations and probably terminate ?
>>> Maybe some kind of uevent ?
>>>
>>> Andrey
>>>
>
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809CE0660C2614CCD706774F7090BN6PR12MB1809namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Take a look at what the udl drm d=
river does.&nbsp; It's a usb display chip.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Andrey Grodzovsky &lt;Andrey.=
Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 29, 2018 2:28:42 PM<br>
<b>To:</b> Daniel Vetter; Noralf Tr=F8nnes<br>
<b>Cc:</b> Dave Airlie; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ML dri-devel; Koenig=
, Christian<br>
<b>Subject:</b> Re: How to gracefully handle pci remove</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Actually, I've just spotted this drm_dev_unplug, d=
oes it make sense to
<br>
use it in our pci_driver.remove hook<br>
<br>
instead of explicitly doing drm_dev_unregister and drm_dev_put(dev) ?<br>
<br>
This way at least any following IOCTL will fail with ENODEV.<br>
<br>
Andrey<br>
<br>
<br>
On 08/29/2018 11:07 AM, Daniel Vetter wrote:<br>
&gt; On Wed, Aug 29, 2018 at 4:43 PM, Andrey Grodzovsky<br>
&gt; &lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;&gt; Just another ping...<br>
&gt;&gt;<br>
&gt;&gt; Daniel, Dave - maybe you could give some advise on that ?<br>
&gt;&gt;<br>
&gt;&gt; P.S I tried with Intel card (i915) driver on 4.18.1 kernel to do t=
he same to<br>
&gt;&gt; get some reference point, but it just hanged.<br>
&gt; drm_device hot-unplug is defacto unsolved. We've only just started to<=
br>
&gt; fix the most obvious races around the refcounting of drm_device<br>
&gt; it'self, see the work from Noralf Tronnes around drm_dev_get/put.<br>
&gt;<br>
&gt; No one has even started to think about what it would take to correctly=
<br>
&gt; refcount a full-blown memory manager to handle hotunplug. I'd expect<b=
r>
&gt; lots of nightmares. The real horror is that it's not just the<br>
&gt; drm_device, but also lots of things we're exporting: dma_buf,<br>
&gt; dma_fence, ... All of that must be handled one way or the other.<br>
&gt;<br>
&gt; So expect your kernel to Oops when you unplug a device.<br>
&gt;<br>
&gt; Wrt userspace handling this: Probably an even bigger question. No<br>
&gt; idea, and will depend upon what userspace you're running.<br>
&gt; -Daniel<br>
&gt;<br>
&gt;&gt; Andrey<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 08/27/2018 12:04 PM, Andrey Grodzovsky wrote:<br>
&gt;&gt;&gt; Hi everybody , I am trying to resolve various problems I obser=
ve when<br>
&gt;&gt;&gt; logically removing AMDGPU device from pci - echo 1 &gt;<br>
&gt;&gt;&gt; /sys/class/drm/card0/device/remove<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; One of the problems I encountered was hitting WARNs&nbsp; in<b=
r>
&gt;&gt;&gt; amdgpu_gem_force_release. It complaints&nbsp; about still open=
 client FDs and BOs<br>
&gt;&gt;&gt; allocations which is obvious since<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; we didn't let user space clients know about the device removal=
 and hence<br>
&gt;&gt;&gt; they won't release allocations and won't close their FDs.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Question - how other drivers handle this use case, especially =
eGPUs since<br>
&gt;&gt;&gt; they indeed may be extracted in any moment, is there any way t=
o notify Xorg<br>
&gt;&gt;&gt; and other clients about this so they may<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; have a chance to release all their allocations and probably te=
rminate ?<br>
&gt;&gt;&gt; Maybe some kind of uevent ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Andrey<br>
&gt;&gt;&gt;<br>
&gt;<br>
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809CE0660C2614CCD706774F7090BN6PR12MB1809namp_--

--===============0478569145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0478569145==--
