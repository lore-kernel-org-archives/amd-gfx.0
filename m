Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C262CC48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D0110E2B1;
	Wed, 14 Feb 2024 18:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/RtCRgH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A825810E617
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HljLeSV20uhRzbUY5iYVDiLfWC5pzC1gk9sflAW6ykRFEy+SkgBvuU9U/1O3jOcnyapNjwAQ8xh8+eriqX62AhMp7tTgNk9khtWccvYGJvlXJJWaufP4m1Yzojf+YL8d66pDbCxxG/QNvRB0QwadqBsR98tf3C9GZZVO5c9WjAKz2CYxA38INyKOZ2cNNscsd+fw6SfdskCqHLkOwnaPO74YgzkvsLTsAp+GlFHZm6W1xBjVIgZcdO7U6fSuGppLWyhIuYjvOJUe2/BwRDu5hswK5WNaH7Z7CcC0aPH6EOAfkybHtayaCZT1ei2o4GXiCycyiupatQYoXR+zo2bKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmb1wt0teM+Jpo60BM11Bw+EvAjGXKE0IH2lEadst0o=;
 b=VTGn5egordXdLsmaI8xkrUMPVBYjmFlQxgcCstT0gxKpmkbdvozmGaObmRcmBMW8ErFdcjif8H2gxSUHJwv3dyd5NB454CBDJMeX7TrsQ1MsMmuK1Mx/Nmz3vaiAZCTUvFpo7SsnfStXp+4uW/3RpMBt+Lj3sMkOa9CeT4GZigPbw9rbXAULp5WcznbO5AHzAKPiZOMZuox+Q0J9cYg811/cUiByx27Q3eGIJ1d/OcGEUhVNaRHaUeMHN9qtjZZZaq9oGjHO2gaTbbe/SxiN3qKYNUCQLh6sHUll37aU/oR8L9Fva6y96HM2jVDulKG1Or5mWgDx5Ls0DyAvA4Ub/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmb1wt0teM+Jpo60BM11Bw+EvAjGXKE0IH2lEadst0o=;
 b=O/RtCRgHqnt0O2gUL+eXQfikEcn3s9aNZdJ1409ICcdWdAaNlu4Ybm+tojA+do/f8H4+v7Vj7OK3QyOUywivQdtfzlCXw37XsZMLMKQcfw2JBogQVDUfpoCb6Il/BH/d3bGkFm3Bgs/vzI0AJUqruQMeYrrMu1KjYisgkFmFJts=
Received: from CH0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:610:e6::7)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 18:40:53 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::df) by CH0PR03CA0272.outlook.office365.com
 (2603:10b6:610:e6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:51 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Drop unnecessary header
Date: Wed, 14 Feb 2024 11:38:46 -0700
Message-ID: <20240214184006.1356137-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 549078b6-9672-423a-a6b6-08dc2d8c7948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejw6+n1OXg44OYLXxKtqDjtXkABbNdmU+UeBlY7qxUi2VG5L6rS08UJKsoYkUKpSzbc+8ExGV3UMvqSRkGSKqxvErw5R2sQbplsOT7ab9SQNtzCEFU8HXuQxcHBuBDqWGX69btccT4QAF+gGu7nF9Kyj1PdVkVLyuOUALw9Nv82mqinqOT+ARIazP+kkMi7G67kOR8oU9Wb31GLPMUCE+hrTtCWH3moWjWFYKKBmiN751rj49EbaSkXTz4xNPoe0YDlgnnhuuZV1JbtXLXl0BMAecVCvhH9+DvOox/OBfPAMixYMtpfiv+frvKLEtb3tzFc7ggh4hiVxw0wvvtxdP5tLnXienvYFKauK55+1CipMqJzuIHuLFC6sUGAIYoHu1y3iI3+8Y635NInFmLXwSVHoVi3qPXE6YATvk7Hhsu+8kKGqQXd8NOdQhzlUK/DsEkjh403q8WfLYJUUMKtgPIsaPRUu4mjjPdU99VHE1jat4ZqnXjnyo+H3oMI6pA+d83bMO9iD1yFnw6UAVjPxTzsfhWeuACOqWKkogKNiWa6gvH1JwMBFQqXNYg/Ou+qLAamthlFJI4whzna8seCZJeLUpU6b0qkCsfCWKisv35A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(82740400003)(83380400001)(356005)(1076003)(81166007)(8936002)(6666004)(26005)(478600001)(5660300002)(70586007)(8676002)(4326008)(2906002)(6916009)(426003)(70206006)(54906003)(36756003)(16526019)(336012)(86362001)(2616005)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:53.2462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549078b6-9672-423a-a6b6-08dc2d8c7948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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

A long time ago, the slab header was added to multiple files in DC. We
also included it in the os_types.h, which is included in many of those
DC files. At this point, there is no need to insert the slab.h header in
multiple files, so this commit drops those includes.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c              | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c               | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c     | 2 --
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c                 | 2 --
 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c   | 2 --
 drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c   | 2 --
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 --
 7 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index 39530b2ea495..b30c2cdc1a61 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "resource.h"
 #include "dm_services.h"
 #include "dce_calcs.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 86ee4fe4f5e3..9f0f25aee426 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dal_asic_id.h"
 #include "dc_types.h"
 #include "dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 60761ff3cbf1..2a74e2d74909 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "reg_helper.h"
 #include "core_types.h"
 #include "clk_mgr_internal.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 25ffc052d53b..99e17c164ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dm_helpers.h"
 #include "include/hdcp_msg_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index e8baafa02443..916f0c974637 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 03c5e8ff8cbd..42cdfe6c3538 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f9c5bc624be3..a2387cea1af9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -24,8 +24,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dc.h"
 
-- 
2.43.0

