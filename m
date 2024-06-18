Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070CAC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 19:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601BC10E782;
	Tue, 18 Jun 2024 19:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIqVCr/n";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349B010E778
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 19:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jghQkikg+/QFfxtJLhwo5qjn0wfaX/Eq5t6GjJ41D3Y9LGNGvoo4+n4Y0afdV//Jr1dvxWFE1QtWgHSHmXH/CW9UOdGF6dzNSdt7Rdisk04AILKyylIJKneCSGjPEMARlVp2zeyciypxZf9GEUolNIc3iALMCSC3rb5pRKOSRhkg3NKTMILMpEEcXQPUXa3b9qgrG74YISwwMbuC9dkUbYHkrviqU9lSk5T/PmuWmkhbnkc8ZQEwDkYXMimGr0JpH3ZlgJW0ToSKxYutNWSlEJFz5OllI+kpPZK4zhqjCkUOfc9oQ8ApslQJ+bj/8hXJvLZj/r3qsQBejFQEqANPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaKjqm2NSFuhpgyGmavGx3H2M7dGZ1ihYoF03lCUUVw=;
 b=AmY1VjJ4yKKtifRqqMSuhCs3IYr/+fHTdtduFbRRWWr2zMdaUvGN/AYR0LS6Fj2k6TuWrydNRyXIj/3zD3NmRArNS8tM1PgEKuLb/qWpQw7KcVk7FDEG7yjrk3rgfacgdrfGO7z7zEaJXC0H1cJYyw8E161saF7tJTPpGCQDV+YI0HrRrte3x4FznTUB9DCXSw8W+tSIfH99/3Yu09hVcZsWBCB8MRMtgz3n2d33EU9ptTHfpuZxP3iiNOK70smtNPF5wXI7+0iuinmhjYEHxKQsP4y2280gCUo6og4VO+Qm/7kgKKRjDC9ZaPth3xyYc/SUr99W2ybRWX+KGq4yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaKjqm2NSFuhpgyGmavGx3H2M7dGZ1ihYoF03lCUUVw=;
 b=TIqVCr/n23tmSzP1wNPh5C7obe5r5fZVnqjBwn+6TKKg45oNXM+JRNY55TszaparZCr+/ZT2y3UqaKnLv9vyBc3oddUC/e0VNxjJmkdDaU8FxrkgmTYc6h8GrUtuLmcqa4u47lJ/JqKMFyXEwN81omWLkynfKK1dgmTci1pDeGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:30:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:30:29 +0000
