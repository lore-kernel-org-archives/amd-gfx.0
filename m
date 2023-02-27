Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF61C64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 13:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3A510E1D2;
	Mon, 27 Feb 2023 13:20:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D79D10E208
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 13:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCCZgXPKdOCG9mZi2oHubmtEU1iu7AASRY+miJYK/Y5QILGs1YbveS9Oqi0g4DWyVlXL5oE+L5ILvGvC+Wu8oZU2cwSp32ba4Q6xVoH7rLodPSNVxQJFt9EaBVWJO5tt99F+ZnWDKMy9h6naMwfna3znBQxmhEX5UAaFvdbkQoXMNnIomSAzqow4BJEU9EoJgxwmNQCvYN/6111lTx+z7E/CpG8RJNF/Sn6KZ9ewpaBeLpbsR0JJYHgza19ybfVumQL5kfClqFjoOiDkbnoyt5opUlaJL194Z8bPLIuxAHumdPmnMgJRFPVV/Q8Fgu6kgTUOB0lst5ikp62gavsKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwg68iW/MBhxQG8aPTy/eirbJbipPQ2BAdsstMVFWE0=;
 b=chDA5BJ3sW/KVoYuNAtp9Anh4RAm5uKSYen9Y0Jp8NnJR+MDHlSm9SbL5OJEaK9n/5wzLa6XvvWABw+np1HwoKzahmfUrERsaXbL1niCAYwDbFCvy7a38vn69oSU34/bizs+GPzcJ5oWLfcWtHdC5r9DnNNdEMNc3CnhgBMcRrYy9yqxwWRmt7ycsbvkdRPaqlms3t0JJzNDtyfBAGWDcl/05PuFbnATiqBNROfUmj+rNgt4Aun9hc7TDfKOCfiOq8c2mKA9lAi+FFpaFNhshZu1DiHlTOjKkap+iCTzM9fKHSH4UgisdEZ/O3kf1io4EVUAPfedDXjGsSFEUVB9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwg68iW/MBhxQG8aPTy/eirbJbipPQ2BAdsstMVFWE0=;
 b=wMS1813Uv40iEeQlz6blO9WKFq8bwgzfuOBDP3zXWyFkTu4QV5KMQfewkcI7gs9nVWr2TTkilu0bM4IZxZbb0EDIs90D0p3tzV3waqmZ9szC0AZeB6veOLfUcyhAZgQEaNq7WzYp5x3l3xOZ/Zw0NZZccIMofBPCTUXN0S3o98M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Mon, 27 Feb
 2023 13:20:32 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:20:31 +0000
