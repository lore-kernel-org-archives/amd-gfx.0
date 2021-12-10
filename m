Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736C0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 17:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F3010E34C;
	Fri, 10 Dec 2021 17:08:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D9210E34C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 17:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux090sKJTxo2k6DJjjfP37owZhwwKIwWW3f7eiz/PB21Gfcsfc1wPNlonREMs5NfwETf5DTgVn2910ME28lr7xN2iMEU6bNAg2pGTg8tcpzSt/2WQlLOSeONnbfYnutdY/79RSTijGHx9sa5T6o8q498NxXzpypJoZ7YzVmHKF4gYYo0oLjW7T3PGUkWiSOFQlASzHi7sGtqY7Vx/oyFEYpO+OVv1Wo9Eu76UUTlTqla0MJVlF5AUFBPZr87dQaJLnMn+qqiLHxM9c+gnLQTuhQF5iluj8Wq4IiQ71vdK2Xb4XPvj7lWgKzZDoDFXBL5ww/iwKoyhemsmNLNhp9TtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0Wd+F1tDC/wd3ADLGRqgKvJnzHlE/4QVnWBZqsLZ+E=;
 b=M+hRNblHwg4++hNep0TmfwOUP6Na39Aeyyefuirp/p0ud0ziEMgN7OYSFDlohBTYgxU1blYojWXNNjnD/P0EGnT+B6a140BoMQT0fyyZ0s5FognCQ8m+Wlod4M71Joz22AweHo9wZ7jIWnzIRLMuHMFGDDwT2z0ou2EwM76XwG6j/eJP73Gd6AFkUo6UTWPqchAkJO5g6az8M3kyrAVkPxssBrTf7fB/aNoemMcMTqQS6eiwxch5Lg74mXm9lSC8YQJJEqd6XbKeWCchDYTPHrKXKjVc6J27s1KcceScYcyMKHs3Y/ldaVFji+GOdCVaG3HfrvyaTt0bpPNlVfIfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Wd+F1tDC/wd3ADLGRqgKvJnzHlE/4QVnWBZqsLZ+E=;
 b=ffMWznxgitdI9kSX0WdVO/FbfkazOynFpmqHzrpPNZN7DZXJQoAYlt7QXBnkv1GeIiCNDqr1fw+Jd64iE5hiTp6a14GJKLDQUpnWcgxDoRu1hoRwpG4uJsXwUOJGCkiLKtptmU2Cdj5K/deefnBduJcGbdz342vCmdW2BzWLiJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Fri, 10 Dec 2021 17:08:26 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::c11e:f325:b7c4:de4b]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::c11e:f325:b7c4:de4b%7]) with mapi id 15.20.4755.027; Fri, 10 Dec 2021
 17:08:26 +0000
Message-ID: <c405aa21-a2d3-92a1-b549-959445c8e2c6@amd.com>
Date: Fri, 10 Dec 2021 11:08:12 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes
 under /sys
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20211209074918.1555320-1-xiaogang.chen@amd.com>
 <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
 <66721e5c-a5fb-9b8a-4766-e5788bee4ee7@amd.com>
 <25d924e7-95df-662e-7a3d-faa978c4cd6b@amd.com>
 <dedee52d-b2e6-c5d7-4807-380aa1990780@gmail.com>
 <b81d88ba-c608-bdea-ffad-c9917c9d7aa0@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <b81d88ba-c608-bdea-ffad-c9917c9d7aa0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:805:de::37) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
