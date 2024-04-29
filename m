Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD36C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1129E112D16;
	Mon, 29 Apr 2024 15:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qqqJcwA8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1A7112D13
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq/4WG67rEXnOGl+J52aCE1hwElI4lJJnfO4KRxt55EH17dmVawJWCyeEj5iDgt3ALSKWV/ixrhQpBSEsrKznju/qkKiUWbnJbZfoQ5eNX86CBjP1jT0mhloYhWQR8FkkGGqpQzg/91ErCsc6k5Qn/cgtx9k78Xt6vwR/sDGJnD8Jca5cE+wvQVj03ej7PuAgBU/y25qa9coHeSosAJpedNWMQ1z+TDkmKJOzSmyiD9Ku5zvr/kU5MRdNVwIRnAmV+P9HVXuL3/hcZdx0qKHAcY04uSKJBQ3kXrMmivYiwE7jc9RR1A2QmL3N7VmE73v+XOLJqVsORY6WknOPR9xRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsUP56AKA5aJvUdMh79DRVY8K/cPztIPSzsOfsloIp4=;
 b=NbhAwuEzWHvl00Dg9IvKNAObZXGDfYzkBhzQCr4UDk9FogIoNFL6aC5MTBgzXXMZr7SLXefCB3VJ7VpJ1If7SuYZDGjZDN0xgvzMgjat6lex0EfayuKoXcjZUjv9E3bCfphx4G34WTuTp40F/ZV+5ght4yHnzMLUYZtlwgdKtJ7dYlNx6+Z37GFQRhwGHaOtmVbWCGFHW89d3pFoWEgz6TxT7VQ7Ni5w/N8+Nt3JDuUjoJRx2so8UmdAGjdzIvLcdw6fQ+M/zhFBiEeke/sk9amX9DLyc1YnjP4kCeGm8EUYwzRoMG/vnZV0KvD6RRbZZSfIHxJljyGngezQp4CO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsUP56AKA5aJvUdMh79DRVY8K/cPztIPSzsOfsloIp4=;
 b=qqqJcwA80XsHjVGiknjnzj3cgJlHqHyvPa07LQQ3qrYiQ4DwrpVibO833EBWN6OzDffCTcjl/huBBDMBe2FFxO9TB5qn/boD7LZvvyLVWAhArVW/GSkAeg20oZrY61cWwlGjESkHFjUIy8LA//S9jlHZpwxrK8XjR6g391OjKKw=