Message-ID: <4a76b004-6ce2-e540-8d14-cc0653cea421@amd.com>
Date: Mon, 27 Feb 2023 18:50:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-6-Arunpravin.PaneerSelvam@amd.com>
 <62177dac-97b0-2d85-fdff-92b7f1851ac8@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <62177dac-97b0-2d85-fdff-92b7f1851ac8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c0b7fa-1faf-4b46-b884-08db18c566ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVtyN956EsBpbgILVjlx3W+xiu8jYf8t+zlCvEZfc3Gf8Sj79c2o/KXMudZ62Zmc5RI8vy0HN8hhKvV2cmWb0C/Vc/mT2/1ogNajw/7sr9xjoPXOWxlWth1do6X4YVz6yg++J0c27KQlqkDF44KZGFbBTA2FpFiPtDTQU1dA58fUQDVpyY/9+VfchqVyBi0JZdfXzpPyHOaxKxXQSYwURLgTpVDBo360MHP6p1egmmdXgRr/umiyW8OW1LWOf32LiNvmLoL1tD7Tx4Mo8GT0Gzqg4dXKgiUuJxnN3816096SOWFZqA9EtA2MzXIqCX7tWsF2IbFElGNIYDQxHbaS9PRsX5Bxau1NWftjWiN3fsqJqrauEBSI5O5p1OYa2fD+dsR8W4bR/K5I4uNsAqV9QO6Sb/sP2qgC/tbNpi1cQlT5G40le+oHXMRkASrqvakAwTGs+bc1A+LHoaJbYYRRQetyS4v4Qb77qUdci5IrOCaxF32/Mj+QtETeSf7CXoEe8Ld77JIie1ZNyitSdoQ2DwURXJbkwyjUeV6Go/eIzAFhGUKC9AqkMBLULddht0wvnZCI+YVFijpRH0cpltEULSmTae7nOm+4FRun55/7eu/zCS10DBgiISwOEfDnKjcDDvmOaXH5LNz8jr3pZ4TjjKH2gJz3suqMIo0uydXgUHB9Ixi3rmNaWWFFmrJh9PvrVldeB7lRNS5oyJBPkxfwWC+d21IzMPX9sUCczaXODZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(36756003)(316002)(66476007)(66556008)(6666004)(6486002)(66574015)(2616005)(6512007)(6506007)(83380400001)(53546011)(186003)(8936002)(26005)(5660300002)(30864003)(86362001)(2906002)(38100700002)(66946007)(478600001)(4326008)(8676002)(31696002)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhEOHptTUJ2UnNzeDczWm9NYlZoZU83N2phWGkzajlnUm9tTlo3VFQ3SUdB?=
 =?utf-8?B?c3crWktEZllaKzJGK3R1UUNCdHAza1ozMmdUMlBMUVd2T0pncEVDbE5CVHdN?=
 =?utf-8?B?akMya3I0NmpoR3FZL2lab0l1VElsbDZJVyt1L3o1MDNpRHo5eC8rL0w1aDJB?=
 =?utf-8?B?Zm9ZZCtCRzdpcWFWdkxiYkV1REZkMVloeTloQnJ1QzhTK3N2bXNZKzZaZVZ2?=
 =?utf-8?B?alV4S0hIa1NxSlJYRERVTTdUV0dFaVpQRzA3cjgrakkzMDR2aWkwLzBMMkJC?=
 =?utf-8?B?djFZSlkxdmZpMXZmQm10M0g5WEZTZDlSMDdod3RPblJ6K3Jpd0FPbG1BNVBR?=
 =?utf-8?B?RGhyYkpOTjZrNG9NdlRDSWhjZmIyNG1QN1k0RUFiQ2pPd0NPcElrZ3prZ0oy?=
 =?utf-8?B?eTdDYmxlVmY4Tm9sR1RMMFZRV2kxeDc1dHVRYkRja01XTU5nSWM5L01vSURa?=
 =?utf-8?B?UFlzOUdtM0Jlb1o5dVNnc3l1a2djR29aZVJLQlk2bTN2ZmZKYWgrMVBYSEht?=
 =?utf-8?B?K1k1ZjI4M1JYeVZGd01zWElRMmxNeEwxbUVDc2NYV2RQMHRrdk9yUXhHakhC?=
 =?utf-8?B?Uy9UOFZVWjdIczlBL2FSUmVPY0ZLQkt4N1ZXc3c0RTZ2SDZ5aHV2ZHcxbTh6?=
 =?utf-8?B?QjNZZzhYQUE2ditpVzBiL0NhOGtWY0JLc0VpWGd4cUFVNXBOKzFIU2EwUnJo?=
 =?utf-8?B?UFYvRFU4TE9UUktPaHNlQlhBL2RZcnN0aUpzMVR6Rml0dWMvV3lPVFMwOEJi?=
 =?utf-8?B?OWtTWHJrNy9GaHJLMXBiNnRjNkJ5clVJNkgzREFiRFM4d1N5ZTlaVTZlcGdm?=
 =?utf-8?B?SWIzbFkvWldjMkZoR0dmdnJicHdUYmN5Q0F5SmJrYlBlTFBpSjl6SUloMjh2?=
 =?utf-8?B?MmFJOE5RbFo5RlhIR05PZ2hIdklIbm9mOUxwZjdzYlo2cUlPWkxDbXFHd3o1?=
 =?utf-8?B?MHJ6c2lUQkRqVk9SR2hGS1RFTFVya1JycXBjSmJqZXVEZ0lKMk0xZ2N4b2hH?=
 =?utf-8?B?cTg5VnFNZ3VRYzdabkR6UHVQU0xRTmQvcFhYMnlGWTd4WWRzQzE2ZWhGa3Fy?=
 =?utf-8?B?Y2NPa0tOaEVGa0ZGcTZLQmhVTmptb09DZjRZNFlJVml0aW1tSHBpakppd1Nk?=
 =?utf-8?B?NUhNdkZRTjVubEp0NEYzMUZDQUlrVzRrczdZc285SEU2WWxQM0ZjdkYwSW9w?=
 =?utf-8?B?NHJwME9IeE5raGJoZnZOd2k3R1ZITjF3ZCtlbld6ZkNuQmhkTXpza2x6T0Ju?=
 =?utf-8?B?RVllKzhJMmtMYWpaZHcraFFscUZ6K2hXY0wyTEJuMVJkSEpncU9UQ1RuL0N5?=
 =?utf-8?B?L1JHWmlBWEdXT0hja0tlNWlSSE12NHRkRmcvdXR3OXR0WHRMWnZIWDRxSzB6?=
 =?utf-8?B?UGhuS092Y1pmZ0U5TFV4c0p0VFVlMzg0bCthSmYxNVRBUkhKQ2dkMm5mQmc5?=
 =?utf-8?B?SUo5RUtjYnZIa1d0YWFOdWNoL2pWSFRlOCticVdRZEJiODlRUWVEeHdGdGlX?=
 =?utf-8?B?ckxRcStHNUFadTJ1dHI1SzZNOTRWVUMzU084Q0dZUDd6N3R1dW40eU1LeGJ5?=
 =?utf-8?B?N1g0R21XVHVwRXlEdmc3a0FpQy9WcHJwL0dJZWNseDdEcytqc0dMejc1a0Y4?=
 =?utf-8?B?d0YzOFpPVlVtRXFHUlhSLzhsakZWc3FzUmZHS1VXQ3RINUhUYXUxUjNwRE5B?=
 =?utf-8?B?OVhjNjdEVjZNYmVHTGJMY2RNSnJMb1EwcE5PYnl0TnQ3UklBQi9Sb2E3a0w1?=
 =?utf-8?B?cDNadE5iRGRpVW9MNk1IMFpQaDRuSWtYQ0ZUREhrZUZWNFRWdW1GMXFxRVpj?=
 =?utf-8?B?cVFOcElidVNDRmFtNUZ0MXN6TE1Pa2g3VS9QVW1xaXUyQmxISFhBdHVBaWVu?=
 =?utf-8?B?TmoweUpkSFM2ZVVoZERjR3hDRC9IUG1LQk1lMDlVcmRNRGgzVWxnKzk4RXN5?=
 =?utf-8?B?a1lvdnlWK3pVaDFxRmxleWVPZlhiQnNzbGlRV04xT0dYSEdXZDVnR3JnQjJv?=
 =?utf-8?B?VFhKWmdvSURXdEw2Q0pyQXZWZS8yTlNSQXVSVjJPQ1FNUEhQajdzTnlnMGtn?=
 =?utf-8?B?R1JZQmJ5bWtQaXl0SWtwYzdwSmVwa3pwbCt1ZjljeHNGcmo2emdxL0ZDS1hD?=
 =?utf-8?Q?9zoZLg2glJ8t575n6s6gmYrT/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c0b7fa-1faf-4b46-b884-08db18c566ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:20:31.7943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RwNcp+vdRX7IkLnQgO/lRaO7kL1WwA17uzp3HjeIUrd1XBtyGjJIz+lOlb8AgnZT4iVUwrtSMtfBB/mYfyPZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,


