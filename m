Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21348C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE81D10EA63;
	Thu, 28 Aug 2025 17:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMYO1qX3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7390E10EA62
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 17:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKhginZnArY3eeE7hK/+F+4YlLsWoZouQflfTdcDDjWMGEaL70+QEmvNc9/Z8GqG6kEBVDh9mEMEtpdm9geWrwsb7bQoxstcRWwpE32TqJ8fdok8rU5jPyfhmCRn4eJfP7lamdUTrgbU9deK+LFT6h/ZCpGb1Goy+YKh6PUY0TCeRqYZdNXE0SJ5WDlpDFGf1mkesi7equT/GxpDkbNFrmoOlWOFd9z27q6n1D9OwFae3bZNfW/5TSQ9lbW4dK7uzTdy4w6k+9ktOpBklMkIY0Zb4lMiTZN4a8hLitRJGhp487x+9gL9mPsli9HZvzxdW3WkWIhVYb4DDrIT/LGW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTuxRGgiPAQGVpkQslhCvG8xNgQxRGSnl6bZoB/gGe4=;
 b=s9QylryA1nuMX3dFlLocgWOw5n0xWRGe8f68tzds2PGbA8LiyzEXPNWVBVQCeJUPQmG4gA9l6TR2yNBjXjuFBm5xZq9qx7RZOWN2l5+dRcwmkITUrFZMnPt/n+XKBltA4vAzYRim6g9VPuEEEjqSZCjsAwpoUsdVxwMeMqQZdG7voyUAY87vsHPlnqGo910oxSKCTTwyetRg/rChQjOtmdRAuv/rBibtM1T0V19YFeASC6TDO2LUwpHVpD6toC1TVxPbBHLNc1RD5E4w7NKHm9WEoGhsPE4HKUDn/+X2NYU06KvTeSLSsw9sl6Le+yuT5f/zCvkXqBOwCurprBqzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTuxRGgiPAQGVpkQslhCvG8xNgQxRGSnl6bZoB/gGe4=;
 b=zMYO1qX3fH55L+4+P6UCxJTMOoWoQ6H+oY2KBqTB71ynUZeDVPiVvomysJuUYvcwa8HrHz2Yjd5Sur0XToJndZdIk5CTASDJeVgTu7/z/kcC4p0Ar3bs8Ik6S9e7Nxhzk3HBFay8m9F3IwD5SBW+FBhXKNxDrEeddRMLx5EODV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 17:32:04 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 17:32:04 +0000
Content-Type: multipart/alternative;
 boundary="------------fw8GYw4Qe6gOJKE0hY7v7Bxr"
