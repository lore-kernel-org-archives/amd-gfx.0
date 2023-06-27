Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E90EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 02:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A32710E278;
	Tue, 27 Jun 2023 02:04:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FC810E278
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 02:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9mE3VTbg2M68bjoVy08B0yMOaERtnpWukpKj54m4V7iTy+J5gZNzFoyZliARS2dk2xphdF+wIo70kRtCRFIlP+5nCvKih6bcc8SG8DZFqHFPKCRX/hMhOUFnl+6yX9NEop8+G0XdsbSJ1Q9Eq4UuFcYREQSLv2khZ6zC8LAEVdfh+STiocf3aF6N4TPLiQrSJch/NrJYM/zUr5+WltxvllRe8bJK6wjFLZnaEf7PgRjAuyyVlz/IHdaqRRPYTJwYzRTHxk3+maMkrJZaIULWj5wvnK0JXkT+sD0boi4jvRhbeR+B29d4i/htpGUU2r749gu+/5ZTxaCzf5ypuZPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r30XpRwgDen5fVbOQtxL7pjwcTDhbzt8OWZRHJsTuw4=;
 b=OQKNxB0B2/EUW7g44vDo0PX7q0x/KXSpNy0DU9O1JJExliofuVFquI1DB4KKJQtugdtcZrld/j1B1OVUNMfnhozScDQF6UeR1kpBA3nCK70NzfksbspH9EmDvum/k/DXtTtWRBO0QGGqkkjFevOw5JNa7ncJEtaR8WPrieq3T/+/4ngvfbF0ccXCYZSil540HhAysfcmlNQ/xqyl/BEWs30xyNcc/0khBebhSpJda2mPPm4VmYgsTJ0oxadT+jC8UC2M0eE/y7F3Adm4ZbYU9Xm9vTGbi0ZDW/eGuY/rdUtmP/BOHePDKl0n3RcCvHd8AB0V40boYLuf/Emepw2/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r30XpRwgDen5fVbOQtxL7pjwcTDhbzt8OWZRHJsTuw4=;
 b=JRkqrgwBFXvrSebfm5Etr4hIoOOe2BKHmjbEcvKhJGe/RYvTyl37srzxvcP8Y+S2IgEnroZP6skvLjvR1W30t7pBe+VCGI+6MzF5NK+se+ZqefGZs+vPaQN/zhb5exKH6c0xUcit/fd/Jhk7WMCUwfjHP+eM28uMEJ4mLX/Q8cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Tue, 27 Jun 2023 02:04:48 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637%3]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 02:04:48 +0000
