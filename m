Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA54C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A3010E938;
	Tue, 28 Mar 2023 15:21:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE61A10E41A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8pRctxLwzaK0jmY4a8mq+WFlz65AyQULjaUgMgbYB75FoExtjbg82MFAVIAZqGjVzOp0oIT7fS/6njDUjDrk+TKFV1pywt9MqDie0mDbEtmYFS9gD4WFHes7pgjKdjHzdpGMwRINyt1GtMVkhRNTxUN9v38GuQwn3tF1icJt6UjQkQT3dWh+DAn2SpVdmDnTjUcTwhJuF70z7/3zu/IpXgGGfR2BuJwmwfHV3CitJ+RH7Jf9zQGfKNmBKmEQiYijsfA79fCyrfrZrvoHdMJoST8+7N5KVSLSkeqDAbbU3VvnelTmAWZgr6lFSPZVcO+jjM0PeKWhswOlL55yY/p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDxiQLweJWPcz48Uroleo0W4v6WB+BRL57MdABF/V0k=;
 b=C5zLakx3er06sMXH5nzLLpc4FGA7GEyReB+S+1pI4fvGTTzVm5N2PJDmanUxBfUUQjjr2fx7Dzlf5cq3HJjBhF26RIJDkdrAl1Mp/HoeCGKt4xdKKr0qKP+BB/o635lVN0WCB34KEz6JcdGfOPhAD0T9Nnqa9Rm4v/QEByqwM6OK2cRydSO80HQptySRf0drKkku8u1uk/me7dWzf9mlVfYgCf2bQtgkAe4U9VR2vjb9SG1CUT/0cofQUWbObTVrvAKHuzeKzsM3pYxshFqSN5qOzwhAbUej2A3f6UlHHxHxgIbECH71JytN1AMBHlm1vMOh9w2UoVY4HqElPhd47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDxiQLweJWPcz48Uroleo0W4v6WB+BRL57MdABF/V0k=;
 b=ONSXBVyTe6d/07vZ+YUAxl9ydqjleO1It3Jiq2jdsJVBXAL+dv1qOcl8x3TSygfSLcGIZPlYBj5uD/jm1miw29VuZDSsb+hnAz67MU1aG7AbH4v/HxXuh/ZLzIBaAwJmdQlem3RJ9ck+ryER3E7rBQftiniG4SI4w2yZi0ZtRTA=
Received: from DM6PR07CA0126.namprd07.prod.outlook.com (2603:10b6:5:330::9) by
 MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.31; Tue, 28 Mar 2023 15:21:02 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::13) by DM6PR07CA0126.outlook.office365.com
 (2603:10b6:5:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.29 via Frontend Transport; Tue, 28 Mar 2023 15:21:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu/vcn: remove unused code
Date: Tue, 28 Mar 2023 11:20:35 -0400
Message-ID: <20230328152036.1934902-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328152036.1934902-1-alexander.deucher@amd.com>
References: <20230328152036.1934902-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1c3831-5a82-43f5-9094-08db2fa00a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MehZYudYcMLoAF80A/E8GjZ+HDyDMCx3XO6r83QxKOEUG9rZdBko0p3vlsoijELoqn2qfTDzY2Jb82EnnuDUJvdeOOL+VgcpQUOX3RRm2bC+a6uxalBX2SWaVXyQi2og5a1v+K0VWlT1vx2jZGwuvF9fA0YKhnu5DhaUuufSxcJN1MvrhY5reltNaE2lyjl475j4tb+eaXjocdIiEZwwmgBALS+7HERBwV1xs0GIqmiFL1VCkd6JQa3HnTgSxxFZfz81bLxAXZ4rrlvagKzG28cuqJ1wf/J+gWPG8ykziVyl1BJ7HchbTL+NzN8me6vYkxW2iqsfGgoY3r5y8FcHHYh3LJ8T1wBem6cuTFOAPgbgvQuPyspQv5tDrXwreijGnnks2FrEoWbkURw8TiM4ynlsdu8JBonWhIIHabtKWWocjcDk4Y48pvJzWAJISBz/tt/1vgTQ2pjQIGRteW7nByDKEO7l0CaNVt3MVGMMefe9nVXzfcX14WTjpSEf6cAFZodsYk4x9INY8R77dx/j2/jCrmL7CacZR+UWxS6XTzrNgPJ4xt7tKeMCs7MyRA6ExcX/BzGAATH8zli2uxlxrxOWmOmXEGhY1NHbQ3GK8LY6/d9HOgZ4VLnqUboIJWobi8q2cqbQf+0B0IHXiZWvqQdK4YyyKQd0sJVYFW+wizaVXEp82lyLRT8uGgAiu0PEvASSLKZFNqGcW/gGNPIcF6SoG7utt2QoZo/i5O/7ugM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82310400005)(478600001)(40480700001)(40460700003)(54906003)(316002)(7696005)(70206006)(70586007)(4326008)(82740400003)(8676002)(36860700001)(41300700001)(6666004)(1076003)(26005)(16526019)(186003)(47076005)(336012)(426003)(2616005)(83380400001)(6916009)(2906002)(356005)(8936002)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:02.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1c3831-5a82-43f5-9094-08db2fa00a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Remove unused code.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 121 ------------------------
 1 file changed, 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5eaaac531ab6..93c18fd7de77 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -416,117 +416,6 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indir
 		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
