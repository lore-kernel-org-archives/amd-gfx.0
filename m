Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905C606A338
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xOmIG3i/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2FE10E3F2;
	Tue, 10 Nov 2026 02:04:26 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B254F10E3F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 02:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlMb2CBVHSjOwXej4v+ebz9SNCYtAfzS0FmBhh/F0fXQpyaUVHDztFkkQ0TjJmRSY7xx8W8hGn6QmZJqeg/8TAE0AOKB9shZFbfdg+JuPK11QBWRjbPe5pQP2OJ7ZCDHrmS/JErdMoCkn/TTSL09Xc0i5FoOqsSSkfGUaxSCKxdi7ukacPMUSs/jqUWsKEKGixkjn2NkWJxcEY2W7PDgxnFTZswssmLifIQc3LdOozLNJ9V0UWhw25Tod+gGGOTR3wiWapXEmW07A0Y7owKnnmSeofzxTwtbfjc1dis2gBFiWBG+Vjj8UAxQ1g8HuH5J6W28x97csVgAQ3LvQrPOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69WHjGMnIxzzbbVcQR3gVb4Ojj6QuNzZ8ZNqEFEHOWs=;
 b=wZZtYGzE5aP+TNj3RkeEo5tyOVSxgaPPTCk9LmHI3JwDiQTnyXlAokj0ksB4d3bDiCRHkrXgNXSyX59EtloyfmW4VLlAlyMLBNvi3RJ0C+8FHCrYL3wNntvSWtiPQDsf0veP3dKSvoqkU0Cce+DL6BxPZlc+tD28BW6tSuqsF16v/hs0cJLHL5CmmzYGGZbiLDv8KR8y5x9JWUxHyQOjUEK19N4zNIzci6KAqL7gfHO8utKo+hl/6kL4qHHmsyYvmYbRRuFZIrVlgPKrgkTlRNzcSZ/JrUzV5G+eDPXZoCChdxFzvDEFtM9j2Knl12rqFFYL8XELlb9s4Z0JZkZ41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69WHjGMnIxzzbbVcQR3gVb4Ojj6QuNzZ8ZNqEFEHOWs=;
 b=xOmIG3i/fTrw2PatojqmfXEBvoNdqZTzqUCT6KDo5eauIHbG95x7ww8zjunk3dT8wdts2RZd8WWNv/opo+0iG6NMab/k4vfWo+eFSdQD76r+EVNyaj0AL/MWofhUBImZxi/GAZ96zC72CvkU8daYvq0VDhqpDM2+YOJQkO/SXkY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by DM4PR12MB5914.namprd12.prod.outlook.com
 (2603:10b6:8:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:04:10 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:04:09 +0000
Message-ID: <b866da96-e0c4-452e-9fc7-05375e8f38e2@amd.com>
Date: Tue, 10 Nov 2026 10:04:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 2/3] drm/amd/display: Drop the unused min argument of
 convert_custom_brightness()
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com,
 siqueira@igalia.com, harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com
