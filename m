Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6895C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB0410E644;
	Fri, 10 Dec 2021 16:49:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F93010E644
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4z2WH87tG8Wz+8cf9Man8Vs+Be5tRSx0p5nE+sWc3We+Squ6IBLcyhbYWZp9rTFJ3aiZ0iRrwjB00avS19axwv7PbTGgO0dP/iCjhUPZ0Js9JDvsqdV0n20nhf1XOpAJjcb78/+a4XPt2GuwzZdhIAVEOnHz0dwb0RXSJWQ5Z9d8dMDUlMqj4i2xy9pwCy9MYMGESeqScS1MNqvwmde/Un7gDb+nalVmHmCjf6g+FOYYLeMjRBXaukS79ebKzjYTCAAI/eKI3CZvOIPLg1PKEYJiwuJ3GaJWy9sMz8S/mPIkfRW3BsDsxZO0F4VvHGYx16tzImK4SpT3r/s+kX+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EXmb98UxmsVyC7RXXZ+u9TchOeLEpNDVKPcnbJHvG8=;
 b=Aa7BAlPEEDAGuACh2IR3MaG0kUNyk9MPs57zk3cnCAf9WK1m7tr+R3hnSJ/iJg1aSQd9QkqTXXp4+sGlqzELPQ5U743PssZht/grsiLBLJqwg4Rtl9HFKkzp0YscjJMpFnvPKtqr7/4d/FCjRGWJO7lV/EGU2uIcpQF/y/BGF1nuYNAUoJyPV9HXvpAD7N3e+LwiKAweNJI7ruuJFRBPfaer+PxkX1JcQVlDURrw9/W01neFYZhdi24OlLKszRF5cTXfcuM2EI3rai49iXLUSaIh1pM9H7/u2Gjj/U9IW2bHSfX7xYu5jNqO/iFButcJOOOASkWF9NiaXCYgJwWfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EXmb98UxmsVyC7RXXZ+u9TchOeLEpNDVKPcnbJHvG8=;
 b=naZCHnkqGAH2Qpwm+1NBwQ4Tg7EjPw/bhmK7E/C3nwb7roXaXWjCanq+nGZOxM4ha/wrnTm3HPIvBc5R0AwL+ji2R9KnSqZcNLlCqcbtx6/QeO8TfnFX31wnVw3Q1jVz9tBO36ANVJeWpm/upYUl/ACNkC6YCfPoabfCv1zenfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 16:49:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 16:49:20 +0000
Subject: Re: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes
 under /sys
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209074918.1555320-1-xiaogang.chen@amd.com>
 <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
 <66721e5c-a5fb-9b8a-4766-e5788bee4ee7@amd.com>
 <25d924e7-95df-662e-7a3d-faa978c4cd6b@amd.com>
 <dedee52d-b2e6-c5d7-4807-380aa1990780@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <b81d88ba-c608-bdea-ffad-c9917c9d7aa0@amd.com>
