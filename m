Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7208EEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 10:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F3A10E546;
	Fri,  7 Jul 2023 10:03:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB88210E546
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 10:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/PirXt/6fhwI+cwku94FPIUCsMAAIjiUOOUm+8UAuwGatKjDX5aJU0cV83m5P2sSiohdF7pM6yHL5kzh3Uz17XxZwhVHKdoBw+m1vVRXZDEZjM02P3fHSxVGmKIZ/AuKxN3LZqtuh75AY8vnJxwaaJP3onInVhZvTNuiMZqKXIV3YF5kVAWPTv+Xi/+RHskolHmbErsuvHPA6RZycXAwd0EqCqEEpxQ1jVKuTUVyq/91KUJyHemw2h8BvBGoasa2DZmtNiodx8BHILubT+9V8niAeKx6FNw1ssjk/XASqRztAtZ05ROILBsA2uMJUOTLDi3KHK5NlcuUO/TOfML1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+wjd8RzcwUqyJxcm0jXnt8S+0/PDQYO+PRRAoIJ0Ds=;
 b=ecpGgREa4oU1qht6wThCGDVgb0bNZBX7qNxy+B0YdcP81kGSd6nLVbD59EHBPoPspSMQS0IUCfgSjdCeMGqrC+GgPcIpEoVtdGXqkDmWf5/PpC4lPPhW6Ne5R4mmEA5cuxUjmJM8WBAiPgOE3+biYS22HCL+PbA6TEBTDuO5n0T2C658rTFUcmUDWCyTvFCSjntHMxqZ7KD2PMhbYkCjadWiugZfU1KWxP+N30+fL6giGGomv1m/pZeKIHwPQAOsFw/U2nhX/7SWi/cnQ0JNQdRUXxxz0XgJe7juZOkdUM6caqzQk/zAYZ+4hMhOBrwtHfP6yGPlVZqLfwCVPS2YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+wjd8RzcwUqyJxcm0jXnt8S+0/PDQYO+PRRAoIJ0Ds=;
 b=iFCiLyIVE72nL6hFT5NJ47HmcNDMqUUCPW2Vh3MN5XDvQbnKbUSB+xZhq6fp7o2TsGDHZ6o0mQdsqoaCVrSJZ2Nu8g4PMFf2IZnEzS8yVgWyiC82/rHfPxy7ckKpiei27MiJMaQs7ToD3IjknVm4yNnH6wV/E+/D1zQM9MXKkkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 10:02:55 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 10:02:54 +0000
