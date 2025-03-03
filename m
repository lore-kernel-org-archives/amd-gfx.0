Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6F1C282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 18:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB89E10E3C9;
	Mon,  3 Mar 2025 18:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zvx9dLum";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2903F10E3C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 18:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gParYPFiCPRnLzpbml+I1q4Z5xzmjVqFHm25bfA/NggNRrPQmivPMTjX2PlNbPIbztNimuhuNxWRRc4hgFShalJplulePbxC511fv/Ti0PDF6PZyE5gToMYwx+azh3u2eu2YsZN4mjEhsvYuooFQepvkyLk+mRrunfz738QN4mcQrHnX4ROK4OmEAWwuGP7bEawEZhZg9w5Ux7IAK+lcfKntUrdC5NpwmMO3qKldsKts3INdQMg3L6SFYO3rYj7l/xE9HTw37jWoI7fJnHaFmHN2HmzTRcrmDQknFojichitJrd8u+lQsHr5aI/jEr+7fkpmuL+OtF7y9mrtzI/n8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMKivB6JmFLmZHHILK9HDW3VJV5odNO65aSV6WL5yjY=;
 b=yyfo9ywY/aGa7hdbeew+VU3h8YXnYN3huhps74z+QWMFgwow3jR+p2zkgPjPZCPFYBoMlbRnM81EoU3N2cCBF3duAVz2gH5+nA3IaQ6qAyPdb0dH8JGaid6xM8kFFtMgHqYdtaRKAA/d2LB9gOcEvYKaeF1bKUM7uEj5Dca0LQIF1TBnAQNrYLHJR98PjHduB4nT1S5h6LaN98oja+B8Y/l7fIQexLPTve5doZAEe+GsXYnXjqFftV5RgRvId753oqPF0f2lIPyYJ1SUTgXfttiWJ2gcsFl2TKFaRPL8woBTm3HICR8YcaYkRejYiWoGXfWBXdV9g2Vw5VJajbcQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMKivB6JmFLmZHHILK9HDW3VJV5odNO65aSV6WL5yjY=;
 b=zvx9dLum8Ucm7S3TbRSOwVsiviA/Sbd7TuBVU5nJHmg/gcayqsULxIhMXo/olcf+FuWa4GLPJdzjejuIKAuPKzGtmv29iab2NBNIbdyRX2eWGWlpffANe2PSma0pzPKTzTkx51QkR6unys4RNMdlfY7RDURuR6JzB3UzjtoRVu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 18:48:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 18:48:05 +0000
