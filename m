Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C5BC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6B110E1C6;
	Wed, 29 May 2024 06:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5R/acoTa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC9510E1C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfrQwp4JXZjfNs8g4Ja7BSNA9v3Xmhy5eBcAU/TRDE2RZnC7+eF6vh30yKwVT1gRPIj668PTxMfScGEuigFAe8tfrRimdgSbOPKWN/J6RoBocbLLuxVQjjnClBrhW859J3a0INY804LTM4FxHB26C2eFPiTHrsV9BTCUGUsCoEsOHzctpML+a7T7MovgpnVhH83xWSp1TyQBevpQiSpAYP5CoARBWwmmK2OmhSaIgkGpwUUaqFkMFnS7SnvJMMjsD/+sAvihPs549m3uUC0dfMxk0Hg2ltsQfBkUgHXPp1PCtF16ghrtZeiS5HZ/lej/yp0BzM+F9evgDMJJHQbJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjHB/Xwy8oGAAvV78oo2PcCv1/A/nsk6ba95REBs36E=;
 b=VNa+WOu5ZWg5MhbrU1bLA0+04gTt4A+3LAsZt67eqWm0Gr1AdDzsIWIx05Q4AD8uZK7lkb+dX/tD59RZEs6hpSyhKoQbzS0ofqDr1ebf56WBsjd+HgXTT9tip+g+uE/1A5eXo8Xi7S1lHFPugLq89fJH47pV6nsf5jjks9ScdHIQGwl0UgomDqyCDm8GVgfFnV9duZP1z8+VTBQ1PM8I/akQVQA3Ylwvvn578BYRI3THGmgZpXRPbOB4z5Pos0vdpCz5KDjk7/JX6fOyFQbszfodFtaexMGWK1sz6v0brkDC5ARw7a4hNMDrfJLyki0L1L1RAltSdF43sl+9JzbZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjHB/Xwy8oGAAvV78oo2PcCv1/A/nsk6ba95REBs36E=;
 b=5R/acoTajCXEtJom1hT2FLu0LhUUGbKsnSMl7af7z4oCFyvMULNeFyxFX2Jml6cpOaGyRZ2Pmu+Dy0tesWblW0Y4KtdfxcGTEYqpW6n914nhhreW7NK2ungXZxSc2sKQ+NgVMa88SVob2AnmfjbLU62MARBkaJINcU2azSDN4A4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 06:43:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:43:41 +0000
