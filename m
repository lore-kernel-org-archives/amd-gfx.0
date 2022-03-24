Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ED2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 05:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EC310E1A1;
	Thu, 24 Mar 2022 05:55:40 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E865410E1A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 05:55:38 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8e8.dynamic.kabel-deutschland.de
 [95.90.232.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6609961E64846;
 Thu, 24 Mar 2022 06:55:36 +0100 (CET)
Message-ID: <803cd706-a162-9dc7-1e9f-7e72ad70d0f3@molgen.mpg.de>
Date: Thu, 24 Mar 2022 06:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/vcn3: send smu interface type
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
References: <20220324025914.718674-1-yifan1.zhang@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220324025914.718674-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Yifan, dear Boyuan,


Am 24.03.22 um 03:59 schrieb Yifan Zhang:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
> 
> For VCN FW to detect ASIC type

What affect does this have? How does VCN FW behave different now?

> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e2fde88aaf5e..f06fb7f882e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -159,6 +159,7 @@
>   #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
>   #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
>   #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
> +#define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
>   
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> @@ -279,6 +280,11 @@ struct amdgpu_fw_shared_fw_logging {
>   	uint32_t size;
>   };
>   
> +struct amdgpu_fw_shared_smu_interface_info {
> +	uint8_t smu_interface_type;
> +	uint8_t padding[3];
> +};
> +
>   struct amdgpu_fw_shared {
>   	uint32_t present_flag_0;
>   	uint8_t pad[44];
> @@ -287,6 +293,7 @@ struct amdgpu_fw_shared {
>   	struct amdgpu_fw_shared_multi_queue multi_queue;
>   	struct amdgpu_fw_shared_sw_ring sw_ring;
>   	struct amdgpu_fw_shared_fw_logging fw_log;
> +	struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
>   };
>   
>   struct amdgpu_vcn_fwlog {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index b16c56aa2d22..c5bf7cbfa82c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -219,6 +219,13 @@ static int vcn_v3_0_sw_init(void *handle)
>   					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
>   					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
>   		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
> +		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2)) {
> +			fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +			fw_shared->smu_interface_info.smu_interface_type = 2;
> +		} else if(adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1)) {

Please add a space before the (, which `checkpatch.pl` also would have 
found:

     $ scripts/checkpatch.pl 
/dev/shm/0001-drm-amdgpu-vcn3-send-smu-interface-type.patch
     ERROR: space required before the open parenthesis '('
     #58: FILE: drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:225:
+               } else if(adev->ip_versions[UVD_HWIP][0] == 
IP_VERSION(3, 1, 1)) {

Also why not order it smallest version first? Will there ever be other 
IP versions for VCN 3.0?

> +			fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +			fw_shared->smu_interface_info.smu_interface_type = 1;
> +		}
>   
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);


Kind regards,

Paul
