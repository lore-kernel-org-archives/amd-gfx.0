Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD08C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 18:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CECEA89A72;
	Thu, 23 Mar 2023 18:06:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F2689A72
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 18:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SczFqduWj301i0usF8nyswSavoIbOhJwMiAUwDMc/XoqBiDLHtJ8sKm4GR8/PNUyeMRUfnKnqDxudXG6R5x3o/skOxwN1V8ZgQuSvNT7gIXgAJ2VgiTXPHLlRU6RwfzYFuHSvJR0Sx/++bsj95MBpDCmVa47JId4JntweSp3Yp8LneTu6n2bdFYkHknSPlTK4N74zS4JXA0KTyptUfh+YIa8vIi0DXULn06LYbn5mQeFYJMervsp2nOyFFpGsBsEykYtmas1C/87pK2qwATGjliY4vAdjvyvvF14z2gKu78qLYr53OCb1rmSEHK0r6uAHFG/gc1SeMdzi7PthnViBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DvytGo2x4f5fXG6gXs4P/p0QyOZLFuluEflFJBce8Q=;
 b=dYujWnaYRHWHxUVrvLfuRzwnMGkcfwbXytnR0850dQ4opsK3aIQwRmRfdOnMhr9w2WNzYnx/q4A4lTCwCQx1GkWLB7hYsHhFAAkv/Iy0kUAhx6M/85DLpmx5kVbVIZgSquNLtIjvNCXM/j+vXWnaAcrqBhqI7xzxgRwkDISe8WnhjrF23fi6DoHBDW55jKt7TE4Kt9z/toX2D40TDf8HrXVZRfFWXfkgEcO1P7/M4L/Evqb3Gv056zLIou1a+ZNjnmSwf3ZzQMdapNZN9cFQHx5m5W6z2GFWtolW3bXwxpyyJVdxnGvcVAzNQm8QjZP+oI7G7fdY9TuN/R0MPoXNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DvytGo2x4f5fXG6gXs4P/p0QyOZLFuluEflFJBce8Q=;
 b=0TqrBa19cnI8rh40RYcX0gNhNJMod8j7TG5fjDytTVM/yfY/t7EkolfBiE5fz6ZmRJmwOWNnNFNy24yvpnefHeDqfW2MyfC7sg/ZEySUBmfrlv8h+MHqHl1SCzlth2jwsmG4OnfI2yApuTcNaslkZFZ1dy0XU8gcn1cLG2bD9zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 18:06:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 18:06:18 +0000
Message-ID: <07785bf1-80a0-e6db-66a3-eca43c5e945d@amd.com>
Date: Thu, 23 Mar 2023 13:06:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230322054808.1555230-3-WenYou.Yang@amd.com>
 <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
