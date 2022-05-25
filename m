Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00EAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 12:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0F610E9B5;
	Wed, 25 May 2022 12:38:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05A510E98F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 12:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1pFDMFNycO0t+JnF6nW6/ay34Zqs3fv2vk5VfdvcXx6nffopzYifJAyehPEVmeS0vQmYkoebc1iNPDPRiKiDwYBOQBeRtyUxMC4a2not+GeCiOcyhBGSsk7Nnnl7Yc9skzvRsXuaVo5V/dpjBKIcpCnWBD+j1iRBjEk4frvEafnyY39KVg2LkeXRgTa5sxxwceOaD2kkDgfZ08Dly5TCoUnphyYzK8r6E6fjdby8E2UcuzpEQP7nSw+BSyWXESEp/Zrz206YxLaGVr8wloSm2Wh5pseh3nqL39S02J98Ej+y2DJRh5PYv2g9SiZkpFYxVhsg6b8nBWRm0QAef4xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thfzZ5UbgrgnROiYMchsV1uQvE9EiC7QYqOiF6aIVhY=;
 b=MGdOX+d4jCQl7VrqtZorNtjfwkF/msCY16x6e09L1qDDXoNkcjSjSY0Ib5Qen+wSS/oJdDPB0MsAB9mhePQIiptbpnFcazg8Wpq3DcvDMPU5+km69Qc+ycjZ/cDIrr+RvYnTpzwrLBV2x0nl2YxzrZpBLLXhlzsxO/zLG3xDaK7W2C6gn/M/YMdtEMt07d2hl3HgV6rnm21Zv6pRxxPl3fJ4v64bL61JfzHzTds+iQvDQpifUSoZckMCUpqqElWEobJLkWWZGA6qlYnhgzmyGELp2K0ueRyT80T2umTDOaHUBj3f+G15V94iA+JMdURQVmOQOOUDCYxFmvjnuexJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thfzZ5UbgrgnROiYMchsV1uQvE9EiC7QYqOiF6aIVhY=;
 b=co8Tw2VQYX7OmJhfp2kI1BJMniIz6OP2GET0IpmtcMlzQcvM0KHAmj8whniSXeMxdC24Kouh7jy/J6bcGvSf+wkSqeyIGB8QQu5l2aJc1VZOReW6CV9DXP702rTSw6LxzOBLUCeBJAWId/kJktXiB/unNzY1HL4K9r4eSmHlQV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:38:51 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 12:38:51 +0000
Message-ID: <0333920f-7db9-404f-7f15-acd2204586fc@amd.com>
Date: Wed, 25 May 2022 18:08:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error
 address
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, tao.zhou1@amd.com, evan.quan@amd.com
References: <20220525061047.26529-1-Stanley.Yang@amd.com>
 <20220525061047.26529-2-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220525061047.26529-2-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c917b16-4159-45fa-acbd-08da3e4b8547
