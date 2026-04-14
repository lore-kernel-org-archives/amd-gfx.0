Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E565F531E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 01:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5F610E03A;
	Tue, 14 Apr 2026 01:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XeWEs275";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D85E10E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 01:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx4p+85oWzVd7+CySKTGDsDE34iodoEkXgOvLATD1KdK2AROl1ZJ1gZr75fusBK0I8TtMKTBVdKT0ib4161pjS6EPrh0Q72n0/OueysVAh4BvkH1ygkMalTEYP73iUl7NR46l9tzPJMDJODM3zHsMVl1KbOvz3USQbvHiipCCv1UEgAcwCHFPSqQp2izzt0PreX7zx8LO92trKFGIHHWmX2QiAzx3V7HwdVNxWF4z/uRm2XyMCgocD9AwOX8aiwBgMAwG4eVygmW3htAR5ZunAoKsjFL+wFDOAWVDLzbMYb9mc6ogony8QPgW1Iid8B3CgnUpGkbfgXjtwyY+Cdv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXXjY8RTlWo1nc/UCW3HC7fKsdyRuV60YR25aH6tOCQ=;
 b=so38dqyDMEVGtL9oJlmrc2yKrsRDxhFY3DwcujKfY7o4LjdfWCqnpAPiWDS9ZK3yaxVrGVHj8bpXPTOdNkBaZvnMPBdM/jrrNmp/JJuAKUxB7y0dbZkxe5yNSDqWmR+pciy3n23UthoiFe0TWfMHrq1qWJmLzbna+BaYY8nzaQCLY3BqKdU9ycFnrf/3nMvWieuIfJnQpYJMPw0GdFby9bUfU9rhcatpYs4ST3RDJNO0yJs34h4pojHRmCHmXXJuR6W/7rTafaYrPGTZu1rJhEd6OxL//uKK/pnzb/v/Bx/+/doIZyP62ChJrh6UymJn4ENxHFfz5tjnEwGKsYXc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXXjY8RTlWo1nc/UCW3HC7fKsdyRuV60YR25aH6tOCQ=;
 b=XeWEs275wpMluXXq1atEb5ocE8wOF5TQQQr//bW+QNSjmms0Ar1JokuBjCghVceTfiFbNGCF8mXIZtY+2RlDLgAMIt6mhh08Hjqlhpg63soJ88r4coYd7YGD5faQzZaLyWOJaiVkyxzUQppxxYYpsSGtJpCjGOewDGOatJ+ECKA=
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 01:32:21 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::3a) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 01:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 01:32:20 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 20:32:18 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Rename CPER Fatal severity macro
Date: Tue, 14 Apr 2026 09:31:50 +0800
Message-ID: <20260414013150.3158534-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2776bd5b-650e-41f2-77af-08de99c5abff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: r3N+KcA0iVhATm3iTYh8hgNyG9OpNFDvRnr2P2sTfSX8wqDvc73q/99ml56tQTb7qlhMk6fbQKy0bGCpTmIwAot1T5FU51Xmkk/IkYKJGDEkOpBCpEa60pBDZRtKktq9TAY9bb6FTEX2Lquh7QKtZ5cbdBlZGOXlTrVHo57Jg2K5tqrkV2G78OI12eEFvMmawxcFlH6Huf0bUD6hEGYU0ayuH7dafRhI9oeoSs0HHu5AmgixR2PbTZsrxZz/kM412l8Mzj/1GjUCul9kiJoORIRBKsfO7PblVDvLmxOPjuAXQL117bzYyQ9x7xBoqhSl+fBqxNPVVYxlQYOCN0LTVTNEmpd4sUibfHe2A85bhpOsxx9wyHhJnIXIh8Wod7IRjwI39t/Dqv6+gUPlFbooqvSnprO9op6IahoJqrbqHsQYWZPhWPAY94lYCJT0MGsL1n4Auw9wS75o7rYyMV3JWZKNnD51z28lxt9AW52kZh1dpwLbJyUT+u3vmJoAqlis/tZD5GOUVIdZyDrHKAZcbPNDJpNM3oX4ZKCzSiYlxIgDa5/cVm6BI9qx+l6Z8pK/nd5u6O/oVrujQ7LBynFDI+IJsJOVE//TgRfKdLwQM50RfXTbEVTjmHEdDSRxRj345uHLj+P/qA0NGysjJGcHCxdF+P974yaepAmUqJrdgAOQEtIUOzSWP/b0MSYMIb3r45mfEFagJuxHtY7vQfFYHZqDiYA48HdHhPh+ZFaxwnivv8J5EkUOwaYOMi8+U8F1b+C6cU97zp3uNa2VslWTYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PoXjyBQgze3UHA/QhtJIbxGkD7489lO+CqNruWYPd8JQfCb0mgJW1BlOUAOreC8vfIxgVh6MSk41pcKKleM4a1zKGWz0GEBD/LskO1eCP9K51Huoqf3Wm+EWLzKeuVJPD1bZgRGGD33VNjTEhyUEPIVJrJDkrB/+qXDmyoaSYFVjEvYMQ9y9qXYTdPuuIzCDt3BV+Q2/96ZO0/VvDWtNudtTeiCLpzLJSkkJzp5Q6HcXElLA2mQk4YqQaymhsvV2FNbkizW3Fj21BSSDUFSxR6+HMQWnug7pIZD957bLr3u0rW6p4ThzAY/Q8xi+XtPILC7UjPaSuMeKPEiBaGRX0Q7FvSt2l6002pK7qrw5I5hEPNvdh6tj/xrYtGvUpt9LulGe+bhyL3s6WoPjgloXoD27512VzpRCUwv4eqpQ/x5S0HQL0Lg2SR6LY7w1F92f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 01:32:20.5349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2776bd5b-650e-41f2-77af-08de99c5abff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
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

