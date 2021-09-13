Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4397C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9B260F51
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B9B260F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A60189FED;
	Mon, 13 Sep 2021 06:25:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDC589FED
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZnl5POi+SwsBRSbN8jvQXXfCWejDZuoq2+rQHqrH0JMSd7Qc5E7cq7MGknWFkAVHJOCtCBMG1A5coHGxuLvM1ovJX9cz43s1dvF8Lu9YNcGmteKOKAxblQVFnzssi8Ckgu42M8DVVZFg1M+XPoCGrLrEpZZSzxmXJKvmOZb/oMfeHc99QSBXS8/nMJ1cWnjWv1a1s19prkaykhYELhR+F43gjX6sQLtIvMhvV/mwuu118j+SeDHeMNZYJJhWhZR+6XiPKcr5n7GX/R+7BMs0Xoh5bnNneEtJ7yH/8KzMLK9sSETJC/jIJy1dinnU0gK5+gd+girRqt7buRm5R0iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Eoi0kbS9dT+rc7Em9uxakt8OIHklc33wj4Aj8w5i51E=;
 b=EcThJhbVUY53pssTAHk1ZxrH2lyqh7FFDyKcKO0z1xa74ZH72aqY0xvEiCfZ/HpEBPC1YaxKq5Y+XRhL/w3qQ4Hj2zMZNwfZZDp2XZ7WfKLkgy7TsV2xJNcPXJKlsU2poMQW5rdtu3wzXvPJXAv2WygxgyylgApyP9XV6K2fgwhRk9aRRoNp4oP+p9l9KeVyA3re2UJEHuOY53uMepb89tVY9EBA4u2aSIvdsrc8ioFoZPYYi0BfYdBfjfaOylpPfqwgojTw7xsXbdwbed+xkE789jbslJHbAxQE2J+/dnK+Va9DkZbTp57zgrVafPvLeu34Jcf+S8cWNJe4QpIOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoi0kbS9dT+rc7Em9uxakt8OIHklc33wj4Aj8w5i51E=;
 b=Q8O3sWzARGcs8hjtHxnEjoMsexkwT0bgJrDVlbj38IXXK2YGy3vUeHIJUKakEtza7GxFTC6afPvf3y3UhmJmOid7kzK9HPV2r1/OULANjj3hPplT5wc1AU2lgynDbWOiOuHygTcjpO/PoE4pmI3SsRnRPg+JTv4Hl/pi07LD6tg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 06:25:54 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%8]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:25:54 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSBy?=
 =?UTF-8?Q?ace_of_IB_test?=
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
 <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
 <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <c5dd6689-1f76-203d-3d1b-fc3dbfe7056a@amd.com>
