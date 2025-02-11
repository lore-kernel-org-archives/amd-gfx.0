Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27059C0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 08:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B0210E43C;
	Tue, 11 Feb 2025 08:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQBfyIWF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CCA10E438
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+5uvjcNGvkW23Oshhax3CDgNIEff4gJNpDRNYvHKrnMduHlaqcKrOyZZSBMHmp5orTgv+Sea0uJ7b6VU2rtbyNceq5dUuni0JbgbV1/XR2B5XvPUTn4uzzkO0CnhsqpfuNzlfmbsG9XmUb6M7k6dxy77EUsGOeDFBXhLcuXUWh6ZGMBT06KOoVtuXkpL91uoHHeLX+lUHfhGQhzbyi1rJndQQsklOl6GVnMHYPAb+CBHakRJMAum9utP2MkBrkKlmtB+0V8n9iRKOG5HH3kaIWaD9FHpptZ6cV/bU4uvs0Tzhl7aV3mSFcHnF6TAeujwCrzxvKjBo6Wu3ShuMpgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ6CjB4ixjQLBbrDiGTjWKo9zMzfsqjMM08Umc+GAbo=;
 b=IO/z92oVbWDaKNEqLeaJmiFD6OiOLmd/tpbt0o/hC3FPrWLbPJ/M/lL54zvnmlkHiPVmYiiVPZlZdqbqX1t2reCN2TvbyNUc52DCzR5XMW1VnvKKFA8/bDATsAbeCvdoMyZdvTpGXgPO2P1362ENzSrH53Mvpe2TC5SXJeQ0+913P29cUcEClPhSzUoG58zm/4BLJnD28xvviY1r267jY7JWxJpKc/P698PcoHt7CwAQP6oH2Gj3zdw/TF8SyXvxgMR4dcgfs7daK0GGo+tffckw21uawimKIu09GtHUB9Yihgy1u0OkqDfTmn2wKV7OFH+FLrNLNHTtvzerEE+XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ6CjB4ixjQLBbrDiGTjWKo9zMzfsqjMM08Umc+GAbo=;
 b=hQBfyIWFEtbaRsWGAcmKDTA8yQONtUzI8Vzcd1GmggRRMCh2UO/VLH1Zfve1hD4GeBOLDb90GPDpzWEEQI4MZaIRh2KKmqwWe+YL8p0ZXc2f6WQYqU1Meg6t71wYT9RH9mahsyOz0WUa00v43tUDPbGMuEdQY1im90fBgUD4crc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:03:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:03:51 +0000
