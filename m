Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1A7EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734C810E474;
	Thu,  6 Jul 2023 16:29:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F16010E474
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEl4wFWD71ZDI5n65QB17BwtjCqnR2VdUixEqHu7BNBudAwbXChJomjlDwOCusAYTYdceFvo1iCtnU9CIGmCuu4Kfjbak9aiXpavhMrju6dQkvnnIZP4dBlkM1QSb9+S0/cOhP8m84xiSH9cdGXQHAipqrDKbpnoiBcyy6eWJCR2AWNxBupckiMTWPBKHGLbHHKk2PjoUSFq97lTyX854trMhoYGafQl8D92eCvb3wHbAJOPcthQDNh2sjJsd3hhn93B8SPZBpzZUSTtIynuvrz1PG7Lxbyl298WlvwYsIlR9Mk9qRprm3lAP4/5VGcz9F/xel4W4zaI66DwPuoj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxlLk6XMkIbyT3vADU/8nYZTQO7qe0i2Io/0nVGbsG0=;
 b=OFUPJ8dOJ0SWu4QyR3FBD0xxnJ5AvapeffoCLusMyTcxKBAtAiQcBjwNNlUDV+D6sq4K2Uv9ZeGmjidlG4plC8gKvy9MLuLiMXYkpieSxQ6kyjuNBkTzBchpTsQuyeEaRX7tiG68eFHpz8ysfCohOBkfFBtIZiRc0OYa0vEVyjq2JkWfn4Nh53iLkLIgo+PjoTA9T1Ewyn1/uhnBBuG4ZTLx7QRpQrMiqrRGCVN42IM0Ira9EQlW5REQWIYiVYNBCQZwKScUI9W9WaaSNBSR6Wr3bhLG0RCqVgSoKAXfbV5j7IyNDvWqnjPxKU3HaP4bwUfuOHt3/rwPqF4WPXl2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxlLk6XMkIbyT3vADU/8nYZTQO7qe0i2Io/0nVGbsG0=;
 b=rJLP6Qqc12pS6OJV7K+nhSGAXB9hNhg6yvLbTeq5xKsEuG/IuJEzKf/kfOtSpwwEUfxZ4ioa6WIsJCF/ccL6Sr6OJ9Arc4fUM0fn90N0ifpvBtKrhRxFXatCnEZXjY1k18+yS/0zm6LMMRLOk/zpF1YNq8vLSF9Ecl+8Rlgu61E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 16:29:13 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:29:13 +0000
