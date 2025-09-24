Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B413CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DD210E7A4;
	Wed, 24 Sep 2025 17:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqSxfvdP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3019C10E7A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0Ls0ko3yWrRtUoFDq3MpHZZYcOXAct5XAzhoeSryIS5pfpAI4zJux3ke03z+SMloQ+atThctcG7r90xKqUc8gJprrQEC4ZEZnD4w7Bv4R0mpDhpUNyFbrre8igYAkGwU0kH7uiUSjZqmeJAGEzTa/rrpBXebTcv3/meIZUD/FID3lT0Z7r8ddh37dkU283vDly+Y3ng6/Y6tyn+jTj4j3puWrH2+gjuRU8vqIi/bUmkrSawhrc5bL7XZ03Xs87auq0+5SZwRzSUGOGusxMaO2j/pPkBFM5U4EUdtd+T/xZVYwJYZDOyHzx9m1docU8Z8Wuy4fillSCuBnWvbRZ9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU99cIRekaiddL8ov/xQLohLeijzC8KSH5JZCMiupl4=;
 b=eGHmWrITrRnfXSKJ+2I6ToMsxANuaK2k92376KfCplVdJRbuzez5jFb3moWmPB59Rxh2fHeUCrbqE2hjsQaqfxYrx6uu0snlZpm4yWms6zVRIabTnqCKYMxMPrSRwbbPre9VM4daJgNpTXDKUO8U1YCSYtcsiDvqqR5DybN44HAZT+pd9Tjnj345kR/QgbjOTyJ8Xy2yjylSazNgn2ouhFHicerkxXRegF37R4ZA8z2NnATEdZ2qDWzkgh6Cx9OUMGQrAntFHN9TCjPQNeG6/jJs8rxG5XEliYgD3Q7qekapByvQyo7jstH0qrNTWn+9fyiTFRNzaJhD7UciVzABWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU99cIRekaiddL8ov/xQLohLeijzC8KSH5JZCMiupl4=;
 b=eqSxfvdPbZVoVHArQf2CsAze1n8U47Ea6CoeM9u0l4DRo9TI2315pricPnpT0XISzAaR3OQcrxEcObvdEzDTSn0QyHQqukggiRvudFUFiAMaEUwFFML1iyMX6CBcxxbl4b6Qw4hz7Eln/zEJHxlmnPwDeQm+jxPQ1C1miquu4zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Wed, 24 Sep
 2025 17:58:08 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9137.012; Wed, 24 Sep 2025
 17:58:08 +0000
