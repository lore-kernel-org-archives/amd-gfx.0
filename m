Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5563FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC83112B8E;
	Mon, 22 Apr 2024 14:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDu+0pZ/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D7D112B8B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoVWjI1YtInZq8kfb+qbyiUTPrSsB2FUgtzV5T+gKEtx+KQ4J6sBbj3llKfWyJg3LeOg/EiV8WZ3GaITGvtIh+1YtU5+iJcFc2wLdy2zhIS1K7Jeue8KdMZ2MvFMKMFaYoPjpCYvA7HqXHY1FwtYqgLOBcHLolZtF799ucnedhT1B48eO5kd+G+uf6Ret2wnuMYkftjDFpkuIGV0eDcuRnNalrzvyxfMVAmJdHjiEyYBjAAe2dQhYxRJFECta7xWhCerV/BApBNmsvZMlusGyctKGVinooGCfnK3+99oISal/pXEYWA6q263pHU/E0XTplDw1N6wiKgP6Rx49I5BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iS2crvXvUU/hk/l4Hqc5f5fPGOjkDWyIgkLmfq/Rbc=;
 b=igtVHbltWio3q2DCDeWjjIVuucmsjdJtXzBjHGllzEgF9Zv430Yo4RMbGndA7D6+NU1PjK3Rfy50MZZZcajhg5q/KfZn+ZVXIBItNWrEbzG9/HjA1nA/s6yNNrIDew01ZwLE+ogBxhDyK2vii9C1Utx0vW18qh2mY8Ot2xcox28WxxsxTP2G3oyYjz/i6YpvGUMeH4gI0OSF956fZ+uejbXPOib2CzbCPKCPTeV+73B2KnY37fpbDtVYBW8uk6ofqz5uZrNFjv7/qzx6yiNkAYE+33SWBrjeqq0R/5mVMCAty25BVayAtx0KekFRrlLP0axnD4CzmWv2HGnFIz8g2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iS2crvXvUU/hk/l4Hqc5f5fPGOjkDWyIgkLmfq/Rbc=;
 b=SDu+0pZ/uPftfcXU8ZPCwuHLd9qdnbu20NGacUiSHBF9+HZQMxdFEAY4PgBvf0T1lHiTtJC6SqxYRArGnpC25IQih9/Z5xMxUgwu0UEH5GwsTZm9WKPAaYlOupg6OvGgESEaoYJtYarQ+nvfcMUH6SLfyqXXtcmuEBWCjUHc4pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:41:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:41:01 +0000
