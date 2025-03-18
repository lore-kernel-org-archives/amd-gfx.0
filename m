Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B219FC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A4A10E489;
	Tue, 18 Mar 2025 13:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgWvnHCH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E0C10E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpIZGaRubbpLwxDpK9+R+pI0NerT3XYoFhtsSffYAqUYIWWiOT3vLLEMvgELFwdpVmpzN2zSovscTK4Btd1ThukX+qN+KYj3AHXI9zOy8OgY84OVurueXPov7h0HWJ+3oO9E0en7jA1n4aDJiPJbsf0adF0P+Y9akeZTHDP+a5LiTGvy5HbrU74ZeYdJ6eRyxhxDy/59ChWIAo3OMiR0qyF4M+huCuyKqsDYmNMlImOmq0mt0/BBBJgFM0KPH+q26iRNRlXT19+F6mGo3gPrmYEGukwlGoLJJ7bi/F+YrxqJfln63+f+cavxdrsx1vBEfSlxQQVwUlCi2PABPDyysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThAHqQOGZM/NdfFxFE1AMeiVgGwHNcMU0ndoLDLnqu0=;
 b=Bp2Crop2fTDlWa+nGDG5/jUg3OWmtXQfvD7tFDTa03STmG42/42mAHN2WRZue0uasbN6ocU4J/8bQBXGz2rnoRPEFRvCjRWhlzX486ukdvAcLvWWFBUB5BE/8Y1xaLXZTUsLIDsth9xKqEQvicO/1to3tPjnMGjBT2TU5y9mtqtyNGzA/QPAJttzWw4dPPmZ8Bx0/a3M3KP58UcwBYVpEMS2p15OSZw3wBZSq/YCsbUJzxMWHVCe9u9fDeM54fd6s3nTewU9dTUO/BD59wouECPSkJlfqcMxgtJbTUq7Z5iUAcd3jPcfJ/b2BS6FAEbKTXuqIvF1VQchbucPNKSyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThAHqQOGZM/NdfFxFE1AMeiVgGwHNcMU0ndoLDLnqu0=;
 b=fgWvnHCHHRxzQ7FzeVLZxfVBFxbOIYFcQRusf8m0oAYlbIyC2AzrZ2+RizP7hKNp2LfezKfYktMcf2mSS1U3jC6rxhvLz5jro8FKECB1tfx+eo9mr8sc7FhVFIBL+vNnTKJJ6zYJ2Tz7iDxrA1s5dJfe1eZZyZ3buET6PgIoemQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:22:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 13:22:17 +0000