Message-ID: <a9b3bfdf-f626-44bc-92db-327d17d06e8f@amd.com>
Date: Wed, 29 May 2024 08:43:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] drm/amd/amdgpu: remove unnecessary flush when
 enable gart
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-6-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-6-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dc2f19-0c81-4815-f884-08dc7faaad74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm1uay9RdTIvMExEUVR2ZS9ZVzdZdXFmK1FBaWhQVytvWjB0NkRSZm50RlYw?=
 =?utf-8?B?NmpFZTVjNEtqUnp2eHFPZDlWOGNtRCtEQ1cxQnFNalFrS2ZTN29JNmRjRmhW?=
 =?utf-8?B?UDVQUE1TUlZmNGxGZm9mR1lkMkt1dkFTaFdiUDNUZWxLTUhuY0R6REhwVm4w?=
 =?utf-8?B?NjVsbU1ZaHd4Kzl0ZmRSZC8wVVNoalNtWlJMN0hjR1dZano3SFRzeU1BeHEv?=
 =?utf-8?B?R0NVS2dibWpySGROUkl3V0ZrR2dtL3VSZ0pzVW13S0w3R0taKzRzaG9iSkxr?=
 =?utf-8?B?R093V3kzNDErOEJvaTFzR2hHbU1ENWc3VzVoZ1V1cUg5TGtDLzdvWXgzTVBQ?=
 =?utf-8?B?YlBHWEZMd3dhR3RKeXorV3E5NkkrOXhlaG9PaXVpd200UU9HS1hlU2FRVzI2?=
 =?utf-8?B?QTdjSGRZR3p5NWZwcmdDSlBDdUJKYnFQVmNjbmRnVEp5VGJBTi9ZMXRoK0J6?=
 =?utf-8?B?U0hUSWIxTlZ0QVR0OHU1Slo0RStTVnNVN0VwdlEwVXBseHNLV1JuY2JMZmky?=
 =?utf-8?B?ZmROR2Y3V3NtTDJBdWVVQkhkK3hNU3V4SUNwUDBnWGFyaG5od0k5MHF5a3Ar?=
 =?utf-8?B?Q0ViOXl3d3JmNDlFSDRkQ1pUR043YzJyQVZFMklnSmthZjMwYkpJazIyWWs3?=
 =?utf-8?B?ZlRPQW1QTWY5OUJYSmFnLzMvSytUWi82T0JuK0dzdW5wQkc5cUlqRjRLZE43?=
 =?utf-8?B?c0tIdW1rSnNZcEhlTEVaT1RXMmNZcGdKQ0g0dGg2azNMaVVQcWpKRWZJRHdP?=
 =?utf-8?B?YVQzNThOQk15TmxuWHRNWEF6endLa1U3UGdBOWdvdHNNUFp5RkhoNTV2S2FY?=
 =?utf-8?B?NFNncmlEMDZjODNTRHNhSDlTZ0xVbWwwb1k3WEJtN2xuaStXcWFMZisrRnRH?=
 =?utf-8?B?aUl0K25qRVlZU3pZUHVFZytvT0Q3T3lMWFZHNndJRW5CUFRPMGN5VURaV3c0?=
 =?utf-8?B?R2xsUFZtbXMrTTJBdzZMektLVkdBTlplb29oU2NPK0FHdnVGdmdEVmwyVGpV?=
 =?utf-8?B?WU1EV2NGUWZMWlkyNGkrd1laVUU0UWZpL1FQdzVvT3hwYk5BeDl2ZzlrWVll?=
 =?utf-8?B?eDNQN2hvdnk0azE3Rk9lYnBldk1IZklmeG1uUHg1a2dzMjdvK0d6dmYrWHg1?=
 =?utf-8?B?aXR6MGJxQ2JlMmE0MVdxRkVzM25wV2FBV3IzUkhoWldYWnNEQWxvSDl4Nllt?=
 =?utf-8?B?TEwxQUhQZDdYM2JGY1NhQnhVeDRGZ25HOFVEN2h5UmMvME5VaUQrV2U3SEpn?=
 =?utf-8?B?OVNHckxOM0tycTNONFE1YThhenpZQnZsOXFuRHpzMGMySngzMzVza2k0Q29h?=
 =?utf-8?B?U0FPcGdVbFpJOGM1STlYL2JBZFVCWUIwY1ZqK2orbmQ0bDZLMXFndytLb2cv?=
 =?utf-8?B?Ymx4NXJtOVM5NE5mOUFWYTBYRXVTTUM0UHdlQnJZNUV4eVhJUUFpZVpnTEVs?=
 =?utf-8?B?R28yRWZhbkE3dDFkWS9rcTBLSDZ4M25BcmRpWFJRczMvTTNIQ0NDRC9YKzMw?=
 =?utf-8?B?RHpJS3FUeUl0TCtHUXZreFJDd21EMUNjUnVIaE81ZFhZZ3JDNmo1TTEzblVV?=
 =?utf-8?B?cVlJZ3NtS0VmWm94b2oyV0UxZDRSRGlieEQ4R0FXWnYvbWg4Vzg0bzQ3N04x?=
 =?utf-8?B?dll6bmdMVHJURWVHUlZ5cndRcm5mQVhNZWUrN2ZDVFF4SWFzd1Mrbnc5cjFz?=
 =?utf-8?B?RDN5a1JkY2lmL04xTlpjYzVlWk9NRkZvaDlieEVuY2swZ0w2a3VqWDB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlRQnhsY2t4RTIwMWlWN29hdW05YldJSGFsYzFHbm82UG5vTWVVSlhxczN3?=
 =?utf-8?B?S1QrL1F2cGFEeWRSa0U2bURxYmxkM3VGN1ZRdytZdk1pZ05qblFFQW5Dc01t?=
 =?utf-8?B?WkdOWUFhd0IyV3VvK0JVaWcvb29tZ0l6cm9GT0t4SUZSUThneDN0clBqTkts?=
 =?utf-8?B?TExyTGcvcXltSldtSzUvK2pWeWJieXcrbFBSbzZDZXpyWlIyeGpMUU1mbGRT?=
 =?utf-8?B?VjdrTWVHa1ZwbmlEV2oyTmFJWEpnbmRsVmZBU2ZDRXR2RVVzN2s4S1l2UHUx?=
 =?utf-8?B?TThYcmlWdW54NVk0V2ROR214ekxnaEU2NkdRaFllNlYxLzA0cnVON0FNK20r?=
 =?utf-8?B?M2JZOUd6eVNTSm9qbHhrNmViNEEzRGF6M3ZQOEozSXBWaTV6NzdYd1BOelNN?=
 =?utf-8?B?NXJyaEtESCt0NzhoR1RYNVBubWlEWUp2WnBxSzM3TFJKV0lZU0NnU2IyWGZO?=
 =?utf-8?B?Umo0UisxUzNSYzZhUjAxM2dqdHdHSEwvcWRvVWFUeW9BTm5TRG1GVzVtTTlp?=
 =?utf-8?B?dkVGcjNOS2g3emFIVFcwbk4wano3bnNHVndJd3RBdjFVSGJLRFZ6ZnhqMFo5?=
 =?utf-8?B?WFZxRTZiQlFlNWpEd25XY2EzTDMyUW1CcjBmcnQ2OUE4U0sweUpnczEyWVpY?=
 =?utf-8?B?UzZxUEI4WXd6endMZ2xteVZxMXNtUnl2TWFmYU51ZStWdVp4MDhYUnpBMGJG?=
 =?utf-8?B?S0xuM05ET05NMTlUT2svQlVSMlBsZkFXZVJweTF5cDNTUzFpaitCL01yakdB?=
 =?utf-8?B?R3NZazF5WTJwVlVXMXpveWZpSHRWOTZCWUFxNlRkdnlRZFB0ZlRSbmxxeUZp?=
 =?utf-8?B?dGpKRk9TSDk3cUJqdUVVdG5Lc1Y4MkphUkg2MjRoV0FheFRzdDBhMkVCWmlM?=
 =?utf-8?B?ejFmSFA2ZndiRTZDck5MK0F2ZU0vQlNGTDdvd2hhYmk2dmZYaXFNYlVMeXRi?=
 =?utf-8?B?T0xHdkF5WlNBODlRRUFqQW5BcERKanYzMEx4a0MvNHYyQ3ZFdmJ2cFFGbW5q?=
 =?utf-8?B?WGwySHB5ZWxDVFpkdjdOWEJLdnlBVVBUZTh2bFhnRlg1cS84NWpyL3JjNUpK?=
 =?utf-8?B?N0hQOG5kUWhzckNjMWM4dkR6L3oxUWgwMnBqVnhsOFdheEJyR3h3bW9walRF?=
 =?utf-8?B?bjlDS0JyNGFNckRtbU9NaUtXYW1rVFpCZW9KWDh5V1JKK092MjZGMlBqK2xW?=
 =?utf-8?B?RlkvTHFOOUpucnYvRmU5c3JHb256M3dKRW4xQWd1VDlaUDErUkxmVllreU1O?=
 =?utf-8?B?cklSeEtuTE9nTWlpa3c4NXc1MWg1SEFuaHJJR0JCT010NDlUcHp6WUNOZUI2?=
 =?utf-8?B?VTREUjNLNTZ6SXBvUlBYZnRuUkw4d2Qzd0dsRC9RQit6ZExhOVRhTVQzUXJt?=
 =?utf-8?B?SzAvaFdXTmZ4ZEJhb2V6OEJHSkxJZ01iaGhaSUY3ZDhmR3cvSTk4ZTdzQ2NR?=
 =?utf-8?B?L3ZSU1JwTi9yeThkdWdxejd4VFFyQjFuWmdEOTRjUkVPYlR5U3l6Yjl6U3lz?=
 =?utf-8?B?M1dTQTNZZUs2K2JUeExwWnVYcGlCbVduTDNZaFBibkU0WG9mM0praldIVGt3?=
 =?utf-8?B?RVYvM1hMT25YMXMwUG4raUw3bjUvL1pxaEd3aFFiSVYzckFEc3dxcXRxR3Jn?=
 =?utf-8?B?UzRvVHhMbXpEQXJZR0gzVVFraGJzVXRhZlZMTTdpcVlpTm5XMmFNc29IZUZw?=
 =?utf-8?B?NzU2WlpMQVQyVTdrVEY2eGdIbGlEQTFwYTluMm4rTThQQitJd21reHBoNXVE?=
 =?utf-8?B?Q1kzcnpDU1U3cmNLcjBVZHNOQXdJWmdTWUR5a3RhY0ZXN1FyYUtiVkFLMzM5?=
 =?utf-8?B?cE5NdlRiendWQUlrTUxNMW5DNklHZWhURStWUHpreU96VFZrbFZZUjhOT3FZ?=
 =?utf-8?B?d2Q5eENoMXl3SytHcjdNMXJUYy9VSHdBUEZXdHdSK0RuQjdVdEF4VHBKWi9Y?=
 =?utf-8?B?V3VMaUlOeWpOTUN5VGMzY0NZcUs2QkVPOE1TZ0lhbWNDU0JLbzhwWStkUzBC?=
 =?utf-8?B?OG04Y0lPM2dZS3lUSGM3OHBEenhBWFdSdndQUGprb3BkV09BWEpnZHpYQmZn?=
 =?utf-8?B?bUswaDhsZVNQTE5NeE1rOE9PckdyY3hHd1kyMEgxRHdkUmlmTXlibzRYUDBO?=
 =?utf-8?Q?vCq10QuSzMtv1XFjPYBf0l8CV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dc2f19-0c81-4815-f884-08dc7faaad74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:43:41.3556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTgG4TWTuaGAcLGP5ymadRVbwuggb0XJGYNmLuMztpTIxH6TYZuJ2BeryA1n45kY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> From: Likun Gao <Likun.Gao@amd.com>
