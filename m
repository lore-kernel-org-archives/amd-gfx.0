Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A33DC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 17:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A3610E002;
	Thu, 20 Jun 2024 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9u+412j";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE4010E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 17:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7FRwKGrhcHmASFWwn7Od8JB10g21LMMYSrV1/eVGJSyEI1Zy/vbM1qoHXBsRR3OwyTiXaYZ7AocUGU4dCM80Y1USoesBykjqCVWa1X2TwXbb1dgq3qOBAPjTx3zmLZpxsVzRG9egopMTiPapOZ2mgIAaV3Z7wv+b2rqzC7EhGkFdAoMYDzB76WrzB1oUFKgzGdZ2Ma6vZTjm76KKDcLT3RpNPteG70XgXvJ2Pt6SW+38Qtr3817p3m7YoBRU/8GyJFkcESdYuIcHJQGbm/aSgbFtzGZyAvs7qLB3ieS0hjJxZBIvEn4zfANbKx/CEERiKq2/nKFuFLgX6swtb0D3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wje3q49XFFe28hv1MzZP7abVlxnjmX/tzooTFeB8aYA=;
 b=BZB5v6WG460o6p0JQ/zavmG5jWw5IoQWzEKEIAz5fzXVpng/BawaI1Z7sN8EbhpylAdOuzZZQDyKy0qAJJKkdIa6S7kDtSB+axzOxBVhyFFbCm5IiESQqe6gcYYuW+F2ZT3vhsdijCP+A3J0DUYxigEyMBz4KqpYdih6OYzVYIKZv08tdNkxWcXcvYok7hrHp6fJ2so1keSHRL5bqL/MyyK2fNgrmc6oJqXAkkcytcVu6bieRcaHbDWti+8Kln6GoOsT1T4oJyWDVN5B91w9g5ANczxg4GtYD3zyXvBHkIfyXZiYi+3Gs1dQ7ZQefRAfz5FDEHhf24TeaJSNjm3Gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wje3q49XFFe28hv1MzZP7abVlxnjmX/tzooTFeB8aYA=;
 b=i9u+412jNaUaHzclFNbgc/QuJdgoTgOMsXMsRp82k2WVSfH7FRmNH1fG4sH9Snpf16/j61tX1Jth4ChEZRrX2iQ3It4zpUff32wyvjVI7i9vDb0MOrUPXmKSiLXH/q6TvMMx8q2Sl3h2HdCMuuHqge5syXOGgTEXz7sOvLWdG7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 17:18:46 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%7]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 17:18:46 +0000