Message-ID: <ea28a732-60bb-4d2f-af1f-1451a987f9b3@amd.com>
Date: Tue, 18 Mar 2025 18:52:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: Add debug bit for smu pool allocation
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com
References: <20250307062006.251686-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250307062006.251686-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e5d23b-e970-4c8d-2181-08dd661fe766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDNIMndOazBjWHcvamV4ckhiVENrajFJUVc4Uk5POVVWd1FkUjBpUE4vVlcw?=
 =?utf-8?B?ZkMrUkM1TzdhVXphdm1OMllDbldSQ2o2ZFZpcGJnM1huVy9qYnVhTWRnazFn?=
 =?utf-8?B?RUlPckJaWnB2QWZyd05FQmZ6UkQ0ZWprK1R5KzZieDJ0VDFUY3czalU5VzJh?=
 =?utf-8?B?U0Q3Q2oyL2R6UzlQMHdaZC9Ud2tmN0o3NEZiVTd6R3htTkxDK082NWdiR2Nx?=
 =?utf-8?B?aXExOE90YWJ6K2U3bTk5ZWJpaTNkY1l2ZGkwM1plcUNvOWNDRnVpd2xYeHpz?=
 =?utf-8?B?ck1kdWgvYjFKUDlkbVF0alMvTXF1eG8rS1NsbTEzbXBldS9KVm4veVhTQ2tJ?=
 =?utf-8?B?ZjAyK2w3T3lZWU01ZmlsTlh1OGlwTy9PWjJqWWhTMks2eGpYYU94QkVOQ25X?=
 =?utf-8?B?d0VCQXB2VzcwV2h2TkpDYVprVGxmUlhlNk5IVUZXcEFqaXM1Q1JJbHRFM1RO?=
 =?utf-8?B?VHV5Zm4wVVhGWGovMGdhbndWd0l5WkJqZzE0UkNEeWJQa1JSSWw4TEN5dkh3?=
 =?utf-8?B?Q2s2R2VnWnIwQjRJSERxN29TTitYdEgvRHRvT0dMWXlvWE9GVlhkVEROSXJ1?=
 =?utf-8?B?NTBDRWdqRjhKbnN4R281a3k5N0JTRlBmTjMzeXlDalZRb3k1MjlGL1lFM3E4?=
 =?utf-8?B?ZVNlTUp1c0ZDd2F0c2FOYktWY2dBanp2OVhleW9GK0ErWFJrcmdrWXB0L1dM?=
 =?utf-8?B?b3h1OFVVaFJ6ZitKcHh5TkFKNDVVK2pvQmpwOGlMZEZ6SHF4TThuY0dmSFZT?=
 =?utf-8?B?eFJmcG9WTFZTUGlPRHM5M1NHMTdRMW5UWC9HMjFkTVlFTGwrRnNrRkdwMnRh?=
 =?utf-8?B?OGtpeUE4U09iOFFneEo4K2gvWGZVQzhKWmt3RnJYaWM5eGYxa0xYcURRZ2dI?=
 =?utf-8?B?Um9mdnMwUTRhSzZGaFRmUFE1SXByNWVQTTdpenpyVUNqTktXWlBKWDBZVDVu?=
 =?utf-8?B?Mm90SG1OR0dTYWg2WTZuL0hoUzArZDJ4THU2a3BTQXhEazN3bEFmQlV6bytL?=
 =?utf-8?B?bldoQTROQmoxWUJPUThJcTB0K0p6ZndrOExXUjRWSis4ZU41M0tvYTBwaUM0?=
 =?utf-8?B?dzFZWWFBckdKSnVsR1NiMUwvY2FBenhSdzFuekNEWGplV0FLV1Byd1FZQitS?=
 =?utf-8?B?YWtEZ0RISzZJYXZDQUQ0YmVjOXljZXhpUlFZbG92TWQxMHBtZWFFV3VnL0xK?=
 =?utf-8?B?QnU4RHQ3MW9HeFpEYW1Na0MwNWUvQjgyZWU5NWJLYS9jckZ3aXpIRm1ucXZo?=
 =?utf-8?B?UjlRNmY4cCtFUTJFallLVm9jTVpzQU5uK1BINGpQRUlBMUJ2WTk2bnRXZndQ?=
 =?utf-8?B?NEF5YlJHZ1NUWVExOGFJekticzZkc0QrNXRhSndmTXc5VzV2M1RoS3RobWxa?=
 =?utf-8?B?eERUVzlFd1B2SVlQSjUzYUNsL3RHWHdRYkkxczBUL0RCWk5YbGx2OWpYL3VP?=
 =?utf-8?B?cWs4UUozSm9EVHl1TXZBc3oyUzZzQkRPM3M0ZkVBSzRzVkZOdHNNd3NxN0Zh?=
 =?utf-8?B?OXNMUUR2ZmpDbUg1M0ZJb2o0cHduTW9qUDhXOUJrTFFKQWU1TlExSEJmcDkz?=
 =?utf-8?B?Tjk0U2owYzE1dWlIQVoxRlFIU2szSlptRjV4M2pDckdWNTRmeEdGbkV3Vk5W?=
 =?utf-8?B?MERoc1JRVm1rUUNjSVUwQlorOUJaSUJidkZEUVhUQWdPMXRIeS9FSzlqZG81?=
 =?utf-8?B?VGJrK0htK2VaSUtjZTFPWkdqd2w4N0ZBand0bEJSbFNzcHJVbUc3d0tUWU9T?=
 =?utf-8?B?ZEZHUHo5dDk3NCszaHZYVi94K2c5b0RNbXN2L3FPeFBoUHh0WXIySTN0dTVU?=
 =?utf-8?B?SlZ4dlYzZUpMRDhXak9ERXE1Rk5Zc0NPTi91QzF4VlBLNUVwNjhnR3JFUjJw?=
 =?utf-8?Q?2JG5h+busKzg+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRNNHJ4aGwrbEViTnVBcWlLblowSjlkaWNEQ3A4WXl4aEJOVWdldHNhdFNR?=
 =?utf-8?B?Y2NoN09UeXhzYytoMVhDbVAwbWNESTZyWnAyejNUTXFDUzdiYjA3aVd1MmFO?=
 =?utf-8?B?bUs0cGJ5QXZ4RWNZelZmSXJjMTg5L3pEbXl3M1NxVEVRejBXZkF3SE9LazRX?=
 =?utf-8?B?WlcydHkvVm1iSGczSXF0cXI5dGFrOGJyelBFM2NhSW1mN2RBbWo0bDUzQ1dJ?=
 =?utf-8?B?eFMwN29rNW1TakZqSXMvNHRHMEJmMXZQYk0vZXZQdE9nOXNycmNDQVpCeXNM?=
 =?utf-8?B?ZkpaOUdrNktESWZ1SkpKVW1yRjhtSjBuNUdxSWdzMHdxSjQ1NmlXcmdNTFhi?=
 =?utf-8?B?Tk8wTDNZL3A1MWo3QU1PZDNrOEhzUWJRN0ZMM0svOC9zajgvYzRjbS9kbUI2?=
 =?utf-8?B?aXYrL3pkbno5RHYrMFhOdEVDUVJ0OXVHems5eThoZmloN3RZblRoOWR6TW8y?=
 =?utf-8?B?eVhFbGxlL1FuM1Z5c09LK3VDT1dTajYyUkQ0M2JYd1VEZ1UzRzJXY0ZyQllx?=
 =?utf-8?B?bmpYZGc3Q1NCaDJKUDlVbnNzcVlFYjRzejIxVHd5dnl3U3dDb2hQTi8xRWg1?=
 =?utf-8?B?ZGNWaVdOOUdQcTkvNmQxSXJMdFpNQmNDTFFEc3dzUXNjbTQ1QmtkRkhONkNM?=
 =?utf-8?B?a3B6MDArWTNKaHdGVkErREtOazVtSXhWZERCK1JEV3pwSURJMk9ibGlvOHp4?=
 =?utf-8?B?cnFQajMzWFhYZ3ZNTnQ4WDY3aWpVL1RWbUpzY1VTYnhoelRaMmxoclNXaXRF?=
 =?utf-8?B?akJFcFFrU2tnTlYyTFhHQTVuUnVRK3lmaU4xdWZ4dDlkUDhFYjBsdFZjdFpq?=
 =?utf-8?B?OUJFajhwNkFnMXlhKzhmS0ZvYlVRTFJuenQrZjAweGxoWE9zN2xaVWJ5WTZx?=
 =?utf-8?B?YmF0SG1PTEU3Vk5KWTRaN3QrdnF0U3lmY05FUWlrRFhZZ1J4M1c3Vk1TZkxD?=
 =?utf-8?B?RWpWQjQ0NGM2d0pTeWRIKzlpU3hRYzRvcTVEeDkxMlB1NEVzZE1UUWhZNTNk?=
 =?utf-8?B?MmduZVUvaktIcjRCeWhxZkEzR05mODlQTTRqanpvb0xWZU5adzVyOVNNNHRO?=
 =?utf-8?B?U0libzFrUXZlRG9MSlk0WTZpNnpLNzVtZjcycjAxZWZpRFJ1eFRNVk9nd0Ur?=
 =?utf-8?B?THBPTXo3TVJIa1JHOWp0MWRDUGRHMzRsT3IyZjBVTzJvUnBtelFNNWFVU0Jj?=
 =?utf-8?B?dmpCZmt2VUNUR1daT2hTdlZsQW1HQnRBRWRpempyK3R2aW5xUjN1d084MG9m?=
 =?utf-8?B?alBwdEFUNld0QXVTTEM5NVp6VU5ZMk5tWGJ1cUMvbEVLWGxuWjFEc1EzbUJx?=
 =?utf-8?B?SXlsTFdyQjdoQ0xNUmx1TjFRUmdkdUtCMmp3RWNBbWRnSzUyeFpINzhwQTR2?=
 =?utf-8?B?aHNPRzdlZHpSeVlFNm1pZ3prZlZ0S2gwcGtvMGtzT3NVSmxnMmNRN2dPWWJU?=
 =?utf-8?B?N0xkUGpIdGxzdjQ5eVhrRnc5V0RmYVZvb3lqcHlJZjRHWVVwUHpOUU5nWlFt?=
 =?utf-8?B?WW1MOUVjY1dPcU9nVnIrRGpxeVpSbzFqUHNRcmpUQzVuL1Fxbk44cDh4TEZU?=
 =?utf-8?B?U0djSEZacndPUW5yVG83U0N1UmRROFVTdWYrWW11ejlEWURzaVU1cmhvTTVu?=
 =?utf-8?B?ZU5aVGs0YU5xV1N4aDROSGlidk5nV1RPQld1QlBXOTNrZU1OaVg4UUUvN05y?=
 =?utf-8?B?aGs5QlBxRTBSbDEySHRRelNTUDBRRFJtcDA3TDdaZjN5aDJEUm13c2l2WGVu?=
 =?utf-8?B?Z3g5QmhDMHZOMllwbm0yck0yaTAyTXlzYjhvbmphd1FHRHIrSjJWUzNBR0tU?=
 =?utf-8?B?ZWpzaC9DNDFnbXFwRG9iWTZuME1oOFFHZFdxcnZqZGdBeGpEY09BYzExbjM2?=
 =?utf-8?B?WlQwUkhrTDVBMTVWOGhLTThMZjdSVHB1TFdwWTQrTFFHTm5qVnhlQU9Ob1ZY?=
 =?utf-8?B?SUNCMVhWRnJmdjNqL0hRdVpSRUx0T3lLcWJoVXlqOW9TcHFzSWtZdnhOQVox?=
 =?utf-8?B?amRDSWc0emxMcWhwakdYZG41NysyekYyTG9sTWEweHlQaU1yd1hUTFdpQTND?=
 =?utf-8?B?MG03RXNEM1puYmhUTnZtT0FmcWpFdStvUVAxOWlKWXRlM3hmZ3lveUFOVk81?=
 =?utf-8?Q?v/uoZpdIh7Xv8x8LE5zbBr5ku?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e5d23b-e970-4c8d-2181-08dd661fe766
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:22:17.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGo8XJ9TMLy2oNAwqQe+fLmBzUn1rmrG4zO30pedmeeVzKlXxk2m0OayTxGFNMe6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

