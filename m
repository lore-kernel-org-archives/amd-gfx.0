Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC42C6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E6260FEE
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E6260FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1326E86C;
	Thu, 22 Jul 2021 14:45:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4316E86C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 14:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6avpCe4nolYciQ4B5kbxzpSppH+LG+8UbUjbwLKgcruKu4yBlvW1kS/PB+XrAV/qvco022j4hc8exzMuZTl7E2G2uc7NlfjU8BenvN6n84xQU5tivTwE/YLAoZ9N5tySUxLl7h2vEMlTRno3DL0ZJ/5aYDKXSMk/Ixf0LwNQpFoUpG4RtQQAzie/lbgN0NwRcv2HJRXjV0vRfn3SM+ex8MaSU9Z8riTXyix1k/BtEO5NUuzDGZsvod8hF7+TFrFCxok+f6dv2tyo48EkNG1+9GZYEvHgDsssdbO7YBWIFUdykWBg7o1m9lwD2DVK5xAYXEdS5YEOU38vZwwlkgIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlJtqRGGfFJ+aNUbbfuPi3Qcbu71jhv9nuk/GzsriWk=;
 b=gaJC9UTl3SATgTqM4YkyHS7bKYlz0PjpdpbjEylf013EtM6FAQQ8ok/FCxrbUsOCwuwNGt+eZsTseeaNPekh3b9bRj7BX5rJQj41tbp00TOPm0Eyf0llvnb1mK3VTTZjmozHPaFXSABunifGhQVM0pj/vBPsCoUVKjAVhYuHEdC0ax6OletHwGho3IAbk/zWl2ssw3se6boO2g5BTgyZ5+uBC+Mkgip2U2qj4bWL72z8wlCUnpKKop/M31xBLw97c9xu7ZLNT0jjGGQh7iwSBJgAECAbXpaPxo1RGqwLvTXRkTIpb0m8vzsfPYhn0M5rq+nIOfJ9IxkafR8rb4xSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlJtqRGGfFJ+aNUbbfuPi3Qcbu71jhv9nuk/GzsriWk=;
 b=pn55FmtCXGdDcDk+XXuihy4boeGcjc4hIWVz+Z19f6j+US/E6eJLaoegWHYc0v+qC2Jj56N7y5Dj1TMGoOh0o2Smfl8fJ8fTYEDja67I/ufXwLeP2t+z6doHO8iCZM7K7OpIp7bqAQXeYhQRbIQkNicEH5gZpUzxVB710IAM1Ao=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.34; Thu, 22 Jul
 2021 14:45:42 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 14:45:42 +0000
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
Date: Thu, 22 Jul 2021 10:45:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210722104525.okcnb43goxg6uqej@wayne-build>
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:ea12:7619:962f:f231]
 (2607:fea8:3edf:49b0:ea12:7619:962f:f231) by
 BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Thu, 22 Jul 2021 14:45:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77477a54-4306-45b0-d382-08d94d1f6165
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB249399711D7989E99D51890EEAE49@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIDg/nhNfIkwAZpdw3N0keq8mY5LZgJRofK4y2FXl9yOEzGmY2ysWphkD/AmAcqD8mDXSXjsyu0UtJVxJq2wPfsB/YW2vfwo8HJMQS65WkbYplvvCIhREkn+vQrx2wPxLIde9quIgmVWEz0nitCyyHBtakkqjEyIkRZ/dpCIT9i30zg7OXxX/0RtwY9ZbqkCajY0AwNWmEaCyHZtfVj9U/XIbCgA24CT35dt4KVD+hVsEZfRbwU9UVR0oWk+dC13qrKm9DROsqYrqLJHpzzexJIQlZ4kdv/YFMg6gXW2uMC+PH/n9ZKy1xNeDpsMg4NwDBLAnyI0SAjU3+g/sAzO4wlz/7lusBeG2DWTI1PvR4WJ4QG5rp/A5YdFm0CZ+hzcRIDAq7jUT0P/Rs24yu2cUDKmL7Khtr70Q8uAif5GMrPdOsVrbFMi2VYimXyfa8BRQ2TcgBmqhWn0D9vchISmiFyg/E8RFLmSkMytdznwNaifQVi3hOtnB0Bgexnv5/SyMUdqVnk+JeL+noz5Xiy8BAzo96VGi/JtMuZDTk/75IM32wCVdrDMs6zkB1pVUDBexcx2pbaPuTzM1FPf4Is4HK2qWkglr7q1SYIZck2JC7lNPJ1Dbpxq+wCBB8vs34dX5M+yKCCRwmTjDMvU0CSyi/X36zz2YcTa6mYJ/3JWbUvcwGqMzsOEWJnATEu+f7PfVsSShPJNyrfhxSPfshnFSvLOX7oTOmm6ZZU/YVGPxI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(31686004)(83380400001)(66476007)(5660300002)(86362001)(66556008)(31696002)(36756003)(38100700002)(53546011)(44832011)(316002)(478600001)(186003)(2616005)(8936002)(4326008)(2906002)(8676002)(6486002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdoWUM2SFc3MnViMXUyQkNuUDk4OXc1cGNKWHRuUmJLZEJPalFucVgrSWFY?=
 =?utf-8?B?ekpIaUMxNE9YZzNnRTBYMTZ2K01tQ29KKzh4Y3o1MkJMZ0xUdHJKTVorN2VI?=
 =?utf-8?B?VmtVdWk4RkVMR0s5UGpUZDlkNGhsTUFHQmtXeGhiWFJlc0t1d2hKenpQaXB1?=
 =?utf-8?B?L1BUMkRwYnMwQjd1M0R0QVF1czZ1NUhERGI4dnBjM1UvU2JpU3R0YlRPbjQ2?=
 =?utf-8?B?K3h5Q2ZwWHBZMEVFUXYzc0tqRFdkc3VzNE42Mlh1dXlYemhMMFk4bDEvcU5B?=
 =?utf-8?B?RVFZOWtZN254OGRiZUthMXFlc1ErSGtDWk42QWpmcDVEK21LckpwWmlQeG1I?=
 =?utf-8?B?dVRScDVLd1VNUnR2aUFqbnVPN1FYNTJVQUZPL0dFaTFmOHJvRjgrTGZoOWUv?=
 =?utf-8?B?eDEvdkFiWWh3WmRyNHIrT2E2aU05blVnKzZ6RnZKckxJTW1IQjJtanV3WTFu?=
 =?utf-8?B?TWpOOFZ6Sms1RXRpY3FQOGxFcUJTWHJFV2wvNS9zRVRFbEZwdHRmVElEeDMy?=
 =?utf-8?B?Zm1EOVNZZWxnMTRhdHAwQTNPeHN6OWVLTTRPdnV3M0t3YWNSMlNndFRKNDFH?=
 =?utf-8?B?R0hBT1VaaDBxaGMzWS9rSStEdnhQODFVNzFPR0JaYmZOeVdiejFXV0JSUm93?=
 =?utf-8?B?OVJDVnlzL240ZlRscXNsTFUwRm9JSXd1S0REVE5LLzRRSGlmcmo4QkZPam1o?=
 =?utf-8?B?U0tBU2JLT3JLeG96NFhHa2F4enpQbE9GVTMxTDlDQTdnYVlyWUFnMkErS2gw?=
 =?utf-8?B?SEZVc2F6NnBJT3pHUllabEttRWdTSE1HRW1aOEw1aDJVZWRGeWRUQmNCK01L?=
 =?utf-8?B?dUdDczhaYXpwRzRJd2R5d0o3TUZNaTZSV2NhUnlEejI3MERUNmlGSmhTa09k?=
 =?utf-8?B?eWZVWTR4dW9zdDVYZkt3NEdUbk8vZzY1VjVLNmZkYy9lN3F6MUtaT0dTbXFG?=
 =?utf-8?B?MHdOQTZWT0piS2pGaW1jY0t4M3g0Z3hMZUpzRDM4dVBTemMydmNMemlxTTUr?=
 =?utf-8?B?cEJIbUdKNFNIY0xtZXZZR2k4OS9yY1lTbEphUGFzNVRPQ21vZ0g0QVVyU1RH?=
 =?utf-8?B?T3liNlZLUTdJekpuaHhNcUNXQ1FFYmdUSEgzK2t6ZXRtaUhjUHVxdmJXc2tl?=
 =?utf-8?B?bFFJR1VreE1KSEtkY2xYWTJlTzQrQVIxeU5pMUNGcmZtR0o0RC9jUkdFVlpG?=
 =?utf-8?B?N1JSck1Td0dSWDFnSit6WEdKc2pqYUFpZnU4WS9BZXNNWkVuMEVDVC96UlVG?=
 =?utf-8?B?dWphODR4NnQwbkFYcU0rN2JGWnBaMWMyeGlXNEZ6Vmo0T1pLaXIvVkNPaW5n?=
 =?utf-8?B?a0dDZCt0UDhaaDV1bkpOekZHYlJ3dnRnQmx6RFRmRDZmY0EwK2ZiSi9lTWZG?=
 =?utf-8?B?ZmRLWGtGUmM2OHR2bEgxU3RTQ1VVcWtQN1k5aGtwUTVBTmI0NFBhT0lBOFc3?=
 =?utf-8?B?d3FlQURzbXAzeXptMHVwaEZCT1pvbkQxRFFRR2pEa3k3OUFpVk1Cd0pRRms3?=
 =?utf-8?B?NmtlVFpHK3lVNmFtcTNDdDB6RE9XWXdpK2JkVFN6ZmpxVUd0UUpGZ0p0WHNw?=
 =?utf-8?B?SGFXUlN4RnlCZzlPMGxHWmF5UitEZ3dETGcwOXJ0cDdVckNGaGp0cHZoVGxU?=
 =?utf-8?B?OGQ1RXRyaGpaaTN4SEJHWU1mNS8wRlIyRkVsVktBYWtLWW1CbzIyaEhQSEVr?=
 =?utf-8?B?dTFTQkUrSDJyUWMwR0NPbTNTWlRBYkx2WHgyd1U3bUY0cnlXeU5DMitXMHlu?=
 =?utf-8?B?V2ZWUGRlL0Ixa1lSaEZmQVFzVVJaZEFkNWdOVTlnOEtWbVQwaE4wcWhRR0VO?=
 =?utf-8?B?ZER4ZXV1dTB3UklqYXRvVGM4OS9ka2JvTTdmTUhSWllTREg0YUxIaHc0cGly?=
 =?utf-8?Q?tmgwgU4zaQ26C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77477a54-4306-45b0-d382-08d94d1f6165
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:45:42.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf8zR/Ub1kl8G21XKv5zthQaxotEh6qZCbSChVwDK/qlt1jhU3El7yoZ794LbGWNciZSOzYB1lQbFJvctWfRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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
Cc: ckoenig.leichtzumerken@gmail.com, horace.chen@amd.com,
 "jingwen.chen2@amd.com Jack Zhang" <Jack.Zhang1@amd.com>, monk.liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-07-22 6:45 a.m., Jingwen Chen wrote:
> On Wed Jul 21, 2021 at 12:53:51PM -0400, Andrey Grodzovsky wrote:
>> On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
>>> [Why]
>>> After embeded hw_fence to amdgpu_job, we need to add tdr support
>>> for this feature.
>>>
>>> [How]
>>> 1. Add a resubmit_flag for resubmit jobs.
>>> 2. Clear job fence from RCU and force complete vm flush fences in
>>>      pre_asic_reset
>>> 3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
>>>      for guilty jobs.
>>>
>>> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 16 +++++++++++-----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  4 +++-
>>>    drivers/gpu/drm/scheduler/sched_main.c     |  1 +
>>>    include/drm/gpu_scheduler.h                |  1 +
>>>    5 files changed, 27 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 40461547701a..fe0237f72a09 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>>    int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>    				 struct amdgpu_reset_context *reset_context)
>>>    {
>>> -	int i, r = 0;
>>> +	int i, j, r = 0;
>>>    	struct amdgpu_job *job = NULL;
>>>    	bool need_full_reset =
>>>    		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>>> @@ -4406,6 +4406,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>    		if (!ring || !ring->sched.thread)
>>>    			continue;
>>> +		/*clear job fence from fence drv to avoid force_completion
>>> +		 *leave NULL and vm flush fence in fence drv */
>>> +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
>>> +			struct dma_fence *old,**ptr;
>>> +			ptr = &ring->fence_drv.fences[j];
>>> +			old = rcu_dereference_protected(*ptr, 1);
>>> +			if (old && test_bit(DMA_FENCE_FLAG_USER_BITS, &old->flags))) {
>>> +				RCU_INIT_POINTER(*ptr, NULL);
>>> +			}
>>
>> Is this to avoid premature job free because of dma_fence_put inside
>> amdgpu_fence_process ?
>> I can't currently remember why but we probably want all the HW fences
>> currently in the ring to
>> be forced signaled - maybe better to test for DMA_FENCE_FLAG_USER_BITS
>> inside amdgpu_fence_process
>> and still do the signaling but not the dma_fence_put part
>>
>> Andrey
> Hi Andrey,
>
> This is to avoid signaling the same fence twice. If we still do the
> signaling, then the job in the pending list will be signaled first in
> force_completion, and later be signaled in resubmit. This will go to
> BUG() in amdgpu_fence_process.


