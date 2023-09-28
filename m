Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A4AE732C8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B5710E18A;
	Thu, 28 Sep 2023 13:11:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6180B10E18A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 13:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJQ4iMziztsR4NcsD0n97brobZhZsSZ3fYUvNVg8J7yC7oNMwXzg6YgcQzBXqYInTgLOhGxfoyWPZxYFBwjdx+tbhmCnN+EzI6pwAf/Jd/1RsLRT/9np/spYKbxPCsrZwM1Cw0mjAdgmn0DnM6vNnv+SN93fPMtqqNQBbDtdglUV/ejHFHbXnZZm0GAabhsCnq3Hfwu+yYLCN8Mgpe5SFmf3ETd3PndZIwTn8wVobcJTxevw/K+DqNPcI6uhKEMTV1Z0FJ2X1J1w40HJhuySKoLAheYs5Iwr8gGbQZTaW2bKPccPBSL92jXma6t2UhYW8Lib/0XiFE0IYPZuEnxv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpubvPk4blW03WEiC5K2xG7TIA8IbbTYOrkaCvgfxWI=;
 b=mIsMSOAvdilhkWJHnho9Zif8DIY/Rk0Re9QqCYn/i8+oTE3GqP4k95EbO6mCGp0M6jO1/7mldik8xrF6GYFvXET4MQwxO79pNgirOYxbFjDmU87m+rToKuYPbtFN/+SnzihBd0J2XUjimwd+XtUb9lBcKU3CkqxU1iUrjr8zGieK/atY+hEvVZvFEs1bzPvd9fK2HJVmcnNKHmtzLQpxTsDTdI/ejfCev9bcyxNMX9r6thYteMFfbJHO+hvnRrJ7qaYLYNaLAWensIB7mG3V+DnIOo1EimC7k/dfoGWA/+emRoY7xIFtebCewx4bZ/OT2oj4sVJ2z4m7M3U361MtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpubvPk4blW03WEiC5K2xG7TIA8IbbTYOrkaCvgfxWI=;
 b=Ea5TcgFC7FoNNoIKp/0pMb3VQyC9Z4n9xW6vpKk7Qol6ku6CxXFtRJp/a/7TOrEFsLYgMHgkOTfpRpdT8xzONfMh2Y8r3xHwoXyEq/0y3MQQAY0TjLZjYSiNDGVZr+lA1FDTHOlDPx66A/2zIdz/B8deIxxOHduhsL5Z/JLZAEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 13:11:12 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 13:11:12 +0000
Message-ID: <c097f8eb-9866-d4f8-6b18-383dd9b69400@amd.com>
Date: Thu, 28 Sep 2023 15:11:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-5-shashank.sharma@amd.com>
 <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
 <009e90dd-2cf2-9838-a8c3-f18cbbd29b3d@amd.com>
