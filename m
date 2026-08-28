Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF179C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 20:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA3410E036;
	Fri, 28 Aug 2026 20:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OBT9wUdy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0500A10E036
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 20:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soOHbeydL2rlbhgc1Yc9x1p4zDor87vNr3B/21/jTXOdRx04sdq4Jp1d2ULly4MKQ6J+eV9NcZVs8aibgwAsVhHy48NFRdUG3pbamD1qnHJTq3k91+/sbf2hsdGyuzOwScoCQ52GBkH3Rf1bWxXSQesj9/Pv++Ad1Y4CBlQivYBcTI6cMS5lCI7bxqBovxXvUosYV7t97kCQPoe3SMJOheo9S67U506snBm4drztj31MWQglp3TjaCBIbPBZstl2UFLJogSAmB4MtvzvJO/nYqTPBTleZ0a7XIcvH8IXxPSzA+fi3OqA73517DKrpo1v2q8ypsYMo/cWri9m7uJ0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLTa5nZugJoiaE4kRNoDvo2GtkCC5XnVfhCgqS0xp+4=;
 b=U5RX0Ia8Az8oyz4K8w0VUXvqNueHUtUFTchuZjmek5X6PuaJDINGCNho0fObpzEbmpVVFC9aPmkw2IYfjRaYyXtOmCJuGaftK9J5GSpoYxvfXshdD8ib4mKdm+p5Y8aYomz1THDRqpvWHpWGNMoskMTi2pGrg0O2XbstjkmwiVW9ycY1skhexUqMSfxRsXHsnMTqSL4XqDJG7JLcxektsEW97VKS/ukgKtfSzOoT/YmBQO1XtDsJ1Sz1fbWyi5l+udtqoHa9P/IY6456bsdy1sSbwRjj25jthXU3nCooEDSsFuRk1ZG0wDdQ46fSqyoVRNMunnJzIhcn7ftp9UtpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLTa5nZugJoiaE4kRNoDvo2GtkCC5XnVfhCgqS0xp+4=;
 b=OBT9wUdytJ/LlL8hwZxr+4o76Mgk9Y7B8n+xjW+IMwqfRR0sR+sdH94RTItF03FZeW2Cht45VtiIUUnUo6a4ooA6Doy+FMmXr9W3iQbr2uNwPfLqco4q9w4qS1GN34TZilf0XFoOk/HNQi1nEA6ku6YR/SGnFI1Dg1On6FP5jpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 20:38:54 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 20:38:54 +0000
