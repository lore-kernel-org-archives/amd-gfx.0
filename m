Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBB606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jttqd0J3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054EC10F285;
	Tue, 20 Oct 2026 07:09:26 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F34C10F285
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 07:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFio+PDA/fFCWQzwaNzZmtPuKol0fmS/iNdEVieJxyf6ErHIn72rowZPfANynvbEz5o54IX1k9tEk2D9W+stBi/3phwHVoXz3smIIQXwxTJG/XsgILRzxXP0sbH4k2We27vGur8+Ja5s03ouG4XDkjxRseghGgmxbfOy1T16aO8Dk9iZtCTmuy49u2ebibaM4bLOw2bd3OcgffY+Vh3HDkLDv+03H3Bd4N/UVlQKd/YpOl0F9xppA3KhrQw5+86Uscz4GDTo0SCANbE3bvzKMgM5NdIUe8LNi79tjyi4N37Kxo65JMvXQJcNWdoLoeG/CXpoZNSWk5AE9XKUHwWDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MRxoKjuF9GY/psXikfP6nL1wHAFQUCFGShyp8Ugn/U=;
 b=v43wPT2yNOVXx713JeGkpmsQRPkyi+2ne01RZBhiAkOg/Z4XK9LJcafR/rcXJ/J3e9wnxWB/05u/BKqQwvXgk/1YHS2nWcurieisOUBaT9n0a2PB0Jo9BfuXIGd88nMYK8VlnATUkOmR6gX3lySYcYssVkiAzCIYnhxTsTdpCfHBzXc/oegQZyD59r/EROyjew8cR66i+sTzdrLfi3cFnCZI1s4od+ssA/7RP0N1qDZj3OE7n4qTPBAH5NYe8/uYcy3/GRX3pYYfT6Zg4/PzmkJU4oMh3wZcEqRBYlYTHFjTNp+62meIMxidozUyfJuqjwx9O9htRPuUHeVjo7SYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MRxoKjuF9GY/psXikfP6nL1wHAFQUCFGShyp8Ugn/U=;
 b=Jttqd0J3XHPmvcgQ2D7aY3pf3EYyonsnQs11Zk32VTTNtyq015uzze0s3PowSbzdkbPUC2+BIXJxT2y5uWeKMgcVTjjBHcbXnws4tjtjemk5mWl5DmQFnmH3lHwIycMjNuTnoZT0+i+GuvH0TrUFrq+DrOFCTrIlyXf9/dB/08I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:09:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:09:11 +0000
