Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D23CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A5410E55A;
	Mon, 22 Jun 2026 08:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1eQ1Hsp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A179310E557
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuKpA/6/a590Nk4ImAcphC8siWXbbH6sAv2qS0/M89H0j4aSPMaGHwfMisRg2LjCva58OsRvIIWBN3WFnb8DLlvAmufN9GIh9FHMEfznbffrn8stMpFIQP/QbBOc0cp6sPt7Dpk8yHj5wnTLuzQy+1qqF8eBD6Do3qPZPt6YEXjE57rkfMoSRTwMQaqJHtwLOtBfa8M8XloO4B6OyU6ZygXuynKGeOpgbTT1Y+TI++U1J5SjWeSFJqJ3a81IUCpx6/rQPnp3QehHZtMHTVWq9uaYWVCZU2xYJ0wyc+C0qLucshYqFEmpDEVtzlZVq4NkXoglzLebPT6NZKDV1WdOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnA/vfR18tcCM0/EXtmQRMonq0HD1GrUIiiRf/iJPt4=;
 b=KpaG/yxQP9BZY3MQgUdvVTSWctevgJooNxRKulxiko0oYH7qwKoh49eoew6WHjucZ2lSzmB8KAW1eoraezJgPm9TExo3kvbCeiWjvxh/OmW0RCHji8AYHrpt0qEexx0QAAd/ho0Nq5MzGw52Grtsu3cPzYILj/j0FQZBi0njv1fQVXLe8Vqvms0x8umCHPVnL3FVEflOwSUvDn04md3fdu1djKl6nzF4SKDfwcfecxmwKL9z6jJyX8JAabgicJXOfJ1nu1+/68SX+PQXBadc5WT5TlGs1Mb0vIslSb/mcZivGeE9eklXIjEScjdtWAJ35s6xEA0Fhb1Wsr/E3QsFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnA/vfR18tcCM0/EXtmQRMonq0HD1GrUIiiRf/iJPt4=;
 b=b1eQ1HspuEPD7CHJ3C/lMo/yl0lLmIIciTOwQ/xvH3wT3YuAUUx8I7foY0/yhKaDm1Pl9Dgb/UjAWnnFg4U7npjANid4WOQVySD8OI2OT8jOeLlmP/9nx3Jw4IbRer8uHlNJyBDL5p5UdvBm2ejGMXOgohooapdkXcW30X99nsI=
Received: from CY8PR19CA0046.namprd19.prod.outlook.com (2603:10b6:930:6::10)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:45:27 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::44) by CY8PR19CA0046.outlook.office365.com
 (2603:10b6:930:6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:25 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 09/48] drm/amdgpu: retire sdma v4.4.2 ACA support
