Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E13C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 06:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F5410E07A;
	Fri, 14 Feb 2025 06:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZffoTjI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0C910E07A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 06:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poO4AhYhDpyND0KhuD4pdpGFJORZjbdUBIV0AQUWDCrKROW46zNpsLgAPx20deihHInbZFfon32z2d2AIDIy5uXct4Qe4PPfmTP0t/R1SrCGicltiME21f8D6YIp7q09mk+rz8FEX/Bnp2tmq/THe8mFbeoqCl/C9hFNnH17ux7I63FadzNTW+6eAKI9bvhROJeQYNiR1nW+HVK3xVR4nvZyOOB7rOfn72/uf/cNqLWbBwi/qTFAJQ6GhFmU3VPE8NdBp/aARiVI3rSI4ppUzCZDxl3kvSxQwirlsSGMqagaBcjnpz1ERHfZ/ZEMnFycpwadTDQAZpUlAiznb/smYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIoKWM+60EPD+NMmeyd5nmKNWRj3yGzgXidPzaDRqdw=;
 b=ns6Q5cWXjED4i+tEmHPZLDhxIY9xDJs1lYK1areA4MN6vv15t2JYUiVrKqDyF+RzuyR7E9CRKsJ8H+iLXHZx1hnAkNDDJ6u2mngMvo94ozg8cnaS9eyQ1HqGf3orPGTuHMkbgxNsKDS4WJbovwJBgsD3+Cvp5ibLIa03wfGt6LGOmlSCz+dLLOvy2MBVnJiij95iblEt1fHersmbi3mY9NCpInXakPwO5LpYu/gUZs5hb4sWwaTfqEtQv2hydPK9gcZY01DfRc07+zRh9yQGuprvNQHD7M2BjjLg3g0ThHwHXQBTCZEdU0pMqwKafCP/Ja2b5ZSgyMqrvG90B4i4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIoKWM+60EPD+NMmeyd5nmKNWRj3yGzgXidPzaDRqdw=;
 b=hZffoTjInaGKaklW5g+BLMvpIdajfRI+o19yoVWWzdN4a3Raop4dgsMp1PZUfa2kh944b2YBsDIAOBZgdS8WWxzpTryPewrS6QvyHRT4e6mEhu0zzZVaeTXcrdGkOHjqDww0Md6aEUd9Q+WCysdd6Fy0jtL2bO7V2RnlqV8Mu/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 06:10:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 06:10:04 +0000
