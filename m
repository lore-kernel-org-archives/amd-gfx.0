Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A71C54E49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 12:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7653310E199;
	Thu, 29 Feb 2024 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ml7S+q8Q";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FDA10E059
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 12:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fivSBL2fptunG34NAhe1SGfiknC7bXM5q2S0K2h3ZRuFnGYBOwytHIPQZ1mWWMyrnZuokjFfhp5vVehM8T93CWdOiCCNrhWseckurlt8pHzKSLPQ85hFBHnN/viOURPcP14OW+AL6oH9xuaQWokpgNteJoiI65Ya3ayDyLsNeLnDWm5gJPtefdJYFkkckgQZB4lDQ4SrBS+kzUAAJLkqnw2ZLmf9X4Qn7zQnoyhIh4ageB74nbz2Kh2eOtEXFcGlqAMGJTE0c11Qxp+VXfV2CmrP97iDCLXVVO/kUNG3Ninq+jxyJ4iMZ6SGjPx2hh4hXD7c2w4dUepCmJmhkGaoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL65cVSIIZIdzRu7djI6iBKpGj5r3T0dANpAMIWq8Wg=;
 b=EdhLFQB7XLSJw4J6r+x4LrFPEIKMuZdDnPSbJL/hXctUGE+H+yTX6WNQqL4dJgRFA9HyGT5j0MGzDEtI3b/oNjcp01tDiQoccdAzuAlDuwfy8dLa2bH9K8/SocxprQGs1rTZt74wWsPOXwJNXA3Q2DR0XcON9l3JOpAbYee25yxtIunAHURbd8M0o5q2FpsmAYtf/G02sz1QcwIKrxwLXN/7oo1a4wug6ttL54LNH+5F0Tm4MkHtALHVGVzLzQOgWlpMnIuyY7nMSOPPpRttmVaFzwZBIHe0VRuCvdNQ+6kU1nOForGZZxlaGaEpbLCDZlt47+GZGfdPxO7jNDREww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL65cVSIIZIdzRu7djI6iBKpGj5r3T0dANpAMIWq8Wg=;
 b=Ml7S+q8QlVDu5YyW1EBeWEMWb0f9U/7801DEAYZdxzaZXf3sJR74JXb1kjMd6oa2KpYopv7X+o4F8DQcb1s2o+xUKe64tcxlpYr45xYsxoTTEju47gZCaf5YVgtI4iOrxk6xQr/nGPs1QgBVMWiSYiY8urWTMYar6xXqdbnnBtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Thu, 29 Feb 2024 12:29:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 12:29:23 +0000
