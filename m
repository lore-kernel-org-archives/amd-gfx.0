Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F29C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2124710EFD5;
	Thu, 30 Mar 2023 19:32:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C0810EFD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcXQ+axUKWtO8a6h8wKT2qsMk0GWhNz4yAiV+VjooPYreQe93jwhz7i9+LAEP4Qtno2wS6nJaAUlTVYAdIOBCEHSdkFUCKUrm0jj5Tgapho4qGvbS/783WiKuLN7uFnILVV9+fcDvH+yQrYntj6wZ9x2Sk3pgDrTS/J3hYahDx5tLjCsZ1h2bMdOk+K7lSh4Xhi32vT4c0epg3nuHPCYt6kI0hokJKs72mUgP0Bn7QuKKEj3+1vGuv4gHh9c/H5EPkkXVWMfNCnXBs/EDdAH2i8ztZeu69YNL7T6tpfh6T1tQQmmTX/BidgXdmz1EWytV9KyltYGDLLBWB/xpTkFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIxauaPlPDmhlZywCLjbna09b8iFF9wWsQhQeZQA7wk=;
 b=P35EzLjLglM2Y+/Cb54APr7VoAjHB2A8vsXAWRj6tk77oHA47jTnykLvpCNrLga9fV2QMheD+qio23XoKBQh/S2GqsE9Lekl4P8l9d50HC1EPK5V5+0Cvtb+Jtz4ygzqVP2cSuJBekckZCik3o1V5dY4Usi1bkElzaIPAbyAjIIYymiSJB0N2AjkmnIDCkRnyiHfRnp/ddEGQU6pqsq1L++6yl7tw+uLbtqm62aIhgoyR28VMw9RqfOT9bjjVCm31n+kO8j0q1JMEbN/fjhvKBkJFU1+QfVYWezYx/v8AQ5PRrO7xz5v5JpC/TAO2u38E1P9BNH2fqzJeQ/+En4nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIxauaPlPDmhlZywCLjbna09b8iFF9wWsQhQeZQA7wk=;
 b=x2wU6Hy0U0PwyZz5auTc0IqmWXgn8iqjZ0fWUVz1zrCHW+ZnMf+LtndyPF8XRs1zCoD9TrNttZkXPvwxsw+EVLtG6uTUGuwyTWIzgYIshXmpISz8KMoRez7tLEG+xbOAr2hrXMQEaOmZES89pjM1V2YVJHkQSk3kOlrCGaUaLkg=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:32:24 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::7d) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amdgpu: Add SDMA v4.4.2 XCP funcs
Date: Thu, 30 Mar 2023 15:31:56 -0400
Message-ID: <20230330193158.1134802-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccdb010-9c26-4dbd-e643-08db31557d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCwORrJrqFKAL+DNR8vKUiEXOooHPXc0OFvx+zbmwOupt4x8DJNmZdPSrmLYxXc1N8qahtk/GVqDzvNaLnmP4tb1QI8sDdUBtc+H8ynA80ScrpPVD8SZpZIVEjABiFXT3IFea5O/QbcK7DKfuyGHfGfW5KcCH3TPDZnJzmWuPmHFhrh2K2P5bKC6x5JE1cMIxruOmbcgmGJguoseDcjEi3gmbkEpCOeHHy2e9nKbMkW9hw7OSg+f07RKxF74r9b7CEAH0rrwagMazEce2oONoS7L3Z4u2WPgqDGvm8pmp+ZyQ0FOxUyUjktW+I8+1NgQ+GDBT3B/aqOGAZq8sYjSMpEBp7/tTtwKm+wFTJZy5NkjO8qtkJGwehGA/eiRkDMSvabvYQJErvRn4e4oswqBMoK6+/Sobpej/yBouvT5EveBd7vrr97m6KLSBLdx8FhJQCeJgsAge1OKtrsrJRKxJ3CLYpm2N2nHYa4AtLTdN8Q30Jotrmk7SIDagf037prn42Ul0whVpErX8HkZXBZHaPEbZBTi9j9/lplvAgByDVUJmFjfyMjgntdT3xfOuwyKfxDcvuuIg4MO/wHIkWj5urfKSmKDcrzE2Imn26jnYuoCcTYHEX+A0et0jrA1iRo5KAd6BeC3QwnKLrhl+m5URq3V6SPsA27SIJEIn4jPKoRqPcWGHI2SwotvIN87xPMEYxbtZ35ci6olOGjmzeCAnzkJuWdbC7NXD0RXGuPN9ec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(2906002)(81166007)(4326008)(356005)(86362001)(40480700001)(36756003)(82310400005)(40460700003)(41300700001)(8936002)(5660300002)(6916009)(316002)(478600001)(54906003)(6666004)(7696005)(1076003)(26005)(70586007)(8676002)(186003)(83380400001)(2616005)(426003)(70206006)(336012)(16526019)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:24.2592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccdb010-9c26-4dbd-e643-08db31557d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add functions required to suspend/resume instances of SDMA which
are part of an XCP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6a971e15b4b0..184eb7902722 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 
 #include "amdgpu.h"
+#include "amdgpu_xcp.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 
@@ -2025,3 +2026,38 @@ const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
 	.rev = 0,
 	.funcs = &sdma_v4_4_2_ip_funcs,
 };
+
+static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	if (!amdgpu_sriov_vf(adev))
+		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
+
+	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+
+	return r;
+}
+
+static int sdma_v4_4_2_xcp_suspend(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t tmp_mask = inst_mask;
+	int i;
+
+	for_each_inst(i, tmp_mask) {
+		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	}
+
+	sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
+	sdma_v4_4_2_inst_enable(adev, false, inst_mask);
+
+	return 0;
+}
+
+struct amdgpu_xcp_ip_funcs sdma_v4_4_2_xcp_funcs = {
+	.suspend = &sdma_v4_4_2_xcp_suspend,
+	.resume = &sdma_v4_4_2_xcp_resume
+};
-- 
2.39.2

