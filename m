Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967DAC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 06:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33AD10E8C6;
	Tue, 27 Sep 2022 06:12:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F42310E8CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 06:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFx1MGw4fsUdE1gjOXW9RTnYGpkC39AjDKysWHt+Ph+7nGH+W1ftMTgWoswG/zcM/bjWTqiJy37KYpHoYJ09b+t7FkyEye4g5qJ2I25+MvxAIU5Pp0OxpqDN1lZQhdu1zUyX+BVuxpUIBaTTYDg41F6qS/JNXWtaqYeMyysJ66WTQJHy4b4qSfdjjJeaY1/KtQXUi2ZH7/GWxWm7MdadA3tqomQW7DV+DxttSj/5PA5FW1Kyi7JEJnkNLaGboVbBzVgxBtpjRoibClUAiCmH31F6Qkhd27SuSHvvgvw+ffzYG0qOjPn98FS60/9Z5kVSeXBgt6dcRED5qtJCCvmWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTXfG+k9aRY9jOHT9IBSVcOSEsJ0Zt01LUAT9K0V+WU=;
 b=RdlNHdKcZV5SH3o8MEsF1fgZFtMi2Yi+mucs0GU/sm5ckxRgpd5UKKZw7Nx+a4ee5gBGaSdOfnewZl6GyKjbGajjWtfiHH+QspTGIbeBhG1dzK8NWWVQTAFfxXWl/+Zz8343KQBajCuc4ubzQHVb5rVSx9VBRpGLQIhrFg1Qs5di01ZUDfodAtE7aaObVARV5gzVK6vKsiDCd+N5/neiI2wk0IxFe3bQbLme5tcZiuClNcoRQ/g2mVJ1sZpvZekvRlbt2yS5eaTLC4gPEJz9RVRWmy1J2kHWt+2nTPt3Tski4XkWHG3sTvcvd/Cww0jlfIAu49TikLjy7elDxpoPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTXfG+k9aRY9jOHT9IBSVcOSEsJ0Zt01LUAT9K0V+WU=;
 b=GXyauUYn5n33YgMyGng8KjOS96cD5dOheOMKULqYn3Smm/UqE8HQtEyFqsIR9tXhsMtmBq18zCTMBDZ/zgFuV+VK/bGDw+uigkpk45Ylzli2H4YfDhuvEzZdFjd5PY5JWdolzKAKGqvrQmccPh6kve4JQeFuiXPd5GpsZrFdGjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:12:24 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:12:24 +0000
