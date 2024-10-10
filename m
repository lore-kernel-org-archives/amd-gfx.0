Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D6CF07C1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 08:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8609B10E893;
	Thu, 10 Oct 2024 08:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xo8y5KDQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E8410E893
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 08:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOS/bSYCx5MXegd+2dKY8krgMiGbSctxTUJj2JpEyOdw6rXbe+AbmfKRkr568vPZCdvr4VEeuAbgI28csJi1Y5/+zdZNAQkQI8Ns3XELTFbe3YIxjdpW+ZBJ7tZ2eo8wE/XooUSRGSDuUtXWUOPUFXMf0I7TKiy09dKd4G4/5hB8BsTY+afJGEq3jyl04FsowABLQW+n5z6r6oh3JIShkYpnoq+zSihaY8eeOGBMWOS+6sl+xja4P7j9K65zRgRjJyyH4oDriKze6kV+/6qLEH3nI1cJYG2uaBMX7m06QpubWrmAr2Nn0Ig+2ZcHcmNpTQRkTWFW5bv2+FEJRqbgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPcy8rSCvxg+ZkfmChAOdlFs0MUzcg0dMAoKLopthh4=;
 b=o7kz20qKAo+nbUSB/xW2YbKzH9Mbc7d2KEG9cRvwXvSmLebi7RzCIrd3BYHiHV2CYO6wzfpcxQ54ixJtiT0MFyaHueXUCuOeeBaSPDFcrJUOrBZzAlXVwaCujxbFNzuLI6LmX+eElELpvvSEjgBo0Gu6P5Qv9ymCRT9k+0Kl5SczHj2K93Ozas/7wNL8mCNxGef2oEFTUc3kSkGLNI+DXDb2vXb8bxtrZ+hwtDOi3kKP7OXSRyHC4HcBY4XbC60Z4zrdcXKzQNv04z4RYJsbNMcUqHbkn2x6Ux/qPTEzuwh92ySTYGBqx54qRTPfF3AUb03t+bpXK/5Wu+XaCUzJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPcy8rSCvxg+ZkfmChAOdlFs0MUzcg0dMAoKLopthh4=;
 b=Xo8y5KDQI6nr9EOiIpnybIG0QJXKOPRfxRjHEutJmu/VmfrEtzAIEr8jyPZEpqicEXFZ11TiZ/K9CNs0Vu6HzvU/beQr82Wa6WQa9d/1+U2+UZWNeYPHsKyqUdr2yfpqixUkgLBX1/dk42FExHguYlE4duWCUmYZQfmxWUwHBEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Thu, 10 Oct 2024 08:12:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 08:12:24 +0000
