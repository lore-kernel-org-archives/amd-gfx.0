Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7215BCCD184
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Oct 2025 23:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E0710E064;
	Sun, 12 Oct 2025 23:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dc7TkFCX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B2310E064
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 23:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4PzsxBlKoxfVYcCKs0sVRL7mZgTrpCbAK7o3c/1nk/IKlZH9ZAsuL/tgyaPOPbMtqrReGxBLSaHIXnN+xToz6KJ7Qax4ZnUVK0JuzrrtDWadhxNhzv+KYK7PIg9T0dh1bTVUi+IYXsP/86793z8QAHm/pxbJ7Yh/W5u5vlOZMbG6Y+O/MsfnhCP7mGR9FOiL7hEGnVl4/+EPqfyX/AFmM6vMsYxym9IR/6pnB/txK4uMevJGuEXjYWFjUGNn2hxjVBXIARZyTMX6aKmdtVfagxuPyneSqaEhjLYvDmmQ7bQdezK9Aox+RZiLMEvvPnrkhNDOMmixYfZEHAmjVoAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llk+IJVSuByV5upvUin9Y7FinQd8fN2HGiL4zfoklhs=;
 b=o02p9XkeIjaf1y1v1dgFUXxAH2/eAxy3ywsQmLOUvB03nKEcQThjrFX+ZDcY6iF7wiKvHaKAc0pzZK6VkuydyJoJddtsEA3l3O9Z3L1vBc2vH4Yl6z49H488m6f0vQW6fJuzyXakNGLmduswLcrRY/LS/BY6mLQUZbYVOUNkY+jnYBAZWvdNV1yJSlq0WAuX8R/eImoMGC8HT0K5sByqVNDUiAejF6hTEztQLsM6zg/qGcb+iKCDdfkEGXVeXr7PojQz9XWkKuYwalB8Ji7XdQvC6uqqwFeKRf3iv8IXe7RtMEPkMRQHPMxuwBC4IbW7M+AZp57OomMkqvS2+9t+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llk+IJVSuByV5upvUin9Y7FinQd8fN2HGiL4zfoklhs=;
 b=dc7TkFCXmbwgXAG4uKlsm4SshFcF2v3gFLoymJwA9NUhCEVfMZgsXet/ds17d9akdo1vHBkhxfcY5Dy+j3d28n+0bUVeHG0JeQeoiWXeq66jPN+9m7bU2D/wCKiJv6rdeK6emVbAaUJoJ5rhr26c0s2kMIUoCNLgbHayp3GJ0lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 23:55:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 23:55:17 +0000
Message-ID: <9ad81657-4eea-d416-9c52-d62a7c4fdb50@amd.com>
Date: Sun, 12 Oct 2025 19:55:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference in APU threshold
 calculation
