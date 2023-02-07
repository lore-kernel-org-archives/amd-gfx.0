Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D76C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 18:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACC910E1CF;
	Tue,  7 Feb 2023 18:28:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EACD10E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 18:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi+qB22oAjZWRZWp8kswxabYq+120snRhowd31881n2fjo0hpPP8jj7IN9BamzWJZnMjSX03vSsVCO/r58Kye1ACKfPg3IMfkBtkaMXPYqkQPAsYTvJ/k/UiCXorcVCdgHWKYgrPuralTs4Ni95UlRSJbEgBW/6G6a93uuYhwPQXK2ZEuOv65SvVNPploSroY/plBrUaA0DZKXhfwb7C1dmYUEt70PkDS1jCg8N713s1NuAdtLltDWfW4pN5tEUwOFPvIxTAftFaDiW2Mg9G4X0uMeVcI7BFfzag5CRXTNcY6FqroNesooRfsmd9XI84oQvPCsZbdQ0YDDwJjVd8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug8dwYli/fZkU3xTaS0VHSd1U8AH+wQLuLo7ED1+92I=;
 b=Lz0iMQxBYpgP7CwkWT0rNssZquLlBf/KbkJVeDG+udZXsnpSR8rPzIQc7AyDnXtgWvYGgOxcvVjSp2/vv9QhyadLuXSWLtAyMck4QqgM9M7jDOo2ltLzP3rmiaTPvPBBcS8d5LDBazmvV61Z8iaAAI1q8OE29KtnT3EHdq9AnZCmUYXMGArxYpoXhjRLUWHxveAyG25uwDSfFbLpMi102gZWApEv+3K8CQRS9tD9xxnjmLavHKyLiTEpL3I4pje7JMNhTUh9s7ER3DYWwIilur1bGPwjrxZgxMfvKk906EZDg2IMufIgF6mIYeQliwrXt7VhtUKe0DsHFqoMox76Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug8dwYli/fZkU3xTaS0VHSd1U8AH+wQLuLo7ED1+92I=;
 b=fUXjzFB07PWCRG4bNGkLArdnP5zB0m5G5xMNJQlrkbX0Wmo4G5m4Auoi44uvFHb4zMZFNjxMotqAgh9GLRrrtn9LL34yAlym0Il+AsC0Xmq69ZGPPTER6qOreOwZr6/Q+cDXD7oTuXpw4p5Z7AXJyCVP2oYZd1HErvM/Mzl+AIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 18:28:29 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 18:28:28 +0000
