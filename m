Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74058CA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 11:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8D910E86C;
	Thu, 14 Aug 2025 11:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZnS9GDx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBF110E86C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 11:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t90x5UGi6Ah+qKmhHy6IBq1qO6wz1UhtgHjuq95HO7Zj685qFyx48XFsCcx2AiSw5gmbcxWa/H5rahXoW92IKB+OIzTrvj6Z4Wp+JAd4xyMj35dkQQenaCACiOVCCgMYjg4uh9SxvAT6IDkwKoAQKPG7IsWxnQK5axa7oYEIL9W0fXL6v3qwFCKl2a2CUi+x4lwW+A+IjwJ/2t/lI+C1cSfJITeoKh0OO5MsUbduLvcVdW2rIZrpKobAynuafi4RZ9eEQGBZFzJgrqiN2plpoP8oZHAThOWPHdViSm3VOrqV3DzaEuOiAc0SpoZqjfIdpYpnP0C6PYlB/Rl0wRJTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBSWDlkqZjSJKIPTl4xis6tinwIlBNgNd+v7kblaaR0=;
 b=ppOwmAd4FPsw1r4WTVZH2GuwUdlJdvo6T0t77h74TEX4E6OA9196m7Gtxh6G9BvSG62c5gKfGB5y945IyJiqlmwwzkAM/JYGX6rxUqheMdxQCZMKbKPeTSFheoVzIloS5sOxTV4wiBXJW5TBPG3lv2c0nFezVcqnqCTMAmg6tTzwui7ROiUP97go6BwGtGlpWBC+VFvzhZmfOC18TE78br/vhvwQhjiuG2I56KxfOsBqgrBwHNpoZLv62QeolTzfRfiYCN82OOjnTpWGeHpnaaRIo3h04tCuPfZ9gnizYfOERjyzNa5+dELmerga8wacNnd8jH1j+Pgg8C7rZKx8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBSWDlkqZjSJKIPTl4xis6tinwIlBNgNd+v7kblaaR0=;
 b=pZnS9GDxvMfO0+wi/lAGrlsazWFu6UcHNU2JRLbT7ekvq/AUuZiXCVrb7C2PapE5wFf5u+EhURlQFA6/VTrVdn1OxE9ahJDqckA/fvMRTnkJLoJDYEHpcpiyn0oJVobFuWCOTYm+YynS6Hfoy5aYoqLYBKsNgUflY/WFCbvrQoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 11:51:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 11:51:21 +0000
