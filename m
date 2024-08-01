Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9F7C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 04:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E1D10E04D;
	Thu,  1 Aug 2024 04:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JxkKfW6V";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E400410E04D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 04:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODvA6cN+LpO38N1sFbPTp71KSWYz3iu9iOkT+d7BY/am3PawkOoQgvXAq9HrmP8JRsAaPO1kgFmu5FjImL1jfLsoX0NPwBQaWX+Bxn4Ya9E4eTva/n5FltfoPvEmfLa47NF3ETuPylflq1RTbOsfVAZDYRV9ZxL75mgn1akHC5Y/BhwPQkKUpUEDHw524TvFxGPwL1ezNnyZsJmVYlwpQzDzzCPExrPiEN8ygn7wBUKlWIGCVYa6na1kA3Z+r6v2hF+hqQIz6CjTvOjgTKIZpbnnDmzLahqdVQGbWg8IpS7otizQVk/oDi3WJLGJ3uSDsqwUD1OogCKds/R0rGtrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYmKL9OCKLEgcHvgRw1ZzSLw8gMJMx1DAWeqh/1o2xo=;
 b=Ie6GsJpwzrBlA2kkYMw6YM19Ehgwgq5CeKE3ftCi9L5sspWfz+eGuaooaqhFf8GO4e2akhfWhuJf/vUh4VMnegiK4BdfGlq7wGm/LkNZb9nPAwGXJwBTmdc97sr4dSKLz9rncwDfMq79SO9obyZlrMJBPA5TDTKjPzdHZo/2lgbqPDN55UmA0mkDhu2DVciZVcoXDr0GTDFCoLHo5KFbP6CF80VHdwc7WXBy53UT6B1+LCETIaLUq/k9v9StUpobxQ/i+cBi+dEKgFMXc3FabHItztUvt2vhhg8WpUJ42srhVmXCI0AwBu7yQzmDMdjW8l5Tj3tydXzykiy97nOyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYmKL9OCKLEgcHvgRw1ZzSLw8gMJMx1DAWeqh/1o2xo=;
 b=JxkKfW6Vg/W9XT1hm6tCe8B3sB5SXHy8NV6K1tXxZznSb5Wj3N0LFjv9mmzop3skT8AGXnj07BAnOceynnLHUf6ECojHEi4829NVlFGayRBRVIgZCYEf67AfVBv1sb9eM0RyY2NO7AwmkaqzAGAiaWcxh1j0XpTbfOC0W0418kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 04:28:08 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 04:28:07 +0000
