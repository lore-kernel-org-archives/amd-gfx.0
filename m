From: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: drop the drm irq pre/post/un install callbacks
Date: Mon, 22 Jan 2018 18:42:59 +0000
Message-ID: <BN6PR1201MB0100462BB7320A3F8FFE1DBCE4EC0@BN6PR1201MB0100.namprd12.prod.outlook.com>
References: <20180122172249.22421-1-alexander.deucher@amd.com>
 <742cf61a-d07b-799f-be8a-d151c976ff10@amd.com>,
 <bf43f531-5f85-a038-b2e1-54813661f2e1@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2078059372=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bf43f531-5f85-a038-b2e1-54813661f2e1-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============2078059372==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB0100462BB7320A3F8FFE1DBCE4EC0BN6PR1201MB0100_"

--_000_BN6PR1201MB0100462BB7320A3F8FFE1DBCE4EC0BN6PR1201MB0100_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tested-By: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>


Thanks,

Nick

________________________________
From: Grodzovsky, Andrey
Sent: Monday, January 22, 2018 1:36:01 PM
To: Wentland, Harry; Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Lipski, M=
ikita
Cc: Deucher, Alexander
Subject: Re: [PATCH] drm/amdgpu: drop the drm irq pre/post/un install callb=
acks

+ Mikita who verified the patch.

Andrey


