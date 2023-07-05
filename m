Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A107EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 16:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94CA10E392;
	Wed,  5 Jul 2023 16:05:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CCD10E392
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 16:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyhdY2YRkibWgh89qdU3rjFD/6YAqh6bJ5uXUj+QvFToBUIURG1QIvkwmGs1PkLZVvpNcBx2b20GMEiYxSKUUee+h9tG5E4BzOyS2BuEsVXZld5YNJ594YHzN91eHBwuAOXMBKMJwWOV2ThekpzvLicxpN+dx+JhmgETCm7DoIDIKQGUciBIlyH1yumKvVWtgAeLvkDRMyeUfM0WmZ6LznA6LjtETMGgAvZwyeL/7bgbCwk0rrw+h0Xcz7QAamRn3cOBw9KPV4GiXzrxPpsZAN2sKlmNbGNqljghtjy9Xf/BVQeQZb2SW2WwPl9n8qGGI2Eb1m6WDMzREDdbqzOEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6ovsYC8qQNodXrKjLYNURiCgmCd/LNSkvUOc6MPczs=;
 b=bUWOmyyu72dNO2CX3Mq25dTjNIHVmF0wcVg7c43qkk9XhFMGb2RsuOyUOJWTbj9ywu5pXkOz3F7Jqyaz1cORrwiwcvcUQaEAVaFjVTVkxdmhNeeZJwnE9OcPrrYoE/vRsi5ZyA4psev+4AzT9zqSLHQZGxea4dd0rdC2y0WuAVyRVv5Zr1q6Pr3rADwVVLyscW/26eZVpxFer1Al1Twj0yWYDIcWTP5A7Wcn5HSG9+3DMhEl18A+X3G4TNpv+YuZjGaKWGvPi7qqI95J0gUbdG+k6XrIbKBhJEmaiWjityPwahaz3iUlJXRNuIW/+ObrNOldev83w3bCpKNCZ2CVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6ovsYC8qQNodXrKjLYNURiCgmCd/LNSkvUOc6MPczs=;
 b=44VhFS9crAby9Bl2rPFodGtG3xNA07UHZX0ful9047NWKeHsEBFJXcRX4OdkxPlQfum+rzkAocF+9X8NL21srSe2Ls59faGGNjr2QkhB+lbIGewQFmD+NTsiIttXkcgALMifYm97aV9MyKfBeb+/BkgLVuiHJTT/l0ad1qp7NpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 16:05:53 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::e535:b815:b26d:ee9f]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::e535:b815:b26d:ee9f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 16:05:53 +0000
