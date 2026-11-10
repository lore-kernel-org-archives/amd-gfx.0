Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B849606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DoaGWKpk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B86B10E047;
	Tue, 10 Nov 2026 02:02:00 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0296C10E047
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 02:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhwuSUJ65IXNVRclog4UlNhnmsltjMToO64s9NNszYAmKwHiygO+oZpNqPr8P6ccHtVh1ipDn+mBd/0T22FJfaOeWlzNfupVGHtwwfJG2cV6kCLCpBQm4mRxS7TJNwHvdkBjh48B7ab4ApuUhxXT0JSVbdl8GwpSwEUKZkSrbLfCUIOgdInwObZnA6R9Kv0yZMrNnFUsQjbN56fzwOnY1ecvQY8y19vO0at7b5/pgbZ+/rIDJhb5VnONZHbES1qOapY43+Wqnb54RRLjLvB+y8fqzOiX7CdMg02xCZbQWGvjc8ZEqVMMnPAoSE39H5FMpO5OsJWlXOzo7lqgIYoOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzjS/OAy+xk3hLDz83U79i+janrUgVwcIcXhT9pjoDY=;
 b=O/nVyYQa+SLm8ZDohD7oGNfPDjdHpmXQFAZfINF6/VvNWYEvxGgFpRgM7GPrUTjoeYamE4Ad88rq2oyxo4cfhaTWHEpWHJ00VK2iw0Pb4xR/bysk5OVdpP8cLvsKn3QTTmBngY7/lhQJhZwRoRWSyfggcocDc6cNiUucN2SWHGMCRk4i1fbUh9kHER4GKZlUJ6Ju3iu3Ai83UnwMGl2wKjhRQfFesY4OVgFS0bUL/VOlbkqG5qoxam3wE6fhTOtluqhlleyRVJPoBGJexaUrMTAL3VTkNZGgtmYqWyBaXx5d6vHej9oeBnsFca9A1ws39bPeWkxCXWox2Urcpj6Vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzjS/OAy+xk3hLDz83U79i+janrUgVwcIcXhT9pjoDY=;
 b=DoaGWKpkjtIT7Z5u/8gu8RSdaD0r1cgNUUEdxJq++ptsLU+kO4+VZd8gGKbMYuWphFCIXBISsmXrRoEUXDiYBbq12GNXMK7kUfD3b/0oOXyHRUNCSUJlktitGlZJjpfQ0TpHBmfVAqHIj4lWuhwkQ/h5xBAeGEsfsdIzabdNFO0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by CH4PR12MB093331.namprd12.prod.outlook.com
 (2603:10b6:610:507::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:01:50 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:01:50 +0000
Message-ID: <f4f18d6f-db29-46ce-82f2-ca6269810e49@amd.com>
Date: Tue, 10 Nov 2026 10:01:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 3/3] drm/amd/display: Add a KUnit test for the custom
 curve minimum
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com,
 siqueira@igalia.com, harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com
