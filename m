Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2E1CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5FC410E7E9;
	Wed, 14 Oct 2026 15:19:51 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130F110E7E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PToMZpeqoyoYbiwRg0OM+xTARYQ+F1FrAOpi9LPGBER28v4Vvg+I4TnxrhCMxLy0DLbWcy7uZIzovGrSvaNtj00K/dcHtY5IEb2VJq0hD972xxmAo2JnEeKWnDnXJez0Gr3EWK7jVNf558QW9fMAr9T0nnzluNDqeqmOHfWtWsGYwIzldG9Y/n3sMqspaRq1/s8xI3dl4jrS8T5sBIAKTEQ1kou6gWMhcFP/a43m4yHtTfOAcFO7g7htApLpOJhaeMW7WoOovmO6nRvET8ePohyLQybYewHLVWangsTL9W1j5BZskasUPhIQRzhkwyimlC45MQKTN/vIwTCT9LcaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seDgNFgju+V4288UAEKlra4z2JiU0IL0N7ZMKvQr6Bw=;
 b=n3dxJNTIi23B+gUdJhdcFebT71Xz7C7zvnv3pnY+ZMZhZ0oo5Qz+Fr9wu9CwlrteTWrK5j2MEH6xGltpCu7LETXzxaARG4yd1Clw9Xy+draM3xwU35eEKEVc6dverhDR4RD8tr7Zrc295m2nUkOHEENxDNY1QQXD8LAoHhefvXeSP5cp8GY/lmF1G3oZdDkdg1q5yweLOwHEXzzdBPM/SS1i75yv9aKihcGVwINt5b+Ali1jDN19GrnoG/Y1IpEmUX/L510d6CLt4PVbVIcy2xmpy62S7q67il7XvokxfqGAtXlCXnFPWWkj0IfnBDMriYTv+2DSqZw5/gkt46KfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seDgNFgju+V4288UAEKlra4z2JiU0IL0N7ZMKvQr6Bw=;
 b=olYV+Xy4EN82m3gmubVzwMepiN+BRm7JApYdEWJK7xrT6NPc9WT0jLMm1REDgsiZt9vZUpUHJEis78bn5sLnySY1NtO+1YM7JGNlWDLsWVlhxGbpWED1vLki9nDptGQqrmRc7X5CWs9wRvtjQg6TcNBY55r/MyWTv0eNre02BM0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 15:19:41 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 15:19:40 +0000
