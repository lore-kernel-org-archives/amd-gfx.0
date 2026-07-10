Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440C7C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 01:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67A710E04B;
	Fri, 10 Jul 2026 01:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qqyxJwBw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADA210E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 01:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz009mURG1+WDNGzu97ed1Bt2K/I2AKdEyfU1lq6wzDetwaHbNud6fFcLJq6SCulgO2qS1J9qIEWhaif39tYWKdOxUKz1w2VcTFSNCRc6tmkVgVtwLkXwS7q9QD7EDe6owpwj360MWKMw4fNMFavfEDX9gaH2wBVJkv4ZWz9/zf11fUZspr2i8NqRc59XfXFPsLiLFR/PQn8Ul3l50slLKeahg42NcRDm259HPgIEV0kMSaPCH+YHuFIN/QdO/5c0uv9aA45Pg1NObz6s1FpoSiDlNqxFTiZob4coElEUgXGN3OpJf6UzO9hX9S+dAkeDBvvdbi9sVMKC93ynHw6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCP7VCtkhXE3w4dSAsYxmM5gCWF6WlqPeystDunhziA=;
 b=fB0CMLiir6sNddI4OnWgc2x2czWTTzy3COnba4QNSgNE+nXOQxt5wcGQjWPFLgygorIhVBzh0G1PpeF2XPuQBiTOZqevosiqeLfYnpRVK4U8p85oHFrJj70XsyvMZns6ag3Ol0mtJGaBQeunCZqi/h96F9Iv9PsVew6ahl3qoZYteCVXogXPTPde0QWUSiBLJR6+rSRkkzueIuucb9VcvIN3SpaRrlacVUUifZSsta/Cz212oi5hWho7XKM0X3D8bDwk4ssuzOTdtx8ko7t7oc7lgUq9F1ZQHScgAxaBc8L2QLbdYsYuF1m1InVHX2++/aHhbcLNtnrLZ98m7J1C7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCP7VCtkhXE3w4dSAsYxmM5gCWF6WlqPeystDunhziA=;
 b=qqyxJwBwjpy7c6IczKhGpK6Er2YfWxbFKHPECRA1hBNlixQ9tD7bdGO+XD8JM7r9UydPA/lEqNxiFgbvFB2yJFZv6L9H4bc2PhcqV6hxKsg1Bs6QKSshR00TDGLlzhLKLLHpnju5zHKuMERuYv5+i7z5HlLmVeb7SEso5HZ91/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 01:09:20 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 01:09:19 +0000
Message-ID: <e31394d3-6658-4d99-84d0-1927b7dfa80e@amd.com>
Date: Thu, 9 Jul 2026 20:09:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream
 encoders for DP MST
