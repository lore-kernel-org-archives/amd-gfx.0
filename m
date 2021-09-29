Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 19:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7D66138E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 19:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC7D66138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5532B6E20E;
	Wed, 29 Sep 2021 19:57:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92996E20E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 19:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DefNqaZTz8ygMbzQ5oIBNYI/qP85vQTfppn3O87gBywwKImgTfVxo7+dH8tkZ9kLRWha1Y0KfQYEOACz340m9F9CWSrYsqxBN54sKdUV4ZBa9C7Af4MEieIUpelJ4PQoq2UAHrwltO4gXd+vmcsJz+TuJlnS5fmUBKx0hp4dsk7sVwi15a4q8hHh0Ohq/gwArOPLTkrp0yVbXUGbrh/7RhNdm5FKBqdR3BfMDo134hcpDMm5wR1I25XGPPGQYEudVXYzkDA3LKX95OmFmXl8wll7hu/k1hsYT/NidPjOPO/dYasTichSGQob9JPwvnlCjOG65gE72B+P/kfMUPx/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fAWfIXPze2zJgln3MmjoKkfMw+e8SYhMhyfnDhNR8ys=;
 b=T9qH+bqt1PqAKdjYk92wcFrmUD/oyQDsr1qm+NzMUXUEebNdLHX2j319+E4fk6JEYO87yvBDs5kY7Uwgl734+T+0jxDanqWJsVxc1v2vkP9mQRhn9FIjrS3SNauhaX4h8B/LSpJtnc11cLKulRGfcoYI9aSd17lNJSee7Ib4/KFQqqoL/1FxpcUrLgcjeB/rqmPCRrzw7vGiGP3d+8zEEWjus/gTR5B92CKGB1AcNEE6QfNgTJmv2IfiZMnW4Q906el2SW0j8sAC95sN5bnNQ48JoN9v6wRMnHa1M2Ld1aCb6JJRqNW75mES2CZ61+HAispyUzIVHMY/2TvqlL39yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAWfIXPze2zJgln3MmjoKkfMw+e8SYhMhyfnDhNR8ys=;
 b=A0yuip3MGT9heIASCZ7BvKpU6ckT1OKVhfc54djy0gpztbv7q+Dprx0ckacu+X1lBDLstYjKDWWuCNy3/w6B3+NtebTGf67hC8seQp0ESE7mmSBOv9zw6zVUwI1klQ9PaxGz4U/y07U7FMte3TEoGFQ6YEZrCxL/FGHw0KCVX5g=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 19:57:18 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::86) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 19:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 19:57:17 +0000
Received: from work_495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 14:57:16 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jamesz@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/jpeg2: move jpeg2 shared macro to header file
Date: Wed, 29 Sep 2021 15:57:08 -0400
Message-ID: <1632945429-7902-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 172d6580-25fa-4460-bfda-08d98383575b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4074:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40743813688F09495E11DDCBE4A99@DM6PR12MB4074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ndm8RdMBu6wKJKtO/koLt9Fy+/HsoaZqivEJaT72ThD5caPusRQT1pnVGKyJ4rHF7sn6yhxJ50mV9pu9qO1sSU7rWD8VbbQweTDI9OQrW/zL5V6g5zVxF2+tOEa+yVFAtU4dEoC/kEdl/lpY5s3hKTWKMcZtOxJmIGO7ouBFfocdxcQeS4x1Ryxyg0uNKDsCHTk/6ePaPSZXscqAtsEPwdM4s4eIKHuR0ciD4fifDtm7seGsadsMpH9NbOwrNJ2/yeUAZDehr75seqzJ7U1Ed+w5HE+59pUowyQU1O1VOh1mTM2X+hJ36hX/8Wlrc6VwLUEFMt+gBWeFivmsucqW5m4lB1ptw8aYEt155JnWqTcMvJb53+h5hKD9EkK6WUPG2ivxPBv9O6ysUaBt+3qSpeioKd9fLTqzsahym3RhGvu2gzhCe7yGuUxdujw8BzQWbCcyLFZB7C8dRqTLgUfRiI+1kThPJ/wRlZWctBaNggkB0EOtjsk9CKqOzAXt/KC7YQRo16u3sZu2JVVbxCPwJMbuNDCySH8cuvjnfAmqslaMN7+1A0JlhQv+iGOQjrxZV2Ph8O2QLpm5nyrfHRn+FAS+VhAt9BD4YaU0665WsbaepWBe88J4hSR6Ti2I4YRGojfSQ7oFdBTrNnBwH+WDWpq4vVvWO39grt34FFlgiz2iLI9w7hK7Jw+XhH1WUg8BzLRHM+dbgicQ/68RVzt6v7IuEI4CSdt8KhItk4YuYs0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(8936002)(36756003)(8676002)(16526019)(81166007)(186003)(356005)(36860700001)(426003)(86362001)(70206006)(2616005)(70586007)(6916009)(83380400001)(82310400003)(47076005)(7696005)(26005)(2906002)(6666004)(336012)(316002)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 19:57:17.7791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172d6580-25fa-4460-bfda-08d98383575b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

Move jpeg2 shared macro to header file

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 20 --------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 85967a5..299de1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -32,26 +32,6 @@
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
-#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET				0x1bfff
-#define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET				0x4029
-#define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET				0x402a
-#define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET				0x402b
-#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ea
-#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40eb
-#define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET				0x40cf
-#define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET				0x40d1
-#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET			0x40e8
-#define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40e9
-#define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET				0x4082
-#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ec
-#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40ed
-#define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET			0x4085
-#define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
-#define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
-#define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
-
-#define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
-
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 15a344e..1a03baa 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -24,6 +24,26 @@
 #ifndef __JPEG_V2_0_H__
 #define __JPEG_V2_0_H__
 
+#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET				0x1bfff
+#define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET				0x4029
+#define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET				0x402a
+#define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET				0x402b
+#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ea
+#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40eb
+#define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET				0x40cf
+#define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET				0x40d1
+#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET			0x40e8
+#define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40e9
+#define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET				0x4082
+#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ec
+#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40ed
+#define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET			0x4085
+#define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
+#define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
+#define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
+
+#define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
+
 void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
-- 
2.7.4

