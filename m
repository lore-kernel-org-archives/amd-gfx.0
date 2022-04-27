Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170C2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FD310F3C6;
	Wed, 27 Apr 2022 03:02:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1B710F3C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjCTb2ikEkjp/BiuN656ayTwAubaDdPlAs+5JO8qpqxnC5zZMCXGZwZJ/fOW1jLNTorgfmDpTdeMQD3lVrAwruQdvBuGlebN+eZAGMx/UikMcafdIlZZW+qUPArpDRPUclGAGFQiTmyV6ra9+5H4JPcgFzfZkD4Sb9SmbJxeQO1iwdP72K2CHFJfvYWenHh0Gegsk7VEv4U+se4ZJ/U23b9q/lbbgpnru34wfOQXZ1PFou0QE2P3sgEA3L5uza0AKIKvd3aCeFMk54QhSauFou9LnAwNSZ/EHniwlCLyPdpsF9EubQFrO/3YfGkYSRxRBmmF5R+HVHXXh1Ux8ZWvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfK+HZCJGVWCxDW31XCaWgNqj0QkLTCx8ifNSL6hnhM=;
 b=mmO4Hl62w/9vhgBHDMPuhnMEt2xLjBrHJt5ESL/Jb7YZS1nrfq3V2hMmWv6abID+ppQyB4jVehG4nMq//groL5XUcOPPvWwAyC/wKaBOqfAi7ACc3z/FR2QX5meTMzRgnQZWsPTRkRE4o65CEHZpW18jFR5OiWe+9r3QFchDwfofSM882UP7JBG1pXn96T+SOxgQn57+11o1sdsZHlJ6jYSp6cWJ+PptG5UJoN21ApPbhbtH0b6qwMvaJU2mdytVQEGpZ+6E8GZ8OBYQjc+6CPbAEiSh15ZwVESygXIYWmZzXtceEr+2ZWl7HEx2kCjB3UQ3ZuUA76+v3Ak/WiG8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfK+HZCJGVWCxDW31XCaWgNqj0QkLTCx8ifNSL6hnhM=;
 b=cqa8a6+7mOYGKlhIQXTIZpFwgC+Hkhiv+JbeDitFu9DbPFaP0Ej4FLteoWhlcZaRqcOqblsdrYRXokQzkI/1xbn8rQevMZ/sVC+LVYDZER2GMoBo1njTZn0ctZnLKmUkWpLtC1C6CSEIBtSeRcKwFtq/IMQE/R7tcQLl81FfRAs=
Received: from BN9PR03CA0446.namprd03.prod.outlook.com (2603:10b6:408:113::31)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 03:02:09 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::3a) by BN9PR03CA0446.outlook.office365.com
 (2603:10b6:408:113::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 03:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:02:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:02:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 20:02:07 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:02:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/display: [FW Promotion] Release 0.0.115.0
Date: Wed, 27 Apr 2022 11:00:58 +0800
Message-ID: <20220427030059.1242868-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ae3405-301f-4e24-c2a4-08da27fa51c9
X-MS-TrafficTypeDiagnostic: CY5PR12MB6346:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB63464E2933409C5012582D5AFCFA9@CY5PR12MB6346.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+9d9qiL9cXv2M3MCNBeVFCiPqzDZcoRRpa4jGh842i2losv3oZEQO0Mb8NMUtL/MI2lWJc3hRL+8pY+/5nbuY62im39magnTS/z/4J4gJjJynBsrz/iYByaY7DLU8CvYr6ul+1SkSz6XODjAVdoAVqSxKT1saLRvqiB5K+ibcyXpWx/hn6MiYaEJikMJQD25rbS6BVHWiAYJk1dq+W6I7BYvLJx7u50mwsJkZ5uGvw4xzcFmVdsESW47vK0R++fkrsud135KhmpDuHjGfGI8GD8ssSzUqcGM618v7o/RQA3JqHzEF302beHU2mTmhPildzyyVgwBZ+/47lpKXyTNV16pSqHUJQ/jIJRzNpLsy8mqsK17XQSbj5qP4NsjNFExrf6rd5HkDDyvqB38a4umdtyL1XB1H/oBXDB6gIzusmeTYKd7G9AUhZ/6xTtPgyOC2kDcDluAwG/T0jM63LioaX5D9TEQoFAXRlu8ZOGE64XNCQcF5DfbRyi5s3qxSWemTTywzRsFzN2GJAYnAIdXiIzc/gAbZps8BXq3JfzrA3ccfh3QEaaYWBL7Ban7gFU6H6OMiNqZyCJJCGOO3sgS6Emz3/dsKvQrec9fA2XT7Vs6oZ2QFrM23WF2pEok+OObIeXAY5xdBQjqQ1O7UucvTgDvItlmxc4C0Kx2YYjk0JqpnYEWRU3F4ZFO4GaHWEUr85256OceHYOkrQiwWBM1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(36756003)(36860700001)(2616005)(70586007)(5660300002)(4326008)(6666004)(1076003)(8676002)(70206006)(508600001)(40460700003)(54906003)(8936002)(2906002)(86362001)(336012)(426003)(47076005)(26005)(6916009)(81166007)(356005)(82310400005)(186003)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:02:09.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ae3405-301f-4e24-c2a4-08da27fa51c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add new cmd for querying HPD state

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e24f117e831e..385c28238beb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -350,7 +350,7 @@ union dmub_fw_boot_options {
 		uint32_t power_optimization: 1;
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
-		uint32_t usb4_cm_version: 1; /**< USB4 CM Version */
+		uint32_t usb4_cm_version: 1; /**< 1 CM support */
 
 		uint32_t reserved : 17; /**< reserved */
 	} bits; /**< boot bits */
@@ -654,6 +654,10 @@ enum dmub_cmd_type {
 	 * Command type used for getting usbc cable ID
 	 */
 	DMUB_CMD_GET_USBC_CABLE_ID = 81,
+	/**
+	 * Command type used to query HPD state.
+	 */
+	DMUB_CMD__QUERY_HPD_STATE = 82,
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
@@ -1353,6 +1357,30 @@ struct dmub_rb_cmd_dp_set_config_reply {
 	struct set_config_reply_control_data set_config_reply_control;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__QUERY_HPD_STATE command.
+ */
+struct dmub_cmd_hpd_state_query_data {
+	uint8_t instance; /**< HPD instance or DPIA instance */
+	uint8_t result; /**< For returning HPD state */
+	enum aux_channel_type ch_type; /**< enum aux_channel_type */
+	enum aux_return_code_type status; /**< for returning the status of command */
+};
+
+/**
+ * Definition of a DMUB_CMD__QUERY_HPD_STATE command.
+ */
+struct dmub_rb_cmd_query_hpd_state {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__QUERY_HPD_STATE command.
+	 */
+	struct dmub_cmd_hpd_state_query_data data;
+};
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -2757,6 +2785,11 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD_GET_USBC_CABLE_ID command.
 	 */
 	struct dmub_rb_cmd_get_usbc_cable_id cable_id;
+
+	/**
+	 * Definition of a DMUB_CMD__QUERY_HPD_STATE command.
+	 */
+	struct dmub_rb_cmd_query_hpd_state query_hpd;
 };
 
 /**
-- 
2.36.0

