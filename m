Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F6606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AmcjNqqt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D0B10E4AF;
	Fri, 23 Oct 2026 17:13:02 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411CF112B17
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 13:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQxU9/c7Xix94GchAohXszEQmW4+82JWQR1grm8GK/iqzk3HZCspzkNX2VmjXmfkf4WrVeJGnI8xm1AQjHoL5ComSpNPE9IeMxF0nev94c/KTEaOCp+aoVJ4yJArqh3V+MzWdtvr/T+grPq0h/6+BVv2OQpjUY4nV0ZQIx07w+kfKogfsMGC+2XDEo8B3AhK181G90mqyjyNFDPijS5OVCUwEN/iXXeGp7sEc3AYpxpJIxPpN6oom/E4pULSWUpa97s+PFjy3Ot+J/s4LG33ff8zRhdFKLo2CQgbDR9Y2zuDJe/uq36j/68WSc1qAl19iS9/FmC6SKfn9WSpjqyTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7d580qfpxFN6U4IgJ6yPHPIpNjEbUzc6DfX/h0u/lM=;
 b=OPY/SHGW2/pfpQC5ZNdUcQUseAXIYEQic7ciTcMVjGIzeRbT/yFWnUxqDi4oBfMSzTUlkSFwDM84csx02iSAiySh65wAWbVloGtS73RhxNQ83HfRpS/NKnlmgmCYX+Z6UHyhzGSvel9C8dLW6pKz4BF+euEuK84guPlXOSGs7XZTlTlVdo9EJ2FgzNOzQeNAAUKFvkEut/XsZmgIpq0KLhOcG9xiRYx0y0qG4At7icIHuCjeiFx24k9TkfO8z27BS5e9AxXxBa46VrCHvzOzP+bB7Jam9NjB+EzipgK612Gmdo1nqz+9ZIbmdvyLWgfNCrAeUEKYaiZN2W1GkLLBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7d580qfpxFN6U4IgJ6yPHPIpNjEbUzc6DfX/h0u/lM=;
 b=AmcjNqqt8oxRM4BjA4s5GRLBsY+usFHE9nI8pzfEaIT4ByPao4f2Em+d8qvg/YngRyqlThFxSgjEinU9awyJuRCibCnLf5l8DcJT7jTD8vZTI7j7MTm11Kq7iiFozUYcjg1Mo9NyzCVbKb/SEOmGaZvyhmqFi6bvucAxqIVRi/8=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 13:26:04 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::14) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 13:26:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 13:26:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 08:26:02 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 08:26:02 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 Rosca" <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu: Bump version for allowing jpeg type 4
Date: Fri, 23 Oct 2026 09:24:49 -0400
Message-ID: <20261023132447.1036020-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019200726.15262-1-benjamin.cheng@amd.com>
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a92a08c-3118-4d59-388c-08df31093000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|261021121427099003|10067099003|22082099003|18002099003|261021123027099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3hr5ylS9WsmH4Wbol3E1AsWOGaaryG32pBeOBYZfOda5dJMGBhkUIEpDWHve0mZ6E7uadgbFSxnV4MhDIcwRrdWqD8WD2WdyZzwO1vrRfOLqArnq7RLWyyGgjxPQ/vn4wsz24n7mBUG/YoPNa6ONfCjUJr50dS9MtqUeqgoaf4j8/9PS6Y8cNHWDfHXCUsPkt8Rn6WIeXHjZeqlWNR/S9wmzVRHQz24Xa0rtvGwm4krqLGc9YSHdmZFk6ImQQNhOQfKkNMr8LM8S+Q1+IDcrfQJj16XD7hrI8Su01ocQMsHKXkGdOIfe91nNhZbEXPLG8kq3JeCLWng5QHRA6z+K25U0DbXsw9H7+O4wNkqsB2FcTmBrSHWXfuBAKkLKNT/E4Bz8ZuOB1YoVJDs8k1N/m3/ZbLH3/1hMS0paYpyuAiMF2AjfQSsMVaQbSvOrj1Oap23FjqkY9dn21ao4JSXJK8V9P8lej5LOvey1l8BqYZVRtWSxJBdTgmSyB0iSKUenC3ZLh7fKh76ZXwxY235ua3YYDquPL0EJ57HX8wroX3rozY7UMy1G6HlouTXL1nAOZ5esU7IcFUkffShnDBkRD1xzXfXpXNrxBYNFtZ5pVjjinqxVAzE5amMSYrz/JnyK4UY92EYxFaWhVQYAxAwh2OSxuEprTp8Z4kSl6xeGlEp3ty73blNxo5UlJShvceBgDxhxt9rmhxsjolulR7R9VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(261021121427099003)(10067099003)(22082099003)(18002099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZdRm1R60EfRvD2LToK8o1XjspBTmgGCpweTd7kn71TDnTAdOxKwEIngdS/jiXHAdtJUpLD/K4n5smSpqndQ6Ltmzl2McSEdPEvquZ89aPXZTkJB0h8s/1PzrVVZIGvfVNGTDBHL9LAdArhA8dkmUeb1ftVhPBjCaSUkw2WaNOhWpOO4uD3wt9xgwNpi75QVvehxpkrsUxdhfAQmH48DJdi6Hqs49fuiTbRBMrtdsItnuxRZNOsr2KunLXF7m4k7lVF4a2+Li3hHGWgCQVy0TkyMif2SvJlJM8wcaXDEh22L4ulQhzNoUjWWTG1ZynayfkUlxr2BRwJfM5lMuKDoKHDq1c1qglVQrlgfBRO2FjhIQPC1kjQHAMmfGw0ujvFQhM8f/DX9jPUq6XuGmfCVHTufJadvexn8aiNvUoD6GCX0nhmBlmKd/U3A3wlc0/tAq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:26:03.9247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a92a08c-3118-4d59-388c-08df31093000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow userspace to know that kernel will not reject type 4 packets.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f..1325f9b2b096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,9 +128,10 @@
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
  * - 3.65.0 - Add userq syncobj timeline signaling support
+ * - 3.66.0 - Allow jpeg type 4 packets
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	65
+#define KMS_DRIVER_MINOR	66
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.56.0

