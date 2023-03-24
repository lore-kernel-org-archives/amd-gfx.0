Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EF5C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 02:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E371F10E4BB;
	Fri, 24 Mar 2023 02:29:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DF710E4BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 02:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2sZEt9Gb8impb2bt479gwEMLCRM+4mKsTOyyj7gODKPSUpPmtGvDsM7W3R7N0RU3c/MP2+9J0mtLR3M+kVXIjKMmjc+RxPl4a5CuNXF7KIdLVFnATID/2IHVWFtAuFHvZNvWeK058BC1hDoBOTFiA5LtZc15SNhgvd/m7f5TQKJ6GdRu+9kzh7k2kJlA0BXmzBmTlxdyqIyTjC1+5UjhieIxjmq5FBottpo/ZsgmFqs+kEKghW1796cMsfAn2Sb9cTEifQv2APMc1c8X9QVAa84KnjyxdPwEHU/q0Uqd9ONnhFnMMnLPe3eF7FrvnesY+LLuAmx+sYtL1l+wbEkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68Vblbms+EmhlWocvx+JfF7znWoFjpSJlxEQtevdkT0=;
 b=ZEnjchLzr1Oe2pVd4yfucp4+P3hZL4lja91dBwQYkRVY7WfMmjAbcgy/dHKJqEXGoaOj0GqV/2REJiGT6cOoFbU0Pkk4yLU2fz2x+eTur3yfjW8FBRqjzWfj0frS2QCGKwpCpzb4iGT1wFNU4Qf1fM78ERER4iF3qmlBkyRMSjHZ+qx2OgSs2v4qPaEZCbjaUqIWVgGjS43istp6IuD2z3pwV5Yo09nDrCZl3dfgigEhQE2ZHsq1s8MTaHnWoWYgFVCsz8uhyKQKYmIoiXz2ow9DkSFxF27O4TCglTK7WGOud3YtNBnMvCrMODzGewkWXqeM+ZTr2ZU+aSMFQ8gIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68Vblbms+EmhlWocvx+JfF7znWoFjpSJlxEQtevdkT0=;
 b=zNkHEagshF4Nov4bmuJ9sJ8oU4Z1BiXC+N0gQKsXVJo8zRKf5zhceVvM8zMf1ApmfmVoFv6Hod5tjHEVVi/36xuaxz/4tUMBijOrKTb8g2f0z7WEC5C5i0hl0oeFvu2de8bXOAt8iN8bdQiKgMoH1pv5OGMprMPyEyfhEll4Nzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:29:35 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 02:29:35 +0000
