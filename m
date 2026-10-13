Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D51CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582D810F770;
	Tue, 13 Oct 2026 11:18:31 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0B510F774
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXc4kC/E5z8L6ojGts69z+J0LZYCprGnBfK2umv1cRoMZfpjqoDU2LcQ9mH4cBQ/5fPVj7dtoRdzCNPzjn6l+yK3LcZvZ/jwN4jVb9SvwfDs7LoDWep7GtULQXC5Rw2xV+yXwUK4JAIkQvvT+FhZTJ5NqxxVCNOFbbO8vdWe+FWeEDJHNnRJrMGtTidvkdbO84qHwd3BWa9X+7/KFvxqpwVPnLaeuFMgVuWnxY/5NNVkoPL8tsqQmCg0AWJn3X3QHUqQqPEyqEk9iS6KtsReQZWq0kiB7v1i4tuQi9DEQY+ZQBQ3uzKWwYYg1qpZ/aXTEwdoZNNEnCC9J1bPkC/Oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlNGBi/JdpKmNH5cFT3VGP8HP/fh2Vb2kgLcvkUpemo=;
 b=ktr+sifem0cjoOWX0o+bGLIRiVsCl3IVZ3rX6Oxt0VUGLdLdAvOaP8B4ka1cWT/pvAIocokUGfcYlUxK1w9xmzYyImnJPUxREMxnHb3THuoaOFVA7lX9N+HSawK3X5fEvPjpF7hBv+G/90L2wWf7tgjYaUWGnRKZYfqXPyTS0HhXFrRVFnn+Aiai2PjUxZQZno8+2nJSEsmfJOieJV4q+Del0x9XHSjNbdvgAmVVYFlI7Sq/edmhUqgsemvW0h0pqBL+dsHwSs4BwwMx2LkODSRKHTcf1JceHssb6JYq5Do65ZDaOPza3sJAy6K3bHMsHoUEy6W0Ofm3mMof0SKLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlNGBi/JdpKmNH5cFT3VGP8HP/fh2Vb2kgLcvkUpemo=;
 b=MdFM5ENJrEJ6P8Ki92bOfpSc6uTKs/ZZwoP0AzajLLYgB4wt/5qXkuZYRTiMR2IEB9TZysHdBTHqWVlGMFqSxzvtDUGbZGH0ht0fIXoBac4kr83C9AEoe1XUE0x5qnyQBWB6lj+AhjHB6kuOPwTmsMVxE/TU8s6OMJ+0xHOlXV8=
Received: from SJ0PR05CA0188.namprd05.prod.outlook.com (2603:10b6:a03:330::13)
 by DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Tue, 13 Oct
 2026 11:18:21 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::99) by SJ0PR05CA0188.outlook.office365.com
 (2603:10b6:a03:330::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:18:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:05 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:57 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 15/30] drm/amd/display: remove hard code min dcfclk for AC.
Date: Tue, 13 Oct 2026 19:08:02 +0800
Message-ID: <20261013111616.2267344-16-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DSVPR12MB664020:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ddcf46-715a-4355-3561-08df291bb0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|18002099003|22082099003|10067099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5ROAuT5p6Z3ForsdfrjUppANiFtz5djIMlOBk2yCWHFdNwBAvXz7ZfiM11pCzx4tW7pELWACNE682qpN7mJX+YzT2av7FP+xhl9H3hN540o7ABxfBj0/nBe5T+fHEH4bbn7IWEbfSPpMqDZGzI3j0G/ze3gawC5v+0QnqvXzMu4rJ13MC69ihrft7m51054v1iYdFyXYvj4LgSowWJxTpAH6lVINeWcfG+gKjAIuw+PvKd+c8wV/VHD52MLXYs/6DrkNlXqolgFvavJavLgkSUsUaeWB8xmvOfvTUrVfJSkwoATUxGqiUIGaf0xiTo0jcwEL1fbbyv/TutO4RfrLv3TBnC6h4BVrxDNqs7G+M9/5CbkbtHOb9GSTkkQEa8I94NDGrFHohPse/oysEWw898jhgAe4fA3GVsZ7POeE3O/6vczLe5OtsiHH8DbN/BKyrkKYZNL2eZ6AKAEJ9mPVi3qGRMO0R3MIwalKO52mwayQm4NK7DVVzd2uczHLkSPACWwU1iYIL5k9uZgI0RAnwo3gAuGFDuGvCv/tUX6ERSA10D/fxBPfPjgeOQviJTvXTxdy0hqIuu551Yc2UHQRg5ZLeqJ821wNZR4GXrNeLwaWucAGR/+yPqTL05SwP+rnGUmPxYVPNuqG0005xxStTIKF1hIp3PAzyU+6fVwyxVOh/SitRBZBuSSa24CPd2rbrr6cJKdRCP7NirjWbJcKgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g9GQlR6A3oTzCvLusWq4FXnrFdUuW+389tQvQ6ecQT0toJH61E7q/iRrqtgQfiBh0a1UgPp6AyB0WSxmXbbEWwdZa6VILLANS/7OHpjEsL9mlAiNkyrSZQzwW+p0h9xDiTfuRzMfUhviHeO5eAou5TfqjMVf1ORWyXFA5V5fJfixi895pntQMSRdEfdqZf+n5TIxll6ClVWTKrWhypRmZ139BtNQHDsjaz/L/lXSwV2Rdkc2JGwh7XJnDmIihN1SnGoba8hy23k7WApRem+SWI9IIzOt9g1yGuaHliw9HkCyoDFPheQewkTSTNBtcVVaMXUMx7iJjApAOSQdXOvi17uT7LuguvdKVKGJM4pEwHdsiYENgxL428chKjVJ1YzAM1h8zkn6QT4D9mYPtnIDNpr18iUlEcGkgfePoY0stFzI98MwkIwNiV+J5pv32DnP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:21.4623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ddcf46-715a-4355-3561-08df291bb0bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB664020
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
At driver init time, power_source is not initialized.
It will override DC's min dcfclk as well.
Since latest pmfw has the fix release, we can remove the previous w/a.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c   | 2 --
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c            | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index d500a3210eed..33f0099075c0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -418,8 +418,6 @@ static void dcn42b_update_clocks(struct clk_mgr *clk_mgr_base,
 			dc->debug.force_min_dcfclk_mhz = DCN42B_MIN_DCFCLK_MHZ;
 		else if (dc->debug.force_min_dcfclk_mhz > DCN42B_MAX_DCFCLK_MHZ)
 			dc->debug.force_min_dcfclk_mhz = DCN42B_MAX_DCFCLK_MHZ;
-	} else if (power_supply_is_system_supplied()) {
-		dc->debug.force_min_dcfclk_mhz = DCN42B_AC_MIN_DCFCLK_MHZ;
 	}
 
 	dcn42_update_clocks(clk_mgr_base, context, safe_to_lower);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index 3ef9a0152058..8ebd3d948567 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -392,10 +392,9 @@ bool dmub_dcn42_is_hw_init(struct dmub_srv *dmub)
 
 	fw_version = REG_READ(DMCUB_SCRATCH1);
 	is_vbios_fw = ((fw_version >> 6) & 0x01) ? true : false;
-	if (is_vbios_fw) {
-		dm_output_to_console("\n: DMU started with VBIOS FW, fw_version = 0x%x\n", fw_version);
+	if (is_vbios_fw)
 		return false;
-	}
+
 	return is_hw_init != 0 && status.bits.dal_fw;
 }
 
-- 
2.43.0

