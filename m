Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77DFC0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 03:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B03C10E0B7;
	Tue, 15 Aug 2023 03:50:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA77C10E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 03:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLnixGqGai5dElqAWdT+H3FX4ihWTOdED3VjevrBHrLvt09OlJdfTtBQifBMYW0IGImOpssJ497Zcnza8EIE27Yo4PGIJLDoZpHIbmubyYL9qDCzo/QF3z8f94CPo0E6jQo1Grz04XtXdfEQStZCUkm97sXDKz7muQsh8ZeSwstU5MHNAvamFpVvf2RriZqkuRdd4bHetjMhPLLQZ7xsa/s50D4K4ToYDVLDYs1RRWNh2/kTd4OU63xu5LE41hdNMO0ruboiGAVfceMTH1i5hxot3wNywxO961HLJGAE5pkhOX3dhjlGiP/Y8hHixkiLsv5Oxgz6hOKmKcwlX1ijlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl4SZWqZDUBlzA6Q7bv3t8J8LDlcig7qnxn28oPbpzY=;
 b=iCQFDdbEbDoWnHxxFG2Z+2hvEg+AVoE0c1D3ljnaZQUW6/0XqMSpVVs4zF1SBVmddZvm5oEH7bHn8vqbxc7yDqXFmEoBu6vZHxY8aMZNU8K8Td+amWZQJJynq46s2Gomltn378FB5Csg5ZmrmQ227pqqanfLd6Ho8j2igiTCJxfpCAWhqq5tCENmLS7AXXfbSNth23TLAnH0Sh/qo/iNhQqXpQpVibM9CjfeF+INGmtsId4sppb23pZLkIo6sRTomRh1CQWm0vRH8EJM1yUpD9tpQ6OagZ2xe+gvs2z0ujM1BoHKSRUs/XfZIcpVDbJD+j7uBlNc60f2LrZdOVv71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl4SZWqZDUBlzA6Q7bv3t8J8LDlcig7qnxn28oPbpzY=;
 b=OwXexRN4skmRfRFZ7GMZi1AaA/MPo4kasdY9xtAt/dAAeCWMNd1+YgMv7WGiGo4Q9Ekp0O1vy6vFA0RwxWRxxHP6GUxRlL/74uIT6REm/wclcIU0KYJJipzFEcOkd4EkPg4yzMFpcSkGL3GZgTrfzZVdkveyAlhHXrBcu/zlVMU=
Received: from CYZPR05CA0013.namprd05.prod.outlook.com (2603:10b6:930:89::11)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 03:50:28 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::59) by CYZPR05CA0013.outlook.office365.com
 (2603:10b6:930:89::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 03:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 03:50:27 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 22:50:02 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: skip fence GFX interrupts disable/enable for
 S0ix
Date: Tue, 15 Aug 2023 11:47:09 +0800
Message-ID: <20230815034710.3865829-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 647f9fe1-3692-4ecd-21ae-08db9d42c38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEyuE8VZFYtzKqrTd2lMkrU7+aQG7wSihhA/GUA0KT5QSjJtLUwYVuzt1QgmJHiMYLXCzBjO0gOJ4OT95RheaaZx9Uz5WLqUMbfF7/2WxN0m5SHBScrEeQXnRtqTe1eBVfZdNs1NpulU80ol6QvOQ5A7/bg2z97u51oWXinnILQ0KcQAWyTpCEO6mymRFJcs8Jcg82JbSCcaHv6fKeWOCe9ZSwdkmAAZNxYtvwV4M2GKZDdRVMUPNomD3UmYn98/RSpXGsOflcMZGWuOaZv3Z/XDMQBCmN4Si2QUt97StNUo8M9D3MMl5qUrarxiwdr5i3/h7kfLb9jE9pRpWwH1nmSF/UHSp0ufqQx/TNe+OsdBXv8sXaJ5pGZdceTo/pFg40dDiWMS6VYx15QD8XO2pSA42PoQQVUak3Khwe8bsyYoNBzClGdSRrcxgTauF2nu3pz1XJTh2y+IWBGb7chbqOGl1o3gBj6nXmEmgGzm+BHp+Nzc8Nh7FudimO+HGzxH1h2RqjtGt4mMa1/yceG80+yaTUAz+GiuHqB9uFP/NKsIBHGuCF/bwR3ms5maaLgleq9Z2FRJbshChoPu6PBPNUH1WQVIaW6o4i+u2oFBEDvoIANWWRqq9/vg0FqbLaBIuITQheTUt514Ut09Lc8m/uoI3F8jKJLUit1VJH9prATdpIiUfTpCE4yPk4ht5uz3JQxNMLiLUikFXye1FikbhyUGrLUB40IlKsQFT1sBObz/FXG75y85LUoAJzHTSI54AJpvwoPkdT8dHGviWtBtQBXoMtRfAZRE8zBmgjnndek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(36840700001)(46966006)(40470700004)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(2616005)(83380400001)(36860700001)(47076005)(7696005)(41300700001)(54906003)(70206006)(70586007)(6916009)(2906002)(316002)(5660300002)(8936002)(8676002)(4326008)(478600001)(40480700001)(81166007)(356005)(82740400003)(86362001)(36756003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 03:50:27.6237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647f9fe1-3692-4ecd-21ae-08db9d42c38e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, lijo.lazar@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX v11.0.1 reported fence fallback timer expired issue on
SDMA and GFX rings after S0ix resume. This is generated by
EOP interrupts are disabled when S0ix suspend but fails to
re-enable when resume because of the GFX is in GFXOFF.

[  203.349571] [drm] Fence fallback timer expired on ring sdma0
[  203.349572] [drm] Fence fallback timer expired on ring gfx_0.0.0
[  203.861635] [drm] Fence fallback timer expired on ring gfx_0.0.0

For S0ix, GFX is in GFXOFF state, avoid to touch the GFX registers
to configure the fence driver interrupts for rings that belong to GFX.
The interrupts configuration will be restored by GFXOFF exit.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 41 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c694b41f6461..7537f5aa76f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -551,6 +551,41 @@ int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_fence_need_ring_interrupt_restore - helper function to check whether
+ * fence driver interrupts need to be restored.
+ *
+ * @ring: ring that to be checked
+ *
+ * Interrupts for rings that belong to GFX IP don't need to be restored
+ * when the target power state is s0ix.
+ *
+ * Return true if need to restore interrupts, false otherwise.
+ */
+static bool amdgpu_fence_need_ring_interrupt_restore(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	bool is_gfx_power_domain = false;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_SDMA:
+	/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
+		if (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0))
+			is_gfx_power_domain = true;
+		break;
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+	case AMDGPU_RING_TYPE_KIQ:
+	case AMDGPU_RING_TYPE_MES:
+		is_gfx_power_domain = true;
+		break;
+	default:
+		break;
+	}
+
+	return !(adev->in_s0ix && is_gfx_power_domain);
+}
+
 /**
  * amdgpu_fence_driver_hw_fini - tear down the fence driver
  * for all possible rings.
@@ -579,7 +614,8 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			amdgpu_fence_driver_force_completion(ring);
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
-		    ring->fence_drv.irq_src)
+		    ring->fence_drv.irq_src &&
+		    amdgpu_fence_need_ring_interrupt_restore(ring))
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 
@@ -655,7 +691,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 			continue;
 
 		/* enable the interrupt */
-		if (ring->fence_drv.irq_src)
+		if (ring->fence_drv.irq_src &&
+		    amdgpu_fence_need_ring_interrupt_restore(ring))
 			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 	}
-- 
2.34.1

