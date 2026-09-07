Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02DFC79FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 15:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B7D10E883;
	Mon,  7 Sep 2026 15:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjC+rDbT";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CA910E883
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 15:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5N2eA0HknAIZU2VtLIFEge2uAGH3iBesbg3JfkBYyIj6nNZDiNEf/Klb+dg24CM1SW0BV+u77lbbi38e2xND5g9o+xvbqbZVK/nb6IqJSiCwG5yO73euQ7VSZWK9vmlcmffIm2NT1jss/K6gVWoCDnLE04Kowpiya+FpquAuJYkRg/6htZP0vcdQsEf4eH1NaCsA7AVJnts2aAKJh5cRdUK1ihRFMAk/QdOTIBHY89BV2SLECr0zHhVPWoI3IIXUtHL09Hao+RmP3hs85bAte2SCocF4Vw86cMLBN0CRf96+l2wZXOHi3vLlYicMKI1KaUrlHxyScloLTRk0twteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezn6VN00sQGlXuA+aklcvCf3ZWYCvhWiAITsPNDOqpY=;
 b=e9VafbuLGzUtXOPvwA5ETlI8EHMeGfdmJ+QyQplVEr0OgheS9pB474Xa7PvOB0G4CSYQ7DM/mlpZPG1IEof6jzgV3Qe3NejKfgpZAeU/nsxxtlDFi+IYHISYBCI7cPOoq9QkSD8xB9jqNmxHU7/hMJO1RT0hwJ5cSraKI/zl2JuIb8Ewtw5+wQ7kTRISGTZz8tlPrQZJlzOo2+hL32kWlBn69IE1VidkCLyMS3jofVxStpveHGwMBayTwZoLIY/5kn10vmZFnegLnNZ6dcsl67s+7HroO0/7PxoD9xucE8vk7QKY8j1PgM054iwO1kG7JpS0e9FWkuv6r3MUAiNt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezn6VN00sQGlXuA+aklcvCf3ZWYCvhWiAITsPNDOqpY=;
 b=MjC+rDbTVkntVA57bDuJcCk9gn1b3QWRiGDk7bllDEHPcbUYwiauRbib0E96ic+c/I2oJGe2dIf8NgASwp9OTTf3SkynNcxRNXJbJzh8kKNk//cDYY9YUxwyX9r8DK/hy4mAcuDoijsi0x07BTyti6tfuesIY6Mkt6VTG6DOSRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:40:44 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 15:40:44 +0000