In-Reply-To: <009e90dd-2cf2-9838-a8c3-f18cbbd29b3d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb50dc2-e1ec-49da-a2a7-08dbc024633b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOoTJBtWUhcv9vq08jqlLPLIWMr17YQcgbDKNyRJUNTqHo18Ng9oEyWW9cDlGReeZQlb1sNtF96X7bjmvH+lMXAncCJqHFOsGO0MEAVFpcpv/obv2NpEImWc6gw4OjsXr6A7JJPsExTLbYgvtnu3xURTWEWAJ8SxGpTWGVtbh6C839Jhoe6Qs2UjZC0V5MbKrvL/zkVmx6Pwx2tdsxndQibpPNNflUSTmizx13MyYwKaAPvOI824r85x+p6QIrrzQKaAcBiDcrRojYTbOzFln3Tew0NJxNl+/mfAY6EK1RR4Luhj4kS+54cbBWRft4K/IAgL96Ztu8MkgpSncrpqcvckt6Ery64MtzpkiLzCvqexTQL2FbVID65d9rOdj2XngnVcjdiMPS/KmZFRl76GPzPjw5djhcAFqctsr7VdvIszSm+9hg2xWq7wZM0vi+GqGEPC/bboCYHiFG8swKW7KDIskqAV+lol2sDwvAh0/M+d2QglXN5Wx0euTg+3FyaP2xEDOmYAVxKo//PQeXmPXEDWNhvMRMbXKk/w3LXniYI60xKdcMgWwYjE7P8FY59FKHoIr4HIsluc9hBemXgZyA32iGbOehHrLmgY9TGM5EqGdCSmrrvja4x8gLrFa6VuYnb+Bz3r9DcqLqnO2Cp/Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(26005)(53546011)(6666004)(6506007)(6512007)(83380400001)(66574015)(8676002)(2616005)(8936002)(4326008)(66946007)(6486002)(316002)(66476007)(66556008)(41300700001)(478600001)(44832011)(38100700002)(2906002)(5660300002)(86362001)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVlFeXJqQWlCN2wvaHR0Mmt4clVzdHF1VW1kRHBBTFBMZHVMVGRDeEFQcXh5?=
 =?utf-8?B?ZVFGMCtqQUtUUFdObVA4MFJPUE56M2doclo0U2x2ekZFZEp5VTlEbzBNMTc4?=
 =?utf-8?B?d1F0UVJWWUlLSUt6RHE0b0l5d2xsZkJsT3JLUFRxT1RubmVQbDJhbm5vQ3N2?=
 =?utf-8?B?UStBeUNUSFdiRG5PV0JETWdBeGNwM3VtZ0JSQ3ZhSURjL0hmRTRISitVNVhU?=
 =?utf-8?B?Rmc2RVNMSElvTG4yVUd6YVZkYVlrVTBoSWVVcERMU3JSTUYzSFEvZ2VEaWow?=
 =?utf-8?B?cDYvZnpQeWcxOVI1UVovMUtsWGlTVnZXYTNtWFIxME1SU1h0amxXQ2FUUDdx?=
 =?utf-8?B?dmhJVlpIQ3pDaGhCU1MxWGRneThpWGhtcFlIZ25CN2QybXVlY1Z4VVNsWmpv?=
 =?utf-8?B?emFPZTc2aHFuYTVVK0E4WDFCeGgwTnF4SkFvYVgvRndYWHlEbDBJaHVQdzVs?=
 =?utf-8?B?Qyt5a3ZtZUI3SFc3RXVtY2dURzBoRWdGdXhBU2VXL2dMclpmOU1heW9jS1pB?=
 =?utf-8?B?bDRVSmMycTFhT09WV3FTdWdpL2l2Z0xBWUJnMmF3c0dPQS9oa0pyay9wZXdB?=
 =?utf-8?B?bXk5bExWbDV1RGs1VlBMUUdQN2NkbTNnK3J1WlRqeW92MkFRYkQ2WXFjSEZn?=
 =?utf-8?B?Ry9RVER5Sk1OUE1Ucm1FdExYYkViQUpyYXYvaGRHR0szQ2dGK09NSnpqM0g3?=
 =?utf-8?B?VzY2THJpZEdwb0RhK2hOMy81b1NMSzVGbW5UM1l2d29QNGhzVUc5bEFHZ3Fa?=
 =?utf-8?B?eEFsOWdDK2o0NXphdG0rNW5BNnlnN3AzWTZnSUt0ZGllV0Y0VkNoZU9EcTdr?=
 =?utf-8?B?Y0tkaHJmMW5PN3NCc0dpUHhIbHRxQlkvZnFRa0t4L2JTVWZncGRWazNnMk1G?=
 =?utf-8?B?ZGQ5WW9HQy9oRWNIRGI1THlodmpBdVNMVTIvQVlLaDV0TG4wZStCSnJOYXBm?=
 =?utf-8?B?VTIzTi9TU1ltSCtscVR3Q0FOVitmN3o5V0ZqT2tNOEREcGI3ZThpeDBWM0VM?=
 =?utf-8?B?T3o5UDByRmZjZXVoUk5QT0JHRzZteVdhOTQ4OHA4L2lMd1dPaEJHU0J2UGRT?=
 =?utf-8?B?cVNiMFc1K3h5eWEzOFRDSXNFOVFYMFAyQnF6b2kyOW9qazBoRnFFeTJwTEJF?=
 =?utf-8?B?VlFvWjJreXF2YkFJazVnb2dKbXhXMndUTSt6QW9SODY4cldKc0tQUFFmQkR2?=
 =?utf-8?B?UjVpNnc3VHV5RitRUWRvaU11OVByb3NvbmtCR0ZVZ2NVSDBGQUpiY1BNOEJx?=
 =?utf-8?B?dWNpYjgyM05QVXZGNm5YMVJDT05zL2pPMXhGZHZzd0FIVE5ESVdsNUE2VVVX?=
 =?utf-8?B?QzVkSE5XSUVuQjZPTnpKRENIRlEzL1ZyNGluNnNKVXpRY0RQRS9UV0JqLzVB?=
 =?utf-8?B?WEpza1o5b05ENEZUVFNHck1odkFSMXpTUXNETk15RVdpYUhpTjVOdkZLOXVq?=
 =?utf-8?B?cFlNL0E5QzltTTBVb1VSaS81VWloeTlkODdYaFFNRjAyZzZUcGZpL0x6NCtV?=
 =?utf-8?B?QnNDcnk0a2pkSTZZYmRMSkhrNnZTNSs2VEl6WDVNeTZsdXJPbXB4bFA0ZzZx?=
 =?utf-8?B?MUIvSUhuYjQvcmVsQWIrRWpHanZEQ0c2NjAxWVV3UW1ITUxJcTI5V2ZIT0lY?=
 =?utf-8?B?T2dUSkxIUnAxTEpTTERMZkJabXBXOW9LWno5Rk1wNTFLaENjZmI0T0tFRThW?=
 =?utf-8?B?cVN3NDJ5SERoSEN2UXAvQnlNenpLMzkwY1hvOS9pektKWndwR1BEajdDMytC?=
 =?utf-8?B?akx3aFZkelF0YkliS1dSeGdXRlNCWVZFbDdlLzlQMWRkbFJvdjdsZmFMMlRx?=
 =?utf-8?B?dmN1Z1RnZDIweXYrS0p4eUxONDczd3UvOTBSQjBzM1J5Q2NUQVBqa1pqZHVV?=
 =?utf-8?B?U0I3UVkvWjQxdlNOcnZZOGNvWVNJa21KYXExUUlzSnJLM3VKN3Z0aE9OK2I0?=
 =?utf-8?B?UEhuVWRYbVcvVW9heElJaGh4U3hNdjZwamJaeWtOZGZNeTlGaGVTRURZMXhr?=
 =?utf-8?B?bzJUcUdTNW41bXhUVEZ4U1VKQVRHbURVbUhDRC90ekdiZ2pBVFVDdTVUcnNt?=
 =?utf-8?B?ZXpzWnBqN0szNk9XSG5xeWRYRWJNUW5uSjBVYmZ1NHdqV2VHZzN5Rk03bXRY?=
 =?utf-8?Q?DzO/bQy2Sq3bFTomBoIPgrMeZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb50dc2-e1ec-49da-a2a7-08dbc024633b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:11:12.0651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNlcX7Ya7EP/PVsh8qg00cLoi1b/wP5ba0q6ro5ot2sSDm7RyaatAbM1mwtLazrrYmgU+td+3APMBIEbxfs9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/09/2023 10:24, Shashank Sharma wrote:
