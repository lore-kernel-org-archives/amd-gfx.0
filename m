Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3936FCE086
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 14:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503BA10E959;
	Thu, 26 Feb 2026 14:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DgLP9TKl";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFE310E05D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 14:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRyEKXeJRMAKsATroEn9HYadBRY0a0JlYkj+PsSWTNAwB+We/6uDsuxawZ+HFq1UsFmjOBPBgvxA9pmgU1ILg5S4g+URsVohpOEuZBezP2sDZQCCN9LRcJ0BRbSH204BLIObggUBGyqS3J+qyAkaQxX8vY8cnL/JMnot0PGu43i3qcJE5RI1Qk4Dp8mQ/5hOctrNeXw6fO0Tv4EutwGJOxCNkT3Wpe+6YW+qxW8w2gBgGEwO19Z0xg1oLA0/1FwYBt7fxgLqHSy4NiHfTbOjcOHW05VE8hDk+jtcm/n5yGIFGiupZrtgiyliAU1w6alyTJIjI8lehYtOG/+FEjMQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gooEPhyP4PBQvuLZmZsICtZ6gOzCPHrjkDNVqZeHQ68=;
 b=v9ima4wr0K61+BCkP/WuqYMjYHY9i1cwedcoXvuXN96dlfVSEEbinGizNO/GXV4q49JbkRQysfTjbRQ3jXumZuzaPA8xmpZIWYRGeFA+gtMCz57mJlq5wF9cnFodJDMreu3m8JGhMALAb8zxEJ5Nns+BLs4jWEmZFVI63zt8xxsGrebfGkbv2vTHLWYA3eV5Wkxe/95rM2jeJRQuWFboOXpGTapTKPomreCqVK34ro0CX1FLHs4YXtmIV/H3x5FlH19f/z1/WwgrvfecKs8QqNxJFPrnAmRv/KWB9neXjmd6mRocpLCHZNx9riV9jj74Aua+ccbRbWos0LSQfhC6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gooEPhyP4PBQvuLZmZsICtZ6gOzCPHrjkDNVqZeHQ68=;
 b=DgLP9TKlqAUV8WePqa1VMfbYuHEPvGt+a91hXBg3k6KZBMCYhKI7Wy+9SU31T2sxOoK8XGkordT2EXH5cPJfNb+ujfDxF4e1HL5PWAZFNdvTtSC+7w3hS5daz5E0MqI7vGVVtp1bulebx3yaDo7LbIahiWTeyZlDTVfaQft5Jwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 14:08:40 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 14:08:40 +0000
Message-ID: <80fd61ee-becd-4b92-a592-8f7a1a9f960e@amd.com>
Date: Thu, 26 Feb 2026 19:38:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/psp: Use Indirect access address for GFX to
 PSP mailbox
