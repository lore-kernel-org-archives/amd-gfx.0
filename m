Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB17EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65B710E05A;
	Thu,  6 Jul 2023 13:43:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7F910E05A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzqTTWS0WmnjD6t+ZN08mT8jIgr/IdJiwZXTUUO8y9OQ1e7XlUC1XLf1gYfadcE1WOXDXg0jbRFZaH5iOAGoixqmzvampLLUGD8AOa9EuxPdCrEqfS3amTLo4+XyRgSfBFL5Bc9XkrcmDYDaihkjHFNiUeaJRqAHRz30Qz1bXBbCOpBJSkcP/4iAP8TfMARUg6fJYMOcxXxDKoAUwNhRf7/6q3lROXB2gE6XiEwZPOvTH9SR3co+iSmeW+zp93JcGk8k449EnoiItptc58vubLBOe980fkFbszGRJJv/s6s6lizR6Qa3LW10NUrFrFSf7Nqh870d8kDX+i6ve1i8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e9cwVnysNT17Yu7aUY8m2qjw+EirxgSFxEFQ5p+gcs=;
 b=M2HIsP9zdIfjJiMPxCiS5zOgodpAb6fQSTyfi7UwbgQ94Skx04/DwaAHmtkSmL2lOqpFFGj8t+PjfZvMCjxUZdmGgQCPTVc7IBG9O7kQEkZMCnOR9UdIzKnoa2F2wQChZ1a7ym22gTON3iCSkXZSvO3QyJWeBEYdgq+ObkmrAf7JzYzIh+gFHk5PYOuWOBdRdPQgIA7TH7/7Xe9/+slkKw4ha3QayaW9IDTwJrVjAbGqsyuPJUa18NwspqkJE1fQFtcDHeVGY5DRfqzp7EFpacz5Dur9tooKA+QLwJ3K+jxR3h6Qg4ZfenvKxat+PKzbkefpJXWfg4LF3e7DIlZzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e9cwVnysNT17Yu7aUY8m2qjw+EirxgSFxEFQ5p+gcs=;
 b=GPHGN/PnSsQXdZ7m7t8GN+IXb0V2w2ZSxooL2LAPJuWHt0oGsJpFv4wj+R21GaW18RKoSEWzIvznbMltLZ1MdHNvCvS9vQom0QC0PBQjqI71Eds0J0sCXq0bsvnIIJlvMAFIum4AeVe6y99Jc79006QSa+7icyi0srY5iLxxfW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:43:39 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:43:39 +0000
