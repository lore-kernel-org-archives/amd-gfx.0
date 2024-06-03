Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14815C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631C410E23D;
	Mon,  3 Jun 2024 01:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v5ZquCXs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B05910E1DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZuUMb/MhN41uq91D/pfMOeY+PIPbpg6MnanMOVn2G1NS+dxVnidy8cn2c3KsnM1tUtxtlihl4rkpGKSGJYrj050ZLJceYGwTMVSnAn4cgVCHCVJkH69cvYQzdNjbl65QCqU4/PqMFxwhZJ08cxreNBma/BDFL6T/6G0wbZuJ2xyYzr35Vt2oUzBbj/OfnPHPJyuIIhzVfzjP9oBtt3EhpT5Wguj3YHnWK89zOCnjB/nMJgaeq5wzm2IlozxzHL+SP3Bo5eAch1VHBa2WUW2KmAvf9+sZ04CKuz0vYqHqXGQzQ6OIhgnH8I81dNWhLqePn3RIRNB1m5kZb2Gi5FysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N18W8jCbgfAaJkZmZywZB2ltuv08hrXDXALULnyx/G4=;
 b=eQIfc46z8a3YNjQt0YFtqwa47j5bncECj2MIlYmmgPfdms2o+L8dkNSSnvaaCIDdbY/TUqLuR/WVjcZTty0aVc82I1Kw+1L5JvnMIfTUO1UDkYjUZTk7IS9tX13SOE7ZUUqWNFpYPdnQGPjhqn5BiHiJWX+HCXgKi+jRQTKCpn6egJgZrSqIwFAU61kBxWkr/f/28kS/SBgPyOopFBNKrBv0wlaHcTSzUFIw9tPwbtVizqhkSiJv9xGnrlTwkp+yj72fgtFi38y98OMCSDF8RfQouF/0xM4pqIb6Mfu8C+OrFh/sFrrQsNpsPAk+J6CqdtqXW5ci9UBr6x/fQYfTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N18W8jCbgfAaJkZmZywZB2ltuv08hrXDXALULnyx/G4=;
 b=v5ZquCXsqjlcgrC1f0lbuO/ldhsFhJ6iN4ULtH6Z9Lplg/GLumxpjULv63sIfzxiRiSKxQfi8zV19Vc2cPnjXjurPU9sW6aOMfGQQieW2KECgXYWwtGk014CrrUtUxigyz7TPnNNwF7PBPdJRiAuFLkPnxpeKbwRAYyJkYQpHN4=
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 01:42:58 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::50) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:55 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 11/18] drm/amdgpu: refine vpe firmware loading
Date: Mon, 3 Jun 2024 09:42:05 +0800
Message-ID: <20240603014212.1969546-12-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b763ba-46d2-417c-63dc-08dc836e7ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bZrYPHOWKdI8au0XpEHfe9QHpOx76chNHhVKF1aZIfPFQMNmjiAVfnxVSqsZ?=
 =?us-ascii?Q?mF+sh/mTZqOFsRcnCTdXGrKmbaYvz3DHnNI1r2yYlUaCtQ1HpzYsrUaa3czk?=
 =?us-ascii?Q?KjDJBm3lqscZ1MTYZ3y/ndovpEXEVCnqTduLNq4fLz8gfN7JxIM67dHTPKyj?=
 =?us-ascii?Q?LmWra35bZc9bZbShFg5DlrKPK9YOo2KKNmZb3IwWnrPCcqrca2vLZJ42jCJm?=
 =?us-ascii?Q?5IfW078B4SRy+0/EQjoyJCuMp7fdRnoz982XMdWkAJWXLspAXEEzB8pXz9xB?=
 =?us-ascii?Q?WqQyj8jSL4unlbSjOVRd0VIullk0mc7WUXVC7ScowqfVNYoH7OqSEYPJYGvO?=
 =?us-ascii?Q?+CPu3CQ290M+9AmlY1lckCtFrbj7DuhVw1bU0ChcVgQkQD71nAaBknVWz2qR?=
 =?us-ascii?Q?KYvM45yYi/0I6ey3V2EwnBOtxzsVLNq9/FWEqmfF0JSJtAl0daeUNUSyvMYU?=
 =?us-ascii?Q?biXYyymPZSQXFLi0xk8wIdOJHf5sQDvLJdbbJ2LfM3/x0jgMsK9ALGLGeZj+?=
 =?us-ascii?Q?216nPmQWtP2co267W2ABhNNwhbDktpLr4hoXfzCvZg7s12CmBzeW6dJ1Dgj+?=
 =?us-ascii?Q?FYzjSPiC18FY5QEchCFL1jxSKsg3FMTJqR+4ZotTd/4q7vi0DOsl4vXDbn5w?=
 =?us-ascii?Q?hJkqvofbeL21eCX4Q3FgbastrtJ4R7+FR1jF+xIIjhhEdn/8hp1GJm5O9fqN?=
 =?us-ascii?Q?Ug+L3HmaPFT3gmn+CBDva/Kf2jkZ/Ko1YitH7KdN16WEQAklZfx2Ae4wAx19?=
 =?us-ascii?Q?eMud3uQBYCDtB5wuGNfMYRvNgSZ4v1xJj5Ky8ArkQBL0+pQiNfm9CWd5IiSn?=
 =?us-ascii?Q?LB1gEDKu6lvpjtAZZ2UZN8eA7vHDb+oREIk56MqkKWvBSGxcZ3/JMsO8nlp+?=
 =?us-ascii?Q?c764Wv02d7kbmVEkoN2W92nH5LIgcLUaHq546876qrR4g12UkExBl/bhujKe?=
 =?us-ascii?Q?zsoe//LBBAKBEzkXOw40bpIwqygaIvvcyUjPs/mV1leuOse+Eayid7ixnVgB?=
 =?us-ascii?Q?3CFE+iZS0vj5hdLUoTiXyqwr2y2SYfPMGXWO2ZKjyk3x8KGhDr4wL1AvKZon?=
 =?us-ascii?Q?jpD6dW65gWdyngYDY9cT7NOQM6pJev8qmvTaM+WSkuxcxzr0rPLEMExVgMlu?=
 =?us-ascii?Q?V8QC3gVL3rjgNrdwONGWcsvQRP1VNKmEcqPRJ4b9kz7GZkrF7Hgu3rSrkDC8?=
 =?us-ascii?Q?ZJSwOKepoQnnpgt5eBdgsVMlB4oBVuTw9B0Iyqyf/P+Zl2reQqEwYbnYnSVE?=
 =?us-ascii?Q?F3TLBhXA6MlwbtfnJGO6t9HzHizA3X9YTGgCYM7grD5M6/vmeE0KnYYkeNba?=
 =?us-ascii?Q?cuQPMsUBpmNNywgj5mXk7IXQdnelXBPhUA1itKsNFqoYMoFkFJVJQ+qau4px?=
 =?us-ascii?Q?QYcvY7UEJ7b8yOAk1px28J/AFE8x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:57.8235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b763ba-46d2-417c-63dc-08dc836e7ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

refine vpe firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 49881073ff58..bad232859972 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -232,13 +232,11 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr;
-	char fw_prefix[32], fw_name[64];
+	char fw_prefix[32];
 	int ret;
 
 	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", fw_prefix);
-
-	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, fw_name);
+	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin", fw_prefix);
 	if (ret)
 		goto out;
 
-- 
2.34.1

