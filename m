Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4118CC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 12:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E8811B2CE;
	Mon,  6 Jun 2022 12:58:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1318511B2CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 12:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0VF0ZzWj++jG2ara9LYa0eYVLom6u5n3HsZLg8232NpprOR8/qy4uk1KFB0B1QSiN4ZikIuYSLA0/54H4omRypGCgt4+ZzjhMKl7r9aZG3mWEBjCkVsiHNTQyqgZpgoGHQk7QI8TG1chOyl1bg7Wncu+UR4lG3MvpqTdXZXWiay81+nN6/aqqn0cxE8eiEot3X7jujKJP4gsUQHnRo2GwpifyCZoGRzBSn2FRJrWvV/QFCD84ee2sEl1VPQYqZBO4JSbXzF0jWiS4OKpcdIhF0+nh9F79cv6r8zapBQIN5aJh6AE27oJ64Dq2rJa4GlO09+abjDmvVVz+3n6iCEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHO6q2I3IkRyKmCuW7o6p/0UIyRvZ8sEHvIb9J0dOec=;
 b=EOoCrS2gGJg+qRB75RHqEULQZaR1Oomv4j/Lx/4MphmB2I1kVnhhbzQye5twEhmphctXfWC6Tsk4GY4RpCRKnZTHMcwp0xZ0p0iPTDg2j6/eIVvggb2m1klFWQ09TwQ3OMwZu/o3Qiq9IhpAef952DKSXYWERduw1vDvgdHcySoveZMgRWTyCCpr4rhqsU3y8P/hJadqF81cfjlyecJr7JSYkNsqPTo8akTsL4XStkKEJAy68lzkxgiSzOO4l9IDuZ7CILhU8UtvHxUdPsQjQuS1udDrDQeKPGWLCX+TWn0eFeow61UYITOdfC0NgHNBvamy9xIW88APZhAjZlHghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHO6q2I3IkRyKmCuW7o6p/0UIyRvZ8sEHvIb9J0dOec=;
 b=b7DsswsQgEr1xBrY+Nm2MjbV0j+/OJguharNXUDaC+Lf71UcD1Q40WWac+eAtlBKHc8qCN1KJ00LFxHWIvYk5JYMRCPlaCLQ/KCVEQM6V1fP24gseyx9LmOR26Vz9VHmagf4m/OUedDHApFL2bkwiij22rwC6hRsTPjoD69l60c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 12:58:01 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:58:01 +0000
