Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD212C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 05:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B5310E0C5;
	Thu,  6 Mar 2025 05:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iGqeBxTv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBF710E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 05:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLH66PICXg0GivNziJAX1S1l4KetLoWdcWdyHc1TfYLlLNEpAURWg0ZQ/eVcnWZbegnZqt6Q7vfn6Bacoej1oePeUFrqUGb9wM5Piw8p0AyPq0H+F23RDl59BrVQCPT8UzeTOAD6zZyFiVbXi2l9fF8JmWrQzbmQHrkhfH+nCgl+A9gHtBZFx5pr0IwQAQvGnDkPxQtnFJS//9UBKasD0zp1LSDovvY5s/iwZyplNTkRjzJm+sKhVMtsBGpvXNomKBK0Nc2l93dalXT6yb5zA7p6Fu0gAOAkYlDWPmAGuGKwub9jFIzPNdxquq4N2dkRbYH0gbyEGCy9x5ekb40cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGz2WaDbp68i8qLmnkFR8YFDTWDn9jSoAzTubZAXnzw=;
 b=RAvNCA9QNnpx3TvKZWvIs9cazIqQQ4P5cBTJd2NoKNBoQ4YeKLEtKfQu9AjOXngeh3MJrgNylw339mo4VTLNutG5Zd0Bc0JIkY06Q31FICxv8kfXhCmWAD7Fg1j0SJQoj0duNivpj6lPCwnt8KgsIYmjtIgT8CiptCKykuMFRzFTtWTpYuhSvAU/vKskGjt+3Z/TOXiaxR+FRBAgSUg0zlRQCYCyV2zDmPbDP2dCheuDXQnRM4U3K9gkLD7JFF82G0fb9BIsFjQy7aO0RYa01UgsZp4ISyeyxEB3mKQeFrdUHmTXLxG17FmmwFWLQWJzjHH43GqFfx6+j9VOXkPHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGz2WaDbp68i8qLmnkFR8YFDTWDn9jSoAzTubZAXnzw=;
 b=iGqeBxTvehHo1aQs8nF/UFoJ6RtGQaHJqQ+nlVby79CyJbz+S7/ChpqVx9mnLX0A+qfctEqF+SpjouTXOUps3NhsO7z9VTEo1cMXJXHWeN/g+f5NPQK23y1C9toPuphjecGtM1hG97YA6nTxITXXmRghxtTJLRT56JfXUIwtx3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 05:12:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 05:12:01 +0000
