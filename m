Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425ABC41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 09:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73B310E76A;
	Fri, 22 Dec 2023 09:08:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99AB10E765
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 09:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HssACy4oAdlyRanVZ5FUSobqeORAqmcHC3/apP+Shsxnzsy54BfDX+vNZJ4uvYCOdkllTbzelEzmDc8r33SSwZvHWqMHoP28g7IcTbGrDePXrfIuwOEaDZ7PGS/nAXb+wokpP0L9VVn0KeQULv65vJS/atW/DIRRUx2qHpenpwrDFS59K0UUcjYQT8upLWF90IhS2w5uo2T4ovI1cIe8sxCeRQ+x2PNR9Wz6cht8P8cPVA10VOrsFP6h53g/RKhQBsadwqWs6WYzepjsH+cH/Xzgn9q5dLpGxbXTdB9AOXEyMmWIvxBxFA7cv10WSBNdgscS6vkUCFaavv5KbxikEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22fL1lvDoQz1e+MJm8SqLaOOfLajMKSd8fybK+XXo5Y=;
 b=lb/8TaE9QE2GgSexq9CBO3vNMign9amrfeeJJNHyQLBUwvD5hryrjBEnYJG6ppsejzLicl664kYylT1mYAuTe9Zmqnrl98XUR/xJaum5DgTHngIt0FAGtBXtwci7mNapF8b/wvgDtTpUU2GjlBvVq6evI5GNd6jqfElz8k+nQge5pkoY4fmxpG0GsvDlUHOZHbbCZWhiy5LzzcAwQ8fIY5T/gKjbxo+o7pEq+zmPg9xwOLLUN5smJPYYeAb7vdO8YkIZRBKtIrnbgXGoEmj5isRCqSTPA6cKiKpD3Jo89d7jOA/ThYhNoigsiMSAYmrh+yD/EK3hfbPdOznmkFVv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22fL1lvDoQz1e+MJm8SqLaOOfLajMKSd8fybK+XXo5Y=;
 b=2rBlN+aAj4BHb34WvXW97jdShlxnaNvxsKSrr7BkA/wFh5bA/ydzgzV5M785kgJ3Hniv4qgryGbxgcZwpBC+qtGdgpD8gNEK6w9bNZV+8wFYPaGfx0D/p+6Rd8dWdAaqLcfGXe2qJrt+CLxDLwBwf8VHgYR7UBH1DTV5tKaV1AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 09:08:34 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 09:08:34 +0000
