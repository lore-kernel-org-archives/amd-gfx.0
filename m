Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A00C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 22:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B36710E78F;
	Tue,  6 Feb 2024 22:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzNwqwBl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D86310E78F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 22:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg7sYmFhkM4nAaXPIkhPUEDiPvOeS374ekdkPh45Qz4uRrJ55+BdthnTsUPXjumsbZL8f1jznKv203danxSuSlu+RHlb6N2xWYfK2LXXX5mebakXWKeB9jr+tNZaGH2OfkDkOswqUzSfN2iOxrg87cn2iFfo3ESgneoCIW/cHoH4/sfxoAuB+B2BEcXEwMOneFDDqrWmR4l+uzo+jwwcnZUC4jXhqbt5CMl2roU+B+YVSNM4V9cAQb5SAId5ZL8gl/QUE29NIVOwhAy2AD6/5SmtDq0tJwVF5z4DXy/6P/ihdXgdR40kgdCld5tDf97M6QYjc44EK9OOQ3Dn9Sl+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXUP+06hrPbm4Gu3Q/971rb60lB+Q9ruZgZ2uLXjmH4=;
 b=h3TumaWF8Ie2UE6oKwZIZSfF5vISX9QqOnlJrNHDyrxtXt10fNzi8xwcszyog7qpAJLY5ROaLcE72iTtP2+uOSo6E1ciuOXCTSZ703ppIBTESVoMo3F2ZcUBwOHRjyYSLyeTZAvTH3s3cTwqRuOVzlHN4Jpg9ZyXimz66UDvc3ou4rnXui99MqdwOhu6qabEnZ4g/3Yd0rz/Ud3EXfATuL+ytY+VvUJE/1y+W0RGb+344aSyFmAUGfbD1FMgggqzwzc8e11VBW80NntbwiF32L7JlpaabPeN81DXgzIvsyVW97GLFcDKgxgh1baLnAhEo7x6XQ0nxZkAtoWlS7I+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXUP+06hrPbm4Gu3Q/971rb60lB+Q9ruZgZ2uLXjmH4=;
 b=yzNwqwBlHUVcJ876oTc2ZENQ9ylDJvW6wKmS/eW8J18trflkiOfuNBPBo6NBRatLM6T1kUCGg6B1aQDUs+gICNsOhLt8Hue0w20IhLPKJMerfnoRBeKp/VEr6eLpaBEM+TRddkzCYOp+tgYy0TCOvki3yXuZXfzfqhRSRoZHXvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 22:14:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 22:14:04 +0000