Message-ID: <832aea2f-8692-406e-874e-679bbf0c33a1@amd.com>
Date: Thu, 10 Oct 2024 13:42:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ae226e-b7ac-4300-693e-08dce9034578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWRFRVp6RWVYWjRUeGgyWGhiZDZZa04wTDBPWEI3dGtwT25NYm1ERVViVExo?=
 =?utf-8?B?ZjgvNE12ZGt5WUE3RUcvZXAxdlkrSmVGajE5akFzOU1qRWUwQzE4RU9XSDVU?=
 =?utf-8?B?UFpJZnRNMUczc3dBajV4clVDUkw3SlRLaHkxOUpLQWgzbGR2dkt3SVE1Z1Jz?=
 =?utf-8?B?N3g5ZkI2Wk55Wi9wc3NVL0JKT0ZaTS9kNHRIcHJvZFUyYWJCaThpVjd5ajQ0?=
 =?utf-8?B?cktlbFQ4emVFTi81QlNGTkE5TzREUWU5RXYrZnVBVkJBMVkrK0dEa1NLVmVK?=
 =?utf-8?B?dis0d3lJcUlGc1h3d290OEVxRkNUVW5YRytuNS8vRXJOQjJKNlZkV2JIQXhy?=
 =?utf-8?B?YnZhUXR2NWw0cGwvVmpwMEhxZlpKOGRJT3N5WkZ5eEVkK0RjQVoxWnJSU1ZX?=
 =?utf-8?B?TU92WVA2TEcrY0ZoTG44TTd0cnpocTF0emZ6aGtNTTFJZmNrUWM2TUQxTi9R?=
 =?utf-8?B?RGFISkV4R0htaC8xbTFhbjRUa0tYWkg5MDNMSjVDZXJGTG1HZVFuMzJZTHdI?=
 =?utf-8?B?MXJoQlYwZDVCUHdMdExLeE4rT3ZzRUpUNGt2NG8vSjVWZXNqK0l4dTg0VHUw?=
 =?utf-8?B?akFlTGw4U21xVkN6V2tPeXhSQjl3ZWtsV3F0QTB4UFBSMkd4NGpqd0NiQkt0?=
 =?utf-8?B?eWFGM2ZWQXdRRnN3MGQ0dS9OREtaUTlvUDQ5TGJqVUJWZDBDaThVbFdCTHlX?=
 =?utf-8?B?VHU3V3cyakRmZ3oxRDU4OFlRRnh4eHFSWlRYS0lPZ0dlN0hnTnZXUFZ2Q2FC?=
 =?utf-8?B?R0NQeUJPaGdhS0hyTUVhUVJTN1BSRHppRkoxN00vaUNKWkZYdnAyRmQwaEU4?=
 =?utf-8?B?ckpod3lXUXdYQkFNMVVYdnk4S3I0ZnFRUExXT000RmVxQjA1SE0xVVZaR2lv?=
 =?utf-8?B?V1NhT0ZDR25hMkNSZk5PbWFFMFphdlE1M294cWl0MWd6eVAvME9oM0VtelBR?=
 =?utf-8?B?anZXUmF6RmtPZDZEMG83eHVOYzNTUWY1eXgxd3ZES1RjZ0NjVGJKNXBlWWVl?=
 =?utf-8?B?a3F1VW5Sc1UxQlF0S0l0WTBvVmJ1UEUvSFFubitIOUtXYWQ2dldYSkphdG1L?=
 =?utf-8?B?L056VFZZaVlPR2tyK0pIeUhLSE1vQS9QQm82Qms5ZjFQOUJwcU9SM0hGQU9i?=
 =?utf-8?B?NFpYVW9oSG13UWpiSFg1MzQrd255eklSaG9Icm03QzJEZDZwMTYyN3VCRlNR?=
 =?utf-8?B?T1pLMXNZUC92SjZHVlh1UFFZaUFFdHdxbHlrd2JhZDVaVnNwUnc5cWFOajRw?=
 =?utf-8?B?b3F1QWRzKy9kQ3BEUi84S1dGazFkOE11SDh6eVZMRTl3SW9mMVI2NEtwMFpZ?=
 =?utf-8?B?eEt6dmc0L3EyZFVYS3VjYXhzQm5Ubmp0SDJUUnMvSU9Lam1tWTQ3WDVDK3Rw?=
 =?utf-8?B?QStLYU5xOVlFb0w3ZmRZS1IzWWJST1N5MUF3VU9rb1YzV1RCQzIvaWpTS0Ir?=
 =?utf-8?B?RXlVU2xkeDJtTW5ONDhUcnhLUVFkSE5EUVRKT2UzMStuR3FsV211WHBWb0hz?=
 =?utf-8?B?Uk8vN2NwNG1LWGlMem50UGZQS1Q5VEJlUWluZDgvU1VlZ1JLUHc0WThHZXNJ?=
 =?utf-8?B?alNBd3o1clhweXBzZG1saldka0JIWThQMWlXMWRoRE5MWjZxYzg2R0d0UlZF?=
 =?utf-8?B?ZXpxYjI4ZWtrSnQzL1RUMGYrREkvY2hyRkdhbG54Tm51SksvUld0M200ZlhO?=
 =?utf-8?B?eEJZMEdQMnpsU0UzUlg0K0x3U1JNWXdwVG9BZkpITm0vcytMK0oxTGJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFIwTGo4Q1pPSlN1UklYWCtYL3FxYnBYWGhvT1RmNEthVHJXZ3ZBQkNVK0NK?=
 =?utf-8?B?VC9LTTRaRHROTjFINzJSUlpyM3pLbE9PWC9HM1RuSTZOam1iU3N1WDhqZ0N4?=
 =?utf-8?B?aHBLbnBDSFdnUUQzMU1iV3pmeG9QUXI5dkdwS1RYUUFaUkdLRktHdnF0STNK?=
 =?utf-8?B?Rm93dXB1RnlIdWM3UlNZNEtNamJzdGZ1OGRRdXg5a0k2RlVGb1RUWllHc293?=
 =?utf-8?B?dEw0ZHJ3RDE0UzRndkFJc1FiUFA1ZTRIQVpXeGZMMW54S0tYMjJhNWRteXRI?=
 =?utf-8?B?STFvZEM5SFpaTzBhcCtnc29NblFSYTRQVFppYWpPVGRpalVtcTUwYzEvYytZ?=
 =?utf-8?B?VTNLYzBxSG5oOEV6bHpTekxDUTYwU0tJVnhsdzMwSWZSMzAvZ0Q3TTdmV1hO?=
 =?utf-8?B?Sms5ODZ6SFRyc3d1MURQck1HM2xGWS9hVzQvNjhLSXYzYjJSajdxQURyL3BL?=
 =?utf-8?B?azhDblNibVQrZ3JEa3FXR3NIelUzMDh5Rmp5c2NDaWE0WXdMTHRyR0pHQ09O?=
 =?utf-8?B?dnJaRHMvVDB0b0szV0pEeGl3YjBmK3pIV1IvNDVJZkRjNmJBT0FCOWNZQ2hX?=
 =?utf-8?B?RWdveW5kczMyTWllRE1RVEpZK0F5UWsxQ0JORzVlRFhJVzNEZlMybTRhK3NZ?=
 =?utf-8?B?S1hFWGJZRTdmWWpxeXc5cllYcC9aNXNGcURKSHpqQmRqdG9ybjNiNE9lOXFy?=
 =?utf-8?B?ZGpERGlYb2k4MHpCQWtqK1dyUGJsTE90N09EMUhCN2R0V3E4MUF2NnJkQ05G?=
 =?utf-8?B?YzNGNWtEeTRNb1Z2cmJvSlVwRVpPV1ZuU0lnL3VSQm82a2NoT2xOcVJldzFU?=
 =?utf-8?B?RFF6N3JmOFFVVktnRmZ2b1VlNk1UNlFydU9DUG5QTFlRbVI4SklsWjh0WFdN?=
 =?utf-8?B?MkgzZmQ0ZG5uekpnOGNuQzhOM0xUVVhhNVpwcG1TRmFUbCt5L3h5Q1NuNTV3?=
 =?utf-8?B?dFpjdUdhU3lpS3FzTUpUQ3c4UjZRTUp6OXBxc2NQcEJaL1Z5R05PTkRMN2x5?=
 =?utf-8?B?WEhZNGJPcGV1L2Q0blZmU3VpYkJPOW9GT29xbWQ3VGx5bW1FWEhRaWd1QXZF?=
 =?utf-8?B?ODk4N1dMQ05Ccnc2cWxrY05qNFFmRmlGV0cvWjdRbmtiT1NYb1pYcy9XZDJ0?=
 =?utf-8?B?SUtHNit6clM0Rm0zek45K2hia1g4ZE5mU0NGMzZYWm5TUER0a082eGhpSkJu?=
 =?utf-8?B?TlA4VHkyNE5yMDVuQXhFL0EzK3ZkcHE4OFNUODNyd1I4eW5MellKV2lHZDlR?=
 =?utf-8?B?UUd1QmFBL0Z3cUZkK3djZjM2emlrUDNGU3d6WUpGaWp4QlptMHRkcEFnTVhH?=
 =?utf-8?B?L2kwQ0JTbmhNQUMvQ1VVUWxYanNyQU5CK2FYRFk5cG9BbnJmdGtoRjFyR2tV?=
 =?utf-8?B?K3dnVUFpcTVtN29QMW4rMXlkdXhSdHE3Z1o5OC9mSG9JNnFZSmh6T05JeFZw?=
 =?utf-8?B?TzkrVmdkc2xEVHZNK3RpUHhtWnpsRzk2OWM4WVVvdFpvUk9ZV1k4bU10bStr?=
 =?utf-8?B?Q1hDb0duK1ptbUs1dXdkMGZQQ3FmQ0dNeGl2YmRrVUZmMjhUWjFKa01NUzNu?=
 =?utf-8?B?L0JqajJTQldpSndBZkdjbjAycDdGclVYcGk3SHBneWlnb3A0R2dRRTBhRUZk?=
 =?utf-8?B?cVd5RmFGd3p2eUdnRDRHRmg5aHc4TlRxSEhOOFJSTTBMc2sxYlhCM0M5cG9w?=
 =?utf-8?B?R1BBcVV5b2pZVEZEaDJHMDl0cnVVQWFTRnNFT2o2VnF1Snh6c2NVdEg1TzNu?=
 =?utf-8?B?Y0d4bGdVcy8vMEJoRmNFTzgyOEhncW1nLy80QUlxQVZ1Y0lRbUhNcHJyT3FT?=
 =?utf-8?B?TDl3NkVxUnZLcEMvelVrM3VMb0d4MGJMeGc2a2NjMlVGUjcrOTRJdXREUEVL?=
 =?utf-8?B?ai83THVQUFRIdHl6SlFOTFN5bm90alg5cTVoR1hkQm53VFJkeTlSek04M2Z4?=
 =?utf-8?B?UERLK0xOeHY1cmYyZ0NzTjArV2pRTTdUdnlCQkJ0VDRGV1QvQ0lqdXNwRkFo?=
 =?utf-8?B?YWFYZ2lqZWtueGdUL0pDSzFkS3RYeFRodnYwMkU3ZktLSUp3alAwUk83aTNk?=
 =?utf-8?B?cTNQNFV4Q0lPOExvSUYyR0RKREJzMWJ1bnJxUjZnQkxSSldtY2w3M3VNMU1O?=
 =?utf-8?Q?PccOA4o2nSoqoz5qijG8RAcaY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ae226e-b7ac-4300-693e-08dce9034578
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:12:24.2855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4Z4o+sQgo6SyvQaDJ8KnN7H+r3kfbYUSBj8BMNKscHU1zd5EqGbpxZuZoTVT70N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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



