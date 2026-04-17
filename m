Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5494FF43697
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 12:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA56710E2BD;
	Fri, 17 Apr 2026 12:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yHL649Y0";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD7210E2BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 12:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+raGpUxEXj6/t2WXdW9RLN/LfIHnWleUgro4zqCGy/NdGD/hZj4ldbUMe1zEzgEJ5Kh7D/y+8F0e16hWzwGqhNUJlel4b4GVbMlEnY3E0KJeemJxYn6P1zw9MGV1HRtj7g/SW5yarmQpbXLptHsD/zVgFqe6k567WBMSyfhQMiT7gAuzcFEB0jjNXrkpkDDGBTlVDm+AGDNvjpigAF/hhNX4TamwjuLuRSnrpw4MmvR6itDXFRcNw8Rfd3QVZSzYTFSYeSI0FUSrJUzck1gqbUFdAbF+VG6iECzLOUDE8c9Z+kanIgvkTr5XkvSwF91Fow/0SowJSQkax7AoWQcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqP6nOw3MW/+ps76fnwhO2bGYq2dTFOM75q7SzfQ6mE=;
 b=xjvo8j54WysrK7ozS0jHUymzHPtRjjRYcCcOZsJ0H3M3v2xCza9IZDVUWNtTQYSPUatqXWvr36FRbgqestTN32hHA9xg9fPchelNflppqZiIE1Rm9QQvnvx6Op9rUvK2PGipjnBhUK93WdX79q+TtgZCHe1Of5f1WdtHuT9FQbO/W6vAkkm/DT/BS9HsvR2s0DjJFEqVxAGNx4YekaghNiUNRlp0ZDc00BoJXsIyFcrqcXyKK7WQ1/Yq6MPv3vJklilm1E8z1ShVH+AcvYTPOyFr4j3tptg2lSGFmzVqCdD6DV743fWZ3DZK2T77hMmLRuzpyDPyFuvX94dXgLyKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqP6nOw3MW/+ps76fnwhO2bGYq2dTFOM75q7SzfQ6mE=;
 b=yHL649Y0pBToleAybTLVpDosdpQTs4wcquWOWpCpgPX0bcTNxFGvYfjITkca1UMePYaRWrPG4SDy1X1YoVVOc2HLIlZW6/3wlZHJi++oePWkInWhXEuSkdSr94wx7b3g4mFn7YAqTyamGQl+ZwBdAb35Hp5TUrzA52E8n25OJVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:56:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 12:56:56 +0000
