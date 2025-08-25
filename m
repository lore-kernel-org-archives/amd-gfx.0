Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05938CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D45A10E4DC;
	Mon, 25 Aug 2025 14:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ns29hYdq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C9710E4DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL2Iv0/ywbhqE69vDh3EarnnPzbbvX0kDP6C+ZvsYs/soU6gtCL7oO+znNMaopVhKT6O2tf4qecQgiuGJaAfN6Y/uaNCL71qZxKaFRU/Q94z9tfpv2yFSYc6fcCsRabdFzwBk2+1jOn8g9AuXp2P5SCCVrgLI/aIjmRCb/NiQ5KAxqFQJzNja+NCQzYqP+vlLQv8R8LSrQTIZ5l0UxOMmyV/DQerw1PV2ji+8WSqqvIzuTv4QMHhAdcg1z25uo1lcN2xtp7f/OH1v8k3KPQiX1O4LHGcKjHwDLEUEBuYMjSLuh6uf+2YirV2m3H+Rgd940zRE0Tabauf5phieArujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MW5qBiEi2LRYj9LqfpYcQyiT0p0TXfTlpl/Czn7Atc=;
 b=XYv//yukrBfTHAtGHtsNNg0p04pc5wl4odZ1bCqlI11xX/lc1Y2Jerma98AeWdFkebLZpe7S69sQFPUttwX2SQSesSrx3saMBYRzhUERvBYXCZ1AwsLtYdnwUCHms4zYxcWKEvTdVQmYS8wZ3cykvQcU/6cY/LLleyaotvhrtP2+N8ovOaM5gfr12Wr1i3nyaig30JbSSjMH6S4h2Nr5EYNrVH7Gj6nbUxonJUss6+phiLoC4P8vnkv5WZb/gYKzuNSVt335Ie1QCHnzgSp4keC2iXVX/9efOSg2eC/sqqWC1A0m+/6K5xl+foUzDbHEWGvYQihZFWlzzGmGh3yGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MW5qBiEi2LRYj9LqfpYcQyiT0p0TXfTlpl/Czn7Atc=;
 b=ns29hYdqq57Tyl+NkTPd350fzdJKsRNR+25VbOiORddF0nOx8dOaAFMZVu/s0/4MrpGbfnVPWRMJyYCdYiupeenCIhbBJSBJKr21hGOyeZwO2lA+YdlGONfkO7v5gquVSdCfSk3FPoRPqElUhbmv350xHTBH4U06ejkBK9VZ1xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 14:43:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:43:31 +0000
