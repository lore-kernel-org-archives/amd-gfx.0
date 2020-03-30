Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C59C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 14:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41A32073B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZKf9vbjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41A32073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4C76E3F2;
	Mon, 30 Mar 2020 14:21:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27A86E3F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 14:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu6oPOKJc1vxpBjw4qxYyhU80xuA7Ys8TDt/Gz5s3BXXA34iqfy779Ri4SauH8ZlxLXTJQp1EOs/zLMPPA1tCByOIjXyGWpSTEFBZPzg7j6UP3gbEx0uM0/Ud7IJ2EK4KpLuDHp9x990RLWcZpGfQYB6hCSF2+Pr/SbKiootBWvAwzz7ZGTkLbw6uwMfLzvohCe2CSpWAE6RgvIiaRTmdRd2nv4TThe3oIw6/+nAdTb6v/b7CWcrpD/6sKRDzWQRT9nNE7FQf2rUN1Tdlhnvp6Uarx5sdjMS9PTaUV6f9ZGseZRtkbYaFPu0LoxmjLK6Fn2Pw7QfYzXxwkMkbywKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlslxGqMMDhqjPM93LzuXPqOLR+AFGZ+wflHb5XrVmk=;
 b=TTHCOgPG1rFTnGeBdK+42vo2yuQUcXKAPxlyCMo467JGvU0ZqzvlHSjbF4zLASzdXmXhB/gTL2m0Ocmu1JqqPjK3Rgxkgk7GwFSu4s+RVPZ3A0Lba6waZXM9tBG0qj0XpDU1R68VtZCILjkiUZuIRInLhSRYEoMjDiXv6YWyoXeMy7B0bTha4zL+iKmZEIpLR5VqHxxOO6m8OFphLJjcRuhFoJ7OF3mw+kQNgEVZix/GWr4jXO9h7v+jCOpX1rzckyQKAAh1ikJyqM8WC0gClR4u2I6wZItBoRfxoQpoCGnjw7clehyztYgRAZuZgp1emRPGUVPwJvDlDcDD14y9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlslxGqMMDhqjPM93LzuXPqOLR+AFGZ+wflHb5XrVmk=;
 b=ZKf9vbjN/kOfBqx/IX8tJLcIpW//xMsrBX83r1nq7E0rU6wYHPBwUVNRKip/bXa2OLRrwbhdxAtqVF0GIK8j64esbCvPcH5940gN2xdQYUOFrt6JcoQCzAr4GrIbgfLgSqcGkLOKeS4NSXB1Pyubbeaw8tfvqNGgqAcHWM9lc5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 14:21:13 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:21:13 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu/vcn: Add firmware share memory support
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
 <1585570418-13894-3-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <ba771d61-642d-4ea3-ba77-1b22c7334ee1@amd.com>
Date: Mon, 30 Mar 2020 10:21:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1585570418-13894-3-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::29) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:e2d5:5eff:fe20:5971]
 (2607:fea8:a200:445:e2d5:5eff:fe20:5971) by
 YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 14:21:12 +0000