Message-ID: <89ea2f13-57aa-4a9d-98b3-f5693e33c13a@amd.com>
Date: Fri, 17 Apr 2026 14:56:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu/gfx6: Support harvested SI chips with
 disabled TCCs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-8-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260416202643.25350-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 39df7659-6e22-4a88-2981-08de9c80cdf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Rgxb6iYeB18Uqh1QcwuwutLrVOFLx2t2mNz0jmjY472JmKq82gAnP8SX3huRjkF0Xj3S3BvSiu7vtDGMYMdhdR/mZxgDEhJlgEolv5GD5lub6tzK5Ub3kws23CKYpyaW+o9BYBEe5t/ATRv8lTJqogp5s9plfaqUbw9lSJeZtajF5OGyughigjcDZQjXDn1XPqvyerBWG0zBcbSZ4MVyqj3p+qfTXVUerejHzyeMmGO2lZlddU8SkZrHG/donzYgKPzZX3Ad5kuea7gbqnl744o9qjTl4d1PobS2iicy1AdblwAvwzaH6mK1wpK7CZOIwN5BwcCC9k9Z7wak4CA6foU/k4IH0VYSsIy4XZ0yJJytRzBa3UUA/oBEIz/0vKNxJemHlLZ5YIYyJ9kJChIP9rseM7hZCe46gsp7u62tx9huUyR29lEtxHEa4/2dQfm1ZHDV09uEag34NVME9/NZsTbTvQouyE6MY6Qyab2SIeMEmR4tfh7mq0dh+kdFvjHfCCcjs8RsLtU9mhkJLtuvHb7/vCQvaYsHaSP1oSvNBZPlv9K4Doo0oBuS7IOvCuEtLdVKOnB3yJxnVTAhuY6jS7IQ0w+s4Zanxt8P1URuyKHRDRb8Zm1sXDvLMEDlMu/kuibigfOwHVFS5EW0kh5qOucmb5749cDhcpby7ZYG15E8NR53aJ8wt0PK7LqKRUB7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGcybG5oeS9CODZiNGZVVGtXSDhSS2V3YmZsV1dBRUQ5MVcraXNjY1B0dm8y?=
 =?utf-8?B?WnMzcmxNa3Q4R3dzQTcvTG5va0pUUkl6c21WMkhhaGN2Wk1JQ1F4THdKRXVC?=
 =?utf-8?B?c3oydlJ1SGdEVzZ6RnV4aGhMMXFRL1hXb2swbTQraUthVUR3dGJtRlZaSkl5?=
 =?utf-8?B?ZXV0RFB1R3RBdnduWU0yd0kxMkJFaTZ5c3lkaCtkN0h5OEJkL2NxQ2JyWldC?=
 =?utf-8?B?c1NnbzlBRkhPdW84WmVTTnBlNTdoZmhOb0N3OUlWaSt5MnNUWDdUWnNtd3N2?=
 =?utf-8?B?Q05lYmRvV0N5RDVkUloxeVo5dVV6andVanRmN3A0ck12cFFyUE1VNXFjTjhE?=
 =?utf-8?B?NE5uSVdkNmF6L2NTM0hqSnpiK0RSa2pjWXBkUnQ5aUYyb1RmQVZuL1Y3ejVz?=
 =?utf-8?B?aWI0TXlPS0pGZTBpbjdqMVNqaDZZMzhZVGwvNm1EZk05WWxqYUcybENLU3p6?=
 =?utf-8?B?VllDZWhyNCsrTTJoUkQwM1Fvam5oWG95aCtiOE9md1hxN2Q2cnB4NjJoRzdJ?=
 =?utf-8?B?YUEwc2k2K3EveWk1WkJJK2JvTEZYVU9kSWRNMXkwTllsUStMRkpHR3FHVFlH?=
 =?utf-8?B?K2tJb3g1RktqMEZKWGY1bFcya0JXUExsMU9icUpPZWlaUG1vbTRJeFJ6cTAx?=
 =?utf-8?B?RHlIS05SOHByY1FCSjBQY01sRi9JMFFyREFlNFNGalVpOVYzMFZCQmN3N1pD?=
 =?utf-8?B?K0dpcXhJa0UyKzZpckxaOEUvbjd2cjNIaDZueUtRclV6MEx0cnNSSTdxNHdN?=
 =?utf-8?B?UituaVdDeUJrRENyc29jT05pbXZoYUJNb1lPREtmWjhsNzMyL0pSVFdVZ0hj?=
 =?utf-8?B?SnpxUHYvZzFuTWhpUjZHZWdBRitlMWIwb3hQVFQ2TEppQ1g5MEc5c1RhYkty?=
 =?utf-8?B?K2dLZTRxbUc3K2JxdFRvbGtKbHovSmVnMExyZnVXSTJWL1hkd3Mzb3VWUGp2?=
 =?utf-8?B?UVJnUG5zMkFRcmdlMHpLbWxhbFQwcjZEWTBGVHpTYnczTjJkQ09XRzMrTkRP?=
 =?utf-8?B?MEtvVWVOaGpkQzlrajl2NzJzMUMxbDRqaWFQSjVFUVFNcHNPRE1vN2xlaHNP?=
 =?utf-8?B?ZWJTeDVFcUdueWFkRzdZSkJ6VVVmZDhKbldtaTgwQkFkQ3dxS1JBUXA2dCt3?=
 =?utf-8?B?Wk1jNS9yTW9Qd2g4bytFRFY5MUVwKzFvNmNybDdmOVVFcmJMaFFkZS9YaWpy?=
 =?utf-8?B?eHpNdDRzOGo2dko0dU9aNEZjd2xIdEEvazh1MnBadzJBWVd5bWpGc3hOL0NK?=
 =?utf-8?B?OTdRaG5xdlhKcDNzVEFKUWlUUUszYVBObW1ra01nbFhqQm8vWFJIQ0xianps?=
 =?utf-8?B?cE9xa2UzYWdyc0FLSm1acmZVR1pUclh1YXZ1V0VFZHcwd1Z1WXR6b2hCcjJU?=
 =?utf-8?B?ZVY1OERleG9jbVpFZnBMb21BMktkZ0xmSVJJbG9QV0RtQjRLcExITm0wSkw3?=
 =?utf-8?B?L3NpZkZuNjFtdlJCc3ZLWDZmQlltTEdrZnBkQVAxbWZGUFk1SHg4TEtqb08w?=
 =?utf-8?B?cVdiUk0zeWhLVzhoaVhKQ0ZMU1hGUGFUK0xvenRWMVNmTTdYN2FmZFV1OTd1?=
 =?utf-8?B?Zk9wK0Jud1E4RHlHOE01MFlwazEvQ2R0T2d4c2I1TUM4ZmZpcDJBTmlFQ1JT?=
 =?utf-8?B?MWxDZlRub2RlL0w1WHk1Mzl5bXJpejYybHlHY0hZQ0pqNDdNQnpYRENWYzZu?=
 =?utf-8?B?TVJyeFYrZkhndys1cDl1eEhsSnZhNnYyRVliYVJmeGQ2Y0p4TkRmNzc3bVBq?=
 =?utf-8?B?WTlNSFIzZ2xza0dpWStzOW5wYkFJYjhRYWo2bnJEL2lXU2Q3N3FBWFFSN0V0?=
 =?utf-8?B?aGdsclJWQVpUTHBiMkptMUNUR1VEbFJPZDUzZnhrTm10cDI0WGZrd2lmWXpS?=
 =?utf-8?B?c1huN3ZrcmttaitNMnpDZ0EvZ3M3Rng1Nzh0eWhxR2cwNXE2OFFzK1RUaEs5?=
 =?utf-8?B?ZUVqak5NQTdPSUV4WnoxWGxQWEhtQ1BMTWVZWWs1Tll4Z1BsTGlEZmFUZ2ht?=
 =?utf-8?B?bkJrS2tJRmNqSEtKYUhYZytsaXlMTFFVL2p6ZDVXazI3cVZpY3FJYlloODMr?=
 =?utf-8?B?SHhsNy8zcStMVEk5NEhFSXdTUld1WFp1bk9yZm9mU1FhQjZYS0UvUFIzUENO?=
 =?utf-8?B?aWRxRlZHemdiTVlVWnQ5QUptMlJlMExOOXVMWi9KQkREYWZ1T1loZlNQbnF2?=
 =?utf-8?B?M2FUbVB1SWt0WkRrc01DV2tjVnBweXdIbExvNUNPZEZVR1JzbkdmRS9SN3FO?=
 =?utf-8?B?UGwwYzBDaFpoRjNHdi83QXZldEZjR3dxbEh0V2JYbmtEUTVwbzFPV0VYN0xR?=
 =?utf-8?Q?KTZdYjSunwRccjTyww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39df7659-6e22-4a88-2981-08de9c80cdf0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 12:56:56.2215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVpWnvmUMy7dyuL9uW6Drps4Ypg50B3niqWETmOwEpxZR4slHqmKQ8mhkfIO5um0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1
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

