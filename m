Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0183C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 09:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8122F10E067;
	Tue,  8 Mar 2022 09:35:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2318B10E067
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 09:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekUBYDkVa/VctxR3ljIO1FuCtuJOP2SRGme6ehnziRgvA/YFJ7Xf/fwu+EDm+rSHXjc2SojnbXU2a/IRAfbXowkzfBtGlVKcs85Wnv/VSmXzH4fF4ALMT+BjFDwB6j/BsLTWpQHFhY9zonrDlfcMQ2ixkyqNX/wl7t5y2Tt194WfH7CBTANB/p/nlFgQcLIEhXZbZjRaOdQ03HVhpReKCrFky7HQ1M8J6SkBUNRvzmFIJvOmqYriTalDd22yzkM9vgI12S9uMQ/eajzqsMa2ydqx3D6zL30FKQ4NJJAyVF1bSXTk3fywAqxyp1gbgflzBv+t1Di2k8Y53E9fjB/TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxAp5LgNGNubrxnWd6OFbPGBHGj05fbBUE1OUoxcH5A=;
 b=KsRQEs/Bx9UtGnFpMZr/H+OQfh8+HO0sRIw+o7f7NOCDZEKI6aAiX301fwZrBO46O26tiibVCWp6ToN1U3vo6GAXEYoyDe2AN3pObRyB92UFMUn84JF1fG8ZrWjXrLqR1aVHVsZ1oGXWYQLIZzuFFe71jGTjjL295mpfRirCNqFpR6I0/C5eM7D+XDlcX9LE6nEMjAdLky3GizxXgqqkz8VKltJnDjcqEsVkjBf73YwMp59dVlwHZotLiEkHi31sZxfGXEbpLiVGwZsSmEnQ27feZVirEgfuboHfD9LuZm2mUb3wCO64jj/nMCu71oybAXzx288uDjCaKe+Mkope2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxAp5LgNGNubrxnWd6OFbPGBHGj05fbBUE1OUoxcH5A=;
 b=nFWycSIkX8GInWdXRzmDrLhefEFyw0DpmefVYQwkBaC8wALMQXnUePoOQqwUOpXKfYcaCb0eCP0+J30segfbby2L6h4GYNjtd/y0tLHQmuXmebC6qyNa6IWjtlHaWWPanG+o7PIE/MdIxTA8RKtg0ckljbYDcf3sPmQTJ78rREQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 09:35:23 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:35:23 +0000
