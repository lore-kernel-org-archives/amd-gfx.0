Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473A2ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E37010EB6E;
	Thu, 15 Sep 2022 17:01:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E59E10E21F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwSZKRWdVvTZ/ExwOyE56VD2j5Ww4sdciO41jrFgbe7W9rOynXWu8nHI+GjLHVlUeeRYHHblFZnoKvoTUIH3KmiBiiECGtji8RuSlwF+sW+iFsSRq2AIkvHbGLTlYMDMjYTDiU1Vx+ScKJH2sx/HbUm38IN4SoSOvQBJxea3WOnm0qcU2VjH/RClIEwcPZ14bgS4FVIop3VP1niMpaEnjKyNiWKVWSB6IzoE4hZDeLCpg0NzIP33Vwds/5CVmxExW9fKtoUmefqe6A0aQCJ/Co9kdREyTVJxJOagKlS/7yiCJqR+VzIYy8cW54XMFKp66Jd08Z2rIpjpo2zDW95bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Wvj67xJJ20kCHRYegySusEibOy4X1Q8xMBKFG828Jc=;
 b=DFxcRJYHXtRn2xj3qvpRw3w9mjY+6wc74b3RsdlhjzJ3Nwk9ve7sxxsBTb0gUSG6AmKFlDtg8Ep3zY5iGcjGoRR6A0GUoGYFGR8JVB1eEK+99hw/Wba774M1QQg8SP/iPnBE6CcAyJyad3YQ2ucpiZuPRhOmrGwcWh2lQRNm82zT3xpNLUyyvMwoix82K8AC4aK0D6YD2xcsO0CB2+zgx0dGoxrTk9h/p9ow94h30CaErUZe3HYZsDRco8DbvaCSdH8/2mE83PMeDer598rk3+DXAeLtmu1deHXaQ+wZMur2keUHrcnKj30fPWjwf4y1KsBqpHyxwj1MNhzUc9fs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Wvj67xJJ20kCHRYegySusEibOy4X1Q8xMBKFG828Jc=;
 b=J2wOWL6jOrq+YrkK5mSKuMECFLPBAVQCO0/9mJF/bWPpd21rnuRdnGg9AnB1EZOK3p4WSsGimVtucIHWofP0k1/xBtmyvRT2FNpZH8d6uNZZTVtSiarxEtScUFzin7Wyfo4/LShjWZkZNs3GwU/RvO1tu7zdulL3S2EugQmNk5U=
