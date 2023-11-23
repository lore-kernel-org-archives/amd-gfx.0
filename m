Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6208EC61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0811F10E34E;
	Thu, 23 Nov 2023 20:22:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9313510E34E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1AobG6IGU15K9uFaV0s0laPwZUGbRbOc7rK+7TTHk1LW3TWpkTdxt+6A/CdxHKng6qkbTHTO5H8WF94ktJ/SzR9d1mvtXNSpUg+qVzxh/qMw4JAffldLfk/PH8rCJgItBN93i5/fAWtR3R67DkkLDyhOw4GkGxMAXTwnxvp6Sds4qk7kedkNZNvo61QsmfNvuolI27pqrAL05ODNakJ79A3nDvhbRVxHqWWVXwob53IT6E3KzVBvtUBHpwF+VoFxFiNQnbtXuQ1NtNqZwR0pHBD/tQ+95c5yCe32lhovYogsN1/heO6iA0GeRfsgJJb/62KN2FV51Shm5oE63XCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+54Az8nGqdJH+bo4oySJGvYZ3PUAYjmLXQmqj/+Ezkc=;
 b=WZBMEpkTSNLUYvkNhq2mLJes95VrRgPn6eeHsHFjrQ/jkfKfdaf9gLhFxMZLG0Vvu9YEwsLFnFHeD/ULVJObsi9y7dtiHuwUTOfrGCHvliZdsDq1p4lFLGOxRMWXx+c7+td3daMGzgKB+B7e2k9ypp0Ln+lrHzZFtv0XVsLG6DUqZHKqjAoQynIWFrHiTHz/4HItDl0bNqOiQXy2wNauFDovDjojT7Zd6kvcgUtmrC33Td7tNBUwasCbrb5yvFALrJ/GNNkwAQ13J8sHx1Iqomz6W0BpJYtFD2ysEXio1YLpewzJRr+DR25KOq2lDQaI8/8xr3BXFxnxwNjGm+PP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54Az8nGqdJH+bo4oySJGvYZ3PUAYjmLXQmqj/+Ezkc=;
 b=vC1rr1ld8ENFzrj0PsNfTHu1Usi2R4MK4e5D4KambVziKtMJefIqS5Gpi4sQ4E5RBa3LztK0rxjmYKc9KD6+enl92fsfKfmr/lYzltrCM2k0sVuQ+MZhYCcKreJxMHLyJDwSAn53yb35CYFuEN+/Qf59PbHcWr3z0XAmhwMcpUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 20:22:26 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 20:22:26 +0000
