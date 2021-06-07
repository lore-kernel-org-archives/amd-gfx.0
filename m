Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84726C47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508C260FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508C260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 190296E947;
	Mon,  7 Jun 2021 16:49:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2336E94A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc9j9ClouSIBosFRViR/SFj9LdEYWX+KN9D11sf34eRaFo+PHc4EX36rxFK8drBOsGJ6qR9tzrfpY4TwNlawK8NQcbI8E25W7RfuZDSXyd9mkPbGkZd96R31/BfJMo3bIo4KtJ1A5W/52uq32ur+bWjAWkVkS8dzP2PfvQtagL8el4r4slj2PP0eBjL651hGGq6JrC/uzPfHjsoRvNROjbakOoJA279ExkFEVN3ICw4iIICOPFyn4IOWzpYK4PlnZr49AwyvtCHbcVbBKZnQym+Hdrou53B8bnivgpdtwdAQsvXDDenSqJQq6xN0lEWulTQO36qNnX2WmI81lgfZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOv6y3aYfB5FgzPJ2dX1ogizuq9lcYeSS5OZtDTCYBA=;
 b=A7RrekClaAlwzVLhTMN/AmNWZ6KOC756ytkumle+yU0BI7UKPoTsFa0O7jdmwF4B6UAGMUlvndjndoHrU51f2nka6EOp+ji9zsxrWbJs6FqqmbEgnpCHFnuyT26uXOlkqnyeZ8rwS9wboDauYVK7Byy+knMJarOz9RfI7EnmjVkUoJ394MFEndNUCfjaEbJkDPHAEv7tc2za5Kzq8e3VKyf58a44ooPe76ttUD2bIY8z6v54ZWUT6TJ65KyVceUsAo8N3izG5FjkX2kHYsPoFdPwnvG85FcsarmOF7UIEZPxBSgEAbtDL5Exf1g5wznIzcOIjPkZVVRLKz/R1OOFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOv6y3aYfB5FgzPJ2dX1ogizuq9lcYeSS5OZtDTCYBA=;
 b=13edYvWDq/yTyn09WE0QFHuCNolw4gC6ChEZKs3I3FXQYsZBIMJq3dGEs7/z3SIus94x+0f0yrXy/+9lh1jDbQXhMX4d/cxXEOOoxgt3zVwQ/bSSdHXdJxHbVYoBAVAfJ97frCCPY9pqL9dwTLvIwaVXVPEE6w/UYIAA9ljV/ig=
Received: from BN6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:404:10a::11)
 by DM5PR1201MB0250.namprd12.prod.outlook.com (2603:10b6:4:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:24 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::c2) by BN6PR13CA0001.outlook.office365.com
 (2603:10b6:404:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:23 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:19 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/30] drm/amd/display: [FW Promotion] Release 0.0.69
Date: Tue, 8 Jun 2021 00:47:13 +0800
Message-ID: <20210607164714.311325-30-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d43b4f9d-5b1b-4c73-d409-08d929d43436
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0250:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB025043A7D933512C1E6B849EFF389@DM5PR1201MB0250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7cSwb7SAcgz7C8ii9GhEDfGvQLbpyDd+aGxu6dOMmifjNTR7QeUqaFOTxHHZyo3Wl1L6pT/fDIQvbJzQALNlWg1WSo2u/s14pExO6jakuKGYplEtTRozg8YdTqi5tgWIWxSAG7eQC39rW/SQF9bWhqLvO5D/cRgDBOthzU9eJRfs+gJMMM7p26guV9UchxEkVlOIDZmoiS33m3hOJndR+8TZ5ZFXxmu1mvq/k8ISG5knUAL5GuxFiKixfS5rsA+pZudHB80JPfRK8GULPZ0JN3ieF1XiHY9/w0gRq29CpmSwjODWvC3oG8cgn7cJP0IhvYXRnEva7roKQTTo+rnPHJHw5f86gmJdXNmRqs6RQ9Fh3coNNOZtG/jrUBBtoDJSrvTQoG0y1iU5SXvObMgYbvqDpEPNEl7gVsVPEKDvEc9s7z1T4vz/MgayF9OC25N08XqtnutMbWKSj4wSemnBCupUNUy42MylNWx5PklwIbb3jbc3h/aFPpnYLHqtan47VvyLdumBshdPH0MUOe/p5+ndkFqAKpo+cS33Qz+Qaximx2m4uoNJhI2UcYfxF7kQJ61CIW1foS/cs7bZSPtvbCueg9m9Tz5WU5cNN2MiqIC8pWOyAsCCzzkyAUrLUPeBW5YdeOQCahqicPJ35njzwgG0wCcPUuZvnzrox1rQBS2y3qNFDJ+nEMfkfmpRcNs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(47076005)(82310400003)(2906002)(316002)(82740400003)(8936002)(6666004)(81166007)(8676002)(86362001)(5660300002)(7696005)(83380400001)(186003)(16526019)(478600001)(336012)(4744005)(2616005)(26005)(36756003)(426003)(70206006)(70586007)(4326008)(44832011)(6916009)(36860700001)(1076003)(54906003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:23.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d43b4f9d-5b1b-4c73-d409-08d929d43436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0250
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7c95d6eb930a..a7a4360682f0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xeb3203315
+#define DMUB_FW_VERSION_GIT_HASH 0xefd666c1
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 68
+#define DMUB_FW_VERSION_REVISION 69
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