Message-ID: <8b5da169-f2a4-4b30-9e50-84960bc7d100@amd.com>
Date: Tue, 11 Feb 2025 09:03:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 lin cao <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250210211904.281317-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250210211904.281317-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e10a0ca-9b06-46fd-4f77-08dd4a729f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2JZTUNla2FBbEpTY1RpRHFqVnJrMWhjUGxhb3VkU3FYdzJKUjBWZEgvYThI?=
 =?utf-8?B?TWNQekI5UHVZY21IRUh4NHBEVTM4eUhGMzl1Uk1FZXljNGh2WTBzNE9obWw3?=
 =?utf-8?B?VktTZU1UQ21FZndiOHBRTldIVVpyL1BrUTVZcFNpcXJraEJQRitPZ3hFYUt1?=
 =?utf-8?B?aCt1MC9DOTk1eUF2aC8rQnJOSzBvTjNNczN6T1gvSzFZa2M4V1hGd3RsdVll?=
 =?utf-8?B?ZFhDVk9KWU16VlNJSnZ3VUphSlJQelUrL3VsMjJxa3dhL0JnY3l2bGVsUDNJ?=
 =?utf-8?B?MWhFdllGSVR6TWNWRlhsaExMWlFhcklka2NiVnVNSjdsNlFMUlBqREhOUkln?=
 =?utf-8?B?bmlBSWhvRVJGRmdrckJWcklFMEJMWVh6bC90OWw4b0U1a0pPWGRjMHZycFBj?=
 =?utf-8?B?Z2JzcytUeGVQUmpsUmJMK0VHdzJZaTRnL0VoUGNpR3NFRG1RRTZnRlJxdG44?=
 =?utf-8?B?OExoSlFBQmxzZVkrMk5sREhHSDdSaUNNRVRkWGM2cmRwZ3dXb3NGVUFWTDFx?=
 =?utf-8?B?cGVXTXRocTU0NmtaVXhJWUlHaTMyOW5jeElsRUp6Y2JjT2xMdnkxQ1VTVzFS?=
 =?utf-8?B?a284UjZpdTE5YWtSb3JsZkc1ZU04Z1I0dFY5SUlaUUJielg5MTR6ZzFZUWE1?=
 =?utf-8?B?cktVWWpsNUFaeXl1NWVESFV6K0JNRGxPQlp0bGVJVUVlWE1NSytQZHBKY0Nk?=
 =?utf-8?B?cDBwaVNQU2REM0JXQXRuUjNVdDNHZkI3YlltblZvd1pSYlJhTEJuRHJLTmVB?=
 =?utf-8?B?ZTV6cDBEd1NhdjhBcTFrZndRTTFrYStwT1BYLzhRc3A2a0ZnR0lJd2NEQll3?=
 =?utf-8?B?THU0UDNkcXVVd2x6MW14Skw3TEZzSFpTMGppQVcrYkZ3c2hBYmdQeHBMNWRV?=
 =?utf-8?B?cUNnV3lIVEFuWm9sc0FSSnJoOTE3dzJjM3psS3hRYUYzNkVRR3JYdzBvNlYz?=
 =?utf-8?B?WnpKYnFqOHE2RmgwdnVXZzYvTWpNcitBWjFHcDZ3eEVYSE1GSFNsNnlLNWJs?=
 =?utf-8?B?clUwekZDMEgyTVVpeUlwbEo4aUh4TlhvRCt4ajBLbElLdDRyc1hXbVB2NTdC?=
 =?utf-8?B?Q091Z2dDZXRGaGhUNkV4dlJGZUcva2FJcTdhdHpNQWpZOEo3elZKT29kYXdE?=
 =?utf-8?B?b21yRURzc0RNclZzYlVESWJCTnVNRmlacEhhZEliUEFuNmwrZHNSektidHBu?=
 =?utf-8?B?SVIvZVhWak1JemlYNUp3YWV5V0ZhOUJqM1NRTzNRNHAzUHJaalJzRFhJY0cy?=
 =?utf-8?B?NCtBU054cHJ0L1k1N0p0MVJTWjhlbVJObitsMWpBVU9FbHBWYXk3YVBDUDN4?=
 =?utf-8?B?WVU1SWpLR1B4TEd3QXhUd2dzczQ2VFpMc0FOaDFuWXQ2dDFOL051dXhlUDNR?=
 =?utf-8?B?Y1Y3RnRaUzdnQW8rOWsrOUNRVzV3dXVnYlRsRFpwU2QvQWhTMnI2R2VIaGRq?=
 =?utf-8?B?WjlTNEsrUkRMYjQyWmN3SHJvZkd3eWJMK0E1MGE2NHAvclowZVNhY0JXUytB?=
 =?utf-8?B?T0dTNHhPZU1meG5rTHI0QUp2TUhVREl4UUhzNTlwK3RtV1hEcUlxdU1JNnhM?=
 =?utf-8?B?Z1hnbjlMODhoNzNtc29FNFg4bUJVKzh1cWlkK0syeFoxWWtMTGtCVk01YUlG?=
 =?utf-8?B?UE1va2tZMGdsUENiWUpPZFJxRGRhQ1MzdkxaNVhrZmRZc1JXd3RpMnpKZzVk?=
 =?utf-8?B?WXdkQVB5TDJ4bHkrNkRjeGp2eWIxNTU4M0grOXlLL0s2WEMzL1ptNEVnVEd1?=
 =?utf-8?B?MXIvdFk4bkxtRjZpMG5RL2R2S21RV2hJRFB2SFh5bTU0UDhMQjY1Y2g0aXVr?=
 =?utf-8?B?UnUvcnlQRzE2QlVYaVk5SW0zUkw0V0kvNGdyakllL250SG14Tnlkb0JUL0h4?=
 =?utf-8?Q?VJ4l0xKs9ztFx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnRVYTRIYTY2c2dpY0I5MmYrUG5DS00vdHVoNnpoMXZqdUhnUSswQzBCc3Uw?=
 =?utf-8?B?NFg0Q0JTVU5LYjkzOE5HN0dPbmZTa3cxNmE4V1hOdFhDZ3U4ZEhJci9tcVN4?=
 =?utf-8?B?OFFZaU5MZFhuY3YvaW4vQVJRMUJBK3pvR1lObVZTbU04Y0Y1YzM0V1QwK1RP?=
 =?utf-8?B?cGNaeXp6VENIYm5uWmU2SHFTb1JLc1RHd2FtUW4zbzRTVkN3ZFhVRkQwdU5O?=
 =?utf-8?B?UTRyQnVha2t5d3FMMzV4c0JJMm1LUXZRUHV3dEZkNnBZSDZBbzgzaTNiczY5?=
 =?utf-8?B?YUVQRFZkalIxTVRRSzNMdDNMQVhnYmhhZFJ6NVIwQmJJeWhXL3pUaGFUalZn?=
 =?utf-8?B?MWcxRHk4NnZ3emluYm1RbXlmYzc5NzIxbExtYlRidVJzeFVSbmFDSFZlaXBQ?=
 =?utf-8?B?UWdEU3JoNk9QNWRkUTBCMHE4NDh2L2w2VGpMaXFubXNVUEpkVmMrZ0Nrd09R?=
 =?utf-8?B?cmFkc2RjRlFBeEgvays1c2VRV3grRk4vZTNkWFZvMDBWcnk2cFZ0cUhMekxI?=
 =?utf-8?B?TUFlbjFLSUxLRHd5WkY4bTRIRDFRVlRDU09RcWpQTkJ3d1JvWXUvc3I2SE9u?=
 =?utf-8?B?K3RJZXR4S05XcWR6clllOVNQQW1IaVN0cVBrL2dMZC9Rb0pJVVduK0ZFQ3RY?=
 =?utf-8?B?UzRZSzVvcWZwczU0RGpaN0o4WDVlZ2szbExYK09kUndKay9BTExBSFVIcThM?=
 =?utf-8?B?cW93MkN6aHJlUTRKTW5vQXJuTXJVL3NjK1puQy9UVThoeWRReUhoWEI5NE9L?=
 =?utf-8?B?WWlNV1dQRlZjUk5yYS9MdUJnSDB4QkNrdEI0YVMrdXQ1V3hvaDNwenNrV0tV?=
 =?utf-8?B?U2VRK0VxMXhyZjBKb295L2R1NUc1cGU2WmcyaUYvVXdzeHk1NTlzRTBoc0pj?=
 =?utf-8?B?S1krUjZmWWFpUmVDRjJmSmJkQW5BWVFtSElNVUp5elNNa0N1aXhIbFR1dlJS?=
 =?utf-8?B?TDRXUU1lcHRoRnFUeFJGNit0OSt2TUVTcHlLYWExNTFoL08zanBDV2laVnhR?=
 =?utf-8?B?UkVISUp5OEl1dWErT2xzenZvTUNabjlUVXF0cEFlQjV1Sm5NMTRCZ0xuUVlU?=
 =?utf-8?B?WEp3c0MwdXRSYnNlRXJUS0ZQN0tNWFpKeHhmWFlNNmIzV2JhMlB4RkoyRi9N?=
 =?utf-8?B?NVE2SXhrSmJLTUR0VEYxUjJ3aTVtbjFmT09ySmZjWm1UR0JNeldrOVJUZ1Zu?=
 =?utf-8?B?R2VvS2lhU1FjbUYzTjNrVlFFQzdCMWw3eGdFbkFyc2NQdWR2UjZUUHQ2ektE?=
 =?utf-8?B?bEt0L0diK240bUZuc0tNQStxM2JPRGk3NFVzNFdST1FGOGZhTndHMzJ5NHBO?=
 =?utf-8?B?ai9la3hpMmN0T2s5QWQzcE5kR2IwUmZLaVkwZk9VcFFYbFg1NHYzL2lVQkZq?=
 =?utf-8?B?bHk3VHF3RlQ4MFJ6b3V1aGkxUlc5T2w0WlhUTzVWK1JGYVZLQnIvSDNmcm9l?=
 =?utf-8?B?WXpiaGFTajlQUFBvdkpiRWdiR3JzWjdSb0gxR2NteEZ0MXQ2NkJzbU1qZmpP?=
 =?utf-8?B?b2ZPN1MxTmNuWG9ZUkdqZ1dpYktoMkVIZStJajV0NVpUT2RIcytJY0lseDhP?=
 =?utf-8?B?ZnlEc3Y2RGxqOWYvRzhaTWwwR1UrV01jNmRSVFRYSUlFeEZiTXNJY0h3anV1?=
 =?utf-8?B?Vm9IbjZraTN6bWppRDhvRU1HTnFjRGtXYTJ6b0IrZVVMUVNNQThmWmM5UHYr?=
 =?utf-8?B?dWhIbGlBMitGZUpvaHhESkRKcFZTcStlZTF4bTN6d2RaNjgwZ1N6OTB2Q1A5?=
 =?utf-8?B?NFUwUEQrajNpRlJqbGVhS0ZZR3ppd3pWOXVyVE5yUk9HcTNERGRYT0UyY0hs?=
 =?utf-8?B?bXkxV3FIeTN1SDdYdWxIdVVmY0hRZnpuV0NrRFU5UjR0WGRoeU1iMkZ6LzFm?=
 =?utf-8?B?VmlSU2N1Zlc0T3ZOQUU3ZUlUSnc1LzQwRUxuVEhOYzBBZ0huTnZybVUraU1F?=
 =?utf-8?B?ZjNVTXhqamZISlhiUW1OdlpUUDlIbmY2MHNoZXAwYk9kb2ZvZ0pxdXVLcDlr?=
 =?utf-8?B?T1ZvM3JYa0xoQy9SQTZqUzlyRm1vRU4wSXUrekgzTS9aZTZ2QlI2ck1UTkZU?=
 =?utf-8?B?bTlkNTVUbmZTKzlXbXpYR205VnNHODVIZWZRUVBtU1llbjJCZ1ovdkFuc3Ux?=
 =?utf-8?Q?pwT1y7181VCNWghFv9OVQJtxW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e10a0ca-9b06-46fd-4f77-08dd4a729f0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:03:51.4204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gg7lva/47SfU6Uue6PSeEpQq1jlQD/YqdsDeW8zx68NmsoAzCO2tNXs0GKrCEaE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

