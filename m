Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A730CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 02:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9801310EC62;
	Tue, 29 Sep 2026 02:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0+IFEu6p";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D2410EC62
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 02:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqzfE2VTERmTHRlkmaCxBhSwTmppN7kXGUyot+U5EhlhGx2yYAZV1C9HZ/iyvuk4VGaZxbmpIQ0nhaZxrXJb4X25wAU10YbVRu49xpBKPcIbHjDMTf1cNoWlqjrlG+h7ymvprl8DFNBiAZj6f6NZTW3Nlpd5Zz9tTv/lJY2fs4j9odKf2cmDOPlVI9j4c3oRJG5nhcEZZOLvYceFI/xK29WOSXcRi9iNt942iY5HAEoXdnkIzc1lbHLJBUfnC+Nfh6hTyvLnkSfl6y7NU+m6USsAAH9SdUIj4e5kRQTc8ZBeKVRS+o2IbNTKlvrXaqvT9c4NXOaUZYDiufI/gqO5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6D5oUiwLUz0lQPCxlLQurIwmTbyS70iB4QnQ0p79bc=;
 b=fC9CZUHNAXWh5Ujk5t3rWBx7NFQjyTOAGZjA9+CKvN88WVusBOdldm1LQom4JD25vOW2MkK0ys6qdrPkVmBHOiAGmhNVpy8/4tC2ABYL6WE7b9zEluB/aKUlqE0SNnz6b34A70NobxWkafzVlQCc3t5JfNBIt7KmIKHhqcNrqlJtrELgXTG5Ri1A4vL79exT0CrfGNCSQPfjSYNm1/TmoVj274dw5zDbyW+SLsaC7fsLQe2cNwu3l85KSW74KJDgRjmoTyxgu8FKSNcWxtLjquI0XPv9BCAN/WGHgPFGI3NOsxocDvgG2r4jWNlgCwm79x8CmTDynwqXcCyxI1cMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6D5oUiwLUz0lQPCxlLQurIwmTbyS70iB4QnQ0p79bc=;
 b=0+IFEu6pq+Lda7ns3jN9d+kkBnE05unB+HWG90IcwSD62uJnNbbiGjVxePO6J2Qhs1qsAkjybQuqXnic6JSM2alTDYxdtoe6MYP9rvFjRnoz/wmTq+EihzoJia9AWkvOzbz2na4dxZrDWC+lC9g7CZpLgEKzJc2KX4u6xezBXc4=
