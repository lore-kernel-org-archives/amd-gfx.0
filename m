Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91AAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 21:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8CA60F6F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 21:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C8CA60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061546E499;
	Tue, 26 Oct 2021 21:11:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E0C6E499
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 21:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1fxCdxrX/UjaObLW/1mFXYVULOvPMGrG6YilsIyn9qlJwnfSAo68DaH33XUO8O/HIhRw0EN9Gx8RATXHbYOId6761i/KM+kiHIL470RLq7kfdYNtkko6xgbEgbLThPqUSptsYTEJ/noXPXkJEnhE/DGlaWvqq/8k+kM/8c0ewYW70+cZi1O2izdpjqpKFZh/UBXn9SfsphIBHHmtpavt5J5HtsMZXZ9c+SfSTweuvQ5RiIDGfQILWlK1GnWKCMsi5pEwiIejHtOIEYrC3fXNpDwQA4ru6EpVMCzq7veAB9m52HM61Jbw8bBuyL0o3P5bkDpdxCaIjB8gGJCL0DwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF8hv0R6fbOpQU6+uyeXkXzm4L/n/giHucZmxjQmBc8=;
 b=bvP8mSQhmgHuw/i9pW6FiBt9jpu4dTPC0Pft9oLd1OG2k0EiQFzZTUEyiJajXB61KtZGTHJrzDRJ6Il4PjMUB8Onf9cH2pXh3go3kKL9WyYBHWi1eCX9FfBxj+RTH08tsYvopq9idY7hdtfLbZAqhN5Q0GkPmXT342TWjKa0eblX4TuB16SiIZMVKQ2E89qRh6T6IHa6xEPNo17TAZR+2i/biQwlw7lpFGEKf3qBODukCfK9+t62mlAWZTsd0ZO59mz6lAV46fc4W8tMnFnENYLy/ZnvzXcBZhL9op1ZjIfwT/DtVH1CVhhQS9TygCjIuXdQVe7JsItzUkeHYRR9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF8hv0R6fbOpQU6+uyeXkXzm4L/n/giHucZmxjQmBc8=;
 b=BkoZdbX8z7nZrfFNi+fb1BNRslPG8j42QFemYqk7BYn3p/FNugM5ilI/uFueuU3jV0rIOgKLkc4JBzEYw2W8+skPqgHNll2z1vhSIpsYNak3TGt82PhkYASDsNb/YMDQeEKxP1llhUouMozpTioFbjLVcoOzTykfnhCPD0PAyBQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 21:11:10 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 21:11:09 +0000
Subject: Re: [PATCH 02/13] drm/amdkfd: replace kgd_dev in static gfx v7 funcs
To: "Sider, Graham" <Graham.Sider@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
 <20211019211334.1552825-2-Graham.Sider@amd.com>
 <03de6841-ab7c-dfee-824a-09499e986608@amd.com>
 <DM6PR12MB30675828D42D464E099AD4368A849@DM6PR12MB3067.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <116c2065-0781-a647-007b-176309370117@amd.com>