Message-ID: <c3386a43-a7fa-4ebe-bb37-3145cad47a52@amd.com>
Date: Thu, 28 Aug 2025 13:32:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: David.Wu3@amd.com, christian.koenig@amd.com
References: <20250828140548.5792-1-alexander.deucher@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250828140548.5792-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YQXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::26) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e1b214-ffcb-4582-e6ea-08dde658cdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUlLNEQ2NWNqN2JQS2liRjliZWtLdG84anFlSFZhdWdsbXN4a2djSTBHT2lv?=
 =?utf-8?B?RzZVd1RKVXFVN1FoOVhFbmhQNVpOdWtaNFJPNnZQOEdLelJiZHhpWUlJM0VX?=
 =?utf-8?B?cTdJNDN3ZGQrY3ZzTzlzMjRQT3JjSHdFSjdmWTZJaFhQUm9YZkg3UEU5dUk1?=
 =?utf-8?B?RmFuMkJTOVdETkNqTXJSL2Q2SUhSSWlNZUxld0lRa0YzMWYrZFRvbTJKS2VZ?=
 =?utf-8?B?TFRkNGNZWXdha0NtNUxLc2dvaWJWd2tWVFZmWEhXQ3BKaysrbk9nRm9Fcy9l?=
 =?utf-8?B?cjNDRjY5dThoK3lWeG1pY29DcW92WnJpbkprNUdsdjdRVy9PSUUzL2Qyemx4?=
 =?utf-8?B?RVRwdGFGcmIzZTg0ZGFvbGkxOVVQeTlKL01SbTdXRXAyWGYwSlJ3b09SaXN1?=
 =?utf-8?B?VzlPL3ArVFk1aE54eFVvRWJvd2NuY2RRU25FcW42YmJ6ZUJlTnNZQXpURGNR?=
 =?utf-8?B?UElaQlp3Y0YyaHBaWXhsSjhGSWZUMEd1UkdXNUFwWFFiSS82MjFVYXMxZ1gv?=
 =?utf-8?B?TFdVNjVNbFAxdFVZRWNNQkVIL2JZcHNYQTZCTHdTV3JDWXpBVTFIencraEtT?=
 =?utf-8?B?TlNzNml6d3J4aDRONHZtSnM2bG9ud0JJc0RBdVV4VFhuL3hFQytXZGxJQ1ZS?=
 =?utf-8?B?WkZHWFdEZ0ZKcUhlczdRc2FzMGs4djU0enExeHZuQjh4RUczNFQydjB0TnEz?=
 =?utf-8?B?Uk9CUGYzT1hVSTN3aFNraEFFUGpWODRzZWZrSnQ5Q3ltY0x4V3RjNkpjc2Jx?=
 =?utf-8?B?RldyRURFVGcrSnMxT2NWMWlKL1VRdHNuYUhVQ3JhSit4T3BndkFMRlRYZlA5?=
 =?utf-8?B?TVZiRW1aZTIwZ3Fkc1JjRldZK29tQVl1VTNWUndMUWJ0bmpDTitxQzFhbGls?=
 =?utf-8?B?Q0VLa1J2Q29KZVNJb3ZyUUNNeDFhYTVsVFlSUTBUSmpiSUgwWWdIS1U0OE5S?=
 =?utf-8?B?Z2M3V3ZzbmhNUGNDK0VBTFZxNGpacUovektJREJBZm13ZWY3TXRWNitMTlp4?=
 =?utf-8?B?MENmY0NxSzVmb3ozZ0VDUVBwOXR5SEhOMmQxSTVFNVQ4THg1Y2VyVW9NUTJk?=
 =?utf-8?B?T3lQNUlINHdyM2NvYk9ueWhuV0R1bGZzYUIwY0hOTGFzVjJaYytjL1VtM2F4?=
 =?utf-8?B?a1loc1dFdCtFWEJlOERhNFNJVzduOHpTQ0cyRUVsUmplWmRDeHJRQ2N3cG1j?=
 =?utf-8?B?bVhhYnFHMnRGWW1ra3ZqWXE5ellPVE9OeXAyOHFBOGxiOW55bXh3N204OGlS?=
 =?utf-8?B?WllGWXduM1hPYTBmSUs0M1lXNGpZYkswV3EwanRPWHVsUTQ2UzJ4Q2VpZFk0?=
 =?utf-8?B?Y1BPMVFxblJxd1htRjVmTXVsTmFEL09PaFRabzc4alVERi8xMURjUGVSUGJ6?=
 =?utf-8?B?QWRadFFoRlc3NUZWeWFqbVZaUnlZc0lWVGRTWE9kY01qekh0SVZYeGpNTnhF?=
 =?utf-8?B?eDJoaEtaWGFzL0Qxd3ZzRUVpZGJRQ0EzZlJCVkZsbHN6bjRUYmJZUEFzVHNC?=
 =?utf-8?B?aTA5dGFDa1BxVEdCaWVSemdISEVJeVR1NnIxMTRiYnA0NjgwczF4Zkt5Vnpw?=
 =?utf-8?B?N0hzKzd6QWNITXJWWml1WWNWMGlOV3prSzU2NkpLTlFHbDdUb0pWdW9Sc3NW?=
 =?utf-8?B?V1FMSFcvMElNSklvQzU0UzFMZXlaV2Y1cEE3aUx1Q0c0a1RwNC9FU2dtVnRu?=
 =?utf-8?B?MTV6UUpPNlZnVHRQM2JtNkU4aDhEZUtNUlBJR3U1STRzaGxGeXRucERldXNK?=
 =?utf-8?B?aGlIK1VyQTk2dXRORUZ1YUFDcFZuTjVMU0ZFWmU0ckdaL045WUFVT3J0K094?=
 =?utf-8?B?WmVMb1d2WkZYNTM0Ukk4ak1oTjdNSElseFg2TFlOV2pOelgycWJURkhtb0Vk?=
 =?utf-8?B?VllBRHJrb2hDR3FIMVVYTUZFaldlb1AzN2RLYk1ndTROd0lZQ1NrMVdRZVJ0?=
 =?utf-8?Q?Dw1jTmYsEPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdpaTRyUjhlSnhueDNQTFgvT3BDNy9MeVZuU0VFSWY2dHZwYjFneEdud0tQ?=
 =?utf-8?B?dTR6c1F0a3NpZHpMYkJLZGtzV0dkVkF5bUZ4NUpDa0tMaGRxdkt4dXF1K1Bm?=
 =?utf-8?B?SnJxa3JBOVB6RHBmcjlQdGZXci93ak4yZUFRUTk1UzdtY0RvcWpaa3kyTHQx?=
 =?utf-8?B?dWNTSWpSWWVod2dGYXFuRGdkT2w1K3J1elJsWlNTQ21laWZyZFNWaERmOGN5?=
 =?utf-8?B?QzB3WVdZcENKcFlUeUxXbCthWCtMS1Z1ckZpVFJ1VW0wUG93aytUdDVYRnZi?=
 =?utf-8?B?ZnR2VXdoWVl1bzhITkZYSlhKejk2czR0ZWdWbGM2NVpLSnVkd01jbXRkT0xh?=
 =?utf-8?B?QmNIQnA0RFp1Nmw0NkZwM3dkL2ZBeWxtV2NkNTFjblRzbUZZZUNCNEFLSUN5?=
 =?utf-8?B?MjI3OW81OTVsenRteU5RYW13Mk9Mc1h2NUJIdm9BNHJndVZnZkZXU2VZd2dm?=
 =?utf-8?B?dnU1SStrQndPemxUbVphcEVta3V5OE51NHhyVkdXNDFkOG54MVhFTThEbzc2?=
 =?utf-8?B?RlFEVVozMlBXYzEwRURGV1VnK3JZSWw1VjdNOG1VaG5lS2NRaG0zNUxFRUJJ?=
 =?utf-8?B?RzAwYnNCNHdXanRMWEZVeW5wOUQ1RGUwNXltcUU2WVBYKzB2UjBiNUNQbWJP?=
 =?utf-8?B?Q3o3SHc3SS9NRjVnOUQ0bE9GWTFNNHJHTzFpV3VGY2RNZ2NjWmFCTFlmVnZI?=
 =?utf-8?B?WUNMbWNORXJTU0hleURkcG9Pc2d1SmhTSDZDbHZJTzJGMjlFOFBadTBHTkVI?=
 =?utf-8?B?dk12cUNpbEp1aVpic0RMY0tXMzJuQjU0Q200UkdKMC9adDR6anBsa0dLSito?=
 =?utf-8?B?eHU1OHlhMkttTGY3d3JHQWZlNXJ6aEI0V0M3c2pHRnhRNFFQdVVjMitUSjVW?=
 =?utf-8?B?S2ZKZjVVazlKVEMxL1JkYVE5bVNla0UyN1VNRGZuYUt2YmxERHJUMWlKQlQw?=
 =?utf-8?B?cW1XM3ZNeG5UUW5LMUNlSlMxU3VSN2theUpwUGhtUnRtaWdXWnhPMzM2UVRv?=
 =?utf-8?B?R3h1bUZ5cDNSMlk4ZWVLaHVhMW1jOE84YkxPazA0RFRxV0NPc1gyRUx2dHdI?=
 =?utf-8?B?VHFzK0VvSnRBMUJmMGRPYXM3eTJjdWlEa3NFRVU5ZEJ3NkdSNlN2azdleC9X?=
 =?utf-8?B?cVVFTHpNek9wWGMrOFRURzNQWW5qK1R5aWhpSEJwZzZBdlpVTGN1bG5qSlhv?=
 =?utf-8?B?SHEya0cxR0R4bXhmSlhFUk1adlFTa1pNU0dYRlorYkdPUkxGaDhLWjlpZktt?=
 =?utf-8?B?QlBvM3JQa3doV241KzQyN0FSRGE5Z1FyV1VSejdkTU5EdFpGbTFVMnhBLzlC?=
 =?utf-8?B?V3pzSkZuNlhlUWxFQUdDNHB6S2phc0RvNHhab2JCZDhOVlpuektjTnFMSmJB?=
 =?utf-8?B?ZUEzeS8wa1JiRHVMZjR4YVE2MnBCbkVvSWZLMXlGS2FMYkhNNGlEdng4c2Ux?=
 =?utf-8?B?RVdYUmhhTElpa0ZEWWxhdGUrYTZxd0w5Mlhzem1WRDBCOTE0b3ZtWk92eXdO?=
 =?utf-8?B?VjVsWXYrUjZUU2Y0VmpTODU4WTBEVEw4Zkc0Z0hxMU01UzNLNThJbGNKeVlJ?=
 =?utf-8?B?V2hsc2t0b3pXQUtiRXBIK0dISXpnZmNZTWRoK0FiSWcxYkloN1ZrY2MvNXBx?=
 =?utf-8?B?VENESTk3WkE4UVRqMGhreE5waDdzNmxJc1RTUnFqaE5IdXVTSVd1a3dwUVky?=
 =?utf-8?B?dnhRbSsrS0tPSkFGUGtsN2l5QUxvRFcyZ0pjcnlxQjZWK2cwdmxPYkFOU1Zn?=
 =?utf-8?B?d1pQNDVVUTFuQk1ESEV1MUhCUkw3cGZUc1pGNFI0VjIrL1B5WjZkRFdGcnZC?=
 =?utf-8?B?THVVMFVDekRnYzV4a29HQTEzOFhPWHUyZVJVbjluNWFRKzY2amlPeGhQRU5C?=
 =?utf-8?B?aUlzbEFkMGtrL0hxTGV3RzQwbUdOOU9XbWhEeExSV2x1dk02dTlQRVFraU9B?=
 =?utf-8?B?eHlTY3pacnMzSTJmNjNOVWVRZDJpdklnSFJyTmIyNmVHc0V6aFZQL3c0Y0Ux?=
 =?utf-8?B?bkc1eGhvbjIwRWtwUWRhR0hYZDNPN3lIcURqRytNQnVIbTdFaHBaRGw0V2FE?=
 =?utf-8?B?UVhhUmg1TWk1b1VSSUtBUzhiajZkamdKTHVyMkt6UGxQVDhyd1VnSDViVjdV?=
 =?utf-8?Q?hglUZhpDG9Z+fhVMhKeAxNAks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e1b214-ffcb-4582-e6ea-08dde658cdcd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 17:32:04.3379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WaBEZ8X7N0asM47BBmj4Lld0/oOmt3wCWtg/QVEZbQnoORNm22zZD0PEf2eVC+SirFS3RKWlqZm/2a23/Abtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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

