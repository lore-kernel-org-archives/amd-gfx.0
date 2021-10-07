Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88CA60F58
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A88CA60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242CF6F400;
	Thu,  7 Oct 2021 10:59:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAA26F400
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 10:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpDuYrM5OGQlpfbIVKc/VRjoUX5fe4U8BKcs9Y1WmZYUCppaRt0IViOip8dYjqsD1zTtPjR1rUGnQQMpkUKP/iHMFHTNF6HHy9bfAMZzu6N2y/1mGNNnQaf7oKpSSlSnbtvVEJnOuRpVJP9Gcdvm55C38Dw4zmctsx4v5Jtw7FelCffnx/hbnTdUd7Kw2KmUE358ONJQ4vitD/8gQ4+PiLCLk9fBL8CpJkhTWQBW8sFt62Hb/IaaX9hxfqNPBTAGP7aMFX4xwHklS61Ns0Sv3xdSAqtAFflQhg4g6cOOZlyGSrHLa/YJOyg8c3hlniTVkgVLG2P+Azqc06l4wHm6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykMYeOLLVxsv5GaDHltnlzFdUsHbs4zpR7fZPd5NFeE=;
 b=alhK7o3Ftn6buhEnWogHlEq51R3MP9yPhwBiDI6vooJIAq3LdVF0LsL3fPR5HloHvP5oQnSXDZMUZhD31Fi4GH9rF2PY6UO3kMPSBHNw+OofAujOKpPU1weNjMKkbT85UNqAEddG+O+Ys+9cFUACM93U9WWl29pG2hsVZDA2cEf3nXBbbBNqd8BLwribe90tMYTmxWEmQ8+A+U0Dy5Hx+Z1yTwk72XtJKCQwqzYcqg2V7dssPkLyT+rgWM36b2O4Vuzmt00tx7gRbRPeP5A1yZx92OEvJpshooXwyhFZYUD7u2N3+631aFRYGY6je1A2qcekl9XKJEERuhjGd6TKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykMYeOLLVxsv5GaDHltnlzFdUsHbs4zpR7fZPd5NFeE=;
 b=hqCmsRNeKY9VZRAE+rdegtkindA2La4WRimw8AXRHLpn3YT3NS9/IRgxqSMBgZRs8sUJvxYTORCVN1R+qP4Jn6lvFz3tNWYPhdqUdb0Wn93/hd4JVCyFsTEW0EzBHFNRKuQHNKf2gX6/YLl3/UBn/HCcXq8YJvb9NWj9ws9iDFs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 10:59:30 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 10:59:30 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: unify BO evicting method in amdgpu_ttm
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211007100032.8140-1-nirmoy.das@amd.com>
 <722d6f33-4353-768f-1509-cc82e81654cc@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <4b6452af-9028-e591-e6bd-13928575bf8a@amd.com>
