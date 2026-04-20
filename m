Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA8F588C1
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927A910E56D;
	Mon, 20 Apr 2026 12:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mLM9fWt5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AC610E56D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUxDGu0SRcHVQSCQyZjv+T+OKjlKG0PTc6ejRWWunSZvckbnz9PoAZX+zkPWL2iUxoTCn7IbmhgHEiwR+lKbIELcHuJyfiVog8VqyNWXkpj/YZJz9gV9BMHAoXG0my5i49DMSB2qelyWQrvjqoh7soC1+0lLg1Xr4946GbqLk2ihqqR1rlojRI6Mc2oPklIMkHfMQObdAoHn5jnirKdze/KHj9fgg7dbcq2AOZ6MnhZyMTX4C1fMafnIvjhsay26S0Qg0VNhBJbCCT4M7ce9Q2lcxctNQEL9vpbtNkOSxwfqe+Yg8mILEbdnEiUaR3cuNGuBSqmMFvyDJiGVql79NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWZu+AvV+TcvfecdExFLWeB8zvmceDkiqWAB4EF3oGg=;
 b=PG8k9T6kljW/eVwpcGi/+E1scQge9HmrE2sGTaLty/irtJ2qhRIPHvk/yN3gUVz4Sz9LIBmD/WsUqqkfhll1y1qE/3aItVXzu1PXLhcJIbXtOG55Dou9YCIMsOtpaTiZUaDyTspkMzfv3e9XeAoSfcwuyhvOF53i5D0roECto2QmX1VAFLSG+cZiQGp1wGNDH16i8qq1IIZ3RWhbRf68wvKvqbsv10aALigRqU5eSr+K5fDBQiXg82rbDM44rFNfIafc5SQ/re3Dx119rRnn7R9cpA/eqbj2/9TRWucMSVyootx38ngm7adXJ+2Rw/JW4j/++gL6YejrP0B2BLanQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWZu+AvV+TcvfecdExFLWeB8zvmceDkiqWAB4EF3oGg=;
 b=mLM9fWt5JlXKY+TODukyYHWMEclxE1HwrlNZXUBwfvdQqxe6krk20AIn4oQ/ocj7DQ4Gm8qsGjx2PNFZY35KeJlSdzZdBCuhHlfflg7kRfrBB1EqGB7ls236Xl42VgisnvpzgPZZP1vzMWA4JoqNTLx9DzbJfGyWa/BFy7Vrods=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 12:16:47 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:16:47 +0000