Message-ID: <989be73f-bc25-46a6-bd28-3a2576fdc73f@amd.com>
Date: Fri, 14 Feb 2025 11:39:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250214055534.3249909-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc4e863-9ad9-4585-bdf1-08dd4cbe391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjNveTJydTl1OFZaL0E1UC9sY1IyVFduYVdGMzhYcTdRbHFhS1lqMVJiWDBY?=
 =?utf-8?B?RHlnN1hmLzdmOS9RbUtqaWhYVU96bEpVZDNzOEh4TXhibWlJVmdoRTJVclla?=
 =?utf-8?B?VzVsMXZVMVg2enViVTRJR3BMQmlXS3MrUHFqM2hXN3IrR3hnSmVDVVFNWEEv?=
 =?utf-8?B?d3pMQU50anZrZ2FtZlFvYno0dnFKcHdZb2NDTXlqTlptbFdrRHdxUDdWdXFN?=
 =?utf-8?B?cW9ha3hBTythNVVtTVRiV2d0MDZVRy9pZHUzZXg0U0loWnkyNHJUVDRGeDRu?=
 =?utf-8?B?UlNjVUpXQk9TWHVSYzNTbXpuMHlaMGpsUmVrcUk1cWIzSXRnT05VZEZ2MjIw?=
 =?utf-8?B?RUhLb1owSWpLalBpcVJJVzR3TERmQkJBcko1U3Fmd09PejliTHRZNTVBU2ZZ?=
 =?utf-8?B?aVdub3piL0NmR2dTQUY4VjZoRWI5MTA0ODVCTThmZFpTb1lTMjFrbGlyTndj?=
 =?utf-8?B?dWlXeVArODUyV0wycG1rK0xENXovWHd2dUJvRDc0YkowaE4xUDdOeTFlajJl?=
 =?utf-8?B?RDVuNWpINnFYSEhMVjloU0pGZjQ2TWhIdlVqNk1iaTlsZDFFa3BmT0FSK3Zu?=
 =?utf-8?B?YUlwYWNvenhzM3Q2RExwUFZUQ2VXTUpYekpoVkRtVWpzTlRLMUlXMkprOTZZ?=
 =?utf-8?B?UDJIQTJQeXJwMDl4S28zTjdrMUhiaWh3bEtFUW55L2dZZTBaSGlyRzgrcmZU?=
 =?utf-8?B?c3NEUTEwT0kxeVdWRFpSWUtNK2dxS1BDUVNvcGhMc2taYXdTanpnQ21EWk9S?=
 =?utf-8?B?bEdrd0kzOSs1WXA0OHJjNWlDTDNJQkV5VWtHYzJwbTdTVjRaU01RbVlSMk9V?=
 =?utf-8?B?TjROa1lnQS9Oblh5U3VoUVBoMW84UVhuMjE2VXgzTVlXd1VHdWx2ZjdmSTRD?=
 =?utf-8?B?b0pQajhGb21EN25JOENJMWJjMUNXWWtoOVRmWkxheXRqKzdrdi9QUk1reEp5?=
 =?utf-8?B?dnIzcXRpeWRNaS9WWXNqWDZGZ1pYMTBWR1d5TlZkNlpwUThXcVZzWElBVThV?=
 =?utf-8?B?UWo2cHpQbFc5SVJOM0Y2SzVRajZWYUdKUEpSand6cTFZZUpZekw3VjFJRmdF?=
 =?utf-8?B?WGh4V21DWUNUUVNRTVpBM2FEODZoQ0h1eUR1dHgxcW15VFNLbTlQTytpSjBj?=
 =?utf-8?B?K3p3dW1QQllmQitVNndiM3FYMlk0RFlydDFpbCtDWVdyRVpmUjRSbHpUYkdo?=
 =?utf-8?B?ZWJXb0dHSERMNzJESlFQeUEyWGZJUFRwVFNhNkExUU9MeTFxaHpUWnl4c0pT?=
 =?utf-8?B?UHFQTVdMeSsreGN0Q0NRcTFQOVhuQUsydFo4amlNdS9nM1AzNDAraERadWIz?=
 =?utf-8?B?N3lXeTh3V2d5NTJuY29aNzBDcUZnaUNTcXRGNDM3YWk5OTBtSWRYZGNieUxx?=
 =?utf-8?B?STZDV2xDOUd5djlhYWMzRTYrUU9EZDlxbnIzajVieHVSUWVyRGFqS21GS2tz?=
 =?utf-8?B?T1RiczVYK25mRUdRRnZiSVV4cXo0MGZyVlhQQjZycU11d21wUlhmUDB1S2dP?=
 =?utf-8?B?eThoUW4rQndUdEdqWG5wVlZaNzdvdEdIUVRlU2NWMFQ0QzZXc04vcTRTb3Yr?=
 =?utf-8?B?OXc2WnFhWE9yVkNZV3pUWTVXR3BGV2kxNHc0NEtESTRNUDk0NHdPZC9OU3BJ?=
 =?utf-8?B?Y0VwSytFUUVQUHdtOXI0RFJ6SGEyRTBSVktpTUNtcS9yNDRkK2NUaXJaOGtF?=
 =?utf-8?B?Slpic1ZJNWtaTnZRYTRnYnZTUHpFNWtYd21NM0hmNTNIaEI5VGs1VmNaVE1M?=
 =?utf-8?B?bGpQdXJ4MFlzVXRpSHY0Y0hxejl2aGpMaDNOMFZXZW1TMGl0RThHd1ArZy9n?=
 =?utf-8?B?OVZyRmZDOUIwU0J2bVlZZ2hFaW1vZjhUOUNRVWQ0VnR0M0wxMk1hNEFJNHho?=
 =?utf-8?Q?g8A1xJNkV3QC6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUU5Y1BodXJvdG1NZVNaR2o2Q0NmaTFscVUyN0VFNjRnNm11czI4VUFnK0pl?=
 =?utf-8?B?T1VrWFV4MWRVeGRNeDE1ZWN5SWtjemtVdEhubmM1bWRrckF1Z1RMKzQ0NkRu?=
 =?utf-8?B?Vzc3VldKQjVBS1o0VHI1TFNSNGMrekd3UUlZdnRmNENWZW1uZFpXSGxaOTYz?=
 =?utf-8?B?Ni9jVnpqYUpaeFpCNnBjZlF0OWxuYmpTSytQUVZ6UGwxSG9idmxGczZVSGlz?=
 =?utf-8?B?MkJFZjNZK2pFRHJid3FuYUtsNUJkaVBZUWNKbHFPNlRRQUxKSERCMDcyZjdY?=
 =?utf-8?B?UHk3VWRvUVJlSW9hUm1kL0RWdVJYdFFCRStMOEJUWjUrUU95TEF6Z3RiV2Fw?=
 =?utf-8?B?MlRrNTZSeXZvK2NtRWo3ek9vczJxbXRxTzFiYkJMTjhZaTV3eVloRUpHS2Nn?=
 =?utf-8?B?UWtNaWVHZTZ6eEpZbTY4RDlDQmVsbUJRTEp6WFpwOGxmaU1MTVFidHBwYlVJ?=
 =?utf-8?B?Z3poQXFtd0dRR0FPUVN4ODd1SkI3NzQrSmhPT013QmpQNjVZVDAxRmtWOVVI?=
 =?utf-8?B?T2ozTFQzTHA2RG5semZUYWlEZzNoM3FWenp4em5GcHlNOGpjamo1QTJHYnhB?=
 =?utf-8?B?VTJ0QmV1ZEVoUjFVWDhvSC9qRkg2aldSemd5S0VHbE5Zbm9NdTlTcW41WFo4?=
 =?utf-8?B?Z3FXaGgwS1kyOEczQU1hdGhjaEhqNHhXNXdpMVBnSzczS3ZoRkRNRE5uY3d3?=
 =?utf-8?B?RlpxMllMckFNdDd2cmpuVHlRci9GVG0vVk1YSkRvTFFLUFFqY0ZGUFdsanF0?=
 =?utf-8?B?bGc0WHV5SXY3RFNGTWRBR2pCa2E5TWt2dTBDRjV6NDFNenNCN0NpNDZTM1NL?=
 =?utf-8?B?R0E5Q0EzS0JVSXdJVWI1YTBMNDBZWGVvSzVwMy9MUkIycEwrdzdRWGhDUzVw?=
 =?utf-8?B?blRib2hNSXRrNFFlRjBJK3J1MjlDaStoYUhlZzl6Qy80MU45L1g2bk5hMlVW?=
 =?utf-8?B?ekhPM0NKWEtYSVcxeGdSYWFjSml4TlJNeW5YKzlZQmZHR0lIdDh1U2YxSWNh?=
 =?utf-8?B?akZkZkt0M3JNRS9YTGlRNm9sUytoSUExNGVOcG9seE1XTzladk9FWFRDZWhK?=
 =?utf-8?B?RU1ka0pTZ29xKzZRcEsxcnBJandJY295TmRZOXZBd2xVVGZFZUIyM1IyMzBQ?=
 =?utf-8?B?empScmltblg3RlhRN3MwRkUrbXNtNGhXS1FXZ1pQbHNDUFFhWGpYY0hEYk5s?=
 =?utf-8?B?VXlpdGZDM3k4UXlubHZwUU0xcllKRTluRG1MdFVpa0dZWFJHMkJRNGxJSGxL?=
 =?utf-8?B?ZTVXdVFxY2E5dTdRd1AxeVlMdEtKN3BiUXhqampvMUtBMnFZZUZOd2tZTVpK?=
 =?utf-8?B?L3FrV0tVdWVtUENlQUpZMk44d2F2S2YxdTJCUzlSUk43OVFRQTM0bCsvcmM3?=
 =?utf-8?B?TUp2bFo1Q3ViZGkyQlMwK3ZUMzYwVHhESEs3T0ZVbXJQK0EvcjB2N3lvUkdx?=
 =?utf-8?B?cUVTbktBZHJiZmFuSWs3TGllbnR5dDBnby9RQzRlVHRBSWhCVGxNdElFQ3JG?=
 =?utf-8?B?Vmx1OVVOWWhPcFFhUmZFQ2pheiszTnBJLyt0dzd5RGtHV0RlSElhWjZpZEFk?=
 =?utf-8?B?OVlmdkREd3NLbUFnWVlxdmltWVA0QUc4Q2tkaDVoUGI1Q3d1ZkkwNGk2bW9U?=
 =?utf-8?B?bE1NWVJrWGtmQU9LdzNwQ1JVSnVMSUw4aXJKeC9uVHRhQkxXeU13dnVaYmc1?=
 =?utf-8?B?RWFBRTZFdWZ1YVBndjd0UUR2TGdZd3VuV29QRnM4OHJIOHNrQ1pGb3EwcmQ0?=
 =?utf-8?B?T0lOTTRzYkJBeGlVSDErMXM2S0tVSmFkQ0E4UVZxWVlHQ0U2bXI5Ri8yTzJS?=
 =?utf-8?B?NVZkTjNEay9oSDkvckdoN2JHU0FTRTVZRUJhdGFkQ3Azc09BVHBsL0w3eXo5?=
 =?utf-8?B?ZmovWFRITWVDRWxmTmNjd2F4YitPelhaRGFFSG9RNHp5MFIwbHBmaXBwY3FZ?=
 =?utf-8?B?cHFrYmZxWG5Fd2M3MmZCNllyVnVYNlRwT05kZWQ2V1ZOUnVYNTFBa2pzSFlq?=
 =?utf-8?B?bnVpSE5FSnJybnhiUzdDc0QySm1SbXZQa29SYityS2s2TTBKNUxIREovN1l2?=
 =?utf-8?B?YXRVbCthK3kvSjdlT2p2NzE1T2Y0ekcwd3VkMXh1RkwvWGRVcjJHZzgyZkRu?=
 =?utf-8?Q?g3dHUEH72GldZbWZbZsIKNsnp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc4e863-9ad9-4585-bdf1-08dd4cbe391a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 06:10:04.5257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LE790rWUGiPF1lQ5NxGbuxFNXqhJ0WvZJPnrlfZPOR2JuNqjMpMnXVd3qg/Rl8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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



On 2/14/2025 11:25 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This patch updates the SDMA v4.4.2 software initialization to enable per-queue
> reset support when the MEC firmware version is 0xb0 or higher and the PMFW
> supports SDMA reset.
> 
> The following changes are included:
> - Added a condition to check if the MEC firmware version is at least 0xb0 and if
>   the PMFW supports SDMA reset using `amdgpu_dpm_reset_sdma_is_supported`.
> - If both conditions are met, the `AMDGPU_RESET_TYPE_PER_QUEUE` flag is set in
>   `adev->sdma.supported_reset`.
> 
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index b24a1ff5d743..e01d97b96655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1481,9 +1481,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
>  	adev->sdma.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> +	if (adev->gfx.mec_fw_version >= 0xb0 && amdgpu_dpm_reset_sdma_is_supported(adev))
> +		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;

This function is reused across multiple IP versions. MEC fw versions
aren't the same across those IP versions.

Thanks,
Lijo

>  
>  	if (amdgpu_sdma_ras_sw_init(adev)) {
>  		dev_err(adev->dev, "fail to initialize sdma ras block\n");