Date: Thu, 7 Oct 2021 12:59:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <722d6f33-4353-768f-1509-cc82e81654cc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.121.191) by
 FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.4 via Frontend Transport; Thu, 7 Oct 2021 10:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e499e64b-eca9-4f1e-0c4c-08d989818993
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55361684AE15CB8E427FB0878BB19@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKStH9vgIkxIEwsQOgqhi5duclSWXg/qfy7qEElwTDGitLBUpbsjwXdzHjMYbGP/o+JnPMoa1N+q09PrqJ9Qbe08GqslIpmoIqbTqUvqDe6ui1ceZdAAHayPv+dnlTLosIkPxkClLBNRwE1XgMZASzNv/HgfP4jBrCMuXVn0WR8OWSm/Y42nXYRlD+FfOf9Yinq4rSVHaIyxa4jEz3y5MAAEw1wZdNxrP/+jq3Nhj4cm2Tz9b0synjA0d5U5QFkxGcmagXqG4TmGruWCu5O6ATKC/mmhmddiQ44taHYC6BePDnnCL1MhZjsGbQXrFSBla4BemSRxIVw8n8JKEEftG399SQoTaO29cSuEMz/qI/ox+Z1xmAQtVrt/05p8lYVYR/jTA6q11tq+NdyDtYJqQDS0NH34fOH82qQsTXTybkZMpdjgr8/VhuUa/Clha2XvMfNmFAXWO06+Q/JR4pNdeUONzV3p/pVK4Uo9hcPcMqcR2RyNEST3Yjk9Dy4YRe57Q3lp5yLXSU99gbyOQEECyzhipItgXZhid+/yh/IuHgqMinDoVQkArqtkIU/lFMZb2yyguGktqg9vgxPKE3L7vUqcTo8BwcpdYY8KgO6T7gyXfKmA78cKzdzvDLISWVxiwP76X1EKBVtFWmvWhvXM0XXg00YrtU+B8dIM5J38phWm0PosebznbAtNocKEOPnM9jbTlSd0iLZRro2TRH2hasnIsI9s8c8aKXGFWDKQeVDxPh75/btVpYUDcC7DGZE2MjOAXIKWVc+hdslPngP8cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(5660300002)(6486002)(8936002)(8676002)(508600001)(66574015)(16576012)(316002)(53546011)(86362001)(26005)(186003)(31696002)(4326008)(38100700002)(38350700002)(2616005)(956004)(6666004)(66946007)(66476007)(66556008)(52116002)(83380400001)(36756003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdYVFo2SUJNbllwSEdKMEhkeXpoVjRMK1ExN09vOE9TTUxGVDhYNjRFM2hM?=
 =?utf-8?B?SVJSSVNNT1BHc3d4MkxEaUFsdERiTUJYUzE3bTR2RHhkVEwzMXR0Y21ROGhY?=
 =?utf-8?B?R2VtbVY4OXRYOW04UXVXREFUMm5teEhJam5sTnRQanlERFpIa1h1ci9mUW9W?=
 =?utf-8?B?TEJ6WUFDUUJST1U2UFMyZFVXY3lMZy90aWFQQ3RoRFBaL0xMNXFqVHFGamRu?=
 =?utf-8?B?WmJKOTJYYm9lSTBwM21IcVEzUGhnaU8yMWFLZUZlTlZmR0tobTF6UjlFSGpZ?=
 =?utf-8?B?VnhPNEZPcWxlMEI5Q2ZkTmxpVkFNRjB3TEZjVmNXVDRna2tQbXhlUWFUNHhY?=
 =?utf-8?B?MUpoWTBaMUh5eXowK1duRFpVQStHZUhKSVZ3UnAzOEQrS1U5d3FHWHRudzFX?=
 =?utf-8?B?NlcwZUR5SmduUVArZVVyOFVGQnBxaDV1R0Y5blk4TmozcWJUTnJvZUxMNW96?=
 =?utf-8?B?bGRrck05Q1lYZFh3ZEx0WmZqbDd1d3hLN2NiTE1MbGpJaUNWTG10MVBLdWd6?=
 =?utf-8?B?bkZDYkdJRUpaOTFkQ21wczc1eTlZTXlCbWcyMnh4dFNBVWhWNThpcUxZN3Fw?=
 =?utf-8?B?eUxoa0c2RlkxejlSSlZlemZGL2NMUUwyNHVudUlodktLd1ZvZGQ3THZMSnZV?=
 =?utf-8?B?L3g3NnFHOFZFdUIyNXhxNDZZYVpKS2s0Z2FKZ3lTZUJTRU1BNTJWMXlla0s1?=
 =?utf-8?B?M01FZ0RXTkNmUHhYT1kzb0NRNzZ1SytGRFlIekVnUnFkcHF5UTBrZ1pqU3di?=
 =?utf-8?B?aDh4UzgrOHcrQXRONEJKa2dkemNEOVVtTkl0SWtqcDczUktDcnNTQ3RkS3pr?=
 =?utf-8?B?bUlsKzRaR0ptOFZZN2E1S01VenVmd292WDlXQmtHVVFLbEQvY0hwZFdiZDQv?=
 =?utf-8?B?QU1HN3VQc0FqRGJYZWRkSHE0SW9CN1FFRTRNNDBrMjhRYm01QTZpOEdCYW1i?=
 =?utf-8?B?eFBmSGhwMGhoT0ljOWJBdGlmQ0VzVXdacUxCemh0WkVpYkJNTmhPY3F0NFpB?=
 =?utf-8?B?ZnlHMFVxQjFPYjNVZUdubHgwc2hGZkNGRTQ4RUpzR1VzVjUxay9YQmxOQTNq?=
 =?utf-8?B?ZDVUaEkrMkl4NmhCdHlVb3VPMHlwMHRqU3ZDb2FwNmw3US9UTDNOdjhLNHgz?=
 =?utf-8?B?UUhSaVVoZ296aDBjaW13RG9JQ0xFMFlmWXhmelZJZHhydXJaNnpHc2k4ckIx?=
 =?utf-8?B?c3Z2ZjlUQVYrNGpJNXI1ZTdtdklQV2grVkhwQUR6WXpkRTR6MWVmaUV1Qkl5?=
 =?utf-8?B?T0NxejdKWE5wMnptbTNlb0t4Z2luQlBQa08wbEVpQVNHTW5qTUJTalNxY3Fs?=
 =?utf-8?B?ZE5HQ2VpazJ1ZHZTQzJKSzNRb09RUHo3VkZBQWtMR0V4L3E5R3pBNDlXWTl6?=
 =?utf-8?B?RkhuN2V2ZlF5R0lBWXJUeFVpT1d1R3VvZFlXbmpBcUlhOW5KVTRTN2pDWE9x?=
 =?utf-8?B?OVl5MGlDZmpVSDArSFg3bUliTTNBSUx2Mis2emRzOEJWUFBXUkgvYUpId3Uv?=
 =?utf-8?B?YkVoL0dQOGROUnkvQVFTTmhBUis4YkVaOXRoZVBRbHNWK1ZpbUpvZjNwbTVZ?=
 =?utf-8?B?cHB5dEJOdTZFZFZWMUdKYUlIUUg4OXcrMUxQNEpRNm0rVmxNV2RxZXNjRXdU?=
 =?utf-8?B?Z2lOWU9uY2FjUkNqb3dEc1pUdkFXM1BYSmZoZys1d2lpd1V3STBhcmZsR0NQ?=
 =?utf-8?B?bktOV1psMWxvcVlvbjRNNXp6NVJ0NFBRclJFemJkajlQNGlzdTNHUEVFS09i?=
 =?utf-8?Q?W6BWrDzu9DnqJ0KR0ioUDEM/aKHcstWgthjBk8O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e499e64b-eca9-4f1e-0c4c-08d989818993
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 10:59:30.4016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkbvLKxB6cx5B5m67eiMr/nr3RyuvoXbJfjVlv9MvrlScxqQQCCbEPtomLOxmTsLdbXDUlAHHLBl4NyVkKvBYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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


On 10/7/2021 12:38 PM, Christian König wrote:
> Am 07.10.21 um 12:00 schrieb Nirmoy Das:
>> Unify BO evicting functionality for possible memory
>> types in amdgpu_ttm.c.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 30 ++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 23 ----------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 30 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>>   6 files changed, 58 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 5497e2d31d1a..164d6a9e9fbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1328,7 +1328,7 @@ static int amdgpu_debugfs_evict_vram(void 
>> *data, u64 *val)
>>           return r;
>>       }
>>   -    *val = amdgpu_bo_evict_vram(adev);
>> +    *val = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
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
>> +    *val = amdgpu_ttm_evict_resources(adev, TTM_PL_TT);
>>         pm_runtime_mark_last_busy(dev->dev);
>>       pm_runtime_put_autosuspend(dev->dev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 57638fe9cfc2..032deca4cea2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3880,6 +3880,25 @@ void amdgpu_device_fini_sw(struct 
>> amdgpu_device *adev)
>>     }
>>   +/**
>> + * amdgpu_device_evict_resources - evict device resources
>> + * @adev: amdgpu device object
>> + *
>> + * Evicts all ttm device resources(vram BOs, gart table) from the 
>> lru list
>> + * of the vram memory type. Mainly used for evicting device resources
>> + * at suspend time.
>> + *
>> + */
>> +void amdgpu_device_evict_resources(struct amdgpu_device *adev)
>
> Please add static here, apart from that the patch is Reviewed-by: 
> Christian König <christian.koenig@amd.com>


