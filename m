Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB9EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F0F10E3FA;
	Thu,  6 Jul 2023 13:40:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBF510E3FA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amdCtXz38KGKXb10o+wi9wX4+6W9bTQlQGwYsFuXM/XwH7QODE14MvPaUjTlLxN9zIV/UWmXfMniytcTqrvYIIX/XsHJFPSDcvKJy6h8MOF5MslPunWWUJbRdWkxZ+qeIG/cxYpG0/lq60tvANRYNYj64YUaFclv/ndeuwRU6LB0GiA7igkzRfx7vzP94BQKUZEc4zO16eQNT33eruPLbl3RfuhCS7bkmG7ILnfpXV+mHISPd4u4Rkma6i3wsolFW9xW/k0xj+izaFyPp3F9MTsHhKfqzMq8mG0GGUlV9xVDrukcRnoFhJPXsC6lkRA+IqEzB8p3q1I7RcwdGltgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+9RRbID9BXfuuFcxe3iAuolq6qmC8ck3rhWrekGtKs=;
 b=VbKL54V9YIYOq9dgs185WhG89ipEHnAfEFTSVhdPfLOTXIQaSg7z+oGOPa73FLoGNFD41U6LMzxFeZ6ZOB1yxNDZf+Od4CU1E7os+KTW60BNpm6gP+ol9v+wVFLlZ7/X17nXhCwBlgOJQI/eIOLK3fehkRgqoXXFdB4REnYeJNw1rALAllTc/0s0vDEmpvmZPUcvavqRtG7E4DNOpraP25GjRzk4SotKhtH5cp1SqkjpnTDFN5xt5x9dvZzazre6O6ndnrqK+H+yS46PInkrnMKoolRR8ZC/lg44LK4TTi++PF7jQ11lvk+ZPU7QzbqcDd8GIf6pxUhbZDxwigOp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+9RRbID9BXfuuFcxe3iAuolq6qmC8ck3rhWrekGtKs=;
 b=VOSWHyn2sFuILVM290K4Unu66fkgMnsf5XQGDUj4qQiqeObjwAW52yk5uqnNIAZ4Hz26E0ZYBmL/ei2qYkp7v9rp0YG6Uw5+tWUY8aw9NDjfrafdMOmVJDkn1rnnmPnES39VCrPwcs2TSuuOQVfT0PpJRzRFVMxo3QAcwDhCgrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:40:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:40:04 +0000