On 2/27/2023 6:29 PM, Christian König wrote:
> Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
>> This patch introduces new IOCTL for userqueue secure semaphore.
>>
>> The signal IOCTL called from userspace application creates a drm
>> syncobj and array of bo GEM handles and passed in as parameter to
>> the driver to install the fence into it.
>>
>> The wait IOCTL gets an array of drm syncobjs, finds the fences
>> attached to the drm syncobjs and obtain the array of
>> memory_address/fence_value combintion which are returned to
>> userspace.
>>
>> v2: Worked on review comments from Christian for the following
>>      modifications
>>
>>      - Install fence into GEM BO object.
>>      - Lock all BO's using the dma resv subsystem
>>      - Reorder the sequence in signal IOCTL function.
>>      - Get write pointer from the shadow wptr
>>      - use userq_fence to fetch the va/value in wait IOCTL.
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 258 ++++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
>>   5 files changed, 270 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 1c3eba2d0390..255d73795493 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -964,6 +964,8 @@ struct amdgpu_device {
>>       struct amdgpu_mes               mes;
>>       struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>>   +    struct amdgpu_userq_mgr         *userq_mgr;
>> +
>>       /* df */
>>       struct amdgpu_df                df;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 6b7ac1ebd04c..66a7304fabe3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2752,6 +2752,9 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] 
>> = {
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_DOORBELL_RING, 
>> amdgpu_userq_doorbell_ring_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, 
>> amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>> +
>>   };
>>     static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 609a7328e9a6..26fd1d4f758a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -249,3 +249,261 @@ static const struct dma_fence_ops 
>> amdgpu_userq_fence_ops = {
>>       .signaled = amdgpu_userq_fence_signaled,
>>       .release = amdgpu_userq_fence_release,
>>   };
>> +
>> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
>> +                    struct amdgpu_usermode_queue *queue,
>> +                    u64 *wptr)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_bo_va_mapping *mapping;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_bo *bo;
>> +    u64 *ptr;
>> +    int r;
>> +
>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, queue->wptr_gpu_addr 
>> >> PAGE_SHIFT);
>> +    if (!mapping)
>> +        return -EINVAL;
>> +
>> +    bo = mapping->bo_va->base.bo;
>> +    r = amdgpu_bo_kmap(bo, (void **)&ptr);
>
> Oh, that's not something you can do that easily.
>
> The BO must be reserved (locked) first if you want to call 
> amdgpu_bo_kmap() on it.
sure, I will take care
>
>> +    if (r) {
>> +        DRM_ERROR("Failed mapping the userqueue wptr bo");
>> +        return r;
>> +    }
>> +
>> +    *wptr = le64_to_cpu(*ptr);
>> +
>> +    return 0;
>> +}
>> +
>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>> +                  struct drm_file *filp)
>> +{
>> +    struct drm_amdgpu_userq_signal *args = data;
>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>> +    struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct drm_syncobj *syncobj = NULL;
>> +    struct drm_gem_object **gobj;
>> +    u64 num_bo_handles, wptr;
>> +    struct dma_fence *fence;
>> +    u32 *bo_handles;
>> +    bool shared;
>> +    int r, i;
>> +
>> +    /* Retrieve the user queue */
>> +    queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
>> +    if (!queue)
>> +        return -ENOENT;
>> +
>> +    r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
>> +    if (r)
>> +        return -EINVAL;
>> +
>> +    /* Find Syncobj if any */
>> +    syncobj = drm_syncobj_find(filp, args->handle);
>> +
>> +    /* Array of bo handles */
>> +    num_bo_handles = args->num_bo_handles;
>> +    bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), 
>> GFP_KERNEL);
>> +    if (bo_handles == NULL)
>> +        return -ENOMEM;
>> +
>> +    if (copy_from_user(bo_handles, 
>> u64_to_user_ptr(args->bo_handles_array),
>> +               sizeof(u32) * num_bo_handles)) {
>> +        r = -EFAULT;
>> +        goto err_free_handles;
>> +    }
>> +
>> +    /* Array of GEM object handles */
>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> +    if (gobj == NULL) {
>> +        r = -ENOMEM;
>> +        goto err_free_handles;
>> +    }
>> +
>> +    for (i = 0; i < num_bo_handles; i++) {
>> +        /* Retrieve GEM object */
>> +        gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
>> +        if (!gobj[i]) {
>> +            r = -ENOENT;
>> +            goto err_put_gobj;
>> +        }
>> +
>> +        dma_resv_lock(gobj[i]->resv, NULL);
>> +        r = dma_resv_reserve_fences(gobj[i]->resv, 1);
I am reserving place for each BO here, should we move this down?

Thanks,
Arun
>> +        if (r) {
>> +            dma_resv_unlock(gobj[i]->resv);
>> +            goto err_put_gobj;
>> +        }
>> +        dma_resv_unlock(gobj[i]->resv);
>> +    }
>> +
>> +    /* Create a new fence */
>> +    r = amdgpu_userq_fence_create(queue, wptr, &fence);
>> +    if (!fence)
>> +        goto err_put_gobj;
>> +
>> +    /* Add the created fence to syncobj/BO's */
>> +    if (syncobj)
>> +        drm_syncobj_replace_fence(syncobj, fence);
>> +
>> +    shared = args->bo_flags & AMDGPU_USERQ_BO_READ;
>> +    for (i = 0; i < num_bo_handles; i++) {
>> +        dma_resv_lock(gobj[i]->resv, NULL);
>> +        dma_resv_add_fence(gobj[i]->resv, fence, shared ?
>> +                   DMA_RESV_USAGE_READ :
>> +                   DMA_RESV_USAGE_WRITE);
>> +        dma_resv_unlock(gobj[i]->resv);
>> +    }
>
> That will still not work correctly. You've forgotten to call 
> dma_resv_reserve_fences().
>
> The tricky part is that you need to do this for all BOs at the same time.
>
> I will work on my drm_exec() patch set once more. That one should make 
> this job much easier.
>
> Similar applies to the _wait function, but let's get _signal working 
> first.
>
> Regards,
> Christian.
>
>> +
>> +    for (i = 0; i < num_bo_handles; i++)
>> +        drm_gem_object_put(gobj[i]);
>> +
>> +    dma_fence_put(fence);
>> +
>> +    /* Free all handles */
>> +    kfree(bo_handles);
>> +    kfree(gobj);
>> +
>> +    return 0;
>> +
>> +err_put_gobj:
>> +    while (i-- > 0)
>> +        drm_gem_object_put(gobj[i]);
>> +    kfree(gobj);
>> +err_free_handles:
>> +    kfree(bo_handles);
>> +
>> +    return r;
>> +}
>> +
>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> +                struct drm_file *filp)
>> +{
>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>> +    struct drm_amdgpu_userq_wait *args = data;
>> +    struct amdgpu_userq_fence *userq_fence;
>> +    u32 *syncobj_handles, *bo_handles;
>> +    u64 num_syncobj, num_bo_handles;
>> +    struct drm_gem_object **gobj;
>> +    struct dma_fence *fence;
>> +    bool wait_flag;
>> +    int r, i, tmp;
>> +
>> +    /* Array of Syncobj handles */
>> +    num_syncobj = args->count_handles;
>> +    syncobj_handles = kmalloc_array(num_syncobj, 
>> sizeof(*syncobj_handles), GFP_KERNEL);
>> +    if (!syncobj_handles)
>> +        return -ENOMEM;
>> +
>> +    if (copy_from_user(syncobj_handles, u64_to_user_ptr(args->handles),
>> +               sizeof(u32) * num_syncobj)) {
>> +        r = -EFAULT;
>> +        goto err_free_syncobj_handles;
>> +    }
>> +
>> +    /* Array of bo handles */
>> +    num_bo_handles = args->num_bo_handles;
>> +    bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), 
>> GFP_KERNEL);
>> +    if (!bo_handles)
>> +        goto err_free_syncobj_handles;
>> +
>> +    if (copy_from_user(bo_handles, 
>> u64_to_user_ptr(args->bo_handles_array),
>> +               sizeof(u32) * num_bo_handles)) {
>> +        r = -EFAULT;
>> +        goto err_free_bo_handles;
>> +    }
>> +
>> +    /* Array of fence gpu address */
>> +    fence_info = kmalloc_array(num_syncobj + num_bo_handles, 
>> sizeof(*fence_info), GFP_KERNEL);
>> +    if (!fence_info) {
>> +        r = -ENOMEM;
>> +        goto err_free_bo_handles;
>> +    }
>> +
>> +    /* Retrieve syncobj's fence */
>> +    for (i = 0; i < num_syncobj; i++) {
>> +        r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0, 0, 
>> &fence);
>> +        if (r) {
>> +            DRM_ERROR("syncobj %u failed to find the fence!\n", 
>> syncobj_handles[i]);
>> +            r = -ENOENT;
>> +            goto err_free_fence_info;
>> +        }
>> +
>> +        /* Store drm syncobj's gpu va address and value */
>> +        userq_fence = to_amdgpu_userq_fence(fence);
>> +        fence_info[i].va = userq_fence->fence_drv->gpu_addr;
>> +        fence_info[i].value = fence->seqno;
>> +        dma_fence_put(fence);
>> +    }
>> +
>> +    tmp = i;
>> +
>> +    /* Array of GEM object handles */
>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> +    if (gobj == NULL) {
>> +        r = -ENOMEM;
>> +        goto err_free_fence_info;
>> +    }
>> +
>> +    /* Retrieve GEM objects's fence */
>> +    wait_flag = args->bo_wait_flags & AMDGPU_USERQ_BO_READ;
>> +    for (i = 0; i < num_bo_handles; i++, tmp++) {
>> +        struct dma_fence *bo_fence;
>> +
>> +        gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
>> +        if (!gobj[i]) {
>> +            r = -ENOENT;
>> +            goto err_put_gobj;
>> +        }
>> +
>> +        dma_resv_lock(gobj[i]->resv, NULL);
>> +        r = dma_resv_get_singleton(gobj[i]->resv,
>> +                       wait_flag ?
>> +                       DMA_RESV_USAGE_READ :
>> +                       DMA_RESV_USAGE_WRITE,
>> +                       &bo_fence);
>> +        if (r) {
>> +            dma_resv_unlock(gobj[i]->resv);
>> +            goto err_put_gobj;
>> +        }
>> +        dma_resv_unlock(gobj[i]->resv);
>> +        drm_gem_object_put(gobj[i]);
>> +
>> +        /* Store GEM objects's gpu va address and value */
>> +        userq_fence = to_amdgpu_userq_fence(bo_fence);
>> +        fence_info[tmp].va = userq_fence->fence_drv->gpu_addr;
>> +        fence_info[tmp].value = bo_fence->seqno;
>> +        dma_fence_put(bo_fence);
>> +    }
>> +
>> +    if (copy_to_user(u64_to_user_ptr(args->userq_fence_info),
>> +        fence_info, sizeof(fence_info))) {
>> +        r = -EFAULT;
>> +        goto err_free_gobj;
>> +    }
>> +
>> +    /* Free all handles */
>> +    kfree(syncobj_handles);
>> +    kfree(bo_handles);
>> +    kfree(fence_info);
>> +    kfree(gobj);
>> +
>> +    return 0;
>> +
>> +err_put_gobj:
>> +    while (i-- > 0)
>> +        drm_gem_object_put(gobj[i]);
>> +err_free_gobj:
>> +    kfree(gobj);
>> +err_free_fence_info:
>> +    kfree(fence_info);
>> +err_free_bo_handles:
>> +    kfree(bo_handles);
>> +err_free_syncobj_handles:
>> +    kfree(syncobj_handles);
>> +
>> +    return r;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> index 230dd54b4cd3..999d1e2baff5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> @@ -27,6 +27,8 @@
>>     #include <linux/types.h>
>>   +#define AMDGPU_USERQ_BO_READ    0x1
>> +
>>   struct amdgpu_userq_fence {
>>       struct dma_fence base;
>>       /* userq fence lock */
>> @@ -57,5 +59,9 @@ int amdgpu_userq_fence_create(struct 
>> amdgpu_usermode_queue *userq,
>>                     u64 seq, struct dma_fence **f);
>>   bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver 
>> *fence_drv);
>>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>> +                  struct drm_file *filp);
>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> +                struct drm_file *filp);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index d4317b0f6487..4d3d6777a178 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -457,6 +457,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr 
>> *userq_mgr, struct amdgpu_devi
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       INIT_LIST_HEAD(&userq_mgr->userq_list);
>>       userq_mgr->adev = adev;
>> +    adev->userq_mgr = userq_mgr;
>>         r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>>       if (r) {
>

