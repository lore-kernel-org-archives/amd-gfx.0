Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A8CC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E2E60F91
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01E2E60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C956E1F6;
	Thu, 12 Aug 2021 06:17:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622CE6E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiUAnfX0mUvsRhIKcAnhImDBF1tY8Z8Z8LBeMP/mxlcIb6ZlzEbdFHPUJlDokq6oGALPjErUygoJGuVNgFqzcZy2fLwK80bas4Jx0VKE2HW44oXloPEfYeSNqWQGbqMKNZPgkaM4jjxmLvtxDGNwkCk1iu5VLcxIZujf5z3NO8w0aKGuNJRVrJDkVSzUxEhIjYxyuBKEpxsE6hWHeD1MUlRmQ6guqLJg1wHQz7KYn2F1iOX0GBzuwELsm6nBx5JDBvz3pqx4d5eyW0sn8oSqOEkhs63ibUa6HjBifgmrnH1jmmuV/xshsueROhw5aAwZC5SKw5lbQRX8OIrmt8XnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Ut/ekDnL+Z4Mew5l2i1eoa/OP2ldGPlHP4pT9mtJ4=;
 b=Cy8eYhQFAyzzdsKb4TaTeYn9nSX4hEUv+KnZmzsJTTSWjxHEUHeyiHGr7kyfPE6+yZW/hBtQexMleLUWWwPZgKt2ZYRZPlRiqwLbPNES7hQi9JbDzle8WvvY1XcI+PPohMFU430rS0qNgw+6FSo7SnIz/5aQz867h6n5uiKkyGnCVjmoOyGi3e/wsRNVZfoxZVFkhCo4HQ2Su/9D1PqXgOizDRAqvbyxPJUd/WCEsuqdmYBLhyADC6HFwQY0cgPSxjwjg88rsdlIl3uJ7T89xkNwpTToE4JGCZOh4gOmWfhP6za0FiaKPSYiWE0iipQPHgNBsmHj7zATpWp1t6KyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Ut/ekDnL+Z4Mew5l2i1eoa/OP2ldGPlHP4pT9mtJ4=;
 b=t/L2rFaK2CeK2UfEN2FFgCUn3zbWL2uT3HVTAKAk4sl2IFjW8ES0BAidgsckkkI5PT5lbQSwAhZQOGpF/Hs5fJFDuDmnuoyr5ajvygUjLAuNKWF0CftSoGwGAE6FY9Z1Yf60CX6BO7/ByF1gSdHqMLohuMYLC0WA4kW2evfnstg=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 06:17:02 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::75) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Thu, 12 Aug 2021 06:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 06:17:02 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 01:16:59 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov for
 aldebaran
Date: Thu, 12 Aug 2021 14:16:52 +0800
Message-ID: <20210812061653.1286150-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8e05c5-98ad-4359-2fc2-08d95d58ccb0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-Microsoft-Antispam-PRVS: <SA0PR12MB457342F038B8A0D1CAA85405A2F99@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aa6DWODkIYwtpWumhhjpKCWKsr84R1rpNAtpV/9VGWfHz0FxfafaAw29hR80QJTcd9h2gTnpAltYJp/xRNODpsaWasDf9ny7bR7keSrMwAMRXTuBckKgP/C79A1tsELOKUZ4BTyijVfIejL1go7PePAcymQ0ozOPoym8J0Gzw48Y7xa+673+hrhdcqEBFOgRDOJ8v5Nfe5IAlYAzw7zxQ5/tJo/tETbUVxtHprfhsuc5nTxghGsMr1NkvbjSYxsfBohTrAc4UiFBrTn0EztdRznyQglOWOiglg+1BYRKtzRakBsfZUmE/WioV5oaP4ZOchZpr5J/9ignSY5Lmn1dijBADDlRtZVosCpt8UrkERkYLguL7JHWmm8Bh5vvcGBlveHsXa7cgUtVt2tTM9om/Xqa0KgRTgbv1F8S25zlbqbDJ//gDn1C5dtjHouMqSJdFoMBCVTaJaiEc2Qxj9s6dvMflyZKunHs9YqwmAztRC5cDMdka2RUeO7ZUHJj8niVAlWPYbqsFW0EL6F7lQsYLvb+bZF/QVxSI2RAA91vZ7sh9S8aFeIaYG0tY0SsX1v6qO8XB3ElDhtzP1Kvqq86GDP2UlbKAP1lySWzw4LpVzn84847I1iTcHYzrIgI2bZB/DLW5+QbLePTR6P07ZKfVXbUay4HASMkBxK/RrIhcZyk0+y/2qx9t+/yf4qZa1GvRlUs2xdQR2cD07uS/CTRV2awHr6bnnfqLGBFoUZsKhPI6/dOcbXdqZjDcJynPoypSEqSbIbpBHx+9P7I0D+k4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(81166007)(5660300002)(6666004)(54906003)(82740400003)(356005)(6916009)(83380400001)(8936002)(47076005)(7696005)(316002)(4326008)(36860700001)(336012)(82310400003)(426003)(70586007)(26005)(1076003)(2906002)(36756003)(8676002)(186003)(70206006)(34020700004)(478600001)(2616005)(86362001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 06:17:02.1190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8e05c5-98ad-4359-2fc2-08d95d58ccb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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

