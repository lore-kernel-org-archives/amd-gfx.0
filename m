Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0C9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 07:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B0011ACAF;
	Mon, 10 Jan 2022 07:03:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5290111ACAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 07:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGQ49slErLRBeaZ+gJ1Z6JFaqNFP47c7NXIpXTQWPHuXceSo7BVXNSsDtSdRoZd+7KRl7qB25HRacgKSsnErJ55V7hM8i14lFWg8qrS6/w2YWJQB4eA7bJjiL3hYnkqGfYw2QjlE4ujZ7R9IbqxwUkJMRpRSKeO2SvJKOspHcm/wFkWfOzGJYddWl1LxO8TcjOsWU8YQOOCTj2OzuFADUdgBry/Q0BdnuJ9pZclljWrC5Sf1vQnMDfxzdWuOW/BGfC3WRDtJOMYYhuCLR9RvA/lP5DOuXmydfnOrmpCXxuyJUt6cht0z0Ogb3qCbce7pJQ+rGTDCZ7dwAsK3E1Iz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2LxOYZKLLVJD5c9m0JAHNNMsUDXR2gnJ9CITuCOE1A=;
 b=W8kGB4Br2kkSeToUfYUuUdmw4v+4LQZ0hSOud+T/poSCQAdV+sHWLZzjOIVkn/ALW5syLMvG0wYKyX7e7ALPB1Kay3LlhY5QFtNTyVv+XpY03M2J2sfwtVPpY08v/ylvF3+sl42kCRdx+Nlce9jtwDfpIOMhAdT9JELU2/fmc6f5GSgOE/VoDt9br5Wt4OPlj56cgWhafMW+3lg7VkvcEwQqIB4n89+A4fGgEvtFzdg5ks5gByZTE3bJ9ayaqJsUQAiL+LeaBrNhAJ9U9u3L1sNX4JyE2UunrZloWmHzbpEOZVwra4mNY30f5KVZJvGzOD74/I79RBpHKPETxYccTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2LxOYZKLLVJD5c9m0JAHNNMsUDXR2gnJ9CITuCOE1A=;
 b=lVs4v+u3AE0b9+Mv9EzLW99dtZ4X5eVh+YvyxS/dj/tzDPSzm6VBJxE7rM1obMpItoCQBRmBhgf/QcO7iHgZVT7ZVcW6mAOq3hMxS5+h9Tc+IEaipJd5Ok+J9qKXYXyIgaXZbsua77tlvQ6Fl6NeQoLZdiMQXNqr+4cc5V7bbSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 07:03:29 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 07:03:29 +0000
