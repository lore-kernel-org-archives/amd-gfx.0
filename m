Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C2CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1163210E125;
	Wed,  8 Oct 2025 15:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvCaNg5A";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1665910E125
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5GOSSPhn1CdmX+eizG1O9xjCGC4XckqAvG4sPo+Sh8yOhx1p3VNP8yZRCUBd1Pc7RsYDuLrPXOCEZlSrw6dfwftqujmzZvPvo6QnoMSJZLOHLmzTsGiO22KaUjd7oICdFVxi2dHLKZnU7Zwc+BzjZUGpz+7vsvB9lbm4gkzi4VWNrBxl/kVj7YshrkmrANoyqwCgfJoi1W7kXLcsQSNP8ELmjvbAU3qoFiF9yngZ0jyH7AJ29sSN71mmgi6+Aq8uFO3Act4mSO+PBbf+TsqiGDgt25g5ut915ViaVqhFqJ9zEwdMa5pY11SKKHaX/5zojzw9/c3nLgPelachYTbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NYoivC0Dx7MlOIsAMzsIYDducSWLE8gVpMuqamG7Uo=;
 b=FxleJ7HuSerJR6KRholwNnWODlk6EjKt5JKCukZsepgiTzOezhttgNZ9PHraPWZLD9naK+fq5C/W8auxMBbCKcU4V4bx6Piu7lsUdNfRJkNod0SzPAfnV9uGSCQB8Rb1H6AoWKK7Lt43BxMIMgH7q0E8baVj1q7c7kx3LTjbf6A6JZDRlQ059/W861pNBxSHWWLmcUZUSrUIdsHXvQ3EuGrfc7fcJ5+e4sEp/afBUP/s4iKZ1bA6eUt76RZ9A06GLu7XrZyRPHJRaWaZac5EU8TowxGD52uhYzWU9yb7TRv5VdWpTbzte7rJKsHF3bRSuDn/5oa6L+uAKsFS38VFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NYoivC0Dx7MlOIsAMzsIYDducSWLE8gVpMuqamG7Uo=;
 b=rvCaNg5AX6TRIC41u7EnXHkNh07X9rMjB2itwmeqUS4lcUgnArW0G9W3o5waH3pJ5hElQIloZlH/XFJmOGTKlhifSYCXi6xY4Bj5VJAF5oL8DhfkmZQ8tNhnok5GLNTqUqPde1CcBOurWK2gKAhqQrNlUijoj9sHZlAMkFNxmPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 15:00:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 15:00:51 +0000
