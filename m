Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B167C74A4B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEC110E467;
	Mon, 13 Mar 2023 01:44:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6267910E467
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8N8uu9BZu0NC6/LG7ZxVK4NsyDYoRU/2DULRqVU9nMs6OJMz78sW/nOeA++oEc9y6U/cgtWkNdecqoS0+165QPFIX276vEsRaoz60IVGIljvjMoCfoxh1xXZSSyZTVbvDmC0HBATnMIm7+ZMh9kNJobeN8khFPO/czpf/l3FCupf0PLmwTzhgFDMQ5uKsSj98rDe7lbj/Ki+V+IrlU7gNUB6qCn8PJwliPzlvHMdsLfzmNY9C1JvZTk5WtsyiW13lgGaFTs9YmZOU5WfeIfU1XIXGrx6wZT/1BJTuOsCidm2Wj7X+oIP5SYTgeS6/ghQeIwBuDwe04t1wz6qxauIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XvzoPobnYh9sUUQn/TrL3JgwmEV9rnqnZDchsBsk8w=;
 b=Mvtn+oiPpjqA2omYUuG7Up0H0iPo5sZ/sB/H07EuT6cdh23MUwbCEmfA5dSf56ahuJDY4PTPTGb5ke+1g4bRvnQS3xBspHhzwZu/pRhWNlJQBAGkF1GmEYaVcA5g65VcakF7R+40soTe7LrF5IUyzPe/43Gj7c0FlvcKU6U59NU6K1iLMW/x28755seyjRTMND2iK+ivnZ2sVIZhYf07wWtu/giEb2MsV30AG3TXZNDpRm37xTEfMxSlIvkj/TJVoWfSq8ipkr/CD+Uaqp/zxl013AspOWGB0h/s4jgkNaFcVPtnFCu4r6P3IshVST0nno3AGrt5iKJ7IgGno4Tu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XvzoPobnYh9sUUQn/TrL3JgwmEV9rnqnZDchsBsk8w=;
 b=Db/p9UFbC6DNgMeLsGr30eG7p8shnqaC+3lrmTOXjsdm+ZlSxIEIZ3WQLhVkabgIcSDE565wkGyUz681ozvrqLgS5223WS7Xqt4lv9f/VSYl+atVrsbmROOg0vRp5rsomALmPP1/BhWLOx7CW9e+YcECznxOcNoPMLQyMRa3byk=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 01:44:55 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::48) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:55 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:53 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: Rework pcie_bif ras sw_init
Date: Mon, 13 Mar 2023 09:44:02 +0800
Message-ID: <20230313014403.21903-10-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1a40a2-d088-4ed5-0166-08db23648be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIQDZFUiWCb+4E8Hn4CXwxAK3VX08IoVng4TcX0yxcF7NFcnO/lsxRzcKKeBgNphp+WB03g9/vpYEjGbDY1N8dKiQMQWeqvfb4EkS435H2c1MSU7TZcN9ttb0eBEpAIF6WZoq5ACdzY9SpnHhgkg1sDzMhldjuZp+vVVldwqH32wwY5j/Us2iJ5fbf3e6vl52LrCWC3p4cO9kVujQYJ4CFr06eibDPMabNoRlYNn9+1sdwHzYbZVQZcNFABuDXoU9jH8CDOi49dyPezNQZxX3XrNj6XGe017bdTzz5HWSC95vNbVs8JfPKOr2Zkr2Ct7ihenN4XdgLHLgp5iTipLfLTOV2LDktPkd+WRz24uSN7IOOI5WmA+SQrWT1NnpTyZdi6STyftm+n5lXfsiISdKXaThsc87K0PnhhY/Z4OLVYcQQ2nKNZA5ne+dghEvWpkU7ATiQjV+4pdfFwU89XjfXxBbb7Bp2+MQwOPVLtJzoy/QRx6FXVsCU1rzGhYw8+mUmI7O1SfnkhXd9zcVpr5NiyzmGgv8rHT5hkayE6N8zzxYP4Vft30g3TjUNTvabZSHJNPjkE2bDwPeadgCYtX3G6xMNhhy3qe6D5uDiSAwS7RxP0Ksxb4W116R2S/6o5VTp1QeU1QZEKouFNCMto13zXBDGK13CpYtk/ZoGZ6tO7dK2u+gCBJx8r9uJDM2ARgfjgqbsKZwJb6dYMPvn3ZpYzy0IAWpsiLNHl/PMsCiCM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(70206006)(70586007)(4326008)(36860700001)(2616005)(82740400003)(47076005)(426003)(82310400005)(336012)(81166007)(41300700001)(316002)(8676002)(16526019)(186003)(26005)(110136005)(6636002)(356005)(1076003)(40460700003)(36756003)(8936002)(478600001)(40480700001)(5660300002)(6666004)(7696005)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:55.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a40a2-d088-4ed5-0166-08db23648be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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

pcie_bif ras blocks needs to be initialized as early
as possible to handle fatal error detected in hw_init
phase. also align the pcie_bif ras sw_init with other
ras blocks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 17 ++++++++++-------
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 37d779b8e4a6..a3bc00577a7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -22,6 +22,29 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
+int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_nbio_ras *ras;
+
+	if (!adev->nbio.ras)
+		return 0;
+
+	ras = adev->nbio.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register pcie_bif ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "pcie_bif");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__PCIE_BIF;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->nbio.ras_if = &ras->ras_block.ras_comm;
+
+	return 0;
+}
+
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index a240336bbc6b..c686ff4bcc39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -106,5 +106,6 @@ struct amdgpu_nbio {
 	struct amdgpu_nbio_ras  *ras;
 };
 
+int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 63dfcc98152d..834092099bff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2555,20 +2555,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	 * ras functions so hardware fatal error interrupt
 	 * can be enabled as early as possible */
 	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-		if (!adev->gmc.xgmi.connected_to_cpu) {
+	case IP_VERSION(7, 4, 0):
+	case IP_VERSION(7, 4, 1):
+	case IP_VERSION(7, 4, 4):
+		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->nbio.ras = &nbio_v7_4_ras;
-			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
-			adev->nbio.ras_if = &adev->nbio.ras->ras_block.ras_comm;
-		}
 		break;
 	default:
 		/* nbio ras is not available */
 		break;
 	}
 
+	/* nbio ras block needs to be enabled ahead of other ras blocks
+	 * to handle fatal error */
+	r = amdgpu_nbio_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->init_ras_controller_interrupt) {
 		r = adev->nbio.ras->init_ras_controller_interrupt(adev);
-- 
2.17.1