To: sguttula <suresh.guttula@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260226105757.883463-1-suresh.guttula@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260226105757.883463-1-suresh.guttula@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: a446e9f5-5dfd-482e-656c-08de75408ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: MJG5rIgJlAJyxQQOtW+X2YUjF1CFRjNOASADT3R5WG4BtkWK4Sqd+ycEeScyzVY+c6HTaMNFlMx9tdW8Te/EO+OVkcDAvcmb5P2lyGGjfct0HXi6k3ZxBlXnZOuSXGE5AjxeMNLA8pPc506CKHA5OrkGq4qz6eqPqpmEnrZsu00+JBfgkuLztJnApE695XTDP7tRxrHC7beBZG7FzFmqy4L3HMCwkAM2p+2LJ1BHJ9YABwhad4wePm7Qp+5shNNcSIau1bO4qqS0atIBwUwmGCWiTL6mltt8BNxUosFaFz2l9xwRkUkjRyzx2/zN8gcHfMisnQUQwW+AtrfkMSPSmHyQFN4CdUY3k/oGe2PhzdihK+D9BhG0szNZKYq4ylA5inHC3QYwrwF0GWt1NkNcle8ukAC6eCyi6/1NLWHQMobaEOCZv8rV/rfyGxFNblTvT2jdjLqC+scQ53oC/Dix9klMv+bwtO60ZwQSEqgoNjinKwF8R90LRubwnks7riPg0I4iX8QSEBHM8vNMULGKrmaUoQD83pB8oVWWZ/I+F7XhcjeFlMrzw+GK5DMsaoLW9vrZb1wHcEeCk6dSxTfFDaGyK9rFohTs5Czxfo+ozNIPyVrvNIvISaFhaDAZdVAVsSN8vRh5xGih+T8e0nlwHl3GbRXJU8ctYxaTkcQXgD3Isdnhmm0yLqa8zi1rNEq6GvHn10dyDdC0yYKm6wFGkaOEqY+TxvpIgHMXqYytPTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZlb1NuaFFjekRjR0lqR1NWL0hxVGh0TUpjbC8vRS9hWkFHZDJZMHNRcG04?=
 =?utf-8?B?aUdDV3ZrOFZtMjBDQUtuZnVGZWxNSG4va2tpT0tZVzMrZzNveGxvL1pSZWpi?=
 =?utf-8?B?TElic2I4b1laMHZmZHNzYUc1eTZvUVNNa2RqLzJSbi9XQnVZeStsQUV4cTF3?=
 =?utf-8?B?OW5iSWVHZkRPWjFSSjhhWGN4NnUwRVI4Mkg2K3M4OTJEMFFRUUxVRCtwOWZ1?=
 =?utf-8?B?bDJ1WGVIcEQzZ0dvMngzQ0NDOG1hNThCQmRjN1BIQm9sejA2T3R2b0dPclQ0?=
 =?utf-8?B?TzhrM0dXbEN1TWJnMkVKZ2ZPWmxuWTRvWXA1V0tzUHJjSVlhbnhFaWk0cjFo?=
 =?utf-8?B?MGZ0Mm91aWRPZks5MU5yTjdEZzhiS3c5cDd4bEg0MlFDc1ZxSjJlc0YrWUh5?=
 =?utf-8?B?UzdERjZURWhmRTU5SHA5Q28rcjJUa2RaZ3JQK2s0REFlNE10Slp5WDFjaEVY?=
 =?utf-8?B?Z2xGMW9WclZJVmdQY3l0NWlYcldsS3Y1ZzZiRXRlRW9YS1c3MVVIVzVkYnFa?=
 =?utf-8?B?RjJmOUdaSWNlRXlCSHo3VkZTTjkxQ3BHakdDa3NMSmdRMkQ3WkNJQ3J0NTU4?=
 =?utf-8?B?bmJWcjN4V2U5MHJ0RUNkNXJoQzVENWxQTzlZQzBob2Nwdk9tSjV6Z0lsYXFx?=
 =?utf-8?B?VFhOT1NPTGRRQWlheVFSajNPZXJpRW9LL3pwS01TcFdrUkxlQytURlVhanFt?=
 =?utf-8?B?ZmcwZWZ4RHRVaDFLZlh2VUJoMEpnT0R3NWJwOU9jRndCdjVSZlN6ZDYrRG9K?=
 =?utf-8?B?OEt1OUxhdTUxS2xzNGJzZlRzdTZSVUhrd2VZMlpSdjgzZWxKRStBRTBsRUdv?=
 =?utf-8?B?V05PVGx1dWlaakd5NFZ3cUltSittdmROSDNjUGJ3ZDFGN2hpSnFPaE9OUUVm?=
 =?utf-8?B?VDV2dTA2OVd6OUR4MHdTcjZKWERJRkVqakNNcDdYWlJQNXRGTW5pSm5YR2d2?=
 =?utf-8?B?VktNU0tUN2p2b29vemZ6bkRYRlg4VDgrdmYvUVJHTDJ4VDQ5NW5ZK3lzb3d2?=
 =?utf-8?B?OGt0MVlFTUh0T1JCclA4VnpRM2QwUGRDN0NtSFZoNGJKYnVwbHRiZVhEVDNR?=
 =?utf-8?B?dkw1Nzc0RDh2OEVqZUF0ejRVNGdMcUlnaE1qRzc5YkJJRS9zQzcvWUhZYlcr?=
 =?utf-8?B?TmVQalNaUmRTaFhYRzduN21EaTFRM3FIM2tnVEQ4S0VKclY0REQvbklVdzZE?=
 =?utf-8?B?YVJrQUVRN2hXM0lhZ3pUK0lmNGtHS1BSYXdhNEk2Q3NJM1EwUDZXYWE1YkUw?=
 =?utf-8?B?Q2FBZ2RyOS83YXEwU2xNQ3ljUHFkMzFMQ2cwWFYyN0wwMCs4emE1cm5nWm1U?=
 =?utf-8?B?aDg3ODZtb1AzM3RCZzNLQWVKM0J2ejF6SWlBUFc1WllkRVhyZzNVTHZpSEd3?=
 =?utf-8?B?S1dUMHp1WnY4VFlzTXdlallTbk1QYmFxSm9IWkV4b3ZoV1pTWUZISFNsbEs4?=
 =?utf-8?B?ZmpUa0RRekQ0Y1NDY0xwQmtSNTBYNU1sTjVCTWlQUjJxdmR1YTc0SzVxTHpG?=
 =?utf-8?B?bzZaREZQMjNFV045bTlUREZMem8yRUN3V3hwcHJ4cjRTT1J2UXhQcFk1QmZL?=
 =?utf-8?B?eVJybkZ4NTg0RTJMWk1pMnhQTXFjWlpSUWRjazA1anFHU3VtRGdhU3l4TnpC?=
 =?utf-8?B?dkVhY09FakUrWk1sVm5uaGZPbVV5TVgrYk9ZM1BRZTN3UHRnVlVYUEl2N2Ur?=
 =?utf-8?B?RFBHYXp1bkkwRElHaS9EeVdSOEtUU3h0cWZaTG5wVmpySzhlOCtWa1hGUzAz?=
 =?utf-8?B?U254SWZOUllmK1U3bURLM25yZEpwNS95MUp6Si94a0Ftb1A4VVZNbVpQOFpj?=
 =?utf-8?B?bXN6UTNnM1BqZmlycXdPTnp5eGNiNWJZUGhHWjkrZS9VWWdadHkyaFNIZ2di?=
 =?utf-8?B?Ti9qNEpjQW5PWUJTTXhldUw0M2hIdHFKMVdtbTBndmFXdjkxaHNoQ0s1RWxq?=
 =?utf-8?B?OXplVnN0ZW9YZm0zMXdJWUdHT3JITW9vOVFGNFY4N2hxMW1rOS9ZM3pDajQ0?=
 =?utf-8?B?c3hYZUd2UGx1aWhIaUpRSW9GTVVGbS81KzB1UUptZ3pxc09JUm9EZ0lBK1NI?=
 =?utf-8?B?TG1ScEw5N1dMai9ZZ3pXK3BzWGlhQU5vNGttWjFPZDJGTk9pRng3QnNpTTFO?=
 =?utf-8?B?SEtLdEtyNjJLVVBwVVNka0V4K1dvdERRcjhPaE5aNFRFZ3ZCWjMrSlZ5S1FK?=
 =?utf-8?B?K1E4aTZPU3RVN0xNczRQTU96a3ZKdWptb293azVrNmU3bUEyeU94Vk9JMVla?=
 =?utf-8?B?c1gyaG9NNHYvcUlaTER0OEp2TCt4Wm1HUUMzaTFYdzhzR1J0dDZNOEVPNldZ?=
 =?utf-8?B?SnZWNnMvRjlYbm9MZFB2ckl4UUVUR2hvVW4zVVUzQ3I2TmlRYU9lQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a446e9f5-5dfd-482e-656c-08de75408ab6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:08:40.0389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2OG3nIAi6/tsGXMszfWHnlXXKrMrxzjXr+Jsah9J7lkBOiRofeO5OEeUs5VOCdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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