Message-ID: <c7c78714-d128-5a16-b0a8-f9dab19a71cc@amd.com>
Date: Mon, 6 Jun 2022 18:27:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 1/6] drm/amdgpu: enable ASPM support for PCIE
 7.4.0/7.6.0
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606031124.1818265-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220606031124.1818265-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3923468c-82d0-4faa-c4c0-08da47bc2fdc
X-MS-TrafficTypeDiagnostic: BYAPR12MB2760:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27601026F9B75BC6DF5B4F7797A29@BYAPR12MB2760.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66rWKZsD7xrRMkmX7qXCbrtMddTumbuzQzTnoySimWN5Y1B5OzVzuQQZfpsuXDrXHCd7KFOmcNiFYB1mm0VVNRJyqcjV++GwLrTEXX2yYqhDC3V86O7bPHzWqO8Zj+apphy9eMy89/nY9CGg3PrU7xWwVr5eEUlckdzZbHRtnZz85zSiGMwEwzHvcU/0fCULT0v+CBvQwD6hnkPKWj9/qUguutN9GS4XmZxDMa0aM/HP5lz950L6lTs5n+zAtntdqZDr++ndfP8ELmvsAGJ0e7QygQK3x4nNjVWhVg8B1oSBlJk9qQmWxI8VxMrYcXvSkQ6WkwO7N3CZPBGfPv23d708mNFlFesfYxHnz5MAM82XtbPVxmhT66ItD6zrCLD9PbqFJZuUuAAwJShne+xhfmU/5q8JHCpS5SUY5eyKffqsnzZn9b0duRGFau7xCp+rofT5tDoC8fSfa/74hk9tTvAuASzkQABuCc7DXx/YBV94UFXcnUzRWNYwixd1B1vMgSy6PAaFIzoRN4DJ++AVzO5spWCqs7Eez6FPSVD7XDactEaA1jCtFQPv+iDuKQoWn2yWH5nwczdJsWO+ItgE9BO1gmDlXM4tW+ldaUA8Db3WIWoYKRteoBuB5/TQYHFROK/MvjDRfy53tBlV6SXommaXxAZ5ukO3Mi6Z9Z0WSgn6dBt1vvJgCtUB0GyC0qsZRK0a2Dpm9LeckDYSiWxCT1VJWKIwH634mtl9l9kY0r0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(53546011)(83380400001)(2906002)(38100700002)(66556008)(66946007)(66476007)(4326008)(316002)(8936002)(8676002)(26005)(508600001)(86362001)(2616005)(186003)(36756003)(6666004)(31686004)(6512007)(6506007)(6486002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEphWTBCRmVOcHhJNTZFNVU2Q3ZIRzB0SzFoNDNaQlF5Y3ZkeWhtZis0aUp1?=
 =?utf-8?B?R2lFZ1FxSGhzS0U1UzJ6OUFBZlUwcXZVenJwTERTWE5kTXBJUW9Wc3hjeG5Y?=
 =?utf-8?B?SU9Ta2thYi9aM2FpY2ZDNWZyMEtMMU5VY2tsVXRKRnFvZU85WDNzSlhDVVd5?=
 =?utf-8?B?UDZXa3lPd0lHakNiV2pxTFJNd3A5RG5MMktwUG5XUjdWcTZ3SDFUS3FycUhQ?=
 =?utf-8?B?elRHblVGV3U4WWwvRmNwQjhOQVZoSTlJV2k4SVI2alFOak5uczkzVDVNYnJX?=
 =?utf-8?B?ZUp3TS9xU0FDVXdaZ1ZtekxVU2ZNR0N5cXo1bFZScWlTU3AwaW90alBOUk9x?=
 =?utf-8?B?eWxOL0dwOTVlelpXVzIvb2NpemJMbDFxeU5sT20zSSs3L0dmSVZreEJpT2Vi?=
 =?utf-8?B?YllWdlFiUHhCVHNlcFZpcVppOERLY0lnL2tMWTBzb1Y5SnBiMHlPVkdOWDZs?=
 =?utf-8?B?MEVqVkQzblU0amR2UlYyQXU0NlNjMUpteWxqem1TNjl5YVcyT2U0QTB5TE5K?=
 =?utf-8?B?U0Q4b0x3YzdXMW82VCtlNE82cU5rRk91MTNjcW9GaVNDWHBGSVJsSnc1M2Rk?=
 =?utf-8?B?OEZXUC9jcGp5NU1pdldoMFVneUt1K09zdHVNV2d4WWo2Y1N4bUdmckxSN203?=
 =?utf-8?B?OU9jY041eTUyd1paY2VoWWFxTms4TE5MWWdHMlJsQVdSZFlqWmkvNlRHeWpk?=
 =?utf-8?B?K2JzZGVOb1d4Wmg5N213TlVWSm93VlV2eFYrSzZhTWFONnYweWQ0NkdwNHpm?=
 =?utf-8?B?bFJCVWlWU0xyaVJkeVpPc1IwdXh5bDdDU2wxT2lQYktEelVMYVdZUlRpSHBo?=
 =?utf-8?B?QjF4MjZnRkduWjE3N3d0Q1JBenVwemNrclJyVkxsaEYwbHVHeVY4b3hOQ1Zj?=
 =?utf-8?B?b1dDalMvcDNrZmtjVlU2RnZpVnZvZE1IbFJPNHBxNktHOWYvYy92dWdmMHRN?=
 =?utf-8?B?WUlmRWNqaVp4bVlDOW9lNUZ4cWtLY2NBL0RRbjR3MXlUcGxFWWNzL1Jmcmkx?=
 =?utf-8?B?WlNLNS93NDI4a1huVnUveFF1UWxvWUhFVTNTUUxOVGEyUG5ZRk56QURMSkk1?=
 =?utf-8?B?c3k5SkZ3VDdTZXlaZHNuQUR5bFZJb213Yzh2TFU4WkdXaUZlV2VTMjBJWnpK?=
 =?utf-8?B?SmFCSGpDL3JzeFpJV1BMV25TMFcrYXhWSXZoZUN6QnJYRm01SlhYZENSRjhL?=
 =?utf-8?B?dVBjaWM0bXRnQjdVdTZSRUF5U0xLcXJmOGl6NnFTNS8wNU95cVRJakt0bFlX?=
 =?utf-8?B?cWRuTzYzOTZGeFhrUExLT0V6QzVQRDB5NElEZjJnN1RqWUhXNlVnUlRoREJO?=
 =?utf-8?B?ZEpVTkZMamUzeDA4K2RCUkVvWTBiNTkwalUwZUdBZnZ1SkJ2Ym8xT043Mlh1?=
 =?utf-8?B?YTZOa0ZuQm5zK21VRHhsSGhEcjBJelljcm5FTS9HaEVHN2VKK3E3eGFBVG5V?=
 =?utf-8?B?cmRMOW1TajFjbFRXbU1JMmRMZEZicURTQUNVelp6TnlNaXczQ2RxU0FvZmNW?=
 =?utf-8?B?M29Qc2EyVVd4bHpvS0RJRisyenN6cU1vSTBvUWlJZm82OGdDeDRFejRkZDFK?=
 =?utf-8?B?bGpHVjl1Z3ByaUFHc1dRb3ZMeXY3ZFpKOW1LdFl3Rng2bGdKR2dHTTRUT2xi?=
 =?utf-8?B?d1hrbGk0SzhEWjdZb3VveG9CQUFFeVZac3kxd055ZDRzeUhjTSt0TFk3WEcz?=
 =?utf-8?B?NGNRWGlJT3FhMnFERTViQmdhd2paNm1KUnBhVGVHMXZ3S3dUeWpzei9sRDNP?=
 =?utf-8?B?Zkw4MmtFYjYzQUduc1Rrb2FhOGlMTEVXdEdLaCtlcUFFZElHS0RtVmFuOUpD?=
 =?utf-8?B?KzkxMCtZZkxjMEhzM1BjOVFwVVRlcmJaMGtYbm4xSmN1RGNQRWdTV0tCbFJr?=
 =?utf-8?B?WWhYd2UxaEwvditYZnNlcUx2dVc5SEtXeUViZlBZdG1peUtYRitSOEt1WlBK?=
 =?utf-8?B?TEV3VEFNeVRBdCthRXN3UkkyV1ZLYmNKNjdGTVRCcHU4aTJIZ0hLZTR0T3p2?=
 =?utf-8?B?WDhsc0x1Tkx4eDlqaUhScDdHRDcxNGFHRjhsRmdrMXBXZXZLUTQ3Mm8rWURS?=
 =?utf-8?B?cEJXSmlubXZOL3B6dTZmOXFIUWNZN1daYzhpS0cxY0xQU3dEMzNwUWgyOXpT?=
 =?utf-8?B?Ni92Rk16MDhXTXJrM0ZWTnkwWXlNVHNTK3ZUcFVNUld1ZVluZkMxMm95S2I0?=
 =?utf-8?B?UnRHK1NyejhmSG1BUkVLVUpyeXFwb2dSRFhwdnJEVHJkaGxETlZ3UlBwbWww?=
 =?utf-8?B?L0QyTlJxbTAwUU83b3lIQUZZRllWQTVLSk94d1R3ZUR6MkVVakMwYVpaa3hs?=
 =?utf-8?B?NDdRVGlONXdOL2pjdmg4V25WUndyeUNEbkhNbDdVMkJJZndGc2Fvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3923468c-82d0-4faa-c4c0-08da47bc2fdc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:58:01.2361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXwaV9FxfoWHD48a5j3Wi0BTjqWxXyuTcUzZK4DCITU2KiltjaIMrgpaYUPx7zYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/6/2022 8:41 AM, Evan Quan wrote:
> Enable ASPM support for PCIE 7.4.0 and 7.6.0.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ib3b0e106ff43ad49f0f815e6eeb5c756b6bf4550
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
>   drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 109 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |   7 +-
>   .../include/asic_reg/nbio/nbio_4_3_0_offset.h |   2 +
>   .../asic_reg/nbio/nbio_4_3_0_sh_mask.h        |   1 +
>   6 files changed, 118 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dc938d4d8616..3eabca826c75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -689,6 +689,7 @@ enum amd_hw_ip_block_type {
>   	RSMU_HWIP,
>   	XGMI_HWIP,
>   	DCI_HWIP,
> +	PCIE_HWIP,
>   	MAX_HWIP
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 3996da88e1fa..44cea9649810 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -193,6 +193,7 @@ static int hw_id_map[MAX_HWIP] = {
>   	[UMC_HWIP]	= UMC_HWID,
>   	[XGMI_HWIP]	= XGMI_HWID,
>   	[DCI_HWIP]	= DCI_HWID,
> +	[PCIE_HWIP]	= PCIE_HWID,
>   };
>   
>   static int amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index ed31d133f07a..add093b9aa79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -344,6 +344,114 @@ static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
>   	return rom_offset;
>   }
>   
> +static void nbio_v4_3_program_ltr(struct amdgpu_device *adev)
> +{
> +	uint32_t def, data;
> +
> +	def = RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
> +	data = 0x35EB;
> +	data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
> +	data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_RST_LTR_IN_DL_DOWN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2);
> +	data &= ~RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
> +	data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +}

