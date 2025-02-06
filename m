Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57057C02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C8C10E88E;
	Thu,  6 Feb 2025 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PFZLfYZU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED9510E881
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9rIz2cS41z6kJMjfzQI4lR8yUPpmhpDnNs5+btqeLvz12oAMuF63fZnnZEw48oFXK3TAWYkELeLrc9lgIJhx4FPDnFML3RlfSBGlwcyTF5tOWwIjebNb1Gj5VLVT1UfJuBrZW8/79Gz29Iye2TGEtOdCoWoE7/Lkco9NCusMyLL2mAhMijAc9z1IuP/Qf8KKAUsMhiau3Dfiy1JaFDvuGVUWDI35Ju3FUCzcV2BKLroGm8r61w7iCT8EdXd/DxYPAGY8b38rGmD9/iBcWUDHbfJG6XhZgCZAVX+hl2VWnIZ/G3wZ5TXEC0F8MiRQaBUPlN2hwG+yVjk7sBx0qKBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC6WiJ+zyZFJ6QhCzJQgR4f+BjB3G/OnNPCmecbxqy8=;
 b=oA/VBj8clWD0g055AzFc0CLcRBzoFvGczOQmkJSbc6AxHOibK54+N0EVsHp9MNUwQ19X34UznoBogXP1ApvIMYmSCprxPUyttY/eWoVM9pemeapCrqJkn0FsUniy1udCjTDlTPsJL1L67dNu/8NnuC46rs/1VfsMTEoHdtBAjAO2pdx3d2hPunvlNgo2XwwPUtmDDNZDTNsp91hbQrif+ACTFBS4AKM2oZ555vyii0Lqdh7LvVfJ/HTwIyH/Gxv46ptU0fXslfnFPD6Rh7tdreCwChJKXjnDozhSSYPpIrVL6bqWdYD9knoKLuzsBRCiWB0E6KXE7YoMhMR0nfYISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC6WiJ+zyZFJ6QhCzJQgR4f+BjB3G/OnNPCmecbxqy8=;
 b=PFZLfYZUNUTa3GlT/HvMWkuDV5ONNl6HvVy/XG/aqhY/PniJLQdGL4TXg0Rd6uJyXVuq+HI5Wqu2NAwbpCZA7671b6OWSSC0CJLU9eHJcixBlEMDB6u8N45kydQPss6dvFJG6yBaSgqIHOX3dF3rNjgvqF+pAnQLEttkwYdMG9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 14:59:09 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%3]) with mapi id 15.20.8398.014; Thu, 6 Feb 2025
 14:59:09 +0000