Message-ID: <997293a5-a5e0-1216-6155-3eff7618b5e8@amd.com>
Date: Mon, 10 Jan 2022 12:33:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220106055732.3073780-1-evan.quan@amd.com>
 <20220106055732.3073780-4-evan.quan@amd.com>
 <4c820046-fc95-e7ef-c857-eebea6542990@amd.com>
 <DM6PR12MB2619F53DE7747026D05E3A49E44C9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <7dbaa69b-2465-c1ab-9676-4dec289d6356@amd.com>
 <DM6PR12MB2619470CEF4FBD3439694FA2E44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619470CEF4FBD3439694FA2E44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27)
 To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ae19cb-4bcf-4265-1a5e-08d9d4074e52
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3762C2175C47ED97A0C4B4AB97509@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1yNACRKq6KVuAnTrX/NflW8BIDrV2dG6zyHydLHPMSXPxfu3jHHabUFphot5Z1HrmCWQHkgSo9IxEiPQLf+Du8EKQn3PJixBYLMZItEIrd46YRj9O7/FTp5ugb3D3bSQ6K9BN+pf1H/QIdhDkFd0Qnj8DBeIUGkkGnrCLVts2tBWGxtOD77X34FiB/x+OqZds5sQE6UiYjsgV3OT0tLvTxXKIG1p+VOs3oobaQv5uNaves32Kb7vfsmGEXwQi7dByN82p5P+308rkWWUxDtb4csX0GArMWOGV+mid0JcKCQkxvdTnV7CtsKsW/4SfXM9UwHGuXTpSmuv/ubJrst7c9vdtDDfs9uO80Rx/S23P+PDtoDfz9LF209NopILBQZ743vAMK0/JpMVrj99DoC6PV2R6/W8mO1JDbOfxAvZTYdIjq10a9iGQphPUxrOFKTvmD6XVRnTOPLmYf8VF/qzMvQw5X5g6+wrqrkQWwRRhnhijnU1UtpoBz9prUfat1xDNVdYN3H8rU5xle4ZSj0W2k8WauitH9W5pRoXqH2hw4CHCU5J2rXhkdDyBPwQlrgqifWCbOix45PA783R9L0Yfsau7YLrMu6SSHO/4pPVJ3RCQ3VWCYnJj1ew9IUOgfArEOn3sBp8lM07EP8jg80hjBk2ONCpQKe9HHBlmM/G6WH5BRJ+UAIDwR7fnFNp2OzrSQ6F3IooQEe0MYF8cF4WA4O8WkFHWTiM4QMqvVH5Wk7q+gXNAmt7XmN9JQD9NYp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(5660300002)(38100700002)(316002)(6512007)(19627235002)(8676002)(26005)(30864003)(186003)(2616005)(31686004)(6666004)(53546011)(6506007)(2906002)(6486002)(110136005)(66946007)(66476007)(66556008)(4326008)(83380400001)(8936002)(31696002)(36756003)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5mNVRyWUxodUUvd0k1ZlNjVTNVOHBaV1Q0UkM3SVkvVTBERGdBS1JJVjdX?=
 =?utf-8?B?OHRKSVQ0UjcyV1lSRGRVRlNDMmlGMHFvdXNzNEIzbWEvU1dmanhkZEk3cWNP?=
 =?utf-8?B?Z0NrRmxPV05rUE9KTGdZNGhPWEl5VXNXdHV3Z1Z3UlZJMmxTWXRmZkloQ3Ry?=
 =?utf-8?B?bWEzYnhwUm5XL3p0T3IvWTFUWFdieUFtUXpHT1JBcGVXeHU1dHpZejdNdW5t?=
 =?utf-8?B?V3daQUJuLys1bDh2RDlNNmFINmttaER4Y0JwRi9VVUhycXpPSHdVU2lFUGNH?=
 =?utf-8?B?dHVPbUN4ZEFWTi8zbWRvd0F5Ym5tVHlzMUVObkx5UmM1Q0l1UERINVFUTzZ1?=
 =?utf-8?B?V293N0tFUkNnQmhCZFhtbXUzU1hOdkprelNMVW1QWjhQaXN5N2VjdDk2S2ZF?=
 =?utf-8?B?Q2xrNVdydm41aDZiRjJPTGcrN2tLK3k1cExrcWRiUHNTYXQrdjlQRHlIU3Jz?=
 =?utf-8?B?K0pMN2EvSE9lKyt0bTZ1M1VtMzdrdDhXZ2k3eUMxczYxWVlMZlhoK0gxRWt5?=
 =?utf-8?B?M0MrdkdMbEE3VC9hZFNieDQxVUFvcW9HMERoY1IrRTlvdVorRHo2S0tRSUFC?=
 =?utf-8?B?NXk0OFJCekRONVRJZzVNMFBQZDdoR0IxTlpEMy9HelNENXk2ZGlsOWdXTSta?=
 =?utf-8?B?M1h0TFJSTHRsWXpMWVl2V28ySFd5WXB3dExUUWFCNGhOSlFEVFkwTWZYQ1Vm?=
 =?utf-8?B?RUZQR2xoNWtFaXE5RHJWWFVkdDZhQU5RN2pybks1YW9PQmw0WGNEM0I5cUYr?=
 =?utf-8?B?SHNMZ0VlaFN2TjdxaUJlSEtFOCsrRnJheXc4czFGSDIyVkxGek5CMUtOTUJn?=
 =?utf-8?B?T3VuTmh5UnQrU3ZOR0p6YzZLMEJhSnc5cDVrdlBzajFtUjA1aWVBbXYwTEkx?=
 =?utf-8?B?eWNQWnNMbzhKLzZxaVU4MjlxbC8zNURIMDZiSXA1RDJpY1RkUjZHbmp1SWNx?=
 =?utf-8?B?WGFtV0xOS2YxM09TdENWM0pWMGJlQmkzc3JacE9FZ2xaNWlzUEcvRS9ORW1S?=
 =?utf-8?B?MkIzK29LZVFaSXlRdnl4ZGkrbnl2OEswRytqRVdLMStqWnpFeWlmcEsxV1Nq?=
 =?utf-8?B?aFFuaitGRlQ4cFYvSzlzU0RNam5mVmlvQm83QXBOYnl2dGZaUGk2VGgvQ1Mx?=
 =?utf-8?B?NHRGbzJ5NFhoRER6dEcvQ05MYUFOQ01LbmkrZzdIUGdqejNUbnhTMlBiT2lt?=
 =?utf-8?B?RjlpUURrSDFUMWkvSVcvWW5pZzhnL3gvL0NNeGRIN2djaUZ1blBPU2F4WEcr?=
 =?utf-8?B?ampGTnlUQkFxT2g2RElpMnI1djU2Z1lIdFJzSnR0R1k0WG01cllWaXp6eWxl?=
 =?utf-8?B?eW5GYkdlYmg5WHhhekY1NmtTTUZtQVh4Q2hZdFE5YndiL0RHcjBNU0ZacS94?=
 =?utf-8?B?ZlhuQlE3Y3RNZnVuU1dMTklxRWwvQ09ubzNlYVZPbm0zWHNyK21sZHo5dzFa?=
 =?utf-8?B?a3VNb1RoR2EzRUtueVR5RDM2WEkwbUFEQ3VadkovWm14VE0rZFNpTXpUV0dZ?=
 =?utf-8?B?bUVnbGs4OUFBMnkwM0JEZXJUT3BIbTh0SDJDZ3pYZWdJTnpyYnVSNHBXenQ1?=
 =?utf-8?B?R0RqS2RNM2ZFc2F6S3lKSU5wbERuZFo5Y3RpdUtCeGQ2eDFkQm1CT1hJSC9z?=
 =?utf-8?B?K24vVFk4MFFUTjNNRm8yTzcxRllhMVcwckZrc0diOWUyRk56RnVURXh6ZWFK?=
 =?utf-8?B?YUhlczQvRC9jUjlvdUtSY1dxL2xpcU5UYUE2Y1NyTEVJLytJSGlVQzg0Rkdx?=
 =?utf-8?B?KzJZQVVNVVVOMExJWHJsQTlvWXBaN3BNSU80UHFOQUJZNEpDWWtYV2VtUU9S?=
 =?utf-8?B?Y21NQ2psZjNoUDNTNDNLdXhYRE90YXYvenpJOHVWdGpVRFZ1ZlJocEFMOTg4?=
 =?utf-8?B?aDh6WVBPNzE3RnZ4bmkxZWE5MkxIeGtaSjQ5ZjhQTVZTcjdKM0hZUEJrY1J3?=
 =?utf-8?B?N0lHQUJsdCsyRVVJaWphZkRYaG9QSFpxcTZaM08rYXhVVm5tVTJsenFXTWJl?=
 =?utf-8?B?TXFITTMyamRNaEFYNVMwczNTVGJubUdnQ3Q0bjd0cHNNbmZudjVPbTZZZUxP?=
 =?utf-8?B?eHNNZ2NrSlpLR0ttODBGSWdHak9ESjFHclZUQzlQb3k1VUsrd0sybkFDN3FK?=
 =?utf-8?Q?7TzU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ae19cb-4bcf-4265-1a5e-08d9d4074e52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:03:29.6623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1gXqhjxs86b/XYBfwSdLMh7apcRzjgs5LlHirg9PrdtLHaWqSvpBUfMsu0eGTrC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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



