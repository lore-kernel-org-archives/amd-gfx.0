Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB46C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 20:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A810710ED8A;
	Fri, 19 Apr 2024 20:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXMYVfoq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE49110ED8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 20:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSpcQUlB+VaR1wHlwqIEDzUWcHyjiqqvMjmvu6pcvQNtg6II16p8cKF2a0tuV++FLRKmzqdx9rG6cJetuRqvEza8DvgCveUwmZE+O5jWIg/LH7/hTqzcNqhSrlAnsDEEG44PajbtA/Ef4MIpH4NOotrXxQtaVqoajgCuuoanNlm69pG1MlNNqyUSjuXv19NjFzoGuAJWJIVD0v5NrjBn2rTpSxKZSralN64Ay/555zBMc3SRb4SHl1Ha80g7SYO+Zrx1/kkh2zdv/sjeMpkCmqV5sRN+XooD4aIQkZ+35mduV9c9cCzQeE8KepGJUAoCNODeUiFYx826yVVegmqugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wJbvF0/lT/nqXzYf0WmL3LyuJAgNvUmpnXjl8ugQ6k=;
 b=URkDw7ouEHdpeanoTSvehh0Ed1mgMZbiHTEOhbDwfVLf4pEnU5F0aUVhJaxriPtHnqtjHfLah6/YUtrZ1EnPPLCPeXrJ2bFXRqiEV2IpFuDxvVaSSXrPpZv1rAfmUBKURY1rv5ggOmoOjYL7tPhj2fqfRfJDl9H4pyT5VM5+OAXWkGXWrxXyj/19wnIW445vA6T8tkSjA0/2rhnVbORCQ2Zl6fPD9O8C8t+oeWQQ4PTUSQrf6iXXCNnX2yM7zaKOWJL6Ym3U4qkmxSD+8Y1KthyCb5EGEcAa8m/5KAYG0KJMFzzggd2DLBH0JkPtRAhQryIbPFnxMdzPmaFNnaJhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wJbvF0/lT/nqXzYf0WmL3LyuJAgNvUmpnXjl8ugQ6k=;
 b=SXMYVfoqooyxBxmk9SC9w7uFJN/uCnsDvEaMsm6GdYb5Wep7sQXx/em2ECqPzrBPTmmW+qPVaDzmy6/Way/oBnx0hUStEPUYhyp9yeczyH/8Tq1r+/6fZAk8HEf6FmxBmGcFd3Oq+dw/KIVfLsMXu2mtwVXSM16h+/QohmRKcII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 20:53:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 20:53:24 +0000
