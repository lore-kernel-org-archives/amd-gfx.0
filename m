From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Date: Wed, 6 Nov 2019 15:05:16 +0000
Message-ID: <CY4PR12MB18131729CB48513830561F76F7790@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB2975A3DFE6CCED7BB3D6D2748F790@MN2PR12MB2975.namprd12.prod.outlook.com>
 <6be1e7b9-13a9-f382-ef66-00c284a14a14@gmail.com>,
 <MN2PR12MB297565CEDAAF6460C71F98F28F790@MN2PR12MB2975.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0872663815=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB297565CEDAAF6460C71F98F28F790-rweVpJHSKToFlvJWC7EAqwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0872663815==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_"

--_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 6, 2019 5:09 AM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Need to disable msix when unloading driver

Hi Christian,
    We use " pci_alloc_irq_vectors " in amdgpu_irq_init. This patch use " p=
ci_free_irq_vectors " in amdgpu_irq_fini.

Hi Alex,
    Could you help to review this?

Best wishes
Emily Deng



>-----Original Message-----
>From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>Sent: Wednesday, November 6, 2019 5:32 PM
>To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading
>driver
>
>Not an expert on the PCI IRQ stuff, but from what I know that looks correc=
t to
>me.
>
>Only question I can see is why don't we use pci_alloc_irq_vectors()?
>Alex probably needs to take a look.
>
>Regards,
>Christian.
>
>Am 06.11.19 um 07:28 schrieb Deng, Emily:
>> Hi all,
>>      Please help to review this. This is to fix driver reload issue.
>>
>> Best wishes
>> Emily Deng
>>
>>
>>> -----Original Message-----
>>> From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>> Sent: Wednesday, November 6, 2019 2:24 PM
>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>> Subject: [PATCH] drm/amdgpu: Need to disable msix when unloading
>>> driver
>>>
>>> For driver reload test, it will report "can't enable MSI (MSI-X already
>enabled)".
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index 6f3b03f..30d540d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -311,7 +311,7 @@ void amdgpu_irq_fini(struct amdgpu_device *adev)
>>>              drm_irq_uninstall(adev->ddev);
>>>              adev->irq.installed =3D false;
>>>              if (adev->irq.msi_enabled)
>>> -                   pci_disable_msi(adev->pdev);
>>> +                   pci_free_irq_vectors(adev->pdev);
>>>              if (!amdgpu_device_has_dc_support(adev))
>>>                      flush_work(&adev->hotplug_work);
>>>      }
>>> --
>>> 2.7.4
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deng, Emily &lt;Emily=
.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 6, 2019 5:09 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Need to disable msix when unloading=
 driver</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Christian,<br>
&nbsp;&nbsp;&nbsp; We use &quot; pci_alloc_irq_vectors &quot; in amdgpu_irq=
_init. This patch use &quot; pci_free_irq_vectors &quot; in amdgpu_irq_fini=
.<br>
<br>
Hi Alex,<br>
&nbsp;&nbsp;&nbsp; Could you help to review this?<br>
<br>
Best wishes<br>
Emily Deng<br>
<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Christian K=F6nig &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt;Sent: Wednesday, November 6, 2019 5:32 PM<br>
&gt;To: Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg<br>
&gt;Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading<br=
>
&gt;driver<br>
&gt;<br>
&gt;Not an expert on the PCI IRQ stuff, but from what I know that looks cor=
rect to<br>
&gt;me.<br>
&gt;<br>
&gt;Only question I can see is why don't we use pci_alloc_irq_vectors()?<br=
>
&gt;Alex probably needs to take a look.<br>
&gt;<br>
&gt;Regards,<br>
&gt;Christian.<br>
&gt;<br>
&gt;Am 06.11.19 um 07:28 schrieb Deng, Emily:<br>
&gt;&gt; Hi all,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please help to review this. This is =
to fix driver reload issue.<br>
&gt;&gt;<br>
&gt;&gt; Best wishes<br>
&gt;&gt; Emily Deng<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; Sent: Wednesday, November 6, 2019 2:24 PM<br>
&gt;&gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; Cc: Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; Subject: [PATCH] drm/amdgpu: Need to disable msix when unloadi=
ng<br>
&gt;&gt;&gt; driver<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For driver reload test, it will report &quot;can't enable MSI =
(MSI-X already<br>
&gt;enabled)&quot;.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 &#43;-<br>
&gt;&gt;&gt; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; index 6f3b03f..30d540d 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; @@ -311,7 &#43;311,7 @@ void amdgpu_irq_fini(struct amdgpu_dev=
ice *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; drm_irq_uninstall(adev-&gt;ddev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;irq.installed =3D false;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;irq.msi_enabled)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_disable_msi(adev-&gt;pd=
ev);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_free_irq_vectors(ad=
ev-&gt;pdev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_support(adev))<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(=
&amp;adev-&gt;hotplug_work);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.7.4<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_--

--===============0872663815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0872663815==--
