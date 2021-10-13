Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CDA61151
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8CDA61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCC06E0F6;
	Wed, 13 Oct 2021 18:11:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4555F6E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 18:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/okn0XbKN3WUc7XpUR7WVHYHt2ZPiPhjybsjNS2XOiFLQDIua6lX2klt85e4gG3wvAiTMkGZHU0iut/bkbTFOKi8lVV53CIjxIWCSBe0LqNKR8mEXFTFEHFKalYmmKEwjUTvtHleTC3Q2rjG3h9wG0EbwZf4zeCFhYzSeofKHDDes2btA/dxwqsXgWzpSjaH52BGxVf9t6tzcyLVr9rxW1Jh5LYovi+bUZQJDRVxWrKYKoFHu+4YKYT33AnGpipKCPSwwZvEDBwTHkHy9X4f+uR4KaNbe/AXlT8LgUlOYEjWwydDVRRIqnh/36eS7NHAbz0hYV8qqzJKAmQEDII+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBm9ZWjQ4KWoCsYbkFbAlblnBluFqKr9xro/stKl2Ik=;
 b=FgHg+RUVJnqzEPhvpCs/qOyKA0/jGwCbx8wIM0ZJOrVeLfdIRIE5kY+lVxncteQ2/NxQSSs8WHZyxtbOcjx4ck0YqbVDU8u0uWI98A3uO/dc2PUEeEgKjd3V2jk0P/Nkh88/BsWqGcWHRX8LykbQwOeLe3jkvor0FnDJpEzmZG7M+Qd+Opz86jIn3NsAUjMOWmfz+B25V8IUJpOy2lYsS4ihYNY0oMTXUkSHq4sP4NmKO7gu979lRAXn/G7wdmOTWJ33ny92UmnjTHAi1e/4RMkX7SXOfbmqCkx28gu3VZEmXnrbACJwXRGmYvzOMnkI5Z4Xz7w3vs/AseaTfotUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBm9ZWjQ4KWoCsYbkFbAlblnBluFqKr9xro/stKl2Ik=;
 b=f1/mIMsV8TmGqren2eoH08Rak6UVKQZSEKkF0wJ32GQ9Bmu9Jzh7D7QhCPEAd8m/61C2Kfm7xn5BEhfu253SaZphhdsqnB7NxaC8YhEqqLCGkC44+rm7Wt7a/apeda1rP4ufOyzEB9aPCahMzY5aeiEbHmaBEcHbW12xpcCkJHw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 18:11:16 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 18:11:16 +0000
Subject: Re: [PATCH Review 1/1] drm/ttm: fix debugfs node create failed
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20211012115834.19577-1-Stanley.Yang@amd.com>
 <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
 <fb4360bf-57e0-e58e-f858-241b5939425c@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <3cee661f-7807-b3e2-f281-07f7a64e40c8@amd.com>