Message-ID: <0061d3ec-5245-42b1-8fed-ecf46f3a8220@amd.com>
Date: Thu, 14 Aug 2025 13:51:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/4] drm/amdgpu: Allow more flags to be set on gem
 create.
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
 <20250813184953.3666821-2-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250813184953.3666821-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e57303-4108-44f0-587e-08dddb28e2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS82V29zRFhWOTF5dm1ZVmNqeGNTWFh4ZzVvcWlzVDYzeVdUNDZZcGZCWUls?=
 =?utf-8?B?ZUNweHdwVXBDMHFSSXpJODNYeGx0dUc3MUdFWW93enU0dlBxVVdtTWpUYTdE?=
 =?utf-8?B?ZHZvczlDc09jeHRWVE9DS0VlWDlQMjcyN3Y2RW5QYkh6Nmg1UjYxRWpLTEJs?=
 =?utf-8?B?RG8xMFdVRVFzRjZISVJYcVBicTM3aFROTG1oVytQWE1WbzF4VlVWSCsycGlk?=
 =?utf-8?B?d2wySjBQTzlVSlRaNS9tWXJoNnV1czBOeVR6ckZjMVV0MllXN2V1WjB0TDFJ?=
 =?utf-8?B?NDVaczVZdHBDUDgwNnNaOFZnMUVVNU0vVnRRcjdMRW5QNk93M2NmZTAyM2tZ?=
 =?utf-8?B?VUlkb0hueGhLa3oxOVVOa2dhUE54MkhVcENGSTZhMjk3VXV4dmErTGs0aU9I?=
 =?utf-8?B?L3BsQ0dTKzZnLzNqRWVIVUFNN0tjOHRYcGxUY3hmdVVzUml2Q2J4MUR3QjBD?=
 =?utf-8?B?SkFxQXhqQkp1NGQ4L0lBalY5MFVmcmFVNlRWWTZnR1BseGJCUGtQclBnR295?=
 =?utf-8?B?UnVLeUZrckdMRnZIN0x3T0VReCtIZkhFMXR1RkVFS2hndmFrcUJFNUlveEpP?=
 =?utf-8?B?eFdxRnlCYnYyc3UvV08zRk9aNVRYQzd2dUNoQ1dtbUV2R3lZMmpNQXVwSzNV?=
 =?utf-8?B?bTY3VWVGc0lnazdwS01JTGdzZ25TaVp2bzNIeDRJSmJrWVo0dFV3c1VaZkJl?=
 =?utf-8?B?ajhMWUh0dVVmQ1BTQ2dsNlRETGcyMDhZcGtqVXlpejNVemtrV25jMU5qdFhB?=
 =?utf-8?B?OENMTVVMaEl2U3dBRXpaVUR2T2lqYjRmMHdvOW1sRkpsa3dncjRBWUhGcVVs?=
 =?utf-8?B?QmVrb3o1ajNndmd6cXZ4aDdneFFzK0QwcXQvSkc1Zkhjb2hySkNCbmlCcVZm?=
 =?utf-8?B?N3FxTVZ6YXRPeitSejhmbHR2LzRxUjBKTXJrekV3S1NCTFl5enNVdWp4RmQ1?=
 =?utf-8?B?bTBJQWJaWXV6N2FBTXg0dUFtenFaLzZseG1jUWQvUFB2dE9rdnB6L2MzUGlZ?=
 =?utf-8?B?VENrdFFyK0pUNVZZbFdEWUZsZDlqcTAwMHF4dlpxMXZheGswbmt0R1BhZkQw?=
 =?utf-8?B?Rm96empiTWpWQ0kyVkUwN3hPNmlDRjRPZzFtS0NTTDRGakZnOXN0ZGhtQ0hZ?=
 =?utf-8?B?OE5Lb2NIWi9zbjcwWkt5OEVUWEg1angrZXR0MDEvTjllOU1NYUVHOEp6am4y?=
 =?utf-8?B?dEFucVYrUGZFa1EzaVBJaFpFc29SdEs3YlZvRnFmQnlNWGFFb2VjUnRoeVlV?=
 =?utf-8?B?VnQyS1grOUc0VFBGSWlPanlnVHpEa1FFZ1dMbkd6ak9rOUlOVTd4N3lGSXRp?=
 =?utf-8?B?TVpuR2tzQXhycndULy80cGZjeFlqTlRNRGRFMHpPT0tzRVZFUFlMRHZzR2VI?=
 =?utf-8?B?Z3ppMEFxTEFIY0JLMElScDRSVk05akFCS1NWR2xzTmlMamZyWXREY2F5NmpZ?=
 =?utf-8?B?a1liNExYT2drbFdSU1NGa3J0SUhnZUI1Vlp1QVZZejRQcUk3Ny94RExHeEpV?=
 =?utf-8?B?L0dkZ0lwUVp2SW4rS25nUzIzcU5hLzRxb0YycFFEcElIOFZhT0lsK2I1M2ta?=
 =?utf-8?B?R0lQT3oweWRqQktrMUMrTTR1c0tITytaWUtQTlhaUUxSRGh2d3V1eWRIRnRN?=
 =?utf-8?B?WmJWOHZTQWtCaVpWY0srN2JFdmFtVTV2aGY1WTVFc0Y2eGpuVEVMWWUxMWI4?=
 =?utf-8?B?OXNBVnhrMW1mblcxb0c5SHZuRWs0cmJXRVNVVVd3WVNVdXJQckxBU0R5aC9R?=
 =?utf-8?B?WVMzVjhkR1RpczlTRDlXNEtLWHRGUGxac1ZhMy9pcWk5U2o5bW54Qis3THRP?=
 =?utf-8?B?Nm9YZkhicGd1bUwxZ0dlRXVRb1g3Y0ZJUWhOeWNpdHpZTy9DdG01VXcyb3Ex?=
 =?utf-8?B?Nm4zUHlsbzNKWnVwSmo3TkJxL1BKRXpWcTFvOW54RVJyOXE3ZUsyL2h1L2VW?=
 =?utf-8?Q?EAtBioZk2yo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldqWW04VDNFN3NGYWFpZ0krOEVRRktteldWT2hWLy9CMmN0ZUg4WSt6bUt4?=
 =?utf-8?B?YnNjNGg2ME9mQ2Fkc0V1RjNyRm1TcTFaeFVNQktQRGVMMldkMUZMU1dWaE85?=
 =?utf-8?B?SUM3V1Fjd2w3K2kzMmovanY4cXZkMFVndWNKa1NrSjY1YkVRKzVldHZXODVa?=
 =?utf-8?B?RUc0dGV5a2lDYzk1b0k5Mzg5OXRobktOeDE0WVEzeWdTRG1QMDh1ZGM1cW91?=
 =?utf-8?B?MytkcVQwUUdwOWgyU2dnQlZRNmU5VGV2aTJnMk1sZVlGd2VkU3BZMmp5eEtW?=
 =?utf-8?B?Yzlqb01MUFZNWm15c08wV25WV3BhWWZheFNEU2QxdGVqaXNEQUk5SWpqM2VT?=
 =?utf-8?B?cXA4V1Zld2lUbGxIN3E3VU9vbkdVOGpJRGlGbVZaRVpRTTZSNkhJUUpIcXZu?=
 =?utf-8?B?N3U5RDloUVFwWHhXTnZselhOSGQ3WW9zaGpqUjhVUkgvSER5eWg5UGVSaEgy?=
 =?utf-8?B?dmZ5KzNsU1J2c0JrdnBVcDU0bXZNbW9QSmxoYnplK09zNWpNUUVTMlkraU81?=
 =?utf-8?B?aXRWNDNBOEtnQ2V4ZkFUQVlpWnUreWtnKzdoM3ByUU45VXhyRktscEo4L2pK?=
 =?utf-8?B?WVo1QW5XTVFpemFjUmwrQlRZL1RDb3QzMUd1SlBJaVVPanhnNCtCUExudzNK?=
 =?utf-8?B?VE5SLzZxdDJWVVRiUFNyejJCMzVCR05oWW9YR3EwNG5xVmxQQ2k2MlJvUGpl?=
 =?utf-8?B?ekdzTVVGT2xOM0U4V3Z2VTVtbFdXRnRDaVFhd1p3NHp4QldyUlJ3ejVEZCta?=
 =?utf-8?B?SlZMTDFZL3ArZWUwTWo3bENQSDRnQ1NFR05nUkg3MlA0Z0xoZTMvVFVkdDFm?=
 =?utf-8?B?S24wU0s0cTg4TVlVUEhQR29iL1VQOEhGSTF5YVZLRTZVcUxVSm9LbnJqQjlQ?=
 =?utf-8?B?Ykh5NW40bTY5NmQyYzF3Y1pxSEFQNzJ3OUJRa2tIUGJNSHd4TC80QWlEUURO?=
 =?utf-8?B?ak02SUtxd1Zpd1E1Z0RQaFVNdTkwbmdETE0wTTR3QlRka0lNdk1vWGpYQzdQ?=
 =?utf-8?B?a3lOK21QRisrZjc2aEdLYVNCcUlyREVWS1lqd2tVckVmdjZ1VkREL1V3eUJ4?=
 =?utf-8?B?NlhIekJEQ2RHRHF1dldNYmZZQlR6Q2VFNmp3NkNrOTJFMEJKV0VoK0daRVZT?=
 =?utf-8?B?dzc0amtvQ3A2OHVVVWRJZmRQNExIaFBxZWRwSTkwVW5DWk90dkQ5MDYzYmJW?=
 =?utf-8?B?M0tyL3EwYXBuY211b0ZMWHVDVlJHaTFITnhTS1lWWnkwZ2xWeUZaNUs1RmpN?=
 =?utf-8?B?c1FIeTg0dHBJYlNnQ3lMT05maDhQSzFLUnJQYVlhb2lZRWVpV0xHdnhwSDhS?=
 =?utf-8?B?V1pGRUc5ZzBMbVpIQ0h0VVhxYmR0MEY4UWF4QzZ1NHVvYXlyZG52b1Blc1FN?=
 =?utf-8?B?cEhCTDA2TU54YmJkSzY5WVN2enlEZ0ZMNVFVTjd2cUJQcmFGY25OVTN2YUN5?=
 =?utf-8?B?YjNmT1pEY0N4eXBrMnZHdjB3SW1HTmwvUUlqS2FJcW9rWm13MVJEVGxZSDRv?=
 =?utf-8?B?T2VNbGkza05JNktLK1ZDVXRqbGhybDZIWUNKNHEvM1pXbm1TZ3BqeVIyVDV5?=
 =?utf-8?B?Zi9naFRVVlVqb1RuVW12N3JHZW5Ub0lOSE8reDJKVTU3dmJYRjNjYU5xN2xu?=
 =?utf-8?B?TVpoSitaajg4MUN0TjQ3RlVEU2IrYlZPQllaV09VTVJDTC9nb1dBb0VkNjhL?=
 =?utf-8?B?MzRzM2EzZlZoWnJSR0Z1Y1cxN1dqY3h0RmVvc2hQaXRZZS9YNlgyUmx0QWxu?=
 =?utf-8?B?M0lGRUowT3pnN2EybWRvQ0ZZLzMxZWQzLy9CZmxkanlwemczdXY3eE15Q0FO?=
 =?utf-8?B?cEt3WUI2bEJBTjJNMkhuN3MxbzZUQzk0Y1EyOElna2FzdVpmRmtnblRSWGtv?=
 =?utf-8?B?Y3ZYR3hVaFZLYkh1NXJUZ2htV3AwZUIxNVdZR1psRWJDTXR2OWZXZzRJQmlC?=
 =?utf-8?B?SDNNbzhwLzIvNUVOOW1jRXNjOFJuNzRBanl0L0pMZVd5UTlKZS9PUEIvdGJ4?=
 =?utf-8?B?K2RzZU1aZnRZeVF1UTYwdXJOcFpmRXhUMUxWMjJvZFp0OTR0UDl5djM5YXRI?=
 =?utf-8?B?UEpWYWFHb3ZTTXFDcWJOMk5Na051bXpZeHkrRnpIMGQvaStMemJJNGsvSkkx?=
 =?utf-8?Q?GBVelP0qLN4ufGtjgMKYdamVH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e57303-4108-44f0-587e-08dddb28e2d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:51:20.9520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc/GXraVyhKtfTOFv6EkUhltYRk9lHUsLw8lZckpYxLtqwE16FwIjhcI+Onfl1yt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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



