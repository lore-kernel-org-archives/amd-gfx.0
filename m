Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F4BCA0EC3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 21:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B648210E1E2;
	Mon, 11 Sep 2023 21:47:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1A310E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 21:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIdgSIGMcqtnmCgt6YkIwfQKGJjK+Cm8lm7zdnbWhB+g+CBbsTa1gNV5E4v/A+0DaOzPimkjwdK9VcP3/BH/zsIny3mQaW+hpQPkM9/3ObtCpNxAieo7i21gr10AsixXig1Z+CKxWrMGWVFR2j8gZI+SzDBwP8SVyN1bv6zpH48sU60MOdtUV449U4+jR+7KFmC9qS1uFSR3t+/ruDNHb+eTiu4U8uQq6y1ii3PBM0s7eIgfBrUkUGgWrWuBKaa0NRL93E4+1HQWksJ04kyBq7ZTfOITR5IdcCSX4moyKwr5FVzhgTfb1eJWREI0bOD0PijBNfH6WBnGJ23m2ghr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULBQLdotR55s2RADIfCsotn6DKI3CxR2XQVgoR7QTNY=;
 b=JLDthxazu+GKGS8zM5NR7R4QTcPNu7gQr1SvOerbl9WNtM8oepyKl0k+b1Bi2e4/Izg0tAtXhYehb2O51tFCI7KdEi+NsDxSVWZ4FPE25gPY5Qee/9EywYCiA4I+n5X8Qt9sZcFqaPgm71/IATpx/bJ1iddSIxd1s8iZqoY+v8dd86sAZ4ITvBLxhSn0fZo2VF0SCLo4WS1NGV2MQAwfzTPpTLy6mls1tQNbpJXUhcWFt7trY7tLV71+2OqGhhix4euk+iZzwKGwCSAiWqe8Mu85tfoGifHZQVdCJ2xjx/o+H0mjG8T3wlIGOaLJKnfTxaqACSZB3d7YTKu26sSkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULBQLdotR55s2RADIfCsotn6DKI3CxR2XQVgoR7QTNY=;
 b=Oi1BxwMIA+R6Epfr6l/L0/utGoADhc+sSURMUmOly81rRdDbSYDQcFQxEcKBePrBnjPPnUBwxQTc4OQc8vKocNF9lssL8GvX93ZNBlEtBZoRJYQKp9fmCpoVAiDNlZDjKqDLtXvcfuuW2HmPOPx9n7QilnY9+KhXoK+KwTuvvY0=
Received: from SA9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:20::28)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 21:47:13 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::7d) by SA9PR03CA0023.outlook.office365.com
 (2603:10b6:806:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 21:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 21:47:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 16:47:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add vcn_doorbell_range callback for nbio 7.11
Date: Mon, 11 Sep 2023 17:46:58 -0400
Message-ID: <20230911214659.1074052-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bf1d70-a18c-4393-3854-08dbb310a893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tCG634MWRHSBq80SwOhn+0MJB3dqbzsc0hSGxSjll8oEvF30poWqRCs1OEj6RIIog9j3J0rPy5xgAGl4FY/DR6gX+B4jJs/tEZHnfQB9mrEacjXpGp1tOr81OivPVTFgQI543EKe14nvhxPJwK5hSob97rHiGnq33v35WdSE39lSoiOX8GL9ghtlHt2QKjFyHg8x4LSfD+NgeRy9fxRZHtjWyWZ8ePj4/7fm3rg6qZTk/Pi6CNKwGM5ZPnZjpLybNV0rAnxub+bSsW/WezwFYtvFSS0S+7RxOSVtP3/grpjt7zvUC1FsOdS9HbSbEl1S6mEd+LOUanNXYNfaYGI6tm8HFNiBA64urpYPfzJgWzaCigTNg9kBtuqDAE7Az4DWjoHaDAEwFjgWfX1ICoDMkP7Pmj5z7Q8N55hIIStS87G1bqVbw7PUyHw2CfHmv/sqz+JV18NFZU1kb17vWlbeNEsdCQOAqCdzgzXjF7bMsGl9Nr7B6qOzc38JrZPvu6rusl19meZgNDnEa+mgtgS17NC/NX1shlve5HiJDXC7dO9lqABM4w2jLuUiWcne8uU/kyW1Cg4bvfpA1CAHmNrNpEzi2tT/8nSE6UJqtC5biV/LjDZvqezHC9Z/24kYxu+ZbvFaXFKatloF8JvdixrLMOcODxSnRIMaAqL3PZIXpmZuldcugRIH+Ti+qHQRTw9DOF9SY4l5jeWW/9xZnD7kurf48elPxupLhfP2iDGOkNDRpcsXvYSCKnOpLA33ZstqEDNgG57WzwGul/N9Vlsmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(70206006)(81166007)(356005)(7696005)(6666004)(36756003)(82740400003)(86362001)(40480700001)(47076005)(36860700001)(336012)(1076003)(2616005)(16526019)(26005)(426003)(83380400001)(478600001)(40460700003)(8936002)(4326008)(8676002)(2906002)(41300700001)(316002)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 21:47:13.1501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bf1d70-a18c-4393-3854-08dbb310a893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement support for setting up the VCN doorbell range for
NBIO 7.11.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index a32d9b8ec51b..bcf5fb420fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -100,6 +100,27 @@ static void nbio_v7_11_vpe_doorbell_range(struct amdgpu_device *adev, int instan
 	WREG32_PCIE_PORT(reg, doorbell_range);
 }
 
+static void nbio_v7_11_vcn_doorbell_range(struct amdgpu_device *adev,
+					  bool use_doorbell,
+					  int doorbell_index, int instance)
+{
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VCN0_DOORBELL_RANGE);
+	u32 doorbell_range = RREG32_PCIE_PORT(reg);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 8);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 0);
+	}
+
+	WREG32_PCIE_PORT(reg, doorbell_range);
+}
+
 static void nbio_v7_11_enable_doorbell_aperture(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -256,6 +277,7 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.mc_access_enable = nbio_v7_11_mc_access_enable,
 	.get_memsize = nbio_v7_11_get_memsize,
 	.sdma_doorbell_range = nbio_v7_11_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v7_11_vcn_doorbell_range,
 	.vpe_doorbell_range = nbio_v7_11_vpe_doorbell_range,
 	.enable_doorbell_aperture = nbio_v7_11_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_11_enable_doorbell_selfring_aperture,
-- 
2.41.0

