Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED52C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 10:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A407410E4B5;
	Wed, 29 Nov 2023 10:50:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2284910E4B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 10:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnQVj28rIssmDJYYMmM2EUhYLxhBSU4C2tOvhH20dwqlqFhsERFnQzGvJ9ipCnXCnsykDVXB3g10PnWa7kh0z3brDii6Kaxlp80RUFK4hlWH+KDdO5KoXgkIzu8iyROE8NU7T+NcSfcK4mzR0pw4IKdlUo4RXxrBVL+7U4dfYxzXps095iIQFYypdp423VkpwTBrC477UT4EyIPwA/7BJi9ISwgY2os+wnlx9NF/KF77SIpDLQSdgcRG/GyiCGCJ3ssHMRF7xB9uoPPZv4TpgtimyoopuDr8UB2cBod3fJGDhujsmqbjAMHVpWkn5T5v4dzwv4ihFtEVtZXjVss4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6wbTbOGPhEyz6bWLf3ys3kXbFXfJZVkrWMgI5tq8ck=;
 b=LNmMcp4CNUTIF+Qbh7jaKk7GbavGB3MDNmO0L2UxChvYLhFoEW9usiCtqNySXzDgkPfb6/p1CSmHpb0OFKzFl49oWvL+6VIYUisZrNVad7UCi3cAJiKm98MJf8J8tYx2YR4ePnFtfjfB7KTDozQqJ//kwaz5iwfWAuNng1czD3NBrCL9b4fR3zQ4PcB47f9ISvZ8GL7DYiy8fFP9ovwQnAxxf2YdIVcLUNBbdNJfA2qRImYO0067u3HdVxVS6I04b6XeBxys9ZtNWpOYrzVQngl/+WaiowVUNuqq5hy6JuwLGFu6wDlqmxZUtmz2k8fxipwmoanawS9HjGZWePR3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6wbTbOGPhEyz6bWLf3ys3kXbFXfJZVkrWMgI5tq8ck=;
 b=kmB24TDW2JGk43RGDjG3bC/wEzmkK6+5bSsDYNo4PxZti1WxpVFwo+JNtmM6QSzVQzaWCLujZMiOEwwtziIi4y2lcGC4pB9RdxBGtrq7JLdw9PlUXTjJ64cWa3iiVOLbeiFDEzCIYu36GYn79Ni2XXVP4t50OxAZ9Vudhu+IAm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 10:50:07 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 10:50:06 +0000
