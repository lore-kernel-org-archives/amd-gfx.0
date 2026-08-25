Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213FDC61DBD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 21:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A224310E1A7;
	Tue, 25 Aug 2026 21:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uILx0nHn";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0ED10E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 21:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKZex9xLERLPRXmJxX35Wp+5dzXSfY1dEJkvGaw81YLiRc2PwpHOkUxsO03GS0IFdP8MoFzTq1wg1wFuYlfAVWO1zaMg/QLeCbV6gvgmb/DOJ0+acfRb/r36iJTp7irknHVBQCz4yrEajb23w0wVkl0ZcPWjbjZYcG3JzjkIYtEMUSQJN8OzR1ERzuoEIpDInpg0vAk47jRv9rEozQLcF0tSQPnQ9rYAlActOI0Jfk2Um/kBHpQ8AGGKe10vFIbnA96hC5uv/rIdacmMLkbCKR/I1VNAbHGfTHggOn4Jv+kE5xCORU4fqROZC1quTWqbDUpACPjz+l+T63T/auCjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmEcBHPU8mz9MMXDWw6aglbxUrahVl46m/xbxT6Z/Oc=;
 b=JxYcOxRC1jVOzYWDmwy/ZFdfu/xEx7XSUAQUvi4R1mVn8LQ7dmSAhHOuD+ACRScVxYBQpMp+OKZtZZ1SADXIiyB1rjEq7tLbfsJsyNxySGsUkETLct2YorMKD+ZXWP9wm9HSjdvT0dZcy6G/4IaYqr98vsh45P0LQHFrgzBPTFXIMO5KD2Bu/gpn4hjD5lwlKk5WZk+XalywkFS/1YESXBdRRbFWk1bnZG9fBDZlaoZwmnuQaSQiA2BxWDETK+L/x4ojhha8l+4dvydPBYbgFSaMvsRWVgMud+9eoOQyRpA8t+CJhyRQovySuldanOBkosIFSqr5uEvun0fNoJiEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmEcBHPU8mz9MMXDWw6aglbxUrahVl46m/xbxT6Z/Oc=;
 b=uILx0nHnSCpkAT6T8BtPU47GUYCXozYhGo8fr9RfIMtpVSZrx2/bjH1/XP7BDtiDnmO6hUijHBwHRwc+xkw7PBvdaoKXwcN5eUigEwFYdoYL0wfi7z23bRk8UoqE6alZ4yP/jyc+PFXE2e6wbmP6nSA/Ix10LmLIj/bHM8UliBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 21:23:05 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Tue, 25 Aug 2026
 21:23:05 +0000
Message-ID: <bf88db52-6b66-4731-9750-943cfd64e0a4@amd.com>
Date: Tue, 25 Aug 2026 16:23:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/amd/display: stabilize DCN35 ODM and DSC
 sequencing