>
> On 14/09/2023 09:45, Christian König wrote:
>> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>> the hw's context. As MQD format can vary between different
>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>
>>> This patch:
>>> - Introduces MQD handler functions for the usermode queues.
>>> - Adds new functions to create and destroy userqueue MQD for
>>>    GFX-GEN-11 IP
>>>
>>> V1: Worked on review comments from Alex:
>>>      - Make MQD functions GEN and IP specific
>>>
>>> V2: Worked on review comments from Alex:
>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>      - Formatting and arrangement of code
>>>
>>> V3:
>>>      - Integration with doorbell manager
>>>
>>> V4: Review comments addressed:
>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>      - Align name of structure members (Luben)
>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>        message (Luben)
>>> V5:
>>>     - No need to reserve the bo for MQD (Christian).
>>>     - Some more changes to support IP specific MQD creation.
>>>
>>> V6:
>>>     - Add a comment reminding us to replace the 
>>> amdgpu_bo_create_kernel()
>>>       calls while creating MQD object to amdgpu_bo_create() once 
>>> eviction
>>>       fences are ready (Christian).
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77 
>>> +++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>   3 files changed, 100 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index 44769423ba30..03fc8e89eafb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>>> void *data,
>>>       return r;
>>>   }
>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>> +
>>> +static void
>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +    int maj;
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>> +
>>> +    /* We support usermode queue only for GFX V11 as of now */
>>> +    maj = IP_VERSION_MAJ(version);
>>> +    if (maj == 11)
>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>> +}
>>
>> That belongs into gfx_v11.c and not here.
>
>
> Agree,