Message-ID: <8f42df03-54ff-49a7-a25c-581e379a9837@amd.com>
Date: Thu, 20 Jun 2024 13:18:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant code and semicolons
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
 <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
 <351e1524-9568-415b-bae5-ffb458a473cd@amd.com>
 <CADnq5_OMak3yK6frWXVMHBCdpzg9rTbQAYaB_d4DOrXJ8rRV7g@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_OMak3yK6frWXVMHBCdpzg9rTbQAYaB_d4DOrXJ8rRV7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: f28fa31b-4d90-4397-9770-08dc914d0adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjEzRUE4UkQzT2pRemNUcnAwWjZ4eGVSNHNIKzFIT1NHTzgxcllzcWlJTXBu?=
 =?utf-8?B?UEFlTG51dXp6ZmUvL0M5VWZaY0gzTUl5bHlkQjNxV3o4UDBhTnVkeWFMWFdL?=
 =?utf-8?B?QTFnbDFHNWF3SVNxajI4enYxei9tTS9ySFFEL3BOK1MrZTFGRWxkRE1rVDJV?=
 =?utf-8?B?dGFLN3F4YjJkbklNclJWeE5IR3doZE9iMnlVK25VdWFlTzY4NmJjdjFMSFB4?=
 =?utf-8?B?LzJDNGlmN2J3enFXV1ZOaE5VUHgvTUk5Y2swYUltUmhYMXhLWWFMQkx6dklw?=
 =?utf-8?B?ZkhYQjhqUmg2empZL2FGSElrYVlQRFJKQzlUeDZrV25jR3ZlU3pjZEtDVy9U?=
 =?utf-8?B?YTBXTWpKcW12dG0yS2V0ZVgvS3VNMU9qZEFVQWlvc3lqbTQzWjc0NHpiczd3?=
 =?utf-8?B?RnQzcitsQnQzRWx5QU5Pa0JySUpCYUVpV1huNGxSbmlyQkZSZDFNL240NjR6?=
 =?utf-8?B?YU9mSGc1ck1GVktZSlpLNU9NQU9CWXNrNFpFalN4TEhlZkJUWk9IWXFYR0hR?=
 =?utf-8?B?MGVSS1REWmVYclpFVmNmUy90UlFQdjhSYUdBYWllK01sak41NUcrNXZsbWVR?=
 =?utf-8?B?bnNBWFl0Y1hKQW9VeHVMWjVLRGNoVlpnK1NYMm1BRSsxSG9WQkovMk00SjJz?=
 =?utf-8?B?UFJrOXdQb1FzUUNndGJtSkxtd2tNYlJ2cVpZZFpaaThEVkZPZ0gvQzY1UmJo?=
 =?utf-8?B?N2JVc0VQVkp0ejlyY1BIQXlQTnlqMXZ2ajI3VnRXT05yanJYTUZuYlMrMmxY?=
 =?utf-8?B?K2NzeHF3Q2VkdXlhUmlpbm1VeC92Unc2ZEIwQXQzR3J5aUtyeW1MQXpkSDJY?=
 =?utf-8?B?N3Ixa2kyUWNUWkdHellBTG9JOSs2NDRpb1dnN0tnRDUvMEZhZ3hKSjJLZmhP?=
 =?utf-8?B?V0s2WnA4dzhyYW9pYkZIeGhEWldDcUQrOGYxaGdieXZkYU1vdGwrVVRBZ1Ba?=
 =?utf-8?B?N0pJT3NPc3JqYnRuVFZHeE9JazRrb3pQR3dhWU91MGV0eUlNVXUzd2NmblJQ?=
 =?utf-8?B?bWYxUm1jdVVZT2x0RW91ZDg3SG5tOTJBMnJuVTZVbVZDT1BCejhBaTZVUXBC?=
 =?utf-8?B?OTNKNGt1aU9oWG0xeUtmRWRFMU5qZDc1czFLa0ZWQUNabWxYWDBHcnZNZTZV?=
 =?utf-8?B?UXM3bDhCZzYzTlZOYnYvYWt1OWM1cTg5WUcvSHkweXBOZWxkRnlCYmVHQTEx?=
 =?utf-8?B?amE4RkpTc2dTZlFmTzVDMnhyNTBiZmtqdXJmbU5YcVpGUUhtUEJYa2lQbTdE?=
 =?utf-8?B?UnVBeFRWS293Yk5rMFdOMzdhai9qNFU4Z08xNytlamc0OWxhTms1YytjdExO?=
 =?utf-8?B?UzVqakNkeFJrK3hTQWlXcXVobno0bEw3Ky9QS0Y3dEFsT2NjWWhkVXpqeGRv?=
 =?utf-8?B?Mmc5WDFHWmExVjBmOWhlRjNyNGhXKy9Fd0dTYTBaaXVzanNJVldoTHZhc3Rp?=
 =?utf-8?B?bWFVaThmWU5sWXpITEttazlDMWI2Vzd5VkxEVXdnRVFXYW9zTnZtNng1VGZm?=
 =?utf-8?B?bGVvWjZ2S2pHTU5tQnFIRGJ3aW9TTUtBdWJvWmREd3ZHSWQ1b1RHS2NFdW52?=
 =?utf-8?B?T1dEbjFGcWZyS0w4VTI3VURSV21KQjIrVU9lMDl4RFRuc2R3S0xTd3NXbzY1?=
 =?utf-8?B?cWhxMUYzYXZrN3ByTEU1cjNmOUJEVjZFdlFYWUNJSFhnK1RLVDQwc0V6aGVo?=
 =?utf-8?Q?QnVk1Xhvqt+mWqSXrO6/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01UN1d4MEtKZkF2d2NqMGRYZWJCL0NDOG1SMHJxRVN1NlVZMVZ3bkhzcTNY?=
 =?utf-8?B?ejczNHBzeEN3MDc5ZkVYa2R2UTFIdDhLb0M5QjIxTkYvSDZVMU1MNStNT1Jz?=
 =?utf-8?B?Um93d0lVZklJaEhYMjZzaU9sQkhZQWRSNk1kV2NNM2pCZm9qRlJoL2xqZmhv?=
 =?utf-8?B?by91L0tjT3pKYjNZNTZiMUIvOXB2b3VVMU5RQWpUT2llOHlFbnF0eDhRUFVu?=
 =?utf-8?B?bUtzbmsrRVo1UTlEMEpMcVhsTGFlOUNFZktvMTFvTy80ZWdDWnNMRVRRZTkz?=
 =?utf-8?B?YzhzemQvTUFLZ0dCc2FXaXpxK2lnRXJGUFM4RU14RnlPVVl5SzA3RFZTQVo0?=
 =?utf-8?B?a0Fuemd4aDIxN0oybmdRTjdvRjhPYzZUYXZpYXM1TzJIUlV5cTZQTTVZQzQ2?=
 =?utf-8?B?T0RZd3lmZmJPakxDWlhwd0pkVDV2dVRRRFhlbk5RakNaRW5Icm8yeGdvWk5N?=
 =?utf-8?B?WGpBQWhyZ0kxempqS1o4OWkyM3ZWUUg3djhsN2lYNzFNeG9VZDVvM1ppQml6?=
 =?utf-8?B?TGJzb0tzR2U2MmtCZjVhK0xOM3B3bGl1V0JJQWNNcEtpd01DN0RUb3FsY1Yx?=
 =?utf-8?B?YzhZdDVaRFN2MWc5ajlaNEp5VzMvSWl0eDJjYWNJQldtUnVjWDdlcVhtbGxk?=
 =?utf-8?B?SXlUSGtvNmtIeVBjOUZvRGl2RkRRSGN1K25wbjZnb2gvNENrZUN5QnBRWG5j?=
 =?utf-8?B?cjVxMDJyM3pvandjWGFRZFBPQURpN1d5SDM4NTZwT2VKL2RWekRPYlRsL1JQ?=
 =?utf-8?B?V2JRcDZEYTN3YzZZbnVocU5nRGFndFczQldKNFkrbWRucGp0dUV1aThxU3dM?=
 =?utf-8?B?Vi9LYkV0YUZ2M1dDdS9yS29HRzZtdSsvcjl0R3hmVUV3WlMzL1AzNWVlMlFV?=
 =?utf-8?B?TjE1N2ZaZ0Q2WEpIem9pOU84QTdUemNHbVVJZUlXT0gwWmJqQXFrZ2ZjNUZ4?=
 =?utf-8?B?Vm95TWJUZmIwT2NjN0MwVDRrL0c4RFJMMXB2RldxMnROZGxST0gzM2h2WnQ5?=
 =?utf-8?B?Z0dubmdESUdDZ2xPdkNmK0x0emt2Z1h5NUQrVXNkRUhHc2huMGN6VHNSemN5?=
 =?utf-8?B?UXdNTS8veDdDYU1lMnNwcHo5ZjdPY0dBK1RYN1Z0TEE2TENpMjFQNWhGQWtq?=
 =?utf-8?B?cWhTMm90Nmo2WFNDZ2dyVUVmOUZtQTBXbEo2MGRqbC9OQUhJMjlGVFBDcFJV?=
 =?utf-8?B?NmhGOUJROEN2Q3NCN1V0QmtyTHNqeU41NUhkSkVaemRSQjFRYUp4MEp3UHRk?=
 =?utf-8?B?TEp0bHNPWFpKaitsak82c3N4YnVaL2JtN3oxTml0NjRmNUJqMytSSDF6NGIy?=
 =?utf-8?B?SzdwOThZcjRwR2V4eGljS1h0VG1YYkhtK3RSUXRsR3B5dUdpMllTeUUrQXZa?=
 =?utf-8?B?eGg3L2hVdzNQTkFDWGtPa3lGMWppbzFkZVpmNVY0ZGlSc1JCSUh4NUp2U0d1?=
 =?utf-8?B?TWM1TkF0RGNHeEVGK3FacE10dVhSOGNsd0FIL0VFdWFSM2ErRXlZS2NNeisy?=
 =?utf-8?B?SG1nOWFVRERmR2p1Und5aHJyZ2NYQWlVdDBZcy9CNUZlMnAySGJ0RGtlUUxp?=
 =?utf-8?B?YjF2QWJCUXVYL3VjejBtVjhxVmg1RDFXSCtCSDlLMk4vZE1yQzBCaDJlSFFQ?=
 =?utf-8?B?MzVoYlB3N3RIbWdoS2Nvdjk4MGcrMk9seXl0UHJKVm9mWnllSWhHQTdHK243?=
 =?utf-8?B?bUFIRUlROVZSdENWZzI4aFpHbWlIVG9jUlRRTDJXdzdidE56YkNaOGJoaWZ4?=
 =?utf-8?B?RXorejJRVkttaHYyUHVmaHVvQmJvcHppSm5uL05ZMG5ScmxWd1F4aXhZeXZj?=
 =?utf-8?B?VU1NZ2orVmZUWldvMEVHNEtmTnRpRnJWK0dQVDl4NFBTMDRNb3FobDdFUEJZ?=
 =?utf-8?B?bkMxSmpOL1ZTZ2tTaEF0MTg1RFJPNUJOWGRWNlh2MTAybkhaMmtPOVI1cmVv?=
 =?utf-8?B?YXdDRnZCL0V2STVNelZ1aTNia0lIMkRJTk53WEc0V3BYajEzOWtvWTdxekZy?=
 =?utf-8?B?L0VwN0doRlQxUGJidDB0RnVReE5MVXcyQkc0SFltZUlGdDlvNGtTN3Z5L2g3?=
 =?utf-8?B?SXBNcVVwVER4ano2cS9GSVlaekVpTzlaMnMzZTM2ODNEK2hZNlNtMHNtZE5T?=
 =?utf-8?Q?YwJhsoY6LWDAZjgyXXpUyocey?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28fa31b-4d90-4397-9770-08dc914d0adb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 17:18:46.1677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGCTXfo8C7sehWZhGnYsbWf6BcDheNYaEVvIrJuhve/2SwXyvJietajubLGSIhO5+nOUxDC4vhvK0Qwg6QnoWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

