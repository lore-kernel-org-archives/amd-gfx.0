Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A97C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 13:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6594892CA;
	Wed, 31 Jul 2024 13:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0m+GB7TX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D9F892CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 13:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUkJEyWUxLIKsrCP94ueHkuJyUvS9THGtpDRxpRVybSIj39rf7AvfJil/2JF0sYuzDbFNcFr2vXNnUNfMe/t5QBJzGX8sBhUy1FacFr/VhmytPj78wbmMnqfluvaS6pmSux5jnyL2t0/D4GwyGmF/chaayAfTlZ4rnwDCJxUWOqii2Q7U5O8j/66uJyNpr2kIoNogHJX2ApmAJSuH7XvosWuTXP1GBcIk5ZJj7uoiIV7NZEJ5066P7V4rqeHJbaSbU5LBJY3Brl8QmACRZu/ElCn2RufW7GD4oHEJjZHj+w/MykLPymbuc03DxxeubJM+z5xYcFRoTY6G4v3jp6UtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI49bnLbCeDbLqMv8jKmLfNhFUjyCEns+GVL1KO13t0=;
 b=pJ4cGu+6xyTeVAMa07dKvze3SHFHSpdxEBhP+NTLCXzGzQFImfpVk2w/9lK1BvhTovdcumyvNP6MCeawptWl+N4gWBXYtaO1TeWEJzT/Yr8TJnfxMcdyVP/gfdeaMeu87xXNLUOvh04skneq8U1jdtEOPysYwuDRot799Nz7e1zrcSe5Vpmgub2QS2KUCAei9kwU7eW6T7YlvKDRTyRmaEZk9emGDTB1UtStfvisQWn8qGW0mlly7lY4h/ptCytAsvXUzVQtBZ3h9Rig6r9mmaLLPJOjdO0XRKC5IY+vUILGHacQKiym1KGfVAIuWB4NfYtKAOyG9CMHvKpARV+lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI49bnLbCeDbLqMv8jKmLfNhFUjyCEns+GVL1KO13t0=;
 b=0m+GB7TXfHQfj+5jBDoLTqzJSBxLGqBoxt1I42+T+PKHWdkiHlu4j5qxMI14ZtfPNUXUejqg9ci9WAUats8HZwKXXwYfeYObLZInTW1GflfDzYgesNbMykhX//zExNu34P0frw+jY9iHCqhFvFMGDh+xBUyN7GTn0MAWZjqxwII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 13:31:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:31:18 +0000
