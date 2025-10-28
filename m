Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C54ECCF9EE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 12:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A484C10E3AD;
	Tue, 28 Oct 2025 12:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbP8tTYf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB74C10E3AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 12:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNIieN2CpGzNvejuvaCU4oHx4UvAxqNF74x4KoZCw7PNG7sQWp6+I5odVtzGyKf8/2p+Gu2B5POxebtDCiCBj5IpICOx8uZ+a/f3Dk4kGN14WIC0/os+QmopULshOm5RkrfHpbBCYBz6YcyIrAgDt+aMBrpK3eBQR524Uy6N33tsrwLYLosDo/Att0YffLUcU0EYlmxaEIh577Gr5DwTpQmJpRLWs5yzpkumLNHHmMVwj6Od3ULe5Z9dxXDJpiX7a0/CpWZ5WxkjUg60/Rwi7RlPB2L+6fw+E41B7UV1+PA4+RUSlyKP5n07Q4evSiZ8e0Ju0n2zMKFReqYGmn+kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHFyX9QSGyhQaYWSyn5EQ2ugJtE/WAqqzVDc0eUOs+k=;
 b=Pfhx3BIsaQT7/Nd+byUomhBUHJo9gCCMwn0UDKf4XfticmiesbNL4dZEnT+/Adgn630wzX1w7RY58autHVVIzKkuOC/xND9mCNX8mfzpcyrFTtqxsoaJr3THM4GBH2jhjbW9eyyY/xRFrvNWChofsphQ6Y6nk0oesmelG/JPirv4NxsjgpYq1nprgEqguHGbYClVrJ2M7/A2hTcyss6Qlfs2A8SQ5gCLgl/6D1n88hJsCEnOSn1CCgEgWXt4MQ7r/XJJ9Mz9D50qKNijfG5/RxqAahMvR7XwZqz/7qPPapu8CJPi0NyIxYvuqFr6LUcGMtC+ES4TXWwMaRzqaUCX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHFyX9QSGyhQaYWSyn5EQ2ugJtE/WAqqzVDc0eUOs+k=;
 b=bbP8tTYfv6oiQD+tUgZBRwnA+iEEq1RdzVB9TDrCWImNikQetAiSYyYwmypBDs29taoSAC70xScgyZ1T3CHlGquehOyjW4pL+OW3xqlfoOEZpB72ULMm17sEda8sV8bEmLTlW1T8EBNZxPqN+dSsI5iBYMKjFOSU2pb8otwAuyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::626) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 12:17:13 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 12:17:12 +0000