References: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
 <20261103-amdgpu-aux-curve-min-v1-3-62119efdcc6d@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261103-amdgpu-aux-curve-min-v1-3-62119efdcc6d@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|CH4PR12MB093331:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c60910-2f9a-4781-0044-08df3ece953d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: e4qiAu8HSIuQ0HeIGxuZ0dVRpXJHEiwADhwJoIx99Is108QRTbAuhFjG+4qhE2qyYdmU7mKcWPLIG0UnIX7oPhimoPMO+/5cz/MB3nC8mLYbsUNG3rBwTy9vY+aLtpJhmChWjn7gInnpD68P2OGEpxOvevl2VmynO935nJAJy8YnKAFpXMBI+E7PSMT4VpJGQihOZNZNvUkW0nl6h0o0rIimZT+bHD2zlZfMbUJTN7K2om5hYCIe/c1muVwqxH1YKicMmD1KstYlZ0gw8x3vh/F8WMFC+XHoFNsMooyM+YLBTXHuhyC12ni2kD9ewg2YBM9FRRlNNCPClhndgG0hUl16Fyqip7UN/oqTSvXlnKocfRd5N2ctsbngokxCRlZuGFnrF6QZOZd4EP+8sSBmwZZ5F0S0vFiG/WLNED/ygDNtdcwq686Jk8YHR1qqSWYpDu15HFLC5W4DrgKJ8zkyaC2jHrhweHVfxl95A4c/E76uNsZuukh9aWTT/T4RlNzXs0vGNS959v3BB4q7BhA07+yf7MPELdw3VySOVqxUJDdF7FjsiHzQ4/B6BV9XdBm2Z8mk9ivJTqTYHa3cG1pWPaCx9NIQS3TpH9b8n/GC5NQB+wioKNAoX9p2ORNeK7s7inG/eAPgJOGKcSTW91oBplnrpjndIaH2aglGhR8L+3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWd3bU4vbDRZd1cyTU5TbDVUNVJLMWJhTUNzNkc3UVdqWGMyYmlUcWthT2Jl?=
 =?utf-8?B?UlIzZld0TFlXaUt0M0tnSWtFbG1aMitETmdlSExRNlhCcktXUUc5QzZaaUxX?=
 =?utf-8?B?RFFjOUdId2RMQmsvdXhlTEc4V3RDdGRzSlMxY1FQeWNJSG9QZEtLdlAxZFlP?=
 =?utf-8?B?cjBGQkVuU2ErTlBRaFhtUWR5dGdzMmdjb2VOOU9STzBVNnZoOGpzTUt3L29N?=
 =?utf-8?B?M29uY2p2aVlQYW9kcHlraGsxY04rRG5DRExGeGhvRHpBYmxlcFczbmtZbXk2?=
 =?utf-8?B?SVdvbVhCYXJoVWZKKzhacFNhNnpVc05ZejVRTk5Ca0crY01Xb0FMWk9ibnlj?=
 =?utf-8?B?VHNydFNUTEJwak9MSGNMTjVpOHRjdjQzWUtLQUdBVzNZclg0bDZqeE9qR29J?=
 =?utf-8?B?cEdsRDR0Qm83c3VyNzhvK3M2V2VnRjU0amZwMDV4a1NKZ3VJRVUzOXpVWndM?=
 =?utf-8?B?bWg4WnRlVzFBSnA5M1c2ZUdiNTNTNERsOElTQVB1a0ZUQklLTjl3Nm50aUls?=
 =?utf-8?B?MFJjTlpHRmpZUy9jSmdtUnh1RWVUZVZkZC80QmZieU4zbEVlMk5FQ08rL0h1?=
 =?utf-8?B?cXRrSkNtbXJISVpqRmRUVDlQbnRheVZCc1lDQm00YXpsQ0g2MGxnam1Ca1Az?=
 =?utf-8?B?M2lDdUlVOW9kTVdramJiczZaK1d6ajlsQ1JNeHlZZHpJYy91eWNEeEhLclRu?=
 =?utf-8?B?dzc1ZzEralBLS0hiRGI3R0FNMnhTZmYwQWhuVnhXZmU1K0ErZWRRVTd0Y3dQ?=
 =?utf-8?B?UkUweVlLaEJJMkh0dWtGb2daeUd6a0FOWnF0Z1B1UjJHTW5MbnM1RDJKOUZu?=
 =?utf-8?B?OEY0R0k4bEhtbm91R3hianRiNDlWT0lNanFiQ2hkY0tjUmpLcFlvaXRpVHU2?=
 =?utf-8?B?UnRWeTQvM1NPUG5seVlSY1R5TUpGc2Q5SktBMlBjSzRkTkJZYW5JZWh5RHNs?=
 =?utf-8?B?b1I3V1o2dHJra2dSVHAvNVlUeDNERzBEQ3FuMm1NR0tySHVtSXdLdlZaRFhB?=
 =?utf-8?B?RHlUcGprazl4alRtcXBacnJNTlVKVHZUMWlsNDRHajhCR1VCY1ozWTNweWpr?=
 =?utf-8?B?VXBYdDUwSTAyVElEbi9qSEd4eDN2OHJ6UUk3cnIzM3p1ZU93Tm9SZnNSODlM?=
 =?utf-8?B?dFNIbzc1N01sblRVRHZGK05tTTRadHRUdS9iUlZZdWRuQlJIMHA1YzdRNG1w?=
 =?utf-8?B?WmJveU94Qk9kTmVBMWtHWUU4M0NLTG85RG9ycWdZVG92T0lSTTVRbDJUNElQ?=
 =?utf-8?B?aG1xRE5mZDdUams5QW5YbGVka2hRc25wbDZVOHR3Y2ZDci8wc243SFNPai9q?=
 =?utf-8?B?TDVZaWhCQkFUZ04yeVdnblNNSFB6Qzl3SHJFcU00Nkc3YmtYaWZrTjVyYWJt?=
 =?utf-8?B?a1FmTUZjNTRDejU2MEZWT2RZSk8wczlPM1oyTHM5dmV1WTBLTzh4eGQ0WHk1?=
 =?utf-8?B?Q3o4SmtJZ0JNV1lrZitwb1BBZWtBQnlySHlXeE1aNVEydjdZK1oyZU5aUlR3?=
 =?utf-8?B?ZGZ1U2RUZVFTMVBYYkVCWUpGdjd3OHBLbThYQ0NDOTBwTFBDbkVqWU15R2dJ?=
 =?utf-8?B?NVg5RGdTVXAyODlVaU45NzhiZDJaV1EzaVJLdHRtekRrdWdWaTdrTjgxUHY2?=
 =?utf-8?B?czdMUjZyalB4TEs0ZTdvbFJ6MEVyalRuUlc0SzNreFlzUG5WV2lMVUpqeGpi?=
 =?utf-8?B?N3BlWGRzQUd2OFdMV0ZTaVBJa0libDZyREpENEh3eWpMaWZuYklDQzFlLytM?=
 =?utf-8?B?T3JvVjcvTHk5VHMxZHpMOUJKWFdENkN0SVBiNGhGM0VHOWFOWndJVEtwYW9m?=
 =?utf-8?B?U2luUTlOaTU1RDE3dFpKQk1sVFpQY2xXa3Ywak15TStkYU5BdTlaV1RUL29L?=
 =?utf-8?B?MUY2NmNQUGxTb3dwcEphdDlLaTI5SGIzUG9aSlNIK0xXK1czVUxtMnNORyt3?=
 =?utf-8?B?cXk4aXBKUEVmbm9kQWxzWXRUVGN4ZnI2Mngwc1hnV215YnhqdE5laVhHOVQr?=
 =?utf-8?B?MEtHZW9sUC9sMmdHaEhCQk5Oamlhblo3RE51TmJZd2diQnFXVVpNYXg1bjUw?=
 =?utf-8?B?bG4rRGEwM3FzNjVoekNtTjVVQjVQczJGdy9iWU9sYmY2ajJ4VmVRSlUrWHZN?=
 =?utf-8?B?NDBhRi8rNG1XcHBBYVRabk9NRFhFR2xEVVgyRHk4M2dSS1BMVlpiRllmOGlG?=
 =?utf-8?B?dUE1Y1dQREd3TzJLcG5DazdHRjk3S01yYlN2akZZc1hqRWNFS1N6WDNQTWNt?=
 =?utf-8?B?cVlvS0t2bUVjUXRFMW92YVRJUEZpU25Ga3IwQmhha2lsZDUyRzNtaDJWNGZk?=
 =?utf-8?B?d2pCZmlPQzFvd3NQSkRDK1pzTzNYUVREYWFiZ3hGR2N3OEdBTnVDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c60910-2f9a-4781-0044-08df3ece953d
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:01:50.0608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqsQ3ruzaamp8P1Jf3WQnOrUU1DuolDeUJ/Qw06UhmGe+6JuwkxNepzAmjH5VDcvTiGiRLGpZPTv7yHF2lst9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB093331
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
> Check that convert_brightness_from_user() adds the minimum once with a
> custom curve: a request for 0 gives user_min on the AUX and the PWM
> range, and half the AUX range matches a value worked out by hand
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> KUnit on UML with PROVE_LOCKING: amdgpu_dm_backlight passes 74 of 74.
> Without patch 1 the new test fails with 1998, 131999 and 6023
> ---
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 40 ++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index f1a558516cd8b..3d00cde8c77bc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -1383,6 +1383,45 @@ static void dm_test_brightness_from_user_midrange(struct kunit *test)
>   	KUNIT_EXPECT_LE(test, result, max);
>   }
>   
> +/**
> + * dm_test_brightness_from_user_curve_min - Test Custom curve adds the minimum once
> + * @test: The KUnit test context
> + *
> + * On the AUX range of 1..512 nits with points (50, 20%) and (200, 80%), a
> + * request for 0 must give the 1000 millinit minimum, where adding the
> + * minimum twice gave 1998. Half the scale is signal 128, luminance 51%,
> + * so 51 * 128 / 101 = 65 of 255, which is 1000 + 511000 * 65 / 255 =
> + * 131255. A request for 0 on the PWM range with min_input_signal 12 must
> + * give 12 * 0x101
> + */
> +static void dm_test_brightness_from_user_curve_min(struct kunit *test)
> +{
> +	struct amdgpu_dm_backlight_caps caps = {};
> +	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
> +
> +	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() &
> +				    ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
> +
> +	caps.aux_support = true;
> +	caps.aux_min_input_signal = 1;
> +	caps.aux_max_input_signal = 512;
> +	caps.min_input_signal = 12;
> +	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	caps.data_points = 2;
> +	caps.luminance_data[0].input_signal = 50;
> +	caps.luminance_data[0].luminance = 20;
> +	caps.luminance_data[1].input_signal = 200;
> +	caps.luminance_data[1].luminance = 80;
> +
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), 1000U);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 256000), 131255U);
> +
> +	caps.aux_support = false;
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), 12U * 0x101);
> +
> +	amdgpu_dm_set_dc_debug_mask(saved_mask);
> +}
> +
>   /**
>    * dm_test_brightness_from_user_with_curve - Test Brightness from user with custom curve active
>    * @test: The KUnit test context
> @@ -1976,6 +2015,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
>   	KUNIT_CASE(dm_test_brightness_to_user_above_max),
>   	KUNIT_CASE(dm_test_brightness_from_user_midrange),
>   	KUNIT_CASE(dm_test_brightness_from_user_with_curve),
> +	KUNIT_CASE(dm_test_brightness_from_user_curve_min),
>   	KUNIT_CASE(dm_test_brightness_range_zero_signals),
>   	/* amdgpu_dm_backlight_fill_props */
>   	KUNIT_CASE(dm_test_backlight_fill_props_ac_linear),
>
