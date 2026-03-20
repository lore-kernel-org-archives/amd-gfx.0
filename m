Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D409A108B8F7
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 11:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7459110E214;
	Fri, 20 Mar 2026 11:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="au3W0V5x";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E171410E214
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 11:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym7qQrX9bW7Q36cxNZK4PxIL+gd4zVpXR4iSuyz+1Xd1uCP1zGS5sQGwXrpVjkXndCyD1pVjx6TH6NN/PA4cWUfgcBldQk5lhsrrPcoaVJO4tpyB56lhzou6fzyRxe7L1eenGHDg/yzTruEv9j13smv6pt03v45KBhMFl25hUpf0w4bNl/IDXIJoxMsP8GKHpnmRGQkJUe7YZO6nWJNIkigCkLECutPGsOB+Qzq4TXoz+H2j9mIyrQVw4/sT3y/m/10mAlKy/8axvq/1uiSncx5A9Z1XVbTkfSEXhB4t/ceXcEe5BWqMJHPzvjl39FK4BWmxowOiY/jxYOn698tTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osHREZIJSW+2dr4A9CabcGdsLKb/I7xYVDgDD+ve4OA=;
 b=iFMHnMUtbCxO9U9+YtP13/YjbCOGjeuvxLitFWxhSpBA98M0qR//i4P0SXMF/eHsFAH0rw3eR1T80EdtLtRlCNqmo1BIxQquMG0NfDpYvO14M38XgxQjTguia8D8YBrH7dMTF5ze9A8GSKXqWsnH1ZdAO9xcRHuTbixQOOtRbCPjNq5cFIVhPmVGO5ZdnrQWIXWtFDT895msm7kBvNURxn4JPmcT9dnKDXorgeHgoYK4LJxVIKhohSCPf3sfnUtkFjkCvMyoT+J1vhGudvJ1PUWn0Uq8BhCnAR7VX6+KdSI+Rt8+0QoYXcuZELFJxZ9ICTN4UN93NNuwv+37KaPeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osHREZIJSW+2dr4A9CabcGdsLKb/I7xYVDgDD+ve4OA=;
 b=au3W0V5xHfp6fTVw7m1PPGF2Elz2ZP1XDhuk4AePBycFucq56LZDgq3WguUacjsr1mjURH2J+2YgDs/BLH8Km+Jxpca2QSN6f/WZk4Q6vI52zHG3P8HahND2kzGdkSK9Kmov9lfCUMNU2JPikDOXfoqkwpg0efRbTARsZ5j4MWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 11:14:20 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 11:14:19 +0000
