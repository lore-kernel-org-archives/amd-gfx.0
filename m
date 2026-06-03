Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B104CD6E69
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 17:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3EB1121E4;
	Wed,  3 Jun 2026 17:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KqC0s9r6";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6AB1121E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 17:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMjw8cHf0uJjaYmrIo1SeDwJkQrxdrJkN/wB3WKTzZ/7oCLs0vb2kgPBFNbbkRYNUACMdHx+D1gAK6lqWKKbepl5enU5D18VZt1QM+fJeI6fvR8OBjTZ0xGuHool5sOyGMNVvekDL36FKc6s7H3rBq1NETN/G8djQ8baLRmoeOHDUS4VH73X4iSXihFog13hJliszLAU94oc3+i+h0g2jN2RouP6NDSy9lN7Hrh0ScMASOfUzdR8eLLUnn2aXb8jn5TUE8d00BZQexMs5MOIKjiEikmQfmZcM20p65kgt66++xlMPeupSUX9nf8Rvc71EudVTZQAc8HkDQTpvV8a/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzmGMQC1gaUHigxbeISOQTx/5D6zi2QbTkH9BMI8uq8=;
 b=GibvqBFnNu3EDEwAeWzQGgn89Q6rKG/W6gJYiQb3akuJz4/HqxleGT2M8uPwpJwsN2PK1MgVZFEckVreedqI/2mtjcU6JdYmxAsdOpxAa1cFbbOvwulXdyfR+yY8SXEao4yJ8UTV5GqfCZK+fF106U6BqiErrom7o56TosWM8o/K/ZGGCBZseb1s6bispEhUF1ym9+JIyPZQqZ70pJtMsOjbo66hB4+tLXT2wGjg1cXcrITyBMDDrdxdImJvr1+Y6/R4JCCJ6wKlQocpb4n8xTziTUQyfN9SkeeLX5G64OfWR/fnviGTHisXQdsdOIe5DM2D7FXkIdwN2Y+kC99Dag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzmGMQC1gaUHigxbeISOQTx/5D6zi2QbTkH9BMI8uq8=;
 b=KqC0s9r6zVd9wR2FXT9JNYn/0WeMYMkM3wqBwMaIvxpN8ravWIxTEYfVh2h1ECFKnSUe7Aut4HOyLVFWkuVNhmpNNX3Lr44l+k79z0rWLPQeg/Q+CYWTx8NegSed06gsAPSh05TIVFerm4LmZouFm2mAto3coyGAmLxdUUt7oqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 17:54:52 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 17:54:52 +0000