Message-ID: <0226afb2-f699-4396-b5a4-f847f26b8415@amd.com>
Date: Tue, 20 Oct 2026 09:09:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/amdgpu: don't allocate or lock BOs in the
 UVD/VCE direct IB tests
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
 <20261019064838.2577746-5-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019064838.2577746-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2ede4a-54a2-4868-d6cd-08df2e790a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261009220027099003|261009221227099003|261009223027099003|261009223327099003|261009221727099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: W/gaPz4y78JJiFz4dh5MZlILQiTJdUW+hwk5dVtoP2uNp8zMchNqoQnMXZ9gLVoodbTha8BHa41qubghBL5WrqxEp2skArlE1eV4sozdnWA/FJv0XbPSjcONwypgg57S7NQPsmQXVvc0miHwT+wg7djrZUtDTv2RWLPX0tUTCxelgT8v0TGRYoxa63GFbMhjjcRtgL2cvGZb/mPMVfsN9q97KvTG2bd4nccgAAnY7MoIDd018+71lutk+9VPmfaEDCLQE2XZPInK8Ae8ODBi44+65wJbeNKyoubj2vrk9KCjYbAqmYNIU+wMuhMKgLeaoeKvGKt3E2+CkFk3ndJF3dWFod9AoVJTAGMTBTlemg4w1YuK8gxuncqv9BxrNpmcSd3tNqE3dG8eDLWmMj8PQGadGh9B/sKhhKsn+OW19D6wRYwMqtn9XcOMyWaVZiQoSbxAV7E/AbIeMniioVFNomqi03iJDLhOzuOgFgTZ+/pW7xvA4yht0e/by1i/6I0XrEUsgqFVP8AeP4O7xemIEzBByMgmnNj2Iq281TAPAUUWQCx4CIEI8V61i1dgLVZQiE5reC4BQVib53p/pb4+v5fB9+Zr4JNVbaqKAP+0/oVBbxL1D7ECoIF4swujYP9PDCn7tIRWSZvlbRPYzVWUkbU7bjIKc9/lw2gVDxJ2Vps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261009220027099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009221727099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3hsWmd5Zlk1c0hkR0U4Ump6NnhGVnVyNFpDOFZVaVg0MUphK0JkUjdNbjcy?=
 =?utf-8?B?M0Y3K0lQSXpXcnJ2T1lGYS95VDBDeEhiZkFzdlR0L0R1U1owb3JpWldsQzhQ?=
 =?utf-8?B?eXhSSjRuYnFxQWxraFlnMk9FWXRYcWlhN09lc0hhZitjMkFSNjErbDFjK0E4?=
 =?utf-8?B?T3FJY2tUMkphS0FjdmQrclozVlZud2tXZnNQK2UxNFd2cmdvS2d1M0JOcXpa?=
 =?utf-8?B?VmFxdkpOWGs4b2hLY01mT1Vpa0xyYU03RENJWFNvRUJJdFFhRHZrSlVNcWFF?=
 =?utf-8?B?SXJBRGZ0M05acXpiRDdHQ0NXZzFCeFJqQVhlZVJyWlNpa2w1RlVWTXBqOHMx?=
 =?utf-8?B?Y1kzWUE1bE0xQ2VuaVVJeUFZdS9VUUUzcVAvMU9kTnkzRDRpeHdVcE8wTnBM?=
 =?utf-8?B?ZVlHUmhsQy9ZMW51SGdXNzJvQkFPZlEya3FZdTNEMXFqQTdmaUJCK0d1MWdh?=
 =?utf-8?B?bEltSTBoSzN4TVA5RlhyaUtKRjc2R0NqNlhjTFdTbXhMTHNVdEdqbjNUZmsv?=
 =?utf-8?B?bzd3a3Z4WkZMNjBwdGxDU3JxUG5KOFNmY1ZjcFNKUGFCUHh2VnQzbzY2T0pN?=
 =?utf-8?B?MG9VMVRuTVNRTkdSZU9kN0ZLaENPU3Q4SnBpc1ZoZHU2L3VqMFYzZ3ZYY2xF?=
 =?utf-8?B?aTc0d3NyRTE3QXBVWHErWUluR1E1cWdReHl2Q0VUWWJRN1kzNnFrb08va0hq?=
 =?utf-8?B?YmJZbENMN1ZrVFpwN0ViUFJFTUp4SmRHTFo4alFOdTFyem1GR050eUpnT1da?=
 =?utf-8?B?L01rZ2NrZTBPL3Z2akxLYzByMlZiOVJxNG5VSVJwdjh3MzZ5ZC92ZnVYaEJ5?=
 =?utf-8?B?TE43REZFVUpiUkZkWG5sQmx6WWxqVysxZ2lJUnlDUXhjOEtIdEtNOFZIUUdj?=
 =?utf-8?B?OVR2SEVRRkRBZUdqaHVBbTh5aVJSbWxLMVhTMm8xeXpCLy8rS0dUc0lMS0Ru?=
 =?utf-8?B?UEEzTzNjK3Q1WGF2NnlIaFhsdjNxNHFYbk12bDNzR0JHbjdsZTd6dWordXFa?=
 =?utf-8?B?R0d5SG1OZDFITzdTOURBN1ROQkRGc3lHdE5KWm9OQ3hMaE1hWGNRQlRWc20r?=
 =?utf-8?B?QjhjOWR6MnlJYnFtVDltT3hJYVNFQWl1Zi8yazJaUXhJcG1vRG9lajlhSjJG?=
 =?utf-8?B?clYyTUdueWZrK0tXZThrcTR4cVZMUnE5RCtsMWduUmZWOXpLa0czS1dicmQw?=
 =?utf-8?B?RXo5NU5lV2xhT2NObjVERm1SR0pwaXdaZzE1ZU9qSFNLZDU0Y042YVFQMUNF?=
 =?utf-8?B?V1QyRE5Kc00zbFB4VWdBQjhJOFNFRlowR3lRU0dZTUZBQnFNc1NTVlB2Vjgx?=
 =?utf-8?B?V2JML1lNcUlIMnpBNVVGaDdTYkNjaGtSb0hId0M5c1JJWm5XVHdFZyswR1FF?=
 =?utf-8?B?SFk2MS9TYXVEeExDWkpuS3IzVGZrVk9teHhwRXZueEFMejhCdVllZXZBbDVu?=
 =?utf-8?B?OUdjZnZTaEVpcnNQZUFFL0I2MS9kR2NVTTBPY3hhNmltcDhxWG9qNWlwbVU0?=
 =?utf-8?B?MHJBaVpXbWUwMVo5SWo1dFNWMjZLQmpSU0hZR3cyL09EbjVrcnRBZU8vemdt?=
 =?utf-8?B?VGpwY0orSWtWLzIzOFBCYVg2YlFiRU8yYWZLL1hEdXJhYkVPT1dqUk5uYW02?=
 =?utf-8?B?NXlQNzQxblZybmdVMVBxZVNRZnBOQkdFYU9lcDhUQW1BYmhETDQxdVJoOW0r?=
 =?utf-8?B?OXpaOGFaWVRPRmFBS3hsOWVzSTBybGZtS3BWMjZncFBPcFdnc3hzdVRQUFRE?=
 =?utf-8?B?S1Z3SGdlMG8vMDFQTWhVWW8ycHhJQm1SaHlZN1Y4akxhNnVCdWwwQWZWeVA1?=
 =?utf-8?B?OVdkSTZvZmNNUk8ybnByeXR0MDI1TEhickVzekZ1SnAyVmlPTlJLcERRTnUx?=
 =?utf-8?B?YW9ZeUVNRzlEYVgvcUxBUGs1MlBJVkhhMCtIdnBwcE4vNTRhcWQwdHU2RjVT?=
 =?utf-8?B?MnQ3eUlBd2VjcEQxbk1DSTB0bnBTcE1mbFc3MXk3ZzZsSGowOHBDa2FxTHJa?=
 =?utf-8?B?LzRweitidlpUUjZLNzdHOVFvSkE1MFI3WERpQ1lybmo3b0E4dHBMTW5sTms0?=
 =?utf-8?B?Vm15K0IydWdoRzluRXAwbTNyNElVVVNCc0d6UG9xSTd5ZnhENXhFQVczR1ZB?=
 =?utf-8?B?dUJJSUhBQ3JaQktYbm1ZZ2QwMHhrZThRWVJlODkvbDE2d3NUV0g3aFB1c3lC?=
 =?utf-8?B?UzM4bHFkZ3pWN2gzemNtQ1dDZkZUT2pxYW9tclJmWjIvc3hDS0hRVU1hcUEv?=
 =?utf-8?B?dW9ORTZ4L2tCK3FiU05PVG5XeEo4ckZjZjV6ZFkrTVIrT1o2ZXViRHNCL3d0?=
 =?utf-8?Q?M2u2ZILKQ763/ZH3xW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2ede4a-54a2-4868-d6cd-08df2e790a51
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:09:11.0419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2JSdSayokT3i1PnPmqSjaDhWTRYUte7IN1abfuZP4fRfYlrZFjDBxuDeafQ+VHz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 08:48, Prike Liang wrote:
> The IB tests run inside GPU recovery, which must not allocate memory with
> reclaim, take BO reservation locks or depend on eviction. The direct IB
> pool and the job allocation use GFP_ATOMIC for this reason.
> 
> UVD and VCE still pass their scheduler entity for direct submissions, so
> drm_sched_job_init() allocates a scheduler fence with GFP_KERNEL that the
> direct submission never uses. UVD additionally reserves the message BO and
> adds the fence to it, which takes the reservation lock, can allocate a
> fence slot with GFP_KERNEL and falls back to a blocking dma_fence_wait().
> 
> Only pass the entity for scheduled submissions. The direct message BO is
> only used by the IB test, which waits for each fence itself, so only fence
> the BO for scheduled submissions.

