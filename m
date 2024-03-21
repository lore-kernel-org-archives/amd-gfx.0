Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A04C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 08:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1770D10E211;
	Thu, 21 Mar 2024 08:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gN8TXrAZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305EE10E211
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 08:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo1yf06LS63GMtkFACcSPIBVuLaOH8lAgLZr4GGf6GS2rnWUFgthDoTPbTMk8eePQaiXnCmRHKFqdZMuY0SdCFwXfTjghMrLFTlB7wvfMXlGmilWv84T4Azz9+OyEg6YQsHuov3dNU7CczbD2G1UOP5bWZ1E8JQ+IvPxnOM+BU7zU7tkZp7dk3sAMVuAxDsbBi7WgNt4ox+JzrAWNXR/QWriFBkFJrK72UVbpeRwfTf+GtIpTGakWTYcmdf7W77HaE8bcqvNckiqdRtWqIN/TTTXwCl3LTTiLPavUPe86fUaMLiS1EUiZG2YBB2EVoQVlONh6hDxeMbhJn15bcPNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJsPz2W/L4HqRNsFMoJV7ktAIksZ89Z5koWDXhr88/0=;
 b=KpuJCFO8EySYjdkcEBlYOR60woh0j0g6QC7uodVLepQ+VXGWRXVqdvoTXvIlFJrgWKtIScQE1n7j1TgkBCUuF7InoaMYm6bu5gq9ujmFOnzi5dd2O7YbWFrgIVypa3JlnNLFzPxssNqGQghnDX6JDqrQkjqyKxRK2sz9+2C8QHJ+n4rjFI/iB0k6/TwKzC6Xmw90Dwrbf7amRNPqPv4Us+CuC3KsKUJWGnq6WteKs4R1eoq8pOK3Zm9eXWfdEtTtCOmPMspcQsg7750Ez+e8u0Czlulq8OTHluw0hRuWfVCNhWO619UkEQ7GulDaoiwi/hRfKsx/57lguJkhGT3eYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJsPz2W/L4HqRNsFMoJV7ktAIksZ89Z5koWDXhr88/0=;
 b=gN8TXrAZN2GdmXL04cJRrTGKauOaYG73O7WoTdqtTOX6YPVfs29QjK2KGzZ4TB004HNzd/NUbNvaFyHYRPAthdBl7SJPC87+4K/sP8okhklrg7eftcDiFGioie1kxEY+Gq4dEPW8kwJ7mrno4ooKtB77bwQ9tyrs6ygKvoX6GRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:17:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 08:17:12 +0000
