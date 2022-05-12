Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C03AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 13:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE98112021;
	Thu, 12 May 2022 13:15:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01BD11201B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 13:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX/ma5fr1S6/2WeMrdsgfKC07Y6PYTCvh6G4vdJE4hBf1RU+JIlu62burlobej28OpJ87vinUJFwzWC0WrNF+xwiPuLRD5a5PYxGyE9WANH6jBkijxpCiL4JWeTw6WEc+2GxrpQGRMozeTEqnLVaM98wvqoTnZbQBkbKL3lJjcLFR6a8q1aL/8TpSMq61Z21hVsEA3o9ltD9RemdJ6HKCy0bagejrx35SMTdiI6r82XSWxYOlmvjN1iKlDEP6aS5onxGNBfXY8KFScTUYaa/g9nDeVCH9ZD8/+pCMzjwqp1PH8kIVzQeBQ8pBRmPdNAAL1zquXw2K5QxP8K9sISRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5QKTGwOKt36wo5jxWKNRvkUY/UhCGzKxo9SiAlVy24=;
 b=bTlAElKeDsl2s+koXDvFuvf/+Lxa8WnpynvuI3+yRFUoXDISfEMpnrX07oLQraiGXBMBgV247T+BxkC5D512Bxfsk/JTThZi3045lxG9S2qY6wczhhKNMy5bOGszxOyEczyFnKqMha3p8DT+1nzFCh8jj+mZTFjO3Ga31T/ptCKZQd+zZvurm7oxllCvmEvxb1SD4W9hxqCxA47UFPqvgObM1UHF1MEd7aPi436r05BPwxVXkqOt6niEvylgk0SQkRaxG2lnNYXu0GovLrrgFtX/fezZy+2VDls+V85tRD85dDPDXvuL6RLegyJ5eCgjFnvrTK1p32iam1oTbssP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5QKTGwOKt36wo5jxWKNRvkUY/UhCGzKxo9SiAlVy24=;
 b=ghj+sKkcoHdU69K5w9tSzOOIz6WTkE6gHTT8W7dFBbJ3YlZgEPnlz1zKn/jB5JGv00Yakd6FOuuxqpUrnfkb2cfCZwCrfs5LHBVQCTaeBb8ntySfvhXZ7qr+mFlsB1fqoTsMG0zN5ESshVUuXH+3O5k79t+zlhsSXGhyB7KxWkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 13:15:54 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::557c:5a0c:56ac:3af]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::557c:5a0c:56ac:3af%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 13:15:54 +0000