References: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
 <20261103-amdgpu-aux-curve-min-v1-2-62119efdcc6d@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261103-amdgpu-aux-curve-min-v1-2-62119efdcc6d@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c0b0be-5446-4906-baa3-08df3ecee868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|3023799007|4143699003|11063799006|261102123227099003|261021121427099003|261021123027099003|56012099006|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: b4uLydmnN/LOKbf/9Jf0LnnyLKCn2QDAOj+UHPXgKWpRk7rofz4uFKCbDuuNDsI5Tkh8D9BwSGT4kD37ILC9/rJGs8wdulh40KEiHB7RaCkcpdIvOoren48rBPl/u3cNXJKm414fH9qCuwKETYsYnMXCNqxRMKf2NVV+l1kiG6b+jqDH4OFlXGUGs/X3zd7IukrMBONPIY8I3ztiGBYfuT+rlANlFViqAOJv5+3BtUci/Ogieh1xIQ02xPCUvfcD6YvZZTJYLf+N/0pn0eH8FOCYqsAfvFPd6DMNmTfM6T2OR0Vvncm5DAgmyCB5w+VgB3rKXIQOcv4Ltz7ozWJcb0R5sCNeUldmbwXZNzjBA/2LTrQgjotrKNoX3tUWGdHxZZS9GP5JOgvP+Igp9Sn2xbEpKj1CCM/P5ZiWG2wD+lZ+o+NATB/cjKaItqtKq+0aNr/FtAawDE2ryjsoBgkAhIAIM0L1xLUfzRqFcrkX/hkaig+rimmwVsuJmy2/7wSTzZuf94IC+wHWmYyei+5UvoTPIAkEzBH8AFd7m70Xz/py0bV8dMiFuRh2L458aMsLbTf2PLUA3Byy3xbqTj411u6cQK/doF20qNX/29pTR6BDRgBWJGOV4TOYy0qH5z+1Uh7tZ+E25s9ptcP9bJN8fYduTiJmcvuV9BZzOWYwaSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(56012099006)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdRYThuNDdYeVJ0TmtsTmZ1S2V5OGlqdjR0bHdwZjl0VWtsY25wMTkxU2px?=
 =?utf-8?B?WlNwUndsNmMrV0F0Wm5ZZFhDZjJsZ1ZNZ29Qd1ZtdnEvQi9VTWRJbTJ3WHNE?=
 =?utf-8?B?WUpUQSt3YjBHaGp6UDFUc0tSaDVTZnJYTVNFZzhJMG5lRmVGeTlvL3hUc0xl?=
 =?utf-8?B?dVE0Z29vcWFlNkduRzdVVm9NRys5aC9IdHdvQmpFK2J3VktqZkw0WGlQZUE2?=
 =?utf-8?B?SHB5SS8yRUJyU3BBYWIwUExoSkFzU2JLTlBKZEwyazBadHNzMXJyVEhCQ3pj?=
 =?utf-8?B?WlpTYjRjRzdzMGZ5bVBIWE44ZEN4NlB5VStoYTc2R1pkbVl2c0lJRlNtTlBk?=
 =?utf-8?B?bFRHTGxIb0RQSEZYdStSK0d4T09DMUI3RDFlY0ZkMTRLUlBNNVpjV1JCUlFE?=
 =?utf-8?B?cmxMWFc5L2FDR2RtN0ZtTlpyZHdIVjd0TGJsbUlRMDR0b1diV2xmUVhNZFVl?=
 =?utf-8?B?V0VxL0JEWmJnQ2VyRWRvMjRxcWlKQzZEdVJMSmQ0T3VkV3Fyb0twRWNZbVpt?=
 =?utf-8?B?T3k1NTkvTkFlbGlJWWVEWkQwVnpHTm82SUtBMVY5blFyQVcwUW55c08vSDQ5?=
 =?utf-8?B?N1hObytUeEh1T3IrSkQ2aFF4Ny9HZFFjenhldWR1YjM5dElrVFJrY0ZxLzRz?=
 =?utf-8?B?U0dXdnEzWVd5UWpHd3BJeS9pSG0zWXkxQ3VuRFVud1pZWFNMWUp2SUV0Yk9z?=
 =?utf-8?B?MTRQaGRRa0UyRlQxVVl2T1dWR3RZMFNxUVdrR0hGcEZWanNPRnlrRmVwYjFw?=
 =?utf-8?B?d2Z5ci9ndmQ3MXBsa2F6dUZBeFl2eThPeG54UkJ5UjBvTDQ0ang3bUI4cmpy?=
 =?utf-8?B?ZHFPaW4zMGV5ZnNnU3hGcnpzVmJ6bGIrNWJNTzJTeERBSlhmb2IyQ2JhSTgz?=
 =?utf-8?B?UExONlhJdXZjWi9LWDN1aTRndVhtVkRuNkFkM1RmRmZYSWtuODdOTS8ydHNn?=
 =?utf-8?B?TXZKck42bnl0emZ0WFJ1T055aERCT0tLenFiWnYyNjdoREUxWjZWQ0pmMlRR?=
 =?utf-8?B?Mll3Qm1HQ1hIMEVNTjJ4TTV0RDVOV2dlaVNSV3dkWStVdERUa0RsV1dWTDMz?=
 =?utf-8?B?OENVcUtDQzQrdlljM1JBSFJ6SXRXOExyeDhUKzA5c1M5Q0J4V3hnY2QwN1R2?=
 =?utf-8?B?NS84UExSQy9CUnE0Sk5DYTcyTXM3bW01aHN2MG9OclNHM1BURExlRThqVTIv?=
 =?utf-8?B?OEtNRVp3WnBhSWxIUVE5ZEtpTlUxL21SbWU1eFV0cFlYYURLbXpwdHVlRHdn?=
 =?utf-8?B?ZS9vWEhiYUcxSlBLNk5Na1VkUkMvRUV3SlFGWGUrVXJaSjlicFA3Q3NJbGlY?=
 =?utf-8?B?V2lFdW5VY0x6OVNtbjdURUh5SnpMczZmdUd3KzNIWG5lUDZ4cnFBRjNJbks3?=
 =?utf-8?B?SnBCeVFSN0xhMlI0b0hGTWtGTEFEcVNNOTRUU04vaDloZGhUd1RXRk05bVdy?=
 =?utf-8?B?d2EzV3c2ODhyNjRWTklQVHpzVTJZdmd1ZWZOdFI3OGJKb1NXWndzdEUwUnRp?=
 =?utf-8?B?K1dFa2pJcC9PRzJjYVJpOGdDaWsxd3VjMC93RitaTDNWM1JHSDY0YWwwZlo3?=
 =?utf-8?B?TG44RTFXbGFsTkNhVjM1YnZzMkRweDVxbXkwMk5IYjczZzBQcWtsUHkzOStQ?=
 =?utf-8?B?YlhGeFdyN2xkSzZkdDJsQUlKZ0RIaXN5ODJnSUliTE4wTVhybmY5cHZwSlBs?=
 =?utf-8?B?Nm9iQ1NXaWlBdVg4b3gxb2o0QkZjWEV6Q1UzdEpIeFBEc2FybDd5RDloZlQ2?=
 =?utf-8?B?Rk03djcyeHBLaXYrNkdNOTRKdmcwcUsvem5WNkpsT2d2QW16WjgzN01kVlRN?=
 =?utf-8?B?cUp4L213dUo2OUJCdGx5dmFVU3B1b0ZtbDAvN1V2blAzRC9uemsxb3ZkQWp4?=
 =?utf-8?B?dEZGelBEdW5pSXBoNDQzRWJWOHdXM0dXcUNQL0Jaamx5SE52amZ0VmZZSFdU?=
 =?utf-8?B?U1dKZmpHYjJTOUk5SmFHdFpQUXNxQ1hjTXBIRFlVSkdza1dRZHpNQllVekdQ?=
 =?utf-8?B?MmZ3RmpoOEhkcklFU2NFZnNFaEo0YUd0L2R0aHJJc3JnZG4rQ2dDaFBjd2FD?=
 =?utf-8?B?V1VvVWkzeWZyTkwrcXA0dS9uSU9FLytkVkIrVHkxRW1RRk4wTUdRSlp3cHRD?=
 =?utf-8?B?UG1QM1Q1bTJNRisvWlhtd1MzNXV5alpobk9Va0RkZ2pySFRiTitKaThDcTl5?=
 =?utf-8?B?QVVUV1JneFdEUFI3UC91NzNrTytxWGFDd1RqaGVBQy9LaVRFeTN1RkhsNWl1?=
 =?utf-8?B?MUpKbk5nOVpOZGllaE5PTmlhNTNaKzd1WHdhQUlQTmJ1MUhVa0M5TW56TjJP?=
 =?utf-8?B?OVFTMXpvb2lHZWZ0aUtabWw0ZlMrVG5EZFIvM3orbTdQZkRiQnpnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c0b0be-5446-4906-baa3-08df3ecee868
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:04:09.5851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGImeUFjvl9gm4s0KvR1ZZbS2VNamgJPb7IsjxzfolP7VbBsN1EX9PN1mxcv84DBY42artydidRWV0bL59er4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Ray Wu <ray.wu@amd.com>

