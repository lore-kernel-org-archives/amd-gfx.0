Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B527C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8484110E162;
	Thu, 23 Nov 2023 20:01:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05D910E162
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3uM7X6kpkTprG1i5dqVUF7y4ags9LfRfqSx8wYgCmwpGk7FbC/DbvoxEZC3uMeYX6SKVNxrsadAK5Fml1RBFW8kWNPv9IVHtl+icH5+KoXRnQEMMw/AoRKCbuxkiCpJN6Usg2vrXeS+9s11AA7Sq4jDWgY1+jW6zZkM59+UKu2fDzoalCuRyO78lIZR8vc0dW2V0EJY08Hv85VFoH4nxyZ7tuxEOtsIEa1TiToZJ4AVshJKa/1w5gUUUZKS9LWhCS05DWKH2DXtlcWItAqdYcbujdaKNpakrs3x16rb6dVhEpr7S0gBwUdGhWeP9KGPLmfyqs8Fu+pYDOa/6e4G/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AZcqEtnH6RnxCfHFiBT/dGZ9dUd/OCGvPV3eSYreZA=;
 b=I2m50Bo/0HqVQ+egMdbWVZKNxQHWlTPefo2wgRMbjeMTR7Tjnt7tmAOIkbVXpAa6iEBJWcegcDNVJn63BTvkPVYkJ/g7JFoIxMy9Na2wz7xymsbsKHbtLughIGG8fLAv3HGhQU9iGzAfdsyp4tfYs3bzpPCMQp7IPyW63483KdLnazqIi2JpwxaGYKzMN12ihjylEDVymkU+cnsTlW7CjAl6Ma85OJSbA81dlL79ZBXFISf1+NTH5Rzm7LjSxgFbsQnf/yF2auQH1ODBc4BpbBkcWxrvxdTc6tmaaUCr/BJHbOMy67+JFiLCfy4NFN4lMt7LN6Z7eZa6MXX62XW4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AZcqEtnH6RnxCfHFiBT/dGZ9dUd/OCGvPV3eSYreZA=;
 b=2Aob1KSlfuvP4fWLx7PzBHpDespAj/ucwj0q992elqaoppuPuBl0QLLcNObDeiRRKFIE9sbnwrtL8qUyZB+2oTQDbHFAXuZUQb5gQY4OuWyczJaVwPvXjQqrh/w/wVRy+YL1PtvaDtd1px2zjrcg3lvPlzOBLGLD6ZBgoCTINsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 20:01:48 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 20:01:48 +0000
