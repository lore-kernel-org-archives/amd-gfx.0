Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49946D25B47
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9834D10E6A3;
	Wed, 28 Jan 2026 11:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/BA++h+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B4410E6A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 11:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcRaSsizWK0l87y/Mo+L/UYfBtanmd4gQQhaLbW70qnmfobAsMOlS4jrLjR9HjRU13/6NwlKzXnDT/NV4Qnk53dELbNaZ7SIQUu13IgvcYX4VegmNqcq2QEyXF1Pmt9rpg92QBqC68IEIIe7JeDp0QaAEeQrfvyhiS/CL/pBuCRdvoAEIhy6BsERxdSQq6XCCB1vule+tejkvAWoqQ6UVLNo2uCVLzlEPI7o9KnFFrLcaLT7MBgHYbibanIVPpNiWr0FDjXGuIoYk0lE501d49btDhf9CzLa/01ucYvtEcoeC6kt6ahaCfHe83HqpWtLN5PPMtXJ4XrUiXwRE7OcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GimzfAhkNoHtYrQw7tcirpCSeLBKfWI9cbzZy3SwQNY=;
 b=VxTWzyGAcuXyVNZyREOSZnOy6lHvGzTOJgXKdY/ZP1ys/RkssVmAP3gWWz5mfUlz03hGL1dlOlB7CZRQmEFmezGIivJq26rcw2uP49hNPoSuaxNyphz6Om9evmxnEvRq5nOgEE3vsklB8Bw8JxVEbLTPAOmWQJVY/c6GHqxVlbjXiwT50q/G16De2tyvOXN05c+/tteMvNSUjQgoPnhLOY7TmR3/FewO2fjEMnMjFDRtlbuYYkP3OumuO9qTmZyOhQmC7N0hoiFNeT5ZcFFag+LB93BWR3/kwmkWDPcOJEJmk8TujEXnn+++DOcBxvX/BDA2WxdO7S2Q7Y9IGxudqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GimzfAhkNoHtYrQw7tcirpCSeLBKfWI9cbzZy3SwQNY=;
 b=2/BA++h+jFZw//3BP60cgInS8OHDBW4MbMMHr4En4LGj9G7HxA8CFOFofrHIbuA59hn7Vkyse0h/8sfi1BPHWAiQxisn+qr6T1X85zPOsdoaSSR7Jm2ipX5sDVx5SBStmXwBQLG3+h8OGh+ka/oe1wIR0ne/gkmTMpu4sMeI6O0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:59:48 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 11:59:48 +0000
