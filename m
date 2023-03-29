Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E449C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E0F10EC38;
	Wed, 29 Mar 2023 20:14:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD16E10EC32
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec3eltP1HXcqO1/FifyaocfsAX8Sr+6isO4BCxkd+DyJ4TAP8TeJcIFBWaEwL2f53QEtnrbAGkbWFtcpUJr2IFaTH9/PNsu6a3QskDq4yGNcW3BwzAbaC3vs57UFvu4yt0LkJm6zdYvjRpZs0tA9CuV4s/XJJvHMS20LV4Q/ZAEEx+wTQeE8DmieSjA+FE483J0c+1IpmsjSMOxLDBzGpIwrPctj2o6K5JaBlY9KD7UBS033nwe2F6CPd5Pu5DdsWRpoyioFOZXJxSx5+Rd+mBcsd8ZEz8O3N4hAj8Cl4zvD2gZgFAMbl2r23Ia+F+ICCp0EZqdbvf1WXx8072U08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PXqASK2OZ5rrhoVONA8NNnue8WGwxVtqCtO2DD0vrM=;
 b=eB2j8WqIyt4JnkJfDcOnvZ2Gx5APUxR5Tj+0syspf2Lto57eVvNgAuTuVNZ9AgZLqfvwlBqbIWM6p0TSbVHiR6yTbGT+sg22YEJ8wRAhVycC8Zknf6rsd6ZPUVOOcU2WE3X5ms98Gi1uJ0BOWXUkPIh6AFprVWmNMXUe7C9ZYjorKpHhmj87KbaWC/Gcx4yng8BYNInFUz+UZpYiX9jRQHJJ/U3oUfO89BrpP0HyOzEiOL1zc95EmbZh7IQEz4zH2CrJ4ICUruNjxBV6i5Y9nwq3dAbQPHUn8CTgLbjtTuGgDExpiBtqcYuYbXCcfOks4GahTTPZXqJ9He8ETmPhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PXqASK2OZ5rrhoVONA8NNnue8WGwxVtqCtO2DD0vrM=;
 b=BGWWisWwGYRiSdUB7MrLOjQPhqAUgmXVNUBQiJiet4+S8eilQ1RJTisifTMjE+I3YuEbPgYfTjZcYTldEhJnthPqc/OfrBowHgAZSxZnaeoAPINMoYPBZy99aKr8msM5yXoGvgWdlsSqYrY+Tp1zl1SfpF2+Y9d1NBh27O0LchE=
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 20:14:45 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::7f) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Wed, 29 Mar 2023 20:14:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amdgpu: Use status register for partition mode
Date: Wed, 29 Mar 2023 16:14:15 -0400
Message-ID: <20230329201426.1982669-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd2ce2d-a429-445f-fbba-08db30923d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxyONY+c1sbmBVppRgBuTEglWqAT8zCTSWqCvDx1pzK6TL/jY5LYFobg+Rk+81zXkZ4gA11PSydx5MPdTbY31tSPSmqo9Ea3F2E7mER/Kqrk9eQSh7Pxg2NQikDgtEfnO4fb0ulx3eEELjEt8+p4qECacv6SW3M/Qa/wdGBrZAjzyRwA8BZ3VpFEOjWsjehfwKS/k/qpEqbJJP1mE04zAa92j2t4asNhaFAlITpfAIm90Wutl0WZDKIJnEjEdw+Rds0vBu+DPIju1yDfuE8UVoGDPRfW4bF2vZZC9guJYfvQIw+qXU7KuZsmvpMK8WNhnxGOMqNNvoN1rsBTGBFym8iGoLWP7tsLFOCJB8wG0iBXSu9Jfxge7WruAEVMX96VaRx5t7Wsjuv9GVcRQNDcB+WPz/WUUfLYF2WZ2zO936MT8bexi+SFbfKqZV71KN+sTzFHWZNF+sTNLP3Kn3ixngWWIA5lOePpKEIT8GGzjI5Sx6LdoyOwaP++hcArmskoKRvu8fM0doam6UaKzfwzy93BBGDPoaJi0ZGrbuGw+0DKVxa6yrqXiVNyBdDMba9dVhZ9gDOvNJiPF8Jh7XOqWUqzRXkGuLLzyBUsyeWdGT31nQQm+cCSNtHkoJMvBmlaJu1A4UxCGDDwhAdo2fRognLQpLDuYs7R+ZMkIvPRIEb5SXuIg0Lxr93D5jh3D4d4Og7eA72MI/KOPn00CGC0cmlfjwvIWVgIUSAbopkJDp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(316002)(70206006)(36756003)(70586007)(186003)(40480700001)(26005)(16526019)(1076003)(40460700003)(6666004)(82740400003)(36860700001)(2616005)(336012)(47076005)(83380400001)(426003)(478600001)(356005)(81166007)(7696005)(82310400005)(5660300002)(2906002)(41300700001)(4326008)(6916009)(8676002)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:45.3333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd2ce2d-a429-445f-fbba-08db30923d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Program partition status register to reflect the current partition mode.
Partition capability register is for capability and is a one-time setting.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 28 +++++++++++---------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index b3e1eefe260d..08819e4edd90 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -418,20 +418,13 @@ static void nbio_v7_9_enable_doorbell_interrupt(struct amdgpu_device *adev,
 
 static enum amdgpu_gfx_partition nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 {
-	u32 tmp;
+	u32 tmp, px;
 
-	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_CAP);
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
+	px = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
+			   PARTITION_MODE);
 
-	if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, SPX_SUPPORT))
-		return AMDGPU_SPX_PARTITION_MODE;
-	else if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, DPX_SUPPORT))
-		return AMDGPU_DPX_PARTITION_MODE;
-	else if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, TPX_SUPPORT))
-		return AMDGPU_TPX_PARTITION_MODE;
-	else if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, CPX_SUPPORT))
-		return AMDGPU_CPX_PARTITION_MODE;
-	else
-		return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	return ffs(px);
 }
 
 static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
@@ -439,11 +432,14 @@ static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_CAP);
-	tmp &= ~0x1f;
-	tmp |= 1 << mode;
+	/* Each bit represents DPX,TPX,QPX,CPX mode. No bit set means default
+	 * SPX mode.
+	 */
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
+	tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
+			    PARTITION_MODE, mode ? BIT(mode - 1) : mode);
 
-	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_CAP, tmp);
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
-- 
2.39.2

