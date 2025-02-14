Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD77EC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 11:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D99910EC5D;
	Fri, 14 Feb 2025 11:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMUCQ5WI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A8C10EC5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 11:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SerakA4IrzQYasCTvwS9xJgTAieQOcZiR3jvEYmUFKZDvehrc0sRDYKWiJ9rprUZhNDSjz1yYfTEYOY+A2QTX0X5SG1xL48NYpjcV99h5J6+vEZtPRF47x46z4IvBpcgv6V0QdJhPnVdL+sd+q3Ffz2kcdB3GmW/eQKcDo55ZdLS6VmGS6CTdpLuQpcQ9NgFFgAjtYZUnUiep4wDQSRmsdgSg4rxIXOPKJeKVq7d41Twu/QiIhLBkIAmH/IpNyY+3aRHoYA3TdU2zOpB5Bnu+eHzCkAxX+rcUVq4/gR3TakHWAqrpBaygsN9ZBwLYQu/KowBmqXWxf5vqXPkCEx7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygq0TPSBwb3r/zyR1SNqNR0zJ08fmLewCO6x1V0Kvkc=;
 b=w3mK2TNOD4gFh3WYvw6qKqvPut++hnQOYcJiRdkzq1lIV9gew1D4axXlYYnlL9pP6ZQqfjG+1C9z7I6iqEtHL1V9EjEkKLGrW0KKVYp9Xl3VRn0ijTCsDa93X8sYcXdvBvwZq5p6t6cQq7Ilbn1JxqSROL0ShqKfGMvGNO5jGmwuBp3EjkWoHpGQP5aicyErh4u4kBt3+bvqg4gz8M9LlFCKdqjQ9hTNiY+sBNB3ZyAateJgfu5dND6Vd8iAs0tH3xTszu2Fb/QLX/el0A5IX7XfuXDDGD5aVikN0Bp+6MPRHj2/DEn4hR7f2LVu+F9wuqTnmEBbA3U1WX85Kql9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygq0TPSBwb3r/zyR1SNqNR0zJ08fmLewCO6x1V0Kvkc=;
 b=QMUCQ5WIMhW1PrO+4Ya6YHSzJl7hcB4+DB8wV57RusLY7rUfRIhyioA4dNQDkQK7F50f1ccAXsHiMWDZUQVc6CFH955N358rygzIooPYHaIWyvi9NXIf5da6ARx2RhwC+mWPxpYSzq9NIQheplKVnSAQGSnmRx8wiCBZmN8YCwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 11:42:25 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 11:42:25 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
Cc: hawking.zhang@amd.com, lijo.lazar@amd.com
References: <20250214100718.2663073-1-le.ma@amd.com>
 <0e49dc7a-d932-403c-88b5-9b16ab9477d0@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <13d5afc4-4f97-8fe7-0c05-647bfb768abc@amd.com>
