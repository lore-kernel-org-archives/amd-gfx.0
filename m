Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FF1610F7
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7FF1610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114576E192;
	Fri, 24 Sep 2021 05:42:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082226E192
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR3pyNAMVVVEf95gSTMTZwS5JCs+ADuxzsxApAc531C2TRsdG8wDCwOfPEMFgIAPEJFal7RTfbkdSlFrtrPCufOCpozOjNXAQacPQmEFOJtNSwMkj1Eb9cgPdoOjiLt0drstaI9SBsR8c+2krk7zlVWGOM9tev7TIr+urSkSqaoOM+U70nzIdgTj7HFs13CYvvFi00Ijr6HeqDHh1XnzEpyxgfr5sXUhPdWUsONKtoRAHjsnx5ZWt7abFmisGY4rqk/uU8A8thGIJPdwbr/uN6m1UPl4cKXUwExjd+z4SMYyqtS0sleiCLGn3q7/8w9Ss6ZBH70tAIF+ur11lRKORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8BpkXihWvLh5GXFo3TbGu1Uq01s9MwFTUmhHpPER/38=;
 b=ZXpiAIpsPCUli/G87MXvle9voXnFkjEFbCAz06HRqr9eCTruEe8viwo0gsyY9QCVAHamZnolSrBUn6F5Y+vMqslmGLFmJ+sJNTQQ7IgwCPDlTCUSz9s5BhD7YfC+nCyvCQy2gp7jpGhRPIdSQyqdGtSpBwfIJ5OafCCciwoBf70l3d33QfcccF8qP9tAAqiBrOJjUk18Qpb8Voj0oEuVfnFmGoxi6DXN2J1qiIh6OB8AiG5mSz7sWh4SjtlWPLsH6PaVGuhtW9wbDnZ3ZP2y2MNMJjhRuwKLZyzphk5USmN3AZoyrGIz0hYWS/7XqaSm6Bp1ZdYVSqE6RgrFFzya2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BpkXihWvLh5GXFo3TbGu1Uq01s9MwFTUmhHpPER/38=;
 b=0zXCCexCJNRDYJUFYcx6oyept2844PC4GhxyDuqvVMpR5kCpuqz6QcbGyRd+4/dWZ1qcnsKgVsYO1OpkkTjAtTnFpWRMkZmYwU10Z2HQ8qcPRIFbwdeU+vZaySYkWXuRQBrxEZjsuyWGPo8qJPprKH4HIbO2tiaqvucY+E4kmqs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 24 Sep
 2021 05:42:12 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:42:12 +0000
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
 <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