Message-ID: <9cde7098-ecb7-4a13-9c16-7c1fc75f7d07@amd.com>
Date: Mon, 25 Aug 2025 16:43:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820113254.3864753-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:52f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 320cff6d-f5e3-40f0-59c0-08dde3e5c29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG9sV3FadHhFZWVodEl5MmNnd1hmekJUZVY2YnIzY29MQitYL3FMRHZXdWMv?=
 =?utf-8?B?YmRhSmJCSzNoU0kvM2JnQ1ZkQWhkRTFtVGJIVUdHMWJKUGFJUWw4NndQVkl3?=
 =?utf-8?B?UWZZRitVMW4zVFJWUlQyS3d3Rzl0NjNqTEk3UkxHcGZ0Z0txWWRRUHJQL2hJ?=
 =?utf-8?B?ZHAwa2htUjY4d0VmSGgwSjZBOVBuY1NZN1R4RVk0LzdwNkxZWlpHMzRNSVM2?=
 =?utf-8?B?TXBUSjhvUm1wTUlmRHJCdkZrcEprOWY4WnlCNE0yQ0ZFNXRMVFpjUWRNam9D?=
 =?utf-8?B?aURJVW1Hem44Um5NZlZtTmVPV1gzRHNmMFhwNWxGeUdqeUlFdUU0bDB4eTVP?=
 =?utf-8?B?WVF1b1F6THpIRmgwMFRIb3dlK2xlT1lJSFZZclFRa216REdtSkpNbUFhSGRj?=
 =?utf-8?B?NmZ3MHkvQ2RPaFErbFJ4bjA2QnpVWTdnVW51Z0RXNzExNzdIbkNoMGx3Y05C?=
 =?utf-8?B?YU9vNStKckJyR1pvQzE0NWQ0dXhYNVlKUXBuTzV4anRacllVemtoS1hoVnJh?=
 =?utf-8?B?aU1mZjhnT3VjRFlGQWtEbEcvbHJpM0dnbTY3RG9XR0N6VEgrTEJHUEYvUEhk?=
 =?utf-8?B?MlVYZnJDVWtwTTBhR0hvY0VIUDJha2N0V2hnOHl2Ykd6dXhydTl5cUZ2SXRi?=
 =?utf-8?B?OUJsWm9LUE1sQ1JmTnV4Vk9vUFRON2NoTFdpQ0lTVnhUcXBiSHhycGlVd05l?=
 =?utf-8?B?aSt0VWJ6Q3Z3NEtwYTd1aDg2M2lmankvcVVPVGkwNkJmME9TRnFmMFJvY3pk?=
 =?utf-8?B?YThJUG81NGJocy9LVS9Ic1cyeTBmekhDUUxJTjEzY3kybGpiNHkvWHFMdGhJ?=
 =?utf-8?B?RlZMS1JVdjQ5VG5sc2ZNQkROS0ZMcVdvVDdKeVlobjZLdGFmQldWWFQ3b01F?=
 =?utf-8?B?TGNrd0E1QklZT1JaSzliTkQ3ekt4c0dpWVNSOXRLNm51U2IrNXoyYU41Tmht?=
 =?utf-8?B?bThVWDRBb2sxWUNLRzVEcHZDVzdBMEhvR0RvMG93TWZ5eHgvV2lYdWlYTzht?=
 =?utf-8?B?SU5UdGxZcmJOQzQ0YTJyVXNWeGh2R1J0Rm45WE5yOThxU1dsQ2tneXY1Sjln?=
 =?utf-8?B?Q2sxbENhRjJpZkVKTGF3RWlWd0RuQ2NVdDZFNTcxc3VkQmhWWVI0YURpM25S?=
 =?utf-8?B?bWRGQmFQTzZuNm5XS0cxcmlWVlhrYkhtcDFmRlNXMnZKMi9iSWVzNjdsellY?=
 =?utf-8?B?cGFEandyZGVhblBNVUxvTmVRVGdha0NFVXcxODZ0SThZcHhqdXVTaWE2TmJN?=
 =?utf-8?B?d01YbzhITm56MlZjdkc2VTlPTUV2cmZwSmJmdDl6cWRRMVlvZkJIL2FTOHgy?=
 =?utf-8?B?b09oYkRVVU5KS20yRVNtTnpwRFBDcmJHczdoQlNCeksrTCtPU21hbVNlZjZS?=
 =?utf-8?B?Slh3ODA2T1VSMWxzQUNTUFNMY28wcHJ0Y0J4MGdvSjlEcE4xdzM5MHl1SHhr?=
 =?utf-8?B?WktVVmFWMk9yV1BXem12K3F5MnNFZ2Y5dWZNL3NFc1FnT01mNzZXM2YyR0dX?=
 =?utf-8?B?aUhiZ1ZlV3g5OWprend5cTIxU1l2aHFJem5tcXo5dTdvUXJkeVNENTJUNFNs?=
 =?utf-8?B?TC9WSEFrM005YjMvSU1zcWtOK3I4citSVkphTnN5WVBreHFWb1hCeWFtc3FE?=
 =?utf-8?B?N1F3cXhyUk1vRCtCUTl1VVBseEFNMHNVKzdadzE4Wk1NM1NTbXJzTytobG1N?=
 =?utf-8?B?K21oMjE5NWZSaXJtRUVOUjhSRkxxYlYwWWdZaFlVRXNabXV1WEdETVJrZE0x?=
 =?utf-8?B?dnFUaTJiVlRzMEEwbjhxdU1ZSDJJcWJOUkNpRU5HMWdaUS8xRUx4dXNEWG1J?=
 =?utf-8?Q?IN5dnbSUaKrH927IssgO0XyR8aWg+m7ncQFQM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHcwU1g4QWtFRTN6V0IrTFdSNDUxdUFaRGQyL1luVGsrKzVMaTZyemFabFQ2?=
 =?utf-8?B?UzdiMWxObmpFTHA5eUdwS2ZUZ1poTUlXakQ1VEUvaXdzU2w3NEw2bzJGbDJw?=
 =?utf-8?B?eFVXVkRMUyt5eG54VVdINGdma2U5ZjB1eFB5NURFNkwwN2NvYnhCQTF2b0NK?=
 =?utf-8?B?SEJrWGZuUUxoakRjZjB3aHp6akJBRE5Hb3dUNDJYWnFrYTRrUndMTng4enBi?=
 =?utf-8?B?OUc3R2UrdEtRZWh4ZGVrM1JlTkRYQlA3U0lyODA5WW81VlhZTzE2TFdPNjFs?=
 =?utf-8?B?QWdGR3dRK1FBaktCTGYxWk9OVVJOOTRUeldZL2ZzNXpaUFdhSHFwQjRVSGpJ?=
 =?utf-8?B?RTg1ZmRFZHpFM3FHZU9pN2d5N3M5L3dTQW15cUlSZk9jQlVlSDJFVzBxb0lI?=
 =?utf-8?B?TGUvMFpTRnQ3UUNodGoraEZoM01OeTRYSWNsdERxVFFaOE1pVDJsOGsxSDQ0?=
 =?utf-8?B?SFh3VUE5cDVGUGdJNy9wd21pc0QvQkJBdXFGVm9UYk03OWhBaDZualNqZjNs?=
 =?utf-8?B?L0NRRHB4MmNqakpVTVB3RE5hSkQ5YU9ib3l6dHRHOStaQkVFVGU0M3Q3bFhl?=
 =?utf-8?B?MzU4VXNhbU5mcHBUeTBDcnNHWW9ydnE4TGJDVzVvdFp0dVZHeFNvUE9UYkdL?=
 =?utf-8?B?SFBzTW8rMUt6bmZyaDgzVytIQ0tEaEwzYUxYT1VKWWR4bjFua05Xc0hJb2FQ?=
 =?utf-8?B?d3IwbWs3alVBK2JEbzBXYjJ0cHk0UmExM3B2czR3Z2swMmlFSzBlVnYyTEZY?=
 =?utf-8?B?MDFadlZOekM2UW9vbm9wd1VDc2xzNzh6eXlvZHNxZW1sTzlFdWxUdmhIc0Vj?=
 =?utf-8?B?NmFKa2trUHhMMzArR2MrV2JHVzlTbmFFNXFZRUZMQkR6SG5rdXpITnBuQUxS?=
 =?utf-8?B?K09wcDk5aWVmSHFzcGs5Si9kekpaQkhKa0xEb3J5SUdNNE1WNjFzZHkreWk4?=
 =?utf-8?B?RTQvNW9MTHl4RlY3blZaZW1FN0tWSVA0RThacVlCU0FlM1FveTlDZUpwbHJN?=
 =?utf-8?B?dXVRZXc1L0ovNDRyc084YTQ1bnJoeFMrWnc2N1RWWkFuTDl2dzgxQTl0WEVy?=
 =?utf-8?B?Ym9oME5zZU4yMFcvM0tSL3AxQkFHeGJ2enZmRDQ2QkVMRTBGSU9lenNYNmZr?=
 =?utf-8?B?MXhSanN0aFowOHVlZ0pkK2Nqb3V1R2V0dGtzTnh4TjZaVEMxUmxQR1lISjJH?=
 =?utf-8?B?R2E2ank0Z3ZPbmhLK0RhWWJNTzhJdkhkcnNkZnNFM2RoaC9WTjBnbWRRY1Fh?=
 =?utf-8?B?SzYzZ1E5NjF0KysvTHRRaDNnSk54TGlIM2VyR3NXUk1IRDVvWlNRQjJvZmNt?=
 =?utf-8?B?dWh5MWN6c1NFcUhGRzdUQTgvWUVDUVAxTDc4b01rRkM2eVByaUFOQ2xaZmVL?=
 =?utf-8?B?Q0l6ZDlqOTRhYVFTYjMzRm9jKytqK3Z6NERHcndPY0lFZTZQcFl4WE43em9j?=
 =?utf-8?B?WTdBUFZqRm96bjVzRzRtQWVZdW1odCttdnZldURZRzZ5QU5kK1haY3Mrdnps?=
 =?utf-8?B?WnBKcjRvQUtUbWRpVDFMbUd1Sm1vUHAvUW82WlBhL213S2tvM0JRTEF4SDg0?=
 =?utf-8?B?NjlEU0NBQjZrNSs0NVZWb3Uvb2phendrN1k4ZDFoZ3AvYTZDaFZ0RkdQQWph?=
 =?utf-8?B?dExlblJZWlp4NkZ0cmtLRnFRWVFEZGVpbSs1UUxTemNJWWdYM01DaHhKVXg3?=
 =?utf-8?B?ZC9HMU5ENU5Da0MrTUN5eCtwaFdkcEV1Q2p6UXNHQTl4NEdKcExYeDVNV3ha?=
 =?utf-8?B?Wnd6c0RYbXc3WFdQMUFXa0NObFZBamZMMTZBeWNHRk96dXp4OTZzN3hQd3Fa?=
 =?utf-8?B?RlBqb0x2cjhwS0JUc3M5VmV4UGg5aTdSczZQbkEwUWRLVmN5VWpLQ1UxY3FI?=
 =?utf-8?B?RVVIRSt5U2NuZ0RWaFJLOGl1WnRrZ2ZYOVVjUlM4UEljQm94QzV2TWZVa1NG?=
 =?utf-8?B?NExIczk4WlkyamcxRnF2NUoxQWIwbFVnR3FrTlRJN0JBcGJWMFBOejdFWmsx?=
 =?utf-8?B?TmJ3bit1NFkrMFp6a3hCNkkzUmdrVHFuYisvcmJQOUJoTXhKNWV3aWdGb3Fn?=
 =?utf-8?B?UWpiRytYVUpYWHNXTkd0bGpPN3lqTURsSTZUc0xGSmlxY2xsMnhncDE4bVZP?=
 =?utf-8?Q?8mYfY1FF4r1DmUcv4VMyiryaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320cff6d-f5e3-40f0-59c0-08dde3e5c29f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:43:31.3123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuPnEyzEY4qAqBIbzOsneaysTjx6gTa89jtLWPr2Uk6rkqwTx2wKy2WOjrKbrA3t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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



