Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF368C71153
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 11:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCEB10E29E;
	Mon, 28 Aug 2023 11:31:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4397410E29D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 11:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSM454N6+/sEOM7CLYBj0RcsBm6K6a6GLdUW2yMo0Be14n6pVMek9bDyn1hDp+wG423r15X9YilVAqN1N78ULNkCxpnxF8sT07+D30OBzZ9+WHoZk1scZUaiyh8j9b9BBB87qgMljKEcrspKP0jMpLSAJiMgxxAOjY0svuA/Az+dqTcwhAyW5BrevM7Y4H1P/6cPKoLtnCGluyDBc+EkQrqmVytB98tbS6PF0Jh+fWAMI5pVs7FPJGcbl/v+GElBLk+/bA6r0zCBwXvmPPZVOsuJQ5kId8ZIPdpLkrSXRbBHFmhj93l8tHJBDwppEOFVKaXMX1QAepaZzW0z6SJcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpY7Rh1SjfqRJMdr+8QZLnDOtogUcT5FIBdTrhHNQJ0=;
 b=hBwuuPyKviex8BqnrHEi3uGBolYQIhkXzWZMNT1DddxzCvkRdppgHKa3x68oAyBGUPFGG33f8hV+tgatev4QJYFVUbqacNa3fa7hPxXfCidzy2ywgl+zoZxqlA4xTKn0gIAjui6yvzNsdIlJWULP3fkquTX/kBE71BRhM6Mk+fR0ppOyKuGeTD4TJy9uCl+FzmJ8zKn4r66TGIftcN5hzVsXHZMEbIMFdn0wsBGtZp03X2thenlKVKSuBb0WMa/XeBZQo8cjHimyEVJ6k/OOn9yQG53UUPBvS9E/3z44X4wpvyxqjoMtC7cQO3tqZtyyn3Db3sRiaX+75AXAUqrjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpY7Rh1SjfqRJMdr+8QZLnDOtogUcT5FIBdTrhHNQJ0=;
 b=jV2D8b1FLH+7SeaMnjz4dgL+5dz9aXBdQGmDjVexLrsL95O7RQzH9U5RW8qz8DL4PjM0B9K+U9yz0DWpjq6asQDuQkRKSfZnn1ysW//Ng07pmg9BzUuSTxh9ZS0v5lZWEh5JKWZR2QkqGfZloQHpuOAvUf+oN9C9ePf1tJiipb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 11:31:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 11:31:03 +0000