Oh, i see, how about just adding 'skip' flag to amdgpu_ring and setting 
it before calling
amdgpu_fence_driver_force_completion and resetting it after, then inside 
amdgpu_fence_driver_force_completion
you can just skip the signaling part with this flag for fences with 
DMA_FENCE_FLAG_USER_BITS set
Less lines of code at least.

Andrey


>
>>> +		}
>>>    		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>>>    		amdgpu_fence_driver_force_completion(ring);
>>>    	}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index eecf21d8ec33..815776c9a013 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>>>    		job->ring = ring;
>>>    	}
>>> -	seq = ++ring->fence_drv.sync_seq;
>>> -	dma_fence_init(fence, &amdgpu_fence_ops,
>>> -		       &ring->fence_drv.lock,
>>> -		       adev->fence_context + ring->idx,
>>> -		       seq);
>>> +	if (job != NULL && job->base.resubmit_flag == 1) {
>>> +		/* reinit seq for resubmitted jobs */
>>> +		seq = ++ring->fence_drv.sync_seq;
>>> +		fence->seqno = seq;
>>> +	} else {
>>> +		seq = ++ring->fence_drv.sync_seq;
>>
>> Seems like you could do the above line only once above if-else as it was
>> before
> Sure, I will modify this.
>
>
> Best Regards,
> JingWen Chen
>>> +		dma_fence_init(fence, &amdgpu_fence_ops,
>>> +				&ring->fence_drv.lock,
>>> +				adev->fence_context + ring->idx,
>>> +				seq);
>>> +	}
>>>    	if (job != NULL) {
>>>    		/* mark this fence has a parent job */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 7c426e225b24..d6f848adc3f4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -241,6 +241,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>>>    		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
>>>    	if (finished->error < 0) {
>>> +		dma_fence_put(&job->hw_fence);
>>>    		DRM_INFO("Skip scheduling IBs!\n");
>>>    	} else {
>>>    		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
>>> @@ -249,7 +250,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>>>    			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>>>    	}
>>> -	dma_fence_get(fence);
>>> +	if (!job->base.resubmit_flag)
>>> +		dma_fence_get(fence);
>>>    	amdgpu_job_free_resources(job);
>>>    	fence = r ? ERR_PTR(r) : fence;
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index f4f474944169..5a36ab5aea2d 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
>>>    			dma_fence_set_error(&s_fence->finished, -ECANCELED);
>>>    		dma_fence_put(s_job->s_fence->parent);
>>> +		s_job->resubmit_flag = 1;
>>>    		fence = sched->ops->run_job(s_job);
>>>    		i++;
>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>> index 4ea8606d91fe..06c101af1f71 100644
>>> --- a/include/drm/gpu_scheduler.h
>>> +++ b/include/drm/gpu_scheduler.h
>>> @@ -198,6 +198,7 @@ struct drm_sched_job {
>>>    	enum drm_sched_priority		s_priority;
>>>    	struct drm_sched_entity         *entity;
>>>    	struct dma_fence_cb		cb;
>>> +	int resubmit_flag;
>>>    };
>>>    static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
