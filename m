Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1BCC072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 15:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A90610E302;
	Fri, 17 Nov 2023 15:23:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1EB10E30F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 15:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCzb8DqC/3lqLjAz5g1ZEjTH9aTYHIAczj+fzyzUSw0JuZ1/wCyD1v/G+QbFLogOtvmih/lPSdaYa9wevfP/2pinlN2sPk26PYpwNh+JYUJoWHTaG/P1OIPdudedaiGjGNUGOe7T61QwU+omx4P5IlVaaWC97G55ibyo+HKOKY2zlUcInXUOXms+N1fqDOcQVh7sZhIisQ9PCD6HRcG0EnzKw+G60wDXKLucFfQvqu17bWVBgiaM2Q9qlWAkQ6Qm18Zt2oem/+RtT51Ci60LznLsVw1EkkyHnbWzRve2JVNqEzLUwW/JSl70R4Ox3dCgL8ywBmTP8OAzBWzpy2ArnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SbDp/cvL0z8o2iJpj/4lHHV+QMLm9iEUxb/gsn15t8=;
 b=Q9NaMy2eRGz+VS8z3XGP3RoZMqbjWwmDCvUzqkvxoY/TzoIdmXM1IrM49gAfZLGiTx9UDKf8RllCBzNYtLXOJiq/RqRSo6aosGjU2PRhxuU5KpwU8sb1kbmHK0jkhdV9DGddhYvv4G8IhBPeS/pCk7qsUus5FXPmrDWuJxXP8TYTMFMfn6cEL+Mfk5Fu+OoWmYepWnaF5oBRl9CXykvE84+WFAnQ6nNvLgJmCqcpSWXeGEQu0E6WbWI9fLuqIGqQhTDQHEqBfBsJ3RDzALLKiNmtZX8YNn6X650RjChK6ypah686v4ifiXx82g1EIMCbowxQ8NjM6vzUzxJLu8whhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SbDp/cvL0z8o2iJpj/4lHHV+QMLm9iEUxb/gsn15t8=;
 b=l+bb2ClrA6EUeQl5dbSYoGVp7iUebasHAQ4OKI6hC6cV8eV1bW5k+S+Qj+ttgTQiL4PlDQ+ITfl8IFeNuvoUne6RfWZ7clQXdiBDN4erm9pV0pkbuOR5wZ/X9R0QIq+CdxQu6GFD9jteJ4f9+b8stXTAB14966lPcq7XhChdsVE=
Received: from CY5PR17CA0046.namprd17.prod.outlook.com (2603:10b6:930:12::11)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 15:23:52 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::58) by CY5PR17CA0046.outlook.office365.com
 (2603:10b6:930:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 15:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 15:23:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 09:23:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/atom: fix vram_usagebyfirmware parsing
Date: Fri, 17 Nov 2023 10:23:38 -0500
Message-ID: <20231117152339.28627-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf74f73-ae68-433d-e370-08dbe78134ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9q/Rm4x7jI8NWe5EtyP4FUeTpnyD/e4Wvb39MGV3eV6lEdcNkSLR69AYSy0D4845GXmmfqvvGkQ2ri1FdEt6seNWZ7Dde7ZmUL7+HVwuuVaMFVIhOjPtlalXwckFYyey/vGxkyo/vun7KZbRU2LrOWy1HqHnfyUGhRT6zlEYStmu8UQh3tMj5M7rJM4dkOdKz9v1ticgib8mSnsgpEME+JhMs+PltllGPa1zg766Z6VzSi+oyNRdIrR1OwQ2HAgRbibt/0Dq1Zvy/jUc6XW8sIJ9/d2mMBGDt6+ef/VF/1Fwr0AnqXdBLiCfDSRr9IMy3LMgcfYG3NXLTdSvnNv+Gv7gqegjFgV1j6bkFby2a4VNT9z2PmLia6IlRrTdxWTktDBEyqvAeEaL2AaM4Dog8LUVboXgo6DWVh6jequJN/p2/vGInWhbEUHLiwmyQb6FoWU5KrUf27YL5nlmmJPyTpC2UicGwZBRpKp3Cjs1Wh3I1x4RyzyI55iz5cAvaX8LmKs50UTbINqqFBxwwqqJH8pFffnB6bKplhSi3585GfkhutFmCkMbnWDkjltGmWUXFHK3tMBpNTIodu/dDHNquR0RMAxO+hxY0KGP229xrLpLijxwMlnCu/tbLsoWAwC+qPPp+eR511WSYDIZzHLD/iXXAfW39gKZc6km/3UBaaIEaNFRZm2kAUNgk4VocTVBm4J4/2KKB2P/EWpkHcUo3reuiy9oRU9Ddwqu3dveN+9CILVPfdeOArMn+eML97yrSLUufdGzzZVq/5Yzgg4ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(83380400001)(16526019)(2616005)(7696005)(6666004)(1076003)(26005)(336012)(426003)(966005)(316002)(6916009)(70206006)(70586007)(47076005)(8676002)(8936002)(2906002)(5660300002)(86362001)(82740400003)(36860700001)(4326008)(40460700003)(41300700001)(81166007)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:23:52.2793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf74f73-ae68-433d-e370-08dbe78134ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107
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
2.41.0

