From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Improve documentation of bo_ptr in
 amdgpu_bo_create_kernel
Date: Thu, 15 Mar 2018 16:18:55 +0000
Message-ID: <BN6PR12MB1652922737FD3A6CBA7EA323F7D00@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <992da07d-1f19-3a1d-c065-10824871f756@gmail.com>,
 <1521130511-10816-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1441626468=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521130511-10816-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1441626468==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652922737FD3A6CBA7EA323F7D00BN6PR12MB1652namp_"

--_000_BN6PR12MB1652922737FD3A6CBA7EA323F7D00BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

For the series:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

I think Rex already applied the second one.


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andrey G=
rodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, March 15, 2018 12:15 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Zhu, R=
ex
Cc: Grodzovsky, Andrey
Subject: [PATCH v2 1/2] drm/amdgpu: Improve documentation of bo_ptr in amdg=
pu_bo_create_kernel

and amdgpu_bo_create_reserved.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 48e0115..ac1fa33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -171,13 +171,15 @@ void amdgpu_ttm_placement_from_domain(struct amdgpu_b=
o *abo, u32 domain)
  * @size: size for the new BO
  * @align: alignment for the new BO
  * @domain: where to place it
- * @bo_ptr: resulting BO
+ * @bo_ptr: used to initialize BOs in structures
  * @gpu_addr: GPU addr of the pinned BO
  * @cpu_addr: optional CPU address mapping
  *
  * Allocates and pins a BO for kernel internal use, and returns it still
  * reserved.
  *
+ * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
+ *
  * Returns 0 on success, negative error code otherwise.
  */
 int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
@@ -240,12 +242,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *a=
dev,
  * @size: size for the new BO
  * @align: alignment for the new BO
  * @domain: where to place it
- * @bo_ptr: resulting BO
+ * @bo_ptr:  used to initialize BOs in structures
  * @gpu_addr: GPU addr of the pinned BO
  * @cpu_addr: optional CPU address mapping
  *
  * Allocates and pins a BO for kernel internal use.
  *
+ * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
+ *
  * Returns 0 on success, negative error code otherwise.
  */
 int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652922737FD3A6CBA7EA323F7D00BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">For the series:<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
I think Rex already applied the second one.<br>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Andrey Grodzovsky &lt;andre=
y.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 15, 2018 12:15 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;=
 Zhu, Rex<br>
<b>Cc:</b> Grodzovsky, Andrey<br>
<b>Subject:</b> [PATCH v2 1/2] drm/amdgpu: Improve documentation of bo_ptr =
in amdgpu_bo_create_kernel</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">and amdgpu_bo_create_reserved.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 &#43;&#43;&#43;&#43;&#=
43;&#43;--<br>
&nbsp;1 file changed, 6 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 48e0115..ac1fa33 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -171,13 &#43;171,15 @@ void amdgpu_ttm_placement_from_domain(struct amdg=
pu_bo *abo, u32 domain)<br>
&nbsp; * @size: size for the new BO<br>
&nbsp; * @align: alignment for the new BO<br>
&nbsp; * @domain: where to place it<br>
- * @bo_ptr: resulting BO<br>
&#43; * @bo_ptr: used to initialize BOs in structures<br>
&nbsp; * @gpu_addr: GPU addr of the pinned BO<br>
&nbsp; * @cpu_addr: optional CPU address mapping<br>
&nbsp; *<br>
&nbsp; * Allocates and pins a BO for kernel internal use, and returns it st=
ill<br>
&nbsp; * reserved.<br>
&nbsp; *<br>
&#43; * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.<b=
r>
&#43; *<br>
&nbsp; * Returns 0 on success, negative error code otherwise.<br>
&nbsp; */<br>
&nbsp;int amdgpu_bo_create_reserved(struct amdgpu_device *adev,<br>
@@ -240,12 &#43;242,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_devic=
e *adev,<br>
&nbsp; * @size: size for the new BO<br>
&nbsp; * @align: alignment for the new BO<br>
&nbsp; * @domain: where to place it<br>
- * @bo_ptr: resulting BO<br>
&#43; * @bo_ptr:&nbsp; used to initialize BOs in structures<br>
&nbsp; * @gpu_addr: GPU addr of the pinned BO<br>
&nbsp; * @cpu_addr: optional CPU address mapping<br>
&nbsp; *<br>
&nbsp; * Allocates and pins a BO for kernel internal use.<br>
&nbsp; *<br>
&#43; * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.<b=
r>
&#43; *<br>
&nbsp; * Returns 0 on success, negative error code otherwise.<br>
&nbsp; */<br>
&nbsp;int amdgpu_bo_create_kernel(struct amdgpu_device *adev,<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk582111" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652922737FD3A6CBA7EA323F7D00BN6PR12MB1652namp_--

--===============1441626468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1441626468==--
