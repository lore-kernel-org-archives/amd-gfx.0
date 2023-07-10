Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84033EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 04:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F1A10E15F;
	Mon, 10 Jul 2023 04:12:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F18310E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 04:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3WfBpaaytTkEWTbAGn+xGMLMlya0q6NwsmJuGeuPzgfHWnn8vRYOAoAxhgxsTtHZK9gvs/Hc0HsMSpgnLpmjVeI9o9otgvQhXgp9S6AwlVSgcmz1M50Q30xekx4+IeOJ37UK9zww6eFhheQSiAR4WmIWq71hnHzX0iiJUXsATkcIYvySeCl4JDlgONgMREX3ucIXbUfIS/FwbBY/hUG12okH/OJAN2ufuF2L+KCBSv4Xq4T0Q/6DqWb3OK6056DIEBD2j0H9B722D+yMv/bplZ3ixS2fkxyAWmz+g05ZhOqxl03E0Et277Pfb5xHgVvawJIFvqT/hh3umvDGaZHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfEDkdTtuJANU1q2SDBN9WjRoMfFm1dXgVgE4Z/pSBw=;
 b=XXCYcaByzk1WWEi/GxM0CgHDTwG7TQoE0lAvj/bC+nWGso8foDw6BF/0iwfdenu1/QyDmBbfOgtQ5EsPOoqxDF4s+/t/myCKwhzkH+i2/3xDT/7Ua90wJBX/9UNsN6RGi56lIcWKQw3xu6n47Uv1zH9Sv0kQ4JT8RQFyO/y+pt6epcZv2MHsb4p8NEm7uwmSKMvlaRKhD0acZe5AmH2ZV/dbsXviaoZ8MbDEyM9Q/aT2OSM1+kEAJmfuGZQNpNcwfx8W/L24bAdsS+t+a9tZo6ldR7K0aGdqlM62plLYnrovcWzLws8Shcrz3IMoJZgeVCB82s/Axh/AdU/FDj+aww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfEDkdTtuJANU1q2SDBN9WjRoMfFm1dXgVgE4Z/pSBw=;
 b=iMEYeLTPbEgF46J6irw0X8807CfbjbimPI2qtwWJTzzZoQP28V71drXngveh8efHfM04dr8xGCXOmJ9GAXBkaYZHqDiDwhSlyDLxL52h25Vk54NQJVT8cugRHDHMoHu2wNo4vi629MKkEOGI3/6gPBXzKNhuztOZJo5qu62S1Lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 04:12:53 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1940:93e1:ec7b:f723]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1940:93e1:ec7b:f723%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 04:12:53 +0000
