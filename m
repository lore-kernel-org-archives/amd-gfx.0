Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD08E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 23:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A72310E96C;
	Fri,  3 Jan 2025 23:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6b2lkAz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9B110E220
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 23:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg0NNnEg0C6mY6NLcC7eWVbRHUjE7EfIIhRzd9xJSaoDAfyClaNRKmhev1VfpN45HUt4q7kmKQGsIWjbYhq9crZDk0x7nZgF3rPNKA03TVIbcDAWaPFsg3zm5EhuVh+5y7RJ+5DyCWP0aD0FGnLBTzGgHPZt5G+2WATCuyub9er8/yt+3CsHFVRmmitc2NTxdHzLs3oh6J7kvVvruXjA7omxAk6U3dZix5u5cTzqmV+meA4KAEvFlXSB6dXivtRyVAaFliW8Ixgz5WTvQAl8N9jqJvyAB42SZPR64k/gJU5kQSygUlJSm/j0chcnAnccJ+IeptwJJJ0i6d6+7rt8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFzfnmR+j/Vm/spst9hfWEklwVlf2gqXMufUlMooO8o=;
 b=Si0JXAX+xJyrFHXycc67oqnH1S/p/VUqSQu6eNat+pC7NmLwR/OpYhuMVrHrOsEePgIeTyC7L4+oDkpG6f9PUHtKkCGGYsugMrKAFm8gJV4biKM430uK3xM74UwIxLQNsz+frsAKOVwri60b0NnTwC/ZH8kF5BSN24EmTJCGnPE1bp9HyO21jma291U5smu6MvoR7wvk16HCqJaYgaIk78iKuMzdtPVOi/OBevMAK7Lc1OZuBh+41ev6RWku4GB45kLVp8bK4nuDPBe9pTTLRp+x+Tg6stHvLPTLfD+j8zTfPMal78Oms820Lx0fnBuuoQZqW/buFXUxcDFRpv3QEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFzfnmR+j/Vm/spst9hfWEklwVlf2gqXMufUlMooO8o=;
 b=i6b2lkAz3OT2WxR65nf+h4J7G1yCEPHXdTQMZu/dXDrF6gx7XAN+41L47SBL9pxwsBttSilr+S3hiin38/24zuwnzCIplCJjKc/q2WMvgD/8oib9manKHwRqVbqQv0BESJ3+ZcBsEp5bSn+070i+LLcAnyF3M2HqeTd6e0bihoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 23:09:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 23:09:47 +0000