Message-ID: <86f69bc5-cca0-d1ab-4b72-03d0ab7902b5@amd.com>
Date: Fri, 7 Jul 2023 12:02:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <dfd92e84-c51a-82cb-5449-b3bb9c1dd3db@amd.com>
 <21d63938-fb00-35fc-6356-1176c04ccd89@amd.com>
 <06459f04-3030-cf2d-3b77-62bf3dd1f71d@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <06459f04-3030-cf2d-3b77-62bf3dd1f71d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 757d4f18-1d3b-41ed-48a3-08db7ed15528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnYW2hyGvrWocKD7+4BO8GtD46zaWwe+EcOdej7PBYm2RBoyvI2PqpxujXQ0rMn6d82Weyl/aP7BvIwwxZjKs0GKt7z/0p/3KF+gk8Z1GWoKotyvWtUfTD624M/76mgapKBpvbBYxC5ozGAHy+isBuHo1oMZGEnx0xnukJ9p4csID+b2z3O7KtdTtgiEvlF0pI3X9ixDYbTMow+PGM6Z7rNWoZ2XAcmdBIvjIyi81aagiP4JQ0eEshl4dqQVUpfTRsbz+nQH1x3zPvJL3CXWWhuljCDU5HvfFN4Cf0OJJ77Vi0w5bHdq2sRWOIzeBtZOQuJ3NQfqTppkwk0hQiTH3HsrReSIIFt3gcPuLXoLCnPeWea8XKbDfF+BxDbZtuyBlqbThUGr2qK99xqe5kfowrvli9X083tkpb+mHrg3n/hAPn9/vogarjUB52j6uzUD1RK7DvvKZwpvqoIiCr7dUXHBKCEIUHxbyQj7FI2aIjSph+SKLZxhgOO7D+zhtkseiuALKkxL22I2rWT0fxJAT1zrChAgj7jeVFadSyFtZ2DIpCjuggVrSF+0pnjdkbcVKgoBzP9mjtVMiblSS9VlKyRc1QyV7vIgZMFU0VNGJWrOZQlEGAMSX7mCrKH+Tk0Xgfayl8T+TF6Q+23pbhwhsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(6666004)(478600001)(6486002)(6506007)(26005)(53546011)(6512007)(186003)(66946007)(41300700001)(66476007)(4326008)(66556008)(44832011)(5660300002)(8676002)(8936002)(38100700002)(2906002)(316002)(36756003)(86362001)(31696002)(83380400001)(66574015)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xONUh3d2FDOENyUVhObExTeCtwYWM0SUNZMmdVZWVJbjNPSFF6MGNCOXdl?=
 =?utf-8?B?dG9nWWgvQmNKc3k2WHVLRTRudjlOL1UxNHY1QkRLTjFQN3VOODc1SkVCcmFx?=
 =?utf-8?B?NllTcjlSWGk0VGdMV0h3dHlzYnN5U2t2N0wyVWpIeUc4VWVBdEpLVGVxTFRT?=
 =?utf-8?B?V3A2Y3BqVlBheGJIaUhjSjR3R29zZVFxV1ZWYW5RUmlFN0Z4eDJNOGJXYlBr?=
 =?utf-8?B?VGxwVWY3NGsvTFlINUpON1MwS0ZrZ0kzczY2dVg1Mnd3ZGF1aUtYNHMzbVN4?=
 =?utf-8?B?b1Y5Q0JsL3Q0SnBqM1N4YVFtQlkrV3ZiK1lVMjJkNktEYVg5ZVYwQkV5b1Nj?=
 =?utf-8?B?SlJVSnUxNFc4a0pxRXk2b054Qk5KWnp6ZVFVRWp6OUVGejNDQVRkVzhNTU5U?=
 =?utf-8?B?U0xEUnhvUzJwWlVoZXQ1ZjFrQnhHN3lsTVI1YVRzUWt3NEdpcXViV1V4MC9T?=
 =?utf-8?B?WndNWmlhemZxZHZHbUtwV29McnVSV2E2aTN1SnV4ZXNwNThQZmxlRG1iK2cv?=
 =?utf-8?B?YUxwSEM0YUtOYVBnbllOR1BpSXlVeEsvTGJTeFA0ZTNlVXh2VnNlV09KN3dm?=
 =?utf-8?B?QTE3STdydHkrS0VLVnJnMVMyUUREL2hKZDNKc2NZTnBreG43Yk05RXNIclha?=
 =?utf-8?B?REZYMHltK1BlMm5oYVlLeTJYOUMveXhEZWoyaGNVNEZjcjhmc2FheExKeUNx?=
 =?utf-8?B?cUJVUG1UUEVRYi9ZanlEeUZiM0E2OTM1emdad09FM3Fhdy9pR1lNVy9PeGFO?=
 =?utf-8?B?Yy9sS0lUU25qOC94VUR1SVlQdEE0L21TdTJ2SUs5MnBGa05KV3kwdXQ2Yjcv?=
 =?utf-8?B?WDZlU1Z3Ty9zb2pJalY4ZGE5aDk5ZWtpWTJyT2JzUDR4MWd0QmFveDMyM0ZS?=
 =?utf-8?B?MnN5a2hjUzVSY3pZSitPVFRJR0ZHY0Fla1dTZmltODRLTlZNZUZROHJOV3VD?=
 =?utf-8?B?Zlp3VlBwbmc1R2N4SnVzQTExTkVXclhJN3ZJTU1Rcy9ZOTJ1WmhxSDI3cjB5?=
 =?utf-8?B?eHkzNWQyQkpDemFqVmtrTmovcGp3cVFVTnNKalpyS0hRMDRIVEFUT3ZxYTBu?=
 =?utf-8?B?WGE3OUZpWTErVUdYd1ZnZUN3U1cwYnhoNHJyb1FvK1AyTU9LU2RUUXZHSTd6?=
 =?utf-8?B?d0pwMytiTnBpSE1iRHJHbFlMWlJ5ZHVuSWE5QUxhUVRlQnhjOHc5UTYzbVZM?=
 =?utf-8?B?MkVmLzJncnB3N0hEQUtaZi9QcXlXWE5JaUJXcjlLY0tsYS9RMGYvdkF4Z25X?=
 =?utf-8?B?enlXejhQZUtEangycEZ5dnhZdkhIYUxjdnNFRVo4Q0dKS0RHYXF6RWpqOUJP?=
 =?utf-8?B?aWJVWGRXZHJjVkRwTnE3bUFFYzRxQUw3Nm1xZk9IcWI5c1VoRzZBYmZDV2xZ?=
 =?utf-8?B?Wnl6SkpOZ1ROVW81aVpSTFdXbmNwdHNmR2oyeEprczd5dGJJNE1GSzlZSTZx?=
 =?utf-8?B?OGtkQjVmOHZXRWdJV0RrU0F0dUdUQXZiV2h2OFhDY25jYXdWOVhQTGlmeWll?=
 =?utf-8?B?M0V4WkZDeFAyaUZPbU9HTXA3MStuWmdJZmdCN0FlSHI4U3RneFphdnJzRVRh?=
 =?utf-8?B?bmprSFhWV3dWVUxjYytGRlpRWmlFYkZicVVYYWwwdnlvRzBxUU9YcFJnVlNK?=
 =?utf-8?B?SEw2Ti9uK3hvYmNtMTlrSE12Q05uWG9WR0hqUU92VStReG5NQVpJUCtSb1hW?=
 =?utf-8?B?N3BHV0hhSm82M0xUZFFqdE1FVXBHUHZEU2FoS25CWkxsZEdZbUVma0JoQXhN?=
 =?utf-8?B?c3lhL3UrT1RRbEl3MmZOQVQ1U3lrWEZveG9tY2h3dllVaVBUendlSzl2Lzl3?=
 =?utf-8?B?cGNCSUY5aWhzdEFJaFQzd1Znd1BHMzRaN1FyWElZNHM1RSsxR1NqUWJRZEJx?=
 =?utf-8?B?b3kraDFSVEd0blF1MEQ4RjhoSGdYM1dUK29KK1JoTTZNZ3lMV1pOS0Q4TG82?=
 =?utf-8?B?U1hKcU9ieEp1WUhIWitPTTJRNmdUYkF6cHdiOWVrcEI2N0pVYWVRMmhieTVP?=
 =?utf-8?B?UmxuZmNLVk5FVDdZK1JRMkZpZFRTS0o3dVYxeTU1UjVZRjBHZTlpZXhiT2dH?=
 =?utf-8?B?L0JLOFkrdStaWHhwL3IwSGZLZ2hnWXc3TnljcjZzVlZOdUpCTEg1TEd3ZU1H?=
 =?utf-8?Q?yCgVX+0iMV+HdVDOhSe5Er/Lt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757d4f18-1d3b-41ed-48a3-08db7ed15528
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 10:02:54.7625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjIzAoYoJnUNuO6Z8SRYpWLEYq70RY/iL/gYfeJ/ASbcVfg+XCibf4+rD4KsMSjw11RdVrdYsDNC/LNoXccabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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


