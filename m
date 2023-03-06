Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C05C678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8158810E062;
	Mon,  6 Mar 2023 02:32:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDDB10E03F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npravKJNR7CTfDfc0lsKM/cy6CMhBphJb7Z3rLK4fQ9OGCNbFN5g7RhFGF1Mo8oeNG+F/pDLPN59cqgUEe5J/QOLPEcaLr0ltTNRhKhQNsIpkC3ldSLWmwlL9IRnTK78VMCm+OdsPCssk8Isfg5OjcUJlbqUB+E+Rv6uGdnB6aNCweEH6runKhwYlnR4WygJgHsOYObVlHIOZSko+FaHAmGNxMZmai30j1rNhsAYHqWuK6ZFM3rGIBhUc7ThbDAbhBP6BQnF0uMiA0coiwyAK3lS6a7htvkYniJHrYPjvmh4LFvwJr+kybnPAucyPuw1dxO2/eLSjtQnenyyuaCaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp9yEXqSsLHvpAO9+aZaLTqEbon61IDFInyQ1pzHymE=;
 b=UyYhvpT2kqtTviyhH2yhe4nnXSMbzc5k+prCcNOz8iqMxOjLJcKKTlmMKQLQV+TtEZEpHF+e7y44fPQSo0m9ge8SyXDHh3K9nQTg84JnFIuPZAqBCyC4DvqQv3+eKnU3RjOlJrMmLXvaDWtymkcfkfVuGrAmOrPC1s9e9vHkVgvFhF7CC3GCuebt2pM3p/wpeZlW86/GMQlXV8/C33qg4juePGA9ssIpYnNghCqpxLh/7l9Q/YhGuT8cKkQn7LdQT1KN7MHVl22FoaIN3alRu4QMtbebqRKymczCEO/Z9Ar+KY5mI94JG9mr/Iatx+6UKG13JiqVmJ0gAJZoh4a+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp9yEXqSsLHvpAO9+aZaLTqEbon61IDFInyQ1pzHymE=;
 b=qmGs9mZJExHQ50YL/3Qy+euHvyQCK4EBN+AAvCsj1F5saeauHEsUE4JthwuDikenQr1GTgcDZFpISnEMlBcGsuWq86f3BqYyHfi/p3andtrVuQISKjd09ZqE4zL12o5BZNazHB1d5wRTmYgNEAss8LcPVaiiQIdkLGgK45A8DBs=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 02:32:45 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::6) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 02:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:32:44 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:32:42 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: Move vcn ras block init to ras sw_init
Date: Mon, 6 Mar 2023 10:31:51 +0800
Message-ID: <20230306023200.29158-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7366cc-0ee1-4dd7-49af-08db1deb1150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2DtPrqmNf3EHImS2AfN83hGvWmaJ50drtnNDm7Fv5VG6CODJtm9pf/itfRn7IRBbHReTDhr0+G1xFfoHqyyAvtksoBH9vFJ4fUN8YMEQPzf1NYFnooXUUwx9A/tsgDDEPNYSL1zoIv7YhMCSIueY5+oesJnl03CfbQ3FS369dpa3Bj7XHD1D6HZjkZY5lTmGVMsOuMCByJEzmbRAhHlVtPiron5FgrwimwxUWkKQIcHG6czLFhinItAMA2jo7Bi7IrebPEDeGno7/4oENM5FSqzToM6tfKoBAOffD489ryuU0OZWRsdTP1jctliFOELfH+e6vpRetu0SuxYH7Uzzow0JMY2txNKXgOOxZVGUJ4QOQg3YVAn4+BLWi4FXQ7wFrzG4MCbXqmzDOQZqEQ0AHtqGk+gau2CA6ybYEYiA/d3opv4YBAG+J1myHZodecCHeeyNe0Lz5Q1NUomP8GdG3gRpKqhBRl/pSa5OYanx7KWvR0pZpiu7i0Y+kFpR88Otr0ecdSuPEFfFN9MwSEeduZ/wuwlyfzUU+2c2bNapNPqsyyla8WOvWSaVsBaTR4GZG6rOIgiJsyWBBnXiNzMqrJ3s3qZqojoiAYCUPoXjVcJVRoymtWNob41PcyWN63dDgEVLwvmBe2dxluhpLPv2QXgEqovlhMOQEFp94K7PYqHh+D9wuhUQScayhFEyw2Q8jJg0I3lbzKt20OJtl7zpHn53vFH6Wsd8oObBH0KM9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(186003)(6666004)(81166007)(356005)(8936002)(36860700001)(4326008)(8676002)(41300700001)(82740400003)(2906002)(70586007)(70206006)(5660300002)(426003)(47076005)(7696005)(478600001)(2616005)(1076003)(26005)(336012)(316002)(110136005)(6636002)(36756003)(40480700001)(82310400005)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:32:44.6645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7366cc-0ee1-4dd7-49af-08db1deb1150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize vcn ras block only when vcn ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_int.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 29 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 10 +++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 10 +++++++--
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 02d428ddf2f8..8664a5301b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1158,19 +1158,28 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev)
+int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 {
+	int err;
+	struct amdgpu_vcn_ras *ras;
+
 	if (!adev->vcn.ras)
-		return;
+		return 0;
 
-	amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
+	ras = adev->vcn.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register vcn ras block!\n");
+		return err;
+	}
 
-	strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
-	adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
-	adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-	adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
+	strcpy(ras->ras_block.ras_comm.name, "vcn");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->vcn.ras_if = &ras->ras_block.ras_comm;
 
-	/* If don't define special ras_late_init function, use default ras_late_init */
-	if (!adev->vcn.ras->ras_block.ras_late_init)
-		adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d3e2af902907..c730949ece7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -400,6 +400,6 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
-void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev);
+int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b0b0e69c6a94..043c9e0d956c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -225,6 +225,14 @@ static int vcn_v2_5_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
+		r = amdgpu_vcn_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize vcn ras block!\n");
+			return r;
+		}
+	}
+
 	return 0;
 }
 
@@ -2031,6 +2039,4 @@ static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	amdgpu_vcn_set_ras_funcs(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 43d587404c3e..73b0b1b1beec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -181,6 +181,14 @@ static int vcn_v4_0_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
+		r = amdgpu_vcn_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize vcn ras block!\n");
+			return r;
+		}
+	}
+
 	return 0;
 }
 
@@ -2123,6 +2131,4 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	amdgpu_vcn_set_ras_funcs(adev);
 }
-- 
2.17.1