Message-ID: <5bab756e-a155-42c8-8459-d795466ccbc2@amd.com>
Date: Wed, 29 Nov 2023 16:19:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd: Fix handling of amdgpu.runpm on systems with
 BOCO
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231128185238.187381-1-mario.limonciello@amd.com>
 <20231128185238.187381-2-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231128185238.187381-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: bd27f056-e356-4d20-f49e-08dbf0c8f2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOypZ5oHErqO9RSd5aqDBah2DuZaS3/A/W1MxrXs1oMH4WLLL+8FisVlAjiiAyr9xvwd7YZ+UHugAThxHNJfxNlnhSM8ugxy/XW3ZYCBLmC23bPhX7mr/H5MIcv7zJre6AZn7l57cnLhPkVwg/FCUk68lTepCnCNM8VcaC8dsbk3ID21ZBMqS99vcpFtQ8Aollsjw64+Tysp4FuffG8frdrN/VIxhU06zBiXlRz4+JjVb+DdcARAE+ZpeO43bcIm2QtenaOenb0LOx/Qeblow+QyI3XdBNlU2iu5SOE9E8zVKn4kUuZ1CeBbwJKGQrBD4ZB2RZjcV9/nMaiWEPjCz7g7iXBw5DHDeW7ry+DrEOE1pZ9tqiMYNx+rEt/mHnOxwloAGMIx2MABcfE2dl/JfGzOOWZjwmRv6NBnFHR+4mVhm4w6djzaKCOUusS0gGf5Hvx/iFb/tEbcwsvjsnCRwc1gDV6taA5kMfefGgd+5U1jvmv599zJyq4WGem+WGF1sHQQFEFUTlU8L1lBVnu6BjAMbFt73Rb11mksbuZ1C7SsSXls15Q8SKXk28OFNXOqhr5ysb6kYF4LPi/ghfXW6xLpGUoCrSg6vyk0MXSEVt0jRqTI7jbe3PAqCo8ipW6iphsVaJphWjsTKyZ8WVhF8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(2616005)(66476007)(66946007)(66556008)(316002)(2906002)(4326008)(8676002)(8936002)(5660300002)(86362001)(31696002)(41300700001)(6506007)(6666004)(36756003)(6512007)(53546011)(478600001)(6486002)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE5iempJOWNKdklOK0xxM3N2amEzdGU4VzUxanliUEpVbVQ5TXN5ZGZoWXlu?=
 =?utf-8?B?WlRtZG9USnpRenp1ZlMrYWxJVmlrL05veVp5YzJLbi9RQ1dUeEM2R0hSUFMx?=
 =?utf-8?B?WjBwWEpqdHdnNTg4QzVLNHN6K2hQb3ZQdzZVVnRwUmZpNzFzYW9yTjR5Vits?=
 =?utf-8?B?UnoreE4yazVRU2dZWHlnYVZnTVR3V1ZZYUxGcHRZZVlSZGl4SjdIZnNGdU40?=
 =?utf-8?B?SGFtMFA2MkNtZ3ZKMVdZK3lWWlFFc01PbG41a2R0VWl1WngxRzAvcTFuMVFN?=
 =?utf-8?B?Q2NOaG5FZXRqdGcvdjhQNUhVSUFTekhnNHhLdWhEUUlzL0JZdHBCQWpQR1hz?=
 =?utf-8?B?VGtsS0dYSTRNZFJiTHNZQXdxNElvYzE4SlVhWWpPcjVZV2Y1QzF5NE4vYUlC?=
 =?utf-8?B?SkNXSTViS1ovOCtEZ1ZGRllPenFseFFpSHNSZGpqVkRkUDMyazVKNkw0ZFZP?=
 =?utf-8?B?dXhKcnlCNUtGclc5dmR1UDdaKzNjVHNSR0JCZlptU2JoZldpZE05U21rd05X?=
 =?utf-8?B?SjFCTDVXdWVNRWltMGt4bmZjZ2FJMW91TExNcDEwQ3VPNFlPbFNJc2FkU0tX?=
 =?utf-8?B?WmVWeXlLM0xnUDVwaUFLQzBKdUljVHR6UXB5SW1uZ1dhTHUvaXhwOVR0dTdH?=
 =?utf-8?B?N3ljRWtrT0QySVR4OG0zNkp1U29uVHVOdnpFaEJCc0lFQ0hsUWlrRTJxVERl?=
 =?utf-8?B?SDFMQmwwdWZvMldSSjhmTEkrTnBVYWhlNng4S2dQUW16OVArMVhtWk5YWlo0?=
 =?utf-8?B?YkRtaDQvMVRFanRCQVgrZHFOUGZITFZXajN3UldyL0ZDWW5KOFh5Ujg5S0hD?=
 =?utf-8?B?aE0vMGIxbGlVYURwU3Mrb0FYS2VtSzMwK3pCWFFBOEJTNU1wWUhENFZoVnI5?=
 =?utf-8?B?WmRhbVBRYnRNeEhsUktWWVdoVFNKc1dvenp1WEIvbDZxczZSUTNDTG9ucS8y?=
 =?utf-8?B?aFFvakpVYTNMOTQ2TGVJSWNsRUkrcm53d01UVTJmY2hlRllVMjdqMHZ2bHd4?=
 =?utf-8?B?MVZaTnBFMmkzc2hvRE1IR2RuWWxZVjlub2h3bHV4THV0VnFlZ25PNHlieTBt?=
 =?utf-8?B?YUZsb0RaV0pKOEczdE5pU0thQWVFU2c0NGpUNE0vV0NTT1BCSzAxdU5YWjU2?=
 =?utf-8?B?SWNWZlczYzVhSzVleW1lZUR4ZmNMZmVIMGt0OCtyanB2SUZuUHBPVFZiRk52?=
 =?utf-8?B?SHdXQ3R2bDJYUWtWQ0o0c21GR09CVUpaS0luUmJ2RU03a0lsTzV5QlRWOE9T?=
 =?utf-8?B?NnlaZXR5M0w1OUJjVjNFK1dsaGZqVEZRSFZvYzhsVmU4d0duQThjRmZiK2lO?=
 =?utf-8?B?RCtpVzB3N0dicTFTMkxMSVVRbGVRdGtLYmdITjhHVTArN085RC9OK2Y0cjFw?=
 =?utf-8?B?c0NRS3ZNR2ZTcXFHb2V5T2p0QXcrN0IxVGFmN1gxS3d1dDBRRFo1UDY4SVpm?=
 =?utf-8?B?UlNwajRwSlpJa0Vib244SGJRWVZ1VXB2N0hqK3VLY1VjckttS2pESEo2U1h2?=
 =?utf-8?B?cU81ZnhEdDhvVDhSNG15SVB0aW5nS3hhZkRRVE5ITVE0bWFjN0JaeVNKRUFx?=
 =?utf-8?B?Y0g3SDFna2hLUEVhRzVGVnl4ZE12RG9WUWYvVTVYOWVnd0hET20yV2cyR2JW?=
 =?utf-8?B?MDFyWWdvRXc0Tm5YMStYK3NmYzRFemFTaUZTTVpRUFo2dE5ESXNkaDNpcERl?=
 =?utf-8?B?bitKd0Z0MnpmWVh1dDdsWkNaamdNT1dPendnazlQcDhjcTRqVERzQXhCRW1i?=
 =?utf-8?B?Vkk4R0UzVmlrSC8vSzdoQWJFL1d4MW9HU2RGVzNtTk1DekRKSjArcjJWdVdy?=
 =?utf-8?B?cGQ2VnNuOFhQVXpBY25HMkVRcnA2TFFIREtKZ1ovYm5pZGxmNDVFajBQOWw1?=
 =?utf-8?B?QlR3K0VUUHhFTjVLL3lSVTFVMTZwajdUVzJZZ0w0T25MWDNxNCsrRjRMelhh?=
 =?utf-8?B?TnpZUExKYWlKTmpaN29yakdGd0xCTVZJbE5xOEpCN3ZMMm0vSCtQSUVkRnN1?=
 =?utf-8?B?WW8xWkdMRVVnaE9IU2pGYjRhRTRlTk03MkhYbElsa1d6UmtYNzR6L0FYSldh?=
 =?utf-8?B?UC9CYnhFd29rN0NubU1WT0ZQSlVPUHczMkJ5ZmFEcWs1djlheDNEcTZUUmpC?=
 =?utf-8?Q?rraRtre+CXzX/t8G3ISLhp8oW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd27f056-e356-4d20-f49e-08dbf0c8f2c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:50:06.4764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVz9L4ZuTK3sAxvoQbyB9HccWIrX8kcMldP3vgg7rXcmquhX7KFQOGz7+drGrWcl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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
