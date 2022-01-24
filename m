Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC985C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1B310EBEB;
	Mon, 24 Jan 2022 07:29:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD7E510EBEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6cB50pYEMfdCZY1pyCK/igt1NS9Ct1ZNRNgEEMWiOu5boBQrQrUdf5IfoZRQHth5MlB6QJL98tXSzegmkPa/ScGGsD1mLQ3xc80ahXEl1HCkgEd5f4oshRE1ioYl0bnvtfDG7PSQe9IAGMImH+FIrG9cx7JD8j8WhVZXx4Xsi4EAAz8eqwkkf9dW8Wamw2Dyb+Ap/1bODFtuJXd3Ai9yR/jR3/s5STDkeDtbV4heKGDztPlT0yuxSy62+OJQToh+viAyHPAPP2ExuOhFwugiNzta9myYwP4Cqk4q/wCxf9WMXGOhBqwkxZ+bCIH5+9i5BlXnMQOQ5DBdzkOMSFqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw5XsBUfoB5sqvKtfU0+K7MmizKVSggk83GBujaZziI=;
 b=ItUCSjlYs2ezJvgy6Y4rF51NV1b4jjgAK8RS2FfxcrY0QDhMIrbf7laW2Kesr1vyfLXdkzBI1pvj4do4QLguiEB1DL34jDh0PTlPXcryynbF25GmtuOqdwBm9PfKmDJ1FShFibxy24ApK5Uxxa5jDQ96kba7Ik8EkAf3mq7Z3LmilkO8I22HbvGzP5Jc/Yjsce7iGj7qTRyMSYsIZ6mDNY9wCXbMmcNZzNHUuzcEANdktXA6zmCOiEl1hQFzSNSt8odml1+qcWmrsWXHgEjbULCchoTLw7aJds/gjDxybvhL18xbbL8dONGp5uW6LDMPBScIbq6DmH5aKo0AX43XjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw5XsBUfoB5sqvKtfU0+K7MmizKVSggk83GBujaZziI=;
 b=49UHdUcPRglrqzAu47+p4rDPq8dDT+OZl8A93/X97TqswiRDKn7FnUoYVQrU6htSZ98ycJzLL8jGaRihmuPCPvmukhm+BS49YOTnx28/LalTuo47HIQZvd+q6CIv6DEjwO6CWdnF1iniI6U7PsRLZel8+6cpDuB7QrX/ofblHpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Mon, 24 Jan 2022 07:29:13 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:29:13 +0000
