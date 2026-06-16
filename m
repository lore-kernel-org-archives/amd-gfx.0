Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA958CD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 20:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB0910ED8B;
	Tue, 16 Jun 2026 20:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M9DstfhG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5C610ED8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 20:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4W/c67ddLy4HfgReNhtB0guiHohRKTif2ULA8s+SwXlPOnoxHiAYM8qoiQKxdN5duMrCUbpDStAyyYUkmmpw0aFKvIP738pJxWEhFYvhkM+s4FiNLAGT+LYOthMMWrU0RvXchKZuNgOMGF/0BxS6oZlghHQjSFNUruHR/P76TntY6gNzhYey7HOX3CN7om5SokKz8Jkb/vCEFPjglur8z7AkTp4l9syblQ5AQfK/EiY8RmygB743vgMODPJgLE0/vTanMC//KUTrrX6HTNx+SSPUsHozRPZSyARxfqXrey5rW1uV6B7JnA7NiBlo/IeUV/WNHS83daNyBT6F5YFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DivVCBaeOcXgA3lVVXEPCAxuLEp3u1PJAVsU+XTiTd4=;
 b=HrFJYoCPrUpuzTVea3o+mHPIdLGNHswM7uoKtNgxXjNsw1RS9onxMtwnTaDn/YjpsIAD5JFJme2aKajU3IOUzBd7nGk7DHMMRb0rh4COdLZC5XOH4nQ4V/mPXv+IFKgvdAYhGBqUeTUMy0CD1Fsc4FE115Af1Ags7pkdKf2xPoz7zmHN0Y/HhFA7stp8QYXV3fuYTZZWKXYsubWfUzEEQlWCvg3Myb75hJ0V5bvLZwamW0ZkgV9DsSF96ej7s7m0DWtT4ZO/IveKum5ykANin8NoDLMCQl5wHslr0RUdFOnA+fUSOu7gMJm/AdsecuRIa1DSA7YJMcobLk6YHz7Efw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DivVCBaeOcXgA3lVVXEPCAxuLEp3u1PJAVsU+XTiTd4=;
 b=M9DstfhGrRjXv55VFX4+7v+P/sQ3LrkuHxidolFWDNO0nu5BqBGoZ8uWk+Byw/uiCkK3Pwly7K+WhtvG6VkoIlQSyUyxpz4nJ/HTREQ58Ae5vy/F1ZiRemO4PmeeRFuVugYJguRZ8mSfrATW4vuifogGqEj19ohRvpzV/AmxC74=
Received: from PH7PR02CA0023.namprd02.prod.outlook.com (2603:10b6:510:33d::30)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:19:00 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::86) by PH7PR02CA0023.outlook.office365.com
 (2603:10b6:510:33d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 20:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 20:18:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:18:58 -0500
Received: from flamewok (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 16 Jun 2026 15:18:57 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>, Leo Li
 <sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/3] Revert "drm/amd/display: Restore 5s vbl offdelay for
 NV3x+ DGPUs"
Date: Tue, 16 Jun 2026 16:18:28 -0400
Message-ID: <20260616201828.389985-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616201828.389985-1-sunpeng.li@amd.com>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ffd3d3-7f9f-42a4-3e90-08decbe47fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|32650700020|36860700016|1800799024|30052699003|23010399003|56012099006|11063799006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W43Z4B3bMzCaftnBWqQBE0b35nlwgyxxbHYLnL7KZlfjsM0eX3dtexBJjjnn03IlSNH1lvDiPL+yLFDY5BfIf1rPKDIbncQU4+Ab8Ya+RF3N2L8CoyzuvEdOFp/LGf4ZFEm6376welldkpFjxGg6i+PEyquyRkCjftHG2+1olmzeqWu+cJ2dwcODyxZGwz2eS2xfHXOUtrG0Z5qs5WDkFsuX4fYjTpEUtve4H+DkRmhYf53n0lHqx0uG64setPFShOOPvpGDtpJOH/We3TBs4I0KSTpCBiGNhc5F9QXfIdXvAr3sV+NJmxFmee9d44xMB40Q6+aueBAmMioAWgooG5yitSHgKPOYdzRojvv+Em6HrhaArPd9kGltKhVFQzijgfsH/E2+sebdsabikYXKbnKGYd3BLSLJjUfuEtTwsTkiSgimSSCoGdYN+gDMuedvTx895w/6pFQwxvomU7DIUvpeCKdFxIuL1gij7s245cMEvINJeBntkk2wLI9PpSEf6GwamyYCm8ZJKdMEPRnOQUS38m4kcz0VWlx0UOfkm+NckCP1CtC62hsNURvorafythXF6rUWFtsMD6T1gysLPMKty1/wCrz+1ZtR7gJMwXTzoWPPLIn+An0qWTYgOSeDNOi5Y3iNqV61614OEMO8masHH+msuBAJtG8PMuVgTo3741TVKzGYQJ7qPjCmcn9CS7r7a5y+MwsajTLIUlny8Td9ujayM3KvpFjar8XJNKY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(32650700020)(36860700016)(1800799024)(30052699003)(23010399003)(56012099006)(11063799006)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ibxjSQQEcsz3yTXI6ELVNjO4qSSMlOJfYJEMNOpTKsWX9qarf/xx3sXSyj7M/3s6s+QH2CNVN7z+RWWzDegFipB2346rXPwdbJDRcjTNEzWU6rM4Cb07K6liT6oqTWuWfpWf5sqjz+Bdy7vQS05z9Ig/2xXFoVzjqhehkaqke3OCPAiXpTlIAktq9nFFaRTAlAN1sd3L4DPjd3mkIgZ8NUYkgIfIJ/Nz3/5vafesOtxckK8Z9KFZChDYMEKzr7a0z1uhdmiGKfzS/9Q0D2uyvv1mrLt/366w+ycX2hvIctGldef+bGeM5aVzg4sXWXKE0qtFrNDC2L642BS/YGA/qzXLczmOnpXJ7NWJrREJCX2kTk+VE8t78PjECv/jm5QLqZ8yffrzUz2At0bvMAH3LKYeW3I3P6cKr0R+WNCyF5iwsKw8yLptdt2yWaQJSWeX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:18:59.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ffd3d3-7f9f-42a4-3e90-08decbe47fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

Now that proper fixes have been found, let's revert this workaround.

This reverts commit 751414c12388ff2b475e15c15d3c817dcf563635.

Cc: stable@vger.kernel.org
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 571198c46c0c2..26f4e21ef4349 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3527,21 +3527,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	if (acrtc_state) {
 		timing = &acrtc_state->stream->timing;
 
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
-		      IP_VERSION(3, 2, 0) &&
-		      !(adev->flags & AMD_IS_APU)) {
-			/*
-			 * DGPUs NV3x and newer that support idle optimizations
-			 * experience intermittent flip-done timeouts on cursor
-			 * updates. Restore 5s offdelay behavior for now.
-			 *
-			 * Discussion on the issue:
-			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
-			 */
-			config.offdelay_ms = 5000;
-			config.disable_immediate = false;
-		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-			     IP_VERSION(3, 5, 0)) {
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			   IP_VERSION(3, 5, 0) ||
+			   !(adev->flags & AMD_IS_APU)) {
 			/*
 			 * Older HW and DGPU have issues with instant off;
 			 * use a 2 frame offdelay.
-- 
2.54.0

