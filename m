Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFCFC982C4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4BE10E183;
	Wed, 16 Sep 2026 15:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yqKZX1cI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C3210E078
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6z1jzcZyS+1s2ACTH7JHXNUNnEM7oxw1iDzbEbrFTygKi7PU1kvRL+KIItQBCxnUxet2SnU0t6MVtNTrjurYLEqX4V8tOHoCSl8jiS5VGWIuwgiuKGUteE5Aqq2poS1e6tNv+Bhymy8vRBceqOgyDuLxbNJ8NFa+MuV+OcxRxEQK8CYx2TYY1S3vMrLhwEZ5/DEExnnm8DvXs0hwy7dYpvStU/Wy3EbVXnrg4tXdtmJW1x0mK9739QK16bFUg+aenT+pZSqU1gv991tNzehsOpLFUsRGbDndlCGSmRmtWKwYTq6E8buORdmnQui4YE1NykMH8zCInDBoajwD7TKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngozIKc2nYWS0MDUZBY+D3Hi+/2Mvf1PZ/WmiigKmn0=;
 b=aSN/7YWPtTTRmROjYcsA1Wkf7ScFrNrFpWFkazUbvvdnNvsrhXxMLN39yeujpDTnVeCPxnM4Q7gdt88WE5es8A6MNpcwHU37NgJtW1yGcreIh1q2SxADacaeV4vgZP5SBjRpkxggjE1cXMixI9BRbxeoP8KH4joD72nCWKgyojOpvM2cG1336G9IazxV0YdXyJkegNmiUlJrbEJwhufJDxlkPeN3FqGo+4zV07m5Wzrx5/TStXf2li2K0vfzgaQ/HxXHjB6/gvhztbaXF9CqNOry7dtcRCbrynOyF8p0awZfgrTJ1LVtVymWapeyIanJ577J/2LDDvQZcIQivPuxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngozIKc2nYWS0MDUZBY+D3Hi+/2Mvf1PZ/WmiigKmn0=;
 b=yqKZX1cIYHKnXs7DnniSl8hEG/49hMqMrePNBv9edCALLEwzuRqp0u3Fr9ipve9IfRY+TF4/zANCZ5XGWnUerIZX/y45xUS4cY0pkWbncAQXkuvkvHTPqAhJ9nGNgSc5hkgboRj1MGaiKi0LXu2PZeLKJ+hIpU2uQGhx2Ddnh9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:29:04 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:29:04 +0000
Content-Type: multipart/alternative;
 boundary="------------YPSVd0mr94e5M0DbHtAkYjZ0"
