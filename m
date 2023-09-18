Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCBDCD37B0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 18:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09D610E2C4;
	Mon, 18 Sep 2023 18:00:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C93510E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 18:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+TY8RH0o6DvyvIIO6TxFyCmj6Tzmv//AIEtoZmiL0qqiwZ0TftFW/7P9Ibd3YrazO+PRPG0DWitYS+J/uvIgYyowQmpq4Ys27fELawgzifimXs+OYT/yjeFzmDLwAeNa/BThBHqGjz5eeTGyYsaZy6TkJKxwYuY5scfiSetoSENxUN8bRyS64ylpRxUz8jnlgk9aft+LaTZkf7AAtJQ8HfDFeU6JVCM4UbLvBiAVq0OMxuBUbPiCIa4Wi3BDVKZrU9UHGQLs6omqEve+xZZKaIa/pzzoFYbtgPjGSPNtpzuo4mPChELpR57Zubhu6eU+tPXnRvd1EqE4MQBuEJD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EADFVyFqICQU4PI2c5+Kas3HsLQc1GSbgINxHLhgllU=;
 b=G99GucHnmErohLhOM0O/ZOI3JFZT9zgRTuQ3hKbKYg9MSk4ITAUuvUHVmh6gGm3Mxf8Uv2+Gy2vB26ZcQG1OH5iOU/vp8MKCTOkdoXqTG17nwvmyQPC8GVYXGNgwGhrJfxhk6Lzm35oFzaM12C5erOncrRfDvvUbhB7HzSxuftdZGwUJO5DW/P7Rjr0H/mLFTbYAwX17oypHkCDK31TwM1WvztOCrskZvkloIE141ueJckMJHqcEwIl42ogml3+U15zCB2R1HwQe573AQ8LmbY4w1K4WuDQUMrMAVkVY46RkYKK5OEeCDBsO72FHju8rdy7gInLK0EJagv5fHojrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EADFVyFqICQU4PI2c5+Kas3HsLQc1GSbgINxHLhgllU=;
 b=Mm8RK4Ph/HO1VfLjOAUfeOuDx9l+nKPoHEPGqhRGm5OjQLdIEWcQTMQEZEhUq7bSuJWnjT64OEJu3zNcmxJUcbA3F6aCQHza1v57K9WZjhI3VCW5J8HoEgjgo9wK1fJuhNFQjYp94xky7E6goOslnWTvOEL1nQDQxVbdqh36oCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 18:00:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 18:00:25 +0000
