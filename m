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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA944C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B67260FC1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B67260FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF236E0EF;
	Mon, 13 Sep 2021 06:43:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C656E0EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exnVXEbDd+k+5a14MyQHWc+v/QfgzEVKmEuGfML/bAcxeG5yexHP9E3uPjiG6s13WO1UxkB3FzvcWoahSbzv1IoKn6+pgdIoB3XWfVlMcG+Ra09pAUI7OSPip1rbSM3Od+PNaO9yOsEZwidls6oBNwEUEFAkmg+ZvVH9EeLdIt641thT23qD3IOO/eag6P2Kzhg+j0T228airWjFk1eJ4gBJTuQynu8KxU9EBhE7A4agakcsbIOYjqJyEFgIYQqh3p6KfOlmS/DClu9EwsiSDwaDyH1papL9VRqcUIFxEIfDOw5yRUp9XfDMJMvIUa4Y7tJIZ/55GN4VG/LIZ231EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=F7F+jTYT7sKecGrwQEyD0pc1kOWD1ld7DJKQB9z1qLA=;
 b=nsp35bCNdLc4/RBaI65HO1fzmw+xEcwrnrLnElRw6TQLOe+zLY34RKrU64RAdch/+S2JDplMzTNc2N+dWLro3ySI3pHe7iYKRQod7QTkEfhhYYzjByKQscrX5UegGIlEbYKP7PF8zHXVWU67e0ydeGaaqfdyg2c0NTbHak8we2CvPqXSMZzEJ2gVsygVsDiBv9++h3vCXAk0Su2mBv1JrmRiXYE1yEolMGpR8Q+Q09rvPesRq8TVFhDdInAQl46j48VlJcD+nbQL+qcV9pRtBlyeb9JorDUYaDvjMKyWazeloZcTvJOWAs+2pAlJgs+ZNyykLCviqNdNaH3eXCmE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7F+jTYT7sKecGrwQEyD0pc1kOWD1ld7DJKQB9z1qLA=;
 b=R3DFbjJ0Z9ctgph6prNQOF3zxPmsA2a2BarNejTivRyjpQJvn4lBRK11aNRc7vNs+sV3KvlYnHwo55Gs3evtj0UiEEzgFa5+27TN0fFrgeDVeeysrl+TLNZe2/O4wGQe5xB1V6IZEWqb1gEtMrnMCPw40krWumXLIVBxF/rtip0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 06:43:49 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%8]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:43:49 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSBy?=
 =?UTF-8?Q?ace_of_IB_test?=
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
 <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
 <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
 <c5dd6689-1f76-203d-3d1b-fc3dbfe7056a@amd.com>
 <5417fd27-b121-c73a-08da-1fab2cf65cde@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <042106ac-b55f-351d-cbed-86a08ce60204@amd.com>