Message-ID: <14483921-e454-1ad7-ff45-665366158504@amd.com>
Date: Thu, 12 May 2022 15:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <b9fd9cf5-1ae1-a599-576d-74f13b0351d5@amd.com>
 <4e88f5a0-11b7-ac14-ce77-7e69c2ce75c1@amd.com>
 <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f626173-de7b-479a-7665-08da34198b19
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1381D5CE4B8AAAF99B678D9B83CB9@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTQd3F8PGeL27EBBAVdrcah5zjKGNHWl5qQshkXOX+05bWPKI3Xb+f6QjQX2NMTQq6dgMQWR55naMIObi9K5oFDTFSGAz8lL1W2X2iOGpkXci3rRIOoGTjyl0SR3FBGJWTrOLw4vHGGmON3QaWOZ1JIUmri0cKCo7NUt1DOndDl/qjzcf+cxmtxWwsQ3issRbsA3jMg3cbddAQQPB0nOaPJyq3KqMtvt60dAk5ofslTX5OGDIaxWEiYJfGP9MskRmcFKlAe9nygWojEmVrGD7bOhs2oH3el+cVDCrhvD95Hmz352UXpB9I8e68lJLJjwl2PBizFX19YcVfP2jV28oTG+RvnFBZd9uC7WZr57ltAKo61AnqfpdDz1buL1pMBITlA0Ga3FdA1LYMZxdqusleAH8H31cLrsrXmQWTZMKP9Xidc4mDzmTwB+2i9cCDOthf2A5La1u9EICocyxLnsBPQS0c3M50A4FYcgKfpZIsjT9/U/I9hx8hiMmCnwCavY1tut0+Z75ouVqAex1xV1BqHG1hCnHQln9oLe9i327EV5F33rTPs+ZLmGI9EJU8u/FQhxr8N/2bL97g/1DdsydJEIC605u+N6nI6DArULJP2DWBeXsrlWBdIF9lvg8Itb+0UFi59CnVIT9sc0gXB2CgxLXaEeCtr64qmkGwv6JYHvM5NuP6NwC9KHw9eRMPk07G3B5kK7gdcBa9ncuk7PLsZEw7xS7a6OdCVmW4/4utqRlkMA9FWK1wFzlCnslyEkIqw9xtyjdBeQxDoqeKI6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(5660300002)(110136005)(6506007)(6512007)(26005)(83380400001)(2906002)(6666004)(8936002)(66946007)(316002)(53546011)(30864003)(31686004)(38100700002)(508600001)(6486002)(66476007)(66556008)(4326008)(8676002)(86362001)(36756003)(31696002)(2616005)(66574015)(116466001)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVXWDJNbiszNVVZMHNmOUplanZCaTRlOTJnL2Q1d1gyZmhJRXBzRGVtQ24z?=
 =?utf-8?B?bnpMS0ZLem9mTEhpV0x5SldQTmVVUURUU3k5eDBta1BqWXF4c3k0TDZVV1RU?=
 =?utf-8?B?OUZuNWZpUk1wVXBTcklGd3E3QlVFY01WVFZEUnAyeTh1Yjl3ZDBVYmVzcFhk?=
 =?utf-8?B?TEdxRWg3MTY5MmlyK0w0MDNrRVJ5cEV1MUtMaEp5alVQc3ZlcEUxRUsrRHc0?=
 =?utf-8?B?MFZ3TTcvL0JnbXJ0UmhEOVNpVFY3NExvR3dlVGppblA3cjg1anJuVFlpWUg5?=
 =?utf-8?B?OTUwRGh3d0JCSXNZbGJmTkprVjZBdlJnaEhrWGQzNG9xQUppbmRndllCVEJj?=
 =?utf-8?B?aGNpMWhrVVZsU2o1L1RFWFB5V2NBVlYwWkxiZGRmVk1HUVAzVzhSUUZGNkFV?=
 =?utf-8?B?a2xhL1hvZkRqSG12RVNLMzVZZFpmT01ib0RjdnYwUlpQZ1ZUMUg1eFdiem5u?=
 =?utf-8?B?b1EvVEE0L216Q2VWWmNpNGkyWXo4OTRmc2xGTVlOL0RPMVQ0S25KNU84eTFF?=
 =?utf-8?B?NUpQQ1FIZ2J1UjhDdXJFTUFsNTNOd0I1UmJ0M2YzbEtRMTQ5SThHaXplWEx3?=
 =?utf-8?B?MUc0Vy9OVHZLZWNmVC90UlhicjgzRVdoSUpqWnRFdGtzbXdIekcyT2FrK2pa?=
 =?utf-8?B?dlNKMHEwWXd4c1R1eFVkVkc1QWlPTms1NFB2MWZudEdVeGNMMFR5dy84dnk2?=
 =?utf-8?B?b0xCZi83Z2FZRmM5U3dmQmZEeS95VzJCck15dkxCaSt4d3pjcGQyY0dsWG5B?=
 =?utf-8?B?aWlNVGpDUFVWNTdmZS9lRmI2SEo4QkZqSDJxaktadXlrUThpTmNXNTFVSGdL?=
 =?utf-8?B?OEVJVDVxTzJTYXAwTHcrNHEyRVE1bGExenJuQkUxWmpIdkp2WXpycnhMdjU4?=
 =?utf-8?B?d2lLODYvRjhTeVdMWStiMVBjVkp2b1l4cXdZVnJIZjdWRUNKR2JzSFNrbHNK?=
 =?utf-8?B?TEp5bGNpcmpvc2hGY3lOQkxwLzlSaVFWMkR1dkwwUDA5QzN2VVY4VEMyWWlB?=
 =?utf-8?B?RzV2aGlCdzFVNzJZZXBZanRGdi9UQ3JIdzRGdFNCN0ZldlVRRUtiNVVhUXdx?=
 =?utf-8?B?SDJzc3VZSlc5eW53NHd2QUY1NG5CYmtJWm9hRCtWTWt1WWR6TVNKTE0xeUFT?=
 =?utf-8?B?NWVDaHJCOENzd1F6Yk1VS0x4MkIvSGtqL1NEbnpFRGwwSDVmVnRxZER0cFVE?=
 =?utf-8?B?TExsQlVSNC92YnhJWCtvQUhXMXdqMnZOVnNIaDdROC80RlBUSzR0cGpkTFNC?=
 =?utf-8?B?dkZicVcrRnhBUU9UNzZhMW9ZaTQvNFg2dUpHU0V1SGw5UkdPTi8zaDBUM0Uy?=
 =?utf-8?B?b0V3Y0swaHFMZlZUeTg2a2F5di80S01RdXl0aVQ1R25CTkpSOWJzaHRLV0kv?=
 =?utf-8?B?bGRHMUhFdXNmTGFSTG85MWtoYWxBemFPTFlPVEYrSzdyK3Vhcll5TTJWeFov?=
 =?utf-8?B?QWt4UmtDZjJJNmtmN3JJTWlNaEFhbXJ6bmduVlZRWXVHSjJMRnZYdXllcnRG?=
 =?utf-8?B?Yi8rYnc2N0xFRmJDcUkxRmlvdFN0dEx0am1ZUW1Gc1drRkJtZ2Y3UWJJZ2JG?=
 =?utf-8?B?SEhkc1JiZ1RXUXdQTUlPRHhQazFhWTllbysrSGdhdGZiamVIVFdpQkl6Tk01?=
 =?utf-8?B?blVrcVhBWDJzb3ByMDRIV0dDdDJUUlMxTDA3MTU1S2FGMkVrdHdnL1Juc3Vt?=
 =?utf-8?B?V2hmaFhIekovWUg5Qm1rVFF3V29lMXJZcmI5a2VYejR3WDVrL2t0TStiaG5O?=
 =?utf-8?B?LzQ2QzhJaUFGQlJZNTQzOFNSOTBFWWpLSE9CaGV6c2hrbHhGc2VOZGc1Y1BS?=
 =?utf-8?B?UjFLeDRvN0ZkaXh5aW52QVo0TVpzeHR0YmVJRGJuUFFGR2xiSlZJdE93b3Z4?=
 =?utf-8?B?VFZhRXFGTjN4aDhnUFhabzR0T1g1WlhGSU5tekM4UXVOeU8vRTNUTVVRQ1k1?=
 =?utf-8?B?Z3pVOXUyRzIrR0hGWU00em5XOStrcUMwSlhWYkhWRTRIU1lVTld5MU9FbG1X?=
 =?utf-8?B?b0J1V2JuSFV4elJOeXFhVzc4MHhhUmR5RDNxdGhyR3NRVWRiQ1dJdHN1TW9J?=
 =?utf-8?B?MzlHODgxNVJKQ0RzS1FUMHdTYXlpTjJYSms2WWVFUzdtL0lNSTJFbnBQMENu?=
 =?utf-8?B?aWxyemI2bHBWa0NQczJHMGNGNzcvZHpnRjV2QmwyL0lhd2dQajRKM2c1bnpv?=
 =?utf-8?B?MG5aTXN6d09CRklnR24wd1M3Z1ZRd040Q2hnUG0yWWxYKzh1SVl1MlZ5SUNE?=
 =?utf-8?B?QmNoZkpvMWlYL2Nwd1NSSllxRlozdkJRMFkydlZGREFKQ1VrWnAzYVRoekVn?=
 =?utf-8?B?NHN1R3c2eWdISk45SUhzTjVLVWNhQmNyM2QyUXltSGlsSkE3WTZWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f626173-de7b-479a-7665-08da34198b19
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:15:54.2781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv/bQJfpKV6WHNFmqdlKMbNgLVfzoEPzQ6AcqU5je1UTy4GKzOBQPgXr+uGxJfCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.05.22 um 15:07 schrieb Andrey Grodzovsky:
>
> On 2022-05-12 02:06, Christian König wrote:
>> Am 11.05.22 um 22:27 schrieb Andrey Grodzovsky:
>>>
>>> On 2022-05-11 11:39, Christian König wrote:
>>>> Am 11.05.22 um 17:35 schrieb Andrey Grodzovsky:
>>>>> On 2022-05-11 11:20, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 5/11/2022 7:28 PM, Christian König wrote:
>>>>>>> Am 11.05.22 um 15:43 schrieb Andrey Grodzovsky:
>>>>>>>> On 2022-05-11 03:38, Christian König wrote:
>>>>>>>>> Am 10.05.22 um 20:53 schrieb Andrey Grodzovsky:
>>>>>>>>>> [SNIP]
>>>>>>>>>>> E.g. in the reset code (either before or after the reset, 
>>>>>>>>>>> that's debatable) you do something like this:
>>>>>>>>>>>
>>>>>>>>>>> for (i = 0; i < num_ring; ++i)
>>>>>>>>>>> cancel_delayed_work(ring[i]->scheduler....)
>>>>>>>>>>> cancel_work(adev->ras_work);
>>>>>>>>>>> cancel_work(adev->iofault_work);
>>>>>>>>>>> cancel_work(adev->debugfs_work);
>>>>>>>>>>> ...
>>>>>>>>>>>
>>>>>>>>>>> You don't really need to track which reset source has fired 
>>>>>>>>>>> and which hasn't, because that would be racy again. Instead 
>>>>>>>>>>> just bluntly reset all possible sources.
>>>>>>>>>>>
>>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I don't say we care if it fired once or twice (I need to add 
>>>>>>>>>> a fix to only insert reset work to pending reset list if it's 
>>>>>>>>>> not already there), the point of using list (or array) to 
>>>>>>>>>> which you add and from which you remove is that the logic of 
>>>>>>>>>> this is encapsulated within reset domain. In your way we need 
>>>>>>>>>> to be aware who exactly schedules reset work and explicitly 
>>>>>>>>>> cancel them, this also means that for any new source added in 
>>>>>>>>>> the future you will need to remember to add him
>>>>>>>>>
>>>>>>>>> I don't think that this is a valid argument. Additionally to 
>>>>>>>>> the schedulers we probably just need less than a handful of 
>>>>>>>>> reset sources, most likely even just one or two is enough.
>>>>>>>>>
>>>>>>>>> The only justification I can see of having additional separate 
>>>>>>>>> reset sources would be if somebody wants to know if a specific 
>>>>>>>>> source has been handled or not (e.g. call flush_work() or 
>>>>>>>>> work_pending()). Like in the case of a reset triggered through 
>>>>>>>>> debugfs.
>>>>>>>>
>>>>>>>>
>>>>>>>> This is indeed one reason, another is as we said before that if 
>>>>>>>> you share 'reset source' (meaning a delayed work) with another 
>>>>>>>> client (i.e. RAS and KFD) it means you make assumption that the 
>>>>>>>> other client always proceeds with the
>>>>>>>> reset exactly the same way as you expect. So today we have this 
>>>>>>>> only in scheduler vs non scheduler reset happening - non 
>>>>>>>> scheduler reset clients assume the reset is always fully 
>>>>>>>> executed in HW while scheduler based reset makes shortcuts and 
>>>>>>>> not always does HW reset hence they cannot share 'reset source' 
>>>>>>>> (delayed work). Yes, we can always add this in the future if 
>>>>>>>> and when such problem will arise but no one will remember this 
>>>>>>>> then and a new bug will be introduced and will take time to 
>>>>>>>> find and resolve.
>>>>>>>
>>>>>>> Mhm, so your main concern is that we forget to correctly handle 
>>>>>>> the new reset sources?
>>>>>>>
>>>>>>> How about we do it like this then:
>>>>>>>
>>>>>>> struct amdgpu_reset_domain {
>>>>>>>      ....
>>>>>>>      union {
>>>>>>>          struct {
>>>>>>>              struct work_item debugfs;
>>>>>>>              struct work_item ras;
>>>>>>>              ....
>>>>>>>          };
>>>>>>>          struct work_item array[]
>>>>>>>      } reset_sources;
>>>>>>> }
>>>>>>>
>>>>>>
>>>>>> If it's only about static array,
>>>>>>
>>>>>> enum amdgpu_reset_soruce {
>>>>>>
>>>>>> AMDGPU_RESET_SRC_RAS,
>>>>>> AMDGPU_RESET_SRC_ABC,
>>>>>> .....
>>>>>> AMDGPU_RESET_SRC_XYZ,
>>>>>> AMDGPU_RESET_SRC_MAX
>>>>>>
>>>>>> };
>>>>>>
>>>>>> struct work_struct reset_work[AMDGPU_RESET_SRC_MAX]; => An index 
>>>>>> for each work item
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>
>>>>>
>>>>> It's possible though it makes harder to generalize reset_domain 
>>>>> later for other drivers.
>>>>> But still one caveat, look at amdgpu_recover_work_struct and it's 
>>>>> usage in amdgpu_device_gpu_recover and in gpu_recover_get,
>>>>> At least for debugfs i need to return back the result of GPU reset 
>>>>> and so I cannot store actual work items in the array mentioned above
>>>>> but rather pointers to work_item because i need a way to get back 
>>>>> the return value from gpu_recover like I do now in 
>>>>> amdgpu_device_gpu_recover.
>>>>
>>>> You should try to avoid that as well.
>>>>
>>>> See when the debugfs reset is canceled because of a scheduler reset 
>>>> you won't get a useful return code either.
>>>>
>>>> What we should do instead is to cache the status of the last reset 
>>>> in the reset domain.
>>>>
>>>> Regards,
>>>> Christian.
>>>
>>>
>>> Another problem with this approach -  to execute  the actaul GPU 
>>> reset I need accesses  to concrete amdgpu_device pointer from work 
>>> struct (see xgpu_ai_mailbox_flr_work) as example. If i store all 
>>> work items in
>>> array in amdgpu_reset_domain the most i can only retrieve is the 
>>> reset_domain struct itself which won't help since it's dynamically 
>>> allocated, not embedded in hive or adev and can can be one per 
>>> device or per entire hive in case of XGMI and so there is no way for 
>>> me to reach back to amdgpu_device. Back pointer to adev* from 
>>> amdgpu_reset_domain will only work for single device but not for 
>>> XGMI hive where there are multiple devices in a hive.
>>
>> Which is exactly the reason why I think we should always allocate the 
>> hive structure, even if we only have one device. And a GPU reset 
>> should then always work with the hive data structure and not adev.
>
>
> I am not sure why HIVE is the object we should work with, hive is one 
> use case, single device is another, then Lijo described something 
> called partition which is what ? Particular pipe within GPU ?. What 
> they all share in common
> IMHO is that all of them use reset domain when they want a recovery 
> operation, so maybe GPU reset should be oriented to work with reset 
> domain ?