Message-ID: <5843ca55-cba7-46ec-a86b-7cceaa5c20cb@amd.com>
Date: Thu, 23 Nov 2023 15:22:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] drm/amdkfd: add trace_id return
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-7-James.Zhu@amd.com>
 <92ebc9da-a504-4794-a93a-52565ac66333@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <92ebc9da-a504-4794-a93a-52565ac66333@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f146ff-832e-4d5f-0b8e-08dbec61e87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yzLPjsuJALvVTGSkMtOB9V8+Phg5VQpS43CouEE7s7JZAwU06pK/u5PbCCfBd53/5wc3hYRai7lQHXKrbMM7Yoi1zuBsxEuUVgNIdUZAt91E6pezjOXe3NgD35NmrigsvoAui7W434rgcETc7/NDlmDyeBYv7Js8psLEKgn3fSFaGoh4fUmIs2D725tk86a4VDeU4Kf6EGPMw1I1jlmlfRATCIBW16ev8j/GyeaMbef43PHiErfx8WHoCxAKV90YJPgiatKxMfkO3vEfcce73LMD9dQQ+GdAsRFKzw74lD5Stj+4YVy+lu+zCH4y9ho0bfhhyUp/yyTlAXJ83dhNW+R7VYHcHlXw/KVw89zM1j//UvsessmK7+u68XJUVrvhFuwqZryCWUk2u0r0MOrhiJvhL+36QVKuGhjFv7G3ChaiX51EiWiy81fLPPNJpIYdFMhg5fpy/ivNN3LMBiwEAIYU7UZ7PjW49LN8Da+mo69DFRTMAI5iscWj6hTnYB7nF50+8zKTme/ea8qF7PoHvYl+i02TOBs+gkwpWzQKWgtheXEkvkP3UuyQIPZdo7menkWxlhcMfFoTyy/S4qPsTtAhpM/9JAIg4I27ZeHTDVD3QdnWFwv4xRZkATgAxJLdufGbLgihRcur2PWo62zJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(8676002)(8936002)(4326008)(31696002)(53546011)(6506007)(36916002)(6486002)(66946007)(110136005)(66556008)(66476007)(31686004)(36756003)(316002)(38100700002)(2906002)(41300700001)(4001150100001)(83380400001)(26005)(2616005)(478600001)(6512007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjYwa2FpZVIwNXRndVlhM2M0MHgvbnNkSDNUdzlOaVV4c0tncGdFaWUwQzk4?=
 =?utf-8?B?anpQaWRWcGFrampCbzZHQzJ6NkF4VUxEeFdkUkpuVDVZa3kvSlBDNkxDQ0R4?=
 =?utf-8?B?Yjh0cmpyZ3JsOVZjc3hhZXgxcFNTNU5ncVpLMDNzN3dpRHorZjgwaVRTUng2?=
 =?utf-8?B?cmx5RThDK0FSaW5NTmNpaWF1VTNDMm1yTkQvN0h0ckZ1K2xNRGJvZS9EQXpD?=
 =?utf-8?B?OHdHMlNoU3lWcFhwV3ppTm5iQkMxZDFaNVd5LzJRRFFlRStSWU1Ra21BUjZE?=
 =?utf-8?B?MkxMSWFtdUlQbTF0SThFK0tKWXFOOEMyVENhcGNpMnBhQ3JQZER4VmZDUGI0?=
 =?utf-8?B?eGR6TWUvcWlyc0F2UnZNMG55eFFESTdsMU81TkE2d3RycldieWgzOEsxbUlt?=
 =?utf-8?B?RG1pUXdGUFc2YmZQdk14WWZIUndSTFVLanphZlVLRFFZcG1ndVFRakphSDVp?=
 =?utf-8?B?SFVkaXFWbEVoZ2k4Vm5JVk5mU3V4eTVUT2U4WUI5aVF1d3J6VkRNa28yY1Zi?=
 =?utf-8?B?a0VxUzlzUWdXM3Q5aVFVNnpCVFVlaE5PSVFpZHZZZUtLRDMyNEZsSUY0UzQy?=
 =?utf-8?B?VGJlS2RVVlpOOUVIaU1NWUlTZlZBdCtCaUFTSEo5VW9HR2VKRWdmN2o2OUlt?=
 =?utf-8?B?eCszTzJnTjVQbVpkWk16ZEtjakk4bURIRXFLQ09Xck5MZWVoNnJ6OVdjUVky?=
 =?utf-8?B?UTRuUk9Wd0FkUjFTcWg4TzRLOC94SVgvQnBFRENvdTRPdGF1cURRYnlsV3Vh?=
 =?utf-8?B?OEFGRkhtd2xrNE5WdFQ5VWF0TU1kcFVWUlFYWmtLMXVlZVM0emQyQUdOUTN1?=
 =?utf-8?B?N3YwZHphQm13QjZkYi8xc0psT1BndkpRTEk3YWM2cDVtcjhNV2pGQ2FtY3hQ?=
 =?utf-8?B?b0QzQlBINGFRem55YzZjUE9KNm1zNlk3ck5OR2ZmQkQxNlk5cWJMQVM3SitB?=
 =?utf-8?B?bEpzY2FTV2JjSmdHbkpKdVNpaEVUekx0Y3N2eW5mREFSNmhaZFI5VjRhM0o2?=
 =?utf-8?B?REFiOWFYaHJkVFlMZWxOYWE0WVpZL0kwbnZLblhBR1RJS3FLYnNCdTBreGRt?=
 =?utf-8?B?L21SN3ppUmxXRUdlUCtsSmt3cHFuL1g0TzVldkdDRE9Edy9wQU5TQllRUWVZ?=
 =?utf-8?B?MmJNR3l0akk0Y05WKzczblJsYW5tWEgxNUNoWGxmUHJJUVdhTEtCTmRMUGJm?=
 =?utf-8?B?M2V1ZEIvSEJkTVlnbkZEcW5wbHZjTXByS2RaU3hiYVFkeWZJWGV0TUsvWmVN?=
 =?utf-8?B?K3V6UWhJdnJUM2F0YTkxMXNGMUhwS05VM0tHME05anhCVlZxWnorcHZrTEpw?=
 =?utf-8?B?dGhjY3lSNWFFZ1BaU0x4c1lROGRsNlkvOFJ5Vy9DL2tDaUJWZ1RTcHIyTE94?=
 =?utf-8?B?WlhWQXBpdXpCY0NDbjFJSk9uRzhDeDdiSTIrQkJ6a212Z09zaEJKcWR1eS9n?=
 =?utf-8?B?VW85ZkR2ZTNNYlZxWkQ4eUpwbGlSemZ0NWw2MzZXeWlMKy82UC9tNEx0bU42?=
 =?utf-8?B?azUzUDdzK0FXSDM4YTBKUjV0clBSaVNKb3Ywc3ZleEhoRDY0VEF2c0MxTVQ2?=
 =?utf-8?B?bklUUnhNcGJ0ZEJTbVpQaGZ0NllqOE9LKzZiN3BRL3JhaWNGanZIUjJhdHMz?=
 =?utf-8?B?UDFuWTNWcTdPYVp3NFpONnhMOTFkN09mSyt4TkRCcUdjYXVLOHdnSEFiWC91?=
 =?utf-8?B?a1ZxdlpyVFZJY3FLaHM2cys4RTNBaDNnWkNKeVp1b2ZHRS95K0ZtelFidFN1?=
 =?utf-8?B?Z0M0MzRoOXRYT2I3U2t2WStjV0FTWmN0dCs2MVl0V1hiSzJXSzZ2LytNRCsy?=
 =?utf-8?B?Q2Rzc2ZQNFI4U3pEWWZMd0Y0NzVyZUxRdFJZM1d0WEtBZkJtWk9EbWJGRzRi?=
 =?utf-8?B?TEEzYjVVTjN0M2hRa3BNVmkvaFgyU09DSWZhT21NamtscXc1TlViYWZOSzRu?=
 =?utf-8?B?bWpMcWpzL1R6aWE5ZUFBd2dvOThXenh4TEdOWXVrVndUM0tPZDc4Nld0VFZO?=
 =?utf-8?B?RWdhd1dGanVkN1V2NmtydmtDM3ZPZEEybVlOaDdIVDZ6ejN1RGs3d2N3aDdp?=
 =?utf-8?B?WEVvTUQzb0lZSWF5SkpZZ1gxSTZaMERsRWRvOFc2TkJNd0dCOVgzdFNrWHRZ?=
 =?utf-8?Q?34BAFeXP7Ok8EaXIKV+MwJAFo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f146ff-832e-4d5f-0b8e-08dbec61e87c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:22:26.1338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZU/S6ARsctOBhZLu5DSuWtvAQNSdIB+WQjGcClB9c8JPQAdlGzNs/UD+JpH83uX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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


