Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF02C43466
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 13:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE972084C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4M2oP/di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE972084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592D689FA6;
	Mon, 21 Sep 2020 13:48:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5175F89FA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 13:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fda4EXBhYaig/DUwEjiiPdTq0MvBfaHgjya6QOLZk5kRxKKuakgMQsiN6Y6ODhenZOSwyY6CtQFpo1Jtu9iL5jnEeLchEzrBq3T1VG8qk9RfDIKRdxY7Zrx8rPMnUpT6471eZeeXY/SoDAz4eOfOUMemtSQJcSVEUaUgMg/uqXxbRk31t6hOK++WJo6qfSdfAIpRVTjtYKbQRffwUQ5QEI/0Ja9SZGhH5kMjiaYXI/2hZJupeKaMVIRuvTrujteyj+tsR0Fb0QCjpucR+AJC/Ih5TzsZ6zggjfNG4qIx9IvfAJfx/RMb+SbZNJA1xgYhcoc4fIqnfnomqH6Oglm5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NO2pK91SHVwgDQSuG8RooafNxN74RPhdcd/yh5HO/M=;
 b=Ck0rEhYk9VIKZlSABUtwl/ISle0dHd7Lp/PjOWs3QS/D+2HuYe4SJaRheGtwV0Ilf2LYsjgl6R+xApc2xlrdfAhGALGK204SSBzAywdpt4/ChMzM4hTs/TBpJe87uJrm5aN5nXLsMy0ctlbbCdn1ivb8gC4LhFqrWy+zHyPgMcIOxuGoS3JVEtJl2VqPZ0AyDBxSdm5wAxjNp15ZzBXybcuUiQAbES0lc93EkelkZKMu1hr/4oLA86PMXfDAuh3EUjhA6CeraJKX26LNcCxbKkt6k0/0HILT18nE/N4w0H4mZkiVK+5OANQ0bhqBl4qY/BHA+Wo/d5FMIiUn3Bl1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NO2pK91SHVwgDQSuG8RooafNxN74RPhdcd/yh5HO/M=;
 b=4M2oP/diEwoXxdZBHJdbwa41dHvV/sAJt+r6ZbdupIFH/c7ZY+QOIOtqDndaauSao5ZBCXz3PhGHSDEjt3Eh8Z8OkOl2hHOsVWBNcWJ7olf9I65WiPgWM47LSsAwufjD9q3t0yCRron+qfSIOivlbHiCU/11aI9n7+WT1HM+29k=
Received: from BN6PR1101CA0002.namprd11.prod.outlook.com
 (2603:10b6:405:4a::12) by BYAPR12MB3541.namprd12.prod.outlook.com
 (2603:10b6:a03:13c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 13:48:29 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::e0) by BN6PR1101CA0002.outlook.office365.com
 (2603:10b6:405:4a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Mon, 21 Sep 2020 13:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 13:48:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 08:48:28 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 08:48:28 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 21 Sep 2020 08:48:26 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 1/1] drm/amdgpu: update athub interrupt harvesting handle
Date: Mon, 21 Sep 2020 21:48:24 +0800
Message-ID: <20200921134824.29636-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a860f2f-a6dc-4eed-9e74-08d85e350563
X-MS-TrafficTypeDiagnostic: BYAPR12MB3541:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3541BBFCFE0EB0B8CC7A194B9A3A0@BYAPR12MB3541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SW+MWP/yu1pLVzxi8Tux0kQMO4S3bDqBsCYs0mJnHM6gBm9LvcTey+GkvfQvq68/4oaS1+rUlRfr/LTdAaMnOUOSZAEvBKQrLw8OWL+4i33uHI6L9IaUUCGY3JuiZNe+0w5FfOoleMvyTgE/S2E6NwIVmuL5nUp/yEFnZgn0pHnRFrKs+jCK7hnltKB/x7zzNHkOh2GZVlWkV4ibKQNe/JZyTR0dq++KhantcltpJYitrq1KfmgFHY8R3pB3sREdBUb0Rd/18bc1cJqjkoW7YuJEic/lRrq+6THddWq0KfQap7g5SUXQjNTNiJe1RgqrojfcHOdqCK64mzhtCDgov9igoNgA6KJ6JKebtKn+xiFf/dxPevSb4tqnnksKbjkvh8yxVPYgTS1nXqTECXECw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(336012)(70586007)(6916009)(70206006)(2616005)(426003)(26005)(47076004)(4326008)(82310400003)(478600001)(86362001)(15650500001)(186003)(83380400001)(54906003)(81166007)(316002)(8936002)(7696005)(5660300002)(36756003)(2906002)(1076003)(82740400003)(8676002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 13:48:28.9197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a860f2f-a6dc-4eed-9e74-08d85e350563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3541
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
Cc: Guchun.Chen@amd.com, Tao.Zhou1@amd.com,
 "Stanley.Yang" <Stanley.Yang@amd.com>, John.Clements@amd.com,
 Dennis.Li@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCEA/MMHUB EA error should not result to DF freeze, this is
fixed in next generation, but for some reasons the GCEA/MMHUB
EA error will result to DF freeze in previous generation,
diver should avoid to indicate GCEA/MMHUB EA error as hw fatal
error in kernel message by read GCEA/MMHUB err status registers.

Changed from V1:
    make query_ras_error_status function more general
    make read mmhub er status register more friendly

Changed from V2:
    move ras error status query function into do_recovery workqueue

Changed from V3:
    remove useless code from V2, print GCEA error status
    instance number

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 43 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c         | 29 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 29 +++++++++++++
 .../amd/include/asic_reg/gc/gc_9_4_1_offset.h |  4 +-
 8 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a611e78dd4ba..258498cbf1eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -217,6 +217,7 @@ struct amdgpu_gfx_funcs {
 	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
 	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
+	void (*query_ras_error_status) (struct amdgpu_device *adev);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 0c43d7fe893c..1ae9bdae7311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -40,6 +40,7 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5ea14774c0c..40614ac9a111 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1498,6 +1498,45 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 	}
 }
 
