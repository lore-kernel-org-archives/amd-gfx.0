Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F1C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 00:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EB210E652;
	Wed,  6 Dec 2023 00:21:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806A010E64F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 00:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEQbBxTvj054iY9oKjDWbCsrm9DtZro5l6Eu7SD6kgYH+ISq+fGM6F1qWwyt4VKXf86cykRZK9KPGDcyAUtvHTSDINOmqbBVcPqu5LeFP6289UWn4UXyzaMWErxMKOFpAhbIt4mMFfrCFYcQY00A4hO7gRr951eTuNdNJNgvoNuj/8+RrXqK90n3QbuBctfy5w4dnujhsywEahZrdZspln5NtymWRpsmc3XZpyvA0OnX5OZRbbxK+2/DRKH3JHbaqGEAAqTueEWsjUuvNGm2myaImmCKPZ78t1tsPL3n5gckL80aUlKlyRtVEPyVAPecWnzV+A8yMj7ifet9OPJkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDZcsE41+b7NgZUqG/MvCANgElYh8zdE/aB+4H4RmfM=;
 b=dRsPDZ9CssJ7bsPqXzoy3nDGGQF/3SvE5K5k3gxASz3kohXXalRF5XyT2kOJRg7PUnBQyK7vuIitNnc9tbZYjpvDojbMjlqd8osTd22MwAhRs5DDAGlFGZJqNbNvvFU8m1jo0EqZoE7iP7oLIZhGY4R/bNek0yE4yLgIyVZ9SKiLqR85gfrwIthbXb/ZzJN13trUAcgne950xCf7sdjyXrrjPwS/42QfMDL86ZgcfV8AHe+xZBOUUzmfAUm7dVEUUUrQWbxOhvf3L9aGyPRC0GyZCZ7UANXVoRSyckZp8CZzo4pdZb+iji4gMvIU2zUIPv5hqROacaRvRQ/l7bEzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDZcsE41+b7NgZUqG/MvCANgElYh8zdE/aB+4H4RmfM=;
 b=0td3GNorrwBqqfZuIa65PrHxQYuWgQ3CLOPQRdRrQp/UymoWxr5G2YkH8y4HK5aaWD9f+gLTGSwLXa/FM48Qw2rXwOzIzws0S8jCxceqwFFo5p5CFrWBpbSl4tSDBNzFIcSuNzfKZ0NJ3URIYnPuxakEgAVJ+hiTqHIBlO3XC54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 00:21:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 00:21:17 +0000
