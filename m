Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08526C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BA710E83F;
	Wed,  8 Nov 2023 19:11:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A782C10E839
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY/NZr6AboVfj+Rl8CPQHhnjENHvEAIen9ULSt4Nt5/wO67WWeJFTl7EkjvNj9VxSCXetajx0h5O4Q5HO85yOYY3/wqFRQ53vOvxaXAwPAodQdUIp02Kgj4WMKd+1Z4rdbSqow5YyH/olFXbQqQjFoDH0U1dVInZ76PeRoLv9AWbT3DbYfbpOOy47Yy6nt8elCZ4FaefCE0A53UL7UwaNOJcVTAUDGHYZcxtPksGN34SkFeKu495GFBsbDoghkd1hHWSLkOvnUf8z74+LGDpOKAsEiFRwLu56lWN5J8lgFE4v/3RfqGCvY8XuB6MReX4r7ijUh7GGD+mHRBZ63C+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHEx2FCDC1KcmplN7fjKgXNtLF8KlJCUgG66AwFdAgo=;
 b=jHLOSx3m/4kR+Wi9G6rANvxbT0EI2Hsy4pbNLdX7uE/YOHqeEuX9Pf0owOwt3LJY3oQT3LwuRAEzXr0rOfFd81/6pxPj0z7BTlFhiv8DsCgocikCSF/cOuxeZmtL8Uf9dIvcFv2AcnuSbEpl8dVTjeFASO1z7DJYZkjFQ01nMvBvdODLFCRd/AaFkZpm8xfP48FX0krwOGa1tyOqCqQrr8HwkO3XINizxzseIdfFSsX9KROmbfBBxsz1N2y8kP92voa6sRU0p2uOi6Ls8ZRO0+eoAFqG2nUc9YRL+JXx1SYkRUme7HvJOHRrEcDswCJYYQ4cKwgJxZXthasHdCKEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHEx2FCDC1KcmplN7fjKgXNtLF8KlJCUgG66AwFdAgo=;
 b=A3Z2l8nvXW3pWamvjBDMjHZEEhTWnDlKQufD4zngT0Yr4hzOrgVbr99C5gTP0VG/EzgOooIptCHJZJa7JyMGxGVfB2Wqg009CRLMzOvRVrzXHOvYYwOvzdIQtUwsLJd1dhiLgB0Xr8hM/eQ6GbtracFSgVpfXwv6RisUkArLMHg=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:11:52 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::f7) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:11:51 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:11:09 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/20] drm/amd/display: Add new command to disable replay
 timing resync
Date: Wed, 8 Nov 2023 11:44:33 -0700
Message-ID: <20231108185501.45359-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c52b2b-143f-4f66-74c8-08dbe08e90a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YAWoJqNddmoYe0Nx/UvzFB1tRVvXiW+8XUCqONJtsqQVUGNWH6oXUXnXQUNSyZXR76pQTtICd6fycdVceIvH0Cd0ifAdRDq+dn1X7swB53vswgcF5+yBAxML7G0u8wbgkfuHfWE7gjcDiiVsCt2Y6xk2Zg4nlw0zhQXlCPoW63iZU5daxJGcRHySaQBHqWrupmxh7MCUFVqAfwdpTj8UUZrOMrxxbyFEJdm1qW4XWBh0w7vfgXPCgySQmVJDuAAIiyl1d55nrlKBSWdZjVLJbQR8iHTWHqdiegsL+9rQcuG5lDEj9WaiWEEG0I3ESoruFRkW83oOwb663dWvbqbLWqQmX49H3PcdavKS5RIshpFjGBtQIdyhthyHfpdUmEVMuCnH0Ami+aATvk1aU6mqqEZn5drh9dAWTswjZSCsXvGYogpkM7+VslOfIzb3mCs9xVgn09FLIwKLR04+xQnnyO8EmnmIL4fS0nJCy4g5cskPvVAWFw3RPeFLWROMsfvsG98uI7CXoKwbaw3WlNLJEgcUJz/5byF3RaqjUiWqHILHhTjFN14WaEgFhZ2lR8UtYPTOVZRyOjdmDW9GUZy7FBbQqzrYbkHkutA2CdPxVhsfL5n+LRecCizDF/2X1ZZXFkC4Z9sxnLtti+dLt1WskaiiR718Ie/aydewB3QeroApN9s4DHbV5JMOr6AbwCYnCS/IcqTQpMSOMUM/nyqbDBabi3yIxkEek3zZ8yJSf44qmRvPRzMDzMCl8AWoXIcN8VcYVMw9dJg9kqp3Zp1+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(40480700001)(16526019)(6666004)(7696005)(426003)(336012)(26005)(41300700001)(47076005)(2616005)(1076003)(36860700001)(81166007)(356005)(36756003)(82740400003)(86362001)(44832011)(70586007)(5660300002)(8676002)(4326008)(8936002)(478600001)(6916009)(83380400001)(70206006)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:11:51.9616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c52b2b-143f-4f66-74c8-08dbe08e90a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

[WHY & HOW]
Add new command to disable replay timing resync

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ed4379c04715..97faa9cfb6f7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2840,6 +2840,10 @@ enum dmub_cmd_replay_type {
 	 * Set power opt and coasting vtotal.
 	 */
 	DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL	= 4,
+	/**
+	 * Set disabled iiming sync.
+	 */
+	DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED	= 5,
 };
 
 /**
@@ -3002,6 +3006,27 @@ struct dmub_cmd_replay_set_power_opt_data {
 	uint32_t power_opt;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED command.
+ */
+struct dmub_cmd_replay_set_timing_sync_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
+	/**
+	 * REPLAY set_timing_sync
+	 */
+	bool timing_sync_supported;
+};
+
 /**
  * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
  */
@@ -3068,6 +3093,20 @@ struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal {
 	struct dmub_cmd_replay_set_coasting_vtotal_data replay_set_coasting_vtotal_data;
 };
 
+/**
+ * Definition of a DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED command.
+ */
+struct dmub_rb_cmd_replay_set_timing_sync {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED command.
+	 */
+	struct dmub_cmd_replay_set_timing_sync_data replay_set_timing_sync_data;
+};
+
 /**
  * Set of HW components that can be locked.
  *
@@ -4201,6 +4240,8 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL command.
 	 */
 	struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal replay_set_power_opt_and_coasting_vtotal;
+
+	struct dmub_rb_cmd_replay_set_timing_sync replay_set_timing_sync;
 };
 
 /**
-- 
2.42.0

