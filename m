Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E0C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 07:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F3310E679;
	Thu,  8 Aug 2024 07:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OFGtpquo";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AF910E678
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 07:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNmWLY19kItCdazWaMG8Un5pgBkPa3jYAQ3sXOc5iv/3TqnQe77uQI36zOMfC7XxTshIweSjrjy2kW4D6yhxyPQVcEvda6pfRLCT7cNTX2s6cUreSjP1JldMfHgAsVBcfZ9qlmQKDldCHKKigj9Z3xbeoTwqBATjj7B8KG8nEycYtfeU4XhGbpJegXp+c8bB1/Gf2U/1/CiTXja7fbkhkZf16Qrf6cDhg2OqJsRA3ac0B/sXe6u9koJZyNpxb0SQTQ/TGRi13txVtvgaQvb/u2SgniuIW8pUnCrXVA6HTLel3ocLs/7jUB/qnqzqUPurym0Zro1fXR9W10V8HAdc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6Dkz+WYvrr/QEYBypQwRQBHUZ116zBKfgBbhgnQl9c=;
 b=Z3p5kYvAbtZKUzwJ+FV0BZUqX0yKAIUILUnK9xILkiEYkp1KMCBQvgn7xIVcmcIFu5JVEKSCqNlc+arCYHUtVJXRo5DKYAPwaoCkt5Ycgy0T3APNflAofEM+6OttJ93o61+3Dyole959nCDd7/mWJyI027xiSCbsSGFqK7iT7iT8y5Dl/1Vk/AF4UsmE+nGBAJjfVG/r6W9x6wCttPQMINjOfKV9poJfKElLogEilYmCPAE1rfEtddJaWlue12Qkkb/3x1BLxzghhf7EUme4gFsSOLd+4Z2I8Vv5XYoq0RJTtUz8CbAkgB8S4XqGjjvtMHSVGYvnPpW5llZhSqu0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6Dkz+WYvrr/QEYBypQwRQBHUZ116zBKfgBbhgnQl9c=;
 b=OFGtpquoR8oy5npk7HEZA3YQRN0YZO3noaRVTa2jov/4Y9804JLmk9ghluwEdHgOJbx66AUYxGk9b7krL3GIw7akJh2C/dHG/7j1r2x2uhG17xGEwuIpyGAaYKOwgJvdrEMT1wLi2xoTrFcb3UslmNFi8VU37uVCsd6L2cz7YMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 07:29:51 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 07:29:51 +0000
