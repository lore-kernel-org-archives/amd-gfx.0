Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D2AC61DB8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 15:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFF610E3BF;
	Wed, 28 Aug 2024 15:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qgHmgvkv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E7A10E3BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 15:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQNHeeN4AuBSlmjyFxfSYTfmGdFPL43rAZ9s0NjLB/UzieTVXnrB8zFxVQd4SsYU8702Om/rnFbBZnNYHXZljojgAk1Fs04zpd/TGx5dNXgohtOPgTKdhj4TXbPP5cgOO1XYCNJjXPr0NQLmYJATtF/1j8jrfqu7OQFdFrO4hc8t+dhgDNq+3zVLDLWL6LgIHrbCyQIXVrWGNQabw1sKQXopuRY6OFuF8TsXWwpas3o14XjSMnwBNpk27HBYGIwfZaJrrezm78wN1X7M5BixOvSadBOwubIwEXZSiT4BgUorogFR3VT/ynDRFk7iq6nru9feollVrq0al25bx6IYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN0LTn9mP1Mzsu6hmfaf1D1lW+Fa9ct9bZVhvca9B4g=;
 b=tEAB8YTLJ46/Onst4AAxY4HWheq7a1tU977XxmQJuAVVEfLaLOAE/fzU3orMO4/bNJiGduV2amIfgl0ZYSc9LN2N2cWD23cGQlJSo0T+Ez2T9cyAh5b5Ta4TPTdRt2O2iWG83mZN2HJi+7BgG5M8rsFYyzwpwBn5CzfuCk2FrV+Imm74FBZ8NJcS8DAqLrUuo+7OHfd0oFCV/vT/SIfOVHmPRzWI52z3N22vbq1Om1yyfukBLh8z4ExQCVHDUjaFYNBhpPoK035qN3Cmqfd6F7vMpsYYeN3b77uGZ+sZGDyLtelL+E2XneUO8EzmpPhcohGfwmVU/aWfo7n71UY7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN0LTn9mP1Mzsu6hmfaf1D1lW+Fa9ct9bZVhvca9B4g=;
 b=qgHmgvkvpS73LBvk4lUX3s9wfkzaxeeROX9fu6GnwsOPQAR+Yx/7XbGBNRyYBdVIIScE39wPaahTmMlGr9JfF8fNI9qP6Awfi5JVc9n5UsqdCosrJL7FNgxVxY/VSEPxyj+/TNqDbx9idsnbtL3Z/OD6aIc9HGrKmsvyEVkmgrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 15:49:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 15:49:28 +0000
