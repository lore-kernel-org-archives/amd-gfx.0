Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDCEC38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 05:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F6010E31C;
	Wed,  7 Sep 2022 05:58:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D384D10E31C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 05:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJFwPIy0zD2mGp7GBU71aCGHzc/pU5M9kmDJWcXFlXPEbbL7lPUc8G2UmZuZfmtmH8m8IkYtWuT5kdmiaEfE1pgafL4mc2NMVfrFj8yL3bJIypnyq/8y0+MhqUzvsOJWqaofVQ7dX5Fus2p6+AnCB5V3uuuQloMlN/6e+TSEwbEK7GU7Yi6RFNC46otvrAsMYVbIo3iwEFm8u4y9hpJDHfderxbnL73mhUd2inK57ecql//wY83LtWUxl3rBgLZvz0w0qzzzAbWwvQ6pSu/3xNXDmw3x9AF0lHbqHrWxEK/Muh4/rb6z77eUX9KmHX8GUV6riE93rPZKcsWkxeVcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESbBveYBX+j/Unq3B8TJOymMhzmTivyMzEDVd7h76H8=;
 b=RbOEaSuWIPLMez7CmXe3+XChn0ABxPyewCfwsCn84nAS9l2mk8apjFLhIyyZpbfBGqzLnLakEiCv07kJ+/BfEBeIcIM2YTTJX5BkS3IwHBlwOUGwQfBqg5Gc8ByKyAUO0MHtN4W0NCmfjbths+Qul+sJ3ItgsCxdcvMp9bpAI8hmzcX379b2awNSv240GOvgl/DqsgZNu4gzqrvA61XqOMO6JP/ygm3dzFbH+im4DVJmdaccKDKbf2bAJl2LGbg+BNuCqPNnylbNrjhVX7/i80HbJQyn0sl3O7D4qFvRel/KYpdjzeNWodxSjuOdaQrEKZ+zcV3tptVrfq9c9alvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESbBveYBX+j/Unq3B8TJOymMhzmTivyMzEDVd7h76H8=;
 b=K+7ktVoWIdOryU98cCiWsWM7bL3FnNtMwryIDWitXaobrxByKRN/8kapf34NbOObjNBhV4Itb8H6/DgFtumFR71y75nlUh4tGgbDhMiiAu71D5sdrY5c3JYtcOsfA5ZuwN/xeWpfNMYJ2aSJbNXToC/b3gZ5I+igITLlDNZZWzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 05:58:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5588.016; Wed, 7 Sep 2022
 05:58:16 +0000
Message-ID: <18b6aeb9-79ee-2388-f7e2-342d8bfaf09e@amd.com>
Date: Wed, 7 Sep 2022 11:28:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk on
 several sienna cichlid cards"
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com,
 kenneth.feng@amd.com
