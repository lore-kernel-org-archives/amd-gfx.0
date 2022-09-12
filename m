Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E40C6FA83
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 13:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB59A10E494;
	Mon, 12 Sep 2022 13:22:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89A110E494
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 13:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz4cygpIKtUBA652YScSeyhAuerhjzq/UCWhLWEaUVcCXIOBNJmJNxYAZnCUPE2UvKVWnFPn5N3lbjvq1cgG9DdTSWOHPLdyOfs6ngeYo5grUcFG/J7mw2kNZbxlFx0tInnDdrJbh5caYmE5OYnKG8woTA2BJfYBW8/kTGxOnlgJLPUBodcvrkl8o52xmDGNNWWMl1SD3JsL1VxCdiRT+XzM7ObiWFKQCpDBLM7h3n7yiGOy2JZ2VvyXZ/eruXVBWGXeOu+rZAtVlxLuBlJsh5R+FeYROFKJZJaeNfpeSHU9KMs3LNJWbFV4JnzrNT65iZe2ZVvCMrjJFv/ixyszbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwWDGDCt40ZYgTQr1qBz9HvK9OCpVSKfRPhk1KJut34=;
 b=OfRIQZ6rjTHH/AMBB3YbmX2HcXBzUyVu9Q2Axy7J/Qo9kvky+hVQ++E4bdsVFX5JZtZCUvVYNvrDAeh4IEmZAv1TFTUef1fub74ExEmRKEnNS46upOu6WUkVad+7ldU+J+uWZ5n4y3jEXozeTCgd8WHNxVk2LQPFw7WcP00waZRkKSuFGo9h3h/40u7O+czl3r1w91siKPxgUnp8M57nFJWTYazzt43TRuB0L9iqdK8J0aX0FE13WuAP2ZUUTKkgw1n7cIebXAguaUVwj90Sswp+VrD2cNo2CjugGrxjfbgYvZ0EVmfn+z654ALmqhAYoqkPSlqUV9doYBmnxO2Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWDGDCt40ZYgTQr1qBz9HvK9OCpVSKfRPhk1KJut34=;
 b=Z+l1N4+NsYfa6E+rWuRd+PCkfbWlKX9XxFEH9+ZI0WlVWGN9EJMcrtBPVcON6zusTwG1SAjJUDS3VBkgtngj0717r0R58gFgnE8oBzP45qyY1QE5X/HdBc1YMqP5pIiK11L22kh8pwb+E7PmkabXUIjPJ4aYD4VAfgoYXKI0wB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 13:22:42 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:22:40 +0000
