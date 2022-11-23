Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070CFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2463D10E4CA;
	Wed, 23 Nov 2022 01:45:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF7C10E4C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5DIQZ2p8OCCqCSjRMF6SwpphqCxeLpnI9dghA02obghDjKGTFMTzjZRbGvgCBdYyuJoPdgxFEKsg6WKjk2d0Y686QAjp8g8aLtZttay7/QJMr6jpoo9RGrOlwPxOWB9vusD2MWUd5dwY9Q3OAAFHV0aGlxJYbHaFvJdbX+Y8ob6yirHouDwT5wmF+41cAdmO27aTGvzZrBtmCt48t76Gn0xv4lNruhWrJQ8N/10lMVyc+NCYpDuvDMfxg70VfnQfu7MGSdo5yo6xtMCo+ikDxcOFWWeu6HM18+oCGIho/jiXLL6bE9hedIYtENz2YEg08/MmfHXHlVpyEGqqdAJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2EglVYiSQ9pDL7vjYZkzfq+b20cv/AYlYVYQkY8Byk=;
 b=BrPQCPTBz47R7DTWJ2xM0+V2LVMZZGl5NVDxvuvkyWTaeoouiHyNqwvfMrXSS2SuDkUtDFHqSSYeaRXX4XtilI+LaKAYK5an3ZIQzx5Lv4m087kCUfc7MwojZVCjp6I4z7s9i0n350fMl4fIWJ7WPeUMt2DyAhn/VCTLZua3pIFnWcKJ9O/v0zASb4FCV90Kctyom62aMqWi8hJDwdRa4EVe4900MA8fYSXWLdM1+3jQEu3DE2byiG03VQT+pGqUiC0Bs+hyrtdKV9F25cYfzNCSdHwAtNCt7E8kId9hatAaepPViSKcbvkxdjhwxKMACbKcQWzObRQpy4bSzBqaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2EglVYiSQ9pDL7vjYZkzfq+b20cv/AYlYVYQkY8Byk=;
 b=GkbYbLR+uWBR1IVLu81tuyvMYat0uf6CDsbCGMrxayJRYe/NldFymBkSchqw6pjFfmQapSVu1zv4Xij4Mo9kgEhkJUMuVMerzDeCJw7NxyiVTVdGga4ucC6nRNd0Bp0NhbNtf8tLpU4wqogE9R/xrkW5bMULnt+C/R5pF/kitOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:49 +0000
