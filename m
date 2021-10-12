Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3054C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 02:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9F360EE5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 02:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E9F360EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0C389D7C;
	Tue, 12 Oct 2021 02:34:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5339589D7C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 02:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDR84QppgQuPuKceswzI0be99DUcjTbojE9IQgdWenjBqdRZvyxZGq13b5/uZUCIOtmdBs+ejIyXZO+siSKZ4I0L9XumCF0ZBPlT7BHABEny1MPMyvpTX1N4ZYfzLskTuUDYN7rqDuObi3hhC7pkgYVPq5EEy7CLkUq0n1K6HhcH6EyU0I4/6HY8Pp0TBn9HQ0mIfysiy+Mx0vCQx761r0tSkp7zv/yswLxruW+WBpqZQBg46ttd7NNQt5Ym527uVxFeG+wrcGF1oIhJUOxxsxQHRgK3DgHf05+pz75E7Cpqi0bH7MnHu0w2F04fNJxOo3+1jorAFEftWmCjruXSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzRjhgGnDVIMFfBF0r/txMM1q+dUc4s9he7HAZId7eM=;
 b=RFSldBb3PxXcKjU17754FMvVBQlAPxohBNm+8hgM1nUB/TZKL5ButwnU7PYnBGo5aoI2mz2t7EijIX41uJpMlchjF7gNJpqf76Mp7shneYF8GQbZ3+Rjq/hJphBk0jWkgnSiQJ/7k8Jufht/gSP+1GmQV8Fv0jiDUzbtAffUqBm1DqRNRNP8P5foCxJE4yeaUZEhSFQtawf5I0m7vbKWxLhcuRzkLS74qtjVn0bCPA4iMIPtw5A/tC1fduVgo2JPT1tVBCvHsNaibLPjC0ZzI2xaBAjs+TW4VBDrW5zJIAVu+KfJz+NXO7hd3H38YTP1aTx60sXITMy/mkwWgpsZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzRjhgGnDVIMFfBF0r/txMM1q+dUc4s9he7HAZId7eM=;
 b=n6ytDe2a85AQX/IZci3bIfv1P/S7hoHevzIb+TxcfewIJhDR8Bm6onzE+0HW3B4MWhpiJ6VV8qHPM0lvee/+5wfiEmPKV2FL12r8YnJG4VR4NSfwv0X1yxtKnBDqbDMpgaf+198w3ZXN227dYTKgCEidOEFWQh92iKygv5oQ4c0=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Tue, 12 Oct 2021 02:33:59 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::f5) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Tue, 12 Oct 2021 02:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 02:33:58 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 21:33:57 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <john.clements@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset on
 Aldebaran
