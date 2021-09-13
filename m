Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61809C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2217560F51
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2217560F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925AC899F3;
	Mon, 13 Sep 2021 06:22:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0339899F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9jLa7S3Z/aRxN0cfe1ATEZusttyHsZJhzwUvUVWKxFl+boyapaSKJJ537U9XYycrgvGC0KH/m7D7Y46dpm3FaR9Wzv7dxDfucIJC8BEIkLf/gi1664jecQyJYhi5extdLfxdjkGpCDuMKIpGHYwTGfxdVrk2owPKzGw3QdNqHUaYSm2pXuQ+zgCMtQQyuccUtT18GJ+NIJ9XaL5J7gEBqQ1Jzho15xz+8kzayr2c08OzqnDtiUe/mFb72aNaqiY6FdN2/KPUpfF5hJ0wTw7hAK/NQWW3L5d3r7PtST1CuOVHWtVcn6Iorgiezx4l7DdK9WqKCfE6GHtiR/TgzRD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZDkxBeJtbR8cd9EUTqqN9Tu/wSD5vqORqxXM0WuX+Bk=;
 b=nPPwvbXxMP9rZbzYj9kCZxGTkxDuBALJoL+jEmx4W0P4RgChS3bF68LCkGrM724hNpZ/JR/TAEr4AIwr2ATfw6KqTldYUXOu/ERQPTqRJgeymFK11nMuLbPeUzEOz4IcCLc3fImq4m2opvMM0oSPz7AKt7srY8/JqSEvtaEC+B5bBQv1YGS1C00mkZH1Ukc1tkW+mrX3XGZtq8pRxOEbMwvrD4+oJFUViGsAP585yjBUshsgGOqJ4FoD2kMxj85yhfjOXTRaozWyVY56BaeKHyt/KSyFlXuSSJ8lJ96z+qZqwkJRz9q6wvsugV38+eAVh/Lj8sP5IRygSp1umSH1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDkxBeJtbR8cd9EUTqqN9Tu/wSD5vqORqxXM0WuX+Bk=;
 b=DiL5PwKgKmpH9lvBd/vQz8GRdPzGK05tPSiq5P0p65ZE87AaPUofKRG4nxEmRNsWRKhUGY5Ge7jdMutOQmGZCm20Jw993qgjXfT/tQa+fAomHeE99CDfVUK+rIKqHLXheV2yhK+h16oFsKqw/Fg3ky7wGHRPLzsWT8iccy9F488=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3677.namprd12.prod.outlook.com (2603:10b6:208:15a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 06:22:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:22:20 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSBy?=
 =?UTF-8?Q?ace_of_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
 <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
Date: Mon, 13 Sep 2021 08:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:208:be::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:208:be::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 06:22:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c1ef13-1edd-4a73-ef8e-08d9767ed75c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB367704845E9D01154AF7624383D99@MN2PR12MB3677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ax9cehypxHPy+WEZwFf480PuBnpMsSDwKKWEPjhDsqT+xKljryh4/sLetfpCHmOZRWbeaAlNuP0jY7gbYVKp0XLe8a4HlSCKkIfPw4bbKCAFn1CjXCYQujYoiwSn7jgPA2s8pv1O7l0RdK4b6AlidcRQclfigSQwspcx+sY3Nu58krXJHyT+y+pcc1MIh671CWYSuWLw3/rFPkmxmm8mqxVmTdW2YxSiykKZGIrsMsAr1KtDTFUrEo+kTVf7PqbHHBTYDjIX9gqJbcdo9cmFGDKpcH0WaGxReFHV9/qoit+Nyo9vccm98eVa/eUNH506PBfAqTVktCdA2HKz0++1wWC/Kh4kl69Ilcj2l1e3+Ki0hURk78M7LSz/4CirfDube8kXaZdKOHRZsEAr80TK4R/e8UAa6MDIwAaMLbRAMR+uPsW7Lmd+5s5iQPhV4iehPQLGuaNaCqjk0EHq8P+GqAXuLv5E1/FGxu19SLCokRm1CwwmoZTGRcX5YH/wOA0iz8NG9okxcYqwRtNwRKh2G+KUwVNUpn7DedTq/zzDCeE95xE104pm0IKpe/1qJsXr4wwEHwu/khBp82V34Ed9/XqlDYoErJ1CtMCtZNvU4lOSB8B7kUi7JZ8f8QdbOJmbpjTyKFhoGYNCS/o8xfWaRH9NQUO4qWJBhZX5A4FOl1fGOVGMtMIlqkqnQfU8tsDA19aHiZKSiw76ztHvVWP1ZbNPioO5UNMR/sVn04aLJGeYfaMAM/cS0WyV9TUPQtDV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(4326008)(6486002)(86362001)(956004)(66946007)(66556008)(66476007)(31696002)(36756003)(478600001)(31686004)(83380400001)(6666004)(186003)(5660300002)(38100700002)(26005)(8936002)(110136005)(16576012)(316002)(53546011)(2906002)(2616005)(224303003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?bGhnSUorWndYMldOUWZsV0JyWWkrM0dZbnpqNTRVTUFDWlNrTzJZRUV6bGdT?=
 =?gb2312?B?Q2RKYnhoVGpBUXVKaGxxYkVsVHlnQjZqYW9UTGRicmtsQmZGOWVUN21zK0lp?=
 =?gb2312?B?Vkx4UHI2UHNtRnlNSnZSUk9ocFVsajE0ZHFITlNPYndQeFg0cTJLMkhpMllt?=
 =?gb2312?B?RlhrR0VobFJrUEo3M3JLOUl2aDRrSUp5aHdiSXdnV0FrOXhkZ2l3L3lqc3Qx?=
 =?gb2312?B?T1hpRExXdklkRUh2RGd3MnAzdmFCV2xJYTJsY3FWVmxXTVFwTHcva3lrNnY3?=
 =?gb2312?B?ZTJOTjRQS2lBV1FBUzg5SUZMQ0U1VWhmZTZoakJ0U09TUndyVlpNajhxRGh6?=
 =?gb2312?B?ZzlHaHZXVTg5S3ZROEU4WGx4UVJod1ZpeU5pb2xiTXIwVzZUMmV3elFta1NP?=
 =?gb2312?B?UVRHUWMvc0UvakI3YlQveUtNdXFteDAvN1l3MStha2tDVU5GamZuSzBWc3lq?=
 =?gb2312?B?S1hwaEdmVkIwNFVtRkJCNHRsRkF4b25STXlEYzBxT2dJRTB1UDVOY1RTUWVa?=
 =?gb2312?B?L1ZWelQrZjQ4SUl1a2plSEJweG9wT0V0V3kraDdhaWRVRzV5SFRqbW9sZ0ZB?=
 =?gb2312?B?ZE9CTG9CSitFZ3psOUhZbDdYTWJSaVVyZjVwekNtOWRMSGNUSWFRRms3VWVn?=
 =?gb2312?B?a1pmbk5uZ0psTFhjMWJRYmZQbkorRkZvbWdUTExjYUk0cjh0YVZtWXVpWHVq?=
 =?gb2312?B?b2xZci9JK3BMU3RNcjlRZVhpb0ZreE53N25vRlkvR2ZuK2F4b3g0aGM2UHgy?=
 =?gb2312?B?cnJlZXUyYlNQZEpxc3kxUmV0My9rU2VSbll0T1lJMVJreGQ4eDl1ZFdTcVJC?=
 =?gb2312?B?dEZwcGdUeEZFQi9leHozSmszZTM1MXBPNWlORytnRWxPcE5XN09ac1dVZTVq?=
 =?gb2312?B?b1VLZmRWUW9YalFSMVVsYVNCZXFCd2svOUlQV0NsZ3pqaWIxQ2JaTU9rMmxP?=
 =?gb2312?B?bDhMWG02Qzc5ZU9PWFYyb1ZJQUkrM3p0d3ZCdUJhV3lnMExwTFpXSkZsTUpa?=
 =?gb2312?B?YnRCb1pMelVsU3Z1bHYxY0dsQnVjaVBJRXRiS0c5TldaZmhlWHI3SUdEMmRV?=
 =?gb2312?B?UlQ2L3ZGRUdHM1FtL0VSbnpoT2FjajlGUlJCSDU2blVqbTVGZ0FyNE8xbTJ4?=
 =?gb2312?B?eWxiSjdray9WZVJVOFlBeE05N2ZpZGZrZC8rNW52MW5JRjZDVEZUejNNSXYy?=
 =?gb2312?B?ZmpsSGw3VDdZYWwrWGlKM0ZaNmV5eFh1c1VteXFwQjQ1ZlBCdk1sYnJ0Y2tu?=
 =?gb2312?B?NnNkWWJvNUdlb0thM0RBNEFtSlNsMU5td3ZqODV3ZzI4L0NUQzhpcDlkNnJZ?=
 =?gb2312?B?dW9WckVoSXZDT29hRXZGTmcxNncwaUJsQUJxL2psR3RBMnA5VXNMY2dRU2dX?=
 =?gb2312?B?K09nL0huS0Z5TTZtMkRVM1JsMnN4Z2JQOUpJZDBBYWlMdmJPUUhrc1JRbTNx?=
 =?gb2312?B?ZXZsZEhFa0VUQUh5QkNXTkZQd2JrREJwQXZGb0g4aVRPWHVzcWtRR056R0VT?=
 =?gb2312?B?aW9kazlnd3JhNUsyeG5hV1pXTWl6QlFtV3QwcE1LVDJlOUhscXQvZEphV1p5?=
 =?gb2312?B?TzdjUzF3SkpXYkZ4NDJ1WG5ubHlJVzhla2NKNWpudmY0THM3a3QwbmhQcGZ3?=
 =?gb2312?B?cklpZ3BPdUFlOUg2bk83N3RCa2JuSWhxaG1rRnVGNW1lbWZzOXNYWFBaQWRP?=
 =?gb2312?B?aWJmRGhPazk2QVBJSW9DUzQyblBEdDU5bkhNcEFOVkRvWDB6ZjIzSWpEUHZX?=
 =?gb2312?Q?7tRHRWRlctNkZhUa22VUyppjoQE92nsRBU0n5Rj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c1ef13-1edd-4a73-ef8e-08d9767ed75c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 06:22:20.2873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygBId8WLsWiraCGdTwZQH2WEbXmqkrn2uPBqkqQ86228SLl+WAog4OAFTEvrz3qo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
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

NAK, this is not the lazy way to fix it at all.

The reset semaphore protects the scheduler and ring objects from 
concurrent modification, so taking the write side of it is perfectly 
valid here.

Christian.

Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> yep, that is a lazy way to fix it.
>
> I am thinking of adding one amdgpu_ring.direct_access_mutex before we issue test_ib on each ring.
> ________________________________________
> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
> 发送时间: 2021年9月13日 12:00
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander; Koenig, Christian
> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>
>
>
> On 9/13/2021 5:18 AM, xinhui pan wrote:
>> Direct IB submission should be exclusive. So use write lock.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 19323b4cce7b..be5d12ed3db1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>        }
>>
>>        /* Avoid accidently unparking the sched thread during GPU reset */
>> -     r = down_read_killable(&adev->reset_sem);
>> +     r = down_write_killable(&adev->reset_sem);
> There are many ioctls and debugfs calls which takes this lock and as you
> know the purpose is to avoid them while there is a reset. The purpose is
> *not to* fix any concurrency issues those calls themselves have
> otherwise and fixing those concurrency issues this way is just lazy and
> not acceptable.
>
> This will take away any fairness given to the writer in this rw lock and
> that is supposed to be the reset thread.
>
> Thanks,
> Lijo
>
>>        if (r)
>>                return r;
>>
>> @@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>                kthread_unpark(ring->sched.thread);
>>        }
>>
>> -     up_read(&adev->reset_sem);
>> +     up_write(&adev->reset_sem);
>>
>>        pm_runtime_mark_last_busy(dev->dev);
>>        pm_runtime_put_autosuspend(dev->dev);
>>