Date: Mon, 24 Jan 2022 15:28:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: convert to NBIO IP version checking
Message-ID: <Ye5VNSn8Rh8osQ09@amd.com>
References: <20220124032042.1974371-1-xiaohu.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124032042.1974371-1-xiaohu.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a80952ab-2431-4330-6cd5-08d9df0b3818
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43498D87017161194A044745EC5E9@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1H12vlZg7F25nzneSP2DgMEx540y3ysTbUrTkVd8jnHVkxxuYCjxfXuKxLk9yfnK+KkzM+L/yHgw9hw1218GB1NRjEfIBL/WJIlrlo0JpAVs9i70sqlak9hfM9ECUnafWgYTTuJtVANd1exBomWH/T8QFazIRCtEbj8yMGcarWcFxcjO4vZ+ueqbCBKqrFQcAiXSUoJylC1NyVJ/GCwKObTimgez2pGEvokHsxD8soSobZlX8jSdO+BFd4L/NJI9RiDDVUeivPGVIp8G0YbWbESqWGXMPMS8ximQBz1s/BOA3XfS8c7XDfk4HiYVXsFZTlCy8DX9yaEBkvqakQy54kM9FScbpOvc4A5dVbEPIGuA9WwmuADC/nsaBej2loGyvYZP3PQs+XtEo5OY4OFVRSisGB6mX/zIiCjXSR3rgqhhaY26pgK7xuoGikFVaJ/busB8806gM7/jmtl1rT7t3wmlWWNSp/54W68APzX5cuEPbcMZCjf8y27E/cCinbbeibZurI80X4cO6bsL5Ub/HQH+9rwh6p77P+q54RK7ZBdpRv00LZZ8As4/5zbdUdD7dwOGmB/YoWNbrtLOHWUSoaxvLYIoV4b4b7XagoVAj2+WNrM2IbHijqAecE/ofMNOfRWa+IHeGx27trtKPrWRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(26005)(6666004)(8936002)(2906002)(6636002)(8676002)(38100700002)(6506007)(83380400001)(6862004)(316002)(36756003)(37006003)(5660300002)(6512007)(2616005)(54906003)(66946007)(508600001)(4326008)(6486002)(66476007)(66556008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3GTmQq3xU1ULix7eC0XBmao3mLDOquXRNKAT7MZQLJBmTtzb+18GVNndXZv?=
 =?us-ascii?Q?SJstvTADqal7TRqJf5bJLlOYP7Y0WiV7ea5LfNqH/d8MAg9bdgAo5rCPlqw2?=
 =?us-ascii?Q?SNL4b1sxOGE+PMJzOnYzGcjc/ovhep0cOaJgqzH5hvj4vpm8B6zz/X2uW7tV?=
 =?us-ascii?Q?rFYoMouI6nyS0KEcKONjZBAvIdOgBQmT4M3AyUNhsn2CC4dUin6Ij6GrwOfN?=
 =?us-ascii?Q?fMUX+sxagneVD9W2eBypzs/jeqxnU9Pv+MxYyIDmgNz28O9KvPWPviRQdUu5?=
 =?us-ascii?Q?s4B5EU9J3bxpRywXla8L/8l3TxN692my6qGZDk7+QRGIba5gxY9niu9kNi0w?=
 =?us-ascii?Q?z70GeU53eiQw4J8R5Dd2+VmaC80BWisb61cZsQXSq4ObCz5irSljUIFE+vZa?=
 =?us-ascii?Q?8C8yDVvBkPBWzvgqUi9BU7PLmqeRCm+k58Oo+ucFfNg5mFWqcMMyg044D/pn?=
 =?us-ascii?Q?6f4YqFvkba80rDk//ZQpfLd6MtzFsZWj+9vNnOlf4Q8LBjORBWDwoXcQgNOS?=
 =?us-ascii?Q?4qvIT+dhB8JjQhK5qK1cu+faLzO4gD7EgxJFftoRAEgI9IVsGWES2vM8UzXg?=
 =?us-ascii?Q?lI4fiTNelkKBNNk4bNt/g9KyRG1UWyWqtZRNKqcSNcA/3DTOY7fFgNAW5XP/?=
 =?us-ascii?Q?J0J484WbhfKIYeInP4xh06IOl6S0DVUWXu+Gc2SPenfDW/4FHFEZNn7Id2ev?=
 =?us-ascii?Q?7RDcjoirRah9EAvA5Wm55qIT3rRolo12QcZl8e/j7jpG5IMgPe1WK1I2FGhQ?=
 =?us-ascii?Q?1qZIaVzYbu19Tt13Wlxb35jZxmH91bai3OQ/yvAVoWNBMfz1t7zvEN1TBCYX?=
 =?us-ascii?Q?hLEFylQbVQ0UBZWIzzOkB4iZk3IwXKvANIT68siV34ZwdYKFjIMWfodi1N2V?=
 =?us-ascii?Q?BS/FTcieKQX3WyzymWZ4PANFA1Pb1h0hw0+++PP5BX09x68UYGJUP9N1gKhr?=
 =?us-ascii?Q?8Rba95uUmEm0TzbzT7oOfcNnAE02eIaq4eSZpWOJ+Zq1vYDOLrh2mAGpe/AF?=
 =?us-ascii?Q?3RBZzwmPPY9PjC/imdwxgjRlxHNWDjyDWYa9hEWcbYXqNgkSh5SgabICIEsQ?=
 =?us-ascii?Q?MEAMTYXsbdYcxq0XkBDE/i68bamK4umpGCIwCXTO64ApOSPSZb5uyqVIbekl?=
 =?us-ascii?Q?AaHK/BrknZurPo3oQMycQ5SGLolon4MQBhsM42xVlGbyC/5m+A9oF/hOllFf?=
 =?us-ascii?Q?WvdjpoTLvp7Gup2TVuEOyWD7uErTMgAKT0KcyuT+gACf5P4n/m/e8ecMnbtH?=
 =?us-ascii?Q?dvtLrMh3ihQH5PxOMi/tNLGG8rxQzEl0c1SZXorxgp3VE3jA+sMFZc0iS9i1?=
 =?us-ascii?Q?9JoGMPVVXC4p9+xPXTPIjvI8jZlga3uXwBC9A5Bm0Ixh9Df2MszPzJ15MRyL?=
 =?us-ascii?Q?orh8jf8fKMR/s6lef4eETNwPwfYLj/GRivjYEgFRnxaCq9XuHwU65k9XPTIM?=
 =?us-ascii?Q?Jt9pVSjZABabYuZOjXPIjWvgbiEuIEKtlhI32Xm7W/ZRBCMq4bNiXKATt5zP?=
 =?us-ascii?Q?zlU+/LRvqw9SGw5brG8pQtQuEFlHSR5wZ4D9T82KtWYlE3/UkQWMMvMhW6p4?=
 =?us-ascii?Q?kFTg4vc6hHVI26i/9ODxa25JU4E3Ir1mLL8Uidi2rfT7dNjRLa5My7d+KHg9?=
 =?us-ascii?Q?0RhsgdXBAjrHw+45PHiQFMU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80952ab-2431-4330-6cd5-08d9df0b3818
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:29:12.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Roe+EgOkt6fqWyl6QyzttCJrtYfPAyN//wcOCcSqK/m/GBH+95sMCVPgtK7MQzPkH5fwBpgoh6n4061SJtUVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 11:20:40AM +0800, Huang, Tim wrote:
> Use IP versions rather than asic_type to differentiate IP version specific features.
> 
> Signed-off-by: Tim Huang <xiaohu.huang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 48 ++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index 3444332ea110..70e341d884d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -59,10 +59,15 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
>  {
>  	u32 tmp;
>  
> -	if (adev->asic_type == CHIP_YELLOW_CARP)
> +	switch (adev->ip_versions[NBIO_HWIP][0]) {
> +	case IP_VERSION(7, 2, 1):
> +	case IP_VERSION(7, 5, 0):
>  		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_YC);
> -	else
> +		break;
> +	default:
>  		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
> +		break;
> +	}
>  
>  	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
>  	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
> @@ -72,20 +77,25 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
>  
>  static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
>  {
> -	if (enable)
> -		if (adev->asic_type == CHIP_YELLOW_CARP)
> +	switch (adev->ip_versions[NBIO_HWIP][0]) {
> +	case IP_VERSION(7, 2, 1):
> +	case IP_VERSION(7, 5, 0):
> +		if (enable)
>  			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC,
>  				BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
>  				BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
>  		else
> +			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC, 0);
> +	break;
> +	default:
> +		if (enable)
>  			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
>  				BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
>  				BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
> -	else
> -		if (adev->asic_type == CHIP_YELLOW_CARP)
> -			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC, 0);
>  		else
>  			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
> +		break;
> +	}
>  }
>  
>  static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
> @@ -249,8 +259,10 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>  						      bool enable)
>  {
>  	uint32_t def, data;
> -
> -	if (adev->asic_type == CHIP_YELLOW_CARP) {
> +	
> +	switch (adev->ip_versions[NBIO_HWIP][0]) {
> +	case IP_VERSION(7, 2, 1):
> +	case IP_VERSION(7, 5, 0):
>  		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
>  		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
>  			data |= PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
> @@ -260,8 +272,8 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>  		if (def != data)
>  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
>  
> -		data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_TX_POWER_CTRL_1));
> -		def = data;
> +		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, 
> +			regBIF1_PCIE_TX_POWER_CTRL_1));
>  		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
>  			data |= (BIF1_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
>  				BIF1_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
> @@ -272,7 +284,8 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>  		if (def != data)
>  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_TX_POWER_CTRL_1),
>  				data);
> -	} else {
> +		break;
> +	default:
>  		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
>  		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
>  			data |= (PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
> @@ -285,6 +298,8 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>  
>  		if (def != data)
>  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
> +
> +		break;
>  	}
>  }
>  
> @@ -352,7 +367,9 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg = {
>  static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>  {
>  	uint32_t def, data;
> -	if (adev->asic_type == CHIP_YELLOW_CARP) {
> +	switch (adev->ip_versions[NBIO_HWIP][0]) {
> +	case IP_VERSION(7, 2, 1):
> +	case IP_VERSION(7, 5, 0):
>  		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3));
>  		data = REG_SET_FIELD(data, BIF1_PCIE_MST_CTRL_3,
>  			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
> @@ -361,7 +378,8 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>  
>  		if (def != data)
>  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
> -	} else {
> +		break;
> +	default:
>  		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
>  		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
>  			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
> @@ -370,6 +388,8 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>  
>  		if (def != data)
>  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
> +
> +		break;
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))
> -- 
> 2.25.1
> 