Message-ID: <dbeb5593-c04a-48f2-0fe3-2c001da80a25@amd.com>
Date: Thu, 6 Jul 2023 18:29:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <CADnq5_Pj+C3ARsG5OwNaF=zv5FAyRnaDHRP8Xdq9WPvBDhT-ew@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Pj+C3ARsG5OwNaF=zv5FAyRnaDHRP8Xdq9WPvBDhT-ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::16) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: c7688a78-1c23-4e82-376f-08db7e3e2228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpuYyHFNpaKqYdNFUHOnTxwqEjtlns3c3u6wM7/fkCSeqFEUn1gWjqP6oadFE7pMEP0OgwylgCemugYhns9Sc67/YP3OhZAtX+1iwg1kLlyhj7PWbaDKftxJgxHy0euiyUyQWhSfz0mGhW6pm/LtmavNUmc+20jgEWY9vrgrY7MB2DEBK4AvQ9VU3sV6/XsG5mGyvaQQN2XcXCUOBAtLUDg4ZM2MaTUKGFrAoZ+GGV7atOpwNvkKcLKGWsJsuVYjFjTfxobitBT8OOeD//xAlIQqPS72A2varQADW0qB3Ojd4L/JrP+zLhgp/fQV/J2BBFrNc61w/k2eW1aehx1dIWqXQp7V0Td+AQtIRDx+6IOUHMNdg79vnxjUujUhq8CCsy+k4xF8EpW+Vjap/5ZEDkoVHtPlbiXPmJ+S7OVRFY5u+v00rT5vG3XKssO018JZ4fI1MP5hacxeoPaKMeT6jOFKM7WajAR+G64jX5trEf/nb5F8H8vmTwrNrk3VNAx0HJFx+TGVucE0BA9hTiXYPwBGFnJ8jheI1o7zE5uXduzHbyiJp9r15lyk01Uvb9UeTYCenCuclU9fujqXtmgs01wsX3+eGRYzavQdMa3chD0DamIVmObIkbP+euW1Z+DJAo/kPyujI3XMCJHs4ljpbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(26005)(31686004)(44832011)(66476007)(66946007)(4326008)(478600001)(36756003)(6916009)(8676002)(2906002)(66556008)(8936002)(5660300002)(316002)(6506007)(41300700001)(54906003)(86362001)(6486002)(6512007)(31696002)(83380400001)(38100700002)(6666004)(53546011)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFURS9IcUxQTDBDQWpJVTNnNjJpcXRubVBNSGVVWnAzbVJGRllBTFFhSTFT?=
 =?utf-8?B?eWJtaVhYaHMzYnRVWDMzVDF4ZWFLQ2JmN2JPeCtnNVRuS1daQXpjVXdsd1Fw?=
 =?utf-8?B?b2s5VkFZbU5USDE4YXJiSVcvM1QwQnQwRnI5VFoyOVFHQ2xjTzF4VWVqOU5m?=
 =?utf-8?B?cE1FSWNzaGx0ZENrMEx0U2E4VzZONTJneG5iSlVaNGR3dXVkN1ZBd25ib3VQ?=
 =?utf-8?B?UFJTeTNGd3NvVDh1b1VPdnRvekFuTzcyRnU1YmQ3cGRVbU50QzBaNVZaMmJy?=
 =?utf-8?B?aTBnOTQ2eng1SGozbFIrZWJSQW5tUzhQbUJRcXVlelJGSnNLckpBYm5MdlYw?=
 =?utf-8?B?eWRUNGJ4YWl0Z3hXNW5PTzdGN0lwV29POUJ6bnB4WEJCRVoyLzNrOC9oaUIr?=
 =?utf-8?B?ekwxUjg0N0tHZ1dZQnVuMVVtMXhyMEtybXVPR3BTT3lQNkU3d2l2dXJKWFRo?=
 =?utf-8?B?aVlsQjZkYVllRjhHY3QyU2Vnei95VWRHVC82YUpFd01TL3AwMGlDYkt1Ny9Q?=
 =?utf-8?B?ZVJvVEo4NzVZNGJLNlRHREhNd21EeVhUUnZwM1hwSGNsZDd2L0FhUk9XMzRP?=
 =?utf-8?B?REZKKy83MmE2NHlhcEgwcXdrak96ZXJZRUdWWEpXSGtlUlNITGJtNTFGbGFK?=
 =?utf-8?B?TFkzSzNleU90WVVFYXlrWXJpN1l6RXZmbzlzM1pRcEErbHNGeTh6VXRacWxX?=
 =?utf-8?B?aVE0V3lwd3JaUUVUc3NUY2xsVzdKVERNM1doL2RMUk03RExPOFJ2ajZyNDMw?=
 =?utf-8?B?TnQ2NERmbXA3MjNiZXBhWDM1U2ozRzZKQk9IaGcwTndjbWxKc2FMWUczejd6?=
 =?utf-8?B?K1orQUxQUkR0WU0weDJIQ2d3OEo4V0VaMmFIL1BRMlZ1V25GOUZ4cUJXaTNT?=
 =?utf-8?B?T1EvZHVlNk9BdC9DZnhaOE1DNHhmZC9aUVdiUFJxc0Nod0VIc3NIc2xtcUkz?=
 =?utf-8?B?aTdvTTRLa3hhK2ZGaklSTjRPNWtLR1RzNitZMm5UUDBGdkZOZGVzdmhxdzdH?=
 =?utf-8?B?d0V5U1FaWVluSXhrZHoxb1IzTWk1T3VPbkpadk1vWDBiVFUrQTBmYUthL0Ur?=
 =?utf-8?B?b1JxTEd2ZGcvdmZCYWdsYnBDT1NsUFJWUWxnWVVhQjN2UjA1Zy9RZDh4NnIz?=
 =?utf-8?B?cUlQeFZ5VHlaNXZwd1pMeno2eThQQkFCdmxtZ1hOSVlPRFFONmpwRC85Q1pv?=
 =?utf-8?B?bHhXdk1wY3MrNzZGV0NwQXIyeldIM1RCVlFKeHc1dEdKQnpZRzUrT0ZCN1o1?=
 =?utf-8?B?MVk2eDFaaVozZURsNnFyWUE3TUVaeGtaUmluTTFOc05NMGk1VE5xMUthYmlM?=
 =?utf-8?B?b3JtcmR4MEQxeGpMdGE2UTVSQzczWjhtTGF3elZtQ3kvZUNXOTlDdEh0Q1hG?=
 =?utf-8?B?VEplcU1NbFkyTENLcmdnancwRzB6UjJYczdScUxSc1RRS1pBZHNzbDhJRkgr?=
 =?utf-8?B?TVdwSit0bmhsSFg4ZksvR3ZXdStRMW5HQW5hSzZOQS9NNlY4NXFwazIwam1F?=
 =?utf-8?B?cGdYY1JHTDM3MEpmSENETGVYNzREMnBHLzhHMGF5TFkzRWpWRWs0bUd6cnZk?=
 =?utf-8?B?MXZ5NkRJN1FCS1R3N2drZHBxU2wrT1p4aEEydXUxWWQ2QXd5dTkvL0xpUDJF?=
 =?utf-8?B?K2dqNjhlWWJyUW53Vm1ZRXQ5TWpWRTgwWnNPL3IrWGNRajhNT2hKVnUxQ1I0?=
 =?utf-8?B?Z0t1aTBZZkFCQ0pTcFdnZnJadkhGR1RKd0NCWk5aSGJXbkQxZDRvMEZBWlVm?=
 =?utf-8?B?SUJTbHpUa2NCQWwvQkJXUlhOdUJkYzVpSzZEaWVIT21iVlBLUlBNM0hQZVNi?=
 =?utf-8?B?a0dnN3RFU25kWlFPMHdrY2FJcFpVMk03cGhNK0dDTTdaYlpkUG1ITlFaaUJH?=
 =?utf-8?B?YTFhK0N0VUlIaWdBWVFhR1J6MVQxcFc5TFRpZGwzUllHQXp0S20vL0RXNDd1?=
 =?utf-8?B?WnhnTUdZODA4Wk05aVVjNW8xN1A5aUhXT3JReEpkZG8zeG81WlBMRnFwcE8x?=
 =?utf-8?B?R2xTV3lMcjF4QkdzNnBUSUVkR0cxSUZpVW9WOXdrZ3VPT25hYU1TL0RWeW5a?=
 =?utf-8?B?TjR3b1g2aHR3TGs2RExWSHlZRGRDZ2l6NkR4YmlJVFJyVENBc3YyMldtSWRI?=
 =?utf-8?Q?2hi0Xm1YXVr8Xoo76cytvZ9NE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7688a78-1c23-4e82-376f-08db7e3e2228
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:29:13.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4lwZ05jxXf5AT7EjBVweqW+A5VibNsUOggEo0nRNdAEdFlFMnnstqHwzU+ktdFTFSghRshR7/DCWcfsuTY8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,