Message-ID: <bfec7f03-7245-1cc7-60f0-72ac146b5d89@amd.com>
Date: Mon, 18 Sep 2023 14:00:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: use error code EOPNOTSUPP instead of ENOTSUPPT
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915000605.1597561-1-kevinyang.wang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230915000605.1597561-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f539ab-b084-4c17-204d-08dbb87122a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPLDZRNPCrdkfQ54M7RCH5gZFDF1/m380gxCjwnqcLS1O+I/bQ+39ZOIAyw6cyPGi1kiwgVP6WTcancM9nl0q12fEnudO/JvYSFE2sS6xZbz2NfR27hoNGlaW2oyMf0a94LoFoKLORc6xK9y6h/fr9JWRLts1lPEcqoGTRoZTCvXK1E3FeMzio/0DPiu0oOZOK3EUWdpx+6ARwK3w8SDSpYPIUuvRm0G9CVnqI3p/A/Un1yFrPbQnFkEdlj0jBInJawkjOAP90hEyizk0fRxheFCZrv5lsqqtQzSrP9cK8/dzULkpwxhEMK6+aIWCcmHHXLn3DkPT2U7EutzePEKaihXezW2NtU8z3UVR9R0PSyzo2dL9WHJSgFkZRrZ/+cHoHk3FQs5TBMwjCo59b497DEOHmF4BZcuoI6hYsKZl4WbS1O2YFCD8Jz9tJwxIPZ1Gzhp9j1OrV70kxLZ4I6Ce3na5UewP9JWceBsXoaSOBoXwo+yRhIetaywMABSDakbkbPRTBhPgoCNWB20yCFYwuMdXzCf/5JMcfATn8hB9Hw34QmoIivyOmvzsJlA8hFw2c5McUnDVHhgul749tD/s8n5Q1qy4N2xaGYlmabci30HIdhMHrIdiDFfL9y38dDp0HQliyHwE95erL//o9ge5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(8676002)(83380400001)(2906002)(30864003)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(31686004)(6666004)(316002)(6512007)(66946007)(66476007)(66556008)(38100700002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW92UEdXRGQyNUdzWktrSzN0anFtOWk1QVRaUW9UUmhlZXBPWHlzdFNPcnpr?=
 =?utf-8?B?Y1VUZ285TnRwejNKNWNrQXFTeVg0RHJJTTMwYmlFdDUxRlJoRkFUOXE3bVVM?=
 =?utf-8?B?S0RIdzJyU0VwWE1jSjFPdlRaWVJmVEpHZjREOGx0bW9DczVCVUFVTlhwM2U5?=
 =?utf-8?B?cUc5UzRsckdJODBhYTlCTEJwRGRIWk1tdUkySE16T01yRjNHZzg2b3FjUkFP?=
 =?utf-8?B?UjdBeTBNTnRtbDdKRE1vRmFWQlpYelN2SkdJSFo0dUNNWXBDRUFsRzQxc29j?=
 =?utf-8?B?Qm1kZUJCNlEwMHdJczdzY2x0QkRacHJVeFNoZkkyVmpRRVk0dm5sZlFnMlBX?=
 =?utf-8?B?bXJWaGhzWDRPVm5YNElybGo3M1llWERVbDN0c1pwQ252Tk5Mb2ExVUdvOGVz?=
 =?utf-8?B?OHNSNXppaUFRQi80NHUrTSs5WGJ4cU9wK2tCRkFzejJYa3RrV2JyeXBmQlhy?=
 =?utf-8?B?SWlHazd0RGdaeGhCWEM4MVBRVHRkSWRodHAydW9WbmFJOUQwSHUzZFRsbW1a?=
 =?utf-8?B?VHd6bjdUNzV2N3pCeDdOWWtxaEFzUWc4N1pGTXJxZS9uaHRkM3BTZlZhdjFD?=
 =?utf-8?B?TWkyRXczRVJHVEN6TndtSUJicjBRYThpaEc3UGE5c3lYOUpSQUJJa2lJdjc3?=
 =?utf-8?B?T01EVEMwaVkwcjFOWVovMklxRHZjK3pzNXB0Z3NTclBrOEtrTHF4VWhaYzJE?=
 =?utf-8?B?VjMrNzMrNVBWTGd4OFE5dU1adG8vakkyKzQwcEFWUzB1eGpVQytYMytzZm56?=
 =?utf-8?B?L1E5dmEwWlAyQXVaRW1JSWhielpDRzFtT0h5OGJhV3Ezbk9LSXJYT2NMN1o5?=
 =?utf-8?B?YlJwSzRsYWFoNS9KN3RNRkxHQkM5VUV5RG0yYjN5VmRlbjRSWDhPemJrZitC?=
 =?utf-8?B?RmdRd1hoQTF2ODBnKzFqVllhSzlIdldoWjBidWppLzMrSUJRTk5IYklrWmhy?=
 =?utf-8?B?enZiZHZFUUNRbkhjT0ljd2ZteHl4cmVFM2tCKzF0bEtta0VGWnNlRmZESWY5?=
 =?utf-8?B?M2dpVnFCZkluQnRHaDdUSGwyd3J0SG9mdm1YcjFlRkhXZUhmQ25LNUQyYXBK?=
 =?utf-8?B?OGF4Y1lvNTUyVW1MUHViM0VaZkxrNnJOSzZMWEpqcUVrZmwvUHN3WFpIR0Va?=
 =?utf-8?B?djFkMkJDKzBJdmdGV2ZIWXdybVlmZkE1WTZjVnhab1Q5K2ZGVURHUVk3bEFX?=
 =?utf-8?B?TkEyVHFhZjMySkw5Q3hIYld2WFU2TytnZHNmZ0tzeWVUenlNQUJnbmd4OHZm?=
 =?utf-8?B?TmVkN2Rjd05oTm4rUlNEOVBVdkdKbU8xMTZhN28vTjl3dExoNy9IeGJKejgw?=
 =?utf-8?B?dWFtZWRkbVh0YnV0ZDlrblFNc0FCeWZHSHNLTmh2NXRwdlhwcFJxNlczL2hG?=
 =?utf-8?B?NUVXTGNINlQyZmdoWlMxajNCNmRsZ1VhNEJwTnZ5R0J1Y2Rid1MrV1hKOEZV?=
 =?utf-8?B?bXM3SHBVTUJyOWRWYldURk00QkFOeXZIK2NiZjBSSXhXRnVCSDcvL01zRlh4?=
 =?utf-8?B?WHcyaGVmM21qRmNSbVhPcDdiOXBGWmYzTXNLaFdDSE5NR1liYkoxKzM2UDhJ?=
 =?utf-8?B?TVdURzJzM2tMTDh6N2lqdHZTdkhCSzBzS1BtOWhuL1dsTmJEd2Q5cDBkQzkv?=
 =?utf-8?B?RDkyOGhXRzRJcDFBRFhRbjA1QXhERlR6TjFyK2N5V1pVdEZUYm5ZY3NUNTAx?=
 =?utf-8?B?QjB0eGQ4U0ZTZTJaNHZLa3NPZHFodjNRNUh2VVM4UjRHUmxsUlMzNC9zR1hU?=
 =?utf-8?B?SU96N2xmeDBEa0VRYzYrT2pjRUxnL3lyb2xKMHdYSE4rcTN5YzFxa3RjVlhC?=
 =?utf-8?B?b1N2dnhzWXdtUVFjUG9XdWlNbHJJS1pZZ1FyNGp3ZkF6ZUNKb0dnbzBsekNQ?=
 =?utf-8?B?NUNyMGtUUnFvc2xJRFJaQkpZYWRUT1RzM1RaR2VBQ2JHSHlaVkF2elg1ajdQ?=
 =?utf-8?B?NTF4WlpVRVNmN3dhV3BIN0p2bHNDeEticUhZajltdXJCNk1YMkhRK2JYY1Qv?=
 =?utf-8?B?Mi83aU0zc3ZQMm5Oa0pEUkYzVW1KQ0tSS0d4c29jUXQwZWFWQkNtVHhTc0Ju?=
 =?utf-8?B?bm5mNk05d0hlbzZhcElZTDMxVGVlaFloS1p5R3ZIOHZLdW1jZVoxWU44YnBU?=
 =?utf-8?Q?a99yVJ4zRD/wQVaxzZt3tYlmy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f539ab-b084-4c17-204d-08dbb87122a5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:00:25.8957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9Zu3PWB+ZoEtmyryDJBQUwDTNOVVRDYgNQlmIUfPv8Um3hYOcLSWuGiuNA0RP+Dzbv+Uv6n1eqVvOfjL1fDww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

