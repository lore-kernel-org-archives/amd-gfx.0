Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE52BC25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 08:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB6C10E773;
	Thu, 26 Oct 2023 08:16:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B6010E773
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 08:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8Lwny7HymIj59INQWyQOfYq9QbL6vUDZwIy5E3o1JRnW82zhHrAwpqhLsHVwYYuREwTpo56uCcclkb1PMDp+d6AhGK9dKVjV/bVAwDP56+10hoLjgzv8JdYSOoE5YoaP9pvP17EA/PNRzfBufheidZ1ObjnAyjjvAsexRUfEuDBLYOedVKCPwegKMTwxXKfrV0Mc2oB91aJ1s1K9lOVCXZuAPcFxFUsPhzYmIORVxd1UY+YP42tH8wvQGKR6sfyeHORo9GAA8QUFxx0GyvOnVNlU0kMu0u5oFkCo67mMjcJ1PSsZPbI6ItFwJYw9Wj5yyL72eW5/QFeDRzUjF3cJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6Q4OJalJPHh5y+iE1Nwk4ZQr8Md+A968NelT6rxcdQ=;
 b=LYVHC33Lsmu9hisb6rqFO+8dt7f4NJbl06uc/naDNUnRSb1QlzkmDVQ/OT5tAxF7VNy20ZKJl7b2pNe5mEH6jH4mLMCjnqdLBuCL8IN0VuPuChZcvtH7BON4UaBv3CHqNR9K2cUpn3Wpnk5FnQzH+Z6+AMSpi7NpkTcKfJc3qLRbmy0xfgC6s2Ls2GRi5Dn2GoqsBlrf8o3AU+BdXtRCio5AdFddAiNLgT11TF/B0JH5w5eHQnAVT1VcsLmVIfFOtCiOWtcyixkst25hzinx71dPNQVYODfp8xhb9Es0EpzaNfXQfLcpd3s3/M9PaEZd2nI6TP5TPbIW+uf5kiX8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6Q4OJalJPHh5y+iE1Nwk4ZQr8Md+A968NelT6rxcdQ=;
 b=UwIuTs/t5y4ba6U31GlwoNWdimRZz3dk3vXmrpNz9F76PDr1pIOcGxvb7Vun5YjOUzkbDcOaD3CICf+wN+iYg6K8ZM2m6+P5e+9pyNSFxr3hLIM0wez6njp1gPIFElfi3h6dskzKYWaxvHC+6OGwqtahGQo5Zo4JJjzO2yaw84Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 08:16:54 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::737e:9615:922a:d3d4]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::737e:9615:922a:d3d4%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 08:16:54 +0000
