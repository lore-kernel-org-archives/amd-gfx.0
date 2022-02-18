Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16596C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 07:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D65B10F029;
	Fri, 18 Feb 2022 07:13:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B921610F028
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE5cpJmMy55qMt3mSwQVUQuPhPlrfFe4GQnsLTCa3X/dK18efXr8AWRq4nuRiaSz/jIWxoyQBj9ulbIqxxaB9WaV3p9OSxfD36gw/y2p2W+3co1Nfl/Pk0i6Ye13roFV3h9gytekdeckLJLcxm8iUhkt0lGUN/0rdWIDwlOBoFuySoEA43K2j5nJg3XGaJbGKpc/Dol0F+F3Scmg5M9Dcf/SXmHlP5aguVIaRji0yUBq8P5sq7H/by7wd3iLGZp1D3cK+xgEYd0Uarwuw4cEBc/5VvBKH1YLAlT7lLQ9u2xHmotqnBHAf6WDTtJ7+ZM3akVlytBm2M9Y7qvUOHMjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HWkRfzslnB3CQP5ZMR7UZeiqukFz098T7LaF8+IqNc=;
 b=lWwgETnU+y/g283ggtMkcFM98aNiPHEH6NLKvjh/qtBf085BwqPgqxD8ufLu6wEQiQU253LYXLsSxHi23YOR914UA4iOwsbVSq4vKAP7Y4fUbwS7pKOKZCMGBeeibTnXdKpk3YOKJ8K1e879OfvG6aD2MHGLEIb1k/pRSd6ryRhS1ng7gcQXrBL4pm6nECF4D7WIUXpGy+Qv+t8GVQbMdqYdKSfM/bozZp1Pq/lIOL5D8/2DvceCKnRYGJ3qQdoTTalqtbNbqb+BRmCCS00mic28zYcuU1ZwO8Ou36GpaGuRL6dmH7pnZvDKoNx1HboFFlzHlQ3z6JKd5ei7yahulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HWkRfzslnB3CQP5ZMR7UZeiqukFz098T7LaF8+IqNc=;
 b=ptqyOx6SwZv1IygcmJA41jnxRqEtnT+viLwM/CyfTC8iA3FtrxC8ATY2vi5Ttmq7b4HmxyKD9hXL8HaJx/a0AYVaZtmvUoYvZnydwJjfq650FlRPvyiryDb4hUg1pzG1Ivbn9bNnh5YvB1FUEJ2BFKUjJ/2Ch25dTnW8OGzHEfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 07:13:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 07:13:29 +0000
