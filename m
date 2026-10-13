Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFB0CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC38410E6C6;
	Tue, 13 Oct 2026 11:18:39 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7225610E6C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JemU+5RLmoVjb06brZmyN2rGmBOf7xOOoOgqLWTga6+rG525MRs0Zc9TpW3aBU5EAb7xEzYm9tPEZanKT65aPYsaAmdMHV1VNG1nQW13CPj2Ie+/1z+KAdvBGWgmyRO+PXW1eeCokK9AbmEzd+nppu7AmhrwyZenK7v8QIlGHO6dGdsuKZdfX0GaMm0Ggv87anYpydWh5yGFeiTzMXG7wDnbBlA07gjz2utFO+UNOcMaWumEU6NVeXF42d2ETNoi93VPf/BCRGLoBavJdzPVk5CBAqG7jrM4t/12hCZmVg28cb0Jd3Qno2NbbWW6xNaiHADkaMIzkDha4bQ7KRiU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZVHqbvzTSd/ZmiBcCp5/Ie5NVdbWgoLpRR/invygA8=;
 b=ugnPcm4yynpOWzbpBF+8YcbROXqCaNytXUL+OyIZcF+8UgBZf+qI5ylOzioJnDBM4k8QxjG23p9COiG8SBgsy6sBrIVuOkyYMCPEE1RczOclIfRAWbxz/fBRv40UYhwza6gHOHnqrspkmPTuE7FtHfJS9UaMzuhp3Q99bimTP3AnXxVq9MdJDp3Ob0Q5RL5s1updSGzc26X81lhXaQk+1fpP3J0uA2RKou5ns67jACDs/BI/e5EWV7YTJvpUr1rGlC7P00gUyHp5nCNzANI4rFIuDFLzY5OmOxd5pNSbKgZm+ub9P4JKmOjk9/IUMyMz/H8fR5ylDYnkBX9n1BO1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZVHqbvzTSd/ZmiBcCp5/Ie5NVdbWgoLpRR/invygA8=;
 b=fZ6wxe8Ypy3eEvfYbSx8hhvAee+9eUZgB2aapviD/qXrnUT91/IfstdLoaXP2aZscU2jDNpY2qfgzpISUDT7VMrRzQfepsI74/p6fNOPROeK4LmLleOm0jr7TRD8J2nN1zyubx5deGHfGNqVsAoFM4m2LoY1UuV+W7xtGTL1YV0=
Received: from SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:18:18 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::47) by SJ0PR05CA0172.outlook.office365.com
 (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Tue, 13
 Oct 2026 11:18:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:56 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:48 -0500
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
Subject: [PATCH 14/30] drm/amd/display: Do not allow vbios version of dmubfw
 in the driver
Date: Tue, 13 Oct 2026 19:08:01 +0800
Message-ID: <20261013111616.2267344-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad369e8-6ca9-4a70-997b-08df291baf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: NQbmydoWwSP2kR7U91Foc5VJdML8FVC9tXzpHb4Yim9ko3EctMpwpnxLMh1DuPq3GNErahJjBMJhPsKp27rI+sEL0XPR6rMAO6leaIkdbIy77CuTcVPOXg/98NMA9mbV+lxevVMRoFejtPiANOuaFg4bq9hZyYefLqxILLj/WdcZliG24e+ru82QXRFLeVv83wBQUCLASGXjL4sbu7X+SuBarWBLLXvP0HI2o00bnuBR0QbB1HCGgjo4h+sOJvkqf6v3rF8h6ZUInGluGMdy+CejQyDN2PdLXN6W+r3MxmcRTQkNjS39r8ptMXU/HhTA58bsvjLj2Px+wNYGZvS/kHVawBkBsHmdhfsNIwAiny10tVp00OOzhHIwOQiIjjMhw5xTJIhM7mh/Bn3fWJzpi8gvbG3+jZgASe9g+5MMIb0CZCn9vH/h+ZytarMnxtn2tlB0rKY8tASisCzzq/I0ESnP6i8NVpNfWRw+nTl9NHhlB4HYsXyldsUKshyNUIpwzzzO5jPuowxChbwnC1l9Br/vMsNb3vCqGZdTuo+GQYVq4m1fhIKQoH+fVTRo58rcPVrnE331NqMXxGO0RFIwp15A2qPhCEViuQII8PG930UCVExwz1qWnZBs+KjwZajB+zbIrV5M7+fuxhNlq4kq/Q0OdMaZRQErJliNErIdrPc+XxlwURD6f3n4C2VGQxa7ph2ZKBoeGJuvVdgMuNcAWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UFRBHV+or8sigCI4bgKP6BbkF5WNjTCOeuHgnOKTd1dwTzswpCdOAlL9YQE80/qhG8VD+DI+n6wts101Hv3fp/FUzBV6FSvKic8LlAoYzje6uRgdYNNxjSNjigiffzUIz76qt5XLetrAmozgfSccDZHl6GutLXBrEQQNPiY6oZo9obCyBhEq0dBaHbgROV7DNncI4Fvh+4kb+ECi5q2utZeOD9CXsEMHC+5kxeQXJYE/saonbv9w/SdMimnUBi4EZFN+LrmFzlpPQLMflfPOV5AN4VhoW7h+jt6QCbv6KoAhWWa0eQhYEAJg6VAwth6yW9JsY6tTHdIQ1525wquDS7mOTVa+X7ipD0CnY6eHkJKtNKHIYcVoXCRGQeEBOgOuPguLWXMWX9/wWqjGnLDalEHiVbwMWrX3rzt0xPjBOeii0bimI9jMKXexmLK9qqre
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:18.6063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad369e8-6ca9-4a70-997b-08df291baf04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
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
The vbios version of the dmubfw lacks driver feature support such as
HWFLIPQ, PSR/PSRSU/Replay/IPS, etc. Allowing the driver to use the
vbios version of dmubfw risks a deadlock and system hang.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index 53e70c682a77..3ef9a0152058 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -384,10 +384,18 @@ bool dmub_dcn42_is_hw_init(struct dmub_srv *dmub)
 {
 	union dmub_fw_boot_status status;
 	uint32_t is_hw_init;
+	uint32_t fw_version;
+	bool is_vbios_fw;
 
 	status.all = REG_READ(DMCUB_SCRATCH0);
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_hw_init);
 
+	fw_version = REG_READ(DMCUB_SCRATCH1);
+	is_vbios_fw = ((fw_version >> 6) & 0x01) ? true : false;
+	if (is_vbios_fw) {
+		dm_output_to_console("\n: DMU started with VBIOS FW, fw_version = 0x%x\n", fw_version);
+		return false;
+	}
 	return is_hw_init != 0 && status.bits.dal_fw;
 }
 
-- 
2.43.0