Message-ID: <2dcb306b-17a8-439f-8474-762ad4fd1c4b@amd.com>
Date: Tue, 18 Jun 2024 15:30:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Update mm interval notifier tree without
 acquiring mm's mmap lock
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20240612201101.225674-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240612201101.225674-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0182.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: ea60a7ab-bbd4-48ed-7fe6-08dc8fcd1c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGs3WHpmdHl3eUd0QnlQRjBqc01qMm4wWUwza1o3OHFhZFhyNGxUT3JDZm53?=
 =?utf-8?B?Yk92bnh1akNzbXZRT3FNQS9Ta2IvNkxzMHMxRDlycysvclBaTmFMRUxXSDhL?=
 =?utf-8?B?N1B6dUN6c25tYnhXR2xncDhhVUhwVXcxZDlVa1RjV2hiMG5iMlR2WVpBOTJX?=
 =?utf-8?B?RVdTbEpEalhvY0tCZkVsaUJiTFZpN3JpWXNjbEs0U3lVa05heit6clNzL0RO?=
 =?utf-8?B?Vms4NjBBRVRQcVliQ2V1VEN4YU5zb2pIZy9qbkl0TGY5MGRBK2luREx0Y2RY?=
 =?utf-8?B?eXBrWW9NMmlXRmY0SklnRzg2ZnVLWnB2cmRqaDFFMktYWitTUzV5RVoxazBp?=
 =?utf-8?B?dVRic09vZTcvSUJLU2VMTm5hd1YzaDY5R2J4OWRCV2N6eGdhaEsyMGNncFVo?=
 =?utf-8?B?NDd0eGJjQ3JhcDQxU1VYbjRiMFVoc3B2djIyY29FWmdYcjJwaldCYjRiejE2?=
 =?utf-8?B?bVgreDZQd3JmVEpiWEs5dW13TGdTZ2hlNXhobVRTeEVjQi9pbFdwVTc3Wlpw?=
 =?utf-8?B?WDBNMXdGdDB1d0NLUXIrMm9RTGwrZ2paY3hRb3ljekRHRXVNOUpvQitYWmxy?=
 =?utf-8?B?OXRXNDZUcTdsZXZSNGdtWlYxYWt3NVBubTNORFpXZ3phOHpkWVNvd0dNWEdo?=
 =?utf-8?B?RlVxdDJnVXhHdG5GMnRvZ2VBckdzcWtQZmdYY2UzN2ltY3lsaFM3ZExHTGE2?=
 =?utf-8?B?NUZOVUhJc0IyY0RjZzIxc1RUVFNwTGJyVnFJOHVSeE13a2JLeVQ3NnBNcnFD?=
 =?utf-8?B?M3Z0czBMejM3TC81Wm9DdWIyZGlPd0V0SnVnZ0NkYUhTUEJDV2RZbWlDZEpy?=
 =?utf-8?B?UGpkVVpQOHNKcis0MUxCOVdJd0IwRXJRRWhOZHl1STVVZHo5dkpFWGd6ZnR1?=
 =?utf-8?B?MDdJY3R5Z2RidG1mdmlUd2JKVFdBV2lrLzAxakxtVjA5emNqb0gzbE9wSHNN?=
 =?utf-8?B?ZHhJS2dTM3lTdm9pZjBqeXd4d01hQ2tFbyt6VWEvUUQ1bFBCMlBqejdjYUFN?=
 =?utf-8?B?dEYvNUdqZVp0Q1E3UmxqZldzUUU4Z2dCQ2Q3cWhQZHc0WFlYN01ieXRDQkJ0?=
 =?utf-8?B?Y2FTRkQ3TzU5UkFTNnJmVEJQNEQ0R3N0cHNkbHFhd1JzcDNrbUY1TW5QSEtG?=
 =?utf-8?B?aGh3MFFMMk8zekxqZW9pNlhWM3NSUXVValR5eGRpb1ZaQzVPaytUYUtScDEv?=
 =?utf-8?B?Lzk3THlzSDloSndwaWdITUxTOEtGNVkwTy9PdmJSYk5sN0VESDhxQllLWGpl?=
 =?utf-8?B?QWxPeDU3VVRkRVJpdFpjcG0vZHVHSmpJaUR0SysrSHk3cVFTT1hIZVF6T2hP?=
 =?utf-8?B?R3dxTHRKV1BCdlVSOE9SbWxKUytXZXYxQzE2YWsvVy82c3ZlaXRoR1lsSG5r?=
 =?utf-8?B?NitCWWpTcm10L2MweTEzbTg4Q0cxZFlnWmNxZ1NGV3lKYkl5WjI5YUJ3K0tV?=
 =?utf-8?B?N1pUdWVldTdpdExwWlpGZWkrYlFsSDFsT2tXelVuZzRKeWlZVmtvSXRzNDhm?=
 =?utf-8?B?L2lVNUxxQmxIaXAwSDVJOUtyQk9jdk9jWURYTzFsYVJ5eUhvSCtoRWZYenlT?=
 =?utf-8?B?cWlqcXRNVkN4M2JHek04MlhGemxwZ0ZwbHlwNHRoVGNiZjMyKzgyYlRvQmN6?=
 =?utf-8?B?UVJIajFzd3Rvc1hHK3ZTUlFkSFVQTWE1MlhTQ1V0K1RPS3YzQk1aVGN0dGU2?=
 =?utf-8?B?d3QwOHRaemRyWDlmWEd1VndCNkk4UG1uWTBEY1NuaGtRc2xLR1cvSE9VVDBD?=
 =?utf-8?Q?8xZKT4pWSw9bxh16goygnZ2Vs1frhW6My7tkmLi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFub0pUUk4xeVhZZnlGdUs3T1JUMTdYdWwwOXJQWmhwYnZ0WlgySmo0clRi?=
 =?utf-8?B?dTNWWXkzNE0yU1E3OUFjT1VoV3FtZzliZlRlY1oycmFIUXMzOEM1MkdWUENk?=
 =?utf-8?B?YVQrZldkeS9lU21DVGVma0xpVlNXN2dKN0RwM0ROa3hBSDZPSFdpc0srZ0dr?=
 =?utf-8?B?bENLSlF3bFZaTW5RZWZTQ3pSY1BFSUNuTFhjM0xwMDYzMlJJZldRd1NwdEoz?=
 =?utf-8?B?dGt6Q1grTVhFaW0vVkpENVNPWXo0OWYzTWswcVJFOXMyc0ZEUFQ1S1BBNWxp?=
 =?utf-8?B?ZzdQOE5nYmZyZnl5TTBpWlFWTGErUHdZejBZVWpaZkVRbXVwczNrM3lQT0Q3?=
 =?utf-8?B?dUVOY0R1K3VDNXgxTnBWS1JlOGFRWnBDYlgzL1pGam1ET0VubmRGNUlHekNL?=
 =?utf-8?B?R09Ya3F5TC9vcHBxbU5qbW8yNGI4cVpsbmx3UHFIdlBYZEZ5dDVqOW9lQUw4?=
 =?utf-8?B?K3poZWErWWJqeEl5ZjFiYWIvZjBxYTdMa3lUTTdxSTc0MnUwdWk3d2pZMDhz?=
 =?utf-8?B?d2IwWXRzblJvblBkSTFBVkdyRlYxMEJBd3N1YTFKWlo0SDdSZlNoOElMQjJK?=
 =?utf-8?B?YWMwMk5jMVphS3JWN1pUOWJuQ2tYSEpnci9MV1RENEh5c2RDQm55WWdQL1JS?=
 =?utf-8?B?aE50Z012YjMyYjMwNFF4b1p1VElVU2dpZlpzN2hzQytPWXpCQjAzK1dpNjIr?=
 =?utf-8?B?UVBXZS9zVzFnZmVZUGRBdXBoRjhmelZDY2NicC9vRXB1RHYyL2NQZElEVmt5?=
 =?utf-8?B?c0NpaTNuZGxzNEEwZkpvUnQzRVRubmFnOTRodHF6VEVraUZhYUlhUUxiMGtp?=
 =?utf-8?B?QklVMmJ2eHl4OW14TndOY2ZQOGplaEdSSmx0L0tmNVR6bEZCTStINmd6cnFj?=
 =?utf-8?B?TS9QcmxhYXdOSmJDall3QzhOWmI2b3RSdlZmbU1DamZSQnFqQUIwM0w5dVFG?=
 =?utf-8?B?RDhhVllKSUcyeWhNcG0yWnVxczZSZHZ6M3ZyaFBTNFpvR000UHFrb3grQzFz?=
 =?utf-8?B?WUxVVFViVmp3WjBQd2crbFp5Y0pjTHFyMndXZ2U4Y0RRZ3JNY2haa1RsdEds?=
 =?utf-8?B?M3JTMWNBeWZBUW9CUEhuS3NraVUwQkVLd0pLQnR2dFg5cDBmcEJoQTQrQzFs?=
 =?utf-8?B?UHJWUjMxYkZhcjFybG9QLzF5andLT2ZMdjdPWDdYbHpFWjEvZDlBdlNaNFZD?=
 =?utf-8?B?TGJZYVRscS9SMDBGUEw2WmxxR29TK2hyNkM4b2hsUXE0V0FwcytpU0pQZS85?=
 =?utf-8?B?R2lMMll6V25EUDY5RWFVTVNLY0NqbnMyNkhERDV3VUo2bW9IQ0VCS3lMWE1u?=
 =?utf-8?B?dElIUXRGdUwrUjdnNDgySlo5U1lmdHN1ZHowTm9hZlg1SUgrNlNmUUpPZnRS?=
 =?utf-8?B?Tyt6bWQyYTFJTk0xaTBkUHVwU2pYSEpIWmsxSzdmeEhkVUlFS2xSemtTVkl1?=
 =?utf-8?B?akJFSjY1akk1MmZDMTNNd1NwbEZjelRqTVk0Q2QzMkVTcGg0YnZuSGlOeVZE?=
 =?utf-8?B?M2U4Vmx4K3IxaSt6UGN5UDVpTzN5aVlndCthWUliaHV1SlBiSUcvc1dZQTVE?=
 =?utf-8?B?RFFDMm5sNU5ZbERIRjBNN1gyUlhDeFRrR0UwYzFCTXNyNFEvZGh0T0FmNStn?=
 =?utf-8?B?b3l4eUo4T0hwazVtVHBhSjh2UDJSNTYxazZPYkFNTDV2ZG9LaFFPZER0K1dZ?=
 =?utf-8?B?SnpTbUUzUXBGZ0R6eUxSTGcxNHVQR3U0b25yampaWjBsSjhSS2MzVnZ0dndN?=
 =?utf-8?B?a0F0cmZETFdvY2drZWh4cHFYMjZQWC9aa0hILzBBeHd2bzROUVFrL295SHFa?=
 =?utf-8?B?L0ZOdWtBZCtxMHUwMzZNaklQWEFZSkxXcnRxTmxiTW10cE1mQ1RWdW8vWEZW?=
 =?utf-8?B?Y3dkYVdvb1ovYUVhaFltMEhuSGF1K25vRExMcjdubWF5MmNscTNSUlg1NjRY?=
 =?utf-8?B?VG9oTHVhSFFtdmY0N2x3SU5kMzZxOWRabEVtRHpOK0JpVmJla2NRZm1LeGJC?=
 =?utf-8?B?V0xzeVdIQnFqemRZT1E5MFBsSEV5T083ZDZaSFQ2dU1LVXNsSyswZjV0YWVG?=
 =?utf-8?B?dVFBUjRFVll2NUdxbHl2L3c2VkI1S0NOSnBpaDZrdCtRMGtTbVJmcFlXNWRo?=
 =?utf-8?Q?PYunS3wTiT0Bw6qE2RSSKK9oL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60a7ab-bbd4-48ed-7fe6-08dc8fcd1c91
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:30:29.1283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J8CcuFxUZ9ObOqaTtyT0+oF+tpDLu5D+5+2BpS28vOaTJ6MdRPRRcOafYoy2RXmmZYWT2pz/2i3nPDnbQ1wDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530
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


