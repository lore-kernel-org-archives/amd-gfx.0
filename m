Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A805FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 09:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1688514B0CF;
	Tue, 19 Jul 2022 09:33:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FF914B0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 09:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csv6AaOUaUf35xGWTkUcYL7sCHDlgIXXeWWgCFEVVFK9gzXuYhGRvfC+1OWgLqso/lZiwD2kfRcWF32feRqGMpadybVOCuRfxpNRm9m5v3S65l2ph1tuO77ccsyl4qLEcG9TWtdhnIlPYIPiZqljeQfaeMRB0jO2ZbtIivP0hCMEaPCGGj5id1m+yj3apT025Dzj0WF17Fybq4JyIK45q+sBggVrMlpHmdkjXLPfnbL3brz/+eE3cxEcAsT6htduo+W2SGSWf0vGZnqgRGWtncqOyVteN/M4xMoVxhGaNdAxXvGXWNiRol+/Xm9EigWeBB9afog+B+w9NWoFsQvoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGkkyTs8a2zScTDagQETfizJ7iojg15k+EKNxc3XDo4=;
 b=WNmxdsRYPFpzvfz66U6FYSVTndqfwVsWy0IQO2b1ZGtTx17MgUUOzZnK3+5WtXNIzprTB22CdCe2YWjyZCI3++pnDXaXdnIaV8dDLQavy/nidLRtuuK+05k6+nQg/+dhUaQJ3W9EGcmAnUNKMlyJKfcaIHLD8/W7IGCic5Lqp+0j6raLLy/Bew4TrZvnUJx4lXHDvPJrusMl6nGOGdLpgduND835FacZbsWhPjUPdfTSPd24mlBQEKaWj7mHSOQD5EjivnQ1CFGcl23iWkYf3ciYlgPzc5Yana/VlU+QKlmnTLBHalbx+WVVtb4w8LQtPZw7d1n4ZPIpSSKNDgTFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGkkyTs8a2zScTDagQETfizJ7iojg15k+EKNxc3XDo4=;
 b=DliCPBD5uYl6cqbOLdktfZP8D2RUd4d07loYUYXFHPJVSb/vtlmW+WVn+z0qOoUygH8cHCToYBd5NuSKn7cTxi7dpGYMvTgUezSzFQVkyyISlI9QPO9ZK5jMSe1OvtP3R8dqJYRkdKymz+beu+8157EuosPz6sqWdKOnir1CYa4=
Received: from DS7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:8:54::27) by
 BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 09:33:29 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d5) by DS7PR06CA0047.outlook.office365.com
 (2603:10b6:8:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Tue, 19 Jul 2022 09:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 09:33:28 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 04:33:25 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/pm: correct smu 13.0.0/7 mp1 state setup
Date: Tue, 19 Jul 2022 17:32:43 +0800
Message-ID: <20220719093244.27827-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220719093244.27827-1-evan.quan@amd.com>
References: <20220719093244.27827-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f2f1ab3-6337-4c99-ee82-08da6969bd05
X-MS-TrafficTypeDiagnostic: BY5PR12MB4887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfLCzJXEcCTlqvPbuyrlOLOnyCe9MFJymmtdG9kq4nHpG0hfRD4jGiIrZYqGGjuBhSbhdCiPr9V8QAwFXTFqylBEm9UfVT1MCx7j8FiTLiH9LNLvPATDK8kPCj3UOYOyZvheesE8qO0g2nZOey9vpDiZqXOWIXrgwiWBq+IkPtO/vGI7CUV9IGb1E3i+FV+ShgbxjLKI9uUTy2H0Xvfc1U7MyIxX/t0dCDiEnZQSYypemWGevbuCU6Mtj0n8AOlfiS0YtGerQpNlXhcPviJcvFbrzC0IleCNWzO9SUa/PoCmkxAmLXujU9h1DgR2TkIFxUYBbcZXO7bHrsyAZGxv9H/97lWfTE+37ap1ECG8Y8pxkcn58aVw2jJkcv6Tvn5Cbw1dunGPqD6sDL0RpoP/AWACCA4pus/mb+rWqor45RqWZSa8pDTgIqzCqVr2yj9sPRK/3JvCXWNc6cFgcxTUSy0glM5GEmP1O2q8GquBFYfsKmLXhbJq4PIsZUufwAMGzqZuT+9f3kntmJIH+GRADthvqupwRYLvWlyXeo8FpHwo+jnsmHoMSESiMp1q/cnghpvAeBsyEkKVvsmycTJyTqWl6DBfKqipz7dJJlqWoEZq3V74bboNFH9PPOBH94jUh/6QhgAerYYuC6vZeI94G3+s0t2WFyoQsrcyS3HKd/hkH+lsCAEOEPBETgwtFX+KaABwD3Z0PQsVKkbWsKVIJ4WCMbHCZKlvTkp+q6d7QWzASf1EZjjWlf6Ts5BPuqrxwSF44t9UMzXYH6iFGLdOVoF3XjNI4QIyoJeQ1oPNZgcEF90Tc5sMYT63SAwN7/S/0v2NxrrfoY9bZiwaZNfavQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(40470700004)(36840700001)(6666004)(478600001)(41300700001)(336012)(2616005)(16526019)(186003)(1076003)(81166007)(7696005)(356005)(36860700001)(83380400001)(47076005)(426003)(82740400003)(26005)(44832011)(2906002)(6916009)(8936002)(5660300002)(36756003)(4326008)(86362001)(316002)(82310400005)(8676002)(40480700001)(70586007)(40460700003)(54906003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:33:28.9174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2f1ab3-6337-4c99-ee82-08da6969bd05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only PP_MP1_STATE_UNLOAD is supported for now. For other mp1 state, we
should just ignore it. Otherwise, there will be errors coming out.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I15427d6daf14d5c82a6e7f9d32fdea60a80fd0ec
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 19 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 19 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fe7528c83843..1e0109c10e06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1608,6 +1608,23 @@ static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 	return true;
 }
 
+static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
+				     enum pp_mp1_state mp1_state)
+{
+	int ret;
+
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		break;
+	default:
+		/* Ignore others */
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1672,7 +1689,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
-	.set_mp1_state = smu_cmn_set_mp1_state,
+	.set_mp1_state = smu_v13_0_0_set_mp1_state,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3358be877b56..ea99c38d4e55 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1554,6 +1554,23 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	return ret;
 }
 
+static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
+				     enum pp_mp1_state mp1_state)
+{
+	int ret;
+
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		break;
+	default:
+		/* Ignore others */
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1611,7 +1628,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
-	.set_mp1_state = smu_cmn_set_mp1_state,
+	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

