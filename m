Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DA8C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 03:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA8961057
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 03:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA8961057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F026EC12;
	Thu,  1 Apr 2021 03:21:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EFD6EC12
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 03:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTSTOh0k4A6rXH5G0Ohohf0p4RvlF4XQ7IM/4ZJtxewuml+zTI9mw+m6x6iCqb6zchAWftLjyW7b+NpNdQiTiQvTePfPHo7L95CliQLyCQ7yCi3wpqMuzfn7XtDFm3TCQZ3uVx3ZDqxs2HOJacvMDBPf6LKzrLqh7FyIF4bHTyuGd4BVf77vaMvV42a5ykmr7YE84BgyYaWBIGNMi5ZYAtnZgoOgTXWQPUpuk6ahhQyMISp3s6UzmrVy9A6VAHlg2gasGZLTsEby03kuDjz+A+8tuW0aeMrUic64Mh+A8gCe1My6lVYW7Sw8O+VRqiNSvxbs/1rke5uAtcRxU7Bhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIbLRwuknw3bYmcizwNJbLmADTmurOEWfOXTm6MFCFc=;
 b=LRfzfNNMYmgrIVGD9oGOMl96yYEl3+HwifOOhNRZzZXoHXMJb9yBqSuq8YMQp6eIj2m7t2qER0ebnUEWh9W9ROSwPFrbYn04uT31rkhAYA0pyHXFMNwOq3IQbc4k1AcIYLW4StM/ObayWNQqh5QgNe/kN6PJG3BQbCihD0y9heStnAzO2iYKw4y5SZRr7XyifJHDnwb+OcgU06VM6WWZclygf4xAWOuQ9XyeYsM4Gc0Sx8wa5C73mMaO+1iYFII73lFUy53RQChH7rNgGIguxxj/5qFPtG9NSt9UGNtsmKkhxz9Jd3wI6FJGyy01dRnWiQDt9H3K62ct79AbeogvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIbLRwuknw3bYmcizwNJbLmADTmurOEWfOXTm6MFCFc=;
 b=ugEFGELJ06bYLr6hjSidEI/f5QfijFrxmQ/nbcB5PftSnEl5rEz9Eai86PNVF+pktAaPWT7eKsjM7sY55PVG+zVW6wiDhvSA7fmJuyhJC+PVTPh3C3KigkVlvtMo9KPYDWmMnhSTETig1HVnjxjngEsfbqexpgOA1VD8iaeCOb0=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 03:21:51 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::e7) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Thu, 1 Apr 2021 03:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 03:21:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 22:21:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 22:21:50 -0500
Received: from judeshih-VirtualBox.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 22:21:49 -0500
From: Jude Shih <shenshih@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Date: Thu, 1 Apr 2021 11:21:34 +0800
Message-ID: <20210401032134.1083322-1-shenshih@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57daaade-909a-4aa9-d597-08d8f4bd4ae8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3484E26123B4B14BBD0F01CDF77B9@DM6PR12MB3484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru774hNzbZQqn0BW6TeBq43ZIaxCf1B0ah7qA35KfwwDEhy5iE9YvgT50oHjfo8j6JX16fl4pPyNs1CqmIHcL92YQm+qftkgcm4mL0uMFVaU1TKImZBGZHgBhTJXe5nEyXhCJZj0W7GfNOOR+MBKq/06UuYojOF9Am7NjAbC5salJkdKPcmTfIrcqv/6LiwCsm1sG65Khx1kSkW0S16svFohvxp+q5qCa5S4Ffk0QBe35bObw7nWqWPNtKH2Uil6EVNPs6rRRX5f4rn0ybs6ZoRs5TAEpVbufmRO2r0hRijqBvvkcbaQbijUKTxFKOkECJoMfHwCo4dU2WZfcJwdzOgXgdQ9t5eOxWIXGVDPRezl7DTDgoLP2hGZjPPwUXhk8YwHRvsV7qWsP7MCa+/alh5GGZQMsXo8pzTV5e1Omw+dqRG0HfwLrtykTkZ++0UUG62DItsRCTOHUEeSIyamPTv7wbSB3Dsg8dewwXx4hPZgACDemQxQyXAf+E3m9GfDnR1TorxOhk9r3rcThch1skFYy4+os41mM3dHuHBr62Bbj53+yW3D+0EzROe3CHzlYe25upcwbAY6+sr8057BkABv8QFYAsLVd4rfkC4lTGh4vmKAatCoPIsAYCX6Ts0/M1Qj5VjVPpNPwor7kuN8gKHnMJkT0/J7Q5NYshYd4aY5zS2onfZhJceI+OTji18/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(376002)(346002)(36840700001)(46966006)(36860700001)(47076005)(4326008)(54906003)(426003)(70586007)(8676002)(6916009)(478600001)(82740400003)(2616005)(6666004)(82310400003)(5660300002)(7696005)(336012)(1076003)(2906002)(36756003)(81166007)(83380400001)(70206006)(186003)(316002)(8936002)(356005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 03:21:51.4465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57daaade-909a-4aa9-d597-08d8f4bd4ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
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
Cc: alexander.deucher@amd.com, Jude Shih <shenshih@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
We use outbox interrupt that allows us to do the AUX via DMUB
Therefore, we need to add some irq source related definition
in the header files;
Also, I added debug flag that allows us to turn it on/off
for testing purpose.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                   | 2 +-
 drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
 drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 963ecfd84347..479c8a28a3a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -923,6 +923,7 @@ struct amdgpu_device {
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
 	struct amdgpu_irq_src		dmub_trace_irq;
+	struct amdgpu_irq_src		outbox_irq;
 
 	/* rings */
 	u64				fence_context;
@@ -1077,6 +1078,7 @@ struct amdgpu_device {
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
+	struct completion dmub_aux_transfer_done;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6a06234dbcad..0b88e13f5a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -159,7 +159,7 @@ int amdgpu_smu_pptable_id = -1;
  * PSR (bit 3) disabled by default
  */
 uint amdgpu_dc_feature_mask = 2;
-uint amdgpu_dc_debug_mask;
+uint amdgpu_dc_debug_mask = 0x10;
 int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp;
 int amdgpu_discovery = -1;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 43ed6291b2b8..097672cc78a1 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -227,7 +227,8 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PIPE_SPLIT = 0x1,
 	DC_DISABLE_STUTTER = 0x2,
 	DC_DISABLE_DSC = 0x4,
-	DC_DISABLE_CLOCK_GATING = 0x8
+	DC_DISABLE_CLOCK_GATING = 0x8,
+	DC_ENABLE_DMUB_AUX = 0x10,
 };
 
 enum amd_dpm_forced_level;
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
index e2bffcae273a..754170a86ea4 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
@@ -1132,5 +1132,7 @@
 
 #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
 #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
+#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
+#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8
 
 #endif // __IRQSRCS_DCN_1_0_H__
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
