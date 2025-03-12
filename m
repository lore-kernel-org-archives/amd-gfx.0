Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59EC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 15:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F1110E0F1;
	Wed, 12 Mar 2025 15:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3BcZCHpy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CE910E0F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 15:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkxjyAevp0Iak3eGNZioAFHASZKSM2S/VlqoPf2kPCuLhWm1mWiuw19ZTviPZKY0x0aMlfkKrpJzuDCHsqxSSqj4MIW3EuqS/4Iey0AfsOMATXptHFGhFYHQ4ZZL24Oykik2k0Zfd3Bb5GT+jnwzbUZDABohvw0sEpfhthdgXLW3jE6Uq6DrNeTD15AyIGHLICx/nQ6YTiEPywlPg18OiRqX1G10kIK6o2fwocXQ76Z9HzKXfBTaNOrMx0V8UykPOvTLK467c0org6yaonGjCAaKHTmLTJysPOLxZhrQGYwtLRADCr5+/BKrmDi/GedMNzdFV2pS69LSd6ZIlECfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foWQIRSa08gS3ovvV5urLvfvEGlKXxduZcJqPaS1bE4=;
 b=FEBVFM8FDFI2fMkjZBjJTXPNmfQOeNwM1GFEFUMfSfoAuyH9XTOVFCg01rdpkjJdwaNezg8XE+ONhw0y92J5a9p5kiprZKOvG2bipp13JDDBGrzRE3nXH2n20akG4invJ6SNBAa88E0cAycivunIOheOmBlpzSQDnAtq3ZIngFOQut+k3dw62NBDGc6HdH/V1ImkQQJU46MAWYuAR2o8gP0NrRfqox60gxprzv+VHdH5WSKfPQbAI/YFIG6vI62rxffpH9yNu/lcrIZ0zBfllllAk3O9Z30FB0grpYi99u2HGD6Oz20KfKI+mPWf0DLRIq2QVeXfmhz8v/ZAjptNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foWQIRSa08gS3ovvV5urLvfvEGlKXxduZcJqPaS1bE4=;
 b=3BcZCHpyEBDlYJn74L3cO3OC1h+YXfbzx1gQ0MhrZOIOAiOs9zX3ovpUj7gjrhltXUM3dUTGJv2fUjDNh46gpEVlmblnKvLPE94FOtRK4DR0Y8SrURH01VNFBieFB4YeTijht9eDYi82/7tMknrK1owPNya/ud/WNV6uxRQNqnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:06:37 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:06:37 +0000
