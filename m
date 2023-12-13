Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F85C4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF7210E867;
	Wed, 13 Dec 2023 21:26:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C159010E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSB7W8wgQvaibEn2fQzpoSkOLqBq+RkB4Fjt5eDiqNOeXTz3A78kya5vUhW/AXbD5I3TZYt/yeQ5FT+nW23uiSm6IxYOk/OiOVcxhMU37i2G1VNo42NqCwXSRqkZPwv/DNCXnIHg0XFFdUmpeWT84P3QaEWfK6OtcMWkgJWQg/4ds5SDFWg6r7ifxVG7hk7/F3E7SUw0/wO+MclI/JmKG+AZ1UbTz9umTCIsigd2wTT24U6AxSFLa+k7BwhzwpilQu3DmDMzwmWta0bghQmlK7LSRhX8BqCxlT51cmw2YlWKvD5sD6RMBtHcYhAcsoOHloxGGOWVTyNioe8xuF2xZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAgcMJD3aJMJo4w82DDkNkcT8nY+BnZ5OrXpfDqfwGM=;
 b=SSEeYN95ids/5hR8AI1M+zQfcO5NdWOLa84l1rkIgV7CDWRhMglHT1JoHS3sBhNYfuNmQXGY/EjdrpRApEbybj5yh/2qs2MevueeuiS2Z15JtrwcrXvc9YMbELN7I+b88uAx9b7Fvt+P4iwRqzZ+4RVj/0EGTDOhTKRcrppt7Zf/mMm87et7jvbRBEkaBhmdzfknXPG1iW99rsRuBiwmJW9xfXato0gz7I/DKMPga2CQ/whDRabJSFK/uABN1L548Cs+tVcFG/ufCdBanCvnbrPsywO3T6SoUeMvj/SGEVagEWkO0F7b86+H9fbIKpiiCU3VeFZBn3KeUYWLgTi10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAgcMJD3aJMJo4w82DDkNkcT8nY+BnZ5OrXpfDqfwGM=;
 b=sbphqkLyCVb25gNOgnidz6HN+2+DyDDZy8VkfH+N7tnjo+axIXKovFo4k/8iAOwUYtnA3drNidEmxmRGcYaQEPQLWo3+Ma3NB9YGCn0O6EiakudjqxHOWymm2yDxFAL75X23VJ29zwxODPyEaI4Mcor/PyM0Lv5kV67K/sWpFws=
Received: from CY5PR19CA0001.namprd19.prod.outlook.com (2603:10b6:930:15::15)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 21:26:13 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::a1) by CY5PR19CA0001.outlook.office365.com
 (2603:10b6:930:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:26:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:26:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/atom: fix vram_usagebyfirmware parsing
Date: Wed, 13 Dec 2023 16:25:57 -0500
Message-ID: <20231213212558.1965046-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a47e28-6218-4855-5ea4-08dbfc2221c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMXL5rlPD7pfneW9NoWyryhjU0Yjlq3eNcZtCUy5sPh17aqTCl7SDDF2WEPEU8PtJi+B6KKJKBtsGfLskxFGvaGqDzXKrxCynN8hCNBnfmIKSukhHnOZo2l/x9re87HhATJKYxIR//+t9GbJHTMXq25uuFpGEwu+B2O61RZjS9Awe8lvggpkKOY8zqYVmGxXrHpqvk4zrKsBTTeKRe1p1odc6jaWQqu8lFr5aiFAkE/vaWRN7K6pSFmrAKuVAqgw2M+4oRVJ+r8+Jsz3hI4cAfEU7qnlf5P5rYxxxmj3ep7Q6nJJ/qDTCgnA52xWO0kvP0VFoYL9Gz3H2Na9W+qsQ7WGPhV5lCxGoSXQvDN6kLZ9Mj67ctl0fe0Zj5+anJhEddEgm3gjv48z9YJkaGswM9MVLMIjm4mor+C1VyqSYu0t0jDrB8w5TrnvSnMXAYcget0QlgYewGZlvlqrQKbxGCK1nlJV9DZFKvXQFw/HW37zTzpBnPs1NSFvP2PwkgtqNb1PFDiu+aB8XZ9qrsCrcHr6GuYyTSLmgsr5yxbkM4mQ+SVdaqzTu78w5pM1pVgGX+b2UJWhTuoMgVcwFxgv9irFaipr2IhEVfC+tlf0HekT0xMXmiVzcL12tA64lxHeUwLRXCgCNPQIiGYsQHtd1VZ+urBSmt/n5lzuEqdLIFmUPIpXOuqewrmIsM727cXQOVyIOK4VHLfcavMFAfwVQdUAJjMoYKCh29t6Pq6GfhfPMyPqPcu7GhcR1zlMg7Dl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(426003)(16526019)(83380400001)(8676002)(1076003)(7696005)(2616005)(47076005)(36860700001)(5660300002)(41300700001)(4326008)(8936002)(2906002)(478600001)(336012)(26005)(966005)(6666004)(316002)(6916009)(70206006)(70586007)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:26:12.7568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a47e28-6218-4855-5ea4-08dbfc2221c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The changes to support vram_usagebyfirmware v2.2 changed the behavior
to explicitly match 2.1 for everything older rather than just using it
by default.  If the version is 2.2 or newer, use the 2.2 parsing, for
everything else, use the 2.1 parsing.  This restores the previous
behavior for tables that didn't explicitly match 2.1.

Fixes: 4864f2ee9ee2 ("drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2")
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1215802
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index fb2681dd6b33..d8393e3f2778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -181,18 +181,18 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 	int usage_bytes = 0;
 
 	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
-		if (frev == 2 && crev == 1) {
-			fw_usage_v2_1 =
-				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
-					fw_usage_v2_1,
-					&usage_bytes);
-		} else if (frev >= 2 && crev >= 2) {
+		if (frev >= 2 && crev >= 2) {
 			fw_usage_v2_2 =
 				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
 			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
-					fw_usage_v2_2,
-					&usage_bytes);
+							     fw_usage_v2_2,
+							     &usage_bytes);
+		} else {
+			fw_usage_v2_1 =
+				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+							     fw_usage_v2_1,
+							     &usage_bytes);
 		}
 	}
 
-- 
2.42.0

