Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0624C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 07:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BAA10E7C1;
	Wed, 12 Feb 2025 07:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hkoKTtY+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E2410E7C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 07:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qgna9cssfeioacsOAD9TyMJcNUHaYtPo6/BoClkVktRF8n+59klXkhHaJxOMPEzbsu0pDsBABaUpNSWQGOXsw/uNvYpCkV4MlOnCSOYYOaTiAY/uCou26LNMA8XfEWDy5rGieuPfLk2y+Jtd8a+Xseqwkdwd6FDGpBhDCqboaAVne0OcTVkPrQ4lmjfu3PI8PwHcCHODn8r1FOAdoHujpjbcvMuPqOBVbySomfpHep8eCcCaWRUooUsKkxcMRMkXskUe8Ro8dY6d+8VknhiEL56fouFFYaOUTZOOvYCUL7pdD8OguVCUv2fC+NOuoQjE6AdZ/7GSVpjVUdn5HtlV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OEpBO5VnpiJAtI/LJXvIqRqxD7z6Q/Q1dj6EPH3KG8=;
 b=FmH+ZvfJBI9qxuCPYQmEPzUwX8WqrhfdpKFQns6WMm1DKh1EjRlvQ1KOnpzgO7+Y+WprApb/WcxxiVjMOVbXAjf4xu0z4uMEgildTEVxdoSTWaKHFHBtRx0opLR3IqZAPHDM2ZxRyMMOfQguOLks7MscOLAD+aAnZtkHWMShyKh6qcgV42hHLQsqHpiuSg44q+Bi118pZP/72MGU2JTSuBSvjFY0BQsN3mM54OUL2/GhDBg/w8YBxmIc1J504i3lU2j4OhyeG3B5ZO+4IWEhDe46t1fuqCT/5GalNeNNskKZYAuKf1+Y+9hFeMleDW/KQMOksssjjw5IyjxmvbNUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OEpBO5VnpiJAtI/LJXvIqRqxD7z6Q/Q1dj6EPH3KG8=;
 b=hkoKTtY+gql1+3Ek0cOq1QgZr71ewEbeaJ/DRK1Ais7GSQcq8kViCcYpG2RWYqYi5U19zSo4FzOihtUHgP2eUmxIB24APjfc1L4glYiIXO4SsCF8YyPWXTJoUZ5j1uA78PqjLwpiLELoLRZfx8sizN3pfLthbEXT5CtQ5DAhsVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Wed, 12 Feb 2025 07:17:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 07:17:50 +0000