Message-ID: <01d2ebfd-35e1-8f03-3c22-76314f5e78b0@amd.com>
Date: Tue, 22 Nov 2022 19:21:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 10/29] drm/amdgpu: add configurable grace period for unmap
 queues
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-10-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-10-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d344a6f-75e6-4a39-ec6e-08daccf44ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8c7DfWF3CMhdSHd4KkrHTWJIKNU7BrUUu9NTsDqfPPhm1HRyp7dQzwVCvYkZFZB+TT8BWuQczhaUTdunTMo/4601nLhcYd6M1Rio3vJLLps4m60Hgu4leOucGvAoHJkeEBjH4wjkxZO7aaq5dd+fzSHDEncvHFuqcvkbEsvpvLEzZ0a3CX0A9WA1A4BHwBk0ryd6edWuuPZ8kUz6T13jlLGIRAVdIIcFQ5f/3WTLKC7xxVLiXEQxqFJxMmwtAqVedNkLjGi2R8ZSfkCqi10KZyW6KfxqhhS3R+nM+fbxW4TkiUmw2f+1jxKP0uurVqYhIs0pZJYxMfGY5Cap5ETAb8zJlkNHkG4tt/E7tpHto7BQSzwOs5+7LME1hrjE3tk9r6DQyXTj2Ea+IuMpmhZEXiuG8Q5BBL6d8G3olBZ2CX/zOx4Vpb8zFKQ6XAyjFw4cSsQlPb+s4mL4rMdP7Ieqo7MNv+V3ScC8fHTFXne+sRAXt0VmugIg7I1LcgZOq1QrGxfxBAm1t50Cu8PSkS4hNqfFmOYq7qxghId93c6U+/SufZ/tRysxEjbMS/i2vETbo8HSi/mcm+IQajb80X9837XtwWOIAqKaQ+BViemxupTcAOblrGA8TFCvbUw7pozuvitoaxeQFz0YjDeab+DkV2Q+/NfaPHqmTJeSEcf8BdnBIucXQPthm3IOxVc8PaHSV7RVoXc+rfOHPZcM18SuAnyOPsc57htPQ0cf4qx4/AM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6666004)(6486002)(30864003)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(66899015)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUdmMmQ3UkJEbHpHenBvY1NTaVdCaWhoNUZYNHZncGhWSzVSTjFWVU5vYnZY?=
 =?utf-8?B?ZmdFL0ZKOVpxOUVDa3JXd0NyTHI3R05QNXE1UUhqbG1NazF6ME1XMUV6WHll?=
 =?utf-8?B?NE5waGN4VSs2QUtCenZPS2hRek9VcVlVc09ybTlvWGFROFE3TTlicElzcGRm?=
 =?utf-8?B?d1J2ekpQWWtnL3ByNmFkZ29NUFpwRGpCUFREc3RPTEdqdXdaWmdoaW92aG9h?=
 =?utf-8?B?ZnQzWk1VdHBCQ3ROTld5amhrWEllbnFlY2gvL3VIbWpHSC9MNHl5L3hhSDlZ?=
 =?utf-8?B?c2dvVDdNWEt0ZDQvMXQ2SWhJYXBHaGUyQWdZQkVKaktuM0RybU5sV1AwU0ta?=
 =?utf-8?B?OCtzdXZHaVJUS1JWU2YxbWNWbWZ5cWw0VE9yS2RqdFNyUWExVVplOHRvZURP?=
 =?utf-8?B?b0J6dEFwNkVuQkRpS2IrNDF6MFZMZEhZRU00K1U5QTV6d3QyblZLVElwcktq?=
 =?utf-8?B?Q2xWV1B3ajUxZ3c1cUFRRldzcHZDK041blJQZXZrTkxGL3Fva2ZPaEoyS0sz?=
 =?utf-8?B?M1NCbXZLRmpmb2NDNzgvRzB1bXpvUWFZOE1wNGs5NTdLUDlZVzV1WFJXTU9Q?=
 =?utf-8?B?NDlpY3Nsek91bStwK3g3a21QVjdlRndVSG95czNxWmc5dXVjYnlpbG8rTDRp?=
 =?utf-8?B?Tm40TWRXQUVKVmJNYjVJZVVQK3htYVpNc0ZXUUo4M2djQWU1YkN0NU5tekJ1?=
 =?utf-8?B?Q2JISXJmZkN0NVZ4UjRzdGpoUUZpR1llTEVzRUN1NWNDd05paGs1RnRGcDR5?=
 =?utf-8?B?elU4Sit1dFo0ZnJFM3pIbVkyN2JsQURRNHJPaEw5WExvYVphNFpwbmU5QVdy?=
 =?utf-8?B?K3R1eXMwc3RaeUVpeEN0c05GK2g3Qm5wRUdDZERPL2oya0VIL2FGb3ZONFdF?=
 =?utf-8?B?QVBJZnlMdDNQN3Y3Z0FMTmc2N1hET0g4enlQWE40RWx6ZE5RMlNRaDlsYlEx?=
 =?utf-8?B?d0ZhbHRIU3BGUE9KaksrNlplenF4Vkt6enRXWm5hSHo5R3V3TkpXYnVsNXlh?=
 =?utf-8?B?L3lPOXROSG44UGNsRWdWSlZ3Wk55N3M5WlJSdEVlbVlRTEo1a1ZVVzc1SE13?=
 =?utf-8?B?T3Q5OTU0eWsyVHZqY050NCt3OXVHeGF5elJEc0o2UEVtT2ZvUmNnMEF6aytJ?=
 =?utf-8?B?NnU2UmJGd0tNQmlVY0d5R0N5cDgvQ1JmT214Znp5a08zOWFWV1RCbGNqcVUw?=
 =?utf-8?B?bDNZMUhraWtGQmdDZDRZY1VFYmZ2dHJZclZOMmd4UG5RZkptVU00RWdqMjRx?=
 =?utf-8?B?RFpkZk54clNZQWVxa21aTGJrOGpJeFU0N09neXpRSUpmaDl6eEptdURGWUZG?=
 =?utf-8?B?a0RuZExBUzh2dFBDa1poczVWQUNvb2locW1MR2l0bVBmeDlxOFd4U0VkcEN6?=
 =?utf-8?B?Mmg0UFVPd2t0Z3p5NEpFd1BobEF0WUYzcCs5d0lIZUNsYmJzcjg5M0RaQlV6?=
 =?utf-8?B?ZU9SVkVqMzNLaVdKaUtHNEJmVTBHV1RIT3NKSHJQVm5vU3JUaTZHeitNZEFQ?=
 =?utf-8?B?STZhRkxZWjFtLzBKV3cyRXU1K3U0b1Vhd1dtMy9xeG1YdUNjRWhhQ2tOWlRm?=
 =?utf-8?B?VzZ3RERuU0FhZ1QxTEZiM1JEMTQ2ck03L1NlRFpPblRIQW5oUUtaUW1BQnJ2?=
 =?utf-8?B?ckRZdHBLa09iOFJHcSthNlM0RDFxU1c1Q1RiWHZJdXVvdXUwYjg0NCtMNlpJ?=
 =?utf-8?B?dktIdTgwQWlic2RVSHViQnpYZU51eGYvWWZsSjVHQisrb1ZnUjhLaVhSSlBE?=
 =?utf-8?B?dXhXM1JTb1JxUDVXcjMrdlFPalZXS2hZbkg4SjdXR3FrZk53Rkg0eVo5dnBs?=
 =?utf-8?B?TVFyK0NWNVh6M1Btc3phSXNkbzk2VFJ5RjRYWUFaZzlqaDNuUTg0dWRhYTZ5?=
 =?utf-8?B?cnVha2p4bVdKYkZoaFhJVjNHcjI5MzdLaGFyZFJKUU0wTnFPaHpuRW9yRG9u?=
 =?utf-8?B?ekhXTHMxV1BIbUp0OGZiVmdEZ21paUhpalFUYk5QdzdoUFREN2l0YnlWdUxJ?=
 =?utf-8?B?WEJHYnVHRVprTkdMR3lFRWZPUzZLTllvLzJMUGZIb0RwWHZhUUsxeGhTd3RC?=
 =?utf-8?B?a2g0LzNpdk1uVkhtWlJjSU0wNUN0U2FoOG5yeXJZOFNDeFd5R0tSMWVIQkl0?=
 =?utf-8?Q?9E3cnpIERyHXRwBy2P6iLpYtb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d344a6f-75e6-4a39-ec6e-08daccf44ee2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:49.5489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VzoHHxrxnGhUeviZf/TIa/+5vcqbbi6GJEcW+xNJ9CiKzeHJkYW4Hf+nlD1qEa3ICmATms0/Q952dPhBVXNjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