Message-ID: <533c79d9-cabe-4fb2-afb2-561aae7b8530@amd.com>
Date: Thu, 21 Mar 2024 13:47:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix 'fw_name' buffer size to prevent
 truncations in amdgpu_mes_init_microcode
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240321054647.3625987-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240321054647.3625987-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f3b1eb-af47-41b2-d8cb-08dc497f4f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gegz7hSgQ8MYCbd29gmm5k1iyHCaUYSu3S7eodR8friTmceOXxanA4tAHQbAxybdOn7rYASd6ttipdIcdnbK/lyTVNjzxZHSaaq2UCxgJ08JGBAGLiR/Ccdhvjxv4ljR95FOb/E+UMY1qbLneyVX1NYaX0YYTx1GJLIN34401ZKuxRWe0mt2O/BTLtNwyFAtBErwmOvsjGvHCOz0PXmBvkG7UPMojpgpFbjv87D04qLfCZZa1Q0qzlt8baO7UvFqe5Yfg+9l82YVCCLMY8PgrL4tMRpOpCdBVDsUZzOqmVvyDVKkIjd+TNkE/H27gNkKyRdGp/tcIC9OKRQZczK2xgoj4grLBrb4EKksleAFODY+sSNEoKSbXnK1dUClmq1+TLRDVBP9oYELkdUq9e/sNNkDq4kbsDp8RNOP/WZRUfMfMRMSy4s54y7v6HhJAFFeolRF9kKItrM2CIDzKs9yIt3KjmCrzvmGNQLnAd8a4UGl6M0oSgjjh+yuTuc6LmXR76ubkSu8RlwcuSv9s7EMSM8krbOYU91POtl70MfSHCoD2FxRROlWqTxoP75gawejOQXXl0c9fIhXgBsST1ZkV9hSS/K+Wv64Lj2BDg9a87wlw7vZA0u5Ft81b66y8jSLumin6vQSsEmk+mNqj6OicMe4wm1HqPJe17q+U31scwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk43K3RJYk9CUDRXS1EzV0ZNbit4SHRIcnduenpsRDltN2d4ME9ITThmSGZL?=
 =?utf-8?B?MWsvSHJXc2tFV3F1VGoxa29NUjRHcE42ZzN0Q2FUb0RCNzQ2Y2FGTlNNc01Y?=
 =?utf-8?B?YUhEZ0ppdGMrUzAwNTB6Q2VDWVR0ZWhVNGwyempPRnF2RVR5Mm91eE82VmxV?=
 =?utf-8?B?Y0ptcVk3NzlyZnpKeTZRYXk5T2l4V29GRWw3RE1JcTVhZnlFelFORWdVcTA3?=
 =?utf-8?B?QnVOaHFLMUJlOXgvd2xxcjNXaU5QMXp1S3I0SkU0eWdmN2xINWs3Lzl4U3JB?=
 =?utf-8?B?YThXUGZyTjc2UHhWdDNFZjFmUlp6MW5TWFpvdDRIQzlpNnQ3SGR2ZnZWYXd0?=
 =?utf-8?B?RFFGekFpMlRlMHJtY3JVcXZ4eFZsWWpzTmdGZDZ0QndINGhNbFFnRDNRdFZs?=
 =?utf-8?B?NXhLS29qUC9PckhReUxVRHhISEFiODc2T2t3dDQyTml3R2dQZ055ZTA5emoy?=
 =?utf-8?B?dFJId3QyYTBLTnBFellGWS9pSUg5VHRxeXRUdTdyUm1TclA0VkFFRnZUQ2h6?=
 =?utf-8?B?WHhEeDdOcVVyS3NWM2JtN1loQ3U5NnVwTU1BTHRFZU0xWEsrWFY1MVhsRjBw?=
 =?utf-8?B?ZG5mMXpSMjNPVUZScXdTdnUrcmZOcDcreFpHWnpoWTErNGNTSmNzMXAwOThu?=
 =?utf-8?B?dnVtTTNpejJPNmgyVlFxQ2FzL3U3UWx1bGp5bTFCWjdpK2NFcHk0b2JSbnBh?=
 =?utf-8?B?KzZuVGtxZzZIMkJGZHgzWnIrS3orRjJlSXNxWFNjN0hqWno0ZDQ1RU4wM08y?=
 =?utf-8?B?bnprcEJGYWNiOUV5T2dtZERaanhzMjlQanlCUEN0N3pNcWxiaVhZaTZYREQ2?=
 =?utf-8?B?QTlpOUc1b0lGTlI5L3U0VHBmNkFxOS9tWVFJQ0dDNWJsV3pEOTVFNjVqeVFE?=
 =?utf-8?B?bXNUaFgyU2VWTnlwZUxwZUNZNTVCNm5CcWJHajNXUFU5WWkvY05pT2VvcDB0?=
 =?utf-8?B?aktveCt0Y1drSEx4S2tCZE5ETlJLUzRoYlRrd1BUVHdhUFB0WE8rMW9hdXRs?=
 =?utf-8?B?Rmw3c0V3RnNXd1lyekdvVlZIQXMwVENaTFc5ekY4RGNXSHhoUWJmVHRCMmFK?=
 =?utf-8?B?Y2JMczFweEpWdXAyR01RRzY2eXVOdlIycTgxcXorYkVYNnVrUE9sR3JVVWNP?=
 =?utf-8?B?blUwRWd6WEdBYUdWY2lxM1hXTXdqd0ZOd1BUL3dKRE4rQ3phakJrR09qT1Jx?=
 =?utf-8?B?TFV4YklXaXZCSDFidWlTbXA5Yk5adEhmcGRTMEM1Rys3V0lNbm90WG4wK0Ey?=
 =?utf-8?B?MzFEK3g2SXRTd1NFVkd0blE5UzVlQ09GZ2hzeE5BaUc1S3ZrQ3dTaXViZEsr?=
 =?utf-8?B?UVNId0hTdisxMTZjRlU0RVpjS1l5MkN1VUhZNzcvRWxGSnVuZUFqSC9NK2J5?=
 =?utf-8?B?SW9rY2NXcXlmY1NtaUVqNlV6bFE4Y0pHeUgyTTBKOXNSV2JwemtFd2hSMFhE?=
 =?utf-8?B?TUZNbkNOQUVMajBLVkEvWWEyY2JaRk1ub3M5NjV1RmZBTkdwa2V1ZTFLS1pG?=
 =?utf-8?B?bytYRHRUUnQ3SmYxVVFQUTRGeXdYOGJjWUNsa0dJMmhQdjlPN2RhWmdKVTZp?=
 =?utf-8?B?THkwZUdrTDFQR0ZOSnlkaUVibFdZUStQbS85d2lVMjA2SlM2R3dGSFI1RWFk?=
 =?utf-8?B?ZHBnenVKaWtLdE1FUUNQYXhEWjFINlJaMXRSMlg4VVNwUGhpZUJReXh1NE8w?=
 =?utf-8?B?Tndlam8xVWhJRHN5UEhYUW1pT1U0b1diYXAyZE10Rm96aEI3S29hRUJJWEJI?=
 =?utf-8?B?ZGtVcmpTaGZUV01VYVh5YkU5U2llWVdLb1JGZ3NTNnpjM1d4aks0NThyNDdk?=
 =?utf-8?B?MVh4QlFjN2VGZ1QwNGJqdnVSOXkyZWdiUXI2ZnFkek5URU11RlByV2IwS0VB?=
 =?utf-8?B?b05POEtsU3hnWS9QbktmNExVR2FGUSs0dWpmODZ4b0NVZUYzV2t5QWF2djJM?=
 =?utf-8?B?OWNTK09JWUMwN3Znbkk1b3pkSjB6NjJBVEVLdHFhMnBZZlA0UTI5QUxha3pQ?=
 =?utf-8?B?UGNhdmJVc3c3UncvRTNCU2plOWhLaE0vTHowRjNneGVJNGJ0Z25iT0poUnJi?=
 =?utf-8?B?WXA4OFc0aTR6eDRFUzRiMmJQRWwya1RCb3lDZ3hjbzhZVmoycnFaeUJ1WTJo?=
 =?utf-8?Q?pee056XL9wPGLvPhMAq2jLSgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f3b1eb-af47-41b2-d8cb-08dc497f4f20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:17:12.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XP+r1qiPNUEy6A8OQ43wBnwU796DWl6x8g7CVVZ0fhRJzkGx4VMNc1xh+Q38bY/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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



