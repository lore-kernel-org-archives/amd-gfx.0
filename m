Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A56AC48BC4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2742B10EE78;
	Mon, 12 Feb 2024 17:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWYYZVqu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5D010EE41
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIIKZ6VR9Nk9fIx6Zfx7lxNoQQWSjz2ABHbQ3ef+nm+bbOHIkdzc4w7u2yO6m+vpwoMJWvIgx2PFlDEDcny0xOw/CFy9Z6k4V+ChRMY53Nnx+cvwSD2S36v105mJrZrxMg7RP7sLMmCxOrrOxdHTnzvG1TSDQ/cPBJ+9txBWlY7w+wQh/Y4ecFMTl/bZoxZL0+idBzVTcqJJsEf0VSXYPNHmpK7ZOiGb1Rpl1UYI80rMff/9W6ZUdRA4GA7CO27E39DnB0Z6npnl8BlEatYldKeD1NBNDH/ppueAtvSqJN7oKLBwWgZ/vsYL5NZ4WYZ2emKC/t7PnYNaILTfF3hi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp4g8c4qwj6hoe0Sa/Y1GcWvOGumwKaS9vkMtoFSIIo=;
 b=nh/RZjucFFv4e8+PNNpW0cMxHPx3Ex8hsS4rHgLT/spJS8B4WB1FzjGVMyOme08ckWEoccdXwQkZYR5V5yWyaLCUj2/juTji9hVqc3sh9cYrHpv/3gTT+NyR4+NoWHl1KMsGLvmMEZUX2nqrwdqhSmzcvDFbAwutaxGn9i07iPWIIcpLmUs9vhxpFsr1xLJOigxezUI8s250FY8GeRtiVngQ7IpntevSBaOhMNBabAZ0TsoZuU7Q9D/LlyGlIhUgcaknz++ZMPgG1HRFfbzLa8DN5X/FWnRxQAqVtKmlCP881anNOv9eW9OICzGwEyQhbwAn/apXmhyOqIRI9E61Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp4g8c4qwj6hoe0Sa/Y1GcWvOGumwKaS9vkMtoFSIIo=;
 b=WWYYZVquaUsqMddTRLJFqzCqkHLwHqncXp4N1MO/gNcYr3oxPRSqQuZQ6Gfrqsrmx1KQXR5rOUGWPkgaCiE55nGXXrpEdUH7J8VH6H35nIa2hmhCEBYJWlYYbzIXF/2Ad7fbWLKJwIuMGxjrIBnnJhaJT61va2R4LEDF1Hi+OAc=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 17:59:07 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::f4) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: support psp ip block for psp v14
Date: Mon, 12 Feb 2024 12:58:44 -0500
Message-ID: <20240212175849.433812-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2c78b8-e706-4480-f6ee-08dc2bf44e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXjk+X0qdpG2hJ210r2tXdXtM+RufYB79FksiFO3KzexviYLGia9l2SLYt5g/nnxmohMfI9ryeaBZfEtNp9oYr4tR34vpZcCXlDZHcburyuofXk/+DurvRL+lc666+6ShCnUkQq5/P1AZDVE/GQkAi3/I9BceBnvOB3bu1bfo2/y8Np3KIVopYxGVYaTbJxOcfVRTYJnxGuP7tW74s3xB6FjLTrNnJ7Mdl/OFvyKgBc+PHyQok50+AYLQeFZLIY4+dvW8Ky0wlBln3t1ap5fC+A3R1RNAVPKI9qu/4pfzXMDk3MzYLM9zlZaU4lvCzFojheFNMYpckCQnR0UmQ/Y+BUtNnWmJyge8hMD5K6Ft+t85K3Z8oifoyax2TGk3HCmA7T/h8+kDlfV9SsMvvRBu5WtE77lbDXtyRrV5V8dSAdjkUUmtaETRzFNPFWOsXnX/dxlPu7xsxROJp9D3zlzGfd25n4jaoBevUDdKaPhbYF1UlC7Ym9HftIFNcYvnDy4Oyxo32wM1dl5FN+164pV+Uu+I5n+eP/RwBD8Yhzb70pKU/lkBBB9RmH3PdthHTZ4JbyopSfzz2LYRTUfPjGHUQepVI5k03t+AnFqLlGe80w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(41300700001)(7696005)(6666004)(478600001)(2906002)(54906003)(70586007)(70206006)(4326008)(5660300002)(1076003)(426003)(16526019)(336012)(26005)(2616005)(36756003)(86362001)(316002)(8936002)(8676002)(6916009)(356005)(82740400003)(81166007)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:06.6346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2c78b8-e706-4480-f6ee-08dc2bf44e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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

From: Likun Gao <Likun.Gao@amd.com>

Support PSP ip block for psp v14.
Add psp ip block for psp v14_0_2 and v14_0_3.

v2: sqaush in 14.0.3 firmware fix (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c  |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c09aac91889b..7e12c7b70418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,7 @@
 #include "psp_v12_0.h"
 #include "psp_v13_0.h"
 #include "psp_v13_0_4.h"
+#include "psp_v14_0.h"
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
@@ -224,6 +225,11 @@ static int psp_early_init(void *handle)
 		psp_v13_0_4_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
+	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
+		psp_v14_0_set_psp_funcs(psp);
+		psp->autoload_supported = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -3959,3 +3965,11 @@ const struct amdgpu_ip_block_version psp_v13_0_4_ip_block = {
 	.rev = 4,
 	.funcs = &psp_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version psp_v14_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 14,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &psp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 47ffaa796264..c24b1d7462ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -463,6 +463,7 @@ extern const struct amdgpu_ip_block_version psp_v11_0_8_ip_block;
 extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
+extern const struct amdgpu_ip_block_version psp_v14_0_ip_block;
 
 extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 			uint32_t field_val, uint32_t mask, bool check_changed);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 998758a1b209..78a95f8f370b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -32,6 +32,7 @@
 #include "mp/mp_14_0_2_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -61,6 +62,7 @@ static int psp_v14_0_init_microcode(struct psp_context *psp)
 
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-- 
2.42.0