Date: Fri, 24 Sep 2021 07:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:5264:89d9:5fe9:27b8]
 (2a02:908:1252:fb60:5264:89d9:5fe9:27b8) by
 FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.9 via Frontend Transport; Fri, 24 Sep 2021 05:42:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3b6199-2f9c-4d90-c058-08d97f1e0e8b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4755443D980FD2355DC02F4683A49@BL0PR12MB4755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQ0hH4ebeq37gecqZfa/U+yNil5FwnJ/siv+RG+/HgE/mVstXB7gcSP5qfRkcFvMj1wjK+0Dy6OsGwR6rzyGXzG3/3C7NjKSMqP1KATjzjZDDXNDCFncG3DLtYam+r42c0YdW6kQP035T2rvtcIU7mS3U/6nT6lp9I+3sNTZ+mbAR0gRqHAFYo/mhq7yRQtMy/sZlaBjPYvviC4YfjJnYnfwjbM8v+fohFovscsT4rC46hfQucUil5Ioy2VcpjTDAOI6VAMwI8WB4qDqsgmAsi266N7fJVd9rxVYnMAjBUcmEJTFd8FMkYrm6BiLT+2Ub96VWKVyoM/P6ubLwo8d1TlADlLDPFITcD+AzGDWR2c097hGowS+sS7Nk+j2XVG6O9X1ZMgiLd2zlQ/r3zdTrhjcw5KYyF/LhSYi8Bqo8PXi67xA3C10g4/Q9xXgD2Iox1qxA9lCfCc9/zMA71acn6oCm2X1qjT0UaOrEJoIZBnvic7GTgp6y7L3JD1xTY5dbGrTWyy24TzNTKQm67Xb+2TNU3GcIV5PlEap6i+9wYNZgs6tf96dq0ZGTAGN8xyiY9NJNY+dzD4jqlPGXNCZcjnYQE5lJoGWlEnmEb5RekdgRyQFAt4Nz3GA949Vdz2Wslwi32AzD0KmvT7ulWGSLtbJ09cmBSGJYQ2jv4/uIYXXW04KKN0yNYTqOHu/Ax0p6NkCY1H8j2mWyCHtE4+e98GWXJkLAMtvm2DMXVeyCn9row7xIuzZ8LZ3GSqpJItJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(6486002)(31696002)(4326008)(86362001)(186003)(66556008)(2616005)(66946007)(5660300002)(6666004)(66476007)(53546011)(2906002)(508600001)(8676002)(31686004)(8936002)(110136005)(54906003)(316002)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pJOWwwK0tFb2RlWVNxeGk5UGpKSzIzM0JqdjQ2ZnZoNzYzNWdLL042MjBJ?=
 =?utf-8?B?Q25Ed1I2MmVoWU1yVzg2VmQ2T21oU2poNlhSWnJYQW5VVk5NWjBUSUs0WUU3?=
 =?utf-8?B?a3BxdzZUUE0zWXNsWWdQWFlPMlJXZFJPdkg1Tzh4U2QvUm5scjFJZUNtdG13?=
 =?utf-8?B?N3hYckppTitXNzh5T2hsak9Cc0xhWW8xNFZPZFI1MFR2eXVjcGd4VnNEbnZl?=
 =?utf-8?B?L3VUWDV3OXJpazhPUnRlM1o3aWJEWVFCZVViTDlJZytTcDBMbVdHTVFVQ0Zo?=
 =?utf-8?B?N0JNWEU0cUpQcDdYZmIyWkMyZE11OXhEajhUOXh2WkhvbmwzRVpEVlZiWFIz?=
 =?utf-8?B?bHcweEZDVkVPbS80dWo3Y0dkRU1MUzZvYzVUUE94QlRPNTVSbGVROExTZkw3?=
 =?utf-8?B?YndhbVArZXBXVUo5ZTdXS1JBNUdKRFVjQmNXa1FRaEVUakdsTkhEVGVjSDVw?=
 =?utf-8?B?V3NKNVVueEh3V2JCZmFsdVJJT1pWQkZEdzhvRndYOXdjVW9FbE9Hd3FRVzJk?=
 =?utf-8?B?MnJXejN6cVVCRkRCWXRETE1DNWZ2cFkxZGQxWkxoOThzSGxseW1KWGZWOGNQ?=
 =?utf-8?B?YmYwUHpCU0NEVVRnbzZRSzRHUFpHQVY2VUNBZEdXa1V2ckFMRnRSdWRSNGxZ?=
 =?utf-8?B?NThxc3RvUy85Zm1sbjl5b2svM2UwQ3Y0QUhObnI3NzJOeU5HcnloMGsvclRy?=
 =?utf-8?B?T25ERFk2STVIaExtWGRuMi9MQ0tYa2NsUW5jTlc5TTVOQU5TS3NnYWUxTGNW?=
 =?utf-8?B?ZVQ0VXIrVnU0QUhhRlNsQVdiNlZkdEZQTFlobUpsblVmM2pLSFF5S0dON0hU?=
 =?utf-8?B?RDUzcHlXOUl6dXh2blU2MWRjT2g0eHpKNVEzU1JYSjRNbTlyeTVxUDFVWVFu?=
 =?utf-8?B?ZVp3aTNRdXl5NkJmOEZyVGZYVHFJTndSNkN6ZzNhVGxFRGYwVjhzY2c0bGd2?=
 =?utf-8?B?ZHBWN0NmRHdZcFBzUWFWb2dqSU44QmtkaTlzK0h0WHNiK2FXZFR6RS9aYUNk?=
 =?utf-8?B?UUZtUWtlSHhMd2ozT2RWS09RU09uT1dwZUl6d1d5MEdMdUNsQWRZN2x1amdI?=
 =?utf-8?B?aUNBcmd4eVNxWEd1MXhzeE91elNyRm1OOTBYN3dlT1JDU2RtYkdUL0NITkFU?=
 =?utf-8?B?M0loazV3MXNoN3ppd2RtVW0rRmFhQlV1U1JlcTkyQ2hRTEUzMzVhTDUxTW9Q?=
 =?utf-8?B?d3JxN0RFVVE4R3FWbzVIaGFVcnYvUVZ6SXBWdWgvWnhVL1h0OFVLOXUyeFda?=
 =?utf-8?B?QlRHdjkvelVWVDdPV3VqZ093V2kyY2c5SFNkelZlUkg0NURRVzJzQmNNcUhS?=
 =?utf-8?B?N3R1QUhxTG9UeGhhWk5lK3lBRjA5VzJTNXN2MzZHVjBYanNKSUtRQ2hoSDRR?=
 =?utf-8?B?Q0RlMmpwOElFbTl1Q21ML28zeHVzU1Q5UVBJZURIRCt0QXRHOWtNSnp0cUQz?=
 =?utf-8?B?ZC9tVVJiUlRJNDBWN0MzamV1OTdYbnM1UVd6ZS9UcXRXa3ZreWRPNVVXbDQx?=
 =?utf-8?B?NXRkNEVtQlFkd2NCM3p4eGR6Qjl0blN6ZmU5TS85cE5zYmZFcHllZXd5TjEz?=
 =?utf-8?B?SzdmL1VLSjlUdjZmVzlZcStibXAyWnRxSlZZQlBzS1ExdFFzSHUzM3cyaTN1?=
 =?utf-8?B?UUJSelhpSUhqeWdlZ0ZXVkJubHNqVXZhUDdnUEIzKzM3bzcxUWVkR2dNVklD?=
 =?utf-8?B?cks4bHJBRkNOZk1SWkVaWnZmUS92UVpCNkhJeEthU0NPc3R4MnJaL0JMQnJC?=
 =?utf-8?B?NjhLNkZUSmZ2M1ltT1V1VHVQZ3FhZ3lWY1NzZGtVaUV3bS83UEJlZFE4ZHhV?=
 =?utf-8?B?SW1XbFVEb08yWE8wYlFMLzIyL3l6bTh6ZUx6YkxkQnBOV0xMVnMyWGpoZjN3?=
 =?utf-8?Q?D+M0DOtvz6riN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3b6199-2f9c-4d90-c058-08d97f1e0e8b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 05:42:12.1290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6s9RVvmaAqj8dQsNOnimFtjG9Wv6nfmk/xp6+K62hOoP7qL1ihRH1weyhPA3F4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4755
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

