Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A99CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FACC10E3DF;
	Wed, 18 Oct 2023 11:40:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FC010E3D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrANCbgCpe7j/kBMOoHBdqKwPtFd5c9U+7EY8/XaiMXZHQtrU6kwdPvVOK01uJilp1f/o3/ANYSTYQ9y3H9CABrGfocHWmrGEGCGlEVINPK7WBspr0xGFtTtllTMJ+q2TeJECZ/TcyXmAuLKYflFa+WuybEOpb+gxafEsXA2OfzMHoN3W+ezvvQO7Q+Het0osNyjwJSNNUcsoFogUDRA2zXHXyj5MrhlPh8ycK/DQUj9phSWubwD3qV+bQf42oPQ5dz9REbeaGFZdH2WMoYWUIrfKpStZ6xoW70iehb/kbD2D1gkCmW4hL0JKNDKdBgBCORQO3/1TZnA2pOB2/+CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMLFLShBjojJb8Apjv7NHDq3trUfl53uU6YrCyTGgKM=;
 b=oCl5C+wtVzG6zgjNQbhdF9Bl4m2xok3wtw7OvmRuh8ukEYxE9g6Zxb1Pec498rws+l3lmZgqycYxqM5fJLIWBWWbUPVGyYSwYIn0YwruegS0/yocOmsKH9MbtH8g0lO1SvBBa1kPuObrBnna68XZolyv4p+JPAgjyKoalk8Q0jId/IDPKQG3dXVrMggiLNl5nEeLFzLn63gPQgiepnrYAZGCEwT/k269wVl3xJEok5SKgzR55pubNQz0KlXdrD0V5wkanwJArWnzIJNzR0NxZHqjYIj32Z7o7kC4T60tOyYP2d3GaheN+/lZ4WTJupe/lNTXHaOqOl+NPS5U+PZtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMLFLShBjojJb8Apjv7NHDq3trUfl53uU6YrCyTGgKM=;
 b=l7qKoA7pkdoJxxv2/gdGisSh/0iUHXvDS9q20bcYCegIMrOhOA68Q4s4Ze6Z4H0hqNYVeF+f9wsEB6hfDMjMXyxEsOJ35KM15XETedNhlCMRIkNjZUSD8kw4oW0I7HDcRKcW9gvP2gp8GDBeHlSYn9cYNPHK9GvGB0B9vMY75x0=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 11:40:27 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d1) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 11:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 11:40:27 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 06:40:24 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: replace reset_error_count with
 amdgpu_ras_reset_error_count
Date: Wed, 18 Oct 2023 19:39:53 +0800
Message-ID: <20231018113957.20079-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231018113957.20079-1-tao.zhou1@amd.com>
References: <20231018113957.20079-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: df4c3e7c-3d9e-4494-ad3d-08dbcfcf0627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YN1C9jr0Xyx0GSMSItD/q6VJgccipqUz7w7CDPgnVSuSwfuK+M9ZqbwFdsNhdb+AVcrOwNlr6Qx60JAkhr2QrHOSORDE9uC7xmxbV7Wjt3rsjicp+pQf44un4iMSIUPbckqpmDPxVrLUKqJINCw6djXq9x9FDD7B3IrcNBBKjBh69zywDkeXM5mjyBiW7mkPNdAQQWcMWVYzEHKBz3MU7c6//pwTfPy6bzANWlHvxcbsr67yXMHfmAod3uxhDOzBdgqIaG0RFd2BDvmtEV+VGWd7HEFZtk0VEEYDtoXhn6qmCCIQr1oJEZqKAZQTvURvoy8v2GxjnoGsCY8LWjKo9e6eStt0pmdTiXcNQ0Xdt2Nms/IyHZkhDcwe0hTYAeFhkD1bKmmLoDI6e+Vb3+ydOvV6zFk1cLxtPcFtm4h9AJtEIjDRNqKEiU/CUbVqyGRR90EFo3Q6trpqzWuepBct3Qbu5PexS3YQsx7CBeC42qknzlPgKu0kjtkeFI2gA3U6g2QiAAa7TwQjrMh57Q7Ft+fx5sGvfcTXGR+Ih3y9vdBEbm3oc2zSaagg7J5OpWGFNLt7Eb6Tv+3aEKMHRSWsLTP4gfvswdN+Bsm6KPT59PdalTXyqin+KB2FeP0jtxSczKtjzltXI5kbzffccHe+njGh1s9SLJb480gIi4VE531/eDC82DxYEj0O3TqvajR9icK+6Zxkej6U/rPET91Fgtm2u3mbLonMkN+GDvTdiyt4rFYy5FjCrvOz8NsRAV20csfOfRl/Ny0EUOLexF5b9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(47076005)(426003)(82740400003)(336012)(36756003)(356005)(83380400001)(1076003)(81166007)(26005)(16526019)(2616005)(70586007)(4326008)(8936002)(8676002)(5660300002)(478600001)(110136005)(70206006)(316002)(7696005)(41300700001)(6666004)(86362001)(2906002)(6636002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:40:27.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4c3e7c-3d9e-4494-ad3d-08dbcfcf0627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify the code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 9 ++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   | 7 ++-----
 5 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 31f8c3ead161..04cfd67a37a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3594,9 +3594,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 		if (adev->asic_reset_res)
 			goto fail;
 
-		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.hw_ops &&
-		    adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
-			adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__MMHUB);
 	} else {
 
 		task_barrier_full(&hive->tb);
@@ -5242,9 +5240,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 	if (!r && amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			if (tmp_adev->mmhub.ras && tmp_adev->mmhub.ras->ras_block.hw_ops &&
-			    tmp_adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
-				tmp_adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(tmp_adev);
+			amdgpu_ras_reset_error_count(tmp_adev, AMDGPU_RAS_BLOCK__MMHUB);
 		}
 
 		amdgpu_ras_intr_cleared();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 70e38b013309..2b7dc490ba6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -914,7 +914,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
-	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
 	return amdgpu_ras_block_late_init(adev, ras_block);
 }
@@ -1081,7 +1081,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	}
 
-	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
 	err_data->ue_count += ue_cnt;
 	err_data->ce_count += ce_cnt;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d95fafe7f7ed..70e7e93d382f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1604,13 +1604,8 @@ static int gmc_v9_0_late_init(void *handle)
 	}
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.hw_ops &&
-		    adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
-			adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(adev);
-
-		if (adev->hdp.ras && adev->hdp.ras->ras_block.hw_ops &&
-		    adev->hdp.ras->ras_block.hw_ops->reset_ras_error_count)
-			adev->hdp.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__MMHUB);
+		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__HDP);
 	}
 
 	r = amdgpu_gmc_ras_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ef04aad788a8..7ae5f134f09b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1750,11 +1750,8 @@ static int sdma_v4_0_late_init(void *handle)
 
 	sdma_v4_0_setup_ulv(adev);
 
-	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
-		    adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count)
-			adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count(adev);
-	}
+	if (!amdgpu_persistent_edc_harvesting_supported(adev))
+		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 31aa245552d6..c46bc6aa4f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1276,11 +1276,8 @@ static int sdma_v4_4_2_late_init(void *handle)
 		.cb = sdma_v4_4_2_process_ras_data_cb,
 	};
 #endif
-	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
-		    adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count)
-			adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count(adev);
-	}
+	if (!amdgpu_persistent_edc_harvesting_supported(adev))
+		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
 
 	return 0;
 }
-- 
2.35.1

