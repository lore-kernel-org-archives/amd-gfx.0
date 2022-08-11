Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77741C19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B6C18A774;
	Thu, 11 Aug 2022 04:59:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0294C11AA76
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvDNULxJnuhNAbMH6FT2JK/my+cU18L62SBwBvxsi2oBvOoXSxT18kZcjDBVuy1EVdAQs0XMZ6T/cwVAV6t944kuM7LNiMFxv9T2xf9UJUtg+q2paZj34Ukia6ETcZaFaI3IB8wmanH9tLj00acixrCpbTmqUA2z5nrdIaCfxr3OV5Kld4pL7mJ6lMMDGhCXUEDFbTuFninuH0f4MsZcXZu1SWQdTYIkdmkVB0eb6OPk/VfBQw76U6Ct8wKf1pgJpn7jBORiqwsDGRk9rZNuGtknieLXtv7+7NvGWpmR2YNuwwpuSrKaw6OBu69yFZuEeJB8onsXxW1U/TGCfaY6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO6VGN+Bcx4B/+3LrfNM4mKQy4EJPVuXIltEl3BF2L4=;
 b=kpqwqzU8YJ26zStkKD64eRFQORThBDF2dgNe0RaPrNldCPwsTtfBVIR65Lb8EN0jsUcQPjqpriADib3v4eZ/E0UpyZ92MsrT8CDFDyHnuOaZRzA9l7HIONE6UvvN4PmUDoTyR+YQspgH+ScGbEAAbGS2TlOfD7gN8p16QUINMojhaQSrNhVX5x4Ch0OHq9PQBLRmcmrAX2inTAEm0jXtySQtUvKaXIJvR+C0Buid4xBBsfFXeVnGHni4Ro/EwW7hDH6T+OQFhlxCI4Lh1cw7ahMapd+I38JLYtyd45w8jEiDQtS8BZvg4uN4xdussefXv+iK1SvHVmOBcHz7xlvVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO6VGN+Bcx4B/+3LrfNM4mKQy4EJPVuXIltEl3BF2L4=;
 b=YhxhTydsh6lTvnfOZcUMbczXogIiJrFrKWWoDnLh4j5DzIsSalNasfDyfg3x0KGzCocREfDBr9+N+vbL8MFLmn4zJuUS7xlu5ZLGXEbyR8o9KRimIJP598+AyqKKfvyR1X1g9H1Qcqc4/5ZVAGD+hegXif78M4FFtx5+hcjdckI=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 04:58:45 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::51) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:45 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:41 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: add HDP IP v5.2.1 Clock Gating support