On 11/3/2026 9:15 PM, Hugo Sales wrote:
> convert_custom_brightness() rescales the curve's output to 0..max since
> the previous patch and no longer reads min
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c  |  5 ++---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h  |  3 +--
>   .../display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c   | 16 ++++++++--------
>   3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 8b49cbcde91cd..cef2ad8fea74d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -192,8 +192,7 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
>   
>   STATIC_IFN_KUNIT
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			       unsigned int min, unsigned int max,
> -			       uint32_t *user_brightness)
> +			       unsigned int max, uint32_t *user_brightness)
>   {
>   	u32 brightness = scale_input_to_fw(max, *user_brightness);
>   	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> @@ -265,7 +264,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   	if (!get_brightness_range(caps, &min, &max))
>   		return brightness;
>   
> -	convert_custom_brightness(caps, min, max, &brightness);
> +	convert_custom_brightness(caps, max, &brightness);
>   
>   	/* Rescale 0..max to min..max */
>   	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> index 9ad888d3ae7b2..32ba2f8efb33b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> @@ -68,8 +68,7 @@ ssize_t panel_power_savings_store(struct device *device,
>   int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   			 unsigned int *min, unsigned int *max);
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			       unsigned int min, unsigned int max,
> -			       uint32_t *user_brightness);
> +			       unsigned int max, uint32_t *user_brightness);
>   u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   				 uint32_t brightness);
>   u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index 2d7a07d9ad874..f1a558516cd8b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -1054,7 +1054,7 @@ static void dm_test_custom_brightness_no_data_points(struct kunit *test)
>   
>   	caps.data_points = 0;
>   
> -	convert_custom_brightness(&caps, 3084, 65535, &brightness);
> +	convert_custom_brightness(&caps, 65535, &brightness);
>   
>   	/* No data points → no-op */
>   	KUNIT_EXPECT_EQ(test, brightness, saved);
> @@ -1078,7 +1078,7 @@ static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
>   	/* Set the disable flag */
>   	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
>   
> -	convert_custom_brightness(&caps, 3084, 65535, &brightness);
> +	convert_custom_brightness(&caps, 65535, &brightness);
>   
>   	/* Should be no-op due to debug mask */
>   	KUNIT_EXPECT_EQ(test, brightness, saved);
> @@ -1121,7 +1121,7 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
>   	 */
>   	brightness = 32896;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * Exact match: lum=50, brightness_scaled=128
> @@ -1167,7 +1167,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
>   	 */
>   	brightness = 12850;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
> @@ -1211,7 +1211,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
>   	 */
>   	brightness = 32125;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * The function should interpolate between data points and produce
> @@ -1254,7 +1254,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
>   	 */
>   	brightness = 56533;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/* Output should differ from input (remapped via curve) */
>   	KUNIT_EXPECT_TRUE(test, brightness != 56533);
> @@ -1292,7 +1292,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
>   	 */
>   	brightness = 16448;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	KUNIT_EXPECT_TRUE(test, brightness < 16448);
>   
> @@ -1330,7 +1330,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
>   	 */
>   	brightness = 32125;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/* Should remap; result should differ from input */
>   	KUNIT_EXPECT_TRUE(test, brightness != 32125);
>
