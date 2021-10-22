Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 20:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EFF61040
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 20:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5EFF61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7027A6E578;
	Fri, 22 Oct 2021 20:42:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B3B6E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 20:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knsgJ+JozP9ge2ip8nthtncL3rPCaVvqp9efqpvCr2xA92AWF8VWe2jmaszTRdKijgJmPJkFat8CICHrFEVinyLNuoWkscFW+73xNhL+Oa97MaHildJQl48Bt070Tp3BfwmUUEffxDHnwA+WTbKbYUTQdFqa0aQ3Em8xH43tlxp4tErPnJplBFMrHmeAxtYBqfdTZaH5ThhorWtLHxZ8nkshf6a6Cdm+6viYie4u5T0b6KZeIBlk1sbm3G1+PE1iga9O9jxJoLAJ+EsfdZW27e9CU2mwmazlNUh3XAy0SVHst/87aaIUBkw70I48csHP7rW9iER1KX8vcgRKvgSFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67WtchvFXYAHvlonEcSJs4kTUbQ5YmJma7wSK890ZRM=;
 b=oRBtjpfNC3yRPDFcFvv1vg8i4DAy4oAVsb0NGyxDwPqvsHtYKqvbD/bm/1l+EWfW894g3MHljtrTPH/aO979Z4uI8nCOdylKEwa6tOQw2YkuYLcrjYE5QKj/CYxSdRvW2yS1x7qSiRhm9rY0nYx+jbUz/NULXGnETZLbsYcBRUXj/5GBe/UsNTlAGxQtPSWy+xEduG8afsykINmCA/idOvzlI7UQ4SWfB6Up8Ivgv2trPfx5DPVbuE/FjuQVz7xSOVdPNuY7xKUYW4nUZoynO9+6Fl0zzPhnFa7sU5DIRmT8OFmD8VWO6WqMy5zvCzTlc1UKpeTf/pa4tScVpja7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67WtchvFXYAHvlonEcSJs4kTUbQ5YmJma7wSK890ZRM=;
 b=hDAP2t6rNXSbg8f33Dc18dVYZJ5IqPZ7xGpuKD3KdP8BQEBGjTkI1ndu2CPQ/Lb2Gh6e0mf2kAKR+DuUFbHU9zPM5la+hc0lLUyLsYyTIuugmNH1Qywy6ZtvbDCDLptreW+oT3gNtkxxIp9a9b6ZMDGfBsNsOayEDyK/e7KknVo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 22 Oct
 2021 20:41:57 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4628.018; Fri, 22 Oct
 2021 20:41:56 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: jingwen.chen2@amd.com, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
Date: Fri, 22 Oct 2021 16:41:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [192.168.82.108] (199.7.156.253) by
 YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 20:41:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc10eee2-61d4-49f2-4f6b-08d9959c6371