On a second thought, we can't move it to gfx_v11.c, as this is the place 
where we are setting up the gfx_userqueue functions in fpriv->uq_mgr() 
for the first time, and we do not have another option but to check the 
IP and setup the functions here. The only other option to do this will 
be to move  uq_mgr->userq_funcs to adev->gfx.userq_funcs and setup them 
with the IP init (as Alex once suggested). Please let me know your 
thoughts on this.

- Shashank

>
>>
>>> +
>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>> struct amdgpu_device *adev)
>>>   {
>>>       mutex_init(&userq_mgr->userq_mutex);
>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>       userq_mgr->adev = adev;
>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index 0451533ddde4..6760abda08df 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -30,6 +30,7 @@
>>>   #include "amdgpu_psp.h"
>>>   #include "amdgpu_smu.h"
>>>   #include "amdgpu_atomfirmware.h"
>>> +#include "amdgpu_userqueue.h"
>>>   #include "imu_v11_0.h"
>>>   #include "soc21.h"
>>>   #include "nvd.h"
>>> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version 
>>> gfx_v11_0_ip_block =
>>>       .rev = 0,
>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>   };
>>> +
>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>> +                      struct drm_amdgpu_userq_in *args_in,
>>> +                      struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>> +    struct amdgpu_mqd_prop userq_props;
>>> +    int r;
>>> +
>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>> +
>>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>>> init function */
>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>> +
>>> +    if (args_in->mqd_size != sizeof(struct 
>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>> +        DRM_ERROR("MQD size mismatch\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>> args_in->mqd_size)) {
>>> +        DRM_ERROR("Failed to get user MQD\n");
>>> +        return -EFAULT;
>>> +    }
>>> +
>>> +    /*
>>> +     * Create BO for actual Userqueue MQD now
>>> +     * Todo: replace the calls to bo_create_kernel() with 
>>> bo_create() and use
>>> +     * implicit pinning for the MQD buffers.
>>
>> Well not implicit pinning, but rather fencing of the BO.
>>
> Noted.
>
> - Shashank
>
>
>> Regards,
>> Christian.
>>
>>> +     */
>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>> PAGE_SIZE,
>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>> +                    &queue->mqd.obj,
>>> +                    &queue->mqd.gpu_addr,
>>> +                    &queue->mqd.cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>> +        return -ENOMEM;
>>> +    }
>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>> +
>>> +    /* Initialize the MQD BO with user given values */
>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>> +    userq_props.queue_size = mqd_user.queue_size;
>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>> +    userq_props.use_doorbell = true;
>>> +
>>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, 
>>> &userq_props);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>> +        goto free_mqd;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +free_mqd:
>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>> &queue->mqd.cpu_ptr);
>>> +    return r;
>>> +}
>>> +
>>> +static void
>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>> +
>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>> +}
>>> +
>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>> +};
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 55ed6512a565..240f92796f00 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -29,6 +29,12 @@
>>>     struct amdgpu_mqd_prop;
>>>   +struct amdgpu_userq_obj {
>>> +    void         *cpu_ptr;
>>> +    uint64_t     gpu_addr;
>>> +    struct amdgpu_bo *obj;
>>> +};
>>> +
>>>   struct amdgpu_usermode_queue {
>>>       int            queue_type;
>>>       uint64_t        doorbell_handle;
>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>       struct amdgpu_vm    *vm;
>>> +    struct amdgpu_userq_obj mqd;
>>>   };
>>>     struct amdgpu_userq_funcs {
>>