Date: Tue, 26 Oct 2021 17:11:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB30675828D42D464E099AD4368A849@DM6PR12MB3067.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::44) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Tue, 26 Oct 2021 21:11:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79870a7-f569-45f2-5fc2-08d998c521f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB281097A8F9727F9A5727417992849@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7VdhIBbu9ZeYYMAfV0pZS8cOhYM4w7Zu9Wm6qBaY6gGUqTWYbl6/SPrRylKQed9J+J7AdOJgAyUXfOWt2pA/8rkqMc403rk7lgXAzvJaNlhKwdQjJjXQmHAN59qphA2eA9mRvmriO7iluFZO1B7ZhLf8MUCeXMN5kX9/UnE7APdpCcu9wJPePisMMyMQ31FWU7Zninnpb1akV+9qWPGufT4htaujQ/6scs9fw6xN+gJuND3DKNILw1Iwr6FuncGPNuUmxHmHx7HYas4EdIGCrQ8K9wC4wFTd78xn/wTLatZQZWYpwiK7jBCqwTPcicxok7NNyg0IyaYmvWRjfLq02pIINhsZeltXFDfPSScju+0lircST0nJOjH8x8lEpu/P7AnO2lcyktbJ5xWtsa3XaCBU0E6APGekonQyXVydrysdm33weR2Cm1lzWfhq4M2qF39xbcX6B9kzXn2wf042MzzymMgfgPloFsrVKe0QdqQsgNhJ9gjXtuuWFYnsyAmqVrdVLvFyiWuYXII4FN1cN++UvUlq3GM5jj6IcJVvbqh4dcQD/JeSBybNtQIGJZHk4xVhBzx9VxMnJtH7CJTO/wlZqXy0SVwKKgy/0VR95rT3ODE78q/4OIpvmxLPwiA+ikKZKmQuF/H93wPnr392YFF7WftNrzap35fH5OrYH4bZlNSopCJe5SYEOcs+VuLUBReyTPg7Z7kYTe60GrZk0hQXS2vSW2ydHxQU/Sneq1O4KFpwRbOyEB0SLn2xpXM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(31696002)(4001150100001)(86362001)(8676002)(26005)(508600001)(110136005)(66946007)(2906002)(956004)(186003)(36756003)(16576012)(316002)(5660300002)(44832011)(53546011)(4326008)(66556008)(83380400001)(66476007)(2616005)(38100700002)(6486002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1ZOQlRQK1h4RmlWenBCMmNBeitaQnFIV1BvZyt4T3k2S3Z2MkpzYm5WMEVU?=
 =?utf-8?B?dkxmZzlDNVVvQ0NTQTdvalNWS3hOQW5leS8ybXRyc2cxS0VEdm9uc1hVTmRq?=
 =?utf-8?B?Z3M5MW5ESjFSZ3FlZ1NVbFowSlViZFRZSUF4TndlTHhWdWVNZHBFaFMzUXl3?=
 =?utf-8?B?VTJBRE1aU2MwTzlKbnYrekY2UHlFNE4vSDBYNnlFUnRnZkJ5elJZYWJnY2dv?=
 =?utf-8?B?TmwzUHlleDM4dU9hTWtxRThMMGlteTBCUldQcjkyRjZuRFFWWHo5Y2VkWFRm?=
 =?utf-8?B?cG83ZkZFaVZVa1JFTWQ5T3hHRTBTdDJxZkpCQlVqc25VdkVVbmJMelk2Q0RE?=
 =?utf-8?B?SWlzUDhxK0Y4ZkxRWU83aWtsR2o2ZTBwUnJkT1crb1NpbWhzT1VZeVdMRHcr?=
 =?utf-8?B?WFhLZzgyOW9zNHVaK3RvVElSYnVkSmd2VlpnMllxODJOZ1BhdFhRYmJDaU44?=
 =?utf-8?B?R2JqRkkyZGcwSWdVNi94MGtFQm45Y0kxd1dQN2NVSklDYy9WOW1ncExVN243?=
 =?utf-8?B?MTR1RmlWclFlajIwV1JOc1hTVGdtYVJsUEtaaHBvWnhzeWNpU1g1c3lCU1JI?=
 =?utf-8?B?TjE1RHlzWmN3RE9tZHdjcENadXlydGRWNWxBSHVwMHRzTXBPa3QvZ3Q0aHhJ?=
 =?utf-8?B?WHhiTnhiUEZHa0QrZUducG51ZEJmZW5ObXQxeEhXbVh6WlBDS1NPZE5XYlRz?=
 =?utf-8?B?NW8wR0YrUVJXelBvNzhsa1dtRks3eG03YjZsMFl3QUt2S2VBdFUrS2cvcXd5?=
 =?utf-8?B?VDZSWStINmlHL2VCZXY3NVRwOUhITXJnRldNa0Z4K2Rya2d0S3A3Mlo3QUFx?=
 =?utf-8?B?cGtTYmsreDg1MDJwQUszOUhuU2hWNHdzVkNEZE1NSDRpSmMyVTZiNEJyL1NB?=
 =?utf-8?B?aTRuRkhaRXFGQzQvMXhhYk1sY3I4WXM1YkF0M1hLZktid2VzdVd4UndwSDl3?=
 =?utf-8?B?TjF5WlkwTkptTWJWVG8xN2tsdG9Xb0JrL09DdGVSbGo4MC9FZzRJcVFINHR5?=
 =?utf-8?B?WXRmQ3A0eEE1Sm5sbkNKaldqVFV4U2RQNlpJdW5jRjYvd2lqR3ppS0dyek53?=
 =?utf-8?B?Wkhva1RFdGlzQnVURUpRaXdWV3I4dDdOWC96bVhQbE9mNHhxMUFNYmVQUEV6?=
 =?utf-8?B?cEt2V292dkdzTitETG5TaVZIVGlyY3lydVNFUDkwS2xjbzFnWkt6N0dMRWJk?=
 =?utf-8?B?NjBTL2NPdEo1WDJFODZpWGhmNEppK2NCd0M2MU8vbzdacXdhS2hqdVdldTl0?=
 =?utf-8?B?aUEwY2huZ0ZzNnNKS0VVZURHOFdqelg5NXB3NS9odTFMdUV6ZXZ0ZzUxdUxB?=
 =?utf-8?B?TzhOMkNJTjVhd1hFS3ZwN1phS2ZKTXpGaC9QOE9QTUZwWDZEVm1ZaEdLVVpz?=
 =?utf-8?B?U2hlQnMxa2hGWnV1UjhEcHFieG5NcnQ1a1FnMlZhVXUrYnlOVjFONnc1N0dk?=
 =?utf-8?B?WHI1ZHA2VmF4RzdhOUdGOXVYaER3UVd3VTM1OEFaM3VDV01uK3R3LzVFUjVL?=
 =?utf-8?B?ODdaNDB2bGt2NGsrQUJ0WGdoMFBuMXZLQmhzTFhQR1pHSW5EanFaTHpKYlB4?=
 =?utf-8?B?TTdoM3RGVlExZWxVdHVobmt5VWlmOTRtMTJ6NEtEZlA3VWxRd2hpa01ObUgv?=
 =?utf-8?B?VGlEOUdZUGJjUDBseURVdFFmMzQvamdvOFVyamg3ejFxTEd0U3R5TmtTWmFK?=
 =?utf-8?B?VTJ6bWJLSW9RY1RqZHhGbVVYSXlnNjA3bHo2MW5NRWRaQVhWYmNHZUY2ZmlJ?=
 =?utf-8?B?UFg2QTViay9YQzZjZ0VobGw0a0t1U3J0ckNGS1UrMkpER1hxS0RvMzYxYkRu?=
 =?utf-8?B?TzV2QmFJdFdsR2NkbW9lY1FaTzcwejc2cExycVdDUlBrRnBRa2J1cU8zc1g0?=
 =?utf-8?B?VC9CamxhWW40aCtmMFM5aUFrcGRSUUN5YWNIczVVVlNOUW8vNmZ6ekJySVJ6?=
 =?utf-8?B?bFVNOC9qbHNiaWdxU2RTZDJuY2kvYWJwVXg2Y3NLZm1SRjVHRXhTaE1vOU0y?=
 =?utf-8?B?ajFMbW90RWFpUVcyaURiMHc2UXhKS0k3b2dLQjdhVGhEMHBVUlJrNDUvbjJq?=
 =?utf-8?B?WlNjMS9yM291KzR6TEJpVkxkVlNkb2xMUFlnU3VKY0phcFlFbFptK09EQ3o4?=
 =?utf-8?B?Q2ZmbEFaVGVXdkpFNkg2TmZJSXBtMDBGNEQxbHo1djgwKytxcERsK0w4eGZO?=
 =?utf-8?Q?TAwsrPdLnl4slPsjyV17DlU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79870a7-f569-45f2-5fc2-08d998c521f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 21:11:09.8255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ3TG6edDiIywVBOmPzfNs2aUdedGoLbjOcSSaoiBX+uwE7luewey7lZvS1D/tURkf8OIZa6eHZxwSX+UrFHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-10-26 um 4:31 p.m. schrieb Sider, Graham:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Tuesday, October 26, 2021 4:07 PM
>> To: Sider, Graham <Graham.Sider@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 02/13] drm/amdkfd: replace kgd_dev in static gfx v7
>> funcs
>>
>> Am 2021-10-19 um 5:13 p.m. schrieb Graham Sider:
>>> Static funcs in amdgpu_amdkfd_gfx_v7.c now using amdgpu_device.
>> Doesn't this cause pointer type mismatch errors when assigning the function
>> pointers in gfx_v7_kfd2kgd? Those only get updated in patch 7.
>>
>> Regards,
>>   Felix
>>
> The function definitions changed in patches 2 through 6 are only used internally
> within these files and aren't assigned to any of the gfx_v*_kfd2kgd entries. Patches
> 7 through 11 deal with the kfd2kgd functions that would cause a mismatch if done
> file-by-file.

