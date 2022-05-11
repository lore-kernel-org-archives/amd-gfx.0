Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1C0C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 15:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518EF10E887;
	Wed, 11 May 2022 15:46:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDA910E270
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 15:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVQgsYcd00zmhfcIhM2qxYPr6XOlB1Ej0HbunDPIVZM18IS+OStaRl975vHYb6SAg+8YtuZscElP//WHsElHsvuaj93taTBulgzgnbTYR2+O0h6teChUFPWzora3BEN9sw2UfHBQhAq647u+gwsXYnhYcjg9RyfaRNX/8hhrvlNh0gjYWnp0yRCmQ9dLgLZsep/j3SnPjIwK7D5VBlTq7XqqJeyEeyYWtdTNYFL6UffT7SLWTHNATZogTqLSvrq2KiOgOPmN9kvsLTLGWsLBpOWoXwOpFUSqrh1Nu4+zK41qOIDs57oDxnkXzoElWoldvotkbZqPq30BFlCtRTOh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMwsAzXo4VyLx+Y1slnyMDBr1YqHA7s7pzajQ9aaowE=;
 b=DZP8b/d/myVJLYhpbmh4jLRkbq6K4JrRNlMuAzQIqJvRgEgzvgolZmlmkxRibHM3eTGazC/x77ZGmadV8kS9Wyef9EfByeN2dc37M3GfahE+KBLBEFJwaE9gy7T0u64XwCs5YMIhjQkVympo+R4VncJYC/RKI8PQFd3Azfphucp1rb67x/5zQzpdkrd0KbeMWq2JPxFZiq10QAsLFD+Vo6QauCWiO8PMqv1wCP6VQBBcEyLN4mY7bZMO4X4Mh8gY62+S4g3nfgBShreOvG3Nxzxln+7CAlIkLAxojQwCT+rflqiKI0U0QbXBfMVLT+zrSqBX5wLbjMmp3g+tc2n5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMwsAzXo4VyLx+Y1slnyMDBr1YqHA7s7pzajQ9aaowE=;
 b=GErBlw/o2trE/W3dipIvnCDAberkFVCqvwKkY4u/t9QYXakYS68fJF/zsdyWdnX97TX8LvG4LU7yJ/vlbw2Ye5UwUFPZfwWEK95VV77jXNyqQEkqDmAeuvX+XmTEf/nlTLUZJ76I/Co50OsccyyUvN1VqcEIuEp1oizEecrR2gE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 15:46:31 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 15:46:31 +0000
Message-ID: <ca3c5b0b-4ff4-8bd8-83a7-9b09961539ff@amd.com>
Date: Wed, 11 May 2022 21:16:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
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
 <e5c8d83f-5b8d-8820-404d-94df6021b4ec@amd.com>
 <1541fe10-1424-d9ec-c4bb-4fd5cb1e671d@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1541fe10-1424-d9ec-c4bb-4fd5cb1e671d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a0f16f-de17-46b0-7edc-08da33656b61
