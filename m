Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6657EC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EF110EE9D;
	Thu, 30 Mar 2023 14:34:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DCA10EE98
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2ATQ7FiLvtqnh8TVmL5Q3XWTvOaNLqMTzM0aqNSaOTOamoDRyvwbtp9fNwT9M2XxhgWimP/tUS893eKLJWIqGDaMM0m6bJ1Hqt3nY3zqV3d59w8cz/eYLDkG48H1exq4t6q41s4+P9NHNla8weWY0qNYiXIXW9x8hNQ5laNLxE/l020u7f0/xFuMN+jBl3OQnGWSSTYZ3A1Bp+kED8kpJZPhbkM6P0hV/hT4luWAKhNfwJybay3jyxS7tKff36lzTre+yDOcxdefVsquofrGZNqlZVHhIUZUG537VyrEUMcgcyfqEojYj+C6yKguPh45pDb13hT2sJNfO/BzHz8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiKA1xyyxHg5zKwSP1m/VCmyCTC26iGc+LRlaIlXhpY=;
 b=T2RFXvAGkj4suXlC0iY+Ba80HV+r2xaloV5SPSRbPFanIqF6adG/pEZRO24m32fcuaZsyOVmXLW1K999i9BV/TxLucXKoTUFj0vI5ApxNnW4zt9lkz7PFHXEFRpxzMDrVnasdvqrHXaAH++dUHbfjnHc85RbpZrpwXjbMLxlMpryT34bnGQcnt7576pLwOMTPaP7intLShFVwYThHwTEkFzo1FRS60Qno45OYqSHMmseQ8nt8GH+LB/l2botTEPU8vRSflfWUCFZ0oL8ZhZbWg8w46jmqwAswnXEvOowVod8KxOsm47DueBu5PO8ZoEaj3RJGfEdODWNa6siN/rV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiKA1xyyxHg5zKwSP1m/VCmyCTC26iGc+LRlaIlXhpY=;
 b=BXOFBMdPnDBtDr048popP2OUcSWPY+XGylWnrjoIvJ5anoODTVqi8Nk4CLhNlh0xdJsT0PRZ5AORx+TvByy2fG3iFBKbnZNnR4bUjA0xIy0RkVxX65DWxhZ6XO03h9XnrbzaqhpKakNw+5+LtsB0iJk2oRFmJipRbO2vxfVJAq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 14:34:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:34:10 +0000
