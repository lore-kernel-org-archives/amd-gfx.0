Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E6CD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4120F10E5F7;
	Tue, 19 May 2026 22:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tLfMgyRG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4E210E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNrMSUO3+sY2JpkWmToCJiZFpgGOJdEjlll1a9zuiVsygH9CPJKZUCtyeWP2COA5ZygVB5OZWEcHGPhVbYsdNKwuw6qnYEgzPWAFvLNdQJtDMqrxDF1KzYo3zjoYHZyOO3BOhbsY5fT0AIXyfknxSPDcy91J2mWAkbVY221pEQSRelNwOwDn8dbW8i8vRq40K0DrcxB6mhDMT2tQWu7UHnN6ZM4OXVn5KEfBx6dqWCNLy4W7m2WwPw9MPwK9jJXTXPdi3Pr7DK/94m2PKgBAe2baCfbprM6xxd8OxFK/mbdB+sw/8td+aJ7m1+f/qzBnlbRjLqVVYfCfBWN0zmvd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjBnv5GN3Z7dZ1XLDwMDntikyedVEQ67lilkvLK4bGA=;
 b=SK/aUndXxQphv+OgIaYIJ7sA0V5WQqsGyRYe559gNrJqPGI70Nua+63rHCigCENFh/VaNWUws8U16wsNthIIiFA2scmzyAXoZ2Mc8N4M84y8xSub9cb6+yQegXRGCbDdiGf/BO2WK1oCByvP4m6+9ntUGR2velZwkSeoswfTRowfDrNwTk07LhotbYRlbn8RFdC5wiRMxqQr6Wut6zBJ0NLgG+qKcOgdb8B4bIU3nXWWVmesMAuTyoHMcPCeFYWOhXqbT1r30YX69rBk40YXmgTNO89QZXe9VJpS87Wj6OCdpiEskW7gzTicS3iAzh1p8+keswHwUduwXi8l+OFCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjBnv5GN3Z7dZ1XLDwMDntikyedVEQ67lilkvLK4bGA=;
 b=tLfMgyRG7uCw8r/oSHT/VcLkkSnWfa6T4D6A5DI0Hbh55NpkIyqXfFpp8t1ptK9ptbHjv1aeAiQmolU13eKii3CQoDWOrkfH89Vog6zBdCcrXVbUNEEocdDcIPog+ScWpnxnAbaaXMVziT5piEeCi8rl4x5zQDyRMM2Fse4+KDI=
Received: from PH7PR17CA0057.namprd17.prod.outlook.com (2603:10b6:510:325::6)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 22:06:19 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::1e) by PH7PR17CA0057.outlook.office365.com
 (2603:10b6:510:325::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 22:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Tue, 19 May 2026 22:06:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 17:06:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 17:06:10 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 19 May 2026 17:06:09 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Li <sunpeng.li@amd.com>, <Harry.Wentland@amd.com>,
 <Aurabindo.Pillai@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <michel.daenzer@mailbox.org>, <alexander.deucher@amd.com>
Subject: [PATCH v2 1/3] Revert "drm/amd/display: Restore 5s vbl offdelay for
 NV3x+ DGPUs"
Date: Tue, 19 May 2026 18:04:42 -0400
Message-ID: <20260519220529.202096-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519220529.202096-1-sunpeng.li@amd.com>
References: <20260519220529.202096-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf27699-88b8-4428-e429-08deb5f2db06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|32650700020|376014|30052699003|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: CJ3OQfeGAxuqUgeplkVoF706KneaStc5O5LY/6IfX4Nch2N7ph+Ile95zeHjhAR9iVPNXpjMexpZ9FPKy976ldqSCYGtuLj6W8PMX/mBUsp5S2XRVJaLl3be6nWX9EAVpMd9zqJXzTkqkt23U1YiXkKrpQGGu1Wn6ei0jHPD0mUnBY3XizHZrfcCIOzJExZMvrHt0+y7kQv83e2kVmjHRmKEkULydY9tfWn8jyk9SyE03Pcn5suwXm2XCJ9bT71ydjuSrZth9IDwcquwuhns8XQTTvktfIO4i9U0m5EWBPucqrykAFj6VP81pO4G00jEuBT0Td+lyMQhfu1XUMWHusSnhm9zKUk+EctDaUG2g8J/GbO33v8Cwq58zPzYwh5+5V8fonTfIfSI3RmEmGJ2FJVbIf7DyAJnbVPwNHjrkYfGKYzzv/klbyfAniNFDbNmnImPKl2Se7u8tpNpEzFSsBtEVlWLodKcq2178CyVctRA8yRDQLtGw5CiYip7NjMWnXxohCdWqZ5LilrYjwmdogBbf1FtvAYF7etNusm3kuyT6jDpvFkEtOxZU8kpigECg2XiAdjVJHjbYMoieAueDJ3TqeEs/EHwHwWdMNSYaOrBh4yZzyVR9b5B6Aa5etRuPfMzQRRRAjRIKNmUPFcQLzw/acnGpeDpCcCsqojZzyfqE0DuCkKbfsnz4kkh1+VBGvZPRpDTx7ZChQEiX/R+O91/sLhMB9eTPLozcLz3CqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(32650700020)(376014)(30052699003)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ACYOOnLsIL73/tfR7wZiO+oOg/zOiredVVDSyaGY8JZbNleNOMul3vrn1FBCjp4Z45DVEgYFtYbhVZa2D57YRUcGeA/5qYRUHARToeGOdwVov/1fvY6Kv8Ln+F/McNazq6vKQgI3992Rtxprtl4FVOkp0vcFBuy9aQ5Gc8Ex09AP81U5VBBXHR+axX/MhfnwJ8+73fw8PKFHxm+xGrWXi5lxEBC6jWa2UyDamqWvI0dt+VFTYP5wgJs8JEKhyTaOuXA1N7XHM4R8VPONZAiTuzD1f3e4/AhAvvK9EM1tJ5gWwL1tUx/mee23V+vS9UNjEPdEfLJ6HU+fcfaRC8yzrwelCJx1gOmbiGeT1H26PIR1e4mpupck4VYfH9Mazn0EiDj4Km/gKT6JJLh5i4tXWx+M9jSgu5topWLawBpxox/w3ywipzPEn0wko5YVQpEu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:06:19.3474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf27699-88b8-4428-e429-08deb5f2db06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4670252ede244..be9c4e094d8ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9518,21 +9518,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
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
2.53.0

