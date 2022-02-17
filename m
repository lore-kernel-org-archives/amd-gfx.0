Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF494C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5450710E37C;
	Thu, 17 Feb 2022 14:17:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64A810E37C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxhharaWXrL1EFXq2UEOHIOCJkR5ytZcw9Az2NLoJooCkRui1/F5Jbq3M6XXGydcJCigEJ288SaEhol8jWqLEtM3RMfESpxOLB1xuDrYrFi6/nuOvtB6y3byvnFIDbnacT8BCm8p+4zFqwwsdL1ye568JON/LOneKJekjDx4l3x6olxBDfz9kN+mbMMcOsfugVTqIREy7Kcdz47U6AmmIMgrYYAiH9aL/bQaxi6sk9J+djhKUi9GnaQ1mAwL+7iw1pE/sL4MOPsnnnxW5Ndu5sIRgrlQlbdY9UxR6UzrOEjm4JXoxBYqjPKHWZIKO8WGfSpbhDmyjgrnCkNF9Szmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS25pPozWJk5CilcG6MMKfHAxTgieuwwrISH5PPXMmw=;
 b=NrV1vF57z/+uQ4ajO2eWccRkTJ0OF8B8l+6YdHyxpAtyqXDqE6UemlWNJ5/4Pn0aCfbi/9Ir3PT7Pc4sF2/D4mVOqDkswm3s2slxT01DyIJSHDXssR7hX4UzbhyU7OX7v9zfGawhBhUc0KXEJVNlBNVYHGLcRle5QbyzaTJxdxk9ySxGJWwHqTEs8XV3ZBGAoITrSC/ZX6FZU5Zim9ZEStVL/8XleUpHpD5GqW/ZmNc0SN2VR979IaxXXPXK93y6A2eCKN4LWQpdUThEcwrfJBU3TU4otjjHP4tMB9xfSRVPYpmNSNhiSWeNpoAJVP9/vz3wl9dikYoj+y6N2Rl0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS25pPozWJk5CilcG6MMKfHAxTgieuwwrISH5PPXMmw=;
 b=S86lzJv2b+HIPOGfpDfFW2ZM90ZXKBOs/hdDLwk3K2olMxN10j2SAQ9EfdykIcm08jI76mpAR/ShgnzdiWyBdUZOTKeabGgi09UumSdYTkl5BhV6dpKM7qDTKJHPg0FE/TyclZ17p4YWk5ldNnL5GOeniGsNl/PvDhEhF9tZFMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1662.namprd12.prod.outlook.com (2603:10b6:301:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Thu, 17 Feb
 2022 14:17:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.018; Thu, 17 Feb 2022
 14:17:53 +0000
Message-ID: <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
Date: Thu, 17 Feb 2022 15:17:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
Content-Language: en-US
To: Cal Peake <cp@absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aeddf3e-c95e-4d41-b174-08d9f22048fb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1662:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB166291935CCF9484B80D0AD183369@MWHPR12MB1662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivPBpPH5j2SE2xpF8euTVnjAIy/WZhr6jeEETGVJY3fX3qOHL2NGhY/NU8SM18I2d7R40CpnyiBTKUG2o1STRvsvo+xjBvmWQPXqBfwCb9mGye2M3LdYgBcET8BvVvy7iHmsR+JX3CcwY3SrXRk2YeyOoMegyRd5XKIQRMnwXQiRCcFQ/Tt0o3MrM5VYx8fvsQBkJ+71hAohfoWEPM0y44S8mfDuNv/c8hSE6eN23yDsXxTk3ex22Lp6pvPzQZTWKspVY6WEKdm7gnuQMrm8NtigQwNL5A77Fjfjr3oIdb8d0C+s83moV6M+XuH6B6NuphCvTHZ0zBMXEf3NhXTHNvHkC120nHKHL01tcj/8B6pgdo5fl3OgOpYab5lTTYKoPOT6ZcK/BuYo+UHPpUHoOd6F+RkTMdi5ijNyT2biK2LZL8J/HqnRMRGTA2iCZLuOFZlIcUYDLCSJ8hBVOo0AWiu05Z+1Qhg4E8f382eEXsrdx/7tdj85LGO9CrphZ9AZXejgaz0NVxKABgvZPjfqWKPD6bBNvAYoUuahQ8isrKYuNPdbB9WUDBNKAtBraGyylW0BtQBdX/0wDSvKLUp+2esnqVXioXa/nZXO8UfdFzZ2LMu9nSsu3QCwv9WFF8I490U4mm+1QR0jspOADP4ojxYEsM1g3HjTfNPPLZG728MDGW1qi7RpzmFa5fiumdRmiW8YTiFvL4hjCxXAks1sL2B/yHD61EFbQuDInQuCXjQmY/AWOtdvedIokYZsQM+U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(316002)(66556008)(6486002)(83380400001)(31686004)(508600001)(66946007)(31696002)(6916009)(8676002)(66476007)(4326008)(6666004)(6506007)(2616005)(86362001)(186003)(36756003)(8936002)(6512007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnErZUdBRzJENmRCQkhPM09vS2hXNzFmRXJTMDBnUVNBUTI2c3FLbE1vd2Jm?=
 =?utf-8?B?VWZsdFc3aFFuZk9PQW5HWkFVM1RCazRDMTRxQlI5OGttS0dLNWlydnVUY1Uy?=
 =?utf-8?B?TTgwMGpYUG94cDVWUGJVSzI2YnpXeTRrRlVOOVFXVzlnTUxvaFVmbDJadGxu?=
 =?utf-8?B?M2ROcWlLNkY2bTN4TFhJbGtYWVQ1RU1DY21OR2hVb2lQdUxNUWVHMzJaRlVp?=
 =?utf-8?B?cmp5L2JkeWd5dVovMzlKS241RkViajVMaDRZSVE3NzVyVDhlUDdzYnhKUUd2?=
 =?utf-8?B?Y1hvbEcwZXVhMVpWVGJHSFJRYUh0QWwxZVRqNkdzM1AzeVpySnBUNGVhVWVV?=
 =?utf-8?B?cjdJUHppUXpUbldQcEdlOWU1NE1lWkxQaGtXZUFycVhlMjQzY0JxUWVXMFB0?=
 =?utf-8?B?ajhUcW9MTC8vVjBuY0U4dkthT1FxTjliVFdFMjhDRGFyc3NtUEtBOUQxSDgv?=
 =?utf-8?B?NUlTZk5jTEFCK0thSU9lNWMzRHFWeHlid1ZxZW5PZHcrdFdrblFvcDlIbko2?=
 =?utf-8?B?ZE1sQnVVanZuUkMwbEd1UTkvc3ZtaHdob3QyMU1mOXFTK1AyWmVnNDdRTUMw?=
 =?utf-8?B?ek43TFhndVQ1aFE1YURQZXVxMS9vWlhCKzZQQnkrV21VMnkzaE41VlA3a0xV?=
 =?utf-8?B?SEhHenFvZTcwc0VnOE1yaWEyQnpuZitObzVreGVzT3NCMmpYa09jdDhNb3Jz?=
 =?utf-8?B?MmlPYzF3Nklnd1psaGd6WHJxbHFkY3BQdFcydWxreWUzeTZ2azJqeENDUVpU?=
 =?utf-8?B?eVZHQkkwVExFbU9Zd2lqRU1vRDRMWDdNcHZ1aCtzMmtWNFFOY0VhcmlaQjdW?=
 =?utf-8?B?NC9pN1FPTU9VcTM1WitnV001ZHdISXlydW5xUStjSm81c3FldjZYdWlldWMz?=
 =?utf-8?B?NjhCZGl4cGIvT3QrdWVrMkh2OEhSdXNOUWRpVndwVkJzVCtjZU8vK01PUUtr?=
 =?utf-8?B?ZXczMmdqQUttUUJod0VxR0hGZFJyaG1tbjVpenBwT0NTblhoQ3FPUGtPN2VX?=
 =?utf-8?B?YjFIWlc1TzZZQVppU04wTHlzRzRkWkZJbnl0K3ozc2FZRUI0dWRML1crSEN2?=
 =?utf-8?B?UkI4WHRzbU94aDJkK2h4QXpHeGxkbG9wbWd0Z210SFZpbHp2WngwRGNGVXEx?=
 =?utf-8?B?UGZRNERwWGJDNGd6Sk9mVTFHY3hPd3BQK0dUZVhtS1g0ZG9YRk1XL3dzaVdq?=
 =?utf-8?B?a0dJYkxHY2tOamo5Qm1iWGptdGJQM0tTbytia2N4ZnJ5VWh4d1ZBemI0K3lI?=
 =?utf-8?B?V2pncVJIbFpITGVLTnpJZHpEVDFjanYvK29kbHN2eFVsNjVtRUUwTFBuang5?=
 =?utf-8?B?WFdDL1d4bjFFU1hQdWhtbGxwbnFMNGROeUpvTHNMdlIySzErc1djYnJGZUc2?=
 =?utf-8?B?UzlMUjhaQlZVSGVUU3RFbGRMbW9paUdGRVZOUnhrWWpCZDNZNkFvU1U3anN6?=
 =?utf-8?B?VHlaVDgvM1NkeitKT0Z4TTVYd3dCaFRrZkFVcEM2MTRJdGM3b0JUMnFvUTBh?=
 =?utf-8?B?T2VwbCtSS25lalVINWtzL0JpVUk3UkZ6TzJ5M0hDbXpVbU5tR3dTV1VBWGFa?=
 =?utf-8?B?MWZhSHQzYXJvejVQWDBxaDBod1IwT2lqZWt0TnYvaVN1V25KcW1IRGcwRlRP?=
 =?utf-8?B?N01tZUxRaGtIb3V0QUNFNDBwcTZvTHhFTEhxaXBTZDY2Y091Q1FZcFRZZGhy?=
 =?utf-8?B?RUhZR1JwMDA2ZmhodVZIczhrQnY2R1NVMDZDMnVhakNMYk02cGFxaGR2UmxR?=
 =?utf-8?B?TTRDcisyUklwcFVlUTV6WWxySjh1UzBaazVuZ3Rab3JJbXRUMmZjSHVpWFRV?=
 =?utf-8?B?S1piVS9QcXdBV1JxS0dxU25NWmRFeDlaUXowM1phQjVQNm9uek1KVmRmQU44?=
 =?utf-8?B?VFNhOCtnZ2UwZ05aVit6cGhoeWxYelV4dTFCSDJ4TDU5YXpEam1SUi9oclRm?=
 =?utf-8?B?UFlwdmp2NHkxZmVtUXQxLzhVNkU4ZUZoTDFDTDhrK28wZ3hPNXkwVk1GaWhh?=
 =?utf-8?B?SG52NmxMWjFtWUhzSlE4YW8zM0Mwb1BETGM3ZGU1cGNWMk05bTYwdTNRRGo4?=
 =?utf-8?B?QmtpTHRHWWE2L2lxS25IOXE0YXpGa3EwZlZWQ21DNDRqeERxbENac1BSWTN0?=
 =?utf-8?B?RkFkNDNBWnQ5bWMrOWtJSEpNSWFkMzlLalZGaHVpVEJWNlM3ajZBQWZQdVRw?=
 =?utf-8?Q?s9NT5bAsNINL3lDcUxnQ184=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeddf3e-c95e-4d41-b174-08d9f22048fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:17:53.0090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd450IQtMLHOvkAkmVL91TdahdDjQgREQg+g/VWdRLqMqCZqURssR10uXtSCPhPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1662
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Cal,

Am 14.02.22 um 18:45 schrieb Cal Peake:
> Hi Christian,
>
> Thanks for the reply.
>
> On Mon, 14 Feb 2022, Christian König wrote:
>
>> well that sounds strongly like some hardware problem. What power supply do you
>> have in that system?
>>
> Right now, I've got it hooked up to a Corsair VX550W. It's on a test bench
> so the only things hanging off the mobo at the moment are the GPU and a
> pair of NVMe drives.
>
> I'm also testing this system with a RTX 2060 Super and I have no problems
> with that card, even under heavy load.

Ok, at least it doesn't sounds like it is the power supply.

>>  From your dmesg it looks like the kernel driver actually initializes fines. So
>> my educated guess is that as soon as the desktop tries to draw we suck to much
>> power and go into brown out reset.
>>
> I'm not even trying for a desktop yet, it's currently booting to runlevel 3 :-)
>
> As mentioned above, the 2060 does just fine and its power needs are
> significantly higher than that of the 6500.
>
> It's possible that it's something with my particular motherboard. Michael
> Larabel over at Phoronix did some performance testing[1] with this same
> model card running on Ubuntu 22.04, seemingly without problem.
>
> Do you have any suggestions for further troubleshooting?

Unfortunately not of hand. You could try to play around with the power 
flags, but from your description it sounds like you already did that.

Only other option I see is to try a different motherboard and/or Windows 
with that hardware. If that also doesn't work there must be some 
hardware fault on the RX6500.

Christian.

>
> Thanks,
>