To: Mauricio Bellon <mauriciobellon@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>, Mauricio Bellon <mbellon@lenovo.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260825211819.100210-1-mauriciobellon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: cb06a48e-311b-4f52-e79b-08df02ef0cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|13003099007|3023799007|10067099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 15jnWDathF1/dqmhLoaPer/PEbewzkqSCt63Y/7gdDGxaXAphZSxmCa1RiRtV4mQ2j2S/ItfphL+ahJvtwF5+j+DnU1frQfuRoBXYYfM9d1j5+vjjl0sTLr0G3uHq+UbLVC0mBsc0sAVokfq5wRyqPghi0+3ef6FJZTx7vfoBCu6z9Aqms6GDMjTJmX5YW6LwxOBpUXFCA2auTnEZ9CkWuSI155renU3cYxAZcuM/HukOXbOuIlSjNYBL0nB5Egwt7myiNPtdGfJaVK/36h56Lun5oWaOH0Ifo7F1u8J1CuygC6MCpbPAd1W6DirCcnnughdMN2SeA2PWSbs9h0ZRVfRzzWec9xLI+Rz9lQ4z+wsCpOhCexIb41WUOxbyR0Kl+3qf+6POiS/GPT4/YUeXiLq+lLsduTne4hQCvaSUsW++N3KBJBJcYqAf2edQukkA5/2WILEy+1mqBQr7bMWpdtwJpI5AC22kIaceUNH4udzTDXQKTgQXHbkZ+5JtwRoeIwwz8gxgiC0DM+mDPac/TBcMs54B9hzGxO2Q7mt7jsObOPF+E1ehEnXvJVl8zDuEUzLLBmN7VJKWDhasjV4pD71wG8TGymlqoGb42mZKuW1VaI5gZlH+P27ZsuLcDNb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(13003099007)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBKenJCQ3FwN29mL1pCSWx0ZHFQTURwcThJcUczd0FHRld0aDlNamtsWWxu?=
 =?utf-8?B?V0doanYxaTJBUE82MXBCYzlvdUpLOVZPdWRKakE1SXIrWVk4TGhtM0hsQWox?=
 =?utf-8?B?YlJzbzJhZlE3cU9saVk5MDljQ1VrTzRkNWpNdUU2NFFNNmhYNDFBNnpqOEdm?=
 =?utf-8?B?QmMrbHdQemdXUVoybDgraGI2YStLaG1DdDZsVlhjM0Q2dWRVOWM3enpIZU91?=
 =?utf-8?B?QXdnc2Rob2VvK2tJUWRaYkE3K3pCaHJzREhBVSt3aDhNdVlleWYvR2hQYk5X?=
 =?utf-8?B?Q255VjdTNFQydE9oejJncnNHNm1nTjFpTTJ1SkNHRm9KRnlZcHJLV0doMFRS?=
 =?utf-8?B?b0J5UXN6U0tmcmNPYmkzRGZrN05wZVV3K3YydG1yUmxpUk1WNEVlWExvZE9W?=
 =?utf-8?B?MEgyZXVUMWxORHFCOUFybXV0MXYyQnlwQkkxQkg4aDh5c0JENVJQVUpQazZK?=
 =?utf-8?B?bjVYRVlBTE5qbERPVmticzV6MVl5VzV1SW5tODhGVk5KN09YMDQrMkdnRTBG?=
 =?utf-8?B?UGZibnZQSWpUZXdoK1AxYmVPaVk1RzJZQVgrWjIxbTRaa2NHc1RDTUpIRXA0?=
 =?utf-8?B?d0dudzZWcUx1TmV4QWRYRS9qUkdkemlENDNLdVRYRlJZZ2dNUzdIZ3ZUZFhs?=
 =?utf-8?B?WDI2UlYvMTRCRGpvTEh2UlFTL2dsUXdJYmhoRDhZVytkL0lMWU5hTEljMGh2?=
 =?utf-8?B?eE5wRWlVTGQ2YmxMb005ZDFyWGFDOWgySnRGbjJwR1BFMEd2TklkdXoxL1Zu?=
 =?utf-8?B?L1pqdDF3UjlPYlpJV2c1TkhBT0xaMENkdFBFSE1UakgvZGo3Ni9uK2NmVTRI?=
 =?utf-8?B?RnlIVXhCVWdsam94eG1sRkdkdEJaWGQ3aWRtbkZsYkZyOTJiMlZMczVrQUox?=
 =?utf-8?B?YXA1b3hma3p1Q0kyNENoVmJCdjUrRWFBcm5DZDhsMm9hSHNRRGNrNDlwMm01?=
 =?utf-8?B?cUJVcUpLYVUwZitZQTdSNkNHR1VYT2ZETWx4andqWXBTRXUzT1RJZGtpQzAz?=
 =?utf-8?B?ZmRFRUt6S3RtOVhzdVI1dHpMQmNaQUlTS0hzcXd6Z294ejB6bWViT2w4aTBN?=
 =?utf-8?B?ZmxnZnZrZGd2ZlhYbDROZnRnMUx5dTI1WVMzWTM2Z3BGWmlSdkFOSktVaEgr?=
 =?utf-8?B?WXdwR2NCZnFVMFdYRit2RU4rSmEwWTdmSm1aQXJqVlk2Yi96Ykp3UTFiN0N2?=
 =?utf-8?B?SWxpUWJ4dnZOU0c1SklRSE9QSmVoL1pVZEl6MEdGZnJtbmNXOGgybGFEcWl5?=
 =?utf-8?B?ZjI5N1p2cEtKbjAwSjZOWVZaU1BtY0VFSEtZMGNJYXlxVGE0SWpsQkdnVWEr?=
 =?utf-8?B?aDNZcVhEUHFaRnhid2ZrbHUrZG85OG9qUWRkS3RDeXovRHNvN3NIY2NoaUlu?=
 =?utf-8?B?S05PTTdEWU1GaFl3NFRVRGFSVFNOODc0THZ6VDhjSmRHQUcxcUlCaG5FSzdM?=
 =?utf-8?B?OW9vT3pwbjU2dFJ2UFREdHFwVWxXc2R0SVFiWjE5enJKOTJFQ0pKdjIvR0Vx?=
 =?utf-8?B?Wm1DUmlQN1lGS0ZKbzhndzgwWE9XeDE1ckZQSkxiNXF1Ym9Ram9TeTV1SFFW?=
 =?utf-8?B?U01MQ0RnM2x6KzEySFJQUWl4ZXRkTVBRSDM1eEpJN0xoNXUxZlByanBTQWpD?=
 =?utf-8?B?Q2hkcWVHV2NNQWRETXlnV0pzbitKdlN5UkpCTmNJMFpIYWJjVm1yaUs0WVVD?=
 =?utf-8?B?NDRZdGUrTS9DSit2MW96aXVLNVprUjFRYUh2TXdGNVV0ME91VkZaUmV4SFor?=
 =?utf-8?B?Yk9nTzVzUTBLcHM3QXFLSkI3UDJxUE94RU1kMWpQa2dOSklvR09LS2h3U0lR?=
 =?utf-8?B?MCtHamI5SWVFZVlSMGh3U0IxY2NBNWhsaG91TWVZWGN5bk1lcys0NTdEanNh?=
 =?utf-8?B?TVVsUWV1ZGlGdVBlbXdxZ2c2aHVmTkhPSEpCZzl2RzhVLzNCdGEveWtBeHpm?=
 =?utf-8?B?QlJrSHNMSFJvdEpXUlpqOHhINUtiSFRJRTFwSmdPMUZuc3F6SjRaRFpySW5O?=
 =?utf-8?B?YWhVMXhDbkE5eVRFN2doQmM0cUhSeGhJRkV0MEFZTlZDRG5VekZNZHlzMDdT?=
 =?utf-8?B?R2hCeWZ0WVpyWEsrVDVQMVVzdmpzUGh4OHkwN3NoSGFzZGlCdE1EQ2ZRVFU0?=
 =?utf-8?B?NTJmRUYrSERaTW1EYnBleTBuRm1id1RnRFNiaUhtSEpCTDdlMTRYeHY5UDZT?=
 =?utf-8?B?MWt1VUIyTWV3YzdWWXpRYXpDQ3d4aDNsd1BsTmlrTkRTQ0hSLzNaSUsxQ2NG?=
 =?utf-8?B?V2JscEJGT2J3NCt2WDJhRzZBMHJ2ZXJaZVY0L2JheXJtY3d3UmJ6RDdBenFB?=
 =?utf-8?B?QStaQUpkRzdLM205RVNtQ0pnQUliZmR5eVdRdFF5cGdaQkRJaURMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb06a48e-311b-4f52-e79b-08df02ef0cf6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:23:04.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14ssJeSgeFlUq7lIZtgTkZzXZxniz9yoVIFyffntWTaJSEBvo/Dp0+46CdcWy48JXjI2XnKd7U3CcODrgHGApQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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

