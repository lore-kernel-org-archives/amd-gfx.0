Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD82C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8825B20870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FFg+xjHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5136EB20;
	Wed,  4 Mar 2020 10:52:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708FA6EB20
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 10:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeVYJm4xloiNQzS+oSYI5OyY3cRqcOaW+FibQP+DyNcyZ8OKk/O84SmqqBZTHJ45yfQgbt8WR/NBf/mRPbykBy9fatYA8IVWGiAy0yzE/EVyPDE8pnVQsuXQtkS/2d/EpdmpU8ONkQtQpHAFGyLwC7DOPpv/jpXNcTdxFBaFx/IROirhtBPfgBo/uOQ6RIht4PhAteHe1oZW7fc/xkS00J2YdcJjCCrLtB2ZNUZgq45Xd3N79IaEdFNwlWQ0ood5tEZC8cRoSKBKZ0EgBU4n/IV0L0safSadFDmFzQGMFXVI0xO5yWmXDShgcjAu2/Y363lz0Nr4ZV336iLVbI86mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE4pHjNxNH8TkZRIRpLGlrP4Ws1dpKvLn3TnpChLbEQ=;
 b=l4+phCfrP/bdOICNNpaeQhgzAF5KRDW/rt9ez9+RQ7VF/qz/z9uE+bZI3BPKJ3Toip8eZJyLNdQ/BjXPmee3cYnX/0UGaRYXq/C8oXf78cGuC+AAoKAf2sBKzkChvGeG0p3CenJm/YLWHlFDZFfSaT3ZDtDHovIdcin6iSJvkFL62RODe0r+Sd7uxGywy6KLloYiSPOTU4YSA4olcMNPLDap4TOToycbUPNwmrsOzPS4xKYM9MPcwGdug++hpmkoAdfLYf7TlWNShP2MXKh8SYbIFyL66W45LHTdhPUvgudI9ojzpQoQe3Vi9ncUjBOS675Sjqs2eRpFQxyY2Av9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE4pHjNxNH8TkZRIRpLGlrP4Ws1dpKvLn3TnpChLbEQ=;
 b=FFg+xjHlscxwMsQNxbcahPV9cTnBvAWv8uGhs/3Qjk7Qp7jiW65cyC4lJ8WfvW0Q8I/Nw+spSlcPy9M5AW4TKXPytYmbeqb04ADCQAwhUA0ygmJIBVETAG3gH85S9Kt7Ko+b4WWLCw1sQJLk+NdlNBg17samwDkWcPcMB6QCtrk=