Message-ID: <22b01c7d-07da-3f49-bb1d-e8f822e637e9@amd.com>
Date: Wed, 28 Aug 2024 11:49:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dd4d28-e783-4318-80e6-08dcc778ffcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDVnaHY3WWx6UndPc29IVFVMTTdQalFMMTA5RXZRdXZqUlNWM0lGQkxHQVN3?=
 =?utf-8?B?RG1lR3FyUTIxaVlLY3BMdENLdktDL1BkWlNYT3dmdWZzQjQ1VUlQd1RVdWk0?=
 =?utf-8?B?UUlPbGtVQTV5UGkrNnNJVjFrOHR0U3BOK3o4YTRQQ1hoMm9jVFYySW1PbmFx?=
 =?utf-8?B?cnVINE1Hc3IzWHp6dTQ5dTF0SmJGYUhzeDZzS1JnTTNCWHVJRUs3YXFWY1Yv?=
 =?utf-8?B?THI1YTQ1QkFCU0lTS1JORWE3aTJvL0EvTEt4NHNFK01YRWZZUW1tQldJYlFQ?=
 =?utf-8?B?ay8vUjI5aDZEZW1OVEZDRnhlT3N2cEN4aTlqT3htNTIwUXE2UWdIaGlLV3Z5?=
 =?utf-8?B?NEQ3N2IvVUhVL3ROdjd2VHpwNndrcmFVMVVva1VjazgvMGhuN3hSOGZ0ckl1?=
 =?utf-8?B?bkdQS3piMytlQ0lOL3ZIakFPbTFFQ3lMWWw4Yk8zTEpvVEVxRXp4amM5bGw4?=
 =?utf-8?B?OVlxZEN3SHVxM3VqUUs2VkNjSXRCeFJoSVVwYUhSUEZNYkRpeEpJOWFabity?=
 =?utf-8?B?blhWYXpiVDJJMzhoS0pSbnE2Wi9oT0F5VlFyNmNBWlZJdGVXUWx4d0RndTVM?=
 =?utf-8?B?SmtSckF0T20vUjZjQlFFNUhibjJUQkFEek1LR09vMlRiNlRid2E0bmZrRXVy?=
 =?utf-8?B?YmxDVGxXYTR2MVY0b043c1l3b3Q3d2dtOVpXWWlIb3c2YU5PbzFXTy9VOTVV?=
 =?utf-8?B?bytYQnFmM0pkZ0hzdG16aEt5UE4vZVl3akZJOVVYeXYyQTNzRWRmc2xsZEtH?=
 =?utf-8?B?TE1FWEZhbFh1aFVnUnZsK25EcnhadDM4c1U3RFdzYytQTWV4L1NWUmg2Y2hH?=
 =?utf-8?B?dEN1aGlVM3BQcmQzc25MY0RRSzA2TlRJS093d2wydmFOeU9ZUE5HY0JkNzQ2?=
 =?utf-8?B?ZWtRTFlqN3V2bUVtM1N4YWVmSHUya21pYTR4TjNlVlVPZ2d4S1lBMHZiR2sw?=
 =?utf-8?B?VDc5TmFyMTNOdk0xblhVamxXWlhhc09lQTBYTnRaNzBjVkcvNUtJS3ZFN1Ba?=
 =?utf-8?B?TXRpTWNIUDg4MlJEelp0ZVQrRUdzeTdkZ0lUU2IyK3IzM1lBMlZSZmY1K2xN?=
 =?utf-8?B?c1VrdDNFUUdoNjBEL2hNTmlGK1R3em1zSHYyWXhVVFhUNWNBS2lFT0tkNnVP?=
 =?utf-8?B?dnA2b1lHL3kvRWcwS0NsMnNGc0huYUZlbWdmQ3R1N3c0WC9SZHBUTTBJdnlS?=
 =?utf-8?B?ZG81aWtOekFEQm1XM3VMMzV4S3huS0JteFV2blAvckowVGRvbGZiWjl1ZGRs?=
 =?utf-8?B?Z3l6aCs0cUcwVTN5aXhHckN5Ny9yOFhyZEpDNVNJL2Z0S0ovdXBHM0pTNzNR?=
 =?utf-8?B?cmRvVFQ2M0pUTkNHZmJxU0pDdzF0ang3Rk44OWpzR1RSb2dseTFhQjA0MTFq?=
 =?utf-8?B?K3pCM3htb2FvaGhQZ2ZEVjYrbmpkNElvdExPY0EzM0lhUHhJWTV2Z25RcUZq?=
 =?utf-8?B?UEpvdmI2T0d3bzJXNkZJRllTaGZldGNWU1RRVGV1UU5KQjFZdjdtSXY4L0dk?=
 =?utf-8?B?TDZNVytBNHhteEVsODNES2h4c1pTZkowb0p5YzB3OEFETkdOQU5TT2U4aC9X?=
 =?utf-8?B?TG1wSHBUcThFaHB2SnBWVzJxL0lDZEgwV2R2UzBFYnpLZjdmMTVHNHZhak5j?=
 =?utf-8?B?WExuZW5wdkJFYktpUVI2Nk9pRGpjN3lVM2pUdmp4dmR0S29tYk9QdnVJTkxK?=
 =?utf-8?B?YXM3L2duZjdVamNVQUZpRkZZWlNsdGhPRy9Cc2YwQ1ZqM21vTnYraG12ZHY1?=
 =?utf-8?B?NCtCcC9lZS9OeVJMSDlzbWpqUytHb3IvM0ZWS0FZKzFCZ2k2LzRLQWhUYXlU?=
 =?utf-8?B?V1lFdmtjRGh4V3BablpRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEQ4QUl3SHQ2cklNK1NwdUFzOGhnRFo3c3ZWS2RVc0xVUlRNd2c5WVlubW5o?=
 =?utf-8?B?MFU2YVJmTERwR0MvSCt4Tk1sUHRUWmNpNnJteDM3c0RIZi82aHhRM2tWZGhL?=
 =?utf-8?B?VFI0b2R0S2lBZG1rb3hhUEdxK3ExeEIwZlBRWkwzVXR2R25ydU9VdDVhZ01W?=
 =?utf-8?B?bHlUZ3NlM3k0VkhNRkJNK2lpV3RVWVRtZFAreDZ3NmlHTldSM3NvSmFUMHlX?=
 =?utf-8?B?alhHUkJBbGVTRW4xWU83SUh5RWUyb0s1MnJSL2ZoOS9FWjQzaHFkajZ4b2g1?=
 =?utf-8?B?YkRtV0pZb29MMWJNelNyVDl0OXg5NCttQmJucnFYV1BIVnJrNkR0a0F0T0FP?=
 =?utf-8?B?Q3BkY3hIbEtDdDcveDRjaUF4dG1DTEJWWm5UWXpzUU00V2J3Ry94cDdiWEty?=
 =?utf-8?B?MytTaVdOOHNlQzd2aVlzN0VhSElpVWFnVUN1Y29ST3RtSWhrS09NajAwaXo5?=
 =?utf-8?B?L25sNWI1U25pakZVU2FOc091NHdEVXRmMVpiQllxNkdvUzdHdVBYSHlsYU4r?=
 =?utf-8?B?c3o5Zm9iUFFNa3EvYnRqRmduV1kvL0c5anhhWFRoOHBQVE93Ujd5UmRHeDZS?=
 =?utf-8?B?VEI3MDNISUVySHlPZzEvNUdEdHAra0RvTHRZekhBVE1GVnFiZitwZjNZalJM?=
 =?utf-8?B?RU1xcnk4TU5HZlJRU1NyOG4zZ21RWEF3S2YzL0JycFlENkVIaURLbXpwNVFW?=
 =?utf-8?B?L284cldnTjdpN2htR2RxUnV0bzlBT3Izejd4RkhxV1F2VTg3Sk16Z29jTkRQ?=
 =?utf-8?B?d2ZHVEdnaXNNTGFhelkraTVxZHB4RU9OSTU2UHpiaXZkd3I0UTBWNVc1WE90?=
 =?utf-8?B?QThSeUlDS1VCRi9tUnAzbldqWis5WU1FVXdCREgwUmd2WXVMRTR6TUUzWU5W?=
 =?utf-8?B?QXhkUEx2L3ZKaDVJWHVWYUpqZTkvU3pxRDdCQnhyaENWYXlUaDZUYXN6VkVn?=
 =?utf-8?B?czJuU0F2TXVrZmxnOHFEb0ozK1hhczl6cWFXRTBoUW04Q0RWUTVRL3c3cXZk?=
 =?utf-8?B?Ukp6RHF3YUJiSHR0eGtJK0dnK3l5amp3dW11YmVDZStkMUF5NUJGZDZKSUJS?=
 =?utf-8?B?ZUROYTQzeXlLZUVwTXhjVEFmekZ2SVpzQTVvNVJibFNNYWNxMFVpbUU1amZZ?=
 =?utf-8?B?aHhra2pzQko3MFcwVjI1OXd1MkJHN3Y5amhJRHdTdkxpbW9yOG03R085Sk9r?=
 =?utf-8?B?SndzZ3Z3cUwwNGMxaHhMVGUxSytjZE1xZGRqSmtOaFM0NFdHMUF3ak1vOUNk?=
 =?utf-8?B?RkxnS0NCV2ltVXE1QllubEJVRkhqcnM5RXQ2UHgzVGF1SlFNb3FteXNpVUg5?=
 =?utf-8?B?WlJtVlhlbExsSytRL01QVFNjOGRHUnYvaElEazVDMHJwY3BCZmFXWE5ZK2tE?=
 =?utf-8?B?SjZ3TFE1N01JbWFsQ1JSdHd6UktZQ0t2WnJzbllscXpITjVZcTh6b2RuZmMx?=
 =?utf-8?B?c05PTnAzNWQ0SG1wNTRic2Q2Z25WenZPOTR4M2h2eVJPZVVXdXJZeTlXbVJ0?=
 =?utf-8?B?NjNvRUQvYnB4VkNIVUhaNk1oaGZnaU5lczVvS0V0TFZLdkt0Z3RseFo0d29z?=
 =?utf-8?B?bFpvWWhXTm9sSDFyQ2h2MjJvbHc3U3JkSEgzdWFhUVprM2w4OXUvTWFlbHYx?=
 =?utf-8?B?dmZMNDljaHIxS1BRVmZ2cW1jRmR1Z1QzMEhBUXcxa3lKNmQ3V3EzcmEwSXZJ?=
 =?utf-8?B?UU1nTndSMWRnL1pHbmtPYXZqM0JiWkVYcENtSDJZV1RzZFZZZDV6cUV3czVs?=
 =?utf-8?B?K3kwZ1dIRTNjRERoRXZJeGEyUmpWNTRkckFpa29LUGp2aEN4SnJuN3lFMnNF?=
 =?utf-8?B?eXlxaWkweHYwYXRoQXBQai80ZkZEOE1pUVZReUtlRitYWjJmSzMzMWF5b2pV?=
 =?utf-8?B?ZWVUQXJEK0JHQkZTSHUrM1dZbUtlQWtFbk5yKytrSldFaktiVXBpVlR5Nlpr?=
 =?utf-8?B?elBESE40L2wxVkJlRWFMUGIrSnRJbFppcmk2MVpPRi90SkVYOVJxajlTNklJ?=
 =?utf-8?B?MCtHdnhhQWVKY0hRV3R6TDNrcTdWUW5oSDJBcmR2NlJndTJzckFDR2VzNUlj?=
 =?utf-8?B?V3JacFhoUGs4OStmY0NuQ0JabDI2T3lBRXozZG1NYWQvWEhVMmNZZjU2ci9D?=
 =?utf-8?Q?mcbw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dd4d28-e783-4318-80e6-08dcc778ffcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:49:28.2957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdo0F+skOy4IDT9Pa87A1hxfEXcWhQEy0voT+ou7Yw4Ij3gXpLjRAZ7hBAF/awHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-08-26 15:34, Ramesh Errabolu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">Enables users to update the default size of buffer used