On 8/25/26 4:18 PM, Mauricio Bellon wrote:
> From: Mauricio Bellon <mbellon@lenovo.com>
> 
> Two related direct DisplayPort failures occur on DCN35 with a
> high-refresh DSC stream using two-way ODM. A normal transition from
> 4K120 to 4K144 can commit successfully but produce no visible output.
> After 4K144 is working, a long-pulse hotplug can reconstruct the same
> stream but leave the monitor black.
> 
> The first patch stabilizes the DCN35 ODM update. It exposes the missing
> ODM double-buffer pending-clear callback, keeps the horizontal timing
> divider under manual control while programming the ODM topology, waits
> for the update to complete, and restores the timing-derived target
> manual mode.
> 
> The second patch enables sink DSC before source DSC in the DPMS-on
> pre-enable path and removes the later redundant sink DSC enablement.
> 
> The complete series was built and booted as
> 7.1.0-bellon18-amd-final+ on a Lenovo ThinkPad X13 Gen 6 AMD with a
> Krackan Point Radeon 840M and Corsair Xeneon 32UHD144 connected directly
> through USB-C DP Alt Mode SST.
> 
> The following scenarios all produced stable visible output:
> 
> - 4K144 initial modeset
> - 4K120 to 4K144
> - 4K144 to 4K120 to 4K144
> - 4K144 long-pulse unplug/replug
> - repeated 4K144 unplug/replug cycles
> 
> This series covers the direct-SST modeset and hotplug reconstruction
> failures. It does not claim to address the separate DPIA/MST warning
> observed through the USB4 dock.
> 
> The commits retain my Lenovo author and Signed-off-by address. This
> submission is sent through my personal Gmail account because Lenovo
> email is not compatible with git send-email.
> 
> Bug report:
> https://gitlab.freedesktop.org/drm/amd/-/issues/5033

Thanks for the submission.  If there ends up being any changes to it, I 
would suggest adding to both the code commits:

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5033

No need to spin for now, whoever reviews and accepts this can add that 
when committing.

> 
> Mauricio Bellon (2):
>    drm/amd/display: stabilize DCN35 ODM update sequencing
>    drm/amd/display: enable sink DSC before source DSC
> 
>   .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++++++++--
>   .../gpu/drm/amd/display/dc/link/link_dpms.c   |  5 +++--
>   .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  2 ++
>   3 files changed, 23 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 232bf7d5453df6cc0d877a1003f9aa172e9750de

