Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E94C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 05:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139386E59F;
	Fri, 26 Nov 2021 05:28:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF47C6E588
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 05:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kct0ZCskC8ZOn27lxuSMZJHrOkBjmZbmUOGPtnbRl1+pUIlbIduYPYXxDS1ZA4VKAUrj78ZQ/PCmNC8lqyxjjYMLhMQPITtt9JnibdWvEGiRr5j3wQDZVabDQ24nU/WAlPQolG4KNdi9IgwAq8sX9JgXHm8ZChdDtNRju/InOYO89AeOybWwm8WI+qYkk0rUT1SmDzDM0FTRMv3VxXGkPBV/+7yvpKiV5IbawLVZwmrRfVvd/dbrPgp6fq3pPEsZhsWug56Z22D8HxFnweg9HzGaSctmubiXg/gzNUaRrKKN4a0JotvTDQgh6/o/LSViMac5ADG5x8esVxWdlnpZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnCx5xCxzK73wkUYdLYY7kkkBtWs2mTQTPZkc9ZUx+s=;
 b=k5/owE6VwpadpoXfggmlC04zXFk+Iz9fbB/KPo021tHHh7pLd0hC1ZFYhqnMKlfp1Y6E4/amlvLQk+JjrWcaiXEgk7EYdHngk21LZEUe3LQyz998oJ/f9Wi/HInn0YCHLgGQGeAZ62gpc9qZiI/XxwdyVwIExyRkFPfFN6yLhENS1mjQvp0s73K52hvKEPhLxhBKR63bD2q9WkApuIzWFy0HI0vLJMUCTh4/RbB8SrxJo8SDFjLye0Af/xJTcqHBBGwKkPkR6Q16fC/ILNaQprIXee8LoPPjMUKWmKFdFD5yzHtls8A9AwWaJdLoH2lnkDFocByDFeZCtLVL+4BNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnCx5xCxzK73wkUYdLYY7kkkBtWs2mTQTPZkc9ZUx+s=;
 b=q6xaI4JkFzPNJe2KWSl5xswVJzSiJAlv1jeOLNoDybfofqK/Mjah6I73qe8trTUAJ5IabWM785mmlwpHs+xpa9jTIlsGWO1pwtWgt5nn9Q1h8PY0BpL5FTHo6V3Hnp/6RzZoEIjjsYWmHmnzpUvSK0vMPHnZPStQBlqXEXdFbKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 05:28:05 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 05:28:05 +0000