On 1/7/2022 7:49 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, January 6, 2022 4:29 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
>>
>>
>>
>> On 1/6/2022 12:32 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, January 6, 2022 2:17 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu-
>>> metrics_lock
>>>>
>>>>
>>>>
>>>> On 1/6/2022 11:27 AM, Evan Quan wrote:
>>>>> As all those related APIs are already well protected by
>>>>> adev->pm.mutex and smu->message_lock.
>>>>>
>>>>
>>>> This one may be widely used. Instead of relying on pm.mutex it's
>>>> better to keep metrics lock so that multiple clients can read data
>>>> without waiting on other APIs that use pm.mutex.
>>> [Quan, Evan] If I understand it correctly, what you wanted to express is to
>> use fine-grained lock instead of cross-grained one to avoid chasing for the
>> same lock.
>>> Yes, that was what we did before and that's why we have so many types of
>> locks. Below are my considerations for this:
>>> 1. We actually do not have such issue that many APIs/clients chasing for the
>> same lock. Thus fine-grained locks cannot bring much benefits.
>>> Take the metrics_lock here for example.  The data protected by
>> metrics_lock are for those pm sysfs interfaces. Those sysfs interface are not
>> so frequently called. And almost all the time, they are called one after one.
>> So, it's rarely they will chase for the same lock.
>>>
>>
>> It's not just sysfs, there are other interfaces like sensors, hwmons etc.
>> Basically, metrics table provides data like GFX activity or throttler status that
>> may be continuously monitored by app layer. So other APIs could suffer. My
>> thought is to just keep metrics under a separate lock and not tie with
>> pm.mutex.
> [Quan, Evan] I doubt about the guess that "other APIs could suffer if metrics data is continuously polled by app layer".
> Since according to my previous test(watch -n 0.1 "cat /sys/kernel/debug/dri/0/amdgpu_pm_info") which polled the metrics data every 0.1 second, the smu busy percent was almost not affected.