Message-ID: <bcf37fff-290c-4b17-9207-8a71ae9e5fa3@amd.com>
Date: Wed, 28 Jan 2026 11:59:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/amdgpu: Add ioctl support for cwsr params
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com,
 "Yat Sin, David" <David.YatSin@amd.com>, "Kim, Jonathan"
 <jonathan.kim@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-10-lijo.lazar@amd.com>
 <CADnq5_M6Mi5SJi_AYKhdmwacxumeTUrRHMrKazQxEM4v=utS7w@mail.gmail.com>
 <283b02db-3038-4e6c-b577-a9fa02741b1b@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <283b02db-3038-4e6c-b577-a9fa02741b1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 67339d65-ebbd-400a-9bcd-08de5e64bc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXhIRnliaHpBK3B0MUZ4Mk1sWGltRitDK0FTQ2VlQkhYektod1FkRy9YVWUy?=
 =?utf-8?B?NDhLdGNpTWxRZXRWU04rbVM4SVRqNzZkMHBNelJDb05hVVY4Ny9MZ2JKL0hE?=
 =?utf-8?B?aWlBRG5pM0J3VkJhTmN2UksyeWxkVjVLU2Z0bytONjhLNXBNWlhNa2p2Qmlj?=
 =?utf-8?B?VWdmMC9BVEhmNW55VkplMDRzL093UmYyMExqblgvWXhMblFHTjQxcmhqUzAr?=
 =?utf-8?B?YWxsaldFeUpWQmhDditYUEdybEt1SGsyUVRDSytvYU1SNnNlSzRxbGNyMnlG?=
 =?utf-8?B?QlROdit1TGNFYWVBNDNkMXB6Qi9tenlMR1NDbVJaRncyakJGNmVyWUFlZ042?=
 =?utf-8?B?b3FpajhGcHVaOWZ1ZXdlZWdoOEE0bktSUHB2dk9TZ01zRmRFM3hKRTVoaE5Q?=
 =?utf-8?B?T2I4YU9waG8wMXN5V2Zpa3RudkJsdk9HY21vM3JHZStoQWRaTTk4N0xLb0Qx?=
 =?utf-8?B?WlNXa0FEbytmNS9Pc3NOMjk5QnpZR29aNTZvREIyNEhGejhzc3lXWXROcUpn?=
 =?utf-8?B?dGgxSVdhaDdkM0czSnduS1puL2lsdVFwMm1XZXJtcE1CWkZ1T3pGTVY4R2ZT?=
 =?utf-8?B?MVRpTk9LOElPZFpvVG5WclF2RU5hYi9jUEhMSGl1Nk9pemJXemlZaDE2NTE5?=
 =?utf-8?B?R2JlVk8xT3BFTEZseVBSV3R0Q2FUU1I4WmcvNWoxSVB0OTZBNlZ2S1JjVjNU?=
 =?utf-8?B?Y3k4TWhMb1hzMjJCS3o4U0RnOTdaZWx0cjJHaXpNSjZoMUFDY2dRTjN0eU5W?=
 =?utf-8?B?NzQrZitQWkNCS1paWXdCa09lQUJhaWZsWEx2NXVBYmw5K1RPVWpXTXBHWGE3?=
 =?utf-8?B?RkwxRjhqKzZ6ZTJOMVI4ZmJGZVdVd1hueDhqODFSN3ZrYVJ4dmU3WlZaNWRK?=
 =?utf-8?B?NUp3cnl1Rjh4NGtuUXFxeHhuOFBVVGsrRmc4KzJzUmxINGFmbGdjTWwzMTlQ?=
 =?utf-8?B?U0VVTHJac2FOUm04K1hvVkp4d1E4NEwzUWtFQnhjcXNrWkN1c1FEOHdaTCtW?=
 =?utf-8?B?M1U5c2MvNnFvbGI1NGpVcmpLM0xoVStld1pDU1dyaEhBT3IreFhoRXU0Q3Vq?=
 =?utf-8?B?NVoxaG5mWG5ITW03a1dyQlBLbkt5Vk1mYzN0RnJ3MGVMYU5zcnAxZmx0RzM0?=
 =?utf-8?B?U2J5TnpoaWkvMkpPbWRHR21zWDRBbGNZeDVINTA0bGRVUnduQVRKMnRYUTB3?=
 =?utf-8?B?Y25DVUFTczdkazBUeXZueTlzNDBGWElLNnJFV0NIQnJPQkNlZzgrRHdDSkdh?=
 =?utf-8?B?M0ZoVHd6cmVVNTVsaFdLOXgwbDl0K2duVVdNTjVuV2ljYTR2RVU2bTJTN1RE?=
 =?utf-8?B?S1BoWGYrekxyZG9oaEZUeGs5cWVqbjVkS1pjYjlzZytoMkxtOWNKcnMybEE4?=
 =?utf-8?B?VEhiMjlzWnBNZnVtRVRUL2tIMXcrcXRUL1FkQ1pQRHV2WlcxYXVmM0tLRUp3?=
 =?utf-8?B?cVNyL1prWnZOMXlmQTh5ay84a1haYVk2NEJhNkJkVVh3VTNKKzJEcGExQ1I0?=
 =?utf-8?B?WjhkWHJDdjdPVlRJdTdhWU1TVENhbVk5a3BmaCtJY1pPb0pjdHJva1psVTlB?=
 =?utf-8?B?YVMwaTRDa2ZJTlIzdTNPSFgwZ1NPcGxHYUVNMkRPVGRZc1F1YUlIMTVHM3FG?=
 =?utf-8?B?Z0tHNmQvdWszRmhYU1lwU0EvWjR5bGcvSDdreHI0ZlhNM29tSGhsVStXbEF0?=
 =?utf-8?B?YmVuR0RPQXNzMFg5N1hhSUx6US9HWGh0RUJjQjhRVzBlZzNTMnZmYTdjbnc5?=
 =?utf-8?B?MkhTOENpRVIvajgzcXdIRmJmUG5YU3dOc0dPazlGbHFFeWFLS0JYYlY0WmRW?=
 =?utf-8?B?ZUxvVElyZnNZVys2VGhZV2RPdlhLTlBmYjVucEVWclJROXZKQUx4MncxdXd5?=
 =?utf-8?B?VXpXRTNqZi95TGQ5QXV3aVpkTkFXQ3pFMFZGbTE5MFJIMGlwU2xXUk9GMzdZ?=
 =?utf-8?B?RS85dEg5ZFBGMWxlbWtUM3pOTkdoRURiVXo5YU9wQzl3ZzFMdkQxMlZvWnh6?=
 =?utf-8?B?b2hiWW95MGViamlzR21LaXljUktzUW92MGZENmFFbXMrNHltWGNObEJ1ZWtq?=
 =?utf-8?B?c05PN2RLRHlLU05kYkVROHdNSXVJQldIYnZ6d0pPOVBtNjdZMjhDaG5tVW5K?=
 =?utf-8?Q?CwEw+2GVJSFWJo3jQJO52/p/3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVxNzJzVFJDRWp6eW40NGU4aW43UW5VbUxNdUhBSVV1K3BOaXFpd01pTVk4?=
 =?utf-8?B?WXczZXRKbHIxdXBhQi9neGxxZmkyZWhteCt1SXNlemZ4MGhWMEtBREVZNldj?=
 =?utf-8?B?d1pjY1djM0hISHZ4M25CRnRmc1QrOGZTNi9URG1vM1lLNit2eXFxTU1oVUFD?=
 =?utf-8?B?Zm5kTmFXL25kcXI4SXNscnhoaGtqa2UxbHZJdGwybFgxdVBlb0ZEemRqQkJk?=
 =?utf-8?B?bm4rN3YxT0NLcFhSeTdFZTY4RXJidE42SkZzL09IdmxBdXVBdVBoNjA3bnQ3?=
 =?utf-8?B?dDhnT1BWT2F0ZnBMQTBBcmc3RUk1SnJ5ZHA4QnFzRE9jaTVEODQzVjFtUTJH?=
 =?utf-8?B?U0MyT0FPU0RycGh5dVREblc5V0t6T0FHejNubGozb211N1hYSExRdEVOZXFq?=
 =?utf-8?B?alRrcFRldUNHZ2JlV1VLRHJadGFDc2srSGNWamZQMC9NMkNoZWFVMXE3SHZ4?=
 =?utf-8?B?YzNhOVh2em1XSmtuRkYxekN2S1hHSzFLN09iMVNpY3lZQlJWMWt2N2krYkJ6?=
 =?utf-8?B?SmVDS1JaMkdsY0w2UjBMbEp4ZUwwN0ZDMVc2WmU4UGdlZ0gxejIzSlFBZUYw?=
 =?utf-8?B?TGF2VEZiTEdGWkFEVnFNRHZhazNTSXdlMWhQb3Y2WXdOcXFQMkZLdGJ3UWZw?=
 =?utf-8?B?WHp1elRaTDJZL29jaW81WDh3eWpqNVBWZ0piVzQwK1pNZkR0ZkJEbER4bnBq?=
 =?utf-8?B?QTliYmdjcnlBV2ZrQmNyb2V6WVJFL2VXd3BIaGNyRnBJUEFGdGNBdmd1Qmhw?=
 =?utf-8?B?QWNNOVZjZmllMml2dFByS1NFNC9yK3FmMUtScXZiaitId25odlpYdHJ6Rjgr?=
 =?utf-8?B?alVnTXBtRnl1TkliUzd2NG8yZXdCYkxOdnhYQ2pHUlVlQkxJWkMwWUJacWpR?=
 =?utf-8?B?eFdFNll0YlUwSXJpTzJhVkRJNysrK0o1Qm1yVjJvS2xNT3dOMGRvdURJaC9T?=
 =?utf-8?B?ekhqR0FuYkloMGhVdktRV1lKNDRKVlIyTkhjaTFaUGVaM0MrVy9sUHV0VUNR?=
 =?utf-8?B?SXRFQXAvVU5Ic1ByMTNIalVHVjhNRzRia1JuZUExOFE4OWtubzNTeXQ3M3Zl?=
 =?utf-8?B?TFh0SGJLT2NQNFVlVTg5enlBeWp2UHd2aUNjaE1LU2FnTHNWSldoQmJabndS?=
 =?utf-8?B?dWJkUnhhUlRvcUlQaVBGb25zR1Y1ZVJhSG9MbDgySlVXVjZ5aTBQbGFJN2hm?=
 =?utf-8?B?T2FabWJNYmpiNjN6TFFob2wzTU1ZQXkzQUg1NUlJNGZlVlpOWmg3NkRqbCtV?=
 =?utf-8?B?S2Uzc1B6ZmY5SUl2bVp3YzRNaXN0QjZ0ekZEZzdESjU2LzV5RjVuOFQvTnI0?=
 =?utf-8?B?WjZBa29IUWdJTmdZQkhrWTc0SHVoeHY3Zi96UlNad09ZOFVqSWEranhpcUxL?=
 =?utf-8?B?Rk5SUE1oOUNhL1NPUnY4U2JwWS96bE9OYjdnbTdxQUNmM0tDamhEaXppWHdL?=
 =?utf-8?B?VDI0SVJvanR3MXRiT21qSHBtdURmbE42U2hQTnowK0Y1KzhBWktyY01hY2F2?=
 =?utf-8?B?VnUxbWVkbHFGdXNGbWh6TlZjYVpxSGx3dTIxdjI0azRqa1pRYW8zZkJhZEQz?=
 =?utf-8?B?MS95QUd0YUxvMXZGbkZRRDV6NUVIbGorTFJacGlUNTRtVy9JLzQ5UW1wTjFv?=
 =?utf-8?B?NGpaRS9pdk5QQkVPUStqQ1F4b05aTXVyK1ZxMU5iNUJPeWozTTNKK2pHSlRI?=
 =?utf-8?B?Ty9Jcit3aDNJOVp2ckRCdmNRZVZabGFId3RVQTlqUmg2cjh3amVhSFkzYXF6?=
 =?utf-8?B?YUVMVDlXaktJdnI1ak1pc3ZZT2xVeDJQck1yRjY2cDZyR0JKNDN4allPcW52?=
 =?utf-8?B?VkllTU5nVFNRTTFOaFBBa3RVQ0NoSXF4S0YzSWxoNjh4NjhJYzQwdnlzazJG?=
 =?utf-8?B?QWJrdmpQNDZGY2cwcFhZcXlpR3RuNjFXNHI1Mzg3ZDZLLzZpRXpwZVFUYUln?=
 =?utf-8?B?OHh5RGlDNFBWYTM0a3BoMkRZQVpHR0JPNmplTjR3dm1tS1FLclZRSmw2S3Z2?=
 =?utf-8?B?NjEzczV6ampYMUFHRkhNMzhvOGVwbW92VHJhMmNPWXNla25OSVVPaTdXOGZW?=
 =?utf-8?B?TkZvb3hpMkRCTW1NcmYxdUM1aUFVTjR1MVJENUF2ZmNjUWo1cVFNMEVNMHpv?=
 =?utf-8?B?MVpUWjRGblc0T2VIaEY4ZlJFV1A4UUVlbzJ5d2lBRkhaVUVLZjJ2NEtubFMx?=
 =?utf-8?B?VXZPYllaUkdxSEVJTWp5QTRJUDliRHJtcHhCU2doTHdHQ0ZrMXYwZEwzR3Jo?=
 =?utf-8?B?cEVibjR4RHR5N0RKOXlIVExrQXdra1cxT3lhSVpvdllEb1UzbjN1U0tML2o3?=
 =?utf-8?Q?LBVrnaAmlN6le5roR0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67339d65-ebbd-400a-9bcd-08de5e64bc33
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:59:48.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEmtIqFqt8t4LR8XLvlAxeixZ56AlPCpbH4gUWhLPbJ9lc+JdEhg4bAzAGiOj0LTAy7TDOK5SjBxPvzWj6zQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
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



