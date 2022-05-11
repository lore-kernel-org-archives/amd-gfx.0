Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 11:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A771410E212;
	Wed, 11 May 2022 11:57:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3260110E212
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 11:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alFM+u4x8mkpYE72LuqvlY/1t+u3pwD8Iti1MaNbXLqcXIw/ocVQ9WZsaB2mEKfFpuUawpbd7vyRU0FKXWpsjm39d6l8UhgNLvcf3SHYpT6dbWE5QBjBlduj/XyUJo6UUsixbciK9d63qFTDB5Dp5ATrtWVuErKJXXOb+I/Z3Eq7V9uSMtZ/0ZaFgS4RBvJdzqrlPZjYlZsaZ5hWZeno3Ydv91YzHDNfwZ5YQe5c1VQCEpeZrPYqVjiZOzdF/NpMHsN4v/EMbsWRGCY49quWTbrUnXzU4pA4V9A2UfsIsd6m4GfrpLrPBiNblVeoM/7jQU1h8xRk6+IP1m3/ndAiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghVcqMOxbsiXQFCj0fkhkNBerBZ67hZ1UcB2QxYl1OA=;
 b=gglXZWmXsm63mm+HRIeIjZi5Xbn4g3myzBqfdisBGue4Q3zBNJWZokGIgvpmR4MG6U4QLEN3Ft+xz56FGRIDTYAm9v4cd5wCmo1AlCX04M7CduIKNfpvMQgnDYXLxwicm7BpLAc3EGvXK6YskeVD2SK0ZdJBXkxvUyeSv+5zI43SVh8i/uKfz5VedAhVBRRAcZ9E2BUdt24tIHxgLMEYw7K0nEonYo7l16s66+VG6jLVn8mSSF3SNro0d/cevpsgcj2yzQVbor1m4x4GJk0AURy2Sx3ksa/77jeJRcVusyxFFBNxG1C+GzFhlZCB70yFmPZUIL2/VS0o8Cx9a4zSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghVcqMOxbsiXQFCj0fkhkNBerBZ67hZ1UcB2QxYl1OA=;
 b=4ykQ/7AVG7tScz+yn0rtZa6GXic4k/XwbM2YpNem9jAjpfpBQ+OYVj0v+cFkjQsF9szwz6TF1FqFGPDd2uSMDlvJiW3TSbX402oJlbuNUPh8Y2pjuBsC6zAAqUrha4l2ou+r9lRec7X5foxSHzh8/kNzSYlrDDEf3aOAfzGrK3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 11:57:50 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 11:57:50 +0000