Message-ID: <df3ee42c-1ab5-162b-95f0-f8f12deea809@amd.com>
Date: Fri, 26 Nov 2021 10:57:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211125115049.122591-1-lijo.lazar@amd.com>
 <DM5PR12MB2469D8345E74CB6B2299130AF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
 <a5e2b887-2f61-247f-b279-3db57b68766b@amd.com>
 <630f8b03-3440-d98c-3417-4a0a8ebfc32a@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <630f8b03-3440-d98c-3417-4a0a8ebfc32a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 05:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2b115c-61e4-4d95-418a-08d9b09d857f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB340375ACC4AB13AC3C5A0D7397639@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8rSoXI+nFgTTzDzF9OBHNqOkE745iD+SZvJOI9Bk/l0nygi3/+qCPVzDSDVTB58DVIopXaEi4Sd2rgyrqQpgVb8zFn4oFIk6U0nl2DibmCOs5DtQXUHxlgILGVRo09bbKeDsIDPeqGz0XdYHTx5oTOV2NewrZ6ZyY59WnThNBIMpficmZ98Qvz8ouH1uBmGfZuUCTGc/WrsSOPTmC11FlxmzGr2oX8TBDmaWD1A0xcNqCc8GCnJW6+xb6goFWUyFI3g86cVg76vhasn/rCudUAsHchb4QfDabaSeRr3hfNQYRbHMZjZRu4eGs3BFycgJoFNCz3nzveCn6wFHg8UGfI/dv3zPoqzaaJgPaFSovO0KTi2HAyD+6FDuwn2DKzZnJfzEJYFIQCGtftEUqr450AF2IctcqC+zwlCKdqzqG1sIa97Be1kBdKipnmypPvqAVZn6Y+keu92B5+lQqhtqww7+HVaClP68PZRLyZmnS8L10XchZqFAbCKkIqwZY4JumtelG6bMxuc9TsvSvq7qe2Hb3Ld/EVk2QgiFYVbc/rg2KDjZ4lE1T1etz0iqHxp0YZXx7dNMmRQqtfuyRw8X63WwzrpvThqQJP+tjNQ14bjUS+/bWXTfWDzgXMqlKUbJEPRwSO9HopmgQy9/MkzIsYhtpk6ToS2hBzdsUe8pIgxYbqVTYPRVL1Ni2jLNhCPmAy92O2CTLT20TErng2RgwcciVgUo3sp+BRvNSmHlCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(956004)(4326008)(2616005)(26005)(8936002)(186003)(83380400001)(316002)(16576012)(53546011)(5660300002)(8676002)(4001150100001)(31696002)(86362001)(36756003)(110136005)(54906003)(6486002)(66946007)(66556008)(6666004)(66476007)(31686004)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2F2T3JPSmtrem9yT3RWbUNHV3J1L3owK0RvOXhsajkybG1BS0lrY0QyUFpn?=
 =?utf-8?B?WkJyRjRraFcybFNwQzRQYnlQdnErM1hjK3o5VkFpeVlzeWpRS3VKN0FJZS9j?=
 =?utf-8?B?Zk05R0hkbVlqOS9XU2dkaCsvdjZ1REtSOSsyRSt4d1NhbWV5Y2hGb3dVTG01?=
 =?utf-8?B?TTJDaG8zOEJ6aHJGbkFNSDQ3RlJud0c1cE00bE9rVi9hY2I2VHBvWUcrc0xB?=
 =?utf-8?B?RG4xUkhUVEE3MjlNUXd2bjRtcGF2dVVIM2ZQSS9MdWNvdmczUXozcWdYNWxN?=
 =?utf-8?B?bXVFSDE5T0JLZ3Bpem9GU2tEeUFqMFQ0cHRLckhnbTVYaTFkVXdDcGpXeS9y?=
 =?utf-8?B?Q2xZUHZRU3QyRFZ5ZGhYTVM4WHFjS3JnMGlHVkhhRGFNb1V5eTZqOWIwNlBx?=
 =?utf-8?B?QWZZRHlOWjMzWFJCNWU2RCsyTXVTNHJlTEpxVldmaDBOdk1CenRCMzdxT0Fl?=
 =?utf-8?B?aldQdDJnUjZRdXhVWDV1bHM3bXBqUDdQSHBVd0RXQnRHMnRPN0x0LzJYVjA3?=
 =?utf-8?B?eDB6WmpyZDNZMSt1dDNSTjQvSXFPdjUyU2NQemxDYk5MamdiaUlZM0pxbXE3?=
 =?utf-8?B?dHFqb2orcmhPNEpQKzNoanJLRVUyVHp6MjFYMmdCUUFVbEt5L0I1ak5XL0lT?=
 =?utf-8?B?cVBUQmhMckg5enk1Rlg5RXdSUXlqYzhjd3JTckVYSHZOcmdlYzZ6VVkxL0FR?=
 =?utf-8?B?V2ZIdk0yTGJKS212eExmNEFGNHNJcHRCMEpFcTJnd1hFeGRVTm1tNTFab0lx?=
 =?utf-8?B?RlljbW9KQWs4TXJnTnJ0OVF0U3kzcWgyZTMrWm8vbXNTNmtsQTJ1TGFLc3J1?=
 =?utf-8?B?TWtQZisvcnNaRHR1WnV1NkJhQU5xNVh4WDJIYlpQMWF2QTRlZ2NEWjE5bVRq?=
 =?utf-8?B?Z0pSZnV1ZHExTGFVRkZ3b3FJTk5nYklnZlEyVWdEc2I5ZWg4TkJPOWFrS3Jr?=
 =?utf-8?B?QUxRY3YvSmRBR1F1bzArWEtXckJMczNHNFRpMXpJRGxYZHJtWlpMQ28weDBM?=
 =?utf-8?B?OEwzLzVWbWY1ditHT0ZYdXpEZ1VuWEtSMzFZSFFUV3hlU1UzSGVJSkFodHdY?=
 =?utf-8?B?QlUvL2FMUEN4NW5FM0haOG56OWdTRGFLUnBXMGtDU3JyRDlGNkt6Qnd6SUFp?=
 =?utf-8?B?N2JYOEdrUDFqY1JPVjZXeVRxL3d3dVNHb0ZMTWhuVGJTTXdzb0YyMjRpelBK?=
 =?utf-8?B?K3ZvV1RHc1lWYy95UXYxT2RNUDMyaTNrMVhSVG5ObnloU292cWlPR0wxQ0Ux?=
 =?utf-8?B?ZTcyYi9zTkkzZ2RaVS9Ja1ZsdFR4dkdIMElKNGQrblVSQTNpSTZmZXZSZ3Yx?=
 =?utf-8?B?aVFkeldEVGNhanUxWjFGd05nU0pYQ1pjR1hUZWg5T0xqTnd0RzJVdUYzVHhs?=
 =?utf-8?B?L2ZMOE0vdll0V2x4SW9nY0FNZHd5eGw1OGNXTUozRzBJUS9uY2t2cngwNUhq?=
 =?utf-8?B?UUl4MUVtVURzWFpLRWxTbXA1UzhXK3R5SHJudmVKODUveGhuYlhUMVErbjMw?=
 =?utf-8?B?d3hvZXlFdTNFSThGTSsyVW9sdWpWVytpeWdGYzBPKy9KbTI4bm90a0ZMZ2xS?=
 =?utf-8?B?d081UVhLREI4SldqdTloS2JBZFQ5bFlIMWxLNDFMRmxZcmh0Y0tLczN4QTRw?=
 =?utf-8?B?NkcyNjREajdTMHpkeWtrN2dING9SUkhQR1Yzb1paRkxxL2pJbHJGUDJ6M3VX?=
 =?utf-8?B?ZzFzNjRtbTZiK0ZyZVFYNVVNNnRWbm4zUVZrWkhIVzBkQmhZY1RmMG5FSTBN?=
 =?utf-8?B?dXYrK1JaUUFwbVZOWWdGbWZzWlNSbDZMSmREYWRET3hzcUdiWXdyUEh2SDc5?=
 =?utf-8?B?em5QZEFMZlhBWS9ZYllpUXdLdjU5MFEyVzUwYVU3K1dmYTl4bVRvOXVEVEZk?=
 =?utf-8?B?bjRCc29YZDRvL003cjVMd3hiYkpOWC8zZnZpVEUxZUg4RVRYZ1BPNUxPWno4?=
 =?utf-8?B?VUpNdE9vNkZWRHV3NUd0clhVeXJhTVhqZ2h6VXRWYXBSZDRsMnBkUUFzREY4?=
 =?utf-8?B?YXVEVGIxa0I1aDIzZE92TUkvSDFVU3lDUGlCSFlSRzZEUFdyQmtIblNYK0dC?=
 =?utf-8?B?VFZHcXVObWU4QXkwdXNTSEE2OFB4S3FyQmZsNlk4NGpYckliYUhJNDk4dktS?=
 =?utf-8?Q?Rxo4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b115c-61e4-4d95-418a-08d9b09d857f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 05:28:05.2565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGqmEzJ3Gy12rK/9mq5llCE2IN46fHvR7Lg3ZZXh4JdcNpG21CvkZUMaNCvyPOyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/25/2021 10:35 PM, Felix Kuehling wrote:
> Am 2021-11-25 um 8:32 a.m. schrieb Lazar, Lijo:
>>
>>
>> On 11/25/2021 6:52 PM, Chen, Guchun wrote:
>>> [Public]
>>>
>>> Use dev_warn to be mGPU friendly?
>>
>> The intention is to get a trace as well along with that. There are
>> multiple paths to this function.
> 
> There is also a dev_WARN and dev_WARN_ONCE.
> 

Thanks Felix for the pointer. Sent a revised version.

Thanks,
Lijo

> Regards,
>    Felix
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>> Guchun
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Lijo Lazar
>>> Sent: Thursday, November 25, 2021 7:51 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello,
>>> Mario <Mario.Limonciello@amd.com>; Zhang, Hawking
>>> <Hawking.Zhang@amd.com>
>>> Subject: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
>>>
>>> Ideally power gate/ungate requests shouldn't come when smu block is
>>> uninitialized. Add a WARN message to check the origins if such a
>>> thing ever happens.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index e156add7b560..e0f8ab8be975 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -277,8 +277,11 @@ static int smu_dpm_set_power_gate(void *handle,
>>>        struct smu_context *smu = handle;
>>>        int ret = 0;
>>>    -    if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>> +    if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>>> +        WARN(true, "SMU uninitialized but power %s requested for
>>> %u!\n",
>>> +             gate ? "gate" : "ungate", block_type);
>>>            return -EOPNOTSUPP;
>>> +    }
>>>          switch (block_type) {
>>>        /*
>>> -- 
>>> 2.25.1
>>>