Content-Language: en-US
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20251011103120.1262736-1-Jesse.Zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251011103120.1262736-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bab0aac-eb81-4217-753a-08de09eacb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUxHaHlnVlVHK0tkYUlMdU5IcmZDbi9WM0dmcFpZclZ0R3MxWkJ2dGJDR1Fm?=
 =?utf-8?B?dWpnS2hEZ2hWckNDVGdXQlZpRk9uMnlVdHhPOTdqRGtaNVZKcnQ0aGtGVmxX?=
 =?utf-8?B?VGNPOUxKU1VpM2NrM1YxMVU0K1o1bmhpcGV2MGluY2MxVFl5Ym4wWG0rNUxW?=
 =?utf-8?B?dkxCVFFWVnJ6RUlwNlRaRU0vdm1ta1FKQmtDeWFFMDdJeHo4OElTbHBBMFB1?=
 =?utf-8?B?TGNRUStyQ1Y2UXJSekU2T0E1azhqTVpGRmdrV2dZck8zdytDRm1DZEltaGtS?=
 =?utf-8?B?L1J1dGFySmxPM1VUZnlaUmZ1Y0lFSUREc1Z0M1l4VGladVBTUGJQMVZneVZu?=
 =?utf-8?B?NHZZU1ZxeW9CZjVlMGZCbEo3ZkhQN3h4dlArOWFRYnhXa2VIT3JVck9rbXM1?=
 =?utf-8?B?NzNzSktJQ3VrYjNwUjhFQkJ0SGx2UzJmeTNJcXhWMWNjSmV6WG1URHBTOE1i?=
 =?utf-8?B?VlY0UVVSbHlCTHh6TXBCdXd0SklaL2ZSMDZ4M3RHRkdYNlk4MndhalNGQlBX?=
 =?utf-8?B?TmhRQmtnYmw4S29uZWExVEJVc1Y0TkJNdExPeTRGYzNTa0xpc242Sk5zc293?=
 =?utf-8?B?azVrV3FXeGlsNUIxOFZUOThlSlFxeTlVNGdlZG9NaHZSUmNJbUZEMzhzMkxl?=
 =?utf-8?B?Ym9SdEtMUTR5c0tlOW4wRi9WdUNNVEFoREpGRm1vMFNxd2FWZ0daaHhaWmsx?=
 =?utf-8?B?MklrbVROYmRETWRucXN4WkZGWkIyWXhDSVBRUm5nUEtxMEp6R2VsZzVNQ2I4?=
 =?utf-8?B?NUlIUzk0aUhON0N3NURnb29pc0RQNEtJdDRsSjZHcEhHdWJ2b0wxZ3doR1lM?=
 =?utf-8?B?bjBqMXFhTGpWRU01Z2NSYThGR2JMNk5iUlBiNUwvSzVZb0o3QU1ZdzlRZTVt?=
 =?utf-8?B?aGdJZmJsQzIxeFNwTmR3d2t4UTdBV1J5NW1NdURPOHZzSFVVbkF0NVNoMjdn?=
 =?utf-8?B?V0dEZTF0dXpCaWM4ck5EcGdhbjFzK0t0cjlaUG8ybERyM1N3dlJlTCt2Ykxh?=
 =?utf-8?B?dXhaOFE1RzI4ZURWWGplNWRYQ09CdXczakVHMXQ4Z09waERuTURJVTMraC9p?=
 =?utf-8?B?cGxvREZFNzExOG40Y3dJdXM3WEVLOHhvY0c2U1VzK1hmS3RyQzdYWU12Q2tM?=
 =?utf-8?B?emJsMWo5UUNuQUtJanU1dHpYcFZtUlR6ajF1ampOQzgxWWY1R0ZnaWJBaFEy?=
 =?utf-8?B?R1cwVEJrQTUvUXM3UXVRaDViOEJmemcwUFJMeWtDYllMdkNtMVpIdy90TXIz?=
 =?utf-8?B?VDFTelpjcSt6TytYdkl0NGR3MktUc2s0ZGluL0Yyd1poMVRSam93RFZRVjc4?=
 =?utf-8?B?Y01tTnltUko3TGFwdVJEZDRvd1pTSWxudEVMSWI1UDVQaEtQN1NPdWxzd2tr?=
 =?utf-8?B?ZDlzMzdWZTRrQUJlbWVqWGY5bFUySkpNbzEvbW1jOWJwNzFGT3RXZXBqYnhO?=
 =?utf-8?B?MEllVDN3MTc0ZWk5d2hwa3JnclRzNDlOaDRQTFVDZExHYjA1U2psRUFGNk10?=
 =?utf-8?B?LytHM2pNR3QwZm0rRWVXSHB5aCs1eFFJYWxUQUVlZkM0SklVbTBXWE9sckZS?=
 =?utf-8?B?eDN2TWc5cEVQdWoraU41VDh5bFI1c2owYnE2YVhqY1hlUkI5RHIrZTdybVRx?=
 =?utf-8?B?T0kwSVRPTFZ3eVM0d3VFeGRCZk4rVkxkRVVwRklWMGwyMEpNY3ppblJyVU5D?=
 =?utf-8?B?dnZXbGxJT1cvZTMxSmxnNVRMOGtNR0ZMV25EdVRONzFxWEltS09zaks1L3Fm?=
 =?utf-8?B?MmZ4YzFmNHVhUzllYkVNOTljVXQ1NUZZcmJYWjZ5YnVwUkxFZEI5dFBlMnVB?=
 =?utf-8?B?VUdpa1J5Mmx2TElZN05nTHpvQlo3NlRtWFJTMHVVVlc0NmUzOFdzd3F2Slli?=
 =?utf-8?B?Yk55TVVXNk1MZVdkZTZkUVEwSUR6R0NpMjZqcEl0alJsRnNoR2cyNmFLVTh5?=
 =?utf-8?Q?xIOoEsspRNHvbxeKdbAy0rjFfezszVPV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJMOEJMY0hjN0xQSzNlUFZiamU4RlErT0pUWklOY1FzcUE1K1NKWUFKMTF1?=
 =?utf-8?B?Z0Q1RGM2Z3gzWUR6OGNaUE5LQStkWUxvUWpFUUtnTHZjQ1d3VFZuMEJnM1ly?=
 =?utf-8?B?bUhidVE3Z0xoOVhRcnptT1V0eVNpZHRPcnpDNEFFTjVMd0pHVkJZeEM2VEU4?=
 =?utf-8?B?aWVzaW9BWDBxL2tRVXh5VWpqWTNyNFdUcWV3U21YdlljcUpXdXBMTHBaMGYr?=
 =?utf-8?B?MXNWOG5MaWgwazVyTGM3UStFdGZ2YWg3aGF4TnhpY0ljSHdRS1V5LzVJZjE2?=
 =?utf-8?B?aGNaajNTSEg3Znhrc2tzZy9VWjFIb1NNaEpubDQzbzhORjZhelA2Y1FiR3gz?=
 =?utf-8?B?dm1EajJyQXNScDB3UWhuMFBzcmxuU1p3ZzhjTUROVzlnWGdiUnM0K1FjY2Ev?=
 =?utf-8?B?OEZPQlpiemZ6MGNYY2xFd1hZd1h2YjVTaHJxdWlxVDF3WjlwVm1kK1dCSC9G?=
 =?utf-8?B?aGZyV0laUlFxcUxPeDI1MkYwNFBiWjR0NUZVVS9NUTl4dXphUjVvZEhMSFZN?=
 =?utf-8?B?eHRoWFBHN1V6NUxhc1pvOHo4RDQwR3dSSVQzNXB6cmUvN1YzYldTZEE3bWVy?=
 =?utf-8?B?aDZmUXdHcHVGRkJSZ05keDNaL0RoR2Y4QURWOHdxUWxMWFdzYm9HZDl0Rkds?=
 =?utf-8?B?VGRnWGVRUzlxMnB3dHZkNjFYV0tRMmNlUUJ1SGdQektSVG1uNU1WdTUrS1Jk?=
 =?utf-8?B?SVBxK3ZiK1FBeHJCVGtjMFEzbFFZL1FMMWhiYktqQVdtMmtWQVB5V01TT2ZB?=
 =?utf-8?B?NUxSMFZVRDhWTHE3QkxvRlNqdmhOOUFVeWx5QjNzQjBIYUEvazJ5Rkh1cnVy?=
 =?utf-8?B?L2IvVUdJemhXMmNEN2ZJZ1dnUldibFJkV05CUFNzWkVCK05yb0FvNEk0b3FD?=
 =?utf-8?B?ZDJZZ2RycFBlcXRnb29ZUUNUOWpvaXlDNG5XRGJRWTFTUGpNUVFIaWltcnlS?=
 =?utf-8?B?UkJJdHVxbEtaWGl1cFFpcHNEdUJSdFZoTzZBeWF1YXlCSmV3cnBBV2RTSXJL?=
 =?utf-8?B?ZjlKMWtFUWJhVFdSOU1uYzhZaXpaSzRIUHkvZXpWTjFoQUNyMFE0Vm9Tc05N?=
 =?utf-8?B?U2tIdjBlMFF3NkJ0Qm1RYTFjTnZBUFJCTTZGMDh5RnNpUU43V3VsTGY0UWRx?=
 =?utf-8?B?Z3p4c3pwNy9hL2g1cFkyUk1iOTFJbUcvd2FnRTBTbi9KMXZDUHUwZ01oeUpP?=
 =?utf-8?B?N29jZGFkVzFSYzdTWnV0WVRjaHFzL1ZmRkdrY3dBNllhdmVSUzl6SWdkMlFI?=
 =?utf-8?B?aXNSb1Z0c3I2SGd0Vk41Z0NyQlJXQXExVXFnekJmZG9Zbm1SWFBHZmNaUUJU?=
 =?utf-8?B?bWI3NGR4TUZ3T1VBVWMzVG50dUsvUE00czFsZWlwUlhpdm4xZTljbXNyY0Fh?=
 =?utf-8?B?LzlrRUlhS092OEhaREoxNVdSUDdkdGxvTFJHVUZxZzY2WWxGN2cxQUdXZ0ZX?=
 =?utf-8?B?YXBZMEtBY3N6bFNWMGxlK2phL2M3aTZUSWNlRHhZc1VOaFFwK2EvVXYrRGJJ?=
 =?utf-8?B?L2RRaVdmWW80Z1JBcjUzZ0pjczdBZ0RxVk5QaGp6Q3dvTUY5eFpKR1o2Q0pL?=
 =?utf-8?B?Sitkekd5cmtKZnZYUTZ6VFVZYXhTaFNrU0hqZVpDNEZkRGxONDRaL1NhZTNt?=
 =?utf-8?B?ZWU2WXJOL1JUazZjY2pXWHJobm0vWXNKTGRHYVBQSUsrUUlaTysxZ1l2REZZ?=
 =?utf-8?B?Y0kzbzVHLzg2S0o2VE0rSEluNkNQZkNDUVR2eTRzNFFZQXpGdkM4emNCSVI2?=
 =?utf-8?B?d3FMellyTVA1UEFhTnhqRzY0MCsweWJUVDhnTlh5ZjVQcHFPeVBRMnB2UmJJ?=
 =?utf-8?B?ZGs2V29jTXRIV3RTcDhrTUdBeDNRcWNNNkdLd2FwQ2lnWmFkT1duOFhoUXZy?=
 =?utf-8?B?TWtXT1RQS2hsRHNZNUR5byt3dnVETE5oNGUyZnZQT29BNTFjUE5wM0U4QVls?=
 =?utf-8?B?b002S2ZYay9oeW9DblRhVkQ3R3lYL0VKdnQxdjlPbHhUbXFJNGh3NTMzWDVp?=
 =?utf-8?B?Unh5cU1TNktEc0FJZUREUWdNeGtpRUZ0V1gyVzdLS2Y4N3FyNXlSYUNCbkNB?=
 =?utf-8?B?SHB0RWttK0haOGVFN1NXVXNPSVpkcUNOODZHU3Z1TENCcUlmVDhOM3NRM2c3?=
 =?utf-8?Q?xTic=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bab0aac-eb81-4217-753a-08de09eacb61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 23:55:17.3959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y5miK3aIFYgUt/QIaIHeG/QgeAW9jdtxbANurx//yK1IFjfBrGVVtLKFlRYVf5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
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


