Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24903C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 11:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642F110E1AA;
	Tue, 25 Oct 2022 11:35:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F3110E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 11:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuZ7NXEyC9KR0TBQnKeOrAVCsDfO9eUyCTXzDXa1zF/aiNVLuT8UYXaHqYGiv1KP8XfdgFkRJXDO9oYCJUY8cfBcVFIKFedQrhN0a8W8wEKYbS2sxXXrravOwlnAexuWC/v1nilDobwfsUJ4aJRT8264vVTq50++YtHxDB9Nd6+UIrRIV/ebNi0i8/YPkiqDEqpXX8fq01WIe9em3dlz9i7PGHofVk64ieiAVBOkAQdvM22jFr0TLaAr3FI9L3sp5DRX2Zqx+1orkNKB1iSN0ALJTffxH0KkwsaRrF6xlwfYDbXF+42vUoDHc9fuwn2hhTgzDUDDIJAWroeGksQ7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML9i9zt4l0WlpQq+CKWBHX1+t1I2HpHFmxOLXhms7hM=;
 b=jb48hJTh9107ZykM0p7beG3jkSZVIbpHM48sRfA5YcFpoEsKBMmeanPE9WZ5crXnS+WBNjnAZQW4Tsc3iTmq6o0/c0Zu23K1dMD++AJmbD6TEjRh62NIP+/rDA6U2KyqoUWA9Dn4LRoCK573KJrJdl6F1l3RuLxec7fUPguXUkYWUMtk34eSjRJSpDtcrPIGGt09ra+P0b/EP9pj5HBEvSBqvquPFjcWHEd2UwMIxNkyM1HGJ777yfP/VKcPJBRW7ouQra4RPfKTaLVwLAVjp7634HsTT2Qp3E/IUW90yx6K9HPnuIw1tAY8PJFTOUFl+CYTyjXtxuSzWo0cZrrctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML9i9zt4l0WlpQq+CKWBHX1+t1I2HpHFmxOLXhms7hM=;
 b=LD1SHVeoIYhiJFI7CbE27HQFw+xCtIFTrRqjfQ/3eoHSos27DpW33vmLAOFrG3oqq8ZmcBBkYNke/0XgkYuhkBwU74oMj3e8J0vcPxeUDgk2Z65OzKVneyycwNbv+eYdhbjr4F7PMXIrALxxAF97uTCjJUvHx7UPmMrQsUgOxsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 11:35:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279%4]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 11:35:45 +0000
