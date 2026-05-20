Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027D2CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8895E10EF83;
	Wed, 20 May 2026 08:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I9TC/KX8";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAB710EF90
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvOHVCGtNrC28De5Wspn1w5Oes+zRxz5dbAjdowDGz1OSK/qVLwjk+FqwBpJWAgwtjCltP7/JmUfs35rszw+JY8MEdyueXByMWX7+ZJBD8hWfaUb3Kd9dmnHox9O3dcM1kN0qVFnC9us6laJQVodJ+/xWrWKTPtKUfWRYC/clC/GArp3br2ABc8qtyqNHmDIzT0JAtKRkC0r/PVBcFN4/kQNW/9V5K7AtpuNnDA5kc/+jtb2+JA8lLXr5EjUJqG5nBBUu06CYzzk89FMShYOY6pmkpR/92UmM2JszlWi7iJ7brfTv7Hu9wmBLPW2iicr1h2nP4t3g/LQM0EBc9Hfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuH/ncKCT/nWRs4pVKRGB1LNyGzNcBB2tFGNCnNTHzY=;
 b=h8PbRMrLnRx+GNtw8cXzDOon8fb7khNPA3V7yJ6H1H43hdmgukJKf6fA8xJaftbjyTP3IesGnhWQuQxLJnxZdBYbSnn9vdL1sJmr6eHTdusbat58gYyDPlJ4d3n/heiDX2DokIiQWCUf+uRsv8CWjhJaBWDlQPiCpWteA4FkkxNjx8AnB3KIg1cuBZx+ho9vFS7ofoOqLKjj+AJNksYmtT0DAjLedUcTxLaxyahf5J2gjcBxxsaaalLJ3kAs3t+Z/UUVb9JcGrXsVec6GQfpo3/i6vkDWT4XAAWYVIn5jyDxCqPjq1aPNbyctXJKuVAR/yM3ZH/PF9/G4rGnGRn1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuH/ncKCT/nWRs4pVKRGB1LNyGzNcBB2tFGNCnNTHzY=;
 b=I9TC/KX8gKF8zpNyXRIL3z+fFyUuH/qFu0m6z/LnpyMe9wsdeu3TZrm314pTVVpOCM8kE2fpcQbGDJnPQd/GNxqtqFqG6zuzDn5Y4egdTZTbgdpiBU+h4U9MsbV5Np9og9mdURaxqymeWcX1yl9SJI5ZpmAtBHRmrw0xKcgfQuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Wed, 20 May 2026 08:26:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:26:20 +0000
