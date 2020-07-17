Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7308C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 10:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617A320734
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e19CuEGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617A320734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FF26E02E;
	Fri, 17 Jul 2020 10:48:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FC96E02E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 10:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3ygkJOSXnvuI5Av79FCXwNo8u3q7SZuyQsfW/8sMEXxVd3YDgVA3v7s2L2t3pciNN+qGj70+ZWMJ8jmwCOoBS/m+WMnRi45b5vmxF8+DAYKZtXEkg1eKgoiFl7u8UDmbsOvJiY04361eV0nX5cmYclaQJH0NJuqZAq5OITg1IaJ4soMdKCCkRpEfHb09PnNVNSoPE4WFM2o87B1aJKqXZbqJjaweECG5162jRQ+0OkIT8rYfzuHg1jG1CRHfmbYibtu+djvRR8U7yL5jO7rCEfczPv4zmr2dcIJT9J1W/GBbmuqBM5cnzvXdxAdtj6oltlLvSP0vb6P+QyGsrjB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiGzqTY49jS5QkenZt1nCmEa/aRCLM9oai8huraSz98=;
 b=bVi+BaQ+T0NNDP+sKwvSlWMo1dfE4ceTLCJ3ks3n95UTfEMYpf3zSEQVJdZYr5jNS/REm7zpz9wfcnJAyd2m+5jRBwNsP2UMzssHEhrUVLpXp6XadydV/9XuJXWip3OGL6FnPYGrgV5s+yDh9yZnvdsC378/YHkI8a8xcZjU34ngWOxDd9K/tHX3gYVtr8MW+Cgbpd8IGv/khkHyimHRthOoYULigHZ2aOw+wxhIQn9C2VL4+m6knk9Nu4WNr9W9OxYs02tU5GhBB4GXLxu5+QqHEJRJfzfMApqyUvyu1xn1ifirzcPjclBIu9Qxc5xy/m0KpuHfmFoQyABKoxDvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiGzqTY49jS5QkenZt1nCmEa/aRCLM9oai8huraSz98=;
 b=e19CuEGoCQkiE3ST/prxgntJTFis/x0L/7reJb+R2QXlGqmx+13NerGQY3vSeLhdJPSKUNXIbaFrkz1T8Uun4ipncRJoGd1yAK8OaX6u5U1+/DmTTbSxwtq6E9xMh9xj4Ic4SE+opAFF9BDcgu4mCFHi6ZJaa1zrrGKw2gJUOS4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Fri, 17 Jul 2020 10:48:46 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 10:48:46 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/vcn: merge shared memory into vcpu
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1594905287-2895-1-git-send-email-James.Zhu@amd.com>
 <1594905287-2895-2-git-send-email-James.Zhu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <326be57e-781f-77a0-6169-4b5cef926cf6@amd.com>
Date: Fri, 17 Jul 2020 06:48:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <1594905287-2895-2-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.204] (165.204.55.251) by
 YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 10:48:45 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddb07fcc-aaa1-499d-fe16-08d82a3efaea
