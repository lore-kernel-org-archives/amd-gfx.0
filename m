Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B46C83F21
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 20:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B5110E357;
	Mon, 14 Jul 2025 20:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ly692dDu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3439710E357
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 20:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGZoucEt6jf2UUcIry5sUSgZkTOhXJ1YZxWY07b2pPRGS5tfI1813mRnSt/CzFWk7fvQISJzN06f+yiwugfQlUihjyol/a+CYOxJ4L5rGadyCgFBNQLn6dcC2FKXrGyn3UBys2ItlAG5zNvpmlk9gAG844ZU4kJYaeHgcwlJC5dctw0rgM36ZQEvPNB5DIIIrSrxmT4auEJ5eNavTGizc4ZgNakDSbistnBLmzhtWSidMXoh6t5mREsh7ChdlBdjDi9kxjIw8Y80w9Ea7gZh3TUjt5n/HxQcnKgoIQFx+9ArnlJkYu7+PSIX8pEKGTUMiGzAjEQMRYSwRsuHvjeuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2slm7AmCD77A3irJSRvuKcdQakhX/FwpBoAn3jFMO64=;
 b=M3Z4Srw37GNuM0trWcylmdZtfTXWDy80M0ZOOBFkRmxnlcaBZFqvJZh4WQN6PrlXbAtuGo7cecKWtH2XjStgxpaWB5H/AjjKLfLW797etp03bv/ffVbect6zxobn2GI5Ylzogv613TtKYahGTv3weDqPLsQlF8b1IconEPnVl2aGT8bwkrkWUC+8hIzMYNbzSPELtDN+P5b7ft5HHaYxeU4ToV5wSoEFOoXjJ0zC3MscA3bJYldh2x97mbOBjB9rqkOZgtShT0egM3r8GIFKldCPyw8i3CeHyGvm0JVfr+PofU46iDjzgrI8Hy7zClMKb6y3MfcGeboce1cw3RSYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2slm7AmCD77A3irJSRvuKcdQakhX/FwpBoAn3jFMO64=;
 b=Ly692dDu75jiiC9DV8Be6nArv53gS8v2RDq5elYBphu1JSPTYzO5J6Lwwkjnfg0wth23YGuOlvuGm/sV4ipukbPtfQ8I+UmCl4FaB8nKhXFksPVmHLuYTu2zOdzXsT4TIiafXUh27FlmdJLDxL4l8PD004ITXOE15hYFTK/yJdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 20:22:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 20:22:48 +0000
