Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F2CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 19:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E824D6EA73;
	Tue,  7 Dec 2021 19:33:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44AAE6EA73
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 19:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkt3S/lL8YqM6nJLXh3kjB3NsBW0JzMz+WEFhcdw+MkC+cg3yMt2u+rxfKZuVJZf0fQDhUd/dh+IQtkJU3RS7mF59A5RM1TTw9ciSw2L5otQyzgVNFU9f4tH9CrVdvEYIOkOz/COlcSJZ5pdUPKX8ed+bp8EMgTvOognqBwrItiYtuUjDVLV+jt2xsnUEwK7CIAf9lJfn6eiA6YitLBBWr8j2MrDY0vYhqD0McVd/Hj53cL6Ij7WW11DbdcBYm5/wPaCpvY9WJneC4ak2WQaSRcJ+QifQxAwTSI/HgOzqhIrsZxnwweN43bpmnD1hoPlQMvagsrIoH42FVWfuUIESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF03WTDzPC/oEDFMGNq+mI5GI69JLLVzpP503Etmtls=;
 b=dACWvcfnlFUH5l8rZl3WvYHbCdxaEcehuj6twifPbdz+MO4ODID9fLeKlk2gcB7Vn+n11i67fR1iV9OUPslLgcdJUtjc3huP83bZ0jEJkln7zPlpNim9RtxE+FPB/TnyyeK++psNbQET2tl7HapNltGOoGw83iFNPKd8CmCkP69voET796VGt+1C4GS2GZqkawSNhyrbKLf+pV1lYZyiJFlwHskqHHvdu4yQ8YYC7NXq98FLZONt3s9FroixrrBybUcp/4uujYDybAVirc66ukQENjeldxax7mcPpvObm6evy+Msbg2N7IENntt8j6O82pE2RxaLdCQ629C5xx+J5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF03WTDzPC/oEDFMGNq+mI5GI69JLLVzpP503Etmtls=;
 b=n6DevWoTDxDEnZIkmR055YEhWj7cTtg4013UGGRnvQ4teNtt+s3Ds0yuQ/Y1wbmlOq+ZVJ6ZjPJ+3IcJBEApm8rmzn6/VWnbOsI03xABtwtTgMhNrlaQQr6PVsPb0Lc3RMNTmiVXPT4Q6+YfnWXLkTGSctFIzMqBkfZQt3KR7yU=
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 CH2PR12MB3702.namprd12.prod.outlook.com (2603:10b6:610:27::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 19:18:27 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::17) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Tue, 7 Dec 2021 19:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 19:18:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 13:18:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 13:18:26 -0600
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 13:18:26 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix a missing prototype warning in DCN303
Date: Tue, 7 Dec 2021 14:18:25 -0500
Message-ID: <20211207191825.2463733-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83c5b46-b6fd-447c-0465-08d9b9b658bf
X-MS-TrafficTypeDiagnostic: CH2PR12MB3702:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3702AFDE0E60C3AD43F9ED4F8B6E9@CH2PR12MB3702.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwIKcCuCJZXsMOFo1jUpdC4B/nGraNN9aEWKJLm8vO75G4Yr7Ka9gLRlbWqypzzwXHC2qCsrYf95dNfWT4Jnzh2IqFpwWom9/5wEhVM5d8lZkJj8KC2uMDyGOWNAYM6V4Rmfx/q8tJPHWfSUKTL47jQDT7JKD0nQbG+tHDjEtcpakoJaPNDXmZzs896LyJGqkc/C0O25f8Kx3twaN+D19uq5dYNRu/kAOcW2aKYiWCZ5UGQW0rkyYlRHCjg+Sta03P6IrCKqzMQFNTStaq42iBIDyOH9MgfkfgayzwEgEpcTjgRnCMotnPScfu9HtHQC3ykvuLyO8Bfa2gAZS/LD58kPPgoQdzH3tzExWX5vZFilK8c/Z3hzbia2HfIpzD7ly7Cfw+8HUCaOX+1e0tu2XLjSPlfLqb1yldBLyrQx2V5O1bTqWfuCu7Huvd4Ebc/MExS8H8KgOWH7E8h51t7JyZR89vruJ6F2ib0xD97BYX/o03Lbd/4QPJUmBR5QOXCZLGH+KPkFagE3lekNc7xOPio5sOeBdKhKwlbT2pQGTlxgmTPexSh9g5lF3UJ7hq/ru73nGkAROV2LJYCuYagZdWZQ00yD4OT8jfezP7x6Axu1Yam0D7AudJ5eqvagiXN9XNW+PdcibzkPwxFJapBY+Z2k/hUid0s7Mgqs0zu2TZFFGlNcTJLyi2shXDUh3DyECClznutwy79W/kcN/pHYtTXcQ4Hdf21mgqmV3Ud5Bk3P09btSF1vU06J11NYL3ii6fKG0SSZOTgxuu1odPd+RBU5bbMf0mFb2qILw50z2cLP00bhZyQcH++4+1axUvpYYM3LkUOHO+oR4b3DntIZVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(86362001)(54906003)(4326008)(36860700001)(47076005)(508600001)(40460700001)(70206006)(1076003)(83380400001)(5660300002)(426003)(356005)(316002)(26005)(6916009)(70586007)(44832011)(36756003)(82310400004)(336012)(8936002)(186003)(2616005)(8676002)(81166007)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:18:27.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c5b46-b6fd-447c-0465-08d9b9b658bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3702
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
Cc: rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
A missing include statement triggered a warning when running
a build with W=1:

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c:30:6: warning: no previous prototype for 'dcn303_hw_sequencer_construct' [-Wmissing-prototypes]
      30 | void dcn303_hw_sequencer_construct(struct dc *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: cd6d421e3d1a (drm/amd/display: Initial DC support for Beige Goby)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
index aa5dbbade2bd..d59b24a972bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
@@ -7,6 +7,7 @@
 
 #include "dcn303_hwseq.h"
 #include "dcn30/dcn30_init.h"
+#include "dcn303_init.h"
 #include "dc.h"
 
 void dcn303_hw_sequencer_construct(struct dc *dc)
-- 
2.30.2