Message-ID: <4dc92c3c-09d1-4dfd-be49-48075792e278@amd.com>
Date: Wed, 24 Sep 2025 13:58:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amd/display: Only enable common modes for eDP and
 LVDS
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <20250924161624.1975819-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250924161624.1975819-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: dc03ee9c-a6df-4849-9763-08ddfb93eafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmhmeUJzeUZwbWxNY0VtQzQ0TGtGMU5jUlA5SVZjTklOdEdjV3lkaWswY3NZ?=
 =?utf-8?B?MVd6YlZZem5Tc0xSSTlWTERYTFkySUVZQ3ZyaFA3dDJKd2N5VDZkT2Z3S0hS?=
 =?utf-8?B?ckpSSGZIOWIwUWhKTXJRLzdONnFNd0lZdTE2dUxpaTBjQ2h3ZGp2NVNVeHBh?=
 =?utf-8?B?YTNEaHAreGpyRXpsWnVNQW9ISnJ2M3VUTkM0Y1MvWlg2RzBDb0U1MmhORmhm?=
 =?utf-8?B?aGc1UzNFVjdXMVgrV202dE45VEl0OFFKRVhCTnV4ZHdMbW1MUzFYOCtjblp5?=
 =?utf-8?B?djJReEVKYk9FbWJBN3Q3b3NRT0ROeEJLNFA3Yy9JZmh6WVd6S3ZVbU9DYnF0?=
 =?utf-8?B?c0ExWHVZS0xBekJRSHVNMXN0V2swSXJDQlV0YjgyaTduRmlZWmROeTZlWHdu?=
 =?utf-8?B?amNLNWZEOFhvRno2MVUwbUpjak85NEV6WDQrMEJIeWJKY0tzcFdTdkJSV0w2?=
 =?utf-8?B?MEVyWU10R2N2TzlSZ3RvZHZPRzJPK01YNC81VVg3OGZDMEFqcCtVK3IrQkxa?=
 =?utf-8?B?SXloT2V1Tzk5S0pLZDV6UWZ0dzdVZHJNLzByV2RBSldEZjJKOVB1MFovSVQ5?=
 =?utf-8?B?L0ZWZTlFNUZWTDFLNHpDbE9kUWRubHdPQ0RzMFE3UjNxaTBVcUNrN1h0UW41?=
 =?utf-8?B?M2tCeFZhWlVzUFF6ZW4reUQ0SmRaU2dSdnJ6N3craVV3VXl1NG1JOFhGZlVX?=
 =?utf-8?B?cWtFZVUzNUdOcThmRmkzRUNSbzNIM3FlcjlWOGxITHhkMGhCZW1vK2phaWtx?=
 =?utf-8?B?Vk9WN1NKSkt6UWNGZlFKNVJBTk1hU3c2eHM2dTB1b2ZXb3JXV2JNSklYbWw3?=
 =?utf-8?B?bGlQbzJIYXFJaWZwd2VPQmlwV0I1bUJydERsdTlPelpyVFRlOC9QUm9pdVpW?=
 =?utf-8?B?aTdxVHdHcUhTY3JZYjE0SlFVZVliV3d1eWZXWnM0UFRzeDNMNG51OXNHb2U2?=
 =?utf-8?B?Snp6dmoyMzdGd1Z5MFlsdGIxdzBRLzEzeVlRZUJtZVd2VzFSUms1ajBxYWtw?=
 =?utf-8?B?YWVnTXlqTklsUjV2eER4R2NsMisxa1BGZG83ZTROUktDNkp5eDFERlpZRGgw?=
 =?utf-8?B?U0JFT1piU1pLbTMwdk9CWVJXaVVpeFB4WGNlR3VYNlArTklrRlU5SHFTSEhE?=
 =?utf-8?B?V2x1YVpPaTUzZkYraEhUNmJhaHYrMXh5RG5ST3JxZTZNdDgyKzY1QmtoNTVu?=
 =?utf-8?B?Q2xkT2VsOExleG16dE83Z0hnWitzMEdtZEprQ29uN0plWFFZUHlpeUlNL2RQ?=
 =?utf-8?B?WkhLRXpzNUNMaytLeGF5b1UybmprdlF5Qk9lemFEcEtyQ0VTV3FaM01VbG9X?=
 =?utf-8?B?R2MvREZMSmxwWHRCdm9yUU5rSXBreXhsNlZ1eFdwZGtQZTU0dTYxUEtlYUZW?=
 =?utf-8?B?cFAvNmpFeEVRUUpOVDFaWEJjYjY4aktCY2o5SDVDaWxsZHBnNGZ4V3RSSlA3?=
 =?utf-8?B?bnArU29QQ2NjanQrVWw4QXZEOWY5MkNFSEFhVVhGaXNwcWhuZjdzcUtjbzdk?=
 =?utf-8?B?SVhNUlRUd1ZEQ3o5elh4KzY4MHpPbnhzSUtteDEwVW13b1lSM3d1Q2drMUxX?=
 =?utf-8?B?b0JCVGVBbzUxT05laXVaMlUrQWlTQ3U5Q3l2VHE4R3RtNDJLdk1yaHZkMHVw?=
 =?utf-8?B?QWJGSi85Y2dqaXZsS05QWlBGaTl2bjYyK091c0tqMVBIajN1Y0lvTHNSRFM4?=
 =?utf-8?B?UnZoYkVsRHI1bzAyazZwZW9KZlpJVnhMZHFmRjlldEw0dEREMm5lYk9YY3BJ?=
 =?utf-8?B?UUpXRExxTHFuT1ZHc2hyU04wY1FTOU5qMGc5QUpVeXJmZkIwNGY3SlVhR1o0?=
 =?utf-8?B?UU0wbFEydk9Raml6ODdVeUdGTVdnVFdHbGVOOFdRdk84ZjVUOTcxQmtWbWFN?=
 =?utf-8?B?RU9ocythZDBhQUdXZXcvYUFTVzVpZGo4UHp3bUlUbE5MWFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhJS0hxeUM0ZDhySzN1djZOZWMxSUc3UXNzby9qSWUyTVl3MmFXZXg2N3Mv?=
 =?utf-8?B?b2ZRenFJQm0rK2hxUXBCcnF2MmZaVWg4dUkvOWR1bWZ6Wk1TTVVnYzI5RjZ0?=
 =?utf-8?B?ajNVL1pQL3dIZEVjOGcrTThZVTZxd25pU3VnMVNETUZxVlhNL2RFbWdsbUZ5?=
 =?utf-8?B?VEdnSkliMnZNeU42aDFUWDZwR2pmTG12VUNCT0N5bEdBdlkwTDJUb2V2cWY5?=
 =?utf-8?B?VkpFVlV4bklEbVpUY1dwL3VvYWFlSDAyYmNwV3Bob2xvb2RWRG1qZ0xKRjM5?=
 =?utf-8?B?MUc3dldMeThseUJ0OWZ3QUkyaUVvTHVicnRJS1RPaDVBdHNlSkZHbXE0ZjFW?=
 =?utf-8?B?OFhTOXZVUWI4OGgwWEVhYWJGVjc1Vk1hbGx1RktDcEFmSnBxcUl5NXdlY0dz?=
 =?utf-8?B?UDFDWHNhcmhDYjZ5UXZlck1YcEMxMHJjTXp0OExUcjB0cTl0STZ3TUsySSty?=
 =?utf-8?B?MDhmRHVjNWlCUmxkU1JRcTFLdE5XaXNkQm5QajkvNzVNNFVEK0V3MmxjUnBU?=
 =?utf-8?B?c1ZJaVBRaTlHekpScHVBN293cDcwMzVzVEFISmVjc21yTWFwaFMzbWlzbHYr?=
 =?utf-8?B?dnJ6elVmaGUycDdMVXdEMFA2MUhKeC9adDB4QlQvdVkwdG4xVGZuQXhydkJx?=
 =?utf-8?B?WHNGdlpsYUl5Yyt0a3FVWlAybnA3UzlVQU9TTTArY2xvcUplOU1Kdk51K09M?=
 =?utf-8?B?bWFSZkRiWTdjUTNlTDB6RWRadDRic3d5Wi9tYWJaSGRTZEZ3amovZU81Wk1l?=
 =?utf-8?B?RCtpc0pXQWpyS3pqM3lTZ2JvdUZ3RGthVnhUMVVKK0NkdU10VFAxckZLcHVT?=
 =?utf-8?B?UVZFY3d6N3NPcTV1SXk4MHNiZ2k0cEJ0NGxtN2tCb1JEVGwyWmcwRVdJSDdv?=
 =?utf-8?B?dXpLZzU3ajhuSjdWaFdPUWVOdDBHTEJYajREcktoTUc5aDlkZkZsVWRwT0xP?=
 =?utf-8?B?N1AxaWFsdWxQL1cvMFlRSjdzd21sQkJBZi85MXArVFI5QkJuQVRpK1J6ZHhq?=
 =?utf-8?B?eGlqQVBhYUMwTGhjWTM2UUV1M3c1ZG9tRjNLTWIvK1VYSURtU0J5Tzc0V1Qv?=
 =?utf-8?B?cUVtdHJSRldOVTdyV0RkcUZ5S0hEbkhDdDIwUnhMUmNHY3F2VjJMQm1hbEdU?=
 =?utf-8?B?ZHA3MXZJY3k0Rk4rWGlHUXpwdzVIdWUvdGUrQTZURHh6S200TjAxZjdBbTZk?=
 =?utf-8?B?b1hJNklQTW04SjQwaDVQWTRhU3NtRFp5eTZoUGdyVUZxeFhpMk1GZmw3MDFv?=
 =?utf-8?B?Z3RXbFlxN2NUUkMrdlYzaFBpVHc1d01OQWZpT3g4Z0FUZzIzaC9ON3dNN3Er?=
 =?utf-8?B?V2xEMC95NnBDb09zT2VRRG5Sbm1tMzRUV2F4NmdUOWNtTjlFVWpnSFRNQm5I?=
 =?utf-8?B?b01ucXJIK09JNmtuNW5ScU9EL1BrMGw4V2QveGcvNkRBUzEyblpMMGd5SHl0?=
 =?utf-8?B?cFY2WWZ1TkpaN3N5V1FaUXhRdk1FYUlBenVNdGx1VnF1ZTAvUncwcFduTEJq?=
 =?utf-8?B?TXh3MFozeUIyVHpIcTVxZlJSTHl4TWp2UEg1bkhHdXVYWWNWODZSMFlmcExv?=
 =?utf-8?B?Y0tmMHppcStJMGtXNEpmeklXM1l3SHM1T0ZWR3BpWmRsczBTcThxSDE1RzFW?=
 =?utf-8?B?QndpUEMxWmpLa0xRbmgzNDRpUU9BV3J3Q1VIN0dBMlFXemFQWEFaNEd2NmYw?=
 =?utf-8?B?SXhCVWszQnAySW0ybGwyVkY5ckU0ajIrSXRWdWdNM284d3d2NTErQXhieFU3?=
 =?utf-8?B?OUtXR3pSRWtQYVFCWGFCV1ZGNkxhMUtUZ2wyU1N2RnE3RjI5RmVjVkZLRHdy?=
 =?utf-8?B?OGw2N1lSOVRWc0kwdnFsNHBFeERwOHJiYmZiSlpndEJGZVd2dTUyRHBOYTJo?=
 =?utf-8?B?RFVlU05jMEpSY0V0TnpYWXdDdGFncUx4cDVSQ2xyWHk4VlZXQmZKZXlCWjVm?=
 =?utf-8?B?ODhYV25valp4QnZvMXo5b3B1MjA1ZElydXFjd0t0SE9JbGhaUkVIQVQ0NzlF?=
 =?utf-8?B?d1FSUks4UWVRS1NXaTA3RllPSjZuZXg4SFRtZkR0aFFtZXBiSjJ0WmcvOXVZ?=
 =?utf-8?B?NFY3OEpUcFJPcVIzdytZTmhsMnBZKzJma0RCUlVCaGNHVHF4UXZ0dUNOeXNk?=
 =?utf-8?Q?asFzlnM8RX4uxueASxAdwXM5u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc03ee9c-a6df-4849-9763-08ddfb93eafb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:58:08.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+p8UmMa+L5Qj1tIBdSiH3KSka5blBaIF/+8TTWg9M53v7VN2/cXVxkclXosE3ORbbj2JSAZobzm7h2CpXbcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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