Date: Fri, 10 Dec 2021 11:49:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <dedee52d-b2e6-c5d7-4807-380aa1990780@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: CH0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:610:b3::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 CH0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:610:b3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 16:49:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87d6eac4-5779-4d72-9219-08d9bbfd0321
X-MS-TrafficTypeDiagnostic: BN9PR12MB5291:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5291DD8C60E7A29DD86C5A8992719@BN9PR12MB5291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ax77L7ZYk7e2WqNQOXM9Qs4p0ZPRgOy6d8hb/LhkgbasnMO/yp7/UbCnVVgusWGQZqoUUNls8ogkIMYhyUDbGBqTTL+K8+jWpJBstUaxeiSarMrd2NbdLgCdzAi53um5vLxD7TDtTfgltiTFqc4yhDhR1LFCMCpMmf9qSZpOzxdCZr5gGYXt/NmRZbb4n4TPVzZ5E/0aMQ8pBrxPfzbpNZ4GCZFkE1xPzstctjCajYnYgZr1Y4bmvaitoinTbqwG4Vezx6dmhBz4UB0fIDd4r2rGc1nUQM588n4LaX8IYhvpXWqdt8wtwa0gXYgBNnn30yKTxEypy3RjIhxmZc1YctRtMSFlTr343D6u8brpR018ltgO8rqnYj+R3gKvEd4tBtCVyh5Od4ONbl22QANVDuXoxMCWgqbEFjlq28+48zgHbabsBcKw80i1+Zsydl2WKLnyODsb7eXR9wkiev0GZNYfoQyorZGPZ0u5zPsAGNs4Hhc1/RED4tK0HkYBvQts5PfJeeg+6zxFbj3gMy3hCnRZmovw8BmG1NXAWzA0GoG47K9wuy5aKqvH8UgcClEGIj34v4NcXU7TLA7cXN0s0Pm9pzuTsBNuTi3yc8U5zWH54t0jBMRhOhHd42LV/M7xJPyy+5hY67e7SRlPluMigWLNmAMv1NgN/eH9xs1k6cdFviSCvwcbYZs+D5IU7AA0+dFjdGr54NTFnbFJmfqW/7vw2xAr6RtVofnpIRYunQDteQEXphxUxbN60puRJIK8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38100700002)(110136005)(44832011)(36756003)(66574015)(31686004)(4001150100001)(508600001)(83380400001)(53546011)(6486002)(66946007)(8936002)(86362001)(186003)(36916002)(956004)(2616005)(8676002)(66556008)(66476007)(5660300002)(16576012)(31696002)(316002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBFeHd2Q3JnbnZYcXV2VTJOR1Vvc2tmSGVTVDhtL1NrV0FSTlNUaVVCeGhh?=
 =?utf-8?B?aElxZXRRd08rR3E5UXV6V215WERjZFhZSEhoZTRsamV2QTltZTlDWVlvRTM5?=
 =?utf-8?B?SllsSVRweHN4OWlnVjBlNVZmTjBwRlQxdTBSaFA1Z2JrekY5N0hvbnRiZVVE?=
 =?utf-8?B?VFBXQjJpc2xlazYxVlFlSWxFTkFNV1Y4QStTWkpCVm9ETE9zTG4yUDVwRUVV?=
 =?utf-8?B?NHN1VE93U25oaWJEaFlZbWJocmVPZ1VpNWVBUWFzS2FOWUF2YmdObVdQU0NS?=
 =?utf-8?B?aGowT1VxNXdicWhjMUxHRVQwSFYycGNkQ3drL1llZDIrK082bTB6WjNCU1Va?=
 =?utf-8?B?TGNkZi90cDk5Y01CVS81a1JSVjFZayt0ZDNpMElDMG5mRGR1VXM5VCsrVUJ6?=
 =?utf-8?B?dnhwRXNYcVZVaFdzRC81RWhST21RMmRycVpUMklxbXpEallzR2k0TTd6YjdD?=
 =?utf-8?B?bUxwU05QZytBSVZPeWh3czlod1BGSkVhTEdMVUI4Wkp3dGY3VE1wK0FJSXh2?=
 =?utf-8?B?OWFSMGZ6VUNWNzBzVlFHS3RwK3A0T0tJLzEzcG5rUnNzV1ErU3RXNk16QUl1?=
 =?utf-8?B?alhYQnZUajYrNlBrWnFOYVRoT295QzZoUEdwOVhoQytRYXI2dWw0bFROSE1D?=
 =?utf-8?B?eEpIYjRpbjJsSGhnbFppMXZiTExUU3VadE4wUkxlclR6ZkRJbXFpSFlZdkpH?=
 =?utf-8?B?OElxaGo1VVZzeW5Bb2NhUFRiM2lXbE1WVi9WQisvd0FPWFlqN0xkWE5XdG9B?=
 =?utf-8?B?cXBsWVBGMXpLbG9Xa3YzZ2N1cGVoeUpTTDJndHE4blFJUlQyVkJmKzgzL3d2?=
 =?utf-8?B?OXZxTyszNXZlWE00RGZTVVcrejNBVjUrRHYzNnZZLy9mdnZlOStwY2lEYVp4?=
 =?utf-8?B?S0k5b1g5aGNtSVJ2R0FPT3pPbmdrMVNaTFlmaHFHKzBXdVBJNGdZdnlyMXNE?=
 =?utf-8?B?VEFSZGNIeDBGZXNFSkhpSE9LdE5nQ2FmTVUzNnBtWEhLYUlYMTkvLzhPUHA2?=
 =?utf-8?B?c3RLUUhtVGVtNm5Yb01rY2dCWDAvU0M3eGF5VzhvTTdnKzQvM3dhMkF5Sjl3?=
 =?utf-8?B?OTBWWmlzNjhMdjR4SHlJUm1tdXVQUlh2ZDFsaUtZeFpiTTQxRFZna0J0eTB3?=
 =?utf-8?B?aFhFTWtKM3kxdVpaUUZ0aUlXUEgwMUtEZ1UwYkcxcVJTMHFRYTE1UGlsUWpO?=
 =?utf-8?B?U0dBYm1qNEx2K01LeFQzQW10RlVkc3RYcktMb09WWFFhUGdiL3lMdE1JM1hp?=
 =?utf-8?B?WHdmMy9SU2ZwK2VzalRHdS9PZjVhbEZ3NjRkWXFpK2ZvZ0c1enJpVHV6UUJB?=
 =?utf-8?B?VnJzbkw3UEF6dkpmUFkweHhUdUp1NXhUdytRSmxWRDdnZVBLVEgwNEw0MTJt?=
 =?utf-8?B?VzZyZmUzd3NCckRDVUlWOVltQWRIOExGT3p5eDVlVFpqdWx0ckVoYjBadFZi?=
 =?utf-8?B?VFltdHFrWkpHRmY4UjVTTm1DVGl5dTZxRzMwcEp1TEpJTUUxZmVBeWM3WXE4?=
 =?utf-8?B?WGpROXBENjV1L1RpSmg0OHJJVTdTSU5sL2k0TU5wMGJoTGwyRVZKaXlxN2dl?=
 =?utf-8?B?bk1nNjRDZnlkK2xmZDVxbWJhL3BIVTFBaWE5Z2ZzUGxNVHpQV1ltUzU4WGRW?=
 =?utf-8?B?SFlhTjEwdjlseHZSRzNtUXZvQ0ZFWm9VM1hCM1ZKc3NaV1QvNjBJUTdQNU0x?=
 =?utf-8?B?dkJyK3hEUHRtM1hmbDk3a1JIbTVYSG5CWHp3NnZuZFpVbDErWmVBdDl1RVNw?=
 =?utf-8?B?UDZxWnFoQ2lvOHlQQ1V1dFlwcFpuWTBFelh1VkNTWWozZVN2Z2ZPZUh0aDcy?=
 =?utf-8?B?RVY3clNzdXYyNlg3bDlNOWUybFU4NFdCdFpxUVNoMVd2NW95TER4WGIvVDdP?=
 =?utf-8?B?ZmpGbmRZdmlvN1diaUFOcmZ0bDRNcmZ2RGpRNk8wOWh5Q1BZbWkxRk1lVHFZ?=
 =?utf-8?B?SEkrM3NNUVNFblQxRjg5THJkMVd3OFdOYXBTYjZlQTQ1cFhScWk5bTIxYzhk?=
 =?utf-8?B?VDRCZlFQcnhzR3M1M096ZHRHaVJVblo0RUU4UjhxeTlFekFheUtraUNQQTZu?=
 =?utf-8?B?T3Zyd09vcUN0THRVczJyU051dWJjQUtyVzk0azJxQzkrcGh6M0dQcVJNamhq?=
 =?utf-8?B?ODdBelFHdVpSOUVITVpqRk4wc1RzWFBZbHNxTGVKMVNWRWU3ZmMzeUoxSGg4?=
 =?utf-8?Q?IoNRmlLGhmnpPhkHXuTTGZU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d6eac4-5779-4d72-9219-08d9bbfd0321
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:49:20.5079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YppMrqbz3xhyI+1z0VA2tTwxSpUuU+TuwV/YaG/I+2lg5aOiM5g7JfXhGJvyM0oTvQ5uEXEH9QUHD+XIxnNTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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

On 2021-12-10 2:22 a.m., Christian König wrote:
> Am 09.12.21 um 23:27 schrieb Felix Kuehling:
>> Am 2021-12-09 um 5:14 p.m. schrieb Chen, Xiaogang:
>>> On 12/9/2021 12:40 PM, Felix Kuehling wrote:
>>>> Am 2021-12-09 um 2:49 a.m. schrieb Xiaogang.Chen:
>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>
>>>>> When application is about finish it destroys queues it has created by
>>>>> an ioctl. Driver deletes queue
>>>>> entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
>>>>> which is directory including this queue all attributes. Low level
>>>>> kernel
>>>>> code deletes all attributes under this directory. The lock from
>>>>> kernel is
>>>>> on queue entry, not its attributes. At meantime another user space
>>>>> application
>>>>> can read the attributes. There is possibility that the application 
>>>>> can
>>>>> hold/read the attributes while kernel is deleting the queue entry,
>>>>> cause
>>>>> the application have invalid memory access, then killed by kernel.
>>>>>
>>>>> Driver changes: explicitly create/destroy each attribute for each
>>>>> queue,
>>>>> let kernel put lock on each attribute too.
>>>> Is this working around a bug in kobject_del? Shouldn't that code take
>>>> care of the necessary locking itself?
>>>>
>>>> Regards,
>>>>     Felix
>>> The patches do not change kobject/kernfs that are too low level and
>>> would involve deeper discussions.
>>> Made changes at higher level(kfd) instead.
>>>
>>> Have tested with MSF tool overnight.
>> OK. I'm OK with your changes. The patch is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> But I think we should let the kernfs folks know that there is a problem
>> anyway. It might save someone else a lot of time and headaches down the
>> line. Ideally we'd come up with a small reproducer (dummy driver and a
>> user mode tool (could just be a bash script)) that doesn't require
>> special AMD hardware and the whole ROCm stack.
>
> I think we could do this in the DKMS/release branches, but for 
> upstream we should rather fix the underlying problem.