Date: Mon, 13 Sep 2021 12:13:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5417fd27-b121-c73a-08da-1fab2cf65cde@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::7) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 06:43:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed076f0-d065-429d-896c-08d97681d7ce
X-MS-TrafficTypeDiagnostic: CH0PR12MB5123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51232A5256114D4DB96F21D797D99@CH0PR12MB5123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVy7jd0RDcmC2KQt9AHwzimKB7+5ra5/L6sbRrNXquF3rmzgJq6ft2S8BI9fesaob/Hh41Ea0jv7isbiAIRz13kslGa6X89egw//xkjWMPEYZycNSHifeBya0m8UBdTg+yP+g5RIupE9Y0Ld80/9/ZqebgkG/QoUNfZ+FHitjOSFr1OsHxiCnSc28GgzZJbxA1TBNgdGZ1F6JhEEFwmW8NT5uUnzA5Jm1iLGalSx2+3ztrz/hLh5wFlyBWABzLqJBcML2jKHa3tolJ68M2tyMDn9pVg5ugaLaUaw7/W7c+RyU02LUxwqExzWa4/CUVS/K6WgPB8PMUHo3jAvuXM9dHRi2yMqb8UgeFgVUvo9HEbsOSSnkBHA+wIcSY0NqYYBRA1GZCaCxKe3wen4eYsQF8bF2tJJD0GmlMDs4IC697VpzuzkJ8ysHHsG9YE3gOIdoc0LbHYPvyIPd7oTxzHXV5QOO5yBcqEQ89iAIJVdowo4c5XM7PUEhtYeVOq3HTJPFG4EQ+b7cwNO1BM280cg+a7ttGxOdxJW02Zb1pkwOgxt4NSOt4gFKUBpr+6UzcSFtbKciWLWXKBL91RW6X5nPkxbQjhr26yfJrrTdtb5eHhdQaVQ1R/sh1NPO9VFE+oU8j+6F4oCpupDwK4snbW1j4SChByJtg9FRsVIIOtjsmBYOgMsGIHkc1COz1ObJKA5pHp8RnKseY46VUj5Yh1xT4lcGi8jNUNAWXz34GkIgYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(86362001)(110136005)(5660300002)(31696002)(83380400001)(224303003)(4326008)(53546011)(66476007)(66556008)(26005)(186003)(6666004)(2616005)(316002)(38100700002)(31686004)(16576012)(6486002)(36756003)(478600001)(2906002)(66574015)(66946007)(956004)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhhNDVjMnl6dHEzQTF1b2lDUlhOZzArbG1oQ2dUTDR3UlNDeFNWMGJxTHYx?=
 =?utf-8?B?bDhDRUJVSkN4RlpqZk02VjBrYjY5Uy9aY1MxZXlPQ1gwcHM5UjZMZVIram56?=
 =?utf-8?B?cGdlaFdxQkpnOG40Sjc0RVZvQ0ttT1dyWFFPUU1XMGx3NVAwaVFMUlNrQW92?=
 =?utf-8?B?MTI3NS9qeGdoKyt0RnZmTzh6T0dRS3V6enhHWWdFNU0zcWpnNUlmN3B1ZG9x?=
 =?utf-8?B?V1paa1EyY1FTdWRGaTRtcEFEeXRXYUM4eFFQTVFXcjR5UHA2MmtEREthZnhm?=
 =?utf-8?B?Nm9ueWZtRm0wK0hIVkVnUTcwTWlrNzh1SGpENjdZdmVUOUxCdHB1Zk1MVGk1?=
 =?utf-8?B?empVOU16Y1VkZk5RdUNyc0VnOFUrYWFBandBN1FZUjRSREVQQk05VGhwR1dU?=
 =?utf-8?B?U2E4Tlh4anJrUlBFRHRBUWVJOGNhbzU2Sk1VNUpVSHA1YzdWaW10cVYxUWk5?=
 =?utf-8?B?T1gzdDBaWS85bjJrMFMweVgySG54OFhESE5VTytBVGRwQUZLNXNoNGZiOHp3?=
 =?utf-8?B?MVhTOCtEUWtzMS9jbkFaZ0Z4K2tTNTNLQzg2cExEMDVRcytoTVl3UGRFbG1q?=
 =?utf-8?B?STR3YWhOdGh0Q2pSakZLS1VOSElQeFkxclBuYmpkTDNuaUZxNkFmbjlEUVd1?=
 =?utf-8?B?UzNvdnQxKzZtbzI2azlOc2ZvaWRKUjlVdWM3dTVGQzEzVEpUWStmOEZBLzRW?=
 =?utf-8?B?N2RNMGFKbDZjWFpQd2tjaTNoMEdyaHYyMW51cmlRS1VXR0ZYMEJWY0k3MXNz?=
 =?utf-8?B?Z0lmblNVVXVNNlVmeTJDbzlJbExJL0ZlMlRET0xxRERNaWZpNmdTRURST1hO?=
 =?utf-8?B?K0l5ek55OWtqYm9tR0Fxc3RPZnRjK1hJeGV4V1k1WEtqdEIvUXBOZi9wUmVS?=
 =?utf-8?B?WGRLa0VBbDFkaUtIQTh5MFdaaUF6Y3dVcjRkWERiTG9zeEVvK3pQZ1o0YkVp?=
 =?utf-8?B?NmNnTUFDek4wT29GbHRneHpaUnNybWlNd1lnK25ubG43UTFmMEhBM0RSM3Ry?=
 =?utf-8?B?aDlCQTE1VVUrdHVxV3BiTFZ4Ulc5Qko4REswenZ6dy9XMGJiUURYNTJQbG5u?=
 =?utf-8?B?MkZ4aEF0NkcyR0tKR3VOZExtMzVCMzU3NERPTmdtNmZMR1R0NFYxVHRucXVk?=
 =?utf-8?B?R1BsMTJLSVlUb1JXdDdRYm1DOFhOVDZBNXhMUzlwcUZqa1ZrOVI2RWw0TGdS?=
 =?utf-8?B?eS9ReHpCTiswUUFlcEM1Q0JqWWtyZkVhcEplV0VOYlJ0dC9FMSt0UENvVXps?=
 =?utf-8?B?dVhHWlVUWEFPSUhOM3BBMnlXWmxBelV4YUV5OWNLWVp0WlptcVFIMXQ3amxZ?=
 =?utf-8?B?SVNPcW53anhla29LQzR0WXhuY3Bzc09vRUkzS0lqdURLTGRzWkRYUC9xaUd2?=
 =?utf-8?B?d0FkMVF3OUJuQXZCUEJLVkZKcnNZekFnVUxTV3BxaDluNkJqdVg0UDJKcnMx?=
 =?utf-8?B?clR6OEkxRmhBMlZLeTJReGRrQTB1TStYSW9TWFlEMnlXUFR6dzRxaGV2VklV?=
 =?utf-8?B?ZEptbVBZWkw4SWNZRldHQmUvNlh1ZVExSTFlZXlzRERwd1hoNWJyaVQxWmhK?=
 =?utf-8?B?Y05nRHFPdnhKaDNwT1MwMEVySWxjRS9UTStSRHJheTBmK1JJNGxyQlBrMStu?=
 =?utf-8?B?amdNWkJSRzN2eEN3QzVBWUZuM0hna1JqK2hHa2wwd1F0cWZSSThzM2t3UE5y?=
 =?utf-8?B?OENpU3FoUEFWVGJHblI4WU85YmIrZG5PdUpWbHozZjRnYWZtRXYyK2hub0tM?=
 =?utf-8?Q?SxGikUz0s+ZlNmIHsHIUd3WkXQn7fo6EYyXpaXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed076f0-d065-429d-896c-08d97681d7ce
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 06:43:49.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu3RGWuCnUtxguH9MFjaXsoY+oBeXulKQAFd9BOfRGA7GCRHi9rZOChGCGpqWY+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123
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