Message-ID: <a5e9ba56-aec1-4684-90a5-2cdf46c5d102@amd.com>
Date: Fri, 28 Aug 2026 14:38:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/amd/display: follow-up bug fixes for LUT
 segmentation
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "'Dr . David Alan Gilbert'" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 robert.mader@posteo.de, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
References: <20260820093324.10201-1-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260820093324.10201-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac840c6-acbd-44ea-d416-08df05446056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mOo2i6sNkqKjhQxUQaMXGF9th+9o8D8ykJ78cqrm9NOekpXTrC7eaDgtdrejrbv1o/e3A8Y5YVuOMbV1yfS6kN0OOXkotiyACdqYffeCpFPFKeIhQl6wMZOX9G+V0ss4GiLNGKrpRhovTezcnrsYF7nDnH521mY9U7rz/T5ce8XaXn9xjRlj2Rk2QpqAYjJZb8kczPozJ5Iosduh30dhflbMdzM6jqG7ID0Y1Q9JjkHZrjXKBop5+zP2Mj6OBveYImSI1rmRa51WVF9lcfXtOAqnfP4Ka6C5obq0bqtgzMSQFDTWOpd+YfI0f9Y9yENjAtiNrRkLUZWsipvc9hHZgEe7GCu1KOiFfRtI+YtIkrZiORGubJc15g0BOVF1XUGQ7WxU+CZlPwjhEIbk8e1KgWYJ98SuObL6+/+KBg84x0z+P/CC6jWTmOEQU4VwOPxX7ug7l+LOaBLzMQiZXoGDpGUJLWPFHws74U6bcABWFuqz4Wp176Z60EnK2fLTqqSEg011aMii+IJ6AhkzxeuGl2mdR4gK0nH1dsil8bevekCjzgcjaol/zlBzKrgQyCjyW4preyZf65n94IRbasTAxwP3TLLA29Hj5UG+k8h86NEbY/QLdRormtI4hI7S5jlWIasR3BzwEQaJd1ZYg7Wctl97sQm8QwikGH8LZYLBYuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXduSUd2SVpBYTNaQmprRXY3bTlaVmlQVzFsK3paRVB0RlV3bjRsMFV2Wm4v?=
 =?utf-8?B?dytYLzlHcnhkenBwU3Y4YStYa3g1NTV4dGpNcnBPcVBXU2N5SU52UGZrQ3F2?=
 =?utf-8?B?TVJOT2lJOEtqbmlIU2t2eERiblRVdFdyaHIveThoRUgxK0xHUHk5emFMUENC?=
 =?utf-8?B?ei9UUldKL29GMytrWlNsM3UzSENmQWNIc1dKWmwwNVhSK3FubisydXVVUkg3?=
 =?utf-8?B?VVNYTm56UzkwL0NUUGh2ZUVQT2d4Wm9ydVFDUVJBclFPcWdhOWNyUXBSZXBm?=
 =?utf-8?B?TUFBTUMwRDdtSGxHelA4L0FOOS9xQS9YR0pkVFM5Yk53Vk0yVGpMYzdpMTA1?=
 =?utf-8?B?VlF6VlFjb2grZXc4KzJOa2ZqR1VST0JXeGxKMm5hV2NSekdPN2V5WEpxQ3hS?=
 =?utf-8?B?UUtZVDM3ekJLTnl0amZ1dS8zRGNVZEduVHduTlAvUGFtaEFpdW1ad0FxMVVo?=
 =?utf-8?B?TzllUEwydGRGY2FWWlZHSFlXWEo1VUZkbFBEbVpxQlluWUs4ckxuQU1IT2lu?=
 =?utf-8?B?TTRvZmtsTzYrOHN5M3ZnRVh3bWhQcGUzRURBOWR0UEcvV0ZubDYvNXpxYzhR?=
 =?utf-8?B?MUluUThDZU5OUk42R0JCVWdWeitxclUvMGIwMnpLbXkxMWRoQmFNRnFMWTFJ?=
 =?utf-8?B?QjluS3VLS0ZWWlZpYkZ5cFpQRFYyYThLTndFdHJTSEFESEQwckRhWU5qTXU1?=
 =?utf-8?B?V0NPaHl0d0JVNEJRWEN3WG04cDFpMzgrMUpGOFZoeFpqak41aTBzdTJnV2dR?=
 =?utf-8?B?VFFDdGs1d05Fdld4MXhuamlGdWNuZ3ZWQUFTYk5HYTRYNjVQcVVaUndCTDNS?=
 =?utf-8?B?cVY2ZkpCaWdFN1dwZWYyTXVDVERZb29qbnJGNURkOWs0ZnlqSWhUd3RPU1ZH?=
 =?utf-8?B?bEUrUjlsOW0xVGNDSVdEQ0d4VE1QeTJxL0FJNFlXUEQ2VC9oTm83YllVS0dD?=
 =?utf-8?B?Y0NVZEpUODlCdS9tT0FJNnB6c1hRM1hhUlhxbUlSUTVTWENKN0FoYlh0aGdE?=
 =?utf-8?B?cnNYNTFRVEV6M25ZeEdpUXpwcTQzbzV3bHYzTDRUeVJVMmU4ZVRlSVEzM2F6?=
 =?utf-8?B?THNqS25iNUZhOGs5ZndsWEdNTHc0dTNMMWxvTjR4cGpMR0daRDZFQnhoTTFZ?=
 =?utf-8?B?QW4rQnB5TngybVFSMFgwQWNUUTFIRWJjYmhaaUh0T3Jva3JLbzFFTnY5Ukta?=
 =?utf-8?B?RjNrQXhiemhQSnpmYjJOeVpIR1hrRzhZVUUrNmd4L0xvaU42eG1SSWdnQ3ds?=
 =?utf-8?B?WEYxNkpLR3BreHdZSW90cDFSRWFFR1ZaV0gwV2VuaS83TGVIbkdKbFIvK0xZ?=
 =?utf-8?B?SjltQ29CMXNoQ0JkenM5RlRvYVRuZkx3cjRxZXEvRksvdnM2c0t3VkJJU2Rx?=
 =?utf-8?B?TkhsalRUTk0yR1dtQ0xjN2lRVk85RUhiR3ZUdGRjRENaa0F0MW1mWUh3dDRT?=
 =?utf-8?B?dndOV3NCeHdIbUdRakxpMGVrTXFMSFB0WGZvclcrMWRuOTJWcTFRK2tLTkRp?=
 =?utf-8?B?dW9jVGlZKzdWc2RzVmlpNGk5NWpjbW9LUWVnUkx4S0JxQVJxbDN6VkFrL2pQ?=
 =?utf-8?B?Y0w3QnFqOU11bkhHWWtybjVsbEo3cU82WG9LaThzeUJQemc0anpoVUhVdk5z?=
 =?utf-8?B?WnRvK2cwM2ZCQVlwMmEwbS9RUnBtS1BhdEE5cWFtcnh6a1NORURERDdCVEJw?=
 =?utf-8?B?UW9ndTAwS3FGcnA4dXZ5bXFXQTVzdjduNmFFU2h0dWVJY2cwditwYjlMcFoy?=
 =?utf-8?B?aUZhckd3eHI3T3hEK0MzMFV0Z3JhNVNWZC94emt1dkpSVDJpQlZvVWhoamt3?=
 =?utf-8?B?YjZ0Y0MrUkMzdEhPcEZPdTVSYi9QQWVxVXliYnpkOERMQ2pHeFYydEhCS0Fu?=
 =?utf-8?B?NnZ0WjJpekF4OUh5a2Z1NFFLYmlhdmZZTGFlYXcvZEx5enl0S1BKOFJqZG9D?=
 =?utf-8?B?Q0FXRW1RakZYVWhTMUZxUHdqQzJjNVd0Q20yQnR1TU0vVzRkekNvZmF6MDV4?=
 =?utf-8?B?eGJmOFR5ejE0dEc1U0wwYVVEZzZ0VzlIeTFLV3RQWlNkU3Q1UTRIb3JBRFQ1?=
 =?utf-8?B?MkhOTzFVU0trbnNTVzdpTmNEWXBrd2diMVBYL1F1UWlyY0NZT2c0VEsraGRy?=
 =?utf-8?B?aFVzbzF0ZzJNbGdwR1pMOGUzNWdweUtCRWdFTjExRU9laHhIMzVITFpVcU1G?=
 =?utf-8?B?bkRmeGNCQzFNcDc0NXh2UWhMa2xyZmpCZitrVUhScFZidmM2dk5tNS9JeUxG?=
 =?utf-8?B?azZ6WUNmNjJ1aERXc3NvNjF6Nld0d2lQd0ZYR255Wk5aKzBkOFhKc2hLWXpy?=
 =?utf-8?Q?4UnNNBUJXUOpnjFrmk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac840c6-acbd-44ea-d416-08df05446056
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 20:38:54.5115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TWyuqwKVgsR4MDVleDcyixR1pZIMOrXIkmF0vSpAV887OB1ATIEaAalLRawq3sfBlafi5hOSHmCfZvaUCu4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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

Weekly promotion tests found no regression.

This series is
Reviewed-by: Alex Hung <alex.hung@amd.com>

On 8/20/26 03:26, Melissa Wen wrote:
> Extend halving distribution to all curves/custom-LUT in a
> encode-to-linear operation, not just PQ/SRGB. This fixes IGT kms_colorop
> test failures after [1]. Also use the CM3 degamma helper which
> translates curves into hw points for DCN30, DCN301, DCN31, and DCN314
> not just DCN32+, as the banding issue is present all of them.
> 
> [1] https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/
> 
> v1: https://lore.kernel.org/amd-gfx/20260819161106.27702-1-mwen@igalia.com/
> Changes:
> - Clearly state which DCN versions are affected and the reference commit
>    (Alex H.)
> 
> Melissa
> 
> 
> Melissa Wen (2):
>    drm/amd/display: use halving distribution for all encode-to-linear
>      curves
>    drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30
> 
>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 34 ++++++-------------
>   .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 10 +++---
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 