Sounds reasonable.


>
> Additional to that this is explicitely what we should not do if I 
> understood Greg correctly in previous discussions, but take that with 
> a grain of salt since I'm not an expert on the topic.

Sorry, I'm not following. What's the thing we should not do:

* make a simple reproducer?
* work around a bug somewhere else?

And what's the topic you discussed with Greg (KH, I presume)? Kernfs? 
Workarounds? Is there a record of those discussions for reference?

Thanks,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>    Felix
>>
>>
>>> Thanks
>>> Xiaogang
>>>
>>>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33
>>>>> +++++++-----------------
>>>>>    2 files changed, 13 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 0c3f911e3bf4..045da300749e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -546,6 +546,9 @@ struct queue {
>>>>>          /* procfs */
>>>>>        struct kobject kobj;
>>>>> +    struct attribute attr_guid;
>>>>> +    struct attribute attr_size;
>>>>> +    struct attribute attr_type;
>>>>>    };
>>>>>      enum KFD_MQD_TYPE {
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index 9158f9754a24..04a5638f9196 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -73,6 +73,8 @@ static void evict_process_worker(struct
>>>>> work_struct *work);
>>>>>    static void restore_process_worker(struct work_struct *work);
>>>>>      static void kfd_process_device_destroy_cwsr_dgpu(struct
>>>>> kfd_process_device *pdd);
>>>>> +static void kfd_sysfs_create_file(struct kobject *kobj, struct
>>>>> attribute *attr,
>>>>> +                char *name);
>>>>>      struct kfd_procfs_tree {
>>>>>        struct kobject *kobj;
>>>>> @@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct
>>>>> kobject *kobj,
>>>>>        return 0;
>>>>>    }
>>>>>    -static struct attribute attr_queue_size = {
>>>>> -    .name = "size",
>>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>>> -};
>>>>> -
>>>>> -static struct attribute attr_queue_type = {
>>>>> -    .name = "type",
>>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>>> -};
>>>>> -
>>>>> -static struct attribute attr_queue_gpuid = {
>>>>> -    .name = "gpuid",
>>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>>> -};
>>>>> -
>>>>> -static struct attribute *procfs_queue_attrs[] = {
>>>>> -    &attr_queue_size,
>>>>> -    &attr_queue_type,
>>>>> -    &attr_queue_gpuid,
>>>>> -    NULL
>>>>> -};
>>>>> -
>>>>>    static const struct sysfs_ops procfs_queue_ops = {
>>>>>        .show = kfd_procfs_queue_show,
>>>>>    };
>>>>>      static struct kobj_type procfs_queue_type = {
>>>>>        .sysfs_ops = &procfs_queue_ops,
>>>>> -    .default_attrs = procfs_queue_attrs,
>>>>>    };
>>>>>      static const struct sysfs_ops procfs_stats_ops = {
>>>>> @@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
>>>>>            return ret;
>>>>>        }
>>>>>    +    kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
>>>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
>>>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
>>>>> +
>>>>>        return 0;
>>>>>    }
>>>>>    @@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
>>>>>        if (!q)
>>>>>            return;
>>>>>    +    sysfs_remove_file(&q->kobj, &q->attr_guid);
>>>>> +    sysfs_remove_file(&q->kobj, &q->attr_size);
>>>>> +    sysfs_remove_file(&q->kobj, &q->attr_type);
>>>>> +
>>>>>        kobject_del(&q->kobj);
>>>>>        kobject_put(&q->kobj);
>>>>>    }
>