Message-ID: <28614ac5-dcee-410e-b2c2-085d8de0d616@amd.com>
Date: Thu, 6 Mar 2025 10:41:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix the race condition for draining retry
 fault
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250306015303.3221350-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250306015303.3221350-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc54900-612e-4e87-e10e-08dd5c6d6cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE0yOFZyTTJibkFZdXNPMWllWGtlbG8zS25VcGZpbTlScFpLZC9pcGxyczlu?=
 =?utf-8?B?b3FtN3VFTWhRbXVpODlGUjArQ21ReXNQWGV0a212YU9EcmVOV3BnZTlpYXZ1?=
 =?utf-8?B?clVDSFhpNGFRV0ZnYjg2WDZDcTRiMTVtMlA4aG5Fb0lFc3NjU29DYWV3VE5L?=
 =?utf-8?B?RTB0N3RaYnRVb2l2d3M4Qm1kVkN1SG9ISFBqVDd5VExUSitZZVNZMmtGSzF4?=
 =?utf-8?B?NEI4Qk1BZFBoY1ZKQ3Bha3IyVk4zd3NDak03VjFjZ2V2T0FqVGNBVGU4SFlV?=
 =?utf-8?B?UHRJcjBqQm1VbmwvN0xybTBIVmlacTdzczEwSHVOWDRSOHhNS1RPaCtaMWtR?=
 =?utf-8?B?SENCTzJ1YTU4L0JiTG5pVDBTNmN5ZHdtamtXYlVtWVgrUXNQb04rQmdzcGNB?=
 =?utf-8?B?NHBkYmU1OHpUTmNxcmtCaVp3Uk1uU0I0czl2K0NzMDE4bngyOUNzdzZaZVhB?=
 =?utf-8?B?R3FpVFVaY2VXVDBzMEpHUmI2bzNRTFFtNWhuWWJYNXZtZTl5R3RrSHRJdUNR?=
 =?utf-8?B?QzdTMENBakdvaVYxMWp1by9EMThYYytuWThVV1g3MlJzcm5SZi9ibHdMNTF1?=
 =?utf-8?B?aWFrOHV5R2dEa3R3N3VodFI5MlJJbWZUTEZaUkVYZkhDZTFnV3F1bklJUGxR?=
 =?utf-8?B?M3lwOXRjU3NVdkVzUTMvQ0hZeTYyS2VVaXJVSU9OaFhpWk9hUDhXaW1lYUNq?=
 =?utf-8?B?ejlVVThhUkx6V2l6MXhTNmFaKy94NWtzTFUvYlkyVmY3NURrZFR2MXZPb2x5?=
 =?utf-8?B?eU8wcTVDc3QyWXMwTG1uMEMwcnpJQ2I4bVM3NUszaDdFbElBSUprbFhaYUl0?=
 =?utf-8?B?cVpyNThyTTI2M0F2aHRKdG9WQTE1ZHZZZXM2LzhPcVZnQmNuc2lmaXVaL1pq?=
 =?utf-8?B?T0xldDArdkQxZEtwVWp1OEdjVEdqV1hRMWFVRjFheGYvQVd3UVNMLzRHVzAx?=
 =?utf-8?B?cVhZUFV1b2pJOEJlUy9KclY1RXZLYWxaVlkvRks5UjMrLzhNQkFOWDdQb2Ju?=
 =?utf-8?B?QzJPQkxDNmpueEJHNGFxanVwUTIvSFQ1TTBSdi9iZHBuc1UwYytqaXVCUDJ6?=
 =?utf-8?B?QmpNd3F3SUhUTmZCUVl6elc4Q2pZanlSMkFKelhYczhSRVowbDJDeVJDZUhk?=
 =?utf-8?B?bUo4YzJUREVMZklqazdMd0F6YjlEQU45aEFJbEUzQmlzcGhENWd5ckRsVzVG?=
 =?utf-8?B?NThZWi9NemxUZjhQQS9yczE2UlRXNFRMaDI5QThYQThadUxMS2dyTkJQMUlL?=
 =?utf-8?B?RUtKRm4wTWdVb3NGQ0M0aUxIbVRpajBvMGg1Q2xqMm82RFBRSEJqejdDSUdt?=
 =?utf-8?B?dnltbC9qUWZJMkFicTY5Z0dZdEhIUVJrMGRUZ1JNMTFudmVjL2NMYkgyNm9w?=
 =?utf-8?B?ZzMrQ2J4Zm14OFFSeTRqNU9IWGdzSXNrRDdqSmxFK1dDbmR4R1B2U1M5T1po?=
 =?utf-8?B?V0oyekVsRXMzcEpqNlA1ZU5HWGQ2M21NM09YM0ZoN0tsRkJkSldWTCtUUDBN?=
 =?utf-8?B?MmY4V2FXNDluSHpoWC9QdHY1RWVhVis3NFdjQzRxNlhaK0o3amJ5S3VUUGpj?=
 =?utf-8?B?S0NNbEN4NXBmMnUxQktnMU9sTm5lb2pUaURVbW93NFV0ZGZUNEpvR2FuY2Z1?=
 =?utf-8?B?TTZ4dFByQ0xnd3BLa0lVRjhxcndPbUlRRlJOcG1DQk9DV3o2TFlYT0l4Q21a?=
 =?utf-8?B?eFZrZjFYdGVOay9XSDEvbkpEZCtxVHV6YVgzTjk0VzBuWXVjb0NaM1hhdkdP?=
 =?utf-8?B?TW94ZnV2MlU4ODlZTktYQkxNdmFmaGI4VVJoZ2ZvcEw5Vno5c0xieHdMWmU4?=
 =?utf-8?B?OWNBdXdLcmtydzR1MnlxdkRPRU5YY015ckM0NWdpWHdGcGdiVzM5QUVBcGxx?=
 =?utf-8?Q?jje585iBKoqTI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZBVDFkN2t6UkQyblkwaWxnQ2lCcUNqOWpqUUltYkJJR3NGS1R2WVVwN3NS?=
 =?utf-8?B?SzN1MUlYZjZqcGV3MHM5UjZaZDZIOTJKbVdodXNGQU4wR2gzODJ1R003eGto?=
 =?utf-8?B?YVR0VEc0TFExMGhjbjBrVzIvTkdtMWRHeWV1MFJ3WVhreEx2Yk5OczBWYnVp?=
 =?utf-8?B?RG9oaktyc2FUem94YWI0L0dncnQwRy9paGlyUG1qb0FlbkRTMjhQaURiTWh1?=
 =?utf-8?B?TThxN3kvNHA5STBVNFFlOUw1bnRPeVB3VXh5aDg0Q1F4Vm5GV1c2SHZ3V2pu?=
 =?utf-8?B?d3pWcUtNQzRsUXduNEtGY3VBcHBsY1d5ajhzZUxSUEY3Zk4zNU9NaUdnMVNE?=
 =?utf-8?B?amtndisxOTFaaDc0TlFkR1VhT1VUT04yMmszUUtuamZEUVBRSzVaRmpXMnNH?=
 =?utf-8?B?OFBmUVNjVnBlRHdPcldjOEx4NUJlbTE3U2huRmRBeCsxTW5Bc0RIUEFzOWx2?=
 =?utf-8?B?WDhpT2Y5OEd5TWRJQkN2WVdTTXJYUm1ZRzFJOVlQZkFORHhtNkRpVnZzNFBp?=
 =?utf-8?B?R25xR0U2Yi91ckV5OEl0ZC9iK2g3Yk1kbTg5M21KYUJjWTRESUliT1JzNWc4?=
 =?utf-8?B?TkhCemk1bjlrZStDOE13eko2dDZYVDRtTk9FSytkYlphWkRNVFZOWUJoVzRq?=
 =?utf-8?B?OEJkeFE3S3VjTGF6WmxpZzNJbHhCdzdTZFR4TW9KSGNERzUrYXAzYXNTanBj?=
 =?utf-8?B?dTNhdTdmUFhHZG1mNHpNbm9qS05CK1d2aGNhSXlsODNwNCtWVEdMd043SWlz?=
 =?utf-8?B?aDlhTDRhbXNjeitrWDlFZ3VtcmNDTDZHdmtpN002a0pUaFBKWTBBVlVaZWhB?=
 =?utf-8?B?UkVVTFFyVXlPM1FQbXFIK0llUzdEZ3U2bG1lTFBGL3pqelkrRzE3WmxBY244?=
 =?utf-8?B?MzlDQUlpa2RjbUVtdGNMRnVmWmJMMU4xaWNkcC9kdjZNQW8zSDNtRUxnc29k?=
 =?utf-8?B?T1ZGZmY5Y3A1V2JnSExwK1JNY0wxSVAwaXhjZHZkS0t3QmpxTVB2Ukc2MG5B?=
 =?utf-8?B?UHlYVWlXZ0psNG45SGpqd0NiN1ZVanNnTkllamJKdnJjVmExMDJGcHpqY2hu?=
 =?utf-8?B?aFJYMDRuY0lrTEp4dS9HbENGZ2MzZ2hwS2JjbHB5TXphR0VnTVlFNW1KNkhn?=
 =?utf-8?B?QStqdHIvM1BMellBNTNQd1BQRjlhV0JvTUJGSzdxazc2VGJzQzV6dWpwejZO?=
 =?utf-8?B?V0pINzFWci9hV2VJWTVwK3UvUUpycFc1eWM0Yld1bEs2d2N2YXMwMExVMDNF?=
 =?utf-8?B?T1NsTTZPMnQyd0VKZ0JheTdYRW1SdXovVWxjUGZwNVppOTF4RTRFWUh6UUc1?=
 =?utf-8?B?eHN4WW1jaEVCUTU0UVN1YmkyRzUydlNKVWc4bUJ5ekxwNTFxQ1JnT3dZcnBi?=
 =?utf-8?B?TjNzUnlYZlRadllaUTRlSUF6VnNPRmZjNzFlZjVURlhZTWxXNGhIQkwrbFlz?=
 =?utf-8?B?czFtNVIxVm13NWoxWVpkTnV3U2tac2pJNGNPUWRkcWh1YWVYQTZZbC9SK081?=
 =?utf-8?B?ZDhhRXdjWnZZdmhLaWJ2RUxHKzRnQ1FtUlhQZWRHMW55ZkFkbGZ6SmNBM0Uz?=
 =?utf-8?B?aitDNkVyTFZYZnk3bHliRTlEZEV1TUtuT2FKSWk3dmJWOHNLeFBQcVUydGNG?=
 =?utf-8?B?NnMwaTdYRHVXNUtzUXJueVhCZWZVNUdVUldidFQ2dFRkREhsRHFMaHQ4OHF2?=
 =?utf-8?B?M3NubkdjWHpTaGF5ajdPc0w3ckxlYXdKemlCemJiUW9GdFpWSzd0djNUbnVB?=
 =?utf-8?B?NHlmeWVYTzNFbmRRcGNlZ25JVGxMMkx3SWdSUXgzQXg4TnFaMnc1WmRUQXlo?=
 =?utf-8?B?dHR5Z2xINlgxaWRHTjZDWlNwN2UxcllKV1FCOWlkd1pYT2l0Q2E0T0NpNkI3?=
 =?utf-8?B?MWh1SElldFZWV2QvYkNDNDJyNWMwOGpFTVJGSXJPOStwMDREZTd6UEJFajVm?=
 =?utf-8?B?aVFKV05pMXR2NFJhTTlWQWtiT2lFTVdNK3ZSQVBoVmc5bXJ4aVlDL3E3eGJu?=
 =?utf-8?B?ak81Q1ZxNXRyekpnREZBdW1mNWk2SkZyQXloMThrNlFGa1BLQjVYTTB5d2Jn?=
 =?utf-8?B?eGpKTzBBS2Eyd3RCUnlKTEVadlVoNWs4Rkdub3YvL3czdUZtSGxhbUNNL096?=
 =?utf-8?Q?UIfa95I90MUr3OuU6R+4H+21E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc54900-612e-4e87-e10e-08dd5c6d6cf2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:12:00.9138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnaWVYbAaIQF0mTS65U+svfYJxBRtQw+ifQXKDCP7PuiejkTPjMQOpnW6ghikNom
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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



