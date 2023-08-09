Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E921C41513
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 08:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1410F10E3F9;
	Wed,  9 Aug 2023 08:30:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F85910E3F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 08:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL3BJJUQROiI8haq4MLUqwxIBEs8AMWKXuqp7qEszJakquuzUZlv905mYuI69cYCzKwu2PCROB7fLBgIiCTYn56nmPGgZYE0Ve6o7cOeTjkItWhFXebmE50Ej25S154Balfnvdixfuwkt9EiRagwxw7/q7NIdRmlElruphhmxS2C4jScNJPfUuOS+riJd55O6eiamJuxK6oHXGscPi0C5EzYOEaOw1loMzYyb2B0o88J6u2B98xSM8KxGVMlhlFkQPI39l4ec2AaVrD+YLSJgU8KRCTv8visCz0UXl/49CdXZlWQE4ygjrX2OQ6H24aUSMm5mf+jqlJgYXp3upEfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C9V2glI4dzKtPHELRcdR9ifzijI/BMWuwxnY3LYqWE=;
 b=k4vPAt3ziIOOZ4Fw4HZOYon6oQLCD5Ph9KDum2ii261vp2TyrebIDBVaLnn2dul8ZzkRBRYpUTtryBtUz4yaJxOTkyV+V+UgMQAERjy51nWIbGSZBYqy3TbKsKC32VGuSxdeVRqJKoE5SupY03EIVDUbDYo9GIJxo2o0XtIEXiIKGbNHZeGtQfb8O1X3z5gZxw0ewWsZbaHgqaSxIm2zCat8lMbj+AHcxd/lK8Fw7IV2cC5TFYla5le7l7/x6E38C/JHl/5UsBDeMl2JlL4kIuqs3xaJNZnnAOphk0zea5kVASzUJ2+C41Z29R+DJ437kGmmp/aXPqPP5/E+05em/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C9V2glI4dzKtPHELRcdR9ifzijI/BMWuwxnY3LYqWE=;
 b=tvH4WxleagsVv3VhAf9FSUWfRAGkbN4+fWQTB7PSHZmXG9yHtZ278yJfBotxKZLZ9UT08Rj1ZIPajalhcTh917Y7sS023EFRuxnrei1OHHeaPdDNRCHG4HfX83excYJqqzXsxu66aKxsI94C+UUJRWubLsULuxG0wCO+NehrtWg=
Received: from MW3PR06CA0011.namprd06.prod.outlook.com (2603:10b6:303:2a::16)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 08:30:48 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::e1) by MW3PR06CA0011.outlook.office365.com
 (2603:10b6:303:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Wed, 9 Aug 2023 08:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 08:30:47 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 03:30:44 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add pcie usage callback to nbio
Date: Wed, 9 Aug 2023 16:30:22 +0800
Message-ID: <20230809083023.427025-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: cd43892f-4584-4f0d-4e03-08db98b2eeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUWkdVRCEcc/eJjWxA4pngmJe/anxOrWIp4efheMegbnamoEv8/DahDV67hjrXXJVcFnTagZvUeyicEdMdG/1RUiJLsfAUFX6ixtcF1IvgOebJLfWOvUFQcTn4JwoS4HqCVuWhGkN4WsR49jlaiUGGBtCiehKuWsookT44oXMDTAZGszqozp9gs6s+WsXX4oCCwN1ekw0hxz6UYCVpIy0CrNsLkU+rCnwJ7BgaYStdpdgQLMGIgDtnMTtQTgeExRq2GEH1rb3rFEICxH3F2FVpMYSVDFbSIbHLnRVUuX3JjkhROjHuefP0RoM/fmYyfAcTXf7mylclQNrhvuQ05ir7NvAGAeUC1MOINI5/ZdJi67GwF3QI5Mv7qZMc+e+YyoXeHFw7Yh+dcMA4kqLWDGaFipSRZv9EDkq0g1PpnB4WVJ5JSbmC/Go/xJOXUCXWjITRcMuFPR5QywSbu6FpQwz1V/EUSCtC0pLXhkeao6OIO3vDs1fGbad9UnET0nCNPmm4tDEv+dWvcyMH/jLEoudr52KdC3fOcVCnFXgSbfubzmx1t3Z7QHxY1KSl1eMfjx7XzyLP90YbQKddYq0GsiDSDUApUtlAJvLZG/urwsnmAdpUmrPA7CkGGkK98nt82f+i0hWX4+2zrhOGYuTZJb0eO4IihYGPMbZdLYCs10SOrPpMF9FsCKWYRFz/hZfUQQPaFLNO/F/HxEGW1/eg/AtbRBxkFXdQlEB6XUKGE+ovZoLnKu/tQLXDL1+TOCG2uil8wuBr/WOk5KHlP20D4FAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(186006)(451199021)(1800799006)(82310400008)(46966006)(36840700001)(40470700004)(426003)(6916009)(478600001)(81166007)(16526019)(7696005)(336012)(26005)(1076003)(82740400003)(356005)(54906003)(6666004)(2616005)(36860700001)(83380400001)(70206006)(70586007)(47076005)(4326008)(8936002)(8676002)(2906002)(40460700003)(41300700001)(316002)(44832011)(86362001)(36756003)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 08:30:47.7561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd43892f-4584-4f0d-4e03-08db98b2eeaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>,
 asad.kamal@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a callback in nbio to get pcie usage

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index a3bc00577a7c..f65903a41e6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -45,6 +45,14 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_nbio_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
+				uint64_t *count1)
+{
+	if (adev->nbio.funcs->get_pcie_usage)
+		adev->nbio.funcs->get_pcie_usage(adev, count0, count1);
+
+}
+
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 8ab8ae01f87c..39bf845c9cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -99,6 +99,8 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
+	void (*get_pcie_usage)(struct amdgpu_device *adevi, uint64_t *count0,
+					uint64_t *count1);
 };
 
 struct amdgpu_nbio {
@@ -111,5 +113,6 @@ struct amdgpu_nbio {
 };
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
+void amdgpu_nbio_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0, uint64_t *count1);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
-- 
2.34.1