--------------fw8GYw4Qe6gOJKE0hY7v7Bxr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-28 10:05, Alex Deucher wrote:

> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
>
> Cc:David.Wu3@amd.com
> Cc:christian.koenig@amd.com
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>
> v2: Additional cleanup suggested by Christian
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 140 ++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  22 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>   8 files changed, 64 insertions(+), 165 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f81608330a3d0..7ea3cb6491b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>   			continue;
>   		}
>   		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence.base) == fence)
> +		if (preempted && (&job->hw_fence->base) == fence)
>   			/* mark the job as preempted */
>   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7783272a79302..add272fa31288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!amdgpu_ring_sched_ready(ring))
>   			continue;
>   
> -		/* Clear job fence from fence drv to avoid force_completion
> -		 * leave NULL and vm flush fence in fence drv
> -		 */
> -		amdgpu_fence_driver_clear_job_fences(ring);
> -
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 *
>   	 * job->base holds a reference to parent fence
>   	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>   		job_signaled = true;
>   		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>   		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2d58aefbd68a7..1355fee0e978d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>    * Cast helper
>    */
>   static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   {
>   	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>   
> -	if (__f->base.ops == &amdgpu_fence_ops ||
> -	    __f->base.ops == &amdgpu_job_fence_ops)
> -		return __f;
> -
> -	return NULL;
> +	return __f;
>   }
>   
>   /**
> @@ -98,51 +93,33 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    * amdgpu_fence_emit - emit a fence on the requested ring
>    *
>    * @ring: ring the fence is associated with
> - * @f: resulting fence object
>    * @af: amdgpu fence input
>    * @flags: flags to pass into the subordinate .emit_fence() call
>    *
>    * Emits a fence command on the requested ring (all asics).
>    * Returns 0 on success, -ENOMEM on failure.
>    */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
> -	struct amdgpu_fence *am_fence;
>   	struct dma_fence __rcu **ptr;
>   	uint32_t seq;
>   	int r;
>   
> -	if (!af) {
> -		/* create a separate hw fence */
> -		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
> -		if (!am_fence)
> -			return -ENOMEM;
> -	} else {
> -		am_fence = af;
> -	}
> -	fence = &am_fence->base;
> -	am_fence->ring = ring;
> +	fence = &af->base;
> +	af->ring = ring;
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	am_fence->seq = seq;
> -	if (af) {
> -		dma_fence_init(fence, &amdgpu_job_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -		/* Against remove in amdgpu_job_{free, free_cb} */
> -		dma_fence_get(fence);
> -	} else {
> -		dma_fence_init(fence, &amdgpu_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -	}
> +	af->seq = seq;
> +	dma_fence_init(fence, &amdgpu_fence_ops,
> +		       &ring->fence_drv.lock,
> +		       adev->fence_context + ring->idx, seq);
>   

seems we are missing adma_fence_get(fence) somewhere as I got the following error

[ 8.317720] ------------[ cut here ]------------ [ 8.317723] refcount_t: 
underflow; use-after-free. [ 8.317734] WARNING: CPU: 18 PID: 752 at 
lib/refcount.c:28 refcount_warn_saturate+0xf7/0x150 [ 8.317743] Modules 
linked in: amdgpu(E) amdxcp drm_ttm_helper ttm drm_exec gpu_sched 
drm_suballoc_helper video drm_panel_backlight_quirks cec rc_core 
drm_buddy drm_display_helper drm_client_lib drm_kms_helper nvme drm igb 
ahci nvme_core dca i2c_algo_bit libahci wmi hid_generic usbhid hid [ 
8.317786] CPU: 18 UID: 0 PID: 752 Comm: kworker/u256:2 Tainted: G E 
6.14.0+ #61 [ 8.317790] Tainted: [E]=UNSIGNED_MODULE [ 8.317792] 
Hardware name: Gigabyte Technology Co., Ltd. X399 DESIGNARE EX/X399 
DESIGNARE EX-CF, BIOS F11 10/04/2018 [ 8.317795] Workqueue: sdma1 
drm_sched_run_job_work [gpu_sched] [ 8.317804] RIP: 
0010:refcount_warn_saturate+0xf7/0x150 [ 8.317808] Code: eb 9e 0f b6 1d 
92 c1 ba 01 80 fb 01 0f 87 32 6e 7c ff 83 e3 01 75 89 48 c7 c7 f0 c7 1e 
a2 c6 05 76 c1 ba 01 01 e8 69 93 8f ff <0f> 0b e9 6f ff ff ff 0f b6 1d 
64 c1 ba 01 80 fb 01 0f 87 ef 6d 7c ...

>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -	amdgpu_fence_save_wptr(fence);
> +	amdgpu_fence_save_wptr(af);
>   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>   	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>   	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -167,8 +144,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   	 */
>   	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>   
> -	*f = fence;
> -
>   	return 0;
>   }
>   
> @@ -669,36 +644,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
> - *
> - * @ring: fence of the ring to be cleared
> - *
> - */
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
> -{
> -	int i;
> -	struct dma_fence *old, **ptr;
> -
> -	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
> -		ptr = &ring->fence_drv.fences[i];
> -		old = rcu_dereference_protected(*ptr, 1);
> -		if (old && old->ops == &amdgpu_job_fence_ops) {
> -			struct amdgpu_job *job;
> -
> -			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
> -			 * it right here or we won't be able to track them in fence_drv
> -			 * and they will remain unsignaled during sa_bo free.
> -			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence.base);
> -			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> -				dma_fence_signal(old);
> -			RCU_INIT_POINTER(*ptr, NULL);
> -			dma_fence_put(old);
> -		}
> -	}
> -}
> -
>   /**
>    * amdgpu_fence_driver_set_error - set error code on fences
>    * @ring: the ring which contains the fences
> @@ -765,11 +710,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
>   	amdgpu_fence_process(fence->ring);
>   }
>   
> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>   {
> -	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> -
> -	am_fence->wptr = am_fence->ring->wptr;
> +	af->wptr = af->ring->wptr;
>   }
>   
>   static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> @@ -830,13 +773,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>   	return (const char *)to_amdgpu_fence(f)->ring->name;
>   }
>   
> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	return (const char *)to_amdgpu_ring(job->base.sched)->name;
> -}
> -
>   /**
>    * amdgpu_fence_enable_signaling - enable signalling on fence
>    * @f: fence
> @@ -853,23 +789,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   	return true;
>   }
>   
> -/**
> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
> - * only handles the job embedded fence.
> - */
> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
> -		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> -
> -	return true;
> -}
> -
>   /**
>    * amdgpu_fence_free - free up the fence memory
>    *
> @@ -885,21 +804,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>   	kfree(to_amdgpu_fence(f));
>   }
>   
> -/**
> - * amdgpu_job_fence_free - free up the job with embedded fence
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the job with embedded fence after the RCU grace period.
> - */
> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -
> -	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> -}
> -
>   /**
>    * amdgpu_fence_release - callback that fence can be freed
>    *
> @@ -913,19 +817,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>   	call_rcu(&f->rcu, amdgpu_fence_free);
>   }
>   
> -/**
> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
> - *
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_release above, it
> - * only handles the job embedded fence.
> - */
> -static void amdgpu_job_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_job_fence_free);
> -}
> -
>   static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.get_driver_name = amdgpu_fence_get_driver_name,
>   	.get_timeline_name = amdgpu_fence_get_timeline_name,
> @@ -933,13 +824,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.release = amdgpu_fence_release,
>   };
>   
> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
> -	.get_driver_name = amdgpu_fence_get_driver_name,
> -	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
> -	.enable_signaling = amdgpu_job_fence_enable_signaling,
> -	.release = amdgpu_job_fence_release,
> -};
> -
>   /*
>    * Fence debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 7d9bcb72e8dd3..71215aeb1b6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_ib *ib = &ibs[0];
>   	struct dma_fence *tmp = NULL;
> -	struct amdgpu_fence *af;
> +	struct amdgpu_fence *af, *vm_af;
>   	bool need_ctx_switch;
>   	struct amdgpu_vm *vm;
>   	uint64_t fence_ctx;
> @@ -148,18 +148,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	/* ring tests don't use a job */
>   	if (job) {
>   		vm = job->vm;
> -		fence_ctx = job->base.s_fence ?
> -			job->base.s_fence->scheduled.context : 0;
> +		fence_ctx = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>   		shadow_va = job->shadow_va;
>   		csa_va = job->csa_va;
>   		gds_va = job->gds_va;
>   		init_shadow = job->init_shadow;
> -		af = &job->hw_fence;
> +		af = job->hw_fence;
>   		/* Save the context of the job for reset handling.
>   		 * The driver needs this so it can skip the ring
>   		 * contents for guilty contexts.
>   		 */
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
> +		af->context = fence_ctx;
> +		vm_af = job->hw_vm_fence;
> +		/* the vm fence is also part of the job's context */
> +		vm_af->context = fence_ctx;

I think vm_af is not needed - above code can be

job->hw_vm_fence->context = fence_ctx;

>   	} else {
>   		vm = NULL;
>   		fence_ctx = 0;
> @@ -167,7 +169,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		csa_va = 0;
>   		gds_va = 0;
>   		init_shadow = false;
> -		af = NULL;
> +		af = kzalloc(sizeof(*af), GFP_NOWAIT);
> +		if (!af)
> +			return -ENOMEM;
> +		vm_af = NULL;

vm_af can be removed.

>   	}
>   
>   	if (!ring->sched.ready) {
> @@ -289,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>   	}
>   
> -	r = amdgpu_fence_emit(ring, f, af, fence_flags);
> +	r = amdgpu_fence_emit(ring, af, fence_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>   		if (job && job->vmid)
> @@ -297,6 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		amdgpu_ring_undo(ring);
>   		return r;
>   	}
> +	*f = &af->base;
>   
>   	if (ring->funcs->insert_end)
>   		ring->funcs->insert_end(ring);
> @@ -317,7 +323,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	 * fence so we know what rings contents to backup
>   	 * after we reset the queue.
>   	 */
> -	amdgpu_fence_save_wptr(*f);
> +	amdgpu_fence_save_wptr(af);
>   
>   	amdgpu_ring_ib_end(ring);
>   	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 311e97c96c4e0..9a78fe01efa3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		   ring->funcs->reset) {
>   		dev_err(adev->dev, "Starting %s ring reset\n",
>   			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> +		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>   		if (!r) {
>   			atomic_inc(&ring->adev->gpu_reset_counter);
>   			dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct drm_sched_entity *entity, void *owner,
>   		     unsigned int num_ibs, struct amdgpu_job **job)
>   {
> +	struct amdgpu_fence *af;
> +	int r;
> +
>   	if (num_ibs == 0)
>   		return -EINVAL;
>   
> @@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!*job)
>   		return -ENOMEM;
>   
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		r = -ENOMEM;
> +		goto err_job;
> +	}
> +	(*job)->hw_fence = af;
> +
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		r = -ENOMEM;
> +		goto err_fence;
> +	}
> +	(*job)->hw_vm_fence = af;
> +
>   	(*job)->vm = vm;
>   
>   	amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return 0;
>   
>   	return drm_sched_job_init(&(*job)->base, entity, 1, owner);
> +
> +err_fence:
> +	kfree((*job)->hw_fence);
> +err_job:
> +	kfree(*job);
> +
> +	return r;
>   }
>   
>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
> @@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   	/* Check if any fences where initialized */
>   	if (job->base.s_fence && job->base.s_fence->finished.ops)
>   		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.base.ops)
> -		f = &job->hw_fence.base;
> +	else if (job->hw_fence)
> +		f = &job->hw_fence->base;
>   	else
>   		f = NULL;
>   
> @@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   
>   	amdgpu_sync_free(&job->explicit_sync);
>   
> -	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>   }
>   
>   void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   	if (job->gang_submit != &job->base.s_fence->scheduled)
>   		dma_fence_put(job->gang_submit);
>   
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>   }
>   
>   struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 931fed8892cc1..077b2414a24b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,8 @@ struct amdgpu_job {
>   	struct drm_sched_job    base;
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_sync	explicit_sync;
> -	struct amdgpu_fence	hw_fence;
> +	struct amdgpu_fence	*hw_fence;
> +	struct amdgpu_fence	*hw_vm_fence;
>   	struct dma_fence	*gang_submit;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..901f8bd375212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -152,11 +152,10 @@ struct amdgpu_fence {
>   
>   extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>   
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>   
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -166,8 +165,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>   			      uint32_t timeout);
>   bool amdgpu_fence_process(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bf42246a3db2f..7d1a363ad6878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	bool cleaner_shader_needed = false;
>   	bool pasid_mapping_needed = false;
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_fence *af;
>   	unsigned int patch;
>   	int r;
>   
> @@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
> -		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
> +		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>   		if (r)
>   			return r;
> -		/* this is part of the job's context */
> -		af = container_of(fence, struct amdgpu_fence, base);
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>   	}
> +	fence = &job->hw_vm_fence->base;
>   
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
--------------fw8GYw4Qe6gOJKE0hY7v7Bxr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 2025-08-28 10:05, Alex Deucher wrote:</p>
    <blockquote type="cite" cite="mid:20250828140548.5792-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Decouple the amdgpu fence from the amdgpu_job structure.
This lets us clean up the separate fence ops for the embedded
fence and other fences.  This also allows us to allocate the
vm fence up front when we allocate the job.

Cc: <a class="moz-txt-link-abbreviated" href="mailto:David.Wu3@amd.com">David.Wu3@amd.com</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---

v2: Additional cleanup suggested by Christian

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 140 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  22 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
 8 files changed, 64 insertions(+), 165 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f81608330a3d0..7ea3cb6491b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted &amp;&amp; (&amp;job-&gt;hw_fence.base) == fence)