in migration either from Sysmem to VRAM or vice versa.
The param GOBM refers to granularity of buffer migration,
and is specified in terms of log(numPages(buffer)). It
facilitates users of unregistered memory to control GOBM,</pre>
    </blockquote>
    it is used for both registered and unregistered range cases.<br>
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
albeit at a coarse level

Signed-off-by: Ramesh Errabolu <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f2..73dd816b01f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -237,6 +237,7 @@ extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
 extern int halt_if_hws_hang;
+extern uint amdgpu_svm_attr_gobm;
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
@@ -313,6 +314,9 @@ extern int amdgpu_wbrf;
 /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
 #define AMDGPU_SWCTF_EXTRA_DELAY		50
 
+/* Default size of buffer to use in migrating buffer */
+#define AMDGPU_SVM_ATTR_GOBM	    9
+
 struct amdgpu_xcp_mgr;
 struct amdgpu_device;
 struct amdgpu_irq_src;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..09c501753a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+
+/* Specifies the default size of buffer to use in
+ * migrating buffer from Sysmem to VRAM and vice
+ * versa
+ *
+ * GOBM - Granularity of Buffer Migration
+ *
+ * Defined as log2(sizeof(buffer)/PAGE_SIZE)
+ */
+uint amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
+
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -320,6 +331,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
 MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 = disable, -1 = auto)&quot;);
 module_param_named(msi, amdgpu_msi, int, 0444);
 