Am 10.02.25 um 22:19 schrieb Alex Deucher:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> This commit introduces enhancements to the handling of the cleaner
> shader fence in the AMDGPU MES driver:
>
> - The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
>    KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
>    that requests are handled in a controlled manner and avoiding the
>    race conditions.
> - The CP (Compute Processor) firmware has been updated to use a private
>    bus for accessing specific registers, avoiding unnecessary operations
>    that could lead to issues in VF (Virtual Function) mode.
> - The cleaner shader fence memory address is now set correctly in the
>    `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
>    the cleaner shader execution.
>
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e862a3febe2b2..26af0af718b5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -743,7 +743,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   
>   static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   {
> -	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
> +	unsigned int hw_rsrc_size = 128 * AMDGPU_GPU_PAGE_SIZE;
> +	/* add a page for the cleaner shader fence */
> +	unsigned int alloc_size = hw_rsrc_size + AMDGPU_GPU_PAGE_SIZE;
>   	int ret = 0;
>   	struct amdgpu_device *adev = mes->adev;
>   	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
> @@ -754,7 +756,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>   	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
>   
> -	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +	ret = amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
>   				AMDGPU_GEM_DOMAIN_VRAM,
>   				&mes->resource_1,
>   				&mes->resource_1_gpu_addr,
> @@ -765,7 +767,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   	}
>   
>   	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
> -	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
> +	mes_set_hw_res_pkt.mes_info_ctx_size = hw_rsrc_size;
> +	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
> +		mes->resource_1_gpu_addr + hw_rsrc_size;
> +
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> @@ -1632,7 +1637,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		goto failure;
>   
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +	if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +	    adev->gfx.enable_cleaner_shader) {
>   		r = mes_v11_0_set_hw_resources_1(&adev->mes);
>   		if (r) {
>   			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> @@ -1665,10 +1671,13 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +
> +	if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +	    adev->gfx.enable_cleaner_shader) {
>   		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> -					&adev->mes.resource_1_addr);
> +				      &adev->mes.resource_1_addr);
>   	}
> +
>   	return 0;
>   }
>   