Message-ID: <7398805f-bc8a-4004-a8cd-250f7d52d2dc@amd.com>
Date: Fri, 22 Dec 2023 14:38:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
References: <20231221060521.529095-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231221060521.529095-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c7e038-dffc-44ac-1293-08dc02cd92d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfMZGKuF6c08yaIfwb9iVZywkOILXzZITVtu+ekaDsaty2O1k6nfWSbuFVGy1oEBMKRm9l3wuRDVg3OwdZpkhnjcSrl08N2XtbaKMHOK8BggrBBln/oo2lSH/DiZnAZHlWg5FKzvIP+4KLj2clwjlniYiFNcqhryPaobRzjtc27j117SBIAbaIz+JfWxDynfwqHb6Zrnuq2WaTWWS0V8KoEhmfeKvi3UgyKM0hw2kJ1VCMAsk1l8b4NhtQ6kvpzhVds7GuxypiNRVeqcRDOH8+IxnSo0x066/31WGXOHOdKiV4CTIm3X4Srnyk26Wxagdulj+x/5Jn5/4fT4OVnZnBtXbQ3i/JDJhoV0WBPZTUiV5AB2TFiC3xkvDFFEXJ6A7pcmjJxp4+RcEJOgSLc/8P8dZ2gHwhREns4HaAe9EeQFyx2LN4VJnErDKRSlAzXfjShCfjXtX0kIkwXK7sKIQeMIf98I4ctH+fbgKl2Nspkb4wXdpYc3GpkfzQpYwLh8LM2GgLMUyq5SikFOZyWp+lMsx5QCyC8N/VuH5iGAo+l95dv8pWl/FdCnU0VqvDAshiujELAj/dEP0Yzfd9psUZB7gIe3JExCwmNuwm2ktWW+jfKUO9g9ehXY54rUGwHfdKBqv1wj4T7Nrv9W7nYU5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(2616005)(6512007)(6506007)(53546011)(6666004)(478600001)(8676002)(8936002)(66946007)(66556008)(66476007)(316002)(6636002)(36756003)(2906002)(38100700002)(41300700001)(5660300002)(6486002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJZQ1duOEtXRzJxcmc5eXNrWnFuSVhScUEvNmN3RlAzak9GYWt4NXFuQUFF?=
 =?utf-8?B?RVcySnpJcSs3czVJeHlsTGVwZ250WlA1bEpacUozcGkyaGhUMDAwRUVJL2lv?=
 =?utf-8?B?S0hrbTYwenE5UHNBMlU2Y25rUDFzL1U1MTJwTHV4anZHTm0yRERRQnZtRW03?=
 =?utf-8?B?ZTlWV1RBTWhBK3FBZU0ybHNpNjZtSWE3TTQwQ0JXUG9pR0RsYlA3ZHhVcVpi?=
 =?utf-8?B?QXc5SHlxMkVxRVFNV3N6dUw1cmVNLzdWbGsrRmxZeHUyM0dNMUQ3VlMyL0lS?=
 =?utf-8?B?a2Q0OHVMVzVVYVVDZWc3aG52MXRhaVN4OHNtUlpUNUlISmtUYTRCSElGMktp?=
 =?utf-8?B?NmxlRGRvVXlicnUzK2t6bG1FWmdnd1czQ1E4bEdZa2hDL2FnSDZRUmlISzk4?=
 =?utf-8?B?aVZPeHhRdUhKQUNEODlidm5XSlY5YU9maUFJWjYySEU2ZXRFU3hYWHo5YkFR?=
 =?utf-8?B?bWtvMjk0ZzBZanZpSkRVQisyVUw1WGtMTmZwYnptWUJ6dlNCc05pVmFsVTJH?=
 =?utf-8?B?UzYza0ZnRW1KTjRrWVlLUzVlT3M3S0JNVUdlN2YyWmZuOWt4RjMvRDdCM2dK?=
 =?utf-8?B?cE0yZlFsdXJuV0x6Q1ZVdlladmRSdEFDbmRrcmxobHVrc0YySUlST3JGTDRi?=
 =?utf-8?B?ZExWUytWcUlZbXdqdExxbndWZTNPVDRYNTIxSDZ4cnVHVTF3YXdQRTkzRzNO?=
 =?utf-8?B?VnZHUnVmZFVJRFYyWE11R2VGTElhVjJHV0NaY3JXZnJsYW56K2RyU2N5Y1VV?=
 =?utf-8?B?KzNObndReThUdW8wYTFMMzJXaHl0V1ZnNHh5QzFIRzBFQU1kRk5DYlJhV1Vt?=
 =?utf-8?B?WG1uT2RFNVgvOWVtU1IxelVidUF5Mm5TeFd2TnRNc2s3MkxiRDNFdHJYSGJq?=
 =?utf-8?B?anN3UkJncWdoT1ZhMzVrUHFveFFtdUtvU2pGZ0dEQUVQeXd3Nk44NlZ2QzU4?=
 =?utf-8?B?blZhYytEdGtrSHVUTEQ0am1QaFBrZDdmU2w4Q2U5ZnNnaG9ZMDA4MU1iL05G?=
 =?utf-8?B?ZUtTYkY4TFJsbFZGZjV0bGR2UVpLSUZic2ZpZmFUTGU0ZFpKV1VyN09ld2Ri?=
 =?utf-8?B?UTREeERmaGppU0pzQ2Rac1lEeDlZWGp4bWlUSmVIV0tpQXRRaHZuakNzdFlG?=
 =?utf-8?B?K1ZkTHpNZ1VtbXV6aFBOZDRHbXdUOFFsZFdMT2FQaWNaMkV0a0VPaGpIT0M3?=
 =?utf-8?B?WTRjOTVBWVlKd1NWZmFyVFhERzVpMUFOdXE5enJ5aXNvVTRac3NkZTFYZGds?=
 =?utf-8?B?Z2JnVDk5ZkhzUzZIcDdibXlaSFdUV3crVWNmcC84TGxFYmV4TDJxUTNlcGw0?=
 =?utf-8?B?eENkbUFJbjJwUEFzNDNaVzBUa0NQZm0rcTdKQ1liTE1hUXNyano0cTdscVFr?=
 =?utf-8?B?Wk9ndm9ZeVdLM05ZOEpIMzBqT1M3MEpUVllmaU0xN2pVTU9rUlNwS3A3NXFS?=
 =?utf-8?B?MjNITk1DMWVnTTJNanNQd0ZEcVNxRG5lSDE2RGhSS0VjdGlkaS8waVUvTGhk?=
 =?utf-8?B?aEFVV3VIOWlpLysza2tNdU9MRGIyVEM3SGc2U3dKaVJDWUNkQ3FkVkxYanl6?=
 =?utf-8?B?RmQ4NzR3VU00TWlEQUdKTzhXMFltN2d1UDJXYVh0dit0M04zbTlmblVaOWxQ?=
 =?utf-8?B?cnh0VitockJ1cGZIc1ducEpydzhFQ25GSjBiNjhoZ0xUN2h3bjRPNGpCWEJr?=
 =?utf-8?B?ZVlOWDF3cmpjaVo4cCtyb1JaRzdRSjZTZTZuREZtcXZvbEdFYzlOK3YwcFF5?=
 =?utf-8?B?MjhhRng0c3BpV0VvYmNLdk1WclJ5UGRkU1g2OUhzTVlUSU41OHFTVS9yMVFo?=
 =?utf-8?B?N2FscFF4aUwweEsvdm90VW5UdDJXMmZ4cC9sV3ZLRTJTOEgxM3doTU5MT09L?=
 =?utf-8?B?MDc0TkRwWWE0ZS9FQ1Y1ZkM4ZzFnek94RkI3Snl3TnhwSWlQNHBtK2lVMmVB?=
 =?utf-8?B?TGVPWWlQdUt0bEY4K2cxRlljaGkybEZVc24xZDNLRmsrSXVJNVZ4UC9ZTzJo?=
 =?utf-8?B?WkNydlhhVGNtd2JHcWplc0lVaVZ3RTdkKzY3ZUx3TVZyZnZUTjFJT3FydEps?=
 =?utf-8?B?a1NUK29xandCcTBENlpoL3VTdGNtazJjanc1UEswdENBcy9nQStsYVc5QnFs?=
 =?utf-8?Q?HWqAH3SXkPw7DxnqKtnrfGb5Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c7e038-dffc-44ac-1293-08dc02cd92d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 09:08:33.8313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp7KwHBslEHsXMOyEvBRxonKAEFpiu+qXopsFVlq1Udy0+nTA915SQisgq0gGab8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/21/2023 11:35 AM, Stanley.Yang wrote:
> The ecc_irq is disabled while GPU mode2 reset suspending process,
> but not be enabled during GPU mode2 reset resume process.
> 
> Changed from V1:
> 	only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip
> 	delete amdgpu_ras_late_resume function
> 
> Changed from V2:
> 	check umc ras supported before put ecc_irq
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28 +++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++
>   4 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 02f4c6f9d4f6..b60a3c1bd0f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -330,6 +330,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
>   {
>   	struct list_head *reset_device_list = reset_context->reset_device_list;
>   	struct amdgpu_device *tmp_adev = NULL;
> +	struct amdgpu_ras *con;
>   	int r;
>   
>   	if (reset_device_list == NULL)
> @@ -355,7 +356,32 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
>   		 */
>   		amdgpu_register_gpu_instance(tmp_adev);
>   
> -		/* Resume RAS */
> +		/* Resume RAS, ecc_irq */
> +		con = amdgpu_ras_get_context(tmp_adev);
> +		if (!amdgpu_sriov_vf(tmp_adev) && con) {
> +			if (tmp_adev->sdma.ras &&
> +				amdgpu_ras_is_supported(tmp_adev, AMDGPU_RAS_BLOCK__SDMA) &&
> +				tmp_adev->sdma.ras->ras_block.ras_late_init) {
> +				r = tmp_adev->sdma.ras->ras_block.ras_late_init(tmp_adev,
> +						&tmp_adev->sdma.ras->ras_block.ras_comm);
> +				if (r) {
> +					dev_err(tmp_adev->dev, "SDMA failed to execute ras_late_init! ret:%d\n", r);
> +					goto end;
> +				}
> +			}
> +
> +			if (tmp_adev->gfx.ras &&
> +				amdgpu_ras_is_supported(tmp_adev, AMDGPU_RAS_BLOCK__GFX) &&
> +				tmp_adev->gfx.ras->ras_block.ras_late_init) {
> +				r = tmp_adev->gfx.ras->ras_block.ras_late_init(tmp_adev,
> +						&tmp_adev->gfx.ras->ras_block.ras_comm);
> +				if (r) {
> +					dev_err(tmp_adev->dev, "GFX failed to execute ras_late_init! ret:%d\n", r);
> +					goto end;
> +				}
> +			}
> +		}

This is the not the only ASIC that supports mode-2 reset.

What is preferred here is a RAS API which doesn't do all these kind of 
ras variable checks to initialize selective ras blocks.

amdgpu_ras_late_init(ras_block_id) or similar. Whatever checks done 
above may be wrapped inside the API. For now, GFX and SDMA are the only 
blocks that need to be inited, but an API gives more flexibility to 
selectively init blocks that are reset.

Thanks,
Lijo

> +
>   		amdgpu_ras_resume(tmp_adev);
>   
>   		/* Update PSP FW topology after reset */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 09cbca596bb5..4048539205cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1043,6 +1043,10 @@ static int gmc_v10_0_hw_fini(void *handle)
>   
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   
> +	if (adev->gmc.ecc_irq.funcs &&
> +		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 416f3e4f0438..e1ca5a599971 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -941,6 +941,11 @@ static int gmc_v11_0_hw_fini(void *handle)
>   	}
>   
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +
> +	if (adev->gmc.ecc_irq.funcs &&
> +		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>   	gmc_v11_0_gart_disable(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 205db28a9803..f00e5c8c79b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2388,6 +2388,10 @@ static int gmc_v9_0_hw_fini(void *handle)
>   
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   
> +	if (adev->gmc.ecc_irq.funcs &&
> +		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>   	return 0;
>   }
>   
-- 
Regards,
Lijo

