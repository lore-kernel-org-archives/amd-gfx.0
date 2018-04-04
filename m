From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] tests/amdgpu: add vce mv tests support and sets
Date: Wed, 4 Apr 2018 14:44:12 -0400
Message-ID: <bf5ba149-a6ec-b13a-6bcd-13a9e97cb2b7@amd.com>
References: <1522782139-24945-1-git-send-email-James.Zhu@amd.com>
 <1522860234-21784-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271228588=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522860234-21784-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-GB
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
To: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1271228588==
Content-Type: multipart/alternative;
 boundary="------------0D308620A3A94A43CC1C67F9"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------0D308620A3A94A43CC1C67F9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/04/2018 12:43 PM, James Zhu wrote:
> Signed-off-by: James Zhu<James.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   tests/amdgpu/vce_ib.h    |  21 ++++-
>   tests/amdgpu/vce_tests.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 240 insertions(+), 5 deletions(-)
>
> diff --git a/tests/amdgpu/vce_ib.h b/tests/amdgpu/vce_ib.h
> index 80ab179..cbdcc71 100644
> --- a/tests/amdgpu/vce_ib.h
> +++ b/tests/amdgpu/vce_ib.h
> @@ -41,7 +41,7 @@ static uint32_t vce_taskinfo[8] = {
>   	0x00000000,
>   };
>   
> -static const uint32_t vce_create[] = {
> +static uint32_t vce_create[] = {
>   	0x00000030,
>   	0x01000001,
>   	0x00000000,
> @@ -144,7 +144,7 @@ static const uint32_t vce_rdo[] = {
>   	0x00000000,
>   };
>   
> -static const uint32_t vce_pic_ctrl[] = {
> +static uint32_t vce_pic_ctrl[] = {
>   	0x00000074,
>   	0x04000002,
>   	0x00000000,
> @@ -315,4 +315,21 @@ static const uint32_t vce_destroy[] = {
>   	0x00000008,
>   	0x02000001,
>   };
> +
Parameters array in header should keep read-only. You should modify IB 
on the fly with the conditions.


> +static const uint32_t vce_mv_buffer[] = {
> +	0x00000038,
> +	0x0500000d,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +};
>   #endif /*_vce_ib_h*/
> diff --git a/tests/amdgpu/vce_tests.c b/tests/amdgpu/vce_tests.c
> index 25c0b1f..7b5351a 100644
> --- a/tests/amdgpu/vce_tests.c
> +++ b/tests/amdgpu/vce_tests.c
> @@ -37,6 +37,7 @@
>   
>   #define IB_SIZE		4096
>   #define MAX_RESOURCES	16
> +#define FW_53_0_03 ((53 << 24) | (0 << 16) | (03 << 8))
>   
>   struct amdgpu_vce_bo {
>   	amdgpu_bo_handle handle;
> @@ -55,6 +56,9 @@ struct amdgpu_vce_encode {
>   	struct amdgpu_vce_bo cpb;
>   	unsigned ib_len;
>   	bool two_instance;
> +	struct amdgpu_vce_bo mvrefbuf;
> +	struct amdgpu_vce_bo mvb;
> +	unsigned mvbuf_size;
>   };
>   
>   static amdgpu_device_handle device_handle;
> @@ -62,6 +66,9 @@ static uint32_t major_version;
>   static uint32_t minor_version;
>   static uint32_t family_id;
>   static uint32_t vce_harvest_config;
> +static uint32_t chip_rev;
> +static uint32_t chip_id;
> +static uint32_t ids_flags;
>   
>   static amdgpu_context_handle context_handle;
>   static amdgpu_bo_handle ib_handle;
> @@ -75,33 +82,62 @@ static unsigned num_resources;
>   
>   static void amdgpu_cs_vce_create(void);
>   static void amdgpu_cs_vce_encode(void);
> +static void amdgpu_cs_vce_preset_mv(void);
> +static void amdgpu_cs_vce_encode_mv(void);
>   static void amdgpu_cs_vce_destroy(void);
>   
>   CU_TestInfo vce_tests[] = {
>   	{ "VCE create",  amdgpu_cs_vce_create },
>   	{ "VCE encode",  amdgpu_cs_vce_encode },
>   	{ "VCE destroy",  amdgpu_cs_vce_destroy },
> +	{ "VCE MV preset",  amdgpu_cs_vce_preset_mv },
> +	{ "VCE MV create",  amdgpu_cs_vce_create },
> +	{ "VCE MV dump",  amdgpu_cs_vce_encode_mv },
> +	{ "VCE MV destroy",  amdgpu_cs_vce_destroy },
Why to add create/destroy again? my understanding is that all the 
operations should be executable with one pair of create/destroy.


>   	CU_TEST_INFO_NULL,
>   };
>   
> -
>   CU_BOOL suite_vce_tests_enable(void)
>   {
> +	uint32_t version, feature;
> +	CU_BOOL ret_mv = CU_FALSE;
> +
>   	if (amdgpu_device_initialize(drm_amdgpu[0], &major_version,
>   					     &minor_version, &device_handle))
>   		return CU_FALSE;
>   
>   	family_id = device_handle->info.family_id;
> +	chip_rev = device_handle->info.chip_rev;
> +	chip_id = device_handle->info.chip_external_rev;
> +	ids_flags = device_handle->info.ids_flags;
> +
> +	amdgpu_query_firmware_version(device_handle, AMDGPU_INFO_FW_VCE, 0,
> +					  0, &version, &feature);
>   
>   	if (amdgpu_device_deinitialize(device_handle))
>   		return CU_FALSE;
>   
> -
>   	if (family_id >= AMDGPU_FAMILY_RV || family_id == AMDGPU_FAMILY_SI) {
>   		printf("\n\nThe ASIC NOT support VCE, suite disabled\n");
>   		return CU_FALSE;
>   	}
>   
> +	if (!(chip_id == (chip_rev + 0x3C) || /* FIJI */
> +			chip_id == (chip_rev + 0x50) || /* Polaris 10*/
> +			chip_id == (chip_rev + 0x5A) || /* Polaris 11*/
> +			chip_id == (chip_rev + 0x64) || /* Polaris 12*/
> +			(family_id > AMDGPU_FAMILY_VI && !ids_flags))) /* dGPU > Polaris */
> +		printf("\n\nThe ASIC NOT support VCE MV, suite disabled\n");
> +	else if (FW_53_0_03 >= version)
> +		printf("\n\nThe ASIC FW version NOT support VCE MV, suite disabled\n");
> +	else
> +		ret_mv = CU_TRUE;
> +
> +	amdgpu_set_test_active("VCE Tests", "VCE MV preset", ret_mv);
> +	amdgpu_set_test_active("VCE Tests", "VCE MV create", ret_mv);
> +	amdgpu_set_test_active("VCE Tests", "VCE MV dump", ret_mv);
> +	amdgpu_set_test_active("VCE Tests", "VCE MV destroy", ret_mv);
> +
>   	return CU_TRUE;
>   }
>   
> @@ -307,7 +343,7 @@ static void amdgpu_cs_vce_config(void)
>   	CU_ASSERT_EQUAL(r, 0);
>   }
>   
> -static  void amdgpu_cs_vce_encode_idr(struct amdgpu_vce_encode *enc)
> +static void amdgpu_cs_vce_encode_idr(struct amdgpu_vce_encode *enc)
>   {
>   
>   	uint64_t luma_offset, chroma_offset;
> @@ -521,6 +557,188 @@ static void amdgpu_cs_vce_encode(void)
>   	free_resource(&enc.cpb);
>   }
>   
> +static void amdgpu_cs_vce_preset_mv(void)
> +{
> +	vce_create[11] = 0x01000000;   /* disableTwoInstance */
As I know  with VCE only one instance, it will ignore this. If you think 
it matters,  you could make this value default, and re-set it with 2 
instances case, since we only have limited HW with 2 instances available.

Regards,
Leo


> +	vce_pic_ctrl[27] = 0x00000001; /* encSliceMode */
> +	vce_taskinfo[3] = 0;
> +	vce_taskinfo[4] = 0;
> +}
> +
> +static void amdgpu_cs_vce_mv(struct amdgpu_vce_encode *enc)
> +{
> +	uint64_t luma_offset, chroma_offset;
> +	uint64_t mv_ref_luma_offset;
> +	unsigned align = (family_id >= AMDGPU_FAMILY_AI) ? 256 : 16;
> +	unsigned luma_size = ALIGN(enc->width, align) * ALIGN(enc->height, 16);
> +	int len = 0, i, r;
> +
> +	luma_offset = enc->vbuf.addr;
> +	chroma_offset = luma_offset + luma_size;
> +	mv_ref_luma_offset = enc->mvrefbuf.addr;
> +
> +	memcpy((ib_cpu + len), vce_session, sizeof(vce_session));
> +	len += sizeof(vce_session) / 4;
> +	memcpy((ib_cpu + len), vce_taskinfo, sizeof(vce_taskinfo));
> +	len += sizeof(vce_taskinfo) / 4;
> +	memcpy((ib_cpu + len), vce_bs_buffer, sizeof(vce_bs_buffer));
> +	ib_cpu[len + 2] = enc->bs[0].addr >> 32;
> +	ib_cpu[len + 3] = enc->bs[0].addr;
> +	len += sizeof(vce_bs_buffer) / 4;
> +	memcpy((ib_cpu + len), vce_context_buffer, sizeof(vce_context_buffer));
> +	ib_cpu[len + 2] = enc->cpb.addr >> 32;
> +	ib_cpu[len + 3] = enc->cpb.addr;
> +	len += sizeof(vce_context_buffer) / 4;
> +	memcpy((ib_cpu + len), vce_aux_buffer, sizeof(vce_aux_buffer));
> +	for (i = 0; i <  8; ++i)
> +		ib_cpu[len + 2 + i] = luma_size * 1.5 * (i + 2);
> +	for (i = 0; i <  8; ++i)
> +		ib_cpu[len + 10 + i] = luma_size * 1.5;
> +	len += sizeof(vce_aux_buffer) / 4;
> +	memcpy((ib_cpu + len), vce_feedback, sizeof(vce_feedback));
> +	ib_cpu[len + 2] = enc->fb[0].addr >> 32;
> +	ib_cpu[len + 3] = enc->fb[0].addr;
> +	len += sizeof(vce_feedback) / 4;
> +	memcpy((ib_cpu + len), vce_mv_buffer, sizeof(vce_mv_buffer));
> +	ib_cpu[len + 2] = mv_ref_luma_offset >> 32;
> +	ib_cpu[len + 3] = mv_ref_luma_offset;
> +	ib_cpu[len + 4] = ALIGN(enc->width, align);
> +	ib_cpu[len + 5] = ALIGN(enc->width, align);
> +	ib_cpu[len + 6] = luma_size;
> +	ib_cpu[len + 7] = enc->mvb.addr >> 32;
> +	ib_cpu[len + 8] = enc->mvb.addr;
> +	len += sizeof(vce_mv_buffer) / 4;
> +	memcpy((ib_cpu + len), vce_encode, sizeof(vce_encode));
> +	ib_cpu[len + 2] = 0;
> +	ib_cpu[len + 3] = 0;
> +	ib_cpu[len + 4] = 0x154000;
> +	ib_cpu[len + 9] = luma_offset >> 32;
> +	ib_cpu[len + 10] = luma_offset;
> +	ib_cpu[len + 11] = chroma_offset >> 32;
> +	ib_cpu[len + 12] = chroma_offset;
> +	ib_cpu[len + 13] = ALIGN(enc->height, 16);;
> +	ib_cpu[len + 14] = ALIGN(enc->width, align);
> +	ib_cpu[len + 15] = ALIGN(enc->width, align);
> +	/* encDisableMBOffloading-encDisableTwoPipeMode-encInputPicArrayMode-encInputPicAddrMode */
> +	ib_cpu[len + 16] = 0x01010000;
> +	ib_cpu[len + 18] = 0; /* encPicType */
> +	ib_cpu[len + 19] = 0; /* encIdrFlag */
> +	ib_cpu[len + 20] = 0; /* encIdrPicId */
> +	ib_cpu[len + 21] = 0; /* encMGSKeyPic */
> +	ib_cpu[len + 22] = 0; /* encReferenceFlag */
> +	ib_cpu[len + 23] = 0; /* encTemporalLayerIndex */
> +	ib_cpu[len + 55] = 0; /* pictureStructure */
> +	ib_cpu[len + 56] = 0; /* encPicType -ref[0] */
> +	ib_cpu[len + 61] = 0; /* pictureStructure */
> +	ib_cpu[len + 62] = 0; /* encPicType -ref[1] */
> +	ib_cpu[len + 67] = 0; /* pictureStructure */
> +	ib_cpu[len + 68] = 0; /* encPicType -ref1 */
> +	ib_cpu[len + 81] = 1; /* frameNumber */
> +	ib_cpu[len + 82] = 2; /* pictureOrderCount */
> +	ib_cpu[len + 83] = 0xffffffff; /* numIPicRemainInRCGOP */
> +	ib_cpu[len + 84] = 0xffffffff; /* numPPicRemainInRCGOP */
> +	ib_cpu[len + 85] = 0xffffffff; /* numBPicRemainInRCGOP */
> +	ib_cpu[len + 86] = 0xffffffff; /* numIRPicRemainInRCGOP */
> +	ib_cpu[len + 87] = 0; /* remainedIntraRefreshPictures */
> +	len += sizeof(vce_encode) / 4;
> +
> +	enc->ib_len = len;
> +	r = submit(len, AMDGPU_HW_IP_VCE);
> +	CU_ASSERT_EQUAL(r, 0);
> +}
> +
> +static void check_mv_result(struct amdgpu_vce_encode *enc)
> +{
> +	uint64_t sum;
> +	uint32_t s = 140790;
> +	uint32_t *ptr, size;
> +	int i, j, r;
> +
> +	r = amdgpu_bo_cpu_map(enc->fb[0].handle, (void **)&enc->fb[0].ptr);
> +	CU_ASSERT_EQUAL(r, 0);
> +	ptr = (uint32_t *)enc->fb[0].ptr;
> +	r = amdgpu_bo_cpu_unmap(enc->fb[0].handle);
> +	CU_ASSERT_EQUAL(r, 0);
> +	r = amdgpu_bo_cpu_map(enc->mvb.handle, (void **)&enc->mvb.ptr);
> +	CU_ASSERT_EQUAL(r, 0);
> +	for (j = 0, sum = 0; j < enc->mvbuf_size; ++j)
> +		sum += enc->mvb.ptr[j];
> +	CU_ASSERT_EQUAL(sum, s);
> +	r = amdgpu_bo_cpu_unmap(enc->mvb.handle);
> +	CU_ASSERT_EQUAL(r, 0);
> +}
> +
> +static void amdgpu_cs_vce_encode_mv(void)
> +{
> +	uint32_t vbuf_size, bs_size = 0x154000, cpb_size;
> +	unsigned align = (family_id >= AMDGPU_FAMILY_AI) ? 256 : 16;
> +	int i, r;
> +
> +	vbuf_size = ALIGN(enc.width, align) * ALIGN(enc.height, 16) * 1.5;
> +	enc.mvbuf_size = ALIGN(enc.width, 16) * ALIGN(enc.height, 16) / 8;
> +	cpb_size = vbuf_size * 10;
> +	num_resources = 0;
> +	alloc_resource(&enc.fb[0], 4096, AMDGPU_GEM_DOMAIN_GTT);
> +	resources[num_resources++] = enc.fb[0].handle;
> +	alloc_resource(&enc.bs[0], bs_size, AMDGPU_GEM_DOMAIN_GTT);
> +	resources[num_resources++] = enc.bs[0].handle;
> +	alloc_resource(&enc.mvb, enc.mvbuf_size, AMDGPU_GEM_DOMAIN_GTT);
> +	resources[num_resources++] = enc.mvb.handle;
> +	alloc_resource(&enc.vbuf, vbuf_size, AMDGPU_GEM_DOMAIN_VRAM);
> +	resources[num_resources++] = enc.vbuf.handle;
> +	alloc_resource(&enc.mvrefbuf, vbuf_size, AMDGPU_GEM_DOMAIN_VRAM);
> +	resources[num_resources++] = enc.mvrefbuf.handle;
> +	alloc_resource(&enc.cpb, cpb_size, AMDGPU_GEM_DOMAIN_VRAM);
> +	resources[num_resources++] = enc.cpb.handle;
> +	resources[num_resources++] = ib_handle;
> +
> +	r = amdgpu_bo_cpu_map(enc.vbuf.handle, (void **)&enc.vbuf.ptr);
> +	CU_ASSERT_EQUAL(r, 0);
> +
> +	memset(enc.vbuf.ptr, 0, vbuf_size);
> +	for (i = 0; i < enc.height; ++i) {
> +		memcpy(enc.vbuf.ptr, (frame + i * enc.width), enc.width);
> +		enc.vbuf.ptr += ALIGN(enc.width, align);
> +	}
> +	for (i = 0; i < enc.height / 2; ++i) {
> +		memcpy(enc.vbuf.ptr, ((frame + enc.height * enc.width) + i * enc.width), enc.width);
> +		enc.vbuf.ptr += ALIGN(enc.width, align);
> +	}
> +
> +	r = amdgpu_bo_cpu_unmap(enc.vbuf.handle);
> +	CU_ASSERT_EQUAL(r, 0);
> +
> +	r = amdgpu_bo_cpu_map(enc.mvrefbuf.handle, (void **)&enc.mvrefbuf.ptr);
> +	CU_ASSERT_EQUAL(r, 0);
> +
> +	memset(enc.mvrefbuf.ptr, 0, vbuf_size);
> +	for (i = 0; i < enc.height; ++i) {
> +		memcpy(enc.mvrefbuf.ptr, (frame + (enc.height - i -1) * enc.width), enc.width);
> +		enc.mvrefbuf.ptr += ALIGN(enc.width, align);
> +	}
> +	for (i = 0; i < enc.height / 2; ++i) {
> +		memcpy(enc.mvrefbuf.ptr,
> +		((frame + enc.height * enc.width) + (enc.height / 2 - i -1) * enc.width), enc.width);
> +		enc.mvrefbuf.ptr += ALIGN(enc.width, align);
> +	}
> +
> +	r = amdgpu_bo_cpu_unmap(enc.mvrefbuf.handle);
> +	CU_ASSERT_EQUAL(r, 0);
> +
> +	amdgpu_cs_vce_config();
> +
> +	vce_taskinfo[3] = 3;
> +	amdgpu_cs_vce_mv(&enc);
> +	check_mv_result(&enc);
> +
> +	free_resource(&enc.fb[0]);
> +	free_resource(&enc.bs[0]);
> +	free_resource(&enc.vbuf);
> +	free_resource(&enc.cpb);
> +	free_resource(&enc.mvrefbuf);
> +	free_resource(&enc.mvb);
> +}
> +
>   static void amdgpu_cs_vce_destroy(void)
>   {
>   	int len, r;


--------------0D308620A3A94A43CC1C67F9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 04/04/2018 12:43 PM, James Zhu
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1522860234-21784-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 tests/amdgpu/vce_ib.h    |  21 ++++-
 tests/amdgpu/vce_tests.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 240 insertions(+), 5 deletions(-)

diff --git a/tests/amdgpu/vce_ib.h b/tests/amdgpu/vce_ib.h
index 80ab179..cbdcc71 100644
--- a/tests/amdgpu/vce_ib.h
+++ b/tests/amdgpu/vce_ib.h
@@ -41,7 +41,7 @@ static uint32_t vce_taskinfo[8] = {
 	0x00000000,
 };
 
-static const uint32_t vce_create[] = {
+static uint32_t vce_create[] = {
 	0x00000030,
 	0x01000001,
 	0x00000000,
@@ -144,7 +144,7 @@ static const uint32_t vce_rdo[] = {
 	0x00000000,
 };
 
-static const uint32_t vce_pic_ctrl[] = {
+static uint32_t vce_pic_ctrl[] = {
 	0x00000074,
 	0x04000002,
 	0x00000000,
@@ -315,4 +315,21 @@ static const uint32_t vce_destroy[] = {
 	0x00000008,
 	0x02000001,
 };
+</pre>
    </blockquote>
    Parameters array in header should keep read-only. You should modify
    IB on the fly with the conditions.<br>
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:1522860234-21784-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">+static const uint32_t vce_mv_buffer[] = {
+	0x00000038,
+	0x0500000d,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+};
 #endif /*_vce_ib_h*/
diff --git a/tests/amdgpu/vce_tests.c b/tests/amdgpu/vce_tests.c
index 25c0b1f..7b5351a 100644
--- a/tests/amdgpu/vce_tests.c
+++ b/tests/amdgpu/vce_tests.c
@@ -37,6 +37,7 @@
 
 #define IB_SIZE		4096
 #define MAX_RESOURCES	16
+#define FW_53_0_03 ((53 &lt;&lt; 24) | (0 &lt;&lt; 16) | (03 &lt;&lt; 8))
 
 struct amdgpu_vce_bo {
 	amdgpu_bo_handle handle;
@@ -55,6 +56,9 @@ struct amdgpu_vce_encode {
 	struct amdgpu_vce_bo cpb;
 	unsigned ib_len;
 	bool two_instance;
+	struct amdgpu_vce_bo mvrefbuf;
+	struct amdgpu_vce_bo mvb;
+	unsigned mvbuf_size;
 };
 
 static amdgpu_device_handle device_handle;
@@ -62,6 +66,9 @@ static uint32_t major_version;
 static uint32_t minor_version;
 static uint32_t family_id;
 static uint32_t vce_harvest_config;
+static uint32_t chip_rev;
+static uint32_t chip_id;
+static uint32_t ids_flags;
 
 static amdgpu_context_handle context_handle;
 static amdgpu_bo_handle ib_handle;
@@ -75,33 +82,62 @@ static unsigned num_resources;
 
 static void amdgpu_cs_vce_create(void);
 static void amdgpu_cs_vce_encode(void);
+static void amdgpu_cs_vce_preset_mv(void);
+static void amdgpu_cs_vce_encode_mv(void);
 static void amdgpu_cs_vce_destroy(void);
 
 CU_TestInfo vce_tests[] = {
 	{ "VCE create",  amdgpu_cs_vce_create },
 	{ "VCE encode",  amdgpu_cs_vce_encode },
 	{ "VCE destroy",  amdgpu_cs_vce_destroy },
+	{ "VCE MV preset",  amdgpu_cs_vce_preset_mv },
+	{ "VCE MV create",  amdgpu_cs_vce_create },
+	{ "VCE MV dump",  amdgpu_cs_vce_encode_mv },
+	{ "VCE MV destroy",  amdgpu_cs_vce_destroy },</pre>
    </blockquote>
    Why to add create/destroy again? my understanding is that all the
    operations should be executable with one pair of create/destroy.<br>
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:1522860234-21784-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">
 	CU_TEST_INFO_NULL,
 };
 
-
 CU_BOOL suite_vce_tests_enable(void)
 {
+	uint32_t version, feature;
+	CU_BOOL ret_mv = CU_FALSE;
+
 	if (amdgpu_device_initialize(drm_amdgpu[0], &amp;major_version,
 					     &amp;minor_version, &amp;device_handle))
 		return CU_FALSE;
 
 	family_id = device_handle-&gt;info.family_id;
+	chip_rev = device_handle-&gt;info.chip_rev;
+	chip_id = device_handle-&gt;info.chip_external_rev;
+	ids_flags = device_handle-&gt;info.ids_flags;
+
+	amdgpu_query_firmware_version(device_handle, AMDGPU_INFO_FW_VCE, 0,
+					  0, &amp;version, &amp;feature);
 
 	if (amdgpu_device_deinitialize(device_handle))
 		return CU_FALSE;
 
-
 	if (family_id &gt;= AMDGPU_FAMILY_RV || family_id == AMDGPU_FAMILY_SI) {
 		printf("\n\nThe ASIC NOT support VCE, suite disabled\n");
 		return CU_FALSE;
 	}
 
+	if (!(chip_id == (chip_rev + 0x3C) || /* FIJI */
+			chip_id == (chip_rev + 0x50) || /* Polaris 10*/
+			chip_id == (chip_rev + 0x5A) || /* Polaris 11*/
+			chip_id == (chip_rev + 0x64) || /* Polaris 12*/
+			(family_id &gt; AMDGPU_FAMILY_VI &amp;&amp; !ids_flags))) /* dGPU &gt; Polaris */
+		printf("\n\nThe ASIC NOT support VCE MV, suite disabled\n");
+	else if (FW_53_0_03 &gt;= version)
+		printf("\n\nThe ASIC FW version NOT support VCE MV, suite disabled\n");
+	else
+		ret_mv = CU_TRUE;
+
+	amdgpu_set_test_active("VCE Tests", "VCE MV preset", ret_mv);
+	amdgpu_set_test_active("VCE Tests", "VCE MV create", ret_mv);
+	amdgpu_set_test_active("VCE Tests", "VCE MV dump", ret_mv);
+	amdgpu_set_test_active("VCE Tests", "VCE MV destroy", ret_mv);
+
 	return CU_TRUE;
 }
 
@@ -307,7 +343,7 @@ static void amdgpu_cs_vce_config(void)
 	CU_ASSERT_EQUAL(r, 0);
 }
 
-static  void amdgpu_cs_vce_encode_idr(struct amdgpu_vce_encode *enc)
+static void amdgpu_cs_vce_encode_idr(struct amdgpu_vce_encode *enc)
 {
 
 	uint64_t luma_offset, chroma_offset;
@@ -521,6 +557,188 @@ static void amdgpu_cs_vce_encode(void)
 	free_resource(&amp;enc.cpb);
 }
 
+static void amdgpu_cs_vce_preset_mv(void)
+{
+	vce_create[11] = 0x01000000;   /* disableTwoInstance */</pre>
    </blockquote>
    As I know  with VCE only one instance, it will ignore this. If you
    think it matters,  you could make this value default, and re-set it
    with 2 instances case, since we only have limited HW with 2
    instances available.<br>
    <br>
    Regards,<br>
    Leo<br>
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:1522860234-21784-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">
+	vce_pic_ctrl[27] = 0x00000001; /* encSliceMode */
+	vce_taskinfo[3] = 0;
+	vce_taskinfo[4] = 0;
+}
+
+static void amdgpu_cs_vce_mv(struct amdgpu_vce_encode *enc)
+{
+	uint64_t luma_offset, chroma_offset;
+	uint64_t mv_ref_luma_offset;
+	unsigned align = (family_id &gt;= AMDGPU_FAMILY_AI) ? 256 : 16;
+	unsigned luma_size = ALIGN(enc-&gt;width, align) * ALIGN(enc-&gt;height, 16);
+	int len = 0, i, r;
+
+	luma_offset = enc-&gt;vbuf.addr;
+	chroma_offset = luma_offset + luma_size;
+	mv_ref_luma_offset = enc-&gt;mvrefbuf.addr;
+
+	memcpy((ib_cpu + len), vce_session, sizeof(vce_session));
+	len += sizeof(vce_session) / 4;
+	memcpy((ib_cpu + len), vce_taskinfo, sizeof(vce_taskinfo));
+	len += sizeof(vce_taskinfo) / 4;
+	memcpy((ib_cpu + len), vce_bs_buffer, sizeof(vce_bs_buffer));
+	ib_cpu[len + 2] = enc-&gt;bs[0].addr &gt;&gt; 32;
+	ib_cpu[len + 3] = enc-&gt;bs[0].addr;
+	len += sizeof(vce_bs_buffer) / 4;
+	memcpy((ib_cpu + len), vce_context_buffer, sizeof(vce_context_buffer));
+	ib_cpu[len + 2] = enc-&gt;cpb.addr &gt;&gt; 32;
+	ib_cpu[len + 3] = enc-&gt;cpb.addr;
+	len += sizeof(vce_context_buffer) / 4;
+	memcpy((ib_cpu + len), vce_aux_buffer, sizeof(vce_aux_buffer));
+	for (i = 0; i &lt;  8; ++i)
+		ib_cpu[len + 2 + i] = luma_size * 1.5 * (i + 2);
+	for (i = 0; i &lt;  8; ++i)
+		ib_cpu[len + 10 + i] = luma_size * 1.5;
+	len += sizeof(vce_aux_buffer) / 4;
+	memcpy((ib_cpu + len), vce_feedback, sizeof(vce_feedback));
+	ib_cpu[len + 2] = enc-&gt;fb[0].addr &gt;&gt; 32;
+	ib_cpu[len + 3] = enc-&gt;fb[0].addr;
+	len += sizeof(vce_feedback) / 4;
+	memcpy((ib_cpu + len), vce_mv_buffer, sizeof(vce_mv_buffer));
+	ib_cpu[len + 2] = mv_ref_luma_offset &gt;&gt; 32;
+	ib_cpu[len + 3] = mv_ref_luma_offset;
+	ib_cpu[len + 4] = ALIGN(enc-&gt;width, align);
+	ib_cpu[len + 5] = ALIGN(enc-&gt;width, align);
+	ib_cpu[len + 6] = luma_size;
+	ib_cpu[len + 7] = enc-&gt;mvb.addr &gt;&gt; 32;
+	ib_cpu[len + 8] = enc-&gt;mvb.addr;
+	len += sizeof(vce_mv_buffer) / 4;
+	memcpy((ib_cpu + len), vce_encode, sizeof(vce_encode));
+	ib_cpu[len + 2] = 0;
+	ib_cpu[len + 3] = 0;
+	ib_cpu[len + 4] = 0x154000;
+	ib_cpu[len + 9] = luma_offset &gt;&gt; 32;
+	ib_cpu[len + 10] = luma_offset;
+	ib_cpu[len + 11] = chroma_offset &gt;&gt; 32;
+	ib_cpu[len + 12] = chroma_offset;
+	ib_cpu[len + 13] = ALIGN(enc-&gt;height, 16);;
+	ib_cpu[len + 14] = ALIGN(enc-&gt;width, align);
+	ib_cpu[len + 15] = ALIGN(enc-&gt;width, align);
+	/* encDisableMBOffloading-encDisableTwoPipeMode-encInputPicArrayMode-encInputPicAddrMode */
+	ib_cpu[len + 16] = 0x01010000;
+	ib_cpu[len + 18] = 0; /* encPicType */
+	ib_cpu[len + 19] = 0; /* encIdrFlag */
+	ib_cpu[len + 20] = 0; /* encIdrPicId */
+	ib_cpu[len + 21] = 0; /* encMGSKeyPic */
+	ib_cpu[len + 22] = 0; /* encReferenceFlag */
+	ib_cpu[len + 23] = 0; /* encTemporalLayerIndex */
+	ib_cpu[len + 55] = 0; /* pictureStructure */
+	ib_cpu[len + 56] = 0; /* encPicType -ref[0] */
+	ib_cpu[len + 61] = 0; /* pictureStructure */
+	ib_cpu[len + 62] = 0; /* encPicType -ref[1] */
+	ib_cpu[len + 67] = 0; /* pictureStructure */
+	ib_cpu[len + 68] = 0; /* encPicType -ref1 */
+	ib_cpu[len + 81] = 1; /* frameNumber */
+	ib_cpu[len + 82] = 2; /* pictureOrderCount */
+	ib_cpu[len + 83] = 0xffffffff; /* numIPicRemainInRCGOP */
+	ib_cpu[len + 84] = 0xffffffff; /* numPPicRemainInRCGOP */
+	ib_cpu[len + 85] = 0xffffffff; /* numBPicRemainInRCGOP */
+	ib_cpu[len + 86] = 0xffffffff; /* numIRPicRemainInRCGOP */
+	ib_cpu[len + 87] = 0; /* remainedIntraRefreshPictures */
+	len += sizeof(vce_encode) / 4;
+
+	enc-&gt;ib_len = len;
+	r = submit(len, AMDGPU_HW_IP_VCE);
+	CU_ASSERT_EQUAL(r, 0);
+}
+
+static void check_mv_result(struct amdgpu_vce_encode *enc)
+{
+	uint64_t sum;
+	uint32_t s = 140790;
+	uint32_t *ptr, size;
+	int i, j, r;
+
+	r = amdgpu_bo_cpu_map(enc-&gt;fb[0].handle, (void **)&amp;enc-&gt;fb[0].ptr);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = (uint32_t *)enc-&gt;fb[0].ptr;
+	r = amdgpu_bo_cpu_unmap(enc-&gt;fb[0].handle);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_bo_cpu_map(enc-&gt;mvb.handle, (void **)&amp;enc-&gt;mvb.ptr);
+	CU_ASSERT_EQUAL(r, 0);
+	for (j = 0, sum = 0; j &lt; enc-&gt;mvbuf_size; ++j)
+		sum += enc-&gt;mvb.ptr[j];
+	CU_ASSERT_EQUAL(sum, s);
+	r = amdgpu_bo_cpu_unmap(enc-&gt;mvb.handle);
+	CU_ASSERT_EQUAL(r, 0);
+}
+
+static void amdgpu_cs_vce_encode_mv(void)
+{
+	uint32_t vbuf_size, bs_size = 0x154000, cpb_size;
+	unsigned align = (family_id &gt;= AMDGPU_FAMILY_AI) ? 256 : 16;
+	int i, r;
+
+	vbuf_size = ALIGN(enc.width, align) * ALIGN(enc.height, 16) * 1.5;
+	enc.mvbuf_size = ALIGN(enc.width, 16) * ALIGN(enc.height, 16) / 8;
+	cpb_size = vbuf_size * 10;
+	num_resources = 0;
+	alloc_resource(&amp;enc.fb[0], 4096, AMDGPU_GEM_DOMAIN_GTT);
+	resources[num_resources++] = enc.fb[0].handle;
+	alloc_resource(&amp;enc.bs[0], bs_size, AMDGPU_GEM_DOMAIN_GTT);
+	resources[num_resources++] = enc.bs[0].handle;
+	alloc_resource(&amp;enc.mvb, enc.mvbuf_size, AMDGPU_GEM_DOMAIN_GTT);
+	resources[num_resources++] = enc.mvb.handle;
+	alloc_resource(&amp;enc.vbuf, vbuf_size, AMDGPU_GEM_DOMAIN_VRAM);
+	resources[num_resources++] = enc.vbuf.handle;
+	alloc_resource(&amp;enc.mvrefbuf, vbuf_size, AMDGPU_GEM_DOMAIN_VRAM);
+	resources[num_resources++] = enc.mvrefbuf.handle;
+	alloc_resource(&amp;enc.cpb, cpb_size, AMDGPU_GEM_DOMAIN_VRAM);
+	resources[num_resources++] = enc.cpb.handle;
+	resources[num_resources++] = ib_handle;
+
+	r = amdgpu_bo_cpu_map(enc.vbuf.handle, (void **)&amp;enc.vbuf.ptr);
+	CU_ASSERT_EQUAL(r, 0);
+
+	memset(enc.vbuf.ptr, 0, vbuf_size);
+	for (i = 0; i &lt; enc.height; ++i) {
+		memcpy(enc.vbuf.ptr, (frame + i * enc.width), enc.width);
+		enc.vbuf.ptr += ALIGN(enc.width, align);
+	}
+	for (i = 0; i &lt; enc.height / 2; ++i) {
+		memcpy(enc.vbuf.ptr, ((frame + enc.height * enc.width) + i * enc.width), enc.width);
+		enc.vbuf.ptr += ALIGN(enc.width, align);
+	}
+
+	r = amdgpu_bo_cpu_unmap(enc.vbuf.handle);
+	CU_ASSERT_EQUAL(r, 0);
+
+	r = amdgpu_bo_cpu_map(enc.mvrefbuf.handle, (void **)&amp;enc.mvrefbuf.ptr);
+	CU_ASSERT_EQUAL(r, 0);
+
+	memset(enc.mvrefbuf.ptr, 0, vbuf_size);
+	for (i = 0; i &lt; enc.height; ++i) {
+		memcpy(enc.mvrefbuf.ptr, (frame + (enc.height - i -1) * enc.width), enc.width);
+		enc.mvrefbuf.ptr += ALIGN(enc.width, align);
+	}
+	for (i = 0; i &lt; enc.height / 2; ++i) {
+		memcpy(enc.mvrefbuf.ptr,
+		((frame + enc.height * enc.width) + (enc.height / 2 - i -1) * enc.width), enc.width);
+		enc.mvrefbuf.ptr += ALIGN(enc.width, align);
+	}
+
+	r = amdgpu_bo_cpu_unmap(enc.mvrefbuf.handle);
+	CU_ASSERT_EQUAL(r, 0);
+
+	amdgpu_cs_vce_config();
+
+	vce_taskinfo[3] = 3;
+	amdgpu_cs_vce_mv(&amp;enc);
+	check_mv_result(&amp;enc);
+
+	free_resource(&amp;enc.fb[0]);
+	free_resource(&amp;enc.bs[0]);
+	free_resource(&amp;enc.vbuf);
+	free_resource(&amp;enc.cpb);
+	free_resource(&amp;enc.mvrefbuf);
+	free_resource(&amp;enc.mvb);
+}
+
 static void amdgpu_cs_vce_destroy(void)
 {
 	int len, r;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0D308620A3A94A43CC1C67F9--

--===============1271228588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1271228588==--