Message-ID: <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
Date: Thu, 30 Mar 2023 16:34:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
 <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: b6929aeb-6bf3-4fa1-1f16-08db312bd31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPE6Qk6YI5UBvfnkSOR5qvSWX4Gp/k3IkwryU1x245SUrzpU5ASTPNWH8P+gE+d6bGL/fThryjYTqdliWXrSurQ+UPMZeEAP+DBUU7sCsfLWtdyUGmnCyhEE9wtfyAgHzyf+RqV0zkc18r0JBri0VZtPSSILbKsP2vq+04yBstTg+YTUPLGwHnUD15VeG5zbR9bkxBGWoga9OMEgnJgK3iwjYBWx7Yp4Wq1I+NbSlMe/Fk6NwN2KRlB0KGDOq8L0t6BmrhzGJ2s04eQgQ6QRDqg/vgCTQL0GPkIqG+6OCtqXlAVoCeCpqQg074vMrMrJA8KBrpZtDQ3/L/gJYTSRocY3eUaU+JUCyPD/ecQ1Ts3nFv4CrxOEKqsDtujjY+rgR/U+yoOT4E5hFQoyRVuN0oPDa5gRdOKJwNdsxNA6EjivkDAKsGJAl2voZ4EM35o7tqNv/I8JP2sxmvmSKrGVKxvBCjLaR1GCeOoOP6r4yre7M0nOXqVSQEwL3zUyju2Hwo7qiehQDBbVZWsqnPMlEECCUud3P7M0qHjo6zq8ImV/mntT8vl1YKA5Ldx6vCBykO5W0f39LaOvrCLxSX83V599X5PLqlm3jnrP5PpayfLuGpo4K0P+nYNqagO0M3x8OTVoMKnP/oR0CBro9o9gAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(6506007)(26005)(6512007)(31686004)(86362001)(53546011)(6666004)(8936002)(2616005)(186003)(31696002)(5660300002)(2906002)(38100700002)(44832011)(6486002)(478600001)(4326008)(8676002)(66476007)(316002)(36756003)(66946007)(66556008)(41300700001)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU83RlQ0dW9KVWJMMWM2ZEFaTGNGaEtTS3UydkpCbHc5TzBPS2RFd1MvckUw?=
 =?utf-8?B?VDZFZ0UzV1hvMTg4NlAvaGd2cWNYS0tjamtiN2xIYWxod0Y3QmdiZm1LNmdW?=
 =?utf-8?B?M2IyNE9LUVNXdFVMQVh6L1FlT05taUdlVHJXMzM0bmlJRjh6eldNQ3BHVW94?=
 =?utf-8?B?UnhVQ3ZOSlNTUmtHTGdqNmd6SSt5bm9YcDhZZlBzV25xU3ZteGxLWnBXcGFy?=
 =?utf-8?B?R0tTb2pxZFFXT04yRHVRdWZOK2JQYzVTdzNjdTlNdzZQaGhTb3gvM3RSK2wz?=
 =?utf-8?B?RElGclRiNmhDOGEvNGw5cmZmQnk4dktzaC9RRElyRFNqVGNuVFgweDc5ZlhD?=
 =?utf-8?B?WW80MzE3S0NoWnZ4WkZWSERGR21jbVRxaXBMQjZEZ0prZXQwMzJoL01LSmVn?=
 =?utf-8?B?ekxsbTFZOTZaK09iQ3dDUjVqVnhlVFh4djJrVFhXOE9Qd2FZUUpBSFVtcmlS?=
 =?utf-8?B?cjdBWTRrSld5eStkaGVwS0RPaldEZldQWDhZbTZraWdNWDVFd0J5b1FYazNV?=
 =?utf-8?B?SGttcnRFOHV1S1dpaUFlaWRSbVU4eHo3UlRuWmcwTzk3bGJXSDVWcy9BalNs?=
 =?utf-8?B?bUxiUG9ubU9HMGtWUE9wVmMxS1pqUElFYkFTcHhVaTFYTFJUMDZlSTJSTFEw?=
 =?utf-8?B?UkJLcEZxWXA4cmRESHo4VWZDempJNWZPTWl3Tnk1SmIvNUVFaEU3aWE1d2d1?=
 =?utf-8?B?K0NZTDJsMCt2V0JJUFFFMXBmR01aaVpGbzhBZVQ0MTJROGpHZTdjbEF5Q3BQ?=
 =?utf-8?B?dnlkY1NMOEFhT2dXMTdqTlpTTThkdnQ5S1VNSGtybkdFVHNWenRIcTJra0g5?=
 =?utf-8?B?SDZWZGlad2hYeDhGc2hjVkFyd05TcGxBNjJqTlUxc3Y3Mi9kNzg0eGt2eGxs?=
 =?utf-8?B?Q3lEVjQvNFdBSWlCUGRFTlFFZHF0cVcrYkNwYTcrZ1hScW1McVVrUmRGYWNi?=
 =?utf-8?B?TnhVTUpETU42bm9WQnJqRVZNa3BQUlJvSlRGa01IQnp3RVkrWWVIRFBFUlFK?=
 =?utf-8?B?NkJoZ3JFcDU2WTU0MUpBL3NOd0ovc3VnVkVDc3owaEtTano2OXYwVlRqVVJZ?=
 =?utf-8?B?RENXNytvc2lPMC9vTGlZVWYrZmIyZ1M5U1d4ZGYwM3RHOW5leTVBV2dFMlhD?=
 =?utf-8?B?Sk9RYVJPb1hwbllKR0Y5WHM1SEx4d1NnQm5WNjNLdE5sSnk4TlhpYm82VHEx?=
 =?utf-8?B?K1lHZFdlSnUxdnhWeXVXYXltVGNiZ2lkcjZmMmJ1MEIxSmdqYnRUd2FtaTNy?=
 =?utf-8?B?azlucFpKUFJLR2JNVHhEemVOYWVQZEFWMUVOd2JoVzBGeEx6dnRad2tvRzl6?=
 =?utf-8?B?cVFwS09FZnNiTFhYK3JmRmt0eFNnbjdnbm5LUDFVeFJmclpDUGp3aXZ6WEI5?=
 =?utf-8?B?enFXUnZiSEdXS0pmZEo2UWIwY0VhNjZJaWgxQm5aYndjMWtSNzAxUmMvdjhX?=
 =?utf-8?B?OWRJbVora21CMVlhbC8xOW92WHJnU2hObnJIUmZUenQvOWtPcW5WakJLZVhE?=
 =?utf-8?B?aVIyUUlCNGdGVE1GL2g5b2JlRE4vQjlJblAxKzZaSUtqNExKRmVPUVliOVJy?=
 =?utf-8?B?YVNLbWQ1VW1vRm9rSXBNcmgxY0h5Z1YzR0dHT25zcGY2dXJ1WjhYL3MvRVAw?=
 =?utf-8?B?RUpYUkZ4OGtrb0FWMFNQaGxvazY2clBOZ1pac2pJM2haTStsbHo1N0UzUXpN?=
 =?utf-8?B?V0FlT0VuWXk1UzJTU083T0J3djN6Skd0djk4bStqS2l5d1M5RlNGWlBQc3d3?=
 =?utf-8?B?S2NOR2pqSW0zQVkvMFhNWGE1UVZGZXptcHdhciswSUIrTTlHOVhvVGR6NlRG?=
 =?utf-8?B?RVpRN2x2S1RST1BKclU2a0k4Vmhad2I0UWxiNzNUcTYxZXcxTFZZU1JkSjNE?=
 =?utf-8?B?WE8rMjZxK1BmZm04QmxMaStOV2hjOG5Gb09ZdkxaLzFicmkra1lQWllkLzhs?=
 =?utf-8?B?NVNIWnZzb2QySmpUcW9KNnNZb1VReXV4R0RrV2l6eC9MRW9FbWVWOUMwSkNX?=
 =?utf-8?B?aGEySWRHUXhDT1c1T3BqS01SR0JCTE1DYjFBOFp0cWNTVXFSVG0ySThPaFVp?=
 =?utf-8?B?a3Bvb0lKRzlXanBkRTRHZVhKV2txVVVSK2VvQzgrbUYvQlAzbklrQStKNml5?=
 =?utf-8?Q?16rgI2iyVHSQOVMWNayRkVbk+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6929aeb-6bf3-4fa1-1f16-08db312bd31f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:34:10.1902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhnYlmrkdJ+Q+rzAN8vKyCpkz5tudu5IQJPsje5CCra6+0HOs0gc5V+p7UT3noJ1oJEeUhKr++9zHMctxdP0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:15, Luben Tuikov wrote:
> On 2023-03-30 10:04, Shashank Sharma wrote:
>> On 30/03/2023 15:42, Luben Tuikov wrote:
>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>
>>>> This patch adds helper functions to create and free doorbell
>>>> pages for kernel objects.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>>>    2 files changed, 90 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> index f9c3b77bf65d..6581b78fe438 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> @@ -27,6 +27,24 @@
>>>>    /*
>>>>     * GPU doorbell structures, functions & helpers
>>>>     */
>>>> +
>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>> +struct amdgpu_doorbell_obj {
>>> In the comment you say "Structure to hold ...";
>>> it is a C structure, but then in the name of a function we see "obj".
>>> (Object is something which is defined like in memory, i.e. it exists, not
>>> something which is only declared.)
>>> This is just a declaration of a structure, not an object per se.
>>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".
>> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and
>> many more existing structure.
> The amdpgu_bo is very different than a structure describing a doorbell.
> The doorbell description isn't really "an object". I understand
> the enthusiasm, but it is really not "an object". It's just a doorbell
> description. :-)

amdgpu_bo is page of ttm_memory with additional information,

amdgpu_doorbell_obj is a page of ttm_doorbells with additional information

(it is not just one doorbell description)

I don't see a problem here.

- Shashank

>
> Regards,
> Luben
>
>> - Shashank
>>
>>> Then in the definition, you can call it an object/objects, if you'd like,
>>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
>>> "db = doorb_object[i]";
>>>
>>> Regards,
>>> Luben
>>>
>>>> +	struct amdgpu_bo *bo;
>>>> +	uint64_t gpu_addr;
>>>> +	uint32_t *cpu_addr;
>>>> +	uint32_t size;
>>>> +
>>>> +	/* First index in this object */
>>>> +	uint32_t start;
>>>> +
>>>> +	/* Last index in this object */
>>>> +	uint32_t end;
>>>> +
>>>> +	/* bitmap for dynamic doorbell allocation from this object */
>>>> +	unsigned long *doorbell_bitmap;
>>>> +};
>>>> +
>>>>    struct amdgpu_doorbell {
>>>>    	/* doorbell mmio */
>>>>    	resource_size_t		base;
>>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>>>     */
>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>>>    
>>>> +/**
>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * @db_age: previously allocated doobell page details
>>>> + *
>>>> + */
>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>> +				struct amdgpu_doorbell_obj *db_obj);
>>>> +
>>>> +/**
>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * @db_age: doobell page structure to fill details with
>>>> + *
>>>> + * returns 0 on success, else error number
>>>> + */
>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>> +				struct amdgpu_doorbell_obj *db_obj);
>>>> +
>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> index 1aea92363fd3..8be15b82b545 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>>    	}
>>>>    }
>>>>    
>>>> +/**
>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * @db_age: previously allocated doobell page details
>>>> + *
>>>> + */
>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>> +					struct amdgpu_doorbell_obj *db_obj)
>>>> +{
>>>> +	amdgpu_bo_free_kernel(&db_obj->bo,
>>>> +			      &db_obj->gpu_addr,
>>>> +			      (void **)&db_obj->cpu_addr);
>>>> +
>>>> +}
>>>> +
>>>> +/**
>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * @db_age: doobell page structure to fill details with
>>>> + *
>>>> + * returns 0 on success, else error number
>>>> + */
>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>> +				struct amdgpu_doorbell_obj *db_obj)
>>>> +{
>>>> +	int r;
>>>> +
>>>> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>>>> +
>>>> +	r = amdgpu_bo_create_kernel(adev,
>>>> +				    db_obj->size,
>>>> +				    PAGE_SIZE,
>>>> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
>>>> +				    &db_obj->bo,
>>>> +				    &db_obj->gpu_addr,
>>>> +				    (void **)&db_obj->cpu_addr);
>>>> +
>>>> +	if (r) {
>>>> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>>>> +		return r;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    /*
>>>>     * GPU doorbell aperture helpers function.
>>>>     */