Message-ID: <5b412220-6e3d-4bb4-bb37-eeb654210419@amd.com>
Date: Tue, 5 Dec 2023 19:21:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Auto-validate DMABuf imports in compute
 VMs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231114233254.63139-1-Felix.Kuehling@amd.com>
 <20231114233254.63139-2-Felix.Kuehling@amd.com>
 <062fed7f-1304-4f59-9103-b32bfec830d4@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <062fed7f-1304-4f59-9103-b32bfec830d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::47) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdd0614-6b97-4ee3-00a7-08dbf5f14351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UFWtSf7G/B9hj8tHjEKKKzE/dir6nJorEkq18OVAATKjPCeuYc5tkMziu0EVV2jvOHD2uWI4Aq8bZiJEy2HaUbbZ8t05C2apEB4+6vcux4FwwAFWoBT0hwzMxUomVQy1hdlhR49wce1+87ZAjI6WeTNJGRbKWQ5LJcmkyIpeFF0TG2ka48kVVkoy1w2QORX4ZhYDQklE2bRmySytXlw3XWGD7RfyhEjkd2u9IogZN+pRkutl6MTYR+Ylj2S/jdhyOlZueUnd0/P7zoQzxzXBpztfrQkS3b2iXYwhTZSkCnttAgKHKDNe6aQQmZhLX2iKY7+ALFvDthOyRCbBDYjSq1q25ri6a0GXgzT+TbZ+eU1TijUy40ajiAY5P/acqGGDL4Sn1XvvwRSt+VZuvwTm0UVoz6C7Ncy6UaerV4EJTzluWRdN4HZrF7e37gffvCEfvT7RO00gFYw7l0BUyAGlTG/0AhKnS9LgNE7+NwitdPZuYZBtfKR28r2CzbztZWwVVO4A3lp4nGGh1E2udMADGb501l+hag7fdX8SVLf7gU1Xh2MfOQYacGQs+o6Db3zuO/fFq8TAguUj+wAw/R0S3Hx0cxfPTgxRN+WFltwUAJi1pQ818FXy3psfgGW1XTn6U+HyWuibnW6rlY4gN2ntA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(316002)(6512007)(15650500001)(5660300002)(38100700002)(2906002)(44832011)(41300700001)(86362001)(31696002)(36756003)(53546011)(2616005)(26005)(6666004)(478600001)(36916002)(6506007)(8676002)(6486002)(66574015)(4326008)(66946007)(66556008)(66476007)(83380400001)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGIwNnJmZTBpaG5hd2tkZmJZZHpuWnQxdXpWdjR6L1hFbjdZNVBJdG04eWZL?=
 =?utf-8?B?ZmFTWm1CaHdhSGdOY1pkbm9SRytrd3dnWHR1MjFIYUZPdzNqRmsrTEVxL0pU?=
 =?utf-8?B?TzN1NHB2RUMxUnM0L1Mrd1J1YTQ2Q0FuVGxManI1TmR6T1hseFMxK1l6cnlB?=
 =?utf-8?B?YW04ZW4vSFgzWWQvaHBEaGRqclYrZFNrTHpZd3FwRzZMKzNMNWdzVW42emEz?=
 =?utf-8?B?NHJWbzl1WkNtbExFWTJDMEpPYWdIZTFNTStWTXVnKy94RWRtUnlVSlBydFFV?=
 =?utf-8?B?MHZNT0kwK1pwREZvMXQ4aWtRQzZMcStQR3FRVFNiVTNIWjg5N0l4WXNQTGJt?=
 =?utf-8?B?NHZEZ29xZG9Kd1E1RVVaUkhKSU9oSU9ibHRpUDNVeG5Ma2o2Mm4vWDBST0ZE?=
 =?utf-8?B?K2M0clM4ZFJhdXYzS2Y4YUpOdDNhcEhPWmliS3BFeDBMa2ttWjdtbDVPVjdv?=
 =?utf-8?B?a1JwRk80eCthdzlJQ0FQOVBFQWEzY0tXOFR6YkltZVVmQ2dmdCtzVS9PS3J4?=
 =?utf-8?B?WWhEMm4wck4rcCszTkxiQ1ExaXpYQkl2SUdWcE93VTZQdGN2a2ZiTmUzVFNq?=
 =?utf-8?B?RFZXVkFEZXkyN3B4alB6bHorQmozNjhQWWx4U254dmNZRkw0ZjlPRjNmQ0Qz?=
 =?utf-8?B?QmF4b2V2NzJwQzNwYmJUdUV0djRBdzhxV3U3L1ZhNDI4bVJCS1JrSVVuRXdr?=
 =?utf-8?B?dURaU0x3RWd6aHN5VS83dnptbENlNXByMSs3WFRzOXNQdVViTDROLzVra3pS?=
 =?utf-8?B?WU1BZHh5YTJneG9sd0lCZ2ZGSUNmbFdaRlJUaDRyaUxrYW5CVjRmWHhEMHN2?=
 =?utf-8?B?KzdJS2RWSWUyQ3BNRXBZdU9mZ3dRMDFROWNiMWVUVDFkbjRhVXB6VXMxSE8r?=
 =?utf-8?B?WjBNTVRwUjEyOXVWZVovRWtET0VDVWc4Mno1V2FXQ2tMNDZ3UzFoL29GYi82?=
 =?utf-8?B?TW4ySDZ2dHJXSllveG5BNkF2Nlk0cERMbCt1Mll1Q0E2ZEVncTU1WVZmdndQ?=
 =?utf-8?B?dDBQNFhNa1ZUMXY5bUtzYjZzSzVCK2F2Sy9NR1czK3F3ZEhST1RjdmZyNFdy?=
 =?utf-8?B?RVh5dXRLL1BxM1k5ZXBpRXR6a1hKRGhsd0U5SHg5RlN6N2J6a2EzZm9ZVzQ1?=
 =?utf-8?B?SlU2ai9TUUNmNTRUQmV4YlBySmdqbjM3dVBkSEpvUGlFTmt3bERNZDR5RE1Y?=
 =?utf-8?B?K0hIenRZMkJMUk8xUTRGKzRZTGQrSm1teVAzTlBxcGNKcE5iTTM1MHlMeTd5?=
 =?utf-8?B?OEpoVVlGNTd0a3ExdXZ1NEtwS2dOT1VNZUxsM3B5bUJwWmxlNHJ2aW9tbXJQ?=
 =?utf-8?B?MWo1YW90VjNMbFJhZThKS3JJZGRuR0pSMzFDWk1SS29TbktudjdVb0RHUUxx?=
 =?utf-8?B?aUVjb1hSdW03bXZ5NTVCc0ZlNlVCNHNVSWdpOVhkR1EwenVZOUNEbzJwdisy?=
 =?utf-8?B?ZEQ3T0RCRHlCZzhJMWV4YW8zR2pzOVdTQ2NrS2JzeDFkbnNsVDI3eFYwcVQx?=
 =?utf-8?B?dVpnRE1UVHZPOHN0K1piWGM4RG9aWEhnaGJYN0RLNkRSUit3aDVFbFluWHZz?=
 =?utf-8?B?V3F3Q2tXZXlRaUtnY2NUQ0FVYWZ5TWRXYTJhV2V2ZG9iOUdoVTFJYlltWDhr?=
 =?utf-8?B?ZUNjMm1UdG1ScXFvMHhmOWFvZmgrR1BOQkJVaXZQNG9zcExqRitxZFpTaXRM?=
 =?utf-8?B?UTFRWTNYczZzZXZWK3NSeTBPWTRDUXFaUnRSZHJaUURmdFBjK0pOMVJxTmZz?=
 =?utf-8?B?YjZLWHUxazZReFdReFl3QXlxT3YrUVg0Sk4rU0NDSHNaVmZzZWRNalN2Rzc0?=
 =?utf-8?B?NjNCM2xPeE9uZVBYSnQralJZd1ZUL1BEN1drYnRVbXVDdEJPRnd5ODNUd1h1?=
 =?utf-8?B?amFPZlJSQVZzdHFhSjlnaiszeG55dW44U2VINWVrbmJmd2x2V2poVGZML2Vh?=
 =?utf-8?B?d3lrckdWSmFNZFZPeXg0Zys2Rmg4UU1KWnMrblo4Nmx1cFBRb2w4TjVPaEtQ?=
 =?utf-8?B?eEJ0S051QVhqbDhmQm93djZPRUJGa3V6TmdqejJ5cGFTdDgrUHlkYndOcHNV?=
 =?utf-8?B?SHl4ZXJTT29CSkUrUmdqcXk5OTB4cEFWb2xySHFPQW1OaUk1TFlaZStONEtN?=
 =?utf-8?Q?aa71REDM1iilPhg4O9DTiFcVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdd0614-6b97-4ee3-00a7-08dbf5f14351
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 00:21:16.9883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR2cbhIyIAZEDHWREjMoWQdGE631zT1Z37RIBsAKxrhMXB3QNwx0CcPGL+a71sj5wBkyj2QlbTkCW2UwkK2R4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-04 03:40, Christian König wrote:
>>   @@ -416,6 +423,28 @@ int amdgpu_vm_validate_pt_bos(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>           }
>>           spin_lock(&vm->status_lock);
>>       }
>> +    while (ticket && !list_empty(&vm->evicted_user)) {
>> +        bo_base = list_first_entry(&vm->evicted_user,
>> +                       struct amdgpu_vm_bo_base,
>> +                       vm_status);
>> +        spin_unlock(&vm->status_lock);
>> +
>> +        bo = bo_base->bo;
>> +        resv = bo->tbo.base.resv;
>> +
>> +        if (dma_resv_locking_ctx(resv) != ticket) {
>> +            pr_warn_ratelimited("Evicted user BO is not reserved in 
>> pid %d\n",
>> +                        vm->task_info.pid);
>> +            return -EINVAL;
>> +        }
>> +
>> +        r = validate(param, bo);
>> +        if (r)
>> +            return r;
>> +
>> +        amdgpu_vm_bo_invalidated(bo_base);
>> +        spin_lock(&vm->status_lock);
>> +    }
>
> I see two main differences to the evicted state here:
>
> 1. We now handle BOs which don't use the shared reservation object and 
> needs to be locked manually with the ticket before calling this function.
>
> 2. The BOs are then moved into a different state after validating them.
>
> That could be handled with just an additional if if I'm not completely 
> mistaken which would make the extra state superfluous. 

I tried this, and I think it's working. But if I don't have a ticket for 
validating user BOs, I have to move the BO back to the vm->invalidated 
list anyway, to avoid an infinite while(!list_empty()) loop. So the BO 
may ping-pong between invalidated and evicted, and lead to some 
redundant page table clearing in amdgpu_vm_handle_moved in cases where 
amdgpu_vm_validate was called without a ticket and there happen to be 
invalidated DMABuf imports.

I'm not sure if this will be a problem in practice. If it is, I think 
keeping a separate state for evicted user BOs may still make sense.

Regards,
   Felix


