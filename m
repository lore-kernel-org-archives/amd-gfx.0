Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C9EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 12:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE3C10E57E;
	Fri,  7 Jul 2023 12:46:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0201010E57C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 12:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2WOIBRSDFs2hQtESpgmW/2QfXCuqiHJ/wGNT3rJ5bqZrWyacjSwdy2r7RTkxeUhrvW3ndswy5WGursNW8rD0grwyeaRSYGaoyy8mjDZ/Hod5gZT9R5/bKg7Jy4csS+aJEF7raMfS4h7U0v0q7P1HmSTnM14AEKDRtrG3D3+q3efhmDA+JmtEEtoKjCjecn3vAanX0qF4yG0vlbz8KK2I2A7yfRU4Ch2zwqx5HphUBK2c0LC2ujeloCUFmk6fpk7ZdDfJWfO65gs/HDqA+72eX/nQdqMbFmWptHTHgrjzD4gcWLlh8VqSiKs/1IozdQNWcDOrHflYHpQDCT8Ms+PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgsK14BlQTmVfqDJgj8KEHuptwTwzA1GTE0ErS/djag=;
 b=SOWmrfpQZIGQ6AHLhIcehQQX1M6CwsSKfoqfKdBCTt3jU9yTa03zHBKsbYkdugezGjVFd7tYqrzudWIDlCnzFnJ00npMGyIbm3Tj5hNiXT/fwsXiECikf7SDaFWW9BLnZkiBmrnLgz3gvw72Yzuep4i7nhMae196R0Seyqi5hMkWX5Y+po77GkA2Nk7dG1jYm/yrCUUA+/UywgvbnELQXkOhh3gprWh0dJ+92aZKvc4JdKOdvgU+9A6PTB2hv5LmEgkSeyJZpt+Pg+HObfSGJrZm293zMC0iCHhlf8ltmqG56Kn1h3rjAEP/ln6pR2eCpXzZs/83kadt6rndQyVy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgsK14BlQTmVfqDJgj8KEHuptwTwzA1GTE0ErS/djag=;
 b=PSCoUR6khtYnSd2fH+OGadrRoYEm21um8KmWxL5/M+ReSqyflv5P9CuJnYomaElmbC6eCDeSgkCuPSYIMeYTwIJDycqNksC6effWmEXBaQ9RIHBOtFa6Mpxsfvx3Pkew+9qO1Ws+o9cunR22LfFUIUhoql9CVf9SDJ+CY3TCQ8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 12:46:17 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 12:46:17 +0000