Message-ID: <403431e7-0b2d-44c2-9e75-9593ed6a0625@amd.com>
Date: Thu, 6 Feb 2025 09:59:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20250129152029.32275-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::13) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b40a45d-26a1-4148-9fc5-08dd46becf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlpHbGJrc3RCL0ZWZEt5RTFidGthWk5nVUdvTGRPbE92TmZOTlRzSjdRZnNS?=
 =?utf-8?B?TkQzYWRvNUpEV1dwdkJmdEQzR0hVWTVGMHF0ZHZlaGlWSnpyWDhnR0ZHK3Bt?=
 =?utf-8?B?V2JhSExYMDd2U25JWEE3Wk1OYWNaMlFNTEI3Z3MwK0VUWDZOdGFOVk10ZVF0?=
 =?utf-8?B?SXhTRDYrNmFjcWlTdlU3ejBiRlc4eExESzRGNjR0Nlkwa1ZYbmoxWlYyYUM2?=
 =?utf-8?B?YTBSRnpMWjY0TWRuSldmb1lSZW1MWk94N21zZGNpbVo1UE81eEtibFFVbis5?=
 =?utf-8?B?SjlyQWxpcSt5Q3RYYVFTbTRNRTU2eHc1aVpwYVNWV0s2cXYyQjFjTGdDakM2?=
 =?utf-8?B?bzJKdHovS2hSUHlQck94K2o2aFZtQXFodEpoZjZ0eHM3TndadDY2M0tJcnJV?=
 =?utf-8?B?K0o2R2l1YzRJNSt5SXowQzV5OGxwUGVpWElKeEVGYUZWendtM1ZBZ3pabkM3?=
 =?utf-8?B?M0MzSDc0eW0zNnRyaVJhdHRqSCtEeUhzcGpSRXBwN3RTLzAyL0ZwY1VpYjl3?=
 =?utf-8?B?bG5JYmFMMUFUNEJNbVRtOUg4QkRKSzRlbkgvMG9lTjMxZGZMWVlSanpJdWh1?=
 =?utf-8?B?VUJkZnJ5SC96SEFKSUdXY3RzZGM1dHhXR2k5cForK3NIYjBncHluVGtvYVR3?=
 =?utf-8?B?ZVoyRHVRNHVaVnZ5NkxZSlc0TXJmV1lFcWhUajhSbFdSbEZaNVI2NDZPWmg2?=
 =?utf-8?B?VVBraUxzVDhaQkZaYUVpQ0l6SWhyM1FDc2oxV0xBTUFlWmJibWRTWHhBNlJ1?=
 =?utf-8?B?R2lVUW5EVzl2dkZKTkF5OXpGTncvazJXRkhxZjQweW1HcmlkM3d1U2RQMVZS?=
 =?utf-8?B?RzAxaHEyUFF5TldxQ0RoV3lNb0N3QXp0WGtPdU5mVTZwMHNGczFYUDVFa0dv?=
 =?utf-8?B?RG12akdmMGsyQ1JPZkY0MjE3NnFsK2lvclh0Q3Q5czF5YjlKSkJYdWVYQnBm?=
 =?utf-8?B?TVIxMHlUT0Z4QS8wVVpFYU5PWGV0VURwUzlFT0RUUkpsZUlST1FldWxGRksx?=
 =?utf-8?B?amxycmRvVUxEZkY5MEd1aEJ5MWZZZWYwNExYL0F2TDdZL3kxNTA5Rm91MlNR?=
 =?utf-8?B?R2poWC9Sb0xDSDRUKzhJMGxPcVV2TUtYQXBBYjJFOVR4UlJNS2R5dVNlUFN5?=
 =?utf-8?B?ZXVxaXV5d0Q0MlFKcmY1QjRBclA1OHFKQ0M3SVowMng3RVkreXNrTmRzZjR5?=
 =?utf-8?B?ZUtmTytHREl4QWFaUCtNZnUyOElGeUx4OCs5OGpReXptYlJ1V09QcG5uZ0E1?=
 =?utf-8?B?YVViWjUvZnEwendwU21WelREQmE4cnFxN2ZjL3RHcEUzaWs0cHo3cEltSlpV?=
 =?utf-8?B?am1MUkl1aEZUY2JpRG50UVZsYStWUytlVGNhUFpSR3hyb242bldaMWN3UGNo?=
 =?utf-8?B?V0M0YzRueHp4d1N4MXdLM3RuU3p4UUFTdlZqeWVwTDZQNzRFeUVMdlBmRXBi?=
 =?utf-8?B?UjNHN0kzVlBSRXlsSjJzaUN2VERHOGNoMG42ZVgxbGx5ak1FblE5WUxPcE1y?=
 =?utf-8?B?blQybjlvcmlsVmdDc2VDYjZhQy9JU013eDR3YmlySzRFOUc5MlorY2JZUzJH?=
 =?utf-8?B?VlNkV09ud21CbTNzaDMvYTNjUXI5TEVKOXUvaGVYd292TnNkQWZHUGNFZ1BU?=
 =?utf-8?B?WWNFQU1sNkw3WUJ3ZGZsamVTZWJJWEpaZm1yR0JsNWJteVNFSWQ5WkpuTHh6?=
 =?utf-8?B?RmRTT2w4Wm9PdGJJN3RUQjNxaytEaWdTSWlvUUZXNHF1T2JPSitwb3FJRTA0?=
 =?utf-8?B?dGFqSmpJVG1Mb2dxV0ViY0llMTB4VXQ5K25MMVZpZU9vcjRIOHJ5YnRicWl1?=
 =?utf-8?B?OVo2N0Y1RTc4cTNLN0haOWJudDY5QzIzRzhKenAyS0o0UU9PNHg5ZU1NVWMr?=
 =?utf-8?Q?4nTDl64UQ/jgq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajMzSmJsTlZKdU11OVRMenhLdXV6bFM2bi9keStCY2JyUmRtZ2lJcWlvR09a?=
 =?utf-8?B?TVlxMytTaHoreFRVYlE1dHFnTGxMZ2hOQlJQVXE4UldNM21xa2RzMUNqbFpl?=
 =?utf-8?B?VGI1Vks5M1pWcjh0enNoRlEzRnJjdkJXSGIweG01aUNHTS9EcnUrQzFPWFJw?=
 =?utf-8?B?Vm9wamg0b1F1ektXRC9pR1BoaHk4ZXlnWVlCbS9BZzdKamFSSGM0cTV6VkRY?=
 =?utf-8?B?bHh0M0pOVzBLTXNId2FTQm01cTZkMGs1a3RTQ1FxTVBoWVM4Q1QyYXdqTDRr?=
 =?utf-8?B?dTVTZFV6NnI1T2JXdjVUTmxnYStNTGMyaWFEeTkycFZhelZCU1pBRTZkV1RE?=
 =?utf-8?B?RVo3Nk9ON0NsQWV5RnBtNk5EQjQ2YlFMOGJ6TGo2NW5Ub1VQMkdOY3ZVem1N?=
 =?utf-8?B?VCtSa3ZGT3ZPUHh2S0ZhTU5Gak50ZXNrNnlrUWM3VXFPc05pTUx3Y2llR0tL?=
 =?utf-8?B?MGhObDFVUUNDODRhNktwdUo2bUYzalRUOGErNy85d21URThzWGdyNnVFWHI2?=
 =?utf-8?B?K2I5WEgzMURpQkd0aThjdDhJeGNYbEJ3bDVTbDRTbWFITVdQcGh3RFZGK3h6?=
 =?utf-8?B?aTJEcGZFcE00VnVSWUh3UUFUMlF6Z0IrdTRGeGhXYUNsZkZoeHZlWmhEMFo2?=
 =?utf-8?B?Y0MrRDRPelh3NXh5dmt6dkNoSjF4R1FYbGFNMXRCanBnem9HVTZJYVFpWTY1?=
 =?utf-8?B?dXVtWXRyYVBPTHhHM3BCdjBjQlhpc25DUHdSYjBzSFhWa1FOT3hlNEprOXNI?=
 =?utf-8?B?WEtWTlBidEJoaGw4Zi9OL3c4UnFVa1JOdlBielBTeEp0Nmo0V3FCcDhCeUpq?=
 =?utf-8?B?R2Q0OGJ1Wm1yUW1HTkR6T3R0UzBPbHhaWk1EWnRwcE0zQ1dNd3IvN0JZQWtZ?=
 =?utf-8?B?bHgvMDQwc1JzRk1KU1FyeWRrNHlCZ2h4dUM2WEIxdlppZytHMjdmN3FsMWtN?=
 =?utf-8?B?OXJRclFXRG1uZ0pDRU9LVGJsMzdnREwrcFEvMDN2eVNFV0RIK0FWZ3M2Mktz?=
 =?utf-8?B?WW90eTFJb3M5ZGhyblE0WVNNVHpqOC8xblE0elhoYk8zYUw4Nmp1L25aa1RP?=
 =?utf-8?B?dXAzeG55QUhMcVRLZGdlTG1FeVFrQXNySkxoQ1BDbXlBYzM4V296VC9oSDRu?=
 =?utf-8?B?YmoydTNWS0s4MVR4VnRYTmFQMFFobXlrZkVCeXl4ZDNWUm1saGhDQWZJZ2Rz?=
 =?utf-8?B?M0VCZ0Y2RCtrV2llR1hNMnJ5Ui8rU2xRamx6OVhVMTVZY3ArakRvUEhGNmFj?=
 =?utf-8?B?UE5lUXF1SWtJVGpWOXgrbkx4bUdFZXhTNUwzZ04xWFhneC96SSsxSG5aMDE4?=
 =?utf-8?B?Z1BaSkYyZ3lqbGRNNzZlM1pwcjZ5K3E4c1BuajJEckRwK3d1eW9RMWQ4dVZn?=
 =?utf-8?B?UlRycGttS1FSUUw0dGFuTjR2aUxqWi9jRXZXZ2djZFRtd0lxRWJER1l2Tmwx?=
 =?utf-8?B?a0RaWkF5Y3k0UXVoaENBT0hxOVRYLzliR1lORy9tNUdLbWZrbTUrOE5qajFT?=
 =?utf-8?B?S3IyaHQ0aWZoK0djNjVQQk15aTdpK3piRVZMQjdIN3VXcHN2SDhQTVNNaElp?=
 =?utf-8?B?M0M4VVRUZ014M1FMTzBnWmxxM0V6bittakJqemZQS1UzVzVma3hKSHcyeENR?=
 =?utf-8?B?T1VoYmdxcHdabW4yQ1dxcWhDRUg5R2NxbzZjVWlBUjdScjc1S1ZjN3JVc09O?=
 =?utf-8?B?WEZvNW1nZk96a1l4UTFFUXFvQ1ltMHJ0NEVRVjJkRWlOcGN2bjBuTGwrS0wz?=
 =?utf-8?B?TG9sVFJuMjk4UWVEQlE2YURlUlZLZHEzelJ0NG9qaVh4SzdWUUxYQ3NYVEtV?=
 =?utf-8?B?K1ViVlltQnMwaGZWZU5oNlpNYitndXNpd2JMM0k3R0NPb1hGUjBVRHJsTlNG?=
 =?utf-8?B?UU9nanNocGJ4V3gyVERyNS9Wdzl3SjYxT3REZjBNVW44ak1XaXAyamJTaFdN?=
 =?utf-8?B?UWM1MkpkS0ZFb2RDdmVxMXZQbXRqMEFXK3dZOUJOTndFRno4RE8xSGZDL3Vq?=
 =?utf-8?B?dURLQ3V5aG92dFp1WG54ZnlPR3RrRDZKSVpWNnNVZlprblFZbHlZRlpPWGFl?=
 =?utf-8?B?cjY0anlYSkkzTVk1MW5iVzU2TmtvUWZHOGd6ZzRmWnJ4V1c5L0NsOUUyVnVI?=
 =?utf-8?Q?bxnQiEyzoaKoKSG35JPzOBu2e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b40a45d-26a1-4148-9fc5-08dd46becf97
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:59:09.8536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDauuISyTMPVboJ6cm3QFOwgcVOaIUc9axBqNty7v52AXi7odTLufzgwSxnJJGX2ALHcNAAAYih8jm90drMFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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

