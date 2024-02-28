Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E86C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A87710E643;
	Wed, 28 Feb 2024 18:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BjOEwj7b";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5217A10E643
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP2D9mtLbmFVvjVVImdEeHf+mSXje/8t3UaX4wISt+WeBGh+EVHIgrU+l4/66IsFaxAtQTxlbnL6f7EcTcOmaWZ7Be91WoWzXxIR2sKRmyf0d2XwPzkzJ98nh4nFbTbvkDAcCntg+PUXzFwQC+gAva9DjGQ5wJf3GA77XzZdINHx8OIlRj9dKhXvyAJ8vMxu5AI/82Xl9Qve9X25Q9WPdn1n2EvEfWnG/na+yDg9h7qajf3Hy831fyQQWwqh35ERtQjB8a/HpDbeFIIfV0UUnw03oF1pJPgKTgSrppu2Snqg0CY9ZFMEVredKsnubRDpsyePeIScWnjVqWswpNRFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o36Off8MngEu0k9piwvAta/VvNrdcXfW2XYzWi4WaLQ=;
 b=eOufuPRw/o/79L+/dI4auTMTAIos/8s0sWpglLOPSkFSivy6AnbRCHzvUw7R3xll6k51iY/qRxU7S/JAbYZsrvz6Z4sDFRTL4MNl/T7R9Cg3g8hcWAWYWzXkOjMsO4/2c9URPqyBi1HXIsN9Om/u7fQb37MHRGvDHqCwouqNbBTT7C/v3/7wX4Y08laaj3eFRH4Rb449TjNyW9be9LZIgFvS8t/H3QeV22OsVVxCIjpERycqKUgWLzm0cwp6dGnbMxOorCu225TdZb9eePinKPNtMdwMVCQhm9tXpDuWKqEDTADzLZpgluR26RkZGuvPbQQjnn8taGSQZvHChPSVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o36Off8MngEu0k9piwvAta/VvNrdcXfW2XYzWi4WaLQ=;
 b=BjOEwj7bPEcWqynFdYZE0kz6U8y8xT0K5nheNL32w345c5O2M/egCgL7Wpbwdi0w5RL5dY6kHdUIBDYvJfgU1InqZoM7xpw5c8+qmG2abKalExeuTG0zL7i4zkLpJfkxjZYABVOgXW1oBjrMUw50w8Ufpzis/Sa89XWr5Ms9PsQ=
Received: from SA9PR13CA0066.namprd13.prod.outlook.com (2603:10b6:806:23::11)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:48:00 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::b1) by SA9PR13CA0066.outlook.office365.com
 (2603:10b6:806:23::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12 via Frontend
 Transport; Wed, 28 Feb 2024 18:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:48:00 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:47:58 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 32/34] drm/amd/display: Return the correct HDCP error code
Date: Wed, 28 Feb 2024 11:39:38 -0700
Message-ID: <20240228183940.1883742-33-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7deacb79-f535-46aa-fd70-08dc388dc9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnivGSjbz/eK4kkLb9MjEkNl5nlDySHC1/eIM1cgpsAHMkMX575ZnZxojNSUZwebOFGVV3oo0ePkgFE5vot2aKV7ZFuFsSrFEHBx6MNhle7SHeijrS3A+Aw9Vu2xVIA9YR9uyH3X/9eLic+Jl4bQD8iybnImfzbFyNUPHJsErGpI6ir8m0yuqhv/4I3//qn4wPXJaARG8SiRaDj3vaJVeYPZgib5M7kjbzU6Xf/prW/IHh7m6oZh4abIc3t4aTS2QeweIoK0nr81BtAYVdO/jUkq29dd30900tgEbWXbyUwNNBgyGLnBWEI5ArbmKQDq0qOMljWb9OPIFhj6CTYM+aNhauOAdf9BU9qNP22etzP0ff3PASV6RQ4oLtkpUCm8WCBL51LM+G6wk53OsEFt32ld2lfxroBjGltFnB7E/Qw/eu1ZVSGaeAGmd1sBq2YgFUhE0t5B0g1tkSPJ5hD0y++/2SIHxCG5vDSQPP3ue/tcPXOmmNVXnxldY8curh/C16AZn8gnjWKdoVx+w/NVqj3rvVoAG9ybzdlvst1alGcXAjaML6ZWn2ZjB1/MgXAX9WrT6/1pV6ZnEW+1c49fsz9/peUpXQlYYF4uOvp/BCePE0M7HfoPqrtkOqk1B8gZqUiNQybVK/IPnow79746oInR6B1Dx/7NRJwofsTIiJi/7ioey2EiQn0blchGTrApiKr4x6onXCZX/xC4eCBt544yex9FoOAyq+N0dgg7cKSJIFpkegesI7DUZHDPM7cc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:48:00.5751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deacb79-f535-46aa-fd70-08dc388dc9c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[WHY & HOW]
If the display is null when creating an HDCP session, return a proper
error code.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 8c137d7c032e..7c9805705fd3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -513,6 +513,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
 
 	if (hdcp->connection.link.adjust.hdcp2.force_type == MOD_HDCP_FORCE_TYPE_0)
-- 
2.34.1

