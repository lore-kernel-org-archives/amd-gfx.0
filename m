Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4D4C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 07:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8429110ED8A;
	Fri, 21 Apr 2023 07:06:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2384610ED8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 07:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eccnHQZZg8684+R02lMct5PkS7+zKGmeQuwJ2B1Z7oIXPr5joEyaAPdl9L5u+rS9idjimIgL8mu9BA3udpjQISLv6zqMUUN+NIfH+JtUjILZ7GeF2KBvrtioZd6xNeFqVD50KHgP7UEbsRjhE4y3USyQYjt7J23+azuQbBtpftJguI91EnWiXBbAT+GGkfUAF2r/FQgkdy3cTWR8N63ph2fQlxoVcB+jafXl13DBl4rxTzdYokp5qpEb2u4CvZVxGgCzsLd6KUg6ujOW26Dc7HQs03+yXANksiY6AVI09gJvLWLLfHJJOnjPbEM8bCIdlrE5GOxpws0ZoYNG1WxN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PQgt95UdAyKtG600gbRKTqiYBaCCymgaRrh+Zj7fnw=;
 b=K8/q8TlYGGMLfHA4S5iJ0ZOoWQdtXykm1jyDmmCmnuTVyOeA1Dv1uDT0uj8xBvZJBkecLmp8uik4Zldz/pVI7XIH49UWJUKGCviA2Eq0Sn7NXThmbdNDFLh29EpbcoE5SN+Qml+Vy0GLC7vRE8V/heqkdKlDdMQE9O09CnIob/JZXY13+9GWuKymKS1RvCW0rhZkgqNROp9VWerd9ru9NZcqx7Kv6v0VwocsQsO+mvmL204zaYRu1oF+Y6GwS0+Qko4TfuWwY8yadCx7wDnU1sGc6Kblc9uJfn/4tjA5k7Lix8dS8aAY3jHU5f0jBaJTaXUwlFSBJf6detWbNK84Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PQgt95UdAyKtG600gbRKTqiYBaCCymgaRrh+Zj7fnw=;
 b=YGCxcrJxotC1il76g1RRDctuNEWqNWZHyrg96vXLc/ENjYR4/RACDTPvhZWIjdeEJz8q0PVpUKm1Z5ug53GhMvTVgeg/70kcqYQI8FE/FP5/V5s9/cneOAXKNHbfcbekwszyiuX6kPJDygR7m5PkERVL6ixNlyd6U6DdksZ/xBA=
Received: from DM6PR07CA0038.namprd07.prod.outlook.com (2603:10b6:5:74::15) by
 DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Fri, 21 Apr 2023 07:06:52 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e) by DM6PR07CA0038.outlook.office365.com
 (2603:10b6:5:74::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Fri, 21 Apr 2023 07:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 07:06:52 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 02:06:51 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix memory leak in mes self test
Date: Fri, 21 Apr 2023 15:06:13 +0800
Message-ID: <20230421070613.3820348-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|DM6PR12MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 87715013-be5a-4adf-2a43-08db4236fc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uvVcO7bBB33zag5fs1d18o3+DvD70YH6q7gNlx98tmwEmgCzNyaZD68Y9qmmr/G+efFP2Fb9kAa75YgTp0rcdPOuQhdn5X3B5kYjSn34zQVBJrwdo9pxl+/OIYuB0dVq+tEgTvNH58JZUPtO+VxOCDJyhvS5r8pZlIWwvWxXIb4sg/UMUktamTZN6JTPtq5p2AYWJDUIKuL3GVJ9WKdojd7NCdqVtFDSz/l0ceM4i/vvXxgwfQKfmmZefjJ0FFUEDd1fx89w8SxpkxxDkK6aFpKZg5StuwAiLqMVv3P9+KlihQSAugeggvIgQbTHZO0Xzd08i2BKc5BYUijF4pQZRi7kbEm/Pn13bSufzBz4mA+zyvWQp7ZO5axPP5/eONsHieQ1D7iyLxccgsK+Uc+yTtxModJr86KZs+y9n8/sgFVMmg1PqCyiMLH7Fu12byx3rRYI+aiX1gk/qE7rERZ2Pv29IrjgsAP0PdDX7kgANii1mx8YfHCLcoL5RobkehU1B4Z0RXnpSsahZwaCy4Y0i4kddywXlYou5HJwKYfJ5ezDPC9zurC7cAy4oUEhei4P/MGBFo5tZxKBBZFp9tCg0FB5QAnKgf1vBrBMydMGJHhumPKbQ8LVESdmiRI+7UzncaExdOrdKEUQr/JUYReZ7oO6i8QJKOFfHIAAP2j0uVJ27VK53YMAdyqARCksPYK39ibTTLPw1kXn1LqP+s2WiY0B290LHDNNhOGhU79k0U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(82740400003)(40460700003)(426003)(336012)(6636002)(82310400005)(4326008)(316002)(47076005)(2616005)(356005)(110136005)(478600001)(81166007)(36860700001)(40480700001)(7696005)(6666004)(5660300002)(8676002)(8936002)(36756003)(86362001)(26005)(186003)(1076003)(16526019)(4744005)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 07:06:52.8171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87715013-be5a-4adf-2a43-08db4236fc24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fences associated with mes queue have to be freed
up during amdgpu_ring_fini.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..4a35cee4cb83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -361,6 +361,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 		amdgpu_bo_free_kernel(&ring->ring_obj,
 				      &ring->gpu_addr,
 				      (void **)&ring->ring);
+	} else {
+		kfree(ring->fence_drv.fences);
 	}
 
 	dma_fence_put(ring->vmid_wait);
-- 
2.37.3

