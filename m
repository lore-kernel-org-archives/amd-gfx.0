From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loaded by
 PSP
Date: Mon, 13 Aug 2018 04:16:11 +0000
Message-ID: <SN6PR12MB2656E11594EA2BC12BC5B38DE4390@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <1533832302-21440-1-git-send-email-James.Zhu@amd.com>,
 <1533832302-21440-5-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1882609561=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533832302-21440-5-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gao,
 Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============1882609561==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2656E11594EA2BC12BC5B38DE4390SN6PR12MB2656namp_"

--_000_SN6PR12MB2656E11594EA2BC12BC5B38DE4390SN6PR12MB2656namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Why only the mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW/HIGH use the new tmr_mc_add=
r? And the mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW/HIGH and mmUVD_LMI_VCPU_CACH=
E1_64BIT_BAR_LOW/HIGH still use the old adev->vcn.gpu_addr?


Regards,

Evan

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of James Zh=
u <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, August 10, 2018 12:31:42 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Gao, Likun; Zhu, James; Huang, Ray
Subject: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loaded by =
PSP

From: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

Setup psp firmware loading for VCN, and make VCN block
booting from tmr mac address.

Signed-off-by: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 +++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 38 ++++++++++++++++++++++++++---=
----
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 878f62c..77c192a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -111,9 +111,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
                         version_major, version_minor, family_id);
         }

-       bo_size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes=
) + 8)
-                 +  AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_HEAP_SIZE
+       bo_size =3D AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_HEAP_SIZE
                   +  AMDGPU_VCN_SESSION_SIZE * 40;
+       if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
+               bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_s=
ize_bytes) + 8);
         r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
                                     AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.vcp=
u_bo,
                                     &adev->vcn.gpu_addr, &adev->vcn.cpu_ad=
dr);
@@ -189,11 +190,13 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
                 unsigned offset;

                 hdr =3D (const struct common_firmware_header *)adev->vcn.f=
w->data;
-               offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
-               memcpy_toio(adev->vcn.cpu_addr, adev->vcn.fw->data + offset=
,
-                           le32_to_cpu(hdr->ucode_size_bytes));
-               size -=3D le32_to_cpu(hdr->ucode_size_bytes);
-               ptr +=3D le32_to_cpu(hdr->ucode_size_bytes);
+               if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
+                       offset =3D le32_to_cpu(hdr->ucode_array_offset_byte=
s);
+                       memcpy_toio(adev->vcn.cpu_addr, adev->vcn.fw->data =
+ offset,
+                                   le32_to_cpu(hdr->ucode_size_bytes));
+                       size -=3D le32_to_cpu(hdr->ucode_size_bytes);
+                       ptr +=3D le32_to_cpu(hdr->ucode_size_bytes);
+               }
                 memset_io(ptr, 0, size);
         }

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 2ce91a7..74c4ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -100,6 +100,16 @@ static int vcn_v1_0_sw_init(void *handle)
         if (r)
                 return r;

+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               const struct common_firmware_header *hdr;
+               hdr =3D (const struct common_firmware_header *)adev->vcn.fw=
->data;
+               adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id =3D AMDG=
PU_UCODE_ID_VCN;
+               adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vcn.=
fw;
+               adev->firmware.fw_size +=3D
+                       ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE=
);
+               DRM_INFO("PSP loading VCN firmware\n");
+       }
+
         r =3D amdgpu_vcn_resume(adev);
         if (r)
                 return r;
@@ -265,26 +275,38 @@ static int vcn_v1_0_resume(void *handle)
 static void vcn_v1_0_mc_resume(struct amdgpu_device *adev)
 {
         uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
-
-       WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+       uint32_t offset;
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+                       (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_a=
ddr_lo));
+               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+                       (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_a=
ddr_hi));
+               WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0);
+               offset =3D 0;
+       } else {
+               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
                         lower_32_bits(adev->vcn.gpu_addr));
-       WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
                         upper_32_bits(adev->vcn.gpu_addr));
