Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D56C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667D710ECA5;
	Tue, 11 Aug 2026 15:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ModYWdLG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D199810ECA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJqfI9YgrzzctsA3g9Nz0uhAE09UqsAm99RLIr8b4pq3iwqrbpwBW32aJjMJf+XgUgA7nMHeVtSRf4mmjnmKanSiUNpw53qVXF0t2HsRhIU701P/rAxup7Ebs9DJsvIXryFIrRYZKNaYLVoBSg4Z8eUFZ/HnSe7xR8CHVJGNSrefdYQrNXkdzoGhA4o2DDvV6SlBhMXh5ioZ7mv63pYya7/VYmIBZUOTFHCl1twZd42AGyfCTjeGTMR91p5ZjjjnTREx+sznPj8EPvJre39u66oO8+7D8UHzruiovNav6xc+FVGza9TcuzONOylgBfmTmf/yL5wqEGsTjSXZs44rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVTnv6e++CVe2RrAc1twtWiMP82nkTeTliJlY564RoA=;
 b=tExXKIdPv3tRyaMnuNM3CN+L/A4q0Nsn8t9erc9nAVEjCKDtpObDjNnxmPUEmD7yo6TSNU8fxPawas0DtwH/HjxyMbW+l43Dj+plskxXz1ktQoDB/qZbqzTeklVJ7Ii/oFk5AQYXEGmt5pchnplxrCkD0haim4yGoM2ddvsppCZs0ZBwY6biCAxHl0J1NjLnZ10prhqn2yJpsJUPvMync2WT07/BWLx3TGtvnrBofMVBCrUHoBt4dr08NXFX5QGfzqW7Lz5kPus9/ATE+FAV3rPznOWaBqOsgILi6/ZU1EIIVb6G+5fvJPI4nwZchIoIS9KIL607tUPnsQ0JPAqs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVTnv6e++CVe2RrAc1twtWiMP82nkTeTliJlY564RoA=;
 b=ModYWdLG3ZdRCJ67pOSiEvIRtsmZ4xxOgCmmBGJvuxQqnWIhPIxJLegxAXGFIIq9DjzRqZH9d9Eimwo/mt4iet781axMPRKulj4mwgRZaMXRRvl+4FfYgYEqEz86EyBeNHeqRnhxLM61fOlMxDfhbjszyAVY92HgpoBaEw6+QZc=
Received: from BL1PR13CA0107.namprd13.prod.outlook.com (2603:10b6:208:2b9::22)
 by LVUPR12MB999186.namprd12.prod.outlook.com (2603:10b6:408:3a3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:49:23 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::9b) by BL1PR13CA0107.outlook.office365.com
 (2603:10b6:208:2b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:49:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:23 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:49:14 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 08/24] drm/amd/display: Notify DMU to allow DCHVM<->rIOMMU SDP
 port disconnection for DCN42
