Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A89C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 11:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15FB10E1AB;
	Mon, 17 Jan 2022 11:44:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C372F10E195
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 11:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnACRGDa2VKc5XoucAsvOIAvnRp/lpSPWhMtISmHc/c84aZscb24UZjSHCiNQ730laZWLw30cX9FJbDW982RB8BpeDndoa3GeEUt9B4nqmIoBYi/hioXWZPuhV09FmK2+7HqrkW4LXG9zxZB7oMG6eKUN8+7mJCO6D5QKcJAw9fFUlC05j12tJfeELuZEcAtbUa76s04ejL1l3VTj8pLiqt/8X/vJUR0r8w8C7ESz10nKXgo//5CvDqDsiv27r9Ln9XEljqKGb8OU18MLyvoUtzi/k4l2o7cDcH9lhYTxJCVLVBw5WkV4iALCekBc6tbWVu3CX4znRRLQNS3EnZyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMowjnPYo1CrvVq6CPGTAgTt5sF1dvoKrow3I2aRmYA=;
 b=JiY+GkMGWKLBDzBDVONU+jEobgF17Hp6xMc91Xc+1pBE/B5Bu6Cg+v3rsFopuwE4RCUb9aI81HlT8jJdb8JzUg7Jycyo4a8bKAnpmWUhqY9jPFrzPxokL/B3Deio0HYYc07fSHZaFJ1+jojz9YmJJxkplvBYlk3mBaTKQII2LaQo1hwuMtkeMEsXilRXMlzsnbJMpIKUeMG4xBcs53KxzKvrvmw6x6G36HMA88ZLeonCHzcHK7SByhXpfqqNyfmlj5GqNlqRZax1CHwQXMU98aCgYGSxUD+veqkyA235CwVRu0uydDKWg+dfcxbkFm/G+DxyWEYiJKvKYIz4WtUzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMowjnPYo1CrvVq6CPGTAgTt5sF1dvoKrow3I2aRmYA=;
 b=FF/SAmgF9DvLvCs1SsiTnqmot8eWF8JrPcZ8pm/99RNMaA3jrsloRYSk5plvsnAZkxMBe7kkw2n4ZUDUD4cIEAO9MgoOsNg1rNHuHWB3YKxyPRvgMryKdzL+Dg6VF3AuacMqzdmK/+qdMPxmP/O2Q0S0q6SjCItiwjfLsPHyd5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 11:44:05 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 11:44:05 +0000