On 07/07/2023 10:37, Christian König wrote:
> Am 07.07.23 um 09:46 schrieb Shashank Sharma:
>>
>> On 07/07/2023 09:24, Christian König wrote:
>>>
>>>
>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>> the hw's context. As MQD format can vary between different
>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>
>>>> This patch:
>>>> - Introduces MQD handler functions for the usermode queues.
>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>    GFX-GEN-11 IP
>>>>
>>>> V1: Worked on review comments from Alex:
>>>>      - Make MQD functions GEN and IP specific
>>>>
>>>> V2: Worked on review comments from Alex:
>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>      - Formatting and arrangement of code
>>>>
>>>> V3:
>>>>      - Integration with doorbell manager
>>>>
>>>> V4: Review comments addressed:
>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>      - Align name of structure members (Luben)
>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>        message (Luben)
>>>> V5:
>>>>     - No need to reserve the bo for MQD (Christian).
>>>>     - Some more changes to support IP specific MQD creation.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>> +++++++++++++++++++
>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>   3 files changed, 96 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index e37b5da5a0d0..bb774144c372 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>       return r;
>>>>   }
>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>> +
>>>> +static void
>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +    int maj;
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>> +
>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>> +    maj = IP_VERSION_MAJ(version);
>>>> +    if (maj == 11)
>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>>> +}
>>>> +
>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>> struct amdgpu_device *adev)
>>>>   {
>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>       userq_mgr->adev = adev;
>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -30,6 +30,7 @@
>>>>   #include "amdgpu_psp.h"
>>>>   #include "amdgpu_smu.h"
>>>>   #include "amdgpu_atomfirmware.h"
>>>> +#include "amdgpu_userqueue.h"
>>>>   #include "imu_v11_0.h"
>>>>   #include "soc21.h"
>>>>   #include "nvd.h"
>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>> gfx_v11_0_ip_block =
>>>>       .rev = 0,
>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>   };
>>>> +
>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>> *uq_mgr,
>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>> +                      struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>> +    struct amdgpu_mqd_prop userq_props;
>>>> +    int r;
>>>> +
>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>> +
>>>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>>>> init function */
>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>> +
>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>>> args_in->mqd_size)) {
>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>> +        return -EFAULT;
>>>> +    }
>>>
>>> Sorry, I've just seen that now. Please don't have a copy_from_user() 
>>> in the backend!
>>>
>>> This is pure front end stuff which we shouldn't do in hw generation 
>>> specific code.
>>>
>> This is a bit difficult to achieve, as you know:
>>
>> - the whole reason we moved to ptr/size based approach from 
>> fix-mqd-structure approach is so that we can support multiple MQD 
>> structures using the same UAPI.
>>
>> - which means that in file amdgpu_userqueue.c layer (say front-end) I 
>> do not know what is the right size of MQD, its independent of IP.
>>
>> - the correct size of MQD can only be known in IP specific functions 
>> which are in gfx_v11.c (back end).
>>
>> - I may be able to achieve it by adding a new fptr get_mqd_size() 
>> which can return the right MQD size for me from backend IP function, 
>> and then I can move this copy from user to front-end. Does it sound 
>> like a good idea to you ?
>
> Just use memdup_user() in the frontend. Allocating structures which 
> are copied from userspace on the stack is usually a bad idea as well.
>
> Then pass in the kernel ptr and size as argument here and validate if 
> what userspace gave us is correct.
>
This can still allow the user to pass invalid size (0 or too big), how 
to prevent that ? I can still add a check for 0 size, but how about a 
very big but invalid size for MQD ?

