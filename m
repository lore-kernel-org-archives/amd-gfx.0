Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD52FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D0410EE8F;
	Thu, 30 Mar 2023 14:41:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5E610EE8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alU4Up1vyjXehxR2aYMqlQv1/1h1sahlsP4O2GLlXVkTKhMjBWHgA9QMxlWqxf9QrUo3J629ocFnHa2Ao6WriMTzA2rSIDFTmhJqPL+kEvIzwC4/nEU9D/04A0e1Cl+YHVVEC7m2ETxnRC0pD4YJFj9M439WPnGZQHwY4/9H5TLs+n0BtWIeahbRbYX4Db3ONpVt2gdevar9vFwsib0wg9qrcw3f3ULjjb5QlkNIJ55pD/MhXG7pm1g/PXV1F5yCVKNLiOtgqDGK2qja9AxJCcurjGGjJ+ZMZEzXwRiCgAd0WlAN/v5ETNrJv/Y0EVe5oPA8S8TFqvEHasHlqe0FTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTSp0ELM3Lb+Hi/QKJ7SVZzbOKXcktv9yOjoPnAKr+I=;
 b=lg08uM+F8CradV/VB8UsHN1nWi/Xnz/gYg97SwoOavyZBgX/V8s+89HEMh3Yv3NRDx6uLhJrSVIOV2nRgZ1oKTir+TnK1pr3M5wAffUZc4MPrI/ey6OqTWYugnH1I5NBj+WrEkRQLRqsClhPBxwTTXtNfF4sHT/kVMs1TjZe3KnREIiZY9f9PhvXVeLvQNREtqL2fnHNl+xvxa8quOmJYj1NLs1ZKg68HwA7fXabWFvvINOEPIXf+ieuPTFa7DkfqNr2HweGv7fOefDsuRNPc24GnladAwkVhQIP/1ShoJiEABe5pjj2DqrfwxM/McYQj2AvHrnjh2K3vQx1P0L5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTSp0ELM3Lb+Hi/QKJ7SVZzbOKXcktv9yOjoPnAKr+I=;
 b=lSaoJPoq1AfLswnDKKa9L6BdnfLFgcXntiblm6uhzmSS4cIGH6zX1xgRbtNgsuQGto0Qt5Fzp9Gdsi9tyx/8ACHlUWi30y1jJEDKQ3BJL2w82l+G+XozK6CUCneJidU9nUk4a3S25rc86ZTWJ/dH65bIHtmnlH5GwoLevE7+pqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 14:41:01 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:41:01 +0000