Message-ID: <ce1ac575-6ac8-411b-8498-c71381b37445@amd.com>
Date: Mon, 20 Apr 2026 14:16:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu: Add alignment to
 amdgpu_gtt_mgr_alloc_entries()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a011c4-4146-4c0d-f5e5-08de9ed6b120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: JPPQLBiLnIItOFEYolLugCncDd9fQceracppN6xfm1kv/rzfsWe7FfztCrP1DH1w4cP84jXlZ4jiWy9cMx/XU6gB7sGmJP5Qo94tyu3NoZsT5d0H4d3ba17Yk6rBlnYekSjN8wgDc5Cu9n7+rXylifgnEQu33f78W3ocZljwWklKwXZeYDl/q0HIgnCvwtyw5RvQ9XyxjL7rItyndspG3auSURxnKE6mt6m8GvXONpYbj+hgyF1Tq6KfIPut/7qo0wGijAVVaT3IhS38MGeJU/WVj1WxACTM0QNFUEdtQ9aWxKmI/TIgl8LtpDt5bapg2paVYskgBi4Gx307WVym1jf4B3V9oAFi5dSsWMWrdWTwL/0j5FvFRW+7rXHmf+Y3ElIM5x/eIq7PnRH7mps5gHiT7/UbJfMBWQRoyEwsnG5v55XdAdNXrk+Mecwu25nzBM5q1CtDAwITwj22BArBb9tAkuo3q5MvCID3PHd9wcJPaKJ1KoOQV2bQhpbqJ7b1JPPzyP1rOKVI31p+Neen+nSeLQ3qdL1dvcXrtnbxkVWpVnSIC6Keghy48zQH4ba+6DLWWuUYMSV7VGQcS+TGLGNL8wxAcNuXfjjKohqAFH3HIqinkH82w+0Y2TA3zhS+6aXf5LGWRwlz0ooDw710QtNtQMLGi/U9UK7UC+AdgQ65XElRB4wMj/5k+U77n3P/L5Zt5CwlMGbmdC+/Sqc5uFsNeO29jkIyz5hduKPZTJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVWZmJVVkYya2dkbWFsUDZLSWVZaWxocWZyeTR1TXdDYklBeXQya2kvelZL?=
 =?utf-8?B?aW1pSWhNWGZXTUNmYjhGaU9ab25CT0dMKy8zWTFBMjNRQ0pGTWVMUnZhQVd6?=
 =?utf-8?B?blNQajA5QThObHd4czc5N1ljNWZiUzZrRW9uczB5emRsMDErNDJQVnFnRkEr?=
 =?utf-8?B?MERHc20yL3cxT09jL20rTDZ2dUFhcmI0dUF6ejFyNkJPU3NGTzZmWjZYWTcz?=
 =?utf-8?B?VUQ4TDd6emNHenMvbTFtNFBGSTA4N3grZGJKOXFRZVluV0dmdE9VM1U4d1Rm?=
 =?utf-8?B?OXNuOW1ybmdObmZwaVNvQ3lmODBpM25KNmxxSFA0MktCUG5XSWJHVVlzZmFM?=
 =?utf-8?B?QVhXd2FBK3d3YjQ5eUVVZ2FseUp3d0FacGtzdkFQaDg0bDFWYWx6cEdmdXlh?=
 =?utf-8?B?cTVMOTRzZFF6aklpWTdYMUhCTStna1JQS0RrVi9BOGluaTZUTmltZ2g1TGto?=
 =?utf-8?B?dHhORmE0MEJtVTVGQmtneCtRazZDVWJLaTdzYzVVdjRvQzlwektlSTRLL1VX?=
 =?utf-8?B?bWNITTZIZ3JISE9OVytESDJidHRVLzdra0hyMk0yNlNaaWE2UWdNRm9EV2Iz?=
 =?utf-8?B?LytqUUhPcytFVXU0eVVSRU1oZXZWZy9hQXF4cnROc1NtdUYydk1XMGpvOERG?=
 =?utf-8?B?dEpBNlFBalJQWWJJcVlPUktpWDIzai81RUdOQVNXMk16MXZLN0dZV3o1MmpR?=
 =?utf-8?B?ZzdzZGttSzNoWDUwaFlZczl2Q3dFQ0k4c2NrSnJXUEdDdnZHUm5LWTBiQ2lu?=
 =?utf-8?B?TDF3cnFxOWR1SUZnaTdzRXJFRys3clkrZCtoNzNjL2doTmpGb1V1VmVjMXFZ?=
 =?utf-8?B?eGlnMm9VY3BJRllzRGZkNHZVV1F4Qjk3ekR5NkRWOGFqbU1GeUlta05OZUVP?=
 =?utf-8?B?Zk80cEcxVnF0Zlk4akxEVjJwS1hISmw4SXU0VDg0V1QrZ0xzMkZWanZNUG5w?=
 =?utf-8?B?aU5CTDh1ZEpZSHlMNjh6aXN5emlyYUl2M0Fqbk9sSjE1NTNuWFlnUzEzRnRX?=
 =?utf-8?B?WmdIOHkyazlxYm15M2JaSHVUcFFNbEVqREtKQVNRUXRHTUN3L1Erb1ZsTEwv?=
 =?utf-8?B?cURnb2xPZWdSYzRrWTJWZlM1SGZXRGRKMGpxOFg2UkptQUZ3aVRyV2JEejRm?=
 =?utf-8?B?MEc3Y2RzdTJ2c1lQdTlSRW50QXpIc1g5YkdtYk1iMGREd0lKN1BKRWJlNVY1?=
 =?utf-8?B?WVBNMitGWHk2ZGdCNVQzV0tXUVlOOGxyWEQzQ00yUmpERVE5V2FYeTk5Qmt6?=
 =?utf-8?B?M3prTmRFQnpOeWhwcUFOUTBsayt3Q0FvczB3WHNrNW9zc1Uyd2lDMkJvajRx?=
 =?utf-8?B?cHdBWHVJc3gyeG9qaWVKZGJWbTRPZktYQWQ1Y01UcUYvQWFqZitLdTNoN2Vo?=
 =?utf-8?B?c05GMkRxemhCKzhsMlRrc2tubmVzTTR0YTB0QWZnQW8zQk5NZG1KeVVqd1Q5?=
 =?utf-8?B?MnJ1ZXd4Q3NyVUx2N1g0WFE1Q2N1ei9DbDUxRGNUcE5zb1RTNHFPTEVMMUJU?=
 =?utf-8?B?RzIySGhQQ2EyckxURmVtNXRNd3hzVVVtT0diVEp2aGtZdWVZVkN4ZEJKb2l6?=
 =?utf-8?B?eFFLaEE0aElZTzFHY0dqd1ZGSFpmMHFaZUgxZklJRVhjTytRRWJyNFJPU0Vl?=
 =?utf-8?B?KzZaMFh2ZUFoYVFrOExMSVV5anZ1dDZJNVFjU2hvVzRVRS94OTErOXo1Tzhj?=
 =?utf-8?B?RDdMMjh6MGc5WUc0Y0VCd0RUdi9XSS9MYlZ6c1d4SVM2L1dTa09XbkhvY0Nh?=
 =?utf-8?B?djRnak5uQTgzcUhtZVcwck5URksvNktiRnRoekNPNVpsU05XeGM4YmZrYzFI?=
 =?utf-8?B?M3gxYi80a3RYdnJ5MEtwUXkzN2o2ZEt0OStESFNsOHZqRVRLRlBSNFFlSm5R?=
 =?utf-8?B?N1o4MmxHVURyMGFoVnZ6bENqMnM4c2cyT2dxL29tYWFwYkxNZm9jbjJ4eEFJ?=
 =?utf-8?B?YnQ4MlNSc1dCcWRLYU5ZaEVaelBuMWMvUHIxZDFXdTJMRkpMMnZaMnd1VDZ1?=
 =?utf-8?B?VEJQMFJ5REhZK05FTW1qY01PQ1V3N1pBR09NRkVMRW5rOExPWEMycFpkcEpF?=
 =?utf-8?B?ZExiUUhqTlBOOG5QbHhicmFyRnQzK252MmNsREpJY2hML1VybVpRemNSL2pQ?=
 =?utf-8?B?MXBYNDB6NUJUWTE0VjJkWWd3TnVodVphUFFYQzRDWXpmeHppVVJ3WXBpUytU?=
 =?utf-8?B?dG9oNU0rSWlIcE5XWDQ3M1cwQk9UcE5qUmVsRGs4dmVCbjhGNWRvanQ5Y0JO?=
 =?utf-8?B?cERoclZDSUE4L0FRNTFvbjBCVG1Db2pZWUlSTE5wUS8wRC8zY1dXRjlBU3U3?=
 =?utf-8?Q?lfrn51Pkn+LAmNpK6T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a011c4-4146-4c0d-f5e5-08de9ed6b120
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:16:46.8816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXhKsEoWSDg9dWDkHs7av3U0p7MIRAmWkvN6JqLOSGGrB52f1aEOzAc5gCY9aPRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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