+		if (preempted &amp;&amp; (&amp;job-&gt;hw_fence-&gt;base) == fence)
 			/* mark the job as preempted */
 			job-&gt;preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7783272a79302..add272fa31288 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		/* Clear job fence from fence drv to avoid force_completion
-		 * leave NULL and vm flush fence in fence drv
-		 */
-		amdgpu_fence_driver_clear_job_fences(ring);
-
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
@@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job-&gt;base holds a reference to parent fence
 	 */
-	if (job &amp;&amp; dma_fence_is_signaled(&amp;job-&gt;hw_fence.base)) {
+	if (job &amp;&amp; dma_fence_is_signaled(&amp;job-&gt;hw_fence-&gt;base)) {
 		job_signaled = true;
 		dev_info(adev-&gt;dev, &quot;Guilty job already signaled, skipping HW reset&quot;);
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d58aefbd68a7..1355fee0e978d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -45,16 +45,11 @@
  * Cast helper
  */
 static const struct dma_fence_ops amdgpu_fence_ops;
-static const struct dma_fence_ops amdgpu_job_fence_ops;
 static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
 {
 	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
 
-	if (__f-&gt;base.ops == &amp;amdgpu_fence_ops ||
-	    __f-&gt;base.ops == &amp;amdgpu_job_fence_ops)
-		return __f;
-
-	return NULL;
+	return __f;
 }
 
 /**
@@ -98,51 +93,33 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
  * @ring: ring the fence is associated with
- * @f: resulting fence object
  * @af: amdgpu fence input
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags)
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring-&gt;adev;
 	struct dma_fence *fence;
-	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
 
-	if (!af) {
-		/* create a separate hw fence */
-		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
-		if (!am_fence)
-			return -ENOMEM;
-	} else {
-		am_fence = af;
-	}
-	fence = &amp;am_fence-&gt;base;
-	am_fence-&gt;ring = ring;
+	fence = &amp;af-&gt;base;
+	af-&gt;ring = ring;
 
 	seq = ++ring-&gt;fence_drv.sync_seq;
-	am_fence-&gt;seq = seq;
-	if (af) {
-		dma_fence_init(fence, &amp;amdgpu_job_fence_ops,
-			       &amp;ring-&gt;fence_drv.lock,
-			       adev-&gt;fence_context + ring-&gt;idx, seq);
-		/* Against remove in amdgpu_job_{free, free_cb} */
-		dma_fence_get(fence);
-	} else {
-		dma_fence_init(fence, &amp;amdgpu_fence_ops,
-			       &amp;ring-&gt;fence_drv.lock,
-			       adev-&gt;fence_context + ring-&gt;idx, seq);
-	}
+	af-&gt;seq = seq;
+	dma_fence_init(fence, &amp;amdgpu_fence_ops,
+		       &amp;ring-&gt;fence_drv.lock,
+		       adev-&gt;fence_context + ring-&gt;idx, seq);
 </pre>
    </blockquote>
    <pre>seems we are missing a <span style="white-space: pre-wrap">dma_fence_get(fence) somewhere as I got the following error</span></pre>
    <pre><span style="white-space: pre-wrap">[    8.317720] ------------[ cut here ]------------
[    8.317723] refcount_t: underflow; use-after-free.
[    8.317734] WARNING: CPU: 18 PID: 752 at lib/<a class="moz-txt-link-freetext" href="refcount.c:28">refcount.c:28</a> refcount_warn_saturate+0xf7/0x150
[    8.317743] Modules linked in: amdgpu(E) amdxcp drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper video drm_panel_backlight_quirks cec rc_core drm_buddy drm_display_helper drm_client_lib drm_kms_helper nvme drm igb ahci nvme_core dca i2c_algo_bit libahci wmi hid_generic usbhid hid
[    8.317786] CPU: 18 UID: 0 PID: 752 Comm: kworker/<a class="moz-txt-link-freetext" href="u256:2">u256:2</a> Tainted: G            E      6.14.0+ #61
[    8.317790] Tainted: [E]=UNSIGNED_MODULE
[    8.317792] Hardware name: Gigabyte Technology Co., Ltd. X399 DESIGNARE EX/X399 DESIGNARE EX-CF, BIOS F11 10/04/2018
[    8.317795] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
[    8.317804] RIP: 0010:refcount_warn_saturate+0xf7/0x150
[    8.317808] Code: eb 9e 0f b6 1d 92 c1 ba 01 80 fb 01 0f 87 32 6e 7c ff 83 e3 01 75 89 48 c7 c7 f0 c7 1e a2 c6 05 76 c1 ba 01 01 e8 69 93 8f ff &lt;0f&gt; 0b e9 6f ff ff ff 0f b6 1d 64 c1 ba 01 80 fb 01 0f 87 ef 6d 7c
...</span></pre>
    <blockquote type="cite" cite="mid:20250828140548.5792-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre"> 	amdgpu_ring_emit_fence(ring, ring-&gt;fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_wptr(fence);
+	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)-&gt;dev);
 	ptr = &amp;ring-&gt;fence_drv.fences[seq &amp; ring-&gt;fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -167,8 +144,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	 */
 	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = fence;
-
 	return 0;
 }
 
