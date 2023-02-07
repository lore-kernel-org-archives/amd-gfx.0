Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C5C636D3
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 17:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D6010E1E5;
	Tue,  7 Feb 2023 17:14:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5B910E1E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 17:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BogVQvBbJckJ2/s2I9YfG/7xC0nQ8NlDnCipat65WANdrSa9EQznM+Dtmqmk4qNDT/BTZlumF8ncwnXeRIcPegzkMj5BC5GgNnCW/P/hnoRLB/iAe5EG39XhklybYj5BqoEL7vezV9fHaJD7KfT75b8eKQvHMpC3/OaIHCII3WmaIE3qrLwgAAjnhrO1HEKEJ+Kl+I4ocLthBjK1jEZ2kZplh5bXQglEwxRMPyAt4Nu1C2brQluZ7I0vjYgrlwIzBgmuycglsLmuo6sFpzUjB9aEVcMzJn3tgYPkW8c3RTfQZKPIefasvEGY3gB0VIfPiwZZMGUUSD1gwSQq7dorMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUeDwVM7SLjz5Ts1ODcfiyXUGG3tI0aBTMLcX+UpYh4=;
 b=TS/Qekv/7/0aRk+BEKnUmFHjYUiFOr/sPjhSXsQDoQsVYwANQ3JEjASpTWQrfyafFaiUMtXkqgvS4xI25WoEh8njXtwA4xnfxBxjTq06ZoD+vXgd05y7Vt51BuZbxHv4oJEhVyTZiPPTQ8+heYi7kw3Dy78RxHikDhxrK/dJGLXLMfF0QBypoD+TI5CVkTY60tVZ/Xt+Jg7e0fX2Gt4js7OObxI6DIC3rylLhpS6pSv4307dAuZcrf5giVglSIOG097qqO1lM1qL5kS0c07AuECW6nJcqOhBkL7IQWXgjQUSqUC0i9dgWfB+LdOCLCEMiiBalM0tiZpPn7cXPN6jtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUeDwVM7SLjz5Ts1ODcfiyXUGG3tI0aBTMLcX+UpYh4=;
 b=MOcgg4czh+UEqiPKGGuXnYq4h6wHbbjXwKN2TEYCvUZPKvtuxGSWoEsxXrQo6GCul+NlGPsOEE/87sOBOTLuDqkkud2q9kq7uVXDWOD3hXXh3MvtlVQ6GyXcybLcWrVd7ExfMZi2hBErKvZxKEk9k179OOVBqFFFsPu3L35F4zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 17:13:59 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 17:13:59 +0000
