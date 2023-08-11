Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F210BEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 05:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3953010E653;
	Fri, 11 Aug 2023 05:37:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1037910E653
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 05:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra3JN2SUGYD3QQYh4kwi0GED+RT2H5MJ+iUnE6XqeyUiS7fRclywLaydVEKsgL+CypfeOnht1+1KNL/PJueEG7/DkHGaNe4is8A1Hqhw2AVUfRTeworPsQ7MmctDhfi3a5KpXO0is6TMEct7Ue/qG+Nxl+YiFwUyms4IMVonPOScKwWRItWwjRG5gyTmGmsvTMsy7X6PK4xn7semg0G7YXFI+LDlRQm1GHZCzvNmKWh0QMQHaIGFi0OsYiDiaCRXrcT/a/cO0KcRlVIgccn+UMOUEjdem+pfD4FmwVaZnNEcPC8wGUVdKj3E02jeYDeiGW2uMerMFfCTt8Ufu9GgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcteVubtmZ2jlaGt/OMNJwUokICt9j+w/FL9re9E0/8=;
 b=HXxZXyDvvG8r2Jz2qHuRC/7WDfWKzP+n4nJcB1uXfsptXrxhoX3vqW+NkiYHCBUgvI6xw0tP+6gHg5E4olU9WhrU6bFbafD6/kQEg+rSpCiLdcYp78wjTRleS+pZNMRi4I8IgLb0S/2t7ZHM7wjS6xrrD5S1ON1Czle1Jhv+i3pVNuIzweGRJI7RZzcETDPG61+dPZqfJB16mItPO+uKq2qtogu183zblE0NxDkTVk5WjESGVHF7ixqPzb2FXZCQ0lI3n7PrhfwsPY7p2vybGtkGl8dDEKrOLSYPGm/bNIIpK3QVl+SPIR/L/AEGKdrXtq5oEPiqsQsNW2qqObZcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcteVubtmZ2jlaGt/OMNJwUokICt9j+w/FL9re9E0/8=;
 b=E3eB5aw7gUkOeuP3ZfF2dAa7DpnrxD0RQMOWW4B+24FoB1wgTil3as38/Q/DQpNRYBwIWYhPGnJIA5Mh9h+nCMg/qdeGnThO9Na67SHURdAidlycrkSSGoJV7Ow8a503IcGcBdMtF5zI7OVWdDwICF9akgV9jsCW0bMWu6xtrK8=
Received: from CYXPR02CA0026.namprd02.prod.outlook.com (2603:10b6:930:cc::9)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:37:39 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::a2) by CYXPR02CA0026.outlook.office365.com
 (2603:10b6:930:cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 05:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 05:37:38 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 00:37:32 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: bump SMU v13.0.5 driver_if header version
Date: Fri, 11 Aug 2023 13:36:31 +0800
Message-ID: <20230811053631.2794988-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: a72afae5-eadb-4eda-bfd4-08db9a2d12ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcIT3d9sfSxBH+5LBx+9j1gC0qyNZbMSoKrRKpupkI2FxBrwaRDfFNKBbT6H8V6FlHMZ+/JZ+oW+C0Qcq7ikLrMz1fumjf0bCVxKNVwU8NlkKBNXrD9dNT7U0bN23eDMFSGB98XD7tUIcv7CtG/sY94wuC9LrRUoby27Dp5NDUZ2QbcnJcy5RFxWp1fbX6sC5O6grF7CVY/+Nfg35TSQ+ORH806lxpEMD3e7WDPVY4QnzOeZTR7qn3mupyH3Ls2l1AuIgy8Iqo0dmyFR4zyhrppUawhH1wRixknTw2Y94eFmLBxe4CFgcwtXMdGetiNUxcVuyFoqDBv0oR54wXWFx9Skv+OnGsh9mB4DYvxbK0sWRkS+njkrXfsvY6aw7LUJyyXfY2B/zf2Z9Rv9J9XCrg9OZL4tihrVsy2ceiudlvIOnki587Hu22C1FXDigB2XjyoKylA7gk6O9pHe+oYTL6IxwG2MAS6m6eoKP3vi68hV51MpM1p0yVYx6XtCURaObVJVsjg/uOoPGGgZaxvaXjZOXANcOOpInBEgOAKKTJt8eYqN4JsmyKsgJ2yASv93C6tdtBTQ6l8ZjKOgjadu7dXAHjs+x3N7TaemqQR/FoGXkR0Fm8aNwQzOPPS6HGomK6W3Lbx5VO13CcJDnX+azQPtEFDnKDS8Y7EQDFiU9MnwqBd9l5JXeLXYs7HT8sMqMLSeWSyhAmir6BiI+E/0WuY8h3O+XJJt9UhM6ZJNtfa9LY2kn3/rOcC4H0+Z4t/RpzMn/d7uRjfHPbh9HUWZxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(7696005)(40460700003)(478600001)(1076003)(36860700001)(16526019)(54906003)(26005)(83380400001)(336012)(40480700001)(426003)(2616005)(36756003)(47076005)(2906002)(86362001)(5660300002)(70586007)(70206006)(41300700001)(81166007)(6916009)(4326008)(356005)(316002)(8676002)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:37:38.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72afae5-eadb-4eda-bfd4-08db9a2d12ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, jesse.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align the SMU driver interface version with PMFW to
suppress the version mismatch message on driver loading.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
index 7589faa0232d..779c2524806c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
@@ -23,7 +23,7 @@
 #ifndef __SMU13_DRIVER_IF_V13_0_5_H__
 #define __SMU13_DRIVER_IF_V13_0_5_H__
 
-#define SMU13_0_5_DRIVER_IF_VERSION 4
+#define SMU13_0_5_DRIVER_IF_VERSION 5
 
 // Throttler Status Bitmask
 #define THROTTLER_STATUS_BIT_SPL            0
@@ -103,7 +103,6 @@ typedef struct {
   uint16_t ThrottlerStatus;
 
   uint16_t CurrentSocketPower;          //[mW]
-  uint16_t spare1;
 } SmuMetrics_t;
 
 //Freq in MHz
-- 
2.34.1

