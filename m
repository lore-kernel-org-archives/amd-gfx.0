Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C43CD4F35
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 09:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D5310E202;
	Tue, 12 May 2026 09:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AualDgSx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C31E10E202
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 09:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2pexuI5FQPq1UiqsFRnrO9fGbhBeCr3IjUQLnSMkkwg+I7iYHQMTu6qD4z2ZWj3oSuKqSZgdH6R/8h3DwWmdU4YEL8dbpDUkXwhxvGbQ/vzOIXzIZ4XyJ0b0f435KZlCGep3zKLWQFC5vRSpOjQSXfRyMuH6bsvoGFGCvDcbuEE5RTIir/z/a9gfRuPahm12ONPRkV+Bs1uCWaQDrGevWUEp49LbXLcSiLZ7sJRQoWvmmmy1n4z5zb1lx9aU6TGVZSQ/laTVSx7MtF475fzf3v9tBqgVLYv67H84uNuuqKA3Qv12b6ve6hty/DqrAE/Cq6wirWG6yqPRwyhyWV3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw18yBb6MRxqJTt7gOdKOzrrkG3YYIEqtZcLk4uQAgM=;
 b=gpTWC4tNMkxEQaHN+aRYcXXTb8ueTX+0JQ/XbNeaSB1Nmxi3MBap72hUwSzgd+kKHpA1+gBPlvXJbBwrCK0BYOuuSfFKtIg2oGzCq1jZhw1ZTSwI/SXsWeiVFj716n2s/I84HHQUPmDvBqauPLNN9E3AAWuweTbjHbJ+qbqYIIikhF6iD52orvE8ocI6lVoD6Md0k2zyUpUOpULChaTSt7Z8CJB3mm36DDjIiYQduD5JH9iGFuyz7ZdTixvhjKHEovcrZkcpVUlx0+AmbcMvwKB2YzPYT0VhxMWbXs5u5wwfiAAZEj3SxMHKYgCkDL0mvcygR6R286C5CAcgFjJ48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw18yBb6MRxqJTt7gOdKOzrrkG3YYIEqtZcLk4uQAgM=;
 b=AualDgSxFf5dK/voNOoEelyQu9l2Pi1j/3Gl04HttdnorbT/H330jBRwvgWiuEeVdZuC8t78ApRkr1sF6lYsGEPeuZG7JcBlE+JOWnpobgV+y9VWbocJEmFcpkbZRVcL4gaS+mx8cwTgX5KhucLtXpUEJOVBxLHT1FTwu3Dtp8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:31:29 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 09:31:29 +0000