<Ping>

On 3/7/2025 11:50 AM, Lijo Lazar wrote:
> In certain cases, it's desirable to avoid PMFW log transactions to
> system memory. Add a mask bit to decide whether to allocate smu pool in
> device memory or system memory.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 5 +++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b161daa90019..22775c204632 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -140,6 +140,7 @@ enum AMDGPU_DEBUG_MASK {
>  	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
>  	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
>  	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
> +	AMDGPU_DEBUG_SMU_POOL = BIT(7),
>  };
>  
>  unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2231,6 +2232,10 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>  		pr_info("debug: ring reset disabled\n");
>  		adev->debug_disable_gpu_ring_reset = true;
>  	}
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_SMU_POOL) {
> +		pr_info("debug: use vram for smu pool\n");
> +		adev->pm.smu_debug_mask |= SMU_DEBUG_POOL_USE_VRAM;
> +	}
>  }
>  
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 9fb26b5c8ae7..f93d287dbf13 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -295,7 +295,8 @@ enum ip_power_state {
>  };
>  
>  /* Used to mask smu debug modes */
> -#define SMU_DEBUG_HALT_ON_ERROR		0x1
> +#define SMU_DEBUG_HALT_ON_ERROR		BIT(0)
> +#define SMU_DEBUG_POOL_USE_VRAM		BIT(1)
>  
>  #define MAX_SMU_I2C_BUSES       2
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 54a31d586d55..f6def50ba22d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1027,7 +1027,10 @@ static int smu_alloc_memory_pool(struct smu_context *smu)
>  
>  	memory_pool->size = pool_size;
>  	memory_pool->align = PAGE_SIZE;
> -	memory_pool->domain = AMDGPU_GEM_DOMAIN_GTT;
> +	memory_pool->domain =
> +		(adev->pm.smu_debug_mask & SMU_DEBUG_POOL_USE_VRAM) ?
> +			AMDGPU_GEM_DOMAIN_VRAM :
> +			AMDGPU_GEM_DOMAIN_GTT;
>  
>  	switch (pool_size) {
>  	case SMU_MEMORY_POOL_SIZE_256_MB:

