Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E96C001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 09:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B240210E3C2;
	Tue, 25 Jul 2023 09:20:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E45910E3C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 09:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7ZCdoGk/lrAISNnrGJRmXALsjMP1MAotet80W2meNIxrcmQoBugY0ZGWf5AMazAf/H6DhPcWJ+JtiyR9jgfdQnXGMGJkLRAt4lBZZI9SQVic1430lkoyPvH+njJ9V38YT23IpBNg+52qDN7ZUINfH0zbrB3NC1WVJKIhOKA83c0MrxDLFlRXLnDZLsDfUOK3mksAHdIprL7mehjfeu+qlKlFimHqoWQ/V9z4aTDNd5h0EF9jBB+HlTt61dhq27U80DD8D+FgKApYT8hkYcHdBARF+/ySC4Wpn5yyRP0yOxy55C3UzewoYLcwqRPCrSYZGUwsYqDMDwK7gOhAgUUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDoF/rRqvuAQA6I6T7CI4f8El92xtkh+TiEG92B3iik=;
 b=c2X+NWd3NGQXxb8V1mdZLUY2adtrELmk0VBHLO52sY9NsBQ+N0uh6zX8kruDFup+AAepOI3olpRFLZHxM3WkomYwpBWWrefU5vMIb0LAslsowbtb91We5XpetPmgy+wn31fYG9AikjOWr4Hv/e1QyGfCnklm0dNMVqj3P2hlWUehRUwifQ+AEgh056B97ifxnhlOacAPMivo3J4t0CfvlTFsUov2hhB0oQvDd1occGANl1sKJ532+igM8f3djVKrEVon01Xx/wHAA9jPftIh3cbjYBrI9L19fOjbUfODr5m8A4YvPHJYF5Ey6oV1rCSKxCc8+QjwijBJ/bDU0+NLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDoF/rRqvuAQA6I6T7CI4f8El92xtkh+TiEG92B3iik=;
 b=eicbMbhiA5jB+Qxr2BG1c3hayLuGOsB0Fc0CjQ4r4CjstEQ/fj/wwglxyUlO8otAsrM9aHF24CPx85+u2yOSdfWOEnPAFui4alKiSmM9YWGTtZ72rqJ/7howVdb31v+x7k3hDAPRUdeLLrrLjVv9qRdhwlobkCjMdkw3VEvIu8I=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:20:32 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::39) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 09:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 09:20:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 04:20:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
Date: Tue, 25 Jul 2023 17:20:20 +0800
Message-ID: <20230725092020.3777355-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a28780-56aa-4413-2890-08db8cf06516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUnZ8eIL2oZuwsE5tzsbQZplD+GvGX5UDa0BOr2UDZqV38QqBqLxQ/rp3pIbc17IQEUgfLtvHoASe9lSTKIqklVk1TmWc8H1L90mtH1VuDK5eFsoH7xTm/MI2Na///cLMxcJmmm4z5UX2ZdK3z0BBEQb4HsIgv5jDkjJ+HNTk9Sfp6c6FM6Kss85//Sh0OeeaiioqYFeV3knOaS0zwsltCQOa/1W0rJiMPPUn94v9sDBJPcfMaQCHhTC0PpWOE11ukm/CAp6tyqQyTgcSVQk2+r7pgMXta2rdfZZWt7CfuQ7EIl9Ds10uF55sYbZBOgUjLYNMb1y1ppxnx6jc8I/uZYur1IdIcOD7Fst1D5X/CdFDLXiADgKml5AomIa5oyUydSINtJCf7ne28Ino5RsQ0Ck2nz8pYWIjgVtDDT41cQgJqqihSVdU2372TeNeHW3f9SLXm653C8n0YjSsvwXWOJA8k4epF//F5d32AgSH045FQ+ohdHRHpoYsyNRYMDf5QUAW9uafboIFEECJ9tju3snvIpmIOymnTq8eGwnroumhReBHB3mP7vDwRWkKJyPOkj+jslq1mQmzCITXGVPOSVeg+xNVpY7hi+Wf3QC3t7sM4HvLDFl34hOQZY5UMVSLRjT4ShEhIzwgw6/bsrMvdv+hSoAiuntXHRFG+n3VRbtaTs4zGE6TWbBzpTrhN9E9v11Agu/udhcFLkGO6VbaBOV6sUrPOQ+yc+/d0RspLPlI4mlbV4WBnYk1P1EChlVL1/3xtH3EvnFTsOZ45oTjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(336012)(26005)(186003)(1076003)(2906002)(82740400003)(86362001)(8936002)(36756003)(8676002)(478600001)(54906003)(7696005)(6666004)(356005)(16526019)(36860700001)(81166007)(6916009)(4326008)(5660300002)(40460700003)(41300700001)(316002)(70586007)(70206006)(47076005)(2616005)(426003)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 09:20:31.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a28780-56aa-4413-2890-08db8cf06516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now the SDMA firmware support SDMA MGCG properly,
so let's enable it from the driver side.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6853b93ac82e..9bf7872e260d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -901,7 +901,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
@@ -962,7 +963,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 809eca54fc61..f8b6a2637d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1653,6 +1653,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case IP_VERSION(5, 2, 5):
 	case IP_VERSION(5, 2, 6):
 	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 7):
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.34.1