Content-Language: en-US
To: Andriy Korud <a.korud@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <CAOidqQCv-M7oHt9jMMGo2LvhGyXDfNwjfeP+2tASOvg+yRF9mg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAOidqQCv-M7oHt9jMMGo2LvhGyXDfNwjfeP+2tASOvg+yRF9mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:806:d2::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 9582b5d3-3c09-4bb0-9bd6-08dede1fdea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: ZzSSL2E1iUGqxWBuU4V+tvcoWHDTFCoTyDZ8lZmzXm6EWoZEMEY7PZ4TimpYPuEAAoFBDqcvC+rfWO+TnASb5DqG1XY8eO8Uhk5I8ABdUGCsjHHj8t3N0cnbjxPEfTD1ACsTfxUskMiFs8yPKN4uu5iFG6+K9YaPrYsQB7lMpD7SYThgRGJ15hmpiAVlCSt+CtAiFm/bvIHSL5yzqBke5Nn3yC8+6//hIfwv7DK2nCVR5Dy2MZIHMWbIOzQ8iOV+NkZyqtG3nvY6qVgaxqoUR3AuurRtT1psCbUi2rTADVfEaujSZhv/eqqKbIUrMyOUlLZLo94ViQTlZIYtlhkb+fgsmJkClepGqzbuKSU8qiZhUKQYe+0mN3jgIweFFYjW8Rg47TMYTxjN9TmxpoKrA3xZ2jPSTUmxjBJfwMQcajXG94aSZraYs/eDyu33XYAsO+0OXGZALJhxQ98US9yYrYc/NKuZP7GoRZwkC7OE7N0RtHwgKr+nhalzZRk2TI/fnU8eiToEWjaE4N0w9uPgfwsvgzaMs0ehPhzGSgfCCd4vgVWhfFcgUSB0euWcpcvdpz7WtxkCboGn76pew9CO66lfuCNXAwCfuoEjXVWPhFLXT7Q+8GMjrshftyctF0cQ8zckjmnxuSyykqBgkZW0IcXMza9O4CP3LZt6jvhVYHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZKc2dFUEFpUEVMYXlaby9lVXZSUHE3TzdpVmpTUWtDamFodkowTnlIdXZR?=
 =?utf-8?B?OVNtejBQK2FLVStDb1UySWVyVmp2Zm9ZeUZmSzRHSUZ5N0k1cGQrazZqVndM?=
 =?utf-8?B?cTNLZmZXbFcrVFNYcVNkTXNucVRHVENGeEU2YTZmSkg0cThSa0JiZDRvWUJB?=
 =?utf-8?B?WEo4QzFQYVNNcGdoWEE3dExvZ09US2UvR0Uxa2ZqcFVhWWdaeFU0Q3dKVWx4?=
 =?utf-8?B?S1I2ODdva2Izc2tPUm9TVW5KS2FiR1B3TnNLNE5lcnVQZ3ltYklsaDVKQWxU?=
 =?utf-8?B?Vmg0ckdkSFJnOFBjbzVvSzQ2V0c0d2l5amhnL0tMOU0vVms5VEdNelJOTGxs?=
 =?utf-8?B?WnBtRDFQbHkxeEJBeU95bFlxZUtYM1plOW51VzN5bUYxY2dDK2p2NGZhMjBk?=
 =?utf-8?B?SGQ1MjFBMEdoM0dtK3BnRUVwdTVBQm1rN0NzcGNIN014bExZbjAvTmNiWnAx?=
 =?utf-8?B?U21qbloyL2dVODhld2QvR2syY1c2MGh4a1V4TFhrakZVQ0NNR2xhMWJYeTRo?=
 =?utf-8?B?R2RlOXZ1Q1BvTGI4aEM5aEVHZjlYUExDZTM3TGJ6RlBkeGpxWGJVNlprRzZC?=
 =?utf-8?B?S2tKRVYwUi9KSW9BL01ZZnNDc0U3OXpMSEw1RUVrRTNNVEtXQWZGWStjT2Qy?=
 =?utf-8?B?OFdxUytrR1pDdW15QWl0UmZZYUhEYS9XdmorK2dGY1hRMzhyd3lKU3JkODZx?=
 =?utf-8?B?aXozY0ZLaTdxZ3Bxd3VHM2kybEphUUVBRStycW0wRDlXaWk1dWxwcWRIdnND?=
 =?utf-8?B?bnl3RUhjeFp0QTBZU0tqd09scVBYYlRtbUtxYUg1d0djV1hjRTh5NnY3c0Y3?=
 =?utf-8?B?empYWVlNdm5BZ1AxcElNb0k4TjMxa09QWitwdUhLci9SWXpYa2FrMk9icFBK?=
 =?utf-8?B?c2RhSll4RHFBODZONjBrTlk5VlIxMFV0S3JsVFB5eGtNY1cxNDFtSjMrdUZZ?=
 =?utf-8?B?M2RaTjB5ekFrVURpUEZCZmgwcm5VMDNyQVAxTUJKcTJ1V05CMWUyamViVUV3?=
 =?utf-8?B?Q3BSRDVFZzk0R1ZFai8vdnRocC9icmtCMW13NjRRenpCVHdCZVAwK2xJcnBz?=
 =?utf-8?B?MGR1N085MVZ0TkttR0FPMjF4aVk2SFB1UjVGaUpxZjFyMnR5TUpDNXBFbG56?=
 =?utf-8?B?VVRJazQwR21MdW5pWTFyeGc2ZFF3M3pveGIzSndJdjllcFJScW10S3o4MjNl?=
 =?utf-8?B?d2JtZTVQUlR4RUlQcUk0UnpOZXBTT2prRUplenMwSVFWMWQ4RlFzcjRqRGg2?=
 =?utf-8?B?bXY5Wi80RUM4ZExLZEVYZkFVQ0tmQW9xRHhiWHpwMjE3MElnQjgxYysyQWVD?=
 =?utf-8?B?cmNpMUxTRjBSOHY1ay9kWi9BUVZGTjlPS2lyZ0t1QnpvSnVYQVI2ODVXVS94?=
 =?utf-8?B?OExIQTlkamlPQ1U2aVJFWVR2dk95WmloOGlaNlpWKzIzbjUyOXppOFR5OXgx?=
 =?utf-8?B?RjBtY2RoZXRuVkFiYzB5TFRxYkcvYkE0L2Q3b2ZhNFJ0TC8yaVZHUXY1OW0r?=
 =?utf-8?B?SWR1YjhtTGxGV2NSaXNzbnRRcHpnUUFRQlhJcVdTSmtCT3lWZmh2TDk1d0sz?=
 =?utf-8?B?Z2JOQmdQUHQxRzl1ZFVXd3JnRkg4ZCthQlNySDExN1RGNm5XN0E2Mm9QOWQ3?=
 =?utf-8?B?K1BvbGhyQUNKd3hLbkcycGErM1RqMEpVSlN0NTZiYXkrZ0dxQXBNL29CREdN?=
 =?utf-8?B?VHhzeThIeGE4T25wOXZBUm44TG9XQTRYRFpYRzRHZlptcHBueGtQUzRicm0y?=
 =?utf-8?B?WTdXRG9XYy8zTmF4S1l3UzJOTzJKbE5XVEhJUFBGR2VucTZuaytncnV5dmlM?=
 =?utf-8?B?UnRUYXB3Tm9ReU1nRlVrZjBSZmRnMjB3elNOMzNTNm16QW02U2RQWFFYdnJt?=
 =?utf-8?B?QkVLeEhWbHMyMk80OG9hdTFEdW1IcXExcm90L0dyOFpaK0RIUUZ1UDBQVFV0?=
 =?utf-8?B?M0hnMVk2c2JIckE5YWN1bXlnSUpiL0E2WXBUdjZmS0RsMmQwaDJmSmxieEc0?=
 =?utf-8?B?Q2YveEtTY0pwclR4QkFybXExdlFDcHlLZEZPT2s1MnJPL1ZweWRuOHJkeGJ1?=
 =?utf-8?B?ZnlvYlZxQVk2M2ZZVkh4QWU3c3hXN2lCd2NXTjdneitsQjRFNmJRa1NJd0ZC?=
 =?utf-8?B?cit5czMrSUJZdW9WWHg4elhqR09wOGtCMzlrbnZhWGRlblRVUktUL25tanJj?=
 =?utf-8?B?RWtBdjJWalJ0RzRvcjhIUmRVTUxrSVpmZ01BR1lTR0JWek0yRisyVldqVlNQ?=
 =?utf-8?B?MDFvVkw2SGRlSlFTQlM1OEFTcjVNU0dUU0plWVJmbnVZUGxtUCtzT2R3RVpM?=
 =?utf-8?Q?qXvr9RrT2zMgFD1YDW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9582b5d3-3c09-4bb0-9bd6-08dede1fdea3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 01:09:19.6062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrE/C/EEwL37x+OLtdtrZHLlSGIsU85X8jHRqgONLdcaThwVhyu3Prc96MkqD48FGBFmhbplI1QJFghCQqj8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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