Message-ID: <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
Date: Thu, 1 Aug 2024 09:57:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b95859-c899-4808-be49-08dcb1e257d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0F3ZVdVb0drMUxYRTlPUXJabzlsUGNTdUhwcTNHajJBcURSWTVqeVV2dlZ4?=
 =?utf-8?B?YVpoc21rT2xMQWNuZStUZHRtbDBrRVhQUlBTRU9KODhGb1NoTVp4S1FtN1Rk?=
 =?utf-8?B?RmV1OEZ5NmNmWndTWGgzVHdYS3lJSzE4ekRvUExPMkhaMDRGQTlpVEpKMXM4?=
 =?utf-8?B?OHBpbzlFd3V3Z1M2RlhMRFBxVHp3MFl5Zy83Q0YzRmhRU3U5N2tkNGR1WEw2?=
 =?utf-8?B?ckVTeVJtbVlJdTZZckMvLy9iaGFPMmMvOGRiK0RiZWpSTlQrRGxMSlhQeHJu?=
 =?utf-8?B?UzUxV3A2Wmdpd1dldEpmYk5ET1VxWkNqZzJJL2NISldHVDBhaVZzcDlXTFdB?=
 =?utf-8?B?ZlY2b0lqQTRveWsxZ0xVeEcrWlpBNnBYWWpYNlQ2T0pmZThjZEw1UlhmSm1l?=
 =?utf-8?B?VzdUUGtuM3pYWkJxWmZjZzY5am9wVmRoMU9aRnh6TjBmRU5yZC9TbCtBL3o2?=
 =?utf-8?B?dVU0VWJKMmcxYXp2eU4wYk1xWTNPNDNGWmF1c0IxMFBJZXJLcUZtWGZaZldD?=
 =?utf-8?B?S2d3Mk9TeWtMNWRuSDg0N1FXT0dYVmgzMXhTUE5lcEdRVWY2ZzBjaE1HQWo5?=
 =?utf-8?B?OFhQZmhvRGlpLytVL2JxcnJqS2VzZXRHYlczeW90Z09rT2xGU3IzMmRxd3B2?=
 =?utf-8?B?c1B0RS8rYU9ZUEd6UGgvdjVMNm9pc1RKcnZYeUV6SDlRQ2hyZUZUQnRocEIw?=
 =?utf-8?B?alhralVZSVZPTEQ5bVloWm1QWERrUlFMQVlLUGlZMDJzVWh0NmNhVHFkelpm?=
 =?utf-8?B?amxrSll4ME9BQzdGSnljOWE0VUM3cjZ1cVJaMXIvcTFPZ2d3dTl1NjVYVFN5?=
 =?utf-8?B?YVpIMjBSOXJkVVJkajc0NlFvRWFzU0tsaHU1N2VJbFNFM3RGTENhK0x0VzYv?=
 =?utf-8?B?eVJaT011Q0FiRHk4UlA1dCsxOHJPRk9IanE0THFNSkFqcjFSNTl1eUkzM044?=
 =?utf-8?B?K0E3b1BWY3U0RWc2d01IZjZYUzBnNmEwaFpsY3piZnBVL09mbU44YXRTNkVR?=
 =?utf-8?B?a3RUdmNESVFuUm5CbWFoNG9UZXB2dHM0bWYzY1A5MDdISWZ5L1hEM1pxQTJ1?=
 =?utf-8?B?ZkU1MWtsTUVqTDkvQ0paYXZoNmNtbWV2b2s0Zyt2TlRnUHF3NHZYbnVMalZk?=
 =?utf-8?B?VGVXRzFrUFlBNXNnNzJRY0lxUU15KzZXSmYzS3RaZVVYRVlmRnNaYXIyM1Nn?=
 =?utf-8?B?NEFHUWFXL0Z0RTJycVlxSUhkN1JxdDBZTnQ0MkhEeDV0ZlNCc0pDUWorY2sv?=
 =?utf-8?B?dXJMVit2RlN0OXBoZHdNWVgyWVBjU2QveG56TzFtRU94elJpS3R3cTYwOGgy?=
 =?utf-8?B?VE91ZDFlMHVxWVVPWGdxcGFHUTVEejk4U2FZN0ZoNWhTc1FSNCtZaWVRYlU1?=
 =?utf-8?B?U0NoZE9QWC9MT0t0cVh1THNtQUVaZ29ocFpVUjUzRHFnOU1JSDF6WUtZUlZj?=
 =?utf-8?B?WTJ1VVNoUE04TmJmTFdRY3VzODRIU01NNTIyRG5yRFpqU2RybnN4NEpoVHhi?=
 =?utf-8?B?dURwWld3aTgzNyswajN3dy9Zd0NzcU5KanM2ZVBJMVkwSmdyYjVnVjN1ZnR5?=
 =?utf-8?B?OGxKNDQ4a3lFN0FkZ3N5NVhSSUhnaGhFaGRxbmFhSGdRQ1g5aDRRY3EvWHZq?=
 =?utf-8?B?U2psNXhHK0tMZDZPUFVuc1doaStGTm9sd21INy9YUy9MNFVNa3BZK2tGWm1q?=
 =?utf-8?B?QzNQN1hORnB2Y2tiZEpROEpIeWFSWWFaMzNlNnhwN09MSjR5VEhEdk91amNB?=
 =?utf-8?B?c2RnUyt4d0NCZ2FzdnJVZ0hoTWFOWmlWdS90c1NIZVhHYjJ0WjJqRUhFTHNQ?=
 =?utf-8?B?TXg1cWR2K09qU2NKVWN3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1R6bTBROCt4L21pZEVNbUk4U0hjSzZWN1d3b0VrWHlJL3FITFQ3WWpHVEYr?=
 =?utf-8?B?TWZCK2hBVUthY2JHUmZQQXMxQUpUSWNFVEtaVTV1OVQ1TUNuT3ZmMi9hMDJY?=
 =?utf-8?B?OVZjUVJzZUx6K3YxdXlxNFZqbkN0cFNDcHMyaUNFUW0yUGU3MjVTaWR2ZXd0?=
 =?utf-8?B?RE00UWxXVGJOaXQ2R0tiUm1ZVEk4S0xRNHhVOXZsYnk1V0xTR1BMRkJ3ZVhV?=
 =?utf-8?B?Vm1SaXpSVVh2RU9QVHRCWHVvY2JRT3cvUXdwV0xXcDM4ZTI2N1hmMzgxUWJY?=
 =?utf-8?B?QnplYlEyZFY5S0FYd1RxODNCRmhkbm9vTCtuakJlL2wrUmRjWmdDdzM4VU9t?=
 =?utf-8?B?alZwTlR6eEhTL1V3a0ZtZzNjMVdwUXhCR2FmZ29HMVdkNHlxUWZNY3BsZHZ3?=
 =?utf-8?B?aVpRNlVLWk1kMk9VTGI5cm5VUDFHNi9UWkYyRW9DVTVMdHpXQjVhZUZYMEFr?=
 =?utf-8?B?cVJjSllxR2t2S3lJb2trWnRRV296aW8ycGsyMjlsSEliMkk1ODVhUGtXYzJj?=
 =?utf-8?B?SjcxSVV5SVA1V1hKN2UrVjJpZTNDa2NGSkhGRWlucWlLbFNLaC9pb1FoN3cr?=
 =?utf-8?B?WjJVSXhIRnNVcHRSYnJUb1d6NTdETlUrUFBsWUNWWDgvV2kzTWVIZW9tcVJY?=
 =?utf-8?B?TUlHVlJ3a1l0VmhkNnZkMW9nSkFKZ24ranNVdHVyTm9MNU5aZmNjZDhGWkNx?=
 =?utf-8?B?SElnYzdzRnVUYjhhYWZsSzVSYTdMVXhsQkRKc1VvU1lGQ3BteHZ4ZTcxM0ta?=
 =?utf-8?B?endTSnMwWjE2V2o1aHlWQlFtQ1puREhpcklNZnBoaUlvOXhaMjR1cnpPbklM?=
 =?utf-8?B?cDhlVnFtUUJ0b0k2cU9Bc0dPb0IrQ2RaVTFkL01HY2UwWStWZmx3YVM5dnhH?=
 =?utf-8?B?ZWxySTQwZCtEYk5ZOU5hOERvd3k1eWhpMVBVaGVaRmIrSGgvSHExWW9mN05P?=
 =?utf-8?B?MDlJVUh3RHR2Nlk3aGx2Kyt2NlF3aFMxVmppRmlJVnZGYUFOTWFoMVdjT01O?=
 =?utf-8?B?a3kzZGdqbnNib3ZZWGFXWnQ5KzFiVDZZdEFqbnFkWmE1K1BjWmU1NHVrS1Vx?=
 =?utf-8?B?cDUrYlVoamM3ZFhFMDNCYzA1NHUvdFVQKzJUUUZtb3QrbFN5L2hkUnAwMGg3?=
 =?utf-8?B?WkF6VUFTbG4rZEhJRGxCdXdHQy9IMVEvd0ZFRS9OdTdldlA5UW1mU3hGVnlY?=
 =?utf-8?B?bzR5NXp5Wkd2S1ZUeXI5ejRBd0pDcGFmU3Z5VmdueXY3U0pWOUZZakFrWnhK?=
 =?utf-8?B?bVJmV0tSMHBKVFJyMjE5WW1PZkt1MUVEbndkVk1MakxYZGREalBNWlNRRENV?=
 =?utf-8?B?SnNCbmQzMllFZ0JlUE9UaEY2Mk5WZksvRGVxL0JMcDdna0ZRK01MT2JEamlZ?=
 =?utf-8?B?RmRDZUsvUkhaUDZETnFjSHFWQ3JwSUZudExLSWwrbmRjd0d1MHZSUkNmREtG?=
 =?utf-8?B?ZjhLYXNOaVJZNHZGSjBWdlB1VytiYy9tUU5lRGxsMFdpd0czM3Z4L1N5ZVJX?=
 =?utf-8?B?OFM0ZGJBTUVDTnl3NVRQZXMvSmdlRW9zQ05lQXRuaUhwdXkxV2Z6WXhDZlVm?=
 =?utf-8?B?b2lVQzg1WVlrNnRxWVoxcy9nM1RaODhmbFgyWFZ4WGh3S3NnRVBtN3BWdU1i?=
 =?utf-8?B?QmQxaTNzUlRWQU04MnREWlhDSWlveXAwM1llRWE3NnUxV09nc2ZtcU50TEdJ?=
 =?utf-8?B?SWZqMFBZbzRZWWgzOW9yQWZMdHlwUTNWZHgxTjRIUGY1bFZiMmdxVHZQVzlS?=
 =?utf-8?B?Vk9YZEcyeUkxdGVrKysxSWtISWd2UjNYOHovdG1WRW5yeXBqOTNzc0JNQ0pj?=
 =?utf-8?B?bm0wTGNwV3pRa1hJdml2L2Y1V0FXcjNtcUwzUzluYk9RRXhuSTJuQ3hKQ1Yx?=
 =?utf-8?B?Q1d6QUxBK1FVSHRoNm1meUl4SFhDd0FxNFo1VjhEeFlXa0xZSmpaNkVLNGY2?=
 =?utf-8?B?RnJUbE50VXArSjhPMitPb0ZtRTJRY3NjSzVBOGEvVkl3MU16MjBYRjN1UHBU?=
 =?utf-8?B?L24vWUlsWmI5N0JVTDMwa3NEOTNUMmd0bWF3YWh4OXNUdk1IRk5TSXNZOXBi?=
 =?utf-8?B?cmlOYUNaUXNzbVgrTTBuYm5EN0l4cTVMZ2kySHdOMG0yTUcxcjdLQ2xBS3V1?=
 =?utf-8?Q?7UasFz22zCd4cKljVheNhF0e6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b95859-c899-4808-be49-08dcb1e257d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 04:28:07.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7J70X69wgcmEem+vK4FBIpPt3wvxRhfFmzMqtJGl+XDOvcOtCGJRv3TFRpitI4IZtNMdBFG9ziirWxBHDq/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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