Date: Mon, 13 Sep 2021 11:55:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:98::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15 via Frontend Transport; Mon, 13 Sep 2021 06:25:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbacbc22-08f1-4c28-163f-08d9767f5735
X-MS-TrafficTypeDiagnostic: CH0PR12MB5372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB537223884ABCA064A7E08C6A97D99@CH0PR12MB5372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAO4G1MZXQofNVWZwL2lku5VJtUfx/+KrakJkU1a1g/mO/nyvv+E6oQVG7eTMPTAZsUINya4mKeT1ccU5Bn9wT0nJw4MlzZ7YGaX5DtFjtf6RsTX31rmNdNQ6xazcy2i0/x+eGjvMag0QmWafRMF8n0xAfl7M//CdOjOD7y2z4i46txpq5B76tm82l9Cpoqa7tWlPkse9eKLR7YaxmnkSqlNcIBtbNghJp8eb6XJLdELNB7b0MJslSoujPi99OV8HzyI4LffIXeWnng5lIHRfYyLBpxmGm3aYM+cEoeAVoF7ytCG6pWy9zfBN14zY3bQ1Pc6ye87se9S/v4eZLHpEWgI/eIlopAjVt78r61Swwhxo0gOG65gTYcteFPemz3y0t6WHp72YjkuSGjFwbv3BGyObsoY2lwN+C9SFSX/pK00/pqxpvO9luoHfRppErdr2ft+EeA2Rut/Dvg5xeOdapNeY8Y1jgwyEn9fV0vJJuDzm/NGObuwX6iTNkCPcniKoLjxtXTUORd9gw+A7Q7z/yVwZDQm6J6Iusf5rnxW7kLwP3Wjf5FlDmp9ejS7RqRgxq7cIn3FbtTnGZPEs73UtKgFqv59rWral38rX1AJHjeGtFyRYgIfnA1TtJI2e3dTXGIB6dSaI38YpfAoqfbP3lN4glt7lO9ZGneReD5UxqNzLFZmk1Yksl+MrSvfGp2buXg6TzBDiK6TFpwszKByj4I5K5lMa0hHENHKEEuVjqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(6666004)(316002)(38100700002)(16576012)(53546011)(956004)(6486002)(8936002)(478600001)(36756003)(31686004)(83380400001)(186003)(110136005)(66574015)(26005)(86362001)(4326008)(66946007)(66556008)(66476007)(5660300002)(31696002)(2906002)(224303003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlN2NWZoL3dPUHFhTXZCb0cvUyt1cXJQLzRQMXZydEZ1NHA4ZTY4cjlldTdG?=
 =?utf-8?B?OS9oR2U5U3RuUlJma3p2VHdld2NzQm8ydzhHcnM1UGpaYTY0T1gxNHZlNXZ2?=
 =?utf-8?B?ZlovUkdsRXpQVVVwLzJMQzZuNzgrRThDM2R3U3VjcytPM2ZUNGsrdGVhaGhY?=
 =?utf-8?B?aFlSUmNOekx2UWVWVUNuZFRLb2FUZnpkWVRoSFZRWGY4TWU3TnRyZ0ZzdFp3?=
 =?utf-8?B?MDY1MkRPUzlXYTZaM3RYY3lHUmFwK3BPSmFjU1hYckJMTTBDTGMxUUtnQlpl?=
 =?utf-8?B?UGJaUlA5NmY4OThtSUZOL29jU0o3dGxaZTBlbGhQZUVVTUlUZmtFZ01Db2NR?=
 =?utf-8?B?OUhlMjYvKzhXSXQ4bytqTEFTVkhLVjJndWxDYUFzZy9KMW9rL2R3KzdhSm9I?=
 =?utf-8?B?blFUTExlUWJKb0wyNmhOUldzSHNmOU43eThOSWlTNmp5YVphWTRhSFZYbWZm?=
 =?utf-8?B?UVRJb0RLZFZoSFoxTy91Z0NqVlR2ZzduYS9VS1hhQi9qVjhqMnlOSWVXU1FE?=
 =?utf-8?B?Z1AwU3I4QzlyVjZyNCt4TndkMFRGNnJQWXhWN1FaVTJMbVl4OVoweGVJeWZQ?=
 =?utf-8?B?dnpVdXhOVDNzVTdta3p0T2xXdE10UXFabkFOS0VSZUkwc1pndTk3aXVnQ25U?=
 =?utf-8?B?M0ZZdm04SFdOZVBJTVp6Vm5wcERsU0RPaEhoMThscDZUSWRZcUpjbkVoUG5h?=
 =?utf-8?B?QTlDSkRzUlJlSkFPZXkvNTZSZTUzUTN4Q0o1SEg4WVR0SkVEelQ4NjUydnNT?=
 =?utf-8?B?Z2pyNGQxekJDYXI3NEdQV09HUjE4VUtDZnNvNGtLSWpFOHRYU013RjFyVTl0?=
 =?utf-8?B?QWI5dGt1WUVvcndUOHVyVWYwbkQ2U3I2c0pXOWZHdmNPbGV0MkdXZklvRkNP?=
 =?utf-8?B?ak01V28zVUM3RFlqOTVMOFpFOGU3a1FhWU05MllMVEJHU0ZwMjR2THljanB1?=
 =?utf-8?B?ZTQrK1UvOWJBTk5uQ2p5Q0NPQ2U2bDZYK3VKR1l2REVrdkg1U3pCMjR1bCtJ?=
 =?utf-8?B?OU5wcTl4bkgvWnNPS2hLRTVyNk5LaW9IOHlDOXFjQm40dmY4NGNFNTRZbU84?=
 =?utf-8?B?blRjM0t1OUI2SVFZd2RtaFdMbXNxSCtJckhpU2Nqbmtra2JzTHJYQjRzZGht?=
 =?utf-8?B?YlRUUW1FaTkxRlF2N1MwbC9kWFlha0JSY1VLR1M2QkJCOEErRHR2L3RZeTRY?=
 =?utf-8?B?bjlabEFFVnQrY2oxYmFjYkhyUngvdE0vcDJTYnZKR0ZQbnFUQkJhRTJST0J6?=
 =?utf-8?B?cDJKZjZaYmNGWFRidTJkU3RnQURrYjhCdWNmTmFpeWl4SFYrWDVRek9OcWVE?=
 =?utf-8?B?ZmNpVSs0WXVodlNUUHJyYjhiUzJlQkxJSW9RbjhzMjQ1eUt0VjY0MWQ3NnZX?=
 =?utf-8?B?bjBlMkk2eHJ2Sm9ZVTNJZThoTUY1TUR6T0tobHMzTDJDbnVjbE1nRVYvQU4w?=
 =?utf-8?B?QVV1RzdoaTVmOWgzRENuVXhHQUFkSUFVL0ZZUFpUZStMamJIOGVmT29tZlRG?=
 =?utf-8?B?alNkN3JvVStvVmJwT3J0T040UkhMajhSblVOTHcwd1JvUDVpRFdUbW1LVUFD?=
 =?utf-8?B?NWJJSWFaMUEyRExEeEExRjJPTjJnbGdveCtrR3g5OVVFaWZnTmRRYmg0YTFP?=
 =?utf-8?B?TXRQbkhwdHVTMVZmblpPRzVXYjJ4R0kvcm50Mk4zakJ2elZacjFOZGZHWllM?=
 =?utf-8?B?RjhjdU5mMFZYanh3dlh5SVA2c3E3NngvUytYdnRSdGM2UDJJZm9POGJGVXYr?=
 =?utf-8?Q?Sq8+X7AW+LxCx49U2rYGd77v/anU5GVsoMqpET4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbacbc22-08f1-4c28-163f-08d9767f5735
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 06:25:54.7468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJneZA7oCIOkVsMnopeKl+EW7y+NuUYOVbg08gWX/TFeBIrWWOkgKhKkPra45mg+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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