Message-ID: <089b7705-971e-4d3b-b609-9e17b1d1b1a3@amd.com>
Date: Mon, 7 Sep 2026 21:10:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix userq_signal_ioctl stuck in
 drm_exec_until_all_locked()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260907084719.3972-1-yogesh.mohanmarimuthu@amd.com>
 <f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com>
 <7b03140a-5c9b-4e87-92b7-72e8c1d93722@amd.com>
 <d50952b4-6886-465c-9f76-2eae4895ba2f@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <d50952b4-6886-465c-9f76-2eae4895ba2f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0317.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::8) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: d6025ee6-6a14-4143-7c85-08df0cf6613d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O6fR9fuK+sS5ES12PD0FH3SJnxwhyAnVFwG0Hl3eSrx1ySxQv4lpjjRJc10hNU3wOeq/cH64Q9ku2JDekDxjqAgL+rP4DZk0D3bcJ7VAErSxzWUUuCIps79xSwSqLC7zbBF+ElLkUhWWSU9QlyFFQDIsHdRZCLThIe6xXsMFtP/pXV4LNX9viALzO+RQ7HNSOCAH7sZSwQUXl1E23/VFVsJQYulVQLoTlo/x+wb/g6eNQGtiUzWnz+VMtfNEdK0x/hfEiLeuspjOeE5gYsMmuYmf+K+8gACFmyIhE69u+BanC+w8JFvYl+g0+CucJhsjY+O8/y6z4IC0nSkPhcoAljQglWhVsPy62mO0w0EmSLfoBwsVUm9fpMd8lrNGAXuJhm5I7Z+sMCbyZbtoL5sdbRomJYwMmlfNEtGr140NynBVzycyYGMrLqUUVbqhArAEc3PuD1ebqinVO40WmqZ7I3z2a8s3NOucYVmm/dDEyKboaif0Vgtn83SYy1R4VlBbD1MqH+lLF1UH4x9E7BseNHDQcbnd5Uw0nePsi7iuwIRl4kMMLkZQYb0NvoVblRB5/EF22TeUW4JHrf5LohLerWKLF8t0l7opDlGrCNu1IgAiYELR4kFjpddul+tC+i93
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFabTA1WWVnLzFEVXFYR2l1Qm1tenpBdXJjWDVDTkwvZE5JdkphbmdMVjFN?=
 =?utf-8?B?ODRoRjZ3TExhSXhWcWdGb0IxZXg4cGVCaUl4N0QxZ0pURVBESjNQanZBcC96?=
 =?utf-8?B?UWlIdTJxWkxqU29LdnRUTHI4TVZvOG9sM2NIemVZQkRybUZ2SzhjQm52WC9V?=
 =?utf-8?B?dzJITjRXRzhlOU1xR3B4MWZ5eGVMbk9iQVo2ckJNd2VPdVFIeXNId3BES0Zu?=
 =?utf-8?B?V3g4Q1cxYXdiMUppZzF1MG1ZUnlmTWlVT2c3MWJhNmhDVVhXTWhCa2lVTUw2?=
 =?utf-8?B?Y2hXaUx1RWdmQ3JGRkFRckFidjNsVUl5MWovazZBZjNLYlBqUUVSQmlwTzVu?=
 =?utf-8?B?eHJTTUJCN3VUR2d6YW9JazRHcFk3YndhSnpLMjBlZTAwY1VoUXdGWVlsR1R1?=
 =?utf-8?B?RG9sSTRzZVdaVG9tYUZSVkpna2pqMHJwZCt5MzljYXVTbUsweHpOR2NjWUtD?=
 =?utf-8?B?UFBVR1FkQk1kUlV2eXE1WkZPRG5wUjBXVStkVTZkdGYrL3M2UFhJdWY3d3JR?=
 =?utf-8?B?cUdaZ3kvYWhvYU83K0tZU2w4QzBkWWE3Q05nZzVzVzJXenRFSkZSNUdJdG5u?=
 =?utf-8?B?WFJrYU5BenU1UTRJWWU1Zy96L1hKcFpsemY5ZXM4dWc0MnlFWHVXT0ovamJt?=
 =?utf-8?B?Y3NwTGNMd3BsR0V5VHkrMkxnQnBFSTlxNWRURS9XVzRXR2oraUlxdnVsdnZa?=
 =?utf-8?B?dnd6Z1QrZE1ac1ZPU2E1R1JIcTZ2STg0M0wzOXZVbUliYlVYV2tRbFJsMlFa?=
 =?utf-8?B?cW5YaEM1RUtMU3BYcUVXU0djbVR4N2x1VEpYaHM3NlRCQkkzQTUyZEVaTEpa?=
 =?utf-8?B?clFIbmQxaW5NUVBmMHByK2dORm9WZEs5bU12Rk9YRUhBZnlRQm83U3FUSnYx?=
 =?utf-8?B?UkxkNzFqdlVUem5zOFZQZkpZOUZXQnpoOVVEOURnMWtYUE00YjVFNjZGbmx1?=
 =?utf-8?B?b01LVXQ3bHVPd2ZQNjJLeXN5T1hUcGpKRmxUZGhiTGkzZ21ySkxMVnQwTXlj?=
 =?utf-8?B?SEdVZU1Ibi9GbXB3WGJSTGp0QzJTbkNUL29RQjNTVktvakhnK0pzdk5JdUZM?=
 =?utf-8?B?K2tJWFJ3SkZMNnQ3L2Z2L3dCczZ6c09SbjNVRXRBMW5YQW1KbmIvQjBXVlFl?=
 =?utf-8?B?OTkxbWtoY01KQ0g2UmtuVkU0eWFSMGtwTVMyYkltdkkwMStWL3FEZWpYTFE0?=
 =?utf-8?B?M1dCbSs4b3ZRZmoxazZRc1IxcTlKeUVZOEJlV016b0l1Ujh3RG5OYmNiYkdO?=
 =?utf-8?B?VlhPZ3ZtRU1ITXA0RG9SZmhKaG9kb0dpeWlCbXNaQjc2ejVRMVZwMjJKRW9K?=
 =?utf-8?B?cEsvYXdQVGxsbjhPZmpTMlRxMW43VjMwRkFsVEo2ZWRqTWxveWRPcXdXc3pV?=
 =?utf-8?B?UzI2bGxiQ09Mc3VlMFVObTdnNEs5RmJQbXpSd1BuVnlsVUIrSVUwV1kvVnl6?=
 =?utf-8?B?V210ajhwdlpaV2oxSjZjcFR5TTVQdFUzeE55bFkxc0R1RXBFVnpKbU5zdmxY?=
 =?utf-8?B?V0l4ZnhwcjdKSHYrY1ZFazZraU1wcHNzU0ZYeEh5MElFMnpKMTh3MWdSdzUv?=
 =?utf-8?B?a1kyV3g5Nzh3Y1oyeTRXNllBNnM4TVE5SXNwUzJYeEpqSC9wUjA2K3R3WEJN?=
 =?utf-8?B?bnBjOHpJSG9SenptaHNuanVDT20yWkl5N1NsU1kwMWduVWtqNFNNZHNBZXd0?=
 =?utf-8?B?R29KVmtYWlB2NFdYUCtBM0NQV0JzUmxNSW5ESDJlaS83R0RZeFBuV3J5d2Ez?=
 =?utf-8?B?OFFVTEJFR2ZYbFNsZ2dtMWp6aDIxYmlRN2hyeUQxM2g0SjFBUjdtQnhEWHNt?=
 =?utf-8?B?L0gxNzZXVmVXd3JRZnlmMjlRTUh5T0tIb1lqRXI5dy9hMUxtc05LeEo1YTU1?=
 =?utf-8?B?SldiU2c3TWFxZUR1OC9ibTdudHVlYzVUZ3p0dEVENUh5SmYvSFZPVUQrcFFJ?=
 =?utf-8?B?OE1wRmM2M0ZwSjhJMXl4QjVjNTRPU1hab3Y2MjZERzZGZk9FS1Nqd3ZJQnNL?=
 =?utf-8?B?bTFSdStGMDFSaGZuWVlIV3QvbzVTazFIMmUySzVyVG1TeWVSdUJ1dlJ1bE0z?=
 =?utf-8?B?RGxRSkRqeGRMdysyaVRhZ25rU3AvTFBXVWJ4SjV2YjZvMngxR2FqcHgxa1BH?=
 =?utf-8?B?dlN5UHBWN1JzclBJVXRrbVd3QVdwN1JROXVqWno4b09WVk1kRTZvYVh4UWg2?=
 =?utf-8?B?blJ6YStDK1RoYlVjL1Y2RTc1Mm5aSndGa2FubWxvUmxzL0dXZGFoOEFXMGFs?=
 =?utf-8?B?TFQ0cE5xOVQvVENsTW5LZnhWelZsNm81ZGRCNTFHdXJacS9rTUlzVzNUZERp?=
 =?utf-8?B?QjFIdlhWWmovN3ViQ0ZnYjRkc2kwWVV6c1UydnNMczRHM3J5Z21CZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6025ee6-6a14-4143-7c85-08df0cf6613d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:40:44.5920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0BymjWOY5NYxBN6bZAC1c4v+2oFjN/ASDVjFThu6Ugs/MdUrVzipYRn8y7YS0mJCicbSG7JlxDgSYOzMN75HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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


