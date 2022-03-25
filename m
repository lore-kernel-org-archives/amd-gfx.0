Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715C6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 05:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0350510E976;
	Fri, 25 Mar 2022 05:53:47 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C83B10E976
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 05:53:45 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef76.dynamic.kabel-deutschland.de
 [95.90.239.118])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D827661E64846;
 Fri, 25 Mar 2022 06:53:42 +0100 (CET)
Message-ID: <35bed3c6-3e37-8a49-3b50-c65b0af9ac88@molgen.mpg.de>
Date: Fri, 25 Mar 2022 06:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] drm/amdgpu/vcn3: send smu interface type
Content-Language: en-US
To: Boyuan Zhang <Boyuan.Zhang@amd.com>
References: <DM6PR12MB4843192241F9620519190F0487199@DM6PR12MB4843.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM6PR12MB4843192241F9620519190F0487199@DM6PR12MB4843.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Yifan Zhang <Yifan1.Zhang@amd.com>, Ray Huang <Ray.Huang@amd.com>,
 Leo Liu <Leo.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Boyuan,


Thank for the improved patch.


Am 24.03.22 um 18:25 schrieb Zhang, Boyuan:
> [AMD Official Use Only]

No idea if this would confuse `git am`.

> From: Boyuan Zhang <boyuan.zhang@amd.com<mailto:boyuan.zhang@amd.com>>

Your mailer(?) mangled the patch. Did you edit it in your MUA’s compose 
window?

> For VCN FW to detect ASIC type, in order to use different mailbox registers.
> 
> V2: simplify codes and fix format issue.
> 
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com<mailto:boyuan.zhang@amd.com>>
> Acked-by Huang Rui <ray.huang@amd.com>
> ---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 5 +++++
> 2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e2fde88aaf5e..f06fb7f882e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -159,6 +159,7 @@
> #define AMDGPU_VCN_MULTI_QUEUE_FLAG   (1 << 8)
> #define AMDGPU_VCN_SW_RING_FLAG                              (1 << 9)
> #define AMDGPU_VCN_FW_LOGGING_FLAG     (1 << 10)
> +#define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER        0x00000001
> #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER                         0x00000001
> @@ -279,6 +280,11 @@ struct amdgpu_fw_shared_fw_logging {
>                 uint32_t size;
> };
> +struct amdgpu_fw_shared_smu_interface_info {
> +             uint8_t smu_interface_type;
> +             uint8_t padding[3];
> +};
> +
> struct amdgpu_fw_shared {
>                 uint32_t present_flag_0;
>                 uint8_t pad[44];
> @@ -287,6 +293,7 @@ struct amdgpu_fw_shared {
>                 struct amdgpu_fw_shared_multi_queue multi_queue;
>                 struct amdgpu_fw_shared_sw_ring sw_ring;
>                 struct amdgpu_fw_shared_fw_logging fw_log;
> +             struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
> };
>   struct amdgpu_vcn_fwlog {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index b16c56aa2d22..9925b2bc63b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -219,6 +219,11 @@ static int vcn_v3_0_sw_init(void *handle)
>                                                                                      cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
>                                                                                      cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
>                                 fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
> +                             fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +                             if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2))
> +                                             fw_shared->smu_interface_info.smu_interface_type = 2;
> +                             else if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1))
> +                                             fw_shared->smu_interface_info.smu_interface_type = 1;
>                                  if (amdgpu_vcnfw_log)
>                                                 amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> --
> 2.25.1

The whole patch cannot be applied. Did `scripts/checkpatch.pl` not 
detect this? Please fix and resend.


Kind regards,

Paul
