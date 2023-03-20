Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99251C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CE610E625;
	Mon, 20 Mar 2023 17:38:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF9510E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG7nmemvcbQsYxRejv+MZeQWGwtyqzjb4x8WXe0e/xHdSsz9WEVmXD8fEtupDRrOt1yzYGKk1WvL2G7LbXyvosfljV+pA+neGdmOj8PEGFK04nexdzgsJFSIwro7r/HWlyfIjIx3IaqU393hKF3MBc67iIoIQrqThY0QILV8Ydey1bW7fk5rUyCSLoiBxgRMj7NZTFotz0oKfV8OgW8lyA/SGd62me2vDlH9lGK12BFg9PV9aZeJEPzrQJ1QeNr5DOe5qXjNY7jxhWsW2RALVIYWeRZgVi7bvXrXzvOcWcy1w1xLgswT0v/qIsCMBV6OfH5Ek2eQDaTeDL6je/op6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIScbK94mx8AltUljoX++6HMJpNBgJtKeWjijBa2Swc=;
 b=SN7vY31eJi0qUHeGpyY+Xre13BIjaiUNMi+ZtVsY1lNSiSnSy/A3INdxE82BhGAmdkAkOjq1otzMJN6dkC1Ri9trw8zfiA4eyPX0dt4AxbN8oQaPS8mTJ3Z1PCFQCQH7O28zC089S3FrmoNpWBrRvbs7sNUBVHUZZ9UVhqiraoXdqHDgvREgW9+QXtBeNyhlok4bgkSd8wWigiHqf1JOG8pc8NAzvqxge3MIcWMayYdwduydw/QFqC8QhGsNTTyHpcakvmW+dIHsCq2wUx6kfhlL5nGywJh8u9zZLRf+oD9k9OSkuISPr1M1pQU3BDY5QmuErcfqKn+mx/cwt9OEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIScbK94mx8AltUljoX++6HMJpNBgJtKeWjijBa2Swc=;
 b=SF+/msDCIumADxI4+TITuHUpXPy7pIw2hyRBQmMCjzTmxRDiqeo+wKk+ZlHz/IXjlZ5gQUEeNsfnsbzkCn0B0U6kymSVDBakr/u0lFbbkkEFHhW0/K4UmmHmYOz6ekVY2Ski6Glvr1EKrKAKg8+I2RrJIyFFEQzzbmA+HnAcpY8=
Received: from MW4PR04CA0329.namprd04.prod.outlook.com (2603:10b6:303:82::34)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:34 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ca) by MW4PR04CA0329.outlook.office365.com
 (2603:10b6:303:82::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amdgpu: bump driver version number for CP GFX shadow
Date: Mon, 20 Mar 2023 13:38:10 -0400
Message-ID: <20230320173810.250835-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|PH0PR12MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: a48b923f-eae1-4fc5-d452-08db2969ede2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+b/lUkD89EQyMP/BwxZG5pjCc2wrB2xaqI8rw6HGGM6ReA03xFor4B3QEv+MVeKIHEpShZRnRcYTX2AmdjV1F4am4GgPKaAXBxGVTmKmoyA5C4o5hXryGjhC0R6nBYA6txseTynbhV+Sj7PMzhs3bRbr4qs+y7gxy0MyIeblLi7wqvlzoA1zFfJPRfeEjQJtZLX+Fu3QJ74++1Z776VDoiXbTl71yMVV6cVZkMQi2GtQQI91dU2xEJwmf+vfc30TKOp3aSZEzO8Y3a1ZLtoj0Y68izriz+Jkj9/8KY+y0/Fsz/QOS2/BOFj5kS1E8Gq8wSiWn4p55Z61GtGsPAWn1HzSDVHeIgX0t1gCHTSPttN6FY5J6F/UZQRQ2RhICZNiJRIvIgfE2bAXuM9rCOehvrd/VZee08HEN81UrGRIZoxzdvS7K13ahfdTlAzKCEwib6Vt04px08IHcMwKhj6vbtTtlNUAb4t58fPDitrVeuDEmd+cr2qCcXTfMc999zZEfiOb6voVt2RunL80k395RuvkBevsU8iQ0Bo22VsVASWGWM2RFmC6txC3a2XcadAOKJRzjiKhVatflFtL0ZYGTaOX+XAzU+jPphGJbY6j7ftYS3MUY0FrdYuZ+V1biyNNuDsXndD5Y4RNo7jdKFXISSxp5suwfbaNvEcRkdT8wansPECmLPYYxbHS95Efw1W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(2616005)(426003)(7696005)(47076005)(966005)(478600001)(336012)(83380400001)(6666004)(316002)(70206006)(6916009)(8676002)(70586007)(186003)(1076003)(16526019)(26005)(4326008)(36860700001)(4744005)(8936002)(41300700001)(5660300002)(356005)(40460700003)(81166007)(82740400003)(2906002)(82310400005)(36756003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:34.0709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b923f-eae1-4fc5-d452-08db2969ede2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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

So UMDs can determine whether the kernel supports this.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 64214996278b..81e409501f58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -110,9 +110,10 @@
  *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_info fields:
  *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_inst_cache_size,
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
+ *   3.53.0 - Support for GFX11 CP GFX shadowing
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	52
+#define KMS_DRIVER_MINOR	53
 #define KMS_DRIVER_PATCHLEVEL	0
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
-- 
2.39.2