Message-ID: <3b683519-d634-47a5-a004-eaa9a7aa587c@amd.com>
Date: Tue, 12 May 2026 15:01:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: make sure only one reset work thread
 runs at a time
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512070444.405424-1-sunil.khatri@amd.com>
 <d16f309d-27fd-4f50-8e56-3839501a1196@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <d16f309d-27fd-4f50-8e56-3839501a1196@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: e5172952-7cf7-425d-d996-08deb0093ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XpnvfqeXVZLnRshEk18k9WxYblMVTzoS2dsm2nXKziNfJ8VEjpqAsaARlwDlahxZXC7lVRp/jS765suf47urnfd+EAVdAWCuPb4fOA7f+ubbX1AdSh+4uYfekfSzcx8wFSRp6b17ZMUXLWQl9Ii5r7Pcr7YQCB0HH2TbuH6VH2JLueqvRvZTxfI/U8t0B2fLyVs1O6DwYw+v+yqLp7BHOCEYtp9VkHnodoov06Vv+vXi+0sKd7Mj8tRCuODeCxOWyG0bzGkPkB+8qaACFZ1bLncaB/uYNj3X5B3vhg50yVTfeB6tFZ0/X8aF3UQ3ahlUF9AIZoCFkMthla9sK6ZL2Z4fdsm+X+EXWC88EKU0uLnoTnZ/G61DENx9ipT8qKcnWr84HbU+YSo3boDOpsdA1KPsh+gzM+gCqcdPM5ijVmGDR0jGdWH4MMVTKEAzZp6XiEeREcJqasZaOGSnO8BKhOGlRwkUIK9q3KROJyBZ147LNl9RHEKzhm4sJ1X0o3Jw/p7fqAexfeeu/Rn29hVHi/exqY/sr7I3FyQbGUFggvUzLNW+qDsoWfdGoQlmCeU79dQySTlkFjPdn0fuLTwsBonw/oqovzxgDegWH0U124RFsnJxH1AIG5shWShoYivpTET61mjvTyJmks0nE8DNtpXpvDqLaGxNExMdmqEeEFlzbpE8D33gKq+ZnZmnsDYo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJTQ1M3S0ZTSUlzMEZDTHNaMnFRc1UxQUxpeVVrSzlheVlZOW4wVVVOVGRY?=
 =?utf-8?B?aHZxYUtvcTN2VkJHTUV1VXhJdE9BaHYrbktINjEvcEw3T2ZmdWNFQkQ5a1Zy?=
 =?utf-8?B?WjNaRjR6Q2tiK0lyaDVUK295UVJ1bDFBeUhScmwxYUFSRktoN0ExWkVXWk8x?=
 =?utf-8?B?WGtKeFdmRzIwN2VCMUxkME9mZzkrZDdYRnF6MWVVWWdqOTQvK0U5eUxWeEJR?=
 =?utf-8?B?cnlNclVMR2ZYb2Q3N1ZwY1ZwblIvWlpSeUlkeks5NDRBbkZydUJjLzVhdnRq?=
 =?utf-8?B?bEJZWWNzdUFjR1l3ZzEvU0pQVTRDNzZ2NmNXbkZYZUkxVzlGcXQ5b3lZTjdh?=
 =?utf-8?B?aS8zUmx5SXdKQmxkY2h2YnhYRlJPdk1UUVRmcWZQQkJjTytQWFdNSkdzT3p0?=
 =?utf-8?B?SkN3WTE3SzhzUUNtMFlJOWtrUW5RMUlkTGZoNm5LYUxrNzg3bGcrSTNLdS9z?=
 =?utf-8?B?TTZ3cWNpSTBoMmRZQy9aMDhwOXpSQkovcTF1T25DNTBHRWJ1aWxpOGVNdHN4?=
 =?utf-8?B?L2U4U1ZkVnZRUmpSQTBWOVp1OUNNbFhSc1dqbXpOVE5JSGhZcEVCSGFDbGlK?=
 =?utf-8?B?c2thR0dXRm5meE5BY3dyL1ZJMnhzK0lnM3RRMFR4cmZ5RGdpRVRYM1UxcmpV?=
 =?utf-8?B?b3JIMlFENVNoRG5OQVNIdkZzMWtDVHBqd09vZHhyTEJVcWRNZFJRV1pMa2tH?=
 =?utf-8?B?cjd3VU9xaUlHZzVuNUppdVhkNGNJUjNZTUg3ZGpBUFFtWkFnYVdZTkVCWk82?=
 =?utf-8?B?bkhpWkVhalJybEY1NjQwbVBnaW5wUEVFb0x2SWQwb3ZEemlqRlBpVmlxcHVN?=
 =?utf-8?B?OHE3UXArOEYwOFpMQ3JnVWZBais3NDlIRlhDRTdmK1N6eE15RFFDUVVvUG5U?=
 =?utf-8?B?V0Q0SFc1OElLcnVJbjZCWFA2ZkNpTDdtSkhBS3NIaHp2MkI5ZkFpMnpzWVBP?=
 =?utf-8?B?T003TW5XN3Z3NEFPZHpNYXhBMEh4R2N0Qk9pNnp2R09rSEpSbHROeUtwWUFB?=
 =?utf-8?B?Q0FsdStmZmJuaHRoTmgwdnJQNzhML0xlVDdTTUloRmJPdTF1WnJxTWxSa3F6?=
 =?utf-8?B?MGQ3ZmthWlFaUGJORzVTa1dZeGRMZHJlRkJQSlpQRXdoWVdMZDMxZFhPKysv?=
 =?utf-8?B?dzFpU0hVck5LSmU1aDdVaWR3WmZTNEhuZHNmSUFLTkd0Zk9mRHpMZzlPWWxp?=
 =?utf-8?B?UWFTVnZpVzcrdWRwbHVKTFd6MW1TUUNML2ZVTHZtaTFuQjg4TVNFOTZ4eCtT?=
 =?utf-8?B?R1MyVjdDQytwTTB6MC9peUxBbDYzN0RManhxNlVtbng4TlBoWFhzZkdTakpM?=
 =?utf-8?B?SHZGL0ZmeFo0OUY1RW5zWFZDVEFyZXlCU3dwY1ZyemYrQ1g4aC9aSXlwdVVx?=
 =?utf-8?B?RWxOSzJHZEdITjROK1lWRjJUaHBGWGpKRkR4dGduRm4walB2K2d6bjk3VXMv?=
 =?utf-8?B?NlhHNjhiWm5JVGxpUUhNcVFGTzdOcEZaRU1JRDV1bThFUW9ucHVXMThKekVO?=
 =?utf-8?B?Mm0vUkx6aEVhc0Nvcmg5ZlduK0xzZ1FvcG9hTHdIdy9jTm1JYjFPM0NSeFcr?=
 =?utf-8?B?MzJJZWxUSUpyS0VWWFFDcWtZWFJDMUxpMjZPOGV1ZGFmSG1MYys1c2t6R2oz?=
 =?utf-8?B?VHowY3dWdGVjZktuTXBJVVFUZUUwbTMzWUpGUC9vVTNXS3k2VTZ5OWordURy?=
 =?utf-8?B?ZlhpWkVLZEdPN2FwL1k4TFBoeGZQTEhidUVnSFJ3MElSN3lGbHRaanJJL0U0?=
 =?utf-8?B?ckJKOVhvVnFWZ0drZE1PS0xGbllscS91NHBHR29tWUkwRmlFekxZajlhTEpY?=
 =?utf-8?B?N1Z1dSt0UVAzOTBKeUFKdS94eWZYdk9mYlZEUnhKUnY0M1RQdWNOSEYxalBa?=
 =?utf-8?B?ZFJQZHRYY05pWGgyL28wZVYzRUwzWmZFTW0yQUJab1o0SEx4NHZ0ZGgrVkZm?=
 =?utf-8?B?MCt3eWpNYUxvY3ljUjYvbDhESUMrTFlLUHdUQnRxbTM0V3dXV2pUbm9PWVVo?=
 =?utf-8?B?ZnlybUFqeWpKYlQ0L3gwR0hEeGdjb0h3VnpHTi9lOWlscGM3RHJoRDF3US9r?=
 =?utf-8?B?a1dXcEU4RElZM1ovZWdoZ21jSktLUHQ4K3NqV0ZxK2NPSE0vOEZUaW5kbDAx?=
 =?utf-8?B?WWt0Y1dpUVMxZ3R4TUNvVTgvbXF5SW81RXcyVlAxc2xZV0NMOWVOZWhzMlEw?=
 =?utf-8?B?dFM5bVhHYnNpTHlPM2tVekk5Q1o2LzFOSEFsSVVtYS9KdWxqUXhKam1RNE9q?=
 =?utf-8?B?Skt4NGdIWXZVRzhTeW1Qb3o1RkF2Qkx4dEJGc2FneG9FMGpqN2pQd0QwWGE1?=
 =?utf-8?B?VElvTWU1T3o2SlZUejN2UEM0OUljang4VGZqSVdxN3ZJR3VQbFB5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5172952-7cf7-425d-d996-08deb0093ef4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:31:29.3920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiPDbgtwzXmkkVI9/achDLOtvUiimY7S0gMXozdYkalgw1l7EtfZy1mDrEl+o+D8IHaQDyYTQnIl50ozN/URbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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