On 3/21/2024 11:16 AM, Srinivasan Shanmugam wrote:
> The snprintf function is used to write a formatted string into fw_name.
> The format of the string is "amdgpu/%s_mes%s.bin", where %s is replaced
> by the string in ucode_prefix and the second %s is replaced by either
> "_2" or "1" depending on the condition pipe == AMDGPU_MES_SCHED_PIPE.
> 
> The length of the string "amdgpu/%s_mes%s.bin" is 16 characters plus the
> length of ucode_prefix and the length of the string "_2" or "1". The
> size of ucode_prefix is 30, so the maximum length of ucode_prefix is 29
> characters (since one character is needed for the null terminator).
> Therefore, the maximum possible length of the string written into
> fw_name is 16 + 29 + 2 = 47 characters.
> 
> The size of fw_name is 40, so if the length of the string written into
> fw_name is more than 39 characters (since one character is needed for
> the null terminator), it will be truncated by the snprintf function, and
> thus warnings will be seen.
> 
> By increasing the size of fw_name to 50, we ensure that fw_name is
> large enough to hold the maximum possible length of the string, so the
> snprintf function will not truncate the output.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function ‘amdgpu_mes_init_microcode’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1482:66: warning: ‘%s’ directive output may be truncated writing up to 1 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
>  1482 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
>       |                                                                  ^~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1482:17: note: ‘snprintf’ output between 16 and 46 bytes into a destination of size 40
>  1482 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1483 |                          ucode_prefix,
>       |                          ~~~~~~~~~~~~~
>  1484 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:66: warning: ‘%s’ directive output may be truncated writing 1 byte into a region of size between 0 and 29 [-Wformat-truncation=]
>  1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
>       |                                                                  ^~
>  1478 |                          ucode_prefix,
>  1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
>       |                                                                 ~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:17: note: ‘snprintf’ output between 17 and 46 bytes into a destination of size 40
>  1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1478 |                          ucode_prefix,
>       |                          ~~~~~~~~~~~~~
>  1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:66: warning: ‘%s’ directive output may be truncated writing 2 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
>  1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
>       |                                                                  ^~
>  1478 |                          ucode_prefix,
>  1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
>       |                                                          ~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:17: note: ‘snprintf’ output between 18 and 47 bytes into a destination of size 40
>  1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1478 |                          ucode_prefix,
>       |                          ~~~~~~~~~~~~~
>  1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1489:62: warning: ‘_mes.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>  1489 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
>       |                                                              ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1489:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>  1489 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1490 |                          ucode_prefix);
>       |                          ~~~~~~~~~~~~~
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index bc8906403270..78dfd027dc99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1467,7 +1467,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>  	const struct mes_firmware_header_v1_0 *mes_hdr;
>  	struct amdgpu_firmware_info *info;
>  	char ucode_prefix[30];
> -	char fw_name[40];
> +	char fw_name[50];
>  	bool need_retry = false;
>  	int r;
>  