Message-ID: <df13f705-78c5-4e3a-86bf-8fc969b30d5c@amd.com>
Date: Fri, 20 Mar 2026 16:44:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
 <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
 <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
 <99f813b0-54e2-40d0-9fce-00d1f1f52641@amd.com>
 <78e16a87-de53-448d-94f6-13c7fa99596b@amd.com>
 <9481ee5c-fc2d-4b65-b3bc-cdcdb3180136@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <9481ee5c-fc2d-4b65-b3bc-cdcdb3180136@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0197.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::15) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: a0352104-8d5d-4e24-568a-08de8671d4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 15B2NH/aHCDHADZ5ol4j0aAfsDtNzATaiJpxYpEe/nhwzcC6PxI0QVOVVYSlLos37uMhFzSsYaJ3gTkQmRLfwLc5o0JNkOMnKCX9S2EUOvsBw+1fLhh78WemVu+OVxkkh/Omv1GTPt1gzIfGa0WW9tyus9EEE03i3OsndtSy0lLEP3hv0HS5qVUoXjFYOIIp1XMIZGj/Mgqc+l7evkbThvBqFYTstQv2QTdINHoxotAW2/ovIuqnUJi13+gj15lcBXw1RrnCK6xbypUQGPkLQnJmz1nmmpZqEkQBj/6dENSUwjkHYOi1PMhW7aUHdvozR2dHp1a5Ey9RRIYYfZujVaM+JOVFMqnoQDJIEKdheZ3ys368I0+2PEH1KjhKeEFnIoXWt6yeoPHy4mdOvUdsyKIvepWAStSMQ0RcS2Gt0FznvSWJk+INOWdjwqDOOhQL07ta8JGyfRclpG1LRfgmlkK4ttpfRFTHW89qi4zkm1Bnr2GiIw3oyeGAqQkeItkkQxJWr7etLSbVgqQQTLAhxSxfVRcwOZ+GJIiar6ktKiReM9LCzCQXyw3g2hWB/L1KPwuEiWvXuiitTVgac0srxPiSb+6GBlbCxtD+0lVCEvtP8mnTg6UH5QjyEhbgDMAGScrh/2+HeTBrOWz7mbI6mnGv2bWSNXNM7cdzLMvZTovCO4gQmuLH70p8d2AxIBViUNgsx3gdehcyK0eAAxyTvwNnMi6D9h2VxZN/Wd+sVlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGZSYlpLbnhkUFJ1N3NZV0RpNXBJN2UzNmtWUTNUQ1BnSnI1bGViQ3hwbGt4?=
 =?utf-8?B?ZFNnREpxK2xvQzJXNTFnY3dWb2hvb2p4SUNsVmJHemd5c05KZFlieVhiOUJ4?=
 =?utf-8?B?RG9TQ2tYTGtLdEthQ0J3M3N6dTN0dHJPSmhPb1BvcS9tODZjZTNSaG1JQ0F6?=
 =?utf-8?B?cDdpSFJ6K3BsdkNPU2NldEpBV3d4a0MrMTI3ak12UFRZeGRkeGVmclh6Mm5B?=
 =?utf-8?B?UWNTbXYxYzAyRS9uc1RUcHBGZUpvS1RKZStpc1gzTWhiVVBwcG5SWnRub1Rv?=
 =?utf-8?B?RmdyenVJUnlzVkNQSXFxNmdKemJ5UVU5MjFOcTdFZE9CelBxaGRmL0EyL0sr?=
 =?utf-8?B?Y3RrbGVlWVRxNW5Fd285c3J4MWxWU280K0t4aWQxbGdKUjlYZ2UrVFNOd3U0?=
 =?utf-8?B?MGVlUzQzUEhMSW85amlCUmREVDRxZFpqcWMxazVpNnNBL0VrbTBDcVoycHZY?=
 =?utf-8?B?Y3dzcVBobDIvelo5TFdWT0JVc0dyb2VMVmphR2F4Tmt3bkRaWTBCWWZRZ0xE?=
 =?utf-8?B?UVg5TUJ4NldoNzIvNzMzZTZVS1dVQVFLQWUzYTVGRzhaY3NkYk9PVHJaYkp2?=
 =?utf-8?B?Y0d0eFZmS3JqTmhqODJiR2t1Z2lTVDFJYzF1eDB6UENqVitPUitsaWRIZUt2?=
 =?utf-8?B?QWp2dVdXcklzdjJBemZCZ0xlUDN6LzV4NnU3NHdESWxwR0t1VytGQXF3ZTFZ?=
 =?utf-8?B?blZDZk90MUZmNC9hWElINHU2UWVyTXZFa1VMTlI5d3dLRjFGWTRQOUgxY2ZJ?=
 =?utf-8?B?anAvV2pNV0J2WXc0RURSaEQ0NnB4eDNRdXl3RGZZSVl6RmZrY0FqZUdROE1Q?=
 =?utf-8?B?bjF0eHBwWlBYeDhoK3VJbEQyV1lMdldFbTk0MkNwNm12RW9SelBkUHJWaVdR?=
 =?utf-8?B?eG56c3NqSFkyZTQ0WjJZZUFaT3lpVlhkZzJ2NC91V3dYOUh5czA3Y1pDaG4v?=
 =?utf-8?B?bE4wM0czRWZGYksxOE9wZElsclk2TjBwdVZzay9PVGJZeGxtek0vT1pLOWNk?=
 =?utf-8?B?WUNHY1FOZlcwL0VGWHZDS3RWZVZtbWQ1WWRrZk9QT29yRE9lUW54RkZ0K3dH?=
 =?utf-8?B?YjZJRzZyakFiOThYWU00R3dIaFVZN3RwOXZ3d3lDY0puOTJTK0ZhS0RUNGNF?=
 =?utf-8?B?Y1BYUVd4MnRYMEduNURtbE1jU0dOZUd2V2hMNlhnbEtxZDd5QmRoQ1liYVVr?=
 =?utf-8?B?aS8xOVhIMnkrVlgwWS84ZmtEQ0dtWGxBeWtKUjVISkF0RHRSL1B3aUhveEJk?=
 =?utf-8?B?QndZbzFxR2huZnZMcjhhS2Y2dXhKNVljSTBUdGxnYU16VnM1SlhqY0pXWVpG?=
 =?utf-8?B?QXJ3dVFVdnNJR1dCZG5sbjFiTzFvdjZ0QzFRWEFqU1c3Y0l2dUtaSGNHSlJt?=
 =?utf-8?B?VWQ4RXlHbUNQWFdraDRBK2dQdmpRcHAxVmhXSXRZVUJpT1FZcjVGQ3pGNXdi?=
 =?utf-8?B?c1VVQWdvMWtNbE5PWU1jYVRBKzNCbkRIWWFvMGFCRzcrODh0WDRWWjNRN0NI?=
 =?utf-8?B?SmpxK1ZjbGExQTFhcFJQV2M5VWRXQ2ZMTkxyZkRyVUpSZkFLSFpsc3RyOFkz?=
 =?utf-8?B?TGlyS0FUZ0pNcXZyczd5T0lFZFdkYXlLV0wrMXdMQldtK0MwSWlXMk03ZWZk?=
 =?utf-8?B?dm83amZsR2U1MlZtUTdGY09GMnh4N2p5ZUR0K2NKU0FQZkthOFdRWldwUW94?=
 =?utf-8?B?N1N5VFM3Vm11MkNkYnhkZVFXYk5ucndyNHlieTltcWwvNXdzUnh6a3lWcXBQ?=
 =?utf-8?B?dkNHRjF1R05xbXlnemZ5cVVWZlY0U29RUHJLWnhwa0xSODhqUjFjYkRmQkg2?=
 =?utf-8?B?bFlVZGpRUWZaaDlma0lCcmk1M2FmaXY3bFBaZmlGUC80MGNodFJNa011cURw?=
 =?utf-8?B?Y3NxSmZNa3haWE9zWTNaa1kwd0VCTzRTSFlMaU84VTVsV3NqcStYQzhLbnpZ?=
 =?utf-8?B?UXRuVnlHL1V2N1RhSlVhZkpWWGJGT0w2Yy9LWm9LdHViMjkxdlBhSHlVaUtQ?=
 =?utf-8?B?bEJ6YUg3ekh3a1UyRXVPZkc1UVQ5MlM4VXUza2FrdGFkY2h1Yzhvbkh4T2ZH?=
 =?utf-8?B?dy9VbWdzNktSQUxjaFIyMC9BUmprakxJM0ZobFNlVEpmRldNaU5ySjkybmRp?=
 =?utf-8?B?Q01CUWlnTi9OVDhpYWQ1K1pZQ2ptOUFUVjg1ZEdNMUlMQ0xQZ3JMTkVjZFdF?=
 =?utf-8?B?aUp2NGMxZHVSMS9FZ1A0U2p0aXRIZS8rQ3FMV3hCS0VLcUFnZ1VHYjZXR1Jr?=
 =?utf-8?B?M0dOUWtQWUZVOTM0bjgzYUQ5ODg0Q1ZtT2pZbEF3Zjh6YXNQREZCYk94Wkxp?=
 =?utf-8?B?cCtGMnBmU0x5RDZmcXc4b0k2VkFwUHpKSUJRN0dac29reGRrS0NnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0352104-8d5d-4e24-568a-08de8671d4fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:14:19.7553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yULkqG8su90eXYSrVdzH/MxZxJVP1fexrQBQFQ8E4SxNOOxDLDNKbd7u6X2lh28rK21CArwSrJgrBEnw80yODQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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


