Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D272C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 06:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A0B6136A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 06:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A0B6136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E010A891B7;
	Tue,  6 Apr 2021 06:43:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DA78825B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 06:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzCSuV5KJn/HnC7niPQEc3S7wR1Wja1fhZ+qRq//uesVVH/iF+pV9sSSk/3HqOkcMcFVk3sqUZ+d4ibsNNi3ERgEnur4a/Vq20I9eDROprfEroELLswzm5E9gIyGl5xVTJlZKjZFfatFzjdU8tqq11v2fHXpgY5+D7LEp55Y+6e5DcAqe/xy7n1vpMiZ3LXzzQqk0NrFeqq7QSKgMrdSDxHEoCi4jBADMoY4sMjFdUhgF2eYbxEtwyIN/BBt8U2ZcHJ3rKa6loWez1fL0VGZcrEdMj6LrfBWcN00uW1EYYJqQYfWHOWj38PTisUuYKSW1/mubyvybmlwlEcpWAO49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSKggZoeu1DPYK4uLoalB/oJTXEYSwD4iz4QM1ys1SM=;
 b=hbgXACA5e9yedrFKzvxqKyig/LEnxTrzK6QYJnfMDAQyTLmGRo0h5p0ubYSUxCpqOxKlhEg8m33ybkfjjq78qxHfJYgXTWV7/+mZRu9Ec3lHEdrt+PJst0gjxBreyyUZVsiKPbf95SVTeYNajKek9JY2cjmJeEvRWoeFH+vh9LqIBiBvFAWDsQOicdh9D9sMHDZ61ytnjhWN4Pov7yF1JvufPbeyyg+Ha6X3h7/C5dDsRjfmlFzBQz0GBRFIl6z4t1Lu92f3vO2DCRZOBuUrKFHC8nHJSsC/cXw1aPnkfVa1hgqZLQ5XX/2ZfvQh2uKVnSXqszylQuwWQO2bLqNBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSKggZoeu1DPYK4uLoalB/oJTXEYSwD4iz4QM1ys1SM=;
 b=3oLL2f3p6gLkqnpnjDqKQysjmtyGlUc9pZmqPCkuYeHfGlvwP4QlIRaC7uA+2qWP6zHL9mUcRj8QIuvdY6g/qFPYgIAnMFZV9UpxNME4YSC3hyAYok9VvDYRQmHTO3BEUzNqmjtAH6EjwTVcfNptSINXhH0bBxl+H5fCnVG8JpY=
Received: from MWHPR14CA0070.namprd14.prod.outlook.com (2603:10b6:300:81::32)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 06:43:01 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::bf) by MWHPR14CA0070.outlook.office365.com
 (2603:10b6:300:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Tue, 6 Apr 2021 06:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 06:43:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 01:43:00 -0500
Received: from judeshih-VirtualBox.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 6 Apr 2021 01:42:58 -0500
From: Jude Shih <shenshih@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Date: Tue, 6 Apr 2021 14:42:55 +0800
Message-ID: <20210406064255.45212-1-shenshih@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 663e7d26-d2ee-4460-9940-08d8f8c73952
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:
X-Microsoft-Antispam-PRVS: <DM4PR12MB529485120E7F7C02564C59E1F7769@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Kif2KCMej2yPnXnKk7awL2pGdnBEDhhAtU6CtSqTTyQWXICer76yGvjUAb7OuIDVAYh2DDJG0IHvUq58JuvpqCp3r/FFcV91SbBayRtpQiW4zuLTl1ILUjfh6xsQpyL6UuEl/1BZL5Ffsl2mj7iJMf+tZEFPTTEDibUCd1Ui9B4m2mu/6ALpJUQA1K3iyQfZ+DJtLCflU7LaJ6rms0/e12AN+1IZZPbzXo/rYzBIwMYRfrLDlDMn5J1/+qtMi4XNbYjDx3jYulLvoHcaarryFERCUcdVQED7DYVXoG4x8zzze1i0SINM0lOcr3DKrj/Zduxtllu2ZpgdbsV635qFJb96TtZFD+uIg8UJPNaup1D43SeJizqRNBLArEdeFb01OCbc1CUfivh6ZgATwzSRIDTBO04ebLc0h7wTprB1vEPUJdWuRPbTElA2iTDYcFVP2DNjQZq+lUTsd3FdNXxoe/rqmkofHg4IBv4cvkztiDQzhemh24UcG/f6Kq6wM9OrliMtRmi48yUjvQYUp3uBEz9JYGgPVd6mcoCZSZk81rM9qkfH6Fn+nkNDmVF37MQHKQaMQjk6rFjjYsz7Dndsb6NNP8r7FhSPAOEeEcRKbsJ2xQ0Q5bdHRv5WTbLrQBeafvKkPg3obglLELcHC/e9ODtQLA2/YOch/w4o3rocDHh4OTA24gyAsse04LNwvaA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(336012)(1076003)(426003)(8676002)(6666004)(26005)(478600001)(6916009)(186003)(36860700001)(47076005)(82310400003)(2616005)(83380400001)(356005)(81166007)(2906002)(4326008)(316002)(8936002)(5660300002)(7696005)(54906003)(70206006)(82740400003)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 06:43:01.5170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663e7d26-d2ee-4460-9940-08d8f8c73952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
Cc: alexander.deucher@amd.com, Jude Shih <shenshih@amd.com>,
 nicholas.kazlauskas@amd.com, wayne.lin@amd.com
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
 drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
 drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 963ecfd84347..7e64fc5e0dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -923,6 +923,7 @@ struct amdgpu_device {
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
 	struct amdgpu_irq_src		dmub_trace_irq;
+	struct amdgpu_irq_src		dmub_outbox_irq;
 
 	/* rings */
 	u64				fence_context;
@@ -1077,6 +1078,7 @@ struct amdgpu_device {
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
+	struct completion dmub_aux_transfer_done;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
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
