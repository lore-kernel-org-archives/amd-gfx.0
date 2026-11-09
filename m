Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAE606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cwzFnDM/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B50110E345;
	Mon,  9 Nov 2026 15:00:27 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF3E10E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 15:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwObZ6uu2/o1DDgBLpFLfWhXosiO9JGNvv6C1AShNHfhf+ydlIBHT7wiQlnjC+aOU38SrcnHoZEdH+WrGAjPUb4lHR0FwLObIv0MpoHtaojqCnZ9qoC++WsYBmt+mTdpPFARjYrXVMHAQm0IiQA10iX0PRsYoj/ewpEsduPOq7TEH35nCk5iVijOuye5cBzscVY7V6tG54jNXOfOG2FUeK5Tii3EMTXnmh+I/9BSGvNWvEfHydnfR9399B24z7eQ4zVnqSY8/6XGDssMLPSTvS0oMaPEacDVAIv6bm8aKj39fTbKvUYGXwS7RLLF4ljFgd97nO484b0YeI/kQMwoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvPRojh9CO6vG9sNZ4EZUY3zWtaELp5f+8rt5mJ+3fM=;
 b=kwkkScq05Z3tg6D/QPFMvTvyv8x7li2PdQmFtgmllQhOCDldrw9CMghKdV+6pWwrchd03bQtPOEyP5l2oDBDNINFWmzStMfR/5xOz8E/OSvpBwNSyFLo1ShRoDZ2zCMo4p/VPjNvRsZrpPAsp3ZTxxsKAdyIlzrAujKz680PRhdWIJoT/YwYYzz9BK4IWi4kcHZeoNeUYkSdmhCV0E1Ji79jDVk4e3jN2kLc9KhE/lNIO3Ekhq5/4DTxVKalPkoRAgjOxAoVfaKAU2++EZzseYJAA7SfcRtv+7MGAeHIwPDWRfoRnAeB3dR2Eus9FVK2FhW737SZMBM/nsAOH9t/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvPRojh9CO6vG9sNZ4EZUY3zWtaELp5f+8rt5mJ+3fM=;
 b=cwzFnDM/QdilQJNuH9X04Czzwl8C3nrydjbfmc8m6bW7EzdTlg7Bqn+Rz7VEN0WxRBavoqT3VD/wsV8XfKE8/SZp4LFZHbdZcmrwT0KLa11dPHFX34COxDYEVlURKSWq/94qBuzsQUuC5zUtRF5uWVyQYS71mjvFp2YKEtXKGKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 15:00:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:00:16 +0000