On 4/16/26 22:26, Timur Kristóf wrote:
> This commit fixes amdgpu to work on the Radeon HD 7870 XT
> which has never worked with the Linux open source drivers before.
> 
> Some boards have "harvested" chips, meaning that some parts of
> the chip are disabled and fused, and it's sold for cheaper and
> under a different marketing name.
> On a harvested chip, any of the following can be disabled:
> - CUs (Compute Units)
> - RBs (Render Backend, aka. ROP)
> - Memory channels (ie. the chip has a lower bandwidth)
> - TCCs (ie. less L2 cache)
> 
> Handle chips with harvested TCCs by patching the registers
> that configure how TCCs are mapped.
> 
> If some TCCs are disabled, we need to make sure that
> the disabled TCCs are not used, and the remaining TCCs
> are used optimally.
> 
> TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
> TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
> 
> Note that the TCC configuration is highly relevant to performance.
> Suboptimal configuration (eg. CHAN_STEER=0) can significantly
> reduce gaming performance.
> 
> For optimal performance:
> - Rely on the CHAN_STEER from the golden registers table,
>   only skip disabled TCCs but keep the mapping order.
> - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
>   which performs better than using the same TCC twice.
> 
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=60879
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2664
> Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 63 +++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 73223d97a87f5..baddb3aa7fa3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1571,6 +1571,68 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  }
>  
> +/**
> + * gfx_v6_0_setup_tcc() - setup which TCCs are used
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Verify whether the current GPU has any TCCs disabled,
> + * which can happen when the GPU is harvested and some
> + * memory channels are disabled, reducing the memory bus width.
> + * For example, on the Radeon HD 7870 XT (Tahiti LE).
> + *
> + * If some TCCs are disabled, we need to make sure that
> + * the disabled TCCs are not used, and the remaining TCCs
> + * are used optimally.
> + *
> + * TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
> + * TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
> + *
> + * For optimal performance:
> + * - Rely on the CHAN_STEER from the golden registers table,
> + *   only skip disabled TCCs but keep the mapping order.
> + * - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
> + *   which performs better than using the same TCC twice.
> + */
> +static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
> +{
> +	u32 i, tcc, tcp_addr_config, num_active_tcc = 0;
> +	u64 chan_steer, patched_chan_steer = 0;
> +	const u32 num_max_tcc = adev->gfx.config.max_texture_channel_caches;
> +	const u32 dis_tcc_mask = amdgpu_gfx_create_bitmask(num_max_tcc) &
> +				 REG_GET_FIELD(RREG32(mmCGTS_TCC_DISABLE),
> +					       CGTS_TCC_DISABLE, TCC_DISABLE);
> +
> +	/* When no TCC is disabled, the golden registers table already has optimal TCC setup */
> +	if (!dis_tcc_mask)
> +		return;
> +
> +	/* Each 4-bit nibble contains the index of a TCC used by all TCPs */
> +	chan_steer = RREG32(mmTCP_CHAN_STEER_LO) | ((u64)RREG32(mmTCP_CHAN_STEER_HI) << 32ull);
> +
> +	/* Patch the TCP to TCC mapping to skip disabled TCCs */
> +	for (i = 0; i < num_max_tcc; ++i) {
> +		tcc = (chan_steer >> (u64)(4 * i)) & 0xf;
> +
> +		if (!((1 << tcc) & dis_tcc_mask)) {
> +			/* Copy enabled TCC indices to the patched register value. */
> +			patched_chan_steer |= (u64)tcc << (u64)(4 * num_active_tcc);
> +			++num_active_tcc;
> +		}
> +	}
> +
> +	WARN_ON(num_active_tcc != num_max_tcc - hweight32(dis_tcc_mask));
> +
> +	/* Patch number of TCCs used by TCPs */
> +	tcp_addr_config = REG_SET_FIELD(RREG32(mmTCP_ADDR_CONFIG),
> +					TCP_ADDR_CONFIG, NUM_TCC_BANKS,
> +					num_active_tcc - 1);
> +
> +	WREG32(mmTCP_ADDR_CONFIG, tcp_addr_config);
> +	WREG32(mmTCP_CHAN_STEER_HI, upper_32_bits(patched_chan_steer));
> +	WREG32(mmTCP_CHAN_STEER_LO, lower_32_bits(patched_chan_steer));
> +}
> +
>  static void gfx_v6_0_config_init(struct amdgpu_device *adev)
>  {
>  	adev->gfx.config.double_offchip_lds_buf = 0;
> @@ -1729,6 +1791,7 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
>  	gfx_v6_0_tiling_mode_table_init(adev);
>  
>  	gfx_v6_0_setup_rb(adev);
> +	gfx_v6_0_setup_tcc(adev);
>  
>  	gfx_v6_0_setup_spi(adev);
>  