Date: Tue, 27 Jun 2023 10:04:39 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: rename psp_update_vcn_sram to a common name
Message-ID: <ZJpDt+sRR3pYtx+r@lang-desktop>
References: <20230627004251.3521493-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627004251.3521493-1-Lang.Yu@amd.com>
X-ClientProxiedBy: TYCPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:1::29) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: ec36a615-3b3e-443d-3d59-08db76b2e25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD6MFjoytm4ZwMdUVzTrG2JTtw+PB4Wmgg6x6i2Z1UdSu0X0xWw3QUKOzbAbiYShidEM89/NHDtnvcWNl4yytLA0GT//4lC3cthI+mU1R9VwyMptpL7IPk58SvnkcHWAuiK6LkdEHSWcyOxxPBPl0N207Yg6MXNAld3JC6zJqEzNYhi3nDzRH2/xKtWNPOOBCi8ahHzFcnk/qnAYbTsz7OaOjQYnC2XvpkLxdkFBrQWskRnuhutKd6wxECcQ+itiJvG+NbnBfsGH82PWjOHcVfysGLhWKQhXi7PXh2IjkPpz98hWAkMfBuSBc2Hv6aF2h+B/1x8qA5mz0ehezMGEuUz9t90amz3AKgTXAHJZYYw3S3xdthEuJFGSW828JJoD4DqDkXOogvdA1myX53+YpPFqYRfLYWT0YkGbXlOFBDTL+i7899Jz4L/Za5H1UG0xYqLHnNmMm5dBBi6akf+ZGCj6rUbIbKN4jDfFOoPp6lXXHt++dMdAzUN8KPO1Gsu0gURBWc2iiDOP3LVXGGNvnIZqFJAF5giR0aYUklVBtt1EzmXAsASQcwkQ71bf7qvc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(26005)(6486002)(478600001)(6666004)(83380400001)(6512007)(2906002)(6506007)(186003)(5660300002)(33716001)(6916009)(316002)(38100700002)(9686003)(8676002)(66946007)(41300700001)(8936002)(66556008)(86362001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?os2TFOCdO/WMpIXmRvfmkVS12DgoWBGxZv+NWJILaIKFDQMTzltGyDg3ZLDg?=
 =?us-ascii?Q?pMRP9zTra1VGxb972niGTlbY1U+C22DI1TI1GL7UUVhJbB7OxZSylZBmpCRQ?=
 =?us-ascii?Q?QJ7v4lBd7VWic5TWEgRkvBpzOwOXv5GGnNJCnv0IYZ4dFOBTY642ubGTiFNc?=
 =?us-ascii?Q?hXBZclQ5IMrP7W+cIVPBH3eVo7NiQUT/tUpaZh9X8ifM0jAK+unM9CdZX9fu?=
 =?us-ascii?Q?pALyRTfil+GS0mcdQHqNtTN4lx5U9IkNVtOgZw69fUpeHAYsKRRs6/1TKLS9?=
 =?us-ascii?Q?ifbpdPg28IcCshv0fSEcowPas5x35fOOR8zj41iuX0XO1IgLe34BWi+Pwgqn?=
 =?us-ascii?Q?MOQ2ecdgUyYk6a6hrvgS0PSPvXHb4O/YBiLXRQPolJBLTUHR5O5okR8KNkff?=
 =?us-ascii?Q?Y9xOs+IKLKjKlAi6YK+Rk7wsZ+YA/gxs68dl+u+9MbogaCiUhrm9tka9z+uV?=
 =?us-ascii?Q?xEgA/ycFgF/2Xz4gBFbQoCV5qfLn5r7PyaMK8Nuz4Pk2fIM9jCSWH8oP6cjY?=
 =?us-ascii?Q?Rh36DURIizk2Ko8dAFIkQw2Vmw5+Xk8MHHoR+wJUzLiyonOtYAswwzz7EJql?=
 =?us-ascii?Q?7Bf+IEH2BggbZ3WX/LtZ5sC8YkthR4WjX5jb1HW/HJpjtQH14I6AvgBS2/j9?=
 =?us-ascii?Q?aSHFECRmsdRUxbzljPLl6BusxSodb2IBS3+IVSSFkkQ9DMHg/7KlPHuYpN+z?=
 =?us-ascii?Q?ZYKuWDrfNrUmfnj2TA3YKB1ELzjpdz+o6vfM+jOc9EU1AtHwtsZg5mezbhcQ?=
 =?us-ascii?Q?kLFVI9k9JPcU0ctZz/ssvf6GMUbCNAzMEAtNgtd0PjF8FZTf4YG53VTGARCJ?=
 =?us-ascii?Q?WoH6Pr4ivg28ZbG1Xy/Oj5VqFYPNFZUbOaKUf60AoFiuwYOmoPZhJrjkD9mr?=
 =?us-ascii?Q?f36jm5KkNFDLDYkgm7m/jH8FkecjriL99MOUi8KdkGLizFherrRLK8kKVeHM?=
 =?us-ascii?Q?+iyiGsXvCY/hAMkad5nH8DjifwN8UJDb5j9Whe2fxD2RX7DAKk8PszB0vgSQ?=
 =?us-ascii?Q?IgGlzR3vcd4Hl0MM4HvlHaq/ofgEsOuLgP7qmTeAcS7ssVQudVlOcEDPYHoB?=
 =?us-ascii?Q?vQ73ZJMhXETxxUHoVDwX2js9QLlm6Qx+dDLfumsq/19lNwJCIVmSJMCwybpK?=
 =?us-ascii?Q?bDROpsNrgUz/86/xRebY7tkSK/1M4wVt3+93qqFCaB6COxPHamKSx+EKRs7m?=
 =?us-ascii?Q?HRlUVTif36UzuV4oecjijXS4p2/GyXgkYr+mmyRnCHuUNHhAHDRbo+Js1dcJ?=
 =?us-ascii?Q?aPzFq3zPIAwPDEHdIN95CmXtrUf1UkZt1ta7R0tvbJ/teHa9gLQmRT4GfkEU?=
 =?us-ascii?Q?qb3MgPq4o/6NNh/IqJxi65FtxUrw3kb9aQ/l8QJT50LqJi7f0JjKn6zxgoRC?=
 =?us-ascii?Q?w0DxwYM7RqSuYXh4sYzZoDb41Wow10y5rzDcLTkfUji3T7zT5sVwxWqgG/u0?=
 =?us-ascii?Q?T6ICubd5dM0tiESfMsn3sR2H6PBEJQUQuHT7d58b0njHiYOS6tV4WN/ZG0fH?=
 =?us-ascii?Q?++6RejXgwNxYjHvTbu3+NGjnaI0QLIGRYSCFYHwoqCmOU7nndLWlAVxEAKnB?=
 =?us-ascii?Q?4YmUXvgpxO8CUY1aUpxBStPeuzn3SAq6DKZVHRTu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec36a615-3b3e-443d-3d59-08db76b2e25c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:04:47.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33et0wAQPzbcyKQYTU7JBwGdu3yh+xhVfjUpd610Y4Eg47JjPCrjiW3UeJulo/bjgkv/lW5V/St1ggD6d3n7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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

