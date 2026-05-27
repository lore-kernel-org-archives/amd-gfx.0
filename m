Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F6ECD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 11:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C409210E155;
	Wed, 27 May 2026 11:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4w7+nhbK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14AC10E155
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 11:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIEWb9x+/jhLfTrx/NpjBsp0iQ9x5ONOA1OThSzPVjV6jzFqEddCcblBirnh77UYRHFDVI5xAUtCl5/6j8pOaLtH2UssvyFnpkKQ/f6EU9ma229wgJ5FkZQrDoiDv4exE5RaAcN59nBKidbv2P3rBUXeI9xMYQitUoGkXcPAx+aBkBEyof/8DhOMnpXKzPKs7Y0m+997YFXqMyRlId1E0bDt7STsY/8oNZkUrOaCe/UQwBd2xIgwjfVuZAABmZTbgKTfcSYoiXIMAZI7Z0aq2Po8nvtUtG0Z2wMbrFVs0DJnbH0tpj6uUXcm6th6jgjFidX19pdXkZpoPiIPllqD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLLWXVw8zVZiHVW1xrGH8EzUeYDN7a40MpXzpm5lSgQ=;
 b=PWOkfrMxMiBfsXKwzkhNZsXAQ8GuzVh4Ba5d1kHGthegNhV3VWiOo7iDUOgplOUB8BlAQiHGdWsdVrCJrkW1B3+N8pm5XhLzfsZto6N2TGV4gw1rX3L6eBlWABb5TZATrvqX51ghpZJfDx7QPgza0TNnLc5DEt3FUwYOqU0noS8hLnI50/Z1emlUedKGEJJlWcQDWhKCeeEPhyxMK6iVEekfepvuYt88mp/o/LvyR90Vd9ljM6ZFG2JB/EmNjBBAfe81wtryHa5Wucq1+vwqQby+1UO9x3U9nr3b9GAE0og9ZOELCMzdLGTbEG8rZ828YaHrhTFKBrf+MHWUxCmKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLLWXVw8zVZiHVW1xrGH8EzUeYDN7a40MpXzpm5lSgQ=;
 b=4w7+nhbKw6SIB2HMiGZbGeZOSrU0xkVVssgshTGhz5CR8Nzfy9/OktfbQCN/KznbjbSa1fga3PbYzSmNi6oUwnx2shKaGMZ3ps0R4bQRLinClDoQ8gOsXajdOhUYRYIsIxTV85yvBQQ/RTrGgrUpu+VKwpia0mMMKbKhsCga7rI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:54:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:54:52 +0000