Message-ID: <de0dc981-0aa0-40c5-b24b-d70f76e30e9b@amd.com>
Date: Wed, 16 Sep 2026 11:29:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes12: clear event log on resume to avoid MES
 page fault
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 James.Zhu@amd.com, Shaoyun.Liu@amd.com
References: <20260915071404.3906274-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260915071404.3906274-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: YT4PR01CA0500.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::29) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1911b661-0fc2-48f1-086f-08df14073d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|6133799003|56012099006|22082099003|18002099003|8096899003|10067099003;
X-Microsoft-Antispam-Message-Info: 7Exb9Nljp1kBUTwHtF2qsDkOnR4/kkj+3jQK7ywQYR6RWrUBCrMSnJPB4QotQzPAUZdqqieCLcd8cWUicyzeYF2SrgmXMH3SPYGmIvlAPjJEuqx/eEmdwMq3s7/qiBZ1Awx20bEYyDMxeixgfjnAZnujUyNOIHqYTDUTDpSTfcRaq8VsLEopIDc5BeoLAhjaYUE5NQiWYjrlWvZs8vNWkKO/DLVp/R4mwZXkQWp6aTa1UThDrs+5qyYdUPFV3ldmrVb8hc4oOOA0h0dKLp/PvXpwiYdkfD/lsSTDz4oo1wg63/ACsfVjRVBG/st0XSb3v5kGgBb81wu3NoDiA4m1JsMgxwAEk5f35ViNzdSSNz6OB77SeahSfOOilB6UuqyryTfYVwZmh2aT+um+hq7Ly2j0XTpIJCzB0wF2mn0KZayuV9WIm5ONWFU6u5hfqWGMumWmcfpVM5bPu3tFYjjhY8fg4Ayn8BgZQCIHKt/YmR4Nesk5SUIo5aqHX8yrJhjpqezpvn6bfAdmjJ3njnFZSyVuokWFN0L2YnOFqzMX2gsktcb67MmsqGjV7kN7OdvTF7JiqkuVCifmeeX1WDDoGDHdZDP3g7NREuH919caRdaUyymW05sEwiVNHJUiCgAtEG3AuURzC3TtJ8ZZ60dySdqnZ3KLyRH8231KLJWpDCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(8096899003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGh0WWl4dkNNM2YvSTdkeEt2bGpLMzNXWjV0d1hzTVhwa2FkNDR2ZDVxb2Nn?=
 =?utf-8?B?L2s0TERSM2ZpSXJnOS95cG90SmYrOXFwekZRU0dGSXlXV1BjRkd4N0UrWXEw?=
 =?utf-8?B?eGtETUZ6QkdTK2krMy8zSUoxSFo4ZVlvMFBxNlNGVCtoaFF1dlVhbWc4eTJW?=
 =?utf-8?B?aWNuZUhxN3lEZVJLbU80U01qSHJiemljWms0ZXJsUHFOUDlYeFZWNUJxaEZi?=
 =?utf-8?B?UGFhZWN1VkY4TCs0MkFDenM5SkRMNVEvZWt1RWhqem13TlQ5UGdEQVVoWUc1?=
 =?utf-8?B?Q21oTElSVnlyelJSbFYrRDR1U3ZOYVdrRHJzcEJZdlQ3R2NncDh2UG9qL2Y4?=
 =?utf-8?B?dXJUck1rV29YT3VNZm5vNHJ0YU5xOG5keHdWOG1oVWxDR3VISTc4blJrd0xF?=
 =?utf-8?B?SWIrV1hpOWlUUTQyVFNVc3JkYVpvemZvaHNpdTlMd2JhbHhlVzV0RmlFT1Nq?=
 =?utf-8?B?a1lidkZaOGZUNFc3NU94eUZ6NStZZm5ITktXaVJFOGZFRUY3Y3FGV00yWncy?=
 =?utf-8?B?ZnhobGVvWmt3T0lSRUlRY3B4RDYxbHlHbzdoSkxWTDNOQWZxMzRkbjZoRkd0?=
 =?utf-8?B?Y1NPL3dMdExsd0Y0UXcybjhLbFhvZVEzRGlmZXd6SGdmU05kSGdYamRoUXFj?=
 =?utf-8?B?RzN3ZVE2NEtoQjNqamJBT3lXNDh2dFdFeVB2UzdqbEVyc3RGejI2eXRpWFpo?=
 =?utf-8?B?WDdvQUtkQ0NkVXBneWdvblVoaXhBdXFOTEhSR3JmYUt5WkU2MVZQV05DM0ds?=
 =?utf-8?B?QjhENWs0cE5UMi9yc0tqR0dKTHg1NmdrMmZWdjlmZS96Lzg3L29IWU5HSW1Q?=
 =?utf-8?B?Q0ErOG9nT29TRVhFaVBGSEM0bWM3bFptL05ENkRyVEFKMEtRdU5TTGhpcTZW?=
 =?utf-8?B?S3hSRFNUdTdneFRic2FmVGo3L0dlRUxUMXh6cEt6Y1BlaTNOazRXZ0FvTFQv?=
 =?utf-8?B?MEdYMXFtVXEveFB4MjluK1c2VC9wWEUxS2s3SFM1d3k5U2RtakdndHB2eHZO?=
 =?utf-8?B?OEhjMUw3TFJqUmNYU1pBOWczaFRFTnd4SUhjeGVDYkFGVTdMc3JJb0gwUndx?=
 =?utf-8?B?QnRLMWpGb29ML0dOcS9waVh4SjFBcXpYTjk1TUZrdmNYOWExdXpRNk82Y2t0?=
 =?utf-8?B?eUk0b3REVVZjU0MxY1Q3MnZsdE9VanRPYmlaVXBFRWxqY25LSWJPQlh3TFg0?=
 =?utf-8?B?WCt3MHhWNnA1VWtyeWZkUlp0SlB4UlE0Nno5MUtEZlhqOWhnc0YyeEp2U0N1?=
 =?utf-8?B?NWs0bUZRZS83aGJTZUFCSEZGVElHNzlodnJPbG5CcUtjRTk1OGp0dGlFNlJN?=
 =?utf-8?B?ZlhJZTBwOTNFZ2QrUi9kQmIzeFB6ZGFyV2lYNS9CZ0tqNVIzSFJkMlZBM1BV?=
 =?utf-8?B?d1RtUU85cHR3SlZIOWdDam1WSHBXODV1VW9uTGRvN1hKd1FJVnZJTlVRVzNR?=
 =?utf-8?B?OVdySE1ZMzl2VDVRdlV4S1NmNjg1TzV6dngyaEpsWExsbFQ5TUFRdmx6NFZt?=
 =?utf-8?B?cnIyTFpsbEwrcE13OHBRY3BjTm1oSzBiL1U4RDFRYmJTSHdMZEpkKzhNUnBU?=
 =?utf-8?B?M29YenVOeVpndTJIbXhWY2ZSaFZHUXh3YU9SU2tUcUN5Vy92UVgvK2VTOXkx?=
 =?utf-8?B?V3FWUEt0OHJlaHF0UWpSMFZkakRtWm5TMm1va2JrRnhPMkwxV05FZXVsRmE0?=
 =?utf-8?B?Ymp0RFdnN2dSVHZpdVVSWTNFdWFFUFNHTmNNS3JVQmh1M2VqNTNBb0s4dnpJ?=
 =?utf-8?B?cldwNml2MFpVT1VUMm1hOUpMa1oxR0FmcUJiQjZ1Q2VxL0ZKZjNJUC80RFpj?=
 =?utf-8?B?NGl4S21lTHBPK2t1TkdjRUNwY2R4SlNDa3lIM1RQcWFMVEFSa0ZPLzNwUncv?=
 =?utf-8?B?WWZVeHlvSG5RZUUrbmlnVzhqWkgzYkppL0dGNWRONHN5WHYxNUFnSGMySHlq?=
 =?utf-8?B?aVFPc1ptZEV0VE1pSVVacml4OTJIUzYzNG16ZFJUSTZTSEpLV1NBdFdZa0ph?=
 =?utf-8?B?RjB4ZU1GcmJuMVc4YjZWd1RoRG5nVzY1VEg1Y1ZGZ09aZWl5aXNPeE9HME1U?=
 =?utf-8?B?Uit1K0FXNStOZTd5SzBjamtIaGNXZ2tUOXdoaGJZTEd1K2N4NWNGaVhKbURl?=
 =?utf-8?B?bGtCak01M0FkcUlRUWRiUEtUaTlmWHVxYkswRHl5RG8rSHYzUjhzd1ZQejJR?=
 =?utf-8?B?TXVyZzdwTUtITGZNNHdldjBQa0wxalBndVIzNkgyN3pkNzdTc0swMGpVNDdR?=
 =?utf-8?B?b252Kzg0ek1Sazd3NDFnaGlTK2puQ1B6K2llUS9PRnBZTitWdzZublo4WFBp?=
 =?utf-8?Q?XNoA7abdbjp5NmCHbQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1911b661-0fc2-48f1-086f-08df14073d68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:29:03.9278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8DA4wh4ZZ/9+h4NNIVSVPv+Hph95Tmd7+KAM32ggC+g3UJfFPjBKLYkp3M3M7+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
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

--------------YPSVd0mr94e5M0DbHtAkYjZ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thispatchis
Reviewed-by:JamesZhu<James.Zhu@amd.com>

Tested-by:JamesZhu<James.Zhu@amd.com>

On 2026-09-15 03:13, Jesse Zhang wrote:
> The MES event-log/MSCRATCH region is only zeroed once at sw_init. On the
> resume path (hw_init without sw_init) it retains stale data, so with
> mes_log_enable=1 the MES firmware walks stale pointers on activation and
> triggers a recoverable CPC page fault:
>
>    [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
>      in page starting at address 0x000000855c237000 from client 10
>      GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
>      Faulty UTCL2 client ID: CPC (0x5)
>      MORE_FAULTS: 0x1  WALKER_ERROR: 0x1  PERMISSION_FAULTS: 0x3
>      MAPPING_ERROR: 0x1  RW: 0x0
>
> Re-clear it before unhalting MES.
>
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index ee72afdb0a1d..9e149cf98889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1306,6 +1306,17 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
>   	uint32_t pipe, data = 0;
>   
>   	if (enable) {
> +		/*
> +		 * The event-log/MSCRATCH region is only zeroed once at sw_init.
> +		 * On the resume path (hw_init without sw_init) it still holds the
> +		 * previous session's data, so the MES firmware walks stale
> +		 * pointers on activation and triggers a CPC page fault. Re-clear
> +		 * it before unhalting MES.
> +		 */
> +		if (amdgpu_mes_log_enable && adev->mes.event_log_cpu_addr)
> +			memset(adev->mes.event_log_cpu_addr, 0,
> +			       adev->mes.event_log_size);
> +
>   		mutex_lock(&adev->srbm_mutex);
>   		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>   			soc24_grbm_select(adev, 3, pipe, 0, 0);
--------------YPSVd0mr94e5M0DbHtAkYjZ0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>
Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Tested-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> 


</span></pre>
    <div class="moz-cite-prefix">On 2026-09-15 03:13, Jesse Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260915071404.3906274-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">The MES event-log/MSCRATCH region is only zeroed once at sw_init. On the
resume path (hw_init without sw_init) it retains stale data, so with
mes_log_enable=1 the MES firmware walks stale pointers on activation and
triggers a recoverable CPC page fault:

  [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
    in page starting at address 0x000000855c237000 from client 10
    GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
    Faulty UTCL2 client ID: CPC (0x5)
    MORE_FAULTS: 0x1  WALKER_ERROR: 0x1  PERMISSION_FAULTS: 0x3
    MAPPING_ERROR: 0x1  RW: 0x0

Re-clear it before unhalting MES.

Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d..9e149cf98889 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1306,6 +1306,17 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	uint32_t pipe, data = 0;
 
 	if (enable) {
+		/*
+		 * The event-log/MSCRATCH region is only zeroed once at sw_init.
+		 * On the resume path (hw_init without sw_init) it still holds the
+		 * previous session's data, so the MES firmware walks stale
+		 * pointers on activation and triggers a CPC page fault. Re-clear
+		 * it before unhalting MES.
+		 */
+		if (amdgpu_mes_log_enable &amp;&amp; adev-&gt;mes.event_log_cpu_addr)
+			memset(adev-&gt;mes.event_log_cpu_addr, 0,
+			       adev-&gt;mes.event_log_size);
+
 		mutex_lock(&amp;adev-&gt;srbm_mutex);
 		for (pipe = 0; pipe &lt; AMDGPU_MAX_MES_PIPES; pipe++) {
 			soc24_grbm_select(adev, 3, pipe, 0, 0);
</pre>
    </blockquote>
  </body>
</html>

--------------YPSVd0mr94e5M0DbHtAkYjZ0--
