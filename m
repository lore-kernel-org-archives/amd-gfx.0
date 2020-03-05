Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EAC3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398832073B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xAex2XLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398832073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5786EBDF;
	Thu,  5 Mar 2020 16:08:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED56E6EBE9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnApiOHa/0RrpMZjjgvL1U8UGKGsSVxqSwv+NbAOUNO+ubyXNzlelEcrKuCMAVuFAh7eamhDxmohjPmCG3ZvDMY/HficaBYQNNUjDIES9tlQ7oiUHDNQrlCvwgsSGyLhcbn/5lwnNdxOvkSDXUF/QUuuzfKvoBh+rH5EOIGrG7wjZJ3GoiCkxLaQxMiRrTRlo/+Qnl+61u6qBDVnPFWcFg7is7TML/gn84EUhPYOanpFko00i6VD7sAfaUGRnbGMoM2vQSuvGpdzfcLnU35r8HnnsZs9ytRfRxgRPjhzj2Shzz5Da33bmU7j4pr1UHvCen0PioRlcTAZzd8PvsdOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZGhJsXDO9/r/+5azWhgmTOBbhk+HcTMXoZpFQTmpOw=;
 b=AG60LkVcz7ZOUcSQgTl3MEay89P/4e4YW4TARjpYTAwaw/Ql//LZwz8mU9B/M8H03uaSMRDuXotOPvdxXdXdeBMM5h3lfTb7XQ23K7fQd4zhV6BOcsv9iY/pWByTHkyc/19XIZ7H2wqtR9snPJl/kbLZUDwf2njEN4q06AouBg1dVbPMkrYCkrRVD1HzTsEpFJSFFUhQmaHAcR8QjWQxVy2v8anNUBp+RE0So6vBLFz+DBfBauWpKU9m6rONh3nLAiySNEDM8m8ltgClEmdaG56gpwldQVo0TC/cOy3yeUs6FkaSE6wovSc1zMVzsJKxySNFOG7OCiMu0dOyy6NKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZGhJsXDO9/r/+5azWhgmTOBbhk+HcTMXoZpFQTmpOw=;
 b=xAex2XLp3l4f+9arL076vSu5rCPsW1goiKNpCgCnfPGhPa2s1UhFjLsJifCth8GxEb3jYV4Zj3B7nBrYTQkqg1UuC4V53LHhunBQ6aBTpKSGlOAfIBtYa9LTHtO/OFsizzgXrDTSI3AVnsOEv0w0HmTSDVmxAJK2wKlQDpcr0Mw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 16:07:59 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 16:07:59 +0000
Subject: Re: [enable VCN2.0 for NV12 SRIOV 3/6] drm/amdgpu: implement
 initialization part on VCN2.0 for SRIOV
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-3-git-send-email-Monk.Liu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <dd1f4dae-a48e-3d4f-0815-5b101810a794@amd.com>
Date: Thu, 5 Mar 2020 11:07:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1583415187-16594-3-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:917c:58ca:660b:c965]
 (2607:fea8:a200:445:917c:58ca:660b:c965) by
 YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 16:07:59 +0000
X-Originating-IP: [2607:fea8:a200:445:917c:58ca:660b:c965]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9703921-0253-4c8f-66fc-08d7c11f5fd7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:|DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155199FD81927C55D0BC9B5E5E20@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(66476007)(66946007)(66556008)(44832011)(316002)(8936002)(2616005)(478600001)(30864003)(31696002)(8676002)(81156014)(52116002)(81166006)(31686004)(186003)(6486002)(36756003)(53546011)(86362001)(5660300002)(2906002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xY7dZa5bevjGaiHhhyREZGWXKqhjk77wg/a0NP47fB5ASKOa55jkpguXXMy6bR31YMOJEbJI4VFhm3npUg37VBb2/p8RFF4ChRR320F2KhJqJoFWtGNOGzbD8olAsR1K1BNtxAavUQg04yw7qKuGHmE/PWRYZxl80IF3G/LY/j4ID3oE4PomF3C6LeOb8Otd+NiWw/NOekYacWryLLOm0R5ul5CVzsu5Kgc7BeNlo/Nuz4PTR8kfk4XmYcfzc/gLrZbNhDn4DHlzc446UMQqsRWTIQ94qgkibxRp728WqpZ1bmDV7Ed5XlsfvEP5n/UIuUUOZDAkb2s/2mQO9t4KiNfgpbJywCm+BfWQsUblBhZ/99r+Mvx39/ImjgCzOYiPmGOj29lwOSzsCy5qTTBuc7c410QAVfyejWD015cl6qN6L8hF6jsbFLF0r0742Zv/
X-MS-Exchange-AntiSpam-MessageData: 8K7UA3r9lhbINngycFavoUDTvTcZM/J3FIxdk/yfMnDtxVvHjDGg68y/89XVRbpes4w0J18ApatIA2GB6qUUMIld5uaCJVak7ncJ76Mrm/ifiI7Lq5sRt4XUbaj10klCRKhjHhgxVvVDhbc9DjkAf5ScHz61eR4GFbQfzWFOawc4WCu3oV4rmrfi0WI+Td81hJfCvyy/HtXhiKqQQsAJPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9703921-0253-4c8f-66fc-08d7c11f5fd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 16:07:59.5621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+Cfh4mfVjjp9JhX46I85YqfJBW2AnQDvdyIx7BtvhOPsg9I+9UxdR45v4uvwZ/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-03-05 8:33 a.m., Monk Liu wrote:
> one dec ring and one enc ring
It seems more than that, you might add more messages.


>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 231 +++++++++++++++++++++++++++++++++-
>   1 file changed, 228 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index c387c81..421e5bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -29,6 +29,7 @@
>   #include "soc15d.h"
>   #include "amdgpu_pm.h"
>   #include "amdgpu_psp.h"
> +#include "mmsch_v2_0.h"
>   
>   #include "vcn/vcn_2_0_0_offset.h"
>   #include "vcn/vcn_2_0_0_sh_mask.h"
> @@ -54,7 +55,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
>   				enum amd_powergating_state state);
>   static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				int inst_idx, struct dpg_pause_state *new_state);
> -
> +static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);