Message-ID: <18ab439b-b3e9-fc1e-3447-f2331f423168@amd.com>
Date: Mon, 10 Jul 2023 09:42:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw instead
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230710031004.1106582-1-Lang.Yu@amd.com>
 <20230710031004.1106582-2-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230710031004.1106582-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3872c5-a482-4511-aa5f-08db80fbee02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rx1kX/D1rkGAnwgAX4UQBSHDwWoozn5OK553X9Dqzda4ubGFT3+E0LiZqidd3KZTs/CsWYmydmMRyrMth9lZjxX8l2FXcoyDeGGXGPGfebnw4A0oMWwU8LOwsfdWTz7Td9RlZMka7sEqq8vu0ax+I6aZ3V0Plm+dN9MHnZvLSqPikpc9J2CwALPWh0dmwfrOZ4llJpjBTc/RSIKTSrpUXnBc+7PqidEuWqEvq80GrxvowBzzRLyRY4Pmjr8cSorvmnMNbg+YmzvBM/ggrBnRHDsuDHtoO7BGfdOgmLCdD2XYVQBN2X/g80y7RIRcvclOL4Y/n2pfx3JsRLpdfuKOGb3swfdA+5IV4KZDM72UBQFpa7klb1azcAfaVPTp86Uyg5h/LjIx4X6cv+EP2OljTCCX6ufW8efEXuHRCx3QvGRbYP8oYVK6u3PGMsMloms35MI7YGFnJMLLN6njqKMbbBJ1RhZ74eWYUYN8FcF7g7KXSXzGyP8VdCEVahbQZcZkeBYdk2oQcWCfSm00EBw6oXMFjKWzh5yyqXi6NLK6JsFn53+8jfKNmu+N/joU3qzQHpF/ODpXEjtvtQUjIANKyskBOa+YfYxUcWHb4RFxMcuBMHq8q+HahNYOwtx16quFURByUnXDmn/68s2Bj8/yjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(86362001)(38100700002)(31696002)(31686004)(36756003)(6666004)(6486002)(54906003)(6506007)(53546011)(26005)(186003)(6512007)(2616005)(5660300002)(316002)(2906002)(66556008)(478600001)(66946007)(8676002)(8936002)(83380400001)(4326008)(66476007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVhMEtwbnl6TTR5QzhGOVBIbDZ1RGVwZzlDWjRIaHRFd0ordFNTRGZSYnZN?=
 =?utf-8?B?K3dpRjJmOTgrRTAxczE0cHdEMlhyTW54bHRRVDNVZElBY3lEWlpBdUcyUGdK?=
 =?utf-8?B?bWo1WnRRczVyN0p0SlBqWlNJb3REQ2p1R2R5VFh2TGR3NkpNY01XRUh2ZjQz?=
 =?utf-8?B?TXgrR3hLeTR2cG5UVlExY2UybjNNSXduNkhmZHNjaE84enUzSU5qZW54S25B?=
 =?utf-8?B?dlV1dkR6QlhpQU1SWDltVmVFb01obU9PVUdJV1hGK1dMdmJJSm9ySG45ekJt?=
 =?utf-8?B?c1VwU2Q5THFkSlNrYWxTWS9uczYyYnM4YWE5ampOTzRkSlpaeHlyUFdza1B1?=
 =?utf-8?B?T3N6am9oWTZaYnRKdEF4TGxzektWZXVacDR6VmJoNEREa3VOckFSWXdzWTBp?=
 =?utf-8?B?dmdBamVCMzdKbi90Y0dBOHY1TW5uREZRWDNmZGZ0K1hGRDlSRjdQQTRjSTRW?=
 =?utf-8?B?R083K0VSY3k2NnUrZTZ0MVl6ZXdWWGZnQUlDUlpxUUZuTzl0ekFVa3hIamY4?=
 =?utf-8?B?SE9NZGpOQ3N2aGkrYVhRNXM3c2JLUlBCaWFRMVArR0RQV3AvZzBZNnA0Ulg3?=
 =?utf-8?B?QXl5VkdaM3NXMUR1NHdSaDdCWWdmQ0hheGQ4eU5RUnNxekdiV00weDJGOFFw?=
 =?utf-8?B?NDk4ampKL2R4NkEyczZuOHJYQzJhdmVKaGhjdk1rY0swUit4WUs1VmFrS3NS?=
 =?utf-8?B?NWd6V3dkY0l4aGtqbzRTUjZzZWo1aXRLSVQvQlpnTW9jMDIzQ1lIcjhHb2ZI?=
 =?utf-8?B?TmlvS29HVit5ek5NeEN3RkRWWUtWTWZweStnRjdybiszZzcrM2FyTGJuRTEz?=
 =?utf-8?B?K1c0ZmN1OU1qYVRwWTRYakpiWnlXUHNqNHREYitrWldUYVZRTHh3QzBWVzdO?=
 =?utf-8?B?WGtVMndrQnk5WXpZSDF3SG9QREhkVFVuSlRxRlZ3TWZCTzRZL2FtVW9vbEI3?=
 =?utf-8?B?UHp2aHkva2pUemRHOG1OWWlrOVZvcGdCWWlwdmkxcFdiOHpqVm83Qy9mZGdu?=
 =?utf-8?B?cHI5SHFITCtrSUdaQUxvWFMzTEVHS3ZWWGtXVldJOEZsbFJKYk1ucmRZYlFI?=
 =?utf-8?B?SGZVRkJ2OXhYR290bUNQQzhTcVBmc0VLcEE4TnFiL2l5MXNkZjRLRDhoZisr?=
 =?utf-8?B?YklHTHl5MkVjd2JHRGQ5cy9GRUNzRVVxaEM3T2NFZ2lXZGREMzVEMlFjZVhS?=
 =?utf-8?B?aU9sdm96U2ROczNNK3YxZ0xZa3A2WFcxQno2bmVjeW5wdVAvRGt3bXFKZ0E1?=
 =?utf-8?B?Qm9PcFNYZVoyZmg1VUcwZGl2V09UekU2c21scGVuQTFETVRPUzcxU1dzSEZO?=
 =?utf-8?B?cUEvV3hLUnovcVNVUmpMK004N3F1Qnhma2Q4aG50ZjlZY1J0ZWpyNUIrN2Fm?=
 =?utf-8?B?ckpWa01lUGtkTnB0OGo5M0hNNnpvMnRubXlHclpvbTQwdlpNaWJnSy9VV0tr?=
 =?utf-8?B?Nk9FR3kyYzVIa3JmTUhZQ0wyRllONHA1MVowbmFsVG9BT1dhcG9xbE5DamtZ?=
 =?utf-8?B?T3hzN0E5MlRKZ09wYndVdDVGWEhqczZucDRHbWd1enkxL2NZVk51VzFBYUY1?=
 =?utf-8?B?YnFyL285c1kvRFZyZER6QkJ0LzRBZmdIMWlpM2RYU25KY1VRM2xvZGlzbXRY?=
 =?utf-8?B?WFE1UjFPN3Y4OFhlZFo2Z0Z6aE15TE9GTmd3NGtnak5aN2hpdm1GdzB6UkJ6?=
 =?utf-8?B?ZnFqdFVPbDlQMEtKejJ6UzdBOUNnZXRVWmJ0TDBtcExLc2FHdGhhQmRyKzZQ?=
 =?utf-8?B?VTk3cDlqM1IrMWxVR2VlVXl4QnpyQ1czYTRGcGFvclcya1AyU3BYR2ZGc3hj?=
 =?utf-8?B?TnVROXhJZlNSUGpIYlFiYTkweEFGd3Fncm12YUhxTzdHNHgzTEtqbDBYakx4?=
 =?utf-8?B?QmVjRjBnVjlXYU9LMlNIR3UwdG5sRWcva3Q4MHl2c0NmN1c1elAwS3JsS0tB?=
 =?utf-8?B?NkloeUMvVjdIalVFOExwUTBwMG95RHFhNExZZ3dGaThZUy9JT3JjdWF4ci9m?=
 =?utf-8?B?NmZYQXNyR0lYenF2TEgyMGhxRk43Mk1CY2xuTHFYUE5EZzI1WkV2WjArdzRJ?=
 =?utf-8?B?MVc1TFg0aVVLRmNXeXlabldFdzVLYnJvanVvL04zNlNaRjBpQkUvcmlaaG5v?=
 =?utf-8?Q?qs5IFjRuJ/Y8PxO32s5cmcKxD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3872c5-a482-4511-aa5f-08db80fbee02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 04:12:52.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTfPIP5ha2ayVD1gXamcgM9qz6Y0OX8y6Ewh5+QxQWoLbemGJU9Ijv+kOICM5U0r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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
Cc: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/10/2023 8:40 AM, Lang Yu wrote:
> Replace the old ones with psp_execute_load_ip_fw.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 -------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
>   9 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a1a4408e524d..1b4d5f04d968 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2920,19 +2920,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
>   	return ret;
>   }
>   
> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> -			uint64_t cmd_gpu_addr, int cmd_size)
> -{
> -	struct amdgpu_firmware_info ucode = {0};
> -
> -	ucode.ucode_id = inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
> -		AMDGPU_UCODE_ID_VCN0_RAM;
> -	ucode.mc_addr = cmd_gpu_addr;
> -	ucode.ucode_size = cmd_size;
> -
> -	return psp_execute_ip_fw_load(&adev->psp, &ucode);
> -}
> -
>   int psp_ring_cmd_submit(struct psp_context *psp,
>   			uint64_t cmd_buf_mc_addr,
>   			uint64_t fence_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index efb3972bfebd..c3203de4a007 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -466,8 +466,6 @@ int psp_execute_ip_fw_load(struct psp_context *psp,
>   			   struct amdgpu_firmware_info *ucode);
>   
>   int psp_gpu_reset(struct amdgpu_device *adev);
> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> -			uint64_t cmd_gpu_addr, int cmd_size);
>   
>   int psp_ta_init_shared_buf(struct psp_context *psp,
>   				  struct ta_mem_context *mem_ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index d37ebd4402ef..4e1256af80b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1257,3 +1257,18 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
> +			       enum AMDGPU_UCODE_ID ucode_id)
> +{
> +	struct amdgpu_firmware_info ucode = {
> +		.ucode_id = (ucode_id ? ucode_id :
> +			    (inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
> +					AMDGPU_UCODE_ID_VCN0_RAM)),
> +		.mc_addr = adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> +		.ucode_size = ((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> +			      (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr),
> +	};
> +
> +	return psp_execute_ip_fw_load(&adev->psp, &ucode);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 92d5534df5f4..1f1d7dc94f90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -414,4 +414,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
>   			struct ras_common_if *ras_block);
>   int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>   
> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
> +			       enum AMDGPU_UCODE_ID ucode_id);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index c975aed2f6c7..18794394c5a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, 0, 0);
>   
>   	/* force RBC into idle state */
>   	rb_bufsz = order_base_2(ring->ring_size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index bb1875f926f1..6fbea38f4d3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_dec;
>   	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c8f63b3c6f69..b76ba21b5a89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_dec;
>   	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index d96ff4acae35..e8c02ae10163 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5d67b8b8a3d6..550ac040b4be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   
