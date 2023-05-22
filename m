Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD24C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 09:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C84C10E0FF;
	Mon, 22 May 2023 09:05:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9648810E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 09:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4ZQlLhx6BTzk4ZRfvYe7ZmEKifUjcCy5npt/jh+NuAcugC7cc6T7bTtd6ZufrndGZffYSHfdDgoNb4hC7yTa/N8o7K1Z09PYVbRAJzoRcR9N3Rf+WJcV/882+KymLcv6FzlxDigHf4/2IqGAfMIGMWvYTSHBfq9lhprBJKguvgPQHpn3jJfn6EzeEwUhaxKdSrQO1tolP0h4LBDPoGlyf3WZBMdqdVI2MqbsV1Fwuy0TADpNDsrN7pOOFHPnOs9So2ENTu2g+g3sR4s/btIkkEi/swnK3Z/y/0E3PdzBQ5NtdERN17pOPRXRHvL4E74Q95BJD+Du36fokzTulHkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeWRiGZVLeT6s8xK7TfRGRwkdRWYYmLOO4DGJ2v0mkg=;
 b=i8Y4o1nQCrExyqzcyjCqceU3F2v3W9XTU3VrkoTTCMMnHjcEE7rP/KJFzeyDBOCdJzfTAU+RfO+3JM9FD6ujeyl09j+3QYjIu+Jwhi3U7t016sZS4Su1HQ986lmsucktHKzUbcc84qG+NFPQTO2PPiQV46xzfQm3Gw/eoXTNyFBlxJMGLmuOQJOZu7OqvxA5Fg0sDmYEAy1laIeSGBsPacZ1ulTaKpNikI8vB7y/SIt/LisxQYDA6W7LBlptVQynWW0KEHmf3o4yc5cocLs0JTY6biyQn0Y4ptAp8KLSPtoHYnrwQLpVbJZU+K8CSU1hD8QgHueTHZr4NdvhHlgcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeWRiGZVLeT6s8xK7TfRGRwkdRWYYmLOO4DGJ2v0mkg=;
 b=4diLPyhwEwUAXnjNINEpGT1gkZL9brcBrhHXUzSm001XmXf5n2u4f2F9zd5+s7Nd+bNrCfa5i5y/BWdlI1iOXdE2ehenFuLzbiipALqpYcgi36mKRDA2JRjgoKGS7ARyKc8UxumEWQS40BBrwh7Q7gjfzSgA4C84589zef9Ktug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:05:12 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:05:12 +0000