Message-ID: <c5679626-5f7f-fba3-6483-06da4a961f50@amd.com>
Date: Fri, 19 Apr 2024 16:53:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix rescheduling of restore worker
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Yunxiang.Li@amd.com
References: <20240419190043.3069852-1-felix.kuehling@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240419190043.3069852-1-felix.kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9149ff64-8f85-49c3-f1f6-08dc60b2c113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHJlclV0bzVDVGk4MXhIbjJ6enZRT1piUTB2eHY1dWd1dk4xUkdnSGV2N2V2?=
 =?utf-8?B?OVFpMm51UmpVNmZqODhWU1JTNDZEQWU4bllQN1JxaC94QnYvTGxiczlIZlJx?=
 =?utf-8?B?emxjRmU4QlR3YmdDRDE3L2twVXM1a2E3V2ZJVGN4OEZEWWhzV2hqNHlERktJ?=
 =?utf-8?B?U21wQnZMLzMyY2VHV21UaWhGamFVQTRvbkcxUjE3eTE0bTNCeEt6TCsxOVR2?=
 =?utf-8?B?cTVGQ0w3d21xYmpURkZwaFVITHpFVGhIS0RndXNGSGNpMmdQbUY3SGNzVC8w?=
 =?utf-8?B?VWVCeEc1eG9xYmw4R1FHVzdoTzlqcFBhS3ZDMVY0SmJNTlE1TGZOWjREc3dt?=
 =?utf-8?B?NG9Ja1dzc3BYenZnSXB5NjVvWldvaDluMEhYZi9NTThGcjN6MWpoYnRIY0dw?=
 =?utf-8?B?Uy9IbHpqVHhjTldpNWNDa0VhMVhBOEZNWGlaVDVWT1QvYVlzK3hnRkRJYWt0?=
 =?utf-8?B?OUdpcW9vOUNRb2JnREUxTStUdXVtNDJOWGpJL0NjU2NyZE0vdzk2V0xQaERW?=
 =?utf-8?B?ZldkYnlmc2phMWtSRUZnMDZUcm8yOUJzMC9ZNUlMWG53dWtQbk1yMk9vSE4w?=
 =?utf-8?B?Y2xleDFLZk90RXpoZ2NkNW1VRXNFaHNrNGVPWWVyQityTlNLNndTUWVndzlx?=
 =?utf-8?B?NHJSTmFGVlQxSFRwcWkrR0NjcXVvL1pUbTlidGJPeE4xcnV2cHVUTWlna0or?=
 =?utf-8?B?bTExNnVEakt3SWl4UkkrTkNmM2pTdDg4SlpqeHhzNFNiU1BaWkM5ZVMwTnVN?=
 =?utf-8?B?YmJrQkxQSW9XTnZ4RTFjc3YyZTAwb2xNOUR5RG9YUHJBYUV1V0k5N3lWSWdH?=
 =?utf-8?B?bWFjUjJsck5QOVlFaXZPTzZrN0J0b0F2a0tlV1FVTFJjdWU0OFBBZmJpcGhU?=
 =?utf-8?B?WERBaTRLSi9DcDdySXF6ZWpReEpuVmdGU2x4VEJZY0JLbk9oMWo5QVV4TS9x?=
 =?utf-8?B?aUI1MjRIYjRXRnp1UmlMU1BLMmM3cjZRZzRlSDYrOFNWd0duU2E1eTh3N04r?=
 =?utf-8?B?UlFXZUM0SFg2ajh6V2hmQWViaHFhR0poS0hLa0RpbUJlUys4UXJQa2ZmeFpC?=
 =?utf-8?B?TExrOGRSTUROaCtMTmxJREptcU8wdUNmV3FUN3BsYTd0MFVZeXJmdEs5blgz?=
 =?utf-8?B?enBTeEVJam96dXdYNTNzcDR3RVJKNzdkTlpSSEw0akVCc0REUDlieUE0eUJa?=
 =?utf-8?B?RHVVYVpNMzhiaDZNUHgxdnBIN3BIbHlzZnJXa0VnMFg1cVZmdFREd0NqNGUv?=
 =?utf-8?B?ZSt5N2tob1R4MmgyN3RpQ2E3SEdGVG5jRm1UdWVRczhTQVBnZ2lhWUxQM2dl?=
 =?utf-8?B?SGlPQVZwQ2Q0REhpZFlza2lwOVpWZ3JxanlnN3k1aUdsQXJYVHlsejVqd2lF?=
 =?utf-8?B?SzVuMTNseHFCanREdXpVbWJlRHBiMTlQcXNRNFVlNlFNNlpqcEFzWmFPZ3Fj?=
 =?utf-8?B?KzErTC9VSnFsZ2tzYVg5Vjl6blNiWVRKM2Z2aW54NW9vK1Y3U2pQd2dIaWp0?=
 =?utf-8?B?OCs1MFZZejRENkFrWW85cE94d0Z4T3hkdE9KZEZSeE1kSG5MM1ZxdnhzZjhy?=
 =?utf-8?B?RGF5Q1RTaWRING5tU2Qya0tkTldGWEl5MkovQW52Qno3TzBVbGVXUkVtb2JU?=
 =?utf-8?B?ZmFnMW5XZ3Y4RWVqWlVjSk9tOU8wdmpFTXJHMExSME5PdlJmSEkwWDFpMk9t?=
 =?utf-8?B?Q0Q5Q2dxZHlyb1ZmNmFPSlZpWjE5RFBsMURuZUtwRVM5SHhJbDdIdGVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0wyZnlnSjZQeTBYRnBFbnpzVnBmbGdYeDFUM0ZiR2R2MGQ1aGZkR1hoaEtZ?=
 =?utf-8?B?TmxtQjZrdUdkeTF5b2RHeFVkRTFyd1gxREZUQWFxRG1zdXN1ZGJOYTdJaGlS?=
 =?utf-8?B?bkVQamV5Z3hHUmVFMjlwTjZKUGo3YS9wRHFHdTdlL0FSRXE0ZVh2WUtWTTlq?=
 =?utf-8?B?TnB5U3lSZlpWaUtKYTlxSENUbGdDVUdTdGw0U1ZCZGJjZW4yTnBqMU9JeGtC?=
 =?utf-8?B?ekVqZTY0RmtsZUZjWU9KUWcrVGxGMDRGdEI3RWxmREppMk9MZmROSlJaZWpr?=
 =?utf-8?B?dENkaFBaVzhic0taWG1HQ05rdTh5YlNvcndrRlRHQkJ1a0lVS0ljS1A1QU0x?=
 =?utf-8?B?QzA4WklTZXZGUFNQNjUzNjRIWUIzMHlKTW1XMUdkK3ZZMUQ2cXBDeGpZMDhN?=
 =?utf-8?B?SG82SHhZd1I1bGNNay9LSDlKbkFSSXJKUWg4QjNPMHJOOEUyc3RVNDdtRVJy?=
 =?utf-8?B?Y2pwbHRJQ1BlUkI1OGlmSk4yNkZKVmhycFVaUkE5aURkSStJc0JPNDZ6bUJD?=
 =?utf-8?B?NFhJSFQzbnZxZUNUUmZYQ2hNNXRpWW0wNWp3cXNwMjUrTC9IUFNialN4aTUx?=
 =?utf-8?B?alVFY0tGNTBsWFd4VEQ5ajNFd0huTzJzcjNNRHpUdCtEV2c1UnJtdTVnSW5u?=
 =?utf-8?B?blRKUm5Sdk5XcjdKdGM0d1ZKem1HMG1oWjdWbnZKMTJzc1VXc0FlNzZPOU5F?=
 =?utf-8?B?R1N3TXVNNDRQUm4yTkZuOTl5eTY0ZDQxODVqU3JoR1FLcEY1YjlON2YraS8v?=
 =?utf-8?B?UzZ6VVFlYXdsaHU5LzRsN2t5YlJoOHE4ZFlTNVEvalQwcm0wMmtsNDZ3dk1i?=
 =?utf-8?B?WGh5S2x2N2xFdzNod0V5Sm1JTTdadERSYyt2S1lLdXdjdS9nb1kvMlNjRUFj?=
 =?utf-8?B?bmd0TXlDUlQ1ZVpCbGM4SUovYkNzMHJZSCtkcjE4UmNoOEVoR1R0YWUrakxK?=
 =?utf-8?B?K2NjT0k1WWx1Ykh6Q0IrZWZQUUJrTW9PN01mVWx3WURLK0dGSDU1bTIza1Ro?=
 =?utf-8?B?NlNWMkc2QXoxd2luZTl2TCtkN3crdXRVUUZsTFJ5a0wzWHFmUFROdFRLcmhj?=
 =?utf-8?B?cVNsTjhldEFRSXNVT1lCd28wbnJSaG5yaVJJdGFGUjFmcytDNnVPUCtnWDg0?=
 =?utf-8?B?YWRSUzR2bEorUU43VW9WU0pGSm0xR2twWWtnMVkrdTNydWErQlppQ1BkT25m?=
 =?utf-8?B?L0Z2VFpjMitQQUgvZUd1L0FEd295ejlQeU9GOVRXbXZUTnFyRGF2YnBUNWNS?=
 =?utf-8?B?UmpRWEJkQ2Y0Smo1bWtmRFgwYjl6cUFmQVNuNE9pMkdyUlYvNEZBTytaMnh3?=
 =?utf-8?B?cGM1MHFSRk1vbzRtTkxVZkdHb25sL0JBYWxaQlBTZ3ZXNUZJSmx6MXFNK1dm?=
 =?utf-8?B?SWdneEpVRXpXTVZpa1k5Vi8weEs1Ti9HSGQxcG5jNDlTNGxWWTZTa3lJZHZV?=
 =?utf-8?B?cXhwMW5kOEVCTUdGenVwMktzR2NmRmR6S1ArTmprM0ZDdHJ4RWQ3bjBOeVlJ?=
 =?utf-8?B?NWR4TFdqbkZ0OXBEVWt0cVZDNmcvd2NBWGswZUdnbnZ4N3ZrZENmODRCUE5K?=
 =?utf-8?B?K2hpTWJKeGhPMUo5SDc1WFpDOXR2dE0vaXlhZ1ZYamc3bFpNTXZneFVTb0RC?=
 =?utf-8?B?bmhGcTNFUVhZck9Md3hEbUZsNlg5Tlg2SHp0UldYNHF1MGVELzNNYmRtSFZu?=
 =?utf-8?B?MEtZQ2dpSzFUTXZIejJ6TVJwNWFGWDFhUXhFaDlxd0ozRG5GejV6Tk9wZzJw?=
 =?utf-8?B?cHJtRDdHR0dMSEpKcmR6YVR0N3gxSHpvNlgxTldPSGNLM3hXWjVIdzNYblZG?=
 =?utf-8?B?MEpLT2FmMjB3K3E2ZWVudlN4Q2J5QVBqUk1aaDR1c1JnV3ZYelVKYU9uWEJi?=
 =?utf-8?B?d2luUWhDa3VrTDZodGkvdzRlQVpVbDk1WjF3bjc0SGlpQWRpVUQvZXVGZS9E?=
 =?utf-8?B?OUJBdDd3N21vSjFGQks1YmU4SUhwb1lkYkh6WGFOQTR1eHFndGFRRHQ3Zmd0?=
 =?utf-8?B?eG5PWDd2R3JBdTBGeUdMNmtwQ1gwM1BSWXhWYmdLM3dwMkZ2Slc5WHZETGIr?=
 =?utf-8?B?dC9QNDlwQmtaMHBuVUdGUldyR2hSTEZEM2tISHZmbHBzaCs4VDhOV282a3Y5?=
 =?utf-8?Q?iK3g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9149ff64-8f85-49c3-f1f6-08dc60b2c113
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 20:53:24.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRabbmNuMdF1YX2qlUziiP+6C33fBQXXiRQv60INi/egiRrwX2gSNgTq4neO9vkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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
    <div class="moz-cite-prefix">On 2024-04-19 15:00, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240419190043.3069852-1-felix.kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">Handle the case that the restore worker was already scheduled by another
eviction while the restore was in progress.

Fixes: 9a1c1339abf9 (&quot;drm/amdkfd: Run restore_workers on freezable WQs&quot;)
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20240419190043.3069852-1-felix.kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index aafdf064651f..58c1fe542193 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2012,9 +2012,9 @@ static void restore_process_worker(struct work_struct *work)
 	if (ret) {
 		pr_debug(&quot;Failed to restore BOs of pasid 0x%x, retry after %d ms\n&quot;,
 			 p-&gt;pasid, PROCESS_BACK_OFF_TIME_MS);
-		ret = queue_delayed_work(kfd_restore_wq, &amp;p-&gt;restore_work,
-				msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
-		WARN(!ret, &quot;reschedule restore work failed\n&quot;);
+		if (mod_delayed_work(kfd_restore_wq, &amp;p-&gt;restore_work,
+				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
+			kfd_process_restore_queues(p);
 	}
 }
 
</pre>
    </blockquote>
  </body>
</html>