X-MS-TrafficTypeDiagnostic: CH0PR12MB5300:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53001EFB626C1773A6806FE297C89@CH0PR12MB5300.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ko6PT7pEaQIrPxglG1ukfTQ4lNbV1VSwjotVrxDeTSLnuecqYlzObZ6MrmboD+/CS8F3Q7PVNHi4Y3TUXM8JSKwTc1AyOT0GkGAnNB8IuzJ9W/xnlLN7Yji1HONKLovBDziIoAGTRP/txDH9Rqy4GeUuaXG8qUssZuleyZDu7/hoZzaLKz5rkWQwwOfqkg0r7Qx/Tu9Lmu00dsH7o2f8NAQi2dlt19Uap1Mg+jkWCZeOOhHq+0pcWac+0YkVP6Y7foS+a9wzcweyKD6/PNYlggN+aKUHF0f3EKSE0I2Kyw7kGCxjiJbqQ8Jv9qq+KJihY3ouP6siHaTVM4dvecYTTVB6T+eJ9PhrGNrjizwMrw+vRhfjylkcnvJk9f2aF/McAMFN9gp3P5FpZ14DfJM0iyVIcF5E+esTHQljNQVZtSxOTK3OsnxSrahUY/MojRrbO3crnbbpkeEoIWMF45/FG6JrMt7cjhaRIbMcjhh7xjmC93FW6Qy/1wgcw3NIy6kvh4a10XjYRNf1UUdA35VrdQuoO4LOk4aEuDhC84+A+PLyuu22Lt4S9YWFuuAj4jrWBhxu4Bcqj0MLZdVxUQm53gVwQo0poRyA6yfi+tqxWnkaT+p3JDc2SwpTCWi3LQbb2L8bqir9kTwpkhJW6/JppjRsTYHJUFPg1P5AWyF9TGbLglI2K8wkqnmPaUqUtlL7ntk1pfoqc5vAdqeZFswPqtSWECbJwav+4NHfe5IAPv/M3Jjgty8oX3InKHioZVho
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(66574015)(6512007)(26005)(31686004)(4326008)(36756003)(8676002)(186003)(66556008)(110136005)(66946007)(66476007)(316002)(31696002)(6666004)(2906002)(53546011)(86362001)(6506007)(5660300002)(508600001)(6486002)(8936002)(83380400001)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWErc3U2djE0dEhneFYzVmRSbXlDelY4RWtJMU5wMmZJY2xGVnRseFlKN2d4?=
 =?utf-8?B?VEhHNUpseDI4MVlvUGhiNFlmM2tOU2s0UVg3T1Y5ZWo4aTg3bFc3WmhiK3o4?=
 =?utf-8?B?cVN6UEtlR2l6dXlKbTFHSmJkYlcwYitMUStaa2R4TXRHblE1OTlrVnJvdURI?=
 =?utf-8?B?a3JWYXgxY09BWGE2RkU4dUZPQWxUeWpZZkhlcGNHUUxMSFl1VHMvN29xZ3VR?=
 =?utf-8?B?VEZEUjhsOERySnA1dm44SFR2VTkzVXJsTXFqaGQ5K24rWVJnazVkbXQ0eGJE?=
 =?utf-8?B?cDdhUFI2dXRaekppclZZYnBzOEhwNXlYMjd6SC9iZ2pMM1IweXd3U0o2Qi9w?=
 =?utf-8?B?dVExdGhUZk9mbTFIdkVXN0J5cHBIeU4wck5LZTRRWXhlT0V2VklwVGZpczhQ?=
 =?utf-8?B?YnJ4U0prcTRyM0ZXdC9xenkzYWE2SnZyd1FEaUNaVmgvK0VqQ0VIU3MxbDFx?=
 =?utf-8?B?b3c5VEpaYUc4K0F1YnozbXdZNFd5VEJ4aW50UGxaQlRCUnd5SThFT2VPcVdB?=
 =?utf-8?B?VVFwKzZYZTBlcXJKVkU2eUhaemF2V2FjMkZZcTVFZThyRGIwdzFQT0tlejNX?=
 =?utf-8?B?eUxJWHEzQllJUzg5Wk5sL0dEcGV6aGJ5ckVyb2dWUEpBUGNxeW5rdEgxZXpm?=
 =?utf-8?B?L0t3cURNTkcxUjAxZDFDWW4zYmR5YmtNVW1aYlhBeGNaU3cxN0NRSnc5TDhu?=
 =?utf-8?B?V0w4ZnlrWHBZa1ZJUTlraG8zK1h6RnIrZUU5OU5tQ1JJcXh4cEZlR21XSTYy?=
 =?utf-8?B?elRRd2R4cXNnUFpPODlWZXh2MHhSUzhTZzk0RUowSkE0U0dMMlduMmJNek53?=
 =?utf-8?B?MnVUbWMvcjFYUkRGR3FiWm5OUE1KVGtQQW9LaTJwY2gxaE84YVhEeVMxeWwy?=
 =?utf-8?B?MHFFU042ZEROQkxXSEV4VkRYdFU3a1F4ZGdRZ3R0ZGh0eVBqeFo5NVQydFdG?=
 =?utf-8?B?SGdRbUQ3SEMvMlR1V0J6cGM3eXIxUFZkdDIyNXNjYXlNRm84SmZMUm93a2sx?=
 =?utf-8?B?ZnY0eGkyYUhnaWhnTnJteFdQUjE2TGxZeUdyZHhnVVo5Y1JHMGZ3SEZCWU9m?=
 =?utf-8?B?K0RFQjFLdm1pMm9oeHFUdzA3TkRMTmJVQW5VS05xeEh1MTZoSW8zL2R6Q050?=
 =?utf-8?B?VGI4MEZ2N09ib3VzYVVQUVB2THBVZWQxekNFU2pQS1h0OWVyeWYvU09kaGhG?=
 =?utf-8?B?Qkd6YTJCcEVyNUZKZ2RwMjB3cEg3dDlGWjV5TkJ0KzhuRVBpc1N1T2tLOU1H?=
 =?utf-8?B?MEZERGo5dXI0cjZ4bHdjKzY3SVRGMGlxTENsRTkwVndVOVdaNldoZmNZOUsr?=
 =?utf-8?B?QmZlYVkzNXlXbktrTWNaSjREQmZvN2pPdHlCTXZwaC9TQ3NxWVJYaHhxeWFl?=
 =?utf-8?B?K3ZoVUJCY1Z6VEVRU2NkOXI5SEszdXNYcGFNTUpjekx2RHQ2R1ptUjF6anRu?=
 =?utf-8?B?MVltQk5VYnY5OGhFZGFJVExnV0drSEZXNnQ3NnpwQlJXUE5NZ0pRVGMyVlgx?=
 =?utf-8?B?YkVPVThMejVxYkhOT0dyd1NaRzVjK2VLak5QRlJDOUVuY0EwaG5xS3gzTytv?=
 =?utf-8?B?Q3hqTDQrSHB2cDJRWS9Zdm52bnl3dHBYallzMHlzaC9HYUNpcU5aL0pNeFVU?=
 =?utf-8?B?c3YvUW5oT1lqZ3JvRTZJbWtGUUFXdlYvRDAwSGNBalhIM2o0M0hnTkd1TVhF?=
 =?utf-8?B?dUkyMFdhcnNFVmUvRVJSZTBIN2pjbnJhbE1PN1BWV3k2MXNOQ3pNYVI1Ni91?=
 =?utf-8?B?VndiclNIakpXUFloMlBjWEFVM3lWTkZzQWh4TnFyRE9XNWxPWElyWEtuaHBt?=
 =?utf-8?B?dWJxczFOMTJMVnE1VGtrcFRsSisyU3l5L0VEaDNTUklmOGxVd1A1bVNSZHRP?=
 =?utf-8?B?WlMzb09mSVd3czV4di85YXAzUnB5cWVvMFI3QjlhcmlXamFiZElpR0lBUXZE?=
 =?utf-8?B?U2Rjb3czb3BXRjJWOGtObndQUVJzc20zcEx6M3YzQklaUmRkaDkxUk5vbHhN?=
 =?utf-8?B?T1VEejRJY053RFhWUzZTeUFWS2NmUzRhSXd1Y1R3RG0vclF5NlFncFN0N3hz?=
 =?utf-8?B?Q3ZscENMc2FxajlGWUQvL0tsSWU3WlV6M2RGN1hVRG5uVEdaZ2xGaGVhL1RT?=
 =?utf-8?B?VmVMT2dnQmJnTmNVeDhRU21VbTJUc1FxaTZxTDN1M01uSXh5RWtucVd5aDNM?=
 =?utf-8?B?WTFVVU5pWXpBSmoydFNmTTA2aS9RNnYvYmMrajNNUlBQcHR0QndVVTRFdHR3?=
 =?utf-8?B?Q3RtLytURVR3VlBWRGQ0RlJwM1psTmgwR29FQzNObm4vOGErcGttcWdBUGpV?=
 =?utf-8?B?YWplUnYrbG5hR20zbUk4cHZhYUVOaDhEdTNDZ0lNRkVoTnB5UFZydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a0f16f-de17-46b0-7edc-08da33656b61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:46:31.6048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTNHCnqgYIl4Da/Q7hC9pvbvxvd6cHexzj3eb4afjkGcjKaCZHkrVQI7MIB3LwSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
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