Message-ID: <3b4fbabd-ee08-4f65-8440-fc1f7373886a@amd.com>
Date: Wed, 12 Feb 2025 12:47:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/vcn5.0.1: use correct dpm helper
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sonny Jiang <sonjiang@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
References: <20250210233132.583035-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210233132.583035-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9110719f-6567-4aa0-30b2-08dd4b355b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHhkM0NHd2JrTHNLa0lTc0c3ZHNKRG5EZnVjVHR2aThhVFdmcFo5dmZHbWNH?=
 =?utf-8?B?cEhoaXpCSml5QU9rR0h4eWo0NDB3NG1tdmxoeDZabllDL05QNW5kZ3lPUEtJ?=
 =?utf-8?B?QUVXSERpRHdzS0RnRWo2U1ZINVRub1BWTkFvQzlRMThJVm9WcXNLc25weVdl?=
 =?utf-8?B?MGFPUy9hLy9iTFZXMTk1SktHS293UWxod0lnRkZYcDRIN2JTdTNmSi8rV2N2?=
 =?utf-8?B?bjFRaWJjTURROFJiblJxRmVNUWpBVU1ja3U4SEFnQkh3djFFK1BEZk1ESmhN?=
 =?utf-8?B?MGYxK3locjdhSFpXMEtqTDJOSWY1K2Z1ejlucnFaREtqUTNiYWNFZkVCUWoy?=
 =?utf-8?B?WUNCYTNUZkZ6NzJ0L2E2S0NDTmVkek1tb0VwazdUUHlwSk9pSG03ZkhVcVJy?=
 =?utf-8?B?T01WVEtyRzF1TEVwNmVZemxKM1ROM2phZkJQdXh4cGpadUU3NEhlVnV4MkZE?=
 =?utf-8?B?RStNSUxCRTh6ajFYeUpDR0RSM0k2MURMTC9tMGJObElSU1gySHVHUy85VzNT?=
 =?utf-8?B?NkJvS3dCa0xZVmRPdWdKZDF4eEdmczhiaVF2ZGV1WlU1TlFKZTJYRmtjdDRs?=
 =?utf-8?B?bGpBMzBJMlIycDdvTThUbXcvY3RpMXllamxJU2dSc3RKcmRQWjlmVjhaU0VP?=
 =?utf-8?B?VnNGZ0kxc3RxWS81SUxOQnYwUEN3OVJ3Uk8xUmRTeE9pN0tQQTREbnEyWFMx?=
 =?utf-8?B?dEs0cmRpbDlvQXRwNzRaSEJidEV6aS90MkpISjdPVE91UzMwZnNTZGJoNW5v?=
 =?utf-8?B?ZVhhNUhPaUo1dURSMlFRa1ZNRVhGeVMwTGduVzUwQXNSdE1KS0h2WG4yMFlK?=
 =?utf-8?B?MVBuMDQvb2tDK2N2NGNQZWRwSTdOZ3NseTJQM3FiYXUrNmk3dnNVQXNBMVBQ?=
 =?utf-8?B?M3FvUmNIOXczQjUxb2VVa0g0Y0ZIVUVBQlo0ZFZMNTRVa29zS0Q0Skg0Zmpr?=
 =?utf-8?B?ZlJSWVgrTkFIaVBsQTZZOWtnOTU3blE2dmFhdjkzait4cVhkUHhhREgwcDB6?=
 =?utf-8?B?dEsybVVsWkNTS3hwRTV6SlprTStmK1VONEwxNE03VXhGUmd1OWVrbkQ0QTQx?=
 =?utf-8?B?aFhmMk9xMDBsZ2JHczNCeWVZNTVaS0xsYWNVbGxQMGVCMTFLMlBneVkzam1x?=
 =?utf-8?B?UURtcnB2NXBXUHdKZzdxYTloQi9VVHJJVzJnRUxtR3hpamRpbjR4c1B2VGRH?=
 =?utf-8?B?ejdDYzJsdmo2UW40bTh6SmE0OW9RVEl4M3EyVS9SNWVPRnpoVmx4eHoxd0JR?=
 =?utf-8?B?WHZjNFMwL2o0dVp1SFBVMm45am4rNkNnMFVXWmZGd1Z4cjF0MUFVcG5BWE52?=
 =?utf-8?B?SnlTcmJ5cVlBRVVDalk1eHVXUVhvb0N3WVlkQU9uMjQ5c2tGRG5YUWhhcWtI?=
 =?utf-8?B?ZUFIdUFlRnBuZXVscWJYRzc2VldoWXVJMFBXSm9OZVpCUjFsSzFQOGxmZU9N?=
 =?utf-8?B?Zyt0a3hXL094UTlqL2c3c2lsSVpCVldTamZRTnRQckN4VTNwSVNVZStWbUNW?=
 =?utf-8?B?OVg4RXducU9XK1RpSnNOakZCMWxiN3ZROTJlVFBHM0wySVhnNDhoOUxWUTdk?=
 =?utf-8?B?cTdVdXBaL044SG4vZG1oakJSUVliMVhhVXhtOEFWQVBCWXlEamtJMkkvaXQx?=
 =?utf-8?B?NEN5dDFhczBWYzF0dWVvYXdqYTlJL3NqZXp0b2hxNlVnODhkM3h6YU0rTjdW?=
 =?utf-8?B?ei9WWlduODhCaEh1eFZ1SHdVenhsWnI5OHFvYWF3Unk2dW9xaWZ0STFuQ2RG?=
 =?utf-8?B?eHRxMnhuOUtxNWM4d1poaHpkVjkrQWZ1MDZpVjdFdWRZRVFuRFp1MElKU3Zk?=
 =?utf-8?B?dTFuU3dHOEc3cDdYUjMxRkxxRzV1VUlWaW9xc2cyQW9yZ2EyajZzRGVacHRa?=
 =?utf-8?Q?4nPyF8afc2or8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2VuTmJjblBubVlla1oyN3JsNjdNTzFacEE5U1hBUDBTWnBIdUtUcjExTDls?=
 =?utf-8?B?bWlENTFZSVpUVFJleTV5TFc4OFd4b1IzbkNTdGxzelIzbXMzb0xkYzVjMXlI?=
 =?utf-8?B?aE11NXFneXhuSkVLNmRZdTZVbVlSbzdRaHB2NE11cWNhdyt1R2JKYlAxSWth?=
 =?utf-8?B?bDFHUko0eXI1VFFycGpoNWZ6SU01VHhqeVNvdTJSYm0yckIvcWFNUlNyRExW?=
 =?utf-8?B?REdZZ0NmVUNwSEp0UEJONVhuTHlZSEdrbkovS2hvTHR6TmJvbFJscG1mVzZM?=
 =?utf-8?B?RTArem5XVnlZSnJwb050QTVSdUhhS0dRNjBkRDNyeXJEWmpuQzd1enA2alVu?=
 =?utf-8?B?emJlSG1JbjZQZERGN2VEL09DQ1l4S3dhTVBUZ2phY0xRUmwrUWNWWWJwWEhF?=
 =?utf-8?B?RVFKUkRieGxzR0J5M3U2ZndDRGFPRjR5b0RpZ3lZdmJySWlLNjVHQ1NiQk9k?=
 =?utf-8?B?cE1rS1JScmdpSk9JRzdOTmpBMUx1MTJZR0IrMU5tWURaTnpBeE1rRHpta3RW?=
 =?utf-8?B?YlBrOFFLdzZLVnd1Wk5vYzZidXRmYlRlTWZzNzNCTHBRZ1VkeUxXbjh2ZmxC?=
 =?utf-8?B?YUhpVm9TdTZ3TUhXN2hMdWpJdHFPSWJKcUh0Wmw0L3Z1Rkc2OU1BbllvVHVN?=
 =?utf-8?B?ZTN5MXlyL25QODhHSzFzUGlBeHNSQldHM1ByamZ4MHZjRk1QQTRNMjBUa1hG?=
 =?utf-8?B?OUloSGo5a08zRkVsTjRKT2UzOWFBOTdsaDVtcWxxNHVNWFU2NXhreWJjVDh4?=
 =?utf-8?B?K3NFSE8xK3ZhVk5BVVUySmtCYXZkNFI2eEFyQ1BKUmZMeWxlVm9GYVdDZ1dw?=
 =?utf-8?B?cEdBMmJNV1ZEb0l1bnprQTErQVBsUGtTbzYrTnFYazlVK3JqNm9SeDRUVlFT?=
 =?utf-8?B?T2hGeVlkbGNidWRteDFHbUdOcjR6UHFObHR1UnZEVU5YeFczblFmOHcxWGd6?=
 =?utf-8?B?K0JWT0FVZTl6NGNBcFVZcHo3bFpTbWJONnB6TmxYL3R4NW13cmxENFB3ZmJP?=
 =?utf-8?B?b285NXJhL3Q0c0pVL2RPY1o3L3hTRnVkSHpMN2Z3STl2S01GNklwZjM0cmtR?=
 =?utf-8?B?em5HbFFMb3VQRlZ4Sjgrc3lyemcwTzZ4Q1ZaZ1dGUmVUT001MFQ0MU9wdTJt?=
 =?utf-8?B?SDNFSnRuaGpKeFF1K296MEQxOGZLc1p1bEdSd3NVYVNBMmdTaG5pRmJPcFdE?=
 =?utf-8?B?cXdSTDdpcE9ReWYxTnZLV2xlSVl3MlQ5SUw3ZHBOUGpoVER2RkxOb3d1REkv?=
 =?utf-8?B?T0s2aVdDclRVMU9wK1QwTVlEMXZmdU11cFQ4a25QM1NsYUtvUStCMytNZXA3?=
 =?utf-8?B?MC9qdkdLZWlvZWFiMm1BZlNTOTB1RVNMczNDay9QS2NYWXFRS2I4Y05YRXEr?=
 =?utf-8?B?ZWR1eVFNcCt0d0R6d1ZFUEJIaENwQmFCbHZhWkNiNVRkNHVEUmF6dkYrSE9s?=
 =?utf-8?B?UUZsUkZ5NzJvTkhWcnoyNExsc1VFTjlsV2o4N2UvSEo3TFVRdENqOWVmOXgr?=
 =?utf-8?B?dGhEd0hVaERKY245QlBZaTVYTmoxaERWOXlYb1pvR2dTdUtwendHUktvbHAw?=
 =?utf-8?B?cTJwVEdzUnVRb1JTMkwxS0RweGRMbVJ5bEdORTQzd2ZZa1R4M0lxdnpqNld5?=
 =?utf-8?B?ZDFxMVVlcEtwQ0EycUN5c0UrZlY1ekhNNW9rSFFseTgxeHVmaG15VGxoSXRR?=
 =?utf-8?B?SzVWcCtHaTcyU0Y5b255ZkpJaEpEMC90N014anpObjNKWG1HTUVWYlZvZVlL?=
 =?utf-8?B?NXZRc1duaThKNVQ3VUo0NkpLb1pXRnU0MGt1RVVHL204K0p1b3hUbDM0cktG?=
 =?utf-8?B?bllmZnB1Q0tMdE1xdXlNTWhDWmhleTA5WDhSemhLSXZ3MUNjTWNFemZNZ0Qv?=
 =?utf-8?B?OS8vc1AvUzhVbHFyREVjMWptbXhjcmVjSWdBektFemVpdkpQMEVDTEc4V05V?=
 =?utf-8?B?ZXYyMkVKVFRFQ3A5RktJY0IrRlN3a25WNVRDWW1mWDU0Ti9najltNEpkL1Zu?=
 =?utf-8?B?SnJiWG5YZDE3RDR1ZFN6TDZlZ01iSzdqem80elRVUk00VXlKTEVGV3FZMEhk?=
 =?utf-8?B?d1RkOFV5cFBuQ0JhSkNtRnU0d0pDekx3VjhRMzVKTUdTbmUwZUNGTE5PbThu?=
 =?utf-8?Q?RVQIBJUP8xhngkaiCr+XoWYEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9110719f-6567-4aa0-30b2-08dd4b355b76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:17:49.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oP8UWiL/N0ugJB2T5YVe+/2aVY98TgiJ8PM6vxxecRdGxmrUhTm9m91PAAbMuipv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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



On 2/11/2025 5:01 AM, Alex Deucher wrote:
> The VCN and UVD helpers were split in
> commit ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
> However, this happened in parallel to the vcn 5.0.1
> development so it was missed there.
> 
> Fixes: 346492f30ce3 ("drm/amdgpu: Add VCN_5_0_1 support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sonny Jiang <sonjiang@amd.com>
> Cc: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 8b463c977d08f..8b0b3739a5377 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -575,8 +575,10 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  	int i, j, k, r, vcn_inst;
>  
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_uvd(adev, true);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
> +	}
>  

This whole enable/disable vcn power gating can be dropped. This is not
supported for vcn 5.0.1.

Thanks,
Lijo

>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> @@ -816,8 +818,10 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
>  		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>  	}
>  
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_uvd(adev, false);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>  
>  	return 0;
>  }

