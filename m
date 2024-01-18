Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E3C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0D110E12B;
	Thu, 18 Jan 2024 03:26:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAF710E12B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlBKK3x70TaDjxHlnu160EwOuOHO3XD6pYoSiLYyNKNgyfFz5NBUlThHoNVL8H7nBiPeI9ZluBGq3aFQ8eZRRAYawIpeZX6vkX7FXea6Zdl33fH4dGPHF5uakitzLpAn8LhBdjptrOT4QXNw668ZYqtLPPTlIr7qZ3NyvtFuCgi1kEspMEEvWhOVnzl1DOcXmd3Zo1/ea7q6JkLXnfV6bBRLiKK8avjsMUF6qFUJYbUsxIDmVfPMz6htXQrW/H3wQBl/iphLKgVOXsZk9f0N9End7m+K5PsvqjgbtrQY8vFiO7mdvI9mihvdUVmVzYM+YGBRO9CdfsXgr/KI3pItVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8MVKx/0JpMAjShJCjB0j1FiWFwl86m0166LO+A4dqE=;
 b=e8WiPCLO7hBM3ycytQQusLuDCjfOk+kd1NgctcJiFcQtLln/E2dMN3Vi5fYmHBte2p3mTgpEl58j/rdFzpz6BmZheunYO+fjB8L5BJrH1zEh+LgrFU9ez3Iu7+wkchPRbOCtX6qz+AuZh9Ps6G0CbCeolMyv/ZLoxdAyuSUWscLiGUI8ljkbXdtaeDTi0JmCAt0IY4IOC4kEii+1qcclopER6odlIMP5ZduX9CtrxTAvwjopYHp6+dy2suUpWAVO+yKnswW21X+lqfFS+D7XAJTsYjD1APS3itRsjPNWW8wXc/6DnAsznOSomK2DmbkScZsCZSbMDLVe2PRF0XcYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8MVKx/0JpMAjShJCjB0j1FiWFwl86m0166LO+A4dqE=;
 b=b/h4SMR5GSQL+nXdf6KwVr5ohzNwQmoCyNDWM3S53+NuRsaBlV1gUUHXyj2QnWyI7hZ6EEQy1J6V7QmF7NmN3M6442DoP3JdX9nwT0vkXhjVgF2CfoPUMiQU6nWu87c2/ZQqqHLsRJPAapLRn7kv/58ssaV0ECp13oiOR73QeOI=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 03:26:00 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::e9) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 03:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 03:26:00 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 21:25:56 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Show deferred error count for UMC
Date: Thu, 18 Jan 2024 11:25:30 +0800
Message-ID: <20240118032532.821661-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 588ed58a-9870-400d-003d-08dc17d53152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BG61gL3yC4bEM+CuTU4TVqxMlkazAHYAgJ9QQgP2DxuRGiyZ+b6LOM6qzlMLBrBqVIJm0RQjvDWAGMY2MJaB+g5HuQGt9Bqt+bm8aZeUBTS7HR1kb9IxZNdoOB5KpHJhdf6jaEXZ27eKr+02b5j+iHcZ66n34zvkvm3nmbhin8bBPlnrkFDQOxsGtLWc/lKWC4jdJVcYfD+BoqcNBFAB/dy8onHc+AZBMV7RZ8Qvkyil7CgmAVVh/M+cwsnmEvBZO2iLw3w9VeN5uIhvuk0Hya384VDSTQhM3jItL45M8G2CMZs6DAYuBQTO+U1qFkRtpjbs+5kI9AO/5P3NSXE8HAGcDzOhCGzbNOJ6fUaWss0FLUMRI3/cpwmrQ1/cNy+bLCq/NXotopcGxSmY17951UVso09oGsF6wniwHLq2BkBluBii86eBKpp79sw/9OziYJnIEDiTFGxRh0NSHmJhh5OEAIz3wCs+oWs5cs7AztU0JDDQtbgFbMquQNQ400miFkXp5CmZdMvAkNekoX0KNhDrB9P6cTI3bGtymemfXOoSVzdEbl5dh2ePXLMfjQHLxvCKrWcDJ4rZQp/9T2kKlQPCgRd4wdp7dvxOItyiGkI+Fu086vhP3cYlbRvqABVhpVkEGXZ5lUVk2bbOSxwGuhLdivp6oXnyNBZkqJGeA6Ik7RDYpgp22/vl1Sqt0AHvxoqjUlA78zyYfzHZUbJwb7Qj2OMPv8YgWWA2XL0xgnfiWNp9d5A+NTMGek62Az5AklZrUaQwIYH4DsMlFDTV+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(81166007)(356005)(82740400003)(36756003)(40480700001)(40460700003)(2616005)(86362001)(26005)(7696005)(1076003)(6916009)(36860700001)(426003)(336012)(316002)(6666004)(16526019)(54906003)(70586007)(8676002)(8936002)(478600001)(47076005)(70206006)(83380400001)(2906002)(41300700001)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 03:26:00.1292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588ed58a-9870-400d-003d-08dc17d53152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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
Cc: Tao Zhou <tao.zhou1@amd.com>, "Stanley.Yang" <Stanley.Yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Show deferred error count for UMC syfs node

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35b4fff54ded..f35a74bf5265 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -632,8 +632,12 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 			dev_warn(obj->adev->dev, "Failed to reset error counter and error status");
 	}
 
-	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n", "ue", info.ue_count,
-			  "ce", info.ce_count);
+	if (info.head.block == AMDGPU_RAS_BLOCK__UMC)
+		return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue", info.ue_count,
+				"ce", info.ce_count, "de", info.de_count);
+	else
+		return sysfs_emit(buf, "%s: %lu\n%s: %lu\n", "ue", info.ue_count,
+				"ce", info.ce_count);
 }
 
 /* obj begin */
-- 
2.25.1

