Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45309C41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 09:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C911C10E76E;
	Fri, 22 Dec 2023 09:00:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7016A10E76E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 09:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcPGTdhhYuAkMzC7xfeCwAd9XxBwneQKHSWzeMx+Woagt/s3PYRrp+j1U1aRX3DiQdk26j0erOdjYc1TbQ3SUhQeZ/4fb0GESkpqL2qSWqaGTyJcqOZ4J8NNTrPwy/4Qgrhnfkglxdpdvvmfrd453pMV8ClKW1LsXwkhbmAKS5P44Kcx+ou+tqCtAb4TYjSpGyIQ10jg9nH1NDtYJ5WZvYQJ4CXOKaD4UHyKZ20yuJAUxn7SjsC+POjdFGP0wM4+/ltY+4jzLyeselWxWtC2yiYObU48uz1skkV9EQdsEAeNfb/3fBivLZG3BFhF0klkQfUeOWktYVy4qe57XYiHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWnSLdMHUmsBvhlVoHmk9a+3usyWeKJp5MlF1Z1wQW0=;
 b=SPugQSVarPJ9KM0ml4jrxrMSduaYdWvIlMnqQc+3M+pwjEDjqYxzsHb91ITM6KDa+vSjABbRsfmG84B5EsT7BB7eszPe2Uh18PEBdGIOojJ8YvNGWtaqvNLTx2jex6hWb4VqxhH9v5Wo1D1bVOOCs/Ip7jlprALaHoM86K3EaJEKU4SXDKuOvM8P0Lj4SdUYQC+tBKB3yxBapAyjwqzPWTXYps8iutXh03K+Vuzkn2hHT3vmyvh37WKxZ7V+TlEYcIYIh/w7R7O9xTfxF/1T27N7zEeEp9s1FD5yx1S0AfLxyUJrgFgo3fukK3maDQY1M+Nt5wTWOFReL+Q4OweY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWnSLdMHUmsBvhlVoHmk9a+3usyWeKJp5MlF1Z1wQW0=;
 b=bqHkxjCyPlB/Jepcf+fuKd/mrNqoZCxdiCFSb/r87bLmWntfnQC+MfhF0P5iu8zdI/5ETdY6+S/+zBdO04wIvZWE00qxU9kXxrPUD4BkYp7hbG7R7J/5q/ik5jDXnCBIaGLTbCvcdhK1coaycm4YexiMWJQgTomV15tWxoCqOWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 09:00:10 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 09:00:10 +0000