Yes, exactly that's the idea.

Basically the reset domain knowns which amdgpu devices it needs to reset 
together.

If you then represent that so that you always have a hive even when you 
only have one device in it, or if you put an array of devices which 
needs to be reset together into the reset domain doesn't matter.

Maybe go for the later approach, that is probably a bit cleaner and less 
code to change.

Christian.

>
> Andrey
>
>
>>
>> Adding a pointer from your reset work item back to the hive is then 
>> trivial.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>>> Not 100% sure if that works, but something like that should do 
>>>>>>> the trick.
>>>>>>>
>>>>>>> My main concern is that I don't want to allocate the work items 
>>>>>>> on the stack and dynamic allocation (e.g. kmalloc) is usually 
>>>>>>> not possible either.
>>>>>>>
>>>>>>> Additional to that putting/removing work items from a list, 
>>>>>>> array or other container is a very common source for race 
>>>>>>> conditions.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>>>> to the cancellation list which you showed above. In current 
>>>>>>>>>> way all this done automatically within reset_domain code and 
>>>>>>>>>> it's agnostic to specific driver and it's specific list of 
>>>>>>>>>> reset sources. Also in case we would want to generalize 
>>>>>>>>>> reset_domain to other GPU drivers (which was
>>>>>>>>>> a plan as far as i remember) this explicit mention of each 
>>>>>>>>>> reset works for cancellation is again less suitable in my 
>>>>>>>>>> opinion.
>>>>>>>>>
>>>>>>>>> Well we could put the work item for the scheduler independent 
>>>>>>>>> reset source into the reset domain as well. But I'm not sure 
>>>>>>>>> those additional reset sources should be part of any common 
>>>>>>>>> handling, that is largely amdgpu specific.
>>>>>>>>
>>>>>>>>
>>>>>>>> So it's for sure more then one source for the reasons described 
>>>>>>>> above, also note that for scheduler we already cancel delayed 
>>>>>>>> work in drm_sched_stop so calling them again in amdgpu code 
>>>>>>>> kind of superfluous.
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Andrey
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The only difference is I chose to do the canceling right 
>>>>>>>>>>>>>> BEFORE the HW reset and not AFTER. I did this because I 
>>>>>>>>>>>>>> see a possible race where a new reset request is being 
>>>>>>>>>>>>>> generated exactly after we finished the HW reset but 
>>>>>>>>>>>>>> before we canceled out all pending resets - in such case 
>>>>>>>>>>>>>> you wold not want to cancel this 'border line new' reset 
>>>>>>>>>>>>>> request.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Why not? Any new reset request directly after a hardware 
>>>>>>>>>>>>> reset is most likely just falsely generated by the reset 
>>>>>>>>>>>>> itself.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Ideally I would cancel all sources after the reset, but 
>>>>>>>>>>>>> before starting any new work.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> You can see that if many different reset sources share 
>>>>>>>>>>>>>>>>> same work struct what can happen is that the first to 
>>>>>>>>>>>>>>>>> obtain the lock you describe bellow might opt out from 
>>>>>>>>>>>>>>>>> full HW reset because his bad job did signal for 
>>>>>>>>>>>>>>>>> example or because his hunged IP block was able to 
>>>>>>>>>>>>>>>>> recover through SW reset but in the meantime another 
>>>>>>>>>>>>>>>>> reset source who needed an actual HW reset just 
>>>>>>>>>>>>>>>>> silently returned and we end up with unhandled reset 
>>>>>>>>>>>>>>>>> request. True that today this happens only to job 
>>>>>>>>>>>>>>>>> timeout reset sources that are handled form within the 
>>>>>>>>>>>>>>>>> scheduler and won't use this single work struct but no 
>>>>>>>>>>>>>>>>> one prevents a future case for this to happen and 
>>>>>>>>>>>>>>>>> also, if we actually want to unify scheduler time out 
>>>>>>>>>>>>>>>>> handlers within reset domain (which seems to me the 
>>>>>>>>>>>>>>>>> right design approach) we won't be able to use just 
>>>>>>>>>>>>>>>>> one work struct for this reason anyway.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Just to add to this point - a reset domain is 
>>>>>>>>>>>>>>>> co-operative domain. In addition to sharing a set of 
>>>>>>>>>>>>>>>> clients from various reset sources for one device, it 
>>>>>>>>>>>>>>>> also will have a set of devices like in XGMI hive. The 
>>>>>>>>>>>>>>>> job timeout on one device may not eventually result in 
>>>>>>>>>>>>>>>> result, but a RAS error happening on another device at 
>>>>>>>>>>>>>>>> the same time would need a reset. The second device's 
>>>>>>>>>>>>>>>> RAS error cannot return seeing that a reset work 
>>>>>>>>>>>>>>>> already started, or ignore the reset work given that 
>>>>>>>>>>>>>>>> another device has filled the reset data.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> When there is a reset domain, it should take care of 
>>>>>>>>>>>>>>>> the work scheduled and keeping it in device or any 
>>>>>>>>>>>>>>>> other level doesn't sound good.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> Lijo
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I'd put the reset work struct into the reset_domain 
>>>>>>>>>>>>>>>>>> struct. That way you'd have exactly one worker for 
>>>>>>>>>>>>>>>>>> the reset domain. You could implement a lock-less 
>>>>>>>>>>>>>>>>>> scheme to decide whether you need to schedule a 
>>>>>>>>>>>>>>>>>> reset, e.g. using an atomic counter in the shared 
>>>>>>>>>>>>>>>>>> work struct that gets incremented when a client wants 
>>>>>>>>>>>>>>>>>> to trigger a reset (atomic_add_return). If that 
>>>>>>>>>>>>>>>>>> counter is exactly 1 after incrementing, you need to 
>>>>>>>>>>>>>>>>>> fill in the rest of the work struct and schedule the 
>>>>>>>>>>>>>>>>>> work. Otherwise, it's already scheduled (or another 
>>>>>>>>>>>>>>>>>> client is in the process of scheduling it) and you 
>>>>>>>>>>>>>>>>>> just return. When the worker finishes (after 
>>>>>>>>>>>>>>>>>> confirming a successful reset), it resets the counter 
>>>>>>>>>>>>>>>>>> to 0, so the next client requesting a reset will 
>>>>>>>>>>>>>>>>>> schedule the worker again.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>   Felix
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Additional to that keep in mind that you can't 
>>>>>>>>>>>>>>>>>>>> allocate any memory before or during the GPU reset 
>>>>>>>>>>>>>>>>>>>> nor wait for the reset to complete (so you can't 
>>>>>>>>>>>>>>>>>>>> allocate anything on the stack either).
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> There is no dynamic allocation here, regarding stack 
>>>>>>>>>>>>>>>>>>> allocations - we do it all the time when we call 
>>>>>>>>>>>>>>>>>>> functions, even during GPU resets, how on stack 
>>>>>>>>>>>>>>>>>>> allocation of work struct in 
>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover is different from any 
>>>>>>>>>>>>>>>>>>> other local variable we allocate in any function we 
>>>>>>>>>>>>>>>>>>> call ?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I am also not sure why it's not allowed to wait for 
>>>>>>>>>>>>>>>>>>> reset to complete ? Also, see in 
>>>>>>>>>>>>>>>>>>> amdgpu_ras_do_recovery and gpu_recover_get (debugfs) 
>>>>>>>>>>>>>>>>>>> - the caller expects the reset to complete before he 
>>>>>>>>>>>>>>>>>>> returns. I can probably work around it in RAS code 
>>>>>>>>>>>>>>>>>>> by calling atomic_set(&ras->in_recovery, 0) from 
>>>>>>>>>>>>>>>>>>> some callback within actual reset function but 
>>>>>>>>>>>>>>>>>>> regarding sysfs it actually expects a result 
>>>>>>>>>>>>>>>>>>> returned indicating whether the call was successful 
>>>>>>>>>>>>>>>>>>> or not.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I don't think that concept you try here will work.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Also in general seems to me it's cleaner approach 
>>>>>>>>>>>>>>>>>>>>> where this logic (the work items) are held and 
>>>>>>>>>>>>>>>>>>>>> handled in reset_domain and are not split in each 
>>>>>>>>>>>>>>>>>>>>> adev or any other entity. We might want in the 
>>>>>>>>>>>>>>>>>>>>> future to even move the scheduler handling into 
>>>>>>>>>>>>>>>>>>>>> reset domain since reset domain is supposed to be 
>>>>>>>>>>>>>>>>>>>>> a generic things and not only or AMD.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky 
>>>>>>>>>>>>>>>>>>>>>>>>> <andrey.grodzovsky@amd.com>
>>>>>>>>>>>>>>>>>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu.h | 11 +---
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 
>>>>>>>>>>>>>>>>>>>>>>>>> 17 +++--
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 73 
>>>>>>>>>>>>>>>>>>>>>>>>> +++++++++++++++++++++-
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 3 +-
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>>   8 files changed, 104 insertions(+), 24 
>>>>>>>>>>>>>>>>>>>>>>>>> deletions(-)
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>>>     #define MAX_GPU_INSTANCE 16
>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -509,16 +510,6 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_allowed_register_entry {
>>>>>>>>>>>>>>>>>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>>>> -};
>>>>>>>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>>>>>>>>>>>>>>>>>       u32 codec_type;
>>>>>>>>>>>>>>>>>>>>>>>>>       u32 max_width;
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5201,6 +5201,12 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>> tmp_vram_lost_counter = 
>>>>>>>>>>>>>>>>>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +    /* Drop all pending resets since we will 
>>>>>>>>>>>>>>>>>>>>>>>>> reset now anyway */
>>>>>>>>>>>>>>>>>>>>>>>>> +    tmp_adev = 
>>>>>>>>>>>>>>>>>>>>>>>>> list_first_entry(device_list_handle, struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>>>>>>>>>>>>>>>> + reset_list);
>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(tmp_adev->reset_domain); 
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>>>>>>>>>>>>>>>>>       /* Host driver will handle XGMI hive 
>>>>>>>>>>>>>>>>>>>>>>>>> reset for SRIOV */
>>>>>>>>>>>>>>>>>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5296,7 +5302,7 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>>>>>>>>>>>>>>>>>       int ret;
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5304,7 +5310,7 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base);
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>> recover_work->ret = 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>>>>>>>>>>>>>>>>>> recover_work->job);
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5316,12 +5322,15 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_recover_work_struct work = 
>>>>>>>>>>>>>>>>>>>>>>>>> {.adev = adev, .job = job};
>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>>>>>>>>>>>>>>>>>         if 
>>>>>>>>>>>>>>>>>>>>>>>>> (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>> &work.base))
>>>>>>>>>>>>>>>>>>>>>>>>>           return -EAGAIN;
>>>>>>>>>>>>>>>>>>>>>>>>>   - flush_work(&work.base);
>>>>>>>>>>>>>>>>>>>>>>>>> + flush_delayed_work(&work.base.base);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>> &work.base);
>>>>>>>>>>>>>>>>>>>>>>>>>         return work.ret;
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>>>>>>>>>>>>>>>>>>> *amdgpu_reset_create_reset_domain(enum 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_d
>>>>>>>>>>>>>>>>>>>>>>>>> atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> init_rwsem(&reset_domain->sem);
>>>>>>>>>>>>>>>>>>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_init(&reset_domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>       return reset_domain;
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>   diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>>>>>>>>>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/list.h>
>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_device;
>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_job;
>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>>> AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>>>> +enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>>>       unsigned long flags;
>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct list_head handler_list;
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -76,12 +100,21 @@ enum 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_type {
>>>>>>>>>>>>>>>>>>>>>>>>>       XGMI_HIVE
>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct delayed_work base;
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head node;
>>>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>>>>>>>>>>>>>>>>>       struct kref refcount;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>>>>>>>>>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>>>>>>>>>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_put_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *dom
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>     static inline bool 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_schedule(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>>>> - struct work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +    if (!queue_delayed_work(domain->wq, 
>>>>>>>>>>>>>>>>>>>>>>>>> &work->base, 0)) {
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> +        return false;
>>>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + list_add_tail(&work->node, 
>>>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +    return true;
>>>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&work->node);
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, 
>>>>>>>>>>>>>>>>>>>>>>>>> *tmp;
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>> + list_for_each_entry_safe(entry, tmp, 
>>>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&entry->node);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> +        /* Stop any other related pending 
>>>>>>>>>>>>>>>>>>>>>>>>> resets */
>>>>>>>>>>>>>>>>>>>>>>>>> + cancel_delayed_work(&entry->base);
>>>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>     void 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_lock_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>>>>>>>>>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS (1 
>>>>>>>>>>>>>>>>>>>>>>>>> << 0) /* vBIOS is sr-iov ready */
>>>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV (1 << 
>>>>>>>>>>>>>>>>>>>>>>>>> 1) /* sr-iov is enabled on this GPU */
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>>>>>>>>>>>>>>>>>       uint32_t reg_val_offs;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src ack_irq;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src rcv_irq;
>>>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_mm_table mm_table;
>>>>>>>>>>>>>>>>>>>>>>>>>       const struct amdgpu_virt_ops *ops;
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_vf_error_buffer vf_errors;
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work(struct work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -380,7 +380,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -389,6 +390,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>     static int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_request_init_data(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work(struct work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -407,7 +407,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -416,6 +417,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_virt_ops = {
>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work(struct work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -610,7 +610,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>> @@ -619,6 +620,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_virt_ops = {
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>
>>