On 2025-10-11 06:30, Jesse.Zhang wrote:
> The kernel OOPS occurs due to a NULL pointer dereference in
> amdttm_resource_manager_usage() when accessing the ttm_resource_manager lock,
> specifically on APU devices:
>
> [  911.954646] BUG: kernel NULL pointer dereference, address: 00000000000008f8
> [  911.962437] #PF: supervisor write access in kernel mode
> [  912.007045] RIP: 0010:_raw_spin_lock+0x1e/0x40
> [  912.105151]  amdttm_resource_manager_usage+0x1f/0x40 [amdttm]
> [  912.111579]  amdgpu_cs_parser_bos.isra.0+0x543/0x800 [amdgpu]

I just noticed another NULL pointer reference back trace from 
amdttm_resource_manager_usage, when using rocm-smi on APU, maybe add 
NULL pointer or is_app_apu check inside amdttm_resource_manager_usage?

  BUG: kernel NULL pointer dereference, address: 00000000000008f8
  Call Trace:
   amdttm_resource_manager_usage+0x1f/0x40 [amdttm]
   amdgpu_mem_info_vram_used_show+0x1e/0x40 [amdgpu]
   dev_attr_show+0x1d/0x40
   kernfs_seq_show+0x27/0x30
   seq_read_iter+0x126/0x490
   kernfs_fop_read_iter+0x150/0x1d0
   new_sync_read+0x101/0x190
   vfs_read+0x147/0x1a0
   ksys_read+0x67/0xe0
   __x64_sys_read+0x1a/0x20

Regards,

Philip

> This happens because APU devices (adev->gmc.is_app_apu) don't initialize
> vram_mgr.manager (no dedicated VRAM), but the code still attempted to calculate
> memory migration thresholds using VRAM-specific logic.
>
> Fix this by:
> 1. Merging APU check with the existing bandwidth control support check in
>     amdgpu_cs_get_threshold_for_moves()
> 2. Returning 0 thresholds immediately for APU devices to skip VRAM-related logic
>
> This prevents accessing uninitialized vram_mgr.manager on APUs and avoids the
> NULL pointer dereference in _raw_spin_lock().
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5f515fdcc775..d80414b32015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -709,7 +709,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>   	 */
>   	const s64 us_upper_bound = 200000;
>   
> -	if (!adev->mm_stats.log2_max_MBps) {
> +	if ((!adev->mm_stats.log2_max_MBps) || adev->gmc.is_app_apu) {
>   		*max_bytes = 0;
>   		*max_vis_bytes = 0;
>   		return;
