Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4AEC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CE010F6ED;
	Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnAhzFZ3";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DB010F6DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW11qmttRXqQdg+IRZzTDryuosXnL6nEXkBuZqMCsG61Xco8RZTHmfJfz7ikq3+BmS2qDh2Qhve6AMvmjpn5npAa7espvGReekRrD+V2sJ7c87YwiJbKUrThVM5THSik2jrtSx44ZrJRstSAzFgjANWdPJbsseli2YpMnnRpatdBWFuDGb/mhTYzsdNqxshAqQykJDalM+5OrAK7TBjc4d5M1qiNfAf4uKW0TQoMz/FJVllG783bTf3/9dCN4sOpIKb6QpPWMynadV21S861akl0at9jVHX7iQB4TMltRuyxd8qFrAFWLGSTpImUkmjJkoo//SPJFiaLCnfrdQGP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9RtF2J7airfL+Dj2t2WMmItkIX6Hlyo7TQFcw1it7M=;
 b=Jts4EhZpyA9Bbx7tE0hfvsRkUPPaCMR2Ga8RaNYT9lgud9HaZjOeYuyBgqALlrxKKSDWMvMhn2Mkw2hIBZpzSPiSAVnh6VLPtNtZoH4qOMObnuFZ92j/ziD2jAaO1njV2g+xenOYU/FsB1VoQZRp2VUQB2SyYscQCndNAETJnBQvi40tY131H5qMZYTwzCEyqnknT1Unnjrq349XFdaDWZl65Ut9VvlVIxhbe15gaSuoS6we15x+/MOZguKMsPKr56LF7sd+qbpNnWwwIraO8GHEM+kPlJp+mBVJ+0aMUK3KqvtI+nhRnlbmWJuiUGsli7QjNej65qHce1uRrq3NpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9RtF2J7airfL+Dj2t2WMmItkIX6Hlyo7TQFcw1it7M=;
 b=YnAhzFZ34EeXeJpOE9qWLxRs10lrMFHvVPHgxHgWRBxnK70V9rhhxv25GSzRPtR6n/mxEq+7XzZCG3ckVDnidtM8ok4BxQd0l+cTXdfSvDGqliT5aZU5spNm3QnwSBYMp9fwpRIqCNR8C/n/EX0n4MptarTUcT/PPzpisSmBLVw=
Received: from SA1P222CA0034.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::7)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:17 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::1a) by SA1P222CA0034.outlook.office365.com
 (2603:10b6:806:2d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 019/109] drm/amd/ras: Handling ras mce notification event