Message-ID: <d13d39a9-0cc4-4fa2-a062-54bbf3bd5882@amd.com>
Date: Mon, 14 Jul 2025 16:22:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: rework gmc_v9_0_get_coherence_flags v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 david.francis@amd.com, amd-gfx@lists.freedesktop.org
References: <20250709125119.1606-1-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250709125119.1606-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: abd41bea-d83d-4b90-cfdc-08ddc3143307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTh3RTdLMlIycmQ1Y3FoejFFUTA0a3FJRmx3SVhVeGs0NGNzMVhacVNUUE51?=
 =?utf-8?B?OUFFT3BkN1B5T0YrUlR4dHJvdzNHQ3lPajIwMW1kZEw4ZjVUazYvdGZPekdT?=
 =?utf-8?B?cStPeHpPUGY4RytuU2NOYlFQaWFmUDZlMitlT1UxeFJZSE5nY0RTT3hic2tw?=
 =?utf-8?B?S1dyMmc4K1B0QitYNFNYS2pKQzVpVURzcFRWY2thenB0Q0h6aWdSRkJ0cnA0?=
 =?utf-8?B?TDUxdC9Pa3BjUHBnUDM5SE5zZEFxMnVJcWl6RFBGMGc1MEVGSW1sa0dDckg3?=
 =?utf-8?B?VjBpa1JQczN4azlPOERHeDJiYnFON3VrUCtNVS9sZ0htRUVRMFVSVDl1Skt6?=
 =?utf-8?B?OWg4ekxEK3dJdjVYY1pBMHhwWW9pZDZBa1FlL29yTFBOSWJ5SllDZGc4b3FI?=
 =?utf-8?B?a3VHdmo3eUI4anc2SkhIc1J2NkIvbW9hZ1NjTVg5WFlqM1lYMXJmUkM1eUhE?=
 =?utf-8?B?SUtFNW8xcGNrWTV6SGE3VGNlZkNXNmVNTVBZWXphQkNHZzI5dSsxRHF1SmdR?=
 =?utf-8?B?dTIrSFFDeDMwNWJ0dER6cE1zVUhwOFhlbTFZZ3QvZytkYkVraTNFUFpwUU1l?=
 =?utf-8?B?UGp0ZDNJVmJUY1laRzFVdUxBT3BVeDhJYW11TjVOUmR2YThWSXZjTTBWTGs0?=
 =?utf-8?B?MmVxUXZQUGlUNW5nYnkzNXlCTENwdzFyazM1ZG43SnYrSWx2MjR6RHdZZ2Rn?=
 =?utf-8?B?aEpaZmpHZXhTWXNTeWxmc1c1eVBNMVduWWdDcWlCNTdNUU9OcWR1cklhM0Vm?=
 =?utf-8?B?TlBJSUQ4dnZFNmxNaS96Q0s5U2RidkptWU56SzdaY1l1R0cybVhRQXRUWmNJ?=
 =?utf-8?B?azdFRnRiYmdZcWpxc2tJT3YzSVltbkdubDB5eHMvajg0R2Q1YUJRRWYzYmll?=
 =?utf-8?B?cjdJdXNRRmt2Y202ekVhSUI4NGRXMlZhdmZKbWwxOTNqU3U1VnViY1Z3S210?=
 =?utf-8?B?bGRwWkNSMmVZLzFGRzRGaDdzUFhCaHBOb3hkMk5VN25uVEFJRFNiMTIzYmwv?=
 =?utf-8?B?TWk2c0J5TEZzd3BmVGpOOHhJb1JOeEpZOFRoNTByOUdKaDhyZ3VlaUhrN3Fh?=
 =?utf-8?B?VzQ1eGtwYlhnZ3JqVStLUHJjOXBSeDNGaDZWR0hLMnQ0d2UyWkxTYzZ3cVRW?=
 =?utf-8?B?WVJjYU1YOUxGa1EranR1RWZYUzA5TC9nT3RrYllsUG9Vbk53d1k4VnBWWUF4?=
 =?utf-8?B?VmZ1MUp1OWwrNmxxWTh3REc5NWVwYzhxazFIdGQ1aUVhVWpFWUx3blNrY21N?=
 =?utf-8?B?N0lMd0JHN2R5WmkzUlpqa1J4alNqbURHSSs3TVlLbXF4b2wwQXBweGxndUpM?=
 =?utf-8?B?dHdGUHlPRjFUWU9Mbi9vajhSak5pQ3ZCMnhqNWhhTmpYallBN0ZaR214S25q?=
 =?utf-8?B?Szg2aEFKeE9ROFdILzlUdHFjWUlLTEtXakRkMUQrclpLenNBaUEyVlVRQXps?=
 =?utf-8?B?cHZWWXU1RHdWN2QvTGkra0NQd1JYR3pvQWhZWVU2TS83a0Y2cDhrRjlLclFt?=
 =?utf-8?B?MEJhMENvWFdtY1paSlk3MUF5UE5QMXdjRzAwb251a2RscjFNNUU4QXZoeDlo?=
 =?utf-8?B?UTdlL1BkSW0zUTdXT3B3VnNQMUQ4RkVSNGZmUVRUeUljNUlxL2w5dkVtUDh5?=
 =?utf-8?B?eXF6dFpYZ1FtUXB3L2hiMjc4dFJZRTJLTGFRUnM2VVFpU1N1VkRzZzBiMnBK?=
 =?utf-8?B?bG9xTDRrdGdlbnovWEFET25aYmo5M2p6T29LeVdiaUJIRGNia0RyMm5Rdnlw?=
 =?utf-8?B?NUx1YlE5eVd4Z1JOTFY2cmZYcXF5YmhmbXVROGN5V1hEYkhZaFAwSnFycmJ4?=
 =?utf-8?B?NjRKNFY4WlBnL1M4UDdoVG1ucnUvcmdRb2gzNXdhaC9JbUhuK0hYajI4M1RF?=
 =?utf-8?B?Y2s0cHdBYnJYK0ZETTJPbHlMYno1eExERkRJYjlDUjlBSnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXh3SU1DUkZCaHlVM3BHaThyS3l4K1BqVlVVajFPK2k2K0JoSEk5WlpUQVVS?=
 =?utf-8?B?cWRCOXFHV2ZlMEZEZHlubkxLaTZmZlJ2UU5CWjRxVFo3a3VxNnlaYnE2Yk9o?=
 =?utf-8?B?b2lRa2pCRWpKYkpXZ2grcmRRNGRvT09oUXBZUTQxKzZCeDN0WjZ0MVE2RU9s?=
 =?utf-8?B?aWl4R3JrZXZPdTNRc3FUa1c5WWhraDN5eUZnaGNJN3Z6MHhuYXlyek43cGRj?=
 =?utf-8?B?Uk1BQ2o4QkFXMktoTDJ5NENpa3g2cVJpN1pvOVhKdUZLKzlTQTJLditBMTl2?=
 =?utf-8?B?VVRsaS9WMmZqTHlrdU9nNjEvNWlWOHpwZ2d6Ymh4aktkekJEMUlXb1Q0Q3A4?=
 =?utf-8?B?d2EveEJHTFczbkc4dWRNMjl2V3lRVXQzTzY4cUNSRVcrUk93bkI1cUtYVEV5?=
 =?utf-8?B?MUtLYjVUSlZYVi9QZ0E1cDNqSWwwN2FNRUV3bkhNMzUxTGJxaWZvS2lTYXFY?=
 =?utf-8?B?K1haY0RjNWVteEVQenhrdXVvZjFjUEcyd2tVZzVZRUcrbk9FbnQ5alpXQldT?=
 =?utf-8?B?NUZsZWJxcEh4Rkdlclp4a1lNR09DNmNqaWJNa0doMlRJWHoyWS9qZnRaVTZZ?=
 =?utf-8?B?U0hCaFBybWtBS3R6Vi9DdUwxSFM4eWxIcktub3ZMbnBpNW1OcG1KRWgrMHAx?=
 =?utf-8?B?K1Z0Q1IvODRrS2VHSEx1K2EvQnFuL3pmVGFRN1dCUW1aUXVHdE9veURXNlhJ?=
 =?utf-8?B?Skt0ZU85YWlHRzR6ZEprclU0OGRiZGxBcHIwR0VBT3l6WDFOT2daT3dwb0FC?=
 =?utf-8?B?Z0pzdWtydG9YVitWY0tJNGFXRDZxaHJvNms4QzhtckMxSzVjMVdTWGI4eTlq?=
 =?utf-8?B?cnJza0ZlYUFra05TNmJGUlRQbTFHSTZZdExTZUh5NUFaZTlmb2FBYzZPNWZJ?=
 =?utf-8?B?ZU81bzRVTXVudWxxSENRekxMNkEvN1B1dTR6cTZXaXZsQmJMeU1sMmVSU09j?=
 =?utf-8?B?SkV5bk8xaHdJRXNhVEIrQWd1TWcyb1BhNVV2b0JjRG9nVmMyOW5Ca3Q1eGlk?=
 =?utf-8?B?Z1U2dWc2bEt0U0pTcTYxM2kzOXFLdkcxZ1pWZGgvSmV6MUpzTDVxS2pKRHlr?=
 =?utf-8?B?dnBkWVIvRW8rNWZXdDdTSVJWcm1NYjU2RFRoOVAvbTJqNXNRRmdqanoxNVht?=
 =?utf-8?B?L3JvZHI2UXFSWDFxcGhCZ21TMFdGdlNFSFpVODlIekNmMWViVjZ1UllrNkVZ?=
 =?utf-8?B?MFFLMi9qRHZ2Rkt3Wm9BQUEveHZnZzk3QzZ0MlpmRnRRUHpiZmFYb0d4ejJP?=
 =?utf-8?B?VzU0Zi92SzhsdndaNS9hOXdRNDV0L28wdG1NV3ZpYmVWWHJGejZjeElmQU9C?=
 =?utf-8?B?N25jNlc1N25WbHBTU1dOZVFIK2NiZlBOVWc3SDJKaXJsbHZlQ2Z6VUwvUWpP?=
 =?utf-8?B?UktWTVBSVlcySk9peWpQazVZVFZvVE82VzhFNlozTGJ3WHBSWDB6U3RjWklj?=
 =?utf-8?B?MjVRQU1KbzVFeVV4UnFsZHhyQkxsRWVJUjh0Sm83Z2lHV0s5dzRsdk4xNzFB?=
 =?utf-8?B?c0ZnYy9TU2xJK0RuSjUrTEtrV2Jrem8yaG9iTVNPTENUczNTWUlPQ2lxc0NX?=
 =?utf-8?B?WUxRNXJGQk5kaUZzY0JxSElEL0MybG5VdDlTWmR3VlA1YjB5TXBrWTRHdVZz?=
 =?utf-8?B?cjlrWUhPTnllUi9Melo2T1lJQVNVaVZHN3dMNlhZU3NFRzhLVWl6LzN1cVRK?=
 =?utf-8?B?eHJqcm81Q1YrS1lpcFRERkhKV2o4aHZ2TitZRit1OElKdUYrc1d3NHRVQkpL?=
 =?utf-8?B?WGdCZ3RveGRuaStJMmtYUnpkRGpkQm5BN2UxdjlYbzVWeVFQdjI1U3RMQmxR?=
 =?utf-8?B?Y09SVGVidTJFeWhWa1Z5d2NHVDVpekQxTnowUUkra3pFRlFEOUYvdHhFMWU5?=
 =?utf-8?B?aE1VRFpCejB1VjVESW5sb1QzN2llaThPWnFRbDRMM2lQSEdQSVBHQlgrWWJM?=
 =?utf-8?B?ZzM3OXEzdXNUU2ZlS0t4R25CWTY0N0NhbmdIakpqSVZnajl0V2dsc3lJeDZx?=
 =?utf-8?B?OWZsOEwvcTlBL3Iwd2xqSEtWU0t3MndMVlBrREd3ellUK3FldWdzNFJRN1Fl?=
 =?utf-8?B?cll6ZmZjTGM3djMvVzRMVlRDUStZMi8ySlI5TVY5T0d3cW5oVjB1R3Mrenhn?=
 =?utf-8?Q?CecITP1wknpxE2MkpeQfrou0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd41bea-d83d-4b90-cfdc-08ddc3143307
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:22:48.1522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnthC7oFj6Y/Z7YcZrtagsCcNdFFkwqQTEhV7CDa87d0AKgxnG6R1RdVS6g5HotlYdznY4+XxvUnh+0Ql5znog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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

On 2025-07-09 08:51, Christian König wrote:
> Avoid using the mapping here.
>
> v2: use amdgpu_xgmi_same_hive() as suggested by Felix
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 380b7b81ac1f..71f134d54fe1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1124,8 +1124,8 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
> +					 struct amdgpu_vm *vm,
>   					 struct amdgpu_bo *bo,
> -					 struct amdgpu_bo_va_mapping *mapping,
>   					 uint64_t *flags)
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -1135,7 +1135,6 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   				     AMDGPU_GEM_CREATE_EXT_COHERENT);
>   	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
>   	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
> -	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>   	unsigned int mtype_local, mtype;
>   	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>   	bool snoop = false;
> @@ -1165,7 +1164,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   					mtype = MTYPE_UC;
>   				else
>   					mtype = MTYPE_NC;
> -				if (mapping->bo_va->is_xgmi)
> +				if (amdgpu_xgmi_same_hive(adev, bo_adev))
>   					snoop = true;
>   			}
>   		} else {
> @@ -1257,7 +1256,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if ((*flags & AMDGPU_PTE_VALID) && bo)
> -		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
> +		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
> +					     flags);
>   }
>   
>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
