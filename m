Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E96C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF2510EC9D;
	Tue, 14 Jul 2026 09:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0W3oQC5O";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD4610EC9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH9rYk3KCC8F7A0Ra3Izn2VKXQdL59oi5nlsWPOoySLNaQ1IFOzOuhJ6sfnHcqBexKKG3wV3F8j+upB2fffMkdWp3PawjXtF+HWDjdI6bh8dacWsT0V5fP3IyFTLjslZXZZvvar15LUuFw+p80sLOkfglgpMv4h6mCXbF5D0wBTttSi72mw5PMo9JyuEj9WWHI4c7uVdVILR5bV+2O4zZc29//F4akDkxPgm+G5KWJwwKtWISWqpnyTLPEtbCUDsLTIaLOcgAbqeO90SeiSZ81t29Afpsz+svecTC5D/GPOIOw6tRN4hcZjUybNnrQrujMN4w8DyfSisu3up8zF1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY9Y1fPzPqEhEQ394L0WH1Yvm9cBN1u3Lc6VHdwJors=;
 b=rIKMi8yUQiPMsuWRiDKgoNeGm0I1pEumNPQ7NjVSqKDDQQYzdDphvAfFgbHsrV5HaB8cKSbEOjvW/efGM3FRJDQuMdteOMAgE1M6W8iUoeqpko/306ITbz/Vtla6H97w15IiFBwg0sx8wIjbPXjeKOaYXNLBLe0tW5vttyADsNbGz5aWibzbd2Kewt8LeGoCE6+RBsqBi68rksByn2xmWlbskjHimpNzKhcNASpwYW6JxstOodOv6jgCQnqNhK2gIFHc8BV8OF3p9wDDWJQTWmg0mIPzv2S7ZUgb6/eo1X3HbKFnwphHcKwIHptBEOvaEeXFqlhqHs1juzn/JQA4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY9Y1fPzPqEhEQ394L0WH1Yvm9cBN1u3Lc6VHdwJors=;
 b=0W3oQC5OSu0ediHCNHAkwW58/ByNqNWkE5Xehennp0BZxSDz4QqS2Q/0JEOcb+y3llgxt8dTiJgBBOppK7F0IGHqlwlWZkVQaCPKmKebLCTUYiw3l2rJqJJ9JHkzH2aZXEh9181pLk2tldsnShK7sEDBgmhh1KloUp4mi5srYBQ=
