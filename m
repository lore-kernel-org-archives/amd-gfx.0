Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4001DCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB75610E45F;
	Mon, 22 Jun 2026 04:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nK+PyVqs";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DE210E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksPpX1PJrs3Aez6WN+A8zS+/mJYevf162JokR9+vCDr+EhiHzqFkfdXnZVtNsUVfZBmG9FC0W11qTSGy4Wb6UOi8DRMdfGeyOkr330StS9tUUXShSaNUMLSs8RW3IvPOvGrjFNzSpyUqfFTd5RFF+DmqS+QmXnsMcG6OXoYqfNl1SHrlYuLWzeQbBVk1qqMnvNmOU8Zi3JRbaOQH+YW3fKPcQBFzFUln46fgBP7vFuiS7smHsONCIDcT4eRddfHY0b/5SQMPXHPZNvI5b+M/Fmruy8d4Eev2alR/7Rj9yoLV/t8m8ZyBTM1EeTtcRU5vGkNyQsxbAtray5ezTmVziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QptOuY1tPsWBNuPUDVqephV/QsWBI8uBGnYuOO+fxSg=;
 b=mghauMsSrGSJ2N+EeAo0VRuuvtSLRNFmrQ7YFVQB39wI/wm3fr8/bxV56/1ASPWHKEc41dbXVUO/oyJdhHT6a8YYHJz6beI7/UGzZtqfTQvDljwQGwSN0B13B3cAMMNyX8I+aQuZYXdxkUIst8bKvMdqcBzbWhmICmO/Vv0qCCg+0lFBEQqb9rQF1ipfDfpp5P2zvSn9d0XiZqXoH4hv/mUb3dDJpEH9OU8t7Rk3dAffy0KkDPX4ZwxxOIFgiwt+qJkgFR/8GBctfks93Sph4nv7hbPlJSG28skGNGPEiAiUcHZ/NDyE+YdWTjrVni6i57DPW2bTxR89xg9ynWJjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QptOuY1tPsWBNuPUDVqephV/QsWBI8uBGnYuOO+fxSg=;
 b=nK+PyVqsmSU8o7QZQcMX6rJdk5wjo0KYerYIpDi3v51/py9NQGZB8tL/y6rbiiqOvdnjfmBbuVYq7GMm/l/B1x9FB2CaD7gxD71MoGDyLlRa6bznfY7tQqrlVLbjbHrX9GRAhck7G4WNHfEXdwoo5y+7MgQyzsWzBwACiGG+Vbk=
Received: from MN2PR20CA0061.namprd20.prod.outlook.com (2603:10b6:208:235::30)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 04:42:13 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::23) by MN2PR20CA0061.outlook.office365.com
 (2603:10b6:208:235::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 04:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:11 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 05/48] drm/amdgpu: retire ACA support for jpeg v5.0.1
Date: Mon, 22 Jun 2026 12:39:54 +0800
Message-ID: <5b598f7aa95d9e941f7dd8f04fa66de9a222d923.1782103073.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: aaea366e-6ccd-422a-51d6-08ded018a0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oeQNl2qnA6z36gWkRJ2q1BKP1GV8gx/BJIk8GDs8x8L4Ef1TbuSr9AgWu16izs6kMpSFUhYiORaN+2PQnSTSi7RZyKOZXE8hvBdpOXun9pmybVOPDsgJbP3F7LZlMWhnVc92qP9+TZ1ce1oBbvebRVsMBu3x8w0yn9PLanfSrWoRZUljlDosMMq/gu83XHW6Y17+ijmoKlse3vNQf2FykLWzpBXr1eDXtQTX4HZ+SXR+QTOjkHIhoY/R5i7x4SMBbxEZBVOOvsyabRvAl977/FjGFgWuTc277uw7o0i83Cl6mangIgmWgQyMvo7E+VZPM2FR3tMS82nGKVSR+AqpT9qnySIc0Yf9bAMOKUuDA4QHP3ZU4ZGhDWwdRaG6l58awq4hHGv1pzPUGVSPquIeTuQeOw3cvP/rEd+dRUWv69QEeprJ/ehsrot/IoBhGXJ++7NrMT39gOh7ZX5q5K1Idna9gEUPQRm1j8XU1odSFaXGUX58yMNcD1tQOJvg0y1rV7FFw87Fu1dVsjujewtd9yjvnIM1qpuxeXUrW+0hXjwSN7kKk0OWKgjkeAkyBzrz7f7DtHKmpiLcWdMlQx2DGWc74dbtBxns0P79UXlpdbOVHy/fvGxxU8PHsz6S0dpMQ5CH5wsYI5r3h2/4bai27V3Q9qS7wtPT+cwDdRz57VtSfU2BOGHdcAq8oKbh20w5NMiZO/N3v6RWdZlZI3dpdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v9SKVE5FcicfhgilX1Ex7WnpWegrUu0Y1lPncGuuliLzD/Bpf3aWeXJ7EnL+fC+LyBSrAqc4CzClKb+7J4o2/qOViiwcjwX81fpeLQbXss/Tc2Bnn8wfEpGEU/VxjILzMgO2J0EjZQlnMx65xZHK7tNOkq6qcnLoGWRy5OAxy99U6Et8qdlCdjVzLVXoJ6mKU2d9tuCtmp1B/sLflfaLcqHukGzqXrabV9ndxNBugDPUtj2rtSHGai6tWCC82hFTP89TsAGsy8oMoQpISFvgXybOlS7J7InxXVoo4GJUIQHH6yA6Zye5chiSN8c94t7l4IXqgwepYDoQN1Gsc5Lh4CoA4syRM1lMvN0qazbOlbgNGaJ+PRYmcNOnlepJ1VGhbUoQsymYJkaN7T3Xu74mVoo860gWmUO4CaxDdUVP6ybGY2RR4RTBFnRgtpRpjWHc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:13.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaea366e-6ccd-422a-51d6-08ded018a0f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

Retire ACA support for jpeg v5.0.1

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 96 ------------------------
 1 file changed, 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index a562369d2d81..ed66d5425c95 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -1017,105 +1017,9 @@ static const struct amdgpu_ras_block_hw_ops jpeg_v5_0_1_ras_hw_ops = {
 	.query_poison_status = jpeg_v5_0_1_query_ras_poison_status,
 };
 
-static int jpeg_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int jpeg_v5_0_1_err_codes[] = {
-	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-9][S|D] */
-	24, 25, 26, 27, 28, 29, 30, 31,
-	48, 49, 50, 51,
-};
-
-static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       jpeg_v5_0_1_err_codes,
-				       ARRAY_SIZE(jpeg_v5_0_1_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops jpeg_v5_0_1_aca_bank_ops = {
-	.aca_bank_parser = jpeg_v5_0_1_aca_bank_parser,
-	.aca_bank_is_valid = jpeg_v5_0_1_aca_bank_is_valid,
-};
-
-static const struct aca_info jpeg_v5_0_1_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &jpeg_v5_0_1_aca_bank_ops,
-};
-
-static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
-				&jpeg_v5_0_1_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
-		adev->jpeg.inst->ras_poison_irq.funcs) {
-		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
-		if (r)
-			goto late_fini;
-	}
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 static struct amdgpu_jpeg_ras jpeg_v5_0_1_ras = {
 	.ras_block = {
 		.hw_ops = &jpeg_v5_0_1_ras_hw_ops,
-		.ras_late_init = jpeg_v5_0_1_ras_late_init,
 	},
 };
 
-- 
2.34.1

