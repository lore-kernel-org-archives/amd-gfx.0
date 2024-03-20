Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07917C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A3F10EE88;
	Wed, 20 Mar 2024 06:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNLRzADb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4006510EE94
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7xcChVAG+Ct5Jpn5Ba5JvdpmTHBdzAFbzpRhgeQxRYE8grYLNUkqVL52xj+IDnNDwX0kcym8OItz8n9EgJqMc6/kXlThGn8Oc+xhcEEDN0pnY9y29oIVgTO+KpZe6jKaDx+eN/6uw12ahDDecbkC01YkdTsc/wlg8ZXbn5hWJOuGE7HDx0Zl+lzA0hLVSgivhl+7MfD07N7qqw57qq92f5T7YABd1np6vHO+fUuKxagXbp4J4Kh1qbOLVusCV/PESOBpLtaJOvWIDMoO3bPewmkv8L5dDi1MiKadpVzDn+UK+NZCpdAbOpX/5W4cslxCg+FziGhS3tOI6ZQEmQtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvuNjh5smf50vbNFm5t1jaX+Jn82fvNhriWqQRxIeWE=;
 b=NssP/5pSXYlSzTlOXxklSGc2EiSIL941xkgsXw1LW/gejQpnM6jIjZCfazX2DKSnmVbi2N8wirdgHamjcP20f+aX8M9i1eit4y8gpaJRivE3pvUiMbKLco6oOwFyF3hZbLZrkWDBaGK1HA3nmMvVK10sfvEftYX37FJuRi5Mmkd78rp7BreS9m8Qq2RbT3YPvViSHIxp63snIEqPmzDgt1Yrh+Pdo5n0PzIRD2opRZdG4MyDxr79GQ2WsLF3gE5E9e7VRR+gtUa8mk3H7LQ4yEYAnRk1NUht7mQGh9ikU+Z4yyFTn/l4Ed+MT9tmS9o/iAbf8YiysijVB05TxQLoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvuNjh5smf50vbNFm5t1jaX+Jn82fvNhriWqQRxIeWE=;
 b=UNLRzADbfO1XbULAQ470IbhAmc4T9z0/lLtBIFraqz8XcV3ScpFI0suTBkZ4EuuCYKlOEZg+28j3POxHiBSE5Um5aRdNEJ7CEBuyr1PUz0ZdBskT39wbJv2EJNqUcfyM1DWqvmqXy8SCc/KVsA7smvZS/DDMG9Q3AxfsM6w54zU=
Received: from BN0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:e8::28)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 06:37:00 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::5f) by BN0PR04CA0053.outlook.office365.com
 (2603:10b6:408:e8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:59 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 13/22] drm/amd/display: Add new IPS config mode
Date: Wed, 20 Mar 2024 14:35:47 +0800
Message-ID: <20240320063556.1326615-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: a90b8ed8-7e7b-4955-363b-08dc48a82598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeetkmbMZ/MGwpeCYsl58O032fjRF7zod2c4LuxD9ZLQeFiqyoEtoHA4RIGJA+2vguIgu1T/Dag/yuClSFtPfidrVfDVxUAM7mu9YiuYEiUA63dlOVVsqd55GAcabWpQEybRpf5ilOZudbmg9p0CwiSjcEekYruM4+n5QLpEK9I20bqf19NpNXMHwHD5GrlLOwc6yz0eSofNYsdWnCg9v7/zKBFSKoo7rzImDT3EgTIlKjWk2r8TET8sNphA8rLcOMWajlzh0NvaxB6dbOkN95+rwRNIoJ3dWsZSC5SpvtrmidLjaP+ZIvnpTv8uRFocoq9Ec98Fhgqdjd0dwnLoq49/B59Xvc/FD7r91jmat5btlCKfrF6xhfAPtmt29lnbzfRrvUn6dtmmrbL9KdNjezk3by+LSfWm0ogFY5WH3VkNFgFVUjdkfoKI1jZbSqtl7Etw2IGjTQ7HQM96eDOKddMw4EA29+BclYBScC62haY1WifX/MiXu1D4PWoxH1jtReVe9NTRc/Wjyj4VtBfx03tgpnHBTmflpKTGwhFEr/vJwhhxUfsZ/WPuqpX1IQ5Q7pVwmpEYZsZAbIaAdnlppfjWxNkcsoh1D5IsCFBXvYhEXI9o/ER3C3uF5w2G5pqZlhSKbVNr5De2qUIckcXyRBFrdeNBCey9uKxY+oasL6Mvw/U7RddmFWY27/8tq365gnkiTwn9y63muldutgNt3Z/aqVs6HWRgC4vN1cLN8OBRG7PAlui99aUGbBMe6PEG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:00.1737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90b8ed8-7e7b-4955-363b-08dc48a82598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We don't have a way to specify IPS2 for display off but RCG only for
static screen and local video playback.

[How]
Add a new setting that allows RCG only when displays are active but
IPS2 when all displays are off.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 29 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 12c142cae78b..9ae0e602e737 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1201,6 +1201,20 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 	return true;
 }
 
+static int count_active_streams(const struct dc *dc)
+{
+	int i, count = 0;
+
+	for (i = 0; i < dc->current_state->stream_count; ++i) {
+		struct dc_stream_state *stream = dc->current_state->streams[i];
+
+		if (stream && !stream->dpms_off)
+			count += 1;
+	}
+
+	return count;
+}
+
 static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 {
 	volatile const struct dmub_shared_state_ips_fw *ips_fw;
@@ -1255,6 +1269,21 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			new_signals.bits.allow_pg = 1;
 			new_signals.bits.allow_ips1 = 1;
 			new_signals.bits.allow_ips2 = 1;
+		} else if (dc->config.disable_ips == DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF) {
+			/* TODO: Move this logic out to hwseq */
+			if (count_active_streams(dc) == 0) {
+				/* IPS2 - Display off */
+				new_signals.bits.allow_pg = 1;
+				new_signals.bits.allow_ips1 = 1;
+				new_signals.bits.allow_ips2 = 1;
+				new_signals.bits.allow_z10 = 1;
+			} else {
+				/* RCG only */
+				new_signals.bits.allow_pg = 0;
+				new_signals.bits.allow_ips1 = 1;
+				new_signals.bits.allow_ips2 = 0;
+				new_signals.bits.allow_z10 = 0;
+			}
 		}
 
 		ips_driver->signals = new_signals;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 34cb25c6166a..995a54459335 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -624,6 +624,7 @@ enum dmub_ips_disable_type {
 	DMUB_IPS_DISABLE_IPS2 = 3,
 	DMUB_IPS_DISABLE_IPS2_Z10 = 4,
 	DMUB_IPS_DISABLE_DYNAMIC = 5,
+	DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF = 6,
 };
 
 #define DMUB_IPS1_ALLOW_MASK 0x00000001
-- 
2.34.1