Message-ID: <fa3027ae-12a1-4a9c-88b5-f63c929853a2@amd.com>
Date: Wed, 14 Oct 2026 11:19:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc_v11_0: fix flushing mmhub by pasid
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014150521.2766488-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261014150521.2766488-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::9) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ff5117-2e36-4f67-ab39-08df2a069129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dFGfZv7owG3LnmUkYmNMnDoTiVysnHt+Wss39f/MYD9cjlNquie7efVsEO4oWKE61eg9VQ3pjpK6OnT2nnd4ckJ8zeGCGQEWszMYmtn+ROxxNb7L6gWmJLBZrZBVXc0ty5X9NtBXdWGvAt1fV4r2e1RDCCIyRakjEmDBFbBkeYIWzu/c9Pk/Oe51BLTgOxjS67GMNAqWHysDehLfEtiVraVDIbjARGhqDemClaIQM30w8JdlHqF58crPOCDwpHagak0TsZl9Mv/uOyaFFOx27GWaMbzmM11Aw8QQA9AmpchSFMwArrP5TtClNAsZmjGW45xXKAVlFKSQ/NOtJamcwWhMSsCzxOSBM50A4LTzJBVqVdBj+dMonCHUxe1uJ3kqPXBeRg0Hn2H2EWVUicXHkvnNRcNp31O/i9ofk+iRdrrJDChRPigg8/5M6VOfqcrTPqR5y0zMlyV0q/s4jEhJY0OkxHlGK9WL0aC/KIr5f0ImECfHVxSVNXgGypZA1WcI4P9fuYHfuZM90vJggEeiK4m5P1DLUFNVLGf0uIZfhtt550vYbP8XX0mWMD1skKJ3DMhdre51EuQCKEdrv7ISWdyqAIEFF+CLDspNalgKjAzCO/kAknO1UPfn2YCPg8fg1lK5TM6XOd+AmsW35mlIMXf/xsYfJsu1hfSfT8hsrpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG8zT2VYeWRnMExXWEtlb1BScXBtOG5FUUZBeWFzYnAySWxFMG5PRGdjTDdM?=
 =?utf-8?B?TkJDVmIycnN5M3BVeDJvalljZHZVTWEzS0JhUkgyQkE0dThWU3ZTakVwRHVS?=
 =?utf-8?B?V1lBSmtpQTJQNGNjbm1aZHM2c2NYVm1wcTlxSm1GQ1lGWHZIQXJKY0FjOGVw?=
 =?utf-8?B?SEFYdkluSnNFV3JpeEF6WTVrMCtLRHlKa1JuNW5ROWdLS2IwNTM4WWVIVklp?=
 =?utf-8?B?SitBZDhKd1dwZ1pFSk1iL0QwZ1FnWGxZVDN3U1NCZW5rMkxsZkhCajY3S0xn?=
 =?utf-8?B?ZXkyL2JycG8rNjZSLzdQSFZ3VTlQZW1YRU5CUEpDTTRVdnhQWXZ1SnFjNW9Y?=
 =?utf-8?B?L2laK3VyRGxiU3dQaldRSXYvUHQwb3RUZFVXZG1GVTJGZlFMc3lYR2NzVmMx?=
 =?utf-8?B?WnpMTVlzZVRDcmJjQyt4SXA0eGEzMHZYQlBROGVCNm5BUkhzYzZZU2VVdC81?=
 =?utf-8?B?N0lJcnB1ZXo4bTg0bmR6SnBuYU5IWmV5cGN2eW01SFkvRWpUQ0I3dmFkWjVk?=
 =?utf-8?B?czlMa2FIcEpUa3lid0hQZDRPckVCWXg5NUE0UysvNWdNZmRxL0pYZzlsS2VI?=
 =?utf-8?B?ajRYRnFVcE85WVlXWndReE1jN2J2RnBXaVNBOVNCaWhwbThSbE5hN0gwc1Ra?=
 =?utf-8?B?MkRiTWJDQVZsd01VeVN5VElCd0xsYUxhYnlBZGtkbUNXbXZIQkJGelZRbmRT?=
 =?utf-8?B?ckpBUm1CbXZTaXRyc0w5MnNueng3eENHMldCcGFyRDFqbHc5S1U1ZFpMbjZl?=
 =?utf-8?B?T2hYZWE1VjFFQStHYlhpZUl5Q3hsRTNpTlVtVUZSTGhFZ3NGVEJLcTlxUkdX?=
 =?utf-8?B?MURGdWV5SCtuMTVqWm9qUUd1OU01WGxkRjRjTnpxVDNNai9kU3o5Ulh4YXdt?=
 =?utf-8?B?V1FkTHhIdjcrb0JEYWpWM0N3MExJeTJYM0hWcGdFWTcvcHc2UFI0bWsxd3d3?=
 =?utf-8?B?VFV1VGdmUjYzNlBENEFGeEg4QVZpWGFIL3BTUmxKSUdDcnZVMVpWdVI2T2hC?=
 =?utf-8?B?UXNiSHJZWnFlMUpYY2J3R050TzNvcmxTZkkwMGVaZnByN0ZZOUNEcG9EZVhY?=
 =?utf-8?B?UE1PN2JhMEE3aHlPZ3hlRHpyc0pVYUFVZU5xdHNrclE4akI5Qnl3Y0pGQnhD?=
 =?utf-8?B?NGxRSEQzN1R4bWhienVKOEVuaW5WSlJmVGJwdFFRbS94U0xqSDFScmwyMWdU?=
 =?utf-8?B?SWUzY3Iva1luNWF5ZzlBTjh1ZGRkYW9UUmV0M0VyMzZJK0x5ZEpOSDZoR210?=
 =?utf-8?B?eVUydUcrbWlIZmZGb0diM1dGbHRjNFY3Y0Y4eXRjOERDTGhwOXlCR1NCdkJC?=
 =?utf-8?B?WnFHWUxVOHNFVExTUk1lcGpISVc1ZEVMeS9XSHRrWWFqenRUc2FwckN4M3Bz?=
 =?utf-8?B?WnBtUStQVlFOanN6MHcvaDAxa1Fscnl1UUY0TlRmVXRtc0k0VWZsRGtBYTZB?=
 =?utf-8?B?eEN1dDQvVnJnSG9PNFg1Q3JNZSs3SUNRRUZRY0hsMGpyRjJzenBWZWppR2Z5?=
 =?utf-8?B?UEl3NCtzbUFaUUVjN1ZWWURxbkJIQk1FWEhxQ0Y3b1ZmOHVZSU4wU1VOUWFQ?=
 =?utf-8?B?YnM0a0x2a3ZEOUZJNnZKbnh1S0xkTTltRmx1V1daUWk2Y2hRc1ZSVlJnMGcw?=
 =?utf-8?B?ZFFGT2czelZHakpwSHh4RVU3aU1rWWtmbUg5UEpKSjNJRW1GdWdaWTB2VENP?=
 =?utf-8?B?aHhWTmJMVUZwMzZmVUZabHBBV0xYVkRjZUZvUFNxK2JpOFprK09wL2lOc3ds?=
 =?utf-8?B?clh3a3pqOTBNWGZGUHVWMmoxa3NrM0lXWXc3S0pVaFk4WE5YN0l6TGV5dngy?=
 =?utf-8?B?NWJLT283dFdhcG1NWis0Y2YvRGk5cDh1cnlVdExJRmQ5c2tHQTFQeEdUZS9s?=
 =?utf-8?B?VFl3QjRHMm1mN3UzMjd6UDF2RXJYRjZqY3FNeG1LdjhGSDVNTTBsREI2NFhj?=
 =?utf-8?B?SkRYaFl0TStOQ0dPR2pDNklDVS9CcXl0bllVZmwyMzN1bitlN3hFRjBjR3JG?=
 =?utf-8?B?Vm1MWVJJYWVIK1AzWE0vKzRLaExkUlp1NnRCa3ZRRTU1b0VxTmRKUDU1QVFD?=
 =?utf-8?B?RjlGTEMwUkdRb0xSbjNPYnNQL21qVHI3MUpOMW9iL0xiSWtwa1o3cjVyeDhF?=
 =?utf-8?B?SUFUK0k3RXlpSERLMDZtSGhxd2Y3NEluSExRdncxaHlzQ09Ca25uUWZNL1pN?=
 =?utf-8?B?RjkvZzNFamQzRHhhYjIyeVlnSzBwMlZuN3hZRXFlWi9ITlNpM0liem5aNlU2?=
 =?utf-8?B?eWcwbkMvRkk0aDc4L0phakU2cjJjUjUybUcwYlF4TTFxU1h2QkU2M3RINjll?=
 =?utf-8?B?RzdSTXVUUWJtOXpXQVh0NnJEYzVzWWdOUmZhWFYxakI0VXRybU9pdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ff5117-2e36-4f67-ab39-08df2a069129
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:19:40.5275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqUWgwyF5A8dUCNFv+IX03M1QAqwX1vU9IBwTS0z9I5cVx3Bd0rm5buGggWOfIZt2FVxELvDTGfXfLaO9W0f6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

On 2026-10-14 11:05, Benjamin Cheng wrote:
> Each vmhub has it's own vmid to pasid mapping, but the code was assuming
> that a gfxhub vmid would also apply to mmhub and flushing mmhub using
> the gfxhub vmids.
>
> Instead we need to find the vmid mapping for each hub individually and
> flush with that.


gmc_v{9,10}_0 have a similar issue, but at least by my reading they won't be affected since only KFD uses it there.

gmc_v12_1 might need a similar fix, but I'm not sure how it plays out with the IH_VMID_LUT_INDEX. I'm looking for some advice on that.


>
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 47 ++++++++++++++++----------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 709c3d1b9998..715ccce8e4eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -204,10 +204,25 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
>  
>  static bool gmc_v11_0_get_vmid_pasid_mapping_info(
>  					struct amdgpu_device *adev,
> -					uint8_t vmid, uint16_t *p_pasid)
> +					uint32_t vmhub, uint8_t vmid,
> +					uint16_t *p_pasid)
>  {
> -	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
> +	int reg;
>  
> +	switch (vmhub) {
> +	case AMDGPU_GFXHUB(0):
> +		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT);
> +		break;
> +	case AMDGPU_MMHUB0(0):
> +		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM);
> +		break;
> +	default:
> +		/* There shouldn't be any other VMHUB. */
> +		WARN_ON_ONCE(true);
> +		return false;
> +	}
> +
> +	*p_pasid = RREG32(reg + vmid) & 0xffff;
>  	return !!(*p_pasid);
>  }
>  
> @@ -330,24 +345,22 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>  					  bool all_hub, uint32_t inst)
>  {
>  	uint16_t queried;
> -	int vmid, i;
> +	int vmid, hub;
>  
> -	for (vmid = 1; vmid < 16; vmid++) {
> -		bool valid;
> -
> -		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
> -							      &queried);
> -		if (!valid || queried != pasid)
> +	for_each_set_bit(hub, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
> +		if (!all_hub && hub != AMDGPU_GFXHUB(0))
>  			continue;
>  
> -		if (all_hub) {
> -			for_each_set_bit(i, adev->vmhubs_mask,
> -					 AMDGPU_MAX_VMHUBS)
> -				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
> -							flush_type);
> -		} else {
> -			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
> -						flush_type);
> +		for (vmid = 1; vmid < 16; vmid++) {
> +			bool valid;
> +
> +			valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, hub,
> +								      vmid,
> +								      &queried);
> +			if (!valid || queried != pasid)
> +				continue;
> +
> +			gmc_v11_0_flush_gpu_tlb(adev, vmid, hub, flush_type);
>  		}
>  	}
>  }