Message-ID: <f787a816-96fe-4799-ad7c-cde1bd7b3065@amd.com>
Date: Thu, 8 Aug 2024 12:59:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
 <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
 <a35d84a7-3d8b-4ca3-9157-7d8d48a54b02@amd.com>
 <2ad50a00-b443-47c4-a9b4-04fbfdc67be9@amd.com>
 <e3dde88f-8362-4e80-9e48-c6fb99035861@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <e3dde88f-8362-4e80-9e48-c6fb99035861@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: fd99cb16-1abb-44f8-d14c-08dcb77be3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE15YUdyV203ZFBiU2ppc2ROQ2w0SVIwa3NqV1VCQWIrMVF0MkRtanVjUkt2?=
 =?utf-8?B?QUs2ZWppUzNqOGdKZDg1aE9Cd3QyRUw3R2huOGdnU3UrcVdubGJ5MlpSZC9j?=
 =?utf-8?B?cXFyRkp2NXd1Z3VPL0Y2OHYrK1oyWUZTNnl0T081SC92SlpleGF0OVdtZVBo?=
 =?utf-8?B?K1BrdzBQOWYzR0ZxL2xIT3dTUGV6ZjZucU5UcXJsam5pREQwaExrcjhSOHNR?=
 =?utf-8?B?Zi9GMldNZjJGVGc4MEo4dDQ5UjhObXpGNWJaZXNYOEF3d0JVcm1waUlyMDI0?=
 =?utf-8?B?REtMV0tuTzNmUU0xTTNrS2ZEUXhyUHB1OHVBVDJ0ZWVFUEs0SS9GaG9Mb1I1?=
 =?utf-8?B?RDNrd2VCQmh2MTg5M08rSVdEdnBPQkRQZ0hHVGxnYmFScWtJeTBjaTdXbFNI?=
 =?utf-8?B?ODFuWjErSEpzN2FzTXBuNWcrREJMbXZXQTR3RzZUQjRPZVk1NDdrK25vWEJJ?=
 =?utf-8?B?S0hRWWhtd01VMUd0SUV5NG5IbVFsY3IxMW1vYXRJSEFaREpFK3k4dGVYMlA1?=
 =?utf-8?B?dVlBdXZvWGg3SlErZThtZzdFdGJNMjhlM1RQYXc2a0QwaG5OaHB4VDh4bkwx?=
 =?utf-8?B?VXVic0FNa3JGbGhQNmtyRnlQTnFCNmJHRElaMzhUVDNPOXJDNUcwcFkzR0NI?=
 =?utf-8?B?VEcxV0xWWCtnMi8rOUQwVlZ4dXJyRm9aRFRnZEtvNFpVaXNvTkRqNUNxVVAv?=
 =?utf-8?B?Z3gyRW1WL1J5QkozV3BoeHN0ZTdSOGZGSjRNempOdHFVZ2FqV09sMkRnM051?=
 =?utf-8?B?bmlBQXh2MG9VeHo0ZFVaWHl6UFdXZ3ZyYmNJT3UxUjN4K3ZJR3duSG02ZlJ2?=
 =?utf-8?B?UVVkMm1uSVVVSU1FVVJBS0RZMXIzMURkTFVEWXd1UFhKMzYwUE5IQTZYVVNi?=
 =?utf-8?B?UktWRFJOaE5TbmUvWTZvaGlyM2Q1aldYRVFnZnBoK2xoSFhRbkV6M0FISG12?=
 =?utf-8?B?RGo2MThYYnFlZ3FXMHdHT09CN3dBU2NuQmsza2dWT2l4NDUwcWoxM01aQ1gr?=
 =?utf-8?B?dVl2Zkk2dTVNeGtObitzTW9LQTQvaXJieTk2dlVwSFIzVCtFMzQyanFkRDZi?=
 =?utf-8?B?cGovZFdDNS9rVUNiRjRIcng4WXViTlROa3ZzZ0FhTmZpL2FSaDIxSlRRTGxp?=
 =?utf-8?B?M3o2RXRNbTBvMHJVWll2N1lhYkk2MHhpZ0lzb1JIWHB0eW1jMm1DVEJYM1Q5?=
 =?utf-8?B?OWdSUmt5SWxwZ2pISzIzRDhEaGlCQWVRaTJ2a25vMXdKKzdwRmxXaVBwWXdU?=
 =?utf-8?B?aWFDSGx1VDVVS1Fsa3lYYkhrTXRYV1ZPU25PZnprNXdJMUZEWTFpSkE3aDdZ?=
 =?utf-8?B?MzVLR2dPTkdUTUhpdnhyNVZ6bVpES3ZKbjFuYUNkZDR2bi8yS09jcGk5ckY3?=
 =?utf-8?B?RGlqZGhhdGZSUUNiY3I0dVFvc05KRnQvVDNrTkZBMll2eG1YWTRHNlQ3MGpK?=
 =?utf-8?B?OEIxdndvS3k0eUFsWVVKK3hHak9kUmc1VFM0ZWdYa1Z1R3BDd2JBdGFLSCs0?=
 =?utf-8?B?ancyaGUzcWlIVXF0ME10UnRCbkhGSDZPMGxTUVBGNzUzVUlyZWltMGZTcjdV?=
 =?utf-8?B?Y08vNXpvUmtuVDFqZ2d4TmJDbE9VVXA0SFpWSFVHSStyd1c1QlpabHFKL1Vv?=
 =?utf-8?B?ZzhsTzRNNURQbjI1SDdNWnVJL1dsZ1dPc0h1WjNHcHQ1MmhuZmtBUE5OK0pT?=
 =?utf-8?B?bW1KcTFZOHJsSDh2bm5aTkVjWmRlUktEVmRXMjE3dVlSbjdDT0w3MWdqMzdH?=
 =?utf-8?B?VkRGL0N4ODRnM1FxbG43aUtvTlhPcFRPTzdMa204VDViekZPdGhKYVI4K2Uv?=
 =?utf-8?B?MDFWcmpESGRUWUo0NWdvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2UvZE9pRGNoZEVIVmM3VXNJSDI5cXVIS3lZQTVUVTNJT1R1T1pmOVRsVkk2?=
 =?utf-8?B?U3FHV09GSCtkb1J0ZVprOXlHcG1UcWhrazdWbUNDZGVEUWsxenM4UUVZRmRV?=
 =?utf-8?B?OUJBTE8yMkFvNHcyTVJEemRSWVdoajA5Z1p1ZndVYkdlTTQyQldlWkdRbFpq?=
 =?utf-8?B?YWROd3NTWFF2aitkMVgvYkp3cjBuTm1Ea1BHOTlWOHg3bkx6YjRld2RaS1U4?=
 =?utf-8?B?bitPNm9BcE1XS3ZQSHRDM1hLK3JsTVVFcDhSMlcwam16aHBtMFdzSnhkSVZi?=
 =?utf-8?B?VUZRU3dxbU9OZmc0b2IwK2NObnhlYTVaMmZvcTNmQXl0djdMU3diYkR0MjZW?=
 =?utf-8?B?VHdaYWRPN2lRdnNGZm41Q2xaQUxmVjdxbUNFUVRmRlBidExGc0tVWThMeGVY?=
 =?utf-8?B?b3JnNVFOQlNZZ1FFaEhwbllUdjJqRnBqbEQ4cEhFOVlTSlNrN05UV0RvU1Mz?=
 =?utf-8?B?U0wyUWJNZnZ2MnYyZjBCbkZaK3BqWGRtdi9CV1JHMkRpbGhpKzhjVTJzL1J4?=
 =?utf-8?B?c0xlREM2SjRaOWdoK3IwMitXbkVxQTlIb3Q3U1QvT1J5NHd4T1U5MVAyNnFC?=
 =?utf-8?B?MVF4RHFCTGVZd3Mva1pEcCtxd0FWc2ZORHBDNkQyWDlkMUl6YkFnQ1hqbU5G?=
 =?utf-8?B?NFJCTzIxYXlXOXpySy9sTkduQmFTdzN6aFVWc1c2Q09rUEtVMTVLdUFGYWZK?=
 =?utf-8?B?bVp1MjZGMndEdnJYM2IxY1FyYUxrOU9ldzBMbmd0UEhGK25TdVk0SE9LM0VE?=
 =?utf-8?B?ZG5sL2Y2dGowZ2NHT2RiektncVErTEZzdi9jSE16TFRXTUU4TFJUSVNvWUNN?=
 =?utf-8?B?V1FwNVZuSWZrZFVRYnk2U2JkWWNhYlpKMThOeHZRQ08rWGk5RHUrcHd0OWc2?=
 =?utf-8?B?UUxBamNFVWRXSUNQRWJrT2dLL3BJc3Q0TkRSZG9FZW1oMG5pcldyMjVhQjZ1?=
 =?utf-8?B?cGdUSkZIelNLWjFuOWIyeDkxa094ZE9zNGtTU3dreE90VHY3YTBpLzhDelZh?=
 =?utf-8?B?Ym43Zks0RkZNY1hvSXRCbGdqK1UxNlJmNXdZQUxRaDd2M3dZN3RQM2VZWDdz?=
 =?utf-8?B?MHQrY3N0emw2K3o4cDQ5VUxZS2ZpZTk4SnNMalNrVFUyT3U0UUU2cmVIblQ4?=
 =?utf-8?B?VUxEY0M2VGRXWlF4cWdKcFdTNUZJTGJRZ25YQ1RIQ3VBcVVVTU9CSnc5c0Ey?=
 =?utf-8?B?QzZ6dThmcFlRcE0vRXMvMkY5NEtuV3hwWm9RU0JDSHY2VmJOY0krUlc2dUFE?=
 =?utf-8?B?VHNaL0ZoMzBkZGV4SWZVWXZtV0xzdmliUmoyZDh1cGdreDJnNzRVejFsWDVX?=
 =?utf-8?B?SnluWktBZXpUdjFybkZiUkpEaTZsdDFTRnJoQ2g4WXZqNmNoS250b2NXaHlG?=
 =?utf-8?B?Z2gybmMrZHZ0eGVraE5UUW1EUWtWMDIzQWxnYTh3V2FldEl5SVM2V09sYUpH?=
 =?utf-8?B?U3lyb0RzN053ZzVGUDNhOTRKanpkT0hrQVVHMjVuTGU0bkZVQW5RczJXWlZa?=
 =?utf-8?B?L2xHdkQxUGFmeHBNTnZIOENtWWh1RU83WklIaVVCSC9LcnZ1cVFtYUxkWXBa?=
 =?utf-8?B?V2R6ZmVXLzZDOTR6SjlmWjJ6ZXpuM0N5MTUrN2xIeGlmK1krVWJ6ODVXVXN6?=
 =?utf-8?B?NHMyV2hjTjMrdWVicjZ2cHNvV0xYRVF3UnhCb3FRbEtldVcrRGlITHc2Yndz?=
 =?utf-8?B?TEdvMFhudjEzZU9TTlorOWE4RnlCNEtGUXkvMkNWcVhCaE43dDgzNFovOTh5?=
 =?utf-8?B?OWxHL0xwTzRJamdrVlJFWlB0bTdTd2xxUjhhRzZwdHIrUnlHTGV4cE1PWUxn?=
 =?utf-8?B?Q25zOU5uUmh3TVMwRG1aVlhuT2FRNXlhbHJ0TVVQZXlhbGdlSHRHM2FWbktS?=
 =?utf-8?B?VitpSkRFZzN3WUVWYzhWSTdIaVQvcmJWUnhvWXNpaVRlZ0gwK09HNWpaRm1t?=
 =?utf-8?B?WlpZeU9BRHpYZ0NacTVkZEQxNTc5SVVUV3VHNHZQdWV0bTlabzR4NThIekgz?=
 =?utf-8?B?SkhLb3ljZGFFR0xzRmYveGtGbFpsWGhQcDlIS0dPQnR6M2pGc1J6alFCZWEy?=
 =?utf-8?B?OWFueXM5VXArYVBLK1dwNnBhM1VmeDVCSEhvbG9lU1NBN2dMWEI3VUlqaWhB?=
 =?utf-8?Q?GdIfH3pgOkfQDfqnT0tYHVUTQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd99cb16-1abb-44f8-d14c-08dcb77be3df
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:29:51.2827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb5C+u1xOCVhRepCutsZzp/wJgkmH1odfkwYjNGbReCfp0x7iA+wWEWjoykfsuCtZzJ+yX6KBt3cIj4mAUid0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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