On 20.08.25 13:32, Srinivasan Shanmugam wrote:
> Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves
> as a CPU-visible IO page:
> 
> * amdgpu_evict_flags(): mark as unmovable
> * amdgpu_res_cpu_visible(): consider CPU-visible
> * amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
> * amdgpu_ttm_io_mem_reserve(): program bus.offset/is_iomem/caching using
>   the device's mmio_remap_* metadata
> * amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
> * amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 +++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 27ab4e754b2a..157a5416a826 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>  	case AMDGPU_PL_GWS:
>  	case AMDGPU_PL_OA:
>  	case AMDGPU_PL_DOORBELL:
> +	case AMDGPU_PL_MMIO_REMAP:
>  		placement->num_placement = 0;
>  		return;
>  
> @@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>  		return false;
>  
>  	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
> -	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
> +	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL ||
> +		res->mem_type == AMDGPU_PL_MMIO_REMAP)

The indentation here is a bit of, you should probably check your editor config.

Apart from that looks good to me.

Regards,
Christian.

>  		return true;
>  
>  	if (res->mem_type != TTM_PL_VRAM)
> @@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>  	    old_mem->mem_type == AMDGPU_PL_GWS ||
>  	    old_mem->mem_type == AMDGPU_PL_OA ||
>  	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
> +	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
>  	    new_mem->mem_type == AMDGPU_PL_GDS ||
>  	    new_mem->mem_type == AMDGPU_PL_GWS ||
>  	    new_mem->mem_type == AMDGPU_PL_OA ||
> -	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
> +	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
>  		/* Nothing to save here */
>  		amdgpu_bo_move_notify(bo, evict, new_mem);
>  		ttm_bo_move_null(bo, new_mem);
> @@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>  		mem->bus.is_iomem = true;
>  		mem->bus.caching = ttm_uncached;
>  		break;
> +	case AMDGPU_PL_MMIO_REMAP:  /* <=== New HDP domain for remap page */
> +		mem->bus.offset  = ((resource_size_t)mem->start << PAGE_SHIFT);
> +		mem->bus.offset += adev->mmio_remap_base + adev->mmio_remap_offset;
> +		mem->bus.is_iomem = true;
> +		mem->bus.caching = ttm_uncached;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -640,12 +650,20 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>  	struct amdgpu_res_cursor cursor;
> +	u64 pfn;
>  
>  	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>  			 &cursor);
>  
> -	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL) {
>  		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
> +	} else if (bo->resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
> +		/* Return PFN for the remapped HDP page */
> +		pfn = (u64)adev->mmio_remap_base +
> +			(u64)adev->mmio_remap_offset +
> +			(u64)cursor.start;
> +		return (unsigned long)(pfn >> PAGE_SHIFT);
> +	}
>  
>  	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>  }
> @@ -1355,7 +1373,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>  
>  	if (mem && (mem->mem_type == TTM_PL_TT ||
>  		    mem->mem_type == AMDGPU_PL_DOORBELL ||
> -		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
> +		    mem->mem_type == AMDGPU_PL_PREEMPT || mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
>  		flags |= AMDGPU_PTE_SYSTEM;
>  
>  		if (ttm->caching == ttm_cached)

