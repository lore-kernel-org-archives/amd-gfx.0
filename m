Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9B8C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD0E10E5FC;
	Fri,  2 Jun 2023 15:02:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A350D10E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1UMkzXci99VFHPzZzAYtX8Tqdzq1hTAimxs0juNASxc6YlDEyEkX7r+0aKf6XuTCi6M3xYX40Wh//ln90JhTcMFpCpjg9ErNO7R5n5rdaSFAXlT7RNc4pP42Ce4APUsBriVapwnZDGHjKOD0z4AJ9OTnNwbFV+N3rOS6qI/MIEVDi2qqYbCL0CqmvhP2aHm/BNMhXCVTLIZZjLstzim7s6UmFNbMOCyT1XHv0tiY4+WHAvQlVIIJC94zdUDCX1otMdIMw6CcTCSwASy5EgLC92MzZaDrXkJfQWIVy5nhoEAsecdhzm1PgV6VBPCPtcMrR5FJCVhTLcZfaumB0xtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvs44cTeIQg1uonT1BlFYy0bX4A62/94pOezI/NjswI=;
 b=O+41FazBgp+ViM4wAnWrlWfKa7glbGG8to/XKWSqPmBFwDeHkPtxFIGNa7Nmm5fqj39nn+/dWbjCik/11a8ec8MWGi4pZIzMl0SqyS9RsrRCEI46EdL3HwUaP0x8In+89kqTQXbbhWAPbTNlG6g5rKvhLRC5wqAaWuepIXgV/7mQaph5e5qWuaMal19GsjSL1j6jXt6M3VAT466ZnWUwVWWZhclVxiT8yXayWksFi9+uYymQNO5DbvTTLMGcZ1iYBJUc/RwdPPFQpWXnzwjuOFGgofwdSWOo9CtwHTMoP2nDd5Xu5SR1Jn0JXoC4xYhq/Ap3cPTnLa2tCksP3D21lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvs44cTeIQg1uonT1BlFYy0bX4A62/94pOezI/NjswI=;
 b=Z4ZIlLX47nsCaDFcacWXEDwIFWcR9xiYTygWRHUasAxoY8EdV1TFSSujtO/ZX+zmiuggjDJlCKRriy4qQhukqNJ9uKXFo3syl0BHbxTXPIekT2IDhCCPydBcx5v3Uspvh6k63vupEHZOk4HevSMyhxB0Vp8/e7a0Yh0qPRa0JjM=
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:42::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 15:01:57 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c8) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 15:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.27 via Frontend Transport; Fri, 2 Jun 2023 15:01:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:01:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 08:01:44 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 2 Jun 2023 10:01:44 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally for DCN1+
Date: Fri, 2 Jun 2023 11:01:44 -0400
Message-ID: <20230602150144.259187-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d3371d-3ba5-472a-b621-08db637a4f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ommgaGQeIv0cTcgqsHjVTTq5Rvn4w7mRPp88cDWrSNTf6V6hDkaSaX5Tsy5gMZZgaUWB5cM05EB6Rq7qOVepobwqYkezmfgu3gPW2SvtX0Dd8LMMxUpiN/aLngtin58KSCK/SS4Os0iCEFwhOvl5J8B9IubrNgjkisegM6rE9P6GIrWxNDAsKgErnQG2eQk5Ae98D8pj7TC3Y0A7ZXfEu/T+WAObyHvEyyLYHP5BOOhsS5JNcWjyhLUem7D1PbiYa1EVdHM47ZfoB0qnN+kXdXkC5W1rTbAMkWKgopcTaoMgFAgFYxZnpXYuwSzXE6S3dR7mPThqhIo3vBj7ni5nO1biVcJWNLh5HiscwZCV9SRKy0ubOtqTaVp/LVarlMUvt1Z9TbSKgQ5BrT3VXS8gi6m8W9ZnkfaT+5fpL/Str67XM9ijT1Fs6YIm88AzEz+zdQ1aAxD84AZWXx8djqktuoVXzCEYOe7UC97oPGdTcptTMoXBe5lNHtXSLeDVkhRHy72LYRvTwVT+SMi58yIAATiqNwuMpKAKPfqiTA3AnXvi2kq0ht/FJ+4JKvM5LesHDYKzu2DQzMZlbqi+5WqhFwaTYsRzuES7DYvXGooHFSo4ypxV8y+aMPyYH+4nr1iAdSiiYPph6vNtlcjgl/a8gOlc4hKE3RA2GWqJeKteWy5nv5rv/iv1sSHKAf2g8cS8A4dJbKJIkS5F0zvzHh0Q2KtO2KSVSC3xgGvg9ARglT7dAycUp3n0qe7fIkVC0sxM3RzdFMr659sWB/g3tEFVnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(44832011)(47076005)(8676002)(8936002)(83380400001)(41300700001)(36756003)(6916009)(336012)(426003)(2616005)(4326008)(81166007)(316002)(36860700001)(70586007)(356005)(70206006)(26005)(1076003)(7696005)(86362001)(82740400003)(54906003)(82310400005)(40460700003)(5660300002)(186003)(40480700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:01:57.1617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d3371d-3ba5-472a-b621-08db637a4f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For FPO/FAMS, DMCUB will try to change the output timings by writing to
the OTG registers. However, the timings written directly to the OTG
registers will not be honoured unless VMIN/VMAX selector registers are
programmed with the right bits and trigger source is selected correctly.
Proper solution needs to go into DMCUB but will require additional state
tracking to ensure that the selectors are set and reset correctly as per
driver state. Until fix is merged into firmware, apply the workaround in
driver to unconditionally write OTG vmin/vmax selectors.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++------------
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 10 ++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index e1975991e075..633989fd2514 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -930,19 +930,10 @@ void optc1_set_drr(
 				OTG_FORCE_LOCK_ON_EVENT, 0,
 				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
 				OTG_SET_V_TOTAL_MIN_MASK, 0);
-
-		// Setup manual flow control for EOF via TRIG_A
-		optc->funcs->setup_manual_trigger(optc);
-
-	} else {
-		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-				OTG_SET_V_TOTAL_MIN_MASK, 0,
-				OTG_V_TOTAL_MIN_SEL, 0,
-				OTG_V_TOTAL_MAX_SEL, 0,
-				OTG_FORCE_LOCK_ON_EVENT, 0);
-
-		optc->funcs->set_vtotal_min_max(optc, 0, 0);
 	}
+
+	// Setup manual flow control for EOF via TRIG_A
+	optc->funcs->setup_manual_trigger(optc);
 }
 
 void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index e0edc163d767..8a93cba64630 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -455,6 +455,16 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	/* Set the min/max selectors unconditionally so that
+	 * DMCUB fw may change OTG timings when necessary
+	 * TODO: Remove the w/a after fixing the issue in DMCUB firmware
+	 */
+	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+		    OTG_V_TOTAL_MIN_SEL, 1,
+		    OTG_V_TOTAL_MAX_SEL, 1,
+		    OTG_FORCE_LOCK_ON_EVENT, 0,
+		    OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
+
 	REG_SET_8(OTG_TRIGA_CNTL, 0,
 			OTG_TRIGA_SOURCE_SELECT, 21,
 			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,
-- 
2.40.1