This is a debugfs interface and adding another writer contention in 
debugfs over an actual reset is lazy fix. This shouldn't be executed in 
the first place and should not take precedence over any reset.

Thanks,
Lijo


On 9/13/2021 11:52 AM, Christian König wrote:
> NAK, this is not the lazy way to fix it at all.
> 
> The reset semaphore protects the scheduler and ring objects from 
> concurrent modification, so taking the write side of it is perfectly 
> valid here.
> 
> Christian.
> 
> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>> [AMD Official Use Only]
>>
>> yep, that is a lazy way to fix it.
>>
>> I am thinking of adding one amdgpu_ring.direct_access_mutex before we 
>> issue test_ib on each ring.
>> ________________________________________
>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>> 发送时间: 2021年9月13日 12:00
>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>> 抄送: Deucher, Alexander; Koenig, Christian
>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>
>>
>>
>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>> Direct IB submission should be exclusive. So use write lock.
>>>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 19323b4cce7b..be5d12ed3db1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct 
>>> seq_file *m, void *unused)
>>>        }
>>>
>>>        /* Avoid accidently unparking the sched thread during GPU 
>>> reset */
>>> -     r = down_read_killable(&adev->reset_sem);
>>> +     r = down_write_killable(&adev->reset_sem);
>> There are many ioctls and debugfs calls which takes this lock and as you
>> know the purpose is to avoid them while there is a reset. The purpose is
>> *not to* fix any concurrency issues those calls themselves have
>> otherwise and fixing those concurrency issues this way is just lazy and
>> not acceptable.
>>
>> This will take away any fairness given to the writer in this rw lock and
>> that is supposed to be the reset thread.
>>
>> Thanks,
>> Lijo
>>
>>>        if (r)
>>>                return r;
>>>
>>> @@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct 
>>> seq_file *m, void *unused)
>>>                kthread_unpark(ring->sched.thread);
>>>        }
>>>
>>> -     up_read(&adev->reset_sem);
>>> +     up_write(&adev->reset_sem);
>>>
>>>        pm_runtime_mark_last_busy(dev->dev);
>>>        pm_runtime_put_autosuspend(dev->dev);
>>>
> 
