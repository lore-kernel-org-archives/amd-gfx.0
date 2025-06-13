Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F05C71148
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 14:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E076B10E9F8;
	Fri, 13 Jun 2025 14:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BtkqRoXw";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D306710E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 14:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbOg2tGQ2Fhk9FGigUT+okmHDpf617tWlrD0Q108on5+UVqlv5JVr54Zv8tH5nk2U4SlRfSIcwapqWwZDZkp6+AMrK0lzxgT5LNcpu0VtecbyYFmsbcubAenT7KpEgze3EKxDcSRsc8Kw7U400bVX7aTuBlE+skFxU+agABC0EIWu74Qa+10CgPl887N4CiM44r7bFKgAxohWy/sipIZVN1XYpu/bw2gBjMBLD0pTmXjhyAb5yk7ta9jAqpZgKC3aHxKWTx6zPJhjfxuaEZ++09o/6DbLOZdAwBSjtZyO9NftObQVFf6Bxl7q9QZ9e2NmG5yM+YHhEVqsSKBAhcp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxGfX6BL+xzVXgn10P1DSZx7Er4l0n0ZGSa4cxJ5e30=;
 b=STQIf9vjftDmx5iGIF1e+Fx4jGsnpT0kyKQ+AUdSv5V6yf9Cbn75qQv8Td+graVqr5OLHev5u3FvZmwFVmZQbcAqMFHLt9VkvEJxD81PuCWWlS06xzel6oCdKqMU2SloObfegO8r/RKIEAwvVYfFRdMSXtfaB/hkpU9blEkwjrIo+wOHsctjpiUVp7Fj4c+eKfg9s3jh6ttV1zvWAIS25JrSMQZSx6a5wMrKcVYgeSLnMHGC3EYipc2D3/VIj7SkRGqGdEEK3KCKOggjcdUcD8qm9YyHS6CYfFjBwQPOtgs1oq+hFNEYx1UOwSj4/B95ROR6gQ9R9znVz6s/C3fH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxGfX6BL+xzVXgn10P1DSZx7Er4l0n0ZGSa4cxJ5e30=;
 b=BtkqRoXwnDimoM7mLfc9N/1n5Xb60ph0F87G8hMMtDQ+Oe18HOZXMKVHQ94Vi54r7Q09fkEj/HhQBQt5WmeL32NLiMkXNO5zK3R02etOx9kln1WhR5k5a4L0FfmFNHEMnPkbGNsVe96vPMKU6rjSbuGBgWlVTJz/W493LzQPFxg=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 14:42:15 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::f5) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Fri,
 13 Jun 2025 14:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 14:42:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 09:42:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 09:42:07 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 13 Jun 2025 09:42:06 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: move the dpm table setting back after
 featureenablement