On 8/1/2024 8:49 AM, Marek Olšák wrote:
> On Tue, Jul 30, 2024 at 8:43 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Adding NOP packets one by one in the ring
>> does not use the CP efficiently.
>>
>> Solution:
>> Use CP optimization while adding NOP packet's so PFP
>> can discard NOP packets based on information of count
>> from the Header instead of fetching all NOP packets
>> one by one.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Cc: Tvrtko Ursulin <tursulin@igalia.com>
>> Cc: Marek Olšák <marek.olsak@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 853084a2ce7f..edf5b5c4d185 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>   }
>>
>> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>> +{
>> +       int i;
>> +
>> +       /* Header itself is a NOP packet */
>> +       if (num_nop == 1) {
>> +               amdgpu_ring_write(ring, ring->funcs->nop);
>> +               return;
>> +       }
>> +
>> +       /* Max HW optimization till 0x3ffe, followed by remaining one NOP at a time*/
>> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
>> +
>> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's */
>> +       for (i = 1; i < num_nop; i++)
>> +               amdgpu_ring_write(ring, ring->funcs->nop);
> This loop should be removed. It's unnecessary CPU overhead and we
> should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
> whole packet body uninitialized is the fastest option.
That was the original intent to just move the WPTR for the no of nops 
and tried too. Based on Christian inputs we should not let the nops packet

as garbage or whatever was there originally as a threat/safety measure. 
So CPU side there isnt any optimization but just CP will skip all these 
so GPU side should see the benefit.

Regards
Sunil Khatri

>
> Marek
>
>> +}
>> +
>>   static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>          .emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>>          .test_ring = gfx_v10_0_ring_test_ring,
>>          .test_ib = gfx_v10_0_ring_test_ib,
>> -       .insert_nop = amdgpu_ring_insert_nop,
>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .emit_switch_buffer = gfx_v10_0_ring_emit_sb,
>>          .emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
>> @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>>          .emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>>          .test_ring = gfx_v10_0_ring_test_ring,
>>          .test_ib = gfx_v10_0_ring_test_ib,
>> -       .insert_nop = amdgpu_ring_insert_nop,
>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .emit_wreg = gfx_v10_0_ring_emit_wreg,
>>          .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>> @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>>          .emit_fence = gfx_v10_0_ring_emit_fence_kiq,
>>          .test_ring = gfx_v10_0_ring_test_ring,
>>          .test_ib = gfx_v10_0_ring_test_ib,
>> -       .insert_nop = amdgpu_ring_insert_nop,
>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .emit_rreg = gfx_v10_0_ring_emit_rreg,
>>          .emit_wreg = gfx_v10_0_ring_emit_wreg,
>> --
>> 2.34.1
>>