On 7/9/26 12:34, Andriy Korud wrote:
> Hi,
> On DCE8-class ASICs (e.g. Bonaire), the resource pool contains digital 
> DIG stream encoders plus one analog DAC encoder. When assigning a stream 
> encoder for a second DisplayPort MST stream, if the preferred digital 
> encoder is already acquired, 
> dce100_find_first_free_match_stream_enc_for_link() falls back to the 
> first free pool entry. That entry may be the analog encoder, whose funcs 
> table lacks DP hooks such as dp_set_stream_attribute. The subsequent 
> atomic commit then dereferences NULL function pointers in 
> link_set_dpms_on() and crashes.
> 
> Skip encoders without dp_set_stream_attribute when the stream uses a DP 
> signal (including MST). Use dc_is_dp_signal(stream->signal) for the MST 
> fallback path instead of checking only the link connector signal.
> 
> Tested on:
> - GPU: AMD Radeon R7 260X (Bonaire / DCE8)
> - Board: Supermicro C9X299-PG300
> - Setup: DP MST daisy chain, either hotplug second monitor or have it 
> connected on boot
> - Kernel: 7.1.3 (issue observed since 6.19)
> - Result: kernel oops without patch; dual monitors stable with patch
> 
> Thanks,
> Andriy Korud

Can you restructure your submission against kernel guidelines?

https://www.kernel.org/doc/html/v7.2-rc2/process/submitting-patches.html

This should be a cover letter + patch or just a patch (not an attachment)