Message-ID: <94c84a36-7b3f-497e-8bf7-9a58efe3002d@amd.com>
Date: Fri, 7 Jul 2023 14:46:10 +0200
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
 <86f69bc5-cca0-d1ab-4b72-03d0ab7902b5@amd.com>
 <e06fd18e-aa43-9d1f-ec4b-4dee978ebdbf@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <e06fd18e-aa43-9d1f-ec4b-4dee978ebdbf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BEXP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::18)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 259771e3-7d48-4957-69b2-08db7ee82806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxZgnJejynIZpc8iJoZEdBrgujbnyXosQkEWaVMuyVXifhLiomqqOALFucYZKzk3Vb3PStkijU2KxiVp+XG/Gzrix7+OooBEeCgx91uhDL25A53HhgeV911ArWf6BDyiHNKeZOKnW/YrucpM55aW4+9gtZxrWz0tNnPCyHPVKqyJ2qT2RL5HPD0YQgp7RfnkHY7+ArEbNyIt/b22BocECgRapjB8V9zxeuV/lxEM4DkDpu+vwGTCQT/he/Z1wiylb6iSsHxtK1boOjVPmOWV4enM01MqOQFJM/yIIa8OjC70TmynpZxfWdKszmmLRpBRPZbjBisrIgaEkbMuh20oaRvqIkt4MJaKroPmK4voWT4hORTVyPGQSOoNHXxGS40EsmiCbDF0RBulLEACxebbr802BETep0kcLYj1W3XWnAt9/RYiDkmSscuxxnSEioG/5v0r/Ujr6PESeb8Tf9oqwjR6FE8vjYoPgxtli8E8gWIqLDaylMsoyYPBqRWxwVgAKFhKkT/RbYH4042KAY1AQ9dT0wtjDAUj+mlnManVhbykInCAdslRPa5NxbvnxpWsu0FfMNJcVFI4J49HjTboupezA+Vwv4X55Hku79akMndIEj4oj+gjXHuue7EPa63sjQFoWZBkDYaqpbfm0hhrHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(6486002)(478600001)(6666004)(83380400001)(66574015)(31696002)(86362001)(36756003)(31686004)(2616005)(2906002)(66946007)(26005)(53546011)(186003)(6506007)(6512007)(38100700002)(4326008)(316002)(41300700001)(8936002)(66556008)(8676002)(66476007)(5660300002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytmM2RuVHV1LzR6TDdMczU4Wi9QbzdYa0MxUjBHZEd2ZTB5ZDhFSDVTL0J5?=
 =?utf-8?B?RlIzeXZZd1R1czJqM2hYS0ttZFBUQUVtcTRyYlpiQXRjcG1ZQ3JuSFQ4dU9j?=
 =?utf-8?B?cU45WXJwSHIzVTVZTW1TZHlZWXBBVzhOdVNtalBEQTZYMVp6Ni9BZSswSk92?=
 =?utf-8?B?Nzl2bGx6WmlocjAxYUlFVFBkbks5TFYwQXQ3eGZLQ2JqWGcrNlVBdkFmV25S?=
 =?utf-8?B?L1UxNlBqajl4cUI5RUFyYjMzWHlZRXhPdS92dXg0cW9FSFhQQk1maUg4Vi9W?=
 =?utf-8?B?MTZBRWNJeUtWcnRLWStRWEpjWE5wYmxvaEtETTVzNklhYVIrWlp1L2JIU3N3?=
 =?utf-8?B?Vmp2dzdXdGg1d0h5WnR2bjNYYldITEtWV2FVelhaV2ZFZWRKZkZoa0NlVnZk?=
 =?utf-8?B?NldqdkhhVWlTdGdNYmo5KzRDUmduREhJM3VtTWZjb2FhaUMydHhRUVA2dlpi?=
 =?utf-8?B?clI5eGZsMnZYaDV6L1JDS05RQXUrU1FUcXduWFRKWWxCRW1nbXFEbHZiS3ZO?=
 =?utf-8?B?OWZrVXIwa3FxVUQ2ampoY0xnKzY1R0xwVXR6TU9rUGhFLytDRVMwZ2hFVDRi?=
 =?utf-8?B?ckxCRUtxK1RKcno1cUhYVHdrUC83bkk2Z3JweUgwNlJNOStNZ3E2Wm5WSFlT?=
 =?utf-8?B?ZS9FWmVFQlBBQ1duNmpUUDNYV3haQ1IvRS9WaU54NHhOUUd4eUNiQkJnbFBK?=
 =?utf-8?B?S25ZQWtVWUEvOG1qR3lRTFBFNlhkbzFBbkNNaWRXNUJPckY2aHNWZkhQVGV4?=
 =?utf-8?B?WlBMUVlFNnpIUG1VVjhveThVVGtKVzVVWHlmcmtzVkJZQTlJQ2dlSEJ1dlN6?=
 =?utf-8?B?aXA2VW5nektuQVFaNVo4ZTZJaUxsUUIyMzQ5OG9rdVZBY2J5NEpId2hyY2lM?=
 =?utf-8?B?NDdDQ0Mwa3Fna2hxMHk4VWVSTkMvbVRWQk1ZMXltcEZHM1FwNXczMzBhT2Yz?=
 =?utf-8?B?UEFLWU5YNHc2TE1yS3NoZGw2MGZGQWorTCtPd1E0QjNNeXRMRjJNRW13Mkkz?=
 =?utf-8?B?emVIM2tESUtZN3lYTjVPZDlVS09QdFAvT3ZRMVpUS3hPVEM4TUZGZy9DNnlK?=
 =?utf-8?B?emJ3bFhnbjBrWDhjTDExTm1nS1VlaUVJUCtDK09uRDFTc1RLdjNLWnBZUjNo?=
 =?utf-8?B?OHU4c2RuRm1hditReW5YTTMrSnh5c1YvcGN2NDBnaTFsNnZNd2VhV29kRHJi?=
 =?utf-8?B?N3N1M2tYOXVuaitaeWtiU2Jub3BBMVhhTWsxU1lsU1g0UmtSVXBrK2dXNFVq?=
 =?utf-8?B?Y2tsSXpSQ09Rc2FzaGtlbDdzcGs4UmdMRUZCNzV4dVA1UzZOYzhjRStycGVR?=
 =?utf-8?B?alFmT2NHUFdYSkNTdDVBNGpKMExCZEQyUjZhNjE1QjlkN2xWeEtQNDhBZUZF?=
 =?utf-8?B?SUxQa0JqZGhmd2dxbkRrV0pkUVVvQzVDSGtWTk9ET2djd0kwS3d2clVXUzJZ?=
 =?utf-8?B?dEFPQmtYSFVqamdiRW1jQUpjVHVodTVkckhheTRlK0ZHWVpEdVZ1M01UTit5?=
 =?utf-8?B?L0FOcG9TQ1gwNkx6ektiL1NNUFM3L01QZnVTeTB0aWpISGtCb0dVSU9MbG9l?=
 =?utf-8?B?OWpYTy84N3ZTNTV5OWRTZ2NvY3ExMUhpNmJpNWNYdDdPazFERE9BenNGK0Y4?=
 =?utf-8?B?RWxZVFVoUkQvTS9tT3kvbHRiUmc5UXJzZFN2TU5sOUxJMHE1a05yV21xMXVI?=
 =?utf-8?B?YWJRMFR0RFUzNEJkRmRoOTJncTE0L3hnd0tFYnFwS2tCTTJHb0N0dlBjc2hG?=
 =?utf-8?B?ZHFNMGhYU3lTblQxcjNVa1U5TG1BNGR0WnFlSERxSmQ5bnNNSjBxcitQaVB1?=
 =?utf-8?B?YmUzNnUyTDJQckNBMHJFRWxTWmdjTTRvRTdFTmgrRk95c3RYZUZ0ZkgzOUtp?=
 =?utf-8?B?V28vMTNJeFF6bm1Gck8yVGRZMkx1QjZ3RkxmQVdJcHdDbXZOUFpjNGtBWkhL?=
 =?utf-8?B?clhlbURUUkdVbjV5Y2RCOTFidSsyQTQvWXVYMU9VdWE2cWtDZXNVcHJsT3Bt?=
 =?utf-8?B?d0Z5ZWl5eXlXeElTWXl2aU1IWnRSbWF1VzE3ZVkyNlpvMkVWcWk3YUFMdTRN?=
 =?utf-8?B?bnFiYnJ2aXVqY1hYbG8zU0tkaXY0MXJncUJnOEg3Q3BmZ2wwMFdOV1BPWHZ6?=
 =?utf-8?Q?7WhdKuptgO8JwSor80NZQHHIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259771e3-7d48-4957-69b2-08db7ee82806
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 12:46:17.5257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pIe3xpnNJXDXeNFGMNwIMzUEp1yh8+hjgkfpypP4ZTEMp0Z2OaC4MVzoxuj5Zc0K5AwSwKszKbhj9wU/V4BiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
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


On 07/07/2023 14:28, Christian König wrote:
>
>
> Am 07.07.23 um 12:02 schrieb Shashank Sharma:
>>
>> On 07/07/2023 10:37, Christian König wrote:
>>> Am 07.07.23 um 09:46 schrieb Shashank Sharma:
>>>>
>>>> On 07/07/2023 09:24, Christian König wrote:
>>>>>
>>>>>
>>>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>>> the hw's context. As MQD format can vary between different
>>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>>
>>>>>> This patch:
>>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>>    GFX-GEN-11 IP
>>>>>>
>>>>>> V1: Worked on review comments from Alex:
>>>>>>      - Make MQD functions GEN and IP specific
>>>>>>
>>>>>> V2: Worked on review comments from Alex:
>>>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>>      - Formatting and arrangement of code
>>>>>>
>>>>>> V3:
>>>>>>      - Integration with doorbell manager
>>>>>>
>>>>>> V4: Review comments addressed:
>>>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>>      - Align name of structure members (Luben)
>>>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>>>        message (Luben)
>>>>>> V5:
>>>>>>     - No need to reserve the bo for MQD (Christian).
>>>>>>     - Some more changes to support IP specific MQD creation.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>>>> +++++++++++++++++++
>>>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>>   3 files changed, 96 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> index e37b5da5a0d0..bb774144c372 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>>> *dev, void *data,
>>>>>>       return r;
>>>>>>   }
>>>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>>> +
>>>>>> +static void
>>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>>> +{
>>>>>> +    int maj;
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>> +
>>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>> +    if (maj == 11)
>>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = 
>>>>>> &userq_gfx_v11_funcs;
>>>>>> +}
>>>>>> +
>>>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>>>> struct amdgpu_device *adev)
>>>>>>   {
>>>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>       userq_mgr->adev = adev;
>>>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>>       return 0;
>>>>>>   }
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>> @@ -30,6 +30,7 @@
>>>>>>   #include "amdgpu_psp.h"
>>>>>>   #include "amdgpu_smu.h"
>>>>>>   #include "amdgpu_atomfirmware.h"
>>>>>> +#include "amdgpu_userqueue.h"
>>>>>>   #include "imu_v11_0.h"
>>>>>>   #include "soc21.h"
>>>>>>   #include "nvd.h"
>>>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>>>> gfx_v11_0_ip_block =
>>>>>>       .rev = 0,
>>>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>>>   };
>>>>>> +
>>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>>>> *uq_mgr,
>>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>>> +    int r;
>>>>>> +
>>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>>> +
>>>>>> +    /* Structure to initialize MQD for userqueue using generic 
>>>>>> MQD init function */
>>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>>> +
>>>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>>>>> args_in->mqd_size)) {
>>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>>> +        return -EFAULT;
>>>>>> +    }
>>>>>
>>>>> Sorry, I've just seen that now. Please don't have a 
>>>>> copy_from_user() in the backend!
>>>>>
>>>>> This is pure front end stuff which we shouldn't do in hw 
>>>>> generation specific code.
>>>>>
>>>> This is a bit difficult to achieve, as you know:
>>>>
>>>> - the whole reason we moved to ptr/size based approach from 
>>>> fix-mqd-structure approach is so that we can support multiple MQD 
>>>> structures using the same UAPI.
>>>>
>>>> - which means that in file amdgpu_userqueue.c layer (say front-end) 
>>>> I do not know what is the right size of MQD, its independent of IP.
>>>>
>>>> - the correct size of MQD can only be known in IP specific 
>>>> functions which are in gfx_v11.c (back end).
>>>>
>>>> - I may be able to achieve it by adding a new fptr get_mqd_size() 
>>>> which can return the right MQD size for me from backend IP 
>>>> function, and then I can move this copy from user to front-end. 
>>>> Does it sound like a good idea to you ?
>>>
>>> Just use memdup_user() in the frontend. Allocating structures which 
>>> are copied from userspace on the stack is usually a bad idea as well.
>>>
>>> Then pass in the kernel ptr and size as argument here and validate 
>>> if what userspace gave us is correct.
>>>
>> This can still allow the user to pass invalid size (0 or too big), 
>> how to prevent that ? I can still add a check for 0 size, but how 
>> about a very big but invalid size for MQD ?
>
> memdup_user() already takes care of that (has a maximum of 2MiB IIRC) 
> and the hw specific function should still validate the size to filter 
> out 0 and other invalid values.


