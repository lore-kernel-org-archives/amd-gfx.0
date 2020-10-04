Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F807C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B758206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z39FP5au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B758206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E5D89E1D;
	Sun,  4 Oct 2020 17:20:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2F789E1D
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLs2fA81DGgCUf1vHo1TZ4xkVLW5Io4R8/EUI7Qd1fcVNFfBhswSTHGAI61W8hF7P1k41g/czygIrCLxPXmWSxM9YIOH0g/vRUQRzsZlfzmkP2UHatJUXlPSCpuqbr4dMhJX8/hhrKWmgfpzbKdTyob1eVt0SU9qI+uilNZWNT/r+aAGWRm8z39dfCLHu78HtCOpPb1Y9fpnpHXXtuiCRIgp7iZ1azRBJr7MFQ4ByxUEDRUQwV6efYR/pTQtrnQ86puPiJjCWKJNR8I0VVnIxVLtA/hyQbqvthqFkDOmXe4qqwRcL1EjTlraMTsWUIWkxNJrqQCquR8MvXub/l31yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82YJqx7yirIw3wgubUjPLOS561oJzBzTuTSpuB3KX9Y=;
 b=lNOB1EKV1F6rjJOHG+c7n2gnrQaenP2ep7tak8paT626vjCVDQ71s6ieU9r4Akyk5cshiZiOGyaC0DgGaes7EgAdFvKruz3pwfLHUcPQNl3jRwk9ceTwRa1HCKrF9uNApZWB50nDwAFymzlsWUzttl68KEFhNx6f4en6B6LcC3igSjFS8B+wRkse1QTel0aHpLfFrlgLT9wsM6MGcSSPKRqy2ZkHkpUBLRLF78kIY7aNKtmANpQhUZEkQ2llsWICYF3hhv+TlVdTHO5yYvV6vwb26/DjOuO4SFR/nWzdRug2gwBpZFEAgOUzHvc18tCxZsb8OVJ0OzitEaDd7IOLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82YJqx7yirIw3wgubUjPLOS561oJzBzTuTSpuB3KX9Y=;
 b=Z39FP5auGu+hHIz612YzJw93Cc6Pp0JCNc5IPjPU7kEdO7ai1EDd8rDCXRnhxUJzdYhXZC/EjQOhOxGhO97MD1L2EVq1dHzaaVywE6Vzgl6azAe8s6T+s2j6s34DIHmHSbqr/NZeuM6ICpPxoaqs4BdVoePWMOOyQlGubm+Nayw=
Received: from MWHPR1401CA0013.namprd14.prod.outlook.com
 (2603:10b6:301:4b::23) by DM5PR12MB1788.namprd12.prod.outlook.com
 (2603:10b6:3:109::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Sun, 4 Oct
 2020 17:20:24 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::35) by MWHPR1401CA0013.outlook.office365.com
 (2603:10b6:301:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:23 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:22 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:20:16 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/18] drm/amd/display: [FW Promotion] Release 0.0.36
Date: Sun, 4 Oct 2020 13:18:11 -0400
Message-ID: <20201004171813.7819-17-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e901de-6f08-4515-af0a-08d86889c769
X-MS-TrafficTypeDiagnostic: DM5PR12MB1788:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1788E3A8996B0F79EF318A1EE50F0@DM5PR12MB1788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpMcNX8G0fO4UM0K/Qz5AY59a8tygI+g9SGCdXoGZHqH3w4fhvEEuvWh/ROOp1qt/pxoEnlIbTcDwIU9GB2rkUL7hXLrARbW/6FsRCgIEmWlnDCjG4P2t7S5J6SvxqT8xU8LQMDhFwZtG8SvQX87AwK8pQlfjZyVAUQAaQbdmD5cvsc9nERScQazZiqxxOtyYtAxqxy87aHhbj9q9Os3usFILHdSXoKXOqsPbMQn/SOphVwhxYnmXQUk04cWEdAUVv2IJ9TYMZkkNc2lxqXvQhAuHqB9NsNArVjprBlejQYVh0/NmKUmxkNrfYY647g3isTJDOvEURW7Bc0NgOBJXW4nnLUC9ZdOUEOopKWPXkO6qj3kKU2TIZhT+SYQ84Qk3E0RPY4AUyT6HimXXjIW1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39850400004)(46966005)(186003)(26005)(86362001)(5660300002)(8936002)(82740400003)(82310400003)(83380400001)(47076004)(8676002)(4744005)(356005)(336012)(54906003)(316002)(1076003)(36756003)(6666004)(44832011)(81166007)(6916009)(426003)(4326008)(70206006)(478600001)(2906002)(2616005)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:23.6526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e901de-6f08-4515-af0a-08d86889c769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d103ec1eaa73..26a4c6caf606 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x9cf8f05fe
+#define DMUB_FW_VERSION_GIT_HASH 0x959f9d769
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 35
+#define DMUB_FW_VERSION_REVISION 36
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