Message-ID: <37239595-c729-40f6-a105-d66a7a5b4e35@amd.com>
Date: Wed, 20 May 2026 10:26:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: wait for HW fences before VM teardown on
 fd close
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260520010257.115740-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520010257.115740-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c07439-727c-4d4d-ceab-08deb6497862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: poeMNg5nunlFUKGM63BHNOHsf5T0TICU3oOeS7fvn9w58bgpA2mDfhS/TYv8CNe0Mp+xFO8Cv0oG34eSvirgUNKWSJ07K598f0cJj2kuV/dkhmQzRFpuaLuyowq5tpJhhwWdke3niSuVDNo/+kPH06iGlCuyLgOVwjOyeobUSHNUkAz5UvZDUbcHiRa9CeM0LyYTvH9D41PQcRvfV4+k+H2cmFm0+t/6AYhFtmBDbgZBPxU+xMwBb6b3Q99/d6MgJ/Rvsp1anPAJJHovIPo09jkaIL3WMIvdZghj0OknHLAEZxMWh2kbdgdcdvlLwYOw6ZZZ0QR9ax5TxLb4iG6fS0ZM1L7Xx/Nt4BLGB8RJPHaooxaeI1dzByl8e+S+VdrktTfLsmHHYuU180sr6RKPmj+v29Ro2FGYwRJTd/lDzk/hfKYaEEjc4/iQC7pNJVbBwevqgq+lOterqXfJxlVBZLRsoBbvzyVYlwzVDBEp/6krWuXEInU6mifZFRjqvdUex8WzJn3QfkQE1chNtmaqrV8NYg/Az8oOiazY869mH85ejbirRlbk73MQqZ8T1zbBmXMS3Ghb2ejm0Tp3iPh28XCsun1aF1XTVwycOHpH8gZSOfc6k6MJue2NxOWleY3HjWU7IYEyf0o863bjSrGfuFC5epSvAzBshpgxo5Ted1AfLBjLrNsfC4WV/GC9ALzX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTFLVjlkRmxxb2FwSmxFd2dZenpGZzVhR2w1bnVnMUs5UmJpNVZrc3pGNnVR?=
 =?utf-8?B?eDM3ODkwNWNRdURsc3RtOUtiOUI1KzQ4VDRQU1ZMQ3EwQVBrRWk1eDJaK21B?=
 =?utf-8?B?N2xhK3pPT3pjR0VzVTJIWlRtMEh3cFRqemNycTQ2dHpnZEN2eEZXcXc1SVFD?=
 =?utf-8?B?clV6Smx2NmxscHcwRTZwOXFZM3prNjQrSWJnWWVad2I2dXRyMW9HbFVnMENM?=
 =?utf-8?B?RE0zRjNYSUFXcmkzK2hJb3YxUk1wV25nWUUwVllRSWVEbExUTFVMdjZFWXlW?=
 =?utf-8?B?Y1NFZlMxNW9XTXJRNzdhZ2h1bWNhNnFyTmkveFdiZElGeFFkVGo1cmF4M08r?=
 =?utf-8?B?MHJGT3c4ZVYybDM2WkxlNFZvZlVFR21rb1IxSGhydE5PaElnYVc1TW9rRHEz?=
 =?utf-8?B?RXdHcDJuNFM4V1FQSDA2cUVpdDU4ZkdJNm0zSTNTZC9KbHN0UUNIZW16NW83?=
 =?utf-8?B?eGYzaXdpdzhWU3BVTUd2cXY1Q25DZGFaR0VMdmxGZUs0aUhHb0hPOWtLNTdO?=
 =?utf-8?B?ZVA3MDlIakE1cXVaaWREVmtUQkV3eWFUQVE5NmxuM3FnRmRoeWI3OU5HTTdF?=
 =?utf-8?B?Rm45T0I0WkI2REVZWERLUjdKdHpjMVppdXFOdlFaZjBBK0t2VHdKeWZId3pk?=
 =?utf-8?B?MGtyMXd4NmZaU0VaN0NqY0F5RjJkajFLc2JMR0c4S1BEVzgwak1KMTlmcEdK?=
 =?utf-8?B?NTAranpEOUs1UWxwSFkwN0FDcEdtYS8yMHBqNmdxMDR1dWFhTTBnYTdJU2VN?=
 =?utf-8?B?dnM5THNIRjJDUldsQTRTTCtSbmZHSXpYQTFoanJVamFmVjgwcmh4M3RXM3Nl?=
 =?utf-8?B?N2hRTytienhja1YyRkd1eE9PbVRMOUQvQS8yN2cyQXZQTXpWUlI1dXlFaTM4?=
 =?utf-8?B?SFp3VzgydUtmT3J5cDVPQlo4UWFpWFZ0SHdIM1VsSW5aNFBYQXpNQllaeEFq?=
 =?utf-8?B?SW9HYndvbGFwdVo3alc3ZU45RFBTUnNEeHExbEpFMHU3dmREMUxLZU9FOEtC?=
 =?utf-8?B?SnZraW1ZVHY4US9sS3B3dGdNQk9Gc2dPZzZvZVA2a283dEtMdWpTMTMxK2xE?=
 =?utf-8?B?bHVESWRpL01wS0t1RmtDMSt5MDR5eCtmZVZ2aHBvYVROeXZ0L0t3ZVFXb2Zr?=
 =?utf-8?B?Q0VCQzRHSHVLTnJtaXZCSnVHQVRiZitrdmNJQ0p5NXh0eDY3c2J2OTQ2WFBx?=
 =?utf-8?B?S3YzcWhBWVhPNmdKa3dVYzdoSksvdjE1dU9LY3ZaSTQ3cmNLWGIxQUdpTFND?=
 =?utf-8?B?VVAyMTd6anUxZmV1bWFIY1JZVXAwcitxTGNtSUJwSXp2ZDgxOEdCdThSQ0k2?=
 =?utf-8?B?aEM3OWlpbjQrbWdNZkZIOVFWdHRJdzByeDFlRDRKUWEzYWdBOEh2K3Z2MktN?=
 =?utf-8?B?UFNlTncrc3JNelF2TDdvbzBMRERZVlhiTmFtNzlqL1ZIa2lqQVg0aHZBcldK?=
 =?utf-8?B?dnFQMG54Q2pqalFJc3pNVmw5UW9oV3BuaDlpK1o0NWh4NG5hRmlDRjVaY01j?=
 =?utf-8?B?YVZqeXptTnh3akJRekNad2NrcTNadXhvZTlja2ZWQWNPbDlXOUR3Y082L1kw?=
 =?utf-8?B?SE1wQjVEaEs4NDNYc1BGK2pJVjlOZDF6OXQ1eHRxSWYzZ3ZGVERZZEZFaE4r?=
 =?utf-8?B?Vjcwd0lCTitzMVhPcitIdU1NTG13VWh5NnRUd2xZeXd6UytRS3RyZEhYS25S?=
 =?utf-8?B?OXJ1QUhoTU9HbkI0bGYwUFA3WUpJM3BoKytrQ2JNMlc3QjJUODJFenpFc1BS?=
 =?utf-8?B?bTBhQUp2SnFWd3dFQ0FmUHVxQlR2bjk5dGkzcDFWOWRzS1VZdVFkUDFJbXVO?=
 =?utf-8?B?MFJFTDM0alNyemtWNlpQN2lYV3JIbGZOc2krT3RiZ0RoVWR2SjRnOGZZeGxJ?=
 =?utf-8?B?eVc5c0VNVWRXZ2tXbU5zQ2xrMkxCYkhKYTQwNXNjVW1CWVo4RmlrZDRSdUFI?=
 =?utf-8?B?djhzWkMvYW0xNTVzcVNNbW12b0RZRzZ0VEE1YWxNTHcvNCtMa2RBQnAxbHFp?=
 =?utf-8?B?RFlnT0swZjlGVS9RNkdTL0UyNnRMb3p1NGNWSXhwc3NEUW5EeHkyM1ZqYVBv?=
 =?utf-8?B?dkNkREtJYkV1UmNYQWNoT3dYVjVwSkNYazF6emZhT2xXbnZXeFlhOWxVcmE3?=
 =?utf-8?B?akdvbXVZMFB2RE4zZzE2Nzc4c0F5TnFKaXhRMG1OemtGWDByWEwvenFRR0lp?=
 =?utf-8?B?V3RzM0tPVTl5RHBwMTBlR2ZuWXdISjBtZWJ3VkNyTmZlSytJQ3ZLMHlOOTdk?=
 =?utf-8?B?TlR2Sk90a1VEYUlYN0d4bTFraHZBQWs5V2U1WjZ2ZXFjeFFIN253KytpdUpm?=
 =?utf-8?Q?SAnN7AAXbkaAA82m+1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c07439-727c-4d4d-ceab-08deb6497862
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:26:20.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLCfO67nmfk1fqTGDe0cWpQ5UZegkn6Cbme+FjcY+YEQJmSqsTYaAdtu4iqYhjcy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
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

