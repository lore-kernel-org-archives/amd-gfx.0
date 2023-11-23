Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1528FC61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 18:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9848310E329;
	Thu, 23 Nov 2023 18:27:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D129A10E329
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 18:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyj0y2Xk4UXnuPIaAKOURdkVQm56OydTgJd4qsg9mDTDRloaVRdBGOixmVvv9noSIUwXIDpndFKmBvOcAaWp5Z7Ssp2mO0bYBK9THZQ7Ch56SPX2q7ZlrNVF/0cVBMjhAWBCM01wLrgZsxMg1z+cIi4XTkgv57Xu//WL3Gtcl8KgvBgIOAPSJaC3UV+8LX7VPoFpzrK37HIlybqgd6MxWcE3ZLwBkhOiSljOAi/9bqLpJ4ZCSVpDzaBnNCtsGyvc7QTKsWTRCJlC2s7kEf/0VlsS6SXCYkhWr7MnohJKCxkMCaLwlSP892NMWDjIpvnQFIiVyyxTlnGwx0l9VqBuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvwLX3HNOf1WEzs6cwIdo2TawCi/zUpOCkPzK683r3E=;
 b=M7Gd+csBdolW7EPuWOkkM8iuPKdDK6dy4qs10Zy6wInRRaUcImzSvEUykzuYGhwLYfZAQrI8FfhDwJwFEP/im2UYMnnWndU/bDMus+dsQZ/ZXHNQ7xv2//G4+WDMpSVuDd/y3mGeW4eg27PFoX+aT7LKBu9Q9tcfGqDezEEBSi1lp/5zuxKWaZCedhrU6hJ1OuykxziXt6Gl5ysROnb7X5x/ePmzk/aaj+U6yaBvjr8CeiyI/xC6E3li72e36CkzobuU+nbEBmKjRUsDh1ABy6ROrvqHqpsMr9Vzs1s1NimgyvbYqbrZizubfQ9Vye6PHDc0yOGyzugf4P7XmLfDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvwLX3HNOf1WEzs6cwIdo2TawCi/zUpOCkPzK683r3E=;
 b=a66iJzhstIbWMCExWvoEuLbrNyjGN+ohpxIlDbKQggRdPU0zbEdPge+OmGi1SHBcbkalgQpCqKaaEikvS8AwzKRvbkIglhKDwseBe1SYLIA6XpTIvlj0BN/8hGqdkL9i36rBdHL0TVwQLQ8Yxe/IdV4kaz2r/P3dpvhvp6/NW1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 18:27:18 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 18:27:17 +0000