On 8/8/2024 12:44 PM, Lazar, Lijo wrote:
>
> On 8/8/2024 12:36 PM, Khatri, Sunil wrote:
>> On 8/8/2024 11:20 AM, Lazar, Lijo wrote:
>>> On 8/7/2024 2:58 AM, Alex Deucher wrote:
>>>> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <sunil.khatri@amd.com>
>>>> wrote:
>>>>> Add support of vcn ip dump in the devcoredump
>>>>> for vcn_v4_0_3.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170
>>>>> +++++++++++++++++++++++-
>>>>>    1 file changed, 169 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> index 9bae95538b62..dd3baccb2904 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> @@ -45,6 +45,132 @@
>>>>>    #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
>>>>>    #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>>>>>
>>>>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>> regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
>>>>> +};
>>>>> +
>>>>>    #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>>>>                   (offset & 0x1FFFF)
>>>>>
>>>>> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>           struct amdgpu_ring *ring;
>>>>>           int i, r, vcn_inst;
>>>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>>>> +       uint32_t *ptr;
>>>>>
>>>>>           r = amdgpu_vcn_sw_init(adev);
>>>>>           if (r)
>>>>> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>>>                   }
>>>>>           }
>>>>>
>>>>> +       /* Allocate memory for VCN IP Dump buffer */
>>>>> +       ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count,
>>>>> sizeof(uint32_t), GFP_KERNEL);
>>>>> +       if (ptr == NULL) {
>>>>> +               DRM_ERROR("Failed to allocate memory for VCN IP
>>>>> Dump\n");
>>>>> +               adev->vcn.ip_dump = NULL;
>>>>> +       } else {
>>>>> +               adev->vcn.ip_dump = ptr;
>>>>> +       }
>>>>> +
>>>>>           return 0;
>>>>>    }
>>>>>
>>>>> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>>>>>
>>>>>           r = amdgpu_vcn_sw_fini(adev);
>>>>>
>>>>> +       kfree(adev->vcn.ip_dump);
>>>>> +
>>>>>           return r;
>>>>>    }
>>>>>
>>>>> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct
>>>>> amdgpu_device *adev)
>>>>>           adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>>>    }
>>>>>
>>>>> +static void vcn_v4_0_3_dump_ip_state(void *handle)
>>>>> +{
>>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> +       int i, j;
>>>>> +       bool is_powered;
>>>>> +       uint32_t inst_off;
>>>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>>>> +
>>>>> +       if (!adev->vcn.ip_dump)
>>>>> +               return;
>>>>> +
>>>>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>>>> +               if (adev->vcn.harvest_config & (1 << i))
>>>>> +                       continue;
>>>>> +
>>>>> +               inst_off = i * reg_count;
>>>>> +               /* mmUVD_POWER_STATUS is always readable and is
>>>>> first element of the array */
>>>>> +               adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i,
>>>>> regUVD_POWER_STATUS);
>>>> I think you need to use the GET_INST() macro to properly handle
>>>> this.  E.g.,
>>>> vcn_inst = GET_INST(VCN, i);
>>>>
>>>> Alex
>>>>
>>>>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>>>>> +
>>>>> UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>>>>> +
>>>>> +               if (is_powered)
>>>>> +                       for (j = 1; j < reg_count; j++)
>>>>> +                               adev->vcn.ip_dump[inst_off + j] =
>>>>> +
>>>>> RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>>>>> +
>>>>> vcn_reg_list_4_0_3[j], i));
>>> VCN 4.0.3 supports DPG. As far as I understand, most of these registers
>>> are accessed indirectly in DPG mode through indirect SRAM.
>>>
>>> Checking UVD power status alone may not be sufficient for direct access.
>> i am following what windows is following and most of the registers are
>> directly access but i agree some might not be.
> Whether Windows logic works is the first question other than the
> secondary question of value in logging some of those registers.
True. Cant say but the bare minimum we could do for a starting point was 
the intent. Dumping VCN registers is a challenge due to its dynamic 
power gating controlled by firmware.
based on VCN fw guys probability is in case of VCN hung we might be in 
power up state to read some of the status registers if not all.
>
>    We are assuming in case
>> of a VCN hang it should be in good power state and we should be able to
>> read most of the registers.
> 'is_powered ' - It's quite obvious that there is no assumption like that
> :). Secondly, when there are multiple instances where only one VCN
> instance got hung, and others may not be - this assumption won't hold good.