Received: from PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::21)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 09:59:18 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::6e) by PH7P221CA0026.outlook.office365.com
 (2603:10b6:510:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 09:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 09:59:17 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 04:59:15 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: initialize CPER after XGMI reset on init
Date: Tue, 14 Jul 2026 17:58:32 +0800
Message-ID: <20260714095832.52308-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b06e05-d4d6-4228-1640-08dee18e9167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: azCfNTZhJDSByvuLPaEkonmE+Hs/Vp/F0RCO3nyAfNJijbA9zimGl3NWPdMhaIKtOw55n16PTU+fDBec141RAP9B/MoaCck59n83UZJe0s46F0CV+qHqlQYen3a2mlI92iJvDxMeQroGrqxg7b3FLbEFeLlCRbqtNAlfZpOEm/LaD/DTnz82wfewEslVyAnK6TEr7eyL7ERoOkzf2aKs6qcF4YMswethc91wRmyooc2ssSF+DrkUYWP2+7V06vPyvp01UWAqc87NvTFWgNDz+B1WcKl7jf171wnGEEAOjKnTH5hynDMD2AqHFa3sePDwwkdSNossvy00Yh4hgxT2Bam9M1ODPXVKV0/Ot1hfneTzfAird7bR1fXinpd9TK6lfHZUSqVYQuVuGoYYecdH+XQ2e5UuM1UX8cui+FvxsTzcUg7p7ejcrPgmVqY+qtxRIyGvFt+g5jVLIrnewN+oXQ0DwZhom8ePvZ+zbPJsqgfDGUIT9onAxy4EUskXmYqumQO1VfxSnDX1G+meVKiuSXbjteBeihI4YBTG8AC++UFeEgNHbvXnXjo7r2DKX/oJDH2RYhy0VDV4NRytz46sC022Q1qZkVz3vLn2F0c/QzsJdV7X5V8oCler7/0h2Ad3DskvyW8H2OPtgTlsM7t7etLTF7Xwy2QkO2zk9gdnQmC43fNrobC5YQZd19LH14J8NwCHAJ9UZH7AQXCdayx+zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: go1CGlI1wgl1qa4bvrTEPsOTYaPwMO3P4ypsSDGSBH+pcSxvFpQBDwifrmTDFq/1bg6pOk1rNLTLj2h9bII7s+hJ73rmHw+teTxVw8CKCxwrcKxDhtNIZCQQYLSkp4sP1ayTCJMboct+Tt/t/tQxM3RtimRmkgUk8+GIlkZLZEzQ9p8+noT1NwwwaVY4VoGWaGTFFvBBOTm0GUfb9Sc13CWU1GRod2xq2fBHAuwVMohaVigNxoKKPNYQNYRMCqZZH0zZ/VyvLVT/bk5/GtKfsrMQojIr3JcMaUMuEIP66/c38r7kIFG0s1z5cSzBfkeXI2p8s+RXyYu+dffJfUE7S2REWNtCtLHX4MuKqXajC12/aQY4+I1h6JfTOApgLseRYaPW69A66OFQgcaJAIVohaKWd5me9MbgQWetsvd+fe81ceO7nPWVX2tRZ0F6jCwN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:59:17.3365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b06e05-d4d6-4228-1640-08dee18e9167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

The XGMI reset-on-init path can run while the device is still at the
minimal init level, such as during an NPS memory partition switch. In
that flow the normal RAS IP block hw_init is skipped, so unified RAS
is not enabled when the early CPER initialization is attempted.

Resume RAS after the XGMI reset-on-init completes and retry CPER
initialization for devices that still do not have CPER enabled. This
lets the CPER ring come up once RAS is ready while keeping the path a
no-op for devices where CPER was already initialized.

CPER may now be initialized after the normal debugfs setup has already
walked the ring list, so register the CPER ring debugfs entry from the
retry path when debugfs is available. Track CPER ring debugfs
registration to avoid duplicate registration and clear that state when
CPER is torn down.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    | 15 +++++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 6fb129025761..7513541e6eff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -504,6 +504,7 @@ int amdgpu_cper_fini(struct amdgpu_device *adev)
 		return 0;
 
 	adev->cper.enabled = false;
+	adev->cper.ring_debugfs_registered = false;
 
 	amdgpu_ring_fini(&(adev->cper.ring_buf));
 	adev->cper.count = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index d12c98077d9d..76df176eab9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -51,6 +51,7 @@ enum amdgpu_cper_type {
 
 struct amdgpu_cper {
 	bool enabled;
+	bool ring_debugfs_registered;
 
 	atomic_t unique_id;
 	struct mutex cper_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3d1ede5f8de2..78130f8565c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2184,8 +2184,13 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 		if (!ring)
 			continue;
+		if (ring == &adev->cper.ring_buf &&
+		    adev->cper.ring_debugfs_registered)
+			continue;
 
 		amdgpu_debugfs_ring_init(adev, ring);
+		if (ring == &adev->cper.ring_buf)
+			adev->cper.ring_debugfs_registered = true;
 	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b265b68e0f37..4ec8e446d377 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1400,6 +1400,21 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 		 * initialized, and for non-uniras devices.
 		 */
 		amdgpu_ras_resume_after_reset(tmp_adev);
+
+		if (!tmp_adev->cper.enabled) {
+			r = amdgpu_cper_init(tmp_adev);
+			if (r)
+				dev_err(tmp_adev->dev, "failed to initialize CPER after XGMI reset-on-init\n");
+#if defined(CONFIG_DEBUG_FS)
+			else if (tmp_adev->cper.enabled &&
+				 !tmp_adev->cper.ring_debugfs_registered &&
+				 adev_to_drm(tmp_adev)->primary->debugfs_root) {
+				amdgpu_debugfs_ring_init(tmp_adev,
+							 &tmp_adev->cper.ring_buf);
+				tmp_adev->cper.ring_debugfs_registered = true;
+			}
+#endif
+		}
 	}
 }
 
-- 
2.34.1