Message-ID: <4644fc6d-81cb-48d0-b899-a9a4ec4caf46@amd.com>
Date: Wed, 3 Jun 2026 13:54:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260529114031.3714-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::29) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6d997e-a51a-4fba-2d07-08dec1993652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|3023799007|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9fvZpf22mM67OA+7rdBS73Mdna6Bn/5Y3kXkxHtx1TbN9HGyhGhkZAlao3ndJvJvxVp9O8n2HkQyDuXLFhTJ7cB1TBZv7/h8mIdctVA9q+pxIiPJLafOYdEOcUmVaTH6oNFJ+BnYKk08+JMTJRxryMdTdyFfDNu8pxgLShsl3YXHe+4Xi8bUMnukyxtOAX5RAj82amAHsJhLb0iBN24NOokPYeXo/FDkO2YM4VVV54QGKA0W/17wGDAd/DP8hswv12t/PeWp6aMTrayvjnrwTtBl19qOaNfyHgOBIehbdSz5cjyFV8g+Sbk/fhETTEoAbiL/tRr0nZB/qXacb+9oJ093E5Vzf2ruEJ2GCj+Okabxis9MT20WSF9C5CRsOmy+eh8bO28dMbwyrzuCfxsOkmIEqLOdwv80Bt0or3Ac71tWQWVOI0L9g5XBCgBytv6R2xDYdSsQMIi7LFJQQBXIZZjb0FKdLnIcw6Q127O77Zv0Q9Ev+9gUu7M38dDZOMN7Ryih5yufPFr88k+wuKuTtzK7vJQzg+2xFV7a+OJpdIeD1y6eS0LvjcHUEK0FTKGBKHrgZ6rg0UK0/NMxdAg9icW6ICuzp1/FPEUJmskNU4uhGBDdHh44CKkoLyGltxL1fx/wZ8utKgyK3YJij/tPboQ+uBPMj1XDPniCiGpWSFks1ha/W20FwmwMNRq0tOwd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(3023799007)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJidDNPeVR2dzk3KzZONFRHbnJQWDlkMmRQY2pmaEppSDgzNlBwRHlINzBT?=
 =?utf-8?B?bnhLV2R0bFlSaDUzU1JrdGozUmlTOEJ6NTZwakpQREVhRHFFRW1BajlOemxv?=
 =?utf-8?B?ZWJ6cERZUXROdmRIekRaZVhUR2o0eU5HVWhocW9xeXJiYzFFd2N0UFIzenhZ?=
 =?utf-8?B?cGVEUVAwRXJDZjl5TVNqRnZWRDFyMVRMaWQ2MU5NR3pRUzZPcUkrNno5ZGh4?=
 =?utf-8?B?OHVqWmIzWUVBRDVlK3FmdGVGY0J5d1FJMFBnWEQ2Q3JMZDcrTXViUCtIaVJH?=
 =?utf-8?B?M3JQOVRQRm9DcUZBOU1keTRmSk5lM2NXNkFEM0pORWpjT3JQS3NqWXZqWWd3?=
 =?utf-8?B?RWx6Sm1BQ1JrQXB3MHVXeDNJQUdpMW55eFJpRmVlT0lQam5oZFg1WC91d3lJ?=
 =?utf-8?B?a1krb0w0V01FdEt1dnJ4cytUN1lZU0lWNGxOa1p5N0RLb1VmNkpKRTRIWXA4?=
 =?utf-8?B?bklqVFJ5UTFKUW10L29LUTdoNnhrMCtYTmJYTTR0VVg3VWhPem5vOUExRzlS?=
 =?utf-8?B?Mnl3TkhSaHdrUDQ2QXBQVnBjd2tZNmVDRWVpNHpYZjkwREVtdytvZHMxS3Zs?=
 =?utf-8?B?Qnd1UEJaQW9OdmdTVTZSZEhIbm9NZUVmOFA3aHdzM1l1SnF3eC9MUk9obXVm?=
 =?utf-8?B?dkFWaXhPWUh4SHBTMzFPZk9vYkpOckZTQlJURFFoT1NtYWR6UGdGalg1blgx?=
 =?utf-8?B?Y0hOa2dpWVdoZXc4RXg5NXJYMHg1aXNPbkt6M3hheDdRZGUrNHhFL1NPM1Zu?=
 =?utf-8?B?Ny8xdnkxZG81RE9TUytSTk1WYzlwK0JKM0RLSGhyT2Q2cGNkTW1uOHpOLzlT?=
 =?utf-8?B?NEY2ZUxBdDJKbUhaRlI2WURZVFFLRzc5cWt3QlpQOUxnalF3cS9XVFdWVGtn?=
 =?utf-8?B?NStYUkNxdUdrdlkyWkhFM1lUOTQreXg2S1hSTWxDL3hOekxMMlQrbVY4UTBI?=
 =?utf-8?B?d1NBRG5hckh2ZzF2SmVmaGxrbVpyNU9VcGorMndvQzYvV1BMd1VGUWpBNzdU?=
 =?utf-8?B?TFg1TlQ4T2E2ZXZkNXZ5VXpqOEpla2k1bFhoWGNrWWVTMW9uZHJ5ZVFZdktv?=
 =?utf-8?B?SHdWeWNXNVlsZUxlLzNVUTR2T2RJWHNiK21FczhsUjVrS2M1ZUltOUtRbU5U?=
 =?utf-8?B?TDl2d2prdWRRbTc1NDhJSkRRYXB4N1VCQUUxUXBKREh2R0hpMitnOWlieEFa?=
 =?utf-8?B?TWl2K0czMWNxZ2dFTjcrZFZZZFc5WDJWQVVqUTQwamw5SmViKzBXYzJRc1Iy?=
 =?utf-8?B?QXM0bWs5Wk5XMWphUERFWVZuQUdYK0xMQXZCTWphRFFMZGhhODA3djVoMWw1?=
 =?utf-8?B?RE5ZTTVYV00vbkRuZGhMVkMzdURmQm1ITkxKM1l4alF2NEV1Z0ZHS3pHSGFM?=
 =?utf-8?B?QllGTFZNS3NtcHFMSmpwQTJqWnB3eXYyaVFQZ0FzK0RuNks3NHVLWk95bW91?=
 =?utf-8?B?ZGFnYy9Md05DRFlFV0lOeFJWdTloc1NRaEJmaXgzQzgxYlhKWU40d3dwWXdU?=
 =?utf-8?B?YnJRRXdzVVVoWUlvYm5veTRUcktZdDcxNmdqa0ZxUTh6L0Qxb3JnVlUvNkpD?=
 =?utf-8?B?d1c0V1JzdjZQWWtDVkxwOUhtcGNaWEY5U3JOclBkYzhyb2FPazF1OHRubmRJ?=
 =?utf-8?B?aVJCbitRMUd2UWozd0tsWnhZa2ZVSnZTS0ViQ2Q5WjhFbkdRWS9NenMxZDRR?=
 =?utf-8?B?c1NTUkdxdGhTUkIyVUV1ZGZyd3B2dWhtZERVZzhJT0lnVkNrOTY2d0pqVWxw?=
 =?utf-8?B?Yi9LcFFJdnZjcVpLYnVDd0VMWnptVlVFUy9lL0J6NVp2dUQ5WnAyR2dKdkZX?=
 =?utf-8?B?MVdzcGV6czVlNGU4ZGVjR0twSEp6aFFoRUlBYlBwWE5HaXJxdkZzMmNEb2M3?=
 =?utf-8?B?ZTFPT1krdXlrQkt6QmwyY1ZjZTdBR2RZbzdHMnI4ZzFmcmx1UUxCalozMDNa?=
 =?utf-8?B?U3JJckpha2ZkRzJSc09RdlI2S3RTdHI0YzRrbTVPYVRsbExrVmF2dTFOTGtD?=
 =?utf-8?B?Z3ErK0dmVVd5bmUySGNxeU9hZjFIQnJMdDFWNHpseGxhWFg4VndodzRJZ3kr?=
 =?utf-8?B?cnY4V1lrZk5hNlNvRWpCUk9rQ3lHWXp5UHJFUFJURVFCWDFLZG8rYzFkOVpk?=
 =?utf-8?B?MDJMYWVkaFNaZnFDbnNhMXhxTk8vTWhIa0FZWDB2UXhYeUhsaGFXdW8xa0Vn?=
 =?utf-8?B?Q3BOUUt5ck5rVituMEJWZjU2YUZDUGJqQUlGVzRlVXIyNEpoajJtZXVhRFUw?=
 =?utf-8?B?SHFUaE9MVXdCRU92RWM1VjJIRmlyUXV5VW85QzkyUnRWYnJuVjY1dmNPRGdU?=
 =?utf-8?B?dDVQeHpnMW1qZTVrZlNRbWVtVGEvcHRNVlcxWUhVVGVra2ZHUFI4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6d997e-a51a-4fba-2d07-08dec1993652
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:54:52.0788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq1dSTDhfUYmyn3nxog4/+njIOFbqjbUcOyTWBQKbZlOLJvXvDxuxQfAa97xRQ43lV7+d3GslG8DerlrKi2wzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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


