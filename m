Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC12C6FA86
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF9D10E80E;
	Wed,  7 Sep 2022 18:12:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896C110E469
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGl/DBpbBaIB1H5n3fPdGg/4riHNWzayamPtZAfK/221047MgQME0kc7sZfXXCyo7WSu2B3YIuAeNGLKvYjUaKXWXIuYLNWGsIcEN7MG1DPPRIQhkzjjQid4Rn+8+iojHnJhxXO9xHV3hESl4Q3Zsjt7utKNWSDdtFt8PtzQ59ao7qi/8Fna1Br9Pbdnbbn8hlPHXH2+e1ZMtI4Dtnhz9BZ+uhjUw2ehEdISwPg9Kadxxl39EaX3tQHX2FM0e30IaXvoBkJcQnadCSSDifsi8QEBlm5dM9fq1Q/32WjaamI2n57kVXr0W0OF1HuKkncjYf6ldJET2PdfdD4UqrvRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfejwDJUXEGDQE2T1xH0vGE3UhUoktltnkNtg77HtjM=;
 b=g0EVpG18iQAbR4BhTa+iKZXcq0v9LaSnq6Qhhx/z6jzVqcfm8C3TinSOspHgE5SJImctFbWZPRU16d1nWmpFKwVnDgE4tVBAhtM5RtylhWkk9aPlz8Rr0RugqdFL/dhpD8jgAsuekAo47K7SVaEM2FK+hmNwGo4BwTAGeBRp8GGAx/MQio3uEHTdarXGmWf0GfzYDg1pGskfeVO/PG56IWiccwZC8+qtf6FasZ0VIst2rgG8GxNKwwXETDurQNAufEM0YFUl1idLnhdOUzpGqySpJaf6RfX05+qP7fV4q93DPAeMsUhRhqzC4OBgoq/QA3l28B0cUFV0G7WNxUoUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfejwDJUXEGDQE2T1xH0vGE3UhUoktltnkNtg77HtjM=;
 b=Y1eB9bdk8GFForTj39EnfVYaL3NogKK2rm11KJOi/5g6B9FSh+MXlU1FNoRx/wvLpoNqiNLYoqd4azgppp7poEPk6DlsagX0JLcXzeYRMJdZMP/30eZ/Uh6zKcz4G3zCEGJ+vfxvJ6EljOYQPLd8HSl6B5Fsnocp03QXqKu6zn4=
Received: from DM5PR07CA0081.namprd07.prod.outlook.com (2603:10b6:4:ad::46) by
 CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 7 Sep 2022 18:12:23 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::cc) by DM5PR07CA0081.outlook.office365.com
 (2603:10b6:4:ad::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:23 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:21 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: Enable dlg and vba compilation for
 dcn314
Date: Wed, 7 Sep 2022 14:11:46 -0400
Message-ID: <20220907181200.54726-7-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|CH0PR12MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: 0257abad-9e31-4d2c-3f06-08da90fc8350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYZzGpGAzvkprUVYZSCJrcnaYuFhm5TpmJXZiXq1YzAdcEHdvUcpG8+fzlGVJolm3u7VpAphWAWGkpiLQ8tpvdfwHzMD7Bm3+MwNMkXPIvzUb/o7Eq6CA1KIDCMAT+KeURfqvnM7LFojV9k0Id2VM7NDFNgk/w8s9ia6rAQGRTK3XVsSWzS3uTzymrKuQ0gCM1pq0opqsVtfwe+hlD4Vwbo5KUepf8I9keDfHnJS0CPLG/iRXNJpcBYvi2UHffUy4LjlN3+wjN2YUAKHgRxXjq+CtYZ2i2okx2G451r7xqR/Tee3ckBYmZ421x5eHaV7CEYHNLGxn0MsObl+5xk7MFZonfHs21olsQfp++SuOoAX+QEJpMaHPLH1uHDdoINSyQ9+6BMhE2ZSfTatSPE91L5m+6/Hnl8QEcbsYTdQiKSSvz618VFsGtfEdcV7fmyHb4VNLzJzKeo6VvaW6t5OahSP77lrGb42LQptJC+W6+VjvgrLE3cxVNPTkBqTjv28PjM/mrY1dbF9MncPqdtL6OeMQtcHllNbkn6kqNxaOQOmabAJrS7hAMNFG+HhYZ8uVdWhGCREM6+RbcCUYt1YMNfIfZ5e+q45xsy1MrX+oQD1mW/5i75y38ULK1BlzC0Wq4iphJQpzBYbF4TfodpyAPsNxcx+mBheugNUyaONbaGgcRKoyZI3bojpIITAVos9pqapUf/w5uMdAFEhtUlf/hpRYKNxm3jmcYkqr7Sfoc2vb6a1tXq0pnWqOllHWlDsj8nGc942GKclST0Y3MSZcVt1of1z0+upyCMaegrrqUeK5E/ecj5FKgEyTc7mvEZJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(46966006)(36840700001)(356005)(316002)(5660300002)(70206006)(36756003)(6916009)(54906003)(2906002)(40480700001)(4326008)(44832011)(70586007)(8676002)(8936002)(86362001)(478600001)(41300700001)(82310400005)(26005)(1076003)(6666004)(47076005)(2616005)(16526019)(426003)(336012)(186003)(81166007)(82740400003)(7696005)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:23.4641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257abad-9e31-4d2c-3f06-08da90fc8350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

We were not using the VBA and DLG files for DCN314, but the next
sequence of changes for DCN314 will require those files. This commit
adds the necessary files to the Makefile.

Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 86a3b5bfd699..cb81ed2fbd53 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -70,6 +70,8 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_ccflags)
@@ -123,6 +125,7 @@ DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/dcn30_fpu.o dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
+DML += dcn314/display_mode_vba_314.o dcn314/display_rq_dlg_calc_314.o
 DML += dcn32/display_mode_vba_32.o dcn32/display_rq_dlg_calc_32.o dcn32/display_mode_vba_util_32.o
 DML += dcn31/dcn31_fpu.o
 DML += dcn32/dcn32_fpu.o
-- 
2.34.1

