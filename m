From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add VM test to exercise max/min address
 space
Date: Fri, 26 Oct 2018 13:43:37 +0000
Message-ID: <BN6PR12MB1809BA40F7E737C7DB14BA87F7F00@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181026105921.3033-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0996159778=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181026105921.3033-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0996159778==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BA40F7E737C7DB14BA87F7F00BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BA40F7E737C7DB14BA87F7F00BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, October 26, 2018 6:59:21 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH libdrm] amdgpu: add VM test to exercise max/min address spa=
ce

Make sure the kernel doesn't crash if we map something at the minimum/maxim=
um address.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/vm_tests.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tests/amdgpu/vm_tests.c b/tests/amdgpu/vm_tests.c
index 7b6dc5d6..bbdeef4d 100644
--- a/tests/amdgpu/vm_tests.c
+++ b/tests/amdgpu/vm_tests.c
@@ -31,8 +31,8 @@ static  amdgpu_device_handle device_handle;
 static  uint32_t  major_version;
 static  uint32_t  minor_version;

-
 static void amdgpu_vmid_reserve_test(void);
+static void amdgpu_vm_mapping_test(void);

 CU_BOOL suite_vm_tests_enable(void)
 {
@@ -84,6 +84,7 @@ int suite_vm_tests_clean(void)

 CU_TestInfo vm_tests[] =3D {
         { "resere vmid test",  amdgpu_vmid_reserve_test },
+       { "vm mapping test",  amdgpu_vm_mapping_test },
         CU_TEST_INFO_NULL,
 };

@@ -167,3 +168,45 @@ static void amdgpu_vmid_reserve_test(void)
         r =3D amdgpu_cs_ctx_free(context_handle);
         CU_ASSERT_EQUAL(r, 0);
 }
+
+static void amdgpu_vm_mapping_test(void)
+{
+       struct amdgpu_bo_alloc_request req =3D {0};
+       struct drm_amdgpu_info_device dev_info;
+       const uint64_t size =3D 4096;
+       amdgpu_bo_handle buf;
+       uint64_t addr;
+       int r;
+
+       req.alloc_size =3D size;
+       req.phys_alignment =3D 0;
+       req.preferred_heap =3D AMDGPU_GEM_DOMAIN_GTT;
+       req.flags =3D 0;
+
+       r =3D amdgpu_bo_alloc(device_handle, &req, &buf);
+       CU_ASSERT_EQUAL(r, 0);
+
+       r =3D amdgpu_query_info(device_handle, AMDGPU_INFO_DEV_INFO,
+                             sizeof(dev_info), &dev_info);
+       CU_ASSERT_EQUAL(r, 0);
+
+       addr =3D dev_info.virtual_address_offset;
+       r =3D amdgpu_bo_va_op(buf, 0, size, addr, 0, AMDGPU_VA_OP_MAP);
+       CU_ASSERT_EQUAL(r, 0);
+
+       addr =3D dev_info.virtual_address_max - size;
+       r =3D amdgpu_bo_va_op(buf, 0, size, addr, 0, AMDGPU_VA_OP_MAP);
+       CU_ASSERT_EQUAL(r, 0);
+
+       if (dev_info.high_va_offset) {
+               addr =3D dev_info.high_va_offset;
+               r =3D amdgpu_bo_va_op(buf, 0, size, addr, 0, AMDGPU_VA_OP_M=
AP);
+               CU_ASSERT_EQUAL(r, 0);
+
+               addr =3D dev_info.high_va_max - size;
+               r =3D amdgpu_bo_va_op(buf, 0, size, addr, 0, AMDGPU_VA_OP_M=
AP);
+               CU_ASSERT_EQUAL(r, 0);
+       }
+
+       amdgpu_bo_free(buf);
+}
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BA40F7E737C7DB14BA87F7F00BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, October 26, 2018 6:59:21 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH libdrm] amdgpu: add VM test to exercise max/min addr=
ess space</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Make sure the kernel doesn't crash if we map somet=
hing at the minimum/maximum address.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;tests/amdgpu/vm_tests.c | 45 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;-<br>
&nbsp;1 file changed, 44 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/tests/amdgpu/vm_tests.c b/tests/amdgpu/vm_tests.c<br>
index 7b6dc5d6..bbdeef4d 100644<br>
--- a/tests/amdgpu/vm_tests.c<br>
&#43;&#43;&#43; b/tests/amdgpu/vm_tests.c<br>
@@ -31,8 &#43;31,8 @@ static&nbsp; amdgpu_device_handle device_handle;<br>
&nbsp;static&nbsp; uint32_t&nbsp; major_version;<br>
&nbsp;static&nbsp; uint32_t&nbsp; minor_version;<br>
&nbsp;<br>
-<br>
&nbsp;static void amdgpu_vmid_reserve_test(void);<br>
&#43;static void amdgpu_vm_mapping_test(void);<br>
&nbsp;<br>
&nbsp;CU_BOOL suite_vm_tests_enable(void)<br>
&nbsp;{<br>
@@ -84,6 &#43;84,7 @@ int suite_vm_tests_clean(void)<br>
&nbsp;<br>
&nbsp;CU_TestInfo vm_tests[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;resere vmid test&q=
uot;,&nbsp; amdgpu_vmid_reserve_test },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;vm mapping test&quot;,&nb=
sp; amdgpu_vm_mapping_test },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_TEST_INFO_NULL,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -167,3 &#43;168,45 @@ static void amdgpu_vmid_reserve_test(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cs_ctx_free(c=
ontext_handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&nbsp;}<br>
&#43;<br>
&#43;static void amdgpu_vm_mapping_test(void)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_alloc_request re=
q =3D {0};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_device dev=
_info;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t size =3D 4096;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_handle buf;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req.alloc_size =3D size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req.phys_alignment =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req.preferred_heap =3D AMDGPU_GEM=
_DOMAIN_GTT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req.flags =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_alloc(device_hand=
le, &amp;req, &amp;buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_query_info(device_ha=
ndle, AMDGPU_INFO_DEV_INFO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; sizeof(dev_info), &amp;dev_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D dev_info.virtual_address=
_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_va_op(buf, 0, siz=
e, addr, 0, AMDGPU_VA_OP_MAP);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D dev_info.virtual_address=
_max - size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_va_op(buf, 0, siz=
e, addr, 0, AMDGPU_VA_OP_MAP);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev_info.high_va_offset) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; addr =3D dev_info.high_va_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_bo_va_op(buf, 0, size, addr, 0, AMDGPU_VA_OP_MA=
P);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; addr =3D dev_info.high_va_max - size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_bo_va_op(buf, 0, size, addr, 0, AMDGPU_VA_OP_MA=
P);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free(buf);<br>
&#43;}<br>
-- <br>
2.17.1<br>
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

--_000_BN6PR12MB1809BA40F7E737C7DB14BA87F7F00BN6PR12MB1809namp_--

--===============0996159778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0996159778==--
