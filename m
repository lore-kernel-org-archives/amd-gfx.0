Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE1AC2D0C4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 11:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C9020409
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 11:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eI9qr8SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C9020409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C298D6E8BA;
	Tue, 10 Dec 2019 11:07:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A5B6E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 11:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeZNMwBN0OyP1SGY7gN+jwmvgpRx/Zcp2jCAYWtIeaMw17p0xDB1M0lwUrCPxYBrnFAFZxjq3DE96Av1b9OSFVJ+neGVKSZ0V2I+evWchbUKCbUGzmpPjSLAbVa45lx2fiDqN7olZkZ1UcU3UQIDmMPB0P1jiCKyz189JSekr/OAN+GROwcEJkToBXgzuokhYbNoD9f3hhufNFh/4Bset0WdJfTiWe+zYRpX660yIwoeySPBmVW+NjOT/HTjNhJAOj2wqJ0IDiHVRjBaLVxuDqJvkPi/DA8JbYrzbZSrbXOvlM2XZJbTm2wbbldJ5Ij/USZU/wsYWGSrbOmqLtpZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYWo8RfZ1vCV3+izdFFmFwYT2q6BcezMvxYuXhWg19w=;
 b=jfBNKK2zA0Ent0Fsi69MFviGrugyHa1JrwE3l+xepZbmU6W8ccIU6r1s8p49pdGLVcJgo+2yK9wEoR1D2cHC4shZkJNy64cOK/GRX3XMN1d27mOltVSFJe1Sx+TQ7KAtLf8Md9dtmyVKTKrL9HImKMnmCSF73cdNsh/M9trjXiEi2Ukb4WDi3TEmKGgf0iRjs5Jx8LNt0GmUCSyU5Mxk8ApTRvoYMSiQl2ikanbJZrNy9Rz5c8nNeLC/LILeUdnTFCL6SlzXTqkjEPr+Vtyfk2kjJNqFDiJxnzefJ7Waiv3hlsh1rXKVNIy9f5TbboW6dSyNk/gpe0oQPTOvlcvdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYWo8RfZ1vCV3+izdFFmFwYT2q6BcezMvxYuXhWg19w=;
 b=eI9qr8SGQqn5k7sGO9FlAVhqXTqHtU7YV1y1CZFvZIyECR+xIJFMo6QUjIaKDCV2NalOyRk0HXzdcG5dKld+o3B7yx4KJRhc/ambZsn1WyxVqCgIsqMIBmFVLOVbBANc9ECTh4A9mdj7/3zBHWVDQ68CiblF9B69/RvDsQFnnrQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1258.namprd12.prod.outlook.com (10.168.239.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 11:07:19 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 11:07:18 +0000
Subject: Re: [PATCH] drm/amdgpu: avoid using invalidate semaphore for
 picasso(v2)
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20191210025513.14625-1-changfeng.zhu@amd.com>
 <87718283-3287-819e-ee9f-a3d57112bc5d@amd.com>
 <MN2PR12MB28960B7A862EB9DA041CF034FD5B0@MN2PR12MB2896.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <70a81df0-ea97-ce6f-f623-69444326225f@amd.com>
Date: Tue, 10 Dec 2019 12:07:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB28960B7A862EB9DA041CF034FD5B0@MN2PR12MB2896.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0059.eurprd05.prod.outlook.com
 (2603:10a6:200:68::27) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a5ce3c5-50ea-4e36-8c6d-08d77d611f5b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:|DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258E99DCA5E55BB2015ED80835B0@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(13464003)(81166006)(66476007)(66556008)(31686004)(110136005)(186003)(81156014)(6636002)(8676002)(8936002)(36756003)(66946007)(5660300002)(52116002)(2616005)(86362001)(2906002)(498600001)(6506007)(6666004)(6512007)(6486002)(31696002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1258;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHGo1rPRm4s8yVYLje+S0GL9kDHs6AASArB5dmPP5KothwVdu6VsuomOzVs4MqQoGY7eLXup+aFrmSX+xuQJFZXSK84qB0RXdyypnx6kM93YG+LOWE5MM1EfTEFUqTvsubc4TiZrbYP11W89QCa8tD5EHpn1U2hTggmYr2/5lnvEjWrNa/2Maklv4QLDYAfQHYCTViTWdlT+D3zj78k5YKZK7t27mI5R/1ILt7T7YWEzx/aSu+Bf+/IVqsblxvdTZYB0OFeSaWmtVRqS4MoUazhTJIFGUnxCd2qLjoWwTFtzYbjSV0Lg1L3ceUClhFPy+cPUkTv0opbV4UhvY4cuhNDEk9TtLXt/nKquKJmjxvpoAxeizuzC87KOMnMsnV/yTcHoTZ32nTdp3Xqs3jt8fGQJXXj0AnJyHbE+KZKPNtKoMqhVaLEKJwvX1Uy1gzmE9KkPFYiibIxAXHPwzj7InXDle3qVUy05VDwEU4bW7ffuSMcC7Mh6EkG7LswCo22v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5ce3c5-50ea-4e36-8c6d-08d77d611f5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 11:07:18.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ13nJGfJqjn+blUoGoxTts7faxPHWZ18SrOLVmIKfDG8nX8/1cIuwallNNQPo6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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

Am 10.12.19 um 12:03 schrieb Zhu, Changfeng:
> [AMD Official Use Only - Internal Distribution Only]
>
> OK, Chris.
>
> What's about SRIOV?
>
> Should we skip using semaphore registers for SRIOV now?
>
> I add REG32_SOC15_OFFSET(MMHUB, 0, mmVM_INVALIDATE_ENG0_SEM, i, 0x0);
> in mmhub_v1_0_program_invalidation.
>
> However, the problem still happens.

Sorry totally missed that reply. Do we have an idea of the root cause?

I mean we should probably commit a workaround, but investigate what's 
going on here.

Regards,
Christian.

>
> BR,
> Changfeng,
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, December 10, 2019 6:55 PM
> To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: avoid using invalidate semaphore for picasso(v2)
>
> Am 10.12.19 um 03:55 schrieb Changfeng.Zhu:
>> From: changzhu <Changfeng.Zhu@amd.com>
>>
>> It may cause timeout waiting for sem acquire in VM flush when using
>> invalidate semaphore for picasso. So it needs to avoid using
>> invalidate semaphore for piasso.
> It would probably be better to add a small helper function to decide if the semaphore registers should be used or not.
>
> E.g. something like "bool gmc_v9_0_use_semaphore(adev, vmhub...)"
>
> Apart from that looks good to me,
> Christian.
>
>> Change-Id: I6dc552bde180919cd5ba6c81c6d9e3f800043b03
>> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 28 +++++++++++++++++++--------
>>    1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 231ea9762cb5..601667246a1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -464,8 +464,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>    	 */
>>    
>>    	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>> -	if (vmhub == AMDGPU_MMHUB_0 ||
>> -	    vmhub == AMDGPU_MMHUB_1) {
>> +	if ((vmhub == AMDGPU_MMHUB_0 ||
>> +	     vmhub == AMDGPU_MMHUB_1) &&
>> +	    (!(adev->asic_type == CHIP_RAVEN &&
>> +	       adev->rev_id < 0x8 &&
>> +	       adev->pdev->device == 0x15d8))) {
>>    		for (j = 0; j < adev->usec_timeout; j++) {
>>    			/* a read return value of 1 means semaphore acuqire */
>>    			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng); @@ -495,8
>> +498,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>    	}
>>    
>>    	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>> -	if (vmhub == AMDGPU_MMHUB_0 ||
>> -	    vmhub == AMDGPU_MMHUB_1)
>> +	if ((vmhub == AMDGPU_MMHUB_0 ||
>> +	     vmhub == AMDGPU_MMHUB_1) &&
>> +	    (!(adev->asic_type == CHIP_RAVEN &&
>> +	       adev->rev_id < 0x8 &&
>> +	       adev->pdev->device == 0x15d8)))
>>    		/*
>>    		 * add semaphore release after invalidation,
>>    		 * write with 0 means semaphore release @@ -527,8 +533,11 @@
>> static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>    	 */
>>    
>>    	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>> -	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
>> -	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
>> +	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
>> +	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
>> +	    (!(adev->asic_type == CHIP_RAVEN &&
>> +	       adev->rev_id < 0x8 &&
>> +	       adev->pdev->device == 0x15d8)))
>>    		/* a read return value of 1 means semaphore acuqire */
>>    		amdgpu_ring_emit_reg_wait(ring,
>>    					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1); @@ -544,8 +553,11 @@
>> static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>    					    req, 1 << vmid);
>>    
>>    	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>> -	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
>> -	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
>> +	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
>> +	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
>> +	    (!(adev->asic_type == CHIP_RAVEN &&
>> +	       adev->rev_id < 0x8 &&
>> +	       adev->pdev->device == 0x15d8)))
>>    		/*
>>    		 * add semaphore release after invalidation,
>>    		 * write with 0 means semaphore release

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