Thanks, I will add that and push the commit.


Nirmoy

>
> Thanks,
> Christian.
>
>> +{
>> +    /* No need to evict vram on APUs for suspend to ram */
>> +    if (adev->in_s3 && (adev->flags & AMD_IS_APU))
>> +        return;
>> +
>> +    if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
>> +        DRM_WARN("evicting device resources failed\n");
>> +
>> +}
>>     /*
>>    * Suspend & resume.
>> @@ -3920,17 +3939,16 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>       if (!adev->in_s0ix)
>>           amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>   -    /* evict vram memory */
>> -    amdgpu_bo_evict_vram(adev);
>> +    /* First evict vram memory */
>> +    amdgpu_device_evict_resources(adev);
>>         amdgpu_fence_driver_hw_fini(adev);
>>         amdgpu_device_ip_suspend_phase2(adev);
>> -    /* evict remaining vram memory
>> -     * This second call to evict vram is to evict the gart page table
>> -     * using the CPU.
>> +    /* This second call to evict device resources is to evict
>> +     * the gart page table using the CPU.
>>        */
>> -    amdgpu_bo_evict_vram(adev);
>> +    amdgpu_device_evict_resources(adev);
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
>> index e2896ac2c9ce..bd5dda8066fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2034,6 +2034,36 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>       return r;
>>   }
>>   +/**
>> + * amdgpu_ttm_evict_resources - evict memory buffers
>> + * @adev: amdgpu device object
>> + * @mem_type: evicted BO's memory type
>> + *
>> + * Evicts all @mem_type buffers on the lru list of the memory type.
>> + *
>> + * Returns:
>> + * 0 for success or a negative error code on failure.
>> + */
>> +int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int 
>> mem_type)
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
>> index e69f3e8e06e5..ba5c864b8de1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -190,6 +190,7 @@ bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>>   uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct 
>> ttm_resource *mem);
>>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct 
>> ttm_tt *ttm,
>>                    struct ttm_resource *mem);
>> +int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int 
>> mem_type);
>>     void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>
