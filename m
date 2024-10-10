Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8960CF07BD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 07:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8953910E87F;
	Thu, 10 Oct 2024 07:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="trJ5Udz0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A288310E87F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 07:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZp850gtMpWxN4sPq/BdA76AW/btH60hovGCV/i1U5r8uNEhl61XCVsVnBMkxI1TRuAPsxEoIf0GcVoFrGEX6OOZmrbkeULmmPM55LCDjdr80e63ZjiDNBMVGyVdoWcD1aunej+IxLbNw4eVlRojR1bJlto277sKcu7+jrC2J4sa1BHPRhVSjDxT4qhKf2afw9te3R4BgFD3b/vHVV+39tqZAMh91eZYzPXUJjCZ/3fqroiaEmOcc6tazI0dAESR1M01tSRASifkqrTjEtOKw8wp3/PMThmYUQ5nCepTau/JydQjLapmSnkWGCeu6zR6jwtj/m5ldeeURQBD97B/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nIMW7N73Gw4AdiHr2gTK8iGc2aqSl2dA63xiBO1JRw=;
 b=o/mXEQU5zjj2fC1mEoY5LV/oLuveAfLxXRx17a7O3QwwENebvc+8Q1OhI4jM8OLCpgUm9PIvBITmximonH5inhXhV/WfQuZtHhLCp/DEMVG9wCUkqCZl3YlDEeoBttyCgD87FBu6x/BnZ3Y6XA4Jvf6pqR13p/Lq94/wEuS/5UGa3ALAO+V+RUvnUYi5JxTXRWmop8t1Rih3VJNb1Fmm67LwS3dASJzdvZpDCauLOTbBY5Y++pLyKaSBp0NcHj/+ajJFHPQ5va8s6HTGf3K9KyiO/7+/ULRLYXrzEiGzzg35BcNLhxMdVSzpau3mL0ekIUzqV4nQCsDjHPmm1BzpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nIMW7N73Gw4AdiHr2gTK8iGc2aqSl2dA63xiBO1JRw=;
 b=trJ5Udz0AeuAorG0+7l8X47kIkn55b3JFNXmXrgzRm2O2eNLMsSr0P3VvZ5Gar4q9wuS+KPaQE38hVV0nxmuYXjE+u3y4Lbeuqw9PqtucPyLilzrEMZMnz6/Crr8WjJuajnoCGFBMjT+XIqEDUfLQJljGqCw52NO6NCzIt1Ls9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 07:43:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 07:43:11 +0000