X-MS-TrafficTypeDiagnostic: DS7PR12MB5768:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57689C2C1B30C762E2B4585497D69@DS7PR12MB5768.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVs4Ijm0tbLyDhDb6rSvlCR92HDQ1WUD3AM4ycQubque6n+LYe+jV5TGLVIewcjhNaUPMGck9etcGNi8vQe3RqWZEL/MWIlhjjT35F0mYMMhgB/vFftpEhB4K6+dYJFPnOOj2+ALaSuHkZklY27YJc8K05EkGdJm2qB6nrAKBHvrpjGqzrvJSWz/mpVc49VKI/TAnS3hb3nptIbxLBtuT2ZBSxk6SjQbPSi7Ju6iZzue3FouguFscCXjto6hWrhTSG84jbszDsndoD5kxRQefSuXof49hOpa0rKFSNrBwboxxpqiaphDYszmt2tdz9CQyg+LIORA/6rWMvy7elSe5JFv/ESy4lYjPqES2R8JeuatZKXU3XAkD0sRyI8XJ+ELvw10lZHPGHkHjjsj1PDNRBwEYvFhTl6ArAY4ggAvUuju7EDdZ3NZ2g0a74dmQ1Yya1CUPEVvXftF6iHpjpHLkydFnDxwS2CbYH2xIec1z+1NAEo+5AQAUT8/j0NAz4OIcm/Lt27gctb+fHaaHL5UcaWDYpq820XVA1yyMrAnoK7Q/7novW0Cb8D+nJ0FgYycwhSAu8Azvk2cpRDqUnG825hkry0NegZ/hFMKNUy7xGSxB2RlxkkCNKcL3N1Rjm8zyU3xGclOD035HLjtxQE5OViKCFwRk8gbhRA6S7cZOToFBH+3bKVASVVZa3y9/gg0DVkMORrvA+k1epS7SSpHxC5auLULAz7Ah9IOqWs0vgRixm2i0AB5vaz+69V1WVcw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(38100700002)(53546011)(508600001)(66556008)(8676002)(66946007)(66476007)(31686004)(6506007)(6666004)(6486002)(86362001)(31696002)(186003)(8936002)(6512007)(83380400001)(6636002)(5660300002)(2616005)(316002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlwY3NlSEhKRXUzTlFhUEhIZEZHQ2F0WkQwRTZRSkdyekowd251NlNjdnlY?=
 =?utf-8?B?ZExsa3AwQ1I1a0w5OXY5cmRZOUJhTzBQQlhhSDdnNnZTM1lRNUZsUXZralFN?=
 =?utf-8?B?MjdFNlQ4MERvSUFySnA5V1p4T2hpNmdoa05LLzlUZW5PSUFrZk1kcUl6MjJ1?=
 =?utf-8?B?T3l1WWZaNS9ncXA5d3BhRmNvR2hHUysyNzJ1NzI4S1habUtjaWFaR0xndC9u?=
 =?utf-8?B?VDZmMkNCam81UFYzempQSE5VcFduck9YWmUwWjBWSGJnZ05KSkw3TmpaVE80?=
 =?utf-8?B?TzlYRjBpWERtZitJalNTajBrcVNTVkp0eTdlWWYwdGxScGQxQitOamI0YVhN?=
 =?utf-8?B?V0FaZkxrN0F1OThqU0NyUXNudThPNWU5UWZlV1RMc3ZvY01yNnd5aHF6VFlm?=
 =?utf-8?B?T3A1MTRkeTVxeVRBbE1xT2ZMSzQrRWQ3c1lBUzd0SmlrdytTVkEyT3habzE0?=
 =?utf-8?B?SDRHZ3VzZVcvcW1kRjlhWFhCa3drM280Yzc4Z3BZZXhna1VRTFdZbEl4aU9X?=
 =?utf-8?B?WHJCRE9tYUd2c1lSNjdkVmtQRU9HZzNTaS8yQ0ozcFhSd1lNM1BrdjNkZUpl?=
 =?utf-8?B?WFRKRUtyS3c1OC9LY2k0OHZlNWhydVBubngwLytRblhvd1hpVmxYbGs1b0hw?=
 =?utf-8?B?dVBhMkFzTUllYkFBOGZZdG5vZUxUQWRTUDRSVkxqcnF2am01L2xrZUlpZ1dj?=
 =?utf-8?B?Q0JibWd1ZTRFWTIyMjdpVmYwU0tQYThBMEROVmc2OXlrNnNONjVkVGM0UGJ6?=
 =?utf-8?B?cG5iTmhOejdDTkxTdEZuREZrVXpxVXVvWHJBUEE1UTlQZWgyRkwzTWNGaEVB?=
 =?utf-8?B?NDdnQTQxeUJTbGRjMDFUOTNDdTZ6S1V2Um15NkFWSnNoRlMxeE5sRCtFTlJI?=
 =?utf-8?B?K1pkeHM3Skwvd1gybC9qRFFCZ2VaN1Z4WFV2bmlZUVFrTVIrR1BrM1lXdEhs?=
 =?utf-8?B?MkdoNFdXVFM5VWdTZ3YwQm1GUnlUa3hGVVRZdFBOMmc1VWFuTHNvVk80SHBN?=
 =?utf-8?B?VlJxZDZYS0tIbGhqOGp0aW11MStVd25OZ2xkQmVTclgvS09rMkE2WjgxZHNh?=
 =?utf-8?B?c3krVVo3eDBhQzUrMVFldmU5U2l4TzhtNGdBdjAvdzM3c0Z5R201RzJBUUZz?=
 =?utf-8?B?d0hIUXlCWXh1TVJRampMY0tyZHFXNkFJeW5vL0J4SS9GNG1SV1FXSkZ2MFRN?=
 =?utf-8?B?ZTdnSjFrYVEramRoTVFRdTBkdW5ib2I5N09pS1Y3SVBZcFNQV1YxaHQrd3Js?=
 =?utf-8?B?aFNmT3c5WnRSTTJnd0JDbEdiTllTRGYrZmNOVDYxN2l2RGRGc0t6R0lpSHFk?=
 =?utf-8?B?Wm1aelJCZzRSNEhpMDJYWU9NUFpHUDU4VFM0QkQ4TlNuYjMwV0QzMUtsUUlG?=
 =?utf-8?B?b3dMT0l3NVYwNDBmYXpReWNaUzZZT0t3QXFSZm5ucjNoa3dBQThjTE5ZVzJQ?=
 =?utf-8?B?R3kvc1JTQTJzanhjM2hvN2VPb1M3MWZhTFlta2RDM2VwY3JPczNWTmNBOHc5?=
 =?utf-8?B?YlhMdGsyVnVpaGcxcFJxbCtsa094bUhnWDEwelBDMGdyalVnamEvR0U4TnFI?=
 =?utf-8?B?ZmNnUnNQakZnSUIrNmJCN1pieXJXeWlHK2RIVXpvOXVEQnhWV1o5YTBUNVFC?=
 =?utf-8?B?MlhsTDU0RnpENWNUamdaVEU4ZXVGdmREUHl5L3AzcVkxWk1zR1dvd2xzdmdr?=
 =?utf-8?B?YlFqT1B6d0VyYUM5elN4ZklUblRHVXN0cXk1YU5GV2NUbG1QUFR3Z0VKMWFs?=
 =?utf-8?B?TWNySVRiVGFwcE5PeTFZN2JDaW84bE9xVTYva3ordmtkNmNLWTNiam5ORHN2?=
 =?utf-8?B?bUdJRTdPZEhReFZpWHllNkw2aU52VmpkSE10UzZjS2U3RHhEN0lad0FKRndr?=
 =?utf-8?B?Z2lNRWdlRmJ3NjdCUHdRb0diN0o4Q2RSUkV1clpEYzhJZTE4NmFJQk5HVU13?=
 =?utf-8?B?Wmk5cnlXSG94UTJPa1ZKc2tDZTREVmo3bWpsYi9kdnIzNFhGU09FdHVlQ3Zy?=
 =?utf-8?B?bGRpc1EvV1Z1KytLNzhHTjV1eEhxTlNmWjJNTFc2RGcwZUdPRm5MQllQMEdS?=
 =?utf-8?B?aTBQc0NZYWdJUmphN0FvbWJFY0ExTDY4NENvMHNxTXZXSHZESmhQRXAxQ3lZ?=
 =?utf-8?B?SHdUMGFtSk5KWWJHbjY0WVNRSXZoRS83UjBHUjBySzllZ3BtT1lxMEdod2JU?=
 =?utf-8?B?U2QrSGx5TDNmait6M1FzbkE2c05PS05Qa1JDVk9LZ2t3Qk4zQmlBRTJpVXJB?=
 =?utf-8?B?QWQxeWhKUHhMa0pOOUdCczROYzRkZ3k5ZlpLSk5UWUtKM08zdVBON0hoYVJp?=
 =?utf-8?B?RTE3alJGU2dsRzNVMXRvMXplUTVjRmxpY3pRbTg4aVVQcWYrdkZrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c917b16-4159-45fa-acbd-08da3e4b8547
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:38:50.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PxUAKMSiDuar1kCm05UHEaJxVCIzfTVf4XeqtwB6flASU6TnQpFjUK1hwTC13kb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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



On 5/25/2022 11:40 AM, Stanley.Yang wrote:
> Changed from V1:
> 	remove unnecessary same row physical address calculation
> 
> Changed from V2:
> 	move record_ce_addr_supported to umc_ecc_info struct
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 ++
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 50 ++++++++++++++++++-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
>   3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 28e603243b67..bf5a95104ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -333,6 +333,11 @@ struct ecc_info_per_ch {
>   
>   struct umc_ecc_info {
>   	struct ecc_info_per_ch ecc[MAX_UMC_CHANNEL_NUM];
> +
> +	/* Determine smu ecctable whether support
> +	 * record correctable error address
> +	 */
> +	int record_ce_addr_supported;
>   };
>   
>   struct amdgpu_ras {
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 606892dbea1c..bf7524f16b66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
>   		*error_count += 1;
>   
>   		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
> +
> +		if (ras->umc_ecc.record_ce_addr_supported)	{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t channel_index =
> +				adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> +
> +			err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;
> +			err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +			/* translate umc channel address to soc pa, 3 parts are included */
> +			soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
> +					ADDR_OF_256B_BLOCK(channel_index) |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they are hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +

UMC address to PA conversion is common regardless of UE/CE error 
addresses. You may want to pack it in a small function.

Regardless,
	Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
> +		}
>   	}
>   }
>   
> @@ -251,7 +269,9 @@ static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
>   
>   static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>   						   uint32_t umc_reg_offset,
> -						   unsigned long *error_count)
> +						   unsigned long *error_count,
> +						   uint32_t ch_inst,
> +						   uint32_t umc_inst)
>   {
>   	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>   	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
> @@ -295,6 +315,31 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>   		*error_count += 1;
>   
>   		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
> +
> +		{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t mc_umc_addrt0;
> +			uint32_t channel_index;
> +
> +			mc_umc_addrt0 =
> +				SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
> +
> +			channel_index =
> +				adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> +
> +			err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
> +			err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +
> +			/* translate umc channel address to soc pa, 3 parts are included */
> +			soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
> +					ADDR_OF_256B_BLOCK(channel_index) |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they are hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
> +		}
>   	}
>   }
>   
> @@ -395,7 +440,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
>   							 ch_inst);
>   		umc_v6_7_query_correctable_error_count(adev,
>   						       umc_reg_offset,
> -						       &(err_data->ce_count));
> +						       &(err_data->ce_count),
> +						       ch_inst, umc_inst);
>   		umc_v6_7_querry_uncorrectable_error_count(adev,
>   							  umc_reg_offset,
>   							  &(err_data->ue_count));
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 9cdfeea58085..c7e0fec614ea 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1883,6 +1883,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>   			ecc_info_per_channel->mca_ceumc_addr =
>   				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
>   		}
> +		eccinfo->record_ce_addr_supported =1;
>   	}
>   
>   	return ret;
> 