Date: Fri, 14 Aug 2026 17:01:16 -0400
Message-ID: <20260814210246.3067612-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: a17ac66c-a47f-4cfb-781b-08defa477685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mJ6dZr5sHtK/1ApGQ3eSoebXMXhKG2nK37lpzRRc90DrfPSeb09r7ahln9Iio0Uzhrg2/I5IiVo+hBdlJXNiWbqzKHVbwmH57NKTO83FpF356WLlY/u4J6oQQdZxXZ+ouV9uD/Ifig5AKIh9lkINJQqzluJY7ZQvP/cOhsXhpqQvpUtG/L7NGLpyT2ldoruRjT2lZy9Ke10eh3O/PX6iF547lyjTbncTjWNqQSuNW+8E8r6oKWQ5B6ac/HMvsDSa+WnOiFC6DrPXsTPRXa9CzfIwnhGjlH2KFQoa2p1HDS3akKWcdMCstxPyD1V3n9epBFAuyvwqw3CQMCEmYLOGbAdPc/UA4QOcRP1eG+u1wR3Zb7uD+7dXsCVrXh74hPeUyBRCFhvncftC8Nx5om/H8G8gC5l/id77kHH22wX8L3WqDXqcRM85S0mrNtaRofHhXOht+3nTXNbV1oxKncD4HRyE/qty+NOYg6NcZAwmoVMQkzhKmWEuPhV1s1B2l+9ssNXhMwVqLW3pPIOzQcrQcMfMX6ZQ49/wklowr8mzGDrvvb/paOheARMeFTii+c0dH49xDyKIrJsGrbcse/18woqW7Zuk8M0alfVMfWA6cNiPHn2JSG1gKek2Q23Iqz0JgWWJRzqUE/S+r2c180XDAumlSUW8jFYYas+jToU7eTjZPuAI0iMow2GGaqB+9K27w1XOnO9hzez/wDr2ITJHDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eThK2kysZ1REUyIu0OdraXWOTEQR4IG/4Xu6vbo3a+hmMCK5pZtyLxhM8DQhiXSa/R/A+KZnjDL4ghPnEx67exXpPli6LCOirq7DWHBgqH9ajdJH3WWTygnxB4fN0ERNzGPjsALVEsGvvyPm8zkl9/jqaMlkQSUcClWQ6qvkpGz1bLRSy+04/meCrl/H7TY/cPhefU1nXle5kPalRZJkndg/6MCCqeC4DhsEvGFpE7A9cbHLQRvrsAqf6O9XN1hwOymys5fbP7jME3drBLOVcllU9Ld+XyBvbc8OFIPTAQbQaFSwWWv5o74W2RYayEsywN47Nn+EsVXlctDeRF4C5elbem1qDLBxirUbEArdGstAZSHCtFHNE3W4aA+jcgjiYiYXmbYn3wAmr6v/GsW9uC+WQOX6gJgVRMmJg4L17bQs7Wz3iG1uV73aoh6fUty3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:17.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17ac66c-a47f-4cfb-781b-08defa477685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Handling ras mce notification event.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c            |   9 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c  | 103 ++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index be4af1522685b..e6110e02c38e9 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -390,7 +390,10 @@ static int aca_banks_update(struct ras_core_context *ras_core,
 	if (!count)
 		goto out;
 
-	batch_tag = ras_log_ring_create_batch_tag(ras_core);
+	/* Only one MCE error is logged for each batch */
+	if (ecc_type != RAS_ERR_TYPE__MCE)
+		batch_tag = ras_log_ring_create_batch_tag(ras_core);
+
 	for (i = 0; i < count; i++) {
 		memset(&bank, 0, sizeof(bank));
 		ret = aca_dump_bank(ras_core, ecc_type, i, &bank);
@@ -415,7 +418,9 @@ static int aca_banks_update(struct ras_core_context *ras_core,
 		if (ret)
 			break;
 	}
-	ras_log_ring_destroy_batch_tag(ras_core, batch_tag);
+
+	if (batch_tag)
+		ras_log_ring_destroy_batch_tag(ras_core, batch_tag);
 
 	if (!ret)
 		ras_core_event_notify(ras_core,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index 991cf39195eea..795085beb1986 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -124,9 +124,112 @@ static int amdgpu_ras_unregister_mce_notifier(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void __fill_mce_to_aca_bank(struct amdgpu_device *adev,
+	enum mce_bank_type bank_type, struct mce *m, struct aca_bank_reg *aca_bank)
+{
+	aca_bank->timestamp = m->time;
+	aca_bank->bank_type = bank_type;
+	aca_bank->ecc_type = RAS_ERR_TYPE__MCE;
+	aca_bank->regs[ACA_REG_IDX__STATUS] = m->status;
+	aca_bank->regs[ACA_REG_IDX__ADDR] = m->addr;
+	aca_bank->regs[ACA_REG_IDX__MISC0] = m->misc;
+	aca_bank->regs[ACA_REG_IDX__IPID] = m->ipid;
+	aca_bank->regs[ACA_REG_IDX__SYND] = m->synd;
+}
+
+static int amdgpu_ras_mce_notifier_v1(struct amdgpu_device *adev, unsigned int id, struct mce *m)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct aca_bank_reg aca_bank = {0};
+	struct aca_bank_ecc err = {0};
+
+	/*
+	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
+	 * and error occurred in DramECC (Extended error code = 0) then only
+	 * process the error, else bail out.
+	 */
+	#ifdef HAVE_SMCA_UMC_V2
+	if (!((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
+			(XEC(m->status, 0x3f) == 0x0)))
+		return 0;
+	#endif
+
+	if (!adev->smuio.funcs || !adev->smuio.funcs->get_socket_id)
+		return 0;
+
+	__fill_mce_to_aca_bank(adev, MCE_BANK_TYPE_GPU, m, &aca_bank);
+
+	if (ras_aca_parse_bank(ras_mgr->ras_core, &aca_bank, &err))
+		return -EINVAL;
+
+	/* GPU device only record bank data that matches its own socket id.*/
+	if (adev->smuio.funcs->get_socket_id(adev) != err.bank_info.socket_id)
+		return 0;
+
+	return ras_mce_add_aca_bank(ras_mgr->ras_core, &aca_bank);
+}
+
+static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev, unsigned int id, struct mce *m)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct aca_bank_reg aca_bank = {0};
+	struct aca_bank_ecc err = {0};
+	enum mce_bank_type bank_type;
+
+	if (!adev->smuio.funcs || !adev->smuio.funcs->get_socket_id) {
+		RAS_DEV_WARN(adev, "No interface to obtain current device socket ID!\n");
+		return 0;
+	}
+
+	if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_GPU, m->bank)) {
+		bank_type = MCE_BANK_TYPE_GPU;
+	/* For CPU bank, only the first registered gpu device needs to record bank */
+	} else if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_CPU, m->bank) &&
+			!id) {
+		bank_type = MCE_BANK_TYPE_CPU;
+	} else {
+		RAS_DEV_WARN(adev, "Unsupported mce bank: %u\n",  m->bank);
+		return 0;
+	}
+
+	__fill_mce_to_aca_bank(adev, bank_type, m, &aca_bank);
+
+	if (bank_type == MCE_BANK_TYPE_GPU) {
+
+		if (ras_aca_parse_bank(ras_mgr->ras_core, &aca_bank, &err))
+			return -EINVAL;
+
+		/* GPU device only record bank data that matches its own socket id.*/
+		if (adev->smuio.funcs->get_socket_id(adev) != err.bank_info.socket_id)
+			return 0;
+	}
+
+	return ras_mce_add_aca_bank(ras_mgr->ras_core, &aca_bank);
+}
+
 static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
 			unsigned int id, unsigned long val, void *data)
 {
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	u32 aca_ip_version = 0;
+
+	if (!data || !ras_mgr)
+		return 0;
+
+	if (ras_core_get_ip_version(ras_mgr->ras_core,
+				RAS_UNIT_ID_ACA, &aca_ip_version))
+		return 0;
+
+	switch (aca_ip_version) {
+	case IP_VERSION(1, 0, 0):
+		return amdgpu_ras_mce_notifier_v1(adev, id, data);
+	case IP_VERSION(5, 0, 0):
+		return amdgpu_ras_mce_notifier_v5(adev, id, data);
+	default:
+		RAS_DEV_WARN(adev, "Invalid aca ip version:0x%x\n", aca_ip_version);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.55.0