Message-ID: <60f0ec7b-52d4-4e8c-a58a-91824af9db5c@amd.com>
Date: Mon, 22 Apr 2024 16:40:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/amdgpu: Handle sg size limit for contiguous
 allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240422135725.11898-1-Philip.Yang@amd.com>
 <20240422135725.11898-3-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240422135725.11898-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 3760fd89-98a5-45c3-34c2-08dc62da3b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm9UK3J2VHo0a1UwWVZLZTEyS1ZKTVo4VVBUMGpJSktrOHpHYm8wQlRNb2dH?=
 =?utf-8?B?M3IxRHJkQnJaY3hjOExpdHZJcFlTbjZSbU9qUGpUSkdvdXlLM2lwRy9xNTlZ?=
 =?utf-8?B?aVJ4YjQrRW5QRzhYbUx4U29wb2o5dEt0MjJ0aGwycTZrSjI5L1ludU1PTHBE?=
 =?utf-8?B?UVozNUx6cW8wblRZb3hwQXdBNnFidXY3aXFSZC9aNlhmVFdwN0tZd3RYUjdG?=
 =?utf-8?B?dFZyNk1ZVUtoL1FrVi9aTnk5OHljQ2YvdlczazFjek03VGJjN2o3OHlZVlRP?=
 =?utf-8?B?cjAyUTJPUFhTeUt0RzRWVEhaTmFUa3M1TTI5NkI5MDRqOEtPenZWM1lkN1pk?=
 =?utf-8?B?R09uQVJMZ2RZajY2R0liU3hsb1BKOWFKSjVOUnd0eDJENjdsNEZyS25jVklq?=
 =?utf-8?B?ci8vRkZMUHREYTNLRmRzWE5WdDhRcW9DVERkTERFQWxBdVJ5bExHQkw2ZThi?=
 =?utf-8?B?d1liS2VaaXZybll3UEJoZzYrVzdiSlhUUkdZbXNubE85MThJQzhWNUQ4aWxT?=
 =?utf-8?B?STVWRWVlQlFTejZPeUZMQkFVazN1UFh5bWw3Mmo3aXZlTjRSKzMyUlh3YVBR?=
 =?utf-8?B?T1pqc1hTT3RSN1BmWGZXejJwZHJvM1dsa0hxM2tjS2VhM3pvbUo1OXAzUGVJ?=
 =?utf-8?B?dTBiL0U1STlobi9wRk1qT1Yzb09WU1loMnhSd29sQnR4VGo0LzdhdEhha2di?=
 =?utf-8?B?TjQrYllNOXVYc2FzRnphNWhXNzFiVDdvU1liQnZnZUduZGdRRDBzclVQNVM5?=
 =?utf-8?B?WUliTU5talMxL1d1dm1FZVFkYlkrY3ptaWZnazhqQ05KdHV1M2ZFY3JBQXFP?=
 =?utf-8?B?ZVFjby9ZMVA4U3RZVUtvQk50UXFScW91Q0ZnTWJKLzc3MUtTMzduVG52R2Iy?=
 =?utf-8?B?TThTZjBlRUpCdW4vTHduTjFxZGQzR2N5a2xvZmZPYU15NW93ejNlOTFHWkNX?=
 =?utf-8?B?RjBZYTFaeldMS3A1c0V3SUhhUmxTZ2lMUmp3Yk05ZG53aEhXSVhKUXRvNFVt?=
 =?utf-8?B?MXB4dEc4MUUzTkV6N2l0Y1RpdnZyUmx3M2xOR1NXVUNOdHh0T09kZ3l5K21D?=
 =?utf-8?B?YVU3dUpIRnova1gzUGZjMGdBcFJYZHpwME04aDAzNlIzSHVsS1g3Z09vN3NV?=
 =?utf-8?B?dFlPQ1Y5bUxKSVZMSDhDeGRkaEFwdHJSTEk1UXlxUmZQN2xyUDdXSHRjOXJB?=
 =?utf-8?B?b3FuTEcvaHB6SnJwYzlqMnhrTzRROFhLYTR2ZlppTW8wUW1KZlp1ek1Bblpp?=
 =?utf-8?B?RW5Bd0prUENMMVFmeXRneGpLWUVZb3MwMXZLeVd6WTlOWmlLYmF2bTRJSVhv?=
 =?utf-8?B?NUM1L2lGQkxSbWxRK3ovYjd4Vk02V2xjUzJoTHpDcnJ0TGxVTncwU2tqNlI2?=
 =?utf-8?B?Q1VBK082ZjVHT1R3Wm5mbDd3U3FVRlVOZXRDYmRXdStVNWRoZHVFZVRVS01J?=
 =?utf-8?B?ZGQwQURWMDRBS1JMeXZjV1Y1NXErMndoQ05rNDBhaXpwTXBIQ1J6VUkzN0dT?=
 =?utf-8?B?OGh5NWc5aGRwU3AyZW10RzlxaUx0cFp4T2FLNU1aWVlldzcxcG5hRWFLRElK?=
 =?utf-8?B?dXl2Tm1IWHdpVi94SnI4SFJ4ajJkdUxHcUZsYVhYeFJVLzM5WHVNaERRd1FU?=
 =?utf-8?B?VGNUUTUrTmNVNWlpczVsTUdGem5xRWFQYXNCMzhLanVFWDQxVjJNTDVxWVFB?=
 =?utf-8?B?dkJBcnVLVUVzWUVGOW1vdng2TThJb1ZRc2F5L3ZBZ2FiK2c3R1MrQUVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dncyYXJoREVjVDNVK3ZBdWh0aThSaThGek1RbVc5OGRXaWd6N3pzRHdSeXRJ?=
 =?utf-8?B?WEY4NSsvRFIvMTFOWEd4Y0s0LzBYY2d6ZGYxTjFqRXA5OTBXYlFZUUZ3bnZa?=
 =?utf-8?B?b0FQMHByaWd3SENEY1hxTWZpaXZRdHZVOVpHQ0QzWTBTOVJoRnRXMUQ0NmNW?=
 =?utf-8?B?cHA2eTd1ajlJVmpIV0FSVmtYR2ZtWjBRVEJzRkc1elg5czBBajZlWUwrbytG?=
 =?utf-8?B?NUMzVVA4dG5QWE9hb3BncjJVY1dqNXY2d25sTFo1NWk3RkdSM042NnZscXdx?=
 =?utf-8?B?dmQzUWtQVVpyNFZPUmVCMUczNXZUdmFjWjVsTFF1aWIyRmpqQ1cweEFGU0ZK?=
 =?utf-8?B?ZkE3R3N3ZjRhTHIwS1BacmtrZmI3dmJPMnlDVWM4ajA0T1grellsTGVBUzFa?=
 =?utf-8?B?Qm5BTXdFdUN0bEZYRWJzRzEreWJNdW5CU1ppaCtqWmlsR0hYV1RpemN3S0N4?=
 =?utf-8?B?bVE4cTI1dms5RDFwbzZZeFl3V09qZk5vcHZnbkRTZWJza2IrRjdHN3FpdXRM?=
 =?utf-8?B?dzZHUWxLSnBlOGZjT2xjWWw0WTdjcjFCNG50U3JGVnB2ajh5ZTVuSkpWTGJO?=
 =?utf-8?B?Y1hoWGNXdU9IdkdqTEhFTytSalBNRmRTamhpMUNGNVNWYVpEVHE5MHZ1NEda?=
 =?utf-8?B?VERDNDdvR1JGakx6dGl6L0E4a3VPVkNTbTdOaVVVcGI2Ti85QjJ5dGVreHNE?=
 =?utf-8?B?YktpemM1MUxzYm1laUppTFhXNmRPRWFrS0VoMy9qemI1MlZ4RHd1M05FblZI?=
 =?utf-8?B?dkJHSTYrU25Jbk85a2doRVVEaUgxejJSSVZ0ZDdXWktDK0x6RWJ2QmNwelhD?=
 =?utf-8?B?clJ6azhIdHA0Z2hCUlc2MjhhamVVUC9RWlZJRzBCK1AvaU1kWmN2c1NDdmYv?=
 =?utf-8?B?UnlNQXpGRkFRWkZDaVl3dnA2Zk1vb0dVT0ZzM2F2bkV4azl3Ryt5Q0NlekU3?=
 =?utf-8?B?MlFib0NJbExNUXVMNzZKcTVSem1WWWxCeWxHWXQyajlCUnhhczd2dGFVSkwx?=
 =?utf-8?B?c2svUjg1T1R3b1VhYUs4RmNQQWcvUlViRmRSN21LTm9WeUZNM3lFWGhJZWlj?=
 =?utf-8?B?RnExV25peUs2V21pM25pd3N4NjQxME9FdnpwZ2xiZDR3OGZvRHpOakpTN0dT?=
 =?utf-8?B?RUxpQitZNHhmTm1QUEs2SUZDZFpVM3FCWE9IT1UwcGhlQVlhaHFGbzUvZXB3?=
 =?utf-8?B?S3EweGpaSGZOaldPcWtDWnlyNVdFNHpFOEViN1NOZTh4TklXTnFQQnZJK2Jx?=
 =?utf-8?B?MUxLYk1jTENHYTRMcElKSUtpMjN6ZjN4QWcvck5SSFdKR2NMeFZ3b2dLQ1JO?=
 =?utf-8?B?WlN2eTNLc1B4VG13OFVzaUtIRzBtL1hmYUV6Y2ZBSDliSVNZNHBiUjJXcXdM?=
 =?utf-8?B?VktybEhvalBDY2luUEd0K0QxYzdQY1FPMVBRVUlWekoramZZNEhCVTVnOWZO?=
 =?utf-8?B?NkJjUXV6ZXl0aWt5MVoyRjZvQ2JJMldRcnhBdTdrbE1hUFhDQjMvSDBhdndF?=
 =?utf-8?B?a0JZUUFWZzNYWTZRT0dMMzc1SlIyY1NPeEhybW9CcHAxZEtpbFoyNDBvRHRG?=
 =?utf-8?B?VGc1bloxaVJ0dndNaEIyWllId0RZbFV3N3FCVytPUTZycWtZMmtJVGExazZU?=
 =?utf-8?B?b3JMRDE5ZWV1VUt1L2t1cWZ6T010VjRJbVJoNXMyUE43VUFSWFNpd09jdVRa?=
 =?utf-8?B?eHdMYlUzN0RQcjNFUzFSL0JBcUNuQU5jbmRlTzNEZDBCSXRFNjFIYmpCTEIy?=
 =?utf-8?B?WnJQZ3JRZkVhM09va2dyck5TY1NISVNwRnB2dDJrWlRKTGl1dWdSWlZvb3Bm?=
 =?utf-8?B?N3RNNllOK2RIL20yNG4xc0dmVUtkVkdSSm9mQktFUGdiM21waTA5dE9ieGhX?=
 =?utf-8?B?TWJKS2NUNTBzRmovUU9EVThDVGdvREJLVjJqUEFKRVp0Z1AxM3pqclJZYTFh?=
 =?utf-8?B?UDBsQ1EwTXVxeGZvVW1pWUVkWlFaeks2b1NLMk0rVDBHWGFyYW9BeFhWMHUw?=
 =?utf-8?B?S21HRVVmTzQ1c1ZxVGVHS1IyMmg3ZmJTbDVVWlNsZWFxNVlFTE93SXdnbkRo?=
 =?utf-8?B?Rm95bU13Z1lldUw1RUdDVDY2djFXemNOWFpFWXhCKzJzRVJMaGN0VmlyZ045?=
 =?utf-8?Q?QicMLV+CNQGHzVJaxKavoaNzu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3760fd89-98a5-45c3-34c2-08dc62da3b02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:41:01.5271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY5ctkNxvZ+OaBbSo9dyIo9CoyjUZt4YZW21e57vn/8FiDjbNvuz3ydokxdYRWJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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