Message-ID: <6407bda2-f8f3-7d4b-3339-7b301e9fa0ca@amd.com>
Date: Tue, 7 Feb 2023 19:28:22 +0100
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
 <a2f7bc74-736f-252f-8f9c-328466bf8cb1@amd.com>
 <CADnq5_PhjV8354-yJ5s8ZW2dsTJdZu1oZBBsTibqyq7NF=s2wg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PhjV8354-yJ5s8ZW2dsTJdZu1oZBBsTibqyq7NF=s2wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 58837d67-bcfc-4bf0-9f38-08db09391bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvX729kaTN575aroSZPhaFxfn9iIkr3oAYgveMR74v4JGXCWUaHT8IRZ/j4aBQiM4YPEBUROvApfxTUfOm0Vt+S3mtfasGslXo4jNoKe9KSSstxnOfVG+a10WKloQWsxp6hzIJGSnccrQbs63hAQLDCYy9PgKhzAwUtOlV/3vqsrl8CIER4iz5y8L6NPSw/ubJMvcYLsnMfPLtNHPekwJ7EwsofkpJR02t1b+SS1Whm05OlGf9ZBWL6BptDOnZJ1g8e3XWDEbgd5nWujOPCKXrQWuoRj6IKA9sLxTknHyfiVQgQp+GyuLAB+vw6ygAOcsi5KzwAjn+nxdionr91QKYmAzDTelqq3AalXgK9pdEbLgXI/+OjGfqt2YW20wQFpS/UE3Z45AeZ9Pb6wFjQ0Y0KDzRmvgqcW/ssgnD8wWRZWfzuBLjnXQEUKsq6gjaahQuUDKVCpMASk4CHi4/d4OTpHGUvGjJJTweDjcDyxwTm1ddRA8m6pxnpIdVXqDg/tQpS5Qu85l1tPY68UcS6lNO98M2RHINqpNU2AGsvYcKFEGd1v9IOZH0Ii9GoCBICDy7hqysW4fHHfP4CN1tlQOkjDRCDvz566MN9/CoGlsq5V116ugTvyNwHAObSELd7Dl4wxgg5Nn1ZxjiLI8+nj2x4N41jl7tHkq4x1URcfw/3KOA7UBD6R6SV0VRPRqEkkODJGANND2+7CT9aAeX4yzN3LYgqXL305q9pDF1efgn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(31696002)(36756003)(86362001)(38100700002)(8676002)(5660300002)(66556008)(41300700001)(66476007)(54906003)(66946007)(6916009)(4326008)(8936002)(30864003)(2906002)(83380400001)(6486002)(44832011)(478600001)(2616005)(26005)(6506007)(6666004)(6512007)(53546011)(186003)(66899018)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZkWlVkaTVOaENBTUVzbE5uNU1XRU51Ykc5SkpaRy8zRlhGMHBHRU1hY0Nz?=
 =?utf-8?B?QVhOQVluTitabk55ZzZtQ1paU1VjbGZnNXRpOVc4cmY1cG1HbUJlSmdoa0JZ?=
 =?utf-8?B?VDc5S3RydWVTbDJRd0VpLzh4M1hsTUZyS1dCSVJvVE1aVkg1TmxzU1NPMHZZ?=
 =?utf-8?B?ckdCTnhGODBZc3JxczY5b0h2dWNudE0rQ2tNSis4OGZvSHhSY0c0NjZQekE4?=
 =?utf-8?B?SG1JcDlSQ2Myek1EUm9Mb0l1ZFFlYWx3OFNHWTE4cXJVT21SWUptZ0d2RGxl?=
 =?utf-8?B?L25WbS90R0lXRm03NEJsZHFiMWY4RE1JRWVyWW04c29RbU9YOGw0NjVmTXdR?=
 =?utf-8?B?SlpaNkRCMEx5SjlXRmZtZzBvenQ4eWhFWUdRTVlzN0R1VXRndFJrbzg1Ui9P?=
 =?utf-8?B?ZTBiSzJnbnF6QlVmaW96eHhlb2xVTnh3VFpsQkE2TktxZWs0dnR3RWw5c25E?=
 =?utf-8?B?NDRlQi9kV21vQnVBY1BocCszakdabXVOcFVWWW45WlUrTW1iTFozdEppNXoz?=
 =?utf-8?B?WEN2a3gyWEc3YUxaQUEwWndSSFhNSnZBU2N2M2RRdTlXZkpJeWJlTGhYeE5V?=
 =?utf-8?B?cWhrTzVqZ3JscnJZSzRGYUk0NTZsc3hpb1NRYU9YVy9zTHVNU2dKbEMwS2ZL?=
 =?utf-8?B?SFUwcEJ5MXNCR25xQWhvNGlINzYwQXlTdFhrd2ttek95cHBpZnYvWDZOSEJ2?=
 =?utf-8?B?UFdqYmFaNDJwdzNBZHlQSDJnTmczc2FyMjdhOW1nMnhCMlNwVFd4MGJIbzhJ?=
 =?utf-8?B?QUIvd2E0ZU9aSjlrMzdEODlHMDBzV3YycmJIbDNmRWNsMWZ0M2lvTG05amZi?=
 =?utf-8?B?cXNkN1A3ck0zU0ZNV283TWFEK3VHT0h0R0NiMmFKMFM1NTdjWU1RSlBtNWdi?=
 =?utf-8?B?bDJmR29kZ3FuMjc4WDA1dERDTHcyeVdya2piN29ReGNpaW05SGNSWXNPbE9z?=
 =?utf-8?B?NVRTSXNHVXVXeXRiTlpWU1NPd05zZ2VGb1hvYjU1VUg1M0JmdXNORGNlaCsw?=
 =?utf-8?B?VldVYjhvZC9OVGhUM0YrazhOYTc0eThCNEpKTUswZlhGb2NNOWRtT2ZNOWtS?=
 =?utf-8?B?bEtQcS9aMmFsWXFHS0dFVklmbmJLdEJ3Mk8zN3dxT01BM3dobWsrakc4VVA5?=
 =?utf-8?B?Unp1ZEhpcXVuMksvTkhkM25HN2VmMDVOa2YzUnZrZk84MDN6WndwVjYzS0NW?=
 =?utf-8?B?dFVVS25kL1R4bWkwM0VkRGQ5ekhVSkJwUmR3dGxEME9ZNFNpcXlVRWVzYUZN?=
 =?utf-8?B?dW91VW1YZTVoU3RrUkxMSEZzUjdZbnFRcjZjTWNka1dMeUkyc1dSY1hkWis5?=
 =?utf-8?B?MzA0TzRKWUF3a0M0SFhMREYvT1ZDZEhweDk0cVExQ01KRDhvbWF1eS84OUFL?=
 =?utf-8?B?VTJCVHAyV1czNUt0cC9zZDZHaW1nL1gyS3NMdENVSXlxTm11RDE0ZXFtK0ZY?=
 =?utf-8?B?UDErOGFhU2pEMWFhdGZyMEZQeXBJQnlibjEzeDRRU2VNcWNIWmxJQnZocDRZ?=
 =?utf-8?B?S2oza25XTXBBYVNsVGM2T1cxeFRtSjJJWDdmeFNSSWxWM3BjR3dOUjcxK1hD?=
 =?utf-8?B?bFRrTW90TFhSTUltMlRXMDV0ZzRZZ1pnb2c0OGdNTHB3RXFIQWd5VnFDZXli?=
 =?utf-8?B?M0loL21YSkVXZUpkYk5HZHVxR1ZJYmZHaU8xbzBVVFk5bWZ0UllLYUR6ZERJ?=
 =?utf-8?B?ZkpZcmV0ZW91U1pXNHQ1Qk5SSllhUUs3VDFOemlGSjFUaFlNYzc3OWdacVE0?=
 =?utf-8?B?c1VXWFo3MlhHQy91eFM4VkVULzlvQWhMeDJRWHZ0S1d2T1FsajNKTmVJY3Bv?=
 =?utf-8?B?OVkyVXI5QVpiOUV2Qys2Z2NCSmpqMElEWGw3MlZiRFhpVlMrL3lrYTJCeG9Y?=
 =?utf-8?B?V05aRUk4UmhGb0JicSs1M1JnK1NZRkN3dXJ4WkpRYnNqNzNLTHo1bU94ZzZi?=
 =?utf-8?B?MjNDQUpCNUtTQkFzZG1kbEY3RElrcStScDNZUXVsQ0k5dC9XQTVINlRZSk9v?=
 =?utf-8?B?bHF0cUVlendRaXRyVVpaaDhlVVJyWXZyVG5QQm1nNm56UkVsRGhyV0RsR0hQ?=
 =?utf-8?B?Rk9kNnFBMXJxVXI3empTMUNPb0tORXF2MGJYYTM5SGFBOFREeEFYVzJUcEVT?=
 =?utf-8?Q?CrN4BLH3Itdy/sieuR8B9DsFy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58837d67-bcfc-4bf0-9f38-08db09391bc3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 18:28:28.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WrFAX77d493/XG/u4yROVDgwwtBS4yweqPj22bdBrvAabzCrpUyTyCpO/wZDhxPt1EF6Le/iyX1IJfpS9Fibg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
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