Message-ID: <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
Date: Thu, 30 Mar 2023 16:40:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dfc775-7781-4170-0760-08db312cc811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrs8t9yy+AEGN6m0TyIbaAjLGTwctiba0tUpjpzgwwWEyAe2rkNXapcErqJt4e0SjhRNwyeobXIP/ZIZ+WAaUr5aR3l16irtAcQb90FMMCsGZ5qQrDXNOOaiXvU4c+9s8AGMp4ZgMrm0cb9jzevZ5hfSputaGbCDrx1ie9IGgVLYukUsY4B2UZrJhyMVnP7Oet0YApHfZ8m/CXGz38yh5n5EfBxOd8m7v9r8s4niAXSzR7VWrfolzRwiZwwfynwhrwdgBCzefUnEpoZk1bTmkQblHXoPRBqSs7AK+1X6hckF4UVoqie3ET89NgZpboTd9pfy+5GT+kxPCkbPgIBWCfx4MsNB4fFNfsBtSp9nnAsWErNMLcEJS1gYkjFqGJ7kqtXKaSDycOKvBbXD6wpm9pR6+6Z3tgXmnib9UMtHQ3CVNyBqUFWiu8wQV8BlkS5QHIWsmYvyGPS9aZQKurvnC+5TKcljrOGrrlDQQaO7U5RIjrJJ+bdoVCsTfhmxz70k27rECghZgVf26rmZXxd3V9HWpBKMezDNqW41/SIlqP65oQDTIYPw2eLc84RHiacK3+DhV7M4as6hiZsv3lmdx+GDYRoZE0Ct3jTAAB6LOoIHMnHFlf88bg+VvppfqrrMhlnkPJlewADnyX0XBQ7D2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(36756003)(83380400001)(2616005)(6506007)(6486002)(478600001)(316002)(53546011)(186003)(6666004)(26005)(2906002)(6512007)(54906003)(5660300002)(8936002)(38100700002)(66556008)(66946007)(8676002)(66476007)(41300700001)(86362001)(31696002)(44832011)(4326008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUpNeWNtbkd0V0tJVGE2WlFsdUZ6Um8xYnpuZTZyWTJ4dGlYanJ1VEdVdVpG?=
 =?utf-8?B?WHRkUDJZM3I4NDJRQ2srYjF3WTFVV2Mzckx4UWo5ZUJ2VGFvcGljSUlEY2Na?=
 =?utf-8?B?eFpCOWFSOWNVZ3BNM3hnVUJaN1lUQkt3ZzRoeHRiRFlkZnBqcnFvQmdqTHNw?=
 =?utf-8?B?OEIrSGdGOFVlelNMOHRRY05SaGpucVRNQjJDU1NodVozMDI4dnlIYkZ2YXVW?=
 =?utf-8?B?KzZiSGdPQi9WMVRWMlhtWTZIbFM3NW4xSENBRVhnRCtNT2drOHBaMjBvQWxs?=
 =?utf-8?B?ZzFqT2Z1bE1TbHpuYWdwZFhrRUoxM2VJdDViVUJRRHdxNXo4d2J2K0VGWDFT?=
 =?utf-8?B?eGhWTDZ2TUxoNFVhT3hBb2lxbkpLUmZuMTAzTUdQdkhIa0F5YVgrSWVlSGNs?=
 =?utf-8?B?ZWVyZDZ0YUZxdmk5cUhXTURCU1BDaUxrT3IzYnJWM2c5dXdOUVFEbVhKbkJv?=
 =?utf-8?B?LzNQQnJic3VrM0c2amIwNEh6ZWg5eUFaS3NhbnpNQXJaTzcybTdQQlRRRzBS?=
 =?utf-8?B?L3dRMEhuVlFEaUxkWEhpc3ZtcW9QbG9XamlVVTVESGo3eDRuaWxzd1h1Z2kv?=
 =?utf-8?B?VVVkT0ZaNGc3MjN6WEUrazNHK2RaQitWeGozMlNqdFY2Qk1ydHF2V1FIS0Jn?=
 =?utf-8?B?UEQ1WlBKYzBJbjcvZGZoRXZRYkJBYW5zWFpKdTErZlZ3RVNGRVJhNitFRm5G?=
 =?utf-8?B?ZlltWG5ZOUJDNlc0OXlyQWl2Q1RJSEtKV0c3dDIyZ0s1MkEvc21KS05zaWlk?=
 =?utf-8?B?UGxVNzc1a1BkWWVVZnNrNlh1ZzhWTHFIQXpBMmg4VXVna2pUdlNHMm5qbGdU?=
 =?utf-8?B?Q3BkOVlFNlRoalRYZjJPS1kvMTBpU2w2S0dBUGZMVGtJWDZUQ3R5ak12NC9U?=
 =?utf-8?B?N2VRQm1HOWVFTTdvOUtoUWlZMTNORHJZZXJCRU1GdTUweVUyYU5ub2g0NEtT?=
 =?utf-8?B?U3BzL0xsd01BenV0VE9ydTRhU2ZCUFBZc3NVV3JneE9XdXcwS1FVVitDWDdJ?=
 =?utf-8?B?ZGZiaUwzazkrU2pTM1pFc2VqZ2IvU1owMER6TkRaNVZ5dmR3R1dxdGNvRzJ1?=
 =?utf-8?B?Q0JsQmdvb0s4a3k2TUF1U1dUWmJ5ZkxHUVMvRkx5MWZ6dHNrZW9aV2VhaE1N?=
 =?utf-8?B?cGV1c3JKaXZyWWZ0dFQ1eTlLdEI3ZDBCSXdzQXRlSXh3NWhLSDhIbFB6emUz?=
 =?utf-8?B?ZkoxUWd4OTdQeVBSRUFua25sQmZsaDVoYjFzT3BDdFBLNERNNWR2WHE0a0FV?=
 =?utf-8?B?aG5sNWJpaGtER0lUUUVKVjUyZ01QdkgxL29zUzBBQTAxYUFkUWthM3lOMitm?=
 =?utf-8?B?bjhaWkFnUVVEc2UrR0txRVI0bkpreEdYd0l2OFU3am1Jc1BqSE1XOVViN1Q1?=
 =?utf-8?B?azdaL1h0cTNzcDBRSWNTSkhwcnNpdnFFb1dNTVVGWU5ITDdybmRiSkZhS1F0?=
 =?utf-8?B?KzRsckdHZjgzZWRSNXhaNUl1YVl0a2JXTmF3aFlJSFdJck8zSDRKbG5TamUr?=
 =?utf-8?B?K3BOcmVaSDhIaVpncWxZTzBFZ1hkcEpNdEZlZUx1YlpiTGJYUTZYMEhkUXFO?=
 =?utf-8?B?WWRraDVzV1JDVHdEZUtKMTNjUmNRV3V4NmRyZ2JHWlVKYkx5d29TY2l6TDBh?=
 =?utf-8?B?eDlRTTMwUllES0UyOUlMT1BaUjVWd3NtMWYxcnRlWnd0b3lSNVQvUTNWRERs?=
 =?utf-8?B?WmlBamdxZkwvSEE1K2YyT3JnNU9Ockg4ZUFoQXVRTUNNZkpUSGFNMGV5TWdx?=
 =?utf-8?B?NndnRjFENXVsNFhLRG14UktLVlZHc2lmSkdtTVhlZHdyR2tUZ2hSZmJRVFNB?=
 =?utf-8?B?M0ZSRlMyRGtBS1FLcXBUZnJPaktDbHo2OFVqWmpGYS9PcExnV3FscWZYR0RW?=
 =?utf-8?B?dGxEU2RJTGJuS04vai9xRzVST3hnbmpvaEpHVjRvNkx2bkxWcllFZm1LdytC?=
 =?utf-8?B?U1J4TmY5WjM5RHJKTWRIejBVY3piQzJkTFBBeVRtRkdvRjVGQ1VLQUJKT0Fz?=
 =?utf-8?B?Y2RRV2tJS0pkVEEweHBuVnNydHkxc1hlUGZOdFBlUDREN0Zad3FhVXd1MXRh?=
 =?utf-8?B?Vy9Ed2U3dk9MYTUzYk5kVUl3OEc3Vm9Mc3RMVmVhbmNONnhibUlhbDltYUtS?=
 =?utf-8?Q?By3KBuUQL4p2F73ZEnzVsjTe1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dfc775-7781-4170-0760-08db312cc811
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:41:01.1304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKNQ+0thcFrGZNtKu+e+jq7TdDn+ZNq7F9RuD6WohgotWoDkPUL8GqWq73+oIR3q39/wW+D15Cl3YKsoU3KCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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


On 30/03/2023 16:24, Luben Tuikov wrote:
> On 2023-03-29 11:47, Shashank Sharma wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch:
>> - creates a doorbell page for graphics driver usages.
>> - removes the adev->doorbell.ptr variable, replaces it with
>>    kernel-doorbell-bo's cpu address.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>   3 files changed, 57 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 6581b78fe438..10a9bb10e974 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>   	/* doorbell mmio */
>>   	resource_size_t		base;
>>   	resource_size_t		size;
>> -	u32 __iomem		*ptr;
>> +	u32	__iomem		*ptr;
>>   
>>   	/* Number of doorbells reserved for amdgpu kernel driver */
>>   	u32 num_kernel_doorbells;
>> +
>> +	/* For kernel doorbell pages */
>> +	struct amdgpu_doorbell_obj kernel_doorbells;
>>   };
> Here's an example where it could be confusing what the difference is
> between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
> As the comment to the struct doorbell_obj declarations says
> in patch 7,
>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>> +struct amdgpu_doorbell_obj {

What is the confusion ? This is the object which is holding doorbell 
page. There could be 2 type of

doorbell pages, kernel and process, this is a kernel one.

> Perhaps we should call it "struct amdgpu_doorbell_bo", since
> it does contain amdgpu_bo's, which are doorbell's bos.

This is not a buffer object (memory), this is doorbell object, so 
calling it bo would be wrong.

- Shashank

>
> Regards,
> Luben
>
>>   
>>   /* Reserved doorbells for amdgpu (including multimedia).
>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>   				struct amdgpu_doorbell_obj *db_obj);
>>   
>> +/**
>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Creates doorbells for graphics driver
>> + *
>> + * returns 0 on success, error otherwise.
>> + */
>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
>> +
>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 8be15b82b545..b46fe8b1378d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Creates doorbells for graphics driver
>> + *
>> + * returns 0 on success, error otherwise.
>> + */
>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
>> +{
>> +	int r;
>> +	struct amdgpu_doorbell_obj *kernel_doorbells = &adev->doorbell.kernel_doorbells;
>> +
>> +	kernel_doorbells->doorbell_bitmap = bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>> +							  GFP_KERNEL);
>> +	if (!kernel_doorbells->doorbell_bitmap) {
>> +		DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * sizeof(u32);
>> +	r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>> +	if (r) {
>> +		bitmap_free(kernel_doorbells->doorbell_bitmap);
>> +		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>> +		return r;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * GPU doorbell aperture helpers function.
>>    */
>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>   		adev->doorbell.base = 0;
>>   		adev->doorbell.size = 0;
>>   		adev->doorbell.num_kernel_doorbells = 0;
>> -		adev->doorbell.ptr = NULL;
>>   		return 0;
>>   	}
>>   
>> @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>   	if (adev->asic_type >= CHIP_VEGA10)
>>   		adev->doorbell.num_kernel_doorbells += 0x400;
>>   
>> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -				     adev->doorbell.num_kernel_doorbells *
>> -				     sizeof(u32));
>> -	if (adev->doorbell.ptr == NULL)
>> -		return -ENOMEM;
>> -
>> +	adev->doorbell.ptr = ioremap(adev->doorbell.base, adev->doorbell.size);
>>   	return 0;
>>   }
>>   
>> @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>    */
>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>   {
>> -	iounmap(adev->doorbell.ptr);
>> -	adev->doorbell.ptr = NULL;
>> +	bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>> +	amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 203d77a20507..75c6852845c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>   		return r;
>>   	}
>>   
>> +	/* Create a boorbell page for kernel usages */
>> +	r = amdgpu_doorbell_create_kernel_doorbells(adev);
>> +	if (r) {
>> +		DRM_ERROR("Failed to initialize kernel doorbells. \n");
>> +		return r;
>> +	}
>> +
>>   	/* Initialize preemptible memory pool */
>>   	r = amdgpu_preempt_mgr_init(adev);
>>   	if (r) {