Oh yes please! Fixing that was on my TODO list for like an eternity.

Please split that up into two patches, one for UVD and one for VCE.

Apart from that looks good to me,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 11 ++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  5 +++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index ecd7caa95d4b..bc15fed6fb9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1114,7 +1114,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  	uint64_t addr;
>  	int i, r;
>  
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
> +	r = amdgpu_job_alloc_with_ib(ring->adev,
> +				     direct ? NULL : &adev->uvd.entity,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     64, direct ? AMDGPU_IB_POOL_DIRECT :
>  				     AMDGPU_IB_POOL_DELAYED,
> @@ -1159,11 +1160,11 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  			goto err_free;
>  
>  		f = amdgpu_job_submit(job);
> -	}
>  
> -	amdgpu_bo_reserve(bo, true);
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> +		amdgpu_bo_reserve(bo, true);
> +		amdgpu_bo_fence(bo, f, false);
> +		amdgpu_bo_unreserve(bo);
> +	}
>  
>  	if (fence)
>  		*fence = dma_fence_get(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1f7a98cdce5a..4c049e591f7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -470,7 +470,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>  	uint64_t addr;
>  	int i, r;
>  
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
>  				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> @@ -561,7 +561,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>  	struct dma_fence *f = NULL;
>  	int i, r;
>  
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
> +	r = amdgpu_job_alloc_with_ib(ring->adev,
> +				     direct ? NULL : &ring->adev->vce.entity,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     ib_size_dw * 4,
>  				     direct ? AMDGPU_IB_POOL_DIRECT :