Received: from [IPV6:2600:1700:8e00:e070:e5c0:ae19:df78:81df]
 (2600:1700:8e00:e070:e5c0:ae19:df78:81df) by
 SN6PR05CA0024.namprd05.prod.outlook.com (2603:10b6:805:de::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 17:08:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35513253-b1f0-40a5-f76e-08d9bbffae27
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02035AB89DC950FB3E7D32F7E3719@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1Tdh06+4/+pD1Pw34O+km/qVlJBCN4Y9sQJ0IpqcOUCtwk7a7WelKXz4qvwdrsZu8NluEw06tDcdST+MplN2pyPgOxsPsAZW5wvzdhqmPel4AAQn7oahaA4lGYTmrbj4PJNni6kVpZZBNICqqqtqFeT9BrghEfIGe54FixOKPMGyzOtxnDLwGgQtOUfeti7iqstL4pork4Kyo3gQQ11M4ZSPtzRSZCeD61yUfvZ/Nz0dhx2OMPE1/xkTvabz8+Flh2MGc5/Qpbh3Qbm58nrebLTgOb+i4JysWZ7mMxMuOKrVHp3zAXu5GuS6LfsVjfjkKtrnSLk5UB32WJTVn1/fXU3MKRovTdggo0BSdfSbj59KD7POHK1H/sSWxb85lIM0OhrNseu87FguxDpyy74nHJ3PUhy2gjIpSvmkjqc8+UptbFDAlgFnfsZZ94YB6dK8vlV1KI6YJSkAFKlvgfjgtk6twkzH2kbW69JsogvfFtJeJWNqjw3XEvthLryHVwa0eyze/bEE5nZ6uO8Ls4LaHesSVIJoDoIXrfPfQejy/lLsmF6FjfJ3YMO6bjeOaa++iNj+A+1k9c5DUm55gS1i0Xjs8pi5If9265ONJyjPC6DV39geNB5HrvZGUL8LAg2y8JhvBY9dMZCW6GHxowKEVQVhBFvxjowJcWR0tASmG24wnIAXp1sfMUgnHpi6nLXLEe5JoIs7mLq5a/1/sF7wIf4erpZsyE8m/3C7Cs+MoMoQbr9McSyjUrB+t2O5+qk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(5660300002)(31686004)(8936002)(4001150100001)(110136005)(53546011)(6666004)(8676002)(31696002)(316002)(86362001)(66574015)(38100700002)(2906002)(36756003)(2616005)(66556008)(508600001)(66476007)(66946007)(83380400001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllYV3lWZGxpTzh6R0RpUGtCWnc0bjBFeTEwNFVDMUorcGJRdjNFWEpkM2VM?=
 =?utf-8?B?UUk5WGVPZTV0Vzc4dng3Zy9RNjdpVEcwb00wWDQ0cE01b0huWnpTUVlxVzVk?=
 =?utf-8?B?Q2owLzFwa05XaTNJT2c2ZUlaVWZoUlBPZHV4SnlVakx5K2NWRnY5MWRFeStr?=
 =?utf-8?B?ejJpVmh6ZmEyakJkSjdpMTZiTWVBM29CQ0FBZVlaaGVlcHBIZS9uMWJjWGVP?=
 =?utf-8?B?T2dIdFR0VU92eDRIRlE4Y1cra1Qya291Y2pORCtUemtUUWZtVVREQUs3bkZk?=
 =?utf-8?B?SFlxRFcvbnV1THowMjh0UHloQXhKZUI2WHpuUkwwazRZbGVWUFgzZkRlL3RD?=
 =?utf-8?B?ZG9NZTRYd2doRjZhTzVXV3gxYWczRElNWW1XOXFsZUxGbU02Qzc1NDNCSURp?=
 =?utf-8?B?NlIvOTJhdlVQOEs5aTBNYWVlUSt1d1NKb0dXbFgySzhDZTRMR0RKRGg0WkdU?=
 =?utf-8?B?QnNGMk41aFRkbXd6eWdSMGpFOFh0dVFVRUk0b0hMWlA3MGJEL3ZXQ2YyN1k0?=
 =?utf-8?B?bkJlbE4xZHc2ZjhKUVU0T0YwbGZMM0ZvUVVrb1FFbmxXYUtlcFAyZGJoYVhL?=
 =?utf-8?B?a2RZcStKK0xQdHU0dUZQK3UyYXJtbDF3Q1lFd1FUV2toVmozZjM3aVFXeEdP?=
 =?utf-8?B?dFQvdzBHMThoVXhLZ04ycVVWV1FHdCtEbDdsZi9XRTdodExCMDgyZXZ1SE9N?=
 =?utf-8?B?eEFodWphOThBdEJFajlJYkFwak5QU1ArYmtrMkNiVDJVUEYvdU51a0hnVE03?=
 =?utf-8?B?cDBXUytPRHoxRCs1ZWZnVVdiaEZyVDR0ZkltQXQ5Ny85eWFpaCtlREhFZitN?=
 =?utf-8?B?ZlpSTzhXdEpGdmpFaTRXbFhEa01pL2lWbWo4VHl6MUZJZTB5bGMyVXFpY2k1?=
 =?utf-8?B?L2krM1BFSUg3MmNqck5xTHB3WlprYkIvK3RpSEU1OFJMY0FleHBoTmRqUURF?=
 =?utf-8?B?TWJQWFZIc0thTHVPajNLekJDTVp4VjJqWVlSVUZWcHZ1VXI5VTJJbFNvZUxv?=
 =?utf-8?B?dTdIanc0b3dtakhzc0lrK05Ia2prTUoxYXUrMkdiNkduNjFCcUs1K0Yyb0tI?=
 =?utf-8?B?N1ZSWThldDdCWGxZSG1hd0E1UmIzejVGWmFCcWd1bmgwMmhtWXFpS0QvcUhn?=
 =?utf-8?B?ZW9UREZqMFFreGlXcjZmZWVGNklTQmdOVHdDL3dVVEhSaGlENWhNRTBmcWFC?=
 =?utf-8?B?elBnMEh4ejE0aWhaMGtSTGU2anQzd1d1Lzc4RjFtQmp5LzFlaEptVTM1Vmhh?=
 =?utf-8?B?aERQd1lObnU3enZMMWtzRjlQZnJEbmsyZStzSWo1c0dtTUJjTWdtU2cyWW1Y?=
 =?utf-8?B?STdITDZvM2trRGVJOXlFU21Yc1FHcDR5SkJEUmpCcXFuU1UyT3pmdExDK2la?=
 =?utf-8?B?TlNwNlEzeGxnQ0lUc1pMYmtSNG92ekN3TC8zMW9FQmVoTGNzTFBMZDBZcXAv?=
 =?utf-8?B?RHJiQ0oyNkhQbkRpK0xvVTFHVFJvMU5DV1R3VGtpNkVkb1RhR1Q3ZW1pN0lq?=
 =?utf-8?B?dWZoYXpjam1IS1ByU3RxNDZOb1hzZTgwdkQzRXdpZXF2SUVoZUJGVXpyTlVP?=
 =?utf-8?B?SnFIeDBtcXpwbEs4czhiMzJPTEQyQis3S2NpMi94cDJLdjc5Ry93d0ZFbnZY?=
 =?utf-8?B?bS9PWmVCTEJwQ0lSUkFWRzgwVUcyLysvVENENTlEMk9jMkFRY0dleGkxUWxE?=
 =?utf-8?B?SHQ5L3k1WFdlenNlekZCMU5OY3NscXA3UkgwM3BieFhqbXNsWGpKOXkxTkJY?=
 =?utf-8?B?NzNtTlcwbnh1YmJBd080OW1qclJXdGV6RytLeFpvNm1PREJSV2ROR3hLanRQ?=
 =?utf-8?B?KzBsbDU1QmlHb0dkVytzRnQ5aGlGL1cxSHpLZS9PSFhkaVEzTGpXVFM4N3FV?=
 =?utf-8?B?VEVuaFc0ekF3SFI3SXF6NjlxVHp2Ymlub1U0bWdyY0Z1SlJzbDlWNU5yTmVP?=
 =?utf-8?B?RDR3Q1pLZXBocFliTmIvaFFKSk5VQUJCYVRQOXNSSHNiY2ZtdlRoZVRxTXVB?=
 =?utf-8?B?VHJka3NXWmw2b0F4ZkNOemFoamFsSHdhd25Nb0Vsc0l3RE9TYjhQUGJpRUUw?=
 =?utf-8?B?VjhCTThiQmpvRHhpTG80d0ZMYXRxb0M1VUo5YktTWVNqYXpzNDRoWkF1K0pR?=
 =?utf-8?B?a3hqVFJwU25pU3dzWXorU29hZ2RuZ1EyVVAyZnQwaUF0OGp3dXkvQUZ3dUp2?=
 =?utf-8?Q?Pwfjk8qzXZwazRSSHiLoyLk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35513253-b1f0-40a5-f76e-08d9bbffae27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 17:08:26.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYbba1rbSXtRwk8kFNJ0tUUvp14v4adGHscvStv/EKhk7dvrXk8qEajjq26ZeyF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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


On 12/10/2021 10:49 AM, Felix Kuehling wrote:
> On 2021-12-10 2:22 a.m., Christian König wrote:
>> Am 09.12.21 um 23:27 schrieb Felix Kuehling:
>>> Am 2021-12-09 um 5:14 p.m. schrieb Chen, Xiaogang:
>>>> On 12/9/2021 12:40 PM, Felix Kuehling wrote:
>>>>> Am 2021-12-09 um 2:49 a.m. schrieb Xiaogang.Chen:
>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>
>>>>>> When application is about finish it destroys queues it has 
>>>>>> created by
>>>>>> an ioctl. Driver deletes queue
>>>>>> entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
>>>>>> which is directory including this queue all attributes. Low level
>>>>>> kernel
>>>>>> code deletes all attributes under this directory. The lock from
>>>>>> kernel is
>>>>>> on queue entry, not its attributes. At meantime another user space
>>>>>> application
>>>>>> can read the attributes. There is possibility that the 
>>>>>> application can
>>>>>> hold/read the attributes while kernel is deleting the queue entry,
>>>>>> cause
>>>>>> the application have invalid memory access, then killed by kernel.
>>>>>>
>>>>>> Driver changes: explicitly create/destroy each attribute for each
>>>>>> queue,
>>>>>> let kernel put lock on each attribute too.
>>>>> Is this working around a bug in kobject_del? Shouldn't that code take
>>>>> care of the necessary locking itself?
>>>>>
>>>>> Regards,
>>>>>     Felix
>>>> The patches do not change kobject/kernfs that are too low level and
>>>> would involve deeper discussions.
>>>> Made changes at higher level(kfd) instead.
>>>>
>>>> Have tested with MSF tool overnight.
>>> OK. I'm OK with your changes. The patch is
>>>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>> But I think we should let the kernfs folks know that there is a problem
>>> anyway. It might save someone else a lot of time and headaches down the
>>> line. Ideally we'd come up with a small reproducer (dummy driver and a
>>> user mode tool (could just be a bash script)) that doesn't require
>>> special AMD hardware and the whole ROCm stack.
>>
>> I think we could do this in the DKMS/release branches, but for 
>> upstream we should rather fix the underlying problem.
>
> Sounds reasonable.
>
Some customers(ex, MSF) use upstream based kernel, not our release. The 
changes do not affect low level code and should work even after kernfs 
got changed.

Changing too low level code would involve more discussions and delay.

>
>>
>> Additional to that this is explicitely what we should not do if I 
>> understood Greg correctly in previous discussions, but take that with 
>> a grain of salt since I'm not an expert on the topic.
>
> Sorry, I'm not following. What's the thing we should not do:
>
> * make a simple reproducer?
> * work around a bug somewhere else?
>
> And what's the topic you discussed with Greg (KH, I presume)? Kernfs? 
> Workarounds? Is there a record of those discussions for reference?
>
> Thanks,
>   Felix
>
I am not sure either what the rules should be in this case.

Thanks

Xiaogang

>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>> Thanks
>>>> Xiaogang
>>>>
>>>>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33
>>>>>> +++++++-----------------
>>>>>>    2 files changed, 13 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> index 0c3f911e3bf4..045da300749e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> @@ -546,6 +546,9 @@ struct queue {
>>>>>>          /* procfs */
>>>>>>        struct kobject kobj;
>>>>>> +    struct attribute attr_guid;
>>>>>> +    struct attribute attr_size;
>>>>>> +    struct attribute attr_type;
>>>>>>    };
>>>>>>      enum KFD_MQD_TYPE {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index 9158f9754a24..04a5638f9196 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -73,6 +73,8 @@ static void evict_process_worker(struct
>>>>>> work_struct *work);
>>>>>>    static void restore_process_worker(struct work_struct *work);
>>>>>>      static void kfd_process_device_destroy_cwsr_dgpu(struct
>>>>>> kfd_process_device *pdd);
>>>>>> +static void kfd_sysfs_create_file(struct kobject *kobj, struct
>>>>>> attribute *attr,
>>>>>> +                char *name);
>>>>>>      struct kfd_procfs_tree {
>>>>>>        struct kobject *kobj;
>>>>>> @@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct
>>>>>> kobject *kobj,
>>>>>>        return 0;
>>>>>>    }
>>>>>>    -static struct attribute attr_queue_size = {
>>>>>> -    .name = "size",
>>>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>>>> -};
>>>>>> -
>>>>>> -static struct attribute attr_queue_type = {
>>>>>> -    .name = "type",
>>>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>>>> -};
>>>>>> -
>>>>>> -static struct attribute attr_queue_gpuid = {
>>>>>> -    .name = "gpuid",
>>>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>>>> -};
>>>>>> -
>>>>>> -static struct attribute *procfs_queue_attrs[] = {
>>>>>> -    &attr_queue_size,
>>>>>> -    &attr_queue_type,
>>>>>> -    &attr_queue_gpuid,
>>>>>> -    NULL
>>>>>> -};
>>>>>> -
>>>>>>    static const struct sysfs_ops procfs_queue_ops = {
>>>>>>        .show = kfd_procfs_queue_show,
>>>>>>    };
>>>>>>      static struct kobj_type procfs_queue_type = {
>>>>>>        .sysfs_ops = &procfs_queue_ops,
>>>>>> -    .default_attrs = procfs_queue_attrs,
>>>>>>    };
>>>>>>      static const struct sysfs_ops procfs_stats_ops = {
>>>>>> @@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
>>>>>>            return ret;
>>>>>>        }
>>>>>>    +    kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
>>>>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
>>>>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
>>>>>> +
>>>>>>        return 0;
>>>>>>    }
>>>>>>    @@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
>>>>>>        if (!q)
>>>>>>            return;
>>>>>>    +    sysfs_remove_file(&q->kobj, &q->attr_guid);
>>>>>> +    sysfs_remove_file(&q->kobj, &q->attr_size);
>>>>>> +    sysfs_remove_file(&q->kobj, &q->attr_type);
>>>>>> +
>>>>>>        kobject_del(&q->kobj);
>>>>>>        kobject_put(&q->kobj);
>>>>>>    }
>>
