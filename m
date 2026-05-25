Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDACDCD5BDD
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663DC10E29B;
	Mon, 25 May 2026 11:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rO3g/mXc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535B810E29B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/W10NiSgBDCRhssvjubQzi1q46mqbHtZu2LYqD7mz6Bb3k6tHkeoHJPpFdorI+XaLepqxSgmvNou5UeDzVff0/3W5Hka87S4k3Reg46tR2fDf8IrfYzvItNXgAVfNVdXDC5HL0NTw/MIYWXgd7NsAPi6mbLnpMUzAmvhqfaL3bZOXWx5+5KvQSHHHENASlE/LOpeInKTnQh2N6YwdZL70qIj1jcj6xW5+tpsCLONlrzBQZ9kw2hL820eP+lVuPoYJB+5ZfN2dKIYs14Zo3WO1L5euoYlOKOo6526Fl3MFQEEPWkHHFbAJu2S/lFr2DFDCUTEEYUGSWlpDqSgIum7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxcYnrX+P3NgtusWXuPidTgDOoezlI8vMwhgwYVBADY=;
 b=gn99zJ2m2bOM6chhCLbI4JyCnLIR6cWj6habpqndEB1/kGWGdPPTSNq4aVVnmmCAAU8bVcWyl/N4jP5LcPurT4QpstGytEHXl2/TsBKLprVXdQPPk8CC3kxJyjV97sM/Nqo1Fm/6qEvTQPle/xri+7xG5oMMj741CcOncTT4O0LoT+WPXhEZp+Q1LhlGB3j+kmHcQnmu5OIcTTZ+V4yv3boUasPI0hA/EAm/fbRNPPsj1mSvjcWHdccxr/yXgid+EhTNlzC0L7iDqzYyS6fERuKqhBSHyTbgeXZ42UhOOExuNqYGCB9qnmBgNAoeXhSfgMz5+eA4RtznFhbN82f+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxcYnrX+P3NgtusWXuPidTgDOoezlI8vMwhgwYVBADY=;
 b=rO3g/mXc6X9AjUMsSmY4odfyin9SrTYWGhkd9l1qSiCA2jXs2yqoPimiMjulEJ9vevr0GqveazS4LR+6fONodbou8CC4breubUwqHoslKIRiZTMB92CPSjVx8wsWs6q9CdhHud8E0uEQOTGbck26tsRlfxTrsG3N3FPZ/xnTy4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:33:27 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 11:33:26 +0000