Date: Thu, 11 Aug 2022 12:58:00 +0800
Message-ID: <20220811045804.3750344-3-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811045804.3750344-1-tim.huang@amd.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63028532-0d1c-4be9-430a-08da7b562b7f
X-MS-TrafficTypeDiagnostic: MW6PR12MB7070:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v0rRjXMizqlFc18b4sViwSIWkWR7WplYITk6Nue+xKwLfeZODF1KRIZXGS7tRdaFD4rEjj3g/v/FaOQ3QEG2nWn8/s+kigYQYTtxvCIZFzhVB4+t3Jc3ie9ype+UstOumjYL+7XsKg0jGBWaWHGzSfu3xu5OjmLbFOvhGrwS+SH52Yr1+MyeG1XVbXc0YtcC771kBySBUoGZsjdnqrjUH+Y2dEwmFb7ZUJ5Guc3ud425cs489aCoseHn6cMXGQAvO1+qTyJLDJVmeXrXOPJjULszZHu5/AEwJpPBxNYKxUC7LZ5gRB+2iXYCxelAcn7U6G6bLL+f/1PKzCxhc1pl5si59wZoI2z6deDgSjnBfI9JALIip/eudaqULPU7vN86omHsnjLwld+DwVmxldZNGIowo1u+AF8wBUTUqGJqhrPSjo5elfTDr7TT1PYoIxe9UXiQ34Lui5y+XZ+WcwtZc41BqeTwfugM3/dn/5sN3ekiyhU81Lg60YwNEe89MLftYJck3HPAmSDIZlAFnRiD1E/C4ixf26svf65JDjxnXRTXY+poff7Y68K1SzebwK1n5ntsjmpQzqL+otzWb7lyhslD/mrmxbY0kxaRzGb9Tn2TL+SRo5IJy8owP+P/9s3Qg1QrW3S5o87z27cwjCqAlzGCCA7QTQ5y+3P9ZfhlMs8eGcGwLTTP4+mdCuLce5QIzSHnvkJtSKR5GCFRQGVkSA1J7wre6GX3+wgF0tv1lqT/4Nc7fQhlni3HQRRCten3yT+LhiiJ6TSKT/nBOgFXM78YkKnL2RMaJuOJZ3nvVs4YASLZK+9kZfc6uRm8sQ0H96/bm7IoBujMyNjn8vciw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(478600001)(44832011)(5660300002)(70206006)(70586007)(2906002)(82740400003)(81166007)(8936002)(356005)(8676002)(36860700001)(26005)(7696005)(6666004)(36756003)(40480700001)(47076005)(16526019)(2616005)(1076003)(426003)(336012)(186003)(40460700003)(86362001)(41300700001)(54906003)(6916009)(316002)(4326008)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:45.0854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63028532-0d1c-4be9-430a-08da7b562b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add set/get_clockgating for HDP IP v5.2.1.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c | 150 ++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
index 39a696cd45b5..29c3484ae1f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -40,6 +40,156 @@ static void hdp_v5_2_flush_hdp(struct amdgpu_device *adev,
 			0);
 }
 
+static void hdp_v5_2_update_mem_power_gating(struct amdgpu_device *adev,
+					     bool enable)
+{
+	uint32_t hdp_clk_cntl;
+	uint32_t hdp_mem_pwr_cntl;
+
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
+		return;
+
+	hdp_clk_cntl = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
+
+	/* Before doing clock/power mode switch, forced on MEM clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     ATOMIC_MEM_CLK_SOFT_OVERRIDE, 1);
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* Already disabled above. The actions below are for "enabled" only */
+	if (enable) {
+		/* only one clock gating mode (LS/DS/SD) can be enabled */
+		if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_SD_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_SD_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_LS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_LS_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_DS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_DS_EN, 1);
+		}
+
+		/* confirmed that ATOMIC/RC_MEM_POWER_CTRL_EN have to be set for SRAM LS/DS/SD */
+		if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+				      AMD_CG_SUPPORT_HDP_SD)) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_CTRL_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_CTRL_EN, 1);
+			WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+		}
+	}
+
+	/* disable MEM clock override after clock/power mode changing */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     ATOMIC_MEM_CLK_SOFT_OVERRIDE, 0);
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 0);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t hdp_clk_cntl;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
+		return;
+
+	hdp_clk_cntl = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
+
+	if (enable) {
+		hdp_clk_cntl &=
+			~(uint32_t)
+			(HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
+	} else {
+		hdp_clk_cntl |= HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
+	}
+
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v5_2_get_clockgating_state(struct amdgpu_device *adev,
+					   u64 *flags)
+{
+	uint32_t tmp;
+
+	/* AMD_CG_SUPPORT_HDP_MGCG */
+	tmp = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
+	if (!(tmp & (HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
+		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
+
+	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
+	tmp = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
+	if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	else if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_DS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_DS;
+	else if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_SD_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_SD;
+}
+
+static void hdp_v5_2_update_clock_gating(struct amdgpu_device *adev,
+					      bool enable)
+{
+	hdp_v5_2_update_mem_power_gating(adev, enable);
+	hdp_v5_2_update_medium_grain_clock_gating(adev, enable);
+}
+
 const struct amdgpu_hdp_funcs hdp_v5_2_funcs = {
 	.flush_hdp = hdp_v5_2_flush_hdp,
+	.update_clock_gating = hdp_v5_2_update_clock_gating,
+	.get_clock_gating_state = hdp_v5_2_get_clockgating_state,
 };
-- 
2.25.1

