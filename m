Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0982E95A9E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADC410E14E;
	Mon,  9 Oct 2023 15:55:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922E110E142
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr6ludjL/+os96yrvzQwM56y81Z6NIoxxy/8Xrn9ReBik1oSN4+LZlbZIl6Tpm7oZ5LrwNp3YBtGNFgQOd16qQN8ykYdY6h023YZCWGbTvX+yxVGDUdsqr292B0UFRbf0Pj395+tLYUoOEIKmUrWmQ4ZbTe7/QvivL0fYRvtCUqFqutvSGPnsnXjIUsUqhx0L9OdOTyA/4ohPU9hK3YD5theczJCPPisGGbNRosB9mSoGhrnVCVWHgAWwz1X49+2K0nw2P9myDVRBGlYotuVrZdqeO3I/alcSl5K8dRD77JKfcfopJ+y9UWnMOlvmOVHZ/dx3PYkLbo31onSIlUz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFYMTZXTVHAlJviL2R9FwaKBcN5e9PgQfz5+Jps8ByA=;
 b=mNXPiUWbTFSAJgL2CPtYn5B/2sx0Iv4lKROL+WYJ4Zw2B+1JzNxHRvqY2bOGVJXKXeG9+pZe77g1DMHLZKRFrV1Ab5U2hg7qoMvBT85xqmXKv7yJQePXLtDoDm6ec7TeML49JnChNGCTuv5NmDZGdtsTq4idR8beQqwMAEH9N1vsOvrw+5CSLBqT9o2AsXC4XGt36ssdhudQE8kkl+W/bggcbm3OeQBGYBEP35xAxDuRq4GRMwa2SEi2xtoaj6hGq0u6NfsXxScM/81hn+ssw9UlmFRO3fq3AWFGBIjaL94vrYsGtmdfRN/CJ8TxOx+UAr2IXp5bAQ1P5iGG2C0a5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFYMTZXTVHAlJviL2R9FwaKBcN5e9PgQfz5+Jps8ByA=;
 b=f2NGn0ZdSs8z6McTFzgBcrxEMiuSDm4Kyx3e2wkCjzj9wRNxG+Tza44rWRT5qFI1U5RWFyKx/GFU6NLOZJcdrpkcrasPQUGKetaYx4luhcPr0Xh8NCByeQybL3VIUpIULBLVrVLl/5IFSvrGJ6OgDjcc3H+vYISosKU3u17N6Ew=
Received: from CH2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:610:50::28)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:55:00 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::5e) by CH2PR16CA0018.outlook.office365.com
 (2603:10b6:610:50::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 15:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 15:55:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 4/7] drm/amd: Capture errors in
 amdgpu_switcheroo_set_state()
Date: Mon, 9 Oct 2023 10:54:23 -0500
Message-ID: <20231009155426.96232-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcd8f6c-281e-4198-f318-08dbc8e017f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0PksdYCw8VTA6WvaBnPTZ0sNJa1qcPF7NnbKYNH0X0/HKLiJfdCRtmI0mib0GpVpI2WML2CxdlxbjkS1QvZ3MF6qByHtdvDOIDCwZsjxXDynt75yC/Nf2T6EKFmy6x3GJarSns9lHVGXUjEBwjlsV1gDAK5sMG81+bmNTlmcnV4uO4oXMUyESJoF9C0n1H5KInyqn/tyDcH4KcT+NGp4Rnfb+F32nouHmRZkLUXUS2GivDNfjFGsAiS3MPPBVbkYG+NoQHQAdIymDp0hGXGpO2iw8cGf5JLXFNEi/jrGdUj/ZAyRaj/BSirBbnwovh94syDSFazQ0Mj0VBlPT7GtMoM+xZEQ0E+p9Kg5uxsgBZ0257eHXZMm2LqlmSPl0gk0f1/NgtV2IFulSHiNoHdn10KvgcGFEw9VPuBeQrz0b2FXxmNBySwQ5yz03VzAhaoTvqZ1fZvyIc9l2Ksbk0fZxr9LRlcZ2TKJkrPO1NonEjCEXwm30mqGi+cjQQ3elJjumPhwWGA5hLUvaTlfnp1kuqSgQQ3Kn/6L4WURx56aN9My9BklngZ33ncOooDxoGW5v3EmRZGmH0zU1pdiDz0z3hrbUnI3cvB1vjy4XyjcUDB9MbOk3syJuS6AgjuOlzitMwxzO2+mHfuAspqeqQ1rLgAcQiX2tsj1jEu9RP/a9gJt/ZjBR9cAdC5fXM8rPr6/su4WDDIRB/+9u/2YpwWdaXqumiR/i4Kk+Wnn6gT4UAoDBuH/RBKiO8+hykC7kKN3YpeQZcWOAVLct3BbcVFww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(1076003)(2616005)(41300700001)(316002)(478600001)(336012)(426003)(44832011)(26005)(83380400001)(66574015)(47076005)(2906002)(70586007)(5660300002)(6916009)(54906003)(70206006)(4326008)(8676002)(8936002)(16526019)(40460700003)(82740400003)(36860700001)(356005)(36756003)(40480700001)(81166007)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:55:00.1547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcd8f6c-281e-4198-f318-08dbc8e017f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_switcheroo_set_state() calls lots of functions that could
fail under memory pressure or for other reasons.  Don't assume
everything can successfully run sequentially, and check return codes
for everything that returns one.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0f98f720d9ca..65a4537ee6f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1749,23 +1749,45 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		/* don't suspend or resume card normally */
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
-		pci_set_power_state(pdev, PCI_D0);
-		amdgpu_device_load_pci_state(pdev);
+		r = pci_set_power_state(pdev, PCI_D0);
+		if (r) {
+			DRM_WARN("pci_set_power_state failed (%d)\n", r);
+			return;
+		}
+		if (!amdgpu_device_load_pci_state(pdev))
+			return;
 		r = pci_enable_device(pdev);
 		if (r)
 			DRM_WARN("pci_enable_device failed (%d)\n", r);
-		amdgpu_device_resume(dev, true);
+		r = amdgpu_device_resume(dev, true);
+		if (r) {
+			DRM_WARN("amdgpu_device_resume failed (%d)\n", r);
+			return;
+		}
 
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	} else {
 		pr_info("switched off\n");
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
-		amdgpu_device_prepare(dev);
-		amdgpu_device_suspend(dev, true);
-		amdgpu_device_cache_pci_state(pdev);
+		r = amdgpu_device_prepare(dev);
+		if (r) {
+			DRM_WARN("amdgpu_device_prepare failed (%d)\n", r);
+			return;
+		}
+		r = amdgpu_device_suspend(dev, true);
+		if (r) {
+			DRM_WARN("amdgpu_device_suspend failed (%d)\n", r);
+			return;
+		}
+		if (!amdgpu_device_cache_pci_state(pdev))
+			return;
 		/* Shut down the device */
 		pci_disable_device(pdev);
-		pci_set_power_state(pdev, PCI_D3cold);
+		r = pci_set_power_state(pdev, PCI_D3cold);
+		if (r) {
+			DRM_WARN("pci_set_power_state failed (%d)\n", r);
+			return;
+		}
 		dev->switch_power_state = DRM_SWITCH_POWER_OFF;
 	}
 }
-- 
2.34.1