Message-ID: <958e5512-ac80-4cf8-b994-b0bf44f25ce7@amd.com>
Date: Thu, 23 Nov 2023 15:01:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] drm/amdkfd: enable pc sampling start
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-19-James.Zhu@amd.com>
 <eed89842-a946-4574-bafd-dd39bd471d79@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <eed89842-a946-4574-bafd-dd39bd471d79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 764f0503-bb8e-4959-82e0-08dbec5f06c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJsG1m6FITlDlcXESvskWVuCI2tY5YPlqbCOMZ0+M0wfPwERnirj1VTi0X8e41KKfIEUM6/b/8Vv5kczDwjOhuXDVVTUlPIRN21WBMtHO7sax0vR+3+4NQEhD3Lf3bC3x0KZdn0fXFbBnVSSd1cZTvmQGB3wPUacrWTDHnq4iuXnlCwJrHtdbo+WGVnNMfqYcnuPqktReA9njUnjQo3NhPHE/BjwOxcF9BnbdtFXllHXccunvzplripdDcY/Tbrqqz8dJtP9f828QpMSWTkw5rJYm6W+vvhli6z+jlfD//SmRI37Ci//0XhVUXUZE5ALg6iQbiEHJZdbd58k4ph5k71UPCQNb5HPKTfzuO8tnufqZqDOQM+lZx1t3YMvyEOfQXUJX7QBCQsL1q0I5Yqme7Lf8A/YfQs7EqxaTwRU6YAm8srj+0jHlSGnY0N+Oms2Qg3BQpXbIJz4TSFnF8Wmimk6hjrEEdCNBgZdKU2zjHQ1LdTxSMUjUPWfYIbFB7Mhz2N/FSFXhkWfAOAGitl2/B/ndx1IOv4HbV+IfwtZH8JFl+BehhXqab/TtCYcLd/UvAioO7tP640EanDJRKGLFAqzWa0s/RsBHzXM4Ubivn8DrY4mi7VzpvoxGXIm483qrjLlv0bMUoVhtAYUMBS7gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4001150100001)(31686004)(5660300002)(8936002)(4326008)(8676002)(2906002)(41300700001)(66556008)(316002)(66946007)(66476007)(110136005)(478600001)(2616005)(26005)(6486002)(6512007)(6506007)(6666004)(36756003)(36916002)(38100700002)(83380400001)(31696002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0FlL1ZjbkRFMDdpc3Z1L0RVRlRRQ3BIZW5ySHNUcUtVMWk4N0dGeDc2SDVN?=
 =?utf-8?B?dytZRDNyKzlwQVYzYWpaM2RsTlBUemNzeVZRZGlyWkhiTjFCeHZEOE9HRXpm?=
 =?utf-8?B?Y21lVGhFQkpQQkFXaEtvRFJLeXcrRk56L3QrUHlYb1V2QXEzNmtsRWMxS1BI?=
 =?utf-8?B?bE1BZG4zWGJZd0U4SG1EV29uMEo5YmxhRlRucmV0bkpKeG9tN2RzMEhiUVNN?=
 =?utf-8?B?dytHMk54OTd2bHh4a2ViYVJoSXp2N29RSGMvalBmVTBOUlR5RW5lK3Bkd1ZX?=
 =?utf-8?B?SGE1M0Q4SHZqSzUvb2N3blh6UklOckFDZ29HTW1icFd0ekFhQWg2MU5tbkVE?=
 =?utf-8?B?TFpmSVl6QS9RZC9NWTFQTXVKNXZiMXJrVnZEOS9NcGlCaGduV0c1NThNdHdF?=
 =?utf-8?B?NE1yTUMxV3E2bVMzYllXUGxZWXBvOHRjbVdRK0thV3YzbHJ6WnJxZTV4RHo0?=
 =?utf-8?B?aFNYSFJrZnpjZkU4blNZN2I5ZnRIZmJvNmV4TU9NT0RWZk5wSEZxOUNtUzk0?=
 =?utf-8?B?L3ZjbHdJTnpFUmNkek5KU2RpV3Z1alBac1RIejJVTnBGcWxjZmZmYTFmaFE2?=
 =?utf-8?B?c1owdnQveDR2YklVTWMzN0hTQjd6bmxMOEFNR2FvdnFESzN1NnBnVFdZSW50?=
 =?utf-8?B?bHlCc1FJQnh1dkJ5WHE0bnhEZ1hqNSs0akxVVkdxNTVWZW1SR3UzM2dTSVFS?=
 =?utf-8?B?VWJSeHB4QkFVOXlnYTVuSkpCZCtNUVB6RHp2VjJnY09OWEZGYTBtNGhuNTUy?=
 =?utf-8?B?OHRBWlZJMFA1a0RZK2dQZ3F6T2I1ZmNwSG51Qmk4VDlmUkQ0MFFzR214WFd1?=
 =?utf-8?B?NVp2NWxxejFiMVE5KytHeEFYQlp6dmdpV044a3FDdnJkb25jRGhaTndsWFM3?=
 =?utf-8?B?c1NWdVdzS2tWK01WczFORFlvTElzSk52MURwenFQdmllSGs1Zm9DQWw1NVlX?=
 =?utf-8?B?MVl6akFwaVhpcXVtcm1TaFJINENSWm9Zd01LdG0ybnM2VnN3Y2FlSVNnVUJm?=
 =?utf-8?B?YVlDRHhsTDlUTit6emo2ZGc5L0lkdWdOcHNXaE1IZTIrQ3FBQWNKd1RuNmhM?=
 =?utf-8?B?M1d2UklEUTRsa3dxMFlQenlCdXl5eEJyWGxUVVc1dmllck4vZ2hZQStIMnpl?=
 =?utf-8?B?STNqaUJocGl0T2RSTTNsUUc5T0NaTytFTUgyc3FLTzd5QU16VlpwcXJvM1Bq?=
 =?utf-8?B?MkovelNjUStyc1BXUThldkh1VGRiNEZWeUtPMzNUdmlyQmFYL2E5ZjFVUTlT?=
 =?utf-8?B?cE9WQUU1TTh5TEZZc0dCUFhrRGNKcm5FSE5UZUkvOHhYaUdSR00yTFphN2tq?=
 =?utf-8?B?ekJsbHpXTmp2Rk9sVHhpSkR0RGZVOTk5RSt1OElpR090a3lUSXE5UWszZ2c4?=
 =?utf-8?B?dW5oWXE3N3VTbnRPMTMxVzY2alNPWUF2cytDZzVDb1ZDSnZpeU5JKzNNc08r?=
 =?utf-8?B?bVhUenBUb0MxTjVMQzFDTEhHdEQ0aSs4d3Y3VkJiRCt4eXEwUURhczdYYzNJ?=
 =?utf-8?B?ZjQ2ZDQ4R2U5TE4vZHR3YlBMYXBBcElnTDVyRmNCTXd5cGtQd2dtTDg0bHp5?=
 =?utf-8?B?ZEZXeGN2NVBPTEFXQVFKamJpUXBVb1ovZzFOMjkxZGtvOHRzZk01Nlc1NERT?=
 =?utf-8?B?djBYbGdEdWF1a0tRc1BjYlgvWHptVE5xNDE5cjhZR1FuclVSTGxLR0g1b3Rn?=
 =?utf-8?B?K21leTN0VTZGdnVSQ1pmVTdTWjA1cDRpQmxLUnRQd2pKdUFNNzA0NFZHcW1O?=
 =?utf-8?B?QThINlVLOFRIZjBOVE9XR0lVeFdyL3VRbzRNMjAyVllZeEZDU2VjaytWWUxC?=
 =?utf-8?B?YXV1ZEVmelNySmhmNWJCb2xud2tZMm8xTGlrK3NlUDlZU3dhcTByY0JBUk5L?=
 =?utf-8?B?RzhmZUVmcXNDRUtHVHlGM2pwNDM3NHFLYyttNEgrTTgzWTlhcWdJUzgwWk10?=
 =?utf-8?B?WmRIQVJHd3UzcWE0cERIME9uUGZXa1FCZU04M2t1bXRMUXA0ZXVEVk1wekQ2?=
 =?utf-8?B?NGxMeExNQ0FrbE9KTE1FeE54bWFoazhPd3F3TFZ4SHl0MS8xKy91aGtlTHNu?=
 =?utf-8?B?MEFGaFl5QmJrQnl2bTRkZXVWWlpBOVJVR055UnR6RlBjWlhMVzZUcEtId2x3?=
 =?utf-8?Q?c4C7twAhWefL3LCbi5VBcmrXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764f0503-bb8e-4959-82e0-08dbec5f06c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:01:48.6750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7awhBTir5/cks7pY2sUGzmBBTuHoZrNJG8LJfSkiDAOGCdHZoDnLzIhyuA6wBLmy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-22 17:27, Felix Kuehling wrote:
>
> On 2023-11-03 09:11, James Zhu wrote:
>> Enable pc sampling start.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 +++++++++++++++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>>   2 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index 60b29b245db5..33d003ca0093 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -83,9 +83,29 @@ static int kfd_pc_sample_query_cap(struct 
>> kfd_process_device *pdd,
>>       return 0;
>>   }
>>   -static int kfd_pc_sample_start(struct kfd_process_device *pdd)
>> +static int kfd_pc_sample_start(struct kfd_process_device *pdd,
>> +                    struct pc_sampling_entry *pcs_entry)
>>   {
>> -    return -EINVAL;
>> +    bool pc_sampling_start = false;
>> +
>> +    pcs_entry->enabled = true;
>> +    mutex_lock(&pdd->dev->pcs_data.mutex);
>> +    if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
>> +        pc_sampling_start = true;
>> + pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
>> +    mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +
>> +    while (pc_sampling_start) {
>> +        if 
>> (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
>> +            usleep_range(1000, 2000);
>
> I don't understand why you need this synchronization through 
> stop_enable. Why can't you do both the start and stop while holding 
> the mutex? It's just setting a flag in the TMA, so it's not a 
> time-consuming operation, and I don't see any potential for deadlocks.
[JZ] for stop, not just set TMA. need wait for current pc sampling 
completely stop and reset some initial setting.
>
> Regards,
>   Felix
>
>
>> +        } else {
>> + kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>> + pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
>> +            break;
>> +        }
>> +    }
>> +
>> +    return 0;
>>   }
>>     static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
>> @@ -225,7 +245,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>>           if (pcs_entry->enabled)
>>               return -EALREADY;
>>           else
>> -            return kfd_pc_sample_start(pdd);
>> +            return kfd_pc_sample_start(pdd, pcs_entry);
>>         case KFD_IOCTL_PCS_OP_STOP:
>>           if (!pcs_entry->enabled)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 6670534f47b8..613910e0d440 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -258,6 +258,8 @@ struct kfd_dev;
>>     struct kfd_dev_pc_sampling_data {
>>       uint32_t use_count;         /* Num of PC sampling sessions */
>> +    uint32_t active_count;      /* Num of active sessions */
>> +    bool stop_enable;           /* pc sampling stop in process */
>>       struct idr pc_sampling_idr;
>>       struct kfd_pc_sample_info pc_sample_info;
>>   };