Date: Mon, 11 Oct 2021 22:33:43 -0400
Message-ID: <20211012023343.23935-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012023343.23935-1-mukul.joshi@amd.com>
References: <20211012023343.23935-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef1e3600-5279-4167-bc1e-08d98d28becc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4896:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4896F43899BB9A6D704C6EBFEEB69@DM6PR12MB4896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3btkDrlP+GcgdSepWttqhC4uk0c6jqvR4NrLuBpf+p21DzUjukM3eIi74G0f+2qvWw5ll+6OeNG0+jMeU1S0SlAipNfTHglXG1YUteMiCEKAmhClviRXJm7eKQ+LIbyqApW2aN7oitRlOsWoJGtSp6AJZPW31UP//NkmHunt9uGuJf5CYrkWpIokUX3UTxqo3/tMA9IsCI8XuCp6ofk2MQHaqpDU2WTnJoRAUtYrnspg7h9QF9DCAUbw8wDpQeZUMLRY6L6yI/fXBCEYOa1NpFfQJLPDy6k3iYGA/qzENN85qcEJ+nMtVMuW4DG0/RS9P+puSjNOKtsBOuMZ1O9OkAiuJovYg75STKBy4IFKLrJHmePYT2WNOpWbhUebTaLpHuo6FPBqn8njnHUuFXA4XJt50ALmoZWnvWRFW/KXvXmwoJjjl7OCOq6JWqIAOuMhrQtgAmnXGzYzlWVp//MEKB8xmnzeBmpeBxaKCHTWVC53MaKejCt6pw6NrY/0OpuiaJJ86ZHsEeAnXuihrfat7Kyn7ifBTlQtsZjpvGYjLAwS5/ixBGwt0U8g9vv2gc6Uz4u9ZkmCOXBJlwGGLtZJGcKKUplxkE0LVpRNkGC5zJgtXNGWXVNNpnZr+osWN+PWZudQjAfoRHtyEV2iROEw6m3klQci2VcVL/RLE+6ZTglcKRAjEqSxRJGgXKHpjCGuy9Dt+4GLNSsCBM97nug5Bq1cUf2gJFZDuiIJupab154=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(6916009)(54906003)(8936002)(44832011)(47076005)(81166007)(70586007)(70206006)(86362001)(2616005)(4326008)(83380400001)(508600001)(316002)(7696005)(336012)(36860700001)(5660300002)(36756003)(426003)(6666004)(8676002)(356005)(2906002)(26005)(16526019)(186003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 02:33:58.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1e3600-5279-4167-bc1e-08d98d28becc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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

During mode2 reset, the GPU is temporarily removed from the
mgpu_info list. As a result, page retirement fails because it
cannot find the GPU in the GPU list.
To fix this, create our own list of GPUs that support MCE notifier
based page retirement and use that list to check if the UMC error
occurred on a GPU that supports MCE notifier based page retirement.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e8875351967e..e8d88c77eb46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -112,7 +112,12 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
 #ifdef CONFIG_X86_MCE_AMD
-static void amdgpu_register_bad_pages_mca_notifier(void);
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev);
+struct mce_notifier_adev_list {
+	struct amdgpu_device *devs[MAX_GPU_INSTANCE];
+	int num_gpu;
+};
+static struct mce_notifier_adev_list mce_adev_list;
 #endif
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)
@@ -2108,7 +2113,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 #ifdef CONFIG_X86_MCE_AMD
 	if ((adev->asic_type == CHIP_ALDEBARAN) &&
 	    (adev->gmc.xgmi.connected_to_cpu))
-		amdgpu_register_bad_pages_mca_notifier();
+		amdgpu_register_bad_pages_mca_notifier(adev);
 #endif
 	return 0;
 
@@ -2605,24 +2610,18 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev)
 #ifdef CONFIG_X86_MCE_AMD
 static struct amdgpu_device *find_adev(uint32_t node_id)
 {
-	struct amdgpu_gpu_instance *gpu_instance;
 	int i;
 	struct amdgpu_device *adev = NULL;
 
-	mutex_lock(&mgpu_info.mutex);
-
-	for (i = 0; i < mgpu_info.num_gpu; i++) {
-		gpu_instance = &(mgpu_info.gpu_ins[i]);
-		adev = gpu_instance->adev;
+	for (i = 0; i < mce_adev_list.num_gpu; i++) {
+		adev = mce_adev_list.devs[i];
 
-		if (adev->gmc.xgmi.connected_to_cpu &&
+		if (adev && adev->gmc.xgmi.connected_to_cpu &&
 		    adev->gmc.xgmi.physical_node_id == node_id)
 			break;
 		adev = NULL;
 	}
 
-	mutex_unlock(&mgpu_info.mutex);
-
 	return adev;
 }
 
@@ -2718,8 +2717,9 @@ static struct notifier_block amdgpu_bad_page_nb = {
 	.priority       = MCE_PRIO_UC,
 };
 
-static void amdgpu_register_bad_pages_mca_notifier(void)
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
 {
+	mce_adev_list.devs[mce_adev_list.num_gpu++] = adev;
 	/*
 	 * Register the x86 notifier only once
 	 * with MCE subsystem.
-- 
2.33.0

