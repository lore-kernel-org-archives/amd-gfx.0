Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F08BC2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF05F10E59B;
	Wed, 15 Nov 2023 19:45:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A1E10E590
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng5efiaNmR1y+seXYAAKVAQiq2SYIP2LQIdEVKslYmbzyZe/J7v1nw8nNwX2jVrPbpLZroPzSYpNqD73Qiqxf2XxJ36spve7FwVEYQmLyUf83TBx1lsFb/PY8gP4wk2yQcV0BLf/YO2n84QQ/NchR7BX2+6xMevpKlszedpTDfnD4e60soALScpXgoALFRQjoHMYTL16IXRAoenBu/MMHmKcEt7XUAT6UJTN+Rn3U8GSiteExO9BdOnsuXnbfrrn9QXSpz8RquM505RrU8N3qbjhtpYw9SFLv2RE8Qw5vx0P8kpBosPo9eu4nfysfBR2C3/qHnnFxNSzWmVeq23AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhDRkKO6NbBqcvrXhnzCaesn765zDF/UZybTBsJ3N8E=;
 b=WhB4VeUE7E8xbWi13PUWbSujjc8eYuX37U7MXD9pknLJc8Bbbw8RyNMudQd6PrtA6bxerUUGuvUgiXlkC6bBjkP+XpKLqdV4sjf0V6J/5Dufn1T4DgLrxs7S8qFVqgoU7DnEYB7p8F5VgXQ+NkoQ4v0zJpJVax2ziGDD/w6tD1A/wzeAZELkY1nzhFbyJ9Q2KgIx7phUWnD2eu8tIdUPiLAGZ9FOV7izj2OK4zdyiMchXM1NT+s6x/ywnsc87nFE2ipG8v4FyPmCHpvZMreYo9sZl99/vXqxRwYJvg0zK1UcOlcuyPsE/eaD+petVac52MeJqjnWeQ5JGliIsbqqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhDRkKO6NbBqcvrXhnzCaesn765zDF/UZybTBsJ3N8E=;
 b=rMuo77HG4ITeWzX7XWLOEdAOKTeMXPdzMaXBq6g4dYtaYBBJ7f2ycVYDpnsgmv8n8YTEdhZAXJ46Wy3E30lS/Rrh/dDbEQdAuYgIjtjZdutdFaS4riQPZ/FcKcCZ00Dg3J1AXHoTxwA9mG7uxT7o0Aykdqb4g3k0pdkLZUrj5xY=
Received: from BL1PR13CA0182.namprd13.prod.outlook.com (2603:10b6:208:2be::7)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:49 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::67) by BL1PR13CA0182.outlook.office365.com
 (2603:10b6:208:2be::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:49 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:47 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/35] drm/amd/display: [FW Promotion] Release 0.0.193.0
Date: Wed, 15 Nov 2023 14:40:47 -0500
Message-ID: <20231115194332.39469-35-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a91c58-9052-476d-c892-08dbe61353f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v7BRIXK4359+NjNHRd3qryF19Lt1DuI5pVuVglBoV6mgsM1hQJZHyfSF+aJoPvQt3yAX0V3D2W5EL+92+68yu6EhYacE/yfy8KHAC6gjGBlDS5o3EMrNMQtMGgTCwu9r3D7N9QVFsoXc5VBNgRSKvL3KuZD0QTT/mbA98FZNO5tm1yHnKxCWTh1ffEbdJpWvClNpQw44kCA4aYpKgTuHr/laz89XlLaZWQY6W9z7gUOiDEp5ASjTO5WZDjY6S8ivyZvsa8424RV0FE5goViY5x9LWsy9lLaEFte94Vi4u8OcWuckcunDkm3RPUNXRKiFaOqOIseWBSRBto2odZcKzUrmDt+yKxNc0ZdMZwW6QAT7nEBw7m3t9IvX+FSoH1sRfZ0dYG5K35TSAtjjN5HKAx/wlNyA4Y9j+e/Fukda6gnAGmI7IJEfIMVxF8AYz9hRX060vlXAlrqZCHRdjfnN1DQnozHfv0oLRXHxgy29Xjwhu2Jvtu44GdZhx7vN9BERrtKIY6I8GWuhXkeDaus+XOJWCObZmctBRNlSIRTZi03wrsUOT1nFSe04MY1LIhg0RvojAxNBkwu/vIknjNmKB1fR3aTBn+yyhP7BIxhFEhUTnnvO1lkUAF4hB7OTe0M3nnJoeTY+qvCbJBUFWzT0QatTSqySnJyQmDdF13Bt/tGhs668OrO/DaozRYFpyYknbM6o039cklwhYZ4SV3z1SbNWfH7/LvbawwdEt4WouSH1AMR0uTGSsqqac/ZM8r2M+E1S26zh+lVvRhljeDdJGhuEZCTMSZJgYPu0S/yznu0OeeWEEyOQT9qAPat69B3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(2906002)(2616005)(86362001)(5660300002)(44832011)(6916009)(316002)(82740400003)(70206006)(54906003)(70586007)(4326008)(8676002)(8936002)(40480700001)(356005)(81166007)(83380400001)(36860700001)(41300700001)(26005)(16526019)(1076003)(47076005)(336012)(426003)(36756003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:49.0259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a91c58-9052-476d-c892-08dbe61353f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

- Add a tracing framework, to measure duration, execution count and
  longest duration of main loop/vsync interrupt work
  GPINT command is used to start/stop the measurements.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a08073fc92ae..b7d9360bfdc8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -185,8 +185,7 @@ union abm_flags {
 		unsigned int disable_abm_requested : 1;
 
 		/**
-		 * @disable_abm_immediately: Indicates if driver has requested ABM to be disabled
-		 * immediately.
+		 * @disable_abm_immediately: Indicates if driver has requested ABM to be disabled immediately.
 		 */
 		unsigned int disable_abm_immediately : 1;
 
@@ -866,6 +865,13 @@ enum dmub_gpint_command {
 	 * DESC: Updates the trace buffer mask bit32~bit63.
 	 */
 	DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD3 = 119,
+
+	/**
+	 * DESC: Enable measurements for various task duration
+	 * ARGS: 0 - Disable measurement
+	 *       1 - Enable measurement
+	 */
+	DMUB_GPINT__TRACE_DMUB_WAKE_ACTIVITY = 123,
 };
 
 /**
-- 
2.42.0