Received: from MWHPR1701CA0006.namprd17.prod.outlook.com
 (2603:10b6:301:14::16) by BYAPR12MB3271.namprd12.prod.outlook.com
 (2603:10b6:a03:138::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Wed, 4 Mar
 2020 10:52:21 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::c8) by MWHPR1701CA0006.outlook.office365.com
 (2603:10b6:301:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 10:52:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 10:52:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:20 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:19 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 04:52:17 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>, Dennis Li
 <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: add helper funcs to detect PCS error
Date: Wed, 4 Mar 2020 18:52:01 +0800
Message-ID: <20200304105203.6660-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304105203.6660-1-Hawking.Zhang@amd.com>
References: <20200304105203.6660-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(428003)(189003)(199004)(8676002)(26005)(186003)(8936002)(81156014)(81166006)(5660300002)(4326008)(6636002)(86362001)(6666004)(356004)(478600001)(70586007)(70206006)(36756003)(110136005)(336012)(316002)(7696005)(1076003)(2616005)(2906002)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3271; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1fd425-5e3e-4619-23be-08d7c02a1d63
X-MS-TrafficTypeDiagnostic: BYAPR12MB3271:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3271C4174165176E47D5DA60FCE50@BYAPR12MB3271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHV7dHURrxG80+ETgJB+I1+c39shGs3WwJnJ79LnjGYM/9+y5H9PLt9ogYELrtnJyoqInj9Q03M6dG+NFfM1brfvM6PVyemZOBvwgZzXmSbgQxGj6tRR2XWNKfwiUbCE926QmRvW9JcX4dq7ISuutae+X1QZN7ry5D7UOV33yWkFabk6PZ6EwJFtk9XzC9wxkyub62wVMuPQxYh5L9CTbcSoR73DRNZ5LY9tCB5crtctWkY9IwVBcU9mhc3/zHE7jbisJyZD17TycMn495FHRJYxkT2Ym9ql2L26Ru5Mw2VXz9zc8/IU1bVaV//gfdK+0KV12lvuqSxDpWOGYEnRs74GSbwjjJCx3E7O1udkH2YSxlVo9NCYpO44JdRFQuW2tLPesdhf/F7CATtoxgH4Km9WkJ9M2JMJPtDm2Dq8gPT8y+tXxjVKH6jyDCcugRyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 10:52:20.8781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1fd425-5e3e-4619-23be-08d7c02a1d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since from vega20, hardware supports run-time detect
and report XGMI/WAFL PCS ras error. Add helper functions
to walkthrough every type of ras error and report it if
any.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 173 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |   8 ++
 2 files changed, 181 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fbc41926de08..61a28f8ec34e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -26,7 +26,12 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_ras.h"
+#include "soc15.h"
 #include "df/df_3_6_offset.h"
+#include "xgmi/xgmi_4_0_0_smn.h"
+#include "xgmi/xgmi_4_0_0_sh_mask.h"
+#include "wafl/wafl2_4_0_0_smn.h"
+#include "wafl/wafl2_4_0_0_sh_mask.h"
 
 static DEFINE_MUTEX(xgmi_mutex);
 
@@ -36,6 +41,94 @@ static DEFINE_MUTEX(xgmi_mutex);
 static struct amdgpu_hive_info xgmi_hives[AMDGPU_MAX_XGMI_HIVE];
 static unsigned hive_count = 0;
 
+static const int xgmi_pcs_err_status_reg_vg20[] = {
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS,
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS + 0x100000,
+};
+
+static const int wafl_pcs_err_status_reg_vg20[] = {
+	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS,
+	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS + 0x100000,
+};
+
+static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
+	{"XGMI PCS DataLossErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
+	{"XGMI PCS TrainingErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, TrainingErr)},
+	{"XGMI PCS CRCErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, CRCErr)},
+	{"XGMI PCS BERExceededErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, BERExceededErr)},
+	{"XGMI PCS TxMetaDataErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, TxMetaDataErr)},
+	{"XGMI PCS ReplayBufParityErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, ReplayBufParityErr)},
+	{"XGMI PCS DataParityErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataParityErr)},
+	{"XGMI PCS ReplayFifoOverflowErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, ReplayFifoOverflowErr)},
+	{"XGMI PCS ReplayFifoUnderflowErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, ReplayFifoUnderflowErr)},
+	{"XGMI PCS ElasticFifoOverflowErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, ElasticFifoOverflowErr)},
+	{"XGMI PCS DeskewErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DeskewErr)},
+	{"XGMI PCS DataStartupLimitErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataStartupLimitErr)},
+	{"XGMI PCS FCInitTimeoutErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, FCInitTimeoutErr)},
+	{"XGMI PCS RecoveryTimeoutErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, RecoveryTimeoutErr)},
+	{"XGMI PCS ReadySerialTimeoutErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, ReadySerialTimeoutErr)},
+	{"XGMI PCS ReadySerialAttemptErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, ReadySerialAttemptErr)},
+	{"XGMI PCS RecoveryAttemptErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, RecoveryAttemptErr)},
+	{"XGMI PCS RecoveryRelockAttemptErr",
+	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, RecoveryRelockAttemptErr)},
+};
+
+static const struct amdgpu_pcs_ras_field wafl_pcs_ras_fields[] = {
+	{"WAFL PCS DataLossErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, DataLossErr)},
+	{"WAFL PCS TrainingErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, TrainingErr)},
+	{"WAFL PCS CRCErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, CRCErr)},
+	{"WAFL PCS BERExceededErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, BERExceededErr)},
+	{"WAFL PCS TxMetaDataErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, TxMetaDataErr)},
+	{"WAFL PCS ReplayBufParityErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, ReplayBufParityErr)},
+	{"WAFL PCS DataParityErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, DataParityErr)},
+	{"WAFL PCS ReplayFifoOverflowErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, ReplayFifoOverflowErr)},
+	{"WAFL PCS ReplayFifoUnderflowErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, ReplayFifoUnderflowErr)},
+	{"WAFL PCS ElasticFifoOverflowErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, ElasticFifoOverflowErr)},
+	{"WAFL PCS DeskewErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, DeskewErr)},
+	{"WAFL PCS DataStartupLimitErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, DataStartupLimitErr)},
+	{"WAFL PCS FCInitTimeoutErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, FCInitTimeoutErr)},
+	{"WAFL PCS RecoveryTimeoutErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, RecoveryTimeoutErr)},
+	{"WAFL PCS ReadySerialTimeoutErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, ReadySerialTimeoutErr)},
+	{"WAFL PCS ReadySerialAttemptErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, ReadySerialAttemptErr)},
+	{"WAFL PCS RecoveryAttemptErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, RecoveryAttemptErr)},
+	{"WAFL PCS RecoveryRelockAttemptErr",
+	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, RecoveryRelockAttemptErr)},
+};
+
 void *amdgpu_xgmi_hive_try_lock(struct amdgpu_hive_info *hive)
 {
 	return &hive->device_list;
@@ -530,3 +623,83 @@ void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
 		kfree(ras_if);
 	}
 }
+
+static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
+					      uint32_t value,
+					      uint32_t *ue_count,
+					      uint32_t *ce_count,
+					      bool is_xgmi_pcs)
+{
+	int i;
+	int ue_cnt;
+
+	if (is_xgmi_pcs) {
+		/* query xgmi pcs error status,
+		 * only ue is supported */
+		for (i = 0; i < ARRAY_SIZE(xgmi_pcs_ras_fields); i ++) {
+			ue_cnt = (value &
+				xgmi_pcs_ras_fields[i].pcs_err_mask) >>
+				xgmi_pcs_ras_fields[i].pcs_err_shift;
+			if (ue_cnt) {
+				dev_info(adev->dev, "%s detected\n",
+					xgmi_pcs_ras_fields[i].err_name);
+				*ue_count += ue_cnt;
+			}
+		}
+	} else {
+		/* query wafl pcs error status,
+		 * only ue is supported */
+		for (i = 0; i < ARRAY_SIZE(wafl_pcs_ras_fields); i++) {
+			ue_cnt = (value &
+				wafl_pcs_ras_fields[i].pcs_err_mask) >>
+				wafl_pcs_ras_fields[i].pcs_err_shift;
+			if (ue_cnt) {
+				dev_info(adev->dev, "%s detected\n",
+					wafl_pcs_ras_fields[i].err_name);
+				*ue_count += ue_cnt;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+				      void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	int i;
+	uint32_t data;
+	uint32_t ue_cnt = 0, ce_cnt = 0;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL))
+		return -EINVAL;
+
+	err_data->ue_count = 0;
+	err_data->ce_count = 0;
+
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	default:
+		/* check xgmi pcs error */
+		for (i = 0; i < ARRAY_SIZE(xgmi_pcs_err_status_reg_vg20); i++) {
+			data = RREG32_PCIE(xgmi_pcs_err_status_reg_vg20[i]);
+			if (data)
+				amdgpu_xgmi_query_pcs_error_status(adev,
+						data, &ue_cnt, &ce_cnt, true);
+		}
+		/* check wafl pcs error */
+		for (i = 0; i < ARRAY_SIZE(wafl_pcs_err_status_reg_vg20); i++) {
+			data = RREG32_PCIE(wafl_pcs_err_status_reg_vg20[i]);
+			if (data)
+				amdgpu_xgmi_query_pcs_error_status(adev,
+                                                data, &ue_cnt, &ce_cnt, false);
+		}
+		break;
+	}
+
+	err_data->ue_count += ue_cnt;
+	err_data->ce_count += ce_cnt;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index c62a4acf4c14..ae78b7f74776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -37,6 +37,12 @@ struct amdgpu_hive_info {
 	struct task_barrier tb;
 };
 
+struct amdgpu_pcs_ras_field {
+	const char *err_name;
+	uint32_t pcs_err_mask;
+	uint32_t pcs_err_shift;
+};
+
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
@@ -46,6 +52,8 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
 int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev);
+int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+				      void *ras_error_status);
 
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		struct amdgpu_device *bo_adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