On 2024-06-12 16:11, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Current kfd/svm driver acquires mm's mmap write lock before update
> mm->notifier_subscriptions->itree. This tree is already protected
> by mm->notifier_subscriptions->lock at mmu notifier. Each process mm interval
> tree update from different components in kernel go to mmu interval notifier
> where they got serialized. This patch removes mmap write lock acquiring at
> kfd/svm driver when need updates process mm interval tree. It reduces chance
> of dead lock or warning from lockdev and simplifies the driver code.
>
> In addition, the patch adjusts some locks granularity to reduce the lock number
> that driver holds at same time which also reduces the chance of dead lock or
> warning from lockdev.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 181 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   2 +-
>   4 files changed, 122 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index fdf171ad4a3c..b52588ded567 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1078,9 +1078,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   	/* Flush pending deferred work to avoid racing with deferred actions
>   	 * from previous memory map changes (e.g. munmap).
>   	 */
> -	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
> +	svm_range_list_flush_work(&p->svms);
>   	mutex_lock(&p->svms.lock);
> -	mmap_write_unlock(current->mm);
>   	if (interval_tree_iter_first(&p->svms.objects,
>   				     args->va_addr >> PAGE_SHIFT,
>   				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8ee3d07ffbdf..eb46643d96b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -969,10 +969,12 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   	mutex_lock(&p->svms.lock);
>   
>   	prange = svm_range_from_addr(&p->svms, addr, NULL);
> +
> +	mutex_unlock(&p->svms.lock);

You must continue to hold the svms.lock here. As soon as you drop the 
lock, the prange can be freed or changed, so cannot keep using this 
pointer without holding the lock.


>   	if (!prange) {
>   		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
>   		r = -EFAULT;
> -		goto out_unlock_svms;
> +		goto out_unref_process;
>   	}
>   
>   	mutex_lock(&prange->migrate_mutex);
> @@ -993,8 +995,6 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   
>   out_unlock_prange:
>   	mutex_unlock(&prange->migrate_mutex);
> -out_unlock_svms:
> -	mutex_unlock(&p->svms.lock);
>   out_unref_process:
>   	pr_debug("CPU fault svms 0x%p address 0x%lx done\n", &p->svms, addr);
>   	kfd_unref_process(p);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 407636a68814..46f81c1215d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -106,12 +106,31 @@ static void svm_range_unlink(struct svm_range *prange)
>   }
>   
>   static void
> -svm_range_add_notifier_locked(struct mm_struct *mm, struct svm_range *prange)
> +svm_range_add_notifier(struct mm_struct *mm, struct svm_range *prange, bool locked)
>   {
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
>   		 prange, prange->start, prange->last);
>   
> -	mmu_interval_notifier_insert_locked(&prange->notifier, mm,
> +	/* mm->notifier_subscriptions should have been setup for this process
> +	 * ex: during kfd process creation
> +	 */
> +	WARN_ON_ONCE(!mm->notifier_subscriptions);
> +
> +	/* not necessary hold mmap lock to update mm interval notifier tree as
> +	 * opeations on mm->notifier_subscriptions->itree are serialized by
> +	 * mm->notifier_subscriptions->lock
> +	 */
> +	if (locked) {
> +		/* if mmap write lock has been hold use lock version to udpate
> +		 * mm interval notifier tree
> +		 */
> +		mmu_interval_notifier_insert_locked(&prange->notifier, mm,
> +			   prange->start << PAGE_SHIFT,
> +			   prange->npages << PAGE_SHIFT,
> +			   &svm_range_mn_ops);
> +	} else
> +		/* use no-mmap-lock version to update mm interval notifier tree */
> +		mmu_interval_notifier_insert(&prange->notifier, mm,
>   				     prange->start << PAGE_SHIFT,
>   				     prange->npages << PAGE_SHIFT,
>   				     &svm_range_mn_ops);
> @@ -895,6 +914,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
>   	*vram_pages = 0;
>   	for (i = 0; i < num_elements; i++) {
>   		dma_addr_t *temp;
> +
>   		temp = (dma_addr_t *)dst + i;
>   		*temp = *((dma_addr_t *)src + i);
>   		if (*temp&SVM_RANGE_VRAM_DOMAIN)
> @@ -1500,7 +1520,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
>   	uint32_t gpuidx;
>   	int r;
>   
> -	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
> +	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
>   	drm_exec_until_all_locked(&ctx->exec) {
>   		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
>   			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
> @@ -1751,25 +1771,20 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   }
>   
>   /**
> - * svm_range_list_lock_and_flush_work - flush pending deferred work
> + * svm_range_list_flush_work - flush pending deferred work
>    *
>    * @svms: the svm range list
>    * @mm: the mm structure
> - *
> - * Context: Returns with mmap write lock held, pending deferred work flushed
> - *
>    */
>   void
> -svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
> -				   struct mm_struct *mm)
> +svm_range_list_flush_work(struct svm_range_list *svms)

Deferred work is associated with child pranges. In svm_range_set_attr we 
need a guarantee that the ranges we're splitting don't have child 
ranges. That's why we need to prevent new deferred work from coming in.

The purpose of this svm_range_lock_and_flush_work was go flush pending 
work and return with a lock held that guarantees that no new deferred 
work (and child ranges) would be added as long as that lock was held. If 
the mmap write lock no longer performs that function, you need to 
replace it with a different lock that has the same function.


>   {
>   retry_flush_work:
>   	flush_work(&svms->deferred_list_work);
> -	mmap_write_lock(mm);
>   
>   	if (list_empty(&svms->deferred_range_list))
>   		return;
> -	mmap_write_unlock(mm);
> +
>   	pr_debug("retry flush\n");
>   	goto retry_flush_work;
>   }
> @@ -1804,7 +1819,11 @@ static void svm_range_restore_work(struct work_struct *work)
>   	}
>   
>   	mutex_lock(&process_info->lock);
> -	svm_range_list_lock_and_flush_work(svms, mm);
> +
> +	svm_range_list_flush_work(svms);
> +
> +	mmap_read_lock(mm);
> +
>   	mutex_lock(&svms->lock);
>   
>   	evicted_ranges = atomic_read(&svms->evicted_ranges);
> @@ -1854,8 +1873,9 @@ static void svm_range_restore_work(struct work_struct *work)
>   	pr_debug("restore svm ranges successfully\n");
>   
>   out_reschedule:
> +
>   	mutex_unlock(&svms->lock);
> -	mmap_write_unlock(mm);
> +	mmap_read_unlock(mm);
>   	mutex_unlock(&process_info->lock);
>   
>   	/* If validation failed, reschedule another attempt */
> @@ -2186,8 +2206,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   }
>   
>   static void
> -svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
> -					    struct svm_range *prange)
> +svm_range_update_notifier_and_interval_tree(struct svm_range_list *svms,
> +					struct mm_struct *mm, struct svm_range *prange)
>   {
>   	unsigned long start;
>   	unsigned long last;
> @@ -2203,14 +2223,28 @@ svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
>   		  prange->last);
>   
>   	if (start != 0 && last != 0) {
> +
> +		mutex_lock(&svms->lock);
> +		mutex_lock(&prange->lock);
>   		interval_tree_remove(&prange->it_node, &prange->svms->objects);
> +		mutex_unlock(&prange->lock);
> +		mutex_unlock(&svms->lock);
> +
>   		svm_range_remove_notifier(prange);
>   	}
> +
> +	mutex_lock(&prange->lock);
>   	prange->it_node.start = prange->start;
>   	prange->it_node.last = prange->last;
> +	mutex_unlock(&prange->lock);
>   
> +	mutex_lock(&svms->lock);
> +	mutex_lock(&prange->lock);
>   	interval_tree_insert(&prange->it_node, &prange->svms->objects);
> -	svm_range_add_notifier_locked(mm, prange);
> +	mutex_unlock(&prange->lock);
> +	mutex_unlock(&svms->lock);
> +
> +	svm_range_add_notifier(mm, prange, true);
>   }
>   
>   static void
> @@ -2225,32 +2259,51 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
>   	case SVM_OP_UNMAP_RANGE:
>   		pr_debug("remove 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>   			 svms, prange, prange->start, prange->last);
> +
> +		mutex_lock(&svms->lock);
> +		svm_range_lock(prange);
>   		svm_range_unlink(prange);
> +		svm_range_unlock(prange);
> +		mutex_unlock(&svms->lock);
> +
>   		svm_range_remove_notifier(prange);
>   		svm_range_free(prange, true);
>   		break;
>   	case SVM_OP_UPDATE_RANGE_NOTIFIER:
>   		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>   			 svms, prange, prange->start, prange->last);
> -		svm_range_update_notifier_and_interval_tree(mm, prange);
> +		svm_range_update_notifier_and_interval_tree(svms, mm, prange);
>   		break;
>   	case SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP:
>   		pr_debug("update and map 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>   			 svms, prange, prange->start, prange->last);
> -		svm_range_update_notifier_and_interval_tree(mm, prange);
> +		svm_range_update_notifier_and_interval_tree(svms, mm, prange);
> +
>   		/* TODO: implement deferred validation and mapping */
>   		break;
>   	case SVM_OP_ADD_RANGE:
>   		pr_debug("add 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms, prange,
>   			 prange->start, prange->last);
> +
> +		mutex_lock(&svms->lock);
> +		mutex_lock(&prange->lock);

You should always use svm_range_lock/unlock for locking prange->lock.


>   		svm_range_add_to_svms(prange);
> -		svm_range_add_notifier_locked(mm, prange);
> +		mutex_unlock(&prange->lock);
> +		mutex_unlock(&svms->lock);
> +
> +		svm_range_add_notifier(mm, prange, true);
>   		break;
>   	case SVM_OP_ADD_RANGE_AND_MAP:
>   		pr_debug("add and map 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms,
>   			 prange, prange->start, prange->last);
> +
> +		mutex_lock(&svms->lock);
> +		mutex_lock(&prange->lock);

Same as above.


>   		svm_range_add_to_svms(prange);
> -		svm_range_add_notifier_locked(mm, prange);
> +		mutex_unlock(&prange->lock);
> +		mutex_unlock(&svms->lock);
> +
> +		svm_range_add_notifier(mm, prange, true);
>   		/* TODO: implement deferred validation and mapping */
>   		break;
>   	default:
> @@ -2316,6 +2369,12 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   
>   		mm = prange->work_item.mm;
>   retry:
> +		/* use mmap write lock to prevent unmap_from_cpu for same process
> +		 * happening at same time to prevent race conditions between
> +		 * svm_range_deferred_list_work and unmap_from_cpu, ex:
> +		 * work_item.op of prange may be changed by unmap_from_cpu
> +		 * during svm_range_deferred_list_work
> +		 */
>   		mmap_write_lock(mm);
>   
>   		/* Checking for the need to drain retry faults must be inside
> @@ -2327,20 +2386,11 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   			goto retry;
>   		}
>   
> -		/* Remove from deferred_list must be inside mmap write lock, for
> -		 * two race cases:
> -		 * 1. unmap_from_cpu may change work_item.op and add the range
> -		 *    to deferred_list again, cause use after free bug.
> -		 * 2. svm_range_list_lock_and_flush_work may hold mmap write
> -		 *    lock and continue because deferred_list is empty, but
> -		 *    deferred_list work is actually waiting for mmap lock.
> -		 */
>   		spin_lock(&svms->deferred_list_lock);
>   		list_del_init(&prange->deferred_list);
>   		spin_unlock(&svms->deferred_list_lock);
>   
> -		mutex_lock(&svms->lock);
> -		mutex_lock(&prange->migrate_mutex);
> +		svm_range_lock(prange);
>   		while (!list_empty(&prange->child_list)) {
>   			struct svm_range *pchild;
>   
> @@ -2349,12 +2399,15 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   			pr_debug("child prange 0x%p op %d\n", pchild,
>   				 pchild->work_item.op);
>   			list_del_init(&pchild->child_list);
> +			svm_range_unlock(prange);
> +
>   			svm_range_handle_list_op(svms, pchild, mm);
> +			svm_range_lock(prange);
>   		}
> -		mutex_unlock(&prange->migrate_mutex);
> +		svm_range_unlock(prange);
>   
>   		svm_range_handle_list_op(svms, prange, mm);
> -		mutex_unlock(&svms->lock);
> +
>   		mmap_write_unlock(mm);
>   
>   		/* Pairs with mmget in svm_range_add_list_work. If dropping the
> @@ -2814,7 +2867,7 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
>   		prange->preferred_loc = KFD_IOCTL_SVM_LOCATION_SYSMEM;
>   
>   	svm_range_add_to_svms(prange);
> -	svm_range_add_notifier_locked(mm, prange);
> +	svm_range_add_notifier(mm, prange, false);
>   
>   	return prange;
>   }
> @@ -2911,7 +2964,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	struct kfd_node *node;
>   	int32_t best_loc;
>   	int32_t gpuidx = MAX_GPU_INSTANCE;
> -	bool write_locked = false;
>   	struct vm_area_struct *vma;
>   	bool migration = false;
>   	int r = 0;
> @@ -2959,35 +3011,26 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		r = -EFAULT;
>   		goto out;
>   	}
> -	mmap_read_lock(mm);
> -retry_write_locked:
> +
>   	mutex_lock(&svms->lock);
>   	prange = svm_range_from_addr(svms, addr, NULL);
> +	mutex_unlock(&svms->lock);

Similar to above, prange can be freed the moment you unlock svms->lock. 
If you want to keep using the prange, you need to keep holding the lock.

Regards,
   Felix


>   	if (!prange) {
>   		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
>   			 svms, addr);
> -		if (!write_locked) {
> -			/* Need the write lock to create new range with MMU notifier.
> -			 * Also flush pending deferred work to make sure the interval
> -			 * tree is up to date before we add a new range
> -			 */
> -			mutex_unlock(&svms->lock);
> -			mmap_read_unlock(mm);
> -			mmap_write_lock(mm);
> -			write_locked = true;
> -			goto retry_write_locked;
> -		}
> +		/* not need to hold mmap write lock before create new range in
> +		 * mm interval notifier tree, mm has its own lock to protect it
> +		 */
>   		prange = svm_range_create_unregistered_range(node, p, mm, addr);
>   		if (!prange) {
>   			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
>   				 svms, addr);
> -			mmap_write_downgrade(mm);
>   			r = -EFAULT;
>   			goto out_unlock_svms;
>   		}
>   	}
> -	if (write_locked)
> -		mmap_write_downgrade(mm);
> +
> +	mmap_read_lock(mm);
>   
>   	mutex_lock(&prange->migrate_mutex);
>   
> @@ -3082,10 +3125,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   out_unlock_range:
>   	mutex_unlock(&prange->migrate_mutex);
> -out_unlock_svms:
> -	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
> -
> +out_unlock_svms:
>   	svm_range_count_fault(node, p, gpuidx);
>   
>   	mmput(mm);
> @@ -3192,6 +3233,7 @@ int svm_range_list_init(struct kfd_process *p)
>   {
>   	struct svm_range_list *svms = &p->svms;
>   	int i;
> +	int ret;
>   
>   	svms->objects = RB_ROOT_CACHED;
>   	mutex_init(&svms->lock);
> @@ -3208,6 +3250,14 @@ int svm_range_list_init(struct kfd_process *p)
>   		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>   			bitmap_set(svms->bitmap_supported, i, 1);
>   
> +	 /* signals the notifier is being registered for itree mode
> +	  * it does not register new mmu_notifier or increae mm->mm_count,
> +	  * so not need call mmu_notifier_unregister at svm_range_list_fini
> +	  */
> +	ret = mmu_notifier_register(NULL, p->mm);
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>   
> @@ -3553,29 +3603,27 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	mutex_lock(&process_info->lock);
>   
> -	svm_range_list_lock_and_flush_work(svms, mm);
> +	svm_range_list_flush_work(svms);
>   
>   	r = svm_range_is_valid(p, start, size);
>   	if (r) {
>   		pr_debug("invalid range r=%d\n", r);
> -		mmap_write_unlock(mm);
>   		goto out;
>   	}
>   
> -	mutex_lock(&svms->lock);
> -
>   	/* Add new range and split existing ranges as needed */
>   	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
>   			  &insert_list, &remove_list, &remap_list);
> -	if (r) {
> -		mutex_unlock(&svms->lock);
> -		mmap_write_unlock(mm);
> +	if (r)
>   		goto out;
> -	}
> +
>   	/* Apply changes as a transaction */
>   	list_for_each_entry_safe(prange, next, &insert_list, list) {
> +		mutex_lock(&svms->lock);
>   		svm_range_add_to_svms(prange);
> -		svm_range_add_notifier_locked(mm, prange);
> +		mutex_unlock(&svms->lock);
> +
> +		svm_range_add_notifier(mm, prange, false);
>   	}
>   	list_for_each_entry(prange, &update_list, update_list) {
>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
> @@ -3585,12 +3633,17 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>   			 prange->svms, prange, prange->start,
>   			 prange->last);
> +
> +		mutex_lock(&svms->lock);
>   		svm_range_unlink(prange);
> +		mutex_unlock(&svms->lock);
> +
>   		svm_range_remove_notifier(prange);
>   		svm_range_free(prange, false);
>   	}
>   
> -	mmap_write_downgrade(mm);
> +	mmap_read_lock(mm);
> +
>   	/* Trigger migrations and revalidate and map to GPUs as needed. If
>   	 * this fails we may be left with partially completed actions. There
>   	 * is no clean way of rolling back to the previous state in such a
> @@ -3646,8 +3699,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	dynamic_svm_range_dump(svms);
>   
> -	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
> +
>   out:
>   	mutex_unlock(&process_info->lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 70c1776611c4..f7cee69ff191 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -195,7 +195,7 @@ int kfd_criu_restore_svm(struct kfd_process *p,
>   int kfd_criu_resume_svm(struct kfd_process *p);
>   struct kfd_process_device *
>   svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
> -void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
> +void svm_range_list_flush_work(struct svm_range_list *svms);
>   
>   /* SVM API and HMM page migration work together, device memory type
>    * is initialized to not 0 when page migration register device memory.