+/**
+ * DOC: svm_attr_gobm (uint)
+ * Size of buffer to use in migrating buffer from Sysmem to VRAM and vice versa
+ */
+MODULE_PARM_DESC(svm_attr_gobm, &quot;Defined as log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB&quot;);
+module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
+
 /**
  * DOC: lockup_timeout (string)
  * Set GPU scheduler timeout value in ms.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9ae9abc6eb43..c2e54b18c167 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -868,6 +868,18 @@ struct svm_range_list {
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
 	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
+
+	/* Indicates the default size to use in migrating
+	 * buffers of a process from Sysmem to VRAM and vice
+	 * versa. The max legal value cannot be greater than
+	 * 0x3F
+	 *
+	 * @note: A side effect of this symbol being part of
+	 * struct svm_range_list is that it forces all buffers
+	 * of the process of unregistered kind to use the same
+	 * size in buffer migration
+	 */</pre>
    </blockquote>
    The comment is good enough, note maybe misleading, not needed.<br>
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	uint8_t attr_gobm;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b44dec90969f..78c78baddb1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(int32_t *location,
+			int32_t *prefetch_loc, uint32_t *flags)
 {
 	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	*granularity = 9;</pre>
    </blockquote>
    <p>as svm_range_set_default_attributes is called in multiple places,
      add new parameter struct svm_range_list *svms, to remove the
      duplicate code.<br>
    </p>
    <pre class="moz-quote-pre" wrap="">*granularity = svms-&gt;attr_gobm;</pre>
    <p></p>
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	*flags =
 		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
 }