On 5/20/26 03:01, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Add amdgpu_ctx_mgr_wait_idle() which waits for all outstanding HW
> fences to signal before proceeding with VM page table destruction.

Yeah that approach doesn't make sense.

> This fixes a race condition reproduced by the IGT test amd_close_race
> (subtests: close-race-low, close-race-medium, close-race-high). The
> test spawns multiple threads that submit GPU work and immediately
> close the fd, stressing the window between job dispatch and file
> teardown.
> 
> Without this fix, close(fd) tears down VM page tables via
> amdgpu_vm_fini() while the GPU is still fetching indirect buffers
> from those pages. The existing amdgpu_flush() path only waits for
> scheduler entities to drain (drm_sched_entity_flush), but this does
> not guarantee hardware completion. Jobs that have already been
> dispatched to HW rings continue executing against freed page tables,

That's perfectly expected. TTM makes sure that the underlying page tables are not freed until all GPU operations are completed.

If that isn't the case we have a major bug in the fencing of the page tables somewhere.

Regards,
Christian.

> causing:
> - Illegal opcode interrupts (reading garbage from freed memory)
> 
> The fix inserts amdgpu_ctx_mgr_wait_idle() in amdgpu_drm_release(),
> before drm_release() tears down GEM objects and page tables. It
> iterates all contexts and waits on the last submitted fence per
> entity, ensuring hardware has completed all accesses to VM page
> tables before they are freed.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: I33fea5eddaddf1a246d21293d784cc6b7f544541
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 44 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c273557fb1ae..7fc14b7b4374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -957,6 +957,50 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  	}
>  }
>  
> +/**
> + * amdgpu_ctx_mgr_wait_idle - wait for all HW fences to complete
> + *
> + * @mgr: context manager
> + *
> + * Wait for the hardware to finish processing all outstanding submissions
> + * across every context and entity. This must be called before VM teardown
> + * to prevent the GPU from accessing freed page tables.
> + */
> +void amdgpu_ctx_mgr_wait_idle(struct amdgpu_ctx_mgr *mgr)
> +{
> +	struct amdgpu_ctx *ctx;
> +	uint32_t id, i, j;
> +
> +	mutex_lock(&mgr->lock);
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct amdgpu_ctx_entity *centity;
> +				struct dma_fence *fence;
> +
> +				centity = ctx->entities[i][j];
> +				if (!centity)
> +					continue;
> +
> +				spin_lock(&ctx->ring_lock);
> +				if (centity->sequence == 0) {
> +					spin_unlock(&ctx->ring_lock);
> +					continue;
> +				}
> +				fence = dma_fence_get(centity->fences[(centity->sequence - 1) &
> +								     (amdgpu_sched_jobs - 1)]);
> +				spin_unlock(&ctx->ring_lock);
> +
> +				if (fence) {
> +					dma_fence_wait(fence, false);
> +					dma_fence_put(fence);
> +				}
> +			}
> +		}
> +	}
> +	mutex_unlock(&mgr->lock);
> +}
> +
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	amdgpu_ctx_mgr_entity_fini(mgr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index cf8d700a22fe..0ea86235d0df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -92,6 +92,7 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>  void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>  			 struct amdgpu_device *adev);
>  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
> +void amdgpu_ctx_mgr_wait_idle(struct amdgpu_ctx_mgr *mgr);
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>  void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>  			  ktime_t usage[AMDGPU_HW_IP_NUM]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4d4d21babc61..6089bc30c915 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2972,6 +2972,11 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  		drm_dev_exit(idx);
>  	}
>  
> +
> +	/* Wait for all HW fences before drm_release tears down GEM/page tables */
> +	if (fpriv)
> +		amdgpu_ctx_mgr_wait_idle(&fpriv->ctx_mgr);
> +
>  	return drm_release(inode, filp);
>  }
>  