References: <20220907045326.2881218-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220907045326.2881218-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b25b19fa-d3f5-4149-544c-08da9095f51c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0RHd9tyuywWqagN5Ap/916OQdBrwkEWDs3lcDzxnPUbIqraQUmyImB9FExHX1LoD+j13HQFHwK51TmF3K+miRSCznKNd1PrJQ6alqzrBSlVT6M3GS7zXdB9YzKLvi2Q6XPY5xHNb6guDGkC43OyQ8qENOrzS3I3o3SDrUT7sWZXmC3vYshgyi9EHQR6qZxyEY3hLy1ainjz1jjRlCaFfLf5XzBsmSa8CirdCQRDXay0miPafnokBckrKyDqR2WZyc5p1cXTHwWb8naIWwM+nnXBiBWk2ntRjCXlI6pEM3CnKDUwfD1NmQfURIU1kIu902Nigl7ONZDYd+z4R+fAnhWnI4I0O8h3qqy7HRJT/qwFyyIOYUC0i7JiS29Dt83a74gyLVLGbqVn0q1b7Zah09XAe/QfRaLDhfxXHpntBVRKaHjT10ygQ2nYMhI83ylHU9S9gcf/XSfL4Malj9VC9sHQdmPsEIYE8wLzo4Y5084Tuhk9LWhMHEhE0uBejkCLfsBUzJU4ILsG1RJXOHsfTcC/+05e332Ryb8qMrCTgOvCDFqb0Cf4YW2WYImHV4R8VHv8nL1DPWLetI7cCAV6OrOhNpigYyGnY8H121ziLpolFcP3mbxXhQr9mv6fQSscDiK5YcqLlFKRlHohAm7OfJv6WGGANyAt/qhuPXiTeaWrbgbH7iZDF6ogDA+MxBeP8hBnVoDWngyV7/ARqOwdU190sGwPNVtIWRA81RfCT+hB2pCh0R2Y304GCK8Cxb73n1U7AHLJ5r5WBSh2WGo3/S18iPMkHif1YyKeP58NQqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(316002)(6636002)(83380400001)(478600001)(6666004)(6512007)(26005)(6506007)(53546011)(36756003)(8936002)(31696002)(5660300002)(86362001)(2906002)(8676002)(66556008)(66946007)(31686004)(66476007)(41300700001)(186003)(2616005)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVdJNVdnM0FveDJ0dWdYRHY5NFhING56aW5QLzZWL2QxdlhwcWxsclQva2FQ?=
 =?utf-8?B?UWJhN2t3SU5OK2pXQU9yTGJjUSszT2R1SGp2VEExMGNhRWdqajIrbTFxK1FY?=
 =?utf-8?B?WHRPWldHY2ovNkRXVFlNVXE0RmRuVUFnMkRoOWhqeC9OMjJBdnJiOGpwZTlx?=
 =?utf-8?B?cCtJVTA0MUEydjFlTkVGdDVhRjFmVnVyMEw1NmNpbktPUjVXMzdJMVUxaHRI?=
 =?utf-8?B?YmhGWmRrbk10cFhPVk4ydzF2L1FKaExuMXZsZk5RNlptTVF2Rkw3QS9xcGc5?=
 =?utf-8?B?NDMzQW9ETC80YzE4aDkvaHpqclo3VGVYbjZmK3RpSXRueE1DbEZyYXRkYXdz?=
 =?utf-8?B?em4zbzQzOVo5bm5xT0tyakR1aVQrRHN1MUlnZENNaGx3TnZXV0xkWExDeDJF?=
 =?utf-8?B?K3RXdGdFaUpweVdBQ1kyTWFWV3ZvVGxxeW9HVFBxTFVtbUxJaVBmSTJudTJm?=
 =?utf-8?B?dXBNakU0VlZxNnYvSGFXZUYxbjRNSloxRWp1OTA1aDY2SnMrazRDSXVQUmcw?=
 =?utf-8?B?S3REdnBmZ1ZqYWYyOUVYWksyK0F4UGFlSlY5N1NUUnJoS24xci9mSXkrREFv?=
 =?utf-8?B?aE0zUkFjd29WaVV0MmVzUmF3YmpwOEdEcStVT3V2YWYxUVZuYUp6Q3p1cUJZ?=
 =?utf-8?B?NElVSGk2S0p3ZHpwRk9rVjJMQVJreGhmUE8rSjNSNHBXT25PZDJralNvSTc5?=
 =?utf-8?B?bmVLUDdHOWVRL2g2b0UyYVIwVFh1ZUNOMGVwYjFGeUlReEtnY2hnaE5WUlJ3?=
 =?utf-8?B?NHRLLytxaEJRSGsyaUhPVDJGMWtpZHUrWitnTERpcmdKd0YxaDBsWlZZZnJo?=
 =?utf-8?B?aG5FbXBiNVNtN1plRFMyT0pUQm5qRTZ0bU95c2ZzaDFKanJUOFhQQVphZ1li?=
 =?utf-8?B?VnhabHo2NThobVRmY1pHUmlucHlrR0FVNDRBQXJuQmlERXpYbTAyb280Ymg5?=
 =?utf-8?B?V2srQzk5aDM0VnFMRVdyS0tFQlkwWEFPVnlsVG1KRmcyaUhXOWR6V1F5cXRs?=
 =?utf-8?B?QXNyOGlwZHlneG9Ob2h0c2dnWlVSTXkzTFlzOUkvdzMrRERka2VrRmg1dmth?=
 =?utf-8?B?dytqL0ltMVJxalYxNENvZExDTHloY3JvQ3YweTNsRkZZOVRuY1NMakh1V1ZZ?=
 =?utf-8?B?UG1MVUhHaXg1OWE0RU9UVW1tL2t5N0RpSXpnUXllcUM5QWNLczBzdTl5MTRh?=
 =?utf-8?B?bFlhM2o5ZFBiVnhXLzBCUWdGRXlKVlNSQmZoYU5aY2I3RWNnTk5WWkNTLy9M?=
 =?utf-8?B?SFBQNHZLSDBRNCtPOVFsaWNVeVFpUlhYWml2S01KVFpqTnZmL2Z2YkowS2xt?=
 =?utf-8?B?bXJseVluSW5VM1JsN09yc0QxSjE5dWRlT0dPSVR2NUlsNzhnVjNzRHhXQ1Qz?=
 =?utf-8?B?TkhNK1h2UGNhUncyeWRpbGxCRC9kcmhzMWFFUUczTEJPMThXcjhGcUd4RC80?=
 =?utf-8?B?VWdZZ0pPdjlNWUEzLy9zODNmbGg5R2JETS96NzNkWEhpanBYMzEwT2d2N0Nr?=
 =?utf-8?B?eGhZTGtmZUp3NXFNckdBdGVib2xFcmhrMDlFRWUwUnBHRjY1Z1JCU21vUUln?=
 =?utf-8?B?QjJRR2Y2QjhMYWNMR1hDais4bU5sbGdUV0lBNkUyV054MklDemV4ek9hUWIy?=
 =?utf-8?B?Mmk0L042R09wZmhUUXg3Z2VOSmNlZGpFN3RkUUhGSVgrYzVZRVFzTDJndjZR?=
 =?utf-8?B?c3IyQytZZ0d2bXQvaEJ3czNLNDl3VVd3NzFwRDRQRFhZQU11MXA0a0xMbGpU?=
 =?utf-8?B?cmFrS3kwL2szMCtHSndPdTBmd3ZVQkxxVGlreG5ZL0hzYm5tOXNQcHlxeWFv?=
 =?utf-8?B?WTJ0eGJuUGFxK2lGTEtvNC93TnBWd3NBOStKemx6cXNjTHJubk5zTkRYV1Z1?=
 =?utf-8?B?RHg3ZUhLVTFVMTllRHFHOGkrM3pvWWhPdGR3cUFQU3VDTTJ2eExUcG9TUVE5?=
 =?utf-8?B?V3A1Y3lRY3pRUndQWmhVTXhuOGl2WlRkanZlakIzWm1kYlpjU0VLMlZ0WVg2?=
 =?utf-8?B?RGNzeGNOMXduTEM3WklIVEFUalZCKytOa2RMSUhTTEJVUnI1QThHbzgxM1ov?=
 =?utf-8?B?c1FxcURVUDlTWDh5MHN6a2hkUnNueWNqeTY3U1ZwYURVOERkMVJzeGlNY3Vz?=
 =?utf-8?Q?2clRO0AICtLCxmDWyQC1WGWDU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25b19fa-d3f5-4149-544c-08da9095f51c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 05:58:16.6272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9Yp0FfPOeniuVah2D/BpL/naOTt1EUo/tEwrgaDtRRLJm5dwIe+uyedf9fwftcP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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



On 9/7/2022 10:23 AM, Guchun Chen wrote:
> This reverts commit e2994d23d8afa2fb465fdb8cf544b736f67ab8ba.
> 
> Frequent BACO enter/exit will cause EMI failure, so disable runtime PM
> on these server SKUs.
> 

Apart from this, any BACO entry/exit in quick succession could cause the 
same failure. If BACO is used for reset in these SKUs, that also may not 
work.

Thanks,
Lijo

> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 1369c25448dc..4f6473faaf24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -43,6 +43,17 @@
>   #include "amdgpu_display.h"
>   #include "amdgpu_ras.h"
>   
> +static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
> +{
> +	/*
> +	 * Add below quirk on several sienna_cichlid cards to disable
> +	 * runtime pm to fix EMI failures.
> +	 */
> +	if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
> +	    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
> +		adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> +}
> +
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_gpu_instance *gpu_instance;
> @@ -176,6 +187,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   			break;
>   		}
>   
> +		amdgpu_runtime_pm_quirk(adev);
> +
>   		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>   			dev_info(adev->dev, "Using BACO for runtime pm\n");
>   	}
> 