Received: from DS0PR17CA0003.namprd17.prod.outlook.com (2603:10b6:8:191::17)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 02:55:45 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::1d) by DS0PR17CA0003.outlook.office365.com
 (2603:10b6:8:191::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 02:55:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 02:55:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 21:55:43 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Mon, 28 Sep 2026 21:55:42 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip PF-only programming on the VF
Date: Tue, 29 Sep 2026 10:55:42 +0800
Message-ID: <20260929025542.3898711-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
References: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bce0063-b0b2-41fc-eec7-08df1dd527e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qqDPgeke/T5Bv208eR9crDDphKwD5jQFFKGzqmlrgaxC7UM1uvtoyD3IHph5LSCvXq0wzJtJ7nWO2BfJZjYpKn+f6tf39oTguSuk0dVDQbJsoMjtFhw6G2sAzaaXYcwoLA20o65Cv+KsxsXCNeNpNZ8a8LxVmkQG+j3pGwq5cBXwBcGOoGmCcCQi4PE0OrLJj3/nThA82O8vP/jsyWR3OpM1VC7HDa+y5fkcvcsPR9Kzkp4vICZz7QHSJdbYRkAkF9HbpApv8HI0+WRh3Xu1wfqRPo6Obg+Iiemb0H8TLJGc2t1B+uIN3prIhnj0A5nD8u9Xevaz5VQVwAbSDOXuVrQUxtMA1gZcSQzpBnzaExcY/bq8e3JnWV83GhiMc6IWcIOuMpdpyWE5yGyjBYRzrSbbHGM0PQycjxEHgl+ctAs638W+gtumc5IrxXLbnXkoaVc+opUKmmfQxSgDQd0yIS9R1WLMYhCR6S3uWiUlyEflcUKh4OASes9QFunzNjOYQyusW7DsYegqmqFdp++Zu/F+1cDHS1Q+Pa4mOjpMlH0PAGcp15EM490cwu/Q+ghyzDJylcPUnbj3j8gD3H5T50qxQsRomjmmoG49hWXuFApp7dMX9NdKJ2sJOHY1EQ4vsuG2gZRVj1eKapwEqr9Nx0zMMux9r0/1cNWs2GMioQ+FgXUxdjyFnDoYbNIPliUVQGhkhqXOi16u5eJkdoKvdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a28zbVoXscJD0ZSSZG2FouQ5yZunPqoR5XAbfRbN5uEkeL5m3CC+26i46/1/AYq85iqD9v7p9CJV0m9wwr4gkGM7d+G0duC9bwnzydb2MxKipysEcvVmhzsM88BDbTn3gE4ViOM6/Mjj/3kt0D6i01wMjJL/3UJ/5GZpWLfcRMFUrcItZXsdLJdlG1r57kWBKPXVGAA5UcIILj3s4Hz+Pkzz9Cz0j77p34C/U8+R6bv/LYmaLLi7YRToy7bRzkCnCfoWXOOAS8AGAhuy/Jg4VYtK7onEmUDaTXZZuQ/x9ryVbkCjXHILf5rSzgM4WL8fJdvOIKwP0iNkLpR7UKA4bVz+OR3A+KDKdS+ZWBAmZ1sXJp14Sj0T9ijmlB2bI5x7+9HWTONHUTjNiW9gzLxNq41dZ9v44B89FBG7LM1ezCJta4sdZzsyP5sko+O15PyO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:55:44.3630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bce0063-b0b2-41fc-eec7-08df1dd527e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

Ping.

On Thu, Sep 24, 2026 at 07:01:28 UTC, YuBiao Wang wrote:
> Golden register init, the SDMA RB command switch setup, the GFXHUB
> L2 protection fault controls and the guest-side FB_LOCATION programming
> all touch registers a VF does not own, so leave them to the PF.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Acked-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 24 +++--------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c    |  3 ++-
>  3 files changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index db541939555b..4f6eac30b235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2665,7 +2665,8 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	gfx_v12_1_init_golden_registers(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		gfx_v12_1_init_golden_registers(adev);
>  
>  	gfx_v12_1_constants_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index 7fa451b373fc..b13967a1c8fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -482,27 +482,6 @@ static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
>  static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
>  					uint32_t xcc_mask)
>  {
> -	uint32_t i;
> -
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
> -		 * VBIO post does not program them at boot up phase
> -		 * Need driver to program them from guest side */
> -		for_each_inst(i, xcc_mask) {
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_BASE_LO32,
> -				     lower_32_bits(adev->gmc.vram_start >> 24));
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_BASE_HI32,
> -				     upper_32_bits(adev->gmc.vram_start >> 24));
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_TOP_LO32,
> -				     lower_32_bits(adev->gmc.vram_end >> 24));
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_TOP_HI32,
> -				     upper_32_bits(adev->gmc.vram_end >> 24));
> -		}
> -	}
>  	/* GART Enable. */
>  	gfxhub_v12_1_xcc_init_gart_aperture_regs(adev, xcc_mask);
>  	gfxhub_v12_1_xcc_init_system_aperture_regs(adev, xcc_mask);
> @@ -576,6 +555,9 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
>  	u32 tmp;
>  	int i;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	for_each_inst(i, xcc_mask) {
>  		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
>  				   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index 321c67e01443..d1e09acc684a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1397,7 +1397,8 @@ static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
>  
>  	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
>  
> -	sdma_v7_1_rb_cmd_switch(adev, inst_mask);
> +	if (!amdgpu_sriov_vf(adev))
> +		sdma_v7_1_rb_cmd_switch(adev, inst_mask);
>  
>  	r = sdma_v7_1_inst_start(adev, inst_mask);
>  	if (r)