Perfect, I will change it.

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> +
>>>>>> +    /* Create BO for actual Userqueue MQD now */
>>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>>>>> PAGE_SIZE,
>>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>>> +                    &queue->mqd.obj,
>>>>>> +                    &queue->mqd.gpu_addr,
>>>>>> +                    &queue->mqd.cpu_ptr);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>>> +        return -ENOMEM;
>>>>>> +    }
>>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>>> +
>>>>>> +    /* Initialize the MQD BO with user given values */
>>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>>> +    userq_props.use_doorbell = true;
>>>>>> +
>>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>>> +        goto free_mqd;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +
>>>>>> +free_mqd:
>>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>>>>> &queue->mqd.cpu_ptr);
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>>>> struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>>> +
>>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, 
>>>>>> &mqd->cpu_ptr);
>>>>>> +}
>>>>>> +
>>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>>> +};
>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>> index 55ed6512a565..240f92796f00 100644
>>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>> @@ -29,6 +29,12 @@
>>>>>>     struct amdgpu_mqd_prop;
>>>>>>   +struct amdgpu_userq_obj {
>>>>>> +    void         *cpu_ptr;
>>>>>> +    uint64_t     gpu_addr;
>>>>>> +    struct amdgpu_bo *obj;
>>>>>> +};
>>>>>> +
>>>>>>   struct amdgpu_usermode_queue {
>>>>>>       int            queue_type;
>>>>>>       uint64_t        doorbell_handle;
>>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>>>       struct amdgpu_vm    *vm;
>>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>>   };
>>>>>>     struct amdgpu_userq_funcs {
>>>>>
>>>
>