Please keep the empty line here.


>   /**
>    * vcn_v2_0_early_init - set function pointers
>    *
> @@ -67,7 +68,10 @@ static int vcn_v2_0_early_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	adev->vcn.num_vcn_inst = 1;
> -	adev->vcn.num_enc_rings = 2;
> +	if (amdgpu_sriov_vf(adev))
> +		adev->vcn.num_enc_rings = 1;
> +	else
> +		adev->vcn.num_enc_rings = 2;
>   
>   	vcn_v2_0_set_dec_ring_funcs(adev);
>   	vcn_v2_0_set_enc_ring_funcs(adev);
> @@ -154,7 +158,10 @@ static int vcn_v2_0_sw_init(void *handle)
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		ring->use_doorbell = true;
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
> +		if (!amdgpu_sriov_vf(adev))
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
> +		else
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
>   		if (r)
> @@ -163,6 +170,10 @@ static int vcn_v2_0_sw_init(void *handle)
>   
>   	adev->vcn.pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
>   
> +	r = amdgpu_virt_alloc_mm_table(adev);
> +	if (r)
> +		return r;
> +

This is not needed for bare metal.


>   	return 0;
>   }
>   
> @@ -178,6 +189,8 @@ static int vcn_v2_0_sw_fini(void *handle)
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	amdgpu_virt_free_mm_table(adev);
> +

same as above here.


Regards,

Leo



>   	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
> @@ -203,6 +216,9 @@ static int vcn_v2_0_hw_init(void *handle)
>   	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>   					     ring->doorbell_index, 0);
>   
> +	if (amdgpu_sriov_vf(adev))
> +		vcn_v2_0_start_sriov(adev);
> +
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
>   		goto done;
> @@ -1680,6 +1696,215 @@ static int vcn_v2_0_set_powergating_state(void *handle,
>   	return ret;
>   }
>   
> +static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
> +				struct amdgpu_mm_table *table)
> +{
> +	uint32_t data = 0, loop;
> +	uint64_t addr = table->gpu_addr;
> +	struct mmsch_v2_0_init_header *header;
> +	uint32_t size;
> +	int i;
> +
> +	header = (struct mmsch_v2_0_init_header *)table->cpu_addr;
> +	size = header->header_size + header->vcn_table_size;
> +
> +	/* 1, write to vce_mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
> +	 * of memory descriptor location
> +	 */
> +	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(addr));
> +	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(addr));
> +
> +	/* 2, update vmid of descriptor */
> +	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID);
> +	data &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +	/* use domain0 for MM scheduler */
> +	data |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +	WREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID, data);
> +
> +	/* 3, notify mmsch about the size of this descriptor */
> +	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_SIZE, size);
> +
> +	/* 4, set resp to zero */
> +	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
> +
> +	adev->vcn.inst->ring_dec.wptr = 0;
> +	adev->vcn.inst->ring_dec.wptr_old = 0;
> +	vcn_v2_0_dec_ring_set_wptr(&adev->vcn.inst->ring_dec);
> +
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		adev->vcn.inst->ring_enc[i].wptr = 0;
> +		adev->vcn.inst->ring_enc[i].wptr_old = 0;
> +		vcn_v2_0_enc_ring_set_wptr(&adev->vcn.inst->ring_enc[i]);
> +	}
> +
> +	/* 5, kick off the initialization and wait until
> +	 * VCE_MMSCH_VF_MAILBOX_RESP becomes non-zero
> +	 */
> +	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_HOST, 0x10000001);
> +
> +	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
> +	loop = 1000;
> +	while ((data & 0x10000002) != 0x10000002) {
> +		udelay(10);
> +		data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
> +		loop--;
> +		if (!loop)
> +			break;
> +	}
> +
> +	if (!loop) {
> +		DRM_ERROR("failed to init MMSCH, " \
> +			"mmMMSCH_VF_MAILBOX_RESP = 0x%08x\n", data);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
> +{
> +	int r;
> +	uint32_t tmp;
> +	struct amdgpu_ring *ring;
> +	uint32_t offset, size;
> +	uint32_t table_size = 0;
> +	struct mmsch_v2_0_cmd_direct_write direct_wt = { {0} };
> +	struct mmsch_v2_0_cmd_direct_read_modify_write direct_rd_mod_wt = { {0} };
> +	struct mmsch_v2_0_cmd_direct_polling direct_poll = { {0} };
> +	struct mmsch_v2_0_cmd_end end = { {0} };
> +	struct mmsch_v2_0_init_header *header;
> +	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
> +	uint8_t i = 0;
> +
> +	header = (struct mmsch_v2_0_init_header *)init_table;
> +	direct_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_WRITE;
> +	direct_rd_mod_wt.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
> +	direct_poll.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_POLLING;
> +	end.cmd_header.command_type = MMSCH_COMMAND__END;
> +
> +	if (header->vcn_table_offset == 0 && header->vcn_table_size == 0) {
> +		header->version = MMSCH_VERSION;
> +		header->header_size = sizeof(struct mmsch_v2_0_init_header) >> 2;
> +
> +		header->vcn_table_offset = header->header_size;
> +
> +		init_table += header->vcn_table_offset;
> +
> +		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
> +
> +		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
> +			0xFFFFFFFF, 0x00000004);
> +
> +		/* mc resume*/
> +		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +			tmp = AMDGPU_UCODE_ID_VCN;
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i,
> +					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				adev->firmware.ucode[tmp].tmr_mc_addr_lo);
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i,
> +					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				adev->firmware.ucode[tmp].tmr_mc_addr_hi);
> +			offset = 0;
> +		} else {
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i,
> +					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				lower_32_bits(adev->vcn.inst->gpu_addr));
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i,
> +					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				upper_32_bits(adev->vcn.inst->gpu_addr));
> +			offset = size;
> +		}
> +
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0),
> +			0);
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0),
> +			size);
> +
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i,
> +				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> +			lower_32_bits(adev->vcn.inst->gpu_addr + offset));
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i,
> +				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
> +			upper_32_bits(adev->vcn.inst->gpu_addr + offset));
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1),
> +			0);
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1),
> +			AMDGPU_VCN_STACK_SIZE);
> +
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i,
> +				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> +			lower_32_bits(adev->vcn.inst->gpu_addr + offset +
> +				AMDGPU_VCN_STACK_SIZE));
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i,
> +				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
> +			upper_32_bits(adev->vcn.inst->gpu_addr + offset +
> +				AMDGPU_VCN_STACK_SIZE));
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2),
> +			0);
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
> +			AMDGPU_VCN_CONTEXT_SIZE);
> +
> +		for (r = 0; r < adev->vcn.num_enc_rings; ++r) {
> +			ring = &adev->vcn.inst->ring_enc[r];
> +			ring->wptr = 0;
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO),
> +				lower_32_bits(ring->gpu_addr));
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI),
> +				upper_32_bits(ring->gpu_addr));
> +			MMSCH_V2_0_INSERT_DIRECT_WT(
> +				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE),
> +				ring->ring_size / 4);
> +		}
> +
> +		ring = &adev->vcn.inst->ring_dec;
> +		ring->wptr = 0;
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i,
> +				mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
> +			lower_32_bits(ring->gpu_addr));
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i,
> +				mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
> +			upper_32_bits(ring->gpu_addr));
> +		/* force RBC into idle state */
> +		tmp = order_base_2(ring->ring_size);
> +		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, tmp);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +		MMSCH_V2_0_INSERT_DIRECT_WT(
> +			SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
> +
> +		/* add end packet */
> +		tmp = sizeof(struct mmsch_v2_0_cmd_end);
> +		memcpy((void *)init_table, &end, tmp);
> +		table_size += (tmp / 4);
> +		header->vcn_table_size = table_size;
> +
> +	}
> +	return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
> +}
> +
>   static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
>   	.name = "vcn_v2_0",
>   	.early_init = vcn_v2_0_early_init,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