I see. I saw you're changing e.g. kgd_hqd_load, but you're not changing
its signature here, so no problem.


>
> Best,
> Graham
>
>>> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
>>> ---
>>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 51
>>> +++++++++----------
>>>  1 file changed, 23 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
>>> index b91d27e39bad..d00ba8d65a6d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
>>> @@ -87,38 +87,33 @@ static inline struct amdgpu_device
>> *get_amdgpu_device(struct kgd_dev *kgd)
>>>  	return (struct amdgpu_device *)kgd;
>>>  }
>>>
>>> -static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t
>>> pipe,
>>> +static void lock_srbm(struct amdgpu_device *adev, uint32_t mec,
>>> +uint32_t pipe,
>>>  			uint32_t queue, uint32_t vmid)
>>>  {
>>> -	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>>>  	uint32_t value = PIPEID(pipe) | MEID(mec) | VMID(vmid) |
>>> QUEUEID(queue);
>>>
>>>  	mutex_lock(&adev->srbm_mutex);
>>>  	WREG32(mmSRBM_GFX_CNTL, value);
>>>  }
>>>
>>> -static void unlock_srbm(struct kgd_dev *kgd)
>>> +static void unlock_srbm(struct amdgpu_device *adev)
>>>  {
>>> -	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>>> -
>>>  	WREG32(mmSRBM_GFX_CNTL, 0);
>>>  	mutex_unlock(&adev->srbm_mutex);
>>>  }
>>>
>>> -static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
>>> +static void acquire_queue(struct amdgpu_device *adev, uint32_t
>>> +pipe_id,
>>>  				uint32_t queue_id)
>>>  {
>>> -	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>>> -
>>>  	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
>>>  	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
>>>
>>> -	lock_srbm(kgd, mec, pipe, queue_id, 0);
>>> +	lock_srbm(adev, mec, pipe, queue_id, 0);
>>>  }
>>>
>>> -static void release_queue(struct kgd_dev *kgd)
>>> +static void release_queue(struct amdgpu_device *adev)
>>>  {
>>> -	unlock_srbm(kgd);
>>> +	unlock_srbm(adev);
>>>  }
>>>
>>>  static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t
>>> vmid, @@ -129,14 +124,14 @@ static void
>>> kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,  {
>>>  	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>>>
>>> -	lock_srbm(kgd, 0, 0, 0, vmid);
>>> +	lock_srbm(adev, 0, 0, 0, vmid);
>>>
>>>  	WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>>>  	WREG32(mmSH_MEM_APE1_BASE, sh_mem_ape1_base);
>>>  	WREG32(mmSH_MEM_APE1_LIMIT, sh_mem_ape1_limit);
>>>  	WREG32(mmSH_MEM_BASES, sh_mem_bases);
>>>
>>> -	unlock_srbm(kgd);
>>> +	unlock_srbm(adev);
>>>  }
>>>
>>>  static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>>> @@ -174,12 +169,12 @@ static int kgd_init_interrupts(struct kgd_dev
>> *kgd, uint32_t pipe_id)
>>>  	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
>>>  	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
>>>
>>> -	lock_srbm(kgd, mec, pipe, 0, 0);
>>> +	lock_srbm(adev, mec, pipe, 0, 0);
>>>
>>>  	WREG32(mmCPC_INT_CNTL,
>> CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
>> 	CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
>>> -	unlock_srbm(kgd);
>>> +	unlock_srbm(adev);
>>>
>>>  	return 0;
>>>  }
>>> @@ -220,7 +215,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void
>>> *mqd, uint32_t pipe_id,
>>>
>>>  	m = get_mqd(mqd);
>>>
>>> -	acquire_queue(kgd, pipe_id, queue_id);
>>> +	acquire_queue(adev, pipe_id, queue_id);
>>>
>>>  	/* HQD registers extend from CP_MQD_BASE_ADDR to
>> CP_MQD_CONTROL. */
>>>  	mqd_hqd = &m->cp_mqd_base_addr_lo;
>>> @@ -239,16 +234,16 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void
>> *mqd, uint32_t pipe_id,
>>>  	 * release srbm_mutex to avoid circular dependency between
>>>  	 * srbm_mutex->mm_sem->reservation_ww_class_mutex-
>>> srbm_mutex.
>>>  	 */
>>> -	release_queue(kgd);
>>> +	release_queue(adev);
>>>  	valid_wptr = read_user_wptr(mm, wptr, wptr_val);
>>> -	acquire_queue(kgd, pipe_id, queue_id);
>>> +	acquire_queue(adev, pipe_id, queue_id);
>>>  	if (valid_wptr)
>>>  		WREG32(mmCP_HQD_PQ_WPTR, (wptr_val << wptr_shift) &
>> wptr_mask);
>>>  	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE,
>> 1);
>>>  	WREG32(mmCP_HQD_ACTIVE, data);
>>>
>>> -	release_queue(kgd);
>>> +	release_queue(adev);
>>>
>>>  	return 0;
>>>  }
>>> @@ -271,7 +266,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
>>>  	if (*dump == NULL)
>>>  		return -ENOMEM;
>>>
>>> -	acquire_queue(kgd, pipe_id, queue_id);
>>> +	acquire_queue(adev, pipe_id, queue_id);
>>>
>>>  	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE0);
>>>  	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE1);
>>> @@ -281,7 +276,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
>>>  	for (reg = mmCP_MQD_BASE_ADDR; reg <= mmCP_MQD_CONTROL;
>> reg++)
>>>  		DUMP_REG(reg);
>>>
>>> -	release_queue(kgd);
>>> +	release_queue(adev);
>>>
>>>  	WARN_ON_ONCE(i != HQD_N_REGS);
>>>  	*n_regs = i;
>>> @@ -380,7 +375,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev
>> *kgd, uint64_t queue_address,
>>>  	bool retval = false;
>>>  	uint32_t low, high;
>>>
>>> -	acquire_queue(kgd, pipe_id, queue_id);
>>> +	acquire_queue(adev, pipe_id, queue_id);
>>>  	act = RREG32(mmCP_HQD_ACTIVE);
>>>  	if (act) {
>>>  		low = lower_32_bits(queue_address >> 8); @@ -390,7 +385,7
>> @@ static
>>> bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
>>>  				high == RREG32(mmCP_HQD_PQ_BASE_HI))
>>>  			retval = true;
>>>  	}
>>> -	release_queue(kgd);
>>> +	release_queue(adev);
>>>  	return retval;
>>>  }
>>>
>>> @@ -426,7 +421,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd,
>> void *mqd,
>>>  	if (amdgpu_in_reset(adev))
>>>  		return -EIO;
>>>
>>> -	acquire_queue(kgd, pipe_id, queue_id);
>>> +	acquire_queue(adev, pipe_id, queue_id);
>>>  	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
>>>
>>>  	switch (reset_type) {
>>> @@ -504,13 +499,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd,
>> void *mqd,
>>>  			break;
>>>  		if (time_after(jiffies, end_jiffies)) {
>>>  			pr_err("cp queue preemption time out\n");
>>> -			release_queue(kgd);
>>> +			release_queue(adev);
>>>  			return -ETIME;
>>>  		}
>>>  		usleep_range(500, 1000);
>>>  	}
>>>
>>> -	release_queue(kgd);
>>> +	release_queue(adev);
>>>  	return 0;
>>>  }
>>>
>>> @@ -651,9 +646,9 @@ static void set_scratch_backing_va(struct kgd_dev
>>> *kgd,  {
>>>  	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
>>>
>>> -	lock_srbm(kgd, 0, 0, 0, vmid);
>>> +	lock_srbm(adev, 0, 0, 0, vmid);
>>>  	WREG32(mmSH_HIDDEN_PRIVATE_BASE_VMID, va);
>>> -	unlock_srbm(kgd);
>>> +	unlock_srbm(adev);
>>>  }
>>>
>>>  static void set_vm_context_page_table_base(struct kgd_dev *kgd,
>>> uint32_t vmid,