X-MS-TrafficTypeDiagnostic: DM6PR12MB4074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40740E2777AB675132258F7AEA809@DM6PR12MB4074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHf3PBJIliUe02mKHv7DbzNsg3KZCX2Wuc2nLy3vwZg4w+SO+9ZGeWjXX/LIEn80yjWyvKaxMpIHdFNV1QSUI8K73B0PmG2HmTkhclGHLEycgcgo5Q/hduhepszqBcNS/nR1leTlkD1xwE1yE7qLtGg/5MPo+qGur2KVoHgKLTU4Kffa/zx4/YLpyGjtlbYdvRtoZJ8locoxyNeNKgpzNFPAo3XgNz772wyPUa4IiD8JKBDqPL4zYHQZbJitfvunif32GQuBQwzy2skm6t+MJcWoXaJEyWwtbGy/QWu8Y9slf5wJzJFQvmwuLbppRxwRYOxYUXjTWXJr4Uyz+gd1emCHGynLpNL+hVanVpdUi1DZYlzEMS2lUvhwrBua1qQt/l4JvIZl+OcK3WpUaC5sz9MOJCNz9U3fqUT3nAnvrMUzgB4HNWOmZh97WL8lZbqyeqiaduqazcZXRvnNhc18Q6zRULCZJbp+X3lGL/HLIlU9v6Wg2r0MGsCVCPq3b+GCzDOahehtgXpO5jTom4JOn14YxFnaiCM3TDG5CXJBcAyWF6aWHXsY7ooBJQKcgwwU9+aD519IF+4qasUCkbmKfMuLR8vQbc+62sp50iDFqMASxBPAxfRdrfCSW3zb429DBXLUV7Cmpm7Zen/iXxar9cdOcSG62lpPXXWnzFSAySQK1W8/J9MB5pN5E6HNGD6te7b7mkfGxmSi2HDJcRhdZoiRIS11Fk1d0sKeIiGBWuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(5660300002)(38100700002)(2616005)(31686004)(2906002)(16576012)(508600001)(31696002)(66946007)(53546011)(36756003)(8676002)(956004)(44832011)(316002)(186003)(26005)(66556008)(4326008)(4001150100001)(66476007)(6666004)(86362001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1lR2phZWxkMHdxc21ObnNhTTBKOGdlMm9jRWZyQ2svWXQ3d1pYTkdPNE5y?=
 =?utf-8?B?QXBOcG5WeFdia2FZb3dnUTZWWGJKSElnTXFYN2pHOUVkYVJ2cGxjTGltV2Rl?=
 =?utf-8?B?QWpKVHVRQ2JyQ2Z0Zlltb0RTK2VwZW1Tb29rNFFNQXBvS0pSY2pTN0xJOUhJ?=
 =?utf-8?B?Sm8xVkE3aWNJek9VOHp2Z2JQS1V6WmJUOU9hcWp4MWl1a0Nmb0IvSHBlZ3JV?=
 =?utf-8?B?bS9ZbStUQzVML2lBalFEbFBVM0k5NmpGTGtGRE5SdFVkYlAzN3RDeUoxbFVT?=
 =?utf-8?B?dFV4YkZCRFhxZ2syWDRQNk4wWU1WS0RpT2lISDFjbm1ucldPU3ZRYVFjWEJD?=
 =?utf-8?B?NzI3eTg1WTQ0cVAyUHR3YjFGWjJobE9mMVFLR0ZaMnM1UHVWbXJFNnlQdko0?=
 =?utf-8?B?dmRubGxKaVE2b2Z1VXBSWUVzd0tnY3lSWUZSc2ZlR1V4VHFocnZzejJlRDk4?=
 =?utf-8?B?YzZOWGVQaFZHZ0RrM0JYdXVCSFo2Tm5sYjJGRUlvV215b2JSUi9xODZnNlZr?=
 =?utf-8?B?czAxd0Joc0pEanNldjBRaXhwSEhZSzBZVm5wNlVaNW5NUFQwSEVvc0MzMWZJ?=
 =?utf-8?B?VERySStRMXE2NzE2UGlaZW9tQVY2T2xDOTJMN1NYWGpuOHV4bk5CRHd3YXRy?=
 =?utf-8?B?VkphR0U2TkhBcllHSUExbStRaGdVR2hldVZUaloxMTI5a1dlMHdqbWkwcG9R?=
 =?utf-8?B?a1dpQXg2UG9sVWQ3blNnd1FNcVh3Smg5WE1SNXB4eDFMdHE1aWxNWlBjdTdI?=
 =?utf-8?B?dXp4Mi9GN0duY1ExRVRpYTA4TFdaUmZwK2tSbkNnYnpmRkZXeGlnVnBvRVpB?=
 =?utf-8?B?VzJxNWRaVlVkb2Z6TG9MV3RIYXgzOTd6T3FLMGkvMU9RcXQ2dXR4T2tuVENZ?=
 =?utf-8?B?YUpZeFpKM1pYS2FpcmI2djhiRkNFUkhQOHprQ2ZuT2I1M0RLSlRLcjE0Y1lR?=
 =?utf-8?B?bU1xZWVEYzNJQ293WjhNRWY4NlAwUzhFeW80N2ROUDNJckNHTUxnTmlTZmpK?=
 =?utf-8?B?b1JaQkp6UDhkRnZlMnlka2p0Y1dOQWphaVpJQm9YRS9GSWhHZENQdGhMRTVH?=
 =?utf-8?B?MldJdnhsTVl6d2g0ZW41dUtkY09tYnU2anZiQWV0angvS00zWnNTMXN2ZjZF?=
 =?utf-8?B?MThWNzkvRFNYVExHNEZsaGJ5RWVha1QrTGhCVDVGem0wYVhvZlQ1SElKeHor?=
 =?utf-8?B?K0J6V051RkFMK0lEbGNwNG9WNTh2MUtIaU9meFZIV0xjSVdJWFFnZHUzcmdv?=
 =?utf-8?B?TDZyUFRKaTR3SjFDaUg5blh3OTg1R2dHUDc4MWFoQThqdnpkdWp0RWFQWWlR?=
 =?utf-8?B?REQxNlFiaEFYY3hXZWlEOHhod3B6Q3d0TEhSeld0NEhBcXMyMjBtZEVtNXBI?=
 =?utf-8?B?aTIvTGpERE9pSjJ0RERCOGNXQzlvWmFPTFhXUjdjeHI4aGl3Yk5jZ3B5Nm5D?=
 =?utf-8?B?Nk5YbFI3dW41YThqdWRRZklISXhqclpmZnBZdGZKay9aVUcwK1ZRVmhsTmox?=
 =?utf-8?B?dE03VjdXZEFDU3ozUldMMVFRL3RUUjg5NXFtTWdvQXNOelpvbm9uYjNvYVlX?=
 =?utf-8?B?RThXUnJEVGtFUDJlVU13RDdsVnlSZ0lKTDNKTFpzWWRwYnY1ZnJtRHpBOHlX?=
 =?utf-8?B?bHUrdWlwWXBTaWJ2SEluV2JGNGcrUVRKUmJ1eU5ObncwM01IZVpuUFdpMWVi?=
 =?utf-8?B?WjNjMERkOWJiTW1pOXVLWGNKUG5MVGg0aFcvSnBDUUJ0WXdsZlJNQVNWdm1z?=
 =?utf-8?Q?pHu0moqrOK8otEb1GQIK6B3t4O6HR/mw021+s4V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc10eee2-61d4-49f2-4f6b-08d9959c6371
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 20:41:56.7631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agrodzov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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


What do you mean by underflow in this case ? You mean use after free 
because of extra dma_fence_put() ?

On 2021-10-22 4:14 a.m., JingWen Chen wrote:
> ping
>
> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>> [Why]
>> In advance tdr mode, the real bad job will be resubmitted twice, while
>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>> is put one more time than other jobs.
>>
>> [How]
>> Adding dma_fence_get before resbumit job in
>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>
>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 41ce86244144..975f069f6fe8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>   
>>   		/* clear job's guilty and depend the folowing step to decide the real one */
>>   		drm_sched_reset_karma(s_job);
>> +		/* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>> +		 * to make sure fence is balanced */


But that put in drm_sched_resubmit_jobs_ext is for the previous parent 
fence.
fence = sched->ops->run_job(s_job); returns a new HW fence and the put 
drops the refcount on the old one.

Andrey


>> +		dma_fence_get(s_job->s_fence->parent);
>>   		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>   
>>   		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>   
>>   		/* got the hw fence, signal finished fence */
>>   		atomic_dec(ring->sched.score);
>> +		dma_fence_put(s_job->s_fence->parent);
>>   		dma_fence_get(&s_job->s_fence->finished);
>>   		dma_fence_signal(&s_job->s_fence->finished);
>>   		dma_fence_put(&s_job->s_fence->finished);
