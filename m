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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9129FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547FD61216
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 547FD61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EF46E073;
	Thu, 23 Sep 2021 12:24:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71AF6E073
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 12:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDOr/tsIQrVj/cz7QkOXCbflGNcLoZFII36O/qooesih5cm220g+QoHSTlntmq220OLO3XlMVeZ1MIeFx7Nj291oQROn5lLKzBUZZZk8RPAiWcJBNQfGPJVJa3niYzFX0pNKi8McrdLWa5KdxKHDSzEAOT8UcGXZXXuryIbWkBDP/0yPG1U2yykBz0yVtlBgTfyRFTEpt9wU15epjA0hjiQLrD+MzctF/L9+1bnkumtHNUNQDXu8cDl1jrQ/BBQFjYGG4xvr6mTmGKYsDVxVu7ANInpW0oEQ8r93JZsICbshXKlAacGvg22fR29NPXdDNVNgjH7yk4x0sVhVmYjGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=att0bC+zu52zmR4EtL99QoEmXLQd0L7tN5Yx5f1UcWs=;
 b=YGk5IP4tTAotLqgDjMXu+On6wuEI1szcaZ2krWFcgcj7TW2HZUIMLFdqMIN47qdxsRlMjtzi+fZSKO/JWw/2Rb1NmhXDBNykFw7/9ll4tQSc3nRvewMYfkuzDYkUbi08mGjVFRQtlN3x1eST35+bFFBuHvkB6Fp0kXK/4y0zTPJdm2ZiaUNTUidGHZH9/16UDukS6Ps+CsQLs8tYU8iQe5htzk9AngtsSQDvqTnyEB8ijjjqPeD4EGRULICzbSIsd7k+lODrNU4VPTyfEZruF4l8Oal9gxpHDE+xrb8P2s9WwvfrTzux0T7uVP4cXq8zC2Bx+6kqFu6+22AuOXf1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=att0bC+zu52zmR4EtL99QoEmXLQd0L7tN5Yx5f1UcWs=;
 b=tgJN5qk/Xux5hzKTyT2rTa/oE29HmAr+g0d/Giexoxs0Kgg63UnWuNSWL00cg8k7w+B9E48ZLZ/DiDWUNDGaN3tbxlJkywq85Ox+mAT+lhCOXP2ksu/4POOR062DfoAbuBFrhBupKARgL4VaOEb5CzyF7DTA4w2qIjgW+ViUKuU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 12:24:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:24:00 +0000
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Christian K nig <C3B6christian.koenig@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
Date: Thu, 23 Sep 2021 14:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0117.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 PR0P264CA0117.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 12:23:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0e07522-3559-4f9e-a0e5-08d97e8d05ff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45658D452F6618231BC932AD83A39@MN2PR12MB4565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh2RjatLMlCe02vupe+GbyIK0f0Js3ELzFqQI8t40kxMn0/zSPwEI+gWfU+URJDwL45Ma6Bkl/f7Q3ZzgZdeAlsDwhh4Spu1uirC1PSN9yOTOuqCVBHNXyNrzKVoKsFllEu2o5msiNixv89l9j2YStPFceY0gmSzPf6mWG/oSVHNlG/GTqKT1nUr5t2FoJFm/McY0O+2ggOs8hUHe//g5t6KKJKkU6Sb9gtfGcS2VtiUtOT4aEcIvA1Ir5dDVhHt1yWBAyXycznixuJap+DfjlLHzyhsV7mDafHzK46GVsKtEgW9pabUXhavV6OT/gCq6DHaYstHGUULaTjHuzFNvvwvVfyAw5X8+VB675aHMy2Go58wDGEnCEAmC2OcrIEpWI2txLlHE2TLFms+H33W5YnO26GSngBlWJAcbGVGOrDLRnVvIwfpogBOz4eCzOWRymAVn9qFXRUhB87XV+PYnZAmupD6chCSOxsQoJsfmy2RXFlAGJ5fgNi8EAClqoBwMtTsxuyYdPWtKDOWcKD3HURKmCPsatGDZXtR+wlLMvYvUhS12ZQXAbwdQLefNCr0fMk+nMaMXVc8cw4CsMJWvT4ybD7RxIRioofZuNq90pF5G5ygQExOYAigfUySwpVDqn1Ou/wmC4v2wTic/Ot+EkrKMER/xrNfLzH0vUKHm3BbdHCU75m71mK1PXCV2KV9Q2mYupMaPv9AOQDuMMul7vomYjK8lQywDoLcuzo5NmqTV0vKkFn5P5BZToFgJQHr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(5660300002)(53546011)(6666004)(316002)(508600001)(83380400001)(31686004)(6486002)(8936002)(38100700002)(956004)(16576012)(4326008)(2616005)(186003)(66476007)(66946007)(54906003)(66556008)(8676002)(36756003)(26005)(2906002)(110136005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pSeVVOYllCMEFCZTQySVRXU0dYOWVOZFZiTHdwM0JmSUFXK2hQS1REa1Az?=
 =?utf-8?B?SlA1Rzh4RVpkZzdxRDBIOXhlaFBvdXhGRm96ZFlwSXU1RHFFZFkySFdtRU8x?=
 =?utf-8?B?K0R2bGhuYUZuRHVVcHpCdlAxZ0NENGFIV1RhS2FBUFo3aWtTWm16MEJkRFpm?=
 =?utf-8?B?WDFGOHNSOUREeTdFUzN5UXdUY250STBzdWFJenNPV0lmNS93ZVVCR2IzbjNJ?=
 =?utf-8?B?OUs2VmlkWG1rc2tTa1RzdGF5TkhzL1U1cmNmQ09jNCtsUFBSRDRsY3pJclVT?=
 =?utf-8?B?a0xyQ3ZZcE5vSis2ck5RbDFlNHcxSmFSOFVpakloeHlmNFdDbzVwek50WWFH?=
 =?utf-8?B?UU15NDRRR3lhNkthTFUvaGR5MWdQSmttMTBPMDVSU0F6VVl4eEZPdFYwUUJX?=
 =?utf-8?B?UTVHNmZUZTF0ZVh5bStjamx0d2doNFJveVNDTzRhemNrbExWRi9OVHR1MSty?=
 =?utf-8?B?Vm1RdG1SL09yZ0FNY25ESk9RMUNYTWU0T3JqeHpsNTQyZzIwWjR0UkVaUitn?=
 =?utf-8?B?L0pwOGx1OVBySXZFcHJ2WXlxb0xLblIzS2tXOEpJNjZYODBjdk1BeHYrSVNu?=
 =?utf-8?B?N2svcnF0eFhtYXI5MVh2SW4vT3R4RjRlY3dZSlFHdlFoNVdjakg4Y1Vuc051?=
 =?utf-8?B?NHV0WTNneURNVVl6emJkaFJLc2YvQ0w4WXFLSFhuS1Jtc0t0ZmxOOXM2UXJj?=
 =?utf-8?B?cDlqYWYxVFJCNG12NktKMW85Q0kvemdBblJBZ1A0T3RWa2xZOHE4L1NEalY1?=
 =?utf-8?B?OHhIQm9jdHIxOGVYREoxaHEwc1FzVy9TUDU0QnFPOFc2dE5WWkZkZkdXMDVY?=
 =?utf-8?B?ZEF0ck9ZTVpwcGc3Y1ZJT2UzNGp3MVZ4cHRjZHZSZVdLT084Qzdwb21NS25a?=
 =?utf-8?B?TkZ6dmJGSnN5eG1uQm5laGVEUklZdnVaM2d2YWVvdVpsOXM0dFphaVg2K3lV?=
 =?utf-8?B?andQaHJsd1QrU1BWbkRQKytTNUNlWTlhNGQ3TEY3YUtjK2xOZ1lQMlVaQUtS?=
 =?utf-8?B?WXJKbzV2ck04cEFsbmt5Y2cxRFAvWmx4eWhYUlFFTVFkTFN2Y2FKK1A0RTYy?=
 =?utf-8?B?eDdEalUxQTFlR2FudThEUTVlN2xyUTF6K24yMkV5VTgwdGszYmhsU3ZJRGpr?=
 =?utf-8?B?eHhWV094dDFxSFQySVh6MkNJbUg5V2YrRmcxOW9jNXR3WEt6Umg2TE4zVTBz?=
 =?utf-8?B?cTVLaFZFTVhCQ09CWmZFU2x0VGNIUWhKN3JFYmxDQ3VoakJGNVorcmZ0S1Av?=
 =?utf-8?B?L2Nta0grVTB1SkN4WmtLZkEvWmQ2ZlJ5VHZsL2srb3BZSVpQdXFwam9LUThs?=
 =?utf-8?B?MmpPQUNSOW9xeHFLRG9pUHpRSWdRMjZJaE1jZkMxdWFPN2l1dGxMNlVPamg5?=
 =?utf-8?B?eFhPb3dKT0Q1OTRJd0pPZ21FL0JBZEdqUENURHJTV1BZZ3RkREZXKzQya09K?=
 =?utf-8?B?R2llL3RCQWYrNDVMMis2M05rMGMxSDRVdFJYWmk4cEZ6dEpQS1l5eEZzY1JV?=
 =?utf-8?B?WnlwT2R0eGpodVhLQTRlbGhWU2RqcC9wU25TekJWNTRtMkpEZXpxNzhXdHR5?=
 =?utf-8?B?N2Jjdmk3Z0xQelpxbUlneGRFRUdUVlNRRVJESlZqOHluSHZTUUVicGVQZlMw?=
 =?utf-8?B?MGVwTzZPM0xRcmNZbHNETGZ3T1htV3paeXVYY3VHMUtNUU1CUitGZzRySkx2?=
 =?utf-8?B?N2ZtZEhvS3F4RmZicU9Qb3BEcnFreDZGY1Fxc1FRU1dqTGsySmYzb2VPdkts?=
 =?utf-8?Q?lDWfHH60FMi2w9/XfBWzX+UEbmCGW3EFhdmUTWy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e07522-3559-4f9e-a0e5-08d97e8d05ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 12:24:00.7742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX23nBc9t8LU7PLkz0m+5+816H3PpnokMYzPvy3Y6iDz0lgKAyLmqcAPaMAgZ196
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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

