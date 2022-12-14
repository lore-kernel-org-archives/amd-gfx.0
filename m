Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EABC001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3BF10E486;
	Wed, 14 Dec 2022 20:22:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1A310E487
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqCK3aGKBY9HF7+XG8uRDDTrDuAauDncrzTuYT8aVTykNx3SR9TuZsewlrUN5FvU//h+5XTBxt4HC6tF5LKBUvZRtq+IqzyAnJ9Ig8w/WjZU0kr/KDWCDQNHiLf8XwG+7bNM7cvJzChuFfyBJU+TrEDDWqRamwEWD6jNdVRAQgO8nGFwPIU2Q1+4BcCw0A/cCNatEqMWPME+OC64uR8q6sx2jX/SQWaipv3aQjxWZpSdf3QPFXJMgm5sfp/SKocrIRcMttgKlcTfo0R2Ty0KhpcURq4AuO3on22XnJr1c4cbVPgECTLN8cNUPGIIkng5HUTd29dqXhq74YQGZ2XlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGv8g+mBqlkFKPp5uMb4YXr9+vfGMezOI7LZtySEowM=;
 b=ksPObmhqbcPicW59+Se1HUJawuy5eYERDdvj/YIxEDDG60z7AMTphSAENo+3t7ZouwQ4oaeD6FGlPRB5+dUY2VE7SO6v77iIrTlw3YZ3DRx00skK7GjJ595iqaL+G6LFJ1EI2KhvzHi+Ask8sWnS4RdZTEZNMOpgR4nJaeFeEePkwLZ3lgz3fPhFsB0l8qcitPrlUa/x2R2Av1MdbR6ABfxX3V/ImwDc4lpHwB4Jaiw5JIK/Itf2TgXBMRmNl9m0jrH7bQzPceudwLRUQ8g3IDt5Ij29TFu6QOBaQDN8rhM2ZrUun7nRXfCphVWak/ucCDHp74iSyj36wJuoh/gIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGv8g+mBqlkFKPp5uMb4YXr9+vfGMezOI7LZtySEowM=;
 b=HziBu9rOVZCidmVGvLGlrPhOQpYP44stdgFIZ3zG+jgObrE/qkQKF9gtoEsqqc5N0VBMxFoqm1l7kxIM9GYUOp0MzZitlENkM3KjrLKlSQeFyqvdr+GN2bi4aTaAkpVqTPJAgv5P6QdFRyt/mmY9LwzlBk280XMvK3uSjgF5sDY=
Received: from MW4PR04CA0056.namprd04.prod.outlook.com (2603:10b6:303:6a::31)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:21 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::f2) by MW4PR04CA0056.outlook.office365.com
 (2603:10b6:303:6a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:22:18 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:17 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/18] drm/amd/display: Reorder dc_state fields to optimize
 clearing the struct
Date: Wed, 14 Dec 2022 15:21:40 -0500
Message-ID: <20221214202141.1721178-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1679e4ef-c0ac-4475-6471-08dade10e754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMrWqdiu0je5lSZSMpGrPHiMiOPmUuovIQmqOFlTsVKRMXYEWarMfJBdW2neh8gzfqAR3XR8Kzb6eP+81doHhCeX8kC6SavntiFEWrvDKLSGShlXwSHdlUvwfTUqqICxl4NPEZqQhgiaZOsXT4WbPoxR3xbrdfZPisQLf8x9LLLdvo/6OSFqcNxrfoz9x4nLdoYQeXfGh8T8ufr44zAq3xyF6fVWDQ0V9Ce1mMrldFsZ8r/Sh7eluJCCotxl85kohji+wC4XDwUenySKCu3YSnpgR/7ffQTCGlhWphotsWfEhUmoh9el1TuSsxntRD9aEHQqhLLdBvJgFO/Qt+QmGO48sBzoX3s7oLMd7PtyWEO7UNfO3leCiTLbKyguA5q6qfEYNZjbtOawy1sDt/al6CtVu0qT3OV7EghoYkswtPdCm5R6prBAYgq2YdD/roaxTHLHrv/pVQGuMiZHKhApieegJ6oiob3J80EZSxddtiBglCt2Nq8HAGU15U+V34+aCAqyi6I/QlgVwfpuLcsCH2E7bsxxXZ4e8vqJkpIVklqLm4eofxOB2K0+lkDjLOAQ5AJq+dp/pbIA3ov1b4HIPbkjx618nspfMbsljHLPxCsW3uaW4GoUqOIdySUc7TeFBC/6tg9y7Ya8G92jS4v2u/66YAmcGWZE35dDXU4zcixj1Uuv5o5zy5inLopmljVx6+OEdlvzvnFM9UshWXsPyLYFMbvIf3XCZB0Ab/xBnk4gth+xtPtoVLctwgM051C0imXaRQl+fKixDhK3PkGOra4Go0Wxz8/ZL895QxEcUu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(54906003)(8676002)(70586007)(5660300002)(336012)(426003)(2616005)(70206006)(1076003)(47076005)(83380400001)(41300700001)(44832011)(4326008)(8936002)(36756003)(26005)(36860700001)(2906002)(316002)(7696005)(6916009)(86362001)(186003)(6666004)(82310400005)(40460700003)(356005)(40480700001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:20.6694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1679e4ef-c0ac-4475-6471-08dade10e754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why & how]
By moving bw_ctx field to the end of the dc_state the state can be
cleared more efficiently without resulting in large DML memcpy
operations, resulting in better mode enumeration performance on some
platforms.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/core_types.h    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 525f8f0b8732..b093ea495468 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -546,15 +546,6 @@ struct dc_state {
 	 */
 	struct resource_context res_ctx;
 
-	/**
-	 * @bw_ctx: The output from bandwidth and watermark calculations and the DML
-	 *
-	 * Each context must have its own instance of VBA, and in order to
-	 * initialize and obtain IP and SOC, the base DML instance from DC is
-	 * initially copied into every context.
-	 */
-	struct bw_context bw_ctx;
-
 	/**
 	 * @pp_display_cfg: PowerPlay clocks and settings
 	 * Note: this is a big struct, do *not* put on stack!
@@ -569,6 +560,15 @@ struct dc_state {
 
 	struct clk_mgr *clk_mgr;
 
+	/**
+	 * @bw_ctx: The output from bandwidth and watermark calculations and the DML
+	 *
+	 * Each context must have its own instance of VBA, and in order to
+	 * initialize and obtain IP and SOC, the base DML instance from DC is
+	 * initially copied into every context.
+	 */
+	struct bw_context bw_ctx;
+
 	/**
 	 * @refcount: refcount reference
 	 *
-- 
2.39.0