Message-ID: <9b4c3574-a341-483e-95ef-6be9784a59a5@amd.com>
Date: Thu, 23 Nov 2023 13:27:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] drm/amdkfd: enable pc sampling work to trigger trap
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-21-James.Zhu@amd.com>
 <6738fe40-7051-4b5c-9151-3eb7428c9d00@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <6738fe40-7051-4b5c-9151-3eb7428c9d00@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::29) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: b844797c-3cc2-46d2-c4ea-08dbec51d2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTIAlvCPfO+gxCSjHX5hhW9ii9lYmtK7CqmAKYDgahhAwv+7l71lYUJyS+OqwzloBMNsbubjMK3hegQfCzzO52to0B0IFAWbiFzJwDhwsvVjv9fv2rOEHOww9tdE6PRqMcDrRCC+saWDHFt606zxAhfshEk4wMBe7UrPhBP4gp0cF+HmbAhaaVhI9cbwBm/V76IoToHCztXq6Tmnt28SDtA1zJ/5RZob05kV+Dh8+MT5ebPuksB0vajtUAtIvOCgcJXrwgceuZkAEMJpp6xEFWZNo0PDEqlVQzDD/Cg+ZPV3JCi2lB8sWLvBO7yN3IEnm8PNDPGZrUJJJyIQojbXdSNdVe5BYH9ksuaUboJjDX8lyJM1osilobkbxRhHfaimjVDasZTwn8HaYCv2/O3cbSx4XlzhPVLpjhcdsDcBlTJtjtlQpaOnzQUxRD+AYh9zFMDR77KAPONt7TpGxkBMgsSjD4j5xy9chcgqhfC4h5Ud95GjuROIuHdg/CeUuAh/6+togIZv3oXIm2vXxi4ZXZHp1kwUPGpxMsZ12Nlr+SVY4DGn350LWOrZvuNP85+N1RyGlbCpLiKPdg/1xvOY7oZAMLSXZz2yQOBkjj+yN2xNCoYURwxPXWlO3US5L3Z77KtF2L965AXAkE/5s9EZRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(4001150100001)(41300700001)(2906002)(31696002)(26005)(2616005)(53546011)(36916002)(6512007)(6506007)(66556008)(83380400001)(478600001)(6486002)(31686004)(38100700002)(5660300002)(4326008)(66946007)(110136005)(8936002)(316002)(66476007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlzTmlJb3V0YWZSTTBrbFA2SHJsREtKeFJockMyaU1kN3JDVHVUUHErWnM5?=
 =?utf-8?B?NzU2V1QyNGxIOWlUVGlMNXQyUVZyNWV2U0hvN3ZuSnVvaktNVENhaWZoNWU3?=
 =?utf-8?B?ZmZza0hrb0VWUkI2d3N0dHlUS2JvMDlXdi9ZTFpTbmRiNE5PZUh0ZUM2QThr?=
 =?utf-8?B?SUlUSDU2ekxkV3BDbm45bFdsSXZVUXp3dkcvMnlGNVVNK3hXRERzN2JSU1cv?=
 =?utf-8?B?OWZqbTV6anl1ai9KMGZkU1lYTDE2b2Q3aHJCbjVTaTZ0d2RwRUpXeTJEM1Ur?=
 =?utf-8?B?Z3BYcmZNMGw5b1huUmF1Uk91VG5uaXlSL0tXYjY3Tkx4dWh1aUZ2TGpoZ21h?=
 =?utf-8?B?M1JnSG9rcWJ0bkhxSWRObXo3ZUtpcXl2ZXJRUEFNWGppc2xmblhoYm5tc3R1?=
 =?utf-8?B?TFE2bHZxN3ZxZXJhVWVxQU1NMzBRSS9mTHBQUlB6ZGdXZlkwK2lDWTBTR3du?=
 =?utf-8?B?TEZOU2JKRjJTTVNtamxMaW90TDVNM3ZkVndwNEQ1S1pibEVPMTlXaXg2eEcz?=
 =?utf-8?B?ME9FZ2pTSjRvb05hVk5XTENyTWxNYjRSRjE2YmNzWGJoRlREVDM2YW1yaVNi?=
 =?utf-8?B?cXFLaTlsams0TnhTS1JWVHBYWWFJeFIvN1FNZmFTamdxa2srZjZ4emhKbjNJ?=
 =?utf-8?B?VGMvQ0hnd2JxaEpDYVpOcE9RWWtldlNyN1RSNm1sOW8yZjJUWVIxcW5IR0VU?=
 =?utf-8?B?T3Fzcm5uV2J3Mkxob2IzU2xzcWkyamZ0OGhnYXM1TWdKNitwcE5CSTZUT2tL?=
 =?utf-8?B?aEZZVjJIUDhpamFiZjVOc243Q05hcFZoN3FFNis0dVBKZXZ3NVorYk0yem1v?=
 =?utf-8?B?WExsNEt2UXNlNXJ2RG02dy9tQnVjd0VpNU9wdWd1L3owTnc4ZzlHaUQ0NGRy?=
 =?utf-8?B?bGZQQ09NKzJFY3k5c0libUsyUWRVQUZmY2RsZjUrUGZha012V0VkZTk4a1Vh?=
 =?utf-8?B?dDk0TXNseW9pZGVrN2ZxRUkxdXl2N0EyRTBFTWN1UmtGaGxkNzAyVm5ob2pi?=
 =?utf-8?B?bE15a1ovZ1ZXSlBYUnpZSGN6WUZxQ05mOXpGR2V4T3N6QmthVkVzQ2NNSHlt?=
 =?utf-8?B?OHVSeWUxcFRGSW1Nek1OWDJBMXlLM1IvWDBEZmFEQUd5clpQUUFKdDNRd3pF?=
 =?utf-8?B?Z244Z0VIZHJ4WEhUeEt1c3RiVmQrcDdCMUZDWWkvbUxzeE1lSjBsS0RKQTdt?=
 =?utf-8?B?b1ZvSi9FV2xMWDAyTzdDbzYwQk5TN015cDYyVVFqdTJZdkQzMDNCV2prcUVv?=
 =?utf-8?B?QUQwYzcvSjZMWktZMEozYjh2a2ExRCtnSEJuRnB4c2lqQWtia3Z6NXBCQmNU?=
 =?utf-8?B?eU9JM2tTR05lTm5mRXpNUmR5Y3U2RWNVeXhCMGlJQlYrbld6THQ5djR3Qnps?=
 =?utf-8?B?dTVJVUhwSlYvNWQ2VTBmVDhFVitlZ3dxWUZ5bkUvcXF6MEd2QTlzU3RVemEz?=
 =?utf-8?B?ZTZOdWhxa2h4MmNYS1grL0RPQ2IyRGttTVppL0J0Yk5RR09NRGlCSFBjUzhU?=
 =?utf-8?B?NHNSWG9JdzI4KzRiSG1iMit2OFVmYWYrN0dyRGdRaktjVUdiSnRmWUpIOW1B?=
 =?utf-8?B?UGhJS1FoRjdaYXJzL2hzdzdtUFVkVFY1blQwbE1Vb2N6RllvdXJNMEJaMFZp?=
 =?utf-8?B?WE5iQ0tVOUx6SWV1dERISDVlcDJ6S2IveElqby9ZdnlobkozMzBORFM5MHN2?=
 =?utf-8?B?N1U4dk44MlZhNmJQOXdyUzM4UlNhb0dpUWZnN1JmazVmZElJc295WnRoZDFS?=
 =?utf-8?B?eWwzaEpkcTZBYmdIQk5SN2R5RWYxRzlKdDRKV2J2RHFhRXc0L2thRGVMMG1y?=
 =?utf-8?B?Tm1BQ1I5ZjZtTk9Vd1l2S1JubHk2Nlo1elFmVzhDS0ZJRFc2WE5xdDJKNUZB?=
 =?utf-8?B?RTI3TDVYaHVLNWZrSlI2b2R4Q29jckxZL0pnRGk5akRmLy9nTUs5R2p4TS9q?=
 =?utf-8?B?YUxMb0RhRUN3cTNwMlJJaFFQYUlmeVpPSTlzeFBBMkhMK3dodUtTUkZ4NEJm?=
 =?utf-8?B?cHkzdllyTEVHYkF1MVJ3QmQ1amF6L1pxcFJVNTl3enZ1a0NFNXpvZzlFdDFE?=
 =?utf-8?B?YXVnTmlzb2RWTjdmRzlnbkU3NzJDL1UxNi9FeFJCNnVkZFRTNjBHTnR3RCt3?=
 =?utf-8?Q?+wW4BjgWMh1FpSKG5CJONoNnN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b844797c-3cc2-46d2-c4ea-08dbec51d2ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 18:27:17.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPj2JadcppOY1cTb/E7gegk3N74ZnDUbC4PjAtzL+X7f6sckF9fDiekb0OTx077A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
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


On 2023-11-22 17:31, Felix Kuehling wrote:
>
> On 2023-11-03 09:11, James Zhu wrote:
>> Enable a delay work to trigger pc sampling trap.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  3 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 39 ++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
>>   4 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index bcaeedac8fe0..fb21902e433a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -35,6 +35,7 @@
>>   #include "kfd_migrate.h"
>>   #include "amdgpu.h"
>>   #include "amdgpu_xcp.h"
>> +#include "kfd_pc_sampling.h"
>>     #define MQD_SIZE_ALIGNED 768
>>   @@ -537,6 +538,8 @@ static void kfd_pc_sampling_init(struct 
>> kfd_node *dev)
>>   {
>>       mutex_init(&dev->pcs_data.mutex);
>> idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
>> + INIT_WORK(&dev->pcs_data.hosttrap_entry.base.pc_sampling_work,
>> +        kfd_pc_sample_handler);
>>   }
>>     static void kfd_pc_sampling_exit(struct kfd_node *dev)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index 2c4ac5b4cc4b..e8f0559b618e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -38,6 +38,43 @@ struct supported_pc_sample_info 
>> supported_formats[] = {
>>       { IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
>>   };
>>   +void kfd_pc_sample_handler(struct work_struct *work)
>> +{
>> +    struct amdgpu_device *adev;
>> +    struct kfd_node *node;
>> +    uint32_t timeout = 0;
>> +
>> +    node = container_of(work, struct kfd_node,
>> + pcs_data.hosttrap_entry.base.pc_sampling_work);
>> +
>> +    mutex_lock(&node->pcs_data.mutex);
>> +    if (node->pcs_data.hosttrap_entry.base.active_count &&
>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.value &&
>> +        node->kfd2kgd->trigger_pc_sample_trap) {
>> +        switch 
>> (node->pcs_data.hosttrap_entry.base.pc_sample_info.type) {
>> +        case KFD_IOCTL_PCS_TYPE_TIME_US:
>> +            timeout = 
>> (uint32_t)node->pcs_data.hosttrap_entry.base.pc_sample_info.value;
>> +            break;
>> +        default:
>> +            pr_debug("PC Sampling type %d not supported.",
>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.type);
>> +        }
>> +    }
>> +    mutex_unlock(&node->pcs_data.mutex);
>> +    if (!timeout)
>> +        return;
>> +
>> +    adev = node->adev;
>> +    while 
>> (!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable)) {
>
> This worker basically runs indefinitely (controlled by user mode).
>
>> + node->kfd2kgd->trigger_pc_sample_trap(adev, 
>> node->vm_info.last_vmid_kfd,
>> + &node->pcs_data.hosttrap_entry.base.target_simd,
>> + &node->pcs_data.hosttrap_entry.base.target_wave_slot,
>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
>> +        pr_debug_ratelimited("triggered a host trap.");
>> +        usleep_range(timeout, timeout + 10);
>
> This will cause drift of the interval. Instead what you should do, is 
> calculate the wait time at the end of every iteration based on the 
> current time and the interval.
[JZ] I am wondering what degree of accuracy is requested  on interval, 
there is HW time stamp with each pc sampling data packet,
>
>
>> +    }
>> +}
>> +
>>   static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>>                       struct kfd_ioctl_pc_sample_args __user *user_args)
>>   {
>> @@ -101,6 +138,7 @@ static int kfd_pc_sample_start(struct 
>> kfd_process_device *pdd,
>>           } else {
>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
>> + 
>> schedule_work(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>
> Scheduling a worker that runs indefinitely on the system workqueue is 
> probably a bad idea. It could block other work items indefinitely. I 
> think you are misusing the work queue API here. What you really want 
> is probably, to crease a kernel thread.
[JZ] Yes, you are right. How about use  alloc_workqueue to create queue 
instead of system queue, is alloc_workqueue more efficient than kernel 
thread creation?
>
> Regards,
>   Felix
>
>
>>               break;
>>           }
>>       }
>> @@ -123,6 +161,7 @@ static int kfd_pc_sample_stop(struct 
>> kfd_process_device *pdd,
>>       mutex_unlock(&pdd->dev->pcs_data.mutex);
>>         if (pc_sampling_stop) {
>> + 
>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> index 4eeded4ea5b6..cb93909e6bd3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> @@ -30,5 +30,6 @@
>>     int kfd_pc_sample(struct kfd_process_device *pdd,
>>                       struct kfd_ioctl_pc_sample_args __user *args);
>> +void kfd_pc_sample_handler(struct work_struct *work);
>>     #endif /* KFD_PC_SAMPLING_H_ */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index badaa4d68cc4..b7062033fda4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -263,6 +263,7 @@ struct kfd_dev_pc_sampling_data {
>>       uint32_t target_wave_slot;  /* target wave slot for trap */
>>       bool stop_enable;           /* pc sampling stop in process */
>>       struct idr pc_sampling_idr;
>> +    struct work_struct pc_sampling_work;
>>       struct kfd_pc_sample_info pc_sample_info;
>>   };
