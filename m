Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0918C072A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 02:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B1E10E213;
	Mon, 20 Nov 2023 02:49:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E5D10E213
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 02:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7X2LRhsC/4ak7mG/Qq4wlk9Jfw1q9MT+q9KRlJQHvabMLXwywxSBXr+RLSGTKVJTqWcermDhc5S6ZQOqmvaCkFdoW708tK0/jK16Hy6yk0h06ob1DUoFcb+8wIXKiYxXTRJ/tlZ6N/tWjTxmscqNAYp66T/I9j0FA2G4mFu/bopuX0458SOX+sO2NeGFbFZovPfUi4ObmClIdEtQCqBmmQnvFAm3nuuwr8WioCUXZ79tyLx/24LyQEMITLJWMmLLd2aHXdleIKMVyvfXjxuSaTxDbSeSiX5zef2Krhs5n4t+O6NGhMVQgmsJQXCTMd5xbrrjVM3g9/j89FPqnaF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvb6xpaxg9J9hJnG8xF1XGFKnh6IHUUdmAiaFAtydqg=;
 b=St8JBxkHIS+AQZ7mfR68tomNfLkKESWlSePyAtZhSFvWZhWUsUf0LHMKadNZuRrPKv+t7ben9tszFuFC2zB5QGQHe5lVp6YIxrvbfUxEJaImKb3DgtG8r5oGyTvrjrFstf/8dT7jkbnDIFybdeqYadh6fPUf507oxqF7vvLKBSXP6KiMktWDsuzgssxBhm4ZZ988mdHAWjp7vYYrQRyaCfRctp7ZgEnhB714CHNyu33QPb+PHIBsvD7EGb6aTdoex31GDFCfb0ZdrsO1cbjOc+jeX9IJcz2eaP4nxZP4U4/Xsp6XQfhUMlDMkKsE+wF/K9/TsZ3SvakIQxhF8C/2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvb6xpaxg9J9hJnG8xF1XGFKnh6IHUUdmAiaFAtydqg=;
 b=IhubVs1dF8m+TagrtxzjThgGv6RVKaGTeeHpbYWYQpugHfoWlHvFJTfkZXsm0pBb653TVcOb/cnv6aROwTS7Yx+6quh92MaiP0Ot9LxBIgsUS9zqOgMMoMixTJoDz21ZLaxqKD0d3d46LnMsmC5t9N420hlvo6H51scGpiUo4so=
Received: from SA1PR02CA0006.namprd02.prod.outlook.com (2603:10b6:806:2cf::15)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 02:49:38 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::af) by SA1PR02CA0006.outlook.office365.com
 (2603:10b6:806:2cf::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 02:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 02:49:38 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 20:49:35 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>,
 Candice Li <Candice.Li@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Do not issue gpu reset from nbio v7_9 bif
 interrupt
Date: Mon, 20 Nov 2023 10:48:54 +0800
Message-ID: <20231120024855.27697-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120024855.27697-1-Hawking.Zhang@amd.com>
References: <20231120024855.27697-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 455d7dd5-5b39-4485-a1dc-08dbe973564f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TGY0PrBgFJVbhLGUtbVdsvrgUOMwrmErBOA4PS2hY5jRSAJlDwwXMllRv2YQG51xWBJmZV0q/UpIV56m48SbE/sISdHqmDtmuh6UTJ2iVMNJKxMDbZ99BvkpngP8xR5WjVv2RSbIwwfPlwibswYsd/IX7aXlzUDFL8zyisRNkUqX5irBgkpaqKmJtkyVH9N+g0MUR+t6dQbMXkR5ilmgIJCZJaX2zihlKhsb5GIJTU9RFE7cr3yBVCMXghun48D3jgp3NPK90w0Aot9oulygnqrgru/V5CwhgTJ2N7Uh7bQgWJlFSP2+kOna3lZyEyTqg6rY6VROgU827+G44dzFeaFeUlvke/7a/ZTK1fw+QQI5TEQjRXda+FSJwOTvHYyb0nbWh2sZQNGsI4iG2IazQcOdyexDuZEcSZvQneODrmBefJAwVS2yanBAcVmtHz5SlsYF0i+G83j3wMzaV7m4Ei6fXpotXcPLsk5VMt6LChm5/cGFEyvbTQoWzrZejbnsXocN/KTMamhimiIoetSlUcnJ+6qCKSHbzFKST/CMTXYNvVIFx8pMym6vh/DWIxfadZocWjtNCOK+gtJsPbZmrnV9LSxOgxcFWeYIJMneBnZ3NGb34hySnlJOAhdntrDB4KjR6BTj1/DUgxSkBYik/mwyx6YkWHP1EvZcZe7jgP5H2Zg9ApAshe2CrRkfHGeIZ5ATO2EyqvRtMCWMX6vZPttV8G/Zj51ZlYwO3G5/PsyEnNFE86F0nw9enMRnxCuf+0Q/z8mmCrpWPl9xIi+DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(82740400003)(83380400001)(426003)(336012)(16526019)(36756003)(86362001)(40460700003)(36860700001)(47076005)(81166007)(356005)(70206006)(70586007)(110136005)(6636002)(8936002)(8676002)(4326008)(316002)(41300700001)(5660300002)(4744005)(2906002)(1076003)(40480700001)(7696005)(2616005)(26005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 02:49:38.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455d7dd5-5b39-4485-a1dc-08dbe973564f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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

In nbio v7_9, host driver should not issu gpu reset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 23f26f8caad4..25a3da83e0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -611,11 +611,6 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 		dev_info(adev->dev, "RAS controller interrupt triggered "
 					"by NBIF error\n");
-
-		/* ras_controller_int is dedicated for nbif ras error,
-		 * not the global interrupt for sync flood
-		 */
-		amdgpu_ras_reset_gpu(adev);
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
-- 
2.17.1

