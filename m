Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ECFC624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B6810E8E5;
	Mon, 31 Aug 2026 18:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGojmjDA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5140610E8DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxWESzn1n7uc+KFL2naEQJDqeyTVr6o4/RJpZWC74VlM2bfdto05CI/aaTKgi1D7lbtKep30p6tOOo8K07QKGGrbZNBHoYEG85N6yyAUJZ5IKUy3AsqwRQ980sNa4oXbqlNyVQN9G9B5yvUVaN0WrUatas919Yh6L5rIEgp3mqpkoqYS/fVlOAOKX+y86diGbpAY9G8FPaYE/7g3OT7Nnqx8oHvpKqBg8oBHePlWUNlujVQ+qBMCYY+QsS1m43oaUdamdp8glrBZSxwktymj8RdddIMxnMlJ3lLeTd9XhkM0sm4Q6qqsokDKVE+rLz+nKPuD//3VmaZkXXndRa+GtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isp6Zfr2FSz3W17hUiWTrmdrJ9+GTdfbSIwJBGRJSBw=;
 b=cwHVeeI5ytWZrIC82wBqQ4B6C1Dlza6fhEvu8FRGYMscH8CfJK+lrkXTRhKT5NaWQoIwNiHTiBOXaL48+9FRY8mnXxlkdXli4ib/Wy2x4UkslyPW66WzQoMeL5xqj3xJHH8WvAvTNpHwmRfm3GRty2XAH522aJx1nwzIBBYAqIqeVh/jASqhzhzCOPtfXZygDBYUHElo+UfvviZEjBUGU5n4z/akS4/mNyeS/KI0VcL66KOJQn11QldrVTTuNuRQxOjWZeSxkQlePivyK1iL88eHTUry0wy7s/gpE4+TpF2hBEfXSl6UMTcFUGZpXGV+Qe0nwXPkRtWnHgTEUbu7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isp6Zfr2FSz3W17hUiWTrmdrJ9+GTdfbSIwJBGRJSBw=;
 b=hGojmjDAdZoltNzrssL2AUBCsWPE2WW2hPg1T2lxhhS3c/Lfn1rr8TOwncqkJePoCHneNDxnotSciXKI7MCBYtHmfmUJg+1JwsyGywUC9QVM6Za7/2E++YUGdM/g8Sf3s9S03vWfuAgcfYORzRDXiKP4K0AVaM6OSEyP8emoA8Y=
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:22 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::72) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/95] drm/amdgpu: Query initial UALink config from PSP
Date: Mon, 31 Aug 2026 14:26:28 -0400
Message-ID: <20260831182754.1089811-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e852eda-6e66-4a9b-fce3-08df078da2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5LhDzExCJvFXrgSvYcK2v/ZKpJHykHmm0Cp8wP0uQuWrt8TX/S+2sOcJGrNGebCTFHwIMJQcrbw+EQNjmiCpTPCJCpUBhxwQ8aa7+fdvWDa1LfX63U6uySb0vvaBJmfEmMCMCEuPwupDDafsVQfdt/ZfuT0GvjIy2jrLcuA4p88EHPx2vWj41RR+to33MnQV2/LxzrypWWbUyIlACPmwMgrNEH6MuTi28O2X5xJJhnXixGonNXXygEoDRK1EdmJPaeuVWhD2/NsAKmNLH4SFrCAYUHoOl/FD+wMEoVBZ3ljCesCy/6f8q25xB+4uQnUopuodS9GyTZ9LG5eTofbc5H7qCWefYkMKemq6ifk1JV/ReWlIlWqhUapjIY6eCXi/zqxdDU15WaWWrcVxCRUhtBOtngy0BrcBTI/asw9n3wVnIEmw10OhNvjDcx42du2/3YF5FsjIJP7v8fnrt6AmNU12zqBaiOKtK9yYnihhTbELawiWczrxOhRU8OTL9FEp/djHr+eLaHUr8w9fUlSdyiGl1uLbZY8FD3L44DPH84nA38SxC0vK3Dosqbi+DTXfDic1VZH1GvwMVOWf8SwEkotXMfQdw6pk6yfxWjSqAxQHx98Ib50xeMHHXShQxURzuxrIieZfYiUrxTfJ3NdA896/uRscLKnTowBGdAwGr2Hm9OPqb265KIVuCYkBKH/Zo2ha7jyUJ6UvZ92xduSUmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EqiQLgi4ifnu4Fprzv++F9DDVBcMGkXTm2vOSte9S8kkEiHwSK/bW0oHHNjkj+o1HsiTUoH+wBnUL5ENS5AyvxaM0FgFbaykb/2afqR5KUiOENcsEd3U7y/6p2OH+C65iB7g46WHjZdmSN/wKCkN8btHT/69NtaGasYhEra9y5+PgsXWtMp3kjdIFcahLvRKP2x8v4H2xfbwPqkDQPGMxvK9nrVw7bs6OQraaVSrxa3XjvAurI2Luz/VcXtpUIlhzp1wP5/9fhNXGAPdsmklWPVfXhKzYQOR5xAwO/l5844YW5hV4ZObVxe4E5PvVJxooCLUZOf4YxUukq7pLGoA3tscUZSSrDyXcNr2qbY0ynGFz1BA34PZDsAriWrJkIhYKxMvXNH5VJEsShYQTFjgJPEvx4dkWKgchs+bKDVo1Ki/BI/BneaO9PNnSdocYR/K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:21.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e852eda-6e66-4a9b-fce3-08df078da2e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
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

From: Felix Kuehling <felix.kuehling@amd.com>

Query the initial UALink configuration info from PSP at driver
initialization time.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 30 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  5 ++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d91365399c767..41d39f828dfec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -29,6 +29,36 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
+int amdgpu_ualink_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
+	if (r) {
+		adev->ualink.psp_if_ver = 0xffffffff;
+		dev_err(adev->dev,
+			"UALink interface version detection failed: %d", r);
+		return r;
+	}
+	dev_info(adev->dev, "Found UALink interface version 0x%x\n",
+		 adev->ualink.psp_if_ver);
+
+	/* Query initial configuration from ASP */
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+			       adev->ualink.info);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to query initial UALink config: %d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
+void amdgpu_ualink_fini(struct amdgpu_device *adev)
+{
+	/* empty */
+}
 
 /****************************************************************************
  * UALink info and configuration in sysfs
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 3882f29ccdae0..318e49ec0de4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -133,6 +133,7 @@ struct amdgpu_ualink_connection {
 };
 
 struct amdgpu_ualink_mgr {
+	u32 psp_if_ver;
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
@@ -166,6 +167,8 @@ struct amdgpu_ualink_mgr {
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
+int amdgpu_ualink_init(struct amdgpu_device *adev);
+void amdgpu_ualink_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index d5f945617f488..84cdb09f731e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -439,6 +439,9 @@ static int soc_v1_0_common_late_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
 
+	/* Depends on PSP being initialized */
+	amdgpu_ualink_init(adev);
+
 	return 0;
 }
 
@@ -472,6 +475,8 @@ static int soc_v1_0_common_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	amdgpu_ualink_fini(adev);
+
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
-- 
2.55.0

