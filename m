From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add IDH_QUERY_ALIVE event for SR-IOV
Date: Wed, 1 May 2019 19:08:29 +0000
Message-ID: <BN6PR12MB1809B40A04849DBFD778D161F73B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1556613013-8586-1-git-send-email-Trigger.Huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0986914697=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1556613013-8586-1-git-send-email-Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, Trigger" <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0986914697==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809B40A04849DBFD778D161F73B0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809B40A04849DBFD778D161F73B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Trigger =
Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, April 30, 2019 4:30 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, Trigger
Subject: [PATCH] drm/amdgpu: Add IDH_QUERY_ALIVE event for SR-IOV

[CAUTION: External Email]

SR-IOV host side will send IDH_QUERY_ALIVE to guest VM to check
if this guest VM is still alive (not destroyed). The only thing
guest KMD need to do is to send ACK back to host.

Signed-off-by: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index 8dbad49..2471e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -372,6 +372,9 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device=
 *adev,
                if (amdgpu_sriov_runtime(adev))
                        schedule_work(&adev->virt.flr_work);
                break;
+               case IDH_QUERY_ALIVE:
+                       xgpu_ai_mailbox_send_ack(adev);
+                       break;
                /* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ ca=
n ignore
                 * it byfar since that polling thread will handle it,
                 * other msg like flr complete is not handled here.
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index 39d151b..077e91a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -49,6 +49,7 @@ enum idh_event {
        IDH_FLR_NOTIFICATION_CMPL,
        IDH_SUCCESS,
        IDH_FAIL,
+       IDH_QUERY_ALIVE,
        IDH_EVENT_MAX
 };

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809B40A04849DBFD778D161F73B0BN6PR12MB1809namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Trigger Huang &lt;Trigger.Hua=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, April 30, 2019 4:30 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Huang, Trigger<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add IDH_QUERY_ALIVE event for SR-IOV</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[CAUTION: External Email]<br>
<br>
SR-IOV host side will send IDH_QUERY_ALIVE to guest VM to check<br>
if this guest VM is still alive (not destroyed). The only thing<br>
guest KMD need to do is to send ACK back to host.<br>
<br>
Signed-off-by: Trigger Huang &lt;Trigger.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 1 &#43;<br>
&nbsp;2 files changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c<br>
index 8dbad49..2471e7c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
@@ -372,6 &#43;372,9 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_runtime(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_wo=
rk(&amp;adev-&gt;virt.flr_work);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; case IDH_QUERY_ALIVE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_ai_mail=
box_send_ack(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ ca=
n ignore<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * it byfar since that polling thread will handle it,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * other msg like flr complete is not handled here.<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h<br>
index 39d151b..077e91a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
@@ -49,6 &#43;49,7 @@ enum idh_event {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_FLR_NOTIFICATION_CMPL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_SUCCESS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_FAIL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_QUERY_ALIVE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_EVENT_MAX<br>
&nbsp;};<br>
<br>
--<br>
2.7.4<br>
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

--_000_BN6PR12MB1809B40A04849DBFD778D161F73B0BN6PR12MB1809namp_--

--===============0986914697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0986914697==--