Message-ID: <d16eb6df-8a40-4afd-8099-c218fd43aabc@amd.com>
Date: Wed, 12 Mar 2025 20:36:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: overwrite signaled fence in amdgpu_sync
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-3-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250307134816.1422-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bf2688-10d8-41bd-6b41-08dd61777c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1dJb1V2YVJjN1lGV3FYSTVtYWRPZVU3czd5WU40N29DdERXcnhqN2lqZHFR?=
 =?utf-8?B?aW0vMGNQN21ONUZjQVNWNm1ZRndzWmI0TS93MksrcjRqYUZqRUt2enFnTnda?=
 =?utf-8?B?ME9XMDdycmlxUlRXdmZIYy9UeHhJT2toaUhNbUNFN1J5OWNoODd4MHluVDll?=
 =?utf-8?B?UzlvSk83eDJYQWkxUHBEY3BFV2tTc01jaFJxWjQ4QStBTDZPZTlGVkpQUjZJ?=
 =?utf-8?B?YnZNWWRFbGkydFljeEVyTE14UVFKdkp1ZzMrOEJiVGRzWFBPZXY3T1lLSTdV?=
 =?utf-8?B?ZU1FS1NsaUJJVkNSVU44UXhnZENkZXVjNHBqNXY1aGZGOS9ZcFVpR3BTQy95?=
 =?utf-8?B?bGMwZEhSU2tSSHl5YzRhODFkRVhwdnNGQ044Um9ydTlhcE9GeTNXZzBJL0t0?=
 =?utf-8?B?NEFVQTFZT0FMd3pmZGZGZ1VFL1RYSVl1cDJMeUhPVHE3dU9TT1I3MDQ5Z2ZL?=
 =?utf-8?B?eXg2RjZTUlBEbFVvNkU0RmJUakcwN0YzdUdVVlhoa0pXNDZ5WHFkZ1hmV0J3?=
 =?utf-8?B?MGQrbkE0VlNaTEJqQmh4Tk9zNmJNeUZzUlk1amlHOGxlUVBVdUcyank5MDZS?=
 =?utf-8?B?ay9nZmJXVzRreWl0R0E4VFZwUndMeGFVeW93d0p1bnZEMllwYjIzck4zQkZW?=
 =?utf-8?B?OGVaZGkrczdxYzZnWEdvd0o3TndMemVUMXI2MEVHbjkySU9nRXFSZTJMNzJr?=
 =?utf-8?B?MFpKUitkZ2UrckJ2a285RTNteWt2dGhPYXZQNi9sRFFSTmpwajVJdnNLRGJQ?=
 =?utf-8?B?VThVMmZRSE0xeDVrcUluSGhKbnVmcGUzWFN2VVNEcnpEcmpZbklWNEhLVFFU?=
 =?utf-8?B?dEJuWmxSNXR4RDU1a3lzSHVJOHFlQ2ZmenVUWVZkK05uMkNCUzFZdkV1dmN3?=
 =?utf-8?B?SHh4M09pU3hXbEllekU2dklJTWFwM0FkRkNTaHFGeVJ6bzN1WGxvMStKUU95?=
 =?utf-8?B?TjFKYzhEOTgya1hma0Y2MXlOd1c0VEdSNTgvWUd3TWcxL1ZxT2ZyaVZzdDh3?=
 =?utf-8?B?UngrOHpRd1N2K0JmejN5aEJ3aGE5QjZvdlBlUHozWXQ0UjdzOTdpQUVMZy9N?=
 =?utf-8?B?OHhYdHFPMnJSdE9ReXY5VUJyNzV3cDRKVDNsZ1JCdVFqWE01N0hlUWFLbCt4?=
 =?utf-8?B?OXZtck9OUWQ0cEoyYmNpRGFad1RVbitldW0rYjZmRkxBSjdpbTRySFFXcjJz?=
 =?utf-8?B?VUpMdWpkZDRnV2ZxVm9PZmdDbTlBUHlFWnRuTFdLZkRMY1JwZ3Q1UUdXZjFn?=
 =?utf-8?B?ZGs0QXI2V1puUDY5V3B1U2hCM0FGam5SeVRmbDhHTmhnTzVhWkZMTzZiemR6?=
 =?utf-8?B?RnVDRFZ6ZVVyajNPUDk1bm1wQWRUaldNNW84eW8rNExUYzF2emI1NjhzYjdP?=
 =?utf-8?B?Z2l2NktYSjFOd2VVZTZLdm8rTEVrRDUvNGY0eXhZRGZWRFpCT3p5V0NqZDh6?=
 =?utf-8?B?V05EY0JtWGc5S2twdERBMU9qbmtCbmpzTDVtVjJ3OVcyeGlNQXBYcERtYVY2?=
 =?utf-8?B?R00yRm8zai96TnNCOWtwVHZGSmNpWUtBSElNSVJ2MFE0YjI0RmNoY0RVNGtM?=
 =?utf-8?B?NEhjdzZNMno0NlYxVHU1VFE5cmhBaElNczh4RG85dFRhQ28ydGY1SjQrQUlD?=
 =?utf-8?B?VEQ5RUpWSkFZcjM5NzV4MTdjdFdUMk1DSlIrTmZXVHJkVWkvV2pBK0MrYzRW?=
 =?utf-8?B?aEQyNER4bmkwemh4cFhqNHRxaCtySmRsMjFIbHpsL3h1TjdXNURkWUhXMzNz?=
 =?utf-8?B?ZWZacW9FVXY3NG5kTVVsWVdDbS9JQXVGK2lURzcxUTlFT3lmZEJjMjB5cUdU?=
 =?utf-8?B?T09ucTRZWnhUMXlJd2tpZEhORVhYTmkyMzRNYnJVcFFEc0NwTmR1M1NPMFNP?=
 =?utf-8?Q?SKmCHa0gUtg0F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNUMGlCVE10QkxjbElXUkJXdnAyaElNYi93QUxUd05OUkRqaDloK09ETHdQ?=
 =?utf-8?B?cHB0MkQrVk1QZTFyM0w4ekZncjVMU25TM0xaUHFnN01ndGxtM2xITkxkTFdx?=
 =?utf-8?B?a1k3M0ZPV2Q1ZjJxaXhTV1FjRFB2bWJUcWtRV3Z2RG1GVldqeDJEK25JUzU1?=
 =?utf-8?B?RElYNXUxN2lXZ2tpdjNFN2lUKy9pRjd6RkcrUEQ0Q2J3SDJ5dHQ5RzZSRzdV?=
 =?utf-8?B?QnU2QlFCelZKNlBzMy9zbnFxakxlQUdrYUEyV0RQVm5DRXViTU4yQ3pmbDNx?=
 =?utf-8?B?VHJWMDFFVXUzQlAyWlNsV1ZTUkFSdUVQTVlZT0JJQ1YzUEsxeGZSOFVlc3lW?=
 =?utf-8?B?Y1JmRlBaZUFueWt6bWNVY1R2Z1A4Y0ovWmdCRnVCd0xZQ0pidW8zd1pVeHBF?=
 =?utf-8?B?MmdhMkRNR3NnZG5oYWphWkdiTVJpVGJtNEFtQVc3UnNUSUZtVkltOWprTnYv?=
 =?utf-8?B?VjVGOUx6Wllkb24wMTZveC9vaXJVOFQzRDJ3S3R6anIxVnoyK1FKOE0rUHBL?=
 =?utf-8?B?SzhDSC84Mk1JWXBrWklsem41bEhvY3hLemRxajM1UTZDdzBsZzB0WElvM01l?=
 =?utf-8?B?L2ZXSEhGa2pacWZJdEFsRFZoc1hHc0oyQ05UVXdKdnRXdDlJQUx1MnVtaXg0?=
 =?utf-8?B?MDVvTTFhRjVJcnVxY1JtbXNPai8xZy93MHl1WUVqNlBSQzcvV1RFaktmbVZO?=
 =?utf-8?B?aUJUYktxM2x5UEJ2U0p5RHRkL2JrOHRjY3FVRnI2U2NPaDdQcW0xRVZlcE5k?=
 =?utf-8?B?TUM5UFUyT2VZS2Q2ZDNoVVBWdHg5NThPcjZ4WmRON3FCb1NhUzdlN250ekpW?=
 =?utf-8?B?QXNrS3V2NFhMTlArL0pQdWFPQUZQTnFCRWdmQjlnOWIvRXp3SklvVDJEb2Ux?=
 =?utf-8?B?Zm5zWndIL0tXNGFKNG1sNVZNem15QldtbUVMdWNXdmRKeEZmL3dtOXdTUUpZ?=
 =?utf-8?B?aGlxWmtLTlRkS2RZeVJ5QlF5TXVNWnNoRitrSHFmN3YyZ1ZKWjI3VTZHbVdk?=
 =?utf-8?B?YWdxaHM4MmJzZ2hDUndUUGxHRG4yZHJHUFNmSlMzc1RvWXgxMGNEVzJ0NmE2?=
 =?utf-8?B?UlR0Si9jQmE3WW96U0RnSG4xL0hNS3dLcDJWOHkvUnY3L2ZCRHFMY3N1SG54?=
 =?utf-8?B?QnUrWFFPMDZiUEN5RGJSNXI3WmIwenBISGoyOUk0K0FKZkpFajEzQVNxMlVB?=
 =?utf-8?B?Q2J4MmJqUGRVQVZxSEhHMlIrVEdycnFYYkZycytKei9vUkMwbjliVnF4Mkl4?=
 =?utf-8?B?ajNIZmZsdWJwVG5LRmVtN2pmaTR4RHF3QldMdzBBVlU4TTBTSU01Q2Rkbmlh?=
 =?utf-8?B?cGZGdW9kamtLaVZzaVdaNXJmbVd3dnBzR200Wk9nZnh3NWVBUUNRb0JMRWN1?=
 =?utf-8?B?Q01PZzdmTlFCbFhVdWpqZ1htdXc5Ky9BcTk2d0JNOG5BZHBYYWN5d1N1MVlt?=
 =?utf-8?B?SVJaOVNDUytHV2ZVTHFRRnFjV0ZabUwwWHN5eXJtQnJxcFNFWUh3SERlUDBW?=
 =?utf-8?B?cHZqczVOQ0xyMWlmUS9kUFFDYUl3WktISWFqeE5hWTZzVHUwSXI4anlsNzJI?=
 =?utf-8?B?UnRWendvUUV6VVdqa2hCWnc2R0MvNWJZZk93S2JxRTgrWFFNRCtMcVBhckd1?=
 =?utf-8?B?MWNab0wxUnh3ZkJRNzV3Q3N4NG5iTmViZFV6eHpQMXBBUnRyOC9scmlwdDVi?=
 =?utf-8?B?VEZZMlJVUzRETk11bEhIMlk3a0M0ZDZwcDlyVUFaaElRQWY0VUVDTThOTXJj?=
 =?utf-8?B?RndrZEMxZldpeENKMlpuaktrelVCTHNzaGtwU01QUFlzUXY5ZUcvcHN5Vy9S?=
 =?utf-8?B?c081a0tkOUdqV1dlQXNKUFZFWEdTbmhoS09xb01vdHFUeWcxZWNFa1VrT29T?=
 =?utf-8?B?NmNzb0RBNDVwUmRnZWs5QVNtWXQ4ZWR6UGRCcTVKblhmNlNLUDlzekpYQXVI?=
 =?utf-8?B?aGhjeFNjRmk2YjNCRVBmVkIrS3duaktnNVJYUkVpaXozVG9TRjBFakFxU3V1?=
 =?utf-8?B?THdOMDFoMXYwbmlLbXV3VEMzakg3WFRoTFZpVGxUMDlxVFNkWlMyWkIvcy80?=
 =?utf-8?B?cEFFaFI5SXhaZnUxMU43VkV1UTNSaWVUMVZLeGpSTW9IZHlQT2ErVk50MHpJ?=
 =?utf-8?Q?zB0q0TalAyP5DK0AcUBMeaN7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bf2688-10d8-41bd-6b41-08dd61777c2e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:06:37.2486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4dA9cVz1w5Y2byWPSYYhrjx++w4osRQed3gF4J14zLQnsuh4YJyR+ssUPAhO6g3EjvE64OnBl01ErdBXTXAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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