Message-ID: <5dd79ad6-1c6e-b475-0fb4-9c4b85e1776c@amd.com>
Date: Mon, 22 May 2023 11:05:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-5-shashank.sharma@amd.com>
 <CADnq5_NxpDhaqNaYX8dpQtHV7ULOXiv8=-kf1M9vnAyhprBbkw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_NxpDhaqNaYX8dpQtHV7ULOXiv8=-kf1M9vnAyhprBbkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb02a5d-821d-42e0-4976-08db5aa3a638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrDqqG7j6YP1TY66/1txesjUsJ1EyYzjUj1SvXLnP13wfG8y1p46MEiSH8Fj2yVhGtAK88pcNgWwzEgLOiGVsPUEFmvGP+L7SVn1pob3+raWipSxo2uVv1CXgbVR0OdDklf54hu/rB4+HDMJrRrDn6VJn5GFi0FVOBUOBVKB33M9MDWHBnisEbJTlDI39u2Ue6P3K4KQN5bX4e/Z4116oJRXx84TkFy1pL5pBJpqz5TVGSkEg+xbS59uXykjMchUBjBRNFhQEZO6SThztJSZ83gWbzJ9tiVwOXD8xBg9d2TiMHy3LVxJmezPEl3ev3f1XY37cgTZyyBWbEaK1mZ+Yz/VZ78U/ESCFagON8/sC1TfefMe5RDqU2KQtbDKlrFUpHbxe8FqcY/OohCGBHCIr8x017UDTs6De763b0KygJcmD3I/ImLQdi3kGStz4Kg/vvqKUF9nGdXvI1XAiZ92Pza07D9ia6rxeRReFEvmtKAllymiQizUGwWgbi1RNpxG5SWNMHEHi+mTIO+KBlhulqjDGYqaww6GOdX/hCxcttUXRvApJgW7QxnIv62t9GvxasuyjWjXTuxeOvuOtJI3EvWKUX3f0hjYAVbP8CCVmIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(83380400001)(186003)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(6666004)(54906003)(478600001)(53546011)(5660300002)(44832011)(26005)(6506007)(6512007)(966005)(8676002)(8936002)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVNicGlabyt5QnhaV3hOWElCQXNUR3dXZFNSbmN3bTBheGV6Uy82MldrdVJW?=
 =?utf-8?B?Wmhla1FpbXRqNlc1eDFQdjM0cFppS2ZhK0d4dVlZKzNHQytKYlZnbklPU1l1?=
 =?utf-8?B?L1N1bVY0c3BYRkJsQ1FLcFBZRWlvbHluOTBsQTAvdzlSNVEwdE5zNmhCOGVL?=
 =?utf-8?B?U2lCelo0RHdUM2NYVXB2RE1oNHllUU5xS2k0ejNlNHp3MVJUM2JUOW92WWRK?=
 =?utf-8?B?bnhyZzN4R1MzZkljSUhWS1paUVVRTDQyQzNwd2E1cmNJYkxTMVEvUnlzbHpT?=
 =?utf-8?B?eDBibEhwcFVOMU9QYjdzL1B2aGtIZWpsZVhjWWUyMHZmdEFieEJMSThLLzFp?=
 =?utf-8?B?eUcwNzlQSHhJeFhDUXpGRXJkN1FEczhNVmRKZDRscE5kM3NSaG5Tbm5iVVFW?=
 =?utf-8?B?UmlJMmg2cXhHc0FtbkNEblg3OTgzNG5aRTQrRmYva0plSTZNdExQKzZkTktr?=
 =?utf-8?B?dEhTNllhNzFHZ2lSVlpTWGhIaS9OcjVFbmk4TUFyRWJ3WGdJR1VnYmQ0Uitz?=
 =?utf-8?B?ZGEvNU1qNVpZYUkyNFA3UFpzVDhER1NKTmZ3TXNGMHh2cGM1bG4wYjA5NTVQ?=
 =?utf-8?B?MDMrWE05T29mcklKaitsdGhMcVdrZjhkdjFKaUh0MyswSHg1QitWZTMxdmVu?=
 =?utf-8?B?ai9QNi9RejRrajNQUnU5Z2w5Tk5reWhFMWxGUkxDRXZyUnlYS0ljREoyWEVx?=
 =?utf-8?B?MEFHSkpYenJxUUNESDVCVlhqM3owUVRPUDR3dXQ2eHp3d251Sk01ZDI5TjlR?=
 =?utf-8?B?NmlyRkVMQ0IySmlpeGlxL0NWVDRQUS9HK1hCUWQ1SmFkQmg1VVhZbmM1QW9j?=
 =?utf-8?B?Yzh3RFhwVCtmaDJpd1lyTG0wY1ZGZHFkYzlPOUtlY3NIZnQ5bTVKKytJNUVa?=
 =?utf-8?B?Q0NUamlPZnhRVW5IQk84YnQybnBVWGplYkVERmpPZDlWaUk5MVZHQVJiNGZG?=
 =?utf-8?B?c1VtY2NrV3lsNzM3a1RZbWJ2Y2p1YzFHYW4rVXFmOEU5b1NtUG82RGlNNlE2?=
 =?utf-8?B?a2txLzVmVzN4cXU1K1hRczMrVUsvc2RHYjErUUR5ZHR3V3FZRmpiNzE3ejJm?=
 =?utf-8?B?Szh2M1JWTXJIQXZKRHQrQ1I3elJlVEtUeC9BaFVjZDJTc0JnbzRaU2k0VmVk?=
 =?utf-8?B?YWtHcStTWTRINmlWS3pvY0NUL3NBbHdpMzVTd1lMMzBlVC9DZmFHTkMwRlBK?=
 =?utf-8?B?UjdCTkNUVFp1V0lMckVoUFNjTzVCR2hMU3VWTHZ5UjA0WkNGakp0NlZjR3Q2?=
 =?utf-8?B?ZDhHT1hGTklFUFNINW9SU3NMejZhcVlzM2Y4SEFPdDRxSEJvYUU0eUR0SE9X?=
 =?utf-8?B?dGxBYWNtUE5vWldlaERFRVJyS2UzdU5YUVpXR1RKRC9TTEZMWUVzb21aYy8y?=
 =?utf-8?B?TDlJUVlBaTBXdU5pYUk0cDQrc2RSdzliSFlFNkJOVUhQN2lCQVY5L1JkVmxO?=
 =?utf-8?B?WlorVS9yT1A1alUxWE9rYTcvY0ZzVTBURWVwRjR0eWZ0cHZ1dENudjNWRTFj?=
 =?utf-8?B?NmVNWlUvN0plU0x4ZHVJMWJGMlB4WjFyd2tvaGJobFJMRWUvT3FoM0ZUcksw?=
 =?utf-8?B?WWg5QkVrQWZJa2t6WjRrc3pCS0JrVWh3S3JPUE9heEgzSDZqN1RkOXVKM3Jv?=
 =?utf-8?B?TzU1cTluOThwZXNpaE82cVd5MXp1b1MvamJtbm1QNFYyckR6c3Y1czlIK0FX?=
 =?utf-8?B?eDQ3d2FLeCtrenRqeldEQzBaVHVldHpMSURiUzN1ZTFheG85a1pyV0VGVisy?=
 =?utf-8?B?cTZVRFNLeHZzbWk3UTluWEJzajdoRCtDeUVGYjRrZGlMM0dCUC9GeSt3NDd6?=
 =?utf-8?B?ZG5JNUdPQlpMVXhGbEpZdjFva3pOa0RuaXU1SEptS29sWGR6T24vV0NaTVJS?=
 =?utf-8?B?c2twLzRWUkNJbm9EYUIyRWNNSU5UL2VXVlNGQVdVKzY4WnA0dGVWN092Y2Ey?=
 =?utf-8?B?RUpJQ2Y3aWhxSDdhT1pLR1RyZldOZ1hWVmVjWVg3S041MkhYU3NMQUlqWTFP?=
 =?utf-8?B?c1JXQnVubFlEYjlSNHg1M0huaHB2a21hVEZlVkVob3g2WGd0ODlOY24yTFRD?=
 =?utf-8?B?emtma2wrUkdlVWZpTkFyR0VXbEZETnpKaG1UVXhRbmNiUytMWER5Q2lRb3lz?=
 =?utf-8?Q?oV4oIaplARFxYuveubDpQypKa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb02a5d-821d-42e0-4976-08db5aa3a638
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:05:12.1282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOXtfT+CZO71n0eRPKJ/DtFtjYNZJVvAtJyl8Ai6zC8W01DGbEpyXSvKDHWQ8BXY4srgekWhqMlj/ddk1aMT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 19/05/2023 23:19, Alex Deucher wrote:
> On Mon, Apr 24, 2023 at 1:39 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
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
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>>   3 files changed, 89 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 333f31efbe7b..e95fb35b0cb5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
>>                  goto free_queue;
>>          }
>>
>> +       if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
>> +               r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>> +               if (r) {
>> +                       DRM_ERROR("Failed to create/map userqueue MQD\n");
>> +                       goto free_queue;
>> +               }
>> +       }
>> +
>>          args->out.queue_id = queue->queue_id;
>>          args->out.flags = 0;
>>          mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>>          }
>>
>>          mutex_lock(&uq_mgr->userq_mutex);
>> +       if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
>> +               uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>          amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>          mutex_unlock(&uq_mgr->userq_mutex);
>>          kfree(queue);
>> @@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>          return r;
>>   }
>>
>> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +       int maj;
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +       /* We support usermode queue only for GFX IP as of now */
>> +       maj = IP_VERSION_MAJ(version);
>> +       if (maj == 11)
>> +               uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> Do we need to keep function pointers in uq_mgr?  It would be nice to
> keep the logic in the IPs directly.  E.g, in gfx_v11_0.c, we could set
> adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> then the userq code can just check
>
>         if (adev->userq_funcs[queue->queue_type]->mqd_destroy)
>                 adev->userq_funcs[queue->queue_type]->mqd_destroy(adev, queue);
>
> etc.