Message-ID: <1a160113-b450-4247-b4aa-3773cf881fa8@amd.com>
Date: Tue, 6 Feb 2024 16:14:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Set s0i3/s3 in prepare() callback instead of
 suspend() callback
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
References: <20240206213151.22499-1-mario.limonciello@amd.com>
 <BL1PR12MB5144221A0577FD5A0BA4726DF7462@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB5144221A0577FD5A0BA4726DF7462@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fcee42-c9d0-4ccc-028b-08dc2760edf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL5H3uUkcIKCejdD8c9vZjocMGyTVM4jgRpE7GixryJo4lXTqHJKeLByiPFgi5Gc9JU6PKMKYZtJwQ/ZtRbeuu6J/M9BS394+JXhSrqmw56IY+YIXIijwffHvHhXY6pYbbToWyxNScr1JhwJRxzEqeDcUaFMnziN+YW8Rmk12d2WeUiH6PZ8ehZy8azvqaRdVwadaCg0bAmkavdXwhABXbmPF/o6UG6RLLw5mjW658GqHRjrBASz+H9Te3fMmUwXYlLvBtWHcm2KKdwPvKD2L6K0BgO8cNuVppyfMX50Txjk5sUZPwgRu4d0PuXU6EXPKqodCAm8mC5gWlIfiUKHjGRvH35wKJYru8HnkHn8o+bX5dpnBm7MprbIO1t4OojFB2OzB9f92bqRFgRg6WG3ZWb+2WEPpKD1qYQI3PUfXj7eB2/sHuVV3au6nd6pt81TvmXLrpbMWtOEvhuvYLCUnBnFYZUD0/mGi1sWkMnBqqVn6ltKomdF0MLkDnPNzd1//gbwnJ6nkskOVM0gVDzrX1kQsAVdh01zZrEUUla35V3gY3xMwqekcID8nlzrltg86fDMRc2MwPrIRVnSQyBMBdFC3gJiPHm1C8+wUdeYzR4Zzvcgx7MQnB0jfIPM+2dB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(66574015)(26005)(31686004)(2616005)(36756003)(478600001)(83380400001)(6486002)(6512007)(966005)(38100700002)(6506007)(53546011)(110136005)(8936002)(66946007)(8676002)(15650500001)(316002)(66556008)(86362001)(31696002)(2906002)(44832011)(5660300002)(66476007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJZSzFWaTUzaU9CUzdkVC9XR2NUL2lJUVN0MXJkczZLTmpZd1JBenpKbHYr?=
 =?utf-8?B?U3IvL3lzSEQzMXBjRUtxTHg5eWhnMkE0SzdnazJsUWNtZ2gxcm5EQnVWZFhy?=
 =?utf-8?B?Mm9uZGU3bythdHkwTHdKS01IbnFiU2gzR1RwUm9mbDlHcU02UitRajU2SE5U?=
 =?utf-8?B?azI0R05JYWI0K0t6R3JtVmorOElwU3ZiQjNKaXBvMlpHOGd2b3dMMXFhUzJP?=
 =?utf-8?B?RzErb1hFcldZOW1sYkRFWEQ0ZGFXMGdubmJ2bTJWZnJ4Q0ZwUGpMSnZWaFdS?=
 =?utf-8?B?SWNoR2NMblVlM1JVOGxkUVd1T3hnNUVHL3Rkd25iN052MWorQjRmTnA4M01C?=
 =?utf-8?B?TDg4VFpKSW14OE1TcC90SFNjTjYzZEtzbGh4VFFxc2g4b1JLN1JwcWZHNS90?=
 =?utf-8?B?eDJEd29CdGpmUEVOcWlTSlIwNVUvcmhGSFhEd0Zld0pJcUw3bTIyMVg3QXN2?=
 =?utf-8?B?T0hrSThJaHdxS29uV3J0cVg0NVZKL1JzOGZ2ZTRQM3JFc3BOU1FCeG54dXpQ?=
 =?utf-8?B?Q0NLdHYyQ0dQc1dDK3h5Z21jQjVqdFl2TUo0MWlhc3VCZDB3YytwSXhNY1VT?=
 =?utf-8?B?V3JrM0hHeU9DUld6UElPKzJxZXV6b1JOTTBwdHl4SzV0ZFlGajJHUUNDcWxO?=
 =?utf-8?B?ZTFIcis0dWZBUFBVcVB0bmZoNFhlaVZSdUdGQ2tuNi9qNHVyTnBkb0M2Wmo1?=
 =?utf-8?B?TCtLY0RSenBod3l2NjYxMnBoNHJRS0Q1QXpRdGZiT3NOY3cwV1VRK21BM21S?=
 =?utf-8?B?MVFyd2hTWEhqeEx5V3dRVk14M1FNUjZUdnB6K2R3cVg3ZjgzMmVNdjlZZ0gx?=
 =?utf-8?B?b0ZHV3RVZjI4T2RFS0UvZ0lpMXNOc3IwZFFVdWRtREhhV0wyTk1qTGt6MkZQ?=
 =?utf-8?B?VHFyWTErWmVZOEVYcEs5bHR5Wnh0T3MxSnprZ1BEMnBmZDJBQWVLcnRLTE5W?=
 =?utf-8?B?aldLckx3dGtxNTZHRXBJVm9xNnF4eDgvOVFTYWw1NGhZZnpGSU4zQWFIYitn?=
 =?utf-8?B?WXFpZUFMT0t3NlNmeHlqRjRQQzdDTFpnUTNNUHlvTDhjZEsrOWtheFNwbHhl?=
 =?utf-8?B?SDNtK0xpMmdZMFNxNFJEbDR1Z1Y3U3grSkJEMllzcngvTXg3NUUzQms4YzFR?=
 =?utf-8?B?b2YzZlJ1aXNXUUwxTkJIU0FWVldqVnN6QUMrb1hGeG0wTEI3Ti9YL2lRTWda?=
 =?utf-8?B?MFdWU0ZhNVZBWm83ZGJTeDdWRWF1ZTM5dGtpZ1orWkhwekNWdW1XMTRBd04w?=
 =?utf-8?B?NVUwWFozckg4T1NUTWNIUWVrTXlQbnZPSnpFWXNDamRqVU91ZEdQQ0s4dEg5?=
 =?utf-8?B?anhLdjZZK2JZUFdPNjZPelZ0YzhoaVlPV2xpZkJORi9xOEJETWtobHNrZXEy?=
 =?utf-8?B?aUlYd2Q3d3NEYjBTbUJKZ3l6Vk5VMkdkSmdRbWVYdGwycGtCVFYyK2VlZlMw?=
 =?utf-8?B?UVNPWFYwWEdtYXAyOCtzR2lhejhXaktyWFRVa1RQb1BZTXFIUit4b1NMV2Vz?=
 =?utf-8?B?NXk5RmVzRWhrc0tIMy92bzlhSVFIbHBYcGxLR2JVRnNpZmdQekF2UXo1NGJr?=
 =?utf-8?B?cVRPRmNuRzcwMjFMVnd0VnByOW42YTgvNUh3MGI0T1J3Z1NucWpFeUh5SWx4?=
 =?utf-8?B?d1p3VTZBSzBoOHpVcmNJTnBpQ002ZzRFdGVCOWRJUXFDOWxjbU5wdkRnV0Zk?=
 =?utf-8?B?bkVheVlBTnZjVFhNaTcrSVZMM3I4ZVp3NVFKcVNXbnhVQmh1bTZmS0xndWMz?=
 =?utf-8?B?THlFVnlWQ1lCQ29HY1MxN1J5U2JSS3FQbVUxS1FBSFo1MWYwQWk5ZHVnd3Zv?=
 =?utf-8?B?Y2hMTEl3am9IZVZOS1NUZno2MmNoTFN1TUxjWlpVb3NTQnRrVThjTStDZzlE?=
 =?utf-8?B?TVNkQUtJOHVUTGZjR0p0V2dYOThRdkhaeW9wSXNFMGM3ZzY5U1ZCMCtSOEdC?=
 =?utf-8?B?R09OWGhDL1ZDOGNUUk52RnJLL2d2SE1neXRkdTdxMTZhTjlQczQrNlAvb2Jr?=
 =?utf-8?B?Q1VhVnRrbzExaVJVYUNGQ0RjbklkYTB2VitXcUVEV3FyZkRNSjlzUktpVy9o?=
 =?utf-8?B?YWlHNVAwd3BobjFvOUVieE8rT2VidkZ6eStaU1F6bTZvVXE1VU14WFhudm8r?=
 =?utf-8?Q?bqQUka6lDz6FvEavmG5CQL2oV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fcee42-c9d0-4ccc-028b-08dc2760edf1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 22:14:04.3937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9U9dfyb7Cepfd8xXhe9F36tyIF3fkdQGNh9Mn9/9PowJPF6rTa7mYFkaw6wp8Lx4HDqcrgkYf7Rfv7+POs3wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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

