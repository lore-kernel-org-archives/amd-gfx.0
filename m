Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FFDC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872B620673
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t7Ng6Kkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872B620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DB66E039;
	Wed,  8 Jan 2020 15:35:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F3F6E039
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 15:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPk6lwJjpGn6C0UMv2TOd6R7145p3U67u3c/NOla3TDEpVVkwzJBjRnLBnrdJcqf37d4CM8XBRj4lI8pykwKdP2pVOAf4R7YnZwvCYxLz43lSayeJs8bHHgSbwEflgREhdIcE83gb0p3+j+7vtbqZse8HLhCfa0LtvmepHNic5zx+/s0vLjzql42lflJ8YdrvAevVeRNFjqT8X1kNnA573vr3Qk2E0Cj6U0rUBz0VW/iLgOi4A+tla1WDTBm2esTi4PNlOOD0Sfr/Cx5cSxJ9MucYIA5e5IVg4aGGUVIBv9i0Uafh6C0gxzL91tS+miQn2uOwaTUZ5EFmz6ZAdlrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mHGRW51qdAYfU+wb5aO+6tcFlXOmDBBRfxRmtumyRg=;
 b=dc+Z9DkpfhMq0Y8txvdhSzS5ugtG8QwzqI/5G8OSFFJ6tTK+/rnSkCrdDvICQsrQaBcE6iS4VcZenH/gcGSIxKnii5jZo83THTPV3WpETCRKoi2TcO3qUc/pxms4Qy3lgRS7rkqRzhchMO8N1Vr5TzVQi/HoR6l4ZccHlmLGVmdV2OMQKf6xhVUP1vlNdCJQXxZNA6nkcYh5+Y1i71ihoXonUdb4S7FGUZKCAhDe8v8sCXpF0gjCUNi+ptH6gsqlYxJnGjvkoH5JThExAlfUhMcO8rpdhXH95761SbzhzvHynLTb5SEZuAywUyinT1hgqdDdCJQAHejX3aUVQKfJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mHGRW51qdAYfU+wb5aO+6tcFlXOmDBBRfxRmtumyRg=;
 b=t7Ng6KkluzYqaAWmYThQfqFyIaBNK5TCjnrSZva7NfSzJO8+6fDKCG55FGJUpBhr0bv34Cfl8d5ZS5AgRNYldN7buqi79JptnoiXPEkX9XwzfCR4jbpsjvAQIAlZfHdou3p0d53GraB9Rn6zFzA1uZ9Ce4YnJIbXCWWSUCIPGvA=