Message-ID: <fb4548f4-098a-c9ed-26ce-4c98d7219773@amd.com>
Date: Fri, 24 Mar 2023 07:59:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Content-Language: en-US
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230322054808.1555230-3-WenYou.Yang@amd.com>
 <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
 <07785bf1-80a0-e6db-66a3-eca43c5e945d@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <07785bf1-80a0-e6db-66a3-eca43c5e945d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: d27e625c-8928-4ccb-364a-08db2c0f9aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePAguD1QPJ7NmoX/0Y1qAMO8rqRGsm04TYtaie3EfepO9FNbhvneIhcopyRdWQ/Rk0UyaMYPgX9pY8X5XBHXW4FihKGO2qwVHe5avsEaCkl1j3h8qhEGHpHaB3QXl1yl7Zlx8yG9VmpdVNxtBw/E4hVbl9MLr+TiO/n/y388EAJxK8WpvIH9CflYjt7wtJRKBW9iYD6tJ6aHIK+aKSYj4LlWN+CK0WChNx7BMHmQ8IfAuVLVco53OnfLSXa2GDrsRRMFJlwzRiT69Ldl7pklWzj1eNRsVdwQMPlq+FXCv2Rr2XyTJRvjA+Q38mu2loWylLdJcGC/X/1ZdZK0XU4gXu8+7FQd3ruTAnV1mB0P23JtSio6s/hA9wvvbAYf/UlosOL7eW83FnROF2/3DQl1l40amKIthX5D752i9+sr8MUJlBlWhqfsbwkdP49KwHivI3QdPXt4BM/qw/9NWgFXIVs+04CKeHDFJvdLpZKXw84Kv+RhkEcAKOP8FDV0aLPQqqkCWiTaaDKYSSKwa+r+aVlbTTuwQKjjk534CZwu+3w0f031vfaaKDrzQu7xoqvdDX7FfBvrKocwWyDhH5BepF51hMe73K1j3201H0VWVYUta8nhKtb6+pGsKgIip83tJhtb0z2oDqXkprSVb92kAq05CdESLDjuPgtL+Q2z9QLAm9eOTuujgfLjYLIFGZpbfaZU1mQJkSRMgHIz+1LEyD0weL7mflXjZhWjxDakPSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199018)(478600001)(8676002)(66556008)(4326008)(66476007)(53546011)(6636002)(66946007)(110136005)(5660300002)(41300700001)(8936002)(6666004)(15650500001)(6512007)(6506007)(26005)(186003)(316002)(6486002)(83380400001)(31696002)(86362001)(36756003)(38100700002)(2906002)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnFja0hPYVk3R2NHYisvS0Y0OEJNY3RscHYzVUNGR0krZ3A1YXlBd1pVUzVs?=
 =?utf-8?B?clY2QnVhRkptaUNrZmFZeUNxajBRdWxlWlEvSTFiMHUrUjlnQ2YxQUplbXJp?=
 =?utf-8?B?Qk1OK1BVV3U1Q1pnaDhORnhhWmtLZ2FscjZKMWZuekQ1Umx0K1ZJMStGc1lm?=
 =?utf-8?B?OG8xTmVXS0NmZW5sUXN2Q3JiYTNiT2JoRmVlM3ZPbEtvQ0xqQW05NlVFa3dt?=
 =?utf-8?B?L0cxdlBOdGVaaTlSS3JyRjNzWkw0OW9IbDR0MnFpdGRmTUpEbmtEYThvZzlV?=
 =?utf-8?B?R0ZGOWxxUmdIc1JwRGVXTEowQWRNUEJiQzFUbThva2RoZThoNU5GUnkxUEk2?=
 =?utf-8?B?SXZyR093QnpDV1p6SEVjb0phbEFyczJYdG1MRTdveDJ0UUl3ck5jYmdJTUV5?=
 =?utf-8?B?dWY3SHZJVzZkSTdTbEN3U2V4bWd6ZFNITVFoL0tONkozZThqSUVqUlBTb1Rk?=
 =?utf-8?B?aGZOU2pjQjVpQjRYUDdObm9semZFSFNJNW1tclBCTW5YWmxIQ0d1TzBxenB4?=
 =?utf-8?B?RFJSdno4dEszWllSM0NvREZTYzN4ZnBabWl4c1hsd3lKRUFiMkRTbXFzdWJr?=
 =?utf-8?B?MWYzQjdaZXhaR1hkNUJRWlh3RWw0KzVtQVV3cVRxN0dLM3gyZVVVbUt5NUFa?=
 =?utf-8?B?WEZxdFYxOGlYMnE1aGw4SkpGYXNGN1FBREVCMlNxV2hsUjZmcDVEZmJtaFY3?=
 =?utf-8?B?aFkra2hRaldjOUNmZXIrUkZHbnY1UUJGY0pmUW9ScVYvQUNFWEFyR2xSWUIy?=
 =?utf-8?B?NzUrNUZLN2NxZUY0cVkvREcvNnM1dUpMWHB3YnQyZFEyM0hlZVFJL24yalh4?=
 =?utf-8?B?OTBWdUJCZEYvSk9jZEYvby8rTFIzazRHOEU4K3A1dWUrK1NlVVlsU2V5dHFx?=
 =?utf-8?B?RnVjbTgrNUFxWjNaeXJKU3ZCbksyTDV0cDE2OURJdkFxVTdURFV3ZmQ0UDNa?=
 =?utf-8?B?a0xzYTQ3a1k0ZU5uRHROSk8xRm1WcG93M0NVS0xlUk1naXBpd2cxUCs5dWY1?=
 =?utf-8?B?S1dyYkUwejNUaGkrNGlqZ3ByOWxiYWNCaXZXUnhVUmVQa3VWeHZrVG1WT3RS?=
 =?utf-8?B?cE1CSHdKanBmcmVwbmxEVWdkblp3VUw0cHVKRUxnM1lvU3J6QklCTUR6a2c5?=
 =?utf-8?B?UUFuandIRHZvbjB2bXN3QUl2ZWFKNlNjOHBuYzBFelgyaUZZTmVCTU84WkVj?=
 =?utf-8?B?U2prTTdDSGw2Z2JCT3hlYmJXeFhzWDlKU3ptcytoNW51UXAxZ0dhTXVUamtt?=
 =?utf-8?B?MTR4TVR5ZVBFOXNBWnBEVElnSk9RaDlJOHBaTlBpdWFsYnBqb1hhWDVCR1N6?=
 =?utf-8?B?SHduUlU4MlNQVFV3dVZFUGR1NUYveEc3UXBlaGVNSm0rMFN0V1ZacDdiSzhF?=
 =?utf-8?B?SEY5VHRLUWppcUpDVU9mQWRmR2dTN2krY2dQN1RkNTIvc1ArWDVUT3ZpQmtw?=
 =?utf-8?B?UjVid3VscE8xUEtuZDRRdFBzam9DZmhNZjFWSzAwd09XV09UeXl0UWI3YXBU?=
 =?utf-8?B?REdvLzlZendCTlFpdDVoKzdEalQyemVXS0hUVE9idlRJOXUvVGUwV3ZJMU55?=
 =?utf-8?B?bkpldGtTaXRkYTJTRVJXdzltanpxWEZSY1c3aVl0UFhYRW5nMFpPdXA0U2tp?=
 =?utf-8?B?WWFPMUEwNVUxU1U3RkFQQkpHRmtLeVQ0N3d6V1gyRW9SR2hCT2k0eEhyaXZ5?=
 =?utf-8?B?VWZLVGxNamMzZXJOMHJwaUpVTXlsRFJJMnQ0aHRFTEcyRWJIdWUwbzFTN3pr?=
 =?utf-8?B?bjNxMXFSS1JUU3RYMVZlcmhMNmViTFlLUkk3d1pRblh6Z0pyVlB2SmpYVFA1?=
 =?utf-8?B?c0RzQkRNcnRqNjRsQ0c0cXI1ZGxKS2hJVCtOUU5URlZoTEVnZTVDNTNnd2hn?=
 =?utf-8?B?RjExUGpsMHJWMWFSRTY4RVdQaGlOOUUwSTBwSVNSRU5DNXE4SmxOQXVPMk01?=
 =?utf-8?B?WUtBRW00VzBaRUh1ME9kcmpmcVM0QlJpaUl5NUQvT2gwY090SHVTTFAvc2lx?=
 =?utf-8?B?azJjdTgvTFJ1K1FlR2JCaitPSEhKcmFyL051OWN0SE91SnVEUm9rMU1HNUg2?=
 =?utf-8?B?MlZDdm9BaG1mcGRkQ3JyTnE3MmdvZk85eEphTVVGMUhIRUpOMmxFeW1mbDhN?=
 =?utf-8?Q?WEr93eoZ5HDpPmgKeps34sFwd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27e625c-8928-4ccb-364a-08db2c0f9aaf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 02:29:34.5299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sguQiWeCII6FF0eV5iICQwzxVSdCldcNqDaWfbz3e6c7rl6euBqix3OyMV07CTg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
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
Cc: ying.li@amd.com, kunliu13@amd.com, amd-gfx@lists.freedesktop.org,
 richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/23/2023 11:36 PM, Limonciello, Mario wrote:
> On 3/23/2023 12:41, Limonciello, Mario wrote:
>> On 3/22/2023 00:48, Wenyou Yang wrote:
>>> When the CPU SMT status change in the fly, sent the SMT-enable
>>> message to pmfw to notify it that the SMT status changed.
>>>
>>> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41 +++++++++++++++++++
>>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
>>>   2 files changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index b5d64749990e..5cd85a9d149d 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -22,6 +22,7 @@
>>>   #define SWSMU_CODE_LAYER_L1
>>> +#include <linux/cpu.h>
>>>   #include <linux/firmware.h>
>>>   #include <linux/pci.h>
>>> @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle, 
>>> uint32_t speed);
>>>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>>>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state 
>>> mp1_state);
>>> +static int smt_notifier_callback(struct notifier_block *nb, unsigned 
>>> long action, void *data);
>>> +
>>> +extern struct raw_notifier_head smt_notifier_head;
>>> +
>>> +static struct notifier_block smt_notifier = {
>>> +    .notifier_call = smt_notifier_callback,
>>> +};
>>> +
>>>   static int smu_sys_get_pp_feature_mask(void *handle,
>>>                          char *buf)
>>>   {
>>> @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>>>       return 0;
>>>   }
>>> +static struct smu_context *current_smu;
>>> +
>>>   static int smu_early_init(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> @@ -645,6 +656,7 @@ static int smu_early_init(void *handle)
>>>       mutex_init(&smu->message_lock);
>>>       adev->powerplay.pp_handle = smu;
>>> +    current_smu = smu;
> 
> Although this series is intended for the Van Gogh case right now, I 
> dont't think this would scale well for multiple GPUs in a system.
> 
> I think that instead you may want to move the notifier callback to be a 
> level "higher" in amdgpu.  Perhaps amdgpu_device.c?  Then when that 
> notifier call is received you'll want to walk through the PCI device 
> space to find any GPUs that are bound with AMDGPU a series of 
> wrappers/calls that end up calling smu_set_cpu_smt_enable with the 
> approriate arguments.
> 

This is not required when the notifier is registered only within Vangogh 
ppt function. Then follow Evan's suggestion of keeping the notifier 
block inside smu. From the notifier block, it can find the smu block and 
then call cpu_smt_enable/disable. That way notifier callback comes only 
once even with multiple dGPUs + Vangogh and processed for the 
corresponding smu.

This notifier doesn't need to be registered for platforms only with 
dGPUs or APUs which don't need this.

Thanks,
Lijo

> 
>>>       adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>>>       r = smu_set_funcs(adev);
>>> @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
>>>       if (!smu->ppt_funcs->get_fan_control_mode)
>>>           smu->adev->pm.no_fan = true;
>>> +    raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
>>> +
>>>       return 0;
>>>   }
>>> @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
>>>       smu_fini_microcode(smu);
>>> +    raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
>>> +
>>>       return 0;
>>>   }
>>> @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct 
>>> smu_context *smu, uint32_t size)
>>>       return ret;
>>>   }
>>> +
>>> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
>>> +{
>>> +    int ret = -EINVAL;
>>> +
>>> +    if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
>>> +        ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int smt_notifier_callback(struct notifier_block *nb,
>>> +                 unsigned long action, void *data)
>>> +{
>>> +    struct smu_context *smu = current_smu;
>>> +    int ret = NOTIFY_OK;
>>
>> This initialization is pointless, it's clobbered in the next line.
>>
>>> +
>>> +    ret = (action == SMT_ENABLED) ?
>>> +                smu_set_cpu_smt_enable(smu, true) :
>>> +                smu_set_cpu_smt_enable(smu, false);
>>
>> How about this instead, it should be more readable:
>>
>>      ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);
>>
>>> +    if (ret)
>>> +        ret = NOTIFY_BAD;
>>> +
>>> +    return ret;
>>
>> How about instead:
>>
>>      dev_dbg(adev->dev, "failed to %sable SMT: %d\n", action == 
>> SMT_ENABLED ? "en" : "dis", ret);
>>
>>      return ret ? NOTIFY_BAD : NOTIFY_OK;
>>
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h 
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index 09469c750a96..7c6594bba796 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -1354,6 +1354,11 @@ struct pptable_funcs {
>>>        * @init_pptable_microcode: Prepare the pptable microcode to 
>>> upload via PSP
>>>        */
>>>       int (*init_pptable_microcode)(struct smu_context *smu);
>>> +
>>> +    /**
>>> +     * @set_cpu_smt_enable: Set the CPU SMT status
>>> +     */
>>> +    int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
>>>   };
>>>   typedef enum {
>>
> 