Message-ID: <71929ed1-6c22-47dc-9f9a-a4bc15b21629@amd.com>
Date: Mon, 3 Mar 2025 19:48:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove unnecessary cpu domain validation
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.kuehling@amd.com, philip.yang@amd.com
Cc: jamesz@amd.com
References: <20250303184508.2277310-1-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250303184508.2277310-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb47b0d-91db-4ed3-329e-08dd5a83eed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3I0QXl1QXc5OEx2bVplMzVVbkFPUU9ENjY2dVVlL3FPZXpZSnlveU83MmVJ?=
 =?utf-8?B?RHhpdjZ0Vkt6S1ZmVXNqb2E3SVdkd0dhTWdUV3NZZjFuMHhvUHZIMFRFWE8w?=
 =?utf-8?B?UDcvL0U4L1hNM0c3Y1RBVXo2c1hENEwxNk1aQXI4MEkyZkRmMUZHczM1bW9y?=
 =?utf-8?B?UE0wVGxySVF2c0VLL0M5c0x0STFpVURvaGQrS1pYRFkzTXh2anhuYjZRa25j?=
 =?utf-8?B?eTV1VEdxUU9PcmtaUXljbytsL0RxNi9DajJuU1FZQkFONURVMnMxZTZJaXNy?=
 =?utf-8?B?aGdzUmVwdkVIbXVobGVnL3ZraFJtZEhCQXhZeTVIekwvWHliSEsxd3Jkc2Jr?=
 =?utf-8?B?QjdxTG9obm1zMDZnOVVOMXlRYnNXYVpqTHdKQkQ4TnlSSkNFQ3Z1WjZ6VE9h?=
 =?utf-8?B?ZGJkVDFMK2dOMzZLTHF2b3hhaGxoWHFVVnA1MnRMZU0rS2ROOVF0UVhBb3Mv?=
 =?utf-8?B?ZExQVU5XckVBV3hvaVRVVUR3NHpPMTBKQ0xJT1JHRmkvVFQ2OFdVTW9SdjFk?=
 =?utf-8?B?SlFuVWZKbHBOMEhIRmhxdDZLVEJ2bmlFK1dkNk8zZlZDN3laV2F1dWx3VkFa?=
 =?utf-8?B?b0pKY3JPdVlPcGFRazZSSHllbzBtYkN6NVdxRU9oV21lRTdvUVVmdnAxSWJW?=
 =?utf-8?B?RzVUaHhkQUpsRFVyT3RMb0p5cEpMQU9Qbk8wM2tGeUxGaG5yUGY4UElRY1J0?=
 =?utf-8?B?SHVPM2xvLzEzZU1vM2ZYQXF5OUc0cDNnVFhvQlZRbmhJY2pHUnIzcHpzNmZD?=
 =?utf-8?B?NEY0MGwzblpjKzNTT2UxMXRzYjJBcm5abkRtOS90RUNUYWh6SGRmU0EwdzRO?=
 =?utf-8?B?MlpoWEk4YzBiNW91VjU2eTI4ajFZbElma0hJYUcyTTBSNWhhbHdEdDY2RjFt?=
 =?utf-8?B?Wk5FdEd5OHdjOTUxc1dkbzVtUUdac296WFJ5b0lYeUgyNlpBOHZDbE1DMW1D?=
 =?utf-8?B?U2ZuSldFeWtadzNjZ2ZVdzZoWDQ3dXhXRHBZZUNHMjBIWjcvMCtWZitCNjBC?=
 =?utf-8?B?d0tycjBTVis0anAva2plOEpRZE1tNEdiWDhZNkgvTXhrd0pPVm5vR3pYUTls?=
 =?utf-8?B?WTgyRzFLdVo1YUIxMmhraGhKT2xxcjY4dTRBeFpKRDYrOGNOTitoNmRuVWow?=
 =?utf-8?B?YlU2Ky9NZndmOVlhQ0dmOHUvdGgyTnpUdmZTMGVTVnhONFBCWEx0WHdtVDEx?=
 =?utf-8?B?SWxnNW5YbUdxcXBoS3BSRmdmOWJTb1ZYL1RYMU51Y0JUT1VFbS9HczBiWk44?=
 =?utf-8?B?Ly9nejZUTmthWlZvVzdGelZZazNrS1Y5S052YkU2YmFSbmM0R3BSUS90eFIv?=
 =?utf-8?B?UVBJbXdEQ2dZOVJDVFdpTUI1RDBEQzFhWFMxLzFaTWRvcTB5VDcyWU5tc0Iy?=
 =?utf-8?B?bml0dnAyd2pxdlNoSjdGL1dtS1F1Z0tOdGVpUjMrd3cxRTh0MndMR0tTdmk2?=
 =?utf-8?B?dnJOQm9CQnRsUG1ScnJHOXhBRFBRWEVheVZ6R3ZGdEhkTWpsbEJEeTdaUytz?=
 =?utf-8?B?V21INVRlOUVzVlFBb2lXb3F4UlRYOFhlcWJiWENXdG0ydm1Rd2FPUldReVVt?=
 =?utf-8?B?cWZvVllSSlcvNzBIaXBtSXVianhmL0FBaTBoTC9FbmtRZERzOElTdGZNK2tD?=
 =?utf-8?B?ejBjVHpRZlFJb3BieWk4NERMWmMvdWYrQVlWdTdxaFVzcmsxSU84Q2pyM0hw?=
 =?utf-8?B?VDZXTHRHM0ZEOFB1OVZuRUh1K3ZwdlRxTWFNOElwMk9OSG5vOXUwYUN2RDN3?=
 =?utf-8?B?ZWMvTzAxMUtnVXA3MzYzeHgranRrMGFOSldZNmo4SVMvalpVVjA1YXVxdGYr?=
 =?utf-8?B?UE5EQ0pVWkxtNXZxSk04L0ErSUErYzFKNTJzb2VHY21oS09PVUl5MDY3Q2ZN?=
 =?utf-8?Q?B2PsWcS+qTEQZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNiWkNGQ3FxRUF2VkcxUXVMZjRmckFYSnNHazMrTFBhbzdFS1FNWk04QVFY?=
 =?utf-8?B?Z3FmRHdGUWlvaDNzK0Uvc1ZvYzBTWlk5Y3hyZWc0T3pVU2tEMEFJNWZNNUtn?=
 =?utf-8?B?ZjJMQW5FZDlZMm52Q05CSG9zbXQrL05UMURRUDdnTC9pbHowRFJBak5BNncy?=
 =?utf-8?B?THQybVVXeVRRd3l5UjVtSW5mSGdkVVpRMm5JSWpZRktyZjJJT1lvcmlBb1Zk?=
 =?utf-8?B?QzMrOUtwR0wrMXhKc29LTCtrdkQ0bkFFODRNWStvTXE2cXdjZ1RpZ3ZDRXBB?=
 =?utf-8?B?WFFRMnVseDBzUk5uZmIwbnV6OTArUU5vcFBYeHVLbWhSNTdnNHUwRjBJZmhZ?=
 =?utf-8?B?NE5kV0l5aHA4dHVMUVp6Q2lwbzRlMVREMk9vK0JZbHQ1cFRxSzVVUGFCOE5k?=
 =?utf-8?B?MGpCVG1HdzVkM0V2a3lJSGtlZVN2RWZOOE5Ib25QdXRIQUI5UDIzdnVHQSt2?=
 =?utf-8?B?bGJ2TlBjdDhmVlo1ZmY3dktDMzdqQ2VrWllsSHJzMEJ6NWxMWC85ZXU1NWNS?=
 =?utf-8?B?ZkZQYTlVc1NmTS9jL2wvK1F5eStSbDEyQXFKclI0T1hFblZoT1pNN0dtMFc3?=
 =?utf-8?B?QnhJcm5LeEc4ZEpTcWdEMkpIUXZpQWJEZFZjWGdqazlkWlFBWkF0NHhMUStR?=
 =?utf-8?B?dmdhM3FFem5UNG85UHhHT1lGRGEwajNqSmVucGV3N2dpaXcvdXFKalNydmdi?=
 =?utf-8?B?UHFQcGJON1FLcU9pbVRNREpyNXJRWlpZTUllbjlFeURwUGxkQnFMZjZxd082?=
 =?utf-8?B?VUEzS1N5dmRUNE1LR2dtM1JQU091dmt3T2NzN0dwTTFLT2hXZkF1R2lGbEpE?=
 =?utf-8?B?Ykw1ZkZuOUtFN2FBVkdFMEt2TDJPTDZteXhHMUV1Qm1GbVpsS1lJMmtNK2JT?=
 =?utf-8?B?Z2hlWCtUYVVDMzRLdDNZTkozUzVIdkZwQkE0WEhnejdOMVE4UE5EMGNKUitw?=
 =?utf-8?B?dEN3d0tZNlRIbkJiZDFUTis2N1kwdTVZTU15VDVzWTF4MXlpcjB3OEhSSjhu?=
 =?utf-8?B?anJla0pVTkRBYWtKQWk1V2hKTDlPQVE0Z2NtUkF0MXM5dmtkRmRVU056U0Jk?=
 =?utf-8?B?TUtlMUlVN0ZpelIwOFpST2l6U1RJaEMwK3pWdVhNcDZUNVc2Q29tbGJWam1W?=
 =?utf-8?B?dThQUTd1eUo0aWllQ002d2dWQ2x0REV1U1plNWgrVk9iMnVjemhiYi9YNmZQ?=
 =?utf-8?B?TFVkcnJSNCtEeTdmU05iOHFKSWVIVHVPK2V3Z3R0aTF0dWU2c0RCR051byt5?=
 =?utf-8?B?OFFjdVM4dmprWnZUTFFsR1dybmpiSjVwOXlkcUwwTmRrSWdmK25SM3AzNEhl?=
 =?utf-8?B?T3FsU0p5eTRvVGNESnNnR1E1NUJsdy83QWc1d3ZISHg4L2tEeTZzdXNnR3hL?=
 =?utf-8?B?RnpOUUlGbzNQSDRJazdOa0pvdkVsMGVvMjJzdzJWb0tJQ2dtK1F0YnJMZzFY?=
 =?utf-8?B?SkNuWHgxYTZNekQwMjNmMldTNytRWmY3ZU5DVjNYNTJ0bUZWQk1kcHgvSHJS?=
 =?utf-8?B?Q2ZMMEJTb1lUVjlMSVczaDViVStlYWpScElpeERKZHYzelNYcVV5MStYOG8v?=
 =?utf-8?B?OWx2RnJ1ckRhdWVCVzlaWmtaRDB6T0ZIbDZQaEpxNkJ5cmU2UlhHekZUTStY?=
 =?utf-8?B?TXNXSHVRd09JTkFRNXBLUGJnK1ZCNjN1a0Rpek4xeHBKR04xanp0dHoyWEFO?=
 =?utf-8?B?QStWZmkzdVkvanI2YUNEdU0wOWxRd2RyazloWW44dXl3Y3JmWnNuUVROOVJT?=
 =?utf-8?B?eUdhTVB2UU51dWNvT3F1YjBteXE2ZmlXcG9mSnR3Y0hxWklkRkg5Zk1SV25k?=
 =?utf-8?B?TDliczRZbVN3ZGlncXJtdStEOHpFVmYvSTFHYWtNWmQ1VjJhZDM2QVEreFlx?=
 =?utf-8?B?cUhjNm1aaEhsZ0w2WHVHTXQrOUhUcEQvZHd6dWRvWjlwMVlnV0dvS2tVSVds?=
 =?utf-8?B?dnFQajNCOWY5TUVWMTZFT1oya2h2bjhxQ09rU2lZNTdmR1QrQVA1ejZwemRM?=
 =?utf-8?B?Njl2ZWpqdkdCVXowKzlraUJDbFp3RmJwQXFCTDZRK05FNnpMVCtNeU8xRm80?=
 =?utf-8?B?UHZ4SDA0aDhxUU01c3NzeGpxeUZoMTRKY1NBRStudjV6Nk5TbURFZ1c5MHNl?=
 =?utf-8?Q?IH+sN6Yz6zZYGyiFt9L7/b0g5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb47b0d-91db-4ed3-329e-08dd5a83eed1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:48:05.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHpsrafQ/9zRJGeAHHVHKs4vVHTdvqHVUSdvSLklJ2yPMiQgjeo0jARAVCV35MnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

Am 03.03.25 um 19:45 schrieb James Zhu:
> before move to GTT domain.

That might not be unnecessary. We sometimes intentionally move BOs to the CPU domain to invalidate all VM mappings.

Christian.

>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 62ca12e94581..2ac6d4fa0601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -595,12 +595,6 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>  {
>  	struct ttm_operation_ctx ctx = {.interruptible = true};
>  	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> -	int ret;
> -
> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> -	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -	if (ret)
> -		return ret;
>  
>  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>  	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

