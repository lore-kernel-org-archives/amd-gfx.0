Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405E7C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B162075B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qCZRF1+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B162075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FA46E0A6;
	Mon, 13 Jan 2020 16:58:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8398E6E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 16:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn5XTVuAXX55i/QSZs3CGshh1zWsfXk9UI7Gtnc2VXadgcgaLI5DVbzmcDm2AtDSGkZQHKE/1X2dJeNX2eyQthKn40fX4e4FRKKLpLDKrthLM8M1+uZ9xmhVmcnl0aMvYg/V/pIVWot+aNbrthcIRhaJaPUzNiJqBOpjWrONmj9dJCNRJZxh4ygANIFTXZmwxKQWEmXpZqayT1JkDFJ/wEddGWWn3mYofqLcrGufkoW8RUTzNmAnVtGIswt8U5z2NOCXumu9Uwm9m3qnEfnrT1jhIRRCHox45uYhnJwM9gpQB+33SYzTx+s3R8mZvwaz7WKrCX2VKWOx+jgrqqIXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E5JDxMXlm4fmaVPUDLR8G1Ax5Y6FXzdBZuugnvBrz4=;
 b=YXk5o0+VbS1eETzd2y8dg7+8JcpKdyS9ntgjJPKhjt9yiNygoEssC4WA6eqjxS6FT+kZNjtNWQi5z3fhZXUX1EAzGQA1RhvIUyxJBVuFwDqA9IhAFi/mPhxwb/Kv3Jh2e5cHu0SaE7g6WfXROu4af0KC2opIj/lv+QLNhMVSoZt0J9np+FRLH8eDsHM2pm8ssqArFCnpu6+V6aYy6lieHJngl+ZYVfULHkJ8wI53JnOSQGzLU2pz+ZbRXsvX61S+DTdopffGe5qygAC6RJtw7V1dstkQnU7LsRwtio9x0X3RDZkHW0C5rNVbvxCDibWNclteffptylRpxtq3Fd6K0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E5JDxMXlm4fmaVPUDLR8G1Ax5Y6FXzdBZuugnvBrz4=;
 b=qCZRF1+8mcqyEuepjMEOceRMwNOepzgWVpmlGe6fLoiq2K+EH16MMzYcSubLAFfdg/TFxribIMBwfOlusVt/q6DNllYGHnRUSk0Q6kuCyUJkw6MLlXWu1kbfAxam4HfgWQvndOSTASHPt3Cj+cx0+OltN3Cwwd5XKRTI6fLrZek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (10.174.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 16:58:33 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:58:33 +0000
Subject: Re: [PATCH 6/7] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
 <20200111183938.126310-6-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <33b4ed3e-1141-c9fe-3e3f-135b98ac0b0c@amd.com>
Date: Mon, 13 Jan 2020 11:58:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200111183938.126310-6-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 16:58:33 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 110a2522-7a04-4523-e37a-08d79849d2b8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:|DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02033DBA4DE8F494CCBA845E92350@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(81156014)(31686004)(5660300002)(81166006)(8936002)(8676002)(86362001)(478600001)(36756003)(31696002)(6486002)(66556008)(66946007)(66476007)(2906002)(44832011)(316002)(16576012)(53546011)(2616005)(16526019)(36916002)(186003)(52116002)(26005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0203;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MAQ8JItxH9N1LiQWYaZNefFzf3yFnF6J9a82lGpfhJJBEy3gswqiXx8bIsT7xOk4ThCvhx19bfkBe+DQlWzeEqp8c7XMGduHZ9WWuvg1oh/zNkgKSgwZhbiY8NA0fwIsktyyMfX9POxNV/nV9y/7+epwen/JUTRVnctBXfwQHQnQgXuqqluyP/6Fhcc7J6XLA6EPAYcYFNHQ2bhncCMiSmT+dmEUDmHvvRq/w586ZXeS6v3duJfMLMrw0cuUVgrLUGwlR08qkPQEzJ8a3GdbFL74HbcpYKDZRCYAsJJIpHq701at4Kt3VzVnU13Vftdn96j8+WCf3yd7fPdjpiepbyiuXtYKCt48UkydqorSdRr9A3ugOuSAxjtBzPv+z3z4a4xlgd8YrBDONOdaRFdKEuJIw/2wJRmBwowRqXR5GwcqE9Vq4EwUZuKKVK99Euy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110a2522-7a04-4523-e37a-08d79849d2b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 16:58:33.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2I/ZirrRmsVdiYvJboAvvas/L8OyRCV4KCrxxXhYmOaHcjhb4Iu+pXguWfiO+A9fIiHcFZYaPpgu0ALMu2cYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

On 2020-01-11 1:39 p.m., Alex Sierra wrote:
> [Why]
> TLB flush method has been deprecated using kfd2kgd interface.
> This implementation is now on the amdgpu_amdkfd API.
>
> [How]
> TLB flush functions now implemented in amdgpu_amdkfd.
>
> Change-Id: Ic51cccdfe6e71288d78da772b6e1b6ced72f8ef7
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  8 ++++--
>   3 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 88e10b956413..8609287620ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -628,6 +628,38 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>   	return false;
>   }
>   
> +int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +
> +	if (adev->family == AMDGPU_FAMILY_AI) {
> +		int i;
> +
> +		for (i = 0; i < adev->num_vmhubs; i++)
> +			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
> +	} else {
> +		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +	uint32_t flush_type = 0;
> +	bool all_hub = false;
> +
> +	if (adev->gmc.xgmi.num_physical_nodes &&
> +		adev->asic_type == CHIP_VEGA20)
> +		flush_type = 2;
> +
> +	if (adev->family == AMDGPU_FAMILY_AI)
> +		all_hub = true;
> +
> +	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
> +}
> +
>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 069d5d230810..47b0f2957d1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -136,6 +136,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>   				uint32_t *ib_cmd, uint32_t ib_len);
>   void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
> +int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid);
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 536a153ac9a4..25b90f70aecd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -32,6 +32,7 @@
>   #include <linux/mman.h>
>   #include <linux/file.h>
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu.h"
>   
>   struct mm_struct;
>   
> @@ -1152,16 +1153,17 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
>   void kfd_flush_tlb(struct kfd_process_device *pdd)
>   {
>   	struct kfd_dev *dev = pdd->dev;
> -	const struct kfd2kgd_calls *f2g = dev->kfd2kgd;
>   
>   	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>   		/* Nothing to flush until a VMID is assigned, which
>   		 * only happens when the first queue is created.
>   		 */
>   		if (pdd->qpd.vmid)
> -			f2g->invalidate_tlbs_vmid(dev->kgd, pdd->qpd.vmid);
> +			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->kgd,
> +							pdd->qpd.vmid);
>   	} else {
> -		f2g->invalidate_tlbs(dev->kgd, pdd->process->pasid);
> +		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
> +						pdd->process->pasid);
>   	}
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
