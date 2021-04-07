Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C41C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 08:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD7F610E6
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD7F610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D737899D4;
	Wed,  7 Apr 2021 08:34:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E3E899D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 08:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVeCZbq9qXfkSCsEKxVvoRSrZJpiOoRvUoX/Dv3YfAUQAydWA2CI6tpw15pSaH2AVTCeNQTOLkQuIzHI1XsiPiAfYwwj8ypB+TCBZY0EcK72dib43Y9BwRRvwdebQt8FNoBBxBur6SGf7eFFKpCnN8ywKessMXnWKOMciHJ3FTKVN2xTvkhOnLWR2gF/75XQPVm8tGpveecxQ23TH1EL1ECE7SzZG2leWNghBWMrM7n1+kUTcF6dtDqXq2wFZN/sQoLBjhS3wg8mYuLsWsqbFdPf37c69S3xlZrh912rqYloqjFH74pludp8pEbQMQr+Im4U+E2fKBlXNMGZ/GxZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5sJf7ge9ZWJ796LsNtQLIGGpQk2zDr/1/olY93AXvk=;
 b=XtpzV+2+oy4o43Y314mMPmFwgSbZa/zIikL1SXkZUsA6jfpDGnLaVqDKhhg/H41bxaFb9+Wnnb7nhohda/RfQsg25d84ucbVA37YT5ffAZxGP9941rL+oao9ciIQeKhNFvC96WBlXkiuk4DUB5oudlGV2YTEiWn//HE1ptUn2snGySO+zYM3MALV0sY+A/lFeS8seuIw8C9oUf/dMxXX4n/dOHCbvXG8ZqOFRFJHg9dV7CBMSVhmIXVCE6gTxVMfLdYlZzIrUkLnO6V4hQN7CAsMZjVA299bHs6+MQjxetMZsn+vCHP8MPFyng7UDFL6J/XOh+oJXp8L95Ud30K9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5sJf7ge9ZWJ796LsNtQLIGGpQk2zDr/1/olY93AXvk=;
 b=lG8yHzpB54lhIc3lQdhUBaJPZS90SCFbbSDTChLi3HjNipMdQrL3HaW+aZkFxpbuFvtRJXrOhPzUlbC/xtbaWsEAEMmkdwDhxsDwFqc2NEnPWvVf2+ztJ9UWQcnBkTBLiICMaOcYo3kjCNRwO1yc22BZdGadoe+OvftD7n1Vh04=
Received: from MWHPR20CA0036.namprd20.prod.outlook.com (2603:10b6:300:ed::22)
 by DM5PR1201MB0186.namprd12.prod.outlook.com (2603:10b6:4:4d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 08:34:35 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::cb) by MWHPR20CA0036.outlook.office365.com
 (2603:10b6:300:ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 08:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 08:34:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 03:34:34 -0500
Received: from judeshih-VirtualBox.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Wed, 7 Apr 2021 03:34:32 -0500
From: Jude Shih <shenshih@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Date: Wed, 7 Apr 2021 16:34:28 +0800
Message-ID: <20210407083428.93645-1-shenshih@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e267fb7c-c823-471e-14e9-08d8f99ff976
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0186:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01863A252DAEBEDF72792114F7759@DM5PR1201MB0186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FanlpXm7Rkb3J4uX4Hhc8syE8hGUXKG7z8OmZkuU7xOt2VHS+ri/tsKc+GAK60jXac7O47BTooj9hQmY3TezJabq8fPom4yasbx1kU3USeVquQJzBFojlTTKCfy9GK1H2fPrPSiB6BhcmRCg30uQOzxyMfYpSkAdpJ9nD7mV3v5Pg9owrYBkkgixW74QZTx0xzlb6hUVTmMym1D0Yqcauvk6PVdkUEfFUuRWnei/v0TdjvQWN+YKEOqjoVnd0RUGOivWhMswQ6wwVpQZeSW9BeJXEw5SMD735rWeHQDeTgmVRDjrxpeqNKuWcRw7FJ/c8WD3ZaKQtWeK+nZ6JK3BZjyA9pNVTKPRSdKvWFKIDAX3QyPqfn6dC7PzjHo5orennUs3tJgFCdAq3YstHEdFz5QJ8Uf6SHEeRMKXfMyuOkuNMf960h9UPr7/8QXxkUGhTzBXXwgFQu47INcIdnlI/wfuO+pi/+N45kx9wZ7FVmBTBM8w9LkF3b6bJ/cl5HIolprP23iy5b+CiikAjpEM1pLKixKaNoEbRFzCd9X4pvDcVs5q+iTYdwTYPL/6CEZ8YtDhSdjSoOdwCW+zCWGJ8uOitC7y0pGfpOIPpjnQBtEJoxk0S51hH96LDPzIFpPorPhfjzblJmizCVqZuJAs9Q+jOCWjC7t1vaQgir3JJQUxy+l6G7xpJ3Sc1s7mPXG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(1076003)(82310400003)(426003)(36860700001)(7696005)(2616005)(5660300002)(4326008)(82740400003)(8936002)(186003)(336012)(70586007)(316002)(478600001)(47076005)(6666004)(70206006)(26005)(54906003)(6916009)(356005)(2906002)(8676002)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 08:34:35.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e267fb7c-c823-471e-14e9-08d8f99ff976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0186
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

Signed-off-by: Jude Shih <shenshih@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 +
 drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 963ecfd84347..480e07d83492 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -923,6 +923,7 @@ struct amdgpu_device {
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
 	struct amdgpu_irq_src		dmub_trace_irq;
+	struct amdgpu_irq_src		dmub_outbox_irq;
 
 	/* rings */
 	u64				fence_context;
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