Message-ID: <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
Date: Fri, 18 Feb 2022 08:13:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
Content-Language: en-US
To: Cal Peake <cp@absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65edd374-9b9c-468b-e27b-08d9f2ae29fc
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56374BC51966B2764C7E986083379@SA1PR12MB5637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7raNdb7d13AFwDNLT7L0eR70708n/tYdoFxi/Mo3QoufsQbYFwqtn0vUT+yD+G5J3z4NOhG8Q6QSMpvgB8UNk7RSTe2UBfR7MqFtielTnXtEg0RtyqQplgdosdQ2mPqd6NzQkbZhzO2NAOaxBOFydyAnA0Y/JCaUgBZOT2oAJgMl0iGMsFlcClU1XjOBCudXNdsoTR7lxJZbFDiVyBBcZEok3iqBBgWzYSmov1ln/cPVG2YRkhEQV1P8Bj6FKMc5gBTfFAqy+OFONuSSv3EDWIqZPFZj6FUcLrRVSH9Ws4QW0jeNOjQjiCcSNrImlQMiEEmGfycG99PnwpK9qBQ4pHQcksdDJbsZye0HINF4DDMC4cRLt0Yotwe+RT6FyzrT4DQBBBu5jz3rq/3d6d7lzZ5i4HJ893b+PP9zvpp+PD0vkyrJOsjD7VEArib+dibIK+OFHaekb38iKknMg0WgVz4jJZ88uelPmfjxAxxKGEdlZq9q4PhA00yacgjiP1kO8G5JFpSVLcWq/WE1oBHzs8bDSMH+VHZ5TNctc5jJAMASgak0ZdC4Eaw7S1EsvIVFuqXaIrz7TZId0zNIKtn8CRneLMkLY+d1DUghpB8f7C1pph2tLJbnXDdFoaaVOq2/l08/TTI7HwM2X5/mCOQiVRmN23ryLZUn5n21GvQtelxfene25cZ13cZv3MJ3EiqPYmV8Mp2pDhuWzshaeEKFNlK+SsF7rJW2bpIgQVsakmaTijxmlE6bW/zZIfqwiT8IAx7wXNp4bOb7eW7wrxcyXdb1bPZ9A1vi+rbNZGx1rtZS6ZpXauezF8kxOYkcqBym
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(316002)(36756003)(31686004)(31696002)(66556008)(4326008)(66476007)(26005)(186003)(8936002)(2616005)(83380400001)(5660300002)(86362001)(8676002)(6916009)(6506007)(966005)(508600001)(6486002)(38100700002)(6512007)(2906002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJueDA5c3FiN0FnNmJ0UEFoSTFCSW1iUS8rTG10V1NVTGhNVzQ2Z3lTc3hX?=
 =?utf-8?B?KzNUZGoySGJ5SnpDWTlyWW5qc2taa2w2Z29UREVGVnBpc0d5c1BVZ1VCZlNL?=
 =?utf-8?B?L3VES0MxYnJ4dytZV3l0UUJuUC9tcmtyUHlGSGF4Y1ZPMlRGVFNpUXdYcC9O?=
 =?utf-8?B?MXJCeE40TmxUUFdnMUdhNVpwKzlFOWY0SnJ3OElNQTM2RnZudWFVVFRnNVNs?=
 =?utf-8?B?ZjFUMnRNVmRUOCtxR2IwazVmYmVxRE9OMEhSd0lZbDJQNThja0U2Y2RWTUVD?=
 =?utf-8?B?dW1UREErMjJDQ0pwR2o1enpWZ01PMk1za1BvVVNwN2hJRWM4Rnd5Z3pVeng2?=
 =?utf-8?B?TE4wMGFUaERGY09HeDRmcWRZOVBPSkRybEhPanFtQzdmMXBVd1k0ZGpzTE9Z?=
 =?utf-8?B?ZVZnNzdpUlJlMWdTaE5ZS3pSTHM1R214ajdQcEZLUVJnNGFFRGJia3NyWndp?=
 =?utf-8?B?WHhZUHpKRkVCTWN2eHg1cDIwVEdIVis3Z1RxRnkxMUZwYU9MV3pmbTFBZFYw?=
 =?utf-8?B?bDVzZDdPeDBoOFdybXBkT00zWVBreEtUL3dPQXFQSWIyRDYvN1Z0SElpRzFk?=
 =?utf-8?B?bm5vN0VuUmcycTZ0aWZqc2lhTzl3ZG1Jb0tCL3F5MDZ4b2hOZGJWNEs1Q05x?=
 =?utf-8?B?UkdlR0k1cHBKV3VpM3A4OG1sdmZEcG93eHNGQU1aa0FvUEtNc2hSNzdsRjdP?=
 =?utf-8?B?a3dVVjVnK3EzWDdhOEFRdHF1YzRQWE04d1Q4ekNuaWhkMmpNVlRWQld1dEdz?=
 =?utf-8?B?NGhnbUsxMTArZTRQZHA5OThhczlWdVREenVaZ0VxVkRwN0I0ZFVaMHZBYkNP?=
 =?utf-8?B?bTE5OHdyU2pEK1JnamhRSXhIZytzVDlZOHd3T3BpYWJtZFp6dkVGNnZJS0Qy?=
 =?utf-8?B?dnZ0TDBlSGEzTWZldnUxYzZGUkE2YzdCdU5aZ24yNEg2akE4L0l5YkNGLzlp?=
 =?utf-8?B?UEIvK2dlRnRIVWF0eTM3RUZjMnNhWlhSSzhsd0RTWkhXRFBlbmpVOTQyamNW?=
 =?utf-8?B?YUJPRVJ3UFdnNHg0ckE1OFd2UDB6cXFsYSsxQW1xZHJveW1QK0tFUDhXQ05K?=
 =?utf-8?B?QS9OKytEM1ZsN3h2SEQ1b1FkN0JkZGQrVFoxM3ZDd2hTMWVKR2R0YWlROHlv?=
 =?utf-8?B?Q0J0N2JVcCt6bno0TzBBR0VUbWlmOUYxdE9UZzNtUGcrNjNhT0dsV0lybzZV?=
 =?utf-8?B?YlpOOGlnMUxTb00wdTcvcEVZd3lwUzVZeXNzUUxPMTdVLzJzKzB6SW5vdTNn?=
 =?utf-8?B?Wm1EME5FYWZHajRQR2hoVWUwMCtyZWF6aDRsNjhkc0NIWmRPVEdBdjBQeG9W?=
 =?utf-8?B?OEF0TzF6dlk4KzZUamxLejJNd0EzMURBbGt4QlpEOURVa05uYXVpM0s1VjFE?=
 =?utf-8?B?NmpHOGhvTHNmRTQwTEJVblpiVkowbUM2MHQ5Qm11TXZWNjRQcmRVNWZaOHJ6?=
 =?utf-8?B?cUdJQkVhdmszWWo4bURFOXhtenRCcFpwKzhiT2pEUVRTQjhVaUxsSjV3RXh2?=
 =?utf-8?B?c0QzcXdWOEVubXlUbCtRaHdReUpuc0FIYzI5VTM2R3hwK2Q1U3NzTjFDNWYv?=
 =?utf-8?B?cHBLV0dZaXlqN2tyN0hRR1hvTUxmR0NXb1ZXOFhTSFNYdnlhcEJ1Rk5xbmtq?=
 =?utf-8?B?Y1pRMzRGSEV5bnd3eTRLeUpER2U2eDBOUVRrSUFNcXE4Q2VvaHVBMzNzVGFX?=
 =?utf-8?B?bk5BQnBnQkZuM2o5ejUzZmF1WFVHOWZVdXhOeGlSOWZPa290dWtNS01CUXlv?=
 =?utf-8?B?R2lPWWR5VGxqd2JKcUR5bU1NaUdmanNGajlReGx5Vm96clVUUDVkNUZjc05i?=
 =?utf-8?B?THpFTW5BdndtV1ZXZ1F0V1NnL2syUFVGOWl4amp2K25CcGxwcHJpd0ZiMkth?=
 =?utf-8?B?M3ZNeHRIclg4OEhnd0wwK2pRVGk2TmRKY1N1dUdzclhmemtJRjR0WlVHVlNR?=
 =?utf-8?B?cy9ldlB1YTJlZHBORmk2S3FnUlJzOWF3V21jY3RxQ0pYRmpwTXJ3TzYxYkpK?=
 =?utf-8?B?NzlBOTREc0w4a1FwTktZTVlWYllIY2tlR2NDb25RY1QxSkNPZkRaUUUvejVs?=
 =?utf-8?B?emMrT25LMFVxdWR2THdVc2RFdDhOZGd6N1JVT0d3d29SVlJxMHFselQwM0hL?=
 =?utf-8?Q?seSw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65edd374-9b9c-468b-e27b-08d9f2ae29fc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 07:13:29.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFJguYILjxG3tKliEhD0plTBkQwihwu1a4vPsudCjTtk4IL2oDNeUdNl8rBOxTkK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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

Am 17.02.22 um 19:10 schrieb Cal Peake:
> On Thu, 17 Feb 2022, Christian König wrote:
>
>> Ok, at least it doesn't sounds like it is the power supply.
> I was able to procure an 800W PSU just to give it a try, and at first it
> seemed to make a difference. The drivers would fully load, but after a
> short amount of time things would become unstable and the system would
> crash or reset. Very bizarre...

Maybe check if any of the capacitors on the motherboard or RX6500 looks 
damaged. Here are some examples what they normally look like: 
https://en.wikipedia.org/wiki/Capacitor

When capacitors are damaged they usually look like a balloon instead of 
a cylinder because electrolyte liquid inside started to boil because of 
a shortcut.

Capacitors are used to suppress voltage and spikes and valleys. When 
they are damaged the electronics might still work, but becomes unreliable.

>> Unfortunately not of hand. You could try to play around with the power flags,
>> but from your description it sounds like you already did that.
>>
>> Only other option I see is to try a different motherboard and/or Windows with
>> that hardware. If that also doesn't work there must be some hardware fault on
>> the RX6500.
> That was my thinking too. I got the idea to try Windows after I did the
> PSU swap and, like Linux, it was okay at first, but then started crashing
> and resetting. Either the card is defective or it really doesn't like my
> motherboard.

That's a really strong evidence that you have a hardware problem here.

BTW: Where do you got that hardware from? Is it used or a new one? Was 
it maybe used for mining?

Regards,
Christian.

>
> Thanks very much for your help!
>