On 12-05-2026 01:52 pm, Christian König wrote:
> On 5/12/26 09:04, Sunil Khatri wrote:
>> CPU0:   hang_detect_work → directly calls reset_work()
>> CPU1:   evict_all → queues reset_work (via workqueue)
>>
>> There is a possibility of two reset thread running at same time.
>> To avoid that we add a per queue manager flag to avoid duplication.
> Clear NAK, that doesn't make sense.
>
> All reset work must run on a single threaded reset queue, so only one work at a time can run.
>
> If multiple reset sources trigger at the same time (which is quite common) then the ones handled by a reset are canceled as soon as the reset is completed.

Got it probably the reason of two instances running is different as we 
discussed. Shared another patch for an open bug we found.

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 0a1fc45f5b4e..1440f51b667f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -109,6 +109,19 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>>   	if (!amdgpu_gpu_recovery)
>>   		return;
>>   
>> +	/*
>> +	 * Prevent concurrent/duplicate reset executions. Both hang_detect_work
>> +	 * (direct call) and evict_all (via schedule+flush_work) can invoke this
>> +	 * function simultaneously. Use an atomic test-and-set so only the first
>> +	 * caller proceeds; the second exits early.
>> +	 *
>> +	 * Note: amdgpu_in_reset() cannot be used here because in_gpu_reset is
>> +	 * only set deep inside amdgpu_device_gpu_recover(), well after we've
>> +	 * already entered this function.
>> +	 */
>> +	if (atomic_cmpxchg(&uq_mgr->reset_in_progress, 0, 1) != 0)
>> +		return;
>> +
>>   	/*
>>   	 * Iterate through all queue types to detect and reset problematic queues
>>   	 * Process each queue type in the defined order
>> @@ -145,6 +158,8 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>>   
>>   		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>>   	}
>> +
>> +	atomic_set(&uq_mgr->reset_in_progress, 0);
>>   }
>>   
>>   static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>> @@ -1304,6 +1319,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>   
>>   	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>>   	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
>> +	atomic_set(&userq_mgr->reset_in_progress, 0);
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 49b33e2d6932..2748ecc0f6c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -129,6 +129,7 @@ struct amdgpu_userq_mgr {
>>   	 * Reset work which is used when eviction fails.
>>   	 */
>>   	struct work_struct		reset_work;
>> +	atomic_t			reset_in_progress;
>>   	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
>>   };
>>   