On 07-09-2026 08:41 pm, Christian König wrote:
> On 9/7/26 16:42, Khatri, Sunil wrote:
>> On 07-09-2026 02:23 pm, Christian König wrote:
>>> On 9/7/26 10:47, Yogesh Mohan Marimuthu wrote:
>>>> If in userq_signal_ioctl only bo_write_handles is passed and
>>>> num_bo_read_handles is zero then if there is contention the code is stuck
>>>> in drm_exec_until_all_locked()
>>>>
>>>> This happens because read bo's are handled first and then write bo's in
>>>> drm_exec_until_all_locked loop. When there is contention in one of the
>>>> write bo, exec->contended bo is set and the loop is retried, but
>>>> read bo is zero, still drm_exec_retry_on_contention() macro for read bo
>>>> is executed without drm_exec_lock_contended() getting executed.
>>>> drm_exec_retry_on_contention will keep going to beginning of the loop
>>>> causing infinite loop.
>>> Well that is a really good find but clear NAK to the solution.
>>>
>>> This if this causes an infinite loop there is a bug somewhere in the drm_exec object.
>>>
>>> My educated guess is that drm_exec_prepare_array() needs to call drm_exec_lock_contended() even when num_objects is zero.
>> drm_exec_prepare_array()  returns immediately if no of objects is 0. If its not 0 in that case order of calls from prepare_array is drm_exec_prepare_obj -> drm_exec_lock_obj -> drm_exec_lock_contended
>> So contention is never cleaned.
>>
>> I can patch this up in drm_exec_prepare_array in case no of objects is 0 call the drm_exec_lock_contended like below.
>> if(!num_objects)
>>                  returndrm_exec_lock_contended(exec);
> That sounds reasonable, yes.

