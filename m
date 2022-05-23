Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E36C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 15:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1356210F5D0;
	Mon, 23 May 2022 15:39:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9346410F5D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 15:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8rNBZuKWCHyCcpY2ub1pimws80imCz/wx/q4hBXjO18ihbX+zP2cAwgviRmYADiyIQZFECzfrW5LJTZa9hRmngzytbPJa7kbs/sMbiCICJ7TORDAWr3Nzd3wJ8Ts0UUy50iXONhvw+Vv96lUIIq0mz2VuoxvQYKiB+jRu21RzniPUG9CoD9XTbwG/SGB///mAeTeAHJ49gRgjQ0HNEhNsIMCCrR/aC5pLZYiaq0irelSKlsAqgXswsw8dLdHCsBZkVZW89hG+KgTKrLlWrg3HK1JKCK7wh0t3NEknbnamfh6uRYBI1cFeb7pyNS0xmmEEvnPvW/TrXk4q0PJcbvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/SMNH91nRnsevyg4nMicRj3XHLpe5AFs3NRUFasw8g=;
 b=KH7TOSICiIr77mkN0EbkVSIjdEBVSPVOoiI5qejzKSU1ruFdnSNrX2kPsFuaxXnLOIzevu3i6ZF27SYuAqBizCSr5bMc3hsp/EsgpFoUxEdywMdEBUDwJ+/gx/w12jvquCUoSeLF5ZyOBEvS/XFmkEjTUhfbePcTiWzYt3i2KdKn7hsqYKNbScmODvDj3xhFUtbSD/MF719XH6qc0o0y5E2hmA78kSwkdLwkP0fv0PBDYnUN4yrEFWHVj0BXQJnWJZIcznr5ex5Uak+e5h0WC1cy6rsgLzaH4+pdzyB/TFtTgNeLuZMibccPP5tdSOl+Uf6o7V2+7kHAzBdH7Atiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/SMNH91nRnsevyg4nMicRj3XHLpe5AFs3NRUFasw8g=;
 b=rqCvc6exsfAbD+XfO5H0mVVCF2o1k+Z/ZBqDQ/DlGFgESBAawxIWFwV/0ND45COm05qRinPpvUoJCq+nGdg59V5RTGkJOhxSz61sJDIrpbtiVI9XNtyEl7l6KVVzOHM5QMAMCk0789xa8FbQmzeNtv+kMg+QgRYIBOaZXvp0Uyo=
Received: from CO2PR04CA0186.namprd04.prod.outlook.com (2603:10b6:104:5::16)
 by BY5PR12MB4643.namprd12.prod.outlook.com (2603:10b6:a03:1ff::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 15:39:34 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::5b) by CO2PR04CA0186.outlook.office365.com
 (2603:10b6:104:5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27 via Frontend
 Transport; Mon, 23 May 2022 15:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 15:39:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 10:39:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: differenciate between LP and non-LP DDR memory
Date: Mon, 23 May 2022 11:39:19 -0400
Message-ID: <20220523153919.1558019-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c9835c-ce66-433f-ba2e-08da3cd27024
X-MS-TrafficTypeDiagnostic: BY5PR12MB4643:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4643275F3D45E92B0BDDA8F7F7D49@BY5PR12MB4643.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZWUE+dfhw2LAZ04lxU9gFbPGEJ0BpKtkQsPATHo1KVVXfOXIo4w3qCAm4jalUEkz6uPTF6ksacrrCkZzwbg648MbC2ULQUObW9aDyIQ0Nn5FOSYeWs7iQr2aEt1HnmIqOs4uPAHFfhx+okU8i9/RxdooGtcw/H85aOXc+qKykb9VoWMq1bOS6ZSE2VfzWEdFi3PxXXaxxF/X38ktUh2HhUUeyW81cxmbJxppsCQE4r92OFBJjtDu6M2bIAf5FL6yfnVhRyW7kQNqtbEibKxzA+zl+YVTbcAe1CHkubba/C5fDSZiIpTNYokZyCyl1Ng0PXC11yhGYIXowDLiFdbvoyR4vZYWXhAt68H9cI0LpW8ezj6/ZMUmau1SC2CiefbqwOOBBOa3KiZb18cgWhKB6N5A9iifKYrYl9OlSa4JzJNR4BMetdWexwe3P5zoC47o6mWZ2YO6cLkW9lc1qLpGXA+wHWG51vSjpTQFDS8Rf6cnBNlMopFxDjC+DGxUATnTXBPMEH+f07UI9rzb63JTgdtcBJSH5IAGwrCRzUmUBL6LjNU/ns4p+Y6I8qDSwcb+WAF6l6BAaLUOH7yU02ZrVffiC/xRsKJvoSonrg6cOPMPs2ACD46JywMD8qbAsIkgGylNwMTSwJJRvSYN8zKk1mYwhnVB3vMzmriGGozp3Pn6brGPzNG+2idUZrqmFxud83dXF7jYCix+3IQRmwZRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(6666004)(356005)(81166007)(7696005)(36756003)(83380400001)(2906002)(508600001)(82310400005)(2616005)(16526019)(186003)(5660300002)(36860700001)(8936002)(47076005)(40460700003)(336012)(426003)(86362001)(316002)(6916009)(70206006)(70586007)(4326008)(1076003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 15:39:34.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c9835c-ce66-433f-ba2e-08da3cd27024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4643
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

Some applications want to know whether the memory is LP or
not.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 4 +++-
 include/uapi/drm/amdgpu_drm.h                    | 2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 63e0293edc5f..fd8f3731758e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -188,13 +188,17 @@ static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
 			vram_type = AMDGPU_VRAM_TYPE_DDR3;
 			break;
 		case Ddr4MemType:
-		case LpDdr4MemType:
 			vram_type = AMDGPU_VRAM_TYPE_DDR4;
 			break;
+		case LpDdr4MemType:
+			vram_type = AMDGPU_VRAM_TYPE_LPDDR4;
+			break;
 		case Ddr5MemType:
-		case LpDdr5MemType:
 			vram_type = AMDGPU_VRAM_TYPE_DDR5;
 			break;
+		case LpDdr5MemType:
+			vram_type = AMDGPU_VRAM_TYPE_LPDDR5;
+			break;
 		default:
 			vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2780eb5b533a..0d3fd1db5474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1020,7 +1020,9 @@ static const char *amdgpu_vram_names[] = {
 	"DDR3",
 	"DDR4",
 	"GDDR6",
-	"DDR5"
+	"DDR5",
+	"LPDDR4",
+	"LPDDR5"
 };
 
 /**
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bb50644a2129..3a2674b4a2d9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -994,6 +994,8 @@ struct drm_amdgpu_info_vbios {
 #define AMDGPU_VRAM_TYPE_DDR4  8
 #define AMDGPU_VRAM_TYPE_GDDR6 9
 #define AMDGPU_VRAM_TYPE_DDR5  10
+#define AMDGPU_VRAM_TYPE_LPDDR4 11
+#define AMDGPU_VRAM_TYPE_LPDDR5 12
 
 struct drm_amdgpu_info_device {
 	/** PCI Device ID */
-- 
2.35.3