v1:
1. skip to load smu firmware in sriov mode for aldebaran chip
2. using vbios pptable if in sriov mode.

v2:
clean up smu driver code in sriov code path

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 102 ++++++++++++------
 1 file changed, 70 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a421ba85bd6d..3765624d8fd6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 	const struct common_firmware_header *header;
 	struct amdgpu_firmware_info *ucode = NULL;
 
+	/* doesn't need to load smu firmware in IOV mode */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_ALDEBARAN:
 		chip_name = "aldebaran";
@@ -268,52 +272,86 @@ static int smu_v13_0_set_pptable_v2_1(struct smu_context *smu, void **table,
 	return 0;
 }
 
-int smu_v13_0_setup_pptable(struct smu_context *smu)
+static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
-	const struct smc_firmware_header_v1_0 *hdr;
-	int ret, index;
-	uint32_t size = 0;
 	uint16_t atom_table_size;
 	uint8_t frev, crev;
-	void *table;
-	uint16_t version_major, version_minor;
+	int ret, index;
 
+	dev_info(adev->dev, "use vbios provided pptable\n");
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    powerplayinfo);
 
-	if (amdgpu_smu_pptable_id >= 0) {
-		smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
-	}
+	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
+					     (uint8_t **)&table);
+	if (ret)
+		return ret;
+
+	if (size)
+		*size = atom_table_size;
+
+	return 0;
+}
+
+static int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu, void **table, uint32_t *size,
+					       uint32_t pptable_id)
+{
+	const struct smc_firmware_header_v1_0 *hdr;
+	struct amdgpu_device *adev = smu->adev;
+	uint16_t version_major, version_minor;
+	int ret;
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+	if (!hdr)
+		return -EINVAL;
+
+	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
+
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
-		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
-		switch (version_minor) {
-		case 1:
-			ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size,
-							 smu->smu_table.boot_values.pp_table_id);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
-		if (ret)
-			return ret;
+	if (version_major != 2) {
+		dev_err(adev->dev, "Unsupported smu firwmare version %d.%d\n",
+			version_major, version_minor);
+		return -EINVAL;
+	}
 
-	} else {
-		dev_info(adev->dev, "use vbios provided pptable\n");
-		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-						    powerplayinfo);
+	switch (version_minor) {
+	case 1:
+		ret = smu_v13_0_set_pptable_v2_1(smu, table, size, pptable_id);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
 
-		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
-						     (uint8_t **)&table);
-		if (ret)
-			return ret;
-		size = atom_table_size;
+	return 0;
+}
+
+int smu_v13_0_setup_pptable(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t size = 0, pptable_id = 0;
+	void *table;
+	int ret = 0;
+
+	/* override pptable_id from driver parameter */
+	if (amdgpu_smu_pptable_id >= 0) {
+		pptable_id = amdgpu_smu_pptable_id;
+		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+	} else {
+		pptable_id = smu->smu_table.boot_values.pp_table_id;
 	}
 
+	/* force using vbios pptable in sriov mode */
+	if (amdgpu_sriov_vf(adev) || !pptable_id)
+		ret = smu_v13_0_get_pptable_from_vbios(smu, &table, &size);
+	else
+		ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+
+	if (ret)
+		return ret;
+
 	if (!smu->smu_table.power_play_table)
 		smu->smu_table.power_play_table = table;
 	if (!smu->smu_table.power_play_table_size)
-- 
2.25.1