Message-ID: <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
Date: Thu, 10 Oct 2024 09:43:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241009142502.891864-7-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ae18eb-792c-4e5e-9ced-08dce8ff30e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnEzcUFNWi9zVTF0SDd4cVN2TDg4c1M0bjB3RHNacDlEUk9jN2w1YWdVblhi?=
 =?utf-8?B?SFZGQ1o3WG1kUnhUNzYwR052dE0yZXpWb2pXZ1BPQnJieGRJOENTMDhycFpW?=
 =?utf-8?B?SHVxSDhsaFZrSW41NWFQZUJKaGpGWUViRkpENzBKd1hjRkFQUTROUDl5MWpB?=
 =?utf-8?B?WjZWSzhUak9GeTgxUVNJRWduT2ppbjBFYUZUSzZwUCs1c1RjRkFMWU9zSWIz?=
 =?utf-8?B?QWovUENNUnJJS0xka2J4aUQvbWFHSVNkdVYvT043RTUwMTFyL0lYTGZlR2xY?=
 =?utf-8?B?c0kwL2hTa3JheFZoRlJERHM0QTJMeVlNcldsTXNFWG5SbjcrNWVYL1RqdXZw?=
 =?utf-8?B?YUl5RU5hQVlicjhNYzR0QTI3dHhCZkJLbWxiNGlBSW1kM1RpcGtCTk42dFVZ?=
 =?utf-8?B?dDcvSUkxck8wTHNpaFdJUU9yckVQRktFV0V6UjdmcWcwL3F1QzhsK0xPQVBt?=
 =?utf-8?B?cDRsdzZjR2FneW53Y25wK3hIYnFQam1sNFNjUjROOGh3S1dTakFYYkdzeEVi?=
 =?utf-8?B?U2V3dFVjdUZWRmpYQmZvWE9HS3FOWWNuR2Q1UTBsWjB1TE9vcTRmckpxbkNS?=
 =?utf-8?B?QjFOVDA1c1JLUE9hNzBGUzJ1K05FcXM2R3lyaFBmZC9sNHBDL014WjhSaUhE?=
 =?utf-8?B?MVN0KzhPOGxvNWxTTE5wc040dFV1dnZycXpJUVViN0hzYlZzRkhqS3BjOUMx?=
 =?utf-8?B?OC8rQXZESUV3VUwxNjJFZm9YOHFPOXlZbjFsZTZDdkJqVVV1ZlJBUEMyK3Va?=
 =?utf-8?B?Tmd6bzdkdU11QlFiei9GTUhSb2dYY2tUclUwRUNkQlVUUFJIU3V6UGxHT3Vo?=
 =?utf-8?B?dmREUk40U202Wmtqc2lsaEU5MXMvdERLMXNwcjl6TW1MbkIwUVhXTWZER0xJ?=
 =?utf-8?B?R3F1RWFWVzZzNllDYS9ibmhubnZrYkVCQzdEdWo1SUJOWS9ZUmNZbk9IbkZC?=
 =?utf-8?B?d2MrRHFNS3lvMlM3aDBuUGhDQjFlOXA1ZnhwL2JPNlhwVFlXeWxheUgxella?=
 =?utf-8?B?U2pYTWNJeHMwZmJ4NEQ0cVhPYW1SV2tXR0pTQlFMYjVoaitlTGFtd05BZkRs?=
 =?utf-8?B?Y09HalZFTEQ4czRqeW5ma0hadVlucERMa2M2SWE4Sm1rakxZUVV3bnBlMy9L?=
 =?utf-8?B?TjZNQ1Y3cUlvcC9rWWxyamlUSVE2RU9vTXdHU0ZCNm90WTNFMG01a0MyUU9N?=
 =?utf-8?B?aGQ0L3lXbndpMmJ5L3JZNGNWNkVKYjdsbXRwYTBySENkclN4VVNxQ2VWYnRi?=
 =?utf-8?B?dE1rWkRkZnY4NHNReGdRTVRoUll6NXpKUFZRSDVhR2ZoU1pFYXJXMFYxb1gy?=
 =?utf-8?B?N0lzS2M3S3h1V2phdGdPd3hFM1BFTVhId05IQlY0NmdUQWhuWjE5WlU1U29y?=
 =?utf-8?B?MEt0ZzUvcU43WHl5UUtPT2t6QXJJeDlydkZwNUxlR1hsaVVLUHpodzA1dXFN?=
 =?utf-8?B?NTYyeldqSUFhS0crN1IzcjNpSjUzUzZpKzNYZXE4QWtaWlV1RzhwTXhsRmpE?=
 =?utf-8?B?dzVSUWs0VE9DcTFQRUlncU5LRm9TclJOb0tmdWNkbnhXbHR5Z3VBb241djVu?=
 =?utf-8?B?MmFxNWpCTjJKSjRWUlUzL25IOXpxcENkVTVHY2VBYW9yQzExWTFWYjdEdEVZ?=
 =?utf-8?B?Uk5qcUs2WGJPSnVHN0E4MCswOGdXZmM0QU9wV1dSNmErMHdSd1FOSFF1bTd3?=
 =?utf-8?B?aTFEWUdTN05TalRHR3h6NXN4eFVkZkR5OTlTdkFQblEzK1FKZmQ1cXpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVgvYkFrT1o3aHJualRocExKYWZvZThKRUg4SVFWVUpHczdXVWlpU3QwN3Va?=
 =?utf-8?B?VVBxcTBKUk1Oem1PMmowRUp2THNvcmxtRFlrSnlDOHBQMzc1NWZDQmJBQXpP?=
 =?utf-8?B?NGZSUlNzMzM0R0xmRGxZS3VZeXVNUmJ0ajB6ZjZuWGQwV3c4TUNWVkNPWXNz?=
 =?utf-8?B?YmJyM2Vja204elNFNXpGTk1wcWRvVGxpZ2RwcnZsaEo1MmlxWER4WmJPMmor?=
 =?utf-8?B?SWhLZ0pGVlNRVzMxQkJtYTJucmJBMk9nWHN1YmFuUlh2NjNaL3BQNGZ6NXJo?=
 =?utf-8?B?dTJFMzg1OUlYa0xEYlJtN2Vxem1hOGNtcHcrUFI0aEhHazRwM0RpV0NGejdD?=
 =?utf-8?B?d1ZoRzFOelo2NnR1OVdBdGtZV0JVVE1kRW9MbnFlb1FLdkFEcisvSVA4V2NF?=
 =?utf-8?B?QVovQ0NhTlU5MEZQbW1GUjBZZmtzd1Q1SUxBWGQ1QXRHVFFKRVRxL0JvbFYx?=
 =?utf-8?B?elJseEUyTUVSSVd5MmYyU3RaZ3ZFWWJrRjN3MHk5S1FVVitVbE9CaUwvUjNF?=
 =?utf-8?B?ZTFIREJoWEM1NkhUNHdhTktVajhLV3ZBTW84NzhvREw2ZWp3WmtrWUNxblRa?=
 =?utf-8?B?UE81WWlVWjZGaWhWbHlTcnAydXpKTjF4TVd6UVNwbVVNdmZrb2NSSFdqdnZv?=
 =?utf-8?B?L2s3WGQ3cFpRQk5KZUpveEpGU3V4cUNrVnlIc21UcVhXZlBBbm5SV1gwekNo?=
 =?utf-8?B?VXlhdS9FT3VYdmRxM1Jla3lObVNuM0hHRlZYaDBmVDBSUDVlTEtZdFJnbE1F?=
 =?utf-8?B?MWluQjBMc21Ib1FZcnBEakc4alUvdkJ4TE53aTY5UHBpaUxvbkMyek5lSnE5?=
 =?utf-8?B?Zng5cjJHeW96dExnTTJQYzVtK0tjT3VMc0FLVGpibURqRDFyRW8vNFVRdTd1?=
 =?utf-8?B?Nm1Kbk1ERVFHbStTN1lmaGl6NkpuL3dQOEF2ekxNdzM0ZC9qMGVXVjJQR21m?=
 =?utf-8?B?a0hUY0NmN3MrdERsQSsxZitvc3hnaFBQMkdrQ0VUNkxsVGJ4Qi9ZZXNjM2M2?=
 =?utf-8?B?TVpZaGlOOXo2T05wdEVHWDlpVjI2R3A5YWFxMmZFRmtDY0JUclBXZWZWQ0ti?=
 =?utf-8?B?R1RNL0FDWllLMDU2UHkrUnIvOW9qd0lIQ0RCVGdYdTBPdmliZStUTldZSUhP?=
 =?utf-8?B?aDNoMGhyMWRjd1kxRTk5L3ZYMHlDdkg3M3BKak54TEtRV2RTcGwreFYvb0Ra?=
 =?utf-8?B?bTVaREJuWnlNWnF5VElaWDhBNkVROEhhcUlDQmR2by9Sb0NveVgvY1gyN3FB?=
 =?utf-8?B?M2lqRjgrZVhRRUg3SDNvSVVOM3FsZ3VuNXRKdUhoV0pHQklvT2ZOZkZCd2ZC?=
 =?utf-8?B?YkJSUEtZRmxTQXkzeVN0NzYxd0FSTmtmbnp4cTYyZ1dWK1V2MUMzbmtxMlZT?=
 =?utf-8?B?TzIrTW1lamRmS3RlaXZncXV2bmJ0aFBIZVhLdnJCa25oaVk4SzRvcnpFYXk0?=
 =?utf-8?B?RytLc3NacXpTMG1jdUd2RXRtUURLY2ZGeThLSmdFeTRnRnRUMTZmWVNoMndV?=
 =?utf-8?B?WFVoV1dGZFV6cm8rc0pONFB1bVpDSGJDMmZBN2xLbTJNTGN4eS9qU0tic3NF?=
 =?utf-8?B?RDIvSkxRaWFFMEFzLzJXS3FvN3pHdXVhNjR5S0N4UW9xU2pVU1VlYy9RNDJC?=
 =?utf-8?B?VnlsRENHZmNIMS9xWDgvV3JiSVpCN2I2bE9DZWFWVm5LOVpUOFUrOGxGblln?=
 =?utf-8?B?UTRzQmd3bjFrcVdvYnE2aHJKQVBMcklhRWpSK3FiY3BEbHl3Z1dvV1ExYWJr?=
 =?utf-8?B?ODRoTkxHOVF6V01DMDVORHlyVnJ4akpQWitnM3F2enV1Mm9XTFQ2OGNxY3lI?=
 =?utf-8?B?UlhQZTEvS1hVR0d6SnJlQVo5ZlpKZXFWWk80MjdBUFJzRzhtb2xEK0NvM3Nt?=
 =?utf-8?B?NDZ2R05qdzlaamx0TFFpcEhyR3ZyTmJtQ2xGTlNuU2Y3Q002L2ZQRDY0anB3?=
 =?utf-8?B?L3ZjR1VqMmdMYVdZZldyL2pydy9mdFJnaE0yVVRlS1YrMEUyTXFMcnE3VkVM?=
 =?utf-8?B?dUpsTTJxaE1hREJMN2owalZBdHpTTk9Dc3ZaRVRyQVowRXJFMmNVMWVhc0xs?=
 =?utf-8?B?MUx4S0JIa2l3QU9adjhoU1BvQTFJUjlid1c0Q3h5WkpTZjJTMHA5Vnhkd25j?=
 =?utf-8?Q?G49Sa0Z+Jg29j+qOcJLMF7QVC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae18eb-792c-4e5e-9ced-08dce8ff30e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 07:43:11.7008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmrUA/h/1p3zHx2gas8nojd8x9IhL7lS+bZzDuomtTzY/1kSoskmsMEhY6ZVaOpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