Message-ID: <735cc64d-05f6-273c-0236-d383e75a68e8@amd.com>
Date: Tue, 25 Oct 2022 13:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/13] drm/scheduler: fix fence ref counting
Content-Language: en-US
To: Luna Nova <git@lunnova.dev>, amd-gfx@lists.freedesktop.org
References: <20221014084641.128280-1-christian.koenig@amd.com>
 <20221014084641.128280-2-christian.koenig@amd.com>
 <f49e6008-fd01-4942-b39a-ab605548ade2@app.fastmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <f49e6008-fd01-4942-b39a-ab605548ade2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3178326c-86fc-4362-2c94-08dab67d0e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIwFsFRgx5UoylKMmqdc3XsDkmzSBfNJvkxrk2nsieTifHXn3QrKFHnu9j14Mh3FVKNLpm/In4y4wwKpJUMGJ1jyIh0B+WxYXd1Uj0KyAbOE1cTidyYL7NZ2vjQE641kSwV5xSEL4g9LlC7UxwYrYDf5fZRwfoOwIBHE+FyDMQdPYv2dqhyJBeR3JjiO6Hpo/AKlQ5e8Q65PJ6Q/jR0ZTNT0WuYf52I+s9JXq6szA6NrFSmU6C0KpiWwBGgJ8gwIW31hk4L9AN7UF/1+mAAxMsee2U0WYb4ebbTs5AIynS9FO+O1cPAdM6hf4vyCqLRRT6Ylup5BYux2CkI3xr5f/g3H0nfTdEG9Yn7BJ2CElO6LX8rkqhMCx/4N7t6ihVh33NAIduHi6YR7l/XQbDengpPDc8GThgegTTxKMJyt/P3NpnHA0KXPoMysU+ZjHm47hZVjU6892oyQLremwDAHXw1UiC3cmYz9UYhTO1FZ6KJQaPC9zRE/ixdXiRe///mepA04jM2lf94YpN70aYoOd8fdY/IbKpr3/id7dcy7+J01OAz5bkNDm4rT0CI+ayG/AiPZlNxAowDAPWCUDTmLiwfiHiaL4++uyivItTmPtxDxwRk2NerEfF4B+cIMcx8blabpM6QmQS/JknKvUxdS0TRSFVSUMiak+0OCIypybdQ0/z6h/XqESWpvq9lj7kfie9s5Lz2avozruY0g8Bm5/QoYvv1uw4xLHk82sWaFW9QRiSigZi4rzx/NKDsdyWIWorp3qlDDMSy53mEb8OKGaN02hJfWqgWtyeWVC6JJ3mA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(66946007)(6506007)(66476007)(8676002)(66574015)(2906002)(2616005)(36756003)(41300700001)(6512007)(26005)(5660300002)(186003)(31696002)(478600001)(8936002)(66556008)(86362001)(31686004)(38100700002)(6486002)(316002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVONDlTK3p0SHhrK3dIdVZTcW1vRkMyNmdjTTlSK1g1NUhpRzNBeU44L2xC?=
 =?utf-8?B?YUZWOXZiR0ltUHNoK052YjVUVXFLNEdBT05hbHpoWWlqcGJ6a29qanpWRUVn?=
 =?utf-8?B?UEpMaXcya0ZFRDlSSkZISEM0b0owUThTTXRkMFhabmdqWjVRbjN1cGQvNlVS?=
 =?utf-8?B?VENMTHAzRUNXRC9na0VEeCtaYzBDWkFXWHhYR2JsRTBnV1Vxa0xBTnNzb2R6?=
 =?utf-8?B?UXhiRG5YeVhLaldXa2xMUkVGU3BnWEJUcjNZL0tQUWt5YTFQY2RaY2FPWTM4?=
 =?utf-8?B?MnF3ZFF4YnNUWTNLSjlobmpUck94Q3d0RmRTSVVnQlpoYWV0ekZ4WHA4cmx0?=
 =?utf-8?B?UDFKL3FzWDRxR2oxcUllZFd5ckwzbVU3UjRLTU1qTS9mQkEvOUU3NUFGRklk?=
 =?utf-8?B?aFhsblJGN1NTbkRDckpPNXRCWmlSUDJhNFNUR1NFaUhtL0cwRm1NMHRndzlH?=
 =?utf-8?B?Rm56TzVyMm5ETjY2d3JsTUtRdXFhZkc1em54azVnOEp3QlZUSU9uNVpWTlZh?=
 =?utf-8?B?N1ZyWGxKMFNQZVJwZGswUkpNNzhRNDNBZlI5REViY2hwcmZ2eXBPOEV2WTVW?=
 =?utf-8?B?ZmpyditaYmd3b3dkdDNSdUE5aWNZVnJMK3VYS29PWExSVlhHOFlpeXUyckNz?=
 =?utf-8?B?YUhDT2VDN2ptOFVGWWxldVhXVkcyY1FranV1Vzczc2hrcVZuRGJ2U1pmbGtw?=
 =?utf-8?B?dnlPdVM4OWF0WHJVK3RKWFpjLzZTWHNsVDJ3cFNybWVlZUcza3JFN2RwUjkx?=
 =?utf-8?B?ZmNDS0x3OGxJM1IzRWdHVE5RZFZEZ3REVTVrYnlyUEVDVWxpNzdpOWZrTEZw?=
 =?utf-8?B?SUd5b1BoY3lzUHM1QlovUGFnRFJ6TlpVcXU2ajk4NG9PMTBOTlRrZkZQbmh1?=
 =?utf-8?B?NnI1ckJEVG1DTlFuTzByUkg3ME5kazhsSUhHUmUrMVBsdS9KaGtXSmY3c3h0?=
 =?utf-8?B?aGR3Zm56VHMwbGo0SjZFNm9YSUFjWTdqOTNaK0ZRNi8xMGNPT0tyTkJpcUhn?=
 =?utf-8?B?Nzh4UmRNZEJPY3dDQk9WZit2OVAzWUgyUTlKRUY0bThTeC8wRTEzNGpKbnF4?=
 =?utf-8?B?WUhjWUVrZGp0aTVGTW93a1ByREZmV3NmazVubWJoR1JPdVZUZi80eWZadUJv?=
 =?utf-8?B?Zk44R08rcWhNREY1MVY4eXVDU2FiVWh6WEhBbXdtYUZ4azROSHB5UU5INzNB?=
 =?utf-8?B?OElHNE0xbEpEUWJnQkcza2tKOTBFazFyK3o3R1F5c3JJSEtrU2VRL2xFNko2?=
 =?utf-8?B?R3J4d0ZHbzE0dkZhL095WGRQeTFmVTEwa0w5N2w3VVB3eGVTa2xLNSsyUFhs?=
 =?utf-8?B?eXgzMFVWY2p3RG9yZGdKMzFyY2RwWDQrdU9hREFXblZBdUtOVmxYcWtQTVZr?=
 =?utf-8?B?ajFWMTNNbVAxby9Ob3o2YjhrbVRTVzRzSlJkK1ZRVG9HSUhVSTZYWit5aEV4?=
 =?utf-8?B?c2xkVHFOa0R3TkFFV1B1ZlMwaFVZZHBacEk0WXFDRWJuaHZNTlRWYUlxTHdI?=
 =?utf-8?B?VjVvRml5Vk5pcmdCcHVFR2lGdmxvajdoYmlUcmlWSi9qNUVjVVk4UmMvUDJE?=
 =?utf-8?B?QXNzM09GSmg5MEkyU1AwOEJyVlBvWkFCRk5Td1M1TjhTbFVmcmZ1UFdPTWlN?=
 =?utf-8?B?YS9XdHJ6bHM3emZ0NzdiMm1OSkRhNnpFM3REckF2K2JsRHNaR3ZQUTA0Y1lj?=
 =?utf-8?B?UitJdTMyTjhXTExLZ0U0WW55cEM2emt1Sk96cjY1RmxuSmhQeFFKWU5EQTIw?=
 =?utf-8?B?T245a2F5U0txblhzOWVTN1BCSjg4MkNiTTd0TmMwRzFtV0tKSnBPZmlmM2lz?=
 =?utf-8?B?VXRqUllRNnIvUndYc1R5eTlwSWVpNUtpY2pYdFMxUFg0cCs2YUl0Wm9qc3NB?=
 =?utf-8?B?QVMyZURoVzU4aE9DRGVOTGEwMzFXMSt3VUJZS1BMTXFGUXBjNjBOVTBYbm14?=
 =?utf-8?B?NFZHckxWQ010SzB4Y25Rb0ZPMm1JQVdsaUk4TmVPQ2tIUXM4T1ZoMElJYnZ1?=
 =?utf-8?B?QjNJS2xqMHlzYmJSSU1NRHM4UEFBZDFuM3ZQWStuUGlRUVdObGJSMmpiTnlt?=
 =?utf-8?B?NDN6L0RRTWpMbnFER1Fxa2dOMzJVUTc2U3VzdHdwaWdVVWhJNHY4T1NSaUpW?=
 =?utf-8?Q?tQXmFvdWKHWbF7BDGtGLSPv8O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3178326c-86fc-4362-2c94-08dab67d0e32
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 11:35:45.4182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKgxkT1W1VmsGBturhyDjq85M4kDspmN7lEqwWHDLIamTwCzi6HrBkc4Hc7YhM60
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
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

Am 25.10.22 um 05:23 schrieb Luna Nova:
> This patch doesn't apply nicely on 6.0, seems amd-staging-drm-next is missing 9b04369b060fd4885f728b7a4ab4851ffb1abb64 drm/scheduler: Don't kill jobs in interrupt context

Yeah, so what? This is a rebase on top of amd-staging-drm-next. I've 
just pushed the original patch to drm-misc-fixes.

Regards,
Christian.

>
> On Fri, 14 Oct 2022, at 01:46, Christian König wrote:
>> We leaked dependency fences when processes were beeing killed.
>>
>> Additional to that grab a reference to the last scheduled fence.
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 43d337d8b153..243ff384cde8 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -207,6 +207,7 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>> struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
>> finish_cb);
>>   
>> + dma_fence_put(f);
> Conflict here, is INIT_WORK with that commit.
>> init_irq_work(&job->work, drm_sched_entity_kill_jobs_irq_work);
>> irq_work_queue(&job->work);