Received: from BL1PR13CA0203.namprd13.prod.outlook.com (2603:10b6:208:2be::28)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:45 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::1a) by BL1PR13CA0203.outlook.office365.com
 (2603:10b6:208:2be::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/discovery: add mes v12_0 ip block
Date: Mon, 29 Apr 2024 11:12:19 -0400
Message-ID: <20240429151219.3466531-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 584d1b0e-9b43-452a-edcf-08dc685ed2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StJNRDvrFC5RkOFAic8enERBJ7cMNdYuqwvTPeTbwwsR5pXtJLbwZd67sjUS?=
 =?us-ascii?Q?QqlNnS3Z0uY/9zgG5Wkm3zUnSBzlpE2sYRElFdeKGpAAklfI5IhMtMhEPXuv?=
 =?us-ascii?Q?nPZ1csYeTUkBjVb2G663iMVGjcZ9TQulhMv1TAJgrwBJ08aWDXLzvov5xUwQ?=
 =?us-ascii?Q?o8c1r1OHtWcYLKcwwjYRPIjNIegHu3Zke3ftmvEGm5b5mQa02buugyZ/rPK/?=
 =?us-ascii?Q?6Gzh2V1XLFj3ERHBxK7io5xo/1AaVyMLmCPGSVjwHXOW+TMHWfAo8Q8O4CsM?=
 =?us-ascii?Q?p8SXOn8FpWrjazuCozdoVE5eeH2xxmOrCB0hqfxOvUh5V9zaP2wyRQEh8rXE?=
 =?us-ascii?Q?xWKgH5xyjYgi1eEYdd9aPN7ciAg7DOJyBmbmvANFv2n+kC52772P0QaRYNpB?=
 =?us-ascii?Q?GfWPOUMEHrOWmSYw5/pxS81vAl3eWPbTr1Xe4axM/Ab/gR6mnTVgITJLWD4B?=
 =?us-ascii?Q?VcRf0JBG/zrb+SXbNXefRu72LW97RPEwctoEMqazZtFggofQFcJaxWEABvYF?=
 =?us-ascii?Q?rFo3BDfjy5wKPB1bt/dbMAR+IsMBNaPRih7RRQ9HhOKbDJtP1dE4O47nc7Rv?=
 =?us-ascii?Q?L4SuOyECT1+gLsPUjUDbpxqe08lMqBTKZdY36uGN5OBZMrjr1uFFEUWSIo1Y?=
 =?us-ascii?Q?6ar13mAxtBseDXPuTjOZ+6XCx4Q3S/6mXKPrw9AqpVw7YZsZEesvVJ/+XjGu?=
 =?us-ascii?Q?ayW/f+oLOzbyzv18zm6lw/gIh/1anHre1BErOk1InJ+2beGZakExR7p+4eGW?=
 =?us-ascii?Q?7J/SWiDlI0p+xFX1wTEMAoCeMnuBZAdswd3zM5QrevyXCSGtdoRla8uOhMeR?=
 =?us-ascii?Q?4+hjbsmN6EM5EEVe4+p20NvD6aCuF4caxc5n3hOxTWJEY8GXyMDiOithZRGp?=
 =?us-ascii?Q?5q0HyRESCbVUOGGM2t8YpXOXZkafaOuhtXEZ6nXNYrYTKN+1VZdPFvONvdTj?=
 =?us-ascii?Q?CHFtI+bkZLPlbr4PvrJvdvE/T47laVbumFMiz984+Iabpqgsu1Qhv1ad6Jtt?=
 =?us-ascii?Q?/CBRPEzV6OjjR1+rpblNP59AJRXG68DoF6FtvvYwL5dsGErKblezM7phrtWS?=
 =?us-ascii?Q?mnv8DJNwYTxAWw3sX0gANpoVAm8e8Xm1imXCs3Yay3cFW8QqnftE0Yj+iAyx?=
 =?us-ascii?Q?rtlJKdMAtMUc0+Sd53xjccaLZiIE3ITVCcu/la+0Kt9wXB+CrmgOt+ml34yi?=
 =?us-ascii?Q?gYS9pbu6ujTY78yCqWumd1QButzXFZGtwtj37T+jpGluPC5jIvHOv+oCjAC8?=
 =?us-ascii?Q?fVX/1gLzwsDwsLnt5guVQCkWgD81nN04A5KvMYu3WhhqYLQhFjqdOXjsp2Dm?=
 =?us-ascii?Q?Q/i92PJSCt4esOslg0pHM/rKVpgFnlVNEm7z2MrOqiSP9VowJ2bYqkTmyNOj?=
 =?us-ascii?Q?KlXQzhQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:45.0551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584d1b0e-9b43-452a-edcf-08dc685ed2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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

Add mes v12_0 ip block.

v2: squash in update (Alex)
v3: rebase on unified mes changes (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3410fa7022fca..df13c2f9673f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -96,6 +96,7 @@
 #include "amdgpu_vkms.h"
 #include "mes_v10_1.h"
 #include "mes_v11_0.h"
+#include "mes_v12_0.h"
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
@@ -2233,6 +2234,14 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_uni_mes)
 			adev->enable_uni_mes = true;
 		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		amdgpu_device_ip_block_add(adev, &mes_v12_0_ip_block);
+		adev->enable_mes = true;
+		adev->enable_mes_kiq = true;
+		if (amdgpu_uni_mes)
+			adev->enable_uni_mes = true;
+		break;
 	default:
 		break;
 	}
-- 
2.44.0