Am 22.04.24 um 15:57 schrieb Philip Yang:
> Define macro MAX_SG_SEGMENT_SIZE 2GB, because struct scatterlist length
> is unsigned int, and some users of it cast to a signed int, so every
> segment of sg table is limited to size 2GB maximum.
>
> For contiguous VRAM allocation, don't limit the max buddy block size in
> order to get contiguous VRAM memory. To workaround the sg table segment
> size limit, allocate multiple segments if contiguous size is bigger than
> MAX_SG_SEGMENT_SIZE.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 4be8b091099a..9fe56a21ef88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -31,6 +31,8 @@
>   #include "amdgpu_atomfirmware.h"
>   #include "atom.h"
>   
> +#define MAX_SG_SEGMENT_SIZE	(2UL << 30)
> +
>   struct amdgpu_vram_reservation {
>   	u64 start;
>   	u64 size;
> @@ -532,8 +534,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   
>   		BUG_ON(min_block_size < mm->chunk_size);
>   
> -		/* Limit maximum size to 2GiB due to SG table limitations */
> -		size = min(remaining_size, 2ULL << 30);
> +		if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +			size = remaining_size;
> +		else
> +			/* Limit maximum size to 2GiB due to SG table limitations
> +			 * for no contiguous allocation.
> +			 */
> +			size = min(remaining_size, MAX_SG_SEGMENT_SIZE);

Well that doesn't make sense, either fix the creation of the sg tables 
or limit the segment size. Not both.

>   
>   		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>   				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
> @@ -675,7 +682,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	while (cursor.remaining) {
>   		num_entries++;
> -		amdgpu_res_next(&cursor, cursor.size);
> +		amdgpu_res_next(&cursor, min(cursor.size, MAX_SG_SEGMENT_SIZE));
>   	}
>   
>   	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
> @@ -695,7 +702,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
>   		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
> -		size_t size = cursor.size;
> +		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);

Please keep size_t here or use unsigned int, using unsigned long just 
looks like trying to hide the problem.

And I wouldn't use a separate define but rather just INT_MAX instead.

Regards,
Christian.

>   		dma_addr_t addr;
>   
>   		addr = dma_map_resource(dev, phys, size, dir,
> @@ -708,7 +715,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   		sg_dma_address(sg) = addr;
>   		sg_dma_len(sg) = size;
>   
> -		amdgpu_res_next(&cursor, cursor.size);
> +		amdgpu_res_next(&cursor, size);
>   	}
>   
>   	return 0;

