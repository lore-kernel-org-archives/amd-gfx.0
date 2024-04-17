Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2BCC001CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 12:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AD611344F;
	Wed, 17 Apr 2024 12:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QfgcMVgq";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42E8113451
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 12:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZZNHgezguyngIEWWaM5FxN6cQnrli+g7Q9J1ZdtxoMJLKgq52RHeKyAh4TSjFBEyAfhTN21I4r4rooWVSaGuE2kD/QY2RPILAMNDTMXlH7VzQxWMiENrhN1YhrIDLoS+FnUhaIMVfvD052lZPYJPtFB30oRq0xqEjQD6P+DMr+P6A9QM75TZ8sr/StfVdjC5rhOmwoDPNdAWJm2VvSrrr0j2TuhRDalglJnev6RdZp0/zmbGmFVNbRdphfqgzrDqZv8UrV3vo4I9Dmzlu18z6Iw99KFGTmdMTWvWe4SwLVlUldOS1gzMmerKy23QYI3Cf/hq+iGW9JqJVov+cTORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdk1EQpf9C+YzNTxu00iLf2gcJPR8VeAlc3wInU3avg=;
 b=H1rvLDQKXJ5M5o9bkHflwFwB5fcAiN11EPEg3NzNGuMzMWJCXOn167fJknDA0mK5+qdvyR83mgyPsRntVX5AFUQhwAKb/Rt3X4TZx2bzCi1oPiyLBEnMIog4XZgroRB+uQx4louFmYuGdVQf19JH+7bxflfmOvylJxl8m+YaQaDSytAVumlhXnLymITLHclKc9TycM9NGOjOQvG3FaeSTaW/CMJhAjwSBAzGj0XQhq/gbnPNFxAFA/yeTm60deiAMBSgzUvte+sGPpC9A74oKuJ8f07uVXRLkMeZWdoZYTz5XHjSY0Lj3YE93duJe7nT92JslFSODKwmxCEXalNL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdk1EQpf9C+YzNTxu00iLf2gcJPR8VeAlc3wInU3avg=;
 b=QfgcMVgqt/BpTp8NLR2YLw0/AlJeBY2XDb75GyhvIFNs5TbLaBCo206Fg3/g82xImllb4OYq+zvSsEMsrAuPJ1VQOpQ4wE8whCohIdDtgv1mVpzSkI7IwoOfCtPlqZZ5ll2xMpkNUk9yMWyHKPNQwLqnUXLdqz8dDBF6q9LB/i4=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:01:53 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::a7) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.38 via Frontend
 Transport; Wed, 17 Apr 2024 12:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 12:01:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 07:01:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Restore config space after reset
Date: Wed, 17 Apr 2024 17:31:33 +0530
Message-ID: <20240417120133.167619-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5feeea4c-ea1d-4142-3fd3-08dc5ed62b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6p42eaKjgE+BMCKgPOjFYx0fLpCQ7iOBUqfPiC9X3N2iBXi5wnt9eygSkUzwFFImmZWHEsAKq7yLzKZC50WQv4ZbmQBYX9kfoo25uBblIoxThN9UBKMTS3Q349CF0CIECr7UIwR5zwZuTEj944uCamlYQN6h2WXz46dYUDzVmn/g/CKsgbZwhjTIZ3wYdM3Ikg8vIgcmpq9ZKtzGsqsmcVtTQTJuUARgNe2MQfze6OZD7txevpttMPtzISKfz6N6yg4MYN8Ii/kh9ao85Y/QOsTbLBxQNeN/ICERg47fYPbSrPn0gYQKLWfW+3X6cIfme/Ft2rpi/pEJUnZEHiF73JI+QAZl+bcaKgFw0ovMiwh5RgrKw/ZwUv0SdLt1WayqBlhfgfdncOyWzXwjOb1mo/9Qy+n1puKro4zyfILwGp6vQ86rsDl6XtZLDVtwprf45gJqHEN7A0yjBMmNEvzdKbSbhfal4Qi+EAED3eCPBzA0aQd79CuvBSXr/cPdss/pFxkBEtdCI97WorJBVID+QtIPhD6GX5sOWRDtQwfyy1T2ptc5E7io6RHdFPNEaI0KGvwU3LmU1VMbLhltmleyaM0/mQKm6L0PBA0KO8X2EnAl0Lkx4qZTofsEg5ZPoGewA5d5vidAnJf+f6tdIo3maFXOTMnANlBPDJ9pcBGIVDsTRODJTSNsxc73A9Yqhw2gxIJh13dF15ok/qjdpBZiMTaWRT9cWjxBrmNToYuwmSG74wd0FGZKEYPhf4VIXug7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:01:52.1244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feeea4c-ea1d-4142-3fd3-08dc5ed62b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

During mode-2 reset, pci config space registers are affected at device
side. However, certain platforms have switches which assign virtual BAR
addresses and returns the same even after device is reset. This
affects pci_restore_state() as it doesn't issue another config write, if
the value read is same as the saved value.

Add a workaround to write saved config space values from driver side.
Presently, these switches are in platforms with SMU v13.0.6 SOCs, hence
restrict the workaround only to those.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 59e5c6256ea2..ef17c8c1bf39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2315,6 +2315,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	return sizeof(*gpu_metrics);
 }
 
+static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(adev->pdev, i * 4,
+				       adev->pdev->saved_config_space[i]);
+	pci_restore_msi_state(adev->pdev);
+}
+
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
 	int ret = 0, index;
@@ -2336,6 +2347,20 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
+	/* Certain platforms have switches which assign virtual BAR values to
+	 * devices. OS uses the virtual BAR values and device behind the switch
+	 * is assgined another BAR value. When device's config space registers
+	 * are queried, switch returns the virtual BAR values. When mode-2 reset
+	 * is performed, switch is unaware of it, and will continue to return
+	 * the same virtual values to the OS.This affects
+	 * pci_restore_config_space() API as it doesn't write the value saved if
+	 * the current value read from config space is the same as what is
+	 * saved. As a workaround, make sure the config space is restored
+	 * always.
+	 */
+	if (!(adev->flags & AMD_IS_APU))
+		smu_v13_0_6_restore_pci_config(smu);
+
 	dev_dbg(smu->adev->dev, "wait for reset ack\n");
 	do {
 		ret = smu_cmn_wait_for_response(smu);
-- 
2.25.1