I think we should skip this private way of enabling LTR if is not 
enabled by Linux in device control2.

This comment is there in pci driver probe.c

         /*
          * Software must not enable LTR in an Endpoint unless the Root
          * Complex and all intermediate Switches indicate support for LTR.
          * PCIe r4.0, sec 6.18.
          */

Use something similar to detect if LTR is enabled -

         pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_DEVCTL2, 
&cap);
         trans->ltr_enabled = cap & PCI_EXP_DEVCTL2_LTR_EN;


Thanks,
Lijo

> +
> +static void nbio_v4_3_program_aspm(struct amdgpu_device *adev)
> +{
> +	uint32_t def, data;
> +
> +	if (!(adev->ip_versions[PCIE_HWIP][0] == IP_VERSION(7, 4, 0)) &&
> +	      !(adev->ip_versions[PCIE_HWIP][0] == IP_VERSION(7, 6, 0)))
> +		return;
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL);
> +	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
> +	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
> +	data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL7);
> +	data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL7, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3);
> +	data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
> +	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
> +	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5);
> +	data &= ~RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
> +	data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +
> +	WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2);
> +	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
> +		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
> +	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL4);
> +	data |= PCIE_LC_CNTL4__LC_L1_POWERDOWN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL4, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL);
> +	data |= PCIE_LC_RXRECOVER_RXSTANDBY_CNTL__LC_RX_L0S_STANDBY_EN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL, data);
> +
> +	nbio_v4_3_program_ltr(adev);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
> +	data |= 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
> +	data |= 0x0010 << RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5);
> +	data |= 0x0010 << RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL);
> +	data |= 0x0 << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
> +	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
> +	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL, data);
> +
> +	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3);
> +	data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3, data);
> +}
> +
>   const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
>   	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
>   	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
> @@ -365,4 +473,5 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
>   	.init_registers = nbio_v4_3_init_registers,
>   	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
>   	.get_rom_offset = nbio_v4_3_get_rom_offset,
> +	.program_aspm = nbio_v4_3_program_aspm,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 31caae7c2495..d8a954bd4c50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -380,11 +380,12 @@ static void soc21_pcie_gen3_enable(struct amdgpu_device *adev)
>   
>   static void soc21_program_aspm(struct amdgpu_device *adev)
>   {
> -
> -	if (amdgpu_aspm == 0)
> +	if (!amdgpu_device_should_use_aspm(adev))
>   		return;
>   
> -	/* todo */
> +	if (!(adev->flags & AMD_IS_APU) &&
> +	    (adev->nbio.funcs->program_aspm))
> +		adev->nbio.funcs->program_aspm(adev);
>   }
>   
>   static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
> index 53802d674e13..4b489d64deaa 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
> @@ -6918,6 +6918,8 @@
>   #define regPSWUSCFG0_SSID_CAP                                                                           0x2880031
>   #define regPSWUSCFG0_SSID_CAP_BASE_IDX                                                                  5
>   
> +#define regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL                                                             0x2890102
> +#define regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL_BASE_IDX                                                    5
>   
>   // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
>   // base address: 0x10100000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h
> index f3cda48bfaeb..d038fd915351 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h
> @@ -82045,5 +82045,6 @@
>   #define BIF_CFG_DEV0_EPF3_1_RTR_DATA2__FLR_TIME_MASK                                                          0x00000FFFL
>   #define BIF_CFG_DEV0_EPF3_1_RTR_DATA2__D3HOTD0_TIME_MASK                                                      0x00FFF000L
>   
> +#define PCIE_LC_RXRECOVER_RXSTANDBY_CNTL__LC_RX_L0S_STANDBY_EN_MASK                                           0x00010000L
>   
>   #endif
> 