There are other interfaces to emulate the exact reset process, or 
atleast this is not the one we are using for doing any sort of reset 
through debugfs.

In any case, the expectation is reset thread takes the write side of the 
lock and it's already done somewhere else.

Reset semaphore is supposed to protect the device from concurrent access 
(any sort of resource usage is thus protected by default). Then the same 
logic can be applied for any other call and that is not a reasonable ask.

Thanks,
Lijo

On 9/13/2021 12:07 PM, Christian König wrote:
> That's complete nonsense.
> 
> The debugfs interface emulates parts of the reset procedure for testing 
> and we absolutely need to take the same locks as the reset to avoid 
> corruption of the involved objects.
> 
> Regards,
> Christian.
> 
> Am 13.09.21 um 08:25 schrieb Lazar, Lijo:
>> This is a debugfs interface and adding another writer contention in 
>> debugfs over an actual reset is lazy fix. This shouldn't be executed 
>> in the first place and should not take precedence over any reset.
>>
>> Thanks,
>> Lijo
>>
>>
>> On 9/13/2021 11:52 AM, Christian König wrote:
>>> NAK, this is not the lazy way to fix it at all.
>>>
>>> The reset semaphore protects the scheduler and ring objects from 
>>> concurrent modification, so taking the write side of it is perfectly 
>>> valid here.
>>>
>>> Christian.
>>>
>>> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>>>> [AMD Official Use Only]
>>>>
>>>> yep, that is a lazy way to fix it.
>>>>
>>>> I am thinking of adding one amdgpu_ring.direct_access_mutex before 
>>>> we issue test_ib on each ring.
>>>> ________________________________________
>>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> 发送时间: 2021年9月13日 12:00
>>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>>> 抄送: Deucher, Alexander; Koenig, Christian
>>>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>>>
>>>>
>>>>
>>>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>>>> Direct IB submission should be exclusive. So use write lock.
>>>>>
>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 19323b4cce7b..be5d12ed3db1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct 
>>>>> seq_file *m, void *unused)
>>>>>        }
>>>>>
>>>>>        /* Avoid accidently unparking the sched thread during GPU 
>>>>> reset */
>>>>> -     r = down_read_killable(&adev->reset_sem);
>>>>> +     r = down_write_killable(&adev->reset_sem);
>>>> There are many ioctls and debugfs calls which takes this lock and as 
>>>> you
>>>> know the purpose is to avoid them while there is a reset. The 
>>>> purpose is
>>>> *not to* fix any concurrency issues those calls themselves have
>>>> otherwise and fixing those concurrency issues this way is just lazy and
>>>> not acceptable.
>>>>
>>>> This will take away any fairness given to the writer in this rw lock 
>>>> and
>>>> that is supposed to be the reset thread.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>        if (r)
>>>>>                return r;
>>>>>
>>>>> @@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct 
>>>>> seq_file *m, void *unused)
>>>>>                kthread_unpark(ring->sched.thread);
>>>>>        }
>>>>>
>>>>> -     up_read(&adev->reset_sem);
>>>>> +     up_write(&adev->reset_sem);
>>>>>
>>>>>        pm_runtime_mark_last_busy(dev->dev);
>>>>>        pm_runtime_put_autosuspend(dev->dev);
>>>>>
>>>
> 