Message-ID: <98d9220c-ccd1-48dd-a293-eae4703c1dc4@amd.com>
Date: Mon, 9 Nov 2026 16:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu/gem: use dma_resv_add_fence directly
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261109145718.91381-1-benjamin.cheng@amd.com>
 <20261109145718.91381-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109145718.91381-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: f234b4bd-4849-4793-05ee-08df3e7229d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|4143699003|11063799006|261102123227099003|261021123027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: Mw+1eqToZua5Lg/7nrzxtt51J/mdxalvitCQM5Tb/JijdwO8/4I0EDcq1kD0SjqohQ+RkU8LKzxe4RBXD2uIIsQwJBakodG18cI+JU0KIrkRitBSM9i1EkwNaDDSJUJxfi7KR3EFzCeMoVkSsi79bzOakXMFiYIHGzNLsEIQHUZuD2nMQrnAi/UlN1bNSKuEkqk5tQpPnwvfnFjhLDMWrS+eQ9aESftDTXQfvzpnHkcF1OUjYOYgWByoS4zf38AiUJtOjLL9NKCu/eT3x+MlBBHhLeb+8KkKDaIn8TP6GcbCMYUaO30smfytaHyRc8wxw9cqkCEJODuuE9YHl+/pk5TSfxwSB3jftTJlVBPmCdWbhZUEtaq9WUg24yG0vXrI68cYZQjgmwIe2G7bgAhsW0Ml/y77hr3xT6psavYY3PWFa05kNh17gfwQ9nDrthuY45yt5tVfr/s64BY5ZzGs0N10gLJJ+VSJQg3SgewxJffBuVlZIueBXtcEkQNLIDhJ9EQ2zSPTNhMVo7OHeFq1Nj1JbBc81WiU0ySm3AWvdaRe+3btZmtEeu3R0oY0A4buM0aP9dIe5KFRqk0Bxllu0kGP6ocFivZ+xsWJHeQhlofQLkYp3tZmMw0NNn3OqcF2S7NkLLefjIbP2LaA4WJftUhS96wLnHxmWXvw2mZG0g4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1tREJnbXdpd29uUW56aUdtdW9iKytYeDQ4QjZtVDQxU1A2emw1WVFPTGk5?=
 =?utf-8?B?VGs3MlpIanYzVzNpMlNyZlFIa0VCKzBDcWJ0dUQ3blc5Y2IxY2V4MTQrTlp3?=
 =?utf-8?B?OWRDcmdidUV5VllvWlQ1QjJLNnRHOWwycDlFSkVqNmdFaDFzNkRhbzhMOVNx?=
 =?utf-8?B?aUY4TTY3Z0hBY1FtaUZVeStvQklJTDBEdUthb1l4SlBseThSamFKR0ZUTmtS?=
 =?utf-8?B?d0ZDVnlhbTV1M1FhZkd0T1c0c1hqTk5qVDFES3ZIblNUaHU0QzdjVGFIVmh0?=
 =?utf-8?B?TlZQaFJkc0cvdnVZQXhIcW9PYjJadmc2amdLcWdjWEdCcG5UWmlHUzNOTFdZ?=
 =?utf-8?B?SVh1anRmRklRc1JCTGtsRzVLYkxXWDM3Wk4zeXFtYUVOOWNreXlBYW8rbGRk?=
 =?utf-8?B?eGpSelhLM3ZYdGI5VUk4ZnZmeXdtaUMvWE13bDdXOTJqb2FteGc0NXZqZ1or?=
 =?utf-8?B?WEgyLyt5MmpPVGV0cmlBQjUrU01Pakg3WXpFSFhhVEtMQnNPWjA0MDZpYjBM?=
 =?utf-8?B?R1d0cU1GbDBZVWtLbnB6SXVpdk9vS3BhcWVHYjJTZXplQzR5ZlRGMXJCTE1a?=
 =?utf-8?B?TlJCbm9lWGpmS0daOHFPRDZhUTdtUG9ZTzdrY3dYUnJKYTJMRXpObHorV3FM?=
 =?utf-8?B?d3JZdWRYT0pGY041MXFyMTJVSmNDdjB1L1hBVkVPTWhLSEVrNVJLMk1EaWhw?=
 =?utf-8?B?aXdqd3FaRytEOTk3M3oybGZHRGdjZDRvOVZxVnliS1gvZ3RaR3dmMUkzbTE5?=
 =?utf-8?B?NzFWSlEvR0VlejdIVWxLZkdrNDIvOEJkUTNRVkRLbDFza2RpTVFiOHZxSXIr?=
 =?utf-8?B?V1gxSFc3cU9ZZkNmVTBwc2Zka3k0VWg3R29VMmkwZjNIOWF0TVlONUIrWitp?=
 =?utf-8?B?TGgvS1Q3WmlDTWttdFdaYzl0SVFPR3k0OFA1ZkJWVVBBMHFPemQwenM4d3F5?=
 =?utf-8?B?UkJQckZMUkFtcmxURlFNOHRWMmVBS0UxaHRyUUVnQktoaW94VUs2TCsyY3pa?=
 =?utf-8?B?SGI5Tm9GcDdidFdpTUt0cFJNaVpnWkdYVDdzT015Q2IvSkZ4b0FwcEpSN2tL?=
 =?utf-8?B?K3FJVXhNM2RrNHVaQ3FUcW9lblZnRTRlcXNiZGF5WTZFVWNWZU43MjIwUk9Z?=
 =?utf-8?B?cnlHK0sxRmtJbGlZalR3WG5jK2UvU1U5a0Fnd1hab1NIV3BRcmpGTmdyWjBS?=
 =?utf-8?B?MEJZSjlNRXBRNVpKM0hQTU0xcW9EYnU5V0ZhSk0zbGRydzZreVlTd09NSmZX?=
 =?utf-8?B?WjJ1clkzckJCbnZoaHFyTnI1UXZRbGNhRk43eWtWaU43YVFZZytYd1NtRGtq?=
 =?utf-8?B?V2c4MzhNeTNSSG9SdlR1NFlUUTIxRTFjK2x3ZFhETEJjSFdrNCtaZTB2MXhX?=
 =?utf-8?B?YTVWc1lIeFZFKzJRK0ZQYjYvUTlubUtBZjY0cm1xZGVUalc1cHJkdVBxMzVz?=
 =?utf-8?B?cEoxK0FpQTNHdVcwb283TklyOGpNaGEyWGlvNjJGSERGelRBV3c1bzRLYzFs?=
 =?utf-8?B?a2hoK1V4SldBSVNTV2k5UFdGVHdET0ZXaW5Pa2ZnZHZyek92ZS8xSmYwRU5F?=
 =?utf-8?B?a1FMRzVIamR6L2tSZmNzT2w2TVR1Yit4dWI1dk83R1c1NnJQQ0MrMHlLeENX?=
 =?utf-8?B?QlRUTndqN2dVVktreVYyTEFOOVhIcUhqbksvV1NlOWF5T3hKbHVKM25xeUMy?=
 =?utf-8?B?aEpRWDU4cjVwMEkzMUNidkhjR0J0K0xqK0QwZ1Ira2VteklVQnYwdUV5UzVG?=
 =?utf-8?B?RTBWN0x2WE8waFBMVG9JNEJLVXV2ZTJHZG1ndTV4WnZEMWlZS1J6dUZ5elZ1?=
 =?utf-8?B?VXA2Q1d2bkxmUjV0bFRpOGUzRFZFUUk5Q0VVTkZSRmR6azluSXl6d3E4eERS?=
 =?utf-8?B?TlcvUHFLajVCcVNLRDg5R1h0TzBOemVoVWo4NW0vc1M3a2dnSUFNai9ZQmQ1?=
 =?utf-8?B?S05oME02SkRhaWxlN2FtVzVEQ1RHdGlZSkljOWRoWTZiaXI5dXgxQ3RTMk9B?=
 =?utf-8?B?Wkh5R1JrRG1mSkc2S0Y5bGFDMDJPb2g5ejZsRGlTdTd1ZHNDalZ1b0tCOUEv?=
 =?utf-8?B?VUt2SVZuYTBDaEJocTVSQXpEWTV3enM4ZHFwYkdBcVFjUEhzL0tFM2I0M1U2?=
 =?utf-8?B?NEtuRm9SbFJyK2cxSzNtVy9LcHl0bjJqK2Z6MlNYSG5LNFFxZ3c4Nm9wVVpr?=
 =?utf-8?B?MTk4UzFieENEajNSSFMrRmw5VFVPVzM2c25vejJTQXVUeEIwMjVNSGtaT0Jj?=
 =?utf-8?B?QU1BekxMOUdoNU5zNFlaUmpwNXR2bVB0UnNCWmFNWEVTY29yL204VWZaTHpG?=
 =?utf-8?Q?f7gqevUMU57ldwc/Nd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f234b4bd-4849-4793-05ee-08df3e7229d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:00:16.1549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcu3hUyN6hntkWh7tLHRrSii1iWzDyN5O0sX19VgK3ae86M/Y/OR87CDWmHOaTiO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/26 15:57, Benjamin Cheng wrote:
> Christian pointed out that amdgpu_bo_fence() is deprecated since it
> reserves fence slots there outside of the lock. Replace it with a direct
> dma_resv_add_fence call here (we reserve the correct amount of fences
> already). Also switch it to use the BOOKKEEP usage since these are both
> kernel-internal fences.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Oh changing that to BOOKKEEP is a really good idea. Are there still users of amdgpu_bo_fence() left?

Either way Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index c9a84257ae5f..eebba3bea089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -373,11 +373,11 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  	if (r || !fence)
>  		goto out_tlb;
>  
> -	amdgpu_bo_fence(bo, fence, true);
> +	dma_resv_add_fence(bo->tbo.base.resv, fence, DMA_RESV_USAGE_BOOKKEEP);
>  	dma_fence_put(fence);
>  
>  out_tlb:
> -	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
> +	dma_resv_add_fence(bo->tbo.base.resv, vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
>  
>  out_unlock:
>  	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))