On 10/10/2024 1:13 PM, Christian König wrote:
> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>> Before making a function call to suspend, validate
>> the function pointer like we do in sw_init.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 ++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>   5 files changed, 46 insertions(+), 37 deletions(-)
>>

Original patch series is somehow missing in my inbox, hence posting it
here.

Below ones are SOC specific files where we know those blocks implement
the suspend sequence. If they are taken out, then that needs to generate
attention. But this check will cause a silent skip.

aldebaran.c
sienna_cichlid.c
smu_v13_0_10.c

Thanks,
Lijo

>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> index c1ff24335a0c..e55d680d95ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>>   -        r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> -                adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
> 
> I think we should probably create a function for that code and error
> message repeated a number of times. Same for the resume function.
> 
> Apart from that the whole set looks good to me.
> 
> Regards,
> Christian.
> 
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 340141a74c12..51607ac8adb9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3471,12 +3471,14 @@ static int
>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> -                  adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>> @@ -3553,11 +3555,13 @@ static int
>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> -                  adev->ip_blocks[i].version->funcs->name, r);
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>           /* handle putting the SMC in the appropriate state */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 3e2724590dbf..6bc75aa1c3b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -40,11 +40,13 @@ static int
>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>> -                adev->ip_blocks[i].version->funcs->name, r);
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 475b7df3a908..10dece12509f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>>   -        r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> -                adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> index 5ea9090b5040..ab049f0b4d39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_MES))
>>               continue;
>>   -        r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> -                adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r =
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
> 