X-MS-TrafficTypeDiagnostic: DM6PR12MB3355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33552C33EAFFE0FF737A2C23E47C0@DM6PR12MB3355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo+LtCQsVJhU2kh3r21aADulTi+UVQThMHjnjtVAj6mZssDsbKSmLAfemplPxIb1b3LbV4iF5P0k810xAgKNcyPY8Ftn1qWrEoOb4xpUzX/pSnUWz/Fqq7IX4ViWgvvGQFU8uRteXpUxW1xuj5xJEDSPp0V8O+6QyPI5UEy+te678xzRoFJlpuCrG+FDJX9aAxIC88KdSyqss0UaC7OsbKMT0cWdwjO4GvnRQ2mrmR5qKEu1LmeID6px1DhA32zLXS19cJdBtyM6aYJLlrWIWdTAUvwWq6aK7nIkBUFZGCMPyDT/MRk7Lzn4BxEdGIBpL1NZXgSXi6V1XSL1Z4YRL1ugRluSBWRfgUwOMyTmGIQ25MVCuowWmjft6H+EQOhW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(36916002)(66946007)(26005)(66476007)(8676002)(66556008)(6486002)(8936002)(16526019)(478600001)(186003)(52116002)(5660300002)(2906002)(83380400001)(956004)(2616005)(31686004)(316002)(16576012)(53546011)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Djg6x9F5HaF7KgqKqxYFgcOq7fQRLQRJsaDmM2/K+kBUUDs75fJfyn+mJfWM78LzEAnCLHEkNW+llwnAGl9JIt1KvDsp3eeVwHspD6i4Lh4gl0kNAlJbeU2FNuDg/QgYJcdUgUv1mVmsvu+dQWrpyloDVleKRaIPU3dbjPNqbyrSZTNXeGcecXEpFtGSlTl8FGes100Sgb87wdqf4hj68QP+WFqvR+EFaTv1VgNtaymrvvq3ZNgXh5HFRK6C/Qo/dJWHQIlcqvhdPyxxKle0KYoiC7+YeyYtlfWbhigvAori1iFwAnsAaXfDMawEB4kfNB6w0wLsM/QPKn5uf4xcNtE7+t3FtuX0Q110ucEMN5MR705aMYby13pguYIRonleSqOUZyNzaxf0ELbKrRLNmE9kBfTGUvDlRc07cws3f4TwxE33YobgYElUuki+eeNSOjlibWo01wKZlxjmDWZSSX20E4HKYZpLs9PfJ9kzOG+PYJEmbXHokkcsAnzTd+tS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb07fcc-aaa1-499d-fe16-08d82a3efaea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 10:48:46.1746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ucs9zNR/HbFDsoiDBtGOWCRjqqxuh7n/+xmsbH2jQ8ufzbhc71SEFbnaarMegSYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
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

Ping ...

On 2020-07-16 9:14 a.m., James Zhu wrote:
> Merge vcn firmware shared memory bo into vcn vcpu bo.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 18 ++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 -
>   2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index cbc2b30..8c77f9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -168,6 +168,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
>   		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
> +	bo_size += AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		if (adev->vcn.harvest_config & (1 << i))
> @@ -181,6 +182,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   			return r;
>   		}
>   
> +		adev->vcn.inst[i].fw_shared_cpu_addr = adev->vcn.inst[i].cpu_addr +
> +				bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
> +		adev->vcn.inst[i].fw_shared_gpu_addr = adev->vcn.inst[i].gpu_addr +
> +				bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
> +
>   		if (adev->vcn.indirect_sram) {
>   			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
>   					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
> @@ -190,14 +196,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   				return r;
>   			}
>   		}
> -
> -		r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)),
> -				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].fw_shared_bo,
> -				&adev->vcn.inst[i].fw_shared_gpu_addr, &adev->vcn.inst[i].fw_shared_cpu_addr);
> -		if (r) {
> -			dev_err(adev->dev, "VCN %d (%d) failed to allocate firmware shared bo\n", i, r);
> -			return r;
> -		}
>   	}
>   
>   	return 0;
> @@ -213,10 +211,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
>   
> -		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
> -					  &adev->vcn.inst[j].fw_shared_gpu_addr,
> -					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
> -
>   		if (adev->vcn.indirect_sram) {
>   			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
>   						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index b5e9088..7a9b804 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -199,7 +199,6 @@ struct amdgpu_vcn_inst {
>   	struct amdgpu_irq_src	irq;
>   	struct amdgpu_vcn_reg	external;
>   	struct amdgpu_bo	*dpg_sram_bo;
> -	struct amdgpu_bo	*fw_shared_bo;
>   	struct dpg_pause_state	pause_state;
>   	void			*dpg_sram_cpu_addr;
>   	uint64_t		dpg_sram_gpu_addr;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