Am 24.09.21 um 07:35 schrieb Yu, Lang:
> [AMD Official Use Only]
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, September 23, 2021 10:52 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>
>> Am 23.09.21 um 16:24 schrieb Yu, Lang:
>>> [AMD Official Use Only]
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Thursday, September 23, 2021 8:24 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Christian K nig
>>>> <C3B6christian.koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>>>
>>>> Am 23.09.21 um 14:09 schrieb Yu, Lang:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Thursday, September 23, 2021 7:40 PM
>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Christian K nig
>>>>>> <C3B6christian.koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>>>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>>>>>
>>>>>>
>>>>>>
>>>>>> Am 23.09.21 um 11:44 schrieb Lang Yu:
>>>>>>> If a BO is pinned, unpin it before freeing it.
>>>>>>>
>>>>>>> Call Trace:
>>>>>>> 	ttm_bo_put+0x30/0x50 [ttm]
>>>>>>> 	amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>>>>>> 	amdgpu_gem_object_free+0x34/0x50 [amdgpu]
>>>>>>> 	drm_gem_object_free+0x1d/0x30 [drm]
>>>>>>> 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x31f/0x3a0 [amdgpu]
>>>>>>> 	kfd_process_device_free_bos+0xa3/0xf0 [amdgpu]
>>>>>>> 	kfd_process_wq_release+0x224/0x2e0 [amdgpu]
>>>>>>> 	process_one_work+0x220/0x3c0
>>>>>>> 	worker_thread+0x4d/0x3f0
>>>>>>> 	kthread+0x114/0x150
>>>>>>> 	process_one_work+0x3c0/0x3c0
>>>>>>> 	kthread_park+0x90/0x90
>>>>>>> 	ret_from_fork+0x22/0x30
>>>>>>>
>>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>>>>>>>      1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> index 2d6b2d77b738..7e693b064072 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> @@ -1567,6 +1567,9 @@ int
>>>> amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>>>      	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
>>>>>>>      		mem->va + bo_size * (1 + mem->aql_queue));
>>>>>>>
>>>>>>> +	if (mem->bo->tbo.pin_count)
>>>>>>> +		amdgpu_bo_unpin(mem->bo);
>>>>>>> +
>>>>>> NAK, using mem->bo->tbo.pin_count like this is illegal.
>>>>> I didn't  get your point. I referred to function-"void
>>>>> amdgpu_bo_unpin(struct amdgpu_bo *bo)", which uses it like this.
>>>> What amdgpu_bo_unpin() does is the following:
>>>>
>>>>           ttm_bo_unpin(&bo->tbo);
>>>>           if (bo->tbo.pin_count)
>>>>                   return;
>>>> ....
>>>>
>>>> In other words we take further actions based on if the buffer us is
>>>> still pinned or not after an unpin operation.
>>>>
>>>> What you try to do here is unpinning the BO when it is pinned
>>>> independent if somebody else or our code has pinned it before.
>>> Hi Christian,
>>>
>>> Thanks for your explanation and advice. I got your point.
>>> Actually, these BOs are allocated and pinned during a kfd process lifecycle.
>>> I will try to add a flag into struct kgd_mem to indicate which BO is
>>> pined and should be unpinned. Which will make
>>> amdgpu_bo_pin/amdgpu_bo_unpin calls balanced. Thanks!
>> That isn't to much better. The real solution would be to unpin them when the kfd
>> process is destroyed.
> Yes, will unpin them when the kfd process is destroyed.
> But we should indicate which BO is pinned and should be unpinned. Right?

Well not with a flag or something like that.

The knowledge which BO is pinned and needs to be unpinned should come 
from the control logic and not be papered over by some general handling. 
That's the background why we have removed the general handling for this 
from TTM in the first place.

In other words when you need to pin a BO because it is kmapped it should 
be unpinned when it is kunmapped and if you don't kunmap at all then 
there is something wrong with the code structure from a higher level 
point of view.

Regards,
Christian.

>
> Regards,
> Lang
>   
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Lang
>>>> That can lead to all kind of problems and is clearly illegal.
>>>>
>>>>>> Where was the BO pinned in the first place?
>>>>> I found two places:
>>>>>
>>>>> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
>>>>> 				      &kaddr);
>>>>>
>>>>> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
>>>>> 				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
>>>> Well then you need to figure out where that memory is freed again and
>>>> place the unpin appropriately.
>>>>
>>>> General rule of thumb is that calls to amdgpu_bo_pin/amdgpu_bo_unpin
>>>> should be balanced.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Lang
>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>>      	ret = unreserve_bo_and_vms(&ctx, false, false);
>>>>>>>
>>>>>>>      	/* Remove from VM internal data structures */

