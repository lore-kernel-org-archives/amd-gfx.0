Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF57C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBA061207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCBA061207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E34F737D5;
	Thu,  4 Nov 2021 20:52:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1D6737A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0LQSjH5YK/UNfxAo+RKHvwJ2SKqGPKLR+BHeLV24eo16AN4dk4Dfwr3o0lyNeg+Y3Lrc/pTBSqOKuiRVgkNgPbyb9Er1iI/9Pz4aoleiM3i9pCJZq6htsJqr6UhStM1e2WvSOYVeoZab/vO6P8rvBIgRnCzUe0n+aXdHJaNzYtB+X8NB1dOC9QfaMr+wzbNa5FYce3UUjJfzZSUN2hz5tMZQU8t3mtEl6nVzmIZs9U/jxmU9fqgU69v4KShWG1vzZY1Gvsbs1HRduw48a9C1Czf0A94Dnh/v3th6balbzkKnVGP3gXsV+gGrbLbAsAJOgmADJX5doDMweSntlGjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngZvW/DOorT7I4jNUypdHilE6yiqE1VqTvU6qz5rsvQ=;
 b=QTABCkpU5+pL3j4MniOwPQYMCfEEOwLHI1o3Yf2TSxsDb6n+o0dnPkV0xjnNovYEGxfASBcwmz5M08SBhZ6zxHIiA/81ox11lq1rosr+Dh0nVemHiUafp3aCEvcIQnV0c4HV4pZhtAECdl9EyN+FtCr+7OBZVFk84fY0cIJPlyueaw5OUX04ybSudLcFIon7wPlcVFawj9noAw+cWLsHw9sLL12jAMkz6bPbdM6jaPkAa5gpm3dFFxmWuEu5mYRR2S3U6wtJ4dMWJQ3S4cnRW2zDGjKhhsy+QVkSPUdznit/zJ9ET3Qeq9bC10S/m/1jWATiFXHlqMmZ0qHThTyCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngZvW/DOorT7I4jNUypdHilE6yiqE1VqTvU6qz5rsvQ=;
 b=X6gJ971LMyo0t92JDRuLx/1emR7Ko0ctVITCHJ2FAOdtPJFdJrh/moVxI/O5BsNp8Ptvwvm0rB1bB6GONXbWFJ7RwoH8MQDAYgaXw08/JePTCEyl6iNSJntnyo0bho3cXNLSxkinULEi33rD+D0onDmjlYEwlsZDEVX0KrXPNgM=
Received: from DS7PR03CA0360.namprd03.prod.outlook.com (2603:10b6:8:55::33) by
 BYAPR12MB3157.namprd12.prod.outlook.com (2603:10b6:a03:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 4 Nov
 2021 20:52:49 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::fc) by DS7PR03CA0360.outlook.office365.com
 (2603:10b6:8:55::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:48 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:47 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:46 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: Fix Coverity Issues
Date: Thu, 4 Nov 2021 16:52:08 -0400
Message-ID: <20211104205215.1125899-16-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20e66c5-23b3-42cd-fec7-08d99fd50fb4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3157EAC1D2B6058168F5DD36EB8D9@BYAPR12MB3157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQTKBqNikOyZmi2bsMDCccMVQzAOg5BbQB+dxIS1AQA/2iZr4ObYFiVwmMx0sB01ORfYJ4956ClYk68URHs97EX9DbxnfyG6vPeCMUqF5Zi/dzwWICy+8LQ1PDnfmeu5nLHstU5ve1fo2HwP0QIoqeVRbhbbeLWSxWydrLKzsD3O8Gj2CQJBU4yqbNdvAde2QO5hIedwUH0Q99p0P+0G/ddlbsAottAKaYvhEgZ1sENrHoJhpm7s2dJdRDNDpyHZpX+9hLcEQR1fovK9s7xYqQhnzb5jSA47kAKphNpl6jkczScnFzAWr1QZqj6rJe4epeiGlCEFiJiFzoxEMkUFzg6+TMsPAAO49AdgtuoVdaTyO8HzNOh4/Gv1kAan/LA0RMndx/deW4gIyKK07sbi0csjisLSifRDIdX/8MASxfunm4/dril0iteUdL4bW9MgC7svRF9gWPGU6L/mSpYkcey7xAW7iHINrThlbVvxkAMdzOi0jgwsb4UPbKersRzmdh9CH5RoiQmpDl6twQAFpI2O6VMekEpu3AosEQ7sEY45xXXF1pThgaU63vXgiM6bXcvOTlpj6pUSkVfPjKQfs3hBCh1gJdpt/tL+Qzj6tc+DuVTTpNx+DuvkCJbc6H/XXGA2KJ1abRgwdggzK6zYL6j3WY6DiK+CBr+9fus/zMmwf5PIohDHfu2MR0hymHBPRw4oJSYEEHMKgNifrASO0gHY96B7x/L01Lm1mPtLjYo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(6666004)(81166007)(54906003)(316002)(2616005)(1076003)(508600001)(336012)(426003)(186003)(4326008)(8936002)(36756003)(26005)(8676002)(70586007)(6916009)(86362001)(82310400003)(70206006)(356005)(2906002)(7696005)(47076005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:48.9226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20e66c5-23b3-42cd-fec7-08d99fd50fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3157
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
 Chris Park <Chris.Park@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Coverity discovers holes in logic that
needs to be addressed for improved
code integrity.

[How]
Address issues found by coverity without
changing the actual logic.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 0321b4446e05..2d0f1f4a8fff 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -574,7 +574,7 @@ static bool decide_dsc_target_bpp_x16(
 	return *target_bpp_x16 != 0;
 }
 
-#define MIN_AVAILABLE_SLICES_SIZE  4
+#define MIN_AVAILABLE_SLICES_SIZE  6
 
 static int get_available_dsc_slices(union dsc_enc_slice_caps slice_caps, int *available_slices)
 {
@@ -860,6 +860,10 @@ static bool setup_dsc_config(
 		min_slices_h = 0; // DSC TODO: Maybe try increasing the number of slices first?
 
 	is_dsc_possible = (min_slices_h <= max_slices_h);
+
+	if (min_slices_h == 0 && max_slices_h == 0)
+		is_dsc_possible = false;
+
 	if (!is_dsc_possible)
 		goto done;
 
-- 
2.25.1