On 2025-09-24 12:16, Mario Limonciello wrote:
> [Why]
> The main reason common modes are added is for compatibility with
> clone mode when a laptop is connected to a projector or external
> monitor.  Since commit 978fa2f6d0b12 ("drm/amd/display: Use scaling
> for non-native resolutions on eDP") when non-native modes are picked
> for eDP the GPU scalar will be used.  This is because it is inconsistent
> whether eDP panels have the capability to actually drive non-native
> resolutions. With panels connected to other connectors this limitation
> generally doesn't exist as we the EDID will advertise support for a
> number of resolutions and monitors will use built in scaling hardware.
> 
> Comparing DC and non-DC code paths the non-DC code path only adds
> common modes for LVDS and eDP whereas the DC codepath does it for
> all connector types.
> 
> In the past there was an experiment done to disable common mode adding
> for eDP and LVDS from commit 6d396e7ac1ce3 ("drm/amd/display: Disable
> common modes for LVDS") and commit 7948afb46af92 ("drm/amd/display:
> Disable common modes for eDP") but this was reverted in
> commit a8b79b09185de ("drm/amd: Re-enable common modes for eDP and
> LVDS") because it caused problems with Xorg.
> 
> [How]
> Only add common modes for eDP and LVDS for DC, matching the behavior
> of non-DC.
> 
> Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 97d9eba17963..5a05ee6746af 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8151,6 +8151,10 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
>  		{"1920x1200", 1920, 1200}
>  	};
>  
> +	if ((connector->connector_type != DRM_MODE_CONNECTOR_eDP) &&
> +	    (connector->connector_type != DRM_MODE_CONNECTOR_LVDS))
> +		return;
> +
>  	n = ARRAY_SIZE(common_modes);
>  
>  	for (i = 0; i < n; i++) {