Am 23.09.21 um 14:09 schrieb Yu, Lang:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, September 23, 2021 7:40 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Christian K nig
>> <C3B6christian.koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>
>>
>>
>> Am 23.09.21 um 11:44 schrieb Lang Yu:
>>> If a BO is pinned, unpin it before freeing it.
>>>
>>> Call Trace:
>>> 	ttm_bo_put+0x30/0x50 [ttm]
>>> 	amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>> 	amdgpu_gem_object_free+0x34/0x50 [amdgpu]
>>> 	drm_gem_object_free+0x1d/0x30 [drm]
>>> 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x31f/0x3a0 [amdgpu]
>>> 	kfd_process_device_free_bos+0xa3/0xf0 [amdgpu]
>>> 	kfd_process_wq_release+0x224/0x2e0 [amdgpu]
>>> 	process_one_work+0x220/0x3c0
>>> 	worker_thread+0x4d/0x3f0
>>> 	kthread+0x114/0x150
>>> 	process_one_work+0x3c0/0x3c0
>>> 	kthread_park+0x90/0x90
>>> 	ret_from_fork+0x22/0x30
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 2d6b2d77b738..7e693b064072 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1567,6 +1567,9 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>    	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
>>>    		mem->va + bo_size * (1 + mem->aql_queue));
>>>
>>> +	if (mem->bo->tbo.pin_count)
>>> +		amdgpu_bo_unpin(mem->bo);
>>> +
>> NAK, using mem->bo->tbo.pin_count like this is illegal.
> I didn't  get your point. I referred to function-"void amdgpu_bo_unpin(struct amdgpu_bo *bo)",
> which uses it like this.

What amdgpu_bo_unpin() does is the following:

         ttm_bo_unpin(&bo->tbo);
         if (bo->tbo.pin_count)
                 return;
....

In other words we take further actions based on if the buffer us is 
still pinned or not after an unpin operation.

What you try to do here is unpinning the BO when it is pinned 
independent if somebody else or our code has pinned it before.

That can lead to all kind of problems and is clearly illegal.

>> Where was the BO pinned in the first place?
> I found two places:
>
> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
> 				      &kaddr);
>
> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
> 				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);

Well then you need to figure out where that memory is freed again and 
place the unpin appropriately.

General rule of thumb is that calls to amdgpu_bo_pin/amdgpu_bo_unpin 
should be balanced.

Regards,
Christian.

> Regards,
> Lang
>
>> Christian.
>>
>>>    	ret = unreserve_bo_and_vms(&ctx, false, false);
>>>
>>>    	/* Remove from VM internal data structures */

