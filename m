Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DBBC61DB4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F82A10E863;
	Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LkiWLWR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C2810E5AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmnvmvyzWRSAqneZK99C6UC2fSfWgkf3fxun5xDc8XZNEGFcx4L0F93QxngIiKSUKkB/zpJmpBpC1XD9USyn6eeqhfvlpNuVlnw/ME/SlOMUQIW4MSbBNywKlohmlERTgKfj4AbKLr3PbjGnJayA05ocF6S9B9BQkzoLR8c+KVi9+EzWzlEc+dcEt9oo3wFoVyuFgsKFnVmb611K7NEff6H6gXhlHVTkOnW3RQmC3LLGJnkv7FzKkU9jEDvZvp/ss+grtHAJTqhSfUVToW8XT5XkVEguD7HxvB5B488YvZ2xJIiKFiy6TiEZlbRj5Y92vFNxtwoHlGSaOKxiWBkR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNtQuHq8dFwbGF4wxtkGT33hkg9HYxUIo7MZ42e0214=;
 b=wovinb07t+4lzYG/D90VJ0Ac7lRQhM/pu3cHcqol1ck5NzFp553qNeUzo0xkbNHiVBDtXkFMZR4G6kBgq8z/Go4AR20Gr19UY2ckVg58L2e7ENhoOreXvDqIjXPK1VSs9TrD+85Ew//agNQREDoF8a9Fi0ZFNikuZ5az9Dfbjaq0b0mtjrO2Hp8Gz5Q6fHHwsbsjXVr/zy5mcLFOWF3s2Rt7bObnOahAuNw5qCSLged7R3ZEIsWPywiBgb5iKLGUDE2zV77azfB/Tsqyw8ZAuCz0Ln0c/DQepVTeRRz6CVsSrsd2WtNL1/DsJSqyCBgQ2f/9LqqXJmXBHl0v0PVyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNtQuHq8dFwbGF4wxtkGT33hkg9HYxUIo7MZ42e0214=;
 b=0LkiWLWRlvXREDaKhDbi48HUfEzT5v4hKjfHOEoB5YB6HwhNqef72pRfDLtTG0Gf5Gww98nmWKYZBvS1KtBb80jRrRKQJ0LMB2KyI2rNEZjtezE01+ixbnOxRbQv2Z6TTfiMlxjJCYS5xeHaF2fKRtViTmt+uMsJBFnZjhE/GsE=
Received: from DS1PR03CA0024.namprd03.prod.outlook.com (2603:10b6:8:233::19)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 22:14:11 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::3a) by DS1PR03CA0024.outlook.office365.com
 (2603:10b6:8:233::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/30] drm/amdgpu/sdma5.0: add tlb invalidation buffer func
 callback
Date: Mon, 24 Aug 2026 18:13:33 -0400
Message-ID: <20260824221352.1793542-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: ed96aa2a-701a-409f-aabb-08df022d0681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dyADsPld3esmJ7/ZoR0uqulk/GZTW+Do+0cu6WzQ6W/Z9e4PapH3qZlpvqzwQXDA05DdcDxBmjR63lSgouL/WDZIDVI+0nKakWo/rX9FqMVtVBbnG/bz15radLfaHhP+zHI6H76IVhRTAPdlBxL4av9r/AlGgTJe3bDO3qo0Zwntnq/uIBabeeRR+ed6S6hSmOAlPCuR2ZvlKp9+yEalxwNVWY9XRVLum55OMdq414r61LNIcIMQ3lh383oqPxR/+uqCvOQ3R0tV8GvRVFLjPDKoCPXZIZr3MnbqxjIs5jxgLaP5zMBUVAgilGwo20cNO8WSFF/hnzK/7XfpXBCbu9MxIgtkjJR8PMCmKvMXvSkdKPwuAvfvlpW/pNSAF5TRERqCYKGPyEO8cZvbdHUkH2JK00U+Au/XIo8Vh3uSQJFDbFFbMsByFAJAISGP1N6/jusEZBDZJiDfpvQArWIbG8glXTx2ngfY4/z/lY+I0W/8x+BCdT1ewa5UCCmn3wBoGXdROAz3ktrjPMEhqTsQ8PT3TVD5wFdk1fuqc34nIXd2KbsdOXV5+uQQjMqo4HHhnaIjdx9J/pYE/03PMlfWQ6BHWCypTRFn5z4An59BMAwLnxK1xr+l/uSovjD8sKXjqo0LdxNiaBGQBQvxx7ZY9DSHTYPCK4Ugd93smUHC33lsztwmYDBb0qDYBvzZNNkJcBrtLdZ0HzK1YLO8Cgbmcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DGXi1kkYuTEQYVfW+WM7AeZBrG/49GLJYokIvjbsxNvVLDqXHubBq2Pv2u8oIxRH5qqnEqCrftkEOZEZmcez7hQwaU/y+MqPOShqpvcTXBy1OGmD6P3Vf71v+I3AnpgPdZodyp9HEHs53fHSU3GfRrIsc9UEiRhNaPZikcJpH+SNIE8njamB+Dlk2ZeHNhQtSJt9Jz4KLmGqs2m2cu8WNq7oikCxnNWENz7paQxrT0dDyf6sq1nSg+KPDlkfE4TwGtJJ5GSdhCp01oUliRV9zT7aSzu3MM5dTrZNi5IPHTHV0oLWkTGx5QDBtZLEyl7PgpmPNOaSaZeRyA5rYUosibH2uBah/JfQC7+eNj+j18T2UQ7uZt485hL1C9lF1rY83Yyqou3surXqRUM+dc52XnADJq44Z97XCrmGrXsfV/ZxiRFcgTR7O9k9nfdFB3Ik
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:11.5192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96aa2a-701a-409f-aabb-08df022d0681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

Will be used for TLB invalidation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97fee70dc2f64..8cb579ecf522e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -2030,6 +2030,52 @@ static void sdma_v5_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
+ *
+ * @adev: amdgpu device structure
+ * @ib: indirect buffer to fill
+ * @vmid: vmid to target
+ * @vmhub: vmhub to target
+ * @eng: invalidation engine to use
+ * @flush_type: type of flush (lightweight, heavyweight)
+ * @xcc_inst: XCC to target
+ *
+ * Invalidate TLB using the DMA engine.
+ */
+static void sdma_v5_0_emit_tlb_inv(struct amdgpu_device *adev,
+				   struct amdgpu_ib *ib,
+				   unsigned int vmid,
+				   u32 vmhub,
+				   u32 eng,
+				   u32 flush_type,
+				   u32 xcc_inst)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 mmhub_eng, gfxhub_eng;
+
+	if (AMDGPU_IS_GFXHUB(vmhub)) {
+		mmhub_eng = 0x1f;
+		gfxhub_eng = eng;
+	} else {
+		mmhub_eng = eng;
+		gfxhub_eng = 0x1f;
+	}
+
+	/* Trigger invalidation. */
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(gfxhub_eng) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(mmhub_eng));
+	ib->ptr[ib->length_dw++] = inv_req;
+	ib->ptr[ib->length_dw++] = 0xFFFFFFFF;
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+		 SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
 static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.copy_max_bytes = 0x400000,
 	.copy_num_dw = 7,
@@ -2038,6 +2084,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.fill_max_bytes = 0x400000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_0_emit_tlb_inv,
 };
 
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