Received: from DS7PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:3b5::30)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 17:00:57 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::c0) by DS7PR03CA0055.outlook.office365.com
 (2603:10b6:5:3b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 15 Sep 2022 17:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:00:56 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:00:44 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: save rlcv/rlcp ucode version in amdgpu_gfx
Date: Fri, 16 Sep 2022 01:00:24 +0800
Message-ID: <20220915170027.23010-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170027.23010-1-Hawking.Zhang@amd.com>
References: <20220915170027.23010-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: b6180ae7-c49b-417e-07c9-08da973bdb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxBJjxZB5cYRGCU/UsU4dYtp3xmCOYkC+WAf7gfkxPs1H2coDkxlVBEBoSVcGpyN782E8pLjR4uLu/ihAmBy3rgj9AVDtUOZ3Cw4fhsxLh/fdoRuaStkxWaRTr4aJQCBDcIxegkQYLJxTsHB9uCfO+istb8tomjszS3WZOgJ3pf8AYtkrX5af4OoV5lrQihyHGqycOIlVfWyC3ZU4Tt/YUhd+laEj4gvsfjd6g//hYVkWPLvjdH7usIPG2qrjar28w0IhHpQndSvrhzI3liLFOPTZHCwe1PbJafoOJ5wGazWYYudRYSOjkxHqx/mz6HrXA/C76NLXfKfLVbYQiYHtLRBrOrBCxaUcBLXjdXHo9uze9LF9zTMeebVztIJvoZF35KVW8Lbz6f900UxkDjJOuwigz/9AiysXuy8xw3NEI6i4zXQWJpVJ8GeRiSbHRbFU/GwUID3sOEO9sfT4J2ZSnXFi3IWUAlpB1QkeceJcPq9zo8zsqEO/ylDZWTbciKlJOnd5XWQxeGU6B2y4NEc8SXH55VIV+rLQ4UkTPMqX1DbS8a2dIiERYLjNAMRbizGG2pflqzBw7CXVRDlz1CT/+XeC5z8+u2/FmfQmcJus8UM0S4pvUltlAKNWPs77o6aKb0haasDwktougmEvnm2dR6yTd2Pg5mvYK2pM8QJ84Na5r2whE58tjwVbtFVEtkRy3AdAsZD56U5VmJrv5EfplkJCQTKn/gWyf74W75+/reNW6pEytiLKoSOwLfNJqz6fLr5yWJpYX2cUOOBZNIQZkQzgdGbd4YfwqCr3YqI8WEj4/siE5pwfJAgYO3PIgzA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(426003)(186003)(8676002)(478600001)(5660300002)(1076003)(40480700001)(7696005)(82740400003)(82310400005)(70206006)(356005)(40460700003)(8936002)(336012)(36860700001)(16526019)(47076005)(81166007)(41300700001)(86362001)(316002)(70586007)(2906002)(2616005)(110136005)(4326008)(26005)(6666004)(36756003)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:00:56.0326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6180ae7-c49b-417e-07c9-08da973bdb28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cache rlcv/rlcvp ucode version info in amdgpu_gfx
structure

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 027e993ff45a..d60888f35d1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -314,6 +314,10 @@ struct amdgpu_gfx {
 	uint32_t			rlc_srlg_feature_version;
 	uint32_t			rlc_srls_fw_version;
 	uint32_t			rlc_srls_feature_version;
+	uint32_t			rlcp_ucode_version;
+	uint32_t			rlcp_ucode_feature_version;
+	uint32_t			rlcv_ucode_version;
+	uint32_t			rlcv_ucode_feature_version;
 	uint32_t			mec_feature_version;
 	uint32_t			mec2_feature_version;
 	bool				mec_fw_write_wait;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 96b6cf4c4d54..59edf32f775e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -260,8 +260,12 @@ struct rlc_firmware_header_v2_2 {
 /* version_major=2, version_minor=3 */
 struct rlc_firmware_header_v2_3 {
     struct rlc_firmware_header_v2_2 v2_2;
+    uint32_t rlcp_ucode_version;
+    uint32_t rlcp_ucode_feature_version;
     uint32_t rlcp_ucode_size_bytes;
     uint32_t rlcp_ucode_offset_bytes;
+    uint32_t rlcv_ucode_version;
+    uint32_t rlcv_ucode_feature_version;
     uint32_t rlcv_ucode_size_bytes;
     uint32_t rlcv_ucode_offset_bytes;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fa718318568e..ce8c792cef1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -475,8 +475,13 @@ static void gfx_v11_0_init_rlcp_rlcv_microcode(struct amdgpu_device *adev)
 	const struct rlc_firmware_header_v2_3 *rlc_hdr;
 
 	rlc_hdr = (const struct rlc_firmware_header_v2_3 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlcp_ucode_version = le32_to_cpu(rlc_hdr->rlcp_ucode_version);
+	adev->gfx.rlcp_ucode_feature_version = le32_to_cpu(rlc_hdr->rlcp_ucode_feature_version);
 	adev->gfx.rlc.rlcp_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlcp_ucode_size_bytes);
 	adev->gfx.rlc.rlcp_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlcp_ucode_offset_bytes);
+
+	adev->gfx.rlcv_ucode_version = le32_to_cpu(rlc_hdr->rlcv_ucode_version);
+	adev->gfx.rlcv_ucode_feature_version = le32_to_cpu(rlc_hdr->rlcv_ucode_feature_version);
 	adev->gfx.rlc.rlcv_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlcv_ucode_size_bytes);
 	adev->gfx.rlc.rlcv_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlcv_ucode_offset_bytes);
 }
-- 
2.17.1