Message-ID: <ad73bd91-ff2a-e1ff-a4e3-4c4b4a634448@amd.com>
Date: Wed, 11 May 2022 17:27:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: update smartshift powerboost calc for smu13
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511114628.2542190-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220511114628.2542190-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a158a580-8918-4f6c-240e-08da33457922
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB397618CA6AE39936234998D997C89@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7XKw8TMjQ/hXQmkhMd7ry3JBUXL5q8RL/XFK8d1ihJTSkZsBHMbkWCoJduRdFRoLzxFfPXdaqnFueoR4QguQepBlXRIXbIBivTc8jIju08UUe1um6K0AzMJkiKyeh5Dz38GvjQbEBV3SA5SdPNTE05CUCkR9hmk9Scyi8aS64OaweOA3A7M5hc8TQBB9OO/qF4AEKNdDDFaDcOG8b+nBVKV0aB7eeZZzNB9MMHrAIC73wTGOKD3TLkDWW204nsquSW5QaFTBI4MbRuySpL10EjQWHt2GbtXhe4w4cJUpI61jrwpbzu9q88SVHf8j7hRi7OR9W1W1+NVQUNmt7rX+2szIRV2YhTw3D/4lc/nvq4YVdU58yulHavHo2+BKcWPTOkLlZxtHiI3sSHveWQNdhohZsM4+LmwtRT5rUwGGxOX/6yjP1yHJ0e11cG4oATV+p0Oqz7VyCwz9FxKN++AvDGKLORRO6IbuUeTNIQL3l+EZS4v1cC2lzS78xBWyLtb2y8hr6hwxNWgS0Awxm/dyOP23UH6NoCQtrf5SOKdFPCAhAgKq2EcqaR9qmsxgV3ULFvmFmh3FkqCIKsE0U9um2M4+3+Jl++M+6w+hTTvOeBC+nqRyPby1TG5IPDgxCKNleE1DwahXhJ7vpxq4wO9/xBWj0urkPwC6bNOTEx/JjDfkrs6zYneN1tLr8FYiPZUWN1WmQsoxi8OPl+bp/kVrZDvrqoalznu0K8KQu3Kzg/x+8mo+J9XLF6nNAaOgckD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6512007)(26005)(186003)(4326008)(66476007)(31686004)(66556008)(8936002)(8676002)(66946007)(5660300002)(36756003)(2906002)(316002)(6506007)(6486002)(508600001)(31696002)(38100700002)(86362001)(53546011)(6666004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjhwaXZrV3pBcUhoaDkzQnNUT3ZIRllQQzhRZWtTNFBXNEd3Qk53Q1VkRzhz?=
 =?utf-8?B?ZXM4a281WjAralYvUDV0d3lZKzI2U2ZmV2dxUkRNV2ZVV1NUOXpHbzYxU1Nv?=
 =?utf-8?B?cytyUjQ0YUxDVXN1YVVFQytySVVMWUU5N1VFY2YxNk9RUjRlcUkvSU1kSVN3?=
 =?utf-8?B?eDJpMkF2VDFxLzZ6WTBDYk1uSU44cmJPb0FkQUVIUHl1K3BZc0FYZ2M3V2V1?=
 =?utf-8?B?U0tPMEVqK2pqWFN6MjMvYnZwY0wydEc3U3F6ME9ndk0xRy9MZU03ZmxVYzZw?=
 =?utf-8?B?aFF4VHFuQ1ZUektIdmtoRFNKZ0lKR3NVVFRGMVZQUGVnTlJBcnlwOGNodk9T?=
 =?utf-8?B?NDdvamc5VXlwQmVHL0pud1RyS1FydUlmaGJmSnpVbk9weXdnankrNy9tcUJl?=
 =?utf-8?B?T1BJRDVOTkg1ak5DV2tMbXJlV0RmWG51ejVXeDVqSmpYK0lEMWY5cUZIY2VF?=
 =?utf-8?B?OTlMU2c4SWNyTnJNVVJqTzBaOXlkMFl3d0JxYkE2SG5HOC81NFBXc0NaczhX?=
 =?utf-8?B?YnNnTlJta3hIQWwrRUhhRURWc2ViOEhIVGcyWUdHSHVocjRpUFNRak9OODdW?=
 =?utf-8?B?RGE4amRpdFd3UVRYbE54VldTS0FyZTF0RHNKV1A4K0FEUUtlRzQwL2lJUFFp?=
 =?utf-8?B?TC9uU1c3U3E2U1pzUEt1RnM1L3lzeE9VUmwwdnEwSlZGMFRhVUZldklVMGky?=
 =?utf-8?B?ZEp6QU9VamlRT2U4MUhrZTRPTm05ZWRUVk84Y0kzT25xWkczN2owSmdFWGY0?=
 =?utf-8?B?TW1yYmNhN3NNSVB0MHVvL3VMTDIrOVhZSkQvbHVQZFhjNk8rVEpHVlVIeUIz?=
 =?utf-8?B?ejhJRm5VcDVtRnk5VGxJOUVKTlI2Y0lqTjBUY0FPL0VqdXFlMS9CSHBwTFNt?=
 =?utf-8?B?VlZOeUdFeWFFWWR2MU5iSUVwajdQUzlUVmF2Nmh3Mk8rd2hWcjBFSDNyZG12?=
 =?utf-8?B?R2U5QW1yNVBWb2h1a0hvRXpnZWRrckFESkQ3bTgyZW5RSE5pUjJjY1RYMkVh?=
 =?utf-8?B?cTZFcklqRUJJSjZZNE94RFUzMjBZYXQ1aGlwMHJOejNNL3dWc2hDbDdjSXdh?=
 =?utf-8?B?dHUvT21nWEVHaGxFRWo2M3NhT1d6clpzdW9sQjc3SlhvTVZPZkwzL2hzWFBD?=
 =?utf-8?B?VlliYWtUUVRVNGdYc3ZSL1JsOFpKWi9uMEhZWVd5a3U0WFRvbi8rZW1lVTFF?=
 =?utf-8?B?VmdvV1JXNFp5MWFFc1JHOHY0Yjg3VFU1aWxSWGNoMWt3TU1ZSmUwdkp0bDVi?=
 =?utf-8?B?UlhTVG5ZL2lPZGFwUDlIN1NsRkppV2R4S0hycUJRWG5hUFhpck8xVWV1NU5E?=
 =?utf-8?B?MzJpOXM5MllUYTV1cWtmM0plU1VpSkxrdk13dEhjQnhNemErMHJNaW10bEtL?=
 =?utf-8?B?OGViY3Y1U3ErNURDVDNRVzE5dGFpRlJKVVBLU2NWQmZOcDR6a21IV3ZCaVhJ?=
 =?utf-8?B?OVF4S3pCeHdjallBdEowTkp0Z1YvSTN1OVBkYnpZaUFsdTN1cmtCQi9VUjl3?=
 =?utf-8?B?SXBsT1Vyc3duOUdNeTFERFpBQlVhdGlnMEtCRHJaR1ZDajRXOFlQK0xHKzVV?=
 =?utf-8?B?RE5aSE5GVEtranVnN29YeU9LajlFZXRoaUZDZS9QdE9Da1luK3RBcll0Tmpy?=
 =?utf-8?B?K1NhcVRRVkdUbDNsSmtTMWhDREJUVm9lQlQvYk5OeG5qWjFVbU9rTytNRHls?=
 =?utf-8?B?M0lWdnBzaGEzMDE0bnVXeEFrcGwrRnF6TnhzOU1wUi9yY25MOGlOWnhpd1Rp?=
 =?utf-8?B?OWNxN2k2RkV6bWNtdXpSWm9SYkl0aGRLamwzdTMrTnd4SFpRdnhnM2FQTE5I?=
 =?utf-8?B?RjczVDNOVEY3b3AyRVc3Yy9vKzlkUGlHR0xjblh1am1nYW5DOXIxN1lWTmQz?=
 =?utf-8?B?b2pVcml2SXR2T21hWEpsL2FIVHpURmd5eDI0Zi9yYThtU09RTURERkc1VWlF?=
 =?utf-8?B?bjhUb3k0YjNLTS9Oa2Zkd1RFYUxZaUV1WlNLdWRKUlN1aW52RnRlNXNpVlV2?=
 =?utf-8?B?ODNHaDNjWUw1TTNvdWhJdFcxdHhBekc1bDdnNlgwdFdPUlNyZ3ZPRVM4N0xU?=
 =?utf-8?B?QmVNMUZrTGt6VnFPcTVhWHgraDlSUlVxWW1nT2haYkxiNWxURjhua212RU9Y?=
 =?utf-8?B?ZFArZUJOaWhTVjlUdWtqcUpWZnlZbEVieklsNG12RG9aWk53Titid3BaQ0ww?=
 =?utf-8?B?NDJUbzlsdzhjQ1BMbGlSTGJ0eElEM05FQ0k2SlVLTXRwWFBCdkRLNW5INGpY?=
 =?utf-8?B?OWZMd2J3Qlh4VS9EN1V4cGtYSFFuT05mdmNxTUxvNDJqeEQ0RjRQbFJqUFU2?=
 =?utf-8?B?NHhNL3ZSTm5hNlpwZi9nOFY0SmRuOFcxVk1PS0U4MHhkUmlyYkV3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a158a580-8918-4f6c-240e-08da33457922
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 11:57:50.7980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj9/H5Rh7uKmQn9MrdNIlbtc6nLb+psK7DLeBDomqbyeuCb94/i6VLtM0RxJYXIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 5:16 PM, Sathishkumar S wrote:
> smartshift apu and dgpu power boost are reported as percentage
> with respect to their power limits. adjust the units of power before
> calculating the percentage of boost.
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 60 ++++++++++++++-----
>   1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e2d099409123..35fbeb72c05c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -276,6 +276,40 @@ static int yellow_carp_mode2_reset(struct smu_context *smu)
>   	return yellow_carp_mode_reset(smu, SMU_RESET_MODE_2);
>   }
>   
> +
> +static void yellow_carp_get_ss_power_percent(SmuMetrics_t *metrics,
> +					uint32_t *apu_percent, uint32_t *dgpu_percent)
> +{
> +	uint32_t apu_boost = 0;
> +	uint32_t dgpu_boost = 0;
> +	uint16_t apu_limit = 0;
> +	uint16_t dgpu_limit = 0;
> +	uint16_t apu_power = 0;
> +	uint16_t dgpu_power = 0;
> +
> +	apu_power = metrics->ApuPower/1000;
> +	apu_limit = metrics->StapmOpnLimit;
> +	if (apu_power > apu_limit && apu_limit != 0)
> +		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
> +	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
> +
> +	dgpu_power = metrics->dGpuPower/1000;

Before submitting (not expecting another version here), may add a 
comment that APU/dGPU power values are reported in milli Watts and STAPM 
power limits in Watts.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	if (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)
> +		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOpnLimit;
> +	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
> +		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
> +	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
> +
> +	if (dgpu_boost >= apu_boost)
> +		apu_boost = 0;
> +	else
> +		dgpu_boost = 0;
> +
> +	*apu_percent = apu_boost;
> +	*dgpu_percent = dgpu_boost;
> +
> +}
> +
>   static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   							MetricsMember_t member,
>   							uint32_t *value)
> @@ -284,6 +318,8 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
> +	uint32_t apu_percent = 0;
> +	uint32_t dgpu_percent = 0;
>   
>   	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>   	if (ret)
> @@ -332,26 +368,18 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->Voltage[1];
>   		break;
>   	case METRICS_SS_APU_SHARE:
> -		/* return the percentage of APU power with respect to APU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> +		/* return the percentage of APU power boost
> +		 * with respect to APU's power limit.
>   		 */
> -		if (metrics->StapmOpnLimit > 0)
> -			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
> -		else
> -			*value = 0;
> +		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = apu_percent;
>   		break;
>   	case METRICS_SS_DGPU_SHARE:
> -		/* return the percentage of dGPU power with respect to dGPU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> +		/* return the percentage of dGPU power boost
> +		 * with respect to dGPU's power limit.
>   		 */
> -		if ((metrics->dGpuPower > 0) &&
> -		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
> -			*value = (metrics->dGpuPower * 100) /
> -				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
> -		else
> -			*value = 0;
> +		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = dgpu_percent;
>   		break;
>   	default:
>   		*value = UINT_MAX;
> 