-       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
+               offset =3D size;
+               WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
                                 AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+       }
+
         WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE0, size);

         WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
-                       lower_32_bits(adev->vcn.gpu_addr + size));
+                       lower_32_bits(adev->vcn.gpu_addr + offset));
         WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
-                       upper_32_bits(adev->vcn.gpu_addr + size));
+                       upper_32_bits(adev->vcn.gpu_addr + offset));
         WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1, 0);
         WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_HEAP_SIZE)=
;

         WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
-                       lower_32_bits(adev->vcn.gpu_addr + size + AMDGPU_VC=
N_HEAP_SIZE));
+                       lower_32_bits(adev->vcn.gpu_addr + offset + AMDGPU_=
VCN_HEAP_SIZE));
         WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
-                       upper_32_bits(adev->vcn.gpu_addr + size + AMDGPU_VC=
N_HEAP_SIZE));
+                       upper_32_bits(adev->vcn.gpu_addr + offset + AMDGPU_=
VCN_HEAP_SIZE));
         WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2, 0);
         WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE2,
                         AMDGPU_VCN_STACK_SIZE + (AMDGPU_VCN_SESSION_SIZE *=
 40));
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN6PR12MB2656E11594EA2BC12BC5B38DE4390SN6PR12MB2656namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Why only the&nbsp;<span style=3D"=
color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quo=
t;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font=
-size: 14.6667px;">mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW/HIGH use
 the new&nbsp;<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-=
ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-=
serif, serif, EmojiFont; font-size: 14.6667px;">tmr_mc_addr? And the&nbsp;<=
span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quo=
t;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, E=
mojiFont; font-size: 14.6667px;">mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW/HIGH
 and&nbsp;<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_n=
ormal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-seri=
f, serif, EmojiFont; font-size: 14.6667px;">mmUVD_LMI_VCPU_CACHE1_64BIT_BAR=
_LOW/HIGH still use the old&nbsp;<span style=3D"color: rgb(33, 33, 33); fon=
t-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, T=
ahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;">adev-&gt=
;vcn.gpu_addr?</span></span></span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif,=
 EmojiFont; font-size: 14.6667px;"><span style=3D"color: rgb(33, 33, 33); f=
ont-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,=
 Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span =
style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Seg=
oe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiF=
ont; font-size: 14.6667px;"><span style=3D"color: rgb(33, 33, 33); font-fam=
ily: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma=
, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"><br>
</span></span></span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif,=
 EmojiFont; font-size: 14.6667px;"><span style=3D"color: rgb(33, 33, 33); f=
ont-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,=
 Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span =
style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Seg=
oe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiF=
ont; font-size: 14.6667px;"><span style=3D"color: rgb(33, 33, 33); font-fam=
ily: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma=
, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;">Regards,</spa=
n></span></span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif,=
 EmojiFont; font-size: 14.6667px;"><span style=3D"color: rgb(33, 33, 33); f=
ont-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,=
 Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span =