The principal is we are dumping all the IP's irrespective of who caused 
the hang so no matter what instance causes hang the registers are dumped 
for all. The vcn hang information is captured in the kernel logs

that can be used along with it. Also is_powered is per instance and if 
its powered off we arent going to read the register at all.

Based on the experiments i did in case of hang caused by gfx i found vcn 
to be powered off as there isnt any work load on VCN to keep it up. We 
will improvise on the functionality as we start seeing issues.

> Thanks,
> Lijo
>
>> Based on further feedback will do the
>> needful but right now the point where we are dumping the registers we
>> could not make any change in power state.
>>
>> Regards
>> Sunil khatri
>>
>>> Thanks,
>>> Lijo
>>>
>>>>> +       }
>>>>> +}
>>>>> +
>>>>>    static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>>>>           .name = "vcn_v4_0_3",
>>>>>           .early_init = vcn_v4_0_3_early_init,
>>>>> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs
>>>>> vcn_v4_0_3_ip_funcs = {
>>>>>           .post_soft_reset = NULL,
>>>>>           .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>>>>           .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>>>>> -       .dump_ip_state = NULL,
>>>>> +       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>>>>>           .print_ip_state = NULL,
>>>>>    };
>>>>>
>>>>> -- 
>>>>> 2.34.1
>>>>>