On 26-Feb-26 4:27 PM, sguttula wrote:
> The reason the RAP is not granting access to 0x58200 is that
> a dedicated RSMU slot would have to be spent for this address range,
> and MPASP is close to running out of RSMU slots.
> 
> This will help to fix PSP TOC load failure during secureboot.
> GFX Driver Need to use indirect access for SMN address regs.
> 
> Signed-off-by: sguttula <suresh.guttula@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 20 +++++++++----------
>   .../include/asic_reg/mp/mp_15_0_0_offset.h    | 18 +++++++++++++++++
>   2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index 723ddae17644..73a709773e85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -69,12 +69,12 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
>   				   0x80000000, 0x80000000, false);
>   	} else {
>   		/* Write the ring destroy command*/
> -		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
>   			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
>   		/* there might be handshake issue with hardware which needs delay */
>   		mdelay(20);
>   		/* Wait for response flag (bit 31) */
> -		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
> +		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
>   				   0x80000000, 0x80000000, false);
>   	}
>   
> @@ -116,7 +116,7 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   
>   	} else {
>   		/* Wait for sOS ready for ring creation */
> -		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
> +		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
>   				   0x80000000, 0x80000000, false);
>   		if (ret) {
>   			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
> @@ -125,23 +125,23 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   
>   		/* Write low address of the ring to C2PMSG_69 */
>   		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
> -		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_69, psp_ring_reg);
>   		/* Write high address of the ring to C2PMSG_70 */
>   		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
> -		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_70, psp_ring_reg);
>   		/* Write size of ring to C2PMSG_71 */
>   		psp_ring_reg = ring->ring_size;
> -		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_71, psp_ring_reg);
>   		/* Write the ring initialization command to C2PMSG_64 */
>   		psp_ring_reg = ring_type;
>   		psp_ring_reg = psp_ring_reg << 16;
> -		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64, psp_ring_reg);
>   
>   		/* there might be handshake issue with hardware which needs delay */
>   		mdelay(20);
>   
>   		/* Wait for response flag (bit 31) in C2PMSG_64 */
> -		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
> +		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
>   				   0x80000000, 0x8000FFFF, false);
>   	}
>   
> @@ -174,7 +174,7 @@ static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_context *psp)
>   	if (amdgpu_sriov_vf(adev))
>   		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
>   	else
> -		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
> +		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
>   
>   	return data;
>   }
> @@ -188,7 +188,7 @@ static void psp_v15_0_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>   		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
>   			     GFX_CTRL_CMD_ID_CONSUME_CMD);
>   	} else
> -		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
>   }
>   
>   static const struct psp_funcs psp_v15_0_0_funcs = {
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
> index 0e4c195297a4..fe97943b9b97 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
> @@ -82,6 +82,24 @@
>   #define regMPASP_SMN_IH_SW_INT_CTRL                                                                     0x0142
>   #define regMPASP_SMN_IH_SW_INT_CTRL_BASE_IDX                                                            0
>   
> +// addressBlock: mp_SmuMpASPPub_PcruDec
> +// base address: 0x3800000
> +#define regMPASP_PCRU1_MPASP_C2PMSG_64                                                   0x4280
> +#define regMPASP_PCRU1_MPASP_C2PMSG_64_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_65                                                   0x4281
> +#define regMPASP_PCRU1_MPASP_C2PMSG_65_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_66                                                   0x4282
> +#define regMPASP_PCRU1_MPASP_C2PMSG_66_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_67                                                   0x4283
> +#define regMPASP_PCRU1_MPASP_C2PMSG_67_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_68                                                   0x4284
> +#define regMPASP_PCRU1_MPASP_C2PMSG_68_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_69                                                   0x4285
> +#define regMPASP_PCRU1_MPASP_C2PMSG_69_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_70                                                   0x4286
> +#define regMPASP_PCRU1_MPASP_C2PMSG_70_BASE_IDX                                          3
> +#define regMPASP_PCRU1_MPASP_C2PMSG_71                                                   0x4287
> +#define regMPASP_PCRU1_MPASP_C2PMSG_71_BASE_IDX                                          3
>   
>   // addressBlock: mp_SmuMp1_SmnDec
>   // base address: 0x0