Date: Fri, 14 Feb 2025 17:12:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <0e49dc7a-d932-403c-88b5-9b16ab9477d0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::9) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: a06f9e12-bf6e-4472-2bfe-08dd4ceca6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TndnNkxSaEt1MUhDazZOK1I1TEpvUVhaWjMwNk81L3hORlpnVzdtUHdUVXVL?=
 =?utf-8?B?MS9ydWpJNHpVVWpwN1FNZ3dYbFNLVmZZNzh5S0JQemN6cmF6RlB6eGdKOFc0?=
 =?utf-8?B?Y2d5ZVFnbGRCZUxxdVY0QmJ5Z2NEeHRZbEVpdjBUV3Z3b3dIR25JVDJWNHhv?=
 =?utf-8?B?QWFMaVNRS2hHcXpLbEl2b1oyYUlBSDJ5UEI1NFQ4SVVEQlFBdkMrWkh4OTE2?=
 =?utf-8?B?YTZXQS9zWGV0Sm1wQ1ZDVUVLT1RqYjNJd1ltV0lJQTNnU3NpNThYTmRRb2lT?=
 =?utf-8?B?R0xkRTQ1eEJGNnRxdlFyYTNLOUZaKytvMmJja1NlYkFqb0Z5UDNUeklicmdJ?=
 =?utf-8?B?V0dkaXdBUG1OaUlnZEFPWEpndmNHYWo3QldhUEdxall2OHlqbGVBcTR1QXRk?=
 =?utf-8?B?MGRaTGpCTGhwQ0l6U0FqekdrSXJwZFN0K2JMQWZLZjA2anBaU2M5WmlTK0lq?=
 =?utf-8?B?RnFDQldYOGJIaU9mN0V5d2JBTFhxK0VWV21HNi83YVpZQkkycStqMERSbGJm?=
 =?utf-8?B?eHZ6R2NLMmx0bU5KUFVZKzVFQTJyakV0bkhZSkhlcHlraEczS09ZWFU4eGFa?=
 =?utf-8?B?Q2o1dmh0Z09xZDFMSFJRMElBenZVTVpvUjl6a3liaFV3Z2hJVnlBTEw1ZC96?=
 =?utf-8?B?a3RxanMyZ0x2WVQzUlhBNVlQdlpoc2MyZTNsdjVDZTlZUm9vakVMTWRLNHNN?=
 =?utf-8?B?M3h0bE9MSE1acCtYNVE2RXMwenVsaGlmSTdoOHFVV3lIYStKN2dITDJ3ZEVh?=
 =?utf-8?B?ZW9wNmwxZzlJS2hRNVJQVHYwUi9jd1ZpVmlvbVhMaXV4MGduc3N0MzdBdmxj?=
 =?utf-8?B?L1pFaVZQZGlWMVVWWW9ZTFRBZkIwbVBCTm0xKzJRVDRjSFF4SHpHb1ErQkNs?=
 =?utf-8?B?b2U4NjF2QlJqSldCZHFTQ0tEUk9Cb3JURkFBTHRhN3dvRmpVYmhnd0QvVTh6?=
 =?utf-8?B?Ylk0cnpkZnN5U2tXTEpzSnZLTWJ5c3I4NmxqVjlqSzhXcTZnYy9ta2pvVC83?=
 =?utf-8?B?VDZVUnpCOGV4SlNiV1hwRmQrR1A5SFdQWENiTmd5MjF4UDFFcUU3MTBrMFhC?=
 =?utf-8?B?NjJFSERYTzEzVGpESE1MS1RjNWttc2I0bVRSQVNDMU92bEVYWGdZRkt6azl3?=
 =?utf-8?B?cENuQ1UvaTJveElISzZEOTRDc1lkT0sycFNEYlhkK09sTlhrY3NEVkNWZ3JK?=
 =?utf-8?B?Q1B5WGtuZ0hUSzF5NzFqRkFrd0VwaGJkT2ZpQzJZbTBVamV5bkwvUHZla1J0?=
 =?utf-8?B?aVQ4amR5UndVanVZZ3BYTTBTeEFOdGIxcGlmVk9WMnhrcVpVWTJzakQ5NnJY?=
 =?utf-8?B?UWQyYTBXYWhSYjBHMlJQNGlzN2p6aE5JUDJaTVdOaEtxcWk4c0htRnNJMGth?=
 =?utf-8?B?Z3BGMVh5ei9ZY0wxWmFzRk9vcit5ZkdzNGN5WVIxL2duUlBLd2dzbG9tSTU3?=
 =?utf-8?B?QXphNVRGbVo3ek5qK1dWRGpxNm5VaisvSlZ0ZTdFQlpqQ1ZTYlUxZTFML0w4?=
 =?utf-8?B?MmtZMGNWUzR3bTRqbkFFbVBaZmwvL0pZSDdPd0h3b2dFcnJsV29aU0lDWkw2?=
 =?utf-8?B?ZmE0N2tGeXloM2IySFNTdWdma0F3ZzFHZkplK1NRcW5TNUFkMjhNUGJ4Q1RI?=
 =?utf-8?B?WWdJVCtNaC91d25UY2pSOWFSS1cwNHkrUHp1WGJBOEEzOHNlNFF2NDl5N0Vp?=
 =?utf-8?B?MlFwYzhLWllhb09aYjczN3NqVDhJblpwUEpWeUdNWUloUXdHK2hrNVI3aUI2?=
 =?utf-8?B?MHRvWjNHdUUvSEFCbGkyYlBpbytaclNYRDdYRTA4U3hNRzBrbjJEUFBXUHMv?=
 =?utf-8?B?Vnp0ZkhnOUwxeHFNSzVnMStXRXZlN3lvRW5lSFUxTUFCeStBNUtIMG1BMHpt?=
 =?utf-8?Q?Ud+floS7QnAhR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXFPTWhjUHJDb0lPTXFIZzdHL0Q3ZWFZaENWYnY4S2xjL1E3U2dHN1E5eXJV?=
 =?utf-8?B?cVVGUzBFdEphdDQ4a1pLMDBZWWE4RHhNQ0hhaXZZVWhIM3NPa0tEUnJ2bjhN?=
 =?utf-8?B?UXpBK29KQ1d4eWlXMTE0aG1yZWUySjNhamJyQ2ZlalhSbkdKa0dUaWlnYVJs?=
 =?utf-8?B?UWZUR24wYzkrTnh1Tk9DaElpdW1BNzVMdkRVZU85RzYzUVpUUkM1R3Z6VlIv?=
 =?utf-8?B?QmFoc1JxM0h5bXdrOFkwbmlHcU0vOGZBZmI3TkxwY3VUbGxJczhOYk9PeExw?=
 =?utf-8?B?MURuejJBZHRDNGxzZjFMaHZnc0wzeUNBbXY1YjZCa2RSZWF2Sm5oVUVDOXFk?=
 =?utf-8?B?aDNUVjYxTVNpVFNsaW1aVkkyeUxUa25wTEdqbFBQRmsxbzA1UjAvVS9HTElk?=
 =?utf-8?B?dTBRTjNheVhSbUFSSGJ5a3ZneloyNnRvOFI0NTJ1RXRZclM1NXdUL2NneVcr?=
 =?utf-8?B?eGtjQS9zOG5EdndzWlhjM3l5SHgydHJ2aXZNYjE1S1FUVVZZZW0vSkVUS0JK?=
 =?utf-8?B?THV3YkYxWExJM1hjS1pBbkE4WnlmY2NkOHhrRTQ2UzIvVkozaVJjdzlNMElt?=
 =?utf-8?B?WGtPaXQwNG5nMFpRblR0Q0JiOVVxaGIwc2d4NlAxcUJQaU5YaHlPVG9sY3dH?=
 =?utf-8?B?ZFdSbENDTTcyekk5dGtvYWZvOVloaUUrUys2TnFpcDExU3NNUnhaZWhkZENm?=
 =?utf-8?B?a3gvNEVpTFFVSXNiWVhlanRRMVVoUVBXejh6MUd0SkNMbnkxakFJdE13YitF?=
 =?utf-8?B?MnpHTDJNTC9GQVNhU2RiQVlpcGt6Q2h5ZjlndVVncFZuM08wRUVRSVR0Q0kx?=
 =?utf-8?B?TkN2cTQ1SnFOM25JK3RNaURJTUo5N0hzT0VpQ0lsaDZ2d2U1RE84cXdGQXhr?=
 =?utf-8?B?bjBWMUNXOEJlbWVmYjBDMU5wTEUzZExsVTJRQW55MzRvcDR2MUJCRW5qcTJz?=
 =?utf-8?B?SjZ1QVlFeVJZdFZ0Qy9mL3NpcklxSGxlc09CekN2MWFtN29jUDJUUGsyQlpk?=
 =?utf-8?B?Q3JuUmphdmNZS1NNNDdhSU56eUVTSEt2ek54MTBuUlNrYVJmNHdYeFpockhR?=
 =?utf-8?B?UUc3YUQxbU16QXFxTDV0Q2pRZEQ2Z1h4MjNzQXVGaTZEbTRkZWN2M1QvYk1z?=
 =?utf-8?B?QnFlRjc2c2Uwc0lFb05XVFhoeWNMNTZ3Skk1Rk1XUTc0WjJHaHpIenJqQStJ?=
 =?utf-8?B?MHNRSWpNY0pVQjMrZS9Zai9sLzJvdmdpQUxXTU85emJzS0FWRFJQVnM1c2JN?=
 =?utf-8?B?NlNVUm54S2ttTm5wbks4UEJpSGJKN2FxS0JUdXhRR3g2cEpJSGV5WG1JTDNj?=
 =?utf-8?B?THZuSkFrSE15VEhwK2VQb0xSbmIvRCtNNFRuck1xQzJkL053eVZYYjZ2RTV0?=
 =?utf-8?B?dnpaUDduUk42Y3pya1R6WW91Mk5KMndhOFl6Q2FMZHBsYjIwQllVNHE4U1dI?=
 =?utf-8?B?SUlNVU11L2ovVTZMcjU2S0NEN2hKblJGbXZKZ0hURlpyK3d4R1lIVGZQbzNp?=
 =?utf-8?B?eWN1MFN6Wnp1Y3FhUEhGK0VCa2VITU9ON3l2NzRBb3U0STBSRGRiN29TRmRU?=
 =?utf-8?B?NEx1OW9teWZ2Y3l4UnkwUEFlZkdLMXQyYW9jQk1BS2swRUhwdzZRUEFSY0ZW?=
 =?utf-8?B?Q1NSTDd0WGxleWEvQnN1ZFl5OHZuMlYwRHpXVmNSSDNPck5oM29hSWJHNXNF?=
 =?utf-8?B?dmJGZEJEcFR3SnJxV3RPMHNtc0wwSmNTZzI2Mlg4bFBJMHVUS0ZtdmhRYTd1?=
 =?utf-8?B?MldLTU1IVUJsNzVHbWM1REVZZkdVRXBXbW9LOEFMdGYvSHhtTVYvc0ZMU0dH?=
 =?utf-8?B?UDlaT3FCUFo3QmFwN2FxdElQZ0FDL2hpaVdZamFuR1h1VE5tY1h5dmdoUDg2?=
 =?utf-8?B?OWFvNk5ab2dDQW1XamN1Q3lDQkgwKzU4a3pDU21odEk1SXhyN25USzRscENU?=
 =?utf-8?B?Nk9YdGhCQ3liclJzWXVSTjg4QkkwNUhOWk9ITlFpSmNhSmw1eUdRWm43b3ZV?=
 =?utf-8?B?eDFSRnB4MEVURE9HOHFQY0V2TWNZKzV4RzVRaHN6YUplVnRUeXBHYmVRZXU0?=
 =?utf-8?B?cW1NUzZoRWMwVnUzU3p1Vll4YVRpNHRqWnVKcjVvUDJjOUIvSnZsajdzRG5l?=
 =?utf-8?Q?U8WGuKk2z4lqvPw/rE3V4zpxu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06f9e12-bf6e-4472-2bfe-08dd4ceca6b2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:42:25.1194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6D1M3BC4/Ct1ArokLXBEHQdjF8crbgeH+dfe24JMrooHRd2TzrYvKuNAsnC7F1qRF6dp+5QSL2k8baWgVXdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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