Received: from SN1PR12CA0056.namprd12.prod.outlook.com (2603:10b6:802:20::27)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Wed, 8 Jan
 2020 15:35:16 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by SN1PR12CA0056.outlook.office365.com
 (2603:10b6:802:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend
 Transport; Wed, 8 Jan 2020 15:35:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 15:35:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 09:35:14 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 09:35:14 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 8 Jan 2020 09:35:14 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add Pollock IDs,
 fix Pollock & Dali clk mgr construct
Date: Wed, 8 Jan 2020 10:35:07 -0500
Message-ID: <20200108153507.21909-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(189003)(199004)(26005)(54906003)(2906002)(70586007)(316002)(5660300002)(186003)(478600001)(81156014)(7696005)(8936002)(81166006)(4326008)(36756003)(336012)(70206006)(426003)(86362001)(356004)(6666004)(1076003)(8676002)(2616005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2790; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf7b087-2955-405d-173e-08d794505c74
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27900D69BBAECCEDCC0A8B62F93E0@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGF2ZTha9Cg9fMLZdNzjONW5dtpfjtmWFYkBg9wz6PdspYdmykpYs+aAq2hZ0fQgDyvqQXo1SiTnd5UyFdEiKw5JbakpRROnQtHOu0R8FoeFT7EL5plBIDAaBpk7HUoeItMeUS16B1a31EDX2pXoEez3bjSGakoHYriayFDa/XPW/IQr0JSYL4g+VVxfyN9BVnpKKDmIaw9dojdhySomIUKKh9MLjf1uKp8B0BwcjtIcH/+FLTnjsUI7EYdf5AhbG2kB3FZz1/iiLu6a4Ju5jEzE0tmcOMtPJtdNovLiCGcg0K1menveCUc7loLnVqSms7mI7RyDIcBn8PQI1ErvwWe3q17aYwCJSov4LFSUB1CeetWrtWxMDHA8lHN7RVnintkGzi8aTyYZ2OcfjYRw4jKQokUE8UD58CngJoW3htfHCoRF9uVYYK9gL+WUNEi0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 15:35:16.4720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf7b087-2955-405d-173e-08d794505c74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
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
Cc: alexander.deucher@amd.com, Michael Strauss <michael.strauss@amd.com>,
 jordan.lazare@amd.com, harry.wentland@amd.com,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Only a single voltage level should be available to Pollock (min level)
Pollock & Dali get misidentified as Renoir, use wrong clk mgr constructor

[HOW]
Add provided Pollock IDs to ASIC Rev. ID list.
Create new Pollock ASIC RID check, fix RV2 & Dali ASIC checks.
Check RID and set max voltage level to 0 if Pollock is detected.
Work around broken ASICREV_IS_RENOIR, IS_RAVEN2, etc. checks by
performing Dali/Pollock checks before they can be misidentified as RN.

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  6 +++---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index e6c22345f0ea..a27d84ca15a5 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -705,8 +705,8 @@ static void hack_bounding_box(struct dcn_bw_internal_vars *v,
 
 unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev)
 {
-	/* for dali, the highest voltage level we want is 0 */
-	if (ASICREV_IS_DALI(hw_internal_rev))
+	/* for dali & pollock, the highest voltage level we want is 0 */
+	if (ASICREV_IS_POLLOCK(hw_internal_rev) || ASICREV_IS_DALI(hw_internal_rev))
 		return 0;
 
 	/* we are ok with all levels */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 6d60ef822619..a78e5c74c79c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -134,13 +134,13 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case FAMILY_RV:
-		if (ASICREV_IS_DALI(asic_id.hw_internal_rev)) {
+		if (ASICREV_IS_DALI(asic_id.hw_internal_rev) ||
+				ASICREV_IS_POLLOCK(asic_id.hw_internal_rev)) {
 			/* TEMP: this check has to come before ASICREV_IS_RENOIR */
-			/* which also incorrectly returns true for Dali */
+			/* which also incorrectly returns true for Dali/Pollock*/
 			rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
 			break;
 		}
-
 		if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev)) {
 			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			break;
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 11d7daf6f076..a2903985b9e8 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -134,8 +134,13 @@
 #define PICASSO_A0 0x41
 /* DCN1_01 */
 #define RAVEN2_A0 0x81
+#define RAVEN2_15D8_REV_94 0x94
+#define RAVEN2_15D8_REV_95 0x95
 #define RAVEN2_15D8_REV_E3 0xE3
 #define RAVEN2_15D8_REV_E4 0xE4
+#define RAVEN2_15D8_REV_E9 0xE9
+#define RAVEN2_15D8_REV_EA 0xEA
+#define RAVEN2_15D8_REV_EB 0xEB
 #define RAVEN1_F0 0xF0
 #define RAVEN_UNKNOWN 0xFF
 #ifndef ASICREV_IS_RAVEN
@@ -149,6 +154,11 @@
 #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
 #define ASICREV_IS_DALI(eChipRev) ((eChipRev == RAVEN2_15D8_REV_E3) \
 		|| (eChipRev == RAVEN2_15D8_REV_E4))
+#define ASICREV_IS_POLLOCK(eChipRev) (eChipRev == RAVEN2_15D8_REV_94 \
+		|| eChipRev == RAVEN2_15D8_REV_95 \
+			|| eChipRev == RAVEN2_15D8_REV_E9 \
+				|| eChipRev == RAVEN2_15D8_REV_EA \
+					|| eChipRev == RAVEN2_15D8_REV_EB)
 
 #define FAMILY_RV 142 /* DCN 1*/
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