Date: Fri, 13 Jun 2025 22:42:02 +0800
Message-ID: <20250613144203.441129-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fae2985-bd88-49d5-fc8c-08ddaa887d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bgCgMW+YB680PcN1Oe5+OIxCcPjG6FpkEwsUmzAcQ1PaqsYSDMcsZIh1gou/?=
 =?us-ascii?Q?ACaG5k7jAkkenC4pi+LqJyxeHsdl4wOOW1Er3GK9hSVGD3mI5P/Yey5LEIvf?=
 =?us-ascii?Q?zDwde1AO3bgUFRAsT2o14oN8HQoUpueMyqQVC0C+AiENyXM3dUMy9PPsSb8w?=
 =?us-ascii?Q?kG6idyInHgv709ei9EVs7v+R9FZR7ZB1A6/JEkHnNSpNKDIg1aw2XHhc8WQJ?=
 =?us-ascii?Q?vu+b0Q/A7sfI2fGYfPdzkzMTENfTRu9T6lt3IKDYOCsutb2YRrIRo7a5ORUA?=
 =?us-ascii?Q?QIjkfQnCyXbneNCfIgdjnUSVUmsjx2XyQVsHyDm5zNPWElrj9wBiI3Gkmi6u?=
 =?us-ascii?Q?tSpKMUlNROXR5HsY/0tbatskTisPYGzQwG/rq3VQbz4tJTC30hyyTwWAXG64?=
 =?us-ascii?Q?jp2dUH2cWvwnu870rgpDMFTCmTpGfqzrgwruGzmxGNtNO0NuO7dn29VplGES?=
 =?us-ascii?Q?iOSuj8b76DtPEyyCruU48vF2VYZ4ItoAmrjRV/ncPwkWD9fGaqOWUR2wE8Y9?=
 =?us-ascii?Q?t7NHy4Fd/Wtjyh8S5KVtjhwY3IGsZ0fOwtwf8BpygOhAUM/1wDzKW9X4SShx?=
 =?us-ascii?Q?09jyeKol7qgw7cKzJOj1zRNKfjBmrwYcCCqcYx+753Sg07ycyqLqAmcahs+c?=
 =?us-ascii?Q?EsJbeFN/f1XejwYEQJMqEcDACZY1yJL1t99RRQaDZ1R6EHBAed+njPvGOpGs?=
 =?us-ascii?Q?ROF09FNDIcty0j2t8v9dRXOnS4P9tWbkoEKonkXaszZJl1mPb7WuDt9Svgfb?=
 =?us-ascii?Q?xxtrOLgXlGbQ9K4FeYCng8cWtvMOKOlQUvhtePUr5wFGIp8eMgCA6MuhhuBr?=
 =?us-ascii?Q?AOAefnQlesGUqInWuEW56c65oByjE+PlCK6pwK9nTj82vFLfeZFVYIlJVjsr?=
 =?us-ascii?Q?KYbD5vGL8Xh+jzXRFixDeuTe/wLEQ3igLZKrODRN5jVxP2gyniGtadDjOx8v?=
 =?us-ascii?Q?TkDDsUxgI0dteooROGyfk6NiDcmMXYpcfP840Qqr9REIixkUjZ/tZEV8kw8l?=
 =?us-ascii?Q?gKn7wtK3O8yMdiX4LmsgmVwYWoiT0QGz27dgiHNKd//aZCyf9Wn9xrVa4BTR?=
 =?us-ascii?Q?6dnvlNafI3zozu8W8QWl90m19NTaKiaoXgY8AWM5/7BE1WG9qsyCEQBZYgBJ?=
 =?us-ascii?Q?xGSDwUb+TU3lxFCsvDnzAsW18XVodSE2LrKVSQSxVZieuUY9NcPFw1/XSHqy?=
 =?us-ascii?Q?0lgEPhy+lBielh5DoIMt14R4kLZ34fmT/2jlAWHJMUThBOdr7WGdXDk3J3En?=
 =?us-ascii?Q?6GNzyj86Kwc06BLgkkZ6C7LvEuDnHQC3T97DMlzxxAtT6USHXwQmLG1q9z0N?=
 =?us-ascii?Q?/riwofsqmPoDk/E21u1peCb7P2XMOvgryTYeHrrj40w85VNFQpMI6qsbGHyC?=
 =?us-ascii?Q?NmDOP3ebjfVAE4h8OjeUdNDNa0HxNFZjmBxBrfSYAXojtjRn3bUJxCWeFix4?=
 =?us-ascii?Q?XqA9wYaqwbJ5fdfuHfxd5go1L74g/sjylNNrAwSbDvHpHSRocirW/sFmILPc?=
 =?us-ascii?Q?OCZTV+pxbmNQQBNmElBe6rhaE+3FxeDECXjL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:42:14.6527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae2985-bd88-49d5-fc8c-08ddaa887d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

move the dpm table setting back after featureenablemend due to dependancy.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 824fcc6dd32a..cf4ac3914b68 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1687,17 +1687,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		}
 	}
 
-	/*
-	 * Set initialized values (get from vbios) to dpm tables context such as
-	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
-	 * type of clks.
-	 */
-	ret = smu_set_default_dpm_table(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
-		return ret;
-	}
-
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)
 		pcie_gen = 4;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
@@ -1739,6 +1728,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	/*
+	 * Set initialized values (get from vbios) to dpm tables context such as
+	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
+	 * type of clks.
+	 */
+	ret = smu_set_default_dpm_table(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
+		return ret;
+	}
+
 	smu_init_xgmi_plpd_mode(smu);
 
 	ret = smu_feature_get_enabled_mask(smu, &features_supported);
-- 
2.34.1

