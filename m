Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 08:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6726610A5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 08:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6726610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C3A6F3AE;
	Thu,  7 Oct 2021 08:26:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642F26F3AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 08:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc+XWrpoh0N4SbR/tl+uDVfkIm/4RF5MP2g+9eUWdQvutzixtdt1Y36xVKTaBsfJiMlMP4mNjYlA/FhIf5lIdq4ACKPsqIPbjGIBvhvI9ubHDtZBfWCci/IWnKggJAqSDKpRw8cxePYDZMXmqmaF+ZL2rK3tmaOD3sqOgMB/iRnbnKm6o8rkUKgB2c/AbVVot+CJdadyxCiMzw1LZsDqXnA9/ao43jFkEtIxzfaVDQQk3vy5Fu7THaqUhNseDLuTvAjKAlegSfsmWBb+RR9N+8xIBmYuGJFPGcWNj+uDRhdTX6qm3DgT01/02KGXs7Sy7rnnP1PlTm+kb+NEfjaI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2PCyVQjJqJjsi0mHFfRb3JHIZeyE+OiC0Gs/5ej9rU=;
 b=JxaxoYADEYkYv341jj93oZpZFu0+5oAIhCaGaiTlPSZUKXFTpS6bPQv/Azu8WwVW0hPn2jBWrCWnXmzBsepJbg7Wal7Tfzu6Ra3mhqQARQ0DOqXqgdvdYCwN5o+eVhWAtafD6qJaf4g+CuH2qAUaN6RjrPyRXUe4yZuJq5qcqQaKcWVeibef2Lkwtb5FNPt05xEERpl3Oy0lDu1hZY+ihsso+2T125FXTRqcxFx4QEUk1k26WpD8WD565SU5F29jXfv6I8vLRwqbyIgIPhGKz7HXk5LY6R68ma4F5Gyzxahl/0GLBpK2o1le5IWO5frU84Nx+Vs7nT/O+lumeI/OGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2PCyVQjJqJjsi0mHFfRb3JHIZeyE+OiC0Gs/5ej9rU=;
 b=eSqyvCU/aLE+t/9rqrQH5qbtZbVIwzVkylqthrRGoDHAq+PajZMFLI0pem74+yHrrpZtmFOJEM3WHOgDn3nthVF/uEdC6hcgGH/mqa0sXytkWHA1f+Sgrg3KHsL2hM1mIcd9JLsq2hyU9+hoPJhdDSkr3sBBQeAB7R08CmM5F+E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 08:26:06 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 08:26:06 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: unify BO evicting method in amdgpu_ttm
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211006160408.118395-1-nirmoy.das@amd.com>
 <0cd580cb-b8ed-0694-23be-2128cafae69e@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <22995785-e28f-a100-97c2-c17b3dc83cfc@amd.com>