Date: Tue, 11 Aug 2026 05:28:42 +0800
Message-ID: <20260810213010.1703162-9-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|LVUPR12MB999186:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f3947a-1d95-477e-8584-08def7c01da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|30052699003|36860700016|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Fd4+bCybGBba4jXwqBrYBTyidMdpqSVIqYayY4mTEwCIoJ0f1CoX0zWJ0Nto6x8cU0Ne3QB437V8+LO4VNXuuQiZLNabBUsyJVhe3N+/FRm207tp5vO+z6iqiSB8vIal+ZkMKeuxK63Sw2HbkVEDVSSIY7yxs6zo4E/JBqJxZ/ryqh70i4DyXLUx7U3o/p/Vc16yhpivoFPItyEyL+rhYFvUOToezzKuxsf2dJ8nIt+qltWx5AoM1A6LoD9Dreki+qPeIG5nrnTOykfcXq22bEviHC16V0roElxaRSno+xzTCKnDnPcV+RKB8Cwl1OohYWbOA6V/0+XymqYYYrmt80uCE5rkZAGhm26x1EFd5J30QVdYYcicS1CTxjwrVx08Ed87uK1Id9UGZ36EXh4T8I6h1wYObRwKsc1neMpPAJlE7zgQlA9htJE1YzddwWv0oEESdI4CHf3yeD6+A4Mzch6mv3BRQgJ4xKK64tStnX112SMT46vAcgPNsYP5r9f5tPSQ4UxsiZf5q5LWg8tJ0/xeeFt6ybzv1Apjs5Azm9e/JQ52UQHN5t9yALZRMs6WcdeiJVTJ+bNd9mihILbWY2Fcr0OKCO+Rt8zkJrjE3yjcNYCfHFpm+eYB/yWUExMg6frLL3addM99qpo3zMxg+bn+Wr1RX+mX42mSN6uGBMSgH0uaCRdG5U/xIsLTe095UZz3COQ+ZmvxucQu4J8B0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(30052699003)(36860700016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3jA9rbJ8e/SNi2VIi09rWMawxFGY70TnnaIMcngeFW+aWkL0/tC/9Zi2HXGIdi/YnlyC2RXztAMp22MjWHkndo8XF4XGsk922KYlnOzaPUu7kWcX35uEleroI3yIlujgblkyjFESHTOw9LGZaHHf5SfUlvNyMG0OI2CeWNVWjB6WjWVul3SMqL/mJKWEKlgwlvLXyt5+32lYOmXe5MS1ZM4MUfQNUfYrccYbzuH0Z4dvBWsit5WjZD22qcfAPx5D/9V3D/hh13x924GYIdE4DN3D8rsRkln8NgmrzOPWJICiTw2ch34cTQsOb360P7CpFoZa1NxmEaivngvwoK56ZTyImlCpOrYy54+ctN8TM7EKP59pr7goYhSHntzIA2UrhECXVyMHEwL20Wwh8zYkPYwFPSZFSzBb8bij7rbO01PhCyMKBKeFPlT8CS4sLfws
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:49:23.5666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f3947a-1d95-477e-8584-08def7c01da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999186
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Allowing the DCHVM<->rIOMMU SDP port to disconnect during IPS1 cycling
can cause extra credits
to be released to rIOMMU. In turn, this will let the rIOMMU issue more
outstanding table walk requests
at once, overflowing the downstream request FIFO. This results in
dropped/orphaned
requests with no method of recovery. This typically manifests as an
invalidation hang error
in the main IOMMU.

As a workaround, dis-allow the SDP port from disconnecting from IPS1 exit
up until after
powerstatus=1. This ensures that rIOMMU does not have the chance to request
credits multiple
times during the powerstatus 0->1 transition.

Since x86 driver cannot access rIOMMU register space, send a command to DMU
to do it.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h   | 12 ++++++++++++
 .../amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |  7 +++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 01864fe816a3..4723e0974647 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2527,3 +2527,21 @@ bool dc_dmub_srv_panel_polarity_get_polarity(struct dc_dmub_srv *dc_dmub_srv, ui
 
 	return ret;
 }
+
+void dc_dmub_srv_hubbub_set_riommu_pctrl(const struct dc_context *ctx, uint32_t value)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!(ctx->dce_version == DCN_VERSION_4_2 || ctx->dce_version == DCN_VERSION_4_2B))
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.dc_bls_dchvm_init.header.type = DMUB_CMD__DC_BLS;
+	cmd.dc_bls_dchvm_init.header.sub_type = DMUB_CMD__DC_BLS_DCHVM_INIT;
+	cmd.dc_bls_dchvm_init.header.payload_bytes = sizeof(struct dmub_cmd_dc_bls_dchvm_init_data);
+
+	cmd.dc_bls_dchvm_init.data.riommu_pctrl_val = value;
+
+	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index ec5387aedf46..ab026847e38b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -451,4 +451,16 @@ void dc_dmub_srv_panel_polarity_reset(struct dc_dmub_srv *dc_dmub_srv, uint8_t p
  */
 bool dc_dmub_srv_panel_polarity_get_polarity(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst, int32_t *polarity);
 
+/**
+ * dc_dmub_srv_hubbub_set_riommu_pctrl() - Program the RIOMMU PCTRL register via DMCUB.
+ *
+ * The RIOMMU PCTRL register (SMN address 0x16B0A100) controls the SDP port
+ * disconnection hysteresis between rIOMMU & DCHVM. It is not accessible from
+ * x86, so the write is offloaded to DMCUB.
+ *
+ * @ctx: dc context
+ * @value: value to program into the register (e.g. 0x20)
+ */
+void dc_dmub_srv_hubbub_set_riommu_pctrl(const struct dc_context *ctx, uint32_t value);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 5e5a7a74346d..53744b000f5d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -31,6 +31,7 @@
 #include "dcn35_hubbub.h"
 #include "dm_services.h"
 #include "reg_helper.h"
+#include "dc_dmub_srv.h"
 
 
 #define CTX \
@@ -580,7 +581,13 @@ void dcn35_dchvm_init(struct hubbub *hubbub)
 
 		//Reflect the power status of DCHUBBUB
 		REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, 1);
+		udelay(5);
+	}
+
+	// generically re-allow the DCHVM<->rIOMMU SDP port to disconnect after powerstatus=1
+	dc_dmub_srv_hubbub_set_riommu_pctrl(hubbub->ctx, 0x20);
 
+	if (riommu_active) {
 		//Start rIOMMU prefetching
 		REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, 1);
 
-- 
2.43.0