On 20-03-2026 04:27 pm, Christian König wrote:
> On 3/20/26 11:53, Khatri, Sunil wrote:
>> On 20-03-2026 03:43 pm, Christian König wrote:
>>> On 3/20/26 11:02, Khatri, Sunil wrote:
>>>> On 20-03-2026 03:16 pm, Christian König wrote:
>>>>> On 3/20/26 10:41, Sunil Khatri wrote:
>>>>>> There is a possibility of deadlock when last reference to a queue is
>>>>>> put in certain situations where mutex is already help when calling
>>>>>> the amdgpu_userq_destroy.
>>>>>    From functions
>>>>> As far as I can see that is illegal to begin with. Why are we doing that?
>>>> This is to fix the deadlock that prike shared and many other places where deadlock could still be caused.
>>>> There is a possibility of amdgpu_userq_put being called for last reference from amdgpu_userq_restore_worker or amdgpu_eviction_fence_suspend_worker via amdgpu_evf_mgr_shutdown
>>>> and all these functions already hold the userq_mutex and on last reference when destroy is called it again takes userq_mutex and causing deadlock.
>>>>
>>>> Thats why when we are dropping the reference we pass the information of the handled could be called with lock already taken and hence the handling.
>>> Well that sounds like completely broken handling.
>>>
>>> Why are dropping an userqueu reference while holding the lock in the first place?
>> we are doing at withing the locked state in most of the place in the code.
>> few examples:
>> static void amdgpu_userq_restore_worker(struct work_struct *work)
>> {
>>      struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>      struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>      struct dma_fence *ev_fence;
>>      int ret;
>>
>>      mutex_lock(&uq_mgr->userq_mutex);
>>      ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>>      if (!dma_fence_is_signaled(ev_fence))
>>          goto unlock;
>>
>>      ret = amdgpu_userq_vm_validate(uq_mgr);
>>      if (ret) {
>>          drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
>>          goto unlock;
>>      }
>>
>>      // Here the restore all is going through all the queues one bye one by doing get and put
> That is ok, the question is why the heck is doing that get/put? See we need get/put because we are *not* holding the lock.
>
> When we are holding the lock no get/put is needed at all.
Got your point. In that case there is a bug in code and this could be 
resolved with clean up or doing get/put where queue mutex is not locked.
Will send the update here.

Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>> and doing the restore of each queue. Now during put if its last reference due to race with another thread in putting we will
>> call the destroy with locks taken which causes deadlock.
>>      ret = amdgpu_userq_restore_all(uq_mgr);
>>      if (ret) {
>>          drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
>>          goto unlock;
>>      }
>>
>> unlock:
>>      mutex_unlock(&uq_mgr->userq_mutex);
>>      dma_fence_put(ev_fence);
>> }
>>
>> Another example:
>> static void
>> amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>> {
>>      struct amdgpu_eviction_fence_mgr *evf_mgr =
>>          container_of(work, struct amdgpu_eviction_fence_mgr,
>>                   suspend_work);
>>      struct amdgpu_fpriv *fpriv =
>>          container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>>      struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>      struct dma_fence *ev_fence;
>>      bool cookie;
>>
>>      mutex_lock(&uq_mgr->userq_mutex);
>>
>>      /*
>>       * This is intentionally after taking the userq_mutex since we do
>>       * allocate memory while holding this lock, but only after ensuring that
>>       * the eviction fence is signaled.
>>       */
>>      cookie = dma_fence_begin_signalling();
>>
>>      ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>>
>>
>> /* Here in userq evict we do a ref get and put a various places while the mutex is already taken */
>>
>>      amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
>>
>>      /*
>>       * Signaling the eviction fence must be done while holding the
>>       * userq_mutex. Otherwise we won't resume the queues before issuing the
>>       * next fence.
>>       */
>>      dma_fence_signal(ev_fence);
>>      dma_fence_end_signalling(cookie);
>>      dma_fence_put(ev_fence);
>>      mutex_unlock(&uq_mgr->userq_mutex);
>>
>> }
>>
>> Regards
>> Sunil.
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards
>>>> Sunil khatri
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> So based on the thread where it could be
>>>>>> locked we pass the locked information in the destroy functionality
>>>>>> to avoid taking the lock again.
>>>>>>
>>>>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>>>>> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>>>>>>     3 files changed, 40 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> index ced9ade44be4..9482664e9c2c 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>     }
>>>>>>       static int
>>>>>> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
>>>>>> +             bool locked)
>>>>>>     {
>>>>>>         struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>         int r = 0;
>>>>>>     -    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>>> +    /* It safe to unlock since we are in destroy and the queue ref is only this */
>>>>>> +    if (locked)
>>>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>>>     +    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>>>         /* Cancel any pending hang detection work and cleanup */
>>>>>>         cancel_delayed_work_sync(&queue->hang_detect_work);
>>>>>>     @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>>>>             queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>>         }
>>>>>>         amdgpu_userq_cleanup(queue);
>>>>>> -    mutex_unlock(&uq_mgr->userq_mutex);
>>>>>> +
>>>>>> +    if (!locked)
>>>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>>>           pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>>>           return r;
>>>>>>     }
>>>>>>     +static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
>>>>>> +{
>>>>>> +    int r;
>>>>>> +    struct amdgpu_usermode_queue *queue =
>>>>>> +        container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>>>> +    struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>>> +
>>>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, true);
>>>>>> +    if (r)
>>>>>> +        drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>>>> +}
>>>>>> +
>>>>>>     static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>>>     {
>>>>>>         int r;
>>>>>> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>>>             container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>>>>         struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>>>     -    r = amdgpu_userq_destroy(uq_mgr, queue);
>>>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, false);
>>>>>>         if (r)
>>>>>>             drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>>>>     }
>>>>>> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>         return queue;
>>>>>>     }
>>>>>>     -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
>>>>>>     {
>>>>>> -    if (queue)
>>>>>> -        kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>>>> +    if (queue) {
>>>>>> +        if (locked)
>>>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
>>>>>> +        else
>>>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>>>> +    }
>>>>>>     }
>>>>>>       static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>>>>> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>>>             if (!queue)
>>>>>>                 return -ENOENT;
>>>>>>     -        amdgpu_userq_put(queue);
>>>>>> +        amdgpu_userq_put(queue, false);
>>>>>>             break;
>>>>>>         }
>>>>>>     @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>                 drm_file_err(uq_mgr->file,
>>>>>>                          "trying restore queue without va mapping\n");
>>>>>>                 queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>>>> -            amdgpu_userq_put(queue);
>>>>>> +            amdgpu_userq_put(queue, true);
>>>>>>                 continue;
>>>>>>             }
>>>>>>     @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>             if (r)
>>>>>>                 ret = r;
>>>>>>     -        amdgpu_userq_put(queue);
>>>>>> +        amdgpu_userq_put(queue, true);
>>>>>>         }
>>>>>>           if (ret)
>>>>>> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>             r = amdgpu_userq_preempt_helper(queue);
>>>>>>             if (r)
>>>>>>                 ret = r;
>>>>>> -        amdgpu_userq_put(queue);
>>>>>> +        amdgpu_userq_put(queue, true);
>>>>>>         }
>>>>>>           if (ret)
>>>>>> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>             struct dma_fence *f = queue->last_fence;
>>>>>>               if (!f || dma_fence_is_signaled(f)) {
>>>>>> -            amdgpu_userq_put(queue);
>>>>>> +            amdgpu_userq_put(queue, true);
>>>>>>                 continue;
>>>>>>             }
>>>>>>             ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>>>>>             if (ret <= 0) {
>>>>>>                 drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>>>>>                          f->context, f->seqno);
>>>>>> -            amdgpu_userq_put(queue);
>>>>>> +            amdgpu_userq_put(queue, true);
>>>>>>                 return -ETIMEDOUT;
>>>>>>             }
>>>>>> -        amdgpu_userq_put(queue);
>>>>>> +        amdgpu_userq_put(queue, true);
>>>>>>         }
>>>>>>           return 0;
>>>>>> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>>>             if (!queue)
>>>>>>                 break;
>>>>>>     -        amdgpu_userq_put(queue);
>>>>>> +        amdgpu_userq_put(queue, false);
>>>>>>         }
>>>>>>           xa_destroy(&userq_mgr->userq_xa);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>> index f0abc16d02cc..2a496e74ec6a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>>>>>>     };
>>>>>>       struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>>>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
>>>>>>       int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>>>>>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>> index 18390d37a7e0..10e08cb6bd13 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>>>         kfree(syncobj_handles);
>>>>>>           if (queue)
>>>>>> -        amdgpu_userq_put(queue);
>>>>>> +        amdgpu_userq_put(queue, false);
>>>>>>           return r;
>>>>>>     }
>>>>>> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>>             r = 0;
>>>>>>       put_waitq:
>>>>>> -    amdgpu_userq_put(waitq);
>>>>>> +    amdgpu_userq_put(waitq, false);
>>>>>>       free_fences:
>>>>>>         while (num_fences--)
