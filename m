Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A921C47DDF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 08:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F1310F6B7;
	Wed, 24 Jan 2024 08:59:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8051510F695
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 08:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyxNLPXd6xinF2D2LQfU+Hw1acnlUAcEvyq5VBF1DnEEcVz/5zJRX9MYw6wQZnYBiVl6wYrNjR0+ymqilMfFoZjomwPDAkHV2fLnUOcl065ro2vuaqrzK8tHdMyT1oKeSiBRPe0HPjTgwtCu7hlPKhPII1hTc678/OCJIq44WBNKl1qGZevKIwWRk6RXvCpLGb2t1ViCO9ADxitqNGdycGhtzscjy9sSrq+g5jtgJBNTGk0maEBDOzxdhzVZSSDSTWWfhX2HSocvEZmOMqlnjOuosSB0Q2435QR22+2bDZInHWS+CmSfv0plY21D+QNvBRKup2tt0sCjEwJ2TTLRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPhmLgt1kNr7JALYZBGFVnIGw3bKSjHDXxeD0tyczII=;
 b=JC/uzd5xcozAk0KsnSNQbhGfe42hU9FGOVb3s1EOKU9DVQGGQuSXkiLGEpKdv3a70aw+QRrIBdZ26IzLuJZWWW97WbKrccqo1LrbaOYVj0cIdvdkHal8ia9xgOUNyqcyh5ccuvs62d+6Ehv4fUvXQlwtgwIO7HLw7Ew4XpD/EEuBvQ/ov5zxbKY2Mu/PDNcAvuPWfSs273H9+U/HcAf4Y0L4HCPX+c3ssRYcrBqPKpp0WjlIYheu6yrRVTxBMZtq1PQeE7Cq0+8G70kmvp+nlYWih03THRL2hGE/iWu5vgHMtr2Q/kztI2LwgxNIpR6/NmJkRMdVlkdtjbFgNneilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPhmLgt1kNr7JALYZBGFVnIGw3bKSjHDXxeD0tyczII=;
 b=iGokqssyKvuEX86EeDtdaZGxrpiXqv+WJg9fuoHeWuQ3mlfOfuP/d+vHpc331jT6DcgpOj0FiRafR/wSjHJaxfzdKVqyh3+avwQP7mqa7WGJ8ClyZsgKWrc9b/BpAooRGCaBrYeTVC8HPnmyfFZO9qDUrFnH5F0qEG6hai7CH3E=
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 08:59:05 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::ec) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 08:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:59:05 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 02:59:03 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: enable interrupt prior to kfd device_init
Date: Wed, 24 Jan 2024 16:58:50 +0800
Message-ID: <20240124085850.29188-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efe6741-f3a0-47f1-f55d-08dc1cbab7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcHC5jnB9SNIV2aJqoxBMIyYgNRwEr1LMkRAZjCIJNLtnsnvFvfdcHD14hD3NxnreWQtuOLLEne8fs+sVE48e4G4LH1X7KrKYHWkRV7WHG46ClppQ78B917YPUflOOMC7qc5wliHrOoYmzTFnEJEEY0S25qgBiP9N6nejPtUNIUpIv/+0CrgrGiaNoJZXp8o3HpItzWvWbvCLjFWYaoEFh5tZIwKbFkkAKqCu2diZQY2XEMS+a0EDfA4fPOPyIVPiCZjG6a9euhVpMwdsoHHhj9egFTkZ3oy+/dbtM7o4b6gvCvqA6yq5duSikqzjShNqfqorouDkOsBUCdlPaYHkUlPi974tb8zbzatoL/AkoOWt039pZdZXvxzAKd6SWdYACe1lNl11kfAa69/VphaCDZqYYeCf3wAxAJPGKWBSUXUz+HrCJYQWAO+9OZhmqsdZIQmL0XJm2WXgF8B9A9O9K6h0ok2HWrVS2Moi8G6TU53mSDwkS1Nlo/Zc9i5FjtLp+Ck9ZgrEUD8ZZRcP7M9EfLPzzI2msLE0Nnt+Mmzu9md6zPwZWdM1AzIPJQUJ139CDlVVItLLcpjm+/J02kD78/Dc2Gevq8ybnhkyNKN++GMkflbiGdrEshmznvVbhnSvzeaKHiXd9rVl3W+zeYLJxX1p6x4dl59iAssetAIVe9SL7vQSmu0hAvfdnRGfputK153pL7rTQutLmXgZnJgzAmayl/aUUxdggGnME+AipaqTSuZuQ7pYERMAij/bFtn3guZqYpTIt7IpbIltG5IbHPuwo01G/8ct+mLmlaMy6ywsvKFbWfNW5UvD8qWmvun
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(4326008)(8936002)(8676002)(83380400001)(40460700003)(40480700001)(70586007)(70206006)(54906003)(6916009)(316002)(426003)(336012)(1076003)(26005)(16526019)(36860700001)(2906002)(82740400003)(5660300002)(47076005)(7696005)(81166007)(86362001)(356005)(2616005)(44832011)(478600001)(41300700001)(36756003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:59:05.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efe6741-f3a0-47f1-f55d-08dc1cbab7eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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
Cc: alexander.deucher@amd.com, Le Ma <le.ma@amd.com>, felix.kuehling@amd.com,
 lijo.lazar@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to eliminate interrupt warning below:

  "[drm] Fence fallback timer expired on ring sdma0.0".

An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
introduced by patch below:

  - drm/amdkfd: Export DMABufs from KFD using GEM handles

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 56d9dfa61290..c8aa07282366 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2833,12 +2833,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset) {
-		kgd2kfd_init_zone_device(adev);
-		amdgpu_amdkfd_device_init(adev);
-	}
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
@@ -4204,6 +4198,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_hw_init(adev);
 
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset) {
+		kgd2kfd_init_zone_device(adev);
+		amdgpu_amdkfd_device_init(adev);
+	}
+
 	dev_info(adev->dev,
 		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
-- 
2.38.1