On 13.08.25 20:49, David Francis wrote:
> AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is a flag that
> specifies that gem memory contains sensitive information and
> should be cleared to prevent snooping.
> 
> The COHERENT and UNCACHED gem create flags enable memory
> features related to sharing memory across devices.
> 
> These should be settable in GEM_CREATE_IOCTL but weren't.

That needs further explanation. Something like:

For CRIU we need to re-create KFD BOs through the GEM CREATE IOCTL, so allow those KFD specific flags here as well. This will also aid us in the future and allows to move the KFD components over using the render node for allocations.

> 
> Make a new define AMDGPU_GEM_CREATE_SETTABLE_MASK to
> track which gem flags can be used with gem create, and add
> these flags to it.

This describes what the patch does which should be obvious by reading the patch. I would drop it.

> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 +---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..aefae3a9e6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -442,15 +442,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	int r;
>  
>  	/* reject invalid gem flags */
> -	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> -		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> -		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
> -		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
> -		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -		      AMDGPU_GEM_CREATE_ENCRYPTED |
> -		      AMDGPU_GEM_CREATE_GFX12_DCC |
> -		      AMDGPU_GEM_CREATE_DISCARDABLE))
> +	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
>  		return -EINVAL;
>  
>  	/* reject invalid gem domains */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b51e8f95ee86..b3047d73fe07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -71,4 +71,18 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
>  

A comment explaining what this does would be nice to have.

Apart from that looks good to me,
Christian.

> +#define AMDGPU_GEM_CREATE_SETTABLE_MASK	(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED | \
> +	AMDGPU_GEM_CREATE_NO_CPU_ACCESS | \
> +	AMDGPU_GEM_CREATE_CPU_GTT_USWC | \
> +	AMDGPU_GEM_CREATE_VRAM_CLEARED | \
> +	AMDGPU_GEM_CREATE_VM_ALWAYS_VALID | \
> +	AMDGPU_GEM_CREATE_EXPLICIT_SYNC | \
> +	AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE | \
> +	AMDGPU_GEM_CREATE_ENCRYPTED | \
> +	AMDGPU_GEM_CREATE_GFX12_DCC | \
> +	AMDGPU_GEM_CREATE_DISCARDABLE | \
> +	AMDGPU_GEM_CREATE_COHERENT | \
> +	AMDGPU_GEM_CREATE_UNCACHED | \
> +	AMDGPU_GEM_CREATE_EXT_COHERENT)
> +
>  #endif

