Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C88C6FA8F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A1310E347;
	Tue, 29 Aug 2023 14:38:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3BD10E347
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kawed4KMvqFe2u6HID72v6waunqHCZwtqJ7ZPQVoz15wVYLaZmb9cJbSC5ImVq/dj7oOtyOfr3VcvoZaYkvKTpav79MT/lwvUCh1+6VTN08BribEaNnewotR4IVFidKKaylkpaVK8g+hShvCZaiggASVwRxP6uGRSa7QMczJzdNZKE04qPcOvWJNirKPXmzjLAOTvw99r0kNRrtVjjVJrcU0Mbs4fFxovVm4cVf5Vd63mypWCe0EIhaeLAedjnKDcc/220VbxwoIA/hKz56wgxR4Z+t99dd8hbm0qaZ3exSi1hiP0iOlmY73oCMg+XZJtzJUfkgNSxogrKt2wEgbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALoA2M0ZxFONC2tqs+aFcCMRy5AOUeAXc31IhJN4kIE=;
 b=LGP6FZTAEW1BxH1dUhr5qpRVejpJEXC1UmC6NXudAzkhnyzphGbvAL8e7s6ZDypxpnn7fuFuoFnKzlMwGxTY639h+Jb2DczpNJZ5e9Ew81Qig4kVsAtT57vMe4XBu06JkYTWOXg5jNNguuYohyy7dxedwOw5ZZ/ISKEq1HR1JFGsiAVzsjU+s+QvO7Nye22jPIssY/Bn7z7r1GCYy1vZn1qLBXomZXwfdyBtNqemKnkwz7pACw5oZ0VU4xSxrXLqg0Q6Jp2BvfZE3S8s/yUrt1cp/S4ktEqBWJFfmdrKwJR19F37kstzuCg7/viUpBwxFbfGM52eL4pY9Ej1ItD/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALoA2M0ZxFONC2tqs+aFcCMRy5AOUeAXc31IhJN4kIE=;
 b=N307GVmvXejAB39iVwYeLIlYofj+SyJePV4KkZ07d04wnQOfx7VwCm1eKC0pM1smiXAKhWzJH4Nw7mm6qYo95oJ2iT0Cd4JRhlFhvMsmjVnagFQ27T04F1lp/45ZqKhIVWL/fuuJVK8dP72CoEIB7/NPq3RsP8rTgNQl8G4rv/U=
Received: from SN7PR18CA0018.namprd18.prod.outlook.com (2603:10b6:806:f3::10)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 14:38:39 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::6c) by SN7PR18CA0018.outlook.office365.com
 (2603:10b6:806:f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 14:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 14:38:39 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 09:38:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Qingqing Zhuo" <Qingqing.Zhuo@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/display: Adjust kdoc for 'optc35_set_odm_combine'
Date: Tue, 29 Aug 2023 20:08:22 +0530
Message-ID: <20230829143822.1383741-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829045048.1369376-1-srinivasan.shanmugam@amd.com>
References: <20230829045048.1369376-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a8f9ab-cf6e-40c6-4d2a-08dba89da29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLAXOR35/6Z4/eRfpq4ohLxWsbrAHoqSrBZSPt1AaM9FDcfW+tN6acfLudEwGSeRnLU/1G5p1g82QpODYkW3xD8wFGViKBmQHfSP5lh2zPhfL4UlfQC8hPDW7gtZGo4PyX2Vmu0OsiqJhFlvSGI3JpTKrZwwXAWCmiSZSnXbWNoXXjo+rFtFu2HXhZu4tkiSdHhHk4ZwCKXbAcVKi+opxRX/PtL+c9GkbiOlAhd4ZcmfMQkOLpMJCR9W2hBmzNBP8ybkO42s0ab2oOmkhQJeagKDPS89P/dnPKTj3XN+4LlK3o2jwgZF3QDm3dekCpjrUdalS3WiMAwPe1OTIp7oHAMMZB0Fd82RKicMyZghTJ+7UCMgxnFsyoD1X451FxkrTQLTkDAfsjTv7rBB3BqssJ5q+exKLD/n6NWagd8iNQGH7DFCOTevRcqc0nyG5nfdmO9iz+jMf76Ywrm7cpNVfk76JEMIdIEmrOZ3uoArO78g19680M2Y3VSr69ygm0dkS5um3UJraVI6YXV/8/VrJPexGDSpaC36pH+FAiiDvzzu0cgTAoX5QkQ65AyUhrU6StiU8rWEhxd4Ds9Lk2tUN4pPyiWrdwruNO7swsrNPcT4fSjO332InEQMr6dheu6qoZuY4Xn/6XrtNVvRw9iyW7IOghTNR7/VhuQ3L2gSoDE+rTR6mVqaRyZzy27PRfopsohd2wFmU6jpRf/9xc21/sH4QV+wtkx+yh5Catzz8Mh5l/6H68yLpO7Foa2+eocJsJ7pe1ygfgLO96wuTNvGlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(8676002)(8936002)(4326008)(110136005)(36756003)(54906003)(316002)(6636002)(70206006)(70586007)(5660300002)(2906002)(44832011)(336012)(40460700003)(41300700001)(36860700001)(7696005)(26005)(16526019)(1076003)(426003)(40480700001)(82740400003)(81166007)(2616005)(478600001)(83380400001)(356005)(6666004)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:38:39.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a8f9ab-cf6e-40c6-4d2a-08dba89da29f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_optc.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
* Enable CRTC

Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

- Addressed the following comments (Rodrigo)
  - Updated Commit title to 'drm/amd/display: Adjust kdoc for 'optc35_set_odm_combine'
  - Updated the description for paramaters @optc, opp_id, opp_cnt.

 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
index 5f7adc83258b..d64be1a5071c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
@@ -43,10 +43,15 @@
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
 /**
- * Enable CRTC
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ * optc35_set_odm_combine() - Enable CRTC - call ASIC Control Object to enable Timing generator.
+ *
+ * @optc: Output Pipe Timing Combine instance reference.
+ * @opp_id: Output Plane Processor instance ID.
+ * @opp_cnt: Output Plane Processor count.
+ * @timing: Timing parameters used to configure DCN blocks.
+ *
+ * Return: void.
  */
-
 static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		struct dc_crtc_timing *timing)
 {
-- 
2.25.1