On 3/6/2025 7:23 AM, Emily Deng wrote:
> Issue:
> In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>  has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
> is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
> continues execution and reaches svm_range_from_addr. This results in
> a "failed to find prange..." error, causing the page recovery to fail.
> 
> How to fix:
> Move the timestamp check code under the protection of svm->lock.
> 
> v2:
> Make sure all right locks are released before go out.
> 
> v3:
> Directly goto out_unlock_svms, and return -EAGAIN.
> 
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 34 ++++++++++++++++------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d04725583f19..42ee49d19ee9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2917,10 +2917,13 @@ static bool svm_range_skip_recover(struct svm_range *prange)
>  
>  static void
>  svm_range_count_fault(struct kfd_node *node, struct kfd_process *p,
> -		      int32_t gpuidx)
> +		      int32_t gpuidx, int r)
>  {
>  	struct kfd_process_device *pdd;
>  
> +	if (r == -EAGAIN)
> +		return;

As a generic code comment - the parameter passed to a function should
have some meaning and serve some purpose. I don't think 'r' has any
such. You may try to generate a /doc describing the params passed to
this function and then probably will realize the same.

Thanks,
Lijo

> +
>  	/* fault is on different page of same range
>  	 * or fault is skipped to recover later
>  	 * or fault is on invalid virtual address
> @@ -3008,19 +3011,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		goto out;
>  	}
>  
> -	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> -			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> -			r = 0;
> -			goto out;
> -		} else
> -			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> -			 * to zero to avoid following ts wrap around give wrong comparing
> -			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> -	}
> -
>  	if (!p->xnack_enabled) {
>  		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>  		r = -EFAULT;
> @@ -3040,6 +3030,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	mmap_read_lock(mm);
>  retry_write_locked:
>  	mutex_lock(&svms->lock);
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (svms->checkpoint_ts[gpuidx] != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +			r = -EAGAIN;
> +			goto out_unlock_svms;
> +		} else
> +			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> +			 * to zero to avoid following ts wrap around give wrong comparing
> +			 */
> +			svms->checkpoint_ts[gpuidx] = 0;
> +	}
> +
>  	prange = svm_range_from_addr(svms, addr, NULL);
>  	if (!prange) {
>  		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
> @@ -3165,7 +3169,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	mutex_unlock(&svms->lock);
>  	mmap_read_unlock(mm);
>  
> -	svm_range_count_fault(node, p, gpuidx);
> +	svm_range_count_fault(node, p, gpuidx, r);
>  
>  	mmput(mm);
>  out:

