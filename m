Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8047C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 15:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309DF10ECDD;
	Mon, 28 Mar 2022 15:18:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B11C10ECDD
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 15:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsvCRyC+njGrCKhUDpkb/7WPScwC3BThMbA411dxnaeN/wU6DZAMMQbM7CimMLRWC2X2zmD3NFtxAAwYhgNJls2R6hG7yl9b2PvAsVd8bP+8sCMfED+1VtZ13w9VGNfJdrb3cFjDmUygExJUCEqbdz/8nFfq4ExCop3DdYw8CXUPdlx08g2KyXsQCyyITq5XcKfwtmH4N9+Hi0DTdkk4Q/pK5Tz95SIoeqNY8n8zQwgFnev7bzjaRwHZq/DfkW8pi3u+00pvi9zILnq7cSSPmZIAsZIINsPNd4fDEPJT+lyfiNRBRxnSpad9GRdtFIZNe0yGt4rLZ2jTNswqHCBYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t+CeWI8jJoiBfcDj1BshqFm8wg3bAr4rbnx30KLbeA=;
 b=TxHNeJRHFEEHFVXjNvzJGT7iRxk3Bkkt6XPMVn3RIFt/MP2sfKAObHuy50rEvF0hLaxs8hg1h5loLkLHsuC5rzQ3MYwz794IlIcBl+L64FnYiYl32fdcJtsGMRh/QXYFjGBk/lqvzqL7SYsN+HKWXVm2/XN1YEeAYkto6Xw+DmXDPrrgdfScd+E9EaI+SmnsVbx8z7sFxKvra/jK2l3diT9ftrjGcfj0Qd1HrXRCJikQT9YPxx+xFNDUZuXG4e5wG5GPM+hjxaoEOahcEVHUGJ6yD4nzRzD6a4ouE55Rb/ErnX0DSc7Pw+Z5FnD3auprcwe93UwXRRqHuG877M2Iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t+CeWI8jJoiBfcDj1BshqFm8wg3bAr4rbnx30KLbeA=;
 b=qV0arY1wQjLyhT/BA6DPAtheQI+RzY5WGiIpdFUuz74ge0S3Qr8fxxuxftzmRT86Co5ZY/UraDCkb+bmQAiOxyXJmylgwm/79y7Jwbp2XHlaLrSaG+dtpNreYDRPAxqINJRaT+mPW7p7GgWrUbW/m7GZLbQMKlIpdnqpqK/JUaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3773.namprd12.prod.outlook.com (2603:10b6:208:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 15:17:56 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 15:17:56 +0000
Message-ID: <80529a89-effc-368a-da12-14d7e44c860d@amd.com>
Date: Mon, 28 Mar 2022 20:47:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328143518.1253762-1-kent.russell@amd.com>
 <20220328143518.1253762-2-kent.russell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220328143518.1253762-2-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8296898-7104-478f-02ed-08da10ce2288
X-MS-TrafficTypeDiagnostic: MN2PR12MB3773:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37731AD941E7F00E3EBFBBA4971D9@MN2PR12MB3773.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toKPUmAvusvYg37cZpN7jpKGflXzfjCF8584pkE2aypo9qVT883UDWyFhqyMcER7cRB4NwOZmZNjmX8KCiS3sew3SNHE3GrgZaDQlz3XhkbMmSUu++U9rfhFyLl9oryDdfjKxb5DSi8VcUzfg9VyVkSAkPMOIRC0ZE6q1LXX7iqQsRiJv7WM35ffsZ6LmfLat9awJn19RXLR3J28xtPPMc/ANgUcZjVgTJJhO+eridX7TpYcwQvOJc2Lk7GCK4rJLACL/kG862YRvL7AuibQP/r7ipSHgrap+uFqGAv+wrPxSEGEnIhE19MTHoj5qhXCSszKFUlVEzzZ1swQhpk82JE5Fki18QTmPDTC0Gbs8APLZsAvc1n0gKwwiIT/SJkce8x6MOcU1mx8UVC9KrHleLHQwyUEonPSLQsOMrTgSsYW7TEeoPYvcqbYQ6ItQoPljMldA1ZSMm/rnFZXbLrzjZ6CiU5uUgGQHwGPPwn27R0nxXAPigdQzx1TxqeDX9N9XxlVedLh8CAeoI9QOTxTJN3U+z8oAc2M2ZDb7kwcuNbW3FCxs+sfLfR/aZ2vZWGdw36GA9tD5FgRdghuq/N5MxNTHaT0QkKjamh9+h7neWUdC0ROiWl6spJcAgTGQ6ip209jWY7YBJCVjsY8c2ZVA3Jsltl7OAUrqw4sNb51ZCNa1JSgnCKBTK7+dUwmH+QJJqicnvNxuZod0Gk2dkU7pqHvjEkX2XNKNIGBZhFcQUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(6506007)(5660300002)(26005)(36756003)(38100700002)(2906002)(8676002)(66476007)(6486002)(508600001)(6512007)(86362001)(53546011)(186003)(83380400001)(66946007)(31696002)(6666004)(4326008)(66556008)(8936002)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9aN2F4a0pIZllFVGMvVXV4NnB0ZEI3R1RKakI3aW94d20vcHZPbm4zbmsy?=
 =?utf-8?B?NExqbUhoS3R5aU05REppaWl3OTFDdTVqQlF2V0txdTRFK2hJUkYvbWtSbVBV?=
 =?utf-8?B?TWlUNXBKQitwbFJCdXQ5ckNsUHluU2JzWi9jUmtYK3NGdm1HeU00Q0NyT2l3?=
 =?utf-8?B?S1l2bEpldm14K3ZCT01Ic2dka3BnbnZyNVNqc2lzU3Rzc3kyZ1F1Zk1KUGI0?=
 =?utf-8?B?ODZxSXlZNnBINzU3djZabDNpd2tza2k2YkhvU0U3N2MvUEZSNHNCdWZLOTBC?=
 =?utf-8?B?WnFDejRXTDlNQ2x3T0pxU3NNK2loajBOL0I0a1RjQ25PWjRNRTRJVVZZMExH?=
 =?utf-8?B?aUQycGZmSlZBSHppeXFrMHJ4aHFVcU00RWt5dmRGODJJbjVXbmpCMjBrbFkv?=
 =?utf-8?B?SE9CbVNXZ1FHS1hydXluL2RyZkxkM3l4TTdTYTdmL1dHQVpVUURXcnVheUlB?=
 =?utf-8?B?aWptcnFqT2lMZmRYL1NjUTZTcm5kaTN4WEgvV2tDZXdQeGpXNEFBRHg3aU1s?=
 =?utf-8?B?WG1RdU9qZmhIdE9VWkFlbzlpdGM3S0N0bmw5eER0VzA4M3pHeWVjZUQ5b1N6?=
 =?utf-8?B?dWN1ckxaNmhtcTZOUGJ2Vnc4aG9lWFVhb3RZUjM4Z29udGpzcTk1Y1oxY0xs?=
 =?utf-8?B?cm5USG84VkQxNGdMUWZ6ZGs4WWdtRXZ3S0NIV1lkZE00UE04MFQ5RHFWNWs3?=
 =?utf-8?B?WnJPMWJ2bkxrbWJrT3hybnRHNmlwMXBsbDJvS2ExaXZBejFGTUNBLy92M0ND?=
 =?utf-8?B?a0NTVHMvY1gvZ2VGbmlRR0Vjb0JJWXlPNWNLblYxK2t5RGpDNWRPc0FDMTJX?=
 =?utf-8?B?ZG9mQTlOeVE0d0U2aDRWMlVOTExVQlJZMFNSbk1yQTJXc1lrejc4Z0dvL09Y?=
 =?utf-8?B?ajFVQWFDL3Ywb2ZlOUFtYnJIM0VHTUdRS0dHb0o2VVNubUJ3UzhaNHNOSnlF?=
 =?utf-8?B?YzBtWWRkNnoveXJnVzl5OW1pLzF0RzJQaHlKb0krNHE1bWo2VHRZVFFCWnNZ?=
 =?utf-8?B?SHpjZjREN00yelh1aXI0c1hsT2t6TjBQbStCaElxRlpWeHVjUVZ5dzBpbHpM?=
 =?utf-8?B?Y0ZzY0FFczhRVXlKNUZMeWs3bnZodExCSklaTWxtTU1mRDczNjYvR0ZyczVa?=
 =?utf-8?B?UWpOU1JCcVVhOEFkTkFDT0tnUlMwU1RuUFA4QnVuQkZrcTJCU0V5UXliSjg3?=
 =?utf-8?B?bGUzZUxYWUU0NDhyb0REemhRTlBuVmtDSXNSZy9PdHFpSW1YakNWMlROZFVU?=
 =?utf-8?B?c1lSTUNwUEZMVmh3U0hhSXNGZmZNYS9HSjF5WVNBYytSR1VPeVJqclJkcXQy?=
 =?utf-8?B?aUlyR2dpWFIrN3RqalFpWkg0N2pFMWp4MkU3QTBMZW9ia3UxSEdZcTI1aXRE?=
 =?utf-8?B?OEJPMW5WdmZRZUFYeHZBczE5alpNcVhndEZ0cWE5K3RPSTB2RWRDVmpjd2hU?=
 =?utf-8?B?WWpuem5TbkdCZE1DY0dYZHdWRWFha2M1TVp1SDM2SVBlK1lDeENzQjl4RW9E?=
 =?utf-8?B?OWxqZnNweXp4OCtldXZwd3krU0pOVVc3ZjhLY0pvdkIwbFF4L245MHMycHEx?=
 =?utf-8?B?Znd2TmtBc1dLcmVFV2psTlhLbTFxQTlqM2k0N0E0RCtFaU92OVNvazE3QTRH?=
 =?utf-8?B?Ni8yNEl2bjB0d0M4U2Nmb1NRZUhweTJ1ZFpHaFNSNlU5aHpYZGhRTnUvV2VC?=
 =?utf-8?B?d3l5c2tKeXR0MnN1d2t5RStHRTRWODE5SnowU0puQ0ZtTVRRMWRyOTh5SVNw?=
 =?utf-8?B?eEI1RE82elh4UjdDYXR0YVB2YVpMRlc4bUxEQzdDTEowR2dsNXZTWlNnalkz?=
 =?utf-8?B?ZE03T3NHTkNiY1p3UzZUU1ZCRFlFWmM5d1NLL1JHNVd5TlNMcWtGNUd1VmQw?=
 =?utf-8?B?OHpDN1lyVVkySUxwVllHdEczSGFtdGNJRkRzejFjekdaK3dLY21CNmdYaTRE?=
 =?utf-8?B?SDFzTEcvZUtWWmdNVDhKRVI0NmF6cEtQZFNCZDZSRzZaNUwvRkt6K0NHanNh?=
 =?utf-8?B?RnNjclRIYUo2OTVZbTFHNEFTV25vM25WZHQ0OVdWZG9PbGRYeURoUmJ0Sjda?=
 =?utf-8?B?dlZKK2FkR0plakFUZWJhNXNPSjYyTDJvZDE3Y29pb0JpWGp5ekF3TlpqOFdM?=
 =?utf-8?B?MVBrUmlpMWt5Um5aVWF2UUVLcUJyQW10TCtJaVNsKzFzTnhQbGgrNm9vQkhU?=
 =?utf-8?B?V0VOMEhoUWZoTTJmSnUwc0JIbEpYZEZVbDUvb29ERExNRVVEMkp3YkppeXhX?=
 =?utf-8?B?UFVmOHR4YzgzQTZ3RExDN1BxdU9nUlJTU2xoaklJa0pVSThDMXh4d1FsZ205?=
 =?utf-8?B?RXdjdmtZOGE5NXFnRkdRUEdGRXNVcG5YaFB5OW5xTHRjZ29OS2VPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8296898-7104-478f-02ed-08da10ce2288
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 15:17:55.9367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ziRiLzt+pIS9jWznWqdY/cixSttWq/g/5W/Px4YObNBPGeHxxXbuN63zE7pMtAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3773
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/28/2022 8:05 PM, Kent Russell wrote:
> This is being added to SMU Metrics, so add the required tie-ins in the
> kernel. Also create the corresponding unique_id sysfs file.
> 
> v2: Add FW version check, remove SMU mutex
> v3: Fix style warning
> 
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
>   .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 36 +++++++++++++++++++
>   3 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 4151db2678fb..4a9aabc16fbc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		case IP_VERSION(9, 4, 0):
>   		case IP_VERSION(9, 4, 1):
>   		case IP_VERSION(9, 4, 2):
> +		case IP_VERSION(10, 3, 0):
>   			*states = ATTR_STATE_SUPPORTED;
>   			break;
>   		default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 3e4a314ef925..58f977320d06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -1419,8 +1419,12 @@ typedef struct {
>     uint8_t  PcieRate               ;
>     uint8_t  PcieWidth              ;
>     uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>   
> +  //PMFW-8711
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>   } SmuMetrics_t;
>   
>   typedef struct {
> @@ -1476,8 +1480,12 @@ typedef struct {
>     uint8_t  PcieRate               ;
>     uint8_t  PcieWidth              ;
>     uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>   
> +  //PMFW-8711
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +

Is this the case for other ASICs also which share the metrics data with 
Sienna?

> +  uint16_t Padding16_2;
>   } SmuMetrics_V2_t;
>   
>   typedef struct {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 38f04836c82f..550458f6246a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -481,6 +481,41 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
>   	return sienna_cichlid_patch_pptable_quirk(smu);
>   }
>   
> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	SmuMetrics_t *metrics =
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
> +	SmuMetrics_V2_t *metrics_v2 =
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
> +	uint32_t upper32 = 0, lower32 = 0;
> +	bool use_metrics_v2;
> +	int ret;
> +
> +	/* Only supported as of version 0.58.83.0 */
> +	if (smu->smc_fw_version < 0x3A5300)
> +		return;
> +

Since this is shared with other ASICs, I guess this check itself may not 
be enough. This function may be skipped if it's not MP1 11.0.7 or GC 10.3.0?

Thanks,
Lijo

> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +	if (ret)
> +		goto out_unlock;
> +
> +	use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
> +		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
> +
> +	upper32 = use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> +				   metrics->PublicSerialNumUpper32;
> +	lower32 = use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> +				   metrics->PublicSerialNumLower32;
> +
> +out_unlock:
> +
> +	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
> +	if (adev->serial[0] == '\0')
> +		sprintf(adev->serial, "%016llx", adev->unique_id);
> +}
> +
>   static int sienna_cichlid_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -4182,6 +4217,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.get_ecc_info = sienna_cichlid_get_ecc_info,
>   	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
>   	.set_config_table = sienna_cichlid_set_config_table,
> +	.get_unique_id = sienna_cichlid_get_unique_id,
>   };
>   
>   void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> 