Message-ID: <744b864a-b657-4da8-b9ab-446e20e24083@amd.com>
Date: Tue, 28 Oct 2025 17:47:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdkfd: use function return value for clean exit
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251028082311.2841813-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20251028082311.2841813-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0077.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: d1db3852-8aba-4c16-7415-08de161becc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVFnUEdrc1BkalRNTHhKaHJpQjdQaEVpbDk3MHhyclpXaVVoZTQxcFQwVFhL?=
 =?utf-8?B?TklRSGNJdWg1MVcxVXZ5YTA1YzVISkwrcS8vWHhxUGErZ3hnaG15SytvRmJB?=
 =?utf-8?B?M2NqdVVVK2tNWFFxWVdrTW1hMHRFR2NuT3ZYRzJiRXAxeWNOTkFwVXB2RnVo?=
 =?utf-8?B?UElzdXVETlhqR01GOXZVa001N0tua2U5T0labHBPa0VHcTd2clQxbzNOQ0dr?=
 =?utf-8?B?aXdDQktZVEV1UFoxTGt4R0d6aHErWVlFTU1DaldPNHRWSkk4Sk42c0xwYWls?=
 =?utf-8?B?V3o1NzA5UVc2Zlo3ODRyN0M2Rng4cnNacy9KOFFOS09SSzgvOVVIMjVrNUta?=
 =?utf-8?B?Z2VUMm1seUtxWGlkL21BQmVOTEFncFF6OVlYSzl0eEd4L0lDdTBhdUtjcDlq?=
 =?utf-8?B?SWo0K0lSRE5xY1ZNV1pjbU1Dc3M3QzlWdDNWQThIc0Vka1hKU3dOZ3dtMjd6?=
 =?utf-8?B?QnpucnNLZmNJbnhseG9rd1VEaVh1Q3cvejlXRzQ1VGVLN2hKSU83d2V5TTBC?=
 =?utf-8?B?UEdNcVNNYUdwci8vdWx2RFRiVlBuSzBPSTVkNDEyUUx5cStwRitJenorLzBK?=
 =?utf-8?B?bm5VSXhnekJJTE1FMHg1TkZ0Y2pOaHFxeWVNczNnRXFhdkFPbTZpZXJlQkE1?=
 =?utf-8?B?aVZuZ3d1VGpTVGlXL1RRVlBJVERFTUtYbi8vUG84b3c5aWVkS1JLSlFncWVX?=
 =?utf-8?B?S0VpdFNUQS9GaUtDRmJhQmlNd0hwRnpxSmlla3VZZjR6WmQyeVBMekNyT3ht?=
 =?utf-8?B?bGJBK0V3T2RCdWdTRGEwcXpSVTcwVHBjUXpCN096aDNMUDZCaVE1Z3BWQmVX?=
 =?utf-8?B?MkFLS1hCL20zUjJ3RGYwZmZGNGg5VlI0UCtLU09JbWF5bGhqRDBBZlAxMXhO?=
 =?utf-8?B?ZE5Wa0RLQzB5N1BTaHd3OXE4MDU3S1pveG5PME5kenJtY2tTRWxHTmlVSVRL?=
 =?utf-8?B?L0xVSWwvd0VMYXc2TkFuZ2FlVHh3N0R6V1dENXU4TDNPUUNXRkMwcmF4Y1lZ?=
 =?utf-8?B?TmpyOVJGSzZ4V0Vxc0YxbmNzb0RGcStmQndBdndwWS9OYUlmbE8zcVp5bWFN?=
 =?utf-8?B?SHRRb0lMY0xmZ2tHOFB3eFlONm5RREh4WHdOVktpZzhEM2xPak91ZFd1OWxB?=
 =?utf-8?B?dkpZSlFlVGJpWVlQR1VxczJyZTA3eXFqUU9veXBLallTa0s3YnZQVC9ZZnlp?=
 =?utf-8?B?TVJ5TDF3WXRWZ2w2OUFSK1hXTC9WdC84aVZyaG1JNUFYOVV5dVZJYjFEODJU?=
 =?utf-8?B?aUdxWGNwcGpxSEo4T2xhbnVsNHQxakw0VFZMTXN2VnpsbnFIbmg1TndNSTRi?=
 =?utf-8?B?aEM1VjB5cHhQc2hBVmlCZDM0U0hZbDR0MWhhRHhSVFVETnQxdVRXd3pOZDcr?=
 =?utf-8?B?VG1McUhZMTV4ZkNHYmppNEdmaXJPTDVnNFRYOVNaZUhBWHRlWTN3STBBc3Ni?=
 =?utf-8?B?c3YvMUIyR2RiNFJ0eUpmZVZoaFZTT3YycmdZVWF3RFFlbDFBcU9vLzlPckdH?=
 =?utf-8?B?MGZhQkdUODdlWDNmNEcxU3drK0RtNDN2NzR1aVljcGNsZHduZmdYSHlwZ3Z0?=
 =?utf-8?B?NitzSU54Nkk3YXBMZ3ZVZUJBaDh1ODhoVzZBd0ZDbmtqMmlIMGlvbCtpdnlw?=
 =?utf-8?B?TlQybFFzZVRIQ3FaakNLZ1ZEVW5GTmlwbFJuTWVPTzJrc2NyMWg5WDk5Yy8r?=
 =?utf-8?B?bmRlNUR2WWpVNmFaeVNFcXdxZFNSaVhNd0paRTdLMFBNclhMK2U1Q3pBMm15?=
 =?utf-8?B?ZDBrNDhtNVFNeUloS1k2RGpvQTFUK1I0cUhHcVYxNGdsYVJjY2VSb096dDJw?=
 =?utf-8?B?YjVnWGsyQ3VtRjdITEtWYTJrZHJFRjJpVUVhYmVwNnBTN2tndkwrSTJRaDlw?=
 =?utf-8?B?NEc5MmV4bUx4SXFUYTIvVWlwZkx0dG0yRjRPa2o1dEVEU0hkR2wrTDRXVlpR?=
 =?utf-8?Q?KkLdkkruGfY9PNmjvsBtyYeiEhF7SUHP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGlHSjFnSUF2YUhQZzJEVWdxeXNIYVFTRzkvVXFVd3pNdnRwY0ZVQlM1OTQz?=
 =?utf-8?B?RWtxblJnNS9Vd08rcyt4cmdjRVFpSzQ0aXZ3cGYycWZ6Q0J1dWpNZndSQ1RY?=
 =?utf-8?B?TkdTOGZMdjZIQnJjOFNnUm5IbjJ5cHVQZ3ZiWUdPQUhudW5BTUZ4NDhrM2k5?=
 =?utf-8?B?WmZZek9hVGxUUktXaFBkUEVJRitzRHVHWlFyOGNINTl4Wm1qZ0l2K2lBSjQx?=
 =?utf-8?B?S1ovVVpsMEpWcFFYcXlDMm11ZDhVaWxZVitNNXNUYTkrRWNWb2ZQZjNjZ0dM?=
 =?utf-8?B?R2ZMam1BanBpMVV2OERoQzk0ZEl2cmtyYU1paHBQU2JZOXJqWjkxbkcwL1pu?=
 =?utf-8?B?R0FBRjlyYUd6dDVDY05vUTBrenRmNE9udHZTZmlqOXB6d0pZaGI5azdzUldh?=
 =?utf-8?B?R254c0dmYTNBNXNTaTJQS3dYM0lvYlVNRFlvY1ltb2RZLy85RnhaY01ra2E4?=
 =?utf-8?B?emtTRGNlTkxRV3dNMFlBbnVRYzc0b3hhd05lNTEyKzJHSkZ4MTVNcC9CZ2tl?=
 =?utf-8?B?YXJxMERLd0dFbmwzRTJhMWxGLzhlVUJGVStWZ2Iyc2RySlBCSG9jbjluc285?=
 =?utf-8?B?VFBCUFV4Tkx2ei9PcUpIbzc3Q2tQNGM4aXBaQXlEdTFzUWxEbjBvUXBlZmFX?=
 =?utf-8?B?SGVtRG9yTXgvWEJpMnpEbEY2ZmszaG5PdmUza1hsc0c1RzVtRDNJK0lJdStG?=
 =?utf-8?B?bHVMbDUwQkFwM2dVWnJmQS9qQzdjdzFoVCt2bHhnd3NHZUJoVUFrRDd6OEti?=
 =?utf-8?B?WitZLzRrZFFYcnVKSWQ1aDh1OTQ2WkxMWlN2ci93MFFCZGlRbktuTzhoeU01?=
 =?utf-8?B?SVpIUTdxTDNqeVMzd3VqMm1kNEFTMFR0cExxM2ZrMDE4WkJieE16Y016YldX?=
 =?utf-8?B?cFFydzRQdGRQOFRySWU5TVhaVnBQQk9pRGFkNzFDQjhXdGlnTFljbmZXcE9H?=
 =?utf-8?B?YkJJVk1xZzFnZDkwL3ptQlpYL2tCOVJwVHVwYzBndzl5NzkzcVVtaWdWd0pX?=
 =?utf-8?B?L3dMWW80UDFqdExWU2pvZ015NVdqRnZmUmMyTFR5SG5uck1CVUl6RmNiNlow?=
 =?utf-8?B?em9ZQUpRRTI4ME9iOEpTbUpFbEdsYmpyc0thSFMwZ2xWN0YrSkxGMlN3Uisz?=
 =?utf-8?B?ekFwQzh4cjhTZlgrVVNuU1NlRUVoU3hJR3lCUEpHdVdWTFVmaWhXdkIzV0Rx?=
 =?utf-8?B?M0srNHBsdFZIRlNCTWp5NVdRQXZGSzdqMjUzNVlrM25ndEtrRXlDU3QyWXQ3?=
 =?utf-8?B?VW95Nng0Y0dNNUR2eW9DTUNtZnc4TDZBRGNoQmpIZ3YySUh1dXFyYk5PYXNC?=
 =?utf-8?B?VGU4c2Mxb2xQNmtua29OODVnbGtocWZ2U1hPdnhzK21IWms1blRrWEQyK3hH?=
 =?utf-8?B?WEpMTFRNTld2dHF0NzIybEt1WWg5THM4VHFXcldSMXFlWjc2VSt3WDBFcmdi?=
 =?utf-8?B?eE12VHRUYWM2dk1mNzhvRW5TdjlkMGlZbTNGQXprRDErSkZlaFNqOVFMMDdY?=
 =?utf-8?B?eE1CUlZiUW84TzVYOERnUGtBRFVEZ3J3Rmt6VCtlTlk4R2FaZ1BubGhHeU92?=
 =?utf-8?B?eXNraFFRMTNydzJQV3NOT3V3blVsK0tWaEoxSUZHSjVBaWdaQ283c2RycHRm?=
 =?utf-8?B?enppK0FmdHlpdElaRExFYThHZnY4VUZkbVc3STRzdUhobTJGbGlkREl5dC9E?=
 =?utf-8?B?T0pSaDVaWUx0UC8xUnl5bXR0ZTd6MDBBc3pNNjNwaU1JT3d5cS9GVGtnVDRW?=
 =?utf-8?B?Y0dZb0JVamxaU3hRbTg1S1NRQW90NFc3Q0tLM041ZXRkNytpNTVRcjN5VElU?=
 =?utf-8?B?dTNHeDcxS256WE1Wa0kzZ1VEVU1OeEJ5MVlKZGRUWUp1ZFRvcHE0UW9PemUz?=
 =?utf-8?B?K0pWaGRueWdlL3RCelA4S0tKMlFlZFRXUTBnZTgxeVF4YU53RVhaZDVyYzZX?=
 =?utf-8?B?OGxoM2VCYXY0UkRJZllpSkczbHBidnRqY0J0ME9ZeVMzTVkzMW1qUDlqeXQy?=
 =?utf-8?B?ajBUdUxSclJab1VaMXFhaTJZSnkwNDY0N2dqdlBhR1VOZ2JkZ0hyTDZHVXY2?=
 =?utf-8?B?aEhxdXdMTndMUjlLSU1wVVF3N0MrQm1ZeUgveGQ2Q0IzUGEzMzZIUjF5WXlj?=
 =?utf-8?Q?/BReS8kme8JTLWhj8kF5KqkbY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1db3852-8aba-4c16-7415-08de161becc0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:17:12.7469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOW+DlCDbjMM9X2oGuPyc6ozkbRsqJQQ85tPA/mhmJRHUxkj/+nqTnWjqqxLZ0zqgwgwDGm2XjD3rKKCldnyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F
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

Kindly Ignore this as i sent v2 already.

Regards
Sunil khatri

On 28-10-2025 01:53 pm, Sunil Khatri wrote:
> Instead of setting range=NULL and using that for a cleaner
> exit on failure better to use the return value r for cleanup
> and proper return.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ffb7b36e577c..b036e22e0ec0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1746,7 +1746,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>   			if (r) {
>   				amdgpu_hmm_range_free(range);
> -				range = NULL;
>   				pr_debug("failed %d to get svm range pages\n", r);
>   			}
>   		} else {
> @@ -1767,12 +1766,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		 * Override return value to TRY AGAIN only if prior returns
>   		 * were successful
>   		 */
> -		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> +		if (!r && range && !amdgpu_hmm_range_valid(range) ) {
>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;
>   		}
>   		/* Free the hmm range */
> -		if (range)
> +		if (r)
>   			amdgpu_hmm_range_free(range);
>   
>   