- Shashank

> Regards,
> Christian.
>
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> +
>>>> +    /* Create BO for actual Userqueue MQD now */
>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>>> PAGE_SIZE,
>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>> +                    &queue->mqd.obj,
>>>> +                    &queue->mqd.gpu_addr,
>>>> +                    &queue->mqd.cpu_ptr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>> +
>>>> +    /* Initialize the MQD BO with user given values */
>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>> +    userq_props.use_doorbell = true;
>>>> +
>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>> +        goto free_mqd;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +
>>>> +free_mqd:
>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>>> &queue->mqd.cpu_ptr);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +static void
>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>> struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>> +
>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>> +}
>>>> +
>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>> +};
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> index 55ed6512a565..240f92796f00 100644
>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> @@ -29,6 +29,12 @@
>>>>     struct amdgpu_mqd_prop;
>>>>   +struct amdgpu_userq_obj {
>>>> +    void         *cpu_ptr;
>>>> +    uint64_t     gpu_addr;
>>>> +    struct amdgpu_bo *obj;
>>>> +};
>>>> +
>>>>   struct amdgpu_usermode_queue {
>>>>       int            queue_type;
>>>>       uint64_t        doorbell_handle;
>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>       struct amdgpu_vm    *vm;
>>>> +    struct amdgpu_userq_obj mqd;
>>>>   };
>>>>     struct amdgpu_userq_funcs {
>>>
>