On 2022-10-31 12:23, Jonathan Kim wrote:
> The HWS schedule allows a grace period for wave completion prior to
> preemption but the debugger requires good performance since it preempts
> on every HW debug mode setting transaction request.
>
> For good performance, allow immediate preemption by setting the grace
> period to 0.

This is less about performance than about latency. The grace period is 
there to optimize performance in normal operation by avoiding CWSR for 
waves that would drain quickly on their own. But the debugger doesn't 
care about performance and it doesn't want to let waves drain. It wants 
low latency to preempt queues as soon as possible so it can inspect 
their state.

Regards,
   Felix

>
> Note that setting the preepmtion grace period to 0 will result in an
> infinite grace period being set due to a CP FW bug so set it to 1 for now.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 43 ++++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  6 ++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 43 ++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  9 ++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 61 ++++++++++++-----
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 32 +++++++++
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 39 +++++++++++
>   .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   | 65 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 ++
>   13 files changed, 291 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 42491a31f352..c9629fc5460c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -73,5 +73,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
>   	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
> +	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
> +	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 13f02a0aa828..60a204f767ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -397,6 +397,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   				kgd_gfx_v9_set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_arcturus_enable_debug_trap,
>   	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
> +	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
> +	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index c09b45de02d0..2491402afd58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -801,6 +801,47 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +/* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
> + * The values read are:
> + *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> + *     atomic_offload_wait_time -- Wait Count for L2 and GDS Atomics Offloads.
> + *     wrm_offload_wait_time    -- Wait Count for WAIT_REG_MEM Offloads.
> + *     gws_wait_time            -- Wait Count for Global Wave Syncs.
> + *     que_sleep_wait_time      -- Wait Count for Dequeue Retry.
> + *     sch_wave_wait_time       -- Wait Count for Scheduling Wave Message.
> + *     sem_rearm_wait_time      -- Wait Count for Semaphore re-arm.
> + *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
> + */
> +void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
> +					uint32_t *wait_times)
> +
> +{
> +	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
> +}
> +
> +void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
> +						uint32_t wait_times,
> +						uint32_t grace_period,
> +						uint32_t *reg_offset,
> +						uint32_t *reg_data)
> +{
> +	*reg_data = wait_times;
> +
> +	/*
> +	 * The CP cannont handle a 0 grace period input and will result in
> +	 * an infinite grace period being set so set to 1 to prevent this.
> +	 */
> +	if (grace_period == 0)
> +		grace_period = 1;
> +
> +	*reg_data = REG_SET_FIELD(*reg_data,
> +			CP_IQ_WAIT_TIME2,
> +			SCH_WAVE,
> +			grace_period);
> +
> +	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
> +}
> +
>   static void program_trap_handler_settings(struct amdgpu_device *adev,
>   		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
>   {
> @@ -845,5 +886,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.set_vm_context_page_table_base = set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
>   	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
> +	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
> +	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.program_trap_handler_settings = program_trap_handler_settings,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 370d6c312981..0abc1e805180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -26,3 +26,9 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
>   uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid);
> +void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
> +void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
> +					       uint32_t wait_times,
> +					       uint32_t grace_period,
> +					       uint32_t *reg_offset,
> +					       uint32_t *reg_data);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 73e3b9ae1fb0..c57f2a6b6e23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -670,6 +670,8 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
>   	.get_atc_vmid_pasid_mapping_info = get_atc_vmid_pasid_mapping_info_v10_3,
>   	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
>   	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
> +	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
> +	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
>   	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index e1aac6f6d369..673c99c5523d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -724,6 +724,24 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +/* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
> + * The values read are:
> + *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> + *     atomic_offload_wait_time -- Wait Count for L2 and GDS Atomics Offloads.
> + *     wrm_offload_wait_time    -- Wait Count for WAIT_REG_MEM Offloads.
> + *     gws_wait_time            -- Wait Count for Global Wave Syncs.
> + *     que_sleep_wait_time      -- Wait Count for Dequeue Retry.
> + *     sch_wave_wait_time       -- Wait Count for Scheduling Wave Message.
> + *     sem_rearm_wait_time      -- Wait Count for Semaphore re-arm.
> + *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
> + */
> +void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
> +					uint32_t *wait_times)
> +
> +{
> +	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
> +}
> +
>   void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
>   			uint32_t vmid, uint64_t page_table_base)
>   {
> @@ -908,6 +926,29 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>   				adev->gfx.cu_info.max_waves_per_simd;
>   }
>   
> +void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
> +		uint32_t wait_times,
> +		uint32_t grace_period,
> +		uint32_t *reg_offset,
> +		uint32_t *reg_data)
> +{
> +	*reg_data = wait_times;
> +
> +	/*
> +	 * The CP cannont handle a 0 grace period input and will result in
> +	 * an infinite grace period being set so set to 1 to prevent this.
> +	 */
> +	if (grace_period == 0)
> +		grace_period = 1;
> +
> +	*reg_data = REG_SET_FIELD(*reg_data,
> +			CP_IQ_WAIT_TIME2,
> +			SCH_WAVE,
> +			grace_period);
> +
> +	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
> +}
> +
>   void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>                           uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
>   {
> @@ -951,6 +992,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_gfx_v9_enable_debug_trap,
>   	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
> +	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
> +	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index d39256162616..c0866497cb5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -20,8 +20,6 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> -
> -
>   void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmid,
>   		uint32_t sh_mem_config,
>   		uint32_t sh_mem_ape1_base, uint32_t sh_mem_ape1_limit,
> @@ -51,7 +49,6 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
>   					uint32_t sq_cmd);
>   bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
>   					uint8_t vmid, uint16_t *p_pasid);
> -
>   void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
>   			uint32_t vmid, uint64_t page_table_base);
>   void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
> @@ -67,3 +64,9 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
>   uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid);
> +void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
> +void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
> +					       uint32_t wait_times,
> +					       uint32_t grace_period,
> +					       uint32_t *reg_offset,
> +					       uint32_t *reg_data);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index faa5d8c666ee..fbcf4ee07936 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -46,10 +46,13 @@ static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>   
>   static int execute_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> -				uint32_t filter_param);
> +				uint32_t filter_param,
> +				uint32_t grace_period);
>   static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> -				uint32_t filter_param, bool reset);
> +				uint32_t filter_param,
> +				uint32_t grace_period,
> +				bool reset);
>   
>   static int map_queues_cpsch(struct device_queue_manager *dqm);
>   
> @@ -839,7 +842,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
>   		if (!dqm->dev->shared_resources.enable_mes)
>   			retval = unmap_queues_cpsch(dqm,
> -						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false);
> +						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
>   		else if (prev_active)
>   			retval = remove_queue_mes(dqm, q, &pdd->qpd);
>   
> @@ -1015,7 +1018,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   		retval = execute_queues_cpsch(dqm,
>   					      qpd->is_debug ?
>   					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
> -					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> +					      USE_DEFAULT_GRACE_PERIOD);
>   
>   out:
>   	dqm_unlock(dqm);
> @@ -1155,7 +1159,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   	}
>   	if (!dqm->dev->shared_resources.enable_mes)
>   		retval = execute_queues_cpsch(dqm,
> -					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
>   	qpd->evicted = 0;
>   	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
>   	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
> @@ -1492,6 +1496,9 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
>   
>   	init_sdma_bitmaps(dqm);
>   
> +	if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> +					&dqm->wait_times);
>   	return 0;
>   }
>   
> @@ -1531,7 +1538,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   	dqm->is_resetting = false;
>   	dqm->sched_running = true;
>   	if (!dqm->dev->shared_resources.enable_mes)
> -		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -1556,7 +1563,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   
>   	if (!dqm->is_hws_hang) {
>   		if (!dqm->dev->shared_resources.enable_mes)
> -			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, false);
> +			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
>   		else
>   			remove_all_queues_mes(dqm);
>   	}
> @@ -1598,7 +1605,8 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
>   	list_add(&kq->list, &qpd->priv_queue_list);
>   	increment_queue_count(dqm, qpd, kq->queue);
>   	qpd->is_debug = true;
> -	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> +			USE_DEFAULT_GRACE_PERIOD);
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -1612,7 +1620,8 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
>   	list_del(&kq->list);
>   	decrement_queue_count(dqm, qpd, kq->queue);
>   	qpd->is_debug = false;
> -	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
> +	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> +			USE_DEFAULT_GRACE_PERIOD);
>   	/*
>   	 * Unconditionally decrement this counter, regardless of the queue's
>   	 * type.
> @@ -1689,7 +1698,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   
>   		if (!dqm->dev->shared_resources.enable_mes)
>   			retval = execute_queues_cpsch(dqm,
> -					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
>   		else
>   			retval = add_queue_mes(dqm, q, qpd);
>   		if (retval)
> @@ -1778,7 +1787,9 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> -				uint32_t filter_param, bool reset)
> +				uint32_t filter_param,
> +				uint32_t grace_period,
> +				bool reset)
>   {
>   	int retval = 0;
>   	struct mqd_manager *mqd_mgr;
> @@ -1790,6 +1801,12 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!dqm->active_runlist)
>   		return retval;
>   
> +	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
> +		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
> +		if (retval)
> +			return retval;
> +	}
> +
>   	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
>   	if (retval)
>   		return retval;
> @@ -1822,6 +1839,13 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   		return -ETIME;
>   	}
>   
> +	/* We need to reset the grace period value for this device */
> +	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
> +		if (pm_update_grace_period(&dqm->packet_mgr,
> +					USE_DEFAULT_GRACE_PERIOD))
> +			pr_err("Failed to reset grace period\n");
> +	}
> +
>   	pm_release_ib(&dqm->packet_mgr);
>   	dqm->active_runlist = false;
>   
> @@ -1837,7 +1861,7 @@ static int reset_queues_cpsch(struct device_queue_manager *dqm,
>   	dqm_lock(dqm);
>   
>   	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
> -			pasid, true);
> +			pasid, USE_DEFAULT_GRACE_PERIOD, true);
>   
>   	dqm_unlock(dqm);
>   	return retval;
> @@ -1846,13 +1870,14 @@ static int reset_queues_cpsch(struct device_queue_manager *dqm,
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int execute_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> -				uint32_t filter_param)
> +				uint32_t filter_param,
> +				uint32_t grace_period)
>   {
>   	int retval;
>   
>   	if (dqm->is_hws_hang)
>   		return -EIO;
> -	retval = unmap_queues_cpsch(dqm, filter, filter_param, false);
> +	retval = unmap_queues_cpsch(dqm, filter, filter_param, grace_period, false);
>   	if (retval)
>   		return retval;
>   
> @@ -1910,7 +1935,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   		if (!dqm->dev->shared_resources.enable_mes) {
>   			decrement_queue_count(dqm, qpd, q);
>   			retval = execute_queues_cpsch(dqm,
> -						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> +						      USE_DEFAULT_GRACE_PERIOD);
>   			if (retval == -ETIME)
>   				qpd->reset_wavefronts = true;
>   		} else {
> @@ -2195,7 +2221,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   	}
>   
>   	if (!dqm->dev->shared_resources.enable_mes)
> -		retval = execute_queues_cpsch(dqm, filter, 0);
> +		retval = execute_queues_cpsch(dqm, filter, 0, USE_DEFAULT_GRACE_PERIOD);
>   
>   	if ((!dqm->is_hws_hang) && (retval || qpd->reset_wavefronts)) {
>   		pr_warn("Resetting wave fronts (cpsch) on dev %p\n", dqm->dev);
> @@ -2539,7 +2565,8 @@ int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
>   		return r;
>   	}
>   	dqm->active_runlist = true;
> -	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
> +	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> +				0, USE_DEFAULT_GRACE_PERIOD);
>   	dqm_unlock(dqm);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index a537b9ef3e16..fb48b124161f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -37,6 +37,7 @@
>   
>   #define KFD_MES_PROCESS_QUANTUM		100000
>   #define KFD_MES_GANG_QUANTUM		10000
> +#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>   
>   struct device_process_node {
>   	struct qcm_process_device *qpd;
> @@ -256,6 +257,7 @@ struct device_queue_manager {
>   	struct work_struct	hw_exception_work;
>   	struct kfd_mem_obj	hiq_sdma_mqd;
>   	bool			sched_running;
> +	uint32_t		wait_times;
>   };
>   
>   void device_queue_manager_init_cik(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index ed02b6d8bf63..c57f9a46dfcc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -369,6 +369,38 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
>   	return retval;
>   }
>   
> +int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
> +{
> +	int retval = 0;
> +	uint32_t *buffer, size;
> +
> +	size = pm->pmf->set_grace_period_size;
> +
> +	mutex_lock(&pm->lock);
> +
> +	if (size) {
> +		kq_acquire_packet_buffer(pm->priv_queue,
> +			size / sizeof(uint32_t),
> +			(unsigned int **)&buffer);
> +
> +		if (!buffer) {
> +			pr_err("Failed to allocate buffer on kernel queue\n");
> +			retval = -ENOMEM;
> +			goto out;
> +		}
> +
> +		retval = pm->pmf->set_grace_period(pm, buffer, grace_period);
> +		if (!retval)
> +			kq_submit_packet(pm->priv_queue);
> +		else
> +			kq_rollback_packet(pm->priv_queue);
> +	}
> +
> +out:
> +	mutex_unlock(&pm->lock);
> +	return retval;
> +}
> +
>   int pm_send_unmap_queue(struct packet_manager *pm,
>   			enum kfd_unmap_queues_filter filter,
>   			uint32_t filter_param, bool reset)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 18250845a989..f0cdc8695b8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -251,6 +251,41 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   	return 0;
>   }
>   
> +static int pm_set_grace_period_v9(struct packet_manager *pm,
> +		uint32_t *buffer,
> +		uint32_t grace_period)
> +{
> +	struct pm4_mec_write_data_mmio *packet;
> +	uint32_t reg_offset = 0;
> +	uint32_t reg_data = 0;
> +
> +	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +			pm->dqm->dev->adev,
> +			pm->dqm->wait_times,
> +			grace_period,
> +			&reg_offset,
> +			&reg_data);
> +
> +	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
> +		reg_data = pm->dqm->wait_times;
> +
> +	packet = (struct pm4_mec_write_data_mmio *)buffer;
> +	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> +
> +	packet->header.u32All = pm_build_pm4_header(IT_WRITE_DATA,
> +					sizeof(struct pm4_mec_write_data_mmio));
> +
> +	packet->bitfields2.dst_sel  = dst_sel___write_data__mem_mapped_register;
> +	packet->bitfields2.addr_incr =
> +			addr_incr___write_data__do_not_increment_address;
> +
> +	packet->bitfields3.dst_mmreg_addr = reg_offset;
> +
> +	packet->data = reg_data;
> +
> +	return 0;
> +}
> +
>   static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   			enum kfd_unmap_queues_filter filter,
>   			uint32_t filter_param, bool reset)
> @@ -333,6 +368,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
>   	.set_resources		= pm_set_resources_v9,
>   	.map_queues		= pm_map_queues_v9,
>   	.unmap_queues		= pm_unmap_queues_v9,
> +	.set_grace_period       = pm_set_grace_period_v9,
>   	.query_status		= pm_query_status_v9,
>   	.release_mem		= NULL,
>   	.map_process_size	= sizeof(struct pm4_mes_map_process),
> @@ -340,6 +376,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
>   	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
>   	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
>   	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
> +	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
>   	.query_status_size	= sizeof(struct pm4_mes_query_status),
>   	.release_mem_size	= 0,
>   };
> @@ -350,6 +387,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
>   	.set_resources		= pm_set_resources_v9,
>   	.map_queues		= pm_map_queues_v9,
>   	.unmap_queues		= pm_unmap_queues_v9,
> +	.set_grace_period       = pm_set_grace_period_v9,
>   	.query_status		= pm_query_status_v9,
>   	.release_mem		= NULL,
>   	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
> @@ -357,6 +395,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
>   	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
>   	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
>   	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
> +	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
>   	.query_status_size	= sizeof(struct pm4_mes_query_status),
>   	.release_mem_size	= 0,
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
> index a666710ed403..795001c947e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
> @@ -583,6 +583,71 @@ struct pm4_mec_release_mem {
>   
>   #endif
>   
> +#ifndef PM4_MEC_WRITE_DATA_DEFINED
> +#define PM4_MEC_WRITE_DATA_DEFINED
> +
> +enum WRITE_DATA_dst_sel_enum {
> +	dst_sel___write_data__mem_mapped_register = 0,
> +	dst_sel___write_data__tc_l2 = 2,
> +	dst_sel___write_data__gds = 3,
> +	dst_sel___write_data__memory = 5,
> +	dst_sel___write_data__memory_mapped_adc_persistent_state = 6,
> +};
> +
> +enum WRITE_DATA_addr_incr_enum {
> +	addr_incr___write_data__increment_address = 0,
> +	addr_incr___write_data__do_not_increment_address = 1
> +};
> +
> +enum WRITE_DATA_wr_confirm_enum {
> +	wr_confirm___write_data__do_not_wait_for_write_confirmation = 0,
> +	wr_confirm___write_data__wait_for_write_confirmation = 1
> +};
> +
> +enum WRITE_DATA_cache_policy_enum {
> +	cache_policy___write_data__lru = 0,
> +	cache_policy___write_data__stream = 1
> +};
> +
> +
> +struct pm4_mec_write_data_mmio {
> +	union {
> +		union PM4_MES_TYPE_3_HEADER header;     /*header */
> +		unsigned int ordinal1;
> +	};
> +
> +	union {
> +		struct {
> +			unsigned int reserved1:8;
> +			unsigned int dst_sel:4;
> +			unsigned int reserved2:4;
> +			unsigned int addr_incr:1;
> +			unsigned int reserved3:2;
> +			unsigned int resume_vf:1;
> +			unsigned int wr_confirm:1;
> +			unsigned int reserved4:4;
> +			unsigned int cache_policy:2;
> +			unsigned int reserved5:5;
> +		} bitfields2;
> +		unsigned int ordinal2;
> +	};
> +
> +	union {
> +		struct {
> +			unsigned int dst_mmreg_addr:18;
> +			unsigned int reserved6:14;
> +		} bitfields3;
> +		unsigned int ordinal3;
> +	};
> +
> +	uint32_t reserved7;
> +
> +	uint32_t data;
> +
> +};
> +
> +#endif
> +
>   enum {
>   	CACHE_FLUSH_AND_INV_TS_EVENT = 0x00000014
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3ea61fa1db52..a851f814bc9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1300,6 +1300,8 @@ struct packet_manager_funcs {
>   	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
>   			enum kfd_unmap_queues_filter mode,
>   			uint32_t filter_param, bool reset);
> +	int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
> +			uint32_t grace_period);
>   	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>   			uint64_t fence_address,	uint64_t fence_value);
>   	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> @@ -1310,6 +1312,7 @@ struct packet_manager_funcs {
>   	int set_resources_size;
>   	int map_queues_size;
>   	int unmap_queues_size;
> +	int set_grace_period_size;
>   	int query_status_size;
>   	int release_mem_size;
>   };
> @@ -1332,6 +1335,8 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>   
>   void pm_release_ib(struct packet_manager *pm);
>   
> +int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period);
> +
>   /* Following PM funcs can be shared among VI and AI */
>   unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size);
>   