On 27/01/2026 05:44, Lazar, Lijo wrote:
> 
> 
> On 24-Jan-26 2:21 AM, Alex Deucher wrote:
>> On Thu, Jan 22, 2026 at 5:52 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>>
>>> Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
>>> address for save/restore buffer, and size allocated. They are supported
>>> only for user compute queues.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
>>>   include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
>>>   2 files changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/ 
>>> gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 7ad8297eb0d8..2765317f04df 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -343,16 +343,21 @@ static int mes_userq_mqd_create(struct 
>>> amdgpu_usermode_queue *queue,
>>>
>>>                  if (amdgpu_cwsr_is_enabled(adev)) {
>>>                          cwsr_params.ctx_save_area_address =
>>> -                               userq_props->ctx_save_area_addr;
>>> -                       cwsr_params.cwsr_sz = userq_props- 
>>> >ctx_save_area_size;
>>> -                       cwsr_params.ctl_stack_sz = userq_props- 
>>> >ctl_stack_size;
>>> -
>>> +                               compute_mqd->ctx_save_area_va;
>>> +                       cwsr_params.cwsr_sz = compute_mqd- 
>>> >ctx_save_area_size;
>>> +                       cwsr_params.ctl_stack_sz = compute_mqd- 
>>> >ctl_stack_size;
>>>                          r = amdgpu_userq_input_cwsr_params_validate(
>>>                                  queue, &cwsr_params);
>>>                          if (r) {
>>>                                  kfree(compute_mqd);
>>>                                  goto free_mqd;
>>>                          }
>>> +                       userq_props->ctx_save_area_addr =
>>> +                               compute_mqd->ctx_save_area_va;
>>> +                       userq_props->ctx_save_area_size =
>>> +                               compute_mqd->ctx_save_area_size;
>>> +                       userq_props->ctl_stack_size =
>>> +                               compute_mqd->ctl_stack_size;
>>>                  }
>>>
>>>                  kfree(compute_mqd);
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ 
>>> amdgpu_drm.h
>>> index c178b8e0bd3f..b7a858365174 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -460,6 +460,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>>>           * to get the size.
>>>           */
>>>          __u64   eop_va;
>>> +       /**
>>> +        * @ctx_save_area_va: Virtual address of the GPU memory for 
>>> save/restore buffer.
>>> +        * This must be from a separate GPU object, and use 
>>> AMDGPU_INFO IOCTL
>>> +        * to get the size. This includes control stack, wave context 
>>> and debugger memory.
>>> +        */
>>> +       __u64 ctx_save_area_va;
>>> +       /**
>>> +        * @ctx_save_area_size:  Total size (in bytes) allocated for 
>>> save/restore buffer.
>>> +        * Use AMDGPU_INFO IOCTL to get the size.
>>> +        */
>>> +       __u32 ctx_save_area_size;
>>> +       /**
>>> +        * @ctl_stack_size: Size (in bytes) of control stack region 
>>> in the save/restore buffer.
>>> +        * Use AMDGPU_INFO IOCTL to get the size.
>>> +        */
>>> +       __u32 ctl_stack_size;
>>
>> Does it matter where the ctl_stack is within the save area?
>>
> 
> This is the legacy way. Probably, this can be avoided. Adding David and 
> Lancelot.
> 
> Hi David/Lancelot,
> 
> Do you have the background of userspace passing back control stack size?
> 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/ 
> amdkfd/kfd_chardev.c#L260
> 
> Can driver assume that context save area takes care of everything and 
> assume that user allotted as per the right control stack size?
> 
> Thanks,
> Lijo

Hi,

As far as ROCr is concerned, the control stack is just an element that 
contributes to the size that need to be allocated for the CWSR area.  I 
do not expect ROCr needs to know anything about it if it can query the 
driver for the minimum size the CWSR allocation should be.

If userspace processes are interested in accessing the control stack 
(like the debugger for example), the way to access it and know its 
current size is by reading the CWSR area header maintained by the 
driver.  See "struct kfd_context_save_area_header", which contains the 
effective size (of valid data).  This struct is at the beginning of the 
cwsr area (ctx_save_area_va), and contains everything needed to 
effectively decode CWSR.

Does that answer your question?

Best,
Lancelot.

cc Jonathan.

> 
>> Alex
>>
>>>   };
>>>
>>>   /* userq signal/wait ioctl */
>>> -- 
>>> 2.49.0
>>>
> 