X-Originating-IP: [2607:fea8:a200:445:e2d5:5eff:fe20:5971]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1dc81720-2b16-4259-89ce-08d7d4b599a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:|DM6PR12MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3964A49DFC9692BD1880722AE5CB0@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(36756003)(16526019)(44832011)(186003)(2616005)(2906002)(316002)(478600001)(31696002)(53546011)(5660300002)(6486002)(4326008)(66476007)(66556008)(31686004)(86362001)(66946007)(8936002)(52116002)(8676002)(81166006)(81156014);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o74J4rTTAVYgjHgbRiiZ75915iXzTsxJxQhTNDCngwEn7ovKrAEiEyrJ8LhzVg1ik0gSMWI4uyEnuO+EnMHQKOi0kAukM8NCF5vpttO6gyYMEhb+PR+Tl3I/4CPOsDVy6cHNMra78oUvmpuA6dcWZ8lOSEjEpvgotbfxB0L+LTKv4Kj8XTqxgqMPy5mf+XrCykxckfaMcp2tURwjsqmBPNlUXhKd/wiCPtAY2JQIEekqp74PfQdl5QOr2gYF+G+K6KzLdpdSjUp4dB7m4XRxndKKDILsVmuYGYksGBya1E63bO+fP9yLrZBwQBX1TGPIE0WGJR6AlS343ytdFBwUDkiVvZGSHded6pbvOIOnAyxrrUm4wRjMcS4NcdOJZrq3Tz5JwFZV453Qi+aSKmaUrvf2gykULz/NBsp9a3/XGPcl1Frp3ewy9RckWBUIo08o
X-MS-Exchange-AntiSpam-MessageData: k2ChCuM/SclnFcwA6rl90p/LgNr/BpxmNtWBn2mP2HXRcsPc5c/nUiW+EzTCdbn0WTviyGR2ozJkEWk21ua0WE3zrSvxby5YO3JbcVRQcGHO85PbNqhIPs+mRrMf6mafMASmH+3evQ1RlSw5x2Znp9ZyS2OxO+MbAHmahTnc3J9WVIfZaL4oOvgWEuX/oMIYQbSrO6ZIE22Ee1IkWjzXTw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc81720-2b16-4259-89ce-08d7d4b599a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 14:21:12.9249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uwub+1DpLTx1pTU2N9Lz+8a7s0W66sLs4jz3cDYpVMjYFkTSrZTyYpV2+JJmP2md
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-03-30 8:13 a.m., James Zhu wrote:
> Added firmware share memory support for VCN. Current multiple
> queue mode is enabled only.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 24 ++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 7a0b074..328b6ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -182,6 +182,14 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   				return r;
>   			}
>   		}
> +
> +		r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)),
> +				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].fw_shared_bo,
> +				&adev->vcn.inst[i].fw_shared_gpu_addr, &adev->vcn.inst[i].fw_shared_cpu_addr);
> +		if (r) {
> +			dev_err(adev->dev, "VCN %d (%d) failed to allocate fimware shared bo\n", i, r);
> +			return r;
> +		}
>   	}
>   
>   	return 0;
> @@ -196,6 +204,11 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
> +
> +		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
> +					  &adev->vcn.inst[j].fw_shared_gpu_addr,
> +					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
> +
>   		if (adev->vcn.indirect_sram) {
>   			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
>   						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e913de8..853f0cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -179,11 +179,14 @@ struct amdgpu_vcn_inst {
>   	struct amdgpu_irq_src	irq;
>   	struct amdgpu_vcn_reg	external;
>   	struct amdgpu_bo	*dpg_sram_bo;
> +	struct amdgpu_bo	*fw_shared_bo;
>   	struct dpg_pause_state	pause_state;
>   	void			*dpg_sram_cpu_addr;
>   	uint64_t		dpg_sram_gpu_addr;
>   	uint32_t		*dpg_sram_curr_addr;
>   	atomic_t		dpg_enc_submission_cnt;
> +	void			*fw_shared_cpu_addr;
> +	uint64_t		fw_shared_gpu_addr;
>   };
>   
>   struct amdgpu_vcn {
> @@ -209,6 +212,27 @@ struct amdgpu_vcn {
>   		int inst_idx, struct dpg_pause_state *new_state);
>   };
>   
> +#define AMDGPU_VCN_MULTI_QUEUE_FLAG        (1 << 8)
> +
> +enum fw_queue_mode {
> +	fw_queue_ring_reset = 1,
> +	fw_queue_dpg_hold_off = 2,
> +};

Please move the define and enum to the top as others. With that fixed, 
the series are

Reviewed-by: Leo Liu <leo.liu@amd.com>



> +
> +struct amdgpu_fw_shared_multi_queue {
> +	uint8_t decode_queue_mode;
> +	uint8_t encode_generalpurpose_queue_mode;
> +	uint8_t encode_lowlatency_queue_mode;
> +	uint8_t encode_realtime_queue_mode;
> +	uint8_t padding[4];
> +};
> +
> +struct amdgpu_fw_shared {
> +	uint32_t present_flag_0;
> +	uint8_t pad[53];
> +	struct amdgpu_fw_shared_multi_queue multi_queue;
> +} __attribute__((__packed__));
> +
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