Date: Wed, 13 Oct 2021 20:11:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <fb4360bf-57e0-e58e-f858-241b5939425c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (93.229.33.108) by
 FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.7 via Frontend Transport; Wed, 13 Oct 2021 18:11:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b936ebb0-bb73-4dbd-107e-08d98e74d952
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5493F927A6537749FD337E218BB79@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awue05lPlYpOrgTNI1mvLrGKgv/Qn4oiILNwqc3EhVW9gel7Wt3acV5g0HgKEwXhmLrk6QU7mgTDpCBs+4HkxBhZ3fsVnB9qVhKuwfOl+oVAlsfuDY6e2QhCc76N81EvWo1jzTD82p31JCWzEpnG9J/6zSNXDf3RuhQP0WAhizOL5UfXAv45B6UPSnYxpk255NZaUGOOX12tOr7j2BGHAwUJxjlZnyLgLPKKawJCaiVqSvA/mBTd+ubRbgbuNKb+eXfwV1T/va3MGwk7eDiYcGpHptUxSLfAX+idyMCln2BfSz8JJPqo8hxMZGnI4JhWPyqRAJUV3qe8PJIlt+Bwtb4/G4Qe+QH5u8QJbbaOgE/GTfcjEwY2LVkZwvCVdLmmbqTECtkGj0xrSSrOXgcNlOt3KCFJgRSnpOSkOVFfVJhsk3T31lSn7betIPA9K3IQw/E1sr7bwwHYBWVaAkwiq7oR47+W0ZMBtsNNq79Kh8VTSjb2PiiiL+ywme+0lD6nyjaF9NaNQir8/Fhh6e+qacLbH31IZu6R8clI64qU6y531mGwWivPeVRc5+6K8HVBeEFiPqKvNxeSknuwXDHnKV6bx5QJW9U4tcUEVEk7YohlrpGvQv8Y94WeSxQvjLsQQrRZ9G5kCoKVucl8cf41gTmbc+rmSPIqORbGiYh/XgN5NlkPRgoR18T/idvSDdP2bsXg//rAHOpH/qlgYL4hOjfbCQ5pi3Dz943wRZAfa2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(16576012)(2616005)(86362001)(956004)(508600001)(66556008)(8676002)(66946007)(6666004)(38100700002)(2906002)(31696002)(8936002)(66476007)(53546011)(83380400001)(5660300002)(36756003)(316002)(31686004)(26005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snh5dnVmbEtybE9xd1A0WjlUQXk5WVJjWm5rYmpKTzFSRFB6S3pCVTI3bVhG?=
 =?utf-8?B?VjBxTk9tZ2lUWnp2a1dZS1M1b29CUTZmR0dsZXovOWRtOWk5RTRWV0VnaVpH?=
 =?utf-8?B?bkVMZUFhT1ZZbmg3aks4L3duUmtRajJLQjRJbVg4MU11QTlja0QyUFJkMWdT?=
 =?utf-8?B?TmpCVXN5OVlZN21laUtWRTVkMTgvV0ZVNERBUHdLeGZMSDFQUUZIWFJzdjc5?=
 =?utf-8?B?enk1a2htdWc4S3cxV3YwZGRRdTVlamluYVYrdVlyeXJyaTBaS0RObmtKUWxs?=
 =?utf-8?B?SmNzVFRBR2IvUm02ajZkczFxSUNMaHVtT3RJVXRDYk1YMGRMT3hiSUNBQUg4?=
 =?utf-8?B?Y1dWM0hDZHZQejJ5dEVqWDhSTlBKL0VKRExmSTZYeTJDRFZYOS9xTVBoMkpP?=
 =?utf-8?B?ejZtZXQwUWRYaTFYTXh4aW96cnZlbzgwNXViM3JNRUFibWR4YVJ1QWw2ZHM4?=
 =?utf-8?B?RFR1RzlmeldnVnE1ZlRnQ1R5QXBJQmx3YnlVUGU5RmdBWmtwTFM1ZFZENCtu?=
 =?utf-8?B?VUJkc2xaU3NNUDd5TGFxME9EQWZhbEErUjVGNEYzbzJUYTBRSU5BUVpCLzZV?=
 =?utf-8?B?cVd2QzRCdE8wSUgwSnBwaDBGR2oyc21hTnlyVG4zVXBSOWpydWt2L0N1WnZJ?=
 =?utf-8?B?VkJpTlFacElhQ2ZiM0tKZnlsRnV5OGc4d3RRanl1NmpWRjJkcVlVbDRjTVR0?=
 =?utf-8?B?RWcvOXZnSG1iVlZTRld6VkF0Z01EZU1CWWtNcXEyVTF5NXhSTXVEOVhXL1RR?=
 =?utf-8?B?YVQ5UVpwZmJHY3ppYW9WZEplZkxyejNyTkt6Z0ttK1p3TXk3bm1vTjRpWVN3?=
 =?utf-8?B?RHY5Wkd2VkN3MVUrOUg2ZkNwTnJhSSt5NjNJNSs4aTE0MDY0Uk5iZjE4N2dr?=
 =?utf-8?B?SUZ2MjE0eVpsS1E1NjlLMU4vc2FnK0hsOEJpVFdBSGIxWGlCZkVwTkhaaGRz?=
 =?utf-8?B?UnNHNldUTjQxbm1HMjVXUzJvbE4yLzBMZ1dTR1dqWDB4cUhlRi82T0lwcGs5?=
 =?utf-8?B?ek9KM3J1TFNva0tTZHdnT09kL0hOYU0xL1l5cXAxREVGLzdrWkVlTktraTZK?=
 =?utf-8?B?akhWb3VNREs0bmtBWmxkNWpLR1A0c2JXTzZXd3NXKzdGZnBsVjQ0MFV2R3Zy?=
 =?utf-8?B?SXJvcnFxZisrS2RHa3diRjFVMkNpTS85N2N3dEdWcFpNM3pYNTlLQnZNcDFz?=
 =?utf-8?B?dEVuZ1NFK0NCWG4xQVcxTDlsQ1lVSFozWit1cDd4aFl3Wk5SSGEvTXlEOVNO?=
 =?utf-8?B?TjRKaHFGNFlwVGZ3WXhONjhKcjEyRm9SMTR3Uy9ndElBWGR3RXZYY3ZpUllQ?=
 =?utf-8?B?OStsWmt6eEJVcmVZM2UwWERENDJuVzFnYXJVMjVWVmw0N1dCd2RmaDE4T2pi?=
 =?utf-8?B?NjhwYVNoN3hZdnlBODAwcnkrTk04eEdaa1dtMnhqZDh1RnJlZEtsRFBtNUZp?=
 =?utf-8?B?d1ByUzNvaERpb2R1dmdvaVpaUUFsS2xmMWlvQjZmdUxibGF1WlBFNUJwRDYv?=
 =?utf-8?B?cXNzUHdIdkJVT2xFZFBXNlBrcTVnUUxCM01iOUlhb2VGSjd2OFhtUitnUHBl?=
 =?utf-8?B?dHJOY1NxcnI4SFdvMGZPeUExOHZCTGp6T0k3M1NIZVVGc3BpU3h3UmxDKzVI?=
 =?utf-8?B?R3RkUVhKVmxSdVdkQjZzUUp4dVBLcGFEREwyNDBUUFVlcmx3SDRET0huUW1h?=
 =?utf-8?B?aEVWNEZiSGpkOUxJdDk4WjI5Ull0RG9WVFJHMnFQckd1eVYzbU8wOG5KTjZI?=
 =?utf-8?Q?GIWyHMi2EWLrqFltgH/QtKMRhy6aQbAENnSI8qL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b936ebb0-bb73-4dbd-107e-08d98e74d952
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 18:11:16.4673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSgDy/THTSRU46yTvxnCpdFVppIaT1pH4eexPS6nrXi69dLzf31vpsAO67f0kR49LaMUkxlQFVcblywSEzbSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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