On 01/22/2018 01:34 PM, Harry Wentland wrote:
> On 2018-01-22 12:22 PM, Alex Deucher wrote:
>> The preinstall callback didn't do anything because not all
>> of the IPs were initialized when it was called.
>>
>> Move the postinstall setup into sequence in the driver.
>>
>> The uninstall callback disabled all interrupt source, but
>> it got called too late in the driver sequence and caused problems
>> with IPs who already freed the relevant data structures.  Move
>> the call into the right place in the driver sequence.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>
> Harry
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 52 ++--------------------=
--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  4 +--
>>   4 files changed, 6 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index d09c4ee9f7e1..02a9157e72ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1483,6 +1483,9 @@ static int amdgpu_device_ip_fini(struct amdgpu_dev=
ice *adev)
>>               adev->ip_blocks[i].status.hw =3D false;
>>       }
>>
>> +    /* disable all interrupts */
>> +    amdgpu_irq_disable_all(adev);
>> +
>>       for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
>>               if (!adev->ip_blocks[i].status.sw)
>>                       continue;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_drv.c
>> index 24bc3e9203e2..ab4cb4917565 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -856,9 +856,6 @@ static struct drm_driver kms_driver =3D {
>>       .disable_vblank =3D amdgpu_disable_vblank_kms,
>>       .get_vblank_timestamp =3D drm_calc_vbltimestamp_from_scanoutpos,
>>       .get_scanout_position =3D amdgpu_get_crtc_scanout_position,
>> -    .irq_preinstall =3D amdgpu_irq_preinstall,
>> -    .irq_postinstall =3D amdgpu_irq_postinstall,
>> -    .irq_uninstall =3D amdgpu_irq_uninstall,
>>       .irq_handler =3D amdgpu_irq_handler,
>>       .ioctls =3D amdgpu_ioctls_kms,
>>       .gem_free_object_unlocked =3D amdgpu_gem_object_free,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_irq.c
>> index 56bcd59c3399..f6f2a662bb8f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -92,7 +92,7 @@ static void amdgpu_irq_reset_work_func(struct work_str=
uct *work)
>>   }
>>
>>   /* Disable *all* interrupts */
>> -static void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>> +void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>>   {
>>       unsigned long irqflags;
>>       unsigned i, j, k;
>> @@ -123,55 +123,6 @@ static void amdgpu_irq_disable_all(struct amdgpu_de=
vice *adev)
>>   }
>>
>>   /**
>> - * amdgpu_irq_preinstall - drm irq preinstall callback
>> - *
>> - * @dev: drm dev pointer
>> - *
>> - * Gets the hw ready to enable irqs (all asics).
>> - * This function disables all interrupt sources on the GPU.
>> - */
>> -void amdgpu_irq_preinstall(struct drm_device *dev)
>> -{
>> -    struct amdgpu_device *adev =3D dev->dev_private;
>> -
>> -    /* Disable *all* interrupts */
>> -    amdgpu_irq_disable_all(adev);
>> -    /* Clear bits */
>> -    amdgpu_ih_process(adev);
>> -}
>> -
>> -/**
>> - * amdgpu_irq_postinstall - drm irq preinstall callback
>> - *
>> - * @dev: drm dev pointer
>> - *
>> - * Handles stuff to be done after enabling irqs (all asics).
>> - * Returns 0 on success.
>> - */
>> -int amdgpu_irq_postinstall(struct drm_device *dev)
>> -{
>> -    dev->max_vblank_count =3D 0x00ffffff;
>> -    return 0;
>> -}
>> -
>> -/**
>> - * amdgpu_irq_uninstall - drm irq uninstall callback
>> - *
>> - * @dev: drm dev pointer
>> - *
>> - * This function disables all interrupt sources on the GPU (all asics).
>> - */
>> -void amdgpu_irq_uninstall(struct drm_device *dev)
>> -{
>> -    struct amdgpu_device *adev =3D dev->dev_private;
>> -
>> -    if (adev =3D=3D NULL) {
>> -            return;
>> -    }
>> -    amdgpu_irq_disable_all(adev);
>> -}
>> -
>> -/**
>>    * amdgpu_irq_handler - irq handler
>>    *
>>    * @int irq, void *arg: args
>> @@ -261,6 +212,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>>               cancel_work_sync(&adev->reset_work);
>>               return r;
>>       }
>> +    adev->ddev->max_vblank_count =3D 0x00ffffff;
>>
>>       DRM_DEBUG("amdgpu: irq initialized.\n");
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_irq.h
>> index 0610cc4a9788..3375ad778edc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> @@ -78,9 +78,7 @@ struct amdgpu_irq {
>>       uint32_t                        srbm_soft_reset;
>>   };
>>
>> -void amdgpu_irq_preinstall(struct drm_device *dev);
>> -int amdgpu_irq_postinstall(struct drm_device *dev);
>> -void amdgpu_irq_uninstall(struct drm_device *dev);
>> +void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>>   irqreturn_t amdgpu_irq_handler(int irq, void *arg);
>>
>>   int amdgpu_irq_init(struct amdgpu_device *adev);
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_BN6PR1201MB0100462BB7320A3F8FFE1DBCE4EC0BN6PR1201MB0100_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Tested-By: Mikita Lipski &l=
t;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Thanks,<br>
</span></p>
<span>Nick</span><br>
<p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey<br=
>
<b>Sent:</b> Monday, January 22, 2018 1:36:01 PM<br>
<b>To:</b> Wentland, Harry; Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Li=
pski, Mikita<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: drop the drm irq pre/post/un instal=
l callbacks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&#43; Mikita who verified the patch.<br>
<br>
Andrey<br>
<br>
<br>
On 01/22/2018 01:34 PM, Harry Wentland wrote:<br>
&gt; On 2018-01-22 12:22 PM, Alex Deucher wrote:<br>
&gt;&gt; The preinstall callback didn't do anything because not all<br>
&gt;&gt; of the IPs were initialized when it was called.<br>
&gt;&gt;<br>
&gt;&gt; Move the postinstall setup into sequence in the driver.<br>
&gt;&gt;<br>
&gt;&gt; The uninstall callback disabled all interrupt source, but<br>
&gt;&gt; it got called too late in the driver sequence and caused problems<=
br>
&gt;&gt; with IPs who already freed the relevant data structures.&nbsp; Mov=
e<br>
&gt;&gt; the call into the right place in the driver sequence.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Harry<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 3 &=
#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nb=
sp; |&nbsp; 3 --<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c&nbsp;&nbsp;&nb=
sp; | 52 &#43;&#43;----------------------------<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h&nbsp;&nbsp;&nb=
sp; |&nbsp; 4 &#43;--<br>
&gt;&gt;&nbsp;&nbsp; 4 files changed, 6 insertions(&#43;), 56 deletions(-)<=
br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index d09c4ee9f7e1..02a9157e72ac 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -1483,6 &#43;1483,9 @@ static int amdgpu_device_ip_fini(struct =
amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.hw =3D false;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* disable all interrupts */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; amdgpu_irq_disable_all(adev);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip_blo=
cks - 1; i &gt;=3D 0; i--) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.sw)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;=
<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; index 24bc3e9203e2..ab4cb4917565 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; @@ -856,9 &#43;856,6 @@ static struct drm_driver kms_driver =3D {<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_vblank =3D amdgpu_dis=
able_vblank_kms,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_vblank_timestamp =3D drm_=
calc_vbltimestamp_from_scanoutpos,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_scanout_position =3D amdg=
pu_get_crtc_scanout_position,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; .irq_preinstall =3D amdgpu_irq_preinstall,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; .irq_postinstall =3D amdgpu_irq_postinstall,<b=
r>
&gt;&gt; -&nbsp;&nbsp;&nbsp; .irq_uninstall =3D amdgpu_irq_uninstall,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .irq_handler =3D amdgpu_irq_ha=
ndler,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ioctls =3D amdgpu_ioctls_kms,=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_free_object_unlocked =3D =
amdgpu_gem_object_free,<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt; index 56bcd59c3399..f6f2a662bb8f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt; @@ -92,7 &#43;92,7 @@ static void amdgpu_irq_reset_work_func(struc=
t work_struct *work)<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; /* Disable *all* interrupts */<br>
&gt;&gt; -static void amdgpu_irq_disable_all(struct amdgpu_device *adev)<br=
>
&gt;&gt; &#43;void amdgpu_irq_disable_all(struct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long irqflags;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i, j, k;<br>
&gt;&gt; @@ -123,55 &#43;123,6 @@ static void amdgpu_irq_disable_all(struct=
 amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt; - * amdgpu_irq_preinstall - drm irq preinstall callback<br>