@@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
+	prange-&gt;granularity = svms-&gt;attr_gobm;
 	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
-					 &amp;prange-&gt;prefetch_loc,
-					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
+				&amp;prange-&gt;prefetch_loc, &amp;prange-&gt;flags);
 
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);
 
@@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 
 	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
+	/* Determine the starting and ending page of prange */</pre>
    </blockquote>
    this comment is not helpful.<br>
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	start_limit = max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 8));
+		      (unsigned long)ALIGN_DOWN(addr, 1 &lt;&lt; p-&gt;svms.attr_gobm));</pre>
    </blockquote>
    1UL &lt;&lt; p-&gt;svms.attr_gobm
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	end_limit = min(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 8));
+		    (unsigned long)ALIGN(addr + 1, 1 &lt;&lt; p-&gt;svms.attr_gobm));</pre>
    </blockquote>
    <p>1UL &lt;&lt; p-&gt;svms.attr_gobm</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240826193420.126272-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
 			bitmap_set(svms-&gt;bitmap_supported, i, 1);
 
+	/* Bind granularity of buffer migration, either
+	 * the default size or one specified by the user
+	 */
+	svms-&gt;attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
+	pr_debug(&quot;Granularity Of Buffer Migration: %d\n&quot;, svms-&gt;attr_gobm);
+
 	return 0;
 }
 
@@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	if (!node) {
 		pr_debug(&quot;range attrs not found return default values\n&quot;);
-		svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,
-						 &amp;granularity, &amp;flags_and);
+		granularity = svms-&gt;attr_gobm;
+		svm_range_set_default_attributes(&amp;location,
+					&amp;prefetch_loc, &amp;flags_and);
 		flags_or = flags_and;
 		if (p-&gt;xnack_enabled)
 			bitmap_copy(bitmap_access, svms-&gt;bitmap_supported,
</pre>
    </blockquote>
  </body>
</html>
