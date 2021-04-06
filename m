Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2660DC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 13:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E33613C3
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 13:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E33613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA0589A61;
	Tue,  6 Apr 2021 13:40:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5B489A61
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 13:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCseL4cvtLxc7IRACNwmf10o3tQ2T9NtU5rf5+6Ibk3bM3EgeG6DtGnfBZ8RRsuTfUtaeyhmlN4N+TOLYMJxIzNRNZUAizaDMcer07/YIwvjj9sExT9nmdcxFSRnTGpr/LCpNAJxr2602FYZuMXfpCON38UHGKsZn4yilE+SEeKPEpoBaHszg1KPvqQedY10iujPAhceN98jcKcwncwNhMg359HNcBxPMwdU4dX+F1nbjBZOzzoVQ/++s+BtZVA6x0QsyuQjN5LbXryqLR8LpGBIs6XzfRr7DgrUCvWtGTUROpwC6bTo4mD7iYxAToYhBfS0i0sDuWMeukQXJZRHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4j/UJKBkxiZ0Pha0wS0tnxhf6fj1WEkDnhzdQpt+Z4=;
 b=bAju6n+Dd2jntxBLNwKs7p43WL/Z3uHx94P+mCpNmrDUDbHF9XarHZmwuTl5+9fjR709pL03CKUw/00ZB1M3ANNpZeGGNN9poqqvUPElHDUN+z6fsvWzFIuqTrIBwZ1Hsu+tFwlfEDWLPQOF2vVUUaoL1RuXc6gnmUooWhKRhbtHRQGo+kqZet6aVlWlzO0IwpjmkyvyjuBVNU/quH8PmPOEqfV/qPDvJQLXfE1MODHthKSYATSrb/zYMY19wrak+eR5+Rof1BvsfaXRP1HKhbv4lWXGbjZI5guTFhH6VTDCSh3QfkFKBywoTcj74kJVRlx+RgGT6vy4nO0awg6xWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4j/UJKBkxiZ0Pha0wS0tnxhf6fj1WEkDnhzdQpt+Z4=;
 b=B786El9l03Mty9FJXCOr4sAyLMJGh9VPGA8NuWphvGskPSPW57FJ0lCNvTbju48PrWHosy197cm5a9YeXy8oMz9HNqlkd99kU2p8hQB88w2acHC2gwxhBV73jMnHZwZT3DinazFXkINoj1pfrP++reCagtNGiIsZYzbufmB/i0Y=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 13:40:07 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::46) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Tue, 6 Apr 2021 13:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 13:40:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 08:40:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 08:40:06 -0500
Received: from judeshih-VirtualBox.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 6 Apr 2021 08:40:04 -0500
From: Jude Shih <shenshih@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Date: Tue, 6 Apr 2021 21:40:01 +0800
Message-ID: <20210406134001.46915-1-shenshih@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f376315b-6cd8-4f02-146e-08d8f9017d9c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4258:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4258851E955735D8550FBF78F7769@BY5PR12MB4258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sri5NpcjBwqZPf9cpl/ZaUH4ZVA6DwWpYmwDUK+jXxkj3mO3FAU89z32beZxFGzeijwIUADnals5Bc7rYATjx6tc4Argcdb/0qaEGHuN50cV2tnkUYOdT7F50np3QIQikWFhgLgXw+1FoVbeINkH7h8pPCI1eIlEUuo3tHfNbTudk5w3pz58EdphAHyYu7juteBlkPLNo+sk/xDDcKirtUGRpCGCOt1Xd7y4FQksl4AjWcHuVbFfaXg/j7Wu4BLnM0wgZ4DDQ3W54a78cKRlXfYIgcc0zG6y75YE30KMhnBpkRzr968YLQRl2o8yJpHo4X8S7/vN36iNzzZa7G9QCj7cjijWzur+4viVH77IZ8pZnT1VsZTTl8F3m2Y6Gi2Sa/FurIz2pqWdvvXmw5zB24CRqMUzltSJtriBvUfq7BDDfF/9c6nN5wHcXiYq86/GX7bd6oi8mDv9Smop7WLUrgN6a83OkTjWpgbISp2n0AZ0EMeZkrfTPnmdVyK30/47yIu1VviGLPnCpkt9V3kzDlcww/3YhEmCSIMdV/wSQu3D1AuaWbzgC58nx0P+lhEY+0HC1GdT4nmpqBTW1kW2k3KD8qj7oYcdT213C11id/1Xf9WbOHLog1nl/anPPydWvM0eFUGLjBmszNvIpBo7rPODYZszP0d3tN4+bWtyiQEvGUdYZzq2ITCTwc3PgjBl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(346002)(376002)(396003)(46966006)(36840700001)(336012)(36756003)(316002)(6916009)(2906002)(26005)(186003)(2616005)(426003)(8676002)(8936002)(5660300002)(1076003)(70586007)(82740400003)(81166007)(36860700001)(82310400003)(356005)(478600001)(83380400001)(47076005)(7696005)(54906003)(4326008)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 13:40:07.0139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f376315b-6cd8-4f02-146e-08d8f9017d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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
 cruise.hung@amd.com, nicholas.kazlauskas@amd.com, wayne.lin@amd.com
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

Signed-off-by: Jude Shih <shenshih@amd.com>
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