Cc: Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/29/2023 12:22 AM, Mario Limonciello wrote:
> On products that support both BOCO and BACO it should be possible
> to override the BOCO detection and force BACO by amdgpu.runpm=1 but
> this doesn't work today.
> 
> Adjust the logic used in amdgpu_driver_load_kms() to make sure that
> module parameters are looked at first and only use automatic policies
> in the -1 or -2 cases.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 80 +++++++++++++++----------
>   1 file changed, 48 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b5ebafd4a3ad..29381da08fd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -121,6 +121,53 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>   	mutex_unlock(&mgpu_info.mutex);
>   }
>   
> +static void amdgpu_driver_set_runtime_pm_mode(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +
> +	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> +
> +	switch (amdgpu_runtime_pm) {
> +	case -1:
> +	case -2:
> +		break;
> +	case 0:
> +	default:
> +		return;
> +	case 1:
> +		if (amdgpu_device_supports_baco(dev))
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +		else
> +			dev_err(adev->dev, "BACO is not supported on this ASIC\n");
> +		return;
> +	case 2:
> +		// TODO: adjust plumbing to be able to pull PP table to check MACO support as well
> +		if (amdgpu_device_supports_baco(dev))
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +		else
> +			dev_err(adev->dev, "BAMACO is not supported on this ASIC\n");
> +		return;
> +	}
> +
> +	if (amdgpu_device_supports_px(dev)) {
> +		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> +		dev_info(adev->dev, "Using ATPX for runtime pm\n");
> +	} else if (amdgpu_device_supports_boco(dev)) {
> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> +		dev_info(adev->dev, "Using BOCO for runtime pm\n");
> +	} else if (amdgpu_device_supports_baco(dev)) {
> +		if (adev->asic_type == CHIP_VEGA10) {
> +			/* enable BACO as runpm mode if noretry=0 */
> +			if (!adev->gmc.noretry)
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +		} else {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;

On VG20/ARCT, older logic doesn't use BACO as runpm mode unless forced. 
This logic breaks it.

Thanks,
Lijo
> +		}
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
> +			dev_info(adev->dev, "Using BACO for runtime pm\n");
> +	}
> +}
> +
>   /**
>    * amdgpu_driver_load_kms - Main load function for KMS.
>    *
> @@ -149,38 +196,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		goto out;
>   	}
>   
> -	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> -	if (amdgpu_device_supports_px(dev) &&
> -	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> -		dev_info(adev->dev, "Using ATPX for runtime pm\n");
> -	} else if (amdgpu_device_supports_boco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> -		dev_info(adev->dev, "Using BOCO for runtime pm\n");
> -	} else if (amdgpu_device_supports_baco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) {
> -		switch (adev->asic_type) {
> -		case CHIP_VEGA20:
> -		case CHIP_ARCTURUS:
> -			/* enable BACO as runpm mode if runpm=1 */
> -			if (amdgpu_runtime_pm > 0)
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		case CHIP_VEGA10:
> -			/* enable BACO as runpm mode if noretry=0 */
> -			if (!adev->gmc.noretry)
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		default:
> -			/* enable BACO as runpm mode on CI+ */
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		}
> -
> -		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
> -			dev_info(adev->dev, "Using BACO for runtime pm\n");
> -	}
> +	amdgpu_driver_set_runtime_pm_mode(adev);
>   
>   	/* Call ACPI methods: require modeset init
>   	 * but failure is not fatal