Message-ID: <a7d9611d-32a1-df24-2d7b-0031dde56cb4@amd.com>
Date: Mon, 28 Aug 2023 13:30:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Content-Language: en-US
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
 <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
 <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
 <CY5PR12MB6369567CA37A1148A55BC2ACC1E0A@CY5PR12MB6369.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB6369567CA37A1148A55BC2ACC1E0A@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: a29f0c85-7180-43d2-583f-08dba7ba42ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yb1Bu0OWx9oimKX+/MBa69HcH9myRgbdyrAdLV3OMhi/EJRp8QLdN9v4KAal5i4xYFXSJnjUEeHTPrLVqcxfFMcNOtYU5BYI4phQwllrWFlH11OitvfoCL6AKXdEgAi2s3exGy05+Oel20qQYRXT3R6TINpvqt1tiS4/0G+AvK+SAal+iEF+oxIRcOAQEO6qC7B6HhqwU8WMORd9b/OzQgjm6cuqt0PRRp2REze3VDXYUkbmH0P32w8gHb2stND7Va+ucEACjqfZ4XBKKqrHxzZyIvCvqnEd4H0k22cDU+BdjTfEZESUI2KRGx3TuFxW94wQDBFzHIVXu3ZFAmd7hJPy9KNIjqPk7NTyyceNBW/BwUzmp1Y+Dz55ru53sJUswmtY+2excCvQIiaVVRhdEEkbbm+sNEmimnTtDzfOCSbdAMhw4LzW/qV2S8LMbCj5Ld6iXryuaf6lHj2w+RBVgjReW8+rPyOc5wp7WCGB2SyhEo8V4CTmh+Q3cywVyfLDs42+S8rBqUk2K8v6go6GUuNAbOxZJCm1Noh/dcx2QLQsw4wUnt9qmRItEgfEdDGT08sdOIohvWkZL12YCuY/vesp0SjVSWeV6ZQXVg7cQpu9a+eepUtQ9Ubkb5yV8W4yAENA2+IQ54w4EYRFuoAZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(6666004)(53546011)(6512007)(6506007)(6486002)(2616005)(31696002)(2906002)(5660300002)(86362001)(110136005)(38100700002)(4326008)(36756003)(8676002)(8936002)(66946007)(41300700001)(66556008)(66476007)(316002)(478600001)(83380400001)(66574015)(31686004)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFKMVRRR244ZnM2SUFtd3dRSkxZaUNkOVNWQzZKLy9wOUxocDdySjNGL1BC?=
 =?utf-8?B?cFAzaGhZUlZwaXpnbWkzQUZxcmc0OGlWT0ZhTVBUUlJjZFRDSEt1NU5xckhj?=
 =?utf-8?B?RkFRbWNnTlZQaXY0ZWhrcHR3VHZudVJqT0U4bExydmlKL29MclVlN0xyYXk1?=
 =?utf-8?B?WkNaSHg3WkIwcG9LTVlUdjhNL2JYYnJ5ckJ5c05iUmU4cXJhOStLS213U0Ri?=
 =?utf-8?B?TDZpbThIeGR5WjlsYWRWMExINHVydkxPMUgxd3NtdWJoVDdsQnVQYXYyYzdB?=
 =?utf-8?B?KzNrb3JvbkZGb3J1Nlc4bm1Yck13NFJZeW1xcFdpaEQ2aDhXL295bjVtT1lX?=
 =?utf-8?B?SXVCejRJdjFmUDdyY0dQVytyU0NuWnpZTUU3VWdHSE9tMUUxamdnaGFSZkpk?=
 =?utf-8?B?d25pdVI4QU9iYUFzeHdmN0NXM1I1MWNsTDhXNGNpdndUVUF5UXIvcVVGeFU0?=
 =?utf-8?B?UG5UZjNNTXFwZ3JaM3creEhmY3N0bS8zdDhHOHhGN00yczQrOEVQL0NXdVdq?=
 =?utf-8?B?cFQzcVQxQmhFdXlUdkVTQ2xPTFhtL2Q0RVdtd0F6cU1IVG1ZQU1uN3JYNmRL?=
 =?utf-8?B?ajNzSUZTS29uR1VFWW9lU0Y1QzgrK216OVdnVGNnN05oTGdPWGVuZmVBQ0xV?=
 =?utf-8?B?WWRnRWlDMktWT1h0dUxjZjM4WUpLN1B2VkRzNmhhcmRhWTZmSFozdW5WbkNn?=
 =?utf-8?B?U1FzdHkvbFFDWkIvMzE5VTlIWlZZVUF3RzVaajVoenpXUUk2NE04ZzBEVDlV?=
 =?utf-8?B?REJDaHkxL3hjNDFLU3lHMitSSHFDbjlNdXo0ays4UGxRcW4yWHlzVFJncXdu?=
 =?utf-8?B?UjNMeHVuUkVUTVdSZVViMURVb0t3VU05TFhjcERGNFFra2FTMDc2V1MyOHdT?=
 =?utf-8?B?bTUwUVZGTyszcjl6NXpVZHV3Sm85M09FRlhzS1BCMUx0RTFaOEVQQkcxYkE4?=
 =?utf-8?B?aVVzaWxQbTdOY1lxMVJYWTA5Z1NpQWQyWEZINFBiUUhWQkFtQmJ0Zm0vRUxP?=
 =?utf-8?B?QUF0N2N4VmF3VmI1YzhWRDg4czlrQUI2TGZucWl2emkyNVJ6WUtxWU9lNVor?=
 =?utf-8?B?bCtremI3SWJvZHBoRGtRS2lqa21tSU11YUxPbWVkUTRMdVRkeEtaa05wQ3Qx?=
 =?utf-8?B?dzRaVGllY2JJaTFTcGRkcktTSytBRkFhTWIwMDB5L2JYc0pYTjM2VHBCZTdH?=
 =?utf-8?B?ZmQ4ekJGWkYxUk9aaDJidjRMNllMeU02NEozM3owY1MyL1dZSzdsUk0yOStE?=
 =?utf-8?B?V3Zsa2JhV2xNbEVJbXpDaWRDWGU2TGFmbDcwdXpmOTI2aUkvNUdjZXlwRlNM?=
 =?utf-8?B?UUZ6TTNPM1YyY0lhZWR5NHI4TVZmWndkeHJVSFgxNXM1TVBCbXgvOHh1QkIr?=
 =?utf-8?B?aWxpQ2UrWmhsNkRiOFEzMUxDT3k5RWx1TFRWd2xHbWVaNmVBbEtFczFtb1hG?=
 =?utf-8?B?UGVqTUZEcVVXdWpxeVlvMDQ4eEwramVIaWszRHN4aDl2cjhQN0hYMitiSkxS?=
 =?utf-8?B?QUw2RTkzT3RnL0s4Y1BQTldmV0kybmRGTFNUMmJDM2EyUGlKTE9oU1NjV0RO?=
 =?utf-8?B?MWZhaUZVUWs5L0p6akx3TG9iUVZzZ1pSbW5kbk91M0FrT0V3cFpxK1RXS2Yv?=
 =?utf-8?B?Y1RMUUtRN1lnRXpkSkp4c0RUR1JEQjZESEZWdmxzLy9ZdTFsVzh5ZVpHUjZy?=
 =?utf-8?B?VGFiUHFFNmVWRzVLNnU3ZDdmSzdjVWd6aVNlYU41YVVjWjFuT3o4ZGgzVXpK?=
 =?utf-8?B?S3pxZTNqVFlmNnNWaUZFd1dkZXRYYXFPa1ozVjlQVytlQkpxSFFyc20zWGgz?=
 =?utf-8?B?OGVqZzYvcWdnQy9pTjZhSVMxMkYwUFNZQzA5Q2dTdk9EbG42anQrZjRhTlFG?=
 =?utf-8?B?QXBGQ09uV21pUW5LVXl0TURJSG5HOFVvV3RnTHFlbmRUSUlnMWRNMWJjMmVv?=
 =?utf-8?B?d21NRzZVb0J5OGtpK0l5QmlEYWwrYkhEV1FyVWpycEtZUFpjZTVSUHdNQTdX?=
 =?utf-8?B?ZmFzRlhZQmt5aXV5d091SjRENTZBZUE5UTZ2c1NWQ0RjQi95ODR0d00zSVNM?=
 =?utf-8?B?UGRyc0xMc2VQcFRVMzVhZDdjQUwyeW9qMGpER0pxNzcvdmRHY2ZJaER2M1pm?=
 =?utf-8?Q?yO2cxQUWyyru31atODtzK0CfU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29f0c85-7180-43d2-583f-08dba7ba42ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 11:31:03.3678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVp+5P36t5mjoesjAqsSql2EFTdQiLWUOM160y/wOqjhQst/jn7yFrsTUKK1g1Zv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well, there seems to be a very basic misunderstood here: The IOMMU 