Thanks Christian,

sent the patch for review on dri-devel@lists.freedesktop.org

[PATCH] drm/drm_exec: remove contention for num_objects is 0

have a look please.

Regards
Sunil khatri


>
> Thanks,
> Christian.
>
>> Regards
>> Sunil Khatri
>>> Regards,
>>> Christian.
>>>
>>>> Fix this by only locking and reserving fence for bo only if there are
>>>> bo passed userq_signal_ioctl.
>>>>
>>>> Observed this issue when testing with MR
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
>>>>
>>>> Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++--------
>>>>   1 file changed, 14 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index c270635c9..135e77837 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -572,17 +572,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>   		      (num_read_bo_handles + num_write_bo_handles));
>>>>   
>>>>   	drm_exec_until_all_locked(&exec) {
>>>> -		r = drm_exec_prepare_array(&exec, gobj_read,
>>>> -					   num_read_bo_handles, 1);
>>>> -		drm_exec_retry_on_contention(&exec);
>>>> -		if (r)
>>>> -			goto exec_fini;
>>>> +		if (num_read_bo_handles) {
>>>> +			r = drm_exec_prepare_array(&exec, gobj_read,
>>>> +						   num_read_bo_handles, 1);
>>>> +			drm_exec_retry_on_contention(&exec);
>>>> +			if (r)
>>>> +				goto exec_fini;
>>>> +		}
>>>>   
>>>> -		r = drm_exec_prepare_array(&exec, gobj_write,
>>>> -					   num_write_bo_handles, 1);
>>>> -		drm_exec_retry_on_contention(&exec);
>>>> -		if (r)
>>>> -			goto exec_fini;
>>>> +		if (num_write_bo_handles) {
>>>> +			r = drm_exec_prepare_array(&exec, gobj_write,
>>>> +						   num_write_bo_handles, 1);
>>>> +			drm_exec_retry_on_contention(&exec);
>>>> +			if (r)
>>>> +				goto exec_fini;
>>>> +		}
>>>>   	}
>>>>   
>>>>   	/* And publish the new fence in the BOs and syncobj */
