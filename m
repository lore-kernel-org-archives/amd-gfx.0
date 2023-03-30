Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F101C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF96310EFF8;
	Thu, 30 Mar 2023 19:43:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D745910E2D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF6hwZ0dPPjDUBAI0Ft7+jmby/nHdhYOGWQoPFqsKCu5CQxlL/BOfgXygT2b1mHC+3tpCkKUgWi2OhuHARFcHC4eJmmGxRKdcI5ezlnFtWfV4YcV9EiEM3CfEX/wPlExp7yOO58qVan/ss8Y7UUY2mUVXACFttkcMuD5vw45Luc+dLMsYBAwnM91dVfqL2375239tgDod9VqLEw2KkeyCEnjjon0Q+PAociednfMGvWT18N5NKBVoHRWSoQ0b9QLRJj52dHmRuqbFWbbNDRSq9JRxdM3jTueYnZrwzV3cjbRAU02DyRMKQi5UTir7vjdWSeMVo1pdkP0r7dOdZpNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS//3KgB1SCBk2IcVuGkzLnWJvchDifWzTsQ8twDr8g=;
 b=UBpJp8Laup9jiXxrwLccK4r/rPgLeyqMxD7zIbYsGKw3WA7zyfmeY3wvpfW+WfdqTLEgWYpEhBv7XJ4Rz31ay2s5TW7lT7fs93SWTdZhPJLMHlkOqhbybZuBrypCmVcnIsXgmEGjBnvIEP9bw7atp8tXYZ7YDNezpcFw0toiRXL13R+v0tGAbUMQtk277Dl9FfHS5qO2s2jHCjzIQvZ5vHFrnfMOrRP5haFVbkPPQ+d8h/3udPuEWJO607jVaYpqEsfyWNu/gDrJFTCGRNSgANOdE3byPXjYxkuFuCfg320rkItRCmDFn3fUMgGcVv5M0lGQa7LZQmy6J9j6zlKbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS//3KgB1SCBk2IcVuGkzLnWJvchDifWzTsQ8twDr8g=;
 b=hfiGfqeU9MKS3/B10/dx1XalVoAaSybAC0ph4UiQrebShTmgB2dnG8FhoDAkymRF6Y7aK3YWb953enZNCIZi+D8WU5JPQ5MAPfILUqjFyEzMrkrTL8CBBbaKKdqMCa6huWuDRh7dVz16JtjL6H0NKwGJp0vdMYdNleX+SgvGd8I=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:42:57 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::f4) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/23] drm/amdgpu: Add FGCG logic for GFX v9.4.3
Date: Thu, 30 Mar 2023 15:42:29 -0400
Message-ID: <20230330194234.1135527-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2d5868-01e7-4159-2189-08db3156f664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTgpIav62rLtn6mP28PPLqyU/7aRK6JjyMSHlONQUt3jxlcrmwEUDJdEif6Dn04lIIyqpjYcW6qHde4Gz0ihS0SbAShIPwiLkRZlaMgEgwbViT4DYw+ltOYBnIADs5RbmXHus7c9nYc5T/rwTaeFCNhH6poEFYIRXtv8wTcP3qpCNSv+oulOt/YDFL/XvvSyWvU7Fj8RRKTjGFfcGR7ZyE7uCc++Spptu82/vQTtc4qU5ZVwso46MHVAlI3a4SgFZdX7GuHr3EdNytyDsEua+GZVJOQHFcahqWnBf6NTkjf2PqrHl6S3UJb1OT5MkVdghZEhtq7sqfgAwvb5NhHNizg5zmFJda5s/QfozJaJIpNYUwyeDUea0mFkGybflo/emWTRN/udBFej83NtiVl4MXzyBB1wzOblob9XM9WepBjcwesxywVhf1I22uRDF+/9TlDnuIDLmJGVkNiQUXvteQjEttTGSvhYBW4igTnAq4ylhkyU6ywBrA9JSE0wUuoVGm9K+McMmSHdbrKpcRCnxQaJ5fDtQdjGQjNC00DqJWKBmoVB8hxG4pnfwnCcqKXvnAHIieQNmMSZVmOja3RccKFO98UmlVuTfGmxtRg0zXbV6bJysiYXQmLqBl26GU1BFVwHBo3Odl7TKxvm+KdYknN+oOqFfjKp+EgDR4CDwkAMjR7JXSTJWNofth4AH6ORwsc3v2Hz3zzirIuwOKN1FMKWzkjChmA0yxaYswUSNP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(426003)(336012)(6666004)(4326008)(6916009)(356005)(8676002)(41300700001)(82740400003)(1076003)(82310400005)(26005)(40480700001)(2616005)(47076005)(86362001)(186003)(83380400001)(16526019)(7696005)(478600001)(36860700001)(36756003)(316002)(54906003)(40460700003)(81166007)(8936002)(2906002)(70586007)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:57.2825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2d5868-01e7-4159-2189-08db3156f664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add logic for fine grain clock gating logic for GFX v9.4.3. The feature
will be controlled using CG flags. Also, make a change so that RLC safe
mode entry/exit is done only once during CG update sequence.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 71 ++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f899f3f1f51d..f6fb0b01c086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2178,14 +2178,64 @@ static int gfx_v9_4_3_late_init(void *handle)
 	return 0;
 }
 
+static void gfx_v9_4_3_xcc_update_sram_fgcg(struct amdgpu_device *adev,
+					    bool enable, int xcc_id)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				  regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+			     regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+
+	if (enable)
+		data &= ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
+	else
+		data |= RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+}
+
+static void gfx_v9_4_3_xcc_update_repeater_fgcg(struct amdgpu_device *adev,
+						bool enable, int xcc_id)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_REPEATER_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				  regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_REP_FGCG_OVERRIDE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_REP_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+			     regRLC_CGTT_MGCG_OVERRIDE, data);
+}
+
 static void
 gfx_v9_4_3_xcc_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 						bool enable, int xcc_id)
 {
 	uint32_t data, def;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
-
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
@@ -2245,7 +2295,6 @@ gfx_v9_4_3_xcc_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 		}
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
 static void
@@ -2254,8 +2303,6 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
-
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -2298,13 +2345,18 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, data);
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
 static int gfx_v9_4_3_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 						  bool enable, int xcc_id)
 {
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+
 	if (enable) {
+		/* FGCG */
+		gfx_v9_4_3_xcc_update_sram_fgcg(adev, enable, xcc_id);
+		gfx_v9_4_3_xcc_update_repeater_fgcg(adev, enable, xcc_id);
+
 		/* CGCG/CGLS should be enabled after MGCG/MGLS
 		 * ===  MGCG + MGLS ===
 		 */
@@ -2322,7 +2374,14 @@ static int gfx_v9_4_3_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 		/* ===  MGCG + MGLS === */
 		gfx_v9_4_3_xcc_update_medium_grain_clock_gating(adev, enable,
 								xcc_id);
+
+		/* FGCG */
+		gfx_v9_4_3_xcc_update_sram_fgcg(adev, enable, xcc_id);
+		gfx_v9_4_3_xcc_update_repeater_fgcg(adev, enable, xcc_id);
 	}
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
+
 	return 0;
 }
 
-- 
2.39.2