Message-ID: <4af83c37-0a9b-4b15-bfdd-6b8511b93a36@amd.com>
Date: Fri, 3 Jan 2025 18:09:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250103000644.1398643-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 331eb3f8-6ab8-49ac-8fa7-08dd2c4bb788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkE3Y0ZqU3RhRDFqQWNDb2lmZGZxUTQ4Q2VadjdPM1ZVSnQzeitNYlpzd2cx?=
 =?utf-8?B?aGVWaytldlJPNXlscmJXTFlKQTlRcks0cXdRd1EyS0FjSmNBT2R0QndCSVpt?=
 =?utf-8?B?em9rM2lOYTlqaEIxblN1Rk5ZU3k1UmlDYnBXSVFwSC92QVFNZnU5R0cxbmc0?=
 =?utf-8?B?bms3V2pyR0xUZVBiaWRXUWR2ZGtubTBGUlcwL1B4UGVEZkM4STIzSTNSV2xV?=
 =?utf-8?B?aE1sdEdCb0F2UDc2cHVjY2M0Qll4N01vTHJkeTFGQ3h3bDZDWHNvdlByaHhK?=
 =?utf-8?B?KzdSN2d6YzI1blU4SzJ1VnMrSHZxNC9NVmVNdEJuUUNreWN0UUZIQ0htVjg2?=
 =?utf-8?B?eW1Lay9Ic0ExQlRoK1haaGlINHBZOTNxeXBZU3N1YW5xZUYzeVdISWR2MWVr?=
 =?utf-8?B?ZXYwS1d4TmFiRHhpUmtLVTRVYjgyM20xUEZGVTVVeFBuelkrY0J6K00xMys1?=
 =?utf-8?B?dlVJdS9GRHdRSVhHWHRuYS9CUzFhWkV3cEdoVVplaDIzRW1xMU8wQzVJODN3?=
 =?utf-8?B?NG9FK0VNc3pCL1haY3d6TEp4cDdoQ0hxOTZVVGU3S0J0UHdaQnpWWDQ2aGx2?=
 =?utf-8?B?TjZuMm5yYmw3bHJKMHp0S2ZEeGp2MWV1akdHR0kzZHFwbnBIYTVYWEJjM1NW?=
 =?utf-8?B?MmJ2a3RIYzNRZEt3QzNyTGp1cUw1Zkx0Uy9iUGhqdGo2alEraUV2YzBKdWlo?=
 =?utf-8?B?emRodzVPYi9sN3VmRUJFY1JrREFjVnFkWXZwUWtKaHFueXYyY09RK2dxRTZC?=
 =?utf-8?B?THNQTTZueW9JbWR1MHJaZ1RKc0UrUTZHVWdIeEZ5aEJmdyt3bVBLalRFTkVL?=
 =?utf-8?B?Z09RLzk5Z3V0L05EWFVFRE53dGJNdEJ1VDFiWHJOeG1YODBROVpHTkQ0R2Nj?=
 =?utf-8?B?VDk5aERSTUV6YlRtdEdLNTEvSVoxWksvV1UzT25yMXFyUmRmd1FxdE1KWS9X?=
 =?utf-8?B?a2ZZeFQyRGdHUnozZENTTHlBelpuQUVOTk90NEZLbDl6cFBFQzdkZUU5K1lR?=
 =?utf-8?B?Ym1FZklOODVnSFdhbHl3enkyWTdmWkIyTjZKSFBhUjhmT2tzT1kzWVo1ZS80?=
 =?utf-8?B?eWd6T1BhTjRpV2Q3YVZHL1h4M3QvK1A5LzJXUkU1N2NCeHVEMXltZHBNS2RM?=
 =?utf-8?B?MUUxejJBQURsa3Bkd3JTQSt3UzFyaEUyU29JTkMyQUZrWlJWUW5YOVl3MVow?=
 =?utf-8?B?WW5BZ2lmWGwyTHMvMXNIajN5eXZYanhwTnI2ejNmR21tVG1OQXFCQis2RURr?=
 =?utf-8?B?R1BTVkc1aTNWQWdROWdCY2ErMmk4d0FwUXEwdUN3bitVUHZESHVDNktmYkhY?=
 =?utf-8?B?ZnVGMGFyRjdyT2dyMFRLY2J0S3h5RVNCVk1EbWo5T2NFZHdSRWVZWEVaa0lj?=
 =?utf-8?B?RWJ1bTUzZGRqNXZENHQ3ZXh0S2N0ZVJyaCtDSnBSaXQ3dTc1U2JWcVFXK040?=
 =?utf-8?B?YTd0Y1FCZk1kcnhmbWFRejJOQ1RiSjdia3lOMFgwa3ZOcmg0eTBMZC9QSmtU?=
 =?utf-8?B?MVdIU2M5Wk9XcGlXNVlWdHYwdkFIMTBWREozaFNaeEI5cXpjUUUyODIwaW9o?=
 =?utf-8?B?K2NRSG55WFMwVVBRaFVUWDAxSzYxNWhqMVNJRE1LWkdqMmhkWXpSQXRtcUpI?=
 =?utf-8?B?WVR6MkdyRUxDam9MSjFKYk1VUXE4N2wxSGN5bmZuL1ZnbHV3d0IzQUIrQnVH?=
 =?utf-8?B?dTd6UWZSVnV1ekpBM2pTanNrWHVFalJ4ZGtMYVplV2NGd0xXNVJxQXNUcXFq?=
 =?utf-8?B?YnNHOHhVQkFnNmcwYmlSOFJuZEN5TFJnZUgxZ1I4ekpzOURWQjZ3Yzg4cTFI?=
 =?utf-8?B?NnlUNXZCSDhoZ2Z0YjZDZXN6NTZxSHBQemkzSmVkY3A1MHRFZUNNeEVaNGQ1?=
 =?utf-8?Q?IJka/4QajKvsk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERPZitGaFhJMU44WjhKdWl5dW51ZFNacks5b2dXeFVsREphL1M3M1JHQ0dP?=
 =?utf-8?B?UnJVTXNMb2pTSkcvczJFcHVJZ3I0dFZxejJRME83UWkwQTR5U1hxUDZtNENt?=
 =?utf-8?B?b25ERzFnc3dxMFVJWGxSdmxqNkFIVE1DS2pkYjA1MWl3eHRPM0d6dTBsV3hu?=
 =?utf-8?B?S3NCTXZwbTFIb0dlNkFhc1JJN0d5SzMxM0hNelY1UU9oc25JUloxZWtMcUNo?=
 =?utf-8?B?TzdtbmJhWnhVOUNwNUJxcFZmMTk1MTQ3dXcwYXRuM0RxeURzdUx4c01abjdy?=
 =?utf-8?B?VkRYMndpdEtBVHl6UUFuZGNQRTZzdmEwRTd5UkQ0ZmxzV2pldnZUUEtIaDk3?=
 =?utf-8?B?eXZyNU1Jb3hSa1FoRVF1Zjd1dVlvSndObUtIUFk2cHhlNnJmWjh2Qkt6WU1o?=
 =?utf-8?B?eUpZWm5KaUFxdDBvNGZtRE1SVGJUQ2tvQ2tsNmJUVEZaZnU4Y2hLOEErNlRr?=
 =?utf-8?B?UkxDWUo4WERXSUdLeDhSdEZjcnQ1c3dEZUNDSDJmN254cjBqT1lySUFNQWhU?=
 =?utf-8?B?VlU0c0wxZ2h2Zjh4bEluSkFqbEtlSjJoQmdwcWl5Yk80OEJlSzRzSDZadE1J?=
 =?utf-8?B?OTZRMmY0ZUY3dG5BQTBvVFpzZDB5bkoxZjRxRkhGN3h0cTRsTE14ZDNDL01Q?=
 =?utf-8?B?V3pXdkVXeGR4NjFneEVDNXE1TlFNU0V4UXFDYjBCSjZQNEpCbHd2QVovdzdt?=
 =?utf-8?B?dHI4YUExMm1UYktKMFVORWF6NDFldzNLQTRKRThRUDYvZWNDem0zSFhVUi9D?=
 =?utf-8?B?STNvVlpheElQaXQ5ODFuSDAyVUJxcDhENjB2RW8yU21Nc1Vjb3JhUjFxSEJO?=
 =?utf-8?B?WFlYT28xWThLZUNoSjg5Z1pTd0xSUUFaYXpnVWYvVTQ4ekg0bTEvZ0VzeG9H?=
 =?utf-8?B?b25ucTdOdGtaeHA2L01YQkl0QSsxWHowV0dtamVCYVBVejZWM1lCMWpBOU4y?=
 =?utf-8?B?NCtFNTFjNEFQYTRJZHdicFp5aS9jNVM2cjZLVjQ3VmpJME9hdTNwc1FGWno5?=
 =?utf-8?B?WllIcGJYYWFkMG5mSUpQY3hjN1p0WWVvZ0FjWXRnUUdDY3BSYU9BZ05PdHF3?=
 =?utf-8?B?L3p0NjBCTmU1cVRrWGNHRTd6YWJHTkI5VkVuQVZBQVdlY1U5UTI2U3JRWTlF?=
 =?utf-8?B?RWFsYXVaUGRZNmVhQUZhbkRBMDBxckRvV2ZocjZmUjI2VE5GVWxZK1d2VURq?=
 =?utf-8?B?cVl0b2VrQlJ5U05hZnpXOVdYWmE0ZGxGK2RBNjJmSTBGUTVOajZMdllQSHU1?=
 =?utf-8?B?UUl6V1l0RnYraTIrQkNwTUVnVnUyWE4zVkxjQXBuUHA4c3JZTU5ncGZwSmd2?=
 =?utf-8?B?QWRjOWNNU3JCcU9tL1FWV2gvdEdUTGlCSVJ2MjV5MlgvQlpkdTYydXhQSlk4?=
 =?utf-8?B?enoyTWJ2N2dYR0R5Z1h6YUdIckc1blY2RWlMOGIzeXhxN3lVNHI0MjFSUGNH?=
 =?utf-8?B?TzBNUlRmSWNtaXY3U21yMmswaXVUME5VU0U1Q3U4dlZUTkJscVlyOFUrUExT?=
 =?utf-8?B?dE5HWWV6TlQ2RjVIWGc2N3hXVlBJNG9DOHNwL0hDUHRueFlPS0NEVFhyQkdJ?=
 =?utf-8?B?YVpFdlhySDRJMWFlSlpDN1pzVFJFMXdEdkJLTVI4MitGN1l1VTBuZ0prbnk0?=
 =?utf-8?B?QzRDeXNkVGZyWDdoNlFoM1FFMng2WU04d0ZjOVY4MzdmZm8xU0dMSjdqZ1Ew?=
 =?utf-8?B?cFZVV3pJVmRxNS9scDNVeUdOU1RhS1ovcjdWbjRIWVN2b0kyNHptOGhHV2VE?=
 =?utf-8?B?V0JmNGV5Q3JjczVWVEJseTJEQkFabTlCLzYxSzl4NGJDbjZFT29JU3VzYlg0?=
 =?utf-8?B?Rko3b0tWSFVzY0xHNnVOUm9pbHdwdHA1ZXh4ZFYrTnZaYkgvU3duMW1pbTlX?=
 =?utf-8?B?eG1uSERwZVNramxYRnFkRGEvN2JtKzhZV0VRVm5IMHdVWHJBbEJPSmkweVNJ?=
 =?utf-8?B?QzJWam1WbU1OczN5T2ZSN1dXSjdkN3Y5ZmZYMEVQbmg2OG1Rd0lwUm9NdnZo?=
 =?utf-8?B?a0hTV3ZUYmJqZHpSdlZERGpyOVZNdnhNZ2NBU0YzVkNMRzI1R3RtYi9jVXZL?=
 =?utf-8?B?TUhTZVRWZFA2cjJIbE5zbExuYmNmTVlCdWRzaHVSUlkyUFNncVJ3a25UZGJU?=
 =?utf-8?Q?OCMlbayrdc+YMlLJ/JqFmw7Ue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331eb3f8-6ab8-49ac-8fa7-08dd2c4bb788
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 23:09:47.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ji6H3mWr7QMQgwTC3uI8BEe9EemZVFisSI1EGaaysRqt9aTAS/9NUbtDu5AH0LhVEZfnN1RI09UQ8Bf+sS2DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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


On 2025-01-02 19:06, Emily Deng wrote:
> For partial migrate from ram to vram, the migrate->cpages is not
> equal to migrate->npages, should use migrate->npages to check all needed
> migrate pages which could be copied or not.
>
> And only need to set those pages could be migrated to migrate->dst[i], or
> the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Good catch. But I think it's still not quite right. See inline.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 4b275937d05e..5c96c2d425e3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
>   {
> -	uint64_t npages = migrate->cpages;
> +	uint64_t npages = migrate->npages;
>   	struct amdgpu_device *adev = node->adev;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
> @@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		struct page *spage;
>   
>   		dst[i] = cursor.start + (j << PAGE_SHIFT);
> -		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -		svm_migrate_get_vram_page(prange, migrate->dst[i]);
> -		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   
>   		spage = migrate_pfn_to_page(migrate->src[i]);
>   		if (spage && !is_zone_device_page(spage)) {

We should also check (migrate->src[i] & MIGRATE_PFN_MIGRATE) to catch 
only the pages that are ready to migrate (i.e. not already in device 
memory and not pinned by someone else).

Regards,
   Felix


> @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		} else {
>   			j++;
>   		}
> +		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> +		svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   	}
>   
>   	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
