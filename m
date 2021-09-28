Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C69C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A716101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19A716101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC6C6E8F1;
	Tue, 28 Sep 2021 16:46:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BD56E8F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIath6r2iofnVdQr4JNnXV4WjHSQYqe0WwDygxRBcg6aFeCPR0y81KORDbyrdzsqgteKRRaya+OpbLaV4V7mXH2qu2nxHPnL9wN3FvARmqU+nfqaYUtOOoxhjT7ZGu23wLNKgfzOItDaS9ZAkm2YzmWW6g+mweOt/ABl+dpetmPZdgqcRQXsiHKCrLhFCDqgt6SCLFVAkyv5gkBI+fmWzx01CmsQRpWH1V3vpyVrMEHCh9OxonLJUnwKk4BTUNt+6k9XNm0vNXsuxjqTgUpigX+Wk2RMiM8ttdl7IVVHqHT1S9sShv9kCfFsUJPkLqvNynWce5WGVAenClGR+gouEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=h4v/+oVFDwWjpMC1U/iGSms5q3Risvmxm2hdfPH+VHI=;
 b=gFO2cMGJmtZe41mmwgTnnDFWvHMhslqUQWNy/+vvxvn8++e02v/QEIMtSokAE+VJBXo/tRB4RKkT0EaUg8wFKp+g45g0VaI7lkH+lTQwfIPpCyqUYFysBOq7IVePnP2Bz2lCs+SY3pAownBGzjLEimefU1gygPuPhmRL2Vu3l8YaSfvMB0anq7XKKIKTT9jY+wbkIOUBparR2W0Lp2+j6SzWneuc6T08s19d3NTz9UAHTKPHh/j+IMuY2+VcQ3XNUFmvOoWPayNiMBYOj57Ud4PZzrZdT2rSLqRbR0ArZ/i98W6PL+qogth+2D3rGGULKAcOT6S95c0g/eCIUmVGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4v/+oVFDwWjpMC1U/iGSms5q3Risvmxm2hdfPH+VHI=;
 b=ggIYCNSwkhuUT+OIZE9xXNL6ikHrTagbv2Ths7SgEfCFFPdID+/P93P1af/fXFoaeJpqN1rBgndz5bxGMWKP2NPot4L/C2nysvm2ZC+ffzpc8pAURaICEjPo+mtm3Pt5o83yvbb9i5c64OfqZNzBFtjDXS1M44Q99YuPzdtWWMU=
Received: from DM5PR07CA0127.namprd07.prod.outlook.com (2603:10b6:3:13e::17)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:46:50 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::e) by DM5PR07CA0127.outlook.office365.com
 (2603:10b6:3:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 64/64] drm/amdgpu: add an option to override IP discovery
 table from a file
Date: Tue, 28 Sep 2021 12:42:37 -0400
Message-ID: <20210928164237.833132-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2f54055-c952-4836-c976-08d9829f9144
X-MS-TrafficTypeDiagnostic: BY5PR12MB4084:
X-Microsoft-Antispam-PRVS: <BY5PR12MB408462FE8F299B4703D3F2B5F7A89@BY5PR12MB4084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cockLi4VkqlphSWAmN8R5Es/rCoAKPdCxjIj7PXotkBHvFPE0dMP5WTBTVymejQDyynMWUe0GpVvz1Si/u+KObjjHfIbCi4q2f3P4bkLQh+MgmcBS1ooRJBqbLDBXobifpMfvFSBzcjIFWd12bYA/Pz0b0DE6++kp/B1w8tEtV2nR76MmIZrtsnfTTNWYxDEO6GUA1XP8LPop6RNTcp1a9nd68Aq00XhOL076QXsZn4ki69/TA7ckYlndOmkiLvL5s+tEDT4Gq1qYGs7SWGb8wVq2K1np+xVg466h18FRRWChfbozlWZ66PNjVAl5jDers71CSuHQ49Poc4ffXcAC+gYMnLLBc8m8P3Q5s7qNmI5l848mFgKpDk+2UrX3bC+4dOwjQS8Fr526fpJDLwDBhGFCKYXcCM3zy4yklAs3v3hzIAiQnBLXJcZQc4dH9574gFmLIysj4wgUeGVWKj0lGFE9nWoqcZYBQOIFOpKhx34D6uxR0rI0JPiUE3h9c0ayJEiy7n4nEhI5mm3PwXovLbJZ0FUN8uRFmIL6OUu8jHyyLbckMQ9CkoeMRG7tfIfADoi+DGz2g/O4DecfEk0KyoGSpust6VSx05Z8Gz3vvxeAylAn3wJkTp6TGhMcPF8mY8GKVabAgqIwxz3rBeSEspZMtGSyBDd+jdMg5r6bTikUHbXZpRF6giQghitGeVTkl/zIhKyNJPvw3tH3trkOfoFy9N5InUHBObXjYzhfQA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(70586007)(70206006)(316002)(54906003)(6666004)(26005)(2906002)(4326008)(7696005)(83380400001)(86362001)(36860700001)(16526019)(508600001)(2616005)(6916009)(186003)(1076003)(356005)(8676002)(8936002)(5660300002)(82310400003)(36756003)(426003)(336012)(47076005)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:49.7441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f54055-c952-4836-c976-08d9829f9144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 091ded38545f..291a47f7992a 100644
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
index 670b09fb5d34..439b27c802bb 100644
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

