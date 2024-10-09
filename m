Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A8CCEE348
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 20:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381A110E811;
	Wed,  9 Oct 2024 20:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LU8dVdd3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AD010E808
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 20:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZddzpMzrzcQqbf+CKCNkpZWH7tD1Nejx4BXHfv5MP1mIuSGMdYCUqNuTl4hlfGMIILlb5ohKDH8FVCBvit0IySpbycAIfpHq3f95duS4IKYU+VY7OkMJWzyg+kQDC62TSWpVGEG7Uc4AvQFIID/bpAQkaVEjGwHtjyEsTyopcqySQzQV2Fimh9qwMVtEjsrUPFdN9MNpjUd2f6iG7/lB0XNEd0/Co4Hk1piryRJuDasD4T15HaIU2Ho91yprxaqLhCaxj+U34cG1K1LWFt01qyu5FSft9wbKt+/T5jx3SdxpNFempqiVW+p+GUtq3DawNwni2IMv3Kg/J4QIjWefIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzgbwcQnvZjvO8vMlPCjFZ2/TsCD+0+EmTiMIZIZIyI=;
 b=mp9ksRo3tB6he0Saghg8GzS9Bn/4YvglW/zeWRAiw8aTis/Jvubx0kbdZ5KZCMtLLQHMfDkPHv0yr8e2ELpLeIfRHhspw3ojcJulThn92bKFRit5WjEBMYclqURPRukDIeOLv1yE7unPulE9wd34J2JL0y6bDv789rxiiqDXfKwEupc2dZNBOTu0pVE4AM1HMSQaH7WoYzkFoMxEqDamfJkO5RDGFY3cTdeFnSbeZiOed1Edjd91cgJjyHx+de8ezEbn0Gvg1CFt8kWTapodZUfDGBwKvvlevYn/zHLUWcM9sc/c0TbmyJ+fWumSZHNeNdT991OKj63T7FdrWKOe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzgbwcQnvZjvO8vMlPCjFZ2/TsCD+0+EmTiMIZIZIyI=;
 b=LU8dVdd3m8vm1KCXHWf7Qj/lJuz+fMEXaNUbGI6WayPTmDtjRt9z7QM202/sAVjxFQMWRg76Brg61OljTOUb8ExYByRyWFRtSOsZnubF2zI6y1uzgpe2HuluxoRP0aM9nQVqQXWi/diHsB23HqYLvihGWFrK53j2FEIo3ky2V7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 20:38:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 20:38:02 +0000