Message-ID: <2e3beaae-4b93-dc50-d215-207d39e3e2b5@amd.com>
Date: Tue, 8 Mar 2022 10:35:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
 <8d35cf70-0dc3-6fd5-6768-9530d729ae63@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <8d35cf70-0dc3-6fd5-6768-9530d729ae63@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0005.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bdaf589-448f-494d-0a3a-08da00e6f7f3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5152:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51522ECB2D836D91DF604E1AF2099@DM4PR12MB5152.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y75+HZDao7KxGCvUl3EVHuVooZTRDcRNnsDqzQWyKt4VFo/cv62voM6bTV5Eim5G0Eqe5bcQRipfoZnRq+MQy1SANASFehrcDR+dlqPRHG/xUoqU4mG/jHRhVIqHWgkExv2vWqkzSNyBaa4QYc3DfvW1pay/Zj1oMKPmYvwN3WeMa7rMUwANQbZARsKi0yI8YB6HgqeqpuBNOO/JCgUAV3Af1pJp5BvKkSGHiASt7hiWxvFAjv2IQbon6m+SFRk63OWHCK9YP5qV7Lr3CFk8xKsdAyB000xfio/gLdOutBdRQVT6Y4CBMH+da6i9G1IrLVvyLiSgeafq6gwM8uaVkvFCBO+XqL0j2PcTEVNKkyUfTiIfn/6hi3XU/VnhAhxCsHsvR/yB8ssaB+lvGLV1PJZ59pSuljUdBj3HLUBsv/nHlyefPn7THWgLZhMpaLgzBo6KjYS1GNGiaRzdFLnWg70pGFaxUaa2l6uwj4TYDYxiOaufpF0yohNFRlkU4IZ+7LHoo70O5SwkQN4NJGkosmpaIItM65YgZy/Xx27bPZ9eNmYxyvAOitAT67bsFbFYEvj9vYR0zsBTOpToORBXl9sc6nbgvn/DkhStW5GmD2cYJQSlc8wg9ySHgkCQToKZnAaCq43GE9yJZoK4o+yAxGKKxqumSO2lwb1Ypqx6SDpzS94luaQ5MQTEnfHvmYEVZ5JGMbHqg7BXK9roR4sOADQ1Oy7qIvuRQEat3uMEgYhKijWAMf7w7q5pF0blZ6fz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(6486002)(508600001)(6666004)(86362001)(6512007)(186003)(53546011)(31696002)(6506007)(8936002)(31686004)(66476007)(5660300002)(4326008)(66946007)(66556008)(8676002)(36756003)(2906002)(110136005)(38100700002)(316002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXgrYjlmMjJWbFFpcWJyYTMvcVAveUV0a0pLN2hpY1hFWXFydzNTMFlaSklW?=
 =?utf-8?B?SDNwTUtkbzMxMXlDdnNmODRVZ3F4MlV0T3dsZVdWQ2ZQS0RvYnVCZGhNZGVJ?=
 =?utf-8?B?TDJYaHlkVjlhSHR1b0M0UkNsVFJna1EzNTBSazJHaVhLVFo2ZHE5MFdxWWlu?=
 =?utf-8?B?ZFYzUlJRdWs2UnlVYU51c01qbkllRGF6bHpnSXhUWFFrYnJyV2ZUZHZlRmJr?=
 =?utf-8?B?cnVESjR3YWtsTjN0VTNoR3QvNERYN0Uxb0RPNFIvY2VUUXY5emlyVHhjRWJC?=
 =?utf-8?B?WFQ1ek1GM1ljSHZuS1dQVjVKQ29ZNkw4LzVDMTVoZlduUitpK1lSQmk3UzlD?=
 =?utf-8?B?UVczeHdJSDRIZmRZL3JOYUVnSTE2WDhyVWhkSy9oU1VCbkNqVDVwaWw4Q2Ur?=
 =?utf-8?B?L3NxY1pqWFh1c01xM2pKb1FwUGZEcHAyUm1VTEZEU2R4TjE1Rkp4TjNZZTc5?=
 =?utf-8?B?d3ZMWW9mVjQwSjNzVCs5R3RTOHNUVHJySkEycWhpSGlBOGRMVDQvU2xITXha?=
 =?utf-8?B?N1VJa2pPSFhYNkRWd1ZxOTBTak5yRityRzh4cjFQbHY1WmEwVmxIVTFrK09y?=
 =?utf-8?B?SUJ6azFHK0VySmthdm11Q2xiWUdNMGlGa1hSdWhSbFRyZHZWdXdzNTNXSDN1?=
 =?utf-8?B?cEFyazJ0Rm1WR1FQaTY0REJ5R0sxSUI2elpvRjZYMzhKUkoyOCtTRXlVSHdh?=
 =?utf-8?B?ZitOK3pZTXhSRGI4QW1KM1g4YndDblNzR0FQdEU3SWJWZ3gzdkhMck10aU04?=
 =?utf-8?B?MWZZeE14VzlmVHF2R3pIVHl2TmcwUmFJTXp6cTg3bldHZnNDWVRyY3NkcW1z?=
 =?utf-8?B?NFhEdVhSS3ZBeVpsMHdnd3JEUXhRTzRoR1NuTW9xY2JxdklKY2s4eHZmUTht?=
 =?utf-8?B?eHpLZm9sUGRQNVBqcWJFbWpkNnd6TXp4WTVOUERjZ1Q2TU1jeWliNXpqSVJr?=
 =?utf-8?B?M1lVeVlBUnZ5dkF1K0R1N0kwWGpSNGhKRnAvODltNVlvQ29PQ2pjTWFIbTl4?=
 =?utf-8?B?MUhmQUQ3QzFKUFFtclNUOG5zeXArbkJsSmZSUkZGa2hhTVIrT2RnY0hzUEZV?=
 =?utf-8?B?Q0h3eXYwMjlYVE9TRmdPcFBESXYzNHN2bkhSUjEybmx2ZlJTaE0wQ3RiZ2I2?=
 =?utf-8?B?dWZYN2x1WnFsZFFRUGVveXVCdm1CbWFWOGhkeEdTMFRuUVE2NGZUTHU2TE5x?=
 =?utf-8?B?Zjd2dzNIU0h2ZWJNTGw0bnZsN3RJR0J0OStxejZmWEN6eWFlNUNDYlJISmY1?=
 =?utf-8?B?bzFlSVc0OHgvUS9zOUFhU3Y1TldoQWZsU2VJTm9MVHhZdy9HcnFoQ29DcFpv?=
 =?utf-8?B?UGpUY05OSzVWWnhKTDFiRFFsSitCeDNzTVpCU3lGNHZscjdDWjhCOEhzNmZu?=
 =?utf-8?B?bHZKTWJRVWV0V0dMODFROXNwZ1VCdWFKUFo0bUl4S0YvUVNibitWVnZwRTBF?=
 =?utf-8?B?QWhGRFdCbXRwVkhnZk41Qk5adHFNS1dMRVNab2JvNHlJVUtsVFRicnBEMkF0?=
 =?utf-8?B?MUVpcmNDUFp6Mm1NbExaN3BFNFZsTTFpZ1ZQdjJFT1k1Yy9UWE5WbENkZ1Rn?=
 =?utf-8?B?TzFqZWQ1OVRTSkRjTFkzYUg3dXg4NWo3b2EwbVVrUWlTeFBndVdDaUdkVTVq?=
 =?utf-8?B?MndlelRLdVcvODRmNS9VVWllMXpHY0k5dm1DOHA2ajhCQUlaajR3aFNWWG5V?=
 =?utf-8?B?TWpmaXpsREhJbXBYM0lnbVVoMnVXT0J1SGY4YUZIQ29BcitVTVVsdDRndllJ?=
 =?utf-8?B?QVhQdkgwTmx0Unc5dnRKakpZUXhuUGZocHhncDY5cTlrdVlZa0ZwV1FkYWZ0?=
 =?utf-8?B?bXAwQ1FKVGZEQ0ppbW5rcjV1dE1JOGFSazdWdmlxN2RiVFNUQnl0dWJMUnRM?=
 =?utf-8?B?TDI2QTRVUmhxdGw4RjdMWEpxejQ3SGNadzdIUVJmSXZjQVl6NCtCbjR5Yytx?=
 =?utf-8?B?U0p4ZUliMnovcEltcmJ4ZHM3SzRxQkM1ZDRja0ZwU0I3UFlDWHZ0ZWN0Q3NH?=
 =?utf-8?B?Vng0dEMxU3h5a3dzcGNhYjlyWmEvLzBGUndkL0xsa1JtV3RrRkFLVDJyWW5Y?=
 =?utf-8?B?RERFUEYwSGQyM09HN1d2R0toMTR3TDAxbktLUm1SVG1mWDFleWVnR2FVWmdF?=
 =?utf-8?B?RWZBenBXMENFb29nS1hUd05LNEhTNlRtUVh1bno4cHVzOGk4dC9kN2huNE5Q?=
 =?utf-8?Q?wyd5xKrtGw9gusz15HDwV/E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdaf589-448f-494d-0a3a-08da00e6f7f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:35:23.0599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c8rZIFmLqdp/ouuNrtnmitcFRYlYcyJp2NbOfqqoCnS/pQEp7usUnmhGCydKeKoxN59KRpGuPK75HGFgqGjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/8/2022 8:15 AM, Christian König wrote:
> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>> From: Shashank Sharma <shashank.sharma@amd.com>
>>
>> This patch adds a work function, which will get scheduled
>> in event of a GPU reset, and will send a uevent to user with
>> some reset context infomration, like a PID and some flags.
>>
>> The userspace can do some recovery and post-processing work
>> based on this event.
>>
>> V2:
>> - Changed the name of the work to gpu_reset_event_work
>>    (Christian)
>> - Added a structure to accommodate some additional information
>>    (like a PID and some flags)
>>
>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d8b854fcbffa..7df219fe363f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -813,6 +813,11 @@ struct amd_powerplay {
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>> +struct amdgpu_reset_event_ctx {
>> +    uint64_t pid;
>> +    uint32_t flags;
>> +};
>> +
> 
> Please don't put any new structures into amdgpu.h. If I'm not completely 
> mistaken Andrey has created a new header for all the reset related stuff. >
> I would also reconsider the name, at least drop the _ctx suffix.
> 

(Same as comment from other patch) should we move this structure in drm 
level (drm_sysfs.h) like

drm_reset_event {
	u32 pid;
	u32 flags;
	char pname[64];
};

- Shashank

> Regards,
> Christian.
> 
>>   struct amdgpu_device {
>>       struct device            *dev;
>>       struct pci_dev            *pdev;
>> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>>       int asic_reset_res;
>>       struct work_struct        xgmi_reset_work;
>> +    struct work_struct        gpu_reset_event_work;
>>       struct list_head        reset_list;
>>       long                gfx_timeout;
>> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>>       pci_channel_state_t        pci_channel_state;
>>       struct amdgpu_reset_control     *reset_cntl;
>> +    struct amdgpu_reset_event_ctx   reset_event_ctx;
>>       uint32_t                        
>> ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>>       bool                ram_is_direct_mapped;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ed077de426d9..c43d099da06d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -73,6 +73,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <drm/drm_drv.h>
>> +#include <drm/drm_sysfs.h>
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct 
>> amdgpu_device *adev)
>>       return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>   }
>> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
>> +{
>> +    struct amdgpu_device *adev = container_of(__work, struct 
>> amdgpu_device,
>> +                          gpu_reset_event_work);
>> +    struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
>> +
>> +    /*
>> +     * A GPU reset has happened, indicate the userspace and pass the
>> +     * following information:
>> +     *    - pid of the process involved,
>> +     *    - if the VRAM is valid or not,
>> +     *    - indicate that userspace may want to collect the ftrace event
>> +     * data from the trace event.
>> +     */
>> +    drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, 
>> event_ctx->flags);
>> +}
>> +
>>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>   {
>>       struct amdgpu_device *adev =
>> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>                 amdgpu_device_delay_enable_gfx_off);
>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>> +    INIT_WORK(&adev->gpu_reset_event_work, 
>> amdgpu_device_reset_event_func);
>>       adev->gfx.gfx_off_req_count = 1;
>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> 