On 10/13/2021 2:29 PM, Christian König wrote:
> Am 12.10.21 um 15:12 schrieb Das, Nirmoy:
>>
>> On 10/12/2021 1:58 PM, Stanley.Yang wrote:
>>> Test scenario:
>>>      modprobe amdgpu -> rmmod amdgpu -> modprobe amdgpu
>>> Error log:
>>>      [   54.396807] debugfs: File 'page_pool' in directory 'amdttm' 
>>> already present!
>>>      [   54.396833] debugfs: File 'page_pool_shrink' in directory 
>>> 'amdttm' already present!
>>>      [   54.396848] debugfs: File 'buffer_objects' in directory 
>>> 'amdttm' already present!
>>
>>
>> We should instead add a check if those debugfs files already 
>> exist/created in ttm debugfs dir using debugfs_lookup() before creating.
>
> No, IIRC the Intel guys had fixed that already by adding/removing the 
> debugfs file on module load/unload.


Adding/removing on ttm module load/unload is nicer.


Nirmoy

>
>
> Christian.
>
>>
>>
>> Regards,
>>
>> Nirmoy
>>
>>
>>
>>> Reason:
>>>      page_pool, page_pool_shrink and buffer_objects can be removed when
>>>      rmmod amdttm, in the above test scenario only rmmod amdgpu, so 
>>> those
>>>      debugfs node will not be removed, this caused file create failed.
>>> Soultion:
>>>      create ttm_page directory under ttm_root directory when insmod 
>>> amdgpu,
>>>      page_pool, page_pool_shrink and buffer_objects are stored in 
>>> ttm_page directiry,
>>>      remove ttm_page directory when do rmmod amdgpu, this can fix 
>>> above issue.
>>>
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++++-
>>>   drivers/gpu/drm/ttm/ttm_module.c |  1 +
>>>   drivers/gpu/drm/ttm/ttm_module.h |  1 +
>>>   drivers/gpu/drm/ttm/ttm_pool.c   |  4 ++--
>>>   4 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_device.c 
>>> b/drivers/gpu/drm/ttm/ttm_device.c
>>> index 1de23edbc182..ad170328f0c8 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_device.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_device.c
>>> @@ -55,6 +55,10 @@ static void ttm_global_release(void)
>>>         ttm_pool_mgr_fini();
>>>   +#ifdef CONFIG_DEBUG_FS
>>> +    debugfs_remove(ttm_debugfs_page);
>>> +#endif
>>> +
>>>       __free_page(glob->dummy_read_page);
>>>       memset(glob, 0, sizeof(*glob));
>>>   out:
>>> @@ -85,6 +89,10 @@ static int ttm_global_init(void)
>>>           >> PAGE_SHIFT;
>>>       num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>>>   +#ifdef CONFIG_DEBUG_FS
>>> +    ttm_debugfs_page = debugfs_create_dir("ttm_page", 
>>> ttm_debugfs_root);
>>> +#endif
>>> +
>>>       ttm_pool_mgr_init(num_pages);
>>>       ttm_tt_mgr_init(num_pages, num_dma32);
>>>   @@ -98,8 +106,10 @@ static int ttm_global_init(void)
>>>       INIT_LIST_HEAD(&glob->device_list);
>>>       atomic_set(&glob->bo_count, 0);
>>>   -    debugfs_create_atomic_t("buffer_objects", 0444, 
>>> ttm_debugfs_root,
>>> +#ifdef CONFIG_DEBUG_FS
>>> +    debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_page,
>>>                   &glob->bo_count);
>>> +#endif
>>>   out:
>>>       mutex_unlock(&ttm_global_mutex);
>>>       return ret;
>>> diff --git a/drivers/gpu/drm/ttm/ttm_module.c 
>>> b/drivers/gpu/drm/ttm/ttm_module.c
>>> index 88970a6b8e32..66595e6e7087 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_module.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_module.c
>>> @@ -38,6 +38,7 @@
>>>   #include "ttm_module.h"
>>>     struct dentry *ttm_debugfs_root;
>>> +struct dentry *ttm_debugfs_page;
>>>     static int __init ttm_init(void)
>>>   {
>>> diff --git a/drivers/gpu/drm/ttm/ttm_module.h 
>>> b/drivers/gpu/drm/ttm/ttm_module.h
>>> index d7cac5d4b835..6007dc66f44e 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_module.h
>>> +++ b/drivers/gpu/drm/ttm/ttm_module.h
>>> @@ -36,5 +36,6 @@
>>>   struct dentry;
>>>     extern struct dentry *ttm_debugfs_root;
>>> +extern struct dentry *ttm_debugfs_page;
>>>     #endif /* _TTM_MODULE_H_ */
>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c 
>>> b/drivers/gpu/drm/ttm/ttm_pool.c
>>> index 8be7fd7161fd..ecb33daad7b5 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>> @@ -709,9 +709,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>>>       }
>>>     #ifdef CONFIG_DEBUG_FS
>>> -    debugfs_create_file("page_pool", 0444, ttm_debugfs_root, NULL,
>>> +    debugfs_create_file("page_pool", 0444, ttm_debugfs_page, NULL,
>>>                   &ttm_pool_debugfs_globals_fops);
>>> -    debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_root, 
>>> NULL,
>>> +    debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_page, 
>>> NULL,
>>>                   &ttm_pool_debugfs_shrink_fops);
>>>   #endif
>