On 2023-09-14 20:06, Yang Wang wrote:
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
>
> $ find drivers/gpu/drm/amd -type f \
>    -exec sed -i 's/\-ENOTSUPP/\-EOPNOTSUPP/g' {} \;
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

The kfd_chardev part of this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  2 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  6 +++---
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  4 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 18 +++++++++---------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 18 +++++++++---------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         |  4 ++--
>   10 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e055e06d020c..a7f0b6ccd137 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1268,7 +1268,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	r = pci_resize_resource(adev->pdev, 0, rbar_size);
>   	if (r == -ENOSPC)
>   		DRM_INFO("Not enough PCI address space for a large BAR.");
> -	else if (r && r != -ENOTSUPP)
> +	else if (r && r != -EOPNOTSUPP)
>   		DRM_ERROR("Problem resizing BAR0 (%d).", r);
>   
>   	pci_assign_unassigned_bus_resources(adev->pdev->bus);
> @@ -5747,7 +5747,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
>   	if (!amdgpu_device_supports_baco(dev))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   
>   	if (ras && adev->ras_enabled &&
>   	    adev->nbio.funcs->enable_doorbell_interrupt)
> @@ -5763,7 +5763,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>   	int ret = 0;
>   
>   	if (!amdgpu_device_supports_baco(dev))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   
>   	ret = amdgpu_dpm_baco_exit(adev);
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e3471293846f..ffd7035603cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2126,7 +2126,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
>   		dev_info(&pdev->dev,
>   			 "SME is not compatible with RAVEN\n");
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   	}
>   
>   #ifdef CONFIG_DRM_AMDGPU_SI
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 42fc0cc13fdd..e31b7f9fcddc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -867,7 +867,7 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>   		return 0;
>   	} else {
>   		memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 65d2b9ae16bb..120b815a3f27 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -262,7 +262,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
>   		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
>   	else
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   
>   	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
>   		q_properties->format = KFD_QUEUE_FORMAT_AQL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e6f1620acdd4..2c88dbe2d718 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -147,7 +147,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
>   			   uint32_t *min,
>   			   uint32_t *max)
>   {
> -	int ret = -ENOTSUPP;
> +	int ret = -EOPNOTSUPP;
>   
>   	if (!min && !max)
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 650482cedd1f..f48ec6c62307 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2591,7 +2591,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	case PP_OD_EDIT_SCLK_VDDC_TABLE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
>   			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   		if (!table_context->overdrive_table) {
>   			dev_err(smu->adev->dev, "Overdrive is not initialized\n");
> @@ -2637,7 +2637,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
>   			dev_warn(smu->adev->dev, "UCLK_MAX not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   		if (size < 2) {
>   			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
> @@ -2680,7 +2680,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	case PP_OD_EDIT_VDDC_CURVE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
>   			dev_warn(smu->adev->dev, "GFXCLK_CURVE not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   		if (size < 3) {
>   			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 164c2264027d..828e6676e713 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2256,7 +2256,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>   		if (!sienna_cichlid_is_od_feature_supported(od_settings,
>   							    SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
>   			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -2306,7 +2306,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS)) {
>   			dev_warn(smu->adev->dev, "UCLK_LIMITS not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a3cbe15c3123..a928ed20884c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1529,7 +1529,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_SCLK_VDDC_TABLE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
>   			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1590,7 +1590,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
>   			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1651,7 +1651,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_VDDGFX_OFFSET:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1673,7 +1673,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_CURVE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
> @@ -1711,7 +1711,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_LIMIT:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1733,7 +1733,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_TARGET:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1755,7 +1755,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1777,7 +1777,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_MINIMUM_PWM:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -2356,7 +2356,7 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>   		workload_type = smu_cmn_to_asic_specific_index(smu,
>   							       CMN2ASIC_MAPPING_WORKLOAD,
>   							       i);
> -		if (workload_type == -ENOTSUPP)
> +		if (workload_type == -EOPNOTSUPP)
>   			continue;
>   		else if (workload_type < 0)
>   			return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 430ad1b05ba3..f85e0ef60fea 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1515,7 +1515,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_SCLK_VDDC_TABLE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
>   			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1576,7 +1576,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
>   			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1637,7 +1637,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_VDDGFX_OFFSET:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1659,7 +1659,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_CURVE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
> @@ -1697,7 +1697,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_LIMIT:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1719,7 +1719,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_TARGET:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1741,7 +1741,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1763,7 +1763,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_MINIMUM_PWM:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -2310,7 +2310,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>   		workload_type = smu_cmn_to_asic_specific_index(smu,
>   							       CMN2ASIC_MAPPING_WORKLOAD,
>   							       i);
> -		if (workload_type == -ENOTSUPP)
> +		if (workload_type == -EOPNOTSUPP)
>   			continue;
>   		else if (workload_type < 0) {
>   			result = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b3682807cec2..f81ffe7ce7bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -50,7 +50,7 @@ static const char * const __smu_message_names[] = {
>   #define smu_cmn_call_asic_func(intf, smu, args...)                             \
>   	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ?                          \
>   				     (smu)->ppt_funcs->intf(smu, ##args) :     \
> -				     -ENOTSUPP) :                              \
> +				     -EOPNOTSUPP) :                              \
>   			    -EINVAL)
>   
>   static const char *smu_get_message_name(struct smu_context *smu,
> @@ -492,7 +492,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   
>   		mapping = smu->workload_map[index];
>   		if (!mapping.valid_mapping)
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   
>   		return mapping.map_to;
>   