+/* Parse RdRspStatus and WrRspStatus */
+void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
+		struct ras_query_if *info)
+{
+	/*
+	 * Only two block need to query read/write
+	 * RspStatus at current state
+	 */
+	switch (info->head.block) {
+	case AMDGPU_RAS_BLOCK__GFX:
+		if (adev->gfx.funcs->query_ras_error_status)
+			adev->gfx.funcs->query_ras_error_status(adev);
+		break;
+	case AMDGPU_RAS_BLOCK__MMHUB:
+		if (adev->mmhub.funcs->query_ras_error_status)
+			adev->mmhub.funcs->query_ras_error_status(adev);
+		break;
+	default:
+		break;
+	}
+}
+
+static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_manager *obj;
+
+	if (!con)
+		return;
+
+	list_for_each_entry(obj, &con->head, node) {
+		struct ras_query_if info = {
+			.head = obj->head,
+		};
+
+		amdgpu_ras_error_status_query(adev, &info);
+	}
+}
+
 /* recovery begin */
 
 /* return 0 on success.
@@ -1568,8 +1607,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		}
 
 		list_for_each_entry(remote_adev,
-				device_list_handle, gmc.xgmi.head)
+				device_list_handle, gmc.xgmi.head) {
+			amdgpu_ras_query_err_status(remote_adev);
 			amdgpu_ras_log_on_err_counter(remote_adev);
+		}
 
 		amdgpu_put_xgmi_hive(hive);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d898c9ff3526..adee0177654e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2075,6 +2075,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_gfx_funcs = {
 	.ras_error_inject = &gfx_v9_4_ras_error_inject,
 	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index bd85aed3523a..bc699d680ce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -992,3 +992,32 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
 
 	return ret;
 }
+
+static const struct soc15_reg_entry gfx_v9_4_rdrsp_status_regs =
+	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
+
+void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
+{
+	uint32_t i, j;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	for (i = 0; i < gfx_v9_4_rdrsp_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_rdrsp_status_regs.instance;
+		     j++) {
+			gfx_v9_4_select_se_sh(adev, i, 0, j);
+			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
+				gfx_v9_4_rdrsp_status_regs));
+			if (reg_value)
+				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
+						j, reg_value);
+		}
+	}
+
+	gfx_v9_4_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index 1ffecc5c0f0a..875f18473a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -34,4 +34,6 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
 
 void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev);
 
+void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev);
+
 #endif /* __GFX_V9_4_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 6c6ad529c65c..c2ef8142136e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1624,6 +1624,34 @@ static void mmhub_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
+static const struct soc15_reg_entry mmhub_v9_4_err_status_regs[] = {
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA0_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA1_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA2_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA3_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA4_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA5_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA6_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA7_ERR_STATUS), 0, 0, 0 },
+};
+
+static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mmhub_v9_4_err_status_regs); i++) {
+		reg_value =
+			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v9_4_err_status_regs[i]));
+		if (reg_value)
+			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
+					i, reg_value);
+	}
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
@@ -1636,4 +1664,5 @@ const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.set_clockgating = mmhub_v9_4_set_clockgating,
 	.get_clockgating = mmhub_v9_4_get_clockgating,
 	.setup_vm_pt_regs = mmhub_v9_4_setup_vm_pt_regs,
+	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
 };
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
index f41556abfbbc..629a8a3b55e9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
@@ -205,6 +205,8 @@
 #define mmGCEA_EDC_CNT2_BASE_IDX                                                                       0
 #define mmGCEA_EDC_CNT3                                                                                0x071b
 #define mmGCEA_EDC_CNT3_BASE_IDX                                                                       0
+#define mmGCEA_ERR_STATUS                                                                              0x0712
+#define mmGCEA_ERR_STATUS_BASE_IDX                                                                     0
 
 // addressBlock: gc_gfxudec
 // base address: 0x30000
@@ -261,4 +263,4 @@
 #define mmRLC_EDC_CNT2                                                                                 0x4d41
 #define mmRLC_EDC_CNT2_BASE_IDX                                                                        1
 
-#endif
\ No newline at end of file
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
