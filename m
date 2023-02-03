Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22279C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC2410E892;
	Fri,  3 Feb 2023 19:09:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6C710E884
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcHkAP0AZrgHxycfaqiSmh3bCnGLW9dbXG/gt8aPrMzos+u8ke6opwc00MCzmnRB/1OFDUF1lsRG5IehbTWitU8fs/D7+wzOgXAr00sSDJ2kofyV/pjffzmI4C2g2QTqKXESoFuVyLIxirmop4h3kY77hXiD8hYhrD3sBFAS8kKTaeGZXU4qveTJEJPPnlrjY2ibEnnI3XlzkrFWALcWT8er0uLTUvdqmZDviZ6bZidT7U/LfeTxYFuXrejvhSlk53mlkNLjm4LPyC9oF35FCOMkvu+4Cv+MLrv+owEJv1PLQQIik7Vzqwk33K+HGp0agkTOWieWoFOQJIfcVjvKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0WYwAikaUppQfMNYh8uJxSEMnY/ZIpvZh4pgq1GCqw=;
 b=FpoHIv6Xi28WJCfgboxdcFX0Qxl7iNeiIfmgnmPQZha5GjZRAdnKXe/sDfyXz4QEkR66lLgYrCjDYltrXiVBvZb9Ut4Oj0nJTDuGkJiUUJzg2bIyPXDTexGaFAFyVi9m8IsJMQwZl0MF2yK/eviM+4RugGKvao6r0t5XuYFhtvzJkkwOqWX4TK76DRdnck69g/4UJUVYTVYYTp0B9lgfbCH9k4GsffWfiid2pAfpzemBLO69h3MfGROo6nZL6+0Ti+vozkJrjjt5tw6M2VjeKZ+2yFEKEwkM42kNbr7H4ek48QGAC62AtHmo9wQsgckK1FUtzU4my+zWvM/c5LBhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0WYwAikaUppQfMNYh8uJxSEMnY/ZIpvZh4pgq1GCqw=;
 b=sa8HtQ3JbPWRHPDETUdIH+r9zsBMA8Kd/d3G0pcTmH1Bp7w+8ai6vULgPcnNTDMWKRid6CONP6fVHXNpzxs4PvcJ8CoF1Wpubw8zcJ7spNxMig3LR1O5UAl1PO40qkHBMWCo6KwUDOkLWRtjmugzDD5UIoVFhH0MzTcFUnU4t3U=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31; Fri, 3 Feb 2023 19:09:13 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::c9) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:12 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amdgpu: add UAPI for allocating doorbell memory
Date: Fri, 3 Feb 2023 20:08:18 +0100
Message-ID: <20230203190836.1987-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bcbe2e-2ddc-491e-413e-08db061a235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smvYAE7MFegh2eTcTlDrLWJQSKFAUCujPMqo1vadxA/hNSYN69CljFW7Rwx6zNtBA00mZWtSuX74J84rjiy+7dwaqMIWr58UimX+c0LS+PLHNR6qG+09dhpqTMgjX96HYOPf5TmC24BMJ4khRNLu6A2CfRsBFT5Iof/Sb7tr8U0jGaQpbnQLU21lqksReAqMX9vNB6dvnbrtNTkJm1EVTlwG3p7caKFjkRXbHz+HZ5WpRpCfajixakn9SnaOEGB4tU3bF+C+gbPgd7mBkgstNZ5glf3kEziG1x347LTG9EPOA+wxHK8bhYNnRrUoPDVPYchSSNXlqcL1EkwGjMnUVG5QhFw3GIg8ShKBDIOc1wmWcRhPh9j+X6bCBAM2SlSbQw2u4wABkB24Z8atD3Hie02kM9tD/7rHpnrnHPa6T6CGxuexexDlOQCFKNASih+vHhPE26BUh3jyVXfX33OAm2OWRYofTLeIXoSeKXKEDWkvY1rLLk1/9UX2S9DRhwMdw9oGJRzsNj5qJvo7d8NfietmCzfYxbblV/+szw75mWgUwkTad6yON5ypObBmXBP7ddnOxlgHMXjLGKutnpaNVQo75mZEv8TzDu08S2vJmFrmWlwdYsfF80q2ms49awYlvTVPitpdAY6LJPa9apaigysF3kMFT/6vsjYF2ThGVkHfVyP5MovXV0+Tce51G4LCkvq6rPQptFBG0M5LW17Aqm+KUammS/05t5gN40h115I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(44832011)(5660300002)(47076005)(40480700001)(83380400001)(336012)(426003)(81166007)(356005)(86362001)(36860700001)(82740400003)(8676002)(4326008)(54906003)(316002)(8936002)(2616005)(41300700001)(70206006)(70586007)(6916009)(40460700003)(36756003)(26005)(1076003)(478600001)(186003)(7696005)(16526019)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:13.3997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bcbe2e-2ddc-491e-413e-08db061a235a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4038abe8505a..fd1c65d78ded 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -94,6 +94,9 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
  * for appending data.
+ *
+ * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell memory. It is an MMIO region for
+ * signalling user mode queues.
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -101,12 +104,14 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GDS		0x8
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
+#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA)
+					 AMDGPU_GEM_DOMAIN_OA | \
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

