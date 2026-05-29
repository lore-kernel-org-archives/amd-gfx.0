Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388C4CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE08710FBFE;
	Fri, 29 May 2026 09:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HnBw8Rxw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24AD210FBFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0wSqrTEBug5e6R3jAdG0PrVUTxXUmGUjynkBBx3cGDrRdJI/w23mw7Q7CCRu7yLnzOWBFwi0plyWmRlrXMo8BZXg70xqrH/MmGsDtDltRiziXLg4cnTh9k3cArtUKruQ/PqqLAhngMjKqcC5TtEg/K07Kgv3TbTviHPcFRRiiPI9XROXaIHTmzdRagQd+iuy1XSWy2c/boFAUtTNoqNE8FGf/2C8znIahINrdtQMUaFZJoqMs8gQwywQ0E9EGExifaGQy7OHzoRxmwXJQ0WK1fQRYy9JVlrnBrCxrarr13/3NYBzGZp1MYMENuquguF09H5UO/ge9blee/XOmOveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24X4AQ/USMhSH2ILw7XYlFNA3+m56evsRGsQwM3VfRY=;
 b=e3WupnCGvXmt0bDY9MdvZcQQcS1uJDk+cHfubz0lGbltrFU+qPxila85VotSqP9BtNRsKYfYQMu3BGE550rz+L1DUNHW9xMn0zlWos0F7oGMvezU+aOK5YkZ4O09KDefRenIAlcQkjTMgqmk1l+339VeCvfWIRYn1CpUVQzchds2UryaBfu+SQrIPZol2O0q1UrkNTHBGi6Uy5qk4wUh7mcVmvGy4qZ3LRZeRIKkkrBkYMr8cQp/1rzZhS6eYySFuZzEMpbMykWjx/y7u/EYvcUJQJJ700/gLvFTZRvBlGv7X4y5feKlzlmLNZm8Whh3RHnA/+aSZyKcVlViLk08dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24X4AQ/USMhSH2ILw7XYlFNA3+m56evsRGsQwM3VfRY=;
 b=HnBw8Rxw6nqZLXld5p1DC/lSSgJxyDpYGUr0W5xjirW16Tm5n5meJ7eAJAiInebTYpRgiFGddF07e9hFBgKkAfg/ibvyszredsNQMJET3eQEry+79kbiUKJATIPeqLYkccUkfF2mUjcNrBA0nYWCBJiIZE+WjlRw7e7YJ/QipRQ=