Message-ID: <66077329-08cb-8857-584c-1b14bbe23a11@amd.com>
Date: Thu, 26 Oct 2023 13:46:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3
 (v3)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
 <20231025205242.40490-3-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231025205242.40490-3-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e5b302-4d8e-432e-7a5c-08dbd5fbe9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saC7hDc1n8DPzkDov6BfImbHan2/ETJItHZk4CyvL0Z17GUSA1J+wQYHS8gkmntdCpyMIkrYfw6LbOTqJoKNSwtxewlC+H/lVAMHpw5XTb8/SvlpmgadLgraeuD0grvK6Npr6fTwl+JTX/pMe0dEx7eVfeVk2nGjo1ujVXRmrWRzDKj2tCNXOWeUmGWzDmGDrxN6xFArZUNpbp2XqB0j6ecChvf3fMpe+Lonq/jkmCPQSeHZXb8+4O/MdsM44eVf1azgU67kAll4rje94X4PzAcKm1eKg4MB7lyw6JTE8xHj2lLT/qQ/olTHR85yY95rPwkvDLi6euVY9jpMtUlrcB91D3+iKiqGcuZ7FqF4oqow/Qoj3sNa3CTaHyuHcsKLC6JIlXgM5Txgbxqav6IXDpgXrZY5ToMwcN4PDxMyk6Dq7CQub8hggJJXnMOtlF6qinox/oSZGQvop8kyZ78v47DJtuqxLKTPEcgtYb0VCsMaRh/DohsG3JOtA5mDMWAzFqTUemh/ba6dfMmqhDTcfv3u6CawjwBlw+J8hdcrzJmjZrz694uIBgbFUPtMWJRzYujp0a0p2KIihM1EWVsIz2/fLE5CGfW2UoUEJ/r4+1UmvCW37HElY9VVHBOsnsroGN8ztaY9ZA2PMuBKRScUFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(31686004)(53546011)(6506007)(6666004)(36756003)(478600001)(316002)(26005)(66946007)(66476007)(66556008)(38100700002)(6486002)(83380400001)(2616005)(6512007)(2906002)(4326008)(5660300002)(31696002)(41300700001)(30864003)(86362001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdVOUF4a0hNWUs5eHlBcWU2emZMQjg5M3pieEYxRTVpZXJyckpaMkY0bHFX?=
 =?utf-8?B?bVIrMVlnOUpGaklqUmxrV0paQmRyMDRYZXVMSFQyMDdBZmlDWEUzMkVsOXRa?=
 =?utf-8?B?dWpCRmc4V1VmeWpQQUpWdERtOTRIWkRHRXEzTTY4N0k4RzBMZy9peWh4QmpO?=
 =?utf-8?B?SXVXVkkzd3RML3ZpOWhCN1JPd0Rlbjc0ellQaDF3MkpVWFlkdEptV1MvcENS?=
 =?utf-8?B?UXEzSHhTZlpnRVN2cXJjK1M3WC91aHFtK1drTUhjODMxMjFBRzMyR2puKzY0?=
 =?utf-8?B?ZnRMK2hDWTBCY2ZHYnNsaS9BMFl1VDg5WFBvc3hKYlR4U1RpekdLTmI0ZmVY?=
 =?utf-8?B?UDVwVEdNUks4VlNuOG5aK203Tno1M3RqemJ4bTEvMHF5LzVzdkwwZTRlcDZu?=
 =?utf-8?B?ZWtWVUk1UmpRM200SUV2blpJQytWUGN0d1JITFNyRDUvdzhUOG5KRmtURkRy?=
 =?utf-8?B?TFJINVJTU0JRWGtUVTZLUnRoUTlzOGF5aUo3aEVncTl2TG80SlhObHlsU1Zj?=
 =?utf-8?B?YzdIUU5BVGROc3pZQyt4OXFXK21leFVpODNhYmVzaXhlNTlOVE1pTUo5Z0pu?=
 =?utf-8?B?NVZVaFdCNWw0R1RQZ2N0NjJSeGJNL3ZQV0tEenFVa1JiY3RTZEpOcSttYkV1?=
 =?utf-8?B?dThVM2pSV3NJdG1BZno4MnFRRDBYV2xxUzc0SXhlVFI3MkYzMTE0K25la3VO?=
 =?utf-8?B?c0R4KzVaekI1d3VPNHhOTlFQdjFiWDFmL1ZDc0YrVUtLUTdybk5BUGpGZmNy?=
 =?utf-8?B?N3QyeC8raTRlY3BIbTRHT2JHbDRGWWVLdWNUZUxvbzBLSGhxa2d2VUNseHdt?=
 =?utf-8?B?czNyRjJUUURRUXZZeDVJMlYrWktXS3RJY21OZ3ZjSGpqUHBmU3JoZDNMdEY2?=
 =?utf-8?B?a0JOWUFKRnpXQ0c1Ly9RUVI3ZHNxUXNySS8yUkE0UlJLcGhRVjdRNno3RHBC?=
 =?utf-8?B?c3hzRXhBc3RteVVFMmdpWmtWTnR6MHJCL1YraEVEK3BWNkMxZm5ucHRDL3h2?=
 =?utf-8?B?eHJYRGh6TWNxbGw2UEQ2WERKT0NTWE42TjdWMlBkLzVMRWdCeGxKRkx3T0J4?=
 =?utf-8?B?QVFDSVAzTjlMQW5BQXl1ZVpVUHNpOTJnNUxEUy9SdE9jcUUxN21HYU8zU204?=
 =?utf-8?B?eUxhd1BNS0NxcjVPWXRzVnVrdFlpaERhcWtYYkNsTXJZNW9ZTlpsN1hRcXo5?=
 =?utf-8?B?RE12WGw1S2pYNmJpVDkrWE9JNm9NaGJhajhKemR2a251RGhKM0JhdUN1SERO?=
 =?utf-8?B?cEpCUHh4d0NpVUNPNTRYTXNGRXY1dkZOMWJ2dXRhSVRCUG9aNHFXZnJ5cXNT?=
 =?utf-8?B?djNlVTh2aE1zNERpS3ZnNUxSTHJHZGx1dHpEVys2VHNIYUdQYktuWkVjZFly?=
 =?utf-8?B?SnppR1NwSUhwb295eFlIa2V1RWlsVzZ6NHQvY2IwL3JMMzRTMHhUZmsyL1JB?=
 =?utf-8?B?RWxoRzh5Z0pacWN3WXV1NXlWL3dpMjUrYzd6V29KeWp4a0tlZ29wa2hSWExC?=
 =?utf-8?B?YVA5MlkzN25TUUdOdk90aDE0VXpvOUUxSlpzNEJacnV4VmJhMUlyU0RNWE01?=
 =?utf-8?B?SFdEZEsxTXpBdFd6T0wxL3ZuMFYvUzN2MlRPY2pOa3RuUFp6V250SUJnbGRn?=
 =?utf-8?B?YXorMlFaNEl0eGZSOE1oa3FYdm1oZWJWTFVBeWZLMnJQd2RURnQ3dTNYdmdr?=
 =?utf-8?B?cU9vR2hSUG1OeUhoNG0xV0hCNnRpcHBkeGlvNzh6QnBLcHRHS1NHb2g3dDM1?=
 =?utf-8?B?YjRNWXNqS2o4QmxDSlRpWG5oWGRVdGJlcFpSdmU5YnhuL2IwMEt5VHhkaUwx?=
 =?utf-8?B?MmMwT0pqeWU5T0l5eUFLeEIvTVZZckJsNTdaRjk1U1ZMWjdqVlZFVTZ6WHQ4?=
 =?utf-8?B?eHNpMzZ2V016UnNDc0pBQ1cvUktFVXB1MzZLdmpCdXJiQnJYZG1xZ3E3TUhJ?=
 =?utf-8?B?cTBsci9waVg1STF1TVd2MW8xbjNLQ3drdmtBNStPb1VnU29kZ0JUdUc4RkVi?=
 =?utf-8?B?TmptUFFYRnNtemVVUDFpcjROakdjbnBvdkt1NVhzNmZaa1A3bndBY0E1eG5v?=
 =?utf-8?B?OGhhUEtlQ25wOThuYi9sdFlKaGZvdjl1aGM1QjdSZ29lOVhMTWlIakZuaXFF?=
 =?utf-8?Q?mAI8vqP629yChGijFnZ2kdQkL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e5b302-4d8e-432e-7a5c-08dbd5fbe9af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:16:54.1015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HoKOJuC4wkPan5CzWw3jZa14c1VInuuZJ2HjEnlUtiegLqJaRASBfJxh/H6NluL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/26/2023 2:22 AM, Victor Lu wrote:
> amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.
> 
> Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC
> and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.
> 
> v3: use W/RREG32_XCC to handle non-kiq case
> 
> v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
>      of amdgpu_device_wreg/rreg
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 ++-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 84 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
>   8 files changed, 107 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a2e8c2b60857..09989ebb5da3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1168,11 +1168,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   			    uint32_t reg, uint32_t acc_flags);
>   u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
>   				    u64 reg_addr);
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +				uint32_t reg, uint32_t acc_flags,
> +				uint32_t xcc_id);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
>   			uint32_t reg, uint32_t v,
>   			uint32_t acc_flags);
>   void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
>   				     u64 reg_addr, u32 reg_data);
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +			    uint32_t reg, uint32_t v,
> +			    uint32_t acc_flags,
> +			    uint32_t xcc_id);
>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   			     uint32_t reg, uint32_t v, uint32_t xcc_id);
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
> @@ -1213,8 +1220,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
>   #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
>   
> -#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
> -#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
> +#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
> +#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)
>   
>   #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>   #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
> @@ -1224,6 +1231,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
>   #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
>   #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
> +#define RREG32_XCC(reg, flag, inst) amdgpu_device_xcc_rreg(adev, (reg), flag, inst)
> +#define WREG32_XCC(reg, v, flag, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), flag, inst)
>   #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
>   #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
>   #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 490c8f5ddb60..c94df54e2657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
>   	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
>   
>   	for (reg = hqd_base; reg <= hqd_end; reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..47c8c334c779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
>   
>   	for (reg = hqd_base;
>   	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ec32b44df05..9a35088b990a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -471,7 +471,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>   		    amdgpu_sriov_runtime(adev) &&
>   		    down_read_trylock(&adev->reset_domain->sem)) {
> -			ret = amdgpu_kiq_rreg(adev, reg);
> +			ret = amdgpu_kiq_rreg(adev, reg, 0);
>   			up_read(&adev->reset_domain->sem);
>   		} else {
>   			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -508,6 +508,48 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>   	BUG();
>   }
>   
> +
> +/**
> + * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register
> + *
> + * @adev: amdgpu_device pointer
> + * @reg: dword aligned register offset
> + * @acc_flags: access flags which require special behavior
> + * @xcc_id: xcc accelerated compute core id
> + *
> + * Returns the 32 bit value from the offset specified.
> + */
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +				uint32_t reg, uint32_t acc_flags,
> +				uint32_t xcc_id)
> +{
> +	uint32_t ret;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if ((acc_flags & AMDGPU_REGS_RLC) &&
> +		    (!amdgpu_sriov_runtime(adev)) &&
> +		    adev->gfx.rlc.rlcg_reg_access_supported) {
> +			amdgpu_sriov_rreg(adev, reg, acc_flags, GC_HWIP, xcc_id);
> +		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_domain->sem)) {
> +			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
> +			up_read(&adev->reset_domain->sem);
> +		} else {
> +			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> +		}
> +	} else {
> +		ret = adev->pcie_rreg(adev, reg * 4);
> +	}
> +
> +	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
> +
> +	return ret;
> +}
> +
>   /*
>    * MMIO register write with bytes helper functions
>    * @offset:bytes offset from MMIO start
> @@ -555,7 +597,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>   		    amdgpu_sriov_runtime(adev) &&
>   		    down_read_trylock(&adev->reset_domain->sem)) {
> -			amdgpu_kiq_wreg(adev, reg, v);
> +			amdgpu_kiq_wreg(adev, reg, v, 0);
>   			up_read(&adev->reset_domain->sem);
>   		} else {
>   			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -596,6 +638,44 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * amdgpu_device_wreg - write to a memory mapped IO or indirect register with specific XCC
> + *
> + * @adev: amdgpu_device pointer
> + * @reg: dword aligned register offset
> + * @v: 32 bit value to write to the register
> + * @acc_flags: access flags which require special behavior
> + * @xcc_id: xcc accelerated compute core id
> + *
> + * Writes the value specified to the offset specified.
> + */
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +			uint32_t reg, uint32_t v,
> +			uint32_t acc_flags, uint32_t xcc_id)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if ((acc_flags & AMDGPU_REGS_RLC) &&
> +		    (!amdgpu_sriov_runtime(adev)) &&
> +		    adev->gfx.rlc.rlcg_reg_access_supported) {
> +			amdgpu_sriov_wreg(adev, reg, v, acc_flags, GC_HWIP, xcc_id);


I see this path

WREG32_XCC -> amdgpu_device_xcc_wreg -> amdgpu_sriov_wreg -> WREG32_XCC

Similar for rreg. I'm not able to work out the RLC/sriov runtime 
conditions. Is this tested before submitting?

Thanks,
Lijo
> +		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_domain->sem)) {
> +			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
> +			up_read(&adev->reset_domain->sem);
> +		} else {
> +			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> +		}
> +	} else {
> +		adev->pcie_wreg(adev, reg * 4, v);
> +	}
> +
> +	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
> +}
> +
>   /**
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c92e0aba69e1..60ae4bfdc7f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>   		func(adev, ras_error_status, i);
>   }
>   
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id)
>   {
>   	signed long r, cnt = 0;
>   	unsigned long flags;
>   	uint32_t seq, reg_val_offs = 0, value = 0;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	if (amdgpu_device_skip_hw_access(adev))
> @@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	return ~0;
>   }
>   
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id)
>   {
>   	signed long r, cnt = 0;
>   	unsigned long flags;
>   	uint32_t seq;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	BUG_ON(!ring->funcs->emit_wreg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 7088c5015675..f23bafec71c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>   int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_irq_src *source,
>   				  struct amdgpu_iv_entry *entry);
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a0aa624f5a92..c6c8f4fed0c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1076,7 +1076,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>   	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>   		WREG32_NO_KIQ(offset, value);
>   	else
> -		WREG32(offset, value);
> +		WREG32_XCC(offset, value, acc_flags, xcc_id);
>   }
>   
>   u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
> @@ -1091,5 +1091,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>   	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>   		return RREG32_NO_KIQ(offset);
>   	else
> -		return RREG32(offset);
> +		return RREG32_XCC(offset, acc_flags, xcc_id);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 386804f2e95c..b24db7974311 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2739,16 +2739,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
>   
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
> -		mec_int_cntl = RREG32(mec_int_cntl_reg);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);
>   		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>   					     TIME_STAMP_INT_ENABLE, 0);
> -		WREG32(mec_int_cntl_reg, mec_int_cntl);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);
>   		break;
>   	case AMDGPU_IRQ_STATE_ENABLE:
> -		mec_int_cntl = RREG32(mec_int_cntl_reg);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);
>   		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>   					     TIME_STAMP_INT_ENABLE, 1);
> -		WREG32(mec_int_cntl_reg, mec_int_cntl);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);
>   		break;
>   	default:
>   		break;