On 07/02/2023 18:57, Alex Deucher wrote:
> On Tue, Feb 7, 2023 at 12:14 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 07/02/2023 17:54, Alex Deucher wrote:
>>> On Tue, Feb 7, 2023 at 11:37 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> On 07/02/2023 17:05, Alex Deucher wrote:
>>>>> On Tue, Feb 7, 2023 at 10:43 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>>>> On 07/02/2023 16:17, Alex Deucher wrote:
>>>>>>> On Fri, Feb 3, 2023 at 4:55 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>>>
>>>>>>>> MQD describes the properies of a user queue to the HW, and allows it to
>>>>>>>> accurately configure the queue while mapping it in GPU HW. This patch
>>>>>>>> adds:
>>>>>>>> - A new header file which contains the userqueue MQD definition for
>>>>>>>>       V11 graphics engine.
>>>>>>>> - A new function which fills it with userqueue data and prepares MQD
>>>>>>>> - A function which sets-up the MQD function ptrs in the generic userqueue
>>>>>>>>       creation code.
>>>>>>>>
>>>>>>>> V1: Addressed review comments from RFC patch series
>>>>>>>>         - Reuse the existing MQD structure instead of creating a new one
>>>>>>>>         - MQD format and creation can be IP specific, keep it like that
>>>>>>>>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
>>>>>>>>      .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
>>>>>>>>      drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
>>>>>>>>      4 files changed, 169 insertions(+), 8 deletions(-)
>>>>>>>>      create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> index 764801cc8203..6ae9d5792791 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>>>>>>>>
>>>>>>>>      # add usermode queue
>>>>>>>>      amdgpu-y += amdgpu_userqueue.o
>>>>>>>> +amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
>>>>>>>>
>>>>>>>>      ifneq ($(CONFIG_HSA_AMD),)
>>>>>>>>      AMDKFD_PATH := ../amdkfd
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> index 625c2fe1e84a..9f3490a91776 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> @@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>>>>>          return r;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
>>>>>>>> +
>>>>>>>> +static int
>>>>>>>> +amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>>> +{
>>>>>>>> +    int maj;
>>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>>>> +
>>>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>>>> +    if (maj == 11) {
>>>>>>>> +        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
>>>>>>>> +    } else {
>>>>>>>> +        DRM_WARN("This IP doesn't support usermode queues\n");
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>> I think it would be cleaner to just store these callbacks in adev.
>>>>>>> Maybe something like adev->user_queue_funcs[AMDGPU_HW_IP_NUM].  Then
>>>>>>> in early_init for each IP, we can register the callbacks.  When the
>>>>>>> user goes to create a new user_queue, we can check check to see if the
>>>>>>> function pointer is NULL or not for the queue type:
>>>>>>>
>>>>>>> if (!adev->user_queue_funcs[ip_type])
>>>>>>>       return -EINVAL
>>>>>>>
>>>>>>> r = adev->user_queue_funcs[ip_type]->create_queue();
>>>>>> Sounds like a good idea, we can do this.
>>>>>>
>>>>>>> Actually, there is already an mqd manager interface (adev->mqds[]).
>>>>>>> Maybe you can leverage that interface.
>>>>>> Yep, I saw that and initially even tried to work on that interface
>>>>>> itself, and then realized that it doesn't allow us to pass some
>>>>>>
>>>>>> additional parameters (like queue->vm, various BOs like proc_ctx_bo,
>>>>>> gang_ctx_bo's and so on). All of these are required in the MQD
>>>>>>
>>>>>> and we will need them to be added into MQD. I even thought of expanding
>>>>>> this structure with additional parameters, but I felt like
>>>>>>
>>>>>> it defeats the purpose of this MQD properties. But if you feel strongly
>>>>>> about that, we can work around it.
>>>>> I think it would be cleaner to just add whatever additional mqd
>>>>> properties you need to amdgpu_mqd_prop, and then you can share
>>>>> gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()  for GFX and
>>>>> sdma_v6_0_mqd_init() for SDMA.  That way if we make changes to the MQD
>>>>> configuration, we only have to change one function.
>>>>>
>>>>> Alex
>>>> Noted,
>>>>
>>>> We might have to add some additional fptrs for .prepare_map() and
>>>> .prepare_unmap(). in the mqd funcs.
>>>>
>>>> These are the required to prepare data for MES HW queue mapping.
>>> OK.  I think we could start with just using the existing init_mqd
>>> callbacks from your create/destroy queue functions for now.
>> Ok,
>>> That
>>> said, do we need the prepare_(un)map callbacks?  I think just
>>> create/destory callbacks should be fine.  In the create callback, we
>>> can init the mqd and map it, then in destroy, we can unmap and free.
>> If you observe the kernel MES framework, it expects the data to be fed
>> in a particular format, in form of queue_properties, and
>>
>> creates the map_queue_packet using those. So we need to re-arrange the
>> data we have in MQD or drm_mqd_in in format
>>
>> of properties, which is being done in prepare_map/unmap. Now, as the MQD
>> is IP specific, we will need this
>>
>> function to be IP specific as well, so I added a new fptr callback.
>>
>>
>> So the idea here is, IP specific stuff like:
>>
>> - preparing the MQD
>>
>> - preparing the properties for map_queue_packet
>>
>> - preparing the context BOs
>>
>> is being done in IP specific functions in amdgpu_vxx_userqueue.c
>>
>>
>> and
>>
>> - initializing the queue
>>
>> - handling the IOCTL
>>
>> - adding/mapping the queue to MES
> This seems weird to me.  Why have this in the asic independent code?
> I was thinking the IOCTL would mostly just be a wrapper around IP
> specific callbacks for create and destroy.  The callback would take a
> generic mqd struct as a parameter, that was basically just a
> passthrough from the IOCTL mqd struct.
>
> struct amdgpu_user_queue_mqd {
>      u32 flags;
>      struct amdgpu_bo doorbell_bo;
>      u32 doorbell_offset;
>      struct amdgpu_bo queue_bo;
>      struct amdgpu_bo rptr_bo;
>      struct amdgpu_bo wptr_bo;
>      u64 queue_gpu_va;
>      u64 rptr_gpu_va;
>      u64 wptr_gpu_va;
>      int gang;
>      ...
> };
>
> Then something like:
>
> static int gfx_v11_0_create_gfx_user_queue(struct amdgpu_device *adev,
> struct amdgpu_user_queue_mqd *user_mqd)
> {
>      struct gfx_v11_mqd mqd;
>
>      mqd = kmalloc(size_of(struct gfx_v11_mqd mqd));
>      ...
>      // allocate any meta data, ctx buffers, etc.
>      mqd->ctx_bo = amdgpu_bo_create();
>      ...
>      // populate the IP specific mqd with the generic stuff
>      mqd->mqd_gpu_addr = user_mqd->queue_gpu_va;
>      ...
>      // init mqd
>      r = adev->mqds[AMDGPU_HW_IP_GFX].init_mqd();

Actually, we are doing the same thing, but instead of doing in one large 
function we are doing in 3 smaller functions,

instead if having one big create_v11_mqd function, we have split its 
functionality into 3 parts:

- create_mqd_v11, create_ctx_mqd_v11, prepare_map_mqd_v11

I thought it would be easier to read, maintain and review modular 
functions for specific part. But probably I can get rid of the fptrs for 
them.

The IP independent functions are mostly passthrough who arrange 
data/handle memory management changes and call these IP functions.

>      // add gang, or increase ref count
>      r = amdgpu_mes_add_gang();
>      // map mqd
>      r = amdgpu_mes_add_ring();

we can't directly use most of these amdgpu_mes_* APIs as they expect 
data to be created and arranged in MES metadata format, which is not

aligned with how we are getting/preparing the data.


But I am getting your design points, and based on your inputs, I can try 
to re-arrange the code like this:

- Reuse existing MQD mgr and its fptr (create/destroy mqd) for 
add/destroy queue functionality

- mqd_create() can reuse the existing mqd_init() call and then 
internally call the create_ctx() and prepare_map() functions from the 
same file, we don't need separate fptrs.

- amdhpu_usermode_queue.c file can contain just the following:
    - init/fini function

    - the IOCTL handler

    - two wrappers, to call IP specific create/destroy functions.

This should take us close to what you are expecting.

- Shashank


> }
> static int gfx_v11_0_destroy_gfx_user_queue(struct amdgpu_device
> *adev, struct amdgpu_user_queue_mqd *user_mqd)
> {
>      // unmap mqd
>      amdgpu_mes_remove_ring();
>      // drop reference to the gang
>      amdgpu_mes_remove_gang();
>
>      // free any meta data, ctx buffers, etc.
>      amdgpu_bo_unref(mqd->ctx_bo);
>     kfree(mqd);
> }
>
>> - any bookkeeping
>>
>> is being done from the IP independent amdgpu_userqueue.c functions.
>>
>> - Shashank
>>> Alex
>>>
>>>
>>> Alex
>>>
>>>> - Shashank
>>>>
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>>>>>>>      {
>>>>>>>> +    int r;
>>>>>>>> +
>>>>>>>>          mutex_init(&userq_mgr->userq_mutex);
>>>>>>>>          idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>>>          INIT_LIST_HEAD(&userq_mgr->userq_list);
>>>>>>>>          userq_mgr->adev = adev;
>>>>>>>>
>>>>>>>> +    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>          return 0;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..57889729d635
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>>>>> @@ -0,0 +1,132 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>>>>>>> + * copy of this software and associated documentation files (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>>>>>>> + * Software is furnished to do so, subject to the following conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +#include "amdgpu.h"
>>>>>>>> +#include "amdgpu_userqueue.h"
>>>>>>>> +#include "v11_structs.h"
>>>>>>>> +#include "amdgpu_mes.h"
>>>>>>>> +#include "gc/gc_11_0_0_offset.h"
>>>>>>>> +#include "gc/gc_11_0_0_sh_mask.h"
>>>>>>>> +
>>>>>>>> +static int
>>>>>>>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>>>>> +{
>>>>>>>> +    uint32_t tmp, rb_bufsz;
>>>>>>>> +    uint64_t hqd_gpu_addr, wb_gpu_addr;
>>>>>>>> +    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
>>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>> +
>>>>>>>> +    /* set up gfx hqd wptr */
>>>>>>>> +    mqd->cp_gfx_hqd_wptr = 0;
>>>>>>>> +    mqd->cp_gfx_hqd_wptr_hi = 0;
>>>>>>>> +
>>>>>>>> +    /* set the pointer to the MQD */
>>>>>>>> +    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
>>>>>>>> +    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
>>>>>>>> +
>>>>>>>> +    /* set up mqd control */
>>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
>>>>>>>> +    mqd->cp_gfx_mqd_control = tmp;
>>>>>>>> +
>>>>>>>> +    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
>>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
>>>>>>>> +    mqd->cp_gfx_hqd_vmid = 0;
>>>>>>>> +
>>>>>>>> +    /* set up default queue priority level
>>>>>>>> +    * 0x0 = low priority, 0x1 = high priority */
>>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
>>>>>>>> +    mqd->cp_gfx_hqd_queue_priority = tmp;
>>>>>>>> +
>>>>>>>> +    /* set up time quantum */
>>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
>>>>>>>> +    mqd->cp_gfx_hqd_quantum = tmp;
>>>>>>>> +
>>>>>>>> +    /* set up gfx hqd base. this is similar as CP_RB_BASE */
>>>>>>>> +    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
>>>>>>>> +    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
>>>>>>>> +    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
>>>>>>>> +
>>>>>>>> +    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
>>>>>>>> +    wb_gpu_addr = queue->rptr_gpu_addr;
>>>>>>>> +    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
>>>>>>>> +    mqd->cp_gfx_hqd_rptr_addr_hi =
>>>>>>>> +    upper_32_bits(wb_gpu_addr) & 0xffff;
>>>>>>>> +
>>>>>>>> +    /* set up rb_wptr_poll addr */
>>>>>>>> +    wb_gpu_addr = queue->wptr_gpu_addr;
>>>>>>>> +    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
>>>>>>>> +    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
>>>>>>>> +
>>>>>>>> +    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
>>>>>>>> +    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
>>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
>>>>>>>> +#ifdef __BIG_ENDIAN
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>>>>>>>> +#endif
>>>>>>>> +    mqd->cp_gfx_hqd_cntl = tmp;
>>>>>>>> +
>>>>>>>> +    /* set up cp_doorbell_control */
>>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
>>>>>>>> +    if (queue->use_doorbell) {
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>>>>>> +                    DOORBELL_OFFSET, queue->doorbell_index);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>>>>>> +                    DOORBELL_EN, 1);
>>>>>>>> +    } else {
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>>>>>> +                    DOORBELL_EN, 0);
>>>>>>>> +    }
>>>>>>>> +    mqd->cp_rb_doorbell_control = tmp;
>>>>>>>> +
>>>>>>>> +    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>>>>>>>> +    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
>>>>>>>> +
>>>>>>>> +    /* activate the queue */
>>>>>>>> +    mqd->cp_gfx_hqd_active = 1;
>>>>>>>> +
>>>>>>> Can you use gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()
>>>>>>> directly or leverage adev->mqds[]?
>>>>>> Let us try this out and come back.
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void
>>>>>>>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>>>>> +{
>>>>>>>> +
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>>> +{
>>>>>>>> +    return sizeof(struct v11_gfx_mqd);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
>>>>>>>> +    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>>>>>>>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>>>>>>>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>>>>>>>> +};
>>>>>>>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
>>>>>>>> index b8ff7456ae0b..f8008270f813 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
>>>>>>>> @@ -25,14 +25,14 @@
>>>>>>>>      #define V11_STRUCTS_H_
>>>>>>>>
>>>>>>>>      struct v11_gfx_mqd {
>>>>>>>> -       uint32_t reserved_0; // offset: 0  (0x0)
>>>>>>>> -       uint32_t reserved_1; // offset: 1  (0x1)
>>>>>>>> -       uint32_t reserved_2; // offset: 2  (0x2)
>>>>>>>> -       uint32_t reserved_3; // offset: 3  (0x3)
>>>>>>>> -       uint32_t reserved_4; // offset: 4  (0x4)
>>>>>>>> -       uint32_t reserved_5; // offset: 5  (0x5)
>>>>>>>> -       uint32_t reserved_6; // offset: 6  (0x6)
>>>>>>>> -       uint32_t reserved_7; // offset: 7  (0x7)
>>>>>>>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>>>>>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>>>>>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
>>>>>>>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
>>>>>>>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>>>>>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>>>>>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
>>>>>>>> +       uint32_t ib_vmid; // offset: 7  (0x7)
>>>>>>>>             uint32_t reserved_8; // offset: 8  (0x8)
>>>>>>>>             uint32_t reserved_9; // offset: 9  (0x9)
>>>>>>>>             uint32_t reserved_10; // offset: 10  (0xA)
>>>>>>>> --
>>>>>>>> 2.34.1
>>>>>>>>
