Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22487C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 11:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45A360F44
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 11:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C45A360F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3148F6E069;
	Thu, 23 Sep 2021 11:39:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398F06E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 11:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXYXlsoKrpjaa8+uglndpXIvcZikHUqQpHr2lLDwPrW2fW6GDOLh4QeNhcgcRHnj8/53rlnPwHAmC5sVFd3AoxnEczoHBSZw3n75kXmA0K1Tl9knDVqXqutwK8uNILv4JCGb+IXjdQcsFd215XEJUrFNbPIrus0DHufYz+Xx1Bf8myLOiWNDXgYTXUIdtqwyikHnRGG07+KBh99kFGINce2K+AVcelHwTz982A+O2d+LxEzEfvBJ5QMcBKNdvr7J4TUjBQcjPkNrV9r4gBKReiCn86Xd1jyiwJd4JKa8dlvZsrPplSRG6SkSOASpz5GLjtotznhUqzRQI+GsmZn+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=PE305kYqkIl0pF9CRv2Wqr33W8QOjQDrzHW13Gd06Ig=;
 b=N7E6Z7jf4OBtXlrqmzuw1kxzu7M+IpCyuHI7DFWWxRUrm+Ske5/pQBPvrVTFAap1SRK9HN3AxGo6/o3utsmaa7Ty4JRan+ptyTqllZ0FZOmJnRaE0J3lmPuuqHPap4ewXg8HHly8A3KxOgUaI9ELuq3hLslH6iceQhRajX/dRFDWiHHIQ/6pSe3O7u/w93++bYoG3E0EuhM/QtfsBRcBZ33TWgWWHYqAXel4G2SrJVG3nj59WWC/z8UdbV+oxeIWWR1+qwx/2MwipJxVUYghp4TRB4fjEacbWArsJsxNGoasxZls4hWOFtewARYhp/jx1UalA5RW5UAtIA8ksmv/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE305kYqkIl0pF9CRv2Wqr33W8QOjQDrzHW13Gd06Ig=;
 b=tTstjolz9ylb2CXW0z05wstO/1po1t4hQrtAorKOEzy+fBU+wHtu4cTSusOEAx+5z8rM/EeC1onWsBXX+Vu84hkZcle4gm7qLsbiwRXy3ZbcOKNrU7iwjOKv4zW2w3nokoggA3nyfL31JlhFj6dddQEN7JQO+3aRjsQ6brdGfwg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 11:39:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 11:39:40 +0000
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian K nig <C3B6christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
Date: Thu, 23 Sep 2021 13:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210923094405.144613-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0088.eurprd05.prod.outlook.com
 (2603:10a6:207:1::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM3PR05CA0088.eurprd05.prod.outlook.com (2603:10a6:207:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:39:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c942a0e-edbb-42a3-a683-08d97e86d41c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45358C8F9500CA98EEBCEFD383A39@MN2PR12MB4535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7bbt1QPOwpglM+8gSSEsOHK0M80MVmJ0xi4B2bOm/4IBsi/mqGjq6yvAb5gPTgJL8bmL+TyA081Dig9DHFqb/wvVDBd0b8ZWaHo+FtnWQF3eyMRsEKzZovnJz+24mjOKYsJWtrEwZU/naCP4XllVUxfaYjIR2xJn7Cs0UCLZ7nu8O4O7Jt3sNliojZe8L7uDeIH4hO3ZGTNmc9huNAbTC//92E3cln9yYagpYTCBH9cr6/LIm6urb/Ld6yfneEhvlajUVUirRIo64Kua304qkruh0Bv7Ziv5aiHlJB3WfEorISW5Wg66I5/RfaDtIfvJoLuKRKpVr9Qv1bOPCdEbhUVpRYVEpuwTIp8rKzW86N3xxyvm/NJB8dc7kdfHcxlYyEdvbsRHEUR0P7cqyyJZXl6/UDG7uoCubBDMU34TX8ZUpzv940IT/ija535v/r5kn+2nNVzFuFemlPdPN6Lx0kY/m/cuCfglFIGzve4sisuxtCFrz796P9sVzajZZ7JCH4TpL52rGXX204luzjk9M1hfKyeP/ii4WYppO82rdWx2cLFxQsTMZmsBs2z8elsDOF8ts7NlrYd2DWSWTYDywgzulGBNCqC1rAUJ7g+CDkbASUgxsg3KHz9buP0ZV7FlRafRu/vmgYxeB2weICZgID/xFb0u6x9s7uzJTl86daSADcdRaYGwIRnGOJ+RtQBEJdo7453yPrYG3sGz1SXr9353zVuVd7BUhOFn020/gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(316002)(31696002)(16576012)(54906003)(66946007)(5660300002)(8936002)(6486002)(66476007)(66556008)(186003)(2616005)(956004)(8676002)(26005)(4326008)(508600001)(38100700002)(31686004)(2906002)(6666004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlnanl0dXY2OWFabjVyNUhIQWc1M1R6MTVBclhjMzBTRSs1WlFIeDlXeVlx?=
 =?utf-8?B?UEtIN2RremJoRk5CYmp4U0J1R3cxSFFOaFZlS2QyV3I3UGhJbHlVclNRQlhh?=
 =?utf-8?B?YWJsMUxuVDBwS1Z5TzNrMUV5ay9MRUE2NmxvRDgvN0hBdjhIY0NWVDUzMFZQ?=
 =?utf-8?B?T256ZUtmWXZFUmFlYmp2Z2VLVHR2TTZsaVR6RTdnWno3OUwwTk94eHhodkFt?=
 =?utf-8?B?ZGRvcUxhU1RDSjZGeWpOK0JDOHQrZDA0T0VSVituWGd4dzJNOWxUaWVRaDhN?=
 =?utf-8?B?UGlzTmh5ZU5ZdjFDSkpVRkg4Rlg1Z0hvRVpKVU1CYU9LdURoY1c4Y0xqaE5x?=
 =?utf-8?B?dW0rdzVEVXBVdnNQV2dXSWZxekFNZjI1OEFvemFYUS9BcE1mK2VXV0t6dVZM?=
 =?utf-8?B?c2Rwb09VNGFJajVPYnNwN2h4bm9LS1IvcG80b0JjZ0NkdFlNbXZVeG9aS3U4?=
 =?utf-8?B?Q2RBS0E3TktnQ09Uc094ZndESXVrTkUvTGlqUkU4alJ5Qm1sQlgzdnBRekpm?=
 =?utf-8?B?akpLWUJjN3dwWVJJaXBweHExQ3NoaFNURDUrTjdVM0l3cXNqdU5ldmd4SXZQ?=
 =?utf-8?B?MzVzQk5MNTgrUk9xU0ZFSGoyb3I4anlkY3ZzeTh4dG5rNW5HdXFzM2NkZ3dF?=
 =?utf-8?B?ZFRhSlFHL3Y2eVJwdm1JVktKTzMzM0VOK3dPNXhHcG9ObjYzd3FDV2dIUWhY?=
 =?utf-8?B?czJQU05Ja1hSc0JoK0RrL2VzYjlyVUMzdXRwN0VwUTQ5cG53cUlHMmFIMGtC?=
 =?utf-8?B?RDhlUFlSMnFGSGFHMmxDUFJpUW5kbU1qeHI4ZlFrZDhsd1hOVThjNEljbEFp?=
 =?utf-8?B?NCtMVyt3SHJ6QW9ka0lSeDhTV2tMaGRpcTc4VmJyajFZSHBCcEd6Y3MxSi9y?=
 =?utf-8?B?anZrdC9JN2JOdnRFbU1yRnJTNWZDdGRFQ2kxQ1FJcWNsVGR5c3dpVG8zNDhs?=
 =?utf-8?B?VDRyL1ZibHd0QzJUREUvT3FXRjJMb0NnZUt6RkhVdlJ5byt5R1ZaZ1BDT3R3?=
 =?utf-8?B?NStLLzNYRlQ2M0pOWnFvVmVpTmJORzBBeHYvd0R4Z0plSWtQN1dXZ3FMSm85?=
 =?utf-8?B?RlI0MWp3a1NzN1E4VzVHV0J0c3VVcDdCWFFldEZBSDRTTFlDWG4xaHZzT3NX?=
 =?utf-8?B?TENlazM2b0FtRnpFbnB5S2F6RTI2YmRnN0JueExkT2xaM0hjKzVNSUMrUysr?=
 =?utf-8?B?OUgveGVtMzhoSUhNenZaYzVQL1RKekovS3BaejR5ZEhQak1DaDdPdWQ3ZUlN?=
 =?utf-8?B?elJaY252cTlFWklha0dRMW5xa0hjOCtrY2xOK1RBWVNqSlJwV3lSMXErNS9L?=
 =?utf-8?B?c3dKRmVkK25xby9WV0E1YUw3SEhaVnBhVVk1TDBpcTBrb0lNMDlvTnJzSTVX?=
 =?utf-8?B?SnhsOFQ3RnVGbUlMVWpDK09QN1crY3o1dktDTGRwc1FPWmtnSnJTcS9FaTZm?=
 =?utf-8?B?V0J2WE9OSjEvaW11T25wcmRqaXY4Vmx1RjRLNWw0OTNGdzhXMWJ4aHpBeFFT?=
 =?utf-8?B?eVIvSGxMaklhUjZRTENGOHR4TFFLVktvNEJ2UjFhcXJ6SUM0K0F1WXpJb04x?=
 =?utf-8?B?S2dnRzNjUjdWUy8yOEpkWGs3SlVmVDZWSVorMVk2L1hIdFBQQWk2Ty9hMVcv?=
 =?utf-8?B?eVRvU3ArblN1UjZUc1FVNXN1ZUVkcUgyODlRWklNRnRoWGp6QmNlSkJ5V01q?=
 =?utf-8?B?cmdwclJvb0V0SkZYUy9RWmlkQkVyNVc4YUtLd1czRkVkYjJvSVIwN05JZkNl?=
 =?utf-8?Q?tSjqYoG6a1dM8Eivb7FRlX5QNfcUts7221WX3v+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c942a0e-edbb-42a3-a683-08d97e86d41c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:39:40.2628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJeZ90xE43WORmwTjVFal0qNkwwPXSPhVfyGH0gv413UIuyvt2Uyu/terLsUlbb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 23.09.21 um 11:44 schrieb Lang Yu:
> If a BO is pinned, unpin it before freeing it.
>
> Call Trace:
> 	ttm_bo_put+0x30/0x50 [ttm]
> 	amdgpu_bo_unref+0x1e/0x30 [amdgpu]
> 	amdgpu_gem_object_free+0x34/0x50 [amdgpu]
> 	drm_gem_object_free+0x1d/0x30 [drm]
> 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x31f/0x3a0 [amdgpu]
> 	kfd_process_device_free_bos+0xa3/0xf0 [amdgpu]
> 	kfd_process_wq_release+0x224/0x2e0 [amdgpu]
> 	process_one_work+0x220/0x3c0
> 	worker_thread+0x4d/0x3f0
> 	kthread+0x114/0x150
> 	process_one_work+0x3c0/0x3c0
> 	kthread_park+0x90/0x90
> 	ret_from_fork+0x22/0x30
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2d6b2d77b738..7e693b064072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1567,6 +1567,9 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
>   		mem->va + bo_size * (1 + mem->aql_queue));
>   
> +	if (mem->bo->tbo.pin_count)
> +		amdgpu_bo_unpin(mem->bo);
> +

NAK, using mem->bo->tbo.pin_count like this is illegal.

Where was the BO pinned in the first place?

Christian.

>   	ret = unreserve_bo_and_vms(&ctx, false, false);
>   
>   	/* Remove from VM internal data structures */