Message-ID: <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
Date: Tue, 27 Sep 2022 08:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926214014.5450-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::25) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc5fcd1-d6b6-48ad-11ef-08daa04f3e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krV0raXl/gzlR9kernOU01FCm6UzRcye/OPRwqMjYEn8wXIYlYf15CSdQDDjVgVWuh+K9yJVRY3bt28w5pXI0d9H4dzbRxwlavNogdFE8gPqgly4nr6WKJVvnKXEgkQxRyrdDApOxn1mupdAB4i8No65I/Sr8O0gPhqsGD6Q7QYapMNeRc+11beeKE/yFZGb/tdCyRl2WqKavspvJTPyhs9OUHT4EM/5Imn2rzFjC4/U3L0Ts99+w94fRiaZDZPwFV55t4OjWt0eHW0cVhF7YwLH3QzuZA1tOm+XfKxu5E3qGeyrBEmDD/EHXfffxkft0NE57z2JWdXW2CEa4s2AJMkFPyAr1TJ3VfMBcO514YY0syxihOvOJSZGFrIJnJgjjD1tB4hEalxkEIPit45fgd2+0s+4PBiRm/xXEDKUl9g4Hdc9glqjys1ml5K5e+LiBNJdD0Geip7IgppvcBVmPsKm5GH0zMmnfOhep2IuCzMCJY2Ch+0cYSe7QwQJW4H1NKcXq7wGYaUAk8AmCw6IIkq9FfMnZSwfWHpLVt9aCcyo27fRoIVXziYGuQEW352vPbfKzIt+6O0Mie6GX0ubN/SNIQwGUv7e1NYu/7KhWel123YTcQQUOqgSlztRTQ8KkTBnRL+RJmkHqOvtFxi0G9AerZTycg0DNpEwTopDcgZBkBk4pIRoma1Juvu5KBqj/1NIK9IWQOBNTrhHVr3sLSr5HG1ucMPZbSOhf+hg/egvlpqZohIQ+Ml9hvCWKEP+KogiNAVqX5KZZeSMI/DzvP/cggpWC0C8yqRcXY/7rw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(6506007)(4326008)(6666004)(478600001)(41300700001)(6486002)(66946007)(8676002)(66556008)(66476007)(316002)(36756003)(6636002)(110136005)(38100700002)(186003)(26005)(2616005)(6512007)(86362001)(31696002)(83380400001)(31686004)(5660300002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1qem1YdmVOSVNUZU5vQTRRWXB5LzBNY0NMcTZEMFZCVGxrV3VzUjN4L0ZL?=
 =?utf-8?B?YjE0c1FZZGJSa25xQzBlZ0J3TlVDOFkzSHRjOUFNelVxT2lKVVF1SFVTQld4?=
 =?utf-8?B?a3VsRjM3T2ZQZmtyMHRJODRpSnNGdVVrT1JDamozWnpDSTlUeXNPRUZVVDBl?=
 =?utf-8?B?dlN2Zm0rMENDdHM3SDh2akVIVHVqRXNSZjRCQkNRU0o3Q2xOK2dQUWJNS012?=
 =?utf-8?B?ekVGVFJ5aHV2UzVCMDhwUHlXV3QydGlRMGZ4RnE5Y1dzcXhycTdMd0UzYVM5?=
 =?utf-8?B?c1ZEK3JOdG9qRStZZzZwU0cwSVg4U1RMQ1R2MTNTOHEza0RTUFo3eWlsS2xD?=
 =?utf-8?B?NVNNWEZFMGg3ZFFQemhySXRtRDkxdllkenpRMWcvdmZEMG84QmE5ZXdkc2hP?=
 =?utf-8?B?VEJvZlJ0cjVYSHJsaWtEclZaVVFDVUN5Ty9zQW5XRWJMNHQvcXJiQXVvOXJw?=
 =?utf-8?B?SG1UczR1eDBUQXpjOUZyZHBldmVacyt0MXp0c2xFbU5ndlA0OUJPU2lRL0p4?=
 =?utf-8?B?eWlJN3VvRXlkb1JoaW9CanRkVG1EOUl4Q0hQendHeVlTaG5TYzFZWlltV0VP?=
 =?utf-8?B?Y0lRdlQxaDFLZ2RhOUlXNGs4YldSS1JQblFiSmMrN1hwRjFlbDBOaXhUc21Z?=
 =?utf-8?B?Sm00S0dORWpUQWdackhNclZFWU90TC9sN044UGdkRXhtQTUrUDZuemswbDlS?=
 =?utf-8?B?MDVzRFNUNDVIbW9sR1Q4ZktnNGhVSnNLTnhJdjVrRWRyUjFTODEyWGk0M2kr?=
 =?utf-8?B?cE12ZlN4VnhVRkhnZlkyTk85RmFEeVpvSEpLQVoyN3g4Vkg2VngxZDI1Vkoy?=
 =?utf-8?B?YzNaY3UxMnVLcWY4OGIxdWN6TWdVTDE5cE04L2lDczN2ekIyMFNGQ2tNdzZX?=
 =?utf-8?B?OUUwYUN0cm8xMms0R0hmWStkU3FReFE0V3VzcXdQZEo3WWx6S28rbzNFOG1j?=
 =?utf-8?B?aHVrOHRJMGFYcmZSNldaUWlFVittM2F5YkFXTnhMckpnOENsUVRjc2FlUkJX?=
 =?utf-8?B?UW1USml2RWpyK25Vb3oybUg4SFJybU52UUxib09vTTdmdWJwUVFENU9qZlA0?=
 =?utf-8?B?ZkpIRUIwVk9NbEJQeThCUmlBUU53ejVDc2gyM2xoMWNvcU5QNlZzeHFQRGxU?=
 =?utf-8?B?cEhWb211V21Vc3I4VE5wT29zRVlUR3VNQndoOCtoWW5wTVNqUVNhMDR4UlRS?=
 =?utf-8?B?VWJ0WUl0RDRrQTJUSUlHZUNEVzh4T1N4bnhSTllMc1BzSmc4OWhFTkFsNytV?=
 =?utf-8?B?RUlENThqTzVrdFhxWmpiMGRwbldiU2hoaHl6di9vU2hRWkg0aUkwcmI2MEhx?=
 =?utf-8?B?R3JLZlNMOXovYlA1aFplUzRSTHNGd2hSZzZQSGUySWpVZWJLS2dFTithUjJn?=
 =?utf-8?B?YU5RaDMvaS9tVlZZN0o2SkdoeGQyNGhMRGQ1RXZTMFV6M0xKT2pKdzRZbTgz?=
 =?utf-8?B?ZTcrYms4aWc1b09QMVFqUDdpVlJzUU01bkx5S3lIWGxiTVcwNDdNOHN2TTZT?=
 =?utf-8?B?dFVyR3kvblhGTVM0TWlEOHZnRUJ4SmpYVDE0RTRaMEZ2QUJDYytad1N2ZHNv?=
 =?utf-8?B?b2p1QnlGVldvQzE3cjJ2Zm42VndnS2xFZ0IwL0luNUFQRlhwNnVVVXdsdDFp?=
 =?utf-8?B?MXNqejhPNGFiQkhpU09WRlRYYUFCeEFISTlkZ3V0cmhOcU0xVzBOZlc5Ull3?=
 =?utf-8?B?NkN1bUt4UmNjNkg5Y1pDUThOaWRjbXFGMWs5WHRrczdzNndUcGUvVy9mUjZ1?=
 =?utf-8?B?T3lhNnJTNGFXZUxBc1JtUjA0OGU1RUdVcVRhaFBFdFdZdkFiWm0yMnFtUVpu?=
 =?utf-8?B?bWJHUm05cVJLMEkyeHRod3NKYTkwb3gzSW9ldkpocytVK0JOd0RtR0h3bFFp?=
 =?utf-8?B?NW9UTEQ1amlpUzU0SnVwSzVNRXRNeXFRdUZmelZiakJUc0tPaDM4Wm9CQVky?=
 =?utf-8?B?UUYrNHZzLzkzMWs1cFQxdERWZkFjVU1ySDIvRmEzKys1dVhHTjVDelB3ZXM5?=
 =?utf-8?B?THU5Y1Avci9scHhEZVorRFdMRVRLZXJSeUhjSlpla0lPVWxpWHUranZ4UmxE?=
 =?utf-8?B?Ym5kYnBYdmhIVzNKZ0YwSGYwczRTWklJNnlmb1BBcEp3MVZmcTFQOUUyMlNa?=
 =?utf-8?Q?tp/brDXA6fGQMPmKAiv6qLIQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc5fcd1-d6b6-48ad-11ef-08daa04f3e61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:12:23.8568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FpeVgisLsoYekvAHu8HoQ0k8uMLwO3dfaxElDuSJEDbIvtMpmcR8+2lnk362B9w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> This patch switches the GPU workload mode to/from
> compute mode, while submitting compute workload.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Feel free to add my acked-by, but Felix should probably take a look as well.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 5e53a5293935..1caed319a448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -34,6 +34,7 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_umc.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_ctx_workload.h"
>   
>   /* Total memory size in system memory and all GPU VRAM. Used to
>    * estimate worst case amount of memory to reserve for page tables
> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
>   
>   void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   {
> -	amdgpu_dpm_switch_power_profile(adev,
> -					PP_SMC_POWER_PROFILE_COMPUTE,
> -					!idle);
> +	int ret;
> +
> +	if (idle)
> +		ret = amdgpu_clear_workload_profile(adev, AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
> +	else
> +		ret = amdgpu_set_workload_profile(adev, AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
> +
> +	if (ret)
> +		drm_warn(&adev->ddev, "Failed to %s power profile to compute mode\n",
> +			 idle ? "reset" : "set");
>   }
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)