Message-ID: <a2f7bc74-736f-252f-8f9c-328466bf8cb1@amd.com>
Date: Tue, 7 Feb 2023 18:13:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] drm/amdgpu: Add V11 graphics MQD functions
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-5-shashank.sharma@amd.com>
 <CADnq5_M8wnDZUEvDVA_CdyE0sxgg0FragSbO19LjhRE_XMJ-OA@mail.gmail.com>
 <d6e62077-7c6e-1fb4-8abe-275ccdf72003@amd.com>
 <CADnq5_OGOeFLnJyspTYvoOyKv1E=3Tp6uUweCF_JYFRFftuphw@mail.gmail.com>
 <48c0d13f-7ccc-1f05-2a0a-e20bdb1e1fb5@amd.com>
 <CADnq5_P2o2r589ojnFa2mtSeviRvN-gZH96gpyn_FavfRsCBGg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_P2o2r589ojnFa2mtSeviRvN-gZH96gpyn_FavfRsCBGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b3b22b-6829-4609-ad4e-08db092eb36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RHmg29UrS5dXDKYZrxSMxqFetHZ0IEbc0m/z/iPhXB4eOvCnFWx3GciH2smxsB1cCu9WiwSHK4XjHo38wxU2ZTCNJYFRkV+ceubdNEbvLV4pSHYRJ3wpCK3O1PMKRg5bbym+BrbfP027d8opmzEfbrjMz/hgOKOAm/jf2/lsCMdl6KecbXjbW/QthnBNcbBeZETWj7fVCfAqXf2uUc0xOXnm2VUZjrU6WVKPihVe6+56Ow5cW8vhK5CMkQ2ITQElyZSESBcp0OZGugNva2eoVQBT1DoBXuKPVSv7R2642WGAyvsrq+5gn8kPfixXWVbbls+1eGGDuYdHmLhpJNSXs8wkV1cd5M1hpMuyJF9YTtcCQHpdfln/GyGYeaLMMOWOOdvfvT8Gxgm9LVk8IWaBLkI7z64SjAPiUw+WxiJcUJTZeHdJxKodVIGLcG42GdixtSW+hpBHaFqTWqYYxAaxZziR1Nd95l1LsWLVXGtPmUXHHTjKx9NUHAE2+9LqmCpB3sL2fT4C8kAgn4eM7RZbcqDdkZYbqBLxifzONllyo3QHsqGZhLLBuYjMD8ho1xg0yWq9uMv/1Q4ElzYy9FzpkhdQ+oYqp07VMlbnXcAec3ZNnb4i+3ZAaYR0pFRuiClSvucllp8LqvbLCfGnycN8MrI2oV/3Ymm1i/+1qkk74AA970CS4O3L5g98EWuevdzCrdmrrXa5wtqNrn7asgOBQKNwxt52R85lu3ZmG8d3wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(31686004)(66899018)(8936002)(83380400001)(2906002)(44832011)(5660300002)(30864003)(6666004)(6486002)(186003)(478600001)(53546011)(26005)(6506007)(2616005)(6512007)(86362001)(38100700002)(36756003)(66556008)(66946007)(6916009)(41300700001)(66476007)(31696002)(8676002)(4326008)(316002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFaa1VJZXlXWWI2bTE2Z25nWTJQNG9PR09hRmJ2MmFhNi9meGFwYVVqR21J?=
 =?utf-8?B?RGlzdXlBTW44SmFLUzFraWtvNkw4aGcyb0pHOU9BS1pNRjlaaWtIb21LYWNQ?=
 =?utf-8?B?MlptNitYT3JBK25rSHBOUFlpd2RpcDBMbXM0Y25od3FJcnA5Y2FySTUwejl2?=
 =?utf-8?B?SVpEZkpZd1BLckhBQjMydXV4OTFDV2RUVzJWMllDVDZlS0hlTE1VWjhWajEz?=
 =?utf-8?B?K3d3V3VHMVhmV05kN041bW51dVBtODFoQ3dsOC9IbGwzbVJMdU9laXIydnNH?=
 =?utf-8?B?TjJjTk5DMXFZQS9EeTdJdVV2Mkp3aWlJT0RtanJzY3lCVDhHMklKMGdVKzBW?=
 =?utf-8?B?ZmtIMll2VVFRZUJ2bjFaYWRyY3AwVld0akJEVC9vS3FkaGVjSkh2UHhKcEw0?=
 =?utf-8?B?dStLR0hhRFlHUlRFQmtOZCtLY1dIdVkwc2tuWU1Kd3NFbzlkaUlyRFUvQnlF?=
 =?utf-8?B?eVpKdHIzN3FWUHZrR2gyQm5LaGNlZFh0QVlESmIzZDdTc3J3allJZU1IeUdY?=
 =?utf-8?B?R1pBSDNEblg4T1J4bGVpNnFnQkI4U2t0ZkI4NkFZNlN1cUNOVTZuTERPV2xR?=
 =?utf-8?B?ZzNzYnJPekJJZm1zUStiSDB5aThzdXk0dk8rc0dvT01SQ3l5UnlocDE3T2Yr?=
 =?utf-8?B?d3pIQUVzcUZRYkcyOGgrbENTdkVXQldpRjF3L0hTTTNnVW50Z3NxQVc3Smgr?=
 =?utf-8?B?NEtnMjZhck5lWGp4elVXQ0Y1MGloM2Q4NnFvSTB5ZmdscUtJWlJXL0lnaGVL?=
 =?utf-8?B?aURKQXQvZ251MVo3RnllTWwvZ3hsUjB0c20zZjNpRE9rWGxSRWd0YlZjWGhx?=
 =?utf-8?B?RGZXNFRRWCtERy9lbFBnK284ay8zbmV3MXA4empXRUErUGk0RUpQMVF3cWN6?=
 =?utf-8?B?ZFJsV0pub3gvazZPdzUxc3JYQUhqMlNYcm1tOUFuNE5LaHJucDBDSHEwT1Z5?=
 =?utf-8?B?d1Z4TkVWaWorZ2c3TlQycTNCZmd1dXd1MXU5Q0l6T2E0TEFPUkFZOS9VUDA3?=
 =?utf-8?B?bWtuUjUzQ0hSVWlCSGI3OTNkZnhHVGZuNjRMVW5MbVRIVUNwVkY2Z1NjNDUz?=
 =?utf-8?B?WWpVUVVHRi9UQjRGSFpmTDAvV3Y3YUhpU1M4ZWNMOGFrWWdYNXNpN2JUWG5u?=
 =?utf-8?B?UEVYZWlSeW05dldWYmgvYXR3ajh3VnJ4Z3FidmpRbHNlYUdSME82RS9ETGZk?=
 =?utf-8?B?SEQ0V1dWUkFUL3U0QXRZUGhReC9ic0YvTG5HcnV3Q3dZUERTNzB1d0FzaGZj?=
 =?utf-8?B?Ri9LS3pnbTkzRnFOdHBnMlZlYWlkUWtzT1kxTzNGQkdRMWtlYkR3UjNNbHB2?=
 =?utf-8?B?eHN6K3p1TlN4aGJobG0rbjBITXZreW0vZXllYnFNM3VhMldlQ09WRmptY2ty?=
 =?utf-8?B?ZUFlaEd0ZHBCOWJNMTFHa2xFZERkWkh6K1dSRE5HVWRzemZoMVBuM3M1WnFs?=
 =?utf-8?B?M2pUajBmdVVKYW5UTDBEeUdYOFlFRVU5K1p6bGNpQjZJMXhpamdVdW1GdUJi?=
 =?utf-8?B?VFVTelJlQnMxRWFhM1dXcXlRNC81b014V2FjM1lUV014dGM0VnVTY2taTHUw?=
 =?utf-8?B?dks1VXFMSE1NTHBaM1hiT0tabUZ0RFVXenc2NngyMURUVVkvdjJNaXZMb2F3?=
 =?utf-8?B?Unc5WEpjcDUrdDdDWWJBRWVMTGNGUXZhZXdWWGhCTHkzM2pvZ3NiZTJiQUli?=
 =?utf-8?B?T0tLd1ZrbGFTRHBWb2Y1dHZ4Z2psUk5IeE9ObXR0WUdZaTgraE9QZDBrYUZM?=
 =?utf-8?B?REFRajJHNUJqcDBSWDZBQUkxSU5NZGNYWjJPcGpLak5ZZE81eEpIbHFEanVM?=
 =?utf-8?B?UVRVSkZGNHNoSlJGUkYxOXBsN2hNcjFJYkIvN2U3TWNFZGpqQUhyVHYzR3Q2?=
 =?utf-8?B?ampXZkdsRW45SkZldkYweDFFV0JHQlVzQmF1clBiTVMxN2lpb2hmN0RKNFFL?=
 =?utf-8?B?NEFnSnVUYzRmSU56a0wwM1RLTDdBVVl3R2d6OE1QSXpiMVVXYStad2JEY3Fq?=
 =?utf-8?B?YmZIZWR6dlNwT2JwQ0gvTGQzSlBBU01MenFxRnRBMW1oMjRySGdLRVkxRExu?=
 =?utf-8?B?Mmc3NlpRZitUcm1DdVVBd3VrRUJkMkJmQ2QvTTQ3STh3V2Q5U2tlMDBFRThL?=
 =?utf-8?Q?aNO68M7kju+gKr7D2VocXMnFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b3b22b-6829-4609-ad4e-08db092eb36e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 17:13:58.9545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvFjm+FvyarSh/S6QMfd/yrUxi4dqFrvK/NpZm7N8v9S2ISB17WhBhuYwlQZj3pIVKkxvQYN9WKE+31GUXdmIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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
Cc: alexander.deucher@amd.com, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 17:54, Alex Deucher wrote:
> On Tue, Feb 7, 2023 at 11:37 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 07/02/2023 17:05, Alex Deucher wrote:
>>> On Tue, Feb 7, 2023 at 10:43 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> On 07/02/2023 16:17, Alex Deucher wrote:
>>>>> On Fri, Feb 3, 2023 at 4:55 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>
>>>>>> MQD describes the properies of a user queue to the HW, and allows it to
>>>>>> accurately configure the queue while mapping it in GPU HW. This patch
>>>>>> adds:
>>>>>> - A new header file which contains the userqueue MQD definition for
>>>>>>      V11 graphics engine.
>>>>>> - A new function which fills it with userqueue data and prepares MQD
>>>>>> - A function which sets-up the MQD function ptrs in the generic userqueue
>>>>>>      creation code.
>>>>>>
>>>>>> V1: Addressed review comments from RFC patch series
>>>>>>        - Reuse the existing MQD structure instead of creating a new one
>>>>>>        - MQD format and creation can be IP specific, keep it like that
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
>>>>>>     .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
>>>>>>     drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
>>>>>>     4 files changed, 169 insertions(+), 8 deletions(-)
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> index 764801cc8203..6ae9d5792791 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>>>>>>
>>>>>>     # add usermode queue
>>>>>>     amdgpu-y += amdgpu_userqueue.o
>>>>>> +amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
>>>>>>
>>>>>>     ifneq ($(CONFIG_HSA_AMD),)
>>>>>>     AMDKFD_PATH := ../amdkfd
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> index 625c2fe1e84a..9f3490a91776 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> @@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>>>         return r;
>>>>>>     }
>>>>>>
>>>>>> +extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
>>>>>> +
>>>>>> +static int
>>>>>> +amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
>>>>>> +{
>>>>>> +    int maj;
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>> +
>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>> +    if (maj == 11) {
>>>>>> +        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
>>>>>> +    } else {
>>>>>> +        DRM_WARN("This IP doesn't support usermode queues\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>> I think it would be cleaner to just store these callbacks in adev.
>>>>> Maybe something like adev->user_queue_funcs[AMDGPU_HW_IP_NUM].  Then
>>>>> in early_init for each IP, we can register the callbacks.  When the
>>>>> user goes to create a new user_queue, we can check check to see if the
>>>>> function pointer is NULL or not for the queue type:
>>>>>
>>>>> if (!adev->user_queue_funcs[ip_type])
>>>>>      return -EINVAL
>>>>>
>>>>> r = adev->user_queue_funcs[ip_type]->create_queue();
>>>> Sounds like a good idea, we can do this.
>>>>
>>>>> Actually, there is already an mqd manager interface (adev->mqds[]).
>>>>> Maybe you can leverage that interface.
>>>> Yep, I saw that and initially even tried to work on that interface
>>>> itself, and then realized that it doesn't allow us to pass some
>>>>
>>>> additional parameters (like queue->vm, various BOs like proc_ctx_bo,
>>>> gang_ctx_bo's and so on). All of these are required in the MQD
>>>>
>>>> and we will need them to be added into MQD. I even thought of expanding
>>>> this structure with additional parameters, but I felt like
>>>>
>>>> it defeats the purpose of this MQD properties. But if you feel strongly
>>>> about that, we can work around it.
>>> I think it would be cleaner to just add whatever additional mqd
>>> properties you need to amdgpu_mqd_prop, and then you can share
>>> gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()  for GFX and
>>> sdma_v6_0_mqd_init() for SDMA.  That way if we make changes to the MQD
>>> configuration, we only have to change one function.
>>>
>>> Alex
>> Noted,
>>
>> We might have to add some additional fptrs for .prepare_map() and
>> .prepare_unmap(). in the mqd funcs.
>>
>> These are the required to prepare data for MES HW queue mapping.
> OK.  I think we could start with just using the existing init_mqd
> callbacks from your create/destroy queue functions for now.
Ok,
> That
> said, do we need the prepare_(un)map callbacks?  I think just
> create/destory callbacks should be fine.  In the create callback, we
> can init the mqd and map it, then in destroy, we can unmap and free.

If you observe the kernel MES framework, it expects the data to be fed 
in a particular format, in form of queue_properties, and

creates the map_queue_packet using those. So we need to re-arrange the 
data we have in MQD or drm_mqd_in in format

of properties, which is being done in prepare_map/unmap. Now, as the MQD 
is IP specific, we will need this

function to be IP specific as well, so I added a new fptr callback.


So the idea here is, IP specific stuff like:

- preparing the MQD

- preparing the properties for map_queue_packet

- preparing the context BOs

is being done in IP specific functions in amdgpu_vxx_userqueue.c


and

- initializing the queue

- handling the IOCTL

- adding/mapping the queue to MES

- any bookkeeping

is being done from the IP independent amdgpu_userqueue.c functions.

- Shashank
> Alex
>
>
> Alex
>
>> - Shashank
>>
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>>>>>     {
>>>>>> +    int r;
>>>>>> +
>>>>>>         mutex_init(&userq_mgr->userq_mutex);
>>>>>>         idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>         INIT_LIST_HEAD(&userq_mgr->userq_list);
>>>>>>         userq_mgr->adev = adev;
>>>>>>
>>>>>> +    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>>         return 0;
>>>>>>     }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..57889729d635
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>>> @@ -0,0 +1,132 @@
>>>>>> +/*
>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>>>>> + * copy of this software and associated documentation files (the "Software"),
>>>>>> + * to deal in the Software without restriction, including without limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>>>>> + * Software is furnished to do so, subject to the following conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall be included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +#include "amdgpu.h"
>>>>>> +#include "amdgpu_userqueue.h"
>>>>>> +#include "v11_structs.h"
>>>>>> +#include "amdgpu_mes.h"
>>>>>> +#include "gc/gc_11_0_0_offset.h"
>>>>>> +#include "gc/gc_11_0_0_sh_mask.h"
>>>>>> +
>>>>>> +static int
>>>>>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    uint32_t tmp, rb_bufsz;
>>>>>> +    uint64_t hqd_gpu_addr, wb_gpu_addr;
>>>>>> +    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +
>>>>>> +    /* set up gfx hqd wptr */
>>>>>> +    mqd->cp_gfx_hqd_wptr = 0;
>>>>>> +    mqd->cp_gfx_hqd_wptr_hi = 0;
>>>>>> +
>>>>>> +    /* set the pointer to the MQD */
>>>>>> +    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
>>>>>> +    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
>>>>>> +
>>>>>> +    /* set up mqd control */
>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
>>>>>> +    mqd->cp_gfx_mqd_control = tmp;
>>>>>> +
>>>>>> +    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
>>>>>> +    mqd->cp_gfx_hqd_vmid = 0;
>>>>>> +
>>>>>> +    /* set up default queue priority level
>>>>>> +    * 0x0 = low priority, 0x1 = high priority */
>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
>>>>>> +    mqd->cp_gfx_hqd_queue_priority = tmp;
>>>>>> +
>>>>>> +    /* set up time quantum */
>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
>>>>>> +    mqd->cp_gfx_hqd_quantum = tmp;
>>>>>> +
>>>>>> +    /* set up gfx hqd base. this is similar as CP_RB_BASE */
>>>>>> +    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
>>>>>> +    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
>>>>>> +    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
>>>>>> +
>>>>>> +    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
>>>>>> +    wb_gpu_addr = queue->rptr_gpu_addr;
>>>>>> +    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
>>>>>> +    mqd->cp_gfx_hqd_rptr_addr_hi =
>>>>>> +    upper_32_bits(wb_gpu_addr) & 0xffff;
>>>>>> +
>>>>>> +    /* set up rb_wptr_poll addr */
>>>>>> +    wb_gpu_addr = queue->wptr_gpu_addr;
>>>>>> +    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
>>>>>> +    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
>>>>>> +
>>>>>> +    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
>>>>>> +    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
>>>>>> +#ifdef __BIG_ENDIAN
>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>>>>>> +#endif
>>>>>> +    mqd->cp_gfx_hqd_cntl = tmp;
>>>>>> +
>>>>>> +    /* set up cp_doorbell_control */
>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
>>>>>> +    if (queue->use_doorbell) {
>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>>>> +                    DOORBELL_OFFSET, queue->doorbell_index);
>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>>>> +                    DOORBELL_EN, 1);
>>>>>> +    } else {
>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>>>> +                    DOORBELL_EN, 0);
>>>>>> +    }
>>>>>> +    mqd->cp_rb_doorbell_control = tmp;
>>>>>> +
>>>>>> +    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>>>>>> +    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
>>>>>> +
>>>>>> +    /* activate the queue */
>>>>>> +    mqd->cp_gfx_hqd_active = 1;
>>>>>> +
>>>>> Can you use gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()
>>>>> directly or leverage adev->mqds[]?
>>>> Let us try this out and come back.
>>>>
>>>> - Shashank
>>>>
>>>>
>>>>> Alex
>>>>>
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +
>>>>>> +}
>>>>>> +
>>>>>> +static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
>>>>>> +{
>>>>>> +    return sizeof(struct v11_gfx_mqd);
>>>>>> +}
>>>>>> +
>>>>>> +const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
>>>>>> +    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>>>>>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>>>>>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>>>>>> +};
>>>>>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
>>>>>> index b8ff7456ae0b..f8008270f813 100644
>>>>>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
>>>>>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
>>>>>> @@ -25,14 +25,14 @@
>>>>>>     #define V11_STRUCTS_H_
>>>>>>
>>>>>>     struct v11_gfx_mqd {
>>>>>> -       uint32_t reserved_0; // offset: 0  (0x0)
>>>>>> -       uint32_t reserved_1; // offset: 1  (0x1)
>>>>>> -       uint32_t reserved_2; // offset: 2  (0x2)
>>>>>> -       uint32_t reserved_3; // offset: 3  (0x3)
>>>>>> -       uint32_t reserved_4; // offset: 4  (0x4)
>>>>>> -       uint32_t reserved_5; // offset: 5  (0x5)
>>>>>> -       uint32_t reserved_6; // offset: 6  (0x6)
>>>>>> -       uint32_t reserved_7; // offset: 7  (0x7)
>>>>>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>>>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>>>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
>>>>>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
>>>>>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>>>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>>>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
>>>>>> +       uint32_t ib_vmid; // offset: 7  (0x7)
>>>>>>            uint32_t reserved_8; // offset: 8  (0x8)
>>>>>>            uint32_t reserved_9; // offset: 9  (0x9)
>>>>>>            uint32_t reserved_10; // offset: 10  (0xA)
>>>>>> --
>>>>>> 2.34.1
>>>>>>