On 2/6/2024 16:00, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Tuesday, February 6, 2024 4:32 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Jürg Billeter
>> <j@bitron.ch>
>> Subject: [PATCH] drm/amd: Set s0i3/s3 in prepare() callback instead of
>> suspend() callback
>>
>> commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare()
>> callback") intentionally moved the eviction of resources to earlier in the
>> suspend process, but this introduced a subtle change that it occurs before
>> adev->in_s0ix or adev->in_s3 are set. This meant that APUs actually started to
>> evict resources at suspend time as well.
>>
>> Move the s0i3/s3 setting flags into prepare() to ensure that they're set during
>> eviction. Drop the existing call to return 1 in this case because the suspend()
>> callback looks for the flags too.
>>
>> Reported-by: Jürg Billeter <j@bitron.ch>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-
>> /issues/3132#note_2271038
>> Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare()
>> callback")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b74f68a15802..190b2ee9e36b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2464,12 +2464,10 @@ static int amdgpu_pmops_prepare(struct device
>> *dev)
>>            pm_runtime_suspended(dev))
>>                return 1;
>>
>> -     /* if we will not support s3 or s2i for the device
>> -      *  then skip suspend
>> -      */
>> -     if (!amdgpu_acpi_is_s0ix_active(adev) &&
>> -         !amdgpu_acpi_is_s3_active(adev))
>> -             return 1;
>> +     if (amdgpu_acpi_is_s0ix_active(adev))
>> +             adev->in_s0ix = true;
>> +     else if (amdgpu_acpi_is_s3_active(adev))
>> +             adev->in_s3 = true;
>>
> 
> Will resume always get called to clear these after after prepare?  Will these ever get set and then not unset?

You're right; it doesn't clean up.

This is the call sequence:

suspend_devices_and_enter()
->dpm_suspend_start()
->->device_prepare()
->->->dpm_prepare()

Errors bubble up.  In suspend_devices_and_enter() errors goto 
Recover_platform label.  This calls platform_recover().

platform_recover() is for platform recovery not device recovery.
So this patch is incorrect.

Let me see if I can come up with another way to do this without having 
to revert 5095d5418193.

> 
> Alex
> 
>>        return amdgpu_device_prepare(drm_dev);  } @@ -2484,10 +2482,6
>> @@ static int amdgpu_pmops_suspend(struct device *dev)
>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>        struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>
>> -     if (amdgpu_acpi_is_s0ix_active(adev))
>> -             adev->in_s0ix = true;
>> -     else if (amdgpu_acpi_is_s3_active(adev))
>> -             adev->in_s3 = true;
>>        if (!adev->in_s0ix && !adev->in_s3)
>>                return 0;
>>        return amdgpu_device_suspend(drm_dev, true);
>> --
>> 2.34.1
> 