Message-ID: <f1ae17a6-ca15-c53a-1174-b3184f731c44@amd.com>
Date: Wed, 5 Jul 2023 21:35:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] drm/amdgpu: extract a PSP function to execute IP FW
 loading commands
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
Content-Language: en-US
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <veerabadhran.gopalakrishnan@amd.com>
Organization: AMD
In-Reply-To: <20230627044833.3668402-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2693:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad0bbad-1fd1-42df-df75-08db7d71b54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXdiJvqLxZzZiSlRImz+PEhUQkN6s3nKvLSj/4M2fzvHkkJozlo75n1NYH72Su5KLzsc+wgWZo5rE84LsN5p1yi68mUv7i3aZCCWYsnhEd1lZEnHzXS38dPyM1GaDWh/SaIEUQT8QDFUcuTcSbf9FKRu/8DMk82/Dku3eMh2NemgdeWz+ueuNW0tQiz+lQrKLUQfOaqIhcDO0382RGSwK0YV03bM6P9Xm5PZnoO5fe7oEWKtGC2xMwYr3YKSE1lSCMx90UmB/D40yl3RxWO7Q5WVxAnYQUa+6oeMDnfbNV60eX73SSn42xkO8s4hL5qv9R1+nhO+3KgwQzjv3DZMqpaZj3zMreqaDibcNVPJLCQM4qxdnNSOdZz1bDEORahRv5wSFfGUf/jEIllMKfTotyE/ffmQxA5PxFe8dz15cXDZsFynOZZFK2Drx7gwQ39PsxnGCEAEPFebAX1haanA/s+mFGtPDKBHI5cxiS+tcE8EQLOTkYvxbe+gGM58eb5S1lAvfEO2Y+U0Gilbfa/N894z8soKgKxIWwlf8Jdsl/MPG5DQ11NzJxK1JUjCEWwjhDXEszMbyF7ryeXC/ezG+daekKie60UbXfscEoYFC6smZABChrV9SjUT8ber122zrlCSu8Cdkty7i5YVypyC4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(8676002)(8936002)(66556008)(53546011)(5660300002)(31696002)(86362001)(2616005)(83380400001)(41300700001)(66946007)(36756003)(66476007)(316002)(6512007)(186003)(6486002)(6506007)(6666004)(26005)(478600001)(36916002)(38100700002)(2906002)(3450700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tCSUZKcjZJWEdULzNhNU1weFpiRWEyaXhyc0pKQVUxdExQc2RlYTBEVzlJ?=
 =?utf-8?B?ME1TcWpOUDJBUDAyY1o2ZkUxN0tYRVlVemFsS0ZMakloVFdsbjVhSGMyaUlB?=
 =?utf-8?B?VVdPQTdYS25yMi83SVhVS2RROC9sdHVDQTk4SUZZNHp2Z3lVbGx5Znp3dWpk?=
 =?utf-8?B?UlU5SFBQeVVkdzZ6VzYrZTF4azZDSDBTT0pNMTBzcFhXczV1bVZHR2Q2aFVW?=
 =?utf-8?B?Znc2V1IzdURYUDZpK3dsY0wxZXVJRG92N3lLUXI5TnpJaGcvTzFaVy9SODYz?=
 =?utf-8?B?OGt6d0NjN2FRdlJ2cWRHdWViUmtycXJNczkzcitCMG9mRnAxcWFmNHZOVW9m?=
 =?utf-8?B?d3lLZFlRZHpPYnV3eDZNaGU3YmtaUCszVmNkaGFRNnNqbGw2SGpyQ1N3Ri9K?=
 =?utf-8?B?UnpoM3BaS3hYTEh0clhTaGVqaDlsVUhkQkJodE50ZE1sZzBKSkJyY1BIMFVW?=
 =?utf-8?B?MFhjRDAzYXhhcEJ6SWFyODkwVFdwMU1RZjVTMTdPUkJ2N0xpZVFESWFJcENz?=
 =?utf-8?B?VE9ScmZRMmM2dngwRVppNGEvdytiOVh3V2MrL0JFYXE2RURqUmNGTGxtOVIr?=
 =?utf-8?B?ZTBYd3ZiT1pUQU5aNS91TjhCNHZRRGdqYlhVZzk2QlNDT0Jpdm55OEtIZkVQ?=
 =?utf-8?B?blZFZERxRXpRcDVTckMza0Nhc0JXVVkyYksvMmFWVHp2ZGI3Y2JHRkVPM253?=
 =?utf-8?B?azQxVUJxaml5cWFqNllUKzdUYlZTeXBYYzNLOXUwUFExa0wzWDVzSFlOd2tG?=
 =?utf-8?B?dUtnK25McGdESGVoNzNhcmRVRllJYWZ1Mmc0NFZSNHdGcUZqRGFiSFByTXFZ?=
 =?utf-8?B?bm5mbmZtalo3QkwzVXBoOUJPZXErSHhjdXlubHNPUmVQWEVqNDUyRGFMU2ZV?=
 =?utf-8?B?cnRTemc0VkJ2UzlmcXY0K0Fyem9peXdyZzJEdUpjcFpsOWxHR2VCVGYyYlo5?=
 =?utf-8?B?K1gwVllkd3ZlQ3U1Ukptb1JjYTkvK05vTXNzaVlBZHNZbFJsb2VJTGMva1lD?=
 =?utf-8?B?UWczRUpKRjRYRkNjWU05bWRveXJtRkJUS1UrVDhEYWtsZ1dwb09zVmVCMW1U?=
 =?utf-8?B?aG9LMVE2aDlvRGxsUVZFUmFQRy9VK0Vaa25RTW1JdkN4dWovcFUrQ1JrRGNS?=
 =?utf-8?B?NW0zUUxzQ1lscjhtWXkzTUd5MDBsUERJMW5pVUY1b1BkUVIxWXc2MlZGTzJZ?=
 =?utf-8?B?V1BvNEEzajNhSXdrOUxKSnJnVTBlN3EvRHBuS25qT3FSUmxkQnV2bzY1THNq?=
 =?utf-8?B?RytlUHZLdUREOGpraUxNTGU3YmZOUkloQ0x1MllJVjNLL2NGYXlEY3VkdEU1?=
 =?utf-8?B?R1RUUGpHb0VMMXl3Q0NmUS9rVzVhT2tGWjhwNHMyYTArZG5Sa0RUNFk3TlB4?=
 =?utf-8?B?NWErdml5WXM4UGtCZGVsZDA3Y3ZTWEdYUGFNdTgwUEtIOU9SRXFDYlQyWWVn?=
 =?utf-8?B?STRvbDVxVVdOMTFNVHlodVF5S0dQVW53RnFzdDlpb3dJVGxGTG01UWpWRXla?=
 =?utf-8?B?cVRVV2VkQjNjbytRa3ExZHZMMEdQWlN0ZGxLZUNIdnlLdTR5UWhqY0RZcXNF?=
 =?utf-8?B?ZjU1dG1MYWs0Mng2K0l6SC8yN0lLenJlbkt6MUdnRkxZY3VNUTBNZXV0NHRh?=
 =?utf-8?B?RjV3UHU3V3pacDV5LzYxOFAyZXR2MXMyU016T3dETC9paXBOeUluTEVFaTE3?=
 =?utf-8?B?NFR5bk0xeW5DckNXRmZXZWhHMG83Wkl6a0tRdjJ1TDBQTytOODNiYkdIeDZz?=
 =?utf-8?B?dlp2em1wNGM1dTNRdkRiK0lta0MzQzAyYjl4NUYyVGkwcmRvdjIyWE9ZeHdJ?=
 =?utf-8?B?dEh3VDJXMXVrTWIxV0c2b3BQc2Q1cWRBQitLREl0RVlVUUN6V3IxRXhoWDhY?=
 =?utf-8?B?NGcrTnFieVYrQjhPbnRMQUNHb0lMUTJuMXpqclpzb1I0dkZodGsyeXNORStV?=
 =?utf-8?B?VWZ4Q0VuZzZ2Nkd1MHJUUXg3L3NVTHY2ckhuajYwWGNOM3ZXbUlTT3VkN2VP?=
 =?utf-8?B?c2FtQjh3eitvUGN0WURpM2I1WXFRUm5QekJvKzA4aGhtbkhlSTN1dTZUcGFI?=
 =?utf-8?B?Tytwc2cvOGFXeEJCdisxaGttamxYbk5HV1lYcVREaWlDL2Z5N2g1MmJYZkEv?=
 =?utf-8?Q?8/ugsEI5xCooAy7DhMInWVkQQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad0bbad-1fd1-42df-df75-08db7d71b54e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 16:05:53.4016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNF9zQ5YtvGYrYzrwTfN4cbL5OOCtDBkZMKI3gYb2o069qA5ZE/AGiqXkw7M1jFmA3fX/mRiH0Gp9LJ94uuzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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
Reply-To: veerabadhran.gopalakrishnan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good to me.

The patch set is Reviewed-by: Veerabadhran Gopalakrishnan 
<Veerabadhran.Gopalakrishnan@amd.com>


Regards,

Veera


On 6/27/2023 10:18 AM, Lang Yu wrote:
> This function is more general and easy to use by more clients.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 29 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 +++++
>   2 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a33c155dddcf..a1cb541f315f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2445,6 +2445,35 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
>   	return ret;
>   }
>   
> +int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
> +				   struct amdgpu_firmware_info *ucode,
> +				   uint32_t ucode_id,
> +				   uint64_t cmd_buf_gpu_addr,
> +				   int cmd_buf_size)
> +{
> +	struct amdgpu_firmware_info fw_info = {
> +		.ucode_id = ucode_id,
> +		.mc_addr = cmd_buf_gpu_addr,
> +		.ucode_size = cmd_buf_size,
> +	};
> +	struct psp_context *psp = &adev->psp;
> +	struct psp_gfx_cmd_resp *cmd =
> +		acquire_psp_cmd_buf(psp);
> +	int ret;
> +
> +	if (!ucode)
> +		ucode = &fw_info;
> +
> +	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
> +	if (!ret)
> +		ret = psp_cmd_submit_buf(psp, ucode, cmd,
> +					 psp->fence_buf_mc_addr);
> +
> +	release_psp_cmd_buf(psp);
> +
> +	return ret;
> +}
> +
>   static int psp_execute_non_psp_fw_load(struct psp_context *psp,
>   				  struct amdgpu_firmware_info *ucode)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 4847aacdf9dc..bd324fed6237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -462,6 +462,12 @@ int psp_gpu_reset(struct amdgpu_device *adev);
>   int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>   			uint64_t cmd_gpu_addr, int cmd_size);
>   
> +int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
> +				   struct amdgpu_firmware_info *ucode,
> +				   uint32_t ucode_id,
> +				   uint64_t cmd_buf_gpu_addr,
> +				   int cmd_buf_size);
> +
>   int psp_ta_init_shared_buf(struct psp_context *psp,
>   				  struct ta_mem_context *mem_ctx);
>   void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx);
