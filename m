Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B93DCA5FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27CA10F9F9;
	Fri,  2 Oct 2026 19:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M6+OTGU6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A6B10F9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA41QHE27JbSjWbELnTqjTtJVCXA+4y4yGcP9TJVUKw6VuELlMfT5M1nAQSP+SHfJt9uq5cQzAba7bqzqGSyLT7W4HD/Swuvk6lSPSw7WTUs6YYO3ih5x96i2JbfkcIf06wRZc/cPbDXPJorD3HPhvi41WkXtC8axB8Y+67r90PNruQtEWXWiJt52KbumA4BZDbp1s7h8Mbef+U2lc5ZfviNwcJ0gaS7oggddeptuYMzupIHw8ND5xFRrLxDZ+xY667XFwbVSGySMYKFatm6xFf6tXHPCYua7861c/zVHCxt0likMpl+E1UNg20zF2YniEYKVmeUKx300NmXHL4iFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUoJ5HECUrE9LFdQq1tIZRgHm/BZpPKilhhqTGG2l9U=;
 b=krx/rli73milmIWDWubGZT+5SIL15iGzSG2aweem4wUy9BiWyI0Cor7/4su6BiOSZhCgBa/hcAuTvtVZZQgJy6hDFdJxHJRSoKRdkRFS5TaGY/mRNS2G9s/w3bWFfZPaEBRMI/MljK/s46So2/VsKqk+pQqjUUYEEa/THrPHyUPmS1Cfa8kyE9lZcLe06KVOE0kUgMH9/8FZFLtZHZiMM1rTOsCTOyOb4qfGgoh+6ad6HqU8A8LwbNlsjw1VAnrXa/1JPyKpkZgApGZrKcJqiPk0sKHVczEwyCqFPAO2WTmjF76IdeoaXpdRscoRD9j9Ll0RabOXdSRR8MQHIYoVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUoJ5HECUrE9LFdQq1tIZRgHm/BZpPKilhhqTGG2l9U=;
 b=M6+OTGU6R/cHCln2YxhlHND87/88sjPF6iE4v+57KkMETrBXkoDUqzsVBcliaKS2BMDf9B8U2/7UEjEB9cSM83maOiqoUQksD3u3NltI4w5FD67uR1Bl+/3eh1BhRDFs0vg/3D8KAWrustyLWRJbqLfp//VXcMnwElDdc6kXg20=
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 19:33:31 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::49) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:33:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:26 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:25 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Ashwin Santhosh
 <Ashwin.Santhosh@amd.com>
Subject: [PATCH 17/17] drm/amd/display: Promote DC to 3.2.401
Date: Fri, 2 Oct 2026 15:32:40 -0400
Message-ID: <20261002193240.3441018-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: d971d0c2-0b4a-418d-c228-08df20bc0a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: wXSsW6MdDFVciTkDZqz3IDRxS8IggfGCBp0OHAXencIcYTsJoCInjARIalSa58PbvryzxkF5FjHUg5yc+3BYsuS7aG5bFKb4L4sJIEVzxB0GbtkOx2M7ItO1yE61mzjZ0TchqTnB8qfKq4yNO45SkkwQB8YjOpdg0s4f0x9vMyk6X0RJzFt1PIpbHX9HekQ1y8wL0wjInbxAXEqJ/qGDmRUw7QcSRkhFJcPef71fuHuhzOuEKvvlb1ohx85y4+22QbZ31hc9UY8n0NTmvXmdQVUplRCQuI0vmZW8VBVMPw5buZaKQ5NahQx7rjtGNjDOppryt3/W6VxxD6AGAQ1ZrP9GwhBcUX9ts4xz6BfR6itXb2Qmh2fnziOcKsuPaDRtv62H155GKz7tcqYD5KIN4SLMDLnRU/uuw/a37I3QO9RaiicC+s1UvMhrjtboOx050OxhvEze0ibzJda9swhdRg1kQmxw8do//88Az4RB7r7UOHVq0q6byDbFR3O+Wa32fBSh6xG1Cyrez0c1v3M19w5GMEcCegdZf8HoWw8ktUhPBThE8sMt7+CVdZ+xEnkzquwrmYhBGnzzxXpQtwV5CcINspa4PK/k5NOUfG1mpfufdUBPm6BgkBAnMjV8pFlGLArvd5S6kddrqXP88+b+Tz43L9t2F1WFnMqci7m2snJ1c9xMnRfCcxuyjRxS0OTWY8CmRYrOxPFbpAfrroo1mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VB8xMGhOIsUZRqYwwPiOo/z19fvR4SUJvU3cki1OBnlEGq6S7L3Ed6Psh55F5lZeNPhpEb3FQ46KfI5TLlsQkNG9XucJ4fZBrFpJwK+nVOwlPdWiiZsH6O72VxdBIzSPCqSnYmVmDbDAEmlmdHoN/pwpQvY5OfLEMeJ11r313d0pNMcL4aQZOZyFRvj+sPVbiOmbyswxg52eZHRN04IZ39LuAiQWpjHFtnKJCmbcym9K97B5KTFt4LGEEI7SgQcdmnF2Dm+9RHXYKxRyFRE8nGU4rjO6ZHZQwsTXGdJtiwchLxgijNQjwqgDgXPzgD1vBYtFVZXHpIs0LGKiHs9LxEOZ6MWMS9NOQ45v87LJ0lllfmwlrgFVqYqDsS3UsfqW55RxNbY7/9eFq3ShMOGilcGEb89BsjoJF7NFl0Lmqkm33+5c6oafqtb3ywvlemMz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:30.5309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d971d0c2-0b4a-418d-c228-08df20bc0a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455
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

From: Ashwin Santhosh <Ashwin.Santhosh@amd.com>

This version brings along the following updates:

 - Add HDMI RR and SCDC skips.
 - Add debug option to override low power SR latencies.
 - Allow skipping link bandwidth clear.
 - Handle virtual link encoder.
 - Improve MCM shaper/3DLUT programming and DTN logging.
 - Only reprogram DRR when v_total values change.
 - Refactor DMUB fast lock sequencing.
 - Send HDMI VRR metadata in VTEM info packet slot.
 - Set cursor_offload for all pipes for a given stream.
 - Skip link off frame count for general UI.
 - Update link training no timeout behaviour on HDMI.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5cd7699e3e84..d3c484f45333 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -68,7 +68,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.400"
+#define DC_VER "3.2.401"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

