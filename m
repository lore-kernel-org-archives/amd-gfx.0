Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB58C47DD9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 02:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0301122BA;
	Thu, 28 Mar 2024 02:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rePcyuvF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFF51122BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 02:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFbTElMjbPncZ2pp8IO3vHXfC+n8LhwxTzPoYVSuZrkHH7x07XxRCi/lROuO2zPh1jXqMRgW30q8Z+k0dFD4jtjOpUuzpaLoKb+c7vX3zJOw91vFSELM85HUJ6+Pshthidn+HiUQ4opZr29NxgwtpJqT/uiEELyWHLT9F+XxjbR12G2iI8in/y+xAr5sKoUX9jnDE2+e4mdLxSlLvIeifVJP8odVyBiBAdtse71EWeYiMypjtWmCl2ebOwId5svcFnAJfa5xl40g0KZv3Dj0EYHCn6pAYb94FKYBUtEbbxu3AXjtfHsPvnlSGFTB/+WmmyUSKKb/Fg8C4WSvwIse/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7ZMlm8LtqzL3/fU2F6iD+CPtnJyUAEDFQBafHCJhK4=;
 b=bJyRypD362IcthssYsKL+4cLKm8DPeV261fNHOZMfUtkCorL+qMRwP3dKM0AgbAVvzH27lCwPnvj8iyq04YEEp7dDdZfGYIpphXNisxsHW3gviiUKwbx26I25XGsElXEMNXtPxzIadUbRm7QdkI68XnHXHKYJai3HJVmzOQaisAkH3P4ICrZG8haPKZD//s+FC/K6XBhE7OykpEiiq68xdPDeNzUiF26tapQL8pNtyibWOYDbwx0a+LPymNH9kfhjEFfU51uK/qzCREoyqNnWQQQKskfUZpYT1pz/Xjn9SkQFrA2/pL+8cUfyDusZ+NxJhfqCBK/oLrCPv4rLVvi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7ZMlm8LtqzL3/fU2F6iD+CPtnJyUAEDFQBafHCJhK4=;
 b=rePcyuvFMkiQWFukfh8CqCtY+icFc8NHBXGgXtBWf5YHnEK1vx76AzVM/lrR7Y0FArT31xQn7rWhVqvYX6fPzWMVdn3q5AXK6WWspZc1sOEldBLbx31+Lb9Zb56SiN2QJh1dKXEnYHvi0/SFI3RImePQCO8vQakJtvBPnO39S0o=
Received: from MN2PR20CA0050.namprd20.prod.outlook.com (2603:10b6:208:235::19)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:36:37 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::a) by MN2PR20CA0050.outlook.office365.com
 (2603:10b6:208:235::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 02:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 02:36:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 21:36:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH v2 4/4] drm/amd/pm: Categorize RAS messages on SMUv13.0.6
Date: Thu, 28 Mar 2024 08:05:44 +0530
Message-ID: <20240328023544.820248-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328023544.820248-1-lijo.lazar@amd.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdd98bb-13d6-48f7-0caa-08dc4ecfe429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TY9hlq/Dbi7w/Eui4D3y2VBkx4kAx+AGlk/nHOF+t+cA8Jzgb+8YhfnRNN+mF7hfEogKpqGAmSm6f0va4z+ofaFFY6+ftrOP4Y3ylXWa0nr3hk76kXvHPdmSX7L8vCaIga/lVBsIB2ucMdjL8w71ACdeixFTxCtj6lLEHH0zbKe8uOIReOEFq5beE8RdbgNu7IBgfZSdFl04WckZy1I5Op5/ZX+nLMjWYcWlATn5bx9Taxf5tFf6P6e/1kvT3IrbLvt4SgGPmobRvlz2IrrP9rV1EpsbOLgntqRbQXZZm92OnK2pQdA7noUEbQm1fi+v9V1Vi6MRyd6dpOIChTtxEggZR4RLCH4wpd9xVUsU51HWYOv/tnJCGBcXHPRP/v+0fHNH883X/5+EKTY2M9ydwq0aCKBxqiYl/Gt0i476EPgIRlOLxVFh1o1M25CvHpJ+dt+IHJPSFo5DXpEDYLa1jejZzjRKCrlxCKzUxv7imWpZTgxeyg7mmkSNR0kUspmPgW/Vhfw8OpwmJKCjAZKPDoDyIT62gnkG7YcyT3thtFLYJwiTGGR+GTJ6Xm/Tbdptpqx5m8iJPqLqEdhUsOeUKZjuoFZi/+4kMwM3+ptcvtJEHMyBlQyNb118ipK3rkB95Pit4pT45fxpeLjkqQJtAjnbjCpfGLwZ1X0En+GdcpcHFU9xphKtuupGMtyoPF8+I2E/6alwWostSdf7NdbmNmNO2SKDhfljTxYAK46NQStxkf61zfoW4rfjwSKsnd7/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:36:37.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdd98bb-13d6-48f7-0caa-08dc4ecfe429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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

Set RAS priority handling capability for SMUv13.0.6 SOCs and categorize
RAS priority messages allowed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Move setting FW capability flags to IP specific code (Kevin)

 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..6e06729fb2e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -144,7 +144,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
-	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			0),
+	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
 	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
 	MSG_MAP(DramLogSetDramSize,		     PPSMC_MSG_DramLogSetDramSize,		0),
@@ -167,10 +167,10 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
 	MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottlerLimit,              0),
 	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
-	MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMcaCount,              0),
-	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            0),
-	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   0),
-	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 0),
+	MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMcaCount,              SMU_MSG_RAS_PRI),
+	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            SMU_MSG_RAS_PRI),
+	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   SMU_MSG_RAS_PRI),
+	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 SMU_MSG_RAS_PRI),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 };
@@ -3218,6 +3218,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = smu_v13_0_6_feature_mask_map;
 	smu->table_map = smu_v13_0_6_table_map;
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
+	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
-- 
2.25.1