Message-ID: <7a082b06-179a-22dc-e176-3f6d46a1deeb@amd.com>
Date: Mon, 17 Jan 2022 12:43:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
 <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
 <10fe91c4-9078-8937-5dac-0625d38c2ea3@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <10fe91c4-9078-8937-5dac-0625d38c2ea3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05322979-3cc8-4034-5b03-08d9d9aeaa16
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5055BAD1F5AF92EC71E8AFF8F2579@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t6ZYsvbdWQMBO3JTEEHUr0mt13g0qwXeKd3RmL95pnfJsRJtlnlykxfnN2D6ENLOsA6p//9Kgw51A7ZaHg4eo81ab5LWfIvDtZcS4iyhqJ51BpamhKyJswbS5jXm0Ya0md4Ut2T1/4/XZ/A18pYbgWVpQSGqOhfdeTdpuXhzLWsidMUO1pxGcC7/P8v1hSbeNCbx+EW2F1DeBuzJMExgUbl+dJc6aQ52Lu+WWCG3P0/n/NR+sgBQNlSl3c32jlmB/W2RTRyRZX47yMJYrVU8Lp14RVQBza+4T1cwvM87myaq196kwWzScIwSTttYUM1ApLDnStNAK8IJA5LFSrmzMqoNr+PuNL/FWwNqQ0A4tYxzr82zm/5rQknD0Wgb5xmpJBs+tHGd0jWTR2h6i6CQcGBb5DyYn1wKbQxWkdsYT9f3+xXuh3lkUPGo7Eq2p0HqRYbMAbeagq7XqqU0Yws48fTSOJzVeh+xrQUj5qWOpAqg6h3tC72mgTaBmjFS6lTJ0KeIQkggd/8s5gDDSjxJns4ZY3D96r2rXmwE5XAd9+TpUyErslTr+EeCl/xzYEqsHKRaL1r5xWdrCHmBlhRGvELeGbbLb+aH3Mty8dDeJb0fNTUy+Z0TIdDRA3nxY65fSXkWrpNE5Dd1FeHmV+b1cLHYyp7j39+dugR+mEF/4dNJe3NwV6DE2bFkx8JQHu3nlN0IvZUYi+2ne7BDf8Iz/o6tFzxSfnBVAnP6rlpsgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(8676002)(66476007)(36756003)(6666004)(26005)(4744005)(186003)(508600001)(86362001)(5660300002)(31686004)(83380400001)(66556008)(66946007)(316002)(6506007)(6486002)(38100700002)(110136005)(2616005)(4326008)(53546011)(2906002)(6512007)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU8yanBwT1NRbTNkVHVoZGNEdGdQcDhkK0tJTDkxR1U3cUd1MGIyTDVzUVhT?=
 =?utf-8?B?enJtWnBUaW9BM2pKOUtCVlhpQ2ZOWEdQdFJjN3JoMDlUOVNrYU9XVUp2eXkw?=
 =?utf-8?B?U2s4L1ZZMWhDdDd5enRUV3JYK09QMUNSUnJ5SC83REs1SXI1TWVjeHpRT05v?=
 =?utf-8?B?RTRvemF0OU1FL29LN0grOTFoZDAxWnJURE5tSlBiZ2VuN0NmanlCR0hWTHky?=
 =?utf-8?B?NWdrd1JIQlpTL0hVMFlqaGR3RDRSWUEvOS9mdGZlVjhaOW9TODN4dk1EOTZv?=
 =?utf-8?B?Q3pRNm1sVk1sMk01ZG8vYmJnY2xSQnhwaDJ0a284SUd0czJnQkdadXBuVHBu?=
 =?utf-8?B?ODhwVk13N21sOG0vTWlMNFZnV0s4TFVoQTRaU2xzSTdaWEw0dzJmL1NSUHRH?=
 =?utf-8?B?U1Z5emdjdXhqNEY3YnVSQWQwNVNxcmJrU3ZTSGhoVkoydGVpMVpyV2E2L3dn?=
 =?utf-8?B?SFhRTkt0aGN4SmhTMFRnYURHN1VrQ2N6dlhFbGU4OWk5c2MyejNLekVqSnZE?=
 =?utf-8?B?a1M5N1IyMGNUOVc0RzRhU0hCV2lOeVBaRTVGbHE0QVVZN1JJM1hFbkVQVSsx?=
 =?utf-8?B?SWpRTVBQck1Ja01Reld2OWxvRjdPcTlYdnJ4R2o1cVRlUklQMlhhV3VvQ21T?=
 =?utf-8?B?ZDFQY3VacXkyZjg1L0FIUFQwOHlWNWFRczYxN1BjUzJ0RkI3eGk0clhtOHdz?=
 =?utf-8?B?YkZ3NjEyVnRKQWI5QWxGREJBRlhQRDUwSzRiMFFseStpVk9JdWVSY1Nadm5R?=
 =?utf-8?B?OFZtaTBkUm9wVnNTRXZmYm84a0doWnlPV0FOWnhpcE1ibG1SR2ZXUFpmSWls?=
 =?utf-8?B?b3E5NDlUekJPSHB6cjU5RjhUYjNmbjRvZ3hZY3I5UHlzVGJ4eGtvV3NodzFq?=
 =?utf-8?B?NGNYWnMrM3RiL0RnZzlVdGJ0M2gxSjZ1bzhKelc1S2hESU5xbWhSeWViMFQx?=
 =?utf-8?B?SStDODdZOFo5RndiazV5Y09xa016TERzQzNyU3h3cFhwTUxsR2NEUnRvV1Fm?=
 =?utf-8?B?bHVYQXlKTHhhTkVTci9TQkpNcTB5eFVQMWJ5QkE4WGY4YklVc3NhSHVrMVFj?=
 =?utf-8?B?ZTRBdnRUdGV5N2JodWdjMFlJLzFqWkRwUkp1Q3dydUc0bVhNTU5rYUlBTXNL?=
 =?utf-8?B?UnlVNXZaTkZZTmRBM0sxU0dvRUNBRTN3aE1FRmYrNlhvamZZdUMrcldYbk1F?=
 =?utf-8?B?VnhZZmFpK2NqZXpSQnNuUSt3RjVkRGVHWVZxY3NOQzhPaFhmQWNwY1pFME51?=
 =?utf-8?B?UWxseC83WHFVc2ttV1o1UjI4V1Fkd1BhZVVJVS8wSExHSkxMQmJVS1pWTVhy?=
 =?utf-8?B?cDkrWGE4NWJHOHlWblNTR3lRcmlSWmFpNVpWbFVKaVpid0V4bittZW9TeUs0?=
 =?utf-8?B?T1ZmaGt6RXRNRDhsZlpOS3prOTRMQTB0ckJ3N0JKTHhwYVVINWpOK2RiN0ZZ?=
 =?utf-8?B?ZXVLTHdvMWJhNTl4WE5aaUxoRS9YdXUyVU9WOTVydWFHSmNiZXQwV0s3eGdU?=
 =?utf-8?B?dDZmMG5mYXJ6clhtRGJWYmFOUXVBaStHaHZmcVZ4NlliOEZUK01zTmxVNzhH?=
 =?utf-8?B?bFR1ZEF2ZWFuem1jYWpHOTlzWTNpN0VzcmFZVExxZHhQV0ZkdCswU2xIUEVU?=
 =?utf-8?B?NVNhTzdBamhGUmVZaWNqT3pkUE4xY05ReXZnVm10a1hHcDVSRnY3OUZJRUZ2?=
 =?utf-8?B?WndFRC9JaS9kUHlhTXRLVzdxOXNJSmlVSEl5UnlpdmFLQ2UrVnJBSHN4SzVN?=
 =?utf-8?B?L21CdVZxeEhRSWhOTzMvbkdRVUdLM21Sb3B6dmJsQXZvcUk4Nzl2N0dVK1NX?=
 =?utf-8?B?T28wNUJ4RDJxU2VRaDZVdVU0RkNmTGtKem1BdEhDMm1RVk0zRFFKaUx5QlpF?=
 =?utf-8?B?ZGRPb0kra2pYN0ozTlFKaFpPaFZSWGd1elZvUkVpMks2NUdzT214VzByYnNG?=
 =?utf-8?B?ak5WUWtsR0d6Z3FWN1Rvak95a2xIeXk3SjIxeUFRb2ZLc2h5aE8rMVA5aENO?=
 =?utf-8?B?c3o0azFWWTNEZnUvVHN3Znd5bHI3ZVBUOGRDbGlycnJpRkk2a21SSm1qZmFL?=
 =?utf-8?B?SGlIaEMxSmQ1TWlEWTY3K1RYamVUVlZIY2VpbUdLVW9xbzRCY3hHQUlWMEJi?=
 =?utf-8?B?NVJXVzRlTURNd2dxU01wejNKc0F0YkVKV1drYk43Lzd5ZFVQbkwyc28rb01Z?=
 =?utf-8?Q?sgiI3Qebz9Fl8f19NS/9uTI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05322979-3cc8-4034-5b03-08d9d9aeaa16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 11:44:05.1858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UVEI/S0t+flSgi6DOWFE3EdA5WUb+wUUppyVPeaC2vwWSZKcf1WAtRxE1oYgAo/Lf4D3i60LnKO0OMJeDIOFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Christian,

On 1/17/2022 11:37 AM, Christian König wrote:
> Am 17.01.22 um 11:34 schrieb Somalapuram, Amaranath:
>> [SNIP]
>> Any suggestion how we can notify user space during this situation. 
> 
> Well trace points should work. They use a ring buffer and are specially 
> made to work in such situations.

We are anyways sending a trace event with data, but can trace event be a 
wake up source for an application (like a tracer) ? This DRM event is 
just to indicate that reset happened, so app has to read from trace file.

> 
> Alternative would be to audit the udev code and allow giving a GFP mask 
> to the function to make sure that we don't run into the deadlock.
> 
> Another alternative is a debugfs file which just blocks for the next 
> reset to happen.
> 

- Shashank

> Regards,
> Christian.
> 
>> Regards,
>>
>> S.Amarnath
>>
> 
