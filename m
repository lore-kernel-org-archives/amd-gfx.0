Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A52E64004
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2026 02:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8BC10E05A;
	Sun,  5 Apr 2026 02:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xg63Qanl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E73210E05A
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2026 02:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLcTYWNxGuwnZjVF7HlDUf9tObEjwmkRbYtb0nIH1OHlMFqPT4p+M2Xoud4THMpFZcrOoLnknjy4/eJIv5IEEMo617YAXTaPr4mvaPxyeiFobO5RZpuUDHPtmIps8urjJO3VFBlANBqdPI9J13TgThoVb9d2HYH1rCmb/gCUYgCzCU/uwDCUgYtAalWhYVU8YxoLy6kmPaMyNZZsENvvn6XqvcvblX1QATvEr3WEzh8fJgBWktL8UuiAHxVHtduBUg6fzvbcwvWaX/3Qk3rhFjU6EqlhaWKaTWt05pFXBGkL+dxkP9nmv1F/oNMvs0VwuM7AVsRk2nUxs/m3SSq0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN3xWUe79sKw6P4Xx10cY/kIP0Omz4CJ/rsUz72YzPM=;
 b=ZCEKTaR4OnkwIdpgAMfFWNdMhmBAgFOFSXd+6TAd/05U/MbEqFs30P6giQicyE53I0BAuJgS4InQTKqFnctnwW5MhyQL84JBN8f0ieV8RSZ7pUTNw9ME/XvfaKSqesR96+SeOnrpdCUc/UttrsKuGcO8FfW9AuSi6W2qtyuohBGqT+sJsjYzzkZ1BZm5zuFIoof+tkIHMMgGZbDL2Zb5eW5YkswaKyzR5TaFtOZZWbuDorWBFo2aP6sPKbX5ZLbGgAChE4+D8vFD4HZ7aOrHdMdElf/tozNH1FaLIeX4g3LtFgiH+m/NLKU/0+UQsfvUK1z6GkcIHpi3wNE998Pbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN3xWUe79sKw6P4Xx10cY/kIP0Omz4CJ/rsUz72YzPM=;
 b=xg63Qanlvz4RZApbeLfM9rcDFSrBOsc88PcThS0tu/h57LKB3QilQvy+7cuFIWAFoVWf6HGJW5TLul/eKBRZxU2TFh1sGCw6SzXGDJHmULQrtEMOwmpAO9Mu5xA24VOBr2axleKSU/g2jsr6ipCvUieLOsYJTCT5vCYqrCd2tik=
Received: from CY5PR17CA0039.namprd17.prod.outlook.com (2603:10b6:930:12::13)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 02:32:04 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::2) by CY5PR17CA0039.outlook.office365.com
 (2603:10b6:930:12::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Sun,
 5 Apr 2026 02:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sun, 5 Apr 2026 02:32:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 4 Apr 2026 21:32:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix do_mccs handling (MCCS/DDC) in
 amdgpu_dm_update_freesync_caps
Date: Sun, 5 Apr 2026 08:01:45 +0530
Message-ID: <20260405023145.2259115-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 78735261-9fd0-45a2-4034-08de92bb8657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: e4uRLr+2cDWo/5VlCMvMOUW6dhomisr1L/YQJOZ4xZ4pzsQ+XOmVI+8aNDgKxdo3vHzxlqR+gtxFAgwOVBsf3gK6WrFUin+2n3HO6fqEOkFZuvrJmVDpOYNY1FHYc/vjyUqpRHtsaqQRJWcJIPtUYjdBpgddLnC++15gdobErKXaa37hTfdc4cpsdqeNVuEsyIlA3byEAeFz5XVhTPh6+HFJbUb4GVOoq04cHBV0E7jtHN0tYIduvaCTRAhfkFDIwor2/3vZyhJHYRdYiDyMgX9yFXw5CJJtGQ/fimhdH9Mt2cAVPLYCgFzSBfAQtbXhJKSSjvXzt57eQDHOOo469w8Ru51Qry/avjQ9PkSfMeYzmQ8EI2BQf0f0RkXPcwAhL+VyUFRtbjHF1PkZlvXIoFjlHW/1jISR2WmCAyjb+6Lkm1vb8m4App2ndkSvJdV7j7ThXyQgMfR3/M321k9+j8Lsy/RH0eX7w5pb8VMbMfMGGzGz4iiWpVjeHQQM11e7bMd6L5G7ilzUuMwlCfPA4DIiibpNre4IwDobTM64+WVpoEbZBLXfbhEfYkcZboQubz3PA9KT+N0S1QNFnf6O81ZnvD0/BM0UyWps98yGRBo+gIF8G29jLtrqrjFNA02XXr0WZR5hanTtzmceukLHnVPzzdvoGxCdiht8fSeWfC/30QePy/Jpiz+x3zlFVdyXVwD8+oiABtZY0wjTpc1W0pf2C3tM0m7aA57RnGSu52wOQD51HinQGLBg5k24haH3ChfhRV4xtigZrXiEgSI5Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NgrvoWl6ItGbVJ6I78d7r0siTgJtyklqKOxlkyJPuq+5TGeQE2TphcGPYKz+AULEmDRvZwruZTgug5BEZkrRnLq/3onUFv47EszdVu8z2YJFARc7Sf/mnDQv7EmwsWTHmD+hv+jkHXIzTB3zypJi9l2B6xjn8gTBwcw0jWIBcdoGrueGXmKTvBd6e7+sdpqQ+OHUHRFHE8LWmukmZ8mjgvjEMRxEoBYQBnKjiItu2Eli81W+lZb0QbZBI6q/Rd9lX3s3k+mlDQZGJ8/Jhcq9ArCNcR3U2Wssvp8DaUJSYrFjtcE2TZaWj/Cry4KLKfp6o2YF6SOhWkiIf4MrnsjNYM+j2a64goAVeF/YJWO5lT66UmunjdvSdM08JAGRCsnbK5bxR59vl+GeU+9G5IyWqOdcU9CJqBMw3qbLvtEGVUxnmXBXivhz/uri9twVdjuM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 02:32:04.2653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78735261-9fd0-45a2-4034-08de92bb8657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

Fix do_mccs parameter usage in amdgpu_dm_update_freesync_caps.

This function checks FreeSync support from the display and updates
driver state.  MCCS (Monitor Control Command Set) over DDC (Display Data
Channel) is used for communication between GPU and monitor.

Fixes: 980a8981351a ("drm/amd/display: Avoid to do MCCS transaction if unnecessary")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bac02ea15b8a..4b6a1c62bfa8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13259,6 +13259,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
  *
  * @connector: Connector to query.
  * @drm_edid: DRM EDID from monitor
+ * @do_mccs: Whether to query/update MCCS-based FreeSync capability handling.
  *
  * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
  * track of some of the display information in the internal data struct used by
-- 
2.34.1

