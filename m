Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE02C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 08:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7845310E6ED;
	Thu, 18 Jan 2024 08:39:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5963910E6ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 08:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJASWOKJOcfwr6QQXhrCDqi3Z8eqHtta4143kHsgECI5t2yX0r0akTOEBKiyNeP0V95UCy8sNM+scP4FN/NbkcK/MKPjwb6x995xZ96xC6qqNLPKwQ8He0DgJPIDKZKv0iEXV/lEjP9lveQv92FenQffjweh42BfyLt/18tXXARZZPNOsIzpfwM71zvJGnlcvqJFlJ6GToI5DXLBJinAWCBUqVndWqY4lHuUm2mBEY2HfLK9ftzZMvrHkFwJ78I3wIS2pzpZo2QPu424WVv4/dh5elaV/jL+EkC0x+A+a4XzXsPyktSzPBMxlBE2GXkglsnTA1fv1KSKOyzvsQiaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu1Csqrlykj9AuodxAGS/guG1Y1inszhgZ38Fbe7co0=;
 b=ggvA7Bdpl7ADlu83i1OA9/WanNB8BpfSnklGpPcZflk2fG/gCpucmzryH5oSg+5JuRvSdHUPFUKLgiqoT4jlD/dDxJytzoIYrB+f3AjuY0KLVASogSgwZ2SkLbkTtrfr4wGIUKICgcI89DYfAFfWFvWaS58bRgAlmKlGobIdjPxirlqKvDyWqIi9WgDl5pyBzvtzx+I4cbqyimA0y1f6Dq3rAkfV8GfnX179ezmjUKbVHa/PUEPnJNNc9bAfpIfAiz9mGpkwNiMN8bPL52XAd+O4rdmTRRH25e7wRe3VAowzuGpiLnBbJPsUzazN0NYpCWZB39Kz6gRXnS4UeMmGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu1Csqrlykj9AuodxAGS/guG1Y1inszhgZ38Fbe7co0=;
 b=KJjXG9h0S00OiBpK7rfSZpQO87YApIQsaDuB6JQCrh2hchfuxBf2DjF4i2nZBDzztLR2vvId0EoBzKgq02e4rnaiwWuGkEVbHxJXBuiibSAv/ZR6nzBGzCA5qmrMqmORt5k/ZF3Bp5vy0o7EfMNMZtXMWCxH+4T//BApaCs11no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 08:38:55 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 08:38:54 +0000