style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Seg=
oe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiF=
ont; font-size: 14.6667px;"><span style=3D"color: rgb(33, 33, 33); font-fam=
ily: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma=
, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;">Evan</span></=
span></span></span></span></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of James Zhu &lt;jzhums-Re5JQEeQqe8@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Friday, August 10, 2018 12:31:42 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Gao, Likun; Zhu, James; Huang, Ray<br>
<b>Subject:</b> [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loa=
ded by PSP</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Setup psp firmware loading for VCN, and make VCN block<br>
booting from tmr mac address.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp;&nbsp; | 38 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;2 files changed, 40 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 878f62c..77c192a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -111,9 &#43;111,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versi=
on_major, version_minor, family_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_size =3D AMDGPU_GPU_PAGE_ALIGN(le3=
2_to_cpu(hdr-&gt;ucode_size_bytes) &#43; 8)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &#43;&nbsp; AMDGPU_VCN_STACK_SIZE &#43; AMDGPU_VCN_H=
EAP_SIZE<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_size =3D AMDGPU_VCN_STACK_SIZE=
 &#43; AMDGPU_VCN_HEAP_SIZE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&nbsp; AMDGPU_VCN_SESSION_SIZE * 40;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type !=
=3D AMDGPU_FW_LOAD_PSP)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bo_size &#43;=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&gt;u=
code_size_bytes) &#43; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_ker=
nel(adev, bo_size, PAGE_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_G=
EM_DOMAIN_VRAM, &amp;adev-&gt;vcn.vcpu_bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ade=
v-&gt;vcn.gpu_addr, &amp;adev-&gt;vcn.cpu_addr);<br>
@@ -189,11 &#43;190,13 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned offset;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct common_firmware_header *)adev-&=
gt;vcn.fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D le32_to_cpu(hdr-&gt;ucode_array_offset_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy_toio(adev-&gt;vcn.cpu_addr, adev-&gt;vcn.fw-&gt;data &#43=
; offset,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; le32_to_cpu(hdr-&gt;ucode_size_bytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size -=3D le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptr &#43;=3D le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D l=
e32_to_cpu(hdr-&gt;ucode_array_offset_bytes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(=
adev-&gt;vcn.cpu_addr, adev-&gt;vcn.fw-&gt;data &#43; offset,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(hdr=
-&gt;ucode_size_bytes));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size -=3D le=
32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr &#43;=3D=
 le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset_io(ptr, 0, size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c<br>
index 2ce91a7..74c4ef4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
@@ -100,6 &#43;100,16 @@ static int vcn_v1_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_PSP) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const struct common_firmware_header *hdr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (const struct common_firmware_header *)adev-&gt;vcn.=
fw-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id =3D AM=
DGPU_UCODE_ID_VCN;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev-&gt=
;vcn.fw;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.fw_size &#43;=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_t=
o_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resume(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -265,26 &#43;275,38 @@ static int vcn_v1_0_resume(void *handle)<br>
&nbsp;static void vcn_v1_0_mc_resume(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D AMDGPU_G=
PU_PAGE_ALIGN(adev-&gt;vcn.fw-&gt;size &#43; 4);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_C=
ACHE_64BIT_BAR_LOW,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_PSP) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;fi=
rmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;fi=
rmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; offset =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(adev-&gt;vcn.gpu_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_C=
ACHE_64BIT_BAR_HIGH,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper=
_32_bits(adev-&gt;vcn.gpu_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE=
_OFFSET0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; offset =3D size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UVD_FIRMWARE_OFFSET &gt;&=
gt; 3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_VCPU_CACHE_SIZE0, size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_LMI_VCPU_CACHE1_64BIT_BAR_LOW,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ad=
ev-&gt;vcn.gpu_addr &#43; size));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bit=
s(adev-&gt;vcn.gpu_addr &#43; offset));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(ad=
ev-&gt;vcn.gpu_addr &#43; size));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bit=
s(adev-&gt;vcn.gpu_addr &#43; offset));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_VCPU_CACHE_OFFSET1, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_VCPU_CACHE_SIZE1, AMDGPU_VCN_HEAP_SIZE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_LMI_VCPU_CACHE2_64BIT_BAR_LOW,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ad=
ev-&gt;vcn.gpu_addr &#43; size &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bit=
s(adev-&gt;vcn.gpu_addr &#43; offset &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(ad=
ev-&gt;vcn.gpu_addr &#43; size &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bit=
s(adev-&gt;vcn.gpu_addr &#43; offset &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_VCPU_CACHE_OFFSET2, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD=
_VCPU_CACHE_SIZE2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGP=
U_VCN_STACK_SIZE &#43; (AMDGPU_VCN_SESSION_SIZE * 40));<br>
-- <br>
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

--_000_SN6PR12MB2656E11594EA2BC12BC5B38DE4390SN6PR12MB2656namp_--

--===============1882609561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1882609561==--