In-Reply-To: <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:32::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: b68cedda-7cbf-449b-2fc3-08db2bc94cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6+8SnU4tLjh6F2+33dFbHyuSGRwYbeMIWAd31rumSd+HtvQc+w0jQV+6SiOGVwYbTfawi5s4SC4eZ/Spl8aMP1aiNEhYHY53uZOQ4Xwz0XLv8BIW2Su/eP48y2fGFrjtMoM+SNyYltfF56x4dWqhobsPVn52EU0kFOlcV40kxaG43Zpl+VHtysSleqIqMiapjyj2O3Dqzp7eEwxdKILneMbJFG69FIqB2sGKEPS2DfQcB/RXdbzsbepwbrWpr+WRlcmSbVQYld8+4heuXOg4hC2ilYWwX3JI0EUMXGyDYReav3Pcy+RxslDPk3topp+KROpkp4kj1wtiJlexe3PN4hoe7ttFNIQxT0m+u9p8I1p7J63A19+UEbgISdS9HDgQfxMbKvCFADrkjjg3HsdNqzFRbxzPnH1PwyNBBbYqivSKe/Q4SNGYXb5Xe8Wfpd7EYdnForDLFRtKEpjfElU2WQl/M7nxcyb6UQK2oy4wC23LBvOIq+qnh2Z347rdajWC2PQ9fDMZH9kQ9eYYu9/jMebpPcMzH9lnuJGB8OFmfPhYCHjJ+HNB7DOjYmbzPgK+Lyl568fSrfaLKfx6Xof7cieNUbxZSooB8ZHq4Kc+I/yrGWf4ov+vH9PhdjxN7LXtVzTxpEG9T9fQaxqJDxAqKT62FUJ4EgLBUfl23hBMXCx6wYrxCNXsM6bztJZ5pBG2dXE+eB3IZd86b9pRXPycqqzV/GflRI9mSX2TDzs5VM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(36756003)(66556008)(8676002)(66476007)(66946007)(4326008)(6636002)(41300700001)(5660300002)(15650500001)(8936002)(316002)(26005)(53546011)(6512007)(6506007)(6666004)(186003)(478600001)(83380400001)(2616005)(6486002)(86362001)(31696002)(38100700002)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHQ2czZvZDNPejRuaGxrT0NLUG5HN09RNi9aUmQ3Y0JoOTBTMnBBajF2dlNE?=
 =?utf-8?B?N0tuNktJOVFoa1ExR04zM3RZZ2d0S2R6WlhWcVcwTVVrak1oZk14WGRRM1dS?=
 =?utf-8?B?d1VKMDVlV0RzanNORThNdXA0eDg1NkZ1OHVwVlJTRmhDQ3Z2T1NMU0t5djhX?=
 =?utf-8?B?dzdJVlVDNWJrTnFzNUVGZDlobjRmcGJmRW1zTjRXWGZkS1JLZEtkNmJrRkU0?=
 =?utf-8?B?T0xOOExnNjE2SXgwS0tzSkd1bHc0cER2N2JpTU1HcllpNUFMcGxMUnhkK0Z6?=
 =?utf-8?B?UmdXd20zdVhoYnNIKytmRG00M1hZSFQ1eFJVNk81T2huNFVkSlJXdy9hS3RO?=
 =?utf-8?B?aFAyd25keDVyNng5aEFicFIyNklUTDNqZnBXVmI5ODg0cjVoeUM4cGdpdlZa?=
 =?utf-8?B?MTlSOFAxTFBMWTloYVlDdm01ZXF3b3orbmdqM3FTWDFzYzN4YmFnS3h2U3Yr?=
 =?utf-8?B?SEprbGVkRDJjeVdLMDdUaGxkb0pPQUszUkFNdE9qdlU1VURPWk1NZzREVDVZ?=
 =?utf-8?B?dGxGS05JaHpQMVFaQnRiT200U2h2ZzdxNXVSbmQ5YkRHOWJ1ZXZNbUM3M0xU?=
 =?utf-8?B?eHF6YmpVS2kvcisrVG5MMUd1WjBWbmJJYWRxRFVZcWduZVYvZlBRRkJ5N240?=
 =?utf-8?B?N2JnRUFxaGl6VGZQWVlYSUJodVc3NDNiZjRqdUwwRXZxaXh0ZFJxVFE4cnMv?=
 =?utf-8?B?bURLZ1kxbkpCd1hTSmthdnpIdGlZZjRVbE5WZEhaaFV2WTNTREFKUHhpZXBt?=
 =?utf-8?B?dlV5b3ZDQ1QzYjlOams5dDNjMDBaWXpVUm4xTDUwZUIyak1RTGRhc1hIYTVM?=
 =?utf-8?B?MjNONnNIc1AwUHQ3ZjVPc2J3dldxOUdmK2JqQy9TanUra3BFWTloZG12aDdO?=
 =?utf-8?B?cmIxQzZCeEdFcDhCVWJTaXYzajRZMEc0c1VoVnh1N3hURFBkeXRGeC9JWVpP?=
 =?utf-8?B?Q25oY1pqTWxZeHJ5MjA0RHpxU3NQM1h0ZDF2RlliWHExcEdEdUFVNjdxZTFm?=
 =?utf-8?B?RVNoL3pDbURnUkxjc3RQVUM4NmNMcVREV3dkWFBiZnhSeFF5Vis4TS8vQTh2?=
 =?utf-8?B?YzlFSEx4LzVaUFdjS1JURDV0UzVJNmZNODNkRytsbjJyeTNKTXhyVkVOTlhL?=
 =?utf-8?B?MXdvR3o2QllLd3k2SlJodGNER043V1dxSG1uYzF6Wm51cUp3M0FHZkNadERj?=
 =?utf-8?B?eG1qSWgxSnFlazFqTDFXZWk2L3k5ZFNza0g2Z3BmTnlSVkR2TXljL1U4ZjBz?=
 =?utf-8?B?MmlXUmtuUjZaTis0Vzk3RTNsdlhlOXVLL0w5WjJ0aFlHbWlrUFVNNlAxUUFy?=
 =?utf-8?B?T1JOMUo3N0piejd5L3Iya0JjK1F6cUpuUHA2MVRhVTZkY0V3akt0VWV6Y2VQ?=
 =?utf-8?B?NG00dkxSVyszMUw1S3F2TldWVGRYTXc1YmFQNy9RQnJLTlVjcytGWnFmTlZy?=
 =?utf-8?B?WG5IMlZxZGVwbEZwNVhFa1pRYVVyNmRPbGUzeDN1ZXhza1lUV3RpLzVBZ1Y1?=
 =?utf-8?B?UEJVelB2QjZRRFR6SlNoWU13b2d6Qk1pQmxESXBKak45aE0vbW1tekg5Szhu?=
 =?utf-8?B?N0xmMmhtU0o1dnJkU25Nbmg5L3B2SSsrRHBTY2RCT29nMUxqcERXRGFUZ0or?=
 =?utf-8?B?SHNGRG5aSXEwR0ZscUZpcXNkcUZsYks1L0IxZTF2WVFUYzlkT2dnb2hOdnRm?=
 =?utf-8?B?UllJWkx0Szk0Qk94ejljWXgxdUZ0dnZhV2lSTjg1bmg0aUUvKzRpMmE3MlZK?=
 =?utf-8?B?RzRoU3p3aks4dVJwM1MvbTNobThTN2ZXbXF3VUpzTzV5b0UxdWVWbWIxWFpw?=
 =?utf-8?B?YTFQMnU0K3o3YTFlQUQvTi9uWlVZSTNuWVRCMFV5TjlBeVBoN0Q4eHVDeDBM?=
 =?utf-8?B?ejdHZ0g5OEQ1QnZBOXBOc0EyeSt4aS90UUNKWXBvYUxZU0NPdE9NQ1JVQ3J2?=
 =?utf-8?B?a0tOUzJJcXJOYWFTN3RHT3RDbGhZLzR3OVhxMjNtTXFINktiWmhhYTlITzR2?=
 =?utf-8?B?dzJmSnN5UC9iTlJTT1dKQW1DaUVkRUlzMHU4cHFTWk52N1RnU043dXc2Q2hS?=
 =?utf-8?B?Z21URCtSMjVpZGdQZkpCem9pNnczWXY3YkZTSjI4dmFrT2pSc2lhM3kvbjBN?=
 =?utf-8?Q?h7YDfarLauR7bRTFlwDGYTIw5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68cedda-7cbf-449b-2fc3-08db2bc94cf1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 18:06:18.4071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7vzTdH6YLfMB3/IDN5O0SgP2vTwAu4MRcVoTzdIswENVMNhgK7l83fjzdURSOa1svg53thb5sGZqz9Em57bJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: ying.li@amd.com, kunliu13@amd.com, richardqi.liang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/23/2023 12:41, Limonciello, Mario wrote:
> On 3/22/2023 00:48, Wenyou Yang wrote:
>> When the CPU SMT status change in the fly, sent the SMT-enable
>> message to pmfw to notify it that the SMT status changed.
>>
>> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41 +++++++++++++++++++
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index b5d64749990e..5cd85a9d149d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -22,6 +22,7 @@
>>   #define SWSMU_CODE_LAYER_L1
>> +#include <linux/cpu.h>
>>   #include <linux/firmware.h>
>>   #include <linux/pci.h>
>> @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle, 
>> uint32_t speed);
>>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state 
>> mp1_state);
>> +static int smt_notifier_callback(struct notifier_block *nb, unsigned 
>> long action, void *data);
>> +
>> +extern struct raw_notifier_head smt_notifier_head;
>> +
>> +static struct notifier_block smt_notifier = {
>> +    .notifier_call = smt_notifier_callback,
>> +};
>> +
>>   static int smu_sys_get_pp_feature_mask(void *handle,
>>                          char *buf)
>>   {
>> @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>>       return 0;
>>   }
>> +static struct smu_context *current_smu;
>> +
>>   static int smu_early_init(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -645,6 +656,7 @@ static int smu_early_init(void *handle)
>>       mutex_init(&smu->message_lock);
>>       adev->powerplay.pp_handle = smu;
>> +    current_smu = smu;

Although this series is intended for the Van Gogh case right now, I 
dont't think this would scale well for multiple GPUs in a system.

I think that instead you may want to move the notifier callback to be a 
level "higher" in amdgpu.  Perhaps amdgpu_device.c?  Then when that 
notifier call is received you'll want to walk through the PCI device 
space to find any GPUs that are bound with AMDGPU a series of 
wrappers/calls that end up calling smu_set_cpu_smt_enable with the 
approriate arguments.


>>       adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>>       r = smu_set_funcs(adev);
>> @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
>>       if (!smu->ppt_funcs->get_fan_control_mode)
>>           smu->adev->pm.no_fan = true;
>> +    raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
>> +
>>       return 0;
>>   }
>> @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
>>       smu_fini_microcode(smu);
>> +    raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
>> +
>>       return 0;
>>   }
>> @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct 
>> smu_context *smu, uint32_t size)
>>       return ret;
>>   }
>> +
>> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
>> +{
>> +    int ret = -EINVAL;
>> +
>> +    if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
>> +        ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
>> +
>> +    return ret;
>> +}
>> +
>> +static int smt_notifier_callback(struct notifier_block *nb,
>> +                 unsigned long action, void *data)
>> +{
>> +    struct smu_context *smu = current_smu;
>> +    int ret = NOTIFY_OK;
> 
> This initialization is pointless, it's clobbered in the next line.
> 
>> +
>> +    ret = (action == SMT_ENABLED) ?
>> +                smu_set_cpu_smt_enable(smu, true) :
>> +                smu_set_cpu_smt_enable(smu, false);
> 
> How about this instead, it should be more readable:
> 
>      ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);
> 
>> +    if (ret)
>> +        ret = NOTIFY_BAD;
>> +
>> +    return ret;
> 
> How about instead:
> 
>      dev_dbg(adev->dev, "failed to %sable SMT: %d\n", action == 
> SMT_ENABLED ? "en" : "dis", ret);
> 
>      return ret ? NOTIFY_BAD : NOTIFY_OK;
> 
>> +}
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h 
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index 09469c750a96..7c6594bba796 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -1354,6 +1354,11 @@ struct pptable_funcs {
>>        * @init_pptable_microcode: Prepare the pptable microcode to 
>> upload via PSP
>>        */
>>       int (*init_pptable_microcode)(struct smu_context *smu);
>> +
>> +    /**
>> +     * @set_cpu_smt_enable: Set the CPU SMT status
>> +     */
>> +    int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
>>   };
>>   typedef enum {
> 