Message-ID: <56b95963-f617-4578-a660-37eb471edd68@amd.com>
Date: Wed, 9 Oct 2024 16:38:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241009180855.14859-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9888e7a4-a87a-4992-3d63-08dce8a24537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWx4S2ZaaDMrUHNiMDM4MnlMdmNmdm4ySyttSnE0KzQxbWVDMzhrNDEyb0Z2?=
 =?utf-8?B?WmxBZW8xaXViMTZLSGNpVzhKQk9wS3htNDNQVXpuMDYyUmNPWlZPaGdLTWxv?=
 =?utf-8?B?a0ZTTURYTU5PTjd3ZTF1MEsrTldEQ3c2WWlPZXNpRHd4YXV3aHVkTklOcVZl?=
 =?utf-8?B?VEdyajNoUGJDK0c4VUUzNVRlUExvbWRpQmRjWFdkT20vMThEZXhoL3hlNDI0?=
 =?utf-8?B?ZVY4MkZwbWFZM214TUtGQytpMEphRS91MTFVZlNtNGxLZ3lVRzh6UEU2RlMz?=
 =?utf-8?B?UjhnMTloWG1PWVgvbkxmeXNQdTdDdG45b3F3TTlQditCOW5adEk1L1pUbkc4?=
 =?utf-8?B?MEF4WVhtNjJTdFo2Vm9DU1B5bk45emZUMkd6eVVMNWVKR21zdVc2MmtERk13?=
 =?utf-8?B?dHVVaHkxbDdWc3pJOTVHRlZtcWRsTlJoRkFhYXlUL0FoL2xhSm5XM25MVkQr?=
 =?utf-8?B?WDFOVHA5VnF3eEx4eVlaM3ZZQzNDa3U0VUJpSGdwOHI1eW1NUVV0NkZOL3hY?=
 =?utf-8?B?Q0JaK0dUbDBVckN3YkFpdzcvRVdiTXkrMFhRaFhaamwraENlMzdHaDYxYVdL?=
 =?utf-8?B?UHJmVmZYcWNjeFkvampNL2UyZXpLMUJPOVBJdjVKUFZaWXBwQStHVXRkQ212?=
 =?utf-8?B?TGJnRUZMV3FWWE5yaGZsS3ZNMy85cjloMDg2NEN6Nkc4S0wwVVQzVkMzK09x?=
 =?utf-8?B?RTFEVkVxWWdIeTN2cUx1aGZ0cVZRcFV5Q2RiRjBIc0c4ZDFENlRBYkZhS0xO?=
 =?utf-8?B?QWYvMXlDL01BVDIvdHl1QlZuK3UvVy9ZZDg0cUR3YmNWSTlEMFU5UndoYWNr?=
 =?utf-8?B?c25FNmZNaXl1aGhZT1pScDBoVzRrVWdxY2lGbXZrWk1TMkxVNDU0bkZJMTZG?=
 =?utf-8?B?SHFWQW9jUGw4UCtUdDB1bnFzRm9QWWNYY0tUOTVpZkdOVnVZVDBKUjh6NWky?=
 =?utf-8?B?QzNEaU10cEJoSmZuY0xlT210ZVhMU243WHV6a0FOYVFzcXBZVWM5aDA4WEhR?=
 =?utf-8?B?R1FvdmtlNEVBUzlLUzZ0Vlh5NmJKMVl6VVd5MmFNbFJjcFQvTHhBazFoNFlR?=
 =?utf-8?B?WWh3eEl4d3ozWkxIdWt2NXg5RWRjYXhGem9lZHI2dkFwWit2Y0NvdlNSSWF5?=
 =?utf-8?B?YTMrK0Y0YjErVkpNRURhWC9rVy91L0pkdVlpT1hldUpxWnRLdWxaNG11R1FI?=
 =?utf-8?B?ZTVZNFdBU1JsRW9rMU9IUW5Td0xMUUMyUlE1eHplczNEN21DSkpOWjlPcTV5?=
 =?utf-8?B?UzlVd1JjZCswcTdtaHFCa0VGNytxSHVnYTZKcjZSS0pNbEhsaXRhdEtGdkhk?=
 =?utf-8?B?WmpCNWVvbjBLdE1YNFVRUkxEcTVMd2IyZTlhQXMyaU5tZmUxV3BhZTNKMmU3?=
 =?utf-8?B?bDZWdE9Hd3RXUEpEWHZ3aVVpRzNwQk5hS1ZhMHRnV3dWaCtnQ1QwWXpBcnhI?=
 =?utf-8?B?T2JHTWloY2NvWkpkT3o0MHlSdHZuKzVHUXZxaFplS3cybExNaG03TzVUNlBs?=
 =?utf-8?B?cVpWVEtTb2Y1K3lRbUFUT21WamE3SWdDNzVQaTloWWZVV3Q5cWJCTE85a1FV?=
 =?utf-8?B?YWpJVTBSSzVRblFKNjF5WnBKR2VEL2U2ZWRxek5PWGtQTWtuRTNPNkZaMGtX?=
 =?utf-8?B?RXFjd211ZzIrZ29Ua254bFdsbng0amUweUM3cXM1SXlRVmRjcFhoSmxxRk1G?=
 =?utf-8?B?V3NXUGlRMXBybndQQkJSajZ5QW1uajBIb2FsMDVjR2FtbEVzejZ1MGxBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0tzZlBLYXA2bVh4cVV0T3k4dDZobFVGMnlHd1AxcTBQQTRFNVFsOVFBQy9a?=
 =?utf-8?B?eHdlM3FRR2tXWHliUlRXVzZqVHdjUEpRdjdYVTVSUTRKQ0JoYXE2YWY3dEFk?=
 =?utf-8?B?eDlVaTVvWEZob3ppTHlZVlpid0RWOTJPaGtsTmpqQ3hBNThBL3BoUFFBM01S?=
 =?utf-8?B?V0V3QlBDRk5sVlFXWjlGQVhrRHpXaWV1dExXRzJDNG5CeG95TDFudmZaTFhu?=
 =?utf-8?B?Q1FDS1p5amFYcjdiRXloZ0pWRDE3b0hwNWVUZVpjUGRudUYxSTFDM0oxLzdI?=
 =?utf-8?B?Y3pncHZPNGtZTVhYQi8xcEdnVzlONW5yWEtSelRoWjVWcUVUMUR6enZrQi9U?=
 =?utf-8?B?OG44NzIvbFJPK1IwVWx6NHNaUFltU0U3NmxPK0cxMlVVRlh3ckg0VVAwZ21J?=
 =?utf-8?B?Yk5yVzJmUWpIYzhRQ2QzdDdTRUhRRnFSY0wzcU1lNFJ2eVBSWC9OYnhLaW9J?=
 =?utf-8?B?OXdnY1BJYzErVHNJYlJCa0VNamJVRGNVdlZlMUdwM1JvdUhKdUw3R1FvVjds?=
 =?utf-8?B?Rzl0V0RkR0FQZmsvVjk4MjdyM1d4NmZVOXhqSXg5S3BybUh5aVBVNkRPTEhT?=
 =?utf-8?B?TGdBa1NxamFMK0o5ZE00eTlzUVovcGwvcFY1RXc0aHJGMVQ4OWpQL1lFeE8r?=
 =?utf-8?B?SW0rTDVMOFNuY2Z0NVhSNkk5Q2dKZHA3ZzNpUTVTczBUYnZvSm9temRnODhM?=
 =?utf-8?B?ZW1zdDhFWkV5YjFzd0FZRDFjQTNKaDRtVERFUnAzVUtpc1RrNFI2NHlMQmlw?=
 =?utf-8?B?ZmNQR3RXZ2h2UGkyRERESVhBbjd0WEVFOVJXUWNSb1J5MkhsM1hxamY4L2lP?=
 =?utf-8?B?TW1qSDFUQnZsZUc1RzFJcnlhMlErVVFDUHZPNFNJR1JFRjgxMVRadzhwaWhJ?=
 =?utf-8?B?TUVuYmpQTis2bE1RUzI1cHpjcStOMk1SVzhBV0FTL05DUEgwVzAzRWVxS1RV?=
 =?utf-8?B?WGZlYkYxVy85Rnh0alkxdGpIUWNrbUszRXpycDcwZXJ1ZkM4SmxzZVppVnIv?=
 =?utf-8?B?dUFsRlBZSmtmNnBhRU53Sk5nUTh0Y01iVjZYZG00eXhyVnpTUzlPeEJmZGxR?=
 =?utf-8?B?Q28rOGg5ajg3aWJsVHNXRlh6NjJGNW0ybXkydzJrZFg1SGpXd21kRGFxRXY4?=
 =?utf-8?B?d1hCRHVwYXV1YlltUkhGcWptWmZ3cWErRWN4dUFyNTJEMkI0NHFsaXA2Tzdp?=
 =?utf-8?B?WXltY1FMaSt4eHlETWtvUUFDK2FKQ2hSWHExZVA3OXgwcFVRanV6VHZpTVpX?=
 =?utf-8?B?bTdvbWFwdEhEa0VvN0lDQnhwdlF4cjBzZDVKTEZRcHVyWDJYK04yMFM1THBu?=
 =?utf-8?B?MlRhbXdjYlVxcml2NTFJdDc5YlFUY1VpVktoQmFaSmNpSkNRVGpFcUIrTVI5?=
 =?utf-8?B?NkRhWEJaOW1PR3RNSUFCK0R2K1l2TGlTSFQ0dERWa25wK3VzSkxUZWJJVGNs?=
 =?utf-8?B?R0JOd0gvb2xGeDJYNGg3bTlHemhqZHgyM3FSSWJEaXZnTjh6eGdtT1RpVUdy?=
 =?utf-8?B?T2x1ajI5VkdtNEw4RHUxQUdDeFY5WUllMjJuZTRqZmsvRUlkRDd4cTJGU00r?=
 =?utf-8?B?cVpoTUFKaFZET2dxemhxN2dESDEvdXRzNFBNc2VxTlpaZDNlamh2b1NTQnpk?=
 =?utf-8?B?NDJhTzkzaGhkVko5TmVNZXArMTBWbDhWL2NlQ0hkRVhiV3dhTjBKWWFIM3di?=
 =?utf-8?B?bWxaNXZFSjZFOElUbUE2bVlBeHpLUy9xU1BCVG5vMUJpbWdtdUh6STRkVW9V?=
 =?utf-8?B?bkZaVXhQRDRDUXZUNkhuWWppYlN4UDliZUNsdHhpUVVEUHpZM2hLWVNwSmZm?=
 =?utf-8?B?VFpCMWJ4WXBsUkhXM1dFVzZDNmpCY0hKYzNBOTFESXQvZTBNYmpFZmZpL0lU?=
 =?utf-8?B?R3JYU1RKR0Z6TXRvOGlFbHI0NWhHTkxLTDZFdEdYQnJXMW5YZ1dxanNnWFJQ?=
 =?utf-8?B?M1k5cWxBT0hveE9NeVZrd2pyVXZQSEUweVZLeG1WUVJmMzhqRURCbVRMM0Ux?=
 =?utf-8?B?UjBaaW9ncksvMndiTjUwT3ZhZFA0OVc0Q3JKcVpqSEpzc3ZNNklFUHBGQlg4?=
 =?utf-8?B?cDFYNG00TW1KcktJd01QWWJ5NFFqUGV4SjZvTHp4S0dlVFkxMWd6bitRallM?=
 =?utf-8?Q?jJMI63EyqotVglAqxTeylAaT0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9888e7a4-a87a-4992-3d63-08dce8a24537
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 20:38:02.4925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iUd70AK6m+7RJOR21FOXBY78VGIMs1JWLvWguPktT826ojsXysX43Nd9ChFxUPgN3H3rP9E9wfNKYOsbOr5Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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

On 2024-10-09 14:08, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
> it is created not need to increaes its kref. Instad add kfd process kref at kfd
> process mmu notifier allocation since we decrease the ref at free_notifier of
> mmu_notifier_ops, so pair them.

That's not correct. kfd_create_process returns a struct kfd_process * 
reference. That gets stored by the caller in filep->private_data. That 
requires incrementing the reference count. You can have multiple 
references to the same struct kfd_process if user mode opens /dev/kfd 
multiple times. The reference is released in kfd_release. Your change 
breaks that use case.

The reference released in kfd_process_free_notifier is only one per 
process and it's the reference created by kref_init.

Regards,
   Felix


>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..7c5471d7d743 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
> -	if (!IS_ERR(process))
> -		kref_get(&process->ref);
>   	mutex_unlock(&kfd_processes_mutex);
>   	mmput(thread->mm);
>   
> @@ -1191,7 +1189,11 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>   
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   
> -	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
> +	if (p) {
> +		kref_get(&p->ref);
> +		return &p->mmu_notifier;
> +	}
> +	return ERR_PTR(-ESRCH);
>   }
>   
>   static void kfd_process_free_notifier(struct mmu_notifier *mn)
