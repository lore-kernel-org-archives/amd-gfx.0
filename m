Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8FAC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A8E60527
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30A8E60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AE66E0D0;
	Wed, 11 Aug 2021 08:33:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B2C6E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 08:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVv6KocWcr4U6NUPCmi1MMHgNzon4nSqaMSIeKQqvSBlCahRqgaBIAu+/UmNokTtJeRGo9KCy3NM6h+6UWNCQe19udFIsTZBYAT9dOCuu4rpZUAIdc1KNAogAAwE1ugib8MZ2gxPjSrUMSr5fn517vUFwQvA05kpHrE0OgxX6PyEgqS8t7pHjGuI9JDuBaf+GT6iOIKtWWzqfXXu+U0XDpwUNzLntwdA05K7dFJI4XPYxTQPVHIF7caf6xplDmXhy1IhIPCDwnOu40xfQKH+PNuM+0u/BJ3JsVQjI8OrH9GMqjNXpnP0q/EKHJE/diz2nvItyI17IeHwPHYXtSLJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5a4HzGj3T0qFHXwcO4vz+L43n+d55YWJaB5tAAO+CU=;
 b=g5sqUvqodkNKJhrXF+ox4G5xudmLcq7osrwWswPoZBMR9ULoF2YfOgo6Ie+Om/B/FlRfBa9YqNMn9ngt4ghaU/bQBzleUKhtzlGlc7dMk1pgXNOeskrlM1h40pE5YB2j+azuh5WmmAovE4xdd1gAtpmmDdDSToJ0YApR9JNXbNEQpuYgWNLuYmgfZTIb7mvwYSfRLVy9Ovm4REkxB55a7jpsyEE99gxewgJQ4W8GGOAzyesu8rgapzoeS7TNHy1j0n/geygstpmX6ChohLce/jQRRLqYy3m5NdtgaWUxoWcLjPUKsIGOP5Wn72WZH02ozI1/o31Z+KEIJLC2ikTltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5a4HzGj3T0qFHXwcO4vz+L43n+d55YWJaB5tAAO+CU=;
 b=RavlIcpXbvxAH3VicTSZYnjNegJJZsVbr5xIlr2NbdTL7jiil3sjfydNjLE6rdOp3rhnG6emFeKEufsXhI5IP7wOpA+SoCtn/eD9e2InOWYoQuINLM+FQF9obLxsLZ9cjT/byjmCy4J5u0/gjhW9YsilkbLY5f3r1oLSRGgzyWs=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Wed, 11 Aug
 2021 08:33:34 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::70) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 08:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 08:33:33 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 03:33:31 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: skip to load smu microcode on sriov for
 aldebaran
Date: Wed, 11 Aug 2021 16:33:20 +0800
Message-ID: <20210811083323.1084225-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811083323.1084225-1-kevin1.wang@amd.com>
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b34972b-2b96-4942-ab36-08d95ca2b4d8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43176CD01BDCE9E31B3BF689A2F89@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4QgudznGOExtjZrr6ziov2Dt8eSQYOFMI9iGUDtgo66MWEvPItc6rFYsOTJ1XBt/Tk1Ilrim8mdAp5aqbG3dGc63sFRfo6EbMXrHCuFKEICPf0tJb66BF7yvQ+NTzl1nRvY/gd4hyLaMBHhsYzJRxJTJGBjSlGm1oyatVlGzGT3TcAph7uBcyDDyGfBzG59U/mnj2oHQA34yFhZF9mFS2n5o0x0WR6zz1wAGOvbwJOzp0KMzT1MXsGWyO+KJUZyEYcdph9SArVCC/1wPvDc2Rtvinxk3WB9f6Po5eInM3uGwxfHiikPM1fFxio7AAdm+8eAqfZxQBsYAXhuVst08ADFExRLdrqAmfvZzoFswaE/8qk8Q3HZGQ2Q4AUTPOaYgwmjq1I3nEuyFBtYebG36t//BYx+Ta6K1XVi8gUFsNwL2XRglSHREwjUTur/ufjlY/yRSBkVJBsS3vz9U0pkbK/E2VECXUJNRl5H1ODoG5NoLmjhQyHL7+Glj3RWrH6VfMLyNpjC8k2pJ3PNXSJgM3yHdO+adjFgB2JJMoj5jMLpIdj/yc/1yST6LK4Lg1zTeU4sVXnFB864CqK8Jrwmfj2HGb7gT15VXFBpuUq72LWhOsFNb3wyxP3kvVanhWDEysz4FTujKoSIazF9eS6++meWMXVvFLXpOFbg3G/JWL1hzKgC3J2g6JJFR6BKGpnN7oNp3ecsOs2B0fLkb/PCVCCrd2qshV/0fngAHo+kt1SF7je+8Kp844Y9j254QinEWhHc0cdodeYk3uZGxxsPDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(46966006)(6916009)(82310400003)(426003)(34020700004)(54906003)(7696005)(81166007)(478600001)(83380400001)(86362001)(5660300002)(47076005)(2616005)(4326008)(316002)(1076003)(82740400003)(2906002)(8676002)(70206006)(8936002)(70586007)(36756003)(356005)(186003)(36860700001)(6666004)(26005)(336012)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:33:33.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b34972b-2b96-4942-ab36-08d95ca2b4d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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

1. skip to load smu firmware in sriov mode for aldebaran chip
2. using vbios pptable if in sriov mode.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a421ba85bd6d..a0ca7e7a0903 100644
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
@@ -279,41 +283,43 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 	void *table;
 	uint16_t version_major, version_minor;
 
+	if (!amdgpu_sriov_vf(adev)) {
+		if (amdgpu_smu_pptable_id >= 0) {
+			smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
+			dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
+		}
 
-	if (amdgpu_smu_pptable_id >= 0) {
-		smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
-	}
-
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	version_major = le16_to_cpu(hdr->header.header_version_major);
-	version_minor = le16_to_cpu(hdr->header.header_version_minor);
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
+		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+		version_major = le16_to_cpu(hdr->header.header_version_major);
+		version_minor = le16_to_cpu(hdr->header.header_version_minor);
+		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
+			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
+			switch (version_minor) {
+			case 1:
+				ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size,
+								 smu->smu_table.boot_values.pp_table_id);
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+			if (ret)
+				return ret;
+			goto out;
 		}
-		if (ret)
-			return ret;
+	}
 
-	} else {
-		dev_info(adev->dev, "use vbios provided pptable\n");
-		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-						    powerplayinfo);
+	dev_info(adev->dev, "use vbios provided pptable\n");
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    powerplayinfo);
 
-		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
-						     (uint8_t **)&table);
-		if (ret)
-			return ret;
-		size = atom_table_size;
-	}
+	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
+					     (uint8_t **)&table);
+	if (ret)
+		return ret;
 
+	size = atom_table_size;
+out:
 	if (!smu->smu_table.power_play_table)
 		smu->smu_table.power_play_table = table;
 	if (!smu->smu_table.power_play_table_size)
-- 
2.25.1