Received: from DS1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::18) by
 PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 09:41:40 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:455:cafe::1f) by DS1P220CA0014.outlook.office365.com
 (2603:10b6:8:455::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:41:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:41:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Use helper to get pptable in SMUv11
Date: Fri, 29 May 2026 15:11:16 +0530
Message-ID: <20260529094119.1134923-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529094119.1134923-1-lijo.lazar@amd.com>
References: <20260529094119.1134923-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: e96b4962-9bd9-4376-dd6d-08debd667c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JPjt4lRW9GIFVSPnsxfHKh22qi7y6nWIXMGipuRD01tWwCqcYAVTLDDF3y62fTK1YvjV49hku4y2j2u9u2Msoz0bWS6Q0yD+GpJugmScY6rtZbKdHmQ2/PxFPoReinZY1f1e9ZwPr/7N2CWz91PfjvsgCqcuTuCJSUskJUQA5AQW/BX8GVT1g7uFkF5mDf/uq9bOmEqM9gQjDYWwh2Jz5WtR28GXS4RYwpPtOFAXGw8H8VyBLLBMnTR0+ZsJbwfwYu//OfjcrQL270l6o2qByIHkjhujnXxXpJjPEQpJJvHimitaaPSvm7w0aS8zVKtwIlsd9xlM8S6qu7/MiI/hnnJ+K+HK7Z0If+ybELhzt1IKJlen+08o2BJGpmsNIRLlNhuvcXXS6yFrrieduJn+xaJadkO3ywzKoR95Qs1P/aoEEfejf2k0fqNDc1UQwnG99bsuzAUYkONqd/jZSyyhAo0RasdUrcEO7k7Q00BkMt4eNAHD2WGZ0DKS/SqP+66IiPzyRCNexcQuhqYg0jrFpCIsQjmQgt35aHy01PoeDTRgCFLJdKZyWmZr3RK4k/C5Gg+I2cSu4oFMDA0c7ayzFDe2k1dkNfkFDKpBv8Y9McJWwCl+DZe0kdTO5wFeFP3BelD/DiZIfU2aJ+++tzQjpueiXu8oE+n85ur8olzb1G/FuJ0A4DlXOQeeUUjx7byX7ZOaL3mPnpw6G4SDZ5W4Ac7Q9JXzYFmPEQiYyJQnDbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a86Ir/KodqyONgkjKDvo/xh5VkexCVBp8bK7ty5EU+FU+xhsxr1yxwV8WbtZc2meW6+i0ZqS54LmhDwmCVH9osXeimUYq/1X4+ZVw2IKRmJNIbbHJ9FiH5WLUjMpDydB7Yrzhl7HsNCIOG1aUll7jIhblMAOWTqz6CScZPzN4PPcXLdhvabo3k2tUKxFJL89SFR0XqWh9wlJUYk1qH3dvVA2kqm6WOdWbu01UqI1hRSDARgTiR/OJf9eb0nwNmBipameB0Rd7ZgvWlrCVSfvv68winrImfZcGjxBKVsJrRr2PESBoDESREVlIe58HyedJLVWzpvAKKcoaGFuR6RDZhGkdsD7pL/1DbHk+L6F8XIAqGwyP2GYvlZ6sdhLW8FqS3JhbbQ8OFllfOis5eRMQMwA+oQ2IJCqOICNjvKIFzTchjf1R9ks7V1kg8QRV6LU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:41:39.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96b4962-9bd9-4376-dd6d-08debd667c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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

Use common helper function to get pptable from firmware binary in
SMUv11.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 79 +++----------------
 1 file changed, 10 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 98e7109bbc95..ac8f84f1e30e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -192,81 +192,22 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-static int smu_v11_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t ppt_offset_bytes;
-	const struct smc_firmware_header_v2_0 *v2;
-
-	v2 = (const struct smc_firmware_header_v2_0 *) adev->pm.fw->data;
-
-	ppt_offset_bytes = le32_to_cpu(v2->ppt_offset_bytes);
-	*size = le32_to_cpu(v2->ppt_size_bytes);
-	*table = (uint8_t *)v2 + ppt_offset_bytes;
-
-	return 0;
-}
-
-static int smu_v11_0_set_pptable_v2_1(struct smu_context *smu, void **table,
-				      uint32_t *size, uint32_t pptable_id)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const struct smc_firmware_header_v2_1 *v2_1;
-	struct smc_soft_pptable_entry *entries;
-	uint32_t pptable_count = 0;
-	int i = 0;
-
-	v2_1 = (const struct smc_firmware_header_v2_1 *) adev->pm.fw->data;
-	entries = (struct smc_soft_pptable_entry *)
-		((uint8_t *)v2_1 + le32_to_cpu(v2_1->pptable_entry_offset));
-	pptable_count = le32_to_cpu(v2_1->pptable_count);
-	for (i = 0; i < pptable_count; i++) {
-		if (le32_to_cpu(entries[i].id) == pptable_id) {
-			*table = ((uint8_t *)v2_1 + le32_to_cpu(entries[i].ppt_offset_bytes));
-			*size = le32_to_cpu(entries[i].ppt_size_bytes);
-			break;
-		}
-	}
-
-	if (i == pptable_count)
-		return -EINVAL;
-
-	return 0;
-}
-
 int smu_v11_0_setup_pptable(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	const struct smc_firmware_header_v1_0 *hdr;
-	int ret, index;
-	uint32_t size = 0;
 	uint16_t atom_table_size;
 	uint8_t frev, crev;
+	uint32_t size = 0;
+	int ret, index;
 	void *table;
-	uint16_t version_major, version_minor;
-
-	if (!amdgpu_sriov_vf(adev)) {
-		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-		version_major = le16_to_cpu(hdr->header.header_version_major);
-		version_minor = le16_to_cpu(hdr->header.header_version_minor);
-		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
-			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
-			switch (version_minor) {
-			case 0:
-				ret = smu_v11_0_set_pptable_v2_0(smu, &table, &size);
-				break;
-			case 1:
-				ret = smu_v11_0_set_pptable_v2_1(smu, &table, &size,
-								smu->smu_table.boot_values.pp_table_id);
-				break;
-			default:
-				ret = -EINVAL;
-				break;
-			}
-			if (ret)
-				return ret;
-			goto out;
-		}
+
+	if (!amdgpu_sriov_vf(adev) &&
+	    smu->smu_table.boot_values.pp_table_id > 0) {
+		ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size,
+							smu->smu_table.boot_values.pp_table_id);
+		if (ret)
+			return ret;
+		goto out;
 	}
 
 	dev_info(adev->dev, "use vbios provided pptable\n");
-- 
2.49.0