Message-ID: <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
Date: Thu, 6 Jul 2023 15:39:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
 <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: c16cd6a8-fe44-450a-fae9-08db7e2680dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpbwcEhgH4XGvM0+n8yQbSb9EoeW1qLzV1I31emZL4Gw0SUhOPQtFzJhVj2GXooEN1WmR3zXHH07Nvx66TwxoKw+1WIRqdpu69z4bIvwgVjRowlgdWhLoEvyEMGzA0IqFdAQQqiQaYVIYhv/J6ldaE2x0xmfg8AkddiIvGV9uAx26+uoBM+Tw5TV9ycOtyxusxcbHSvaxOVS5BKgYoWKTTEWWxTiFJ7v9q2H+GM6Zm34J24HKLGMjphHMAgP+tVlBzHaOmvIC2fhy+RWkGLCIMpjLrvnMLXXbmsNaTjf/AKP1XxTIHDvwGmVj8LnxIBo7Wc7RG/q1syfEti6ogY3xeSJehu1UvxEOjet6riXHNW//lo3oNvsgcQyyu3VJs+WjAjJYgAlbvhXfj9kv6TaNJoK6upH952IyMRhXouhYo0V4LNTrFZ2NdZ9i9SEkdCauLZuTiIxA9kW+TDsA2iEs1bbaFihsazfkLUoABEAeGATcIvv0x3q3E3XscduVaff9lcedcyfK8d+7VNozfzYzATBao9PfzTXsie6PPP2HVGo8Yxd0I5mmK05aQrwMQOb7I0BdPYDFesD4fIXQOvXJlIjvWInh33x6sh0N7IuWXATOhry4DY0BnPBo8fKfkCNIOb9wqx157lk742lH4RvWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(6486002)(6666004)(478600001)(83380400001)(2616005)(86362001)(31696002)(36756003)(31686004)(2906002)(66946007)(6506007)(53546011)(186003)(6512007)(38100700002)(66476007)(66556008)(4326008)(316002)(41300700001)(8676002)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hSSjBGSzZQbFRJUGVQYk0vYmcwYzlkdU50ME1JVnhwTU9HZ21VRktoZ1dl?=
 =?utf-8?B?R3VyU0NUdnVQTHdZUUR6YkdzTWxXU3BYVExQM1ZDTUUwU2h5LzdnSUU5M1Qv?=
 =?utf-8?B?dCtHTjdVU1NTdW9JMGFITlBobzZ4TDRVd3FBZTUrY0hBaW1LZldWOFJpclhz?=
 =?utf-8?B?ZXdSOS9ZY3JtRklxNkFaMHJ0TkgvUTRvNlpOZmt3UlpDUm84SUtiNTlhZGFK?=
 =?utf-8?B?QVpsYTNlanNkeGYxcXd5dGU4alk3Z3pKRU1qak5sQURGd1BDaGU1VWFsRE9X?=
 =?utf-8?B?VlJsbWlpR2VNTU45S2dxVm4ydVQ0Q1BoS25Pc25xS0hrN0p1WkRqM0RmaFZj?=
 =?utf-8?B?a2Y4RjhrK1Jzd1NwSzZDUlVhaDFJL1RESnBDcDgzOURJY0h4WmEwS0RGUnNl?=
 =?utf-8?B?cVBZeWtSdVF0dDArTCtRbXVSY2tsSkpjVXJoWVQ1bmpYaUFHV0ZobE1sUC9r?=
 =?utf-8?B?U0VjRkhLdUlOcWRmczRBaVVqb1gzTnMwWnFFclh1Tmw4QitXUS9kUHlnem5l?=
 =?utf-8?B?KzV4V1VrSVJsTDlyQ1pDTGdZTEdodWRRY0FRcnl4UldmUnZXcld3a1JiZFlW?=
 =?utf-8?B?Z2Jyc1lHWkh6L3dpWVhTNGExaGVQSTZBczljMDdiSDl0ZC9VRVNhWjRiOTFK?=
 =?utf-8?B?aUp1UGR2MjF4bStSSGFkRldwcUhjbW9KMUdjR0VDT1Q0RE5EdUY4dXQ4TDRS?=
 =?utf-8?B?aktjMXg1N2pPWFJ1WkZ4ZW1BK2tIU2ludFp1VmE1S1BZdEdxZWVpWVA4SGdw?=
 =?utf-8?B?OHdkc0pvVWR4bTZYNjhtenZ0Zk1FM3Z4NzNlUmd4VnhBYTdvWnZFdGRIRmho?=
 =?utf-8?B?TlhFWW0yOW14RnJlOU91SGR3UnAyeHdRV0dibU1pRS9TeHp3ZEI5Qk4rMzNn?=
 =?utf-8?B?MkIrTFBaTFJUV0ZoWVZZTnlpelhDQ2d4UjdQeHpURk4vUDhuMWhXSWJ0M2N2?=
 =?utf-8?B?WmFWL3laWU5TSUYxTnhhb2dxMmNQKzlHb1ZxbGtUQ0VFbDhpZmNqa1Z0eEZQ?=
 =?utf-8?B?dHFva3c5dllSSWg4VU85TXJZTnlma3QyTHJnUmFhT3dSbVJrWWp1My8zRzV3?=
 =?utf-8?B?YmZyaHg5WTdOTE9UR1BGdk5jNmlSVWFqdTBnMXE1RThPTlErZ3ZyNHJCbzlz?=
 =?utf-8?B?TStSYkpqY1VJQkYwb1NIWHEwRmJYUithcG9MSnFKVWcrMkNyL3gwL3lEdWtI?=
 =?utf-8?B?S3FmUGJaeUhaWDVzZ1FVdk5hK0M0UU5nc0NXVFhYakF1aVA2aEhXeVh3OUtF?=
 =?utf-8?B?bzJUQ01TNEJRY2h3RWx1RGg1dEFXV1JRUS9OT1hZSjhOZXhLRGcxRWhDUENy?=
 =?utf-8?B?VTVyWUxPTXVYOFpnTCswVnArU2ZyUHRJcmlKV055M0p6aGtjNzNSOHh4YU1U?=
 =?utf-8?B?VVIzcXpKVXlFSzNqMFhPbDBxdFhJNG80ZGtpS0RvOTlvN3dya2tXb3YxVnNw?=
 =?utf-8?B?Q1g2NGxCMy9wcVlWL0xCenVwRzQrbWJXWG0vYUNxcWZELy9GVnZIQ3RiREdT?=
 =?utf-8?B?SktuQlM3ckp1SmtuZmVTR29wZ1pYSDZrU2tkNkkzUE41MnowQnhoTGpDek9J?=
 =?utf-8?B?OTlQdVdtb1F4SFAxclY3UldxUkhyRFc2M1NzditOaHFXdDQvcE5BUnRmemJQ?=
 =?utf-8?B?YWFWTE44MmtLNXBXU3E1RDhCWXRHSG9iY1BKa0pta0hNN1F0RG8rTmU5NGhQ?=
 =?utf-8?B?RWpadXk1S3pYRVl3TklQOTB2bEdPUXRHN1A5K2gwK0hNdmJ0V3c5b2tOK2tr?=
 =?utf-8?B?N0FXakRDK2dTWTZRc3BKc0ZCVjhZVndaUDF0SGplNEFaYklsVk02MG4xUjI5?=
 =?utf-8?B?ZXRGRURYYmRwbVBjWXFXdTYwYTI0b2JLeE91M2I1YVYvYVNNbFJsUFZiMXZR?=
 =?utf-8?B?RnZ6Y1A3c1pkVUZaajd0QkVtNmV5UWptUzZIN2Fub3A1bURNNEVRVm03dlZJ?=
 =?utf-8?B?SGszN1JKRERaKzVlR3BHU3ZYcTZ5KzhFZ09kUlE1ZUk3aTBDcmZQN2prVzBR?=
 =?utf-8?B?ejM4S2pmZkI4aVY5ZTh5SGlvUzNEWlU1WEVBN20yYW1jbWN6VDNsbmw4eUVV?=
 =?utf-8?B?V096WmxJSW1lK3JiUE1xdTRnNFM4THhaWEwvWmpyZGlFalk2RVRZVStzT2lN?=
 =?utf-8?B?Ukxubk5ZdTlCTjVYSzN4a01oanl0SERONjBscWczVlhQTWtLeUp3b0xTbHBB?=
 =?utf-8?Q?VWXlp/RCYT4z+SXGTm9URn/RfQl8aaZsZTBH0Y5Ip0Kb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16cd6a8-fe44-450a-fae9-08db7e2680dd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:40:04.0488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whq4V33LDvIRsqr9fuxPi67LhLT8A2UyJljkyqW9un6a4T0EUVJY71pqJ/TmuUZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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

Am 06.07.23 um 15:37 schrieb Shashank Sharma:
>
> On 06/07/2023 15:22, Christian König wrote:
>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
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
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>> +++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>   3 files changed, 96 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index e37b5da5a0d0..bb774144c372 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
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
>>> index c4940b6ea1c4..e76e1b86b434 100644
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
>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
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
>>> +    /* Create BO for actual Userqueue MQD now */
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
>>
>> Using amdgpu_bo_create_kernel() for the MQD is most likely not a good 
>> idea in the long term, but should work for now.
>>
> I was a bit curious about this, the scope of this MQD object is kernel 
> internal and used for queue mapping only, userspace doesn't know much 
> about it. Do you still think we should not create a kernel object for 
> it ?


Well we should use a kernel BO. But amdgpu_bo_create_kernel() not only 
creates a kernel BO but also pins it! And that is problematic because it 
allows userspace to do a deny of service attach on the kernel module.

What we need is an eviction fence, e.g. what KFD is already using. Then 
the BO is created similar to how VM page tables are created, maybe even 
using the same reservation object.

But for a test this here is probably ok.

Christian.

>
> - Shashank
>
>> Probably best to add a comment here that this needs to be improved.
>>
>> Apart from that looks good to me,
>> Christian.
>>
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