Message-ID: <92c3bb8c-c8f8-4445-8f01-822ab14e450b@amd.com>
Date: Wed, 31 Jul 2024 19:01:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: report bad status in GPU recovery
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240731100526.32903-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240731100526.32903-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de2fb20-b2ec-447e-abc3-08dcb1650ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW5rNHFjd0N6YzN3Qnh6V1ByNGZERURWbmcwQlZqWmlkemdnL1E1djhLa3Nu?=
 =?utf-8?B?YkdSdFBObHhtVGE5VTlWaFJIM0RDQm11ZFU2QnNJOVA0R2x0RTJJU0dwRXNj?=
 =?utf-8?B?M1dGTXVUWTVLZFgvbFQ3VlYvZzJxOTYxQTcyQ1JBSk5xWmlJam9Wd3Q1eE02?=
 =?utf-8?B?aWxwRGpMWEhUQVNGc0xlMmFSMDA3TkRsaDB3NWtONFFHN1FiTXNxZVY5ak5m?=
 =?utf-8?B?UDU5dHZDT2hLcHg5SjF1c0MxTDNkR01nL1VPakVib2pqSWkwK2pmZEJrQjMz?=
 =?utf-8?B?OGNSSzY2anU4L24xbHp5R0R3MHNtc3ZFMGR3ckhCNFc4TUhienQvdzVBcWFz?=
 =?utf-8?B?bUg3UXJqQXV4K3hYVUtGcml2Rmd3UFR2L2dkZ28rSndsY0ZlVVk4SmRMaWx4?=
 =?utf-8?B?dW4wY1BpTk4xT0hseUZsR1JQMjlJdHFOMmpPaWpHNUVLbWRaSG9ZTXdGTUwz?=
 =?utf-8?B?QXNoM00yalFiQkNyN05BV0NmVmxxMm16dklvbWR3Z3R6aHNkeHFRdWJRdzlw?=
 =?utf-8?B?SHFPV3hQREVjeUJrN2YyWHk0MG8rZTdZVUtnUkhuZ2hTV3RuWktIS1MvcUU1?=
 =?utf-8?B?SVJPeW5XYU9xSHh0YXBYMXI0RXpTMVJBR29sQ1RkbWFHTmZrNjdrL09acTUr?=
 =?utf-8?B?YThlWGM2anRneThyaGNaQWVOSjg0c0NQeU56bzRPYS9SdmE5RFk2cmVOTEli?=
 =?utf-8?B?Vld0OXp1MjFFTlY5dC91R3NMdytFdmRDQ1h2UmtFZWFxa2ljY2NiY012SVd5?=
 =?utf-8?B?dFhNWUJhbThKRjBtZGVOWm53M0RJcXBnNS9UaXZ0SjB6Vm4zNXJtTnY4aWRB?=
 =?utf-8?B?OWh4SHQ4RHJJYjhsaHcrR1UzTFpCMTZNRm45VUxFYUFlQUdNaWMvdGl3NlBP?=
 =?utf-8?B?akR0N0FXcVlWYmJSeDV0d3FwS1RFSUY5TG5adW90Vko5MEt6aDNiUS9sT0Zr?=
 =?utf-8?B?YXNDN0xrL2VHSnJtc2Yxa3I0aUNwenZJRmI2a1IrRFVVU0xWOEVoSnplSm9y?=
 =?utf-8?B?T3FVTEUycXAzT3RiVGo4TjZxZ21TakxhYWxPdFNFb0xoNUd1b3Z6Z2xFZDl1?=
 =?utf-8?B?bFNOSHFQTGswSkN6Y0oxODB2MTlYZTJ5US82SkNtbEpaNDZUdGpqQUdPeXBJ?=
 =?utf-8?B?SlE4QTNNNk0zY1BMdm1VUDVYcXRKMVNoSngxMHFkQ1ZrUFpRUmU2NEFGYktT?=
 =?utf-8?B?U0R5NjdWS09vSHJXZENOOXZ0eGVHR3YxMGRsZ2VaRzlSVXRqS0ZzemQ0N1lH?=
 =?utf-8?B?VUJHMGhvbGpha3lyMHVOQmtEMVhkM0UyMWZqZCsrZDAwSTM2NHlLSHNWZVpj?=
 =?utf-8?B?eGdnaWRydFBnZzlxYmZQTStSWEtQRlpzUE1CUWx4RThlTjRlTExSSGlyY29N?=
 =?utf-8?B?OXV0UVBUallXOFVUUFR3YUE4QmV2aEZZT2FSb1RTOU9xRThYM2RpT1M5NTR2?=
 =?utf-8?B?eXIxOG9idjJ3cEN5L0piR0l5dk1zUm0vZ25GanlYalRNdnhmZzNJYWZhMk9Q?=
 =?utf-8?B?TlliZWJxZkJ1aFU1T2sxZnJ5cHBObGlYUWIybmViKytOdXFlNU5ueXVPMHd5?=
 =?utf-8?B?ZFdkYmgvbS9PZmRTSEJDL0podEFzaGg2ZEx6M0k0Q1hqT0NQaWFPWnFCR2JU?=
 =?utf-8?B?K1NDbG9kakRRZEtGeWEzbnljV1IvRWc0dWZycVdWZ0hrNXlWYWR4ak9QQ0JX?=
 =?utf-8?B?TTYwRE15Qjd5eWpHNTFBTjZQZXVabnVabkhpRWdXcXJjNy9tK1BzWEJnZHF1?=
 =?utf-8?B?UEgySDdrTDQ2b3prU3NiSWUvQjVxdFRnVVBUMWYzQk9ZcW53ZXk4NHc0aE9r?=
 =?utf-8?B?SFFsZ3M0emVZdjhZTkQrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpFcDR2RkxkK1RGTXRtRG4zVVpoejBBUHNXczdMRVFZR05OZlV4cWFvV3ZY?=
 =?utf-8?B?Rm1SRDBmWTM2RXd5RVVnVENDa0VVeXg4TEh5aEt0bmhKTTN0RGY2NHkyaFBB?=
 =?utf-8?B?MDlHdDZiNm9TMURBV2M1c0hWVDJQa2U2QTFGYm10VjdvYllIZlFkQmszR0Y4?=
 =?utf-8?B?bmI1U21rZERZa3ZVdzBKRWEvZGI0UWdWRjRuTUthTHR5UWY4a09aNzY2U0Fh?=
 =?utf-8?B?dks0L2ozZVdNd1JPRmpWYjU3UEt5V1RYZ3Z5T0x2RzJ0ejFPdzJPL0NlRGNR?=
 =?utf-8?B?K0NNdndVd2NhSVpER09yenFJWkVLRlcxZVlwNVVTc09uM2UvdDQ0WkJSSzAr?=
 =?utf-8?B?blo1YjhPZGNKcnE0MFB5UmgvNHpRdmV0QlZvZmVUOWZGajhobVlzNVBGaWl2?=
 =?utf-8?B?Mk5idGxiK3NYUVAybkFrejhXZVZWNmRxMHBGdHluQUxFeWM2Z0ZzeFkxOExC?=
 =?utf-8?B?ODBqcW0reHBmR0g5Sm1NUzYrV3RpRG1kcHYyQTZCZThyWDZkQWJzbVVHQVI3?=
 =?utf-8?B?M2Q0OWYwSWxEYmtPYmd6WkZjd0xRYmlFLzczVHVIc1NTbXQyb0JzY1FoM2dp?=
 =?utf-8?B?d1BnQ25hSEgxS1Fha2VkUkZ1T29BTnVhNS9FQWY2ZzJzMXpjRHlub1FoaDI0?=
 =?utf-8?B?aHI1NDJ4Z3Jud25SelVWK0xZSE0vU2F4UGNEd0FETW1Sa1BOTklkcUlIYk9o?=
 =?utf-8?B?dUprR05JbVN6S0VlUitzNHFrcVdqU1N1SzBycFQwT0Q1enRSL2tGbTdPUG55?=
 =?utf-8?B?S0xPNnYyaXJ2MVp6Z29mUW15cHFWZGRwVTVVTjVpMTU5Y2FFODR0dTVVTDdE?=
 =?utf-8?B?WjZSWTVxOHIycnZHb2FWZmU3ODZuQzR2RXAzakdaaDVmbkRpc3RMVEhsRkE2?=
 =?utf-8?B?SDhmTitZSzdNNzUvTDVadzFsMi8ybGFOcENBYXNiTXRGSlAzeEdiRkxvay9E?=
 =?utf-8?B?d1NPbjk5QjRJRW5OZEVzZ0tmTjhPUFU5V2NpWStiaXA1Rm5ReWFMQmtiQmdC?=
 =?utf-8?B?RHBBeG5UUzgyY1lVVW1oZHArdXNFV24vbUJoN0hmanVuclN5MUpaVWFSaEdM?=
 =?utf-8?B?ZDZWUEFndmJIMmpWVTBOQyt0VWRnUEc1U2FNV21KV0d0WWZVbW9VMXQyWEt1?=
 =?utf-8?B?TnJFYmlCSDFqN1d5ODBCY2t6b2JodlUxZjFUL2VFakt4OExTcDZZcGxYaFV3?=
 =?utf-8?B?TGZValp2RWMwRk5KeHBrSkU0cjlISk9QbjNMRDlGT2dhM2tCSWo5UkxlNDd6?=
 =?utf-8?B?ZUNlSGo5ekZvcWtudWRtaThWWktsbEZFT1RTdENuTmdETnBoU0Ryc3IrRHgw?=
 =?utf-8?B?dXIrWEFKZGJQN2pRYkhwejcvamUvRDZGcWszYVdrOGU5SElOYzhDRmtMU0tQ?=
 =?utf-8?B?aTZld0lUbE5iT2dqWDg1MVhZL0tscU92c241UGs0c24yYi9zN1luSW5tVGM5?=
 =?utf-8?B?RUt6SWZtZ0EvaHA5cmxtWDJiUldlcHRLM0k0YkhseEF3blFmeDRCalFyeVlS?=
 =?utf-8?B?Sm5CZzFYbUp2dHZPMkVjNVQ0M2VqWGZHWnR6UkdiWW1WbU1INmtxandEaTFE?=
 =?utf-8?B?WlArZkJEZUhmVFNraFRzSGNpYlR6RExMU1pLZzhpRm1xTUUwMU1TS0VtWmZM?=
 =?utf-8?B?R2JRb21Nc0hQWjZrQVhXcVpDTTdDTEREemRFRmFVUk1pQStLdS8xN1JlYXpm?=
 =?utf-8?B?c1NRRFpQTDRPbVNWVU9CVkZDRzI0THdSSnZZL0t0OHp5cVNqNkpDUkZQd3U2?=
 =?utf-8?B?MnVad3pweUJrV3BRN0wxUENxbHQxei9QY2dydVZYaXVsUkdtQThyVDh3R25y?=
 =?utf-8?B?V2c4TmdXbDJMSlV4YXJlV2ltRUdZb1JNcHpxSllnSU9rWWFwRTlueGNuREVW?=
 =?utf-8?B?SU56SE5KSUg1aDdsQ3I0dG9oaXNuaGdOUlV0Qkk3TmozT3pCVXZVWGZsNmZK?=
 =?utf-8?B?akxIMUIrQzhjL1c4L3g5R0pCK1VBbUhVaDMzb1JZd252MS95MjVCRGRjUDdP?=
 =?utf-8?B?UkM0STFJYlZIeXdEWloya0Z1a1BTVlVlYWJXd3Y5d2pUY00vdmc4RXlLcDVT?=
 =?utf-8?B?RnQrZjZ3SWFxeUwrNTh5SytUckNQekl0NkppelErWDVQcW1JMVJac1lRdURG?=
 =?utf-8?Q?YJ1JB9whtArhPM1zgZshE78dx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de2fb20-b2ec-447e-abc3-08dcb1650ee7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:31:18.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHW/JpY3ktdmu4zfhZLNv1FGEaNnlbq4yL+zDzGhXht0vFljB2oOyzKoaoaOno7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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



On 7/31/2024 3:35 PM, Tao Zhou wrote:
> Instead of printing GPU reset failed.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 355c2478c4b6..b7c967779b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		tmp_adev->asic_reset_res = 0;
>  
>  		if (r) {
> -			/* bad news, how to tell it to userspace ? */
> -			dev_info(tmp_adev->dev, "GPU reset(%d) failed\n", atomic_read(&tmp_adev->gpu_reset_counter));
> +			/* bad news, how to tell it to userspace ?
> +			 * for ras error, we should report GPU bad status instead of
> +			 * reset failure
> +			 */
> +			if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
> +				dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
> +					atomic_read(&tmp_adev->gpu_reset_counter));

Better to check reset_context.src == AMDGPU_RESET_SRC_RAS to confirm
that the reset is indeed triggered due to ras error.

Thanks,
Lijo

>  			amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>  		} else {
>  			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