Message-ID: <3f530873-91a1-4163-be63-bed80a4078bf@amd.com>
Date: Fri, 22 Dec 2023 14:30:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20231221154321.1369933-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231221154321.1369933-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: edf7e0b1-9a48-412f-c9ee-08dc02cc66d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKI0N47cSOmual07jBpYmRtI7WLM5cuFcxWTpLPF9xi0K1kvZYvVUPCSC6LYEFiejYer4fcbyrosfp7jwAF3rhuHaFzjB6kmRfcCRrRd44QYB3Ll3MEmKeRkL9B2xaI0nHxINXwHMt2E5Ys98FE+dDjgP5JNl5SoVfRA9er1IvFR/tmMNmtfVHVKWtVvx8cEwl79qj39UNGpg3dr9DD1LsKyFoxGsIRSEPzhf0MOflD6fywwG7SbKOhykahYFFlDcb9g/ON4Un5Pe6QXbMDoAzXSG71bcAphahxLK/JXL/6lpkukAABQWx3fp/hmYwYk1z876mPmUt1fts6rGwBIA05J5Qtq5YnVas93nyDJIWCNLq998Hu9cr6FNvPyYKGiI2ErAl2MX4U7mye3jENFfBDAAbnHuCTkgCHjpGYo1eTUPAZvbLXD3KuoCC7R7YwqEjT3C1ddZXOLclplHeEsfIyuJHpt98SSXl84kxLltmb40DKOj6wLCt94CsCJ/JWxHDbyuVy6NUsSONLwo8kvP0PQ4NXT3/AVM8ruW4/zjs0HLqVc+rVCnkJmCiVEAO6jJRlApA50A5WZBJUQFa77plK+K3oNK0Yg2q3sZXFkMzZH5eA9aKfkSpL41wbeK+NGrGz0m1hYOHbTY7DvfwmBYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(2616005)(6512007)(6506007)(53546011)(6666004)(478600001)(8676002)(4326008)(8936002)(66946007)(66556008)(110136005)(66476007)(316002)(6636002)(36756003)(2906002)(66574015)(38100700002)(41300700001)(5660300002)(6486002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDBaQ3lPYUFQVm9kbXlneUVianZPbEZ6ZkpRZmRrTXZJblRGTWZRZG90K3Ir?=
 =?utf-8?B?U24ramdyZTdvQUpMV2dDdW5Obk5xQVN2ZGV2SDhmSy9MRzl0dVJYRC9aTFNy?=
 =?utf-8?B?ZXpOWndFdmJrMzVvdFNvWDBERVFTNVkvU2thTlkzK1BYdjBrNk1Yd0FmaVR2?=
 =?utf-8?B?d1FYVFV5WHVJWjU0TGNnbVcyWFNUemlqYkpiV01zbXBwRjI1a1hCaEZKTS80?=
 =?utf-8?B?MnZwaWFHVmZSa055NkRUS3lZemlqemRYQ2h3RmlNbWZCUm45U0dNQTZtSlBU?=
 =?utf-8?B?YXRrek1YY25ZRnJFbXZ5WDRCTXh1TUpCWlpQQ3RpZFEwMmtNR290VU1lQ1Jh?=
 =?utf-8?B?VmxvdDk3aG1vZXJ6c25QWmhBNFRRKzNPYUpxUEZZcU9KNlc2QlljdGlkZm43?=
 =?utf-8?B?R3lLQlBhS0Zsd09RMElHYTZJMThDLzgvOUtDa3NXSXRGSHRHYWh1bTFNV1pp?=
 =?utf-8?B?d3ZWRlZobjJ3SkxVNndnbitLVVkvZTVXdXUzMGV4NDN5TERSNE1xYm9EdjJW?=
 =?utf-8?B?aWUzRUF4YjlEM1JNMVdhekc1UEZoZHMwVWw5aldJOERTOVVydkNDVjVJMjVK?=
 =?utf-8?B?TFNFaUF5alg3VVhKcG9hQ3lnK0l4Zi8wcmJpcXpaeTRWRlVQOVhZS1VMREYw?=
 =?utf-8?B?NVlwdVRzMWtmTGJ3SnpJUzB0NmxVZGNOQW9zV2EyOGVCL1hFNmNhUDh2eVlH?=
 =?utf-8?B?NW1LMmZYaC92dXZta1pnTVdQK1FaNlNVbFNZZXNzRHA3WG9MWDN4NWxuU0Vj?=
 =?utf-8?B?WUJBWUpBWUxSN1dFRURXVGw4M0JhSEwwQ1BKZXkwaTQ1aE1PeE8xVXFGcE9x?=
 =?utf-8?B?UzFTZmxhUDh2c3lBblJQcm80Zm9oc043RmcreHJpNkozbzhUcGlYcWRqb3d3?=
 =?utf-8?B?NTBVcWFkNnBLV2VNckZXdDkxdVVVWXJZNWlyZE9tVXRaL2l2WnhZOEN4bndC?=
 =?utf-8?B?R1BwbWxaMm5UNHI0dkFFYkFrVm42RStKNjZwbjJDWW9mSVgwVTh0QTd6MFRK?=
 =?utf-8?B?YjdnUFlLNXovZ29OZnErM09saE16OEpaV29tS0lMVDBzdHFqWGFKRGdYaU1s?=
 =?utf-8?B?c2VoOW00dGZDdE5MZlBGUGR0dTl5bWl0VmJKRFdWT1hJWW9lajZPWmxNVWl6?=
 =?utf-8?B?dEIvQzdRYk9ORGU3Y3hmS2cxRUM3aHlqSkxCUUZPNGRMWDlPTnBZQW5sYzAw?=
 =?utf-8?B?UE83RU9HalNiK0xzaXdzTkJHQllHZ3l2c1FqUEJuSW00dVlFVWNIT21Edks1?=
 =?utf-8?B?K0FrUEE3RU9yT2VUUjRjelJBeDBhTXlJeng2RlppTWV2bFlkSjRJRFZVVlQ3?=
 =?utf-8?B?Z3l5cjVCd3R2TUJIVFpyQjRzK21CYXJZMENKM29iL1ZGaitoQS9NWGZkQnNs?=
 =?utf-8?B?dU9RdE4wQkw1VVdqeHB1VlhjTmhHcDRnekFjczh6VGxBNEJSbHhjdkNDanBx?=
 =?utf-8?B?cFA5SVRtRjhJY0ZIdGlQSmhQQVlLcmpONFpJbCthN0gxS1VUbU81MW81Lzg3?=
 =?utf-8?B?UnVtUmtORzdjaVVmNm1TaVNmK29GKzZMZFdNbnd2Rkc4STRFeHNaNUVkRllQ?=
 =?utf-8?B?aVpZRmpZQWR6YUo4UTlpOGp1eGozT0V4amV4Z3g5eG5GS0VEZ0FTa3B4TWxh?=
 =?utf-8?B?RXREZU9MZGdiSmF4VWJCcHQyd0hHUjZwT0cwLy9wUUJTaDRFMkFqR3J5N0Fh?=
 =?utf-8?B?dWJMcUhFbzFaTENGZnM5YU1TT3pnN04wNTBlY1E5ZDIzSlhZVzJWbjNWcklh?=
 =?utf-8?B?U3JNTVFCV0JETmJHZ0x4VFF5WjIrOHdKL1ZycTJHUmc4WUtaNjVReWRGVEpB?=
 =?utf-8?B?a0FlQzZjSE9URHBPby81MUFTQkpUeGo3amZiRC9EdDl5US80VmNBYkNnS3pm?=
 =?utf-8?B?SzduWmNjUnh4Z0tlcGl1bUo0UUVPcmRpOU5ualhObkFNVGIrTk5VaUJTdmdM?=
 =?utf-8?B?bWtVYkJVRGs5cVE2dHMxZ2xFZkF1eHRnRnRBZ2duVDRSMmJzUW13SUYxa3Y2?=
 =?utf-8?B?MENQcG9uYmFCOWtMS2tBREJhSDZta21TVzlKV0Yvc1UzUFFIY1NGY1pDSjU5?=
 =?utf-8?B?cGVNT3hHaXFyREtmSEN3bHJDb09aRUFxbVowbnpOcEV4WXFaNk9YbzlWOXhn?=
 =?utf-8?Q?cnTcOQ9QlESsAA7gsPvBNG5il?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf7e0b1-9a48-412f-c9ee-08dc02cc66d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 09:00:10.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19lk8F33pkfcrgim+vLCy/wgDRXMHSCgBwjokya2RC6g34n0a0NsYpoxddKxrBvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163
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
Cc: amd-gfx@lists.freedesktop.org, Monk Liu <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/21/2023 9:13 PM, Srinivasan Shanmugam wrote:
> In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
> 'adev->pm.fw' may not be released before return.
> 
> Using the function release_firmware() to release adev->pm.fw.
> 
> Thus fixing the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.
> 
> Cc: Monk Liu <Monk.Liu@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4b694696930e..f2c3d7ebb218 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1541,11 +1541,11 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
>   			/* force vPost if error occured */
>   			if (err)
> -				return true;
> +				goto fw_release;
>   
>   			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
>   			if (fw_ver < 0x00160e00)
> -				return true;
> +				goto fw_release;
>   		}
>   	}
>   
> @@ -1568,6 +1568,8 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   	if ((reg != 0) && (reg != 0xffffffff))
>   		return false;
>   
> +fw_release:
> +	release_firmware(adev->pm.fw);

This won't work for others where request_firmware is not called.

Thanks,
Lijo
>   	return true;
>   }
>   