May be try close to real cases like running some videos/changing 
resolution and run radeon profile or some monitoring app in the background?

> So, even the metric data is polled every second by app layer, that should not enforce much loading on the CPUs and SMU cores.
> 
> Also, keeping a separate lock for metrics data does not help much with the issue mentioned here(even if there is such).
> As they(app layer and other APIs) will still chase for another lock(message_lock which is kept) for interaction with SMU.
> 

Yes, only the subsequent steps related to reading table data from VRAM. 
Other APIs don't need to wait for this. Only thinking about profiling 
cases, may be I'm overthinking.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> 2. Cross-grained lock can simplify our implementations. It's hard to believe,
>> there is 10+(actually 13 as I counted) different types of locks used in our
>> existing power code.
>>> By the cross-grained lock, we can simplify the code and protect us from
>> some unintentional dead-locks(I actually run into that several times and it's
>> really tricky).
>>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Change-Id: Ic75326ba7b4b67be8762d5407d02f6c514e1ad35
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
>>>>>     drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
>>>>>     .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  14 +--
>>>>>     .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  10 +-
>>>>>     .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 112 +++++--------
>> ----
>>>> -
>>>>>     .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++---
>>>>>     .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  28 ++---
>>>>>     .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 +--
>>>>>     .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  23 ++--
>>>>>     .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  10 +-
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  21 +---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
>>>>>     12 files changed, 70 insertions(+), 195 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index ecbc768dfe2f..f0136bf36533 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -956,7 +956,6 @@ static int smu_sw_init(void *handle)
>>>>>     	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
>>>>>
>>>>>     	mutex_init(&smu->sensor_lock);
>>>>> -	mutex_init(&smu->metrics_lock);
>>>>>     	mutex_init(&smu->message_lock);
>>>>>
>>>>>     	INIT_WORK(&smu->throttling_logging_work,
>>>>> smu_throttling_logging_work_fn); diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> index c3efe4fea5e0..63ed807c96f5 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> @@ -487,7 +487,6 @@ struct smu_context
>>>>>     	const struct cmn2asic_mapping	*pwr_src_map;
>>>>>     	const struct cmn2asic_mapping	*workload_map;
>>>>>     	struct mutex			sensor_lock;
>>>>> -	struct mutex			metrics_lock;
>>>>>     	struct mutex			message_lock;
>>>>>     	uint64_t pool_size;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>> index addb0472d040..3f7c1f23475b 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>> @@ -602,15 +602,11 @@ static int
>>>>> arcturus_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>> metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -693,8 +689,6 @@ static int arcturus_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>> index 2238ee19c222..7ae6b1bd648a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>> @@ -150,13 +150,9 @@ cyan_skillfish_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>> metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -200,8 +196,6 @@ cyan_skillfish_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> index fe17b3c1ece7..fdb059e7c6ba 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> @@ -546,15 +546,11 @@ static int
>>>> navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>     		(SmuMetrics_legacy_t *)smu_table->metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -624,8 +620,6 @@ static int
>>>> navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> @@ -638,15 +632,11 @@ static int navi10_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		(SmuMetrics_t *)smu_table->metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -719,8 +709,6 @@ static int navi10_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> @@ -733,15 +721,11 @@ static int
>>>> navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>     		(SmuMetrics_NV12_legacy_t *)smu_table->metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -811,8 +795,6 @@ static int
>>>> navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> @@ -825,15 +807,11 @@ static int navi12_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		(SmuMetrics_NV12_t *)smu_table->metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -906,8 +884,6 @@ static int navi12_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> @@ -2708,20 +2684,14 @@ static ssize_t
>>>> navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>>>>>     	SmuMetrics_legacy_t metrics;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       true);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					true);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	memcpy(&metrics, smu_table->metrics_table,
>>>>> sizeof(SmuMetrics_legacy_t));
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>
>>>>>     	gpu_metrics->temperature_edge = metrics.TemperatureEdge; @@
>>>>> -2899,20 +2869,14 @@ static ssize_t navi10_get_gpu_metrics(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_t metrics;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       true);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					true);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	memcpy(&metrics, smu_table->metrics_table,
>>>> sizeof(SmuMetrics_t));
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>
>>>>>     	gpu_metrics->temperature_edge = metrics.TemperatureEdge; @@
>>>>> -2977,20 +2941,14 @@ static ssize_t
>>>>> navi12_get_legacy_gpu_metrics(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_NV12_legacy_t metrics;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       true);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					true);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	memcpy(&metrics, smu_table->metrics_table,
>>>>> sizeof(SmuMetrics_NV12_legacy_t));
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>
>>>>>     	gpu_metrics->temperature_edge = metrics.TemperatureEdge; @@
>>>>> -3058,20 +3016,14 @@ static ssize_t navi12_get_gpu_metrics(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_NV12_t metrics;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       true);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					true);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	memcpy(&metrics, smu_table->metrics_table,
>>>>> sizeof(SmuMetrics_NV12_t));
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>
>>>>>     	gpu_metrics->temperature_edge = metrics.TemperatureEdge; diff --
>>>> git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> index 93caaf45a2db..2241250c2d2a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> @@ -525,15 +525,11 @@ static int
>>>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>>>     	uint16_t average_gfx_activity;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -633,8 +629,6 @@ static int
>>>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>
>>>>>     }
>>>>> @@ -3564,14 +3558,11 @@ static ssize_t
>>>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>>>     	uint16_t average_gfx_activity;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       &metrics_external,
>>>>> -					       true);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					&metrics_external,
>>>>> +					true);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>
>>>>> @@ -3661,8 +3652,6 @@ static ssize_t
>>>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>>>
>>>> 	smu_v11_0_get_current_pcie_link_speed(smu);
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>>>>>
>>>>>     	*table = (void *)gpu_metrics;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> index 5cb07ed227fb..c736adca6fbb 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> @@ -273,15 +273,11 @@ static int
>>>> vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>     	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t
>>>> *)smu_table->metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -335,8 +331,6 @@ static int
>>>> vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> @@ -348,15 +342,11 @@ static int
>> vangogh_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>> metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -410,8 +400,6 @@ static int vangogh_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>> index 25c4b135f830..d75508085578 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>> @@ -1128,15 +1128,11 @@ static int
>>>>> renoir_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>> metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_AVERAGE_GFXCLK:
>>>>> @@ -1201,8 +1197,6 @@ static int renoir_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> index f065d95b117a..014fb88daa04 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> @@ -571,15 +571,11 @@ static int
>>>> aldebaran_get_smu_metrics_data(struct smu_context *smu,
>>>>>     	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>> metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       NULL,
>>>>> -					       false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>> +					NULL,
>>>>> +					false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> @@ -653,8 +649,6 @@ static int
>> aldebaran_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> @@ -1592,17 +1586,14 @@ static void aldebaran_get_unique_id(struct
>>>> smu_context *smu)
>>>>>     	uint32_t upper32 = 0, lower32 = 0;
>>>>>     	int ret;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>>>     	if (ret)
>>>>> -		goto out_unlock;
>>>>> +		goto out;
>>>>>
>>>>>     	upper32 = metrics->PublicSerialNumUpper32;
>>>>>     	lower32 = metrics->PublicSerialNumLower32;
>>>>>
>>>>> -out_unlock:
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>> +out:
>>>>>     	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
>>>>>     	if (adev->serial[0] == '\0')
>>>>>     		sprintf(adev->serial, "%016llx", adev->unique_id); diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> index caf1775d48ef..451d30dcc639 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> @@ -310,13 +310,9 @@ static int
>>>> yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>>>>>     	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>> metrics_table;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>>>> -	if (ret) {
>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>>> +	if (ret)
>>>>>     		return ret;
>>>>> -	}
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_AVERAGE_GFXCLK:
>>>>> @@ -387,8 +383,6 @@ static int
>>>>> yellow_carp_get_smu_metrics_data(struct
>>>> smu_context *smu,
>>>>>     		break;
>>>>>     	}
>>>>>
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 735e1a1e365d..d78e4f689a2a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -964,9 +964,9 @@ int smu_cmn_write_pptable(struct smu_context
>>>> *smu)
>>>>>     				    true);
>>>>>     }
>>>>>
>>>>> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>>>>> -				     void *metrics_table,
>>>>> -				     bool bypass_cache)
>>>>> +int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>>> +			      void *metrics_table,
>>>>> +			      bool bypass_cache)
>>>>>     {
>>>>>     	struct smu_table_context *smu_table= &smu->smu_table;
>>>>>     	uint32_t table_size =
>>>>> @@ -994,21 +994,6 @@ int smu_cmn_get_metrics_table_locked(struct
>>>> smu_context *smu,
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> -int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>>> -			      void *metrics_table,
>>>>> -			      bool bypass_cache)
>>>>> -{
>>>>> -	int ret = 0;
>>>>> -
>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> -					       metrics_table,
>>>>> -					       bypass_cache);
>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>> -
>>>>> -	return ret;
>>>>> -}
>>>>> -
>>>>>     void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev,
>>>>> uint8_t
>>>> crev)
>>>>>     {
>>>>>     	struct metrics_table_header *header = (struct
>>>>> metrics_table_header *)table; diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> index 67a25da79256..f0b4fb2a0960 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> @@ -101,10 +101,6 @@ int smu_cmn_write_watermarks_table(struct
>>>>> smu_context *smu);
>>>>>
>>>>>     int smu_cmn_write_pptable(struct smu_context *smu);
>>>>>
>>>>> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>>>>> -				     void *metrics_table,
>>>>> -				     bool bypass_cache);
>>>>> -
>>>>>     int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>>>     			      void *metrics_table,
>>>>>     			      bool bypass_cache);
>>>>>