Message-ID: <a3b6cb3e-5c96-a10f-d942-ac369d3f84ed@amd.com>
Date: Thu, 6 Jul 2023 15:43:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
 <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
 <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 53203e12-724c-4e54-4211-08db7e270145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CqQghwmIg0RTtKDw19H8wpEEzLjpK3jRoGBBPYtR4CvLgn7ArL7x+b+r1HO3DgmxIJsjnQ8JCoA9NbCvnSqrkjOkoc28ChZvjgXdARxMZQ6Af/Mbo29iUQvMgpN4eZvpV/nv3PRWE9BCt4ZeyjeS1fEU+TQZD701pACEKZ3rAWLhpnXUiNJCmr1ANEpuxllhMVrZIyeDWrzPwSXBj0yq1GOBwRJawjG8k1lVMsfjodthUs3hjUyXmcEhRrr3snpLxj/Hw8AV1JPJsl9K90yJlmHSeeP/vv6ibuwFfE6Pf8GGQndCgLGnX5eegh4kycBhH1HYFGtCGw216l9DwZWIFbwmxB+dLI2J5nirOGPNX/+320FOi4F8Z321+zxxM0cQoiToakzkxKBPuSQt8hnui/jjn2z/QwYfPEv+I3Xu0z+ArZzfK4nyMPK3beZ3GbTJ1s8hfU1WE+nYivTEZvTQZp4yEZohzaypjGpQZ7E4vRFJWUGlh569Lc8C/xXb348X2PU5gARfAsrO0so5C9cjebE22zRawC8HvWQaG39g1IRg0WLoALRnUxll9ShkMHXUhJOcwgO/JuT+4i+PK++ZW6x45lmOFhEB2AaB2AbIHewDA2vt9UDK3gIlGHoUbf9/+QOodW9fJBQUzBkOQQqlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(38100700002)(66556008)(4326008)(66476007)(66946007)(2616005)(6666004)(186003)(86362001)(6486002)(6512007)(31696002)(36756003)(6506007)(26005)(53546011)(478600001)(8676002)(8936002)(44832011)(5660300002)(31686004)(41300700001)(2906002)(316002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RJbkliajMxbHYyZFJsNUpzMUtyUjJXUlBoNnVLMG9RVm9JR2pmMC9YUWRH?=
 =?utf-8?B?S0JoUnZCeHJnalZqSzBYcEFxQ0ppY20xa2l4V1cwYWcwQlVDbDRuUUxyRjdk?=
 =?utf-8?B?dFNPWU1POGIxajY1RGdaeUd1bXRXQkpBOXRjNW9pMWNrSlJtQ2tMbmI1R3Fh?=
 =?utf-8?B?V0JQN0RGK0EyNkxnREwxelZOcDBVK24yY1lMTlg0TFZwdUZ2bEJta0xFRjc0?=
 =?utf-8?B?M1R6R2RtR0UxZkRxbTF0Q1lreFBXbHY1Vm1KWnN5V1QwRWRoTktObndKZkUx?=
 =?utf-8?B?aHo5d2JKdXFXSkkxWTRxanpuRWV3QlQ4TW8vNVJheVptL0U2SW0rNFF3TFZU?=
 =?utf-8?B?cnlueklCN1g3TDdkbCtUcnQvS0hWOUJiZUFXOXRiZXVMdEF4MFpSSG9rcFRu?=
 =?utf-8?B?ZExScno3M0lNN2srUnBJZkZCTkU2RndYanQ0b0ErNHFEZTE5VjZiL2FEZDlZ?=
 =?utf-8?B?Snp4SVNZdkxwS3d5WUVka2dlMVNiZXFScVlYYkxIWlVSOEcreURIcnRFZ2hn?=
 =?utf-8?B?V2wzMEY4Tk9nbHBmL1F1N2dEcVpIVXk4cVRyR2RyNTdrVEc5TEtBcldMYXgx?=
 =?utf-8?B?UEtnV2VSSVVmbElCZTlpd1ZqcU5oOVU2R0h4c28wenJaL0pPUmxqdDNZZnd2?=
 =?utf-8?B?MDE0SHNZdld1SVlIRzdGdk9zK0QzR3QveXJubnhXVnphVFBjTlE3YUFIdmc1?=
 =?utf-8?B?b29EZ0NGUkpOYzdXbld0Z3N0VHFsUHpoU0ZjMFppRjU0Ymw3VzlvL2FrcTY3?=
 =?utf-8?B?Z1R2aUplOERNdnV2VmhwNTYxaFloY04yVVErdzlQNjROSldCUXVnNVUvYUVD?=
 =?utf-8?B?NVhOb2RtdXFlVnM3UTJKc3o2TVVsUWJvdk5JS05YTEtZa1JDOXNCUk5VeDg3?=
 =?utf-8?B?bzBWK3NNNlEwUXpjenpSeXpZYUJOTFgxNVIySWFlOTFmRGhTZ2Nyb0tlbDBK?=
 =?utf-8?B?b3pqZDBNV0RRdFVVUWp0MDFCSDFDWVl0RlNMWTgvWGlhRnhiY1hNZHVPaTEv?=
 =?utf-8?B?RS9yVktWTUFMUWV5ckQ4OUluZm5KNDU3NWp6dm9zYzZ0blVIU0Nuc240cjhx?=
 =?utf-8?B?aC85anpDWmVKK2tseVJIZW93bUxJRWphWmw2YWtqcHdsNUd1djl5dS9teTBV?=
 =?utf-8?B?NlFPcTdDK0h6Z0FHczk0dE14TngxUy8yclBKYVhiNUxzYktVUTZUMitZbkRN?=
 =?utf-8?B?bHlpc0hYUFduOWZvVGJlZjY0cUgrK2hhR2FlV0Nka20vR1lxM081SVdDb3Fs?=
 =?utf-8?B?aFFHSFpOWmZLQjYxU1hEY28rNENaa3pEZlNjZmFOQ2Q5QXZReWl1V0dSUE5p?=
 =?utf-8?B?WS9qVFdnZXV4RkJnZzY4TlZxRUdsRE5McFYvbDBtOWVuK2VRMjlzMXE5TVgr?=
 =?utf-8?B?akdVWVlTTlgrbEFJME8yTUZZcHZwMXRzZWJKL2NYYmN3ZFA5eWVtdmU5cis2?=
 =?utf-8?B?SEoydW9hUUxQSkNsOU5rbkYxc2ZGaTVSTExGMkVXL0tJV24vMjE2cjZmVnYx?=
 =?utf-8?B?ZFpOODZVZXJQajNnVURLRndUbzVlZkF4cnRFQTdjT3Jicyt4bVl0ekk3M25Y?=
 =?utf-8?B?TVl0OUpJd2V3VFBpbW51SGw1cm5nYllYd0NkbU1OYzBEMkFSSURUc3dhWjFm?=
 =?utf-8?B?a0hWWHRRZlR0QUNaYzdCcTBKUTVFay81dnhiVk01NmdjdnErM0tmMkkrWW8y?=
 =?utf-8?B?elMra1NUZXRxTFZSNG5aeXJjR0IwdE5aUkhtVkNuTWR6M3l4SlJGQXoxazRl?=
 =?utf-8?B?YXoraElQQVBLKyt0K2RwRFlXSDI3UmZ1eTdXdHhSVXptN3FDRElkQUdGc1VL?=
 =?utf-8?B?L1gwMXY3Wml2RnIyOFF2VEp0eGs5MEpUWWdYRWdteFN1b2UzNWVZbFQrSnFU?=
 =?utf-8?B?dXY5dDRoWnVMVjBEb2lxSjVWcGFoNEJOajhRNzkrWUVnb2lFdTRScEJoanQv?=
 =?utf-8?B?cFJyMldPYnlhck9oWHNSM3d1SFROOUNzcDBGbzdIeTNhdUVJT2dZL0xkZnFv?=
 =?utf-8?B?bmFnbEwzMGJ3OVpEcUw0dktsREFaZDN6aWFyZzRBSUw4T3BUVm8yYkk5N0ZK?=
 =?utf-8?B?cDQwK05QS2ZxL003NEYvMno2U3hsRTYvZ2VYN1BCcWJZQ1BQSlNlY20xZmNM?=
 =?utf-8?Q?dWpYbCJ9974epBC+OF8qCniNr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53203e12-724c-4e54-4211-08db7e270145
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:43:39.5313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa8tskiJi6GCCAoRQegc2cwhYdxZ1QBmheK1Hw34Paud2SWRVtx1wKmIGF+hPmaO3j0ap4iKqxoZt10FWSFZ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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


On 06/07/2023 15:39, Christian König wrote:
> Am 06.07.23 um 15:37 schrieb Shashank Sharma:
>>
>> On 06/07/2023 15:22, Christian König wrote:
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
>>>
>>> Using amdgpu_bo_create_kernel() for the MQD is most likely not a 
>>> good idea in the long term, but should work for now.
>>>
>> I was a bit curious about this, the scope of this MQD object is 
>> kernel internal and used for queue mapping only, userspace doesn't 
>> know much about it. Do you still think we should not create a kernel 
>> object for it ?
>
>
> Well we should use a kernel BO. But amdgpu_bo_create_kernel() not only 
> creates a kernel BO but also pins it! And that is problematic because 
> it allows userspace to do a deny of service attach on the kernel module.
Ah, that explains it, thank you.
>
> What we need is an eviction fence, e.g. what KFD is already using. 
> Then the BO is created similar to how VM page tables are created, 
> maybe even using the same reservation object.
>
> But for a test this here is probably ok.
>
I Agree, I am working on eviction fences in parallel. May be when that 
series is ready, I can add one clean-up patches in the end of that 
series which will change all these amdgpu_bo_create_kernel()s to 
amdgpu_bo_create()

- Shashank

> Christian.
>
>>
>> - Shashank
>>
>>> Probably best to add a comment here that this needs to be improved.
>>>
>>> Apart from that looks good to me,
>>> Christian.
>>>
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
