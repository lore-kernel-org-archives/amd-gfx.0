Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CA2CCA47C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 10:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988A8112D54;
	Tue,  7 Jun 2022 10:32:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DB811A05B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 10:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpdoPQ2q6nFxj7u7e74ZQ381S/cnyC4xLXa9up62bC5LQUblszuqg9B24l4dBdAPcYwBXUUoHWBzbzHOKveD1xrmFqwcHaC+Qsx3W2cbqD9PQjEo8qjt8Lz5qzZ5+9jFR/ke6wjlLSPsZm4iOIull8KUolHiojnwVaeJdU70zNnaiKw2y2/BulA61wb+qvtZXLaN7j3FC9wonHX9gaGygEa+zFsT/090jHEmBVxFHATkn+rqnWMeqdbkmOO8Kb1HMiUY69CM6xQzcG0/Vd/s77RGPqiyPcB3YUu8unSl/nXwmj6qnxyRwRnH8xLSJg1ISpMO47yBaQ1yfrg6r7LVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtk4oiNMKZNhRM1EvZfhtwXP8NBiaFN7LkdA1fvQ2C0=;
 b=mpuHwnykg8BOHJK1wbBA162fHvKfUsgn8G2ZKaNpdyIujpW9Tl8/dLsTvujx2od13YSvquwk+468kdHyt26hTbGoodLKFIjmYvEL9AXfMGdP/YoJ2jzOu/9RzJdn86MTi0UjORKYzfKuhMoybSfXtY1WeHOOkdfzOg6kzylXw6lJ9C+/IvONB2OqjzAg/CQWEyDzVtn2ATMbjHNBymhqmU0viieK95hjT2iXuIgXKnfPG5NWSpJMKSLs/ewSwr8ZS4k8+J8Gct8yv93a0YIKuU3nV98GmWUJfE0G1gAhLaQTq0RsQztrhZ/zEm0oAkX0gMgcA0sLUj6RHpTIGlrBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtk4oiNMKZNhRM1EvZfhtwXP8NBiaFN7LkdA1fvQ2C0=;
 b=RbYvYcCDdhyZMHECumAIViC4IjoQASq0Q+Razr/zy0Gqo6ndgQsa/20yHjMHcStsVhjSK8GWjcdkgYZmBabS8Ta8Y3wr3YVo1O5lZ4uvNOYKVF15WqWSsPLFS3IK2YlDnENde1hrNhLoUMzsgxD0awX6L4dnfQp5ZKlHAoWXPSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN8PR12MB2931.namprd12.prod.outlook.com (2603:10b6:408:6d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 10:32:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ecdc:8fb6:a82e:1e9c%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 10:32:44 +0000
Message-ID: <3998165c-8dd8-4b33-df92-e784cc57c5b1@amd.com>
Date: Tue, 7 Jun 2022 16:02:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3] drm/amdgpu: enable ASPM support for PCIE 7.4.0/7.6.0
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220607083831.1864654-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220607083831.1864654-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d878f2-f383-4df3-3bea-08da48710eb1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2931:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29313E294FFC1B67F51305A297A59@BN8PR12MB2931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4GHCQzA8grOKU0HOuvwnOKdqc/Tq4iZG9Nf03jN+5MDe4N2/5qiQVAYPCDMQO/Kce9z0WMeEwsKwZPu2v7i7aqMqfYtbFuqSDIduzcgumsxkp6U3hXmKUwZE8067LRJTBDoAJsavPoJsAX8lvXMwVn6jNilI7AOMt/EjtozBXc47aWtrIKUfbkzb0yZ7GSYPwI1xTOJ3KEvVuWtsUkYcT369P7pGkeNhcAmoCqqfoNYiPVCIo6nImzBEDsDwd2zkT9mCkpanC1ZsgiFvFbRbvI/rZ2/xDmdF0eB1sLCbULRQEUA3E7njHbBhp7glHRvH2qIak3SEouDtOMVfn1qc+9QnBgbA5oT7aQZf+dD3ALk7Bo8GZjoEyq6NU7mRnE+OfE9TzVoIjXVF4dCFH4Qm1fYmjDLwzakCDOKoKn0vThAZvG4t92VoKVZ1HlGocsl6PwUs4sbZzVobi3rcTYpP5s3U3coGlLiBV5ezjVZgA9uLkNSuj/rpGOSt7XiPEqdfBBSP7kVyLI4xVjL/Ye09S2TKI8gUa0KLXeaIaNPP8oGhmB4qAg452Pi+aOnMZYoe2nrpHT3/c7dWxTdQki1N3IB7JctBKoCj1WCjnoP0a5Wc4jt5YuZC8+14/OOIB3jbNoVKh49l3IJTi5XziBvs1vIVNmRi2VdUFgZ+UYFI0Zx2+/4CpQ74MhX7BWjN8lhi38ItJeZH6uuN4xp5dEBPpZvX7s7zcZOvSeFKY9mzB04/I0DHzFI1Pxnc+7sbVtr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6506007)(316002)(8676002)(2906002)(4326008)(5660300002)(31696002)(508600001)(8936002)(66946007)(66476007)(66556008)(6512007)(86362001)(26005)(6486002)(186003)(6666004)(38100700002)(53546011)(2616005)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdaZkRBZE9IQWFneHM5OVp4SUxTMnpyVm0vNGZ4VTZLcU5ob3pNakhqSmth?=
 =?utf-8?B?SDh0ZDRETWhwUnh0OUhBRHAyb3pJYmY4cHpVN3U2RGV4aDhKL3MzOE13dEJ6?=
 =?utf-8?B?VGtybTVnd1daTlQ2SjhTeWtBWU9QUFBmT01HMTdnbWo5R0lGdEJqYjBEZklL?=
 =?utf-8?B?cmNmNzgxWElKcjgwb0UzTW8yOElQaS80aDIwUHgzL1VsdXU5UVBHVk13Z2pE?=
 =?utf-8?B?eHdLd2dTQzh3aHNyWVNqSStlYWx0L3crSlhxSXpnc0ZyM1Q2Uy91djhqVXVZ?=
 =?utf-8?B?U04yY1NvdnM5SjNVN3lvQ2ozejdtOHFvTVE3cElRbjRRN1BTTEtBVHo1TXlz?=
 =?utf-8?B?ZE1Ia2ViK0doTEVwTzI4MCtiUCszdjhCRGR4VGZVZ3h0V0wyL241NDJKeVk3?=
 =?utf-8?B?T2VHOHJpRW1LU0hZOUd4ZnNvNHB0Yzc0cjhXaG1Pelk0UFcxeEM0L1B0cGxC?=
 =?utf-8?B?TU9DMWZRZXQ4RGV2WFEvM1dMc2V4YUlMb2V5aDN4STdzcnM1Z05BY2tKeThN?=
 =?utf-8?B?b3NaemlhTEhIL3dpQUFhUHdZZjRCSlRqK1RiL25UMGhXcmQvcWo4aFJ5UGd4?=
 =?utf-8?B?WE1NZTd3dDI2SXliTnRzenpveEV3eHM5bjhWTTQ2RkVHT2VFMnlkcFlvcmJ2?=
 =?utf-8?B?NC9lUWFDNkpwWVV1TUVTZVZKMEFjUlB1aDU0YlhGZWI0eHJIVnRta1V5cXR4?=
 =?utf-8?B?TThQK1pwZzVsR0xmK1lJTUZFdVZBTmo1eUIwQlFkL1FrY2lLUUNJNUN1R3Y2?=
 =?utf-8?B?Z3NudXhsWWhQd0xKS0NUSU00N2t5Rk4vYW1HM0RLcHZqKzdDdUNhYUlQSURJ?=
 =?utf-8?B?TXpqdTd2RG4xSzUwRXpla1BtQnI2SXEwcTFZYmY5QXVnRnZob3pRVm55dzYr?=
 =?utf-8?B?bXJtWkk5TEtrQm5OaFFTTjU0emxyYTlzbGx0NzN5c2hwaFM5U01vMGxvSktQ?=
 =?utf-8?B?QXJ4NDl4cHNSM1pHVmhaMXFtZkdFVmZ0dnNLa1I2aFh1Slg5c0UwLzJNUWhn?=
 =?utf-8?B?TzdWTEI5d2lHdzI4QVZtNlpld1dPNzZpcmdrd1ZKby9OcFQ1TVp3ODNBWFB0?=
 =?utf-8?B?RTVzcmpZY2ppM2Q4bmVaYlVuVWlVeWRYL1hSYjlBTGZ6REFScWtYMXp2c3JO?=
 =?utf-8?B?WUpQcUVXNjkrcmZzQysyV1lyeHVjcGprM2NGNW5RWW8rUVBYR0FWWFY5N0p6?=
 =?utf-8?B?UUNvZHBYV1hPdVJNWmhWV1dUZk9PMFEySWxBcnFpRmtQVUhUQ1E5VkpRYjJL?=
 =?utf-8?B?K3kvdWphQjBVRVY0VFRhdnByQWMvOTdvOEZJWEZ1K0pnNWFSaXpucmtwei9Z?=
 =?utf-8?B?UVMrZTJqTzFwb3diUEpKbGZsUm55V1kwaW10QnVTWXFLd3NvVm1jYi9UZms1?=
 =?utf-8?B?SWd4eFVmVnpDR1duY0E4T3VtMFhQYnBlajludGc4WnQ0MmJkaWdtVUxuS2Vo?=
 =?utf-8?B?ajk3V014SkZOMmozdThBaXUrZ3pOclA1eXVPS0tQUHZkZklLM2VQR0tqMm1S?=
 =?utf-8?B?T05TdE9KLy9FdXVwN2lmbVkrV0hRYWNLV1RuRHM1VTIwblJzS0JnQTdsYXBm?=
 =?utf-8?B?TExBK1BqMTlqL0N1THR6QzRuU25MVTNYT1VuV2ZmNm95VDEwdjFib3kyb0dy?=
 =?utf-8?B?Zzlnck12Sjd5bVFIbmFwait1dWg4VmV1NmNINGJJUUpQUzdFYW00UkVkVytO?=
 =?utf-8?B?SW13YXdITWFGL1JubDVIeUZvLzBnemNvK1pCaUwvWHJqSlNJOHRsV1dGVWhK?=
 =?utf-8?B?K2NjYmFJdWtweFpEdWg0dmVJcVNGUTZteHFZdS9xVVNmL2xWZkt0YUF3eHRq?=
 =?utf-8?B?bUVOclAySmQ5NGpuZ3E2WmVpZlo2UVd1WG5TUndoOERza3JOY2JUS1A0TklG?=
 =?utf-8?B?WFJ2dGtnSktqcUk5SnZWd3RkemZ0bnRVR3VURTlDUXdrMFM0ZUJnMU1iTkZY?=
 =?utf-8?B?Mm9xNWRrWjZxQzVPTDFlNi9TbEZJV093TE1VQlZaNHZoQ1JlcEs5VnJ2aFJw?=
 =?utf-8?B?MGtnRldKYVVkb00wQWZab1VxL25TelFCaFNBUFdvT0VEWDRTaFpQZFV3L1FP?=
 =?utf-8?B?dXBpSUVxeWtZYlVuWWRkVitNV3pkTmp4UkdqRGVwNDc2aFRSZm50ZDVuU0tK?=
 =?utf-8?B?OUdtbHl1MzZqSktocG1malB0b3hIQTU3T0xocUxMSVBFQ1hseWR0TklZclFl?=
 =?utf-8?B?NUQ3UW1ES0dKdXV4ZTN4TGEwWFo0bTdrdUhmUFE3aTB1ZW5Ycm9zTlBIOC9H?=
 =?utf-8?B?SDdzWXEvbkpMQUlIM25vUDRvcnZwbkJuaitNMlJieFFTcnlJcUVKNXFpdnd4?=
 =?utf-8?B?OXdTWDluZ0hncVpOOFBXTkxrckhha3Y2SWxvdXNBV0Y4TVNyYlhQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d878f2-f383-4df3-3bea-08da48710eb1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:32:44.4471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pReJzbj9f208YYvagHRRABd9SdSHg6T97vE8RX4KE8CiLcA31Gi9iEgHEyQMdtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
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



On 6/7/2022 2:08 PM, Evan Quan wrote:
> Enable ASPM support for PCIE 7.4.0 and 7.6.0.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: Ib3b0e106ff43ad49f0f815e6eeb5c756b6bf4550
> --
> v1->v2:
>    - support LTR disabled scenario(Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
>   drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 116 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |   7 +-
>   .../include/asic_reg/nbio/nbio_4_3_0_offset.h |   2 +
>   .../asic_reg/nbio/nbio_4_3_0_sh_mask.h        |   1 +
>   6 files changed, 125 insertions(+), 3 deletions(-)
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
> index ed31d133f07a..233be735165a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -344,6 +344,121 @@ static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
>   	return rom_offset;
>   }
>   
> +#ifdef CONFIG_PCIEASPM
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
> +	if (adev->pdev->ltr_path)
> +		data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +	else
> +		data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +	if (def != data)
> +		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> +}
> +#endif
> +
> +static void nbio_v4_3_program_aspm(struct amdgpu_device *adev)
> +{
> +#ifdef CONFIG_PCIEASPM
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
> +#endif
> +}
> +
>   const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
>   	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
>   	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
> @@ -365,4 +480,5 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
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