On 2026-05-29 07:24, Christian König wrote:
> Split amdgpu_vm_update_range into two functions.
>
> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
> which can be done while holding the VM lock.
>
> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
> lock in MMU notifiers.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
>   5 files changed, 120 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 44fe40f9e8df..653ffa9ca0f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>   /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
> -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
> @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>   #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
>   #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
>   
>   struct amdgpu_job {
>   	struct drm_sched_job    base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index edc8b1ca2d3e..b5adfcacc55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1080,11 +1080,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   }
>   
>   /**
> - * amdgpu_vm_update_range - update a range in the vm page table
> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>    *
>    * @adev: amdgpu_device pointer to use for commands
>    * @vm: the VM to update the range
> - * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
>    * @sync: fences we need to sync to
> @@ -1097,23 +1096,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
>    *
> - * Fill in the page table entries between @start and @last.
> + * Fill in the page table entries between @start and @last. Allocate and free
> + * new page tables as needed. Can only be called while holding the VM lock.
>    *
>    * Returns:
>    * 0 for success, negative erro code for failure.
>    */
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence)
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
>   	int r, idx;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> @@ -1138,7 +1140,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> -	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1149,7 +1150,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_free;
>   	}
>   
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
>   		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> @@ -1158,7 +1159,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	r = vm->update_funcs->prepare(&params, sync,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>   	if (r)
>   		goto error_free;
>   
> @@ -1234,6 +1235,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
> + *
> + * @adev: amdgpu_device pointer to use for commands
> + * @vm: the VM to update the range
> + * @sync: fences we need to sync to
> + * @start: start of unmapped range
> + * @last: last unmapped entry
> + * @flags: flags for the entries
> + * @fence: optional resulting fence
> + *
> + * Fill in the page table entries between @start and @last with a fixed flags
> + * value without allocating or freeing page tables. Can be used without locking
> + * the VM.
> + *
> + * Returns:
> + * 0 for success, negative erro code for failure.
> + */
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			   struct amdgpu_sync *sync, uint64_t start,
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm_update_params params;
> +	int r, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
> +
> +	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb) {
> +		drm_dev_exit(idx);
> +		return -ENOMEM;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.needs_flush = true;
> +	params.unlocked = true;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	if (vm->evicting) {
> +		r = -EBUSY;
> +		goto error_free;
> +	}
> +
> +	r = vm->update_funcs->prepare(&params, sync,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_update_leaves(&params, start, last, 0, flags);
> +
> +	r = vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_free;

So this wraps amdgpu_vm_update_leaves with all the stuff that's 
necessary to actually execute the page table update. I don't understand 
how amdgpu_vm_update_leaves works without this when you call it directly 
from amdgpu_vm_handle_fault (in patch 6). Shouldn't you use 
amdgpu_vm_unmap_range there instead?

And if that's true, then maybe you can use the name 
amdgpu_vm_update_leaves for this instead.

Regards,
   Felix


> +
> +	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +	amdgpu_vm_pt_free_list(adev, &params);
> +	tlb_cb = NULL;
> +
> +error_free:
> +	kfree(tlb_cb);
> +	amdgpu_vm_eviction_unlock(vm);
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
> -					   !uncached, &sync, mapping->start,
> -					   mapping->last, update_flags,
> -					   mapping->offset, vram_base, mem,
> -					   pages_addr, last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
> +					mapping->start, mapping->last,
> +					update_flags, mapping->offset,
> +					vram_base, mem, pages_addr,
> +					last_update);
>   		if (r)
>   			goto error_free;
>   	}
> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false,
> -					   &sync, mapping->start, mapping->last,
> -					   0, 0, 0, NULL, NULL, &f);
> +		r = amdgpu_vm_map_range(adev, vm, true, false,
> +					&sync, mapping->start, mapping->last,
> +					0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3e86a2a470f0..561f2873d2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				uint32_t xcc_mask);
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence);
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence);
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 6f5415d5a1bc..ac3f3e31e2e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   	/*
>   	 * unlocked unmap clear page table leaves, warning to free the page entry.
>   	 */
> -	WARN_ON(unlocked);
> +	WARN_ON(params->unlocked);
>   
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		uint64_t incr, entry_end, pe_start;
>   		struct amdgpu_bo *pt;
>   
> -		if (!params->unlocked) {
> -			/* make sure that the page tables covering the
> -			 * address range are actually allocated
> -			 */
> -			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
> -					       &cursor);
> -			if (r)
> -				return r;
> -		}
> +		/* make sure that the page tables covering the
> +		 * address range are actually allocated
> +		 */
> +		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
> +		if (r)
> +			return r;
>   
>   		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>   		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>   			/* No huge page support before GMC v9 */
>   			if (cursor.level != AMDGPU_VM_PTB) {
>   				if (!amdgpu_vm_pt_descendant(adev, &cursor))
> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
>   
> -		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> -			/*
> -			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
> -			 * only clear one entry. Next entry search again for PDE or PTE leave.
> -			 */
> -			entry_end = 1ULL << shift;
> -		else
> -			entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 37b5166e9a14..d0ea20dea3e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return -EINVAL;
>   	}
>   
> -	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
> -				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
> +				     init_pte_value, fence);
>   }
>   
>   static int
> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
> -					   NULL, gpu_start, gpu_end,
> -					   pte_flags,
> -					   (last_start - prange->start) << PAGE_SHIFT,
> -					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
> +					gpu_start, gpu_end, pte_flags,
> +					(last_start - prange->start) << PAGE_SHIFT,
> +					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> +					NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;