Date: Thu, 7 Oct 2021 10:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0cd580cb-b8ed-0694-23be-2128cafae69e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR0202CA0064.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::41) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.87] (217.86.121.191) by
 AM6PR0202CA0064.eurprd02.prod.outlook.com (2603:10a6:20b:3a::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 7 Oct 2021 08:26:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcaafe4f-b8ad-4592-941c-08d9896c1b66
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5069F3D703C16ECA4337F8C98BB19@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zO+ae6O+tsjqPlDAc3GonRJkkVDQWzyI0B+HeTHc03UXh/7FXzvN0IVBG7aAVGi4YIGlCjb8lgEztvJ+lRP/ISj6TWRwFrhNQA0S80zBfjh84w5TQNALNANMkGviub0XMFTOYTZIkVRe51mxeNZ/WZxObMlZzBpoedjL5vSvLMlcYAQsu60gHK4yDHasTzGf6uqAIQuAJ/4mO9OPiDVlEl6acdvowROA50RjkB6cxt+PTj7CgHPqfBTgXgvO5Kj30clBlRIA19VSTdool3IucV9SQoTgWizAD4C2va7ptU+v6V65fbuu00j8zmz1JKO0OQy6ByuxF7skv6Rabqp/c3/EGJhnXaaWLIBgSQfL3hv2g05Ak+RUT+nz+CIKN+2T/fh9zpylHls9finX6RR5GMlcI7c69G3LFmpXHKyHjHKgEF32acZvMQEHvhRqFADvAQDTzklNHnFj6KQSArfXT8WAPsupCIBMwcTpVT24n6WHrHZhlWnGF8udCTUyivgEXtisYlopqpXVbXSqJ+nPlhL5/1O/ZsYMHy1we1xrMb0Z+WT2yGlyNZGiPuxpzxRIqtxZDgrdPE5brZT5n5C0hfFfnpXlRpTcc5EMFAg3iwgEJwSeGFNapiDhyTWMcjCy60+TLScSZPL66jUI8qegRfKOCdHq3GRQDOUWXZv48f5nJ89NqS2FGcRBfYfLHVZy/9y7PK/46djtVWXoQiqhCvVuWrFzZAMW5S+0g4Mm9LCSjvgi0ltBvwapyI7sj3vdp1U01RWD2PqYfeLajjs0Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(31696002)(8936002)(6486002)(508600001)(6666004)(66476007)(66946007)(66556008)(5660300002)(8676002)(83380400001)(186003)(16576012)(52116002)(31686004)(36756003)(66574015)(110136005)(316002)(26005)(38350700002)(956004)(38100700002)(2616005)(53546011)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUZmZlg4MklFMTlULzVGUkV0Ym82c3ZOT1kvbDRsWGd1cVJmQ0VyRG0zd2xI?=
 =?utf-8?B?Nm5RNFM2U2R3aldLY3lVN1FGakRycjh1Zlp3ZkF6ZENTRTgwQitTZ3RUb3Ro?=
 =?utf-8?B?MVcrcm1MU1J0ckVKM2NPa2paYW5RL3QvVm5ZQWJzelFVMFFoYTZDZHlDR2k5?=
 =?utf-8?B?RFZoRHR4aWNUd0U1MEo3ZHEwSHVDa2J3MkQ5MFp3ZitZTnZ2cjZHOHVuY2Iw?=
 =?utf-8?B?ZktwTjVFb3o3dXFUcm56T1dMWjhqVm0zZnAxTzQzYTN2cy8yOEpoRjZIVUNF?=
 =?utf-8?B?SmZrT005WGc5eEtvdFJ5OWNFdnhSR3AwZ3RpU3V6eFUwTWVROEFXQkw3VWNk?=
 =?utf-8?B?bElUQnUrUGFGSVp5UlZQS0RHVWpyQUVNaU5xaEM1elYyMy9XbFpiNjFMYUF1?=
 =?utf-8?B?ZXdYZXppQ1p6VjRPNE5hc0swV3AydC9iM28zWkZCd2dSbzZIam5xb2o3Mnli?=
 =?utf-8?B?Y0RDR2VFZ3FQaUJOMG50VWh4ekFHTGVDVW1rQzdtay9rNmdDWDR5NkgzQzMv?=
 =?utf-8?B?MGNVbm1QSzYvazBDUmZ1VTduREx0U0ljZ3N4dWV1bS9NWHcxL25IOTdVVkxC?=
 =?utf-8?B?SUQvQVpzTXY5L2svL1pmT0M3MnpnUlc0Uk5DYmw2TGl1YVlRR3VRdTJJblNN?=
 =?utf-8?B?a0EwVVNWcno3QTZJS0dGN2dtOXplcHFoS0ZmS2NTMkNUQ3RRa1BYU2xZc2RB?=
 =?utf-8?B?SmJvQ2UwbDIzRjFCNDdkN002dGhscHNuc2hXWVVraGVYL0tLLzdSanVVdzd2?=
 =?utf-8?B?RFpWc09aWTEwdkFWOWhVTnlVSmJqeVNsM0h0YUM1QXBBWEs1YjZ1WEExVith?=
 =?utf-8?B?ZWVqQ09xdkFwR0ZldlVMeDFKTWQ1VUlnRHhYTjg1alJHWFd0Zkt0NFF6Mjlm?=
 =?utf-8?B?TmcrQVZlZ2xMYlFzSVNpVkorcTVXcElqdUdwNWx1SXZYSFlBR1I4YmtnVUxx?=
 =?utf-8?B?c3FsVXlsenVhdnhQL3h6UUVhWTBZVTByaHNZNk5ZMDR0dTNJWitDeVJZT0th?=
 =?utf-8?B?QTlXcUkyODJ6WHlqZGM5Tlp5UWh2blpKSTJ5TFJMcGtITHQ5ODd1S0NHS2hO?=
 =?utf-8?B?S0dhMWhmVUY0RHkwdHk5dkJCRFZiTndQMGtyUTJzVmhnUVo3VkVUWlYzaVlO?=
 =?utf-8?B?R1FCdGJ1Zlc1dnUvZGFWcnRGczQ0M3dLUVVwWjhrejNjYUQyV1lnYXBUWEFC?=
 =?utf-8?B?SnJKMUpOTG03SkM5TzFrdHlMaXZlanJ2Z203eXFoVjV6L2QyYVdMOWJZdzB2?=
 =?utf-8?B?RnFzY3NvSXJPQmNBY0F3cW9tSUxJZ1RmM2ozRWFuekp2NUdJTit6bXVveFgr?=
 =?utf-8?B?YjNldm5ndm1aaXpKOU5mMWZJVE1kOGVZUmx0T3FRcTgvYmlhdWpFVHNISG9I?=
 =?utf-8?B?NDBiRDVHc25xVVhmWWZFQUxWUklBODZ1ZGtEU1N5dTA3TURwekJKMGJyK2NL?=
 =?utf-8?B?aGx4dXBnNmZUcnRqeTFzdUxUWFRSdjRNaEZKS0lxL2s1L05HUGFXOHpHWHJ4?=
 =?utf-8?B?Ri9ZeWFyKzQweVdRUStIdjZxMEo3dGZPRmY4Mm5UdmJZRlk5VUpYamRESlBQ?=
 =?utf-8?B?R0Rub3pGN0pkRGlzZzFCYjVtZlZVRjFpbXYyd20wMjhtN2pZNjJZbVc5b3Ni?=
 =?utf-8?B?TVF0S0lRSWdyanZGV2owbFZHdmJOMTV3TWEwcjVpREV4VXp3UFRtbXZVNXFI?=
 =?utf-8?B?eEFkSlU4NDVRVUZaVUlUa3VNQktJWGNNeW5JNkRNYXVoSUN0M2FkKzJoUnl2?=
 =?utf-8?Q?9ROHmuldVWBz9BY8uI6GFAooA6eSLatJwdrXa4Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaafe4f-b8ad-4592-941c-08d9896c1b66
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 08:26:06.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCC/tegCyJrZ9Z5sXG2QbihJz4yPP9Ftrcxdamf9Hm/s2yr9srCWS0eoKOBZXEvFA5T+E1qBJsVa1y+pxYj70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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


On 10/7/21 8:08 AM, Christian König wrote:
>
>
> Am 06.10.21 um 18:04 schrieb Nirmoy Das:
>> Unify BO evicting functionality for possible memory
>> types in amdgpu_ttm.c and remove corresponding function
>> from amdgpu_object.c.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 23 ----------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 30 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>>   6 files changed, 36 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 5497e2d31d1a..22f3de29d783 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1328,7 +1328,7 @@ static int amdgpu_debugfs_evict_vram(void 
>> *data, u64 *val)
>>           return r;
>>       }
>>   -    *val = amdgpu_bo_evict_vram(adev);
>> +    *val = amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
>>         pm_runtime_mark_last_busy(dev->dev);
>>       pm_runtime_put_autosuspend(dev->dev);
>> @@ -1341,17 +1341,15 @@ static int amdgpu_debugfs_evict_gtt(void 
>> *data, u64 *val)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)data;
>>       struct drm_device *dev = adev_to_drm(adev);
>> -    struct ttm_resource_manager *man;
>>       int r;
>>         r = pm_runtime_get_sync(dev->dev);
>>       if (r < 0) {
>> -        pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +        pm_runtime_put_autosuspend(dev->dev);
>>           return r;
>>       }
>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> -    *val = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>> +    *val = amdgpu_bo_evict_memory(adev, TTM_PL_TT);
>>         pm_runtime_mark_last_busy(dev->dev);
>>       pm_runtime_put_autosuspend(dev->dev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 57638fe9cfc2..c441ebe9da11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3921,7 +3921,7 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>           amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>         /* evict vram memory */
>> -    amdgpu_bo_evict_vram(adev);
>> +    amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
>>         amdgpu_fence_driver_hw_fini(adev);
>>   @@ -3930,7 +3930,7 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>        * This second call to evict vram is to evict the gart page table
>>        * using the CPU.
>>        */
>> -    amdgpu_bo_evict_vram(adev);
>> +    amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
>
> Those two call are now missing the "(adev->in_s3 && (adev->flags & 
> AMD_IS_APU))" check.