-/**
- * vcn_v4_0_disable_static_power_gating - disable VCN static power gating
- *
- * @adev: amdgpu_device pointer
- *
- * Disable static power gating for VCN block
- */
-static void vcn_v4_0_3_disable_static_power_gating(struct amdgpu_device *adev)
-{
-	uint32_t data = 0;
-
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDS_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDLM_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDF_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTC_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDB_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTA_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTD_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDAB_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTB_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
-
-		WREG32_SOC15(VCN, 0, regUVD_PGFSM_CONFIG, data);
-		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDM_UVDU_UVDLM_PWR_ON_3_0, 0x3F3FFFFF);
-	} else {
-		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDS_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDLM_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDF_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDTC_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDB_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDTA_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDTD_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDAB_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDTB_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
-			| 1 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
-
-		WREG32_SOC15(VCN, 0, regUVD_PGFSM_CONFIG, data);
-		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_PGFSM_STATUS, 0,  0x3F3FFFFF);
-	}
-
-	data = RREG32_SOC15(VCN, 0, regUVD_POWER_STATUS);
-	data &= ~0x103;
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		data |= UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON |
-			UVD_POWER_STATUS__UVD_PG_EN_MASK;
-
-	WREG32_SOC15(VCN, 0, regUVD_POWER_STATUS, data);
-}
-
-/**
- * vcn_v4_0_3_enable_static_power_gating - enable VCN static power gating
- *
- * @adev: amdgpu_device pointer
- *
- * Enable static power gating for VCN block
- */
-static void vcn_v4_0_3_enable_static_power_gating(struct amdgpu_device *adev)
-{
-	uint32_t data;
-
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		/* Before power off, this indicator has to be turned on */
-		data = RREG32_SOC15(VCN, 0, regUVD_POWER_STATUS);
-		data &= ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK;
-		data |= UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF;
-		WREG32_SOC15(VCN, 0, regUVD_POWER_STATUS, data);
-
-		data = (2 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDS_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDF_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTC_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDB_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTA_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDLM_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTD_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDAB_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDTB_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
-			| 2 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
-		WREG32_SOC15(VCN, 0, regUVD_PGFSM_CONFIG, data);
-
-		data = (2 << UVD_PGFSM_STATUS__UVDM_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDS_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDF_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDTC_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDB_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDTA_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDLM_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDTD_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDTE_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDE_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDAB_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDTB_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDNA_PWR_STATUS__SHIFT
-			| 2 << UVD_PGFSM_STATUS__UVDNB_PWR_STATUS__SHIFT);
-		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_PGFSM_STATUS, data, 0x3F3FFFFF);
-	}
-}
-
 /**
  * vcn_v4_0_3_disable_clock_gating - disable VCN clock gating
  *
@@ -869,9 +758,6 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v4_0_3_start_dpg_mode(adev, adev->vcn.indirect_sram);
 
-	/* disable VCN power gating */
-	vcn_v4_0_3_disable_static_power_gating(adev);
-
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, 0, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, 0, regUVD_STATUS, tmp);
@@ -1119,19 +1005,12 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
 	WREG32_SOC15(VCN, 0, regUVD_SOFT_RESET, tmp);
 
-	tmp = RREG32_SOC15(VCN, 0, regUVD_VCPU_CNTL);
-	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
-	WREG32_SOC15(VCN, 0, regUVD_SOFT_RESET, tmp);
-
 	/* clear VCN status */
 	WREG32_SOC15(VCN, 0, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
 	vcn_v4_0_3_enable_clock_gating(adev);
 
-	/* enable VCN power gating */
-	vcn_v4_0_3_enable_static_power_gating(adev);
-
 Done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_uvd(adev, false);
-- 
2.39.2