On 2023-11-22 16:56, Felix Kuehling wrote:
>
> On 2023-11-03 09:11, James Zhu wrote:
>> Add trace_id return for new pc sampling creation per device,
>> Use IDR to quickly locate pc_sampling_entry for reference.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 0e24e011f66b..bcaeedac8fe0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
>>   static void kfd_pc_sampling_init(struct kfd_node *dev)
>>   {
>>       mutex_init(&dev->pcs_data.mutex);
>> + idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
>>   }
>>     static void kfd_pc_sampling_exit(struct kfd_node *dev)
>>   {
>> + idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
>>       mutex_destroy(&dev->pcs_data.mutex);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index f0d910ee730c..4c9fc48e1a6a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct 
>> kfd_process_device *pdd,
>>   {
>>       struct kfd_pc_sample_info *supported_format = NULL;
>>       struct kfd_pc_sample_info user_info;
>> +    struct pc_sampling_entry *pcs_entry;
>>       int ret;
>>       int i;
>>   @@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct 
>> kfd_process_device *pdd,
>>           return ret ? ret : -EEXIST;
>>       }
>>   -    /* TODO: add trace_id return */
>> +    pcs_entry = kvzalloc(sizeof(*pcs_entry), GFP_KERNEL);
>
> I don't see a reason to use kvzalloc here. You know the size of the 
> structure, so kzalloc should be perfectly fine.
[JZ] Sure, will change to kzalloc
>
>
>> +    if (!pcs_entry) {
>> +        mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    i = 
>> idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
>> +                pcs_entry, 1, 0, GFP_KERNEL);
>> +    if (i < 0) {
>> +        mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +        kvfree(pcs_entry);
>
> kfree
>
>
>> +        return i;
>> +    }
>>         if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
>> memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
>> @@ -149,6 +162,11 @@ static int kfd_pc_sample_create(struct 
>> kfd_process_device *pdd,
>>       pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
>>       mutex_unlock(&pdd->dev->pcs_data.mutex);
>>   +    pcs_entry->pdd = pdd;
>> +    user_args->trace_id = (uint32_t)i;
>
> I suspect this should be done inside the lock. You don't want someone 
> looking up the pcs_entry before it has been initialized.
[JZ]pcs_entry is for this pc sampling process, and it has 
kfd_process->mutex protected,
>
> Regards,
>   Felix
>
>
>> +
>> +    pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", 
>> pcs_entry, i, pdd->dev->id);
>> +
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 81c925fb2952..642558026d16 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -258,6 +258,7 @@ struct kfd_dev;
>>     struct kfd_dev_pc_sampling_data {
>>       uint32_t use_count;         /* Num of PC sampling sessions */
>> +    struct idr pc_sampling_idr;
>>       struct kfd_pc_sample_info pc_sample_info;
>>   };
>>   @@ -743,6 +744,11 @@ enum kfd_pdd_bound {
>>    */
>>   #define SDMA_ACTIVITY_DIVISOR  100
>>   +struct pc_sampling_entry {
>> +    bool enabled;
>> +    struct kfd_process_device *pdd;
>> +};
>> +
>>   /* Data that is per-process-per device. */
>>   struct kfd_process_device {
>>       /* The device that owns this data. */