Thanks, not sure how I always miss such details :/


I will resend a v3.


Nirmoy

>
> Probably best if you move that into a amdgpu_device_evict_vram() helper.
>
>>         return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4ec904f36ceb..073ba2af0b9c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1004,29 +1004,6 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>       }
>>   }
>>   -/**
>> - * amdgpu_bo_evict_vram - evict VRAM buffers
>> - * @adev: amdgpu device object
>> - *
>> - * Evicts all VRAM buffers on the lru list of the memory type.
>> - * Mainly used for evicting vram at suspend time.
>> - *
>> - * Returns:
>> - * 0 for success or a negative error code on failure.
>> - */
>> -int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
>> -{
>> -    struct ttm_resource_manager *man;
>> -
>> -    if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
>> -        /* No need to evict vram on APUs for suspend to ram */
>> -        return 0;
>> -    }
>> -
>> -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>> -    return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>> -}
>> -
>>   static const char *amdgpu_vram_names[] = {
>>       "UNKNOWN",
>>       "GDDR1",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 8ff61bad4138..d787e0e89e0b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -305,7 +305,6 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
>>   int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>                    u64 min_offset, u64 max_offset);
>>   void amdgpu_bo_unpin(struct amdgpu_bo *bo);
>> -int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
>>   int amdgpu_bo_init(struct amdgpu_device *adev);
>>   void amdgpu_bo_fini(struct amdgpu_device *adev);
>>   int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 
>> tiling_flags);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index e2896ac2c9ce..545b4bdeae07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2034,6 +2034,36 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>       return r;
>>   }
>>   +/**
>> + * amdgpu_bo_evict_memory - evict memory buffers
>> + * @adev: amdgpu device object
>> + * @mem_type: evicted BO's memory type
>> + *
>> + * Evicts all @mem_type buffers on the lru list of the memory type.
>> + *
>> + * Returns:
>> + * 0 for success or a negative error code on failure.
>> + */
>> +int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type)
>
> Rather rename that to amdgpu_ttm_evict_resources().
>
> Apart from that looks good to me now.
>
> Christian.
>
>> +{
>> +    struct ttm_resource_manager *man;
>> +
>> +    switch (mem_type) {
>> +    case TTM_PL_VRAM:
>> +    case TTM_PL_TT:
>> +    case AMDGPU_PL_GWS:
>> +    case AMDGPU_PL_GDS:
>> +    case AMDGPU_PL_OA:
>> +        man = ttm_manager_type(&adev->mman.bdev, mem_type);
>> +        break;
>> +    default:
>> +        DRM_ERROR("Trying to evict invalid memory type\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     static int amdgpu_mm_vram_table_show(struct seq_file *m, void 
>> *unused)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index e69f3e8e06e5..9ec7531bf131 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -190,6 +190,7 @@ bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>>   uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct 
>> ttm_resource *mem);
>>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct 
>> ttm_tt *ttm,
>>                    struct ttm_resource *mem);
>> +int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type);
>>     void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>