Message-ID: <ee06fb47-75bc-4f22-ad0d-a7c1a2c8a413@amd.com>
Date: Wed, 27 May 2026 13:54:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K
 page size systems
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, timur.kristof@gmail.com
References: <20260527111750.1084088-1-donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527111750.1084088-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c4c232-3a0a-4c0e-9c59-08debbe6c34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: DLPVDHSrKUJST8U8VVacUBEP2kV7l51MTVjb8dgOAjd2Ms32P/vSy+/BuZ7jPqEgh2PGu9CzMu6QfcnYCOiLPlSqR1HAubDTBEl7LHQ7BHc4JZtImc8BIkRa91M99ZykS1pjSA73hbclaXiJV2PcWrkEVpmQ8SmY8TbSExfrPaQhuSXEifMDvp/T0dtNGtu+qk60oWlN+OJEpe4htt+YDeiSaNCz4LXZhi6vmRKWOp5qstmaaF/Eu1uxODgTquq0P4HzR1Jf0zzVhmCq/8JMyc3mei0bSfiAAIBCc6fGMmSUaPxrW+xb2V9L6WFggSFd3wHdcWy/Z2UHabzAxESdy+mP141KWVgRIIPvpYdHY9gjnO06Z9r0nhSdhDHmJHvwIZQGCMMEdGOldmULfCCyTXdBdVQzJdO0QacLDRNdD1ldIKEHElDmd9dc2EQR6sfBlKbOFzzmdSJAariHSV76LxcK8x/9KmYrId9AbYT5kJeqiz7iwxBIYT0VrvwAvpNuMBrrL0uQHUhuuiZu6xKY6DO3lFCLZ0xwBsp3t8mHLgT5Rw3a5w68wppqySas9+v9fYhcUqs0QF05QTAftw54nncjGzOOnJSgvD/S1Yyq38TxZLq7RI5o59LhO3/pQ1g+aMyIfzdTM5fJdWXT1Rg+9wPne4T6K8m6QS5/whatxq1vMhqGMccnYFO2lykrHcQG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElYODl0WWlETi9zZ2kvRWI0NEFvOWxkSmRVWkZ2aGdVa3ZrWkUyNGoycmk2?=
 =?utf-8?B?OTluYzRQMmVJczRNUkhUWGlSMnhxc1pqc3FyZWNnUklJdk0rVkZwRE9vYVhq?=
 =?utf-8?B?MXBiTFJZQXIyZFdXY0lQWWlJR0Q2ZjRzdllyeVUrN0FyNk5iNE9HNytzM09P?=
 =?utf-8?B?ZnplRFAxNjlFemJQZldjajdZNEFmNXZLVW1HN2RRVmdNb1Q5eUNVNnU4bmVl?=
 =?utf-8?B?NEFSVXo3bU5MMHRrNEhQSXlxa0NEVUNxdDhTYjVGTVg3WDU5NjBqczNWZjVW?=
 =?utf-8?B?UFRobVduUVFvTTFibWppWTNtek12U2RtekZVMHd3aWNKYnZybkU5OG1BWCsw?=
 =?utf-8?B?cVo3TDl3RDUrRDBmSDVtc2JLS0YyVzF5WjloY0c4amlSQVlnWWlqd1ZBbzRO?=
 =?utf-8?B?WkdhTldraXFPZ1V3RkhrZ1FuZ0h2UUpxaXF2V0IxOFVXc1RTdEVtbXZtQWxE?=
 =?utf-8?B?V1hBMkdLdXU2ZlFJWkljTW43eFA0M1ZENnFSa2Z6R1ZJSU9jb0xxVElGVUFo?=
 =?utf-8?B?Zm1QZitiTVlTS1YzSEJuaGZOSEJ4c3BJZE5XUTh2RjB3WlVFSS9SV2QvR3lI?=
 =?utf-8?B?ODhEd0tSQmcrRW5WOGFOYlROb2wvUWM0aDJVaVZFeGNCK0pIL2RST0J2cUNy?=
 =?utf-8?B?bktFR1Z2Q2szdzZPaU5WanF1N05pbVBkODZObzBYUjdxbkhMMWdBRXhlWDRX?=
 =?utf-8?B?RVo1UUgxNEY2TWlKM0kwZUxiVHZoZnZZNHJVcmZxTGlMajhmNVMwUk1EbDBv?=
 =?utf-8?B?N0J1ZkJtS3lCdnNCSWZZNEYrcGtCc2V2TDVhM2grYkhVM3B1aTV6dUtXWHRx?=
 =?utf-8?B?ZFJXMENyd3grR0IxWUI5Q3d5ZW0zWTQ5TllpYkNSTDFnbng5d1E5WDJtbE93?=
 =?utf-8?B?c3FXK0YxakRBLzBHWHZFUFZZR0JxSUhyazA4bXpVT0pJdnJRWmt0KzU0N2lU?=
 =?utf-8?B?amdhd3djNDNmeXJvZ3crV3FlOVNXK0F2UWJoVkRickRpcFRJUldpMk9laHFX?=
 =?utf-8?B?M1lKVkYzL0lWbk5UdjRTdmdhejdBTDJVWnBOY2k1NERmNHBZb29QRnVBRXRT?=
 =?utf-8?B?QXExSUpmVkhwRlZONFJoVkN3bE9ES2tad1dnazhxVXU0dVlkV0dUVURsMG8y?=
 =?utf-8?B?bTRueVBWL0cvcDMwT21IZGVvR0xyOGpRcVY4NTZyVExmZ0YzeWRCUS83b0Vs?=
 =?utf-8?B?Z0MvY0RNSURCM0NiUExjYXpSQkVZK3huOGJXUVRDMXJuSE9pKzl1c3NZRExI?=
 =?utf-8?B?NDJNdTVNbWM1THd5ZlJHd3RNaE5McURYcSsvUTA3Wi9GZHpna0dwanN3aEx4?=
 =?utf-8?B?aThBUFdPbXdhNmY4UzhkZTBPM0hOQnFHV2FLRW91RzRQbElYNnhidXk0RDFJ?=
 =?utf-8?B?Yk94bmNzY21ZSDdhMjUrV01vWTFRbjFLYnRyY0hiajU4M284QTNrQ1ozcGhR?=
 =?utf-8?B?UlNvcFMyZG9UTENRemMzUzJzYjFxRUVxL01RRjYxVnBMY0c5clBMT1lFMlFo?=
 =?utf-8?B?YlErVk42d01DdVd2ZmdzWkZxLzVmYmwxQ1N1Z1prWjZ2V2NiaThWUTB5TTJL?=
 =?utf-8?B?U3dSbFZJQ3hoUTZLMDJUaG1zS2hjWTFiRmZhMEpoelc2S2s2d2JtSjhwMm1O?=
 =?utf-8?B?TUVTWDBYSlpUYnlwNms5WXV5UW95TXU1cGI4ZFNnblhZTWlZSHhsckVzYTdQ?=
 =?utf-8?B?REc5MlozcFhRSmlETWI3bjh0Q0gyNGZRTVVVZlBGMnpFM3F4VFNXcUxQYWxG?=
 =?utf-8?B?TUxkYW1ldEtURzhma3NrenptdG9FVkpZc0tFeTRwV1IvbWlPelhOR0ZnYVVP?=
 =?utf-8?B?OUtXZHNzWk5zMlJKVlF5R3dFUG9menJrSDdRQVVjaXBrQldMWldrL0lEME9p?=
 =?utf-8?B?ZVh4Q2k0TkUyQUFxTFFkb3c4emNBaUNRK3hMMkVtaVR4L3AvdENZVnpnajVN?=
 =?utf-8?B?SXpXY3k4cEVuK05PRnRoeUJIcFJwQjZzQVNpcVhEd0lVci80N0pXUlZydE5J?=
 =?utf-8?B?ZEowSGJ1YVFWanRReE1QZjBscnlPeFdHZEs1bzIxUWFIZWw3UzlSaHFnWkNV?=
 =?utf-8?B?SmVCdlZ3VmUyeDhYanlqN3JsbGtLenpGdnd0NDVVRDlkdFZmSVRsNGNHL0N1?=
 =?utf-8?B?NFdUNEc1YXdjcnFxUkowam9Tdi80S1QxWGNEV0p6eWtJVitjNDFvT0pQNU9X?=
 =?utf-8?B?SEtINWJkbWNGZ2ZJS1pqOUVWc2c1WjdPTFN3c05zeDhWaDRZYkJSLzQ0Y0tK?=
 =?utf-8?B?UXZDVElMR2x0Zk5RMDFoS0tsL0JCVkZhZmpBM0JzczREMWROZHNBYUdYZEIy?=
 =?utf-8?Q?6IhKstP0XGADImeV98?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c4c232-3a0a-4c0e-9c59-08debbe6c34a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:54:52.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqsGjII3Zsw5zxU2NVvtXAXDA+4dYnrJpkdnkDrczJuMFhgj7IEVr1pvQ9x++J6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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