Ping ......

On 2025-01-29 10:20, Eric Huang wrote:
> In some ASICs L2 cache info may miss in kfd topology,
> because the first bitmap may be empty, that means
> the first cu may be inactive, so to find the first
> active cu will solve the issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4936697e6fc2..73d95041a388 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   				int cache_type, unsigned int cu_processor_id,
>   				struct kfd_node *knode)
>   {
> -	unsigned int cu_sibling_map_mask;
> +	unsigned int cu_sibling_map_mask = 0;
>   	int first_active_cu;
>   	int i, j, k, xcc, start, end;
>   	int num_xcc = NUM_XCC(knode->xcc_mask);
>   	struct kfd_cache_properties *pcache = NULL;
>   	enum amdgpu_memory_partition mode;
>   	struct amdgpu_device *adev = knode->adev;
> +	bool found = false;
>   
>   	start = ffs(knode->xcc_mask) - 1;
>   	end = start + num_xcc;
> -	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
> +
> +	/* To find the bitmap in the first active cu */
> +	for (xcc = start; xcc < end && !found; xcc++) {
> +		for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
> +			for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
> +				if (cu_info->bitmap[xcc][i % 4][j % 4]) {
> +					cu_sibling_map_mask =
> +						cu_info->bitmap[xcc][i % 4][j % 4];
> +					found = true;
> +				}
> +			}
> +		}
> +	}
> +
>   	cu_sibling_map_mask &=
>   		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>   	first_active_cu = ffs(cu_sibling_map_mask);