On 06/07/2023 18:27, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 8:36 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    GFX-GEN-11 IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>> V5:
>>     - No need to reserve the bo for MQD (Christian).
>>     - Some more changes to support IP specific MQD creation.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>   3 files changed, 96 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index e37b5da5a0d0..bb774144c372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>          return r;
>>   }
>>
>> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> Just add this to gfx_v11_0.h and include that here.
Noted,
>
>> +
>> +static void
>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +       int maj;
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +       /* We support usermode queue only for GFX V11 as of now */
>> +       maj = IP_VERSION_MAJ(version);
>> +       if (maj == 11)
>> +               uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>   {
>>          mutex_init(&userq_mgr->userq_mutex);
>>          idr_init_base(&userq_mgr->userq_idr, 1);
>>          userq_mgr->adev = adev;
>>
>> +       amdgpu_userqueue_setup_gfx(userq_mgr);
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index c4940b6ea1c4..e76e1b86b434 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -30,6 +30,7 @@
>>   #include "amdgpu_psp.h"
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>> +#include "amdgpu_userqueue.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .rev = 0,
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>> +
>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>> +                                     struct drm_amdgpu_userq_in *args_in,
>> +                                     struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
>> +       struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>> +       struct amdgpu_mqd_prop userq_props;
>> +       int r;
>> +
>> +       /* Incoming MQD parameters from userspace to be saved here */
>> +       memset(&mqd_user, 0, sizeof(mqd_user));
>> +
>> +       /* Structure to initialize MQD for userqueue using generic MQD init function */
>> +       memset(&userq_props, 0, sizeof(userq_props));
>> +
>> +       if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd_gfx_v11_0)) {
>> +               DRM_ERROR("MQD size mismatch\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), args_in->mqd_size)) {
>> +               DRM_ERROR("Failed to get user MQD\n");
>> +               return -EFAULT;
>> +       }
>> +
>> +       /* Create BO for actual Userqueue MQD now */
>> +       r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_GTT,
>> +                                   &queue->mqd.obj,
>> +                                   &queue->mqd.gpu_addr,
>> +                                   &queue->mqd.cpu_ptr);
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +               return -ENOMEM;
>> +       }
>> +       memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>> +
>> +       /* Initialize the MQD BO with user given values */
>> +       userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>> +       userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>> +       userq_props.queue_size = mqd_user.queue_size;
>> +       userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>> +       userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>> +       userq_props.use_doorbell = true;
>> +
>> +       r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
>> +       if (r) {
>> +               DRM_ERROR("Failed to initialize MQD for userqueue\n");
>> +               goto free_mqd;
>> +       }
>> +
>> +       return 0;
>> +
>> +free_mqd:
>> +       amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
>> +       return r;
>> +}
>> +
>> +static void
>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_userq_obj *mqd = &queue->mqd;
>> +
>> +       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> gfx_v11_0_userq_funcs for consistency with the rest of the file.


Noted.

- Shashank

>
> Alex
>
>
>> +       .mqd_create = gfx_v11_0_userq_mqd_create,
>> +       .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 55ed6512a565..240f92796f00 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -29,6 +29,12 @@
>>
>>   struct amdgpu_mqd_prop;
>>
>> +struct amdgpu_userq_obj {
>> +       void             *cpu_ptr;
>> +       uint64_t         gpu_addr;
>> +       struct amdgpu_bo *obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>          int                     queue_type;
>>          uint64_t                doorbell_handle;
>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>          struct amdgpu_mqd_prop  *userq_prop;
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_vm        *vm;
>> +       struct amdgpu_userq_obj mqd;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.40.1
>>