Message-ID: <00f5700d-84e0-4baf-accb-624d73004466@amd.com>
Date: Thu, 18 Jan 2024 14:08:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240118072742.999070-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240118072742.999070-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 82397b95-465a-4f01-e855-08dc1800e794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkEg/CaZSOuEeW2gxczuXFjE1od5KlGSAx5ljGKKOcRPf03vsFOfG1GUHzcKfiz1ZBTMROZuL6Mk1KkeCMBxDyTXMWcTkcoEViZhO1ccl0wk2HqPkWDROFwF37OK+4k5e/iOrCZTRDF09UDoEHwDCp5iUC9nQaG630G+T8/jLAkeFTZQu4vyriJx+ofSer15niPltqrDOmsjUc9q6qNxTdzNLIgIPftZnMnASMjhGRAVFxPczHxwh4LhdEqagsG8e1fFVRdTHzYErbmUvTe9IupXRw8luX1fT9lnvQP7ViO/8hSkLlYUV2jF+jZPotwOv4wRMwnLsvEciy/KuUFSqfNAy+uIJfkFpSHXBdbDP5iLgv28cukH4a1apMFhh6xWqNSLuXBIDkc31nEsKlo9tnUJveBXq5fTT+tMhRYLa/s8oamGay9yIbu07L4zpk5DpNWLx4D2/tDE2BMYK/Cc6QJViFgaboY18iG1zly+pCL+yyRYJmM+Fn9KeA633g/4VBx0WlcTQ6eMnvfzCr5+0W3SOpFAfTkK+jkSwweUNKpVKij3hTxV6Z+OQBu1vdMCLjZSDm6MU9fpzRWrR8QkjPZt2cbX+WbUKw/D87I1irobC8QS+OquRD6fnGYGR6HF6PH8ERs5fGnNp8oKwoFdCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(8676002)(8936002)(38100700002)(36756003)(41300700001)(2906002)(31696002)(86362001)(5660300002)(53546011)(6506007)(26005)(6486002)(478600001)(6666004)(83380400001)(2616005)(66946007)(316002)(66556008)(66476007)(6512007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzVHNEJyWllqYkpzWFJvN0NzNXR3cjdGTmpKMWZKWVdJc1ljRVRnejRlOFdQ?=
 =?utf-8?B?Q1FIaEkvTytEUHNpeHhnQ28yRm9wZ0kyeERDSy9FNldqMjRxck96NVVLYklo?=
 =?utf-8?B?ektFVGxoSFFRNW52bm1tNTVkOFhHeUhkc2dIS3VwSU1ZMGxqMWtyRU84WWJE?=
 =?utf-8?B?MjRjV05yU21La05OMjI5S3Z6QTBLN294VlpmMDZWci91RVlzRGk5T1MvRStr?=
 =?utf-8?B?TzJxRktkRTMydkZVTTFGM3Zhdy9qV0graU5PeHJTY2doK1pkRzFaU1AwOVpE?=
 =?utf-8?B?NHVhOWI2UmFVV2FoS0lJa3Y3d1RyMkp0WTM0SDR2K2FLK3Btdk9uVmd4cVJU?=
 =?utf-8?B?blI4aGhhUzBYZHVXYS9VaS9TT2l5NEpIMFArOXdsdWFSUzB5VzcvUGRUbEl0?=
 =?utf-8?B?bEJ2STR3WWpQMjR5MjZ6YmFPblFtMHpkU2JscXNqSWJMeGNtejFYaW9MQ1BU?=
 =?utf-8?B?VmdYSnBwTWFUOWl1VHVuYmRHNmwwUUxhU280cVZndXhIRnltRm9YR2dia3RS?=
 =?utf-8?B?dXVkWTVCOEkyb0tsTHV4MkxkVTVsZEFUZ3hNNnNIbUJmb0lPRzZFYmJjNGxX?=
 =?utf-8?B?R2lFOURYNzhQQXovR0UwTnd0VloyMnFaUnRXVzcwSGZSa1I3ZzdTNmpZREd3?=
 =?utf-8?B?Tjh3L2lYWFhyMk51ZDFHUVRSd09ZUDVkNWRjNG5lOUEwZUlzZXlxRm50Tjd1?=
 =?utf-8?B?OENaVDVkK01DOXNya01tQXkwRG9wKzFycEVoRzVUTC94WWdMYVpuYUZCMno2?=
 =?utf-8?B?Q2tPZis0c2c0ZGxKVS9hV2M4WktXWi83TE1RcnpiY2pkZUNPeXdmQ1lDbm5t?=
 =?utf-8?B?ckxkUXIwQlpmWXEvRUlYSWNoN2kxMjJ4UFFyZ3pPaXhsdG1YL2k0U25EeU9N?=
 =?utf-8?B?dXhkeHZNS282MnNLeExmN2grNTRUbGpvUFl5YmxWbmJnUXpwOWR5T0M4bTZN?=
 =?utf-8?B?N0FvaDVjQWJqYUJLaExoZU9WT3NSeTBFeVNXOTRrQTRTT1NpcEdaMXZXOSta?=
 =?utf-8?B?ek01NmlKdTlBaG9wSzRVaGNuT2crY2crY21VSlozSEI0RkFkOUdlNUtienJ4?=
 =?utf-8?B?SlRGN1cremZmVXAxM3psZjJNdytENGtkMGQvOGpZeWQ1ZG10bDljbE9WUmZJ?=
 =?utf-8?B?UWlsaXpMeGt0TG5sdFJqLzR2bFVoZFFnYXJ6OUpXQUllSExoRUVlUEJ5WHhE?=
 =?utf-8?B?Q0E1MDgzLytyVS93MFhaMzEzYWEzcXVZRkFoTzFPSEJSN1NTRENYYW85dzlI?=
 =?utf-8?B?Zkp6aWtmMmQwK05zcDVxVTdiK21mdFIwME9rRVZMbEgxOFYzOVZwS2JTSGlr?=
 =?utf-8?B?N2c0eUN5b3l2Uit6bms3VCttNjNGeGdNdXdSZ3B4Qk4zMDRVRGJva0c3MzlG?=
 =?utf-8?B?VlIvUVBlZ0FyaEN3WnJGU0hWQjh0YUZvR1pRcm1oM2lWVzF3RHY3akVJUG9Q?=
 =?utf-8?B?OE9vY0FlTXVrRE9wS1hOb1hkRXFyR3l1eE9MTGtSM09KdkxsNjdHREt5OHpq?=
 =?utf-8?B?RTJxb0ZOdkxOV1VvTWpCQkR6Q3JqdVJOTFArMzNwM3dIOGVyR0ZvM3FMbVkw?=
 =?utf-8?B?cktGNzJKQ24ybHJBay82QW9ENUZieWFjd0wvL3hhR2wvR21kZ2cwSHhPcHUv?=
 =?utf-8?B?N1M0K3VxS1pUeWd2Wkw0YWVnOE52d2U2MlBzcnVSWk5WcTZ5TWFiMFZiQ3k0?=
 =?utf-8?B?T1NkZzJSaUxObWRMWFp5MzNOQ21lTHg1bUhHcTluRVI2V0o5d1RaYklEa0xS?=
 =?utf-8?B?TDFCcFlVVVJmbGorOXRuand1SzFJaGl5RHF5aTBQS3lvMUlRd0xNaFFlU0My?=
 =?utf-8?B?YkJZSjVKR2tzU096ZWxCU2h4UGZBYnNwYzN1b2tiTFMxVGdFSmdldFhYclor?=
 =?utf-8?B?UFNIUjkwNnNIY3ZIN01XYWRINitCLzFFSVd5VTNiNmZ0VlZDc09DNlZCbkg0?=
 =?utf-8?B?ZkNaaXdTbDZ1RVVYU3oyVFVBKzVYa3AxQnhVVDg4N1pZKzVaZ012UnhhWVNI?=
 =?utf-8?B?YzY2ZHFCZCtjNEh0SE9MVk9sS2RBYUhQbmpqZkpNeFFvREo5ZXI4emtPMXpu?=
 =?utf-8?B?NTB2UVJHWHVYWXowZFRiRjg4U3UvS05NVmNTeGVJQ3UzOTZmMnhaenZDVUJE?=
 =?utf-8?Q?n8wsf7UeTe1eLaoIIH76kcLlg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82397b95-465a-4f01-e855-08dc1800e794
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 08:38:54.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOd2pyAvUJFFh/XKIcMednjX0FWhL+B79zRt0aF1g/5i0L1ekK2XQXDX7Hj0G3Ke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/18/2024 12:57 PM, Ma Jun wrote:
> The power source flag should be updated when
> [1] System receives an interrupt indicating that the power source
> has changed.
> [2] System resumes from suspend or runtime suspend
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 13 +++----------
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 ++
>   3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c16703868e5c..a54663f2e2ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -24,6 +24,7 @@
>   
>   #include <linux/firmware.h>
>   #include <linux/pci.h>
> +#include <linux/power_supply.h>
>   #include <linux/reboot.h>
>   
>   #include "amdgpu.h"
> @@ -817,16 +818,8 @@ static int smu_late_init(void *handle)
>   	 * handle the switch automatically. Driver involvement
>   	 * is unnecessary.
>   	 */
> -	if (!smu->dc_controlled_by_gpio) {
> -		ret = smu_set_power_source(smu,
> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> -					   SMU_POWER_SOURCE_DC);
> -		if (ret) {
> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
> -				adev->pm.ac_power ? "AC" : "DC");
> -			return ret;
> -		}
> -	}
> +	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> +	smu_set_ac_dc(smu);

In the older logic, driver initialization/resume fails if the message 
fails. This one doesn't care about the return value. Is there a reason 
to ignore and continue?

Thanks,
Lijo
>   
>   	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>   	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 2e7f8d5cfc28..8047150fddd4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>   			case 0x3:
>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
>   				schedule_work(&smu->interrupt_work);
> +				adev->pm.ac_power = true;
>   				break;
>   			case 0x4:
>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
>   				schedule_work(&smu->interrupt_work);
> +				adev->pm.ac_power = false;
>   				break;
>   			case 0x7:
>   				/*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 771a3d457c33..c486182ff275 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>   			case 0x3:
>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
>   				smu_v13_0_ack_ac_dc_interrupt(smu);
> +				adev->pm.ac_power = true;
>   				break;
>   			case 0x4:
>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
>   				smu_v13_0_ack_ac_dc_interrupt(smu);
> +				adev->pm.ac_power = false;
>   				break;
>   			case 0x7:
>   				/*