isolation level is *not* ASIC dependent!

Try to set amd_iommu=force_isolation on the kernel command line.

This is a configuration option customers can use to harden their systems 
and when this isn't properly tested we can't allow page tables in system 
memory.

Regards,
Christian.

Am 28.08.23 um 13:23 schrieb Zhang, Yifan:
> [Public]
>
> Not yet. It will be only enabled for gfx10.3.3 and later APU initially, IOMMU is pass through in these ASIC.
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, August 28, 2023 5:41 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gfx10 onwards APUs
>
> Is that now validated with IOMMU in non pass through mode?
>
> Christian.
>
> Am 28.08.23 um 10:58 schrieb Zhang, Yifan:
>> [AMD Official Use Only - General]
>>
>> Ping
>>
>> -----Original Message-----
>> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Sent: Friday, August 25, 2023 8:34 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gfx10 onwards APUs
>>
>> To decrease VRAM pressure for APUs, put page tables to GTT domain for gfx10 and newer APUs.
>>
>> v2: only enable it for gfx10 and newer APUs (Alex, Christian)
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 96d601e209b8..4603d87c61a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>           bp.size = amdgpu_vm_pt_size(adev, level);
>>           bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>>
>> -       if (!adev->gmc.is_app_apu)
>> -               bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>> -       else
>> +       if (adev->gmc.is_app_apu ||
>> +               ((adev->flags & AMD_IS_APU) &&
>> +               (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 3))))
>>                   bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>> +       else
>> +               bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>> +
>>
>>           bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
>>           bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>> --
>> 2.37.3
>>

