Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F27BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 15:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF5910E537;
	Wed, 16 Feb 2022 15:40:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0522D10E639
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 15:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM8SNDDMdAnxPi+Ln1VrcQh9wV93iXg3+pVAy3CdbbhUaH1hufZ4v/8rhvPa4BJSN4l6TGsybVzdEzZJVHZXOgfBqt8rdNdQ7QmSz1Rsg5v5qfJV8gEenDBwEZoEG1BNp8L3YZSp2F95DGj2fOwOR9Y6A/a46A43Kmb1ktiAwuxYOhUczh4/RRBk0UQmDaRTHTG3K98aodGHZqTmB2opVyPsl7E+Xg6Vs4LglJzTuw1/AuCesmHoBHsL4DQ6QkWSlcxMIysUUmOid6PheV6Qb7fl0wykMPvJRMv+A/7QZsLS7cwRrhIYN1DNM9ft4fuUMCQGiCSl175+ZWSjd3eXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FVKpbQdxT6Gx1jCcxYffebHeSWXfjTkyFnao59A3S8=;
 b=nWYqV1ENsnAn6lCoEqY+3m5agdA56n51bwStxUH5aaqMwGjlfb5K+hMbvYmf6nWX+HbR+H+gda4KA2uq8E/FRGQNcDxHhSpVa+LKwNrWd2fr22VND8fM8Gb48pMw7V7qIWfCd+MgVhdPCTpX3uW/6IIaGIYydgLDTSDbTgvtYoa74QDLB0LEeNwz6FoEGQDke9TgVyeZ8fpTHHM3R1BcKce65zPbsenS5Q3X+aSqlaDUuYx+lHkYQwscCQ0tdaYRK1gOFg1vLVSPwBKlURBOm0KabS5SAheZgoOb5jQteL0SYZidr7wXah1A1eJAt1liyxS8yxddNy3bOFMt7riPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FVKpbQdxT6Gx1jCcxYffebHeSWXfjTkyFnao59A3S8=;
 b=wVX1BzMmzWu2Jj4r/2BF5DNyyrfUvq2+XlqY+MuD17Fry3XrheAPaLGG78FdKQ75y+U/86DUTRQCnoMUcSqHt/5aQ5yznJ3vRIMCg57P7J79VNI2a+tDiE9M78Q3O8EENM4GIuUrCFNtm3+905BWGlrkoR1aungianxNQWkhV44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 15:40:31 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 15:40:31 +0000