On 4/20/26 14:10, Timur Kristóf wrote:
> Add an argument to amdgpu_gtt_mgr_alloc_entries() so that
> the caller can specify an alignment.
> 
> This is a pre-requisite for fixing the workaround for
> ensuring that the VCE1 VCPU BO has a low 32-bit address.
> 
> Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 9b0bcf6aca445..4fea81479264f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -188,6 +188,7 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   * @mgr: The GTT manager object
>   * @mm_node: The drm mm node to return the new allocation node information
>   * @num_pages: The number of pages for the new allocation
> + * @alignment: Alignment of the allocation (in pages)
>   * @mode: The new allocation mode
>   *
>   * Helper to dynamic alloc GART entries to map memory not accociated with
> @@ -195,7 +196,7 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   */
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  				 struct drm_mm_node *mm_node,
> -				 u64 num_pages,
> +				 u64 num_pages, u64 alignment,
>  				 enum drm_mm_insert_mode mode)
>  {
>  	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> @@ -203,7 +204,7 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  
>  	spin_lock(&mgr->lock);
>  	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> -					0, GART_ENTRY_WITHOUT_BO_COLOR, 0,
> +					alignment, GART_ENTRY_WITHOUT_BO_COLOR, 0,
>  					adev->gmc.gart_size >> PAGE_SHIFT,
>  					mode);
>  	spin_unlock(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4c7d1917d9bb1..b7b6c4469937b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2026,7 +2026,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
>  		return 0;
>  
>  	num_pages = num_gart_windows * AMDGPU_GTT_MAX_TRANSFER_SIZE;
> -	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages,
> +	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages, 0,
>  					 DRM_MM_INSERT_BEST);
>  	if (r) {
>  		drm_sched_entity_destroy(&entity->base);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2d72fa2172745..09a524be64c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -148,7 +148,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>  
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  				 struct drm_mm_node *mm_node,
> -				 u64 num_pages,
> +				 u64 num_pages, u64 alignment,
>  				 enum drm_mm_insert_mode mode);
>  void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
>  				 struct drm_mm_node *mm_node);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 5b7b46d242c6d..2fe931366985a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -539,7 +539,7 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  	int r;
>  
>  	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> -					 &adev->vce.gart_node, num_pages,
> +					 &adev->vce.gart_node, num_pages, 0,
>  					 DRM_MM_INSERT_LOW);
>  	if (r)
>  		return r;