On 5/11/2022 9:13 PM, Andrey Grodzovsky wrote:
> 
> On 2022-05-11 11:37, Lazar, Lijo wrote:
>>
>>
>> On 5/11/2022 9:05 PM, Andrey Grodzovsky wrote:
>>>
>>> On 2022-05-11 11:20, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 5/11/2022 7:28 PM, Christian König wrote:
>>>>> Am 11.05.22 um 15:43 schrieb Andrey Grodzovsky:
>>>>>> On 2022-05-11 03:38, Christian König wrote:
>>>>>>> Am 10.05.22 um 20:53 schrieb Andrey Grodzovsky:
>>>>>>>> [SNIP]
>>>>>>>>> E.g. in the reset code (either before or after the reset, 
>>>>>>>>> that's debatable) you do something like this:
>>>>>>>>>
>>>>>>>>> for (i = 0; i < num_ring; ++i)
>>>>>>>>>     cancel_delayed_work(ring[i]->scheduler....)
>>>>>>>>> cancel_work(adev->ras_work);
>>>>>>>>> cancel_work(adev->iofault_work);
>>>>>>>>> cancel_work(adev->debugfs_work);
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> You don't really need to track which reset source has fired and 
>>>>>>>>> which hasn't, because that would be racy again. Instead just 
>>>>>>>>> bluntly reset all possible sources.
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>
>>>>>>>> I don't say we care if it fired once or twice (I need to add a 
>>>>>>>> fix to only insert reset work to pending reset list if it's not 
>>>>>>>> already there), the point of using list (or array) to which you 
>>>>>>>> add and from which you remove is that the logic of this is 
>>>>>>>> encapsulated within reset domain. In your way we need to be 
>>>>>>>> aware who exactly schedules reset work and explicitly cancel 
>>>>>>>> them, this also means that for any new source added in the 
>>>>>>>> future you will need to remember to add him
>>>>>>>
>>>>>>> I don't think that this is a valid argument. Additionally to the 
>>>>>>> schedulers we probably just need less than a handful of reset 
>>>>>>> sources, most likely even just one or two is enough.
>>>>>>>
>>>>>>> The only justification I can see of having additional separate 
>>>>>>> reset sources would be if somebody wants to know if a specific 
>>>>>>> source has been handled or not (e.g. call flush_work() or 
>>>>>>> work_pending()). Like in the case of a reset triggered through 
>>>>>>> debugfs.
>>>>>>
>>>>>>
>>>>>> This is indeed one reason, another is as we said before that if 
>>>>>> you share 'reset source' (meaning a delayed work) with another 
>>>>>> client (i.e. RAS and KFD) it means you make assumption that the 
>>>>>> other client always proceeds with the
>>>>>> reset exactly the same way as you expect. So today we have this 
>>>>>> only in scheduler vs non scheduler reset happening - non scheduler 
>>>>>> reset clients assume the reset is always fully executed in HW 
>>>>>> while scheduler based reset makes shortcuts and not always does HW 
>>>>>> reset hence they cannot share 'reset source' (delayed work). Yes, 
>>>>>> we can always add this in the future if and when such problem will 
>>>>>> arise but no one will remember this then and a new bug will be 
>>>>>> introduced and will take time to find and resolve.
>>>>>
>>>>> Mhm, so your main concern is that we forget to correctly handle the 
>>>>> new reset sources?
>>>>>
>>>>> How about we do it like this then:
>>>>>
>>>>> struct amdgpu_reset_domain {
>>>>>      ....
>>>>>      union {
>>>>>          struct {
>>>>>              struct work_item debugfs;
>>>>>              struct work_item ras;
>>>>>              ....
>>>>>          };
>>>>>          struct work_item array[]
>>>>>      } reset_sources;
>>>>> }
>>>>>
>>>>
>>>> If it's only about static array,
>>>>
>>>> enum amdgpu_reset_soruce {
>>>>
>>>> AMDGPU_RESET_SRC_RAS,
>>>> AMDGPU_RESET_SRC_ABC,
>>>> .....
>>>> AMDGPU_RESET_SRC_XYZ,
>>>> AMDGPU_RESET_SRC_MAX
>>>>
>>>> };
>>>>
>>>> struct work_struct reset_work[AMDGPU_RESET_SRC_MAX]; => An index for 
>>>> each work item
>>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>
>>>
>>> It's possible though it makes harder to generalize reset_domain later 
>>> for other drivers.
>>
>> The current reset domain queue design is not good for a hierarchichal 
>> reset within amdgpu itself :)
>>
>> Thanks,
>> Lijo
> 
> 
> Not sure what do you mean ?
> 