&gt;&gt; - *<br>
&gt;&gt; - * @dev: drm dev pointer<br>
&gt;&gt; - *<br>
&gt;&gt; - * Gets the hw ready to enable irqs (all asics).<br>
&gt;&gt; - * This function disables all interrupt sources on the GPU.<br>
&gt;&gt; - */<br>
&gt;&gt; -void amdgpu_irq_preinstall(struct drm_device *dev)<br>
&gt;&gt; -{<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;dev_pri=
vate;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; /* Disable *all* interrupts */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; amdgpu_irq_disable_all(adev);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; /* Clear bits */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; amdgpu_ih_process(adev);<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt; -/**<br>
&gt;&gt; - * amdgpu_irq_postinstall - drm irq preinstall callback<br>
&gt;&gt; - *<br>
&gt;&gt; - * @dev: drm dev pointer<br>
&gt;&gt; - *<br>
&gt;&gt; - * Handles stuff to be done after enabling irqs (all asics).<br>
&gt;&gt; - * Returns 0 on success.<br>
&gt;&gt; - */<br>
&gt;&gt; -int amdgpu_irq_postinstall(struct drm_device *dev)<br>
&gt;&gt; -{<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; dev-&gt;max_vblank_count =3D 0x00ffffff;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt; -/**<br>
&gt;&gt; - * amdgpu_irq_uninstall - drm irq uninstall callback<br>
&gt;&gt; - *<br>
&gt;&gt; - * @dev: drm dev pointer<br>
&gt;&gt; - *<br>
&gt;&gt; - * This function disables all interrupt sources on the GPU (all a=
sics).<br>
&gt;&gt; - */<br>
&gt;&gt; -void amdgpu_irq_uninstall(struct drm_device *dev)<br>
&gt;&gt; -{<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;dev_pri=
vate;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev =3D=3D NULL) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; amdgpu_irq_disable_all(adev);<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt; -/**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_irq_handler - irq handler<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * @int irq, void *arg: args<br>
&gt;&gt; @@ -261,6 &#43;212,7 @@ int amdgpu_irq_init(struct amdgpu_device *=
adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; cancel_work_sync(&amp;adev-&gt;reset_work);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; adev-&gt;ddev-&gt;max_vblank_count =3D 0x0=
0ffffff;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;amdgpu: irq in=
itialized.\n&quot;);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt;&gt; index 0610cc4a9788..3375ad778edc 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt;&gt; @@ -78,9 &#43;78,7 @@ struct amdgpu_irq {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srbm_soft_reset;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -void amdgpu_irq_preinstall(struct drm_device *dev);<br>
&gt;&gt; -int amdgpu_irq_postinstall(struct drm_device *dev);<br>
&gt;&gt; -void amdgpu_irq_uninstall(struct drm_device *dev);<br>
&gt;&gt; &#43;void amdgpu_irq_disable_all(struct amdgpu_device *adev);<br>
&gt;&gt;&nbsp;&nbsp; irqreturn_t amdgpu_irq_handler(int irq, void *arg);<br=
>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_irq_init(struct amdgpu_device *adev);<br>
&gt;&gt;<br>
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

--_000_BN6PR1201MB0100462BB7320A3F8FFE1DBCE4EC0BN6PR1201MB0100_--

--===============2078059372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2078059372==--