Message-ID: <0cddf8b7-39b1-ae3c-6b3e-c5946d4f96cc@amd.com>
Date: Wed, 16 Feb 2022 10:40:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] drm/amdgpu: add reset register dump trace on GPU
 reset
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
 <20220215101228.9433-2-Amaranath.Somalapuram@amd.com>
 <912e3da0-d244-fba9-2991-acc4ea8e9943@amd.com>
 <bd8ad3f6-ce54-6498-5b79-74e4a5457492@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <bd8ad3f6-ce54-6498-5b79-74e4a5457492@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:610:20::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a589f8-c8ec-419c-a37a-08d9f162a9db
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB527300E9D51D384B594242ABEA359@BN9PR12MB5273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMK8WVipBFBINALnREmFyPfVIwJv0CwwOjVYPWbxZFBGYVF8vfs2AyoULSpCvjXOB+w6dIb5nKI/epG8GQ0vHdgVdmBzaL/8wl1fOFNXvpBvctIbiJgFUT6A/t/3woVPB62UJA365J4dUpi8qzrwB2+U6p8VfmQS/KAmZitbGqZte6IVNey0Eml/JmzjpzDV+dLkhZzp0lZqZS4drTXyHaEoS0o5vAjUb0E1Klen0lCmZB+hvqOHCtr1sGcaxGm0ZEfOGjv4xg4Rrf7Q6WaLvrqzLXYvpB7BBxI5XyTFUplR3XTewg3Ecqs8youDJ8JxNnfut16rfVR2eQcxZVVQ+XR/qZzUIFeiKx1T7otpAGTOCfhxg3JgUs8qRVuxhZO3GJtNdpibwZw6S/Lzo5YNJxVxlqETXQoD8IyEPkjxQYuUNA2Yrq0TolV3EPuaTkImR8FW5NDI3YTaYrJrdpA+RUE1Kax9t1lUq7ctmDN0+tzu0FPAsxHm4ll78q+CMBzoFsh9LxLLhODQmHL/BeE1Gu48xnABlmYJAKqFvXkpMZn6ZAOrLMtXBniN1m4dMFY39e3Fri6wylnmnefDqnIBTa4kpSj5J8+aYC87+KiKNzgg6vLXkARl6y/rLrC5BvwMtfrWiQc57BssxlQf8bZVSzpBTvVI9c9yPFMH+OS9y2/KcgYOILmrqkCi3vNFtfa+Taoi1xAPECki3DTG3UvEASZ1V38YvZ9GbbfzvNoGZA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(186003)(2616005)(83380400001)(36756003)(316002)(66946007)(6506007)(6486002)(110136005)(31696002)(44832011)(66556008)(2906002)(508600001)(53546011)(6512007)(66476007)(8676002)(4326008)(5660300002)(31686004)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czF0bUNyNmtnSnJvTjA2L0N3U2xkK2VhRktGYTVDQXJQYi82THJhV3ZXUHFp?=
 =?utf-8?B?WFNpRThiRDl0WnM0MHhGb1lhV0lFSU9MQld0cjFNUGVXQmxQK2hrMk1aeWFs?=
 =?utf-8?B?djd3SnJGd1pic3o1QWRwSXdLdTN4TkFFcXFqeks1bDI5dHF6cjRRY3FUWnln?=
 =?utf-8?B?QjNvVDFVUHVxNHlxZXdVeHNsODVnTk5ZUGdoVjErZVdzTHR2NisrbG42eUF0?=
 =?utf-8?B?UVYxVUo1by90ZHBCKy9XT2tzZnEvQ1AvL3BzWlJQS1h2Sm9vZmEwZXBGQy8y?=
 =?utf-8?B?bWMwWlhJS2llQTVJTkhDZ3FHc1hBcnFJbFJtYmdaTlV4TnNib2NCUmJBVFQz?=
 =?utf-8?B?dVJZSDRPTWZodGZ2RTNLd21FeTRnTDEyOWtESHRMcmorYzNTVVBXRlhnanlL?=
 =?utf-8?B?eDZyN0pVREFtTWV6YUlLZENUWmttajdRSDBOelJ1bUVCSjRWQVZHby8zQXJL?=
 =?utf-8?B?Qk1TTXNwb1VIbm5XN3Q0WnVTejN5MEFBcmJ0SXN3N0U2RnVkcWVtQTBHdzhF?=
 =?utf-8?B?WDU5N3hyV1lpdE1ycFpKbzVJUVMzUldnM1VFTjVMbHJJZVVlblVNRUJXMEkw?=
 =?utf-8?B?NjRKaVF2STdqclVpb3R0TndYWGxJZmYyRC81TnVGczdyOHJwdGdldkc2YmNF?=
 =?utf-8?B?V0NOK0xMQXQ3MkN2V3RSa2JTcVFhZlVLQWJsMDVBUmlHUisvcTB4a08wZ3k1?=
 =?utf-8?B?d2JZc0pjNFBFZG1obDNnR3dkY3JaNUY2amQ2QjVQVEdGZDlja0VWV1Z1ZzB2?=
 =?utf-8?B?SS9JZVFXMERtaHJVRUc4SllwRmJPam00SEFuc25kVlNtNkNFTWhMS01FUU02?=
 =?utf-8?B?M0JSRE1LRTk2blkrWHl0L0FFWmZ6Myt6TnFJYUdOenFYV1F6QTJORnMzRklj?=
 =?utf-8?B?R1lVTzViRnNMUlV2VlpTcS9BRmZ2c3hpMCsxUDJZcGkzeTcwRXJJeWszdjQx?=
 =?utf-8?B?enBBT3U0cEFYczR3U1pXUjZKMHdTNDF3UlA0c01NRWw0clNLaUtuV0lyemU5?=
 =?utf-8?B?RUtMVmw5UndvaUE4YlFKRitZTkl5SGpCR0JDOHFUNnFVc05lY3RPOUVvRXNP?=
 =?utf-8?B?eUNnZ0JqVS9sYWRoano1VEgyNjgwWVJYWkZ6N0tmZTl3MzhtbjR4bWtYK0Ux?=
 =?utf-8?B?NXVzVkMvcHNHZ2tHRDR1Y3pSeDlCWXNJNEN3NlpLb2hHMW4xbGNVN2pORmsv?=
 =?utf-8?B?dWw1Qldvcldkd2huVGpmWjlKekczZEg4UmxuT09DSWNVcE53ZC84d25aVVdC?=
 =?utf-8?B?a0t6WUxrVlRvWTkzMzlRNDhLQVZVdlorZTFWZGRhTFIyenN3ZkI2Sk5xbkE4?=
 =?utf-8?B?THRwVzh2ZDlqMWx1Ky8yL0VuQ2FHSUlDZVJtSGNac0JPcFIvM0dkWWo0YktT?=
 =?utf-8?B?Z0tMbzRoME5zNm9jVDRjR0xvN2xuR0Q4a3MwdUQ5cTRKb2ZldG0rYWhqSTRm?=
 =?utf-8?B?WUZNTWJnMDJVdWJ4OWNUTmRVemtEbjRUU0JMZllkbll0OXZTdkhpdmhGdjE2?=
 =?utf-8?B?ZnJvbjhSYlhIZE11NC9WZ2NQM2RSL3VtcmRJdU94UFNyWTM4ZGJxWHduNjU4?=
 =?utf-8?B?WSt1eEJxQjh2THIrOU1yMTJtOWdYQ1JWbzhGWE1vOUtxUENvTGdpeUkxTEJ5?=
 =?utf-8?B?SlR2S3g4S3locHBvSFAwMkkvUWdlU3d0VS9CQkd2U3JUYmFEN05pekRZaFd1?=
 =?utf-8?B?VzJMa0kwWHJFbnpwMzBOTmRrL3lZYk1yc0Q2Ukllc0QvYkJQMDRwL25aRWJ3?=
 =?utf-8?B?RzNQRVUyU29ZbVpTVm9kVllLTDRkWjlBWm1wVWs5Y1h4dTZCa3VrbnVwZVNU?=
 =?utf-8?B?akRNYW1wOWR3TlFNRDRTT3ZJMXhTN2Y1WGpMZHBRM3QyV2U0MTcrUVlucFY2?=
 =?utf-8?B?VU1kVlprUTdoVFRaV3RZMjVyeFpzMXN3anplUTd2M0Z0N3dCVFh5Sjh1RmZa?=
 =?utf-8?B?ZnoraTNLTjZIN24vdGFBR0VTU0JRNmxUT2ZDWCs2Z0s4MG9jZ3V5L1V3dVRE?=
 =?utf-8?B?bEhnYXJtZ0k5UWMydXZyWlg5RjBjUmROOFdkaDl4TGtWSm5ESkQvd2RFMmdM?=
 =?utf-8?B?Vm5DK0E4SE43SDBEU0NIVU5QM3JpbWZuRGlEOFpacWJmRi9hRHBsQTErbExN?=
 =?utf-8?B?alBBWTFqQTliS0pIN3RBZEM0ZzZRVGRSK0FSTjN6SXpyOVQwcHZudWxsaGFK?=
 =?utf-8?B?MVhtU1gwRTdvOUhSR2UrWXl3VWRaTWMxWXluZ1dGR2RSbTFRS3VpMVd4VkRN?=
 =?utf-8?Q?WgnE00243vwlfCCQ/3q4Tg6CWvzbmXi00goet8syE8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a589f8-c8ec-419c-a37a-08d9f162a9db
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:40:31.0343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/W98oq3gww+oPoDtrnhnlYzACsNLVVowR1GpsLpYa8Xotfmiu+01NGyuVO45NAtmMa7/o9jbqQtcP5YRnciVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-02-16 05:46, Somalapuram, Amaranath wrote:
>
> On 2/15/2022 10:09 PM, Andrey Grodzovsky wrote:
>>
>> On 2022-02-15 05:12, Somalapuram Amaranath wrote:
>>> Dump the list of register values to trace event on GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
>>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1e651b959141..ff21262c6fea 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct 
>>> amdgpu_device *adev,
>>>       return r;
>>>   }
>>>   +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>> +{
>>> +    uint32_t reg_value;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < adev->n_regs; i++) {
>>> +        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], 
>>> reg_value);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>                struct amdgpu_reset_context *reset_context)
>>>   {
>>> @@ -4567,8 +4580,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>> *device_list_handle,
>>>                   tmp_adev->gmc.xgmi.pending_reset = false;
>>>                   if (!queue_work(system_unbound_wq, 
>>> &tmp_adev->xgmi_reset_work))
>>>                       r = -EALREADY;
>>> -            } else
>>> +            } else {
>>> +                amdgpu_reset_reg_dumps(tmp_adev);
>>>                   r = amdgpu_asic_reset(tmp_adev);
>>> +            }
>>
>>
>> Is there any particular reason you only dump registers in single ASIC 
>> case and not for XGMI ?
>>
>> Andrey
>>
> Not really, should I move it to the top of function?
>
> Regards,
>
> S.Amarnath


Yes, no reason to avoid dumping this info for XGMI case.

Consider also that maybe you don't want to print this when
the reset is not due to any error state - like manual GPU reset
from debugfs - but to know this you will have to wire a flag from
high above in the call stack to here and so probably this not worth
all this changes.

Andrey


>
>>
>>>                 if (r) {
>>>                   dev_err(tmp_adev->dev, "ASIC reset failed with 
>>> error, %d for drm dev, %s",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index d855cb53c7e0..b9637925e85c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>                 __entry->seqno)
>>>   );
>>>   +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>> +        TP_PROTO(uint32_t address, uint32_t value),
>>> +        TP_ARGS(address, value),
>>> +        TP_STRUCT__entry(
>>> +                 __field(uint32_t, address)
>>> +                 __field(uint32_t, value)
>>> +                 ),
>>> +        TP_fast_assign(
>>> +               __entry->address = address;
>>> +               __entry->value = value;
>>> +               ),
>>> +        TP_printk("amdgpu register dump 0x%x: 0x%x",
>>> +              __entry->address,
>>> +              __entry->value)
>>> +);
>>> +
>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>   #endif