On 2/14/2025 4:08 PM, Christian König wrote:
> Adding Arvind, please make sure to keep him in the loop.
>
> Am 14.02.25 um 11:07 schrieb Le Ma:
>> On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
>> will show up explicitly during driver unloading if created bo without
>> drm_timeline object before.
>>
>>      BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>>      -----------------------------------------------------------------------------
>>      Call Trace:
>>      <TASK>
>>      dump_stack_lvl+0x4c/0x70
>>      dump_stack+0x14/0x20
>>      slab_err+0xb0/0xf0
>>      ? srso_alias_return_thunk+0x5/0xfbef5
>>      ? flush_work+0x12/0x20
>>      ? srso_alias_return_thunk+0x5/0xfbef5
>>      __kmem_cache_shutdown+0x163/0x2e0
>>      kmem_cache_destroy+0x61/0x170
>>      drm_sched_fence_slab_fini+0x19/0x900
>>
>> Thus call dma_fence_put properly to avoid the memleak.
>>
>> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>>
>> Signed-off-by: Le Ma <le.ma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 8b67aae6c2fe..00f1f34705c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -759,7 +759,8 @@ static struct dma_fence *
>>   amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>   			struct amdgpu_vm *vm,
>>   			struct amdgpu_bo_va *bo_va,
>> -			uint32_t operation)
>> +			uint32_t operation,
>> +			uint32_t syncobj_handle)
>>   {
>>   	struct dma_fence *fence = dma_fence_get_stub();
>>   	int r;
>> @@ -771,6 +772,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>   	if (r)
>>   		goto error;
>>   
>> +	if (!syncobj_handle)
>> +		dma_fence_put(fence);
>> +
> Having that check inside amdgpu_gem_update_bo_mapping() was actually correct. Here it doesn't make much sense.

Agreed,

Regards,
~Arvind

>
>>   	if (operation == AMDGPU_VA_OP_MAP ||
>>   	    operation == AMDGPU_VA_OP_REPLACE) {
>>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>> @@ -965,7 +969,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   						    &timeline_chain);
> Right before this here is a call to amdgpu_gem_update_timeline_node() which is incorrectly placed.
>
> That needs to come much earlier, above the switch (args->operation)....
>
> Regards,
> Christian.
>
>>   
>>   		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>> -						args->operation);
>> +						args->operation,
>> +						args->vm_timeline_syncobj_out);
>>   
>>   		if (!r)
>>   			amdgpu_gem_update_bo_mapping(filp, bo_va,
