Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA22C7EE25
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 05:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388FA10E2D4;
	Tue, 16 May 2023 05:04:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A043010E132
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 05:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP6jKidMcwRvVyYKwxa/K3Gz+PJBtdA54yJlpGxjwYHiF4YD9UrFoDLZQJYB3Q2x1MN8qo+rsVr2655X2nIEk/6CCU2eU7OC2MJiBqFKKrHM9aEJs8JU+4CdcJu75Td8gXVbbt1p44CU4ukoOzoJiitZmmlpVObSCFQsUaHgHEK4DgiKv2pyBpR8I2VBg+0JdTssY3L66JVz9RU5A5G9QOyzartc5ca8g2pXgEeyYZKUySEWQXy+rJwvFjMERI+Mhf6XCkWH8bGJJiwOjREblNrRakMIQdoMN7A5zW4LgHhyvmagIUWMoQbEps+ORqjevr4e0wZiihIa9vXGEdh1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kW9N807oDWEYLaSF59yIq7n21ViiG3BsqUx+vb2jqU=;
 b=nGiOo8GQVjiUTTMz4XNU6jQJw95fHhcgRKIF8dV0Pd4NuIf7MefAimfVu713s3tLx9SpkFkx8mElS2Po5wL4oLAT3kncUlLtRSTyOaseAs+MAy5CApWX/kTeql7b0pqqkF/6Vokv0x4UYDokUmzqeTPF9J0fILgMvdGSzQLtKCViALDybhlk0SDtkbfYvUUdxWXIznrE1gOOXM5C0wfphYXLf1CAgVhzs4oEhmnDyuZEk4CxqVQ3FgmzQZYQUlDPylFhhiWuhOXZ3YIl/IPJQYVt+P2NkebpQ+2DGfABRFpP/2dYVysJAaEuF15YY8q8hdSpv4tCmjAA+8fVsTPk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kW9N807oDWEYLaSF59yIq7n21ViiG3BsqUx+vb2jqU=;
 b=xbUx5zEKK3/71iKcshDKPgl52PAuJZR5i42bcMJh8CmVWIcWxvcLBb0m1kq4Zq18TAEw920HBZ2BIQXSili+7gDz5/nY7qgwDQHzgUzT0Fz3aaVg/3JD0pMivP39ovmr5Jsk8gjoVgP/wfI6XSU9o9i4m4X6x0tMvVJRMKvqba4=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:04:30 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::53) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 05:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 05:04:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:29 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 16 May 2023 00:04:25 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/6] drm/amdgpu: separate ras irq from jpeg instance irq
 for UVD_POISON
Date: Tue, 16 May 2023 01:03:56 -0400
Message-ID: <20230516050358.13095-4-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
References: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cac357-21a0-4db9-4c8d-08db55cb07d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8ldTNKzvBMx0auMhKgv6T6KzxLfQTJ3qDUXuMM/vn5J4qxRbj64MxE4Ojtey55wsIO4i5mws0gSZOZCmznJ9CU3X2lJjNsrVEoMlFDmH+Pjdn/FOFC45vVPiroXzkFSMzyU46XUW2VfzMFmsMA989XN+JzKUS+3iBIYay2oILwDljk3/sRnlBbPNabJuEl2oHrCDyo1lC7noqRJ9rNJAoSyW9TqOYNVWya+Cr5pk/OPTG8O/twtpcSZ3+mbUsVsQrKghEOhdbFb3ITCA2XAvtZizpsghAkOw/on+91xuYbey0JBE7pSBi+VN0URDZqJrxmniNOAZIs1yzueT6W8pv49fORPH+IXosgD08qlew5iRAuIyqPsY8aGLIh8/qNw0lKzOFYKteeYtEmNnkzKlaWpYZmjrO9urEAHq/IcWee2Spe14m+4zaFw0YGtnj0ZqAy1RIqn9+eKmIVMHBOOmamEgdV4zvoRTDoPvo6rSTifiChHNDg03KIZk3a+uj877CF3hu/7Mu60uZWDhIrmHeQIRvZ2W8F0tSZ4H7RaC7UIJtVg4Mpc5bucNXoDoTw/9RuvyOZmEgXjj8IdMoPXoBiudrZ/CIePRLRxxyme6iDlHd8HgRPjhAAbFAnSe03O42L2DZfxBypQOMao6hAWjMvLbxu5wzuYJKaqOPIFLaJfRFMtDyjveib+0tPL2MIametR6vPY3P9uG1eHw6aUn2EeoJkTleR059uO9c9zRYMTxJOu+HDIwuWfj4pRSbuhynll1SIRm/d1+7McZuYhlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(70206006)(54906003)(478600001)(6916009)(4326008)(70586007)(6666004)(316002)(7696005)(8936002)(8676002)(40480700001)(2906002)(41300700001)(82310400005)(5660300002)(1076003)(82740400003)(26005)(356005)(86362001)(81166007)(40460700003)(426003)(2616005)(336012)(83380400001)(186003)(36860700001)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:04:29.9610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cac357-21a0-4db9-4c8d-08db55cb07d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
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
Cc: HaoPing.Liu@amd.com, bob.zhou@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, feifei.xu@amd.com, tao.zhou1@amd.com,
 Sonny.Jiang@amd.com, Mario.Limonciello@amd.com, Leo.Liu@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Separate jpegbRAS poison consumption handling from the instance irq, and
register dedicated ras_poison_irq src and funcs for UVD_POISON.

v2:
- Separate ras irq from jpeg instance irq
- Improve the subject and code comments

v3:
- Split the patch into three parts
- Improve the code comments

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 27 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 8c479669c459..3add4b4f0667 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -245,6 +245,31 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r, i;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+			if (adev->jpeg.harvest_config & (1 << i))
+				continue;
+
+			r = amdgpu_irq_get(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
+			if (r)
+				goto late_fini;
+		}
+	}
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+	return r;
+}
+
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err;
@@ -266,7 +291,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
 
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_jpeg_ras_late_init;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 90516f623f56..ffe47e9f5bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -39,6 +39,7 @@ struct amdgpu_jpeg_reg{
 struct amdgpu_jpeg_inst {
 	struct amdgpu_ring ring_dec[AMDGPU_MAX_JPEG_RINGS];
 	struct amdgpu_irq_src irq;
+	struct amdgpu_irq_src ras_poison_irq;
 	struct amdgpu_jpeg_reg external;
 	uint8_t aid_id;
 };
@@ -78,6 +79,8 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
+int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev,
+				struct ras_common_if *ras_block);
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.34.1