Message-ID: <ad21423f-7255-4c36-a59a-f6fec5199b79@amd.com>
Date: Thu, 29 Feb 2024 17:59:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20240229061941.1970301-1-Jun.Ma2@amd.com>
 <383ebb6c-b50f-4fa8-9555-e9b77c5a9778@amd.com>
 <c2115fec-385a-4a8e-b056-ec062b1f60aa@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c2115fec-385a-4a8e-b056-ec062b1f60aa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc2234-a8bf-4804-82da-08dc39220f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpyOqxbUxUuoBa2VYr53WUK7pRKw9oUq4LdJ5KhbXRe8yLep5U/sTAcsCxLJsDHHxSO+D5uqk2oYNdRC5jt/NS+Sbh1x+FUS61t9zhnsFsDt6gzLE/cPOw+rE3qDZcwFtV6wqPNweXOjFgIgN7Z/sQcQ9BWjna9pX619yWq0JexLQTWLAMXYDV6wQyuAuMJF63lgjmIsvW7QSEyfJzjmAuvN1aHiVT0pnqj47mUAe55OVgw+D9bJdOkIQxiNVuRg6dttYBrpRRSEP62vADvaQlUdnQ7pyCi0I16t/zGXiCt5VMOeKNugcxFbDb7pDEVWMZTEHTECtoVXXSQy6i+ghclooojz5xTdJRgo8vleAKyDgpAzPwQdLbHYwTKuXZIdlljVlMCgePvTQnDK7Hv4w0eqfEo4yqohYaMqFGCQsc+nC11YLaRYjgZKnybu20rpVssa4SkbPYMYYQlMtUfmSyR68E7RgWxBgMIR4GhG2xEyEPxj38pMnhX5WEqgXB2e1kRU1QAB5k/8DPxrsLDsylBaLKhVZmYugP7nGphFLr5cYDcvizkOnunCu9RYIFRBI6O5k2UMN0vAzojm8oX2UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlmdGpMa1FvY0ZmaVY3QkxIellFTjdUM1JYMm1JcHU1Z1N5eUZNNkpHNEpq?=
 =?utf-8?B?ekI1SkxncVhNeFJnaE5tTCtod0x2MnRkTFExQzNsWW1IZWo4bkZIME9oWnRi?=
 =?utf-8?B?RjJZYStYeGVuMVlnMXB3QmFXcUcvOUFQMXdjbkRCVWRNOEZYVU5TdzlvSEdt?=
 =?utf-8?B?RHZqSzVXc2dVaEdMUHF2MTVja29OWHVjemF3NytKWms0bWNua0tzazA0WHUx?=
 =?utf-8?B?MFlJOFNvMURrODN4czNBQlFkcUQ5TzhRS0orcGdIaEVYRjh3ZGhJbTZFaDhL?=
 =?utf-8?B?MU92Zll2YjNrUWVrWThlQkM5TGZzSHN6VHVLK0I1RjJ3eTF5Q3JDSXVFcHc2?=
 =?utf-8?B?RGdLQUxFK3NGVnJBQ2lHa3pwMy9saTlXOXk3Kzl4bnFIaVZqY21aTE9jQU1u?=
 =?utf-8?B?M043WTlyQ1JoTUdoV0hUaWxMVldxaDBqT2RLdUhJNGh1WUhhUVVsUjBiSUdq?=
 =?utf-8?B?SEZIbVlqZDZzZUVOUXZpZzdhMzFGRFBKTWZDL1NOeWQ0eithRjJqMi9TVDZa?=
 =?utf-8?B?emJ3d1B1QW1LNVNvcXdjUWQrb2VrOVdqQkhnT3pNbEZFTUhzcFIycVQyUXE4?=
 =?utf-8?B?d0FzMlVJQ2NhQ1RJMXU2ajFhSXhUYlF3RHFod1IrZUxWd1FlbkovYjZ0MHYz?=
 =?utf-8?B?S1NGcTh5UUxyN0ZDbXlIQjBuaTAxRzhxYjd2S1ZOTk84LzVTWFArRk5BU0dN?=
 =?utf-8?B?YVg2TFB2OTZ4V3FqeWZLNVlHeXh5N0dPeDRsRWs0SEFqeTBaSGdEcDdhYlpn?=
 =?utf-8?B?MllWc3AyNndKaTRYTTdScHFzbkdoWjAyZ1R3eDdjOTJoR0JDSnJEWi9nL2k1?=
 =?utf-8?B?aS9ZMm45TU1jZmw4cmRqVmdFWVhXTXhXWktydDhPS0M3eElCVUNaWVRpNDNy?=
 =?utf-8?B?cU4vVzZQSXl5bnpMeTR3aUI4N3MvdVo1SFNBZkFzUm4vSUsreDA0MmhwT0xL?=
 =?utf-8?B?NlM1YllyQ1kySnpmNE1QUGgzVHV1V2d0Y29Cd1J0M01admpYMHpGYy82Um5C?=
 =?utf-8?B?WDFWOVd5ankvMkJJaFNBczc0czBDSWp3cHFRb0Vydmdaalg5ajFLNGY4OGpP?=
 =?utf-8?B?QkZlcDZlMXhRUDlLa0J1Zit6UVJ1VlhjT2F4dDhwZmhXOUE1dlUxY2VXeExl?=
 =?utf-8?B?MjAwUEExYlVIU0RBYUpmMkt4aktmcy85M1prd3I3K21KaUZEOXIvb0xta1JR?=
 =?utf-8?B?aTY2OWlnTnp2Y3hNTk1Bb2NEVCtueVduM3crWlROTnlPUVpFYUlVYUNuWUNr?=
 =?utf-8?B?SElkZnlscmxsblh1T25qL2IxSlkzTWZTSkxHMHhKSTZBSXdGcmxWaUFhNkQv?=
 =?utf-8?B?VWkwamxyWjJQRC9DRVFlMDZhOTdjUDYvU0V3ZjN5R3hmcWdORGRWLzlEZnJT?=
 =?utf-8?B?cHhnWElUWldneDBCR0lqdlB0bmx5Vmh3SGpOTXlGcGhHckM1Y2c4djhpZDR6?=
 =?utf-8?B?NDhicVhOS2hSeHdDWXJ1cE5jbmcyVy8xSFFHbEVGb3JkRkxlRE05N25qRWgw?=
 =?utf-8?B?OVE3K2lsd2R4LzJNbWIyejJPemw1c0RrMFdUajZBbHBYTmN4eWNtNHNjRHlG?=
 =?utf-8?B?MU1NWkJGcHR0OC92cWJyZWJYZ2RReUVZaVJSWEpSSWdzb3pvL3JPZzZMNGtr?=
 =?utf-8?B?QWJSNmZjdkVxNXJKajR6VVp6c2pFdCt2b0JSeHhNdEptTnFNbUFXYmhCejU0?=
 =?utf-8?B?WlRWSDJZWVJOR3FHUEtsNWZPa0ViSG8wNWRQS3RJWmcySngvM20yeGt1NVJP?=
 =?utf-8?B?ZE5mWlE5N2paa1Mza3BIcmsrS0R5Mk14SUVmcllnRWxPazBnd1Rad0dUQWZE?=
 =?utf-8?B?RlEwQ09uTzFjN2VmbEFsUFJEWURGL3dkYmVsOElzQ2E3MFVka2p0RENZN2My?=
 =?utf-8?B?WW5ldWN2UFdWR3kwaTh2dmxEVXM0TWdJVTZETEw2dnVPbHJ5cDBrVjdHRDc4?=
 =?utf-8?B?NS9JNzh2amU1THQ2TWd2ZDY0U1BLeTNweHg1UjZvSHlPTU01bUtzS09EU2dm?=
 =?utf-8?B?VUFPdXRxQ3NZYXVVVi9RSjN1Q1BBQlNZRnIxdmt5YnVjNkF0RGJpa0dPN1pM?=
 =?utf-8?B?d3FkRVVqRDRDMDJjeE9yZ2h3UGRoNTZKRk9vbG5TZitvdnBmRjVIWkMxR05v?=
 =?utf-8?Q?0nwDheBXt9gpbn+zk350kPHwX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc2234-a8bf-4804-82da-08dc39220f3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 12:29:23.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuFEUMmVlQgYmnAERuWtIrVHjufoxNfd21rpuSX5IsCJXu5ABebIabEgwQg+ekns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
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



