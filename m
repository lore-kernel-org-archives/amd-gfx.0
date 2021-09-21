Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A9AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2106E61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2106E61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AF06EACC;
	Tue, 21 Sep 2021 18:08:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F9C6EABE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPfSEMD0A4RuWoV1QudEwXsV1o/esoHyMObnVvRyOEAmz5KHn71jFtELZUGB+dPiMT8ZSe1akUVwl9ZYY5BOa9mZhUVpP8Cg31udKJPI0m9hh556EyxwZW1lay2ib7dO3a3+/48F5rqZr5mozY/1N3fbx8Dnh3A97+c7a1NuT49T/Mbyd5zT1GefKnM+153372Nr3ODrnfr2qra8tB1n/WNg7P+yukaQ0RILCirlgLsP8ogTZ2uTxcailFSIjSTzLMW90uvBjld5Bo6T9S86kgudSt7stlSkK7IxwsrWAs+u90xzWHtXVSoeguaXNbW3Oz2PkPz7dZMjyIa6Xjv4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uEIcAEXi1b8BzNJF7uqVqWnO/hUkOqJMGKrz1RNDnVQ=;
 b=n3i/GIxpL2ln42E9GLF1gXqO+NFdDSVv/6Ty1qd57MO9K11ES0AKjX4nHqn20LeglkZ7+xF/VDWowW4nkRJRkpJX6KZ78R1NrOt4cGWpv9usbw6NR6Bb3taUAQiQ/dXidsBGKb2q41qTjwI+F9TliaGo51CPuAK7Dmf0t6RXJXDmskRjyAEFR9oWHgjyLn1B9JvWnPsIYOsXPMnHdyZDEgsvRZm8O3Z/Ke4v3CW9LRCwPVlPTOIwhZH5Cm/D5TfrV9QM+o3cMHZ+zFSBCQeGzqeNj91RXO78P5J9gQWWQUR0E/2buChWLj70632JzRvc7wyhmEMtnOu87w4TQBDYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEIcAEXi1b8BzNJF7uqVqWnO/hUkOqJMGKrz1RNDnVQ=;
 b=Q5irLpH0mF4iS79Xv+q2ZTD1R1HiCyBFAKPJdYkKx4H+3Ks+tfAOOC4I9jZsc4Zr8PMFGfxoGtqLjSTDSSOJZgXmY27z47/dFKi3Lh9Pj1ksSnam92SkEmQmYkJuyB8mNppT9OdDWwvJooULWdCSkMbx0wWszO275HVANTaI4Lg=
Received: from DM3PR14CA0148.namprd14.prod.outlook.com (2603:10b6:0:53::32) by
 MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 18:08:11 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::a8) by DM3PR14CA0148.outlook.office365.com
 (2603:10b6:0:53::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 66/66] drm/amdgpu: add an option to override IP discovery
 table from a file
Date: Tue, 21 Sep 2021 14:07:25 -0400
Message-ID: <20210921180725.1985552-67-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297f74d3-9bed-43bc-76e2-08d97d2ac624
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-Microsoft-Antispam-PRVS: <MN2PR12MB453644554FE264E36A4EC63BF7A19@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCqQ9bMbdmjNE29hyZzw3dKKb4b7TGoH+Qvho4Jie31a0oec8Es/edH5Mixk8XtqbC1ddv5aMAR2JdjskGCR28LzjKmQGl18gQ2eQR+JsgpehgTC6fblpyqUJgJQy+xPoWRGszsWbb+PoUpp0lTjmJicsVaUDDLQf1/NEdbN6rQea/qPsOcCA3x+tcB3GBJvBqySfyDAcZSdiYFsv0SOhbPqSa4EXNEWYjoZ3SoDYyXQM2hxKMP7ubfta/j2tMlB4ANLKWXqTgqkSGukuVnLOBbbcWTPIaggWh+mACU+8ZH6Rm03If4p3fUifw+OBCSNk1pEY00DrZwI0/VtlKq+prCYiS+M/r4HP0C9U6JbHscwdUfFvyh+nSypd/cOxIlwPz1FuHu40Exgi5+lf3Ot/rBblYDjRxiXUmo0WnKY/ch3S50qScl1CLixZQ9LcxS7flZZMZq8fztdRmXxI7anTVIjyeo+opvu44xYW+JMHHdUOxvWdgaXwUcL6ctSA5bX2XMcUxmlO0CR+TNW4nQIn2EsvRvMtRUdh5P1XPbmrfPjkoQQiZCVVoQJtXQAgEua2Km1QkYaKccM07XJ8Ce3nY41xHpk+WwUR9jCk/2pgvXwiLvQFYevClqsMPD5mIZCmBKxenCVBdyvNsFSfkfTiSQWR7H5VQfy9ho7WGRZaZrOWbdgKP5467WwfgG+rflGm6cLXKJQu8LcKSWv/YGFDWuGsPM7SSqxqy6Bi1Hfy2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(86362001)(4326008)(81166007)(70206006)(2616005)(356005)(16526019)(186003)(1076003)(6666004)(5660300002)(508600001)(83380400001)(336012)(426003)(316002)(2906002)(36756003)(82310400003)(70586007)(47076005)(8936002)(36860700001)(26005)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:11.5213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297f74d3-9bed-43bc-76e2-08d97d2ac624
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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

If you set amdgpu.discovery=2 you can force the the driver to
fetch the IP discovery table from a file rather than from the
table shipped on the device.  This is useful for debugging and
for device bring up and emulation when the tables may be in flux.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 821665fb73b0..7ff8b551b64f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -21,6 +21,8 @@
  *
  */
 
+#include <linux/firmware.h>
+
 #include "amdgpu.h"
 #include "amdgpu_discovery.h"
 #include "soc15_hw_ip.h"
@@ -67,6 +69,8 @@
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
 
+MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
+
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
@@ -206,6 +210,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct gpu_info_header *ghdr;
+	const struct firmware *fw;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -216,10 +221,21 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
 
-	r = amdgpu_discovery_read_binary(adev, adev->mman.discovery_bin);
-	if (r) {
-		DRM_ERROR("failed to read ip discovery binary\n");
-		goto out;
+	if (amdgpu_discovery == 2) {
+		r = request_firmware(&fw, "amdgpu/ip_discovery.bin", adev->dev);
+		if (r)
+			goto get_from_vram;
+		dev_info(adev->dev, "Using IP discovery from file\n");
+		memcpy((u8 *)adev->mman.discovery_bin, (u8 *)fw->data,
+		       adev->mman.discovery_tmr_size);
+		release_firmware(fw);
+	} else {
+get_from_vram:
+		r = amdgpu_discovery_read_binary(adev, adev->mman.discovery_bin);
+		if (r) {
+			DRM_ERROR("failed to read ip discovery binary\n");
+			goto out;
+		}
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c7da1f7cc880..ec0a2fd7c163 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -628,7 +628,7 @@ module_param_named(mcbp, amdgpu_mcbp, int, 0444);
 /**
  * DOC: discovery (int)
  * Allow driver to discover hardware IP information from IP Discovery table at the top of VRAM.
- * (-1 = auto (default), 0 = disabled, 1 = enabled)
+ * (-1 = auto (default), 0 = disabled, 1 = enabled, 2 = use ip_discovery table from file)
  */
 MODULE_PARM_DESC(discovery,
 	"Allow driver to discover hardware IPs from IP Discovery table at the top of VRAM");
-- 
2.31.1