Please ignore this patch, will send a new one.

Regards,
Lang

On 06/27/ , Lang Yu wrote:
> Rename psp_update_vcn_sram to psp_execute_ucode_loading
> so that other clients can feel free to use it.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  7 ++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  8 +++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +++--
>  7 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index aa69269169a1..33f8b8389979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2931,15 +2931,16 @@ int psp_rlc_autoload_start(struct psp_context *psp)
>  	return ret;
>  }
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
> +int psp_execute_ucode_loading(struct amdgpu_device *adev,
> +			      enum AMDGPU_UCODE_ID ucode_id,
> +			      uint64_t ucode_gpu_addr,
> +			      int ucode_size)
> +{
> +	struct amdgpu_firmware_info ucode = {
> +		.ucode_id = ucode_id,
> +		.mc_addr = ucode_gpu_addr,
> +		.ucode_size = ucode_size,
> +	};
>  
>  	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 2cae0b1a0b8a..93849db18696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -459,8 +459,11 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
>  			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
>  
>  int psp_gpu_reset(struct amdgpu_device *adev);
> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> -			uint64_t cmd_gpu_addr, int cmd_size);
> +
> +int psp_execute_ucode_loading(struct amdgpu_device *adev,
> +			      enum AMDGPU_UCODE_ID ucode_id,
> +			      uint64_t ucode_gpu_addr,
> +			      int ucode_size);
>  
>  int psp_ta_init_shared_buf(struct psp_context *psp,
>  				  struct ta_mem_context *mem_ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index c975aed2f6c7..e89b1e760000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -881,9 +881,10 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>  		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
> +		psp_execute_ucode_loading(adev, AMDGPU_UCODE_ID_VCN0_RAM,
> +			adev->vcn.inst->dpg_sram_gpu_addr,
> +			(uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> +				   (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
>  
>  	/* force RBC into idle state */
>  	rb_bufsz = order_base_2(ring->ring_size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index bb1875f926f1..e5df190a79a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -912,9 +912,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		psp_execute_ucode_loading(adev,
> +			inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
> +			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> +			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> +				   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_dec;
>  	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c8f63b3c6f69..aa3d7439cd34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1037,9 +1037,11 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> +		psp_execute_ucode_loading(adev,
> +			inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
> +			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>  			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +			(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_dec;
>  	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 2db73a964031..d0867526e477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -993,9 +993,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> +		psp_execute_ucode_loading(adev,
> +			inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
> +			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>  			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +				   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5d67b8b8a3d6..221a10f0316f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -778,9 +778,10 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>  		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> +		psp_execute_ucode_loading(adev, AMDGPU_UCODE_ID_VCN0_RAM,
> +			adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
>  			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +				   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>  
> -- 
> 2.25.1
> 