see inline, please
David

On 2024-06-20 12:50, Alex Deucher wrote:
> On Thu, Jun 20, 2024 at 12:07 PM David Wu <davidwu2@amd.com> wrote:
>> I think the "break;" there is to silence the compilation warning - it is
>> ugly but needed.
> Which break?  It looks fine to me.
example here - code is fine but the compiler will complain about missing 
"break" for case statement.

-               return 256; break;
+               return 256;

>
> Alex
>
>> David
>>
>> On 2024-06-20 11:38, Alex Deucher wrote:
>>> Applied.  Thanks!
>>>
>>> Alex
>>>
>>> On Thu, Jun 20, 2024 at 5:07 AM Jiapeng Chong
>>> <jiapeng.chong@linux.alibaba.com> wrote:
>>>> No functional modification involved.
>>>>
>>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3171:2-3: Unneeded semicolon.
>>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3185:2-3: Unneeded semicolon.
>>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3200:2-3: Unneeded semicolon.
>>>>
>>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9365
>>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>>> ---
>>>>    .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++----------
>>>>    1 file changed, 23 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>>>> index cfa4c4475821..1a9895b1833f 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>>>> @@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode
>>>>    {
>>>>           switch (sw_mode) {
>>>>           case (dml2_sw_linear):
>>>> -               return 256; break;
>>>> +               return 256;
>>>>           case (dml2_sw_256b_2d):
>>>> -               return 256; break;
>>>> +               return 256;
>>>>           case (dml2_sw_4kb_2d):
>>>> -               return 4096; break;
>>>> +               return 4096;
>>>>           case (dml2_sw_64kb_2d):
>>>> -               return 65536; break;
>>>> +               return 65536;
>>>>           case (dml2_sw_256kb_2d):
>>>> -               return 262144; break;
>>>> +               return 262144;
>>>>           case (dml2_gfx11_sw_linear):
>>>> -               return 256; break;
>>>> +               return 256;
>>>>           case (dml2_gfx11_sw_64kb_d):
>>>> -               return 65536; break;
>>>> +               return 65536;
>>>>           case (dml2_gfx11_sw_64kb_d_t):
>>>> -               return 65536; break;
>>>> +               return 65536;
>>>>           case (dml2_gfx11_sw_64kb_d_x):
>>>> -               return 65536; break;
>>>> +               return 65536;
>>>>           case (dml2_gfx11_sw_64kb_r_x):
>>>> -               return 65536; break;
>>>> +               return 65536;
>>>>           case (dml2_gfx11_sw_256kb_d_x):
>>>> -               return 262144; break;
>>>> +               return 262144;
>>>>           case (dml2_gfx11_sw_256kb_r_x):
>>>> -               return 262144; break;
>>>> +               return 262144;
>>>>           default:
>>>>                   DML2_ASSERT(0);
>>>>                   return 256;
>>>> -       };
>>>> +       }
>>>>    }
>>>>
>>>>    const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
>>>>    {
>>>>           switch (bw_type) {
>>>>           case (dml2_core_internal_bw_sdp):
>>>> -               return("dml2_core_internal_bw_sdp"); break;
>>>> +               return("dml2_core_internal_bw_sdp");
>>>>           case (dml2_core_internal_bw_dram):
>>>> -               return("dml2_core_internal_bw_dram"); break;
>>>> +               return("dml2_core_internal_bw_dram");
>>>>           case (dml2_core_internal_bw_max):
>>>> -               return("dml2_core_internal_bw_max"); break;
>>>> +               return("dml2_core_internal_bw_max");
>>>>           default:
>>>> -               return("dml2_core_internal_bw_unknown"); break;
>>>> -       };
>>>> +               return("dml2_core_internal_bw_unknown");
>>>> +       }
>>>>    }
>>>>
>>>>    const char *dml2_core_internal_soc_state_type_str(enum dml2_core_internal_soc_state_type dml2_core_internal_soc_state_type)
>>>>    {
>>>>           switch (dml2_core_internal_soc_state_type) {
>>>>           case (dml2_core_internal_soc_state_sys_idle):
>>>> -               return("dml2_core_internal_soc_state_sys_idle"); break;
>>>> +               return("dml2_core_internal_soc_state_sys_idle");
>>>>           case (dml2_core_internal_soc_state_sys_active):
>>>> -               return("dml2_core_internal_soc_state_sys_active"); break;
>>>> +               return("dml2_core_internal_soc_state_sys_active");
>>>>           case (dml2_core_internal_soc_state_svp_prefetch):
>>>> -               return("dml2_core_internal_soc_state_svp_prefetch"); break;
>>>> +               return("dml2_core_internal_soc_state_svp_prefetch");
>>>>           case dml2_core_internal_soc_state_max:
>>>>           default:
>>>> -               return("dml2_core_internal_soc_state_unknown"); break;
>>>> -       };
>>>> +               return("dml2_core_internal_soc_state_unknown");
>>>> +       }
>>>>    }
>>>>
>>>>    static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
>>>> --
>>>> 2.20.1.7.g153144c
>>>>