Message-ID: <7ed3332e-af9f-461f-a9f7-3be4416c7c9e@amd.com>
Date: Mon, 25 May 2026 17:03:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: change the vital queue unmap log to dbg
 log
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260525075237.244883-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260525075237.244883-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::17) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa3ba97-38ae-4010-7e8b-08deba516f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zXwNgKYUjL95x2rQnVLc7JYmwpQbmFnzvBA6jiaW381bNQGOflupYECtypujhk4+yvBz7bxmnXe+t/YWlm/JY/m6B6ZLLt8Xh/+U2CUTnhHpgjzJc4gRSjIO8q7e6EelurHL/KYGm0CY/Bb5kxr3S4ItRLruoibpafX+i7D3OKKZKRYNXLjcR+4QopUfne0M8h/bUvD1+0nNe8tHwG68QkkhZFGFZXrzTnkLjj6G2UiH64tMBPiY5ze3LTj1fGtb+zd4Sh9Vl59nExLaz0hKhSIOpGNLwdXAQSxFRWvWcM2haeAhvv3z7YKQ8kfX7wlZ/B3XJ2vVUOGB2rB5VfP97daBJLd10WC1HfUwLPAwSIk0JmAyN7SpD2ewnY/rQ8wA1f4qclQxB88qkE2rWirGgD+grOYBQvs1SdB5gFFx8KUvGL00XIzUEgACsQO8/GY60TMYaTWhwBg7JOhaTFDoKaRvgdYo7BmD8+sE2pI+ISMaRELQfAZfQAbXPViUKoSLqzU3kOYfDDlL7hWBavg9HySqVqKVzawRjKGD0FRXYoIqhobj+6ixyWTZiblvWupueD49nvgCyzeIXS90/kLKzG/F+33Syo6BKrJgfk5rQCFmlvMPw5IiUxQSOFv3V/2tC5hksRejrFsxvQm0wGK2LobTmR1HDTAEfvOwB/Gtu0RVS/WF9zAyFxL0tXh49lhb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0k3Vi91Mzl0TkovTEFmYi9mV3VxU0FERUV0azN5cTVjeXY4dnBidDhBMWxL?=
 =?utf-8?B?aWxMVm8vYjJWcDBPaHg0ZU5BMGU4cHRPT2VtUXFYTEQ0SmZCb00xZEVsRUhz?=
 =?utf-8?B?dzl3R2NSVmxRN0JvT0FTV25lMVpNdnltZXNLVTdpMnV1NzZYNnNNNnRZc1oz?=
 =?utf-8?B?ZmJiWTYwanFWcVpOenozNlRpWDVxd2MvbFhUeFJpcWwyOTg3OTIxcEZmL25C?=
 =?utf-8?B?YmdTNE5IOTZsb0phNVRQRnhNRXE5MDZWOE5sSXB3OWFVSENLRFpLOVJqekVq?=
 =?utf-8?B?RWx0UzUxT1lEV1lRUTBncThzeXJJbVBmQ3JUTzZMSUVkcG9XblREOFRzMlZr?=
 =?utf-8?B?UUF5azk1YWJSOFIzVkVPOS9EK0JBdnVwU1lHMmw5R2JaejNoY2VOeUlTYU1T?=
 =?utf-8?B?WnpXYkZNWlRkSXJxdzBhZ0dEdmJQZUUyRHVhYS92cGYzelBPYUNxM3cxck9K?=
 =?utf-8?B?WklveXpSMzdYODJna2x0Q0VhVGowRWIzNzE3RzJkcndONnN1OS9IaTI1RFBS?=
 =?utf-8?B?NC9teUVxL1ZGamo3cVkvYXh1U0tMYVA1eHF1MkVRMEZHOTRlZ1R5dTUyYWNO?=
 =?utf-8?B?T1BZdHZhZW1DcVFpeVd6MWVCS2U5UUFOdTFuZ1ovS05wckRLRUdJdmxpQjNU?=
 =?utf-8?B?WlB5d1A0eUFXL0k2U1BnMS81Z3dmR291RnlxZjRkQTBiWXhIN29hZHNFVDdp?=
 =?utf-8?B?TEZBS1B3TjU5NlRPTFRkSUJLcWl5b0p3U2x0aVdrczMwNEpsZFlPbGIyWmtm?=
 =?utf-8?B?dXQycUlRSEpqK0UxcHpMSTFzNndnbTR0MW1GZnVhQ2E4QzNPejlVblQ5b3FD?=
 =?utf-8?B?d2pZOXhlb1ZEZU5ydFA1UWVwa2xrUXU1eHJoanl1TWRBTWRic1hIa2s1M0da?=
 =?utf-8?B?WXkxSkdhK2pvUXpBeSt5V000QytQT25QaXZuOWJZaStUUEI4Y3B5aVJwdnMw?=
 =?utf-8?B?VVpXdXBGazFxclRXZHA4bjBLUmxDQnN6TUlCMGFRdUM5bXJnSXJ2NVhBOURG?=
 =?utf-8?B?akdpc3Q3TGlaWTViandYRjZaeFU2Q0poNDBjd25kWmhYQnlpeWxBOWFpVlR0?=
 =?utf-8?B?UDU2SlF5eU4vemZnNlJLbC9qaFUwQVlwWlhIWkYwNkw3aWlEVG03ZDlrK0k4?=
 =?utf-8?B?ZWgvdVhhNjIzcEhtVXNZTGVhYWRkem1oRzdEL2ROTlBXdEdLTDcrLzNseDY0?=
 =?utf-8?B?OUNzYUQzWDZ4aTl4WnZCM3Ayd1BlSmg3dlVWdXJEeWZYR0tFcHQrdm10UFJW?=
 =?utf-8?B?amZQcWthVC9mYy9nK3liZzZZN2lzTlVOOHYxTzBKVC83TldpSlBoYTZaWGZp?=
 =?utf-8?B?aE1zMWZCcWUvTUpEVi9ERkMzV2s2YTY1bHkxeElQaWo0RWgwYVNqWW5iNFBu?=
 =?utf-8?B?NlBIdkFqVTNYMEtRMnVMNHZYc0JQODZ1RWpRajE3MFQ3VVR5NXo1Nm1XMEpp?=
 =?utf-8?B?UTFDUFBLUUYyZXJiU0tGNEhnWlBKWmIyVGswbUFlNGVMUHdrNS9ZM3hmZ2xF?=
 =?utf-8?B?OXJvWmcxV3NGQk4zUkRXajMyWHBkU2tWV2NZVzNaNzJ6ZW9JZkdCYXMvODM3?=
 =?utf-8?B?T1pBd1A4V2RpR1hPRm5rYXRFcDVQQXp3SklVbncyWlRGdVh4L3BUZUd3eEhi?=
 =?utf-8?B?TklvUllIQTIrZ1ZaRU5FZm45dlE0Tm9TL2tIaTVNbWlIZnFHaDRMbXJVOU04?=
 =?utf-8?B?VERMa3VuNlpxQWJnejRxOHdPMjZIL21Tdjc5WU5wM1g1aG1MbE5OMmtrdDdw?=
 =?utf-8?B?RFYwS0Fxam16TmFBd3hqTUxsaVBaUm5IVElRaU5LZERaK2VWbElZeHpRUE9V?=
 =?utf-8?B?dnpWRUlaK3JKS2ppZ3c3REp4TWxONFJSdTFMN2dCMnBNeUVHNDJKdlZvU21F?=
 =?utf-8?B?YXYwVmVEbDZ6UkswOVFEcUtNTURCQ0d3TXpTbGIyTTRleXE2dDZGTlRqenpT?=
 =?utf-8?B?N2krUUhnNmljM3RoTFVOWkZuQkhNSXVPdmt6SHU2VmNJYmdXM3ZBVlM4ZGZz?=
 =?utf-8?B?VWltZWRCbU1KUVdUczdtbGt5VVRUUWY4aW9XRC9QRzNSbjNvN0NURFUrcVVl?=
 =?utf-8?B?V2RDUlpDc1NIeHRSMGR3S3h4L0VPam5tdWFSS3Vxdng4bzI5Umk1aUhCbUhM?=
 =?utf-8?B?eHBUV2M3ZWc1VVhBNVRob2pVcWVhUHJxREw0dDNRYktpQThTMDdmQVkvMnpG?=
 =?utf-8?B?UXJZRUsvSlJiWE56bVF3MjNUZTlHN1RlMDdlMDRnVVFFK2gvM2dmemZrTVA0?=
 =?utf-8?B?eGYzckZHL083VHo5T3BETkhqeklSdW85a2ltWUhXSGIxa0JVRjY5MEN0NkJ1?=
 =?utf-8?B?SFdlaHQ3YXBwUmVxWjhVT3gwOGwzMStBWksyT0g5aTBBTnZ4anRjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa3ba97-38ae-4010-7e8b-08deba516f6f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:33:26.7989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBCR6ZTj4vw2vMXGuplINt3tquRpv4OBdTgucgtU1dEqnQklc4xnWfolQWuqKl7whmuV2oQM/FacrRUA+NVc6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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

Please Ignore this. Sending new patch with removing the log altogether.

On 25-05-2026 01:22 pm, Sunil Khatri wrote:
> we see this message once during boot and that's possibly due
> to one of the bo unmap called while the queue is going through
> tear down and we see this warning.
>
> Change this to debug only logging.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index f0c7b686f68d..0f2c00a37287 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1352,7 +1352,7 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>   	if (!ip_mask)
>   		return;
>   
> -	dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
> +	dev_dbg(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
>   	/**
>   	 * The userq VA mapping reservation should include the eviction fence,
>   	 * if the eviction fence can't signal successfully during unmapping,