Message-ID: <88534536-4707-32da-5af7-04668b8cb4a8@amd.com>
Date: Mon, 12 Sep 2022 09:22:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <75db4358-feda-0a0e-415a-ad5edfd4bb89@amd.com>
 <a2482795-4be3-1055-e81b-aa0c8d985e4e@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <a2482795-4be3-1055-e81b-aa0c8d985e4e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|BN9PR12MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf38c7f-d0a2-45fb-a752-08da94c1de12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgTQJqGuN8IXjHOk7y55xpl+PYSJmZ+dZgsxaiuDLSQ7VmNyf/gvMcEoZi6w2N4SM/d5uQPAaCwJ2u7YXUCLAi1NEbrQti7hXCI97RP5e9mh0PHymSHlY8FoAMSrSQs4LwRAW+dnDQ2+LEO++clUdhn3xs0aAX2HOtaw09VVhPn8BStPNfhHpFWSWcEHHbxkNP22CafHYRlAUvrQOBxI421pQ7bCx4E6XBtttGGlbl9QjiiCgsOjvvTGC8X/Ur0jFyiCtzogfsDKqClrcFS/mzZBoPFTHaGqpSR7btLkVZtkenCQ1bjIvSzUaw5CQVbKeHNfjvyPB1KcLjinyf9Ko50wYRtJV65JI2LhWpWlPGfKdtFMixYZNtjgB7CqHVAbrfBlfOkkmE/SdvjDyWf7n17WvqB8bxgtj1/rnFCXH0CL/H1GRc/w9Pw02ZzMP5C/n+TqCtFUsCAf7R0jj4xe602kBtTKCE5C3ANhXXhIV+AiLxBVFkSzPn65Kf2QSpUGHg5qSA1mwP395VFPkTVWSMj0b1Z/7XX15PuDbQnSOEVGmSLlj7ycHmQ3vyLhXYVBwz6p8bOVWpnJh5cz/bVtP22mC/ESUPpfR5/7LQFJw/NefHmFOmfzEuuntq87jUdfSKcu+Wfkyt9dCGM0W6k99F7gd58J+0y2XQ9oIkXNCXqZQLF9svhR1Y1IglDMj+aD9/tM4yXGJAy0szCeMQzeK/XHcKDrb0EwnItKtq8hJU4XLQQHHcRX88FsRVjSHwWCEzw8Y+Oq+1pgUONm/ZAQA0Yjhki4iEGAFVpI5uFdbBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(31696002)(316002)(38100700002)(6512007)(2906002)(30864003)(5660300002)(8936002)(44832011)(66946007)(66476007)(66556008)(8676002)(4326008)(186003)(6506007)(66574015)(2616005)(478600001)(83380400001)(41300700001)(6486002)(53546011)(31686004)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmlhVTYwd1p2M0t5bEMxQkZYWVkweWFsbzEzOEFvcDIzWGg5YUVqTmJTYnl1?=
 =?utf-8?B?T1JKdUp6ZDBwRDdmOVl2OWROOXlHZjluSGJickMrT3BjUHZpbzB3K05Ya0tT?=
 =?utf-8?B?b3JMVE9JbndVQlV0UW5TVVRDa0IzdFVORGNJRThiYUE4eHYvUEkrNk55d0pi?=
 =?utf-8?B?YTlNeThGZWlSaWdoeGx4S0ZWL255Wmd1NXZWaXRSRHhTNTluS0RUT21uMVBS?=
 =?utf-8?B?ZDZLOGQ4cTZ1Q2RnaUpENXZZWDVkUTVIUFpucS83NlR5Z1MydkZMRUtuSXJZ?=
 =?utf-8?B?OUVhczRWSVMzSTNvbU10NmsvZ21YdUxLVExZV1RqMnpMSWpDMUFWVHN0dDh2?=
 =?utf-8?B?d3pLellWQWQwOVZ6c2Rlc0t5NjRqWERFNkZjcFVxanQ1RFdsZlh2cXBvcVI3?=
 =?utf-8?B?bHJGdjVUZCtCSWtpaEFNaFV2OFdvOUhUNDNSaXE5VW9EdEhiS3pSNmgzdytQ?=
 =?utf-8?B?REl5M1NyMFNwZC9hOU9WTU9COUVNZXFKUUUzY0VWMHF4WEJNTm5lWi9ZVjRk?=
 =?utf-8?B?Sll0WDR1SVhKZ2xiL216VW5EcEZVK3I2dHkvU0RHbkRYdE1YUmF4MklmWHpH?=
 =?utf-8?B?TEdyZEFRVnR1Q1V5R08wNm5jVTlGVlJyVldwVWlKVWRxT2pKeFZrbkc0Rmg4?=
 =?utf-8?B?bEFnU3dqNGtIdVE3SS9QbmNmNDZUcFVtYTQ3R2lZNnl3cHFxNEhqV2hOSUtP?=
 =?utf-8?B?UlZqbGo3eXpQa2xqVGxsSi83eFdKbmx1Y1dBYkZHNzMwN0JrdDN3QXBrcElp?=
 =?utf-8?B?dFMxOWpWSzNlUzg3VmdYZDBMRkFVKzNzNFNjTjRvQTc4YlpCZFhqNzRlN2NS?=
 =?utf-8?B?NDVBdEtMUndBL1RKN2d6N1pRdzZGQ3J0ZG1oM21peFA2R3BJZnNoVXhheE03?=
 =?utf-8?B?TlBKc2FiaUM1MU5QNlFsVVpYcG9EaGRIK2ZUVFBmQm5pcEdMRUFETVVqa1Jl?=
 =?utf-8?B?YjBpNUorT1hXc2FWQ2hRc3dKSGZqOFpIbFJYeWZmamRkZnZ0OTBGbnZZbDll?=
 =?utf-8?B?ZTlLcTR1RTE4TkRMM3RTRlFBSVIzaml5N2FTd1Ywb0RzZndIYUFSQVUzRFoz?=
 =?utf-8?B?YlVjbDR5aERuTW1CcmQ0dVdwdzQzcG4rZUNlRmFseThzeGkrbEl4RjJiR0JH?=
 =?utf-8?B?N0pxUSs0MWVQUERSWXc2NUVKWkpjMGloeTlyL2ZGQSs1cW96MkdVMjExRnlB?=
 =?utf-8?B?T0dvL3M3ZnN5Ni83MnM0QkhJd3UrMGdhVU9CdjJ5SlJLSjhZbEZkdVV3cDZS?=
 =?utf-8?B?bzRhcWVYdGRYZkNlbTFqZ1VTRmkvSnZKb1BVeGRiZzk4MUVpeHl4SXpzOGF1?=
 =?utf-8?B?SVBaOVF6Z3IzZmNFTDRWWDZGbENyZUwwWTFQdlBnYjY5dnpQd1VvZHZqcXVP?=
 =?utf-8?B?cnQ3RUcxckVuWk1Wb2V5K3BnOGkwaEdVdUZxRlNoalR0eWFaMVJKTlBqbmk0?=
 =?utf-8?B?YVNuajZ4aWVmSC9Ic090b21zalZub3BlVEVMaVIydEdFNTduUHhGV29zZ3Vq?=
 =?utf-8?B?Qkp2T3djaVp3QnZoUE1hOXhOMCsyR01vaTE1THU5WWhFN0xZaFdIYlZnbGtn?=
 =?utf-8?B?dUZ0Tm52Q3NuTGhBZHg0YWo3dEVLYVRKeGJydXJvTi9XeURZcUszQzBGTlF4?=
 =?utf-8?B?MXJzMEFaTEgzWDY2ZE9oUjVlRFAyMTUwV29DWG4zZk1CY3Y3R21rMDgwaHlF?=
 =?utf-8?B?YkxVU28rYjlnandFY1ZWRDJVcHphT3k5MnZtUFRiclRMOWwzdjczbmtJODcr?=
 =?utf-8?B?T1ZyVFQ2TUlnaDRBTHZ4aEVTSXFGK2oza3FUTUpwU1J4S2UwNGhlVGN6U2pI?=
 =?utf-8?B?alkwMnpxUTJhZU5BQmZFZEtUTWRyRDVYaWp1MkxMR1hPWEgvZFhUcnk5TTQv?=
 =?utf-8?B?cUhSOGJqTTVRQkhLKzQ1dkpEK3RmNGREMEhuY0pVYWNxUWJCQ0Rqd1VkdjJm?=
 =?utf-8?B?MU5UWVVIYnpzRmpYN21rQjNCYVg3Qy9TazV6Q2U5dnE2a3F3ZWpUY0VScU43?=
 =?utf-8?B?V1pxVlJUV0ZwSHlwVW1wRXJKc2Ewa0s1akhtRmtyRTV0enIxVFc4cEFSR3Bq?=
 =?utf-8?B?MHB4MGdHVzl6RXRwZ3V2YjZaOGhGVnNEaHFubUs3OXI3VTRlRTNGa2Ntdnhy?=
 =?utf-8?B?WjZydWNMWDROd2JNUFpjdlpabVE3eXJXbzNGREMyTXM1M3hmbHpZZkExbThD?=
 =?utf-8?Q?Bnme20w/Qu9iQ6rxfjxDFoPzJ9GDqRSFPyhDGJyDXOK8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf38c7f-d0a2-45fb-a752-08da94c1de12
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:22:40.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oC2YEyBlcl9mlGLhal9X3lNmrfDSQsYZo6IU5Y0w93nLJZKqnayxq4sPlWMQP0YeiU4WOVseMsRAGkRb2KRRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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
Cc: Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-12 06:20, Christian König wrote:
> Am 09.09.22 um 18:45 schrieb Andrey Grodzovsky:
>>
>> On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>
>>> The software ring is created to support priority
>>> context while there is only one hardware queue
>>> for gfx.
>>>
>>> Every software rings has its fence driver and could
>>> be used as an ordinary ring for the gpu_scheduler.
>>> Multiple software rings are binded to a real ring
>>> with the ring muxer. The packages committed on the
>>> software ring are copied to the real ring.
>>>
>>> v2: use array to store software ring entry.
>>> v3: remove unnecessary prints.
>>>
>>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 
>>> +++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>>>   7 files changed, 509 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 3e0e2eb7e235..85224bc81ce5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>       amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o 
>>> amdgpu_nbio.o \
>>>       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>> -    amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>>> +    amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>>> +    amdgpu_sw_ring.o amdgpu_ring_mux.o
>>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index 53526ffb2ce1..0de8e3cd0f1c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -33,6 +33,7 @@
>>>   #include "amdgpu_imu.h"
>>>   #include "soc15.h"
>>>   #include "amdgpu_ras.h"
>>> +#include "amdgpu_ring_mux.h"
>>>     /* GFX current status */
>>>   #define AMDGPU_GFX_NORMAL_MODE            0x00000000L
>>> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>>>       struct amdgpu_gfx_ras        *ras;
>>>         bool                is_poweron;
>>> +
>>> +    struct amdgpu_ring_mux            muxer;
>>>   };
>>>     #define amdgpu_gfx_get_gpu_clock_counter(adev) 
>>> (adev)->gfx.funcs->get_gpu_clock_counter((adev))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 7d89a52091c0..fe33a683bfba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>>>       bool            is_mes_queue;
>>>       uint32_t        hw_queue_id;
>>>       struct amdgpu_mes_ctx_data *mes_ctx;
>>> +
>>> +    bool            is_sw_ring;
>>> +
>>>   };
>>>     #define amdgpu_ring_parse_cs(r, p, job, ib) 
>>> ((r)->funcs->parse_cs((p), (job), (ib)))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>> new file mode 100644
>>> index 000000000000..ea4a3c66119a
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>> @@ -0,0 +1,182 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include <drm/drm_print.h>
>>> +
>>> +#include "amdgpu_ring_mux.h"
>>> +#include "amdgpu_ring.h"
>>> +
>>> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>>> +
>>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring,
>>> +    u64 s_begin, u64 s_end);
>>> +
>>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct 
>>> amdgpu_ring *ring)
>>> +{
>>> +    mux->real_ring = ring;
>>> +    memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>>> +    mux->num_ring_entries = 0;
>>> +    spin_lock_init(&mux->lock);
>>> +    return 0;
>>> +}
>>> +
>>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>>> +{
>>> +    memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>>> +    mux->num_ring_entries = 0;
>>> +}
>>> +
>>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct 
>>> amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_mux_entry *e;
>>> +
>>> +    if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
>>> +        DRM_ERROR("adding sw ring exceeds max gfx num\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    e = &mux->ring_entries[mux->num_ring_entries++];
>>> +
>>> +    e->ring = ring;
>>> +    e->start_ptr_in_hw_ring = 0;
>>> +    e->end_ptr_in_hw_ring = 0;
>>> +    e->sw_cptr = 0;
>>> +    e->sw_rptr = 0;
>>> +    e->sw_wptr = 0;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct 
>>> amdgpu_ring_mux *mux,
>>> +                struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_mux_entry *e;
>>> +    int i;
>>> +
>>> +    e = NULL;
>>> +    for (i = 0; i < mux->num_ring_entries; i++) {
>>> +        if (mux->ring_entries[i].ring == ring) {
>>> +            e = &mux->ring_entries[i];
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return e;
>>> +}
>>> +
>>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring, u64 wptr)
>>> +{
>>> +    struct amdgpu_mux_entry *e;
>>> +
>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>> +    if (!e) {
>>> +        DRM_ERROR("cannot find entry for sw ring\n");
>>> +        return;
>>> +    }
>>> +
>>> +    spin_lock(&mux->lock);
>>
>>
>> A bit more generic question, I assume the spinlock here protects from 
>> concurrent runs
>> of amdgpu_ib_schedule. For them to be even theoretically concurrent 
>> it must be from
>> direct submissions to HW (because any scheduler mediated submission 
>> is serialized though
>> the dedicated scheduler worker thread). But in such case why we 
>> protect only here ? If i am
>> not missing something there is no total per HW ring lock when calling 
>> amdgpu_ib_schedule today
>> and we do a lot of HW accesses there to ring  which should probably 
>> be protected from
>> concurrent accesses.
>>
>> So if any one can answer this question ?
>
> Well what we have is in general two schedulers which push their work 
> into one hardware ring.
>
> So we need a lock to make sure that only one is modifying the hw ring 
> at the same time.
>
> From the implementation I think we first write the commands into a 
> shadow ring buffer and then copy them over to the real hw ring here.
>
> So this is the only place where we actually touch the hw ring buffer 
> and to need to grab the lock.
>
> Did I get this right?
>
> Thanks,
> Christian.


For the case of the sw ring yes, but I was asking in general, accesses 
to real HW rings, amdgpu_ib_schedule writes to HW rings,
we may be accessing same HW ring from 2 different contexts when doing 
direct submissions (i.e. calling  amdgpu_ib_schedule
directly from 2 threads concurrently) this opens possibility to 
concurrent access to HW. Or am i missing something here ?

Andrey


>
>>
>>
>>> +    e->sw_cptr = e->sw_wptr;
>>> +    e->sw_wptr = wptr;
>>> +    e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>>> +
>>> +    if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
>>> +        e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>> +        amdgpu_ring_commit(mux->real_ring);
>>> +    }
>>> +
>>> +    spin_unlock(&mux->lock);
>>> +}
>>> +
>>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_mux_entry *e;
>>> +
>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>> +    if (!e) {
>>> +        DRM_ERROR("cannot find entry for sw ring\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    return e->sw_wptr;
>>> +}
>>> +
>>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_mux_entry *e;
>>> +    u64 r_rptr, r_wptr, offset, start, end;
>>> +
>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>> +    if (!e) {
>>> +        DRM_ERROR("no sw entry found!\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
>>> +    r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
>>> +
>>> +    if (r_wptr < r_rptr)
>>> +        r_wptr += mux->real_ring->ring_size >> 2;
>>> +
>>> +    start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
>>> +    end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
>>> +    if (start > end)
>>> +        end += mux->real_ring->ring_size >> 2;
>>> +    if (r_rptr <= end && r_rptr >= start) {
>>> +        offset = r_rptr - start;
>>> +        e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
>>> +    } else if (r_rptr < start) {
>>> +        e->sw_rptr = e->sw_cptr;
>>> +    } else {
>>> +        e->sw_rptr = e->sw_wptr;
>>> +    }
>>> +
>>> +    return e->sw_rptr;
>>> +}
>>> +
>>> +/*copy packages on sw ring range[begin, end) */
>>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring,
>>> +    u64 s_begin, u64 s_end)
>>> +{
>>> +    u64 begin, end, r_begin, r_end;
>>> +    struct amdgpu_ring *real_ring = mux->real_ring;
>>> +
>>> +    begin = s_begin & ring->buf_mask;
>>> +    end = s_end & ring->buf_mask;
>>> +
>>> +    r_begin = real_ring->wptr & real_ring->buf_mask;
>>> +    if (begin == end)
>>> +        return -ERANGE;
>>> +    if (begin > end) {
>>> +        amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - 
>>> begin);
>>> +        amdgpu_ring_write_multiple(real_ring, (void 
>>> *)&ring->ring[begin],
>>> +            (ring->ring_size >> 2) - begin);
>>> +        amdgpu_ring_write_multiple(real_ring, (void 
>>> *)&ring->ring[0], end);
>>> +    } else {
>>> +        amdgpu_ring_alloc(real_ring, end - begin);
>>> +        amdgpu_ring_write_multiple(real_ring, (void 
>>> *)&ring->ring[begin], end - begin);
>>> +    }
>>> +
>>> +    r_end = real_ring->wptr & real_ring->buf_mask;
>>> +
>>> +    return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>> new file mode 100644
>>> index 000000000000..d058c43bb063
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>> @@ -0,0 +1,67 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef __AMDGPU_RING_MUX__
>>> +#define __AMDGPU_RING_MUX__
>>> +
>>> +#include <linux/timer.h>
>>> +#include <linux/spinlock.h>
>>> +#include "amdgpu_ring.h"
>>> +
>>> +struct amdgpu_ring;
>>> +/*
>>> + * start_ptr_in_hw_ring - last copied start loc on hw ring
>>> + * end_ptr_in_hw_ring - last copied end loc on hw ring
>>> + *sw_cptr -the begin of copy ptr in sw ring
>>> + *sw_rptr; the read ptr in sw ring
>>> + *sw_wptr; the write ptr in sw ring
>>> + */
>>> +struct amdgpu_mux_entry {
>>> +    struct amdgpu_ring    *ring;
>>> +    u64 start_ptr_in_hw_ring;
>>> +    u64 end_ptr_in_hw_ring;
>>> +
>>> +    u64 sw_cptr;
>>> +    u64 sw_rptr;
>>> +    u64 sw_wptr;
>>> +};
>>> +
>>> +struct amdgpu_ring_mux {
>>> +    struct amdgpu_ring *real_ring;
>>> +
>>> +    struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
>>> +
>>> +    unsigned num_ring_entries;
>>> +
>>> +    spinlock_t            lock;
>>> +
>>> +};
>>> +
>>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct 
>>> amdgpu_ring *ring);
>>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
>>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct 
>>> amdgpu_ring *ring);
>>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring, u64 wptr);
>>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring);
>>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, 
>>> struct amdgpu_ring *ring);
>>> +
>>> +#endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>> new file mode 100644
>>> index 000000000000..452d0ff37758
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>> @@ -0,0 +1,204 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + * All Rights Reserved.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the
>>> + * "Software"), to deal in the Software without restriction, including
>>> + * without limitation the rights to use, copy, modify, merge, publish,
>>> + * distribute, sub license, and/or sell copies of the Software, and to
>>> + * permit persons to whom the Software is furnished to do so, 
>>> subject to
>>> + * the following conditions:
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE 
>>> FOR ANY CLAIM,
>>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
>>> TORT OR
>>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
>>> SOFTWARE OR THE
>>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + * The above copyright notice and this permission notice (including 
>>> the
>>> + * next paragraph) shall be included in all copies or substantial 
>>> portions
>>> + * of the Software.
>>> + *
>>> + */
>>> +
>>> +#include "amdgpu_sw_ring.h"
>>> +#include "amdgpu_ring_mux.h"
>>> +
>>> +#define amdgpu_ring_get_gpu_addr(ring, offset) \
>>> +    (ring->is_mes_queue ?                        \
>>> +     (ring->mes_ctx->meta_data_gpu_addr + offset) :            \
>>> +     (ring->adev->wb.gpu_addr + offset * 4))
>>> +
>>> +#define amdgpu_ring_get_cpu_addr(ring, offset) \
>>> +    (ring->is_mes_queue ?                        \
>>> +     (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
>>> +     (&ring->adev->wb.wb[offset]))
>>> +
>>> +
>>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct 
>>> amdgpu_ring *ring,
>>> +             unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>>> +             unsigned int irq_type, unsigned int hw_prio,
>>> +             atomic_t *sched_score)
>>> +{
>>> +    int r;
>>> +    int sched_hw_submission = amdgpu_sched_hw_submission;
>>> +    u32 *num_sched;
>>> +    u32 hw_ip;
>>> +
>>> +    BUG_ON(!ring->is_sw_ring);
>>> +
>>> +    if (ring->adev == NULL) {
>>> +        if (adev->num_rings >= AMDGPU_MAX_RINGS)
>>> +            return -EINVAL;
>>> +
>>> +        ring->adev = adev;
>>> +        ring->num_hw_submission = sched_hw_submission;
>>> +        ring->sched_score = sched_score;
>>> +        ring->vmid_wait = dma_fence_get_stub();
>>> +
>>> +        if (!ring->is_mes_queue) {
>>> +            ring->idx = adev->num_rings++;
>>> +            adev->rings[ring->idx] = ring;
>>> +        }
>>> +
>>> +        r = amdgpu_fence_driver_init_ring(ring);
>>> +        if (r)
>>> +            return r;
>>> +    }
>>> +
>>> +    r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>>> +    if (r) {
>>> +        dev_err(adev->dev, "(%d) ring fence_offs wb alloc 
>>> failed\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>>> +    if (r) {
>>> +        dev_err(adev->dev, "(%d) ring fence_offs wb alloc 
>>> failed\n", r);
>>> +        return r;
>>> +    }
>>
>>
>> Looks like a typo copy pase duplicate of the above
>>
>>> +
>>> +    r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
>>> +    if (r) {
>>> +        dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc 
>>> failed\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>>> +    if (r) {
>>> +        dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc 
>>> failed\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    ring->fence_gpu_addr =
>>> +        amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
>>> +    ring->fence_cpu_addr =
>>> +        amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
>>> +
>>> +    ring->trail_fence_gpu_addr =
>>> +        amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
>>> +    ring->trail_fence_cpu_addr =
>>> +        amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
>>> +
>>> +    ring->cond_exe_gpu_addr =
>>> +        amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
>>> +    ring->cond_exe_cpu_addr =
>>> +        amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
>>> +
>>> +    /* always set cond_exec_polling to CONTINUE */
>>> +    *ring->cond_exe_cpu_addr = 1;
>>> +
>>> +    r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
>>> +    if (r) {
>>> +        dev_err(adev->dev, "failed initializing fences (%d).\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    ring->ring_size = roundup_pow_of_two(max_dw * 4 * 
>>> sched_hw_submission);
>>> +
>>> +    ring->buf_mask = (ring->ring_size / 4) - 1;
>>> +    ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
>>> +        0xffffffffffffffff : ring->buf_mask;
>>> +
>>> +    /* Allocate ring buffer */
>>> +    if (ring->ring == NULL) {
>>> +        ring->ring = kzalloc(ring->ring_size + 
>>> ring->funcs->extra_dw, GFP_KERNEL);
>>> +        if (!ring->ring) {
>>> +            dev_err(adev->dev, "(%d) swring create failed\n", r);
>>> +            return r;
>>> +        }
>>> +
>>> +        amdgpu_ring_clear_ring(ring);
>>> +    }
>>> +
>>> +    ring->max_dw = max_dw;
>>> +    ring->hw_prio = hw_prio;
>>> +
>>> +    if (!ring->no_scheduler) {
>>> +        hw_ip = ring->funcs->type;
>>> +        num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>> + adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
>>> +            &ring->sched;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>
>>
>> In general i see this function is a big one to one subset of 
>> amdgpu_ring_init.
>> Could you maybe see a way to refactor such that this function is the 
>> base
>> and for HW related code that different (like BO allocation for ring 
>> buffer) you
>> maybe can add if (!ring->sw_ring)... and add those code snippets ? To 
>> avoid
>> substantial code duplication.
>>
>> Andrey
>>
>>
>>> +
>>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>> +
>>> +    BUG_ON(!ring->is_sw_ring);
>>> +    return amdgpu_ring_get_rptr_from_mux(mux, ring);
>>> +}
>>> +
>>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>> +
>>> +    BUG_ON(!ring->is_sw_ring);
>>> +    return amdgpu_ring_get_wptr_from_mux(mux, ring);
>>> +}
>>> +
>>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>>> +{
>>> +    BUG_ON(!ring->is_sw_ring);
>>> +}
>>> +
>>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>> +
>>> +    BUG_ON(!ring->is_sw_ring);
>>> +    amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>>> +}
>>> +
>>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
>>> +{
>>> +    BUG_ON(!ring->is_sw_ring);
>>> +
>>> +    /* Not to finish a ring which is not initialized */
>>> +    if (!(ring->adev) ||
>>> +        (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
>>> +        return;
>>> +
>>> +    ring->sched.ready = false;
>>> +
>>> +    amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
>>> +    amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>>> +
>>> +    kfree((void *)ring->ring);
>>> +
>>> +    dma_fence_put(ring->vmid_wait);
>>> +    ring->vmid_wait = NULL;
>>> +    ring->me = 0;
>>> +
>>> +    ring->adev->rings[ring->idx] = NULL;
>>> +}
>>> +
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>> new file mode 100644
>>> index 000000000000..c05d8a94ad0c
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>> @@ -0,0 +1,48 @@
>>> +/*
>>> + * Copyright 2012 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include <drm/amdgpu_drm.h>
>>> +#include <drm/gpu_scheduler.h>
>>> +#include <drm/drm_print.h>
>>> +
>>> +#include "amdgpu_irq.h"
>>> +#include "amdgpu_ring.h"
>>> +#include "amdgpu.h"
>>> +
>>> +#ifndef __AMDGPU_SWRING_H__
>>> +#define __AMDGPU_SWRING_H__
>>> +
>>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct 
>>> amdgpu_ring *sw_ring,
>>> +             unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>>> +             unsigned int irq_type, unsigned int hw_prio,
>>> +             atomic_t *sched_score);
>>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
>>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
>>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
>>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
>>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
>>> +
>>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
>>> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
>>> +
>>> +#endif
>