@@ -669,36 +644,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
- *
- * @ring: fence of the ring to be cleared
- *
- */
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
-{
-	int i;
-	struct dma_fence *old, **ptr;
-
-	for (i = 0; i &lt;= ring-&gt;fence_drv.num_fences_mask; i++) {
-		ptr = &amp;ring-&gt;fence_drv.fences[i];
-		old = rcu_dereference_protected(*ptr, 1);
-		if (old &amp;&amp; old-&gt;ops == &amp;amdgpu_job_fence_ops) {
-			struct amdgpu_job *job;
-
-			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
-			 * it right here or we won't be able to track them in fence_drv
-			 * and they will remain unsignaled during sa_bo free.
-			 */
-			job = container_of(old, struct amdgpu_job, hw_fence.base);
-			if (!job-&gt;base.s_fence &amp;&amp; !dma_fence_is_signaled(old))
-				dma_fence_signal(old);
-			RCU_INIT_POINTER(*ptr, NULL);
-			dma_fence_put(old);
-		}
-	}
-}
-
 /**
  * amdgpu_fence_driver_set_error - set error code on fences
  * @ring: the ring which contains the fences
@@ -765,11 +710,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
 	amdgpu_fence_process(fence-&gt;ring);
 }
 
-void amdgpu_fence_save_wptr(struct dma_fence *fence)
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 {
-	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
-
-	am_fence-&gt;wptr = am_fence-&gt;ring-&gt;wptr;
+	af-&gt;wptr = af-&gt;ring-&gt;wptr;
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
@@ -830,13 +773,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 	return (const char *)to_amdgpu_fence(f)-&gt;ring-&gt;name;
 }
 
-static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	return (const char *)to_amdgpu_ring(job-&gt;base.sched)-&gt;name;
-}
-
 /**
  * amdgpu_fence_enable_signaling - enable signalling on fence
  * @f: fence
@@ -853,23 +789,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 	return true;
 }
 
-/**
- * amdgpu_job_fence_enable_signaling - enable signalling on job fence
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_enable_signaling above, it
- * only handles the job embedded fence.
- */
-static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	if (!timer_pending(&amp;to_amdgpu_ring(job-&gt;base.sched)-&gt;fence_drv.fallback_timer))
-		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job-&gt;base.sched));
-
-	return true;
-}
-
 /**
  * amdgpu_fence_free - free up the fence memory
  *
@@ -885,21 +804,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
 	kfree(to_amdgpu_fence(f));
 }
 
-/**
- * amdgpu_job_fence_free - free up the job with embedded fence
- *
- * @rcu: RCU callback head
- *
- * Free up the job with embedded fence after the RCU grace period.
- */
-static void amdgpu_job_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
-}
-
 /**
  * amdgpu_fence_release - callback that fence can be freed
  *
@@ -913,19 +817,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
 	call_rcu(&amp;f-&gt;rcu, amdgpu_fence_free);
 }
 
-/**
- * amdgpu_job_fence_release - callback that job embedded fence can be freed
- *
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_release above, it
- * only handles the job embedded fence.
- */
-static void amdgpu_job_fence_release(struct dma_fence *f)
-{
-	call_rcu(&amp;f-&gt;rcu, amdgpu_job_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_fence_ops = {
 	.get_driver_name = amdgpu_fence_get_driver_name,
 	.get_timeline_name = amdgpu_fence_get_timeline_name,
@@ -933,13 +824,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 	.release = amdgpu_fence_release,
 };
 
-static const struct dma_fence_ops amdgpu_job_fence_ops = {
-	.get_driver_name = amdgpu_fence_get_driver_name,
-	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
-	.enable_signaling = amdgpu_job_fence_enable_signaling,
-	.release = amdgpu_job_fence_release,
-};
-
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7d9bcb72e8dd3..71215aeb1b6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_device *adev = ring-&gt;adev;
 	struct amdgpu_ib *ib = &amp;ibs[0];
 	struct dma_fence *tmp = NULL;
-	struct amdgpu_fence *af;
+	struct amdgpu_fence *af, *vm_af;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -148,18 +148,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* ring tests don't use a job */
 	if (job) {
 		vm = job-&gt;vm;
-		fence_ctx = job-&gt;base.s_fence ?
-			job-&gt;base.s_fence-&gt;scheduled.context : 0;
+		fence_ctx = job-&gt;base.s_fence ? job-&gt;base.s_fence-&gt;finished.context : 0;
 		shadow_va = job-&gt;shadow_va;
 		csa_va = job-&gt;csa_va;
 		gds_va = job-&gt;gds_va;
 		init_shadow = job-&gt;init_shadow;
-		af = &amp;job-&gt;hw_fence;
+		af = job-&gt;hw_fence;
 		/* Save the context of the job for reset handling.
 		 * The driver needs this so it can skip the ring
 		 * contents for guilty contexts.
 		 */
-		af-&gt;context = job-&gt;base.s_fence ? job-&gt;base.s_fence-&gt;finished.context : 0;
+		af-&gt;context = fence_ctx;
+		vm_af = job-&gt;hw_vm_fence;
+		/* the vm fence is also part of the job's context */
+		vm_af-&gt;context = fence_ctx;</pre>
    </blockquote>
    <pre>I think vm_af is not needed - above code can be</pre>
    <pre wrap="" class="moz-quote-pre"><pre>job-&gt;hw_vm_fence-&gt;context = fence_ctx;</pre></pre>
    <p></p>
    <blockquote type="cite" cite="mid:20250828140548.5792-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +169,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_NOWAIT);
+		if (!af)
+			return -ENOMEM;
+		vm_af = NULL;</pre>
    </blockquote>
    <pre>vm_af can be removed.</pre>
    <blockquote type="cite" cite="mid:20250828140548.5792-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	}
 
 	if (!ring-&gt;sched.ready) {
@@ -289,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring-&gt;cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev-&gt;dev, &quot;failed to emit fence (%d)\n&quot;, r);
 		if (job &amp;&amp; job-&gt;vmid)
@@ -297,6 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	*f = &amp;af-&gt;base;
 
 	if (ring-&gt;funcs-&gt;insert_end)
 		ring-&gt;funcs-&gt;insert_end(ring);
@@ -317,7 +323,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 311e97c96c4e0..9a78fe01efa3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		   ring-&gt;funcs-&gt;reset) {
 		dev_err(adev-&gt;dev, &quot;Starting %s ring reset\n&quot;,
 			s_job-&gt;sched-&gt;name);
-		r = amdgpu_ring_reset(ring, job-&gt;vmid, &amp;job-&gt;hw_fence);
+		r = amdgpu_ring_reset(ring, job-&gt;vmid, job-&gt;hw_fence);
 		if (!r) {
 			atomic_inc(&amp;ring-&gt;adev-&gt;gpu_reset_counter);
 			dev_err(adev-&gt;dev, &quot;Ring %s reset succeeded\n&quot;,
@@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job)
 {
+	struct amdgpu_fence *af;
+	int r;
+
 	if (num_ibs == 0)
 		return -EINVAL;
 
@@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_job;
+	}
+	(*job)-&gt;hw_fence = af;
+
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_fence;
+	}
+	(*job)-&gt;hw_vm_fence = af;
+
 	(*job)-&gt;vm = vm;
 
 	amdgpu_sync_create(&amp;(*job)-&gt;explicit_sync);
@@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return 0;
 
 	return drm_sched_job_init(&amp;(*job)-&gt;base, entity, 1, owner);
+
+err_fence:
+	kfree((*job)-&gt;hw_fence);
+err_job:
+	kfree(*job);
+
+	return r;
 }
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
@@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	/* Check if any fences where initialized */
 	if (job-&gt;base.s_fence &amp;&amp; job-&gt;base.s_fence-&gt;finished.ops)
 		f = &amp;job-&gt;base.s_fence-&gt;finished;
-	else if (job-&gt;hw_fence.base.ops)
-		f = &amp;job-&gt;hw_fence.base;
+	else if (job-&gt;hw_fence)
+		f = &amp;job-&gt;hw_fence-&gt;base;
 	else
 		f = NULL;
 
@@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&amp;job-&gt;explicit_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (!job-&gt;hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&amp;job-&gt;hw_fence.base);
+	kfree(job);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job-&gt;gang_submit != &amp;job-&gt;base.s_fence-&gt;scheduled)
 		dma_fence_put(job-&gt;gang_submit);
 
-	if (!job-&gt;hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&amp;job-&gt;hw_fence.base);
+	kfree(job);
 }
 
 struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 931fed8892cc1..077b2414a24b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,8 @@ struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
-	struct amdgpu_fence	hw_fence;
+	struct amdgpu_fence	*hw_fence;
+	struct amdgpu_fence	*hw_vm_fence;
 	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e4..901f8bd375212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -152,11 +152,10 @@ struct amdgpu_fence {
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
-void amdgpu_fence_save_wptr(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -166,8 +165,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bf42246a3db2f..7d1a363ad6878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &amp;fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job-&gt;hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af-&gt;context = job-&gt;base.s_fence ? job-&gt;base.s_fence-&gt;finished.context : 0;
 	}
+	fence = &amp;job-&gt;hw_vm_fence-&gt;base;
 
 	if (vm_flush_needed) {
 		mutex_lock(&amp;id_mgr-&gt;lock);
</pre>
    </blockquote>
  </body>
</html>

--------------fw8GYw4Qe6gOJKE0hY7v7Bxr--