Message-ID: <c729abf1-6147-4f24-b67e-95ee912ca330@amd.com>
Date: Wed, 8 Oct 2025 17:00:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: hide VRAM sysfs attributes on GPUs without
 VRAM
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20251007091925.18470-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20251007091925.18470-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0687.namprd03.prod.outlook.com
 (2603:10b6:408:10e::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: d9472bc3-aa0f-47bd-e124-08de067b7917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUo4REV1RlNTcWJxakk2Y0MrYmN0UjZXemIyWmJJV3Y3R2RhbGdoamRtMFp4?=
 =?utf-8?B?QWwrRmhTZkVBYzdYQ1B4dXZvUHNpV0E3a0RFQnptSHI4RW45dXN0NU5jZjQ0?=
 =?utf-8?B?MTZjdXRUMXFxUm5FbFNVSXJJcDZDWnJsRFo0SlB1ZDg3QmpWSG5XYjJpREFi?=
 =?utf-8?B?R2F6UHViU0NLWFB4ODNDWDdEczNtdWZWbkJMVEJYdHFIR1kzT1hCSXJhbjRy?=
 =?utf-8?B?VkZhRGhqYnRNeFo3bFErbld0K01sb2dHYjZXb1RtMTljS3NIbG9UbCtoUmRo?=
 =?utf-8?B?Si90Y1h6OVBxZUsxMDJKelZPaTNncFRKMUFNQzBsN3BHZnRqdW53Y0Ryempk?=
 =?utf-8?B?NDdkQnNYOGt1b2dSRExyL3c4VXR4d1lKMjdsYUlySndrbCtLdFRPYmQrcjFx?=
 =?utf-8?B?OSs4M053NmZ5dGwvREp0dE5OSzZDaTBLMVlCSkFYc0Y2WjZ3b0UrWGpha0Rm?=
 =?utf-8?B?YlBmSGpYLzE1SnpMNUY4M3ZJZFJOTC95RFdTT1B6U3VRZjFlenNlYWpUbWJW?=
 =?utf-8?B?ZmFIVjBONE9iZFdTYVhVeXBpV2N1NzRwZ0VFNENOcVFGbnlSdm05K1Y5TVph?=
 =?utf-8?B?SU12VVpaTGxicDZ5cmVUQ2JVSnEwRW5NTEJHWW1wd1BCRHVrakFpcy90M1dr?=
 =?utf-8?B?RFcxbVk2THBWcGpxVk1NQVZ0T2pyUlRONmZpZmVIZnA1QUlSbndBK2s0OTQ0?=
 =?utf-8?B?cXRwWGJNdEJDU0ZkcHU0aDVQVW1scUJteVRtbWhjbXBKMWsrWTRvTXRvbVVm?=
 =?utf-8?B?SEs1cXN6d1VJOXIvdXllNEJDUFRTWnpxOGlCK1VCVkZpNVJOUmxMeGlVS3or?=
 =?utf-8?B?ZjZkZG1ydG5HbXQ0dHRxcXY0UStYUkRVdFZHVm9lU1U2bzJkakNpSld4UTRv?=
 =?utf-8?B?VU5CeXNlRDhiQldjbVl4QUJSVkZDbXlsekZnSmtscE96NllQQURuNU1EN1NW?=
 =?utf-8?B?SUI1VWU5ajVsdnpXV0RzUkZnS2g2ek1sU3BJZ1U4OXN0c2o2bjY5UFQ5RUlz?=
 =?utf-8?B?b0UzdWFyNmRvWTdrbFI1LzFVQ2pzVnJqNTAvRWlqQ3pqVjVtZzVuUXB1aGNG?=
 =?utf-8?B?RVA2N1JpQ3dibzhraFZKeGhzZFI3MDFMcUxGUHhJVE8vU2IyZFJQQWg1Y3lz?=
 =?utf-8?B?a1JUZFR4eFNDWWlaM3hmN29aVUNLNzZvTTFLejVZRzNvRUlCbmVZZ0VFV2hX?=
 =?utf-8?B?TWtmZHNVNzRBSVQzVncyQUpiVWxhVlFWcEs2VDl3bmYvTXFNWFZJcVljUmF5?=
 =?utf-8?B?Nk9PNms3b05FRHNMQlN4RlNIZDV2a2FTT2swWGhSbWc0NUZydm5YS1NZZE12?=
 =?utf-8?B?RXRGNC9ZVEZ2dWRXT0hycVdaVlIvczRQV3ByNXUxL2ZPMVNkeFloQ1p1UkdY?=
 =?utf-8?B?MjExL0pVamxjT3VSL3k5bHNRVGtqUWZDc1NBcFJwaUpvK2M3TnZra3N2b210?=
 =?utf-8?B?U1RVaGp3eTdYaVZLSk9PK2VEWnlsY0JNY2JzWStGQ1BTeVhiZlJpQVVpQ0Z0?=
 =?utf-8?B?MG1GcjMveUhxZ2J0bzFDcXFCMVh0RnJVU0hRZFg1U1lBQlhwZlFyMUdyWTdX?=
 =?utf-8?B?dlZ2anJQelN6amc2UmpTQ29oeVVQMXMyN0JMMDh0MWR0RjZwVmxQYkdPL2Er?=
 =?utf-8?B?Q2lwaXh0cEFKZFBndXNPNDBZUy9wRzkzcStYQ2hjNThmMDZMengyd3dVdUFR?=
 =?utf-8?B?bnE2UjhXN2VPM1BhcWlhb3FZN3JiZFZuUWFFaXIzZGxXWmNlYVhZYjQxM0Rk?=
 =?utf-8?B?SnZsaXczWEFKUkVkcVBmTDVtM2Z5aGtrTjg3aWFBM2lKSW9hUUNBTklSb2dR?=
 =?utf-8?B?dFdFSTFPVlRhT3pOVzB2aDJRcThKemNoOWEwNVhzekg5dVIyQjNLbW5PN0dY?=
 =?utf-8?B?Q3hHNTRhOXZTVkpObzJsdlBsbEhNd3VMUDhGNlFCQzFzLzFFVW1xTnpuL3Vr?=
 =?utf-8?Q?rYiDtcS55YkeK1F4qqg9y4P4H6/TbdfL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRZcCtYQkhmMGx0MzNCNFBaR1NvSHhXV1IzMVpXOU45QVREZjMxbmRkNGZh?=
 =?utf-8?B?aThVTzUzN2xjV1VrUGwwcXRUNldPTERxSWdIWXJieFZKbTBzeFE4MzczeC93?=
 =?utf-8?B?UzBLR0l0VU15UGlnRWRvNmdRQnpEL09USkdkWGR4SUdlRVRhWXc3UHYrUGFW?=
 =?utf-8?B?VjJsUWZML3JMRDQzMjIraCtUalpIWm9jRWJVa3NNZnI2WlhmczJOamhNSXNM?=
 =?utf-8?B?Z2pWQW9idlAzMDFPcmYvTndQNGpkNlZHeklTUGNZemxJdlA3NE1xVlRKeWJv?=
 =?utf-8?B?WEczZnc1NGVaVVhlUkRxSjd4U2VqNEN6ZStsZUc1WG1yb0JOKzJZRFY3Y3JR?=
 =?utf-8?B?MVN6YnZCVytPN3BhZDFDUnNoNW4zekJRQTFWbFEvclJRclVpWnAreVc0MDJj?=
 =?utf-8?B?NVBzU1ZIcUVJOStDbS9TTmhHbEJWU3lWNnNjQzY0VXJibjRGVXpCR0hzTWJs?=
 =?utf-8?B?RWRwbE8vL09pNjluaHVPRVo1VG16Tld2SkNoVlF3SFNTNHBEVEVpWS9zaEkx?=
 =?utf-8?B?NXZVQlRjUTFoZFB1eHhDWVFYU2xhTzVkaytNWHg5MDI2R0h5STJFT0VGOUtM?=
 =?utf-8?B?ai84Z3dDNjNMUy91TG5VUllQNHN4UFBFandWWVdzU1Y4QklYd0Fhc2Jrc21q?=
 =?utf-8?B?eU9Hejc1bjFsOEpHSXA5ZlVtUnF1d01EWThnaHdMZnI5UUV5a3htVFdHMHBz?=
 =?utf-8?B?WVl0aDVrR0o4clNCeFdSZWFudG5jUFRkc1BIRTFzV3dueXJuSkVYOE9DZmxz?=
 =?utf-8?B?VTl6V2lHMnBiZTlXV3JacHZENThuaklrWTI5dEcrSW5UWGc1M29GNlI4enVM?=
 =?utf-8?B?ekdDRzhSWlZpTlJpZ2JMdHlxNjRQaVZ2Sk9UeXI3em1KR2Nmd29OZzVNUTVP?=
 =?utf-8?B?RUF1NUVwZmZlVEEzcVVaSzQzckpsbmNyZzNyRXZNTHArcnlLeVdncGU4WDZC?=
 =?utf-8?B?NTRGdHhXZW50OW12czZZalAxcE1xQXhJWWNVMlJOT2xucnJ5Mis2Z0UyU3M0?=
 =?utf-8?B?Yng2ZUY5T1F6NkNJR0l1Lzk2dVBqNVVDdThrZ1NvSmV0d1R0ZWk5U09uby93?=
 =?utf-8?B?dEw0N2JVcFFIQlh6aHpGdUxqcVNNQ1JteXM4SDBJajMxTjZGODF3bmhaQ3cr?=
 =?utf-8?B?Q0FtRDJ5U0ZXY0Z5clZEYmxiL252QXhTbW80aHlNN21HcDJWUGhzYysrY3BO?=
 =?utf-8?B?TnhMekpsUUw0VzNPRHNwMUtIdzM2TXdtbWFwaWJHbW01ZWdFenh3N1c1c2ln?=
 =?utf-8?B?R3B2di9aZUVCclYvRlo2ZWwwVFBQUXpUbVQ2YWZ1Q3NwZE1KM3RubzFDMnFX?=
 =?utf-8?B?ZUd3R2JEZmRkV2hSRjVNejVEQUtPbXVUblArMCtxRnM5VnBiZmtDdExMeXZW?=
 =?utf-8?B?VlhkK3FnMTRsdE9ZMHpPMmZCYmJhVDZENklhRm1UcUJiVzB0ak9xdzArY1I0?=
 =?utf-8?B?dE11WlN3aE1lbGR1TXUvQ1ZUbEJoL0JqOVpUQk1XbjRXWi9ISGljTHRwVGFw?=
 =?utf-8?B?SksxVUFvajFPVmtUZDhRemZNVllndklGTHhWRFROT3JycmlLdjYwdytrTUNi?=
 =?utf-8?B?RndralluckRDdzdoVy9SUHlMeW5xQWRJc2k5RW1EemdSKzBObXhMRmsxMVps?=
 =?utf-8?B?UERuZGNQNnFERGw4RnJqOGw4MklobStrRHFUSHBZTk96a3IyK1VGaSttYmNR?=
 =?utf-8?B?QTVpMm5qTHFpdlVTYkgzWG9RTCtKeVdWSmROWEcyVlYxbnZwS0FUVXp0elFk?=
 =?utf-8?B?bFV5VnBPV1E4cXdkWXc5bkR1d3Q0M0NxTDRSdFBaVllWRmR3NDYxZWtLQTFj?=
 =?utf-8?B?MVByQmQ1czVuTGxEQS9nV1A0dHE5SW1YY3NKMUZWVzZmS0VhRzlZS2swcGl2?=
 =?utf-8?B?S1pML1ZtRWFYMkUya2dFRHE3N3RudDZ3L1VadmFubWtndDhIWHlLSjcvbUxC?=
 =?utf-8?B?UGdNWEcxZlBLMmRkTlNkMDhnMEduMDVZc3BXVXRISFpsYzlNZjhoQ2xmdi9Y?=
 =?utf-8?B?dW1ZUDA5TTlhemRQaFlaYWpVUGFNUEN5LytyTnhjZk5MZVdhQWZWZ25PVHNS?=
 =?utf-8?B?MFZGa29iM1BoUklReVBFQkxmMjhCNmszZHN3ZTI3RFNOaHNBd2VpYi80TXFj?=
 =?utf-8?Q?prwOxEOWm2zKZp9Y87b1OCoMl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9472bc3-aa0f-47bd-e124-08de067b7917
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 15:00:51.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZvoRcuksdwnRIAiF0pcjEeb/GhAkwfKlsTtzFrFIvw/n/R/m7t57EV9rtOABFsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

Arun sorry I should have CCed you in the first place.

Please take a look as well.

Thanks,
Christian.

On 07.10.25 11:19, Christian König wrote:
> Otherwise accessing them can cause a crash.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index a5adb2ed9b3c..9d934c07fa6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -234,6 +234,9 @@ static umode_t amdgpu_vram_attrs_is_visible(struct kobject *kobj,
>  	    !adev->gmc.vram_vendor)
>  		return 0;
>  
> +	if (!ttm_resource_manager_used(&adev->mman.vram_mgr.manager))
> +		return 0;
> +
>  	return attr->mode;
>  }
>  