>
> Remove hdp flush for gc v11/12 when enable gart.
> Remove flush tlb for gc v10/11/12 when enable gart.

Maybe add something like "That is done for each GART mapping when it is 
created.".

>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

With the commit message improved the patch is Reviewed-by: Christian 
König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ----
>   5 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index aba0a51be960..5740f94e3e44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4395,13 +4395,10 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	adev->hdp.funcs->flush_hdp(adev, NULL);
> -
>   	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
>   		false : true;
>   
>   	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
> -	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 1ef9de41d193..5048b6eef9da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3207,13 +3207,10 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	adev->hdp.funcs->flush_hdp(adev, NULL);
> -
>   	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
>   		false : true;
>   
>   	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
> -	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d933e19e0cf5..3e0ebe25a80f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -974,9 +974,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   	if (!adev->in_s0ix)
>   		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
>   	adev->mmhub.funcs->set_fault_enable_default(adev, value);
> -	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> -	if (!adev->in_s0ix)
> -		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
>   
>   	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>   		 (unsigned int)(adev->gmc.gart_size >> 20),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 527dc917e049..cadbe55f0c8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -891,9 +891,6 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	/* Flush HDP after it is initialized */
> -	adev->hdp.funcs->flush_hdp(adev, NULL);
> -
>   	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
>   		false : true;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e2c6ec3cc4f3..a677aca69a06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -861,14 +861,10 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	/* Flush HDP after it is initialized */
> -	adev->hdp.funcs->flush_hdp(adev, NULL);
> -
>   	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
>   		false : true;
>   
>   	adev->mmhub.funcs->set_fault_enable_default(adev, value);
> -	gmc_v12_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>   
>   	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
>   		 (unsigned)(adev->gmc.gart_size >> 20),