On 5/27/26 13:17, Donet Tom wrote:
> When mapping VRAM pages into the GART page table,
> amdgpu_gart_map_vram_range() assumes that the system page size is the
> same as the GPU page size.
> 
> On systems with non-4K page sizes, multiple GPU pages can exist within
> a single CPU page. As a result, the mappings are created incorrectly
> because fewer page table entries are programmed than required.
> 
> Fix this by programming the mappings correctly for non-4K page size
> systems.
> 
> Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
> v1 -> v2
> - Addressed Felix's comment by updating the definition of
>   amdgpu_gart_map_vram_range() to support non-4K page sizes.
> 
> v1 - https://lore.kernel.org/all/20260522112838.1311531-1-donettom@linux.ibm.com/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index b6f849d51c2e..66a15ee13b57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>  				uint64_t start_page, uint64_t num_pages,
>  				uint64_t flags, void *dst)
>  {
> -	u32 i, idx;
> +	u32 i, j, t = 0, idx;
> +	u64 page_base;
>  
>  	/* The SYSTEM flag indicates the pages aren't in VRAM. */
>  	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
> @@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return;
>  
> -	for (i = 0; i < num_pages; ++i) {
> -		amdgpu_gmc_set_pte_pde(adev, dst,
> -			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
> +	page_base = pa;
> +	for (i = 0; i < num_pages; i++) {

Please make that for (i = 0, t = 0; .... and remove the initialization of t during deceleration.

I was about to complain that t isn't initialized because I missed the line above.

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian

> +		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
> +			amdgpu_gmc_set_pte_pde(adev, dst, start_page + t, page_base, flags);
> +			page_base += AMDGPU_GPU_PAGE_SIZE;
> +		}
>  	}
>  
>  	drm_dev_exit(idx);