Rename CPER severity macro to avoid conflicting with UEFI definition.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 12 ++++++------
 drivers/gpu/drm/amd/include/amd_cper.h   |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index c72c345334d0..0b83b61e12f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -151,7 +151,7 @@ int amdgpu_cper_entry_fill_fatal_section(struct amdgpu_device *adev,
 		   FATAL_SEC_OFFSET(hdr->sec_cnt, idx));
 
 	amdgpu_cper_entry_fill_section_desc(adev, section_desc, false, false,
-					    CPER_SEV_FATAL, CRASHDUMP, FATAL_SEC_LEN,
+					    CPER_SEV_FATAL_UNCORRECTED, CRASHDUMP, FATAL_SEC_LEN,
 					    FATAL_SEC_OFFSET(hdr->sec_cnt, idx));
 
 	section->body.reg_ctx_type = CPER_CTX_TYPE_CRASH;
@@ -213,7 +213,7 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 		   NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
 
 	amdgpu_cper_entry_fill_section_desc(adev, section_desc, true, false,
-					    CPER_SEV_FATAL, RUNTIME, NONSTD_SEC_LEN,
+					    CPER_SEV_FATAL_UNCORRECTED, RUNTIME, NONSTD_SEC_LEN,
 					    NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
 
 	section->hdr.valid_bits.err_info_cnt = 1;
@@ -310,7 +310,7 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 	reg_data.synd_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_SYND]);
 	reg_data.synd_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_SYND]);
 
-	amdgpu_cper_entry_fill_hdr(adev, fatal, AMDGPU_CPER_TYPE_FATAL, CPER_SEV_FATAL);
+	amdgpu_cper_entry_fill_hdr(adev, fatal, AMDGPU_CPER_TYPE_FATAL, CPER_SEV_FATAL_UNCORRECTED);
 	ret = amdgpu_cper_entry_fill_fatal_section(adev, fatal, 0, reg_data);
 	if (ret)
 		return ret;
@@ -335,7 +335,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
 
 	amdgpu_cper_entry_fill_hdr(adev, bp_threshold,
 				   AMDGPU_CPER_TYPE_BP_THRESHOLD,
-				   CPER_SEV_FATAL);
+				   CPER_SEV_FATAL_UNCORRECTED);
 	ret = amdgpu_cper_entry_fill_bad_page_threshold_section(adev, bp_threshold, 0);
 	if (ret)
 		return ret;
@@ -351,14 +351,14 @@ static enum cper_error_severity amdgpu_aca_err_type_to_cper_sev(struct amdgpu_de
 {
 	switch (aca_err_type) {
 	case ACA_ERROR_TYPE_UE:
-		return CPER_SEV_FATAL;
+		return CPER_SEV_FATAL_UNCORRECTED;
 	case ACA_ERROR_TYPE_CE:
 		return CPER_SEV_NON_FATAL_CORRECTED;
 	case ACA_ERROR_TYPE_DEFERRED:
 		return CPER_SEV_NON_FATAL_UNCORRECTED;
 	default:
 		dev_err(adev->dev, "Unknown ACA error type!\n");
-		return CPER_SEV_FATAL;
+		return CPER_SEV_FATAL_UNCORRECTED;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/include/amd_cper.h b/drivers/gpu/drm/amd/include/amd_cper.h
index a252ee4c7874..baa0f30b9c4d 100644
--- a/drivers/gpu/drm/amd/include/amd_cper.h
+++ b/drivers/gpu/drm/amd/include/amd_cper.h
@@ -58,7 +58,7 @@
 
 enum cper_error_severity {
 	CPER_SEV_NON_FATAL_UNCORRECTED = 0,
-	CPER_SEV_FATAL                 = 1,
+	CPER_SEV_FATAL_UNCORRECTED     = 1,
 	CPER_SEV_NON_FATAL_CORRECTED   = 2,
 	CPER_SEV_NUM                   = 3,
 
-- 
2.34.1