Date: Mon, 22 Jun 2026 16:44:11 +0800
Message-ID: <d968192dba95231d549fd38750998020a20f74bc.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: c412375d-f496-4372-0e19-08ded03a9bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jf90Sj/u5Nj/PXw9zvJdpuV8lwuBcWwVm8Husp+7NdEd2wVcj01TI0bRUiKFHEjaqhLrnq+FiN3g4AMm55tBmblfSGHqkDh4r3cKvEmFdDYfHk+gJeU5luy64gBIXCjKI+a+9A2RRmjX18Sz+6UiGUux9veVTrpF0ZEpB4zc+5pj78P2lc4GjHyFRsNpDn01M87QsFjo95U53+8FXNzHD/Z+nXntOaPP7TzG+v5HEP4gYBkC+P4XcVONiK/k3OT1tKrdg2kn61WUtv70o+Dk5SH52p923q5yfHVpULQRXEepl1xUAWWI4Syy0UedycqGE11GzqVohktOUCVvtGz2AqurCIFGejMDB/xN/93yTQQDzBeYVPh5QPBWZSVuZDxtjmOxgNqtOGm+GMCwkQqV/HFQSzqrQU4Vi/mF17ba0b2ZbPVnBGuwch46AEZckwlLrWrNi4IdnsmAWUgEfNGFoGLPEsc01uJK0J0v6IpzdlaaS9eKoy/V+NFycu3nb5361G3lMFv3XU2ruayZs5iitrI6k8BqUzuFuIc2buMIJ7dJ7mbHvklJLAUi7EnJ0Zn4Xnds0hZlClDbvNzlShy9mXbRDmW8XzCdyZoCGtXUik1wl5YnCqprrTh5P91qUmbO0D3gZjb7YpyfrsTX74JcK+hywxw8z/+8AqXVCLvatvAnUp+7KZdPMBvDIJPRONKdx6RXimRTOdxCDSgsr9P9WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9IvdyBU1IbMdafFBZ84RQ95/nGxxb35gb9bpgwDhVAi5JA3s3Td7Tz2KGGRPadxcdGWyEHh0DpmUdqbh5daGe6n2uJidLFSv0SyVkp7EXJucbwZw/8nCdbwL8HY0hn6DOM7ArH/j1VUecaf9JcLRS/eVhopFtuVeT8ftsATn1sjHvNh077r4erWQx8X67FIVXaM/pNp7+3tmCmnkWsPLCmsgLuuU0vfgauX4CJcvy7mhIgig4GFkIEtpJhhMdaglSKOQewNib8LzhZNTY+e+q2n737TPK5Netc7aE8vRt/6jBpLGYGTDE32B94Z3eCZRpYZGrGArCkAHcDVGXooDzWb92UueVMkZR+J2xDqX6GiudLCmGGE3qwoArqLzBC8S7tsYZHdiTiKPF/zEL2EQZaVAXm/YbdpyGym1uYzeGdPIkhRp+b1hiKpYMMrrs75A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:27.3756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c412375d-f496-4372-0e19-08ded03a9bda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
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

retire sdma v4.4.2 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 78 ------------------------
 1 file changed, 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index a7685b516f19..0d7e22060a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -95,8 +95,6 @@ static const struct amdgpu_hwip_reg_entry sdma_reg_list_4_4_2[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regSDMA_VM_CNTL)
 };
 
-#define mmSMNAID_AID0_MCA_SMU 0x03b30400
-
 #define WREG32_SDMA(instance, offset, value) \
 	WREG32(sdma_v4_4_2_get_reg_offset(adev, (instance), (offset)), value)
 #define RREG32_SDMA(instance, offset) \
@@ -2520,85 +2518,9 @@ static const struct amdgpu_ras_block_hw_ops sdma_v4_4_2_ras_hw_ops = {
 	.reset_ras_error_count = sdma_v4_4_2_reset_ras_error_count,
 };
 
-static int sdma_v4_4_2_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				       enum aca_smu_type type, void *data)
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
-/* CODE_SDMA0 - CODE_SDMA4, reference to smu driver if header file */
-static int sdma_v4_4_2_err_codes[] = { 33, 34, 35, 36 };
-
-static bool sdma_v4_4_2_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					  enum aca_smu_type type, void *data)
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
-				       sdma_v4_4_2_err_codes,
-				       ARRAY_SIZE(sdma_v4_4_2_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops sdma_v4_4_2_aca_bank_ops = {
-	.aca_bank_parser = sdma_v4_4_2_aca_bank_parser,
-	.aca_bank_is_valid = sdma_v4_4_2_aca_bank_is_valid,
-};
-
-static const struct aca_info sdma_v4_4_2_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &sdma_v4_4_2_aca_bank_ops,
-};
-
-static int sdma_v4_4_2_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_sdma_ras_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
-				   &sdma_v4_4_2_aca_info, NULL);
-}
-
 static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
 	.ras_block = {
 		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
-		.ras_late_init = sdma_v4_4_2_ras_late_init,
 	},
 };
 
-- 
2.34.1