Am 09.10.24 um 16:24 schrieb Sunil Khatri:
> Before making a function call to suspend, validate
> the function pointer like we do in sw_init.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 ++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>   5 files changed, 46 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index c1ff24335a0c..e55d680d95ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
>   
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -
> -		if (r) {
> -			dev_err(adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}

I think we should probably create a function for that code and error 
message repeated a number of times. Same for the resume function.

Apart from that the whole set looks good to me.

Regards,
Christian.

>   		}
>   
>   		adev->ip_blocks[i].status.hw = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 340141a74c12..51607ac8adb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3471,12 +3471,14 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>   			continue;
>   
>   		/* XXX handle errors */
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			DRM_ERROR("suspend of IP block <%s> failed %d\n",
> -				  adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				DRM_ERROR("suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   
>   		adev->ip_blocks[i].status.hw = false;
> @@ -3553,11 +3555,13 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   			continue;
>   
>   		/* XXX handle errors */
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			DRM_ERROR("suspend of IP block <%s> failed %d\n",
> -				  adev->ip_blocks[i].version->funcs->name, r);
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				DRM_ERROR("suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   		/* handle putting the SMC in the appropriate state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 3e2724590dbf..6bc75aa1c3b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -40,11 +40,13 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>   			continue;
>   
>   		/* XXX handle errors */
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			dev_err(adev->dev, "suspend of IP block <%s> failed %d",
> -				adev->ip_blocks[i].version->funcs->name, r);
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				dev_err(adev->dev, "suspend of IP block <%s> failed %d",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 475b7df3a908..10dece12509f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
>   
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -
> -		if (r) {
> -			dev_err(adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index 5ea9090b5040..ab049f0b4d39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
>   			      AMD_IP_BLOCK_TYPE_MES))
>   			continue;
>   
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -
> -		if (r) {
> -			dev_err(adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   	}

