Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE28EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03210E45D;
	Fri, 30 Jun 2023 11:56:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7E310E45B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcFeqxQFNPmAI4At1dy1+khyZ/BiBzHCxUb5/TTpO18DhawPz4UKORs4kswA4iFG+MQpEsNikXgfWRuW03OHMl/6zcvnufGuZDhHAsO5Y/VeOiykgLM7AOzoc6X4whGm3TVO/DdEKn4jVzD81oziU/OQi4PmBLYgaGk36tzH5hym2UBBpGvWVic+v085YfWvkcOP06AQk2s6+y5C2dnGrek+lfWDIGiXRH5eJDQmlQfjabl43S2en2YbXB17zt03Vqn1uoU9bTz1qBH7cZpz+2ujd16lQ2jNaCNxikcHFkf4TfUb0uAY852QDE6n4sxQVJr6didGv82uKHWCdpG2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1Xbg9OmllDg9gChXp3r4oE2jVqhTEg/B6n9Iy/rPgk=;
 b=Dlc6L/xDpkfa0DcIjb1PzEiX2Gdi+fiCX4Elz+QQh7NkNKm4XWzwPPZBthiGKrNyd/yHXfteksuqGOjChcyGXtm60zat1tprtkXqmXYH60yRTwRTakBPgXtmo8ymNlT9uLNh4XIbi3HimvINHAsa0gqrEHcK9aMCLYJnthA9bBKbJv3oPK7w00DSW668TKL7up5f5Hd4VDeOdKXsrEb2zG8imKhXdg4FdFqCOS9YzjK0Y1HAu6kQuC2T+QQzNW49NlHcf92lC5lA1j76qvPBn+Ox6x0T2dI91In7DNVGP0L8R41ME7CSdfkal5aAb0gKIVCVwXTIlFWEQlygLU2fdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1Xbg9OmllDg9gChXp3r4oE2jVqhTEg/B6n9Iy/rPgk=;
 b=YGHKiUKBOEOUfkDo1LnNgF3LLuQy5/6YwQqvxWCMx3R1oll1Bf5u7qLOh8xOkIdy4X10CJMZ6DkbjEwYip8+HFJCjKIBtHed9cnML+ox+c99rzfq2zoMB3UBQf7y1JblfilGp6DgVM52e5z10BJ6DQi3esiuRP1NI0BiuuZN8Iw=
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 11:56:41 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a1) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 11:56:41 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Fix warnings in gfxhub_ v3_0, v3_0_3.c
Date: Fri, 30 Jun 2023 17:26:16 +0530
Message-ID: <20230630115618.2855618-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c2c1e4-3453-42c2-a2a0-08db7961119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yQ5o9MT/yBE2SvV6UN/e9uPTLe+WQsyTOTVlMe+6D5BRh2/qQeIyITZD4iRTcyQm56wTsFAqx6/bEuqUDFZ+Fm4KGS7ACs+2us76VrL0NUEmUwbilhImD3c6UC3E7kTWWzpqK0fz8BD4UOSoalcjOpdsKc3uv1buQb2GseExU+e0Q2qQyRbjTzILKABUQ/aWpcKJbRkyhLqRg+4g3RST19k4WzVml71Y/5szRRWC4GqByHKQi4rUoaen87L9gRq691F68ux7kL/dEQa9Qf1Oez1rzbzsCXRHg68PMT1q/Tmt47tsHH2N8RzFpq8JG9dkeEcI8TXwd5BPg8DrSaZEAiqac776FaBrhgbyIScEiT0l4jwfOjzXDqocINJCAtIL8wRVKCkdWLMG/0XE9Vjg3cTPRo/tdgfvvIOKFkCUidhwDxC4eCug6asAaaabHopVPej9Rtw8RcnLSYfVZBNgkSat8vLrqmS6K92b2JECG9ml0b3n57HOoWXxZKsclDKFBN7YWHu9z73ktSIiTfRqHAcMsomRgD/Q7yaQIsi4SvPVIkyIQ0xDhwYLdkugR+RLI6ZU8Oc4avqjpia3rZHONGjd+Foy9H2HbMKbfoJpmZrPTcXRRaIaVSqq0KABDYKg2RaI+jM878r1OGEn96q61OvClnEq1Ezi6UYef5gmyI5iwU17otl5JD5otFHgIE3lPb1JsoCcMXecBMxuoCmUv7VnXHE6+voUlT5+GurEZC/5WJvQL52wIpdg3M65MoC98gACC51M2IfqAcJrJyrfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(8936002)(36860700001)(26005)(4326008)(36756003)(82740400003)(44832011)(47076005)(70206006)(66574015)(86362001)(41300700001)(8676002)(6636002)(40460700003)(316002)(81166007)(40480700001)(5660300002)(70586007)(110136005)(356005)(6666004)(16526019)(83380400001)(186003)(2906002)(1076003)(7696005)(2616005)(478600001)(54906003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:41.7051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c2c1e4-3453-42c2-a2a0-08db7961119f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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

Fix the below checkpatch warnings:

WARNING: static const char * array should probably be static const char * const
+static const char *gfxhub_client_ids[] = {

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned i;

WARNING: static const char * array should probably be static const char * const
+static const char *gfxhub_client_ids[] = {

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned i;

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index c53147f9c9fc..e1c76c070ba9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -30,7 +30,7 @@
 #include "navi10_enum.h"
 #include "soc15_common.h"
 
-static const char *gfxhub_client_ids[] = {
+static const char * const gfxhub_client_ids[] = {
 	"CB/DB",
 	"Reserved",
 	"GE1",
@@ -340,7 +340,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index ae777487d72e..07f369c7a1ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -33,7 +33,7 @@
 #define regGCVM_L2_CNTL4_DEFAULT		0x000000c1
 #define regGCVM_L2_CNTL5_DEFAULT		0x00003fe0
 
-static const char *gfxhub_client_ids[] = {
+static const char * const gfxhub_client_ids[] = {
 	"CB/DB",
 	"Reserved",
 	"GE1",
@@ -345,7 +345,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-- 
2.25.1