We have discussed about this here as well: 
https://patchwork.freedesktop.org/patch/529513/?series=113675&rev=2 
(which we probably could not follow up)

The problem is, in the discussion from first patch set we decided not to 
use adev for this, instead moved this in driver private from fptr.

>> +}
>>
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>   {
>> @@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>          idr_init_base(&userq_mgr->userq_idr, 1);
>>          userq_mgr->adev = adev;
>>
>> +       amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index a56c6e106d00..9f7b14966ac8 100644
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
>> @@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .rev = 0,
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>> +
>> +static int
>> +gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +       struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
>> +       int size = gfx_v11_mqd->mqd_size;
>> +       int r;
>> +
>> +       r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_GTT,
>> +                                   &mqd->obj,
>> +                                   &mqd->gpu_addr,
>> +                                   &mqd->cpu_ptr);
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>> +               return r;
>> +       }
>> +
>> +       memset(mqd->cpu_ptr, 0, size);
>> +       r = amdgpu_bo_reserve(mqd->obj, false);
>> +       if (unlikely(r != 0)) {
>> +               DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> +               goto free_mqd;
>> +       }
>> +
>> +       queue->userq_prop.use_doorbell = true;
>> +       queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>> +       r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
>> +       amdgpu_bo_unreserve(mqd->obj);
>> +       if (r) {
>> +               DRM_ERROR("Failed to init MQD for queue\n");
>> +               goto free_mqd;
>> +       }
>> +
>> +       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>> +       return 0;
>> +
>> +free_mqd:
>> +       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +       return r;
>> +}
>> +
>> +static void
>> +gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +
>> +       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +       .mqd_create = gfx_v11_userq_mqd_create,
>> +       .mqd_destroy = gfx_v11_userq_mqd_destroy,
>> +};
> These functions and structures should start with gfx_v11_0_ for consistency.

Noted,

- Shashank

>
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 8d8f6b3bcda5..e7da27918bd2 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -28,6 +28,12 @@
>>   #include "amdgpu.h"
>>   #define AMDGPU_MAX_USERQ 512
>>
>> +struct amdgpu_userq_ctx_space {
>> +       uint64_t         gpu_addr;
>> +       void             *cpu_ptr;
>> +       struct amdgpu_bo *obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>          int                     queue_id;
>>          int                     queue_type;
>> @@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
>>          struct amdgpu_mqd_prop  userq_prop;
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_vm        *vm;
>> +       struct amdgpu_userq_ctx_space mqd;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.40.0
>>
