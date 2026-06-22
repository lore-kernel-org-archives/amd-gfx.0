Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9FCCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2C510E468;
	Mon, 22 Jun 2026 04:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxNdFRyI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FFB10E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCPex3kyNa0bx2hL1SEaS8DzYlCJpa+JGsQK5fEYRwIJnj2N6iXQpEFgIgXh3udjc/uzaSHSU9vnnS5XbjSNPMhaZn0Q6+lFGS2z27EHULIm5h1l5cmspFWgVBHd3R45fo4lnl20uTKADdAVdL/2PZ9OfFTQBjRHxr3jYAqmzMzcj5J/MHqT0+WGN8FxWjLs3TRlAIlN0RLMy7jN9imAPD8onKpTNmNShRpvJrE8O+jZspwGUMDMvYsch0HDIVNajOWHuK3iD5ww2RdI8f8JVO4kyA+i8vnIf8+s+bIo1wTwLOxMeAZ/9MPDUWTsBIgiBNac3rBpMrgqzrJ5L/Nt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd2EeHZX2t4bNV6SlOdtf7SOJ123ujJ0jQo+BuWruCQ=;
 b=VAxSFzvlgMXuyzcSBjW4VDSDWaed5w+w7DRM+z5IVaSi9ocWLSqVLB3XO40zQ13/bfVf6sHIMw6Nkn8gayRwPSpE0ILVLlPjDmNlZ8il2hGmmvgyfyp1iRy4GPUZ9LIllucrmqBR5EioKr8UwKc1qVM3esTZKMpGOSL3vmmxW7CMCQajJesNHNNYa1YFwLauWiA5iChfVuIqQI9tkwbYClQZ74EFmjaEi7T4zeYPDRIXnPVQyw1ZKfwlVgwNUdvXlCNaHCGRCmggemjr/T6nBtbJ+9wTavmrlPYmYxTJdEU9NNoiFG6h39lacPi0QlMqSUuyIKiIe7+1R7yJUNAzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd2EeHZX2t4bNV6SlOdtf7SOJ123ujJ0jQo+BuWruCQ=;
 b=zxNdFRyIssNPmOc8i40UL4weWgtTsFWayheRmBsUbRJVxUwGmMGLcK3cVBSoY2mVZgD/RO0oVPo6zeZ+FtSnYszmjq9AIBB5Oe3jiUu5RkSeOCcx6uNNslWxYEh1ZOGx296YYiMjP4wqeGdS9EC1ViLdgGzfc/cJl2En5HqISIY=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:22 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::41) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 04:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:21 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:20 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 10/48] drm/amdgpu: retire mmhub v1.8 ACA support
Date: Mon, 22 Jun 2026 12:39:59 +0800
Message-ID: <702d40f9724f1c14c157df82609b6ff46872228a.1782103073.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e178320-ce56-460c-9cb2-08ded018a628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P/JGje/Uc06FTBrfL7HLIhAuZ5G4xJ6jmXYgNa9fj76cxmmh+eMzOwg5qTh5ljk2HpCR0fLw1NjiI4ZvHrfrkDADzCziSv8T9ey8w1BBR4xi68SbjAhPykGZoqC850jNs6578zyy8oKXXgbTCjz6kJLkdcDlRBmUQdaOK7VeJx9dyT5dAfizp9Y81sD03f0sJr8ueUjmYMXBpKevrPpX4HT19liPAZ1EUI979ws+oUez1uFKcuI8dFN7h+9O+BbFXbOzCFsvwq3qNSCxBa6QRVgkVLERYG6N7a9BWjuNwIrDpNs5PZW2oW+vmDP35k+yBWLx9jNjMoPtLh8MZ/y/ktBazPgKp0d4Gvw/QORPGo9oRXkbTEnPc2pgP2BsjVzPPSTpcr2+4kQKJ8r0B1sXVzQX+YOuUInwrAefgzDPQL+qb+R21fPGIMLrdJ+PZwVArQz+Zg9F+uEV+QnujBRKj44i3QnFH/DB8iDCbQ0c7G/kYreOfEwCYRkoPl4qDMkGjmUu1+BJYf9cPbdnNFqFaDhpi7ZJKQd9sQzVi+HADwdbX2+moOhOC8pLRSCDnkdX5yoTgxg8f7LRSbVXzh2K6Tm5ZIu99/GTWyb8PduBJxWgKQJmSHzxX5maS62F4XiQU86RRuJQabNvUPekk1fZKPObYZ8or+N326pkAmlfyQQXaMhiznLpqmZm59O/beiqu851GLI0LpHnlm0CAl8FDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qpsb591uBBwJpY+g7h5u7sOle0jU+803v44yOiJO6iryuKYIQfanyG4kZx5VUQrYW1wb8YNYi8XRu+Qtf+s2OwANOhz7xZawMyW1rD/j7Ixw6svsh//LI8ZsVkS8GpK1yF9rcy/xXt6V2e6BmFwUAIgzKKby2rgxzlIvu2/URfNP07pVsPlJhcgYP8LWCgpugC/zF4utodeqrhCQ8ogACUAn2Rt5WAAmGxMo6t3eQ5Ve7X8FrQPE/t6DL8CJnOm+b4YNeB4Xc2x/4I7TaV/OJNXcH0SOutjbNjGEybfMQiev312oguhi/PWcJ1e7Db4l1MIdp17n2CHYWVjLncZv9asxAq6RHeFyxjQxwlLqgM0Z9Wp49qbhLLbNVXqqxBeVSujZeT+KSXT1XI70RUjq1/JETjEVM6MeN5rsyqjZkY61Kqu2r2KAV04FgN5T8pGj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:21.8307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e178320-ce56-460c-9cb2-08ded018a628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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

retire mmhub v1.8 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 92 -------------------------
 1 file changed, 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index cc688ae79e84..2a6a5ac4f374 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -772,100 +772,8 @@ static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
 	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
 };
 
-static int mmhub_v1_8_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
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
-static int mmhub_v1_8_err_codes[] = {
-	0, 1, 2, 3, 4, /* CODE_DAGB0 - 4 */
-	5, 6, 7, 8, 9, /* CODE_EA0 - 4 */
-	10, /* CODE_UTCL2_ROUTER */
-	11, /* CODE_VML2 */
-	12, /* CODE_VML2_WALKER */
-	13, /* CODE_MMCANE */
-};
-
-static bool mmhub_v1_8_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
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
-				       mmhub_v1_8_err_codes,
-				       ARRAY_SIZE(mmhub_v1_8_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops mmhub_v1_8_aca_bank_ops = {
-	.aca_bank_parser = mmhub_v1_8_aca_bank_parser,
-	.aca_bank_is_valid = mmhub_v1_8_aca_bank_is_valid,
-};
-
-static const struct aca_info mmhub_v1_8_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &mmhub_v1_8_aca_bank_ops,
-};
-
-static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__MMHUB,
-				&mmhub_v1_8_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
 	.ras_block = {
 		.hw_ops = &mmhub_v1_8_ras_hw_ops,
-		.ras_late_init = mmhub_v1_8_ras_late_init,
 	},
 };
-- 
2.34.1