On 3/7/2025 7:18 PM, Christian König wrote:
> This allows using amdgpu_sync even without peeking into the fences for a
> long time.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index 86c17a8946f5..bfe12164d27d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -135,11 +135,16 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
>   	struct amdgpu_sync_entry *e;
>   
>   	hash_for_each_possible(sync->fences, e, node, f->context) {
> -		if (unlikely(e->fence->context != f->context))
> -			continue;
> +		if (dma_fence_is_signaled(e->fence)) {
> +			dma_fence_put(e->fence);
> +			e->fence = dma_fence_get(f);
> +			return true;
> +		}
>   
> -		amdgpu_sync_keep_later(&e->fence, f);
> -		return true;
> +		if (likely(e->fence->context == f->context)) {
> +			amdgpu_sync_keep_later(&e->fence, f);
--> The call to amdgpu_sync_keep_later(&e->fence, f); ensures that the 
new fence is tracked for future synchronization., ie., so If the driver 
only replaced the old fence without keeping a reference to the new one 
of the next job or second job for example, it could lead to situations 
where the synchronization state is lost. This could cause race 
conditions where one job might proceed before another job has completed, 
leading to errors. , so this is  " amdgpu_sync_keep_later(&e->fence, 
f);" done, for tracking purpose of next job/second job, if we have 
multiple jobs in gang submissions of same context/client, is my 
understanding is correct here pls?
> +			return true;
> +		}
>   	}
>   	return false;
>   }