It's tied to the TDR queue in scheduler.

Hierarchichal model - start from reset of lowest level nodes and on 
failure try with a higher level reset. This model doesn't suit that.

Thanks,
Lijo

> Andrey
> 
> 
>>
>>> But still one caveat, look at amdgpu_recover_work_struct and it's 
>>> usage in amdgpu_device_gpu_recover and in gpu_recover_get,
>>> At least for debugfs i need to return back the result of GPU reset 
>>> and so I cannot store actual work items in the array mentioned above
>>> but rather pointers to work_item because i need a way to get back the 
>>> return value from gpu_recover like I do now in 
>>> amdgpu_device_gpu_recover.
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>> Not 100% sure if that works, but something like that should do the 
>>>>> trick.
>>>>>
>>>>> My main concern is that I don't want to allocate the work items on 
>>>>> the stack and dynamic allocation (e.g. kmalloc) is usually not 
>>>>> possible either.
>>>>>
>>>>> Additional to that putting/removing work items from a list, array 
>>>>> or other container is a very common source for race conditions.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>>> to the cancellation list which you showed above. In current way 
>>>>>>>> all this done automatically within reset_domain code and it's 
>>>>>>>> agnostic to specific driver and it's specific list of reset 
>>>>>>>> sources. Also in case we would want to generalize reset_domain 
>>>>>>>> to other GPU drivers (which was
>>>>>>>> a plan as far as i remember) this explicit mention of each reset 
>>>>>>>> works for cancellation is again less suitable in my opinion.
>>>>>>>
>>>>>>> Well we could put the work item for the scheduler independent 
>>>>>>> reset source into the reset domain as well. But I'm not sure 
>>>>>>> those additional reset sources should be part of any common 
>>>>>>> handling, that is largely amdgpu specific.
>>>>>>
>>>>>>
>>>>>> So it's for sure more then one source for the reasons described 
>>>>>> above, also note that for scheduler we already cancel delayed work 
>>>>>> in drm_sched_stop so calling them again in amdgpu code kind of 
>>>>>> superfluous.
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The only difference is I chose to do the canceling right 
>>>>>>>>>>>> BEFORE the HW reset and not AFTER. I did this because I see 
>>>>>>>>>>>> a possible race where a new reset request is being generated 
>>>>>>>>>>>> exactly after we finished the HW reset but before we 
>>>>>>>>>>>> canceled out all pending resets - in such case you wold not 
>>>>>>>>>>>> want to cancel this 'border line new' reset request.
>>>>>>>>>>>
>>>>>>>>>>> Why not? Any new reset request directly after a hardware 
>>>>>>>>>>> reset is most likely just falsely generated by the reset itself.
>>>>>>>>>>>
>>>>>>>>>>> Ideally I would cancel all sources after the reset, but 
>>>>>>>>>>> before starting any new work.
>>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Andrey
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> You can see that if many different reset sources share 
>>>>>>>>>>>>>>> same work struct what can happen is that the first to 
>>>>>>>>>>>>>>> obtain the lock you describe bellow might opt out from 
>>>>>>>>>>>>>>> full HW reset because his bad job did signal for example 
>>>>>>>>>>>>>>> or because his hunged IP block was able to recover 
>>>>>>>>>>>>>>> through SW reset but in the meantime another reset source 
>>>>>>>>>>>>>>> who needed an actual HW reset just silently returned and 
>>>>>>>>>>>>>>> we end up with unhandled reset request. True that today 
>>>>>>>>>>>>>>> this happens only to job timeout reset sources that are 
>>>>>>>>>>>>>>> handled form within the scheduler and won't use this 
>>>>>>>>>>>>>>> single work struct but no one prevents a future case for 
>>>>>>>>>>>>>>> this to happen and also, if we actually want to unify 
>>>>>>>>>>>>>>> scheduler time out handlers within reset domain (which 
>>>>>>>>>>>>>>> seems to me the right design approach) we won't be able 
>>>>>>>>>>>>>>> to use just one work struct for this reason anyway.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Just to add to this point - a reset domain is co-operative 
>>>>>>>>>>>>>> domain. In addition to sharing a set of clients from 
>>>>>>>>>>>>>> various reset sources for one device, it also will have a 
>>>>>>>>>>>>>> set of devices like in XGMI hive. The job timeout on one 
>>>>>>>>>>>>>> device may not eventually result in result, but a RAS 
>>>>>>>>>>>>>> error happening on another device at the same time would 
>>>>>>>>>>>>>> need a reset. The second device's RAS error cannot return 
>>>>>>>>>>>>>> seeing that a reset work already started, or ignore the 
>>>>>>>>>>>>>> reset work given that another device has filled the reset 
>>>>>>>>>>>>>> data.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> When there is a reset domain, it should take care of the 
>>>>>>>>>>>>>> work scheduled and keeping it in device or any other level 
>>>>>>>>>>>>>> doesn't sound good.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> Lijo
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'd put the reset work struct into the reset_domain 
>>>>>>>>>>>>>>>> struct. That way you'd have exactly one worker for the 
>>>>>>>>>>>>>>>> reset domain. You could implement a lock-less scheme to 
>>>>>>>>>>>>>>>> decide whether you need to schedule a reset, e.g. using 
>>>>>>>>>>>>>>>> an atomic counter in the shared work struct that gets 
>>>>>>>>>>>>>>>> incremented when a client wants to trigger a reset 
>>>>>>>>>>>>>>>> (atomic_add_return). If that counter is exactly 1 after 
>>>>>>>>>>>>>>>> incrementing, you need to fill in the rest of the work 
>>>>>>>>>>>>>>>> struct and schedule the work. Otherwise, it's already 
>>>>>>>>>>>>>>>> scheduled (or another client is in the process of 
>>>>>>>>>>>>>>>> scheduling it) and you just return. When the worker 
>>>>>>>>>>>>>>>> finishes (after confirming a successful reset), it 
>>>>>>>>>>>>>>>> resets the counter to 0, so the next client requesting a 
>>>>>>>>>>>>>>>> reset will schedule the worker again.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>   Felix
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Additional to that keep in mind that you can't 
>>>>>>>>>>>>>>>>>> allocate any memory before or during the GPU reset nor 
>>>>>>>>>>>>>>>>>> wait for the reset to complete (so you can't allocate 
>>>>>>>>>>>>>>>>>> anything on the stack either).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> There is no dynamic allocation here, regarding stack 
>>>>>>>>>>>>>>>>> allocations - we do it all the time when we call 
>>>>>>>>>>>>>>>>> functions, even during GPU resets, how on stack 
>>>>>>>>>>>>>>>>> allocation of work struct in amdgpu_device_gpu_recover 
>>>>>>>>>>>>>>>>> is different from any other local variable we allocate 
>>>>>>>>>>>>>>>>> in any function we call ?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I am also not sure why it's not allowed to wait for 
>>>>>>>>>>>>>>>>> reset to complete ? Also, see in amdgpu_ras_do_recovery 
>>>>>>>>>>>>>>>>> and gpu_recover_get (debugfs) - the caller expects the 
>>>>>>>>>>>>>>>>> reset to complete before he returns. I can probably 
>>>>>>>>>>>>>>>>> work around it in RAS code by calling 
>>>>>>>>>>>>>>>>> atomic_set(&ras->in_recovery, 0) from some callback 
>>>>>>>>>>>>>>>>> within actual reset function but regarding sysfs it 
>>>>>>>>>>>>>>>>> actually expects a result returned indicating whether 
>>>>>>>>>>>>>>>>> the call was successful or not.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I don't think that concept you try here will work.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Also in general seems to me it's cleaner approach 
>>>>>>>>>>>>>>>>>>> where this logic (the work items) are held and 
>>>>>>>>>>>>>>>>>>> handled in reset_domain and are not split in each 
>>>>>>>>>>>>>>>>>>> adev or any other entity. We might want in the future 
>>>>>>>>>>>>>>>>>>> to even move the scheduler handling into reset domain 
>>>>>>>>>>>>>>>>>>> since reset domain is supposed to be a generic things 
>>>>>>>>>>>>>>>>>>> and not only or AMD.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky 
>>>>>>>>>>>>>>>>>>>>>>> <andrey.grodzovsky@amd.com>
>>>>>>>>>>>>>>>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu.h | 11 +---
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 
>>>>>>>>>>>>>>>>>>>>>>> +++--
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 73 
>>>>>>>>>>>>>>>>>>>>>>> +++++++++++++++++++++-
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 3 +-
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>   8 files changed, 104 insertions(+), 24 
>>>>>>>>>>>>>>>>>>>>>>> deletions(-)
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>     #define MAX_GPU_INSTANCE 16
>>>>>>>>>>>>>>>>>>>>>>>   @@ -509,16 +510,6 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_allowed_register_entry {
>>>>>>>>>>>>>>>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>> -};
>>>>>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>>>>>>>>>>>>>>>       u32 codec_type;
>>>>>>>>>>>>>>>>>>>>>>>       u32 max_width;
>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>> @@ -5201,6 +5201,12 @@ int 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>> tmp_vram_lost_counter = 
>>>>>>>>>>>>>>>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    /* Drop all pending resets since we will 
>>>>>>>>>>>>>>>>>>>>>>> reset now anyway */
>>>>>>>>>>>>>>>>>>>>>>> +    tmp_adev = 
>>>>>>>>>>>>>>>>>>>>>>> list_first_entry(device_list_handle, struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>>>>>>>>>>>>>> + reset_list);
>>>>>>>>>>>>>>>>>>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>>>>>>>>>>>>>>>       /* Host driver will handle XGMI hive reset 
>>>>>>>>>>>>>>>>>>>>>>> for SRIOV */
>>>>>>>>>>>>>>>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>>>>>>>>>>>>>> @@ -5296,7 +5302,7 @@ int 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct base;
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>>>>>>>>>>>>>>>       int ret;
>>>>>>>>>>>>>>>>>>>>>>> @@ -5304,7 +5310,7 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base);
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base.base.work);
>>>>>>>>>>>>>>>>>>>>>>> recover_work->ret = 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>>>>>>>>>>>>>>>> recover_work->job);
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>> @@ -5316,12 +5322,15 @@ int 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>> *adev,
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_recover_work_struct work = 
>>>>>>>>>>>>>>>>>>>>>>> {.adev = adev, .job = job};
>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&work.base, 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>>>>>>>>>>>>>>>         if 
>>>>>>>>>>>>>>>>>>>>>>> (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base)) 
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>           return -EAGAIN;
>>>>>>>>>>>>>>>>>>>>>>>   - flush_work(&work.base);
>>>>>>>>>>>>>>>>>>>>>>> + flush_delayed_work(&work.base.base);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>> &work.base);
>>>>>>>>>>>>>>>>>>>>>>>         return work.ret;
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>>>>>>>>>>>>>>>>> *amdgpu_reset_create_reset_domain(enum 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_d
>>>>>>>>>>>>>>>>>>>>>>> atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>>>>>>>>>>>>>>> init_rwsem(&reset_domain->sem);
>>>>>>>>>>>>>>>>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>> + mutex_init(&reset_domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>       return reset_domain;
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>   diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>>>>>>>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/list.h>
>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_device;
>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_job;
>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>> AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>> +enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>>>>>>>>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>       unsigned long flags;
>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>>>>>>>>>>>>>>>       struct list_head handler_list;
>>>>>>>>>>>>>>>>>>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>>>>>>>>>>>>>>>>>>       XGMI_HIVE
>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>>>>>>>>>>>>>>>> +    struct delayed_work base;
>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head node;
>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>>>>>>>>>>>>>>>       struct kref refcount;
>>>>>>>>>>>>>>>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>>>>>>>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>>>>>>>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>>>>>>>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>>>>>>>>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_put_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *dom
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>     static inline bool 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_schedule(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>> - struct work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    if (!queue_delayed_work(domain->wq, 
>>>>>>>>>>>>>>>>>>>>>>> &work->base, 0)) {
>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> +        return false;
>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + list_add_tail(&work->node, 
>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    return true;
>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&work->node);
>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>> + list_for_each_entry_safe(entry, tmp, 
>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&entry->node);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +        /* Stop any other related pending resets */
>>>>>>>>>>>>>>>>>>>>>>> + cancel_delayed_work(&entry->base);
>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>>>>>>>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS (1 << 
>>>>>>>>>>>>>>>>>>>>>>> 0) /* vBIOS is sr-iov ready */
>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV (1 << 1) 
>>>>>>>>>>>>>>>>>>>>>>> /* sr-iov is enabled on this GPU */
>>>>>>>>>>>>>>>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>>>>>>>>>>>>>>>       uint32_t reg_val_offs;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src ack_irq;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src rcv_irq;
>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_mm_table mm_table;
>>>>>>>>>>>>>>>>>>>>>>>       const struct amdgpu_virt_ops *ops;
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_vf_error_buffer vf_errors;
>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>> *adev,
>>>>>>>>>>>>>>>>>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct 
>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>   @@ -380,7 +380,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>> @@ -389,6 +390,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_put_irq(struct amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>     static int xgpu_ai_request_init_data(struct 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>> *adev,
>>>>>>>>>>>>>>>>>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct 
>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>   @@ -407,7 +407,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>> @@ -416,6 +417,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>> = {
>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>> *adev,
>>>>>>>>>>>>>>>>>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct 
>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>>>>>>>>>>>>>>>> @@ -610,7 +610,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_get_irq(struct amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>> @@ -619,6 +620,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_put_irq(struct amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>> = {
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
