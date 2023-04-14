Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E70C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCE910EE08;
	Fri, 14 Apr 2023 15:55:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8BC10EDF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4hpee/XYUAPSu3l2k1VOcHcCFmUJTWnNndJh67a/i71xvVPWMsSYT9y5KvRNMSyCtavG1LJAqTU5K7lWFS7e5wE5eWxlG1ale6PITYB2bQ5+MUq/ySF/trqOlWnRfKzxaT99UfEGgrkVtKgbZUkHKUrXCOzxYtgImeuvSOgfXrauwuob6QghRcd3Jnu/lpuDwmnkt08TLwXlXIbGlcy2yOFMFzLvhR1ObC/a8cc7cqAodAP7MkABwS10TkhP8/63Q8JXkYGQhMSNVN5LhfzbhfdO1NSsLTdc8l3gzXV5RlpjVztYpxFsy7niJ3w2giuwGh9KX6S03ylLUPzCS0tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/hjSSPqcALoa5jBbl+OlQEH+UMYfgVVavP5qkPTye0=;
 b=jNZm69EcKtWNPScZZDFULRoFkVR3292qqdB2lMh3Aq++ktzjDDUIZz5jq57f9Zhuq3oEgqLoebWKbkosLqBOwMJ6EEEsrW+APyp4FBVvn+7YM6K8ooiAa5t5muQishiW1R8MRAASOHcdzFYS4EEoKfkZCh8tujCw/0QlcCWGKCeag7wFDCR2PWYQrcKQO5dgEiOByRhWwFZYvj+27AjkBfxMLM5E07m4XV/BSiIARf090AiAIE2KHsAy24ZVHZtXr+4PcYQkR2QqTuONoXVa4ZprTGfPCnorBUoVOo8zUxfQBU2Dfn8RvNiSp56jUPIS/ieXzEr+OSjQZP4fjuhGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/hjSSPqcALoa5jBbl+OlQEH+UMYfgVVavP5qkPTye0=;
 b=PWY8m0Dtvm2P3hOMT63R6VOhOjUD6WbrUIf6XW06dVTJDzHkigLrpexSIf4QgZhaXsaoifBKJzu2VTqfIsOCu7gnbPza6dsEtAM61vmga2RTTV2Q4eUzoD+SzsTFBrmjcR5dEetG41CaMVu/x2zIO64lM0I5mnXuC0fzqravBIM=
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:21 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::28) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:55:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:19 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 62/66] drm/amd/display: Explicitly specify update type per
 plane info change
Date: Fri, 14 Apr 2023 11:53:26 -0400
Message-ID: <20230414155330.5215-63-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0b1645-33c5-4ccf-0dd5-08db3d00a69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywbYZmck8NDSZpIdFmA0LPxKLxyXuKxJA8hO5nhnbaQPBSmSgMAmwiQMrMyt8g+mDl3cwFQK9R+yTl6teQI3tCLMPsKpVHrsb6AbYaBtWBfeBc7dZEBR5zyDsDl6b74VLc6u49tS8WbtFUwrAcvvLATpd/rlrnbxPyeav/Jkeg+jRwNqojSWhREcorr4nGhwiDFQITZZ2m11He6qk/YXTsZpkJZyoWPOqluglp7NPy1gbGmB1s+Fzdk3BVMC1iiayTUaQ9I1wj27tMLPCt2+9ZyRDHKn7c9Xof/s8hwLjF1UOiSCbKP6aMX5LtbdUuEwLTshtE66WOdo3N+XSsti/NjdlGrEh4fs2QYybnNwdu02wVa06FQOiErhHyz+teHtJFcqC+j7Etnf+lF+e3GgPP3Aev30pi9y4oMlDy7nLeEqHqfEcN1+suGJGcsrl40jQg1hNaZOCDQt+OZNPdgU5y/oWa7ltubV1LlRDQ3PNWj+r/2hWnwt1TrQHMrogny6F25xgWcUMTtlf1XgMu7mwIVA98NyOP6a5EWLOIx8viKpAPSc332wdv4Fz6qdtYDDGvC3ttsEwGVdczUvX/46ATF6NFKzps9tj/pq5/jc8QsCzNR7rRHkBDYUpDCMoikRb/oBqOrGiNQ401cZ8sK68RlOfYL4zXOl+gCOcCvmxUN73F2OB3LRFrM5E4pB9i+T6dErtbwjbSMKArzJCEnxEeoA5en4+TmL7SCMUQSDdsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:20.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0b1645-33c5-4ccf-0dd5-08db3d00a69d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The bit for flip addr is being set causing the determination for
FAST vs MEDIUM to always return MEDIUM when plane info is provided
as a surface update. This causes extreme stuttering for the typical
atomic update path on Linux.

[How]
Don't use update_flags->raw for determining FAST vs MEDIUM. It's too
fragile to changes like this.

Explicitly specify the update type per update flag instead. It's not
as clever as checking the bits itself but at least it's correct.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 238a13266ad8..e65ba87ee2c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2482,9 +2482,6 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
-	if (u->flip_addr)
-		update_flags->bits.addr_update = 1;
-
 	if (!is_surface_in_context(context, u->surface) || u->surface->force_full_update) {
 		update_flags->raw = 0xFFFFFFFF;
 		return UPDATE_TYPE_FULL;
-- 
2.34.1