On 2/29/2024 4:40 PM, Ma, Jun wrote:
> Hi Lijo,
> 
> On 2/29/2024 3:33 PM, Lazar, Lijo wrote:
>>
>>
>> On 2/29/2024 11:49 AM, Ma Jun wrote:
>>> Check return value of amdgpu_device_baco_enter/exit and print
>>> warning message because these errors may cause runtime resume failure
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++------
>>>  1 file changed, 22 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index e68bd6f8a6a4..4928b588cd12 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6000,15 +6000,24 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>>>  {
>>>  	struct amdgpu_device *adev = drm_to_adev(dev);
>>>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>> +	int ret = 0;
>>>  
>>> -	if (!amdgpu_device_supports_baco(dev))
>>> -		return -ENOTSUPP;
>>> +	if (!amdgpu_device_supports_baco(dev)) {
>>> +		ret = -ENOTSUPP;
>>> +		goto baco_error;
>>> +	}
>>>  
>>>  	if (ras && adev->ras_enabled &&
>>>  	    adev->nbio.funcs->enable_doorbell_interrupt)
>>>  		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
>>>  
>>> -	return amdgpu_dpm_baco_enter(adev);
>>> +	ret = amdgpu_dpm_baco_enter(adev);
>>> +
>>> +baco_error:
>>> +	if (ret)
>>> +		dev_warn(adev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
>>> +
>>
>> This doesn't look like a real case, moreover the warning message is
> 
> In fact this is a case that actually happened.
> 
> When amdgpu_device_supports_baco returns with error because of some reasons,
> device will enter runtime suspend without calling the  amdgpu_device_baco_enter()
> and without any warning message being printed. Then, device is usually fails
> to resume.
> So, I add this message as a warning to help us find the real reason.
> 
>> misleading. If the device doesn't support baco, driver is not supposed
>> to call it for runpm purpose -
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2664
>>
> I changed this code in another patch.
> https://lists.freedesktop.org/archives/amd-gfx/2024-February/104929.html
> 

Baco support checks are all based on cached software variables and not
based on hardware interactions. So this is very unlikely. It might also
be that driver really called baco entry, but even before baco entry
happened a device usage is detected for which resume is called.

One other way to really check this is to check if baco exit is called
when the software state is not really SMU_BACO_STATE_ENTER (applicable
only for swsmu). Since baco entry is driver triggered, the imbalance
shouldn't happen.

Thanks,
Lijo

> Regards,
> Ma Jun
> 
>> Thanks,
>> Lijo
>>
>>> +	return ret;
>>>  }
>>>  
>>>  int amdgpu_device_baco_exit(struct drm_device *dev)
>>> @@ -6017,12 +6026,14 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>>  	int ret = 0;
>>>  
>>> -	if (!amdgpu_device_supports_baco(dev))
>>> -		return -ENOTSUPP;
>>> +	if (!amdgpu_device_supports_baco(dev)) {
>>> +		ret = -ENOTSUPP;
>>> +		goto baco_error;
>>> +	}
>>>  
>>>  	ret = amdgpu_dpm_baco_exit(adev);
>>>  	if (ret)
>>> -		return ret;
>>> +		goto baco_error;
>>>  
>>>  	if (ras && adev->ras_enabled &&
>>>  	    adev->nbio.funcs->enable_doorbell_interrupt)
>>> @@ -6032,7 +6043,11 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>>  	    adev->nbio.funcs->clear_doorbell_interrupt)
>>>  		adev->nbio.funcs->clear_doorbell_interrupt(adev);
>>>  
>>> -	return 0;
>>> +baco_error:
>>> +	if (ret)
>>> +		dev_warn(adev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
>>> +
>>> +	return ret;
>>>  }
>>>  
>>>  /**
