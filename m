Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAB0CCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C55012A8EC;
	Thu, 30 Jun 2022 19:14:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9886812A89D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcPs5nJVaw8EVjqjbe+BAZUegLKDJPHb398KMHERx9mz8GJByKQu2muQVdxZdmQHq9JVxA0GwKNbEhc29oMIkWjPSrK44w6PO9Ww6bP1n2wDas3j20PbgOEd4/OuYLG6JxQTY4JVN67CNSpv911nSMRShRJUJtch1kWIi2hS+PWBk7MPV0JDcfBH1mcb6C096gsPq14HWPrGGj9S8sBoRzM5ZPC/Q7glt+u4tOzn08OUBrKf671vBO5JBd8AUOPClTtreOVaKZO5E2QokzQQ+6mYRZhluqm3zrzq6qibZeGNsG8xZAkYgWPKFaJAM7wZeOZm4eCEk1hbCStPf0xraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4vNe//KrOHAGmLJa/sdGt9muBdfsrIZTKA7knfz1gw=;
 b=boI6938dzAanNI1ifg4AIERex46aEwI+qV2/5eS+b4yuDfV931ooRMtpB1rZ/uabacdFE5WWU07BWcrGNLYQpsZtbY9ku0RkZw7ZRFtZDWH0tdecJvCitX7l5+RUnlmd5GnLsIdcsXkTVVTS5LBvPUHph74/VbTgaDilgT7fRUDXV5pfPwQB62mcZgvm8v2U3TNs7OOUaf/rJD0wsAhhm43kv5pn8QEhJOvYt34EmbEmkmxlJ3Orauo6H48mUcYYfw2+kMQQl+TdliZamhnsT88kFMN6at+LqaRIxF9tC5Fe7/kBsk5bM1QaHMlSfhS6D3gCJFc608dE9dQ9hrkmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4vNe//KrOHAGmLJa/sdGt9muBdfsrIZTKA7knfz1gw=;
 b=3hU0IALFIMGP/XPbXm/x052P4z+xplMx5QMD8V5kUMzrl+JsSSpKTf0OaqPb+RLF7I7Nbb9O4BVeEnugM2vHyLOltGrI/FRCHrox02yc4lN5NbluWA6yK6nBhJhBoMS3bYzO8OhDoNoC8JJp/jlC0K5s0+JotoK6yIz7WoApFn0=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:17 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::83) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Thu, 30 Jun 2022 19:14:17 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/40] drm/amd/display: Remove configuration option for dpia
 hpd delay
Date: Thu, 30 Jun 2022 15:13:10 -0400
Message-ID: <20220630191322.909650-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f9a3521-1b10-42a8-f380-08da5accbaa6
X-MS-TrafficTypeDiagnostic: MN0PR12MB5930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFPQed9+8eWH0L+UBKETWYf7kctkMqLrXs/IvOcwPUIOqGKQCxSN2WF7V8Z3l80S26Xy2vs0xVHlJnEEE4huMJzzu1KV3GIQ09hrxUinsmYRoT6C2m2XIGdHVEBrsxdAiGbjOGsVuaYyd8DrLU79BuYXOrRHrqGnbSTOrC43VcpnyEodu3RuU4+M5DeeLCaGGE61sgWYHJBWlm+ra6gyKgr0CBXf3R+u+OnKUtPHu3UZaf9LnavzPGnxpoaxEgw/jtq5/m8/es2yK6e1/vKeO5HMYEvx+uKYdt1zcdpG46gzb+m/I81OVUvfN722itVAxUI8vsIxwn895K1LJXjU0GvnNFs+CGDw4kLePk6petSnEW+tE2d/UAr8oloMfPmMV2B/mzCjtCTryY8xpHL/kjeVNKXrli10mHtyrbWl4hkNEgwr2lOFta6HXEvI6Y97Cmo9wgSJPF44dGfEXHnRbAe43iBqU3jd6qvXYfDz0ld7tZx1+ADiayKxzHSkpppXcZWDOcwX2lEz1DuoU9hC5Fna7+doru8FbURoOpNYekamFezR4/e3xmHam6mxQ+SFnu/zjfGPuxvdowzoHzff5PuH87HZrD0cULG/pcR2pT/W1zmoKWPuPjKqvdtJkQyTw6420Hd47MF/BlP2QLF3ySh892e0D1m2WopT+hpdZoIJVJXK3iO6a66V9cOn6dpHceXdX/e4IhQAe/lkcedOUbbRm9tgOvOvkarFQXAh331C1WE+8coJhenGtXSbzPrI5CjULWuw0sINWJb4oqijVOPGuFN79AiVSStiM6AsPsN4EJ/yQh++iCMcdenGm5ipXqIRiMvFdqVCkT2GWG9OYgTfNq937Gpwguq49sTehs0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(186003)(16526019)(6916009)(316002)(36756003)(2906002)(41300700001)(7696005)(86362001)(54906003)(6666004)(2616005)(47076005)(426003)(336012)(82310400005)(81166007)(70586007)(70206006)(40480700001)(5660300002)(4326008)(8676002)(26005)(1076003)(8936002)(356005)(36860700001)(40460700003)(478600001)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:17.7053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9a3521-1b10-42a8-f380-08da5accbaa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
DC debug option to configure dpia hpd processing delay is not required.

[How]
Remove dc debug option for dpia hpd delay and also added log for
querying dpia hpd state.

Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h                | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 03f7249df1ef..c8610a5dedfa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -85,6 +85,13 @@ bool dc_link_dpia_query_hpd_status(struct dc_link *link)
 	if (dc_dmub_srv_cmd_with_reply_data(dmub_srv, &cmd) && cmd.query_hpd.data.status == AUX_RET_SUCCESS)
 		is_hpd_high = cmd.query_hpd.data.result;
 
+	DC_LOG_DEBUG("%s: link(%d) dpia(%d) cmd_status(%d) result(%d)\n",
+		__func__,
+		link->link_index,
+		link->link_id.enum_id - ENUM_ID_1,
+		cmd.query_hpd.data.status,
+		cmd.query_hpd.data.result);
+
 	return is_hpd_high;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6674edf69b87..30379e5ff898 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -542,9 +542,8 @@ union dpia_debug_options {
 		uint32_t force_non_lttpr:1; /* bit 1 */
 		uint32_t extend_aux_rd_interval:1; /* bit 2 */
 		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
-		uint32_t hpd_delay_in_ms:12; /* bits 4-15 */
-		uint32_t disable_force_tbt3_work_around:1; /* bit 16 */
-		uint32_t reserved:15;
+		uint32_t disable_force_tbt3_work_around:1; /* bit 4 */
+		uint32_t reserved:27;
 	} bits;
 	uint32_t raw;
 };
-- 
2.25.1

