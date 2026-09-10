Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76761C79FB7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 02:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB96B10E595;
	Thu, 10 Sep 2026 02:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L+ggCurJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9925510E22D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 02:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNH0Huf9T9A6dHl/G0wV6b91McQYPOaefYNM0f44SsQgwLjvBiSXHFnWwytR6JTQZMu+DzHmMXAbRn0WCCtfpWxBjukNok8ncMnQc4of7dKoC8cCwNVUkJyMFqPYhCp3+/67eGpd/H4JPPHsdPY+NBoFnwh/0o9L6YNmQmE10lC6hwyOxlxIMijAv4BfSDU4v3YoRnaiqCQQu5vlKoUOQ2/Omz0OwND87aHa8BcusLFY5NdDtsEJTQd9k7Beqbwho1s7j97Hsq5qV/I5p+ie6oDev3c22RDdXYQCosB8xQtSFxjwAn3cvqiZiTLt1VmhsHvi6st1T9dV/QOjFLkjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CrNiW0laYW13DUGxok02GRIDSvwGrpsyHJCEx+Jk2M=;
 b=UOgY4efHxSysAeuv4wCDwMQC4NVaHANtEZyiuV4b9OHBOOTnV10s1nsaJDg+4Lth5ASfxb0b+XJY+OYgRq1T0trvv48ov4Kb0E0QjxkrrmSdT8oSB2bwaIlFRTa5trHdppjsgkeiTeNV3IdgeBDxJw3PsxZtXCQzzmP3jcV7mAXjK3P1/LY4Q6OOfIHALXX7yZtDeJCwwybuxT+qXZRYaFwMBXjQoqqpZbtUfv5ca79nfPpqy5GafPT7TQlUUMGQ73LhjZD3D8pdgVW8AYJ+KE0OcQvE++cFWfwsg7VyCSVV4w8GgFfpL/oMN0u4RCwXBszO3PI8C73dxoR0l/I81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CrNiW0laYW13DUGxok02GRIDSvwGrpsyHJCEx+Jk2M=;
 b=L+ggCurJcSfhTpGrPeMh2+MJnMVbJOYolUti8cwzSDFLs/e3Wg2X92082DSZhh5GP7PoDD1vvpAl/8wq8ZxsI6bDiYRIAS1YtpgyOsoanFJl9/bUjy51DpkUmmfJbnIFuSk+jVBQwUhTEUx8tHMDzgsXmcXmccvRVr0NiMyMtHY=
Received: from SJ0PR13CA0207.namprd13.prod.outlook.com (2603:10b6:a03:2c3::32)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 02:04:31 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::48) by SJ0PR13CA0207.outlook.office365.com
 (2603:10b6:a03:2c3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Thu, 10
 Sep 2026 02:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 02:04:30 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 21:04:28 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: apply the MCA debug mode where RAS comes up
Date: Thu, 10 Sep 2026 10:03:58 +0800
Message-ID: <20260910020358.1541432-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8ec0cf-1f57-4a00-982d-08df0edfd9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|5023799004|10067099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LP/ULvN2Rh4DtlL868FcRZKzbbYeTqm54GP/fyGzefY+gDX0C7H0rOk9AHfoJw4Ahn/7JLa6sa8VEdptFRmN9T4wjKjvtfgRF45xuEIP0KGROPBEHV8HIuyAYA8XPHx7061epi5mjwecSdEo2mrxP6Ip2RA1cmTrj2KgMYRPqxM9ViJ9B4m+0kOxWYiime2xqvDi2xyNgIzhd/p9nRiRvnLaahwiGt6h/YARnNi3i2AFqlWfHZEKkX+ZSaaV4+dzLpfHwmGdnuzaT5X3LT67q7axoA/TvhwY5GvK+/ukZRnrpTFhdFAgnXk42hlcx4nn9HhVAjXjWaPxXQOXJwxOpfn/jARKrvFqqfqRxZxFDk8FeS+MwFiYydidwQQFC4tHhnr2pDqe8j4hiuBD519Lg2tCiongLzAELUtaocxgyHtqx7skEGQkArr1kpa68GHOvWNEUo/ZmVwrM++LMR5+MHrYT+0LdZ3pJN/ek2ZGi+Cu1fOROX2konUb4f5Q7FUN3+t+vYEyYm+HNIC/vxy06sE3VXUIEyMwlTBTKAxSGcfL20zXTX8lQU0HFZTcd2v31iHQM12cqsDTwOLStdmSBEkbQcaHureAJ3OCZyQ3Z4hrDbFXvzYB5TEpY5m0wfpAB0oP7cIjc6FKtqsxjjj60osQENP3lswW+fzl56rAy+APUMukJUytj2u0s18GB4HjdfPZUwulKwKeZCRyBZsg7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q4HskepfzTOCZecrZWvag0Lkb/6RFBndBMzZX+Koc1qopft79kBbu/iq6707rMGrk0AmHiF5slyZ3fdeZX5q6utE6IwWXq/RIBCkMLWlVaw5PPN2sf9HRCP3AIGbcPctOz48myFZd5sPxG8WtcXL+WTeej7jsq15XRSnDSpwUkS5VHqVTn0F05TVskuElUc0k/N7nU/OMSqQMhp/QrdkSDnlt4bafujyRms237rpeeF25KXsgT5Igd/s6a88mo4UifxlMk7N+kVyvmLQvdQQN55rIrsHWm6NyCSftO1T2Dvx7ExixHkPOwp69vP+ucKbZsFXjf2O1m9ilXvM/4SkT6s/WYLYVY+todrtBxdxCXtkjUDLC0JwxPU79ZPq8EI3Bw+G6rNubyF0pFbr0YJ5ht4ekq+TBSoKYGfM/yFFTc0CB1tcBIcvm/USJFnIhY5o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 02:04:30.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8ec0cf-1f57-4a00-982d-08df0edfd9c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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

amdgpu_ras_late_init() sends the MCA configuration to PMFW, but it runs
before RAS is ready on a device that still needs a hive reset, so the
request is dropped and CE polling stays disabled. A reset loses the
setting too, since PMFW is reloaded and nothing programs it again.

Apply it from amdgpu_ras_mgr_hw_init(), which covers modprobe and the
deferred bring up, and from amdgpu_ras_resume(), which covers GPU reset
and resume from suspend. Drop it from amdgpu_ras_late_init().

The control is absent on some parts, so its result must not fail hw_init.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 7 ++++---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index becad704113c..9ba48eef1349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3897,6 +3897,7 @@ static void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	struct ras_manager *obj, *tmp;
 
 	if (!adev->ras_enabled || !con) {
@@ -3906,6 +3907,9 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 		return;
 	}
 
+	if (ras_mgr)
+		amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
+
 	if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS) {
 		/* Set up all other IPs which are not implemented. There is a
 		 * tricky thing that IP's actual ras error type should be
@@ -3966,9 +3970,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
 		return 0;
 
-	if (amdgpu_uniras_enabled(adev))
-		amdgpu_ras_mgr_set_debug_mode(adev, false);
-
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
 		if (!obj) {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..a10d8991d131 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -448,6 +448,9 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 
 	ras_mgr->ras_is_ready = true;
 
+	/* the control is absent on some parts, so it must not fail hw_init */
+	amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
+
 	amdgpu_enable_uniras(adev, true);
 
 	RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
-- 
2.34.1

