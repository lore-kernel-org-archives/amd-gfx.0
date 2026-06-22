Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C1CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819C410E496;
	Mon, 22 Jun 2026 04:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gjuEjlRH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A35E10E496
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF71keojvw+LnDf5JNUmm0351DT33bSSMgaIkzfuUnJPURh1sghfGgz70NdvNnozurC5ZuW4xhsETmhQe9RbHnMMzZbF5nSSSqMKLu4cnILP0Adi/oEZtTARgKrWOKKMsOsSqZbTdvBJ3wTG6EBdQ3OLnMdtU2v/Fdmq4pIecQndro3GW8Qo/jxpg+4wHeYofwKrQBsghC6IR8jRjkfh2FX6PjHdYkvfntlhjJhZ8AHmyC+QED7j4O2FDsH4dM9LHqCX8casWgCRUT9WK3aiOtbOGpqYxBTO2RUbr9YcrGUzeELaqETIi+Ib9OIPxTxcOZsnlJ3Ly/6MsnZA221D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTFLFN1H6fHYCO2lmM8xDeEzdOLXJvdW4VmUAqSOtZU=;
 b=YBxVw8CNah6H+GIQ10j8z+sU5MmyM46FOszfPdkMufqUX2e0sb/HnUc+Ox7vqpPZ7U9dT2X5joNEBYy0lQPUXA9UreVtZ1JcCOU9Xr+zqC/tN0ITZqqQrxD+tUYYeYV3DgbzZgEoOYjjCVvIT+CfB6NRzNMNwuQI2bROH+++KUtzV5dgFszIk2UG57q7Bo0e2M1t9Y+i0TEFPvXi7oNpQkW565V3zjSGKxHcj0JzKb3KFRvIVlc8fMf9iClH5krTsPkvx8XdWNJOcrcti6fD/StY7yKaxXVwPW4/fN4A9S0j/OJkrvFTuZjD0D4pFrlDXIFrMf3f9E9ZWdtYjdkBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTFLFN1H6fHYCO2lmM8xDeEzdOLXJvdW4VmUAqSOtZU=;
 b=gjuEjlRHebUWILkIshZk/atKj+XpfDfu6f9guBEjc4ufP1wnm9R0960GVOiRww60Ckrj4PMvzhQ59gSO0RM3o16hFQEPCPKdOj2iBgWXcBpbWleVCDhlKJ7lD/THaSGFM3th1skfvgFmnL8kuMyeQ9jFja4rMWO0GxCPGCnH1Ho=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 04:50:54 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::a1) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:50:54 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:50:49 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: re-set ClearMcaOnRead CE/UE in late init
 for uniras
Date: Mon, 22 Jun 2026 12:50:41 +0800
Message-ID: <bd577524ff26f6c9c2d934b321bfee56187ca1f5.1782103766.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103766.git.cesun102@amd.com>
References: <cover.1782103766.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 539c3b6f-5831-47a3-9446-08ded019d79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8FtOih7o+mbeXZzxPSnx/RBA31MqNEQ2G9uDb07+IPsFHyek2GktpVo8GGI+m+iICC2M8GHVv7yKCnxcMpqtWMptAPlUrRwSdWYEy4tNHi9SfSyDl4qnHDgFCQUHXp2HK2FAvTv+75q3RBhqY1NdCQACpsh9HKK6ds3GRazkDDhuw0uCvieeHKPmTkrzVD46Dy9lawpJeNqIlF0OzMfVQM9SnNSiaWcJY4EJ0s1BngxNbNGZt647ZGrtO8tpnvwEY631k7gV25/MD2Zx7jTcbvfw+8QN51wUVWfl/ZE+kgKpHnl+BCAhcolZQvE3q0TjVP2ES6J1CPCp0xlZrrPgk2YQ6TjR433wQ5Czw46ZyWi8LEesXqmugtf157EGLNPDKI8BT+RD/Y+vR3lmxl7YC1LKue2wBy6Mb6I7hu6K+yO8cZLd0IVdWdIsmKhY9yXsJpEKAvbM0iuNmKXXOcLdrJ+RjURXlx7N5ywRtJzCOvMcVCzO3ER/0fY0HBct44mvPzRn1x5IwWgecQUyKUbt3k7ylQKbSOC3CdlHPnvxDxo0ob6tF2blT6H/BLVGVcsNcQVXKz5sfjKwfwPWZNxEu3CqSpGu5m3tQwSFOFYNBWSfsQB7aCZgmc6Jp3g1r4kmfBm23+gk8kOWjDWvDGb+7PbC1ABvw7QuLvLzpHXtXZDSFT479O9538X8DYZNxJlodqA/lD1umqfceXllJmCn3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /4FVaM3PVaJedM25+Cr6yXneo79YTxElWoXvAdqvz6eGV4xaP5uZfGoc2DQ22y4urDeDw8VMlHFI/TPscF2pEYNFKNTu4nBNReEXU6yRe6orbss9jiEm4m/Jr/AN5oSzYpJjjp9LKsuL2oX0SgTfIQ36kGUNItVbaP7hcZcN2EkPsQfVMSX81ZyE2Lt0IprD+Pz16C5of1wVFx7gr7G4gEn6MpGQXqNXPqeA4zkwm6Tt9HYjjPGkToSOgPyYHWPB+hobmo4sXzrxzP+gpi8F/ehLQi1rC5uC/RU34Bslm4rB4xv1+rNlPsp8T0GRxmKGY2tt3Xk+WtIWOwv1TyRAbu+dr06JBVkBGEbSAaxE4GeOABfJXuj7VTNPFv40rhfH/tvWhmWe+rfPWh5v3IcnjCLdGElglo8M54sgiztFP07d6bzPLn3XIAow5axoyUm6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:50:54.3043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539c3b6f-5831-47a3-9446-08ded019d79e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-set the ClearMcaOnRead flags for UE and CE errors during RAS late init
to maintain correct MCA error handling behavior

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 465f82c660f2..953a35ec93fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3903,6 +3903,9 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
 		return 0;
 
+	if (amdgpu_uniras_enabled(adev))
+		amdgpu_ras_mgr_set_debug_mode(adev, false);
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
 		if (!obj) {
-- 
2.34.1

