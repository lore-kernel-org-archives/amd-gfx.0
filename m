Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C954AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACEE61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9ACEE61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA2A6EAD4;
	Tue, 21 Sep 2021 18:08:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258216EABC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZfkmig8W4a9OvWpbt2GZXXg6oa2RAWaNGCIVfI/Nmxqh+72lWxweNE3xKuSv/zTi6SKNaw1++kjeJ/q1WrkISVJnlIIJnZITcHaFyQqDO/JyaUahy/+CixoT7JulXLXOEVF9VOphLmvLG3nV0ZuRuWsqTE6NuVJWvTKxKs5GBZOo9DMxHWYva9BbGg3qQaKJBGZwMFq0plJXR/H6/o4GOIaQT6pdnRF+g64/trQweEFGxPs28NCZhN+LPUJERT7td+CZ/gJNHSngAIfRo2QKvCJyGwQftLntxH4Mv4v0Ofj4EvZm+7O4STNAVNzBWnGddzJG1U5NoEAK8AqXqv0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kASduQ/GegO8L9IfpW9CO7xSzTNQMqE/DsY85HJDut4=;
 b=gICnGrgrEOJE4Wj+iAXSJVdD35oCqzkHwNwe/gF23LHqefy4xOU1Bvx9hkL8AdtqlHKKDpltSRSqVevlCIifdXKgrua6r/gDnIxzWA3NcP1hR6H+1o/VJgt8o7iA9ZSig2MOhtLcaN3/dfAvEN3eFzFoI4rsnBVPau7DxkVJRU7wCpe+tf0JGsr9HMlg8a+qfK3YC72s8OnxvSQM+zDy1ZWsgG3Dqgmv4twKcEarAL4aG9c7UasObHQSdPq7isuPjfCMOdN9jrnzoPuWzfKuroghGm0aeNGyogLdhx0CuICba2K7/ZzmgoXeP5K0Bn6z3YWL8OYDegBrvWmDrz81kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kASduQ/GegO8L9IfpW9CO7xSzTNQMqE/DsY85HJDut4=;
 b=mvbeFnXWfzRhQlVzSQa/CuatMtT8OhB7VLdB9j1E1HIRTmKquSSttdM+yr6WZjhOOBMNNTZNhajnVzEx9CmU1JbrIlx7tH3y4MMzoOBL1D7aM2lojJhnrD5ugI9DZ+xK37+P/1DLF9ktOdR3WDFKGHtXpQv5Yv5uTFQQdLL1Lk0=
Received: from DM3PR14CA0132.namprd14.prod.outlook.com (2603:10b6:0:53::16) by
 MWHPR1201MB2478.namprd12.prod.outlook.com (2603:10b6:300:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:08:09 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::5d) by DM3PR14CA0132.outlook.office365.com
 (2603:10b6:0:53::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 63/66] drm/amdgpu: add support for SRIOV in IP discovery path
Date: Tue, 21 Sep 2021 14:07:22 -0400
Message-ID: <20210921180725.1985552-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad19ca3-c66d-4146-1ad0-08d97d2ac4de
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2478292949436917B8508612F7A19@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raGzaq5GE7RZZIC0s/rq4nv5+M6VXlqwtdskQV95pb65AfBPPFU0L3EihAjkelgJGKzS6GZKM8rTlsgJJCUv/RquZ8DAp88WNBVwGdLzAeEjhlnSd75UAHGY+A+Vu5CF/HOpDYcIRBUwl9g1W1XUV2zjrJGDGwU0kth9D5Sc7WM1vx/fBsqPB2m2sczMcJSko73X0Q3JDl0x/5HeGEAapCtdcRvF+ShpCNvMNIwWLQTF4CabIYlUsFYDlIVKwNlHJLmX33QEiamyUh3xZd5UBbVu48K3l/v5Y2LFPLvGKKlBI4K5ImdJE6KLWnQJ0aldZv4k+x2jSzCUXqo25VPEAFbUDbBi+5vIzVF/mZumuY0XZz7K1mC6nWtaJxb43XDa0YKuRDXv48hz1tkiaO/U+bNKSYPnsCgMrN7X2QH3uyln2Z/rQEF7C1LzZDCdSaVgWhRsOLIJwzI5OUIcVWuaP5AknCO5ezWEB6b6KwJbRc7hZFbDWpVoyMtRJ18YA1DxaigSs8Q0+WuskCZ+MEDVQbBNmNybEjkfDyKVUDXV2VHLQLa2lAHH+u0CwR+s7ds2oeDOKrPNQFThCQj7q4KPVnHkN5qrFKhIVyKNG8tsH64ZiIL3wOMt03+pgt8tx6Iude1JxV5Gy4cPqqMiFvihOWXNWgus0eqaEbjJIguUefP/2TiEINktKalun07xFDKx9OYKidvUzO50En7BnyVPU1e+zag9D6sIIsOtSr5myh4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(36756003)(508600001)(70586007)(70206006)(426003)(81166007)(356005)(4326008)(83380400001)(7696005)(86362001)(8676002)(82310400003)(1076003)(336012)(186003)(5660300002)(36860700001)(8936002)(47076005)(6666004)(2906002)(6916009)(16526019)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:09.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad19ca3-c66d-4146-1ad0-08d97d2ac4de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
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

Handle SRIOV requirements when adding IP blocks.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 44ab3d6739e3..821665fb73b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -797,7 +797,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		switch (adev->ip_versions[UVD_HWIP][0]) {
 		case IP_VERSION(7, 0, 0):
 		case IP_VERSION(7, 2, 0):
-			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
+			if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
+				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
@@ -805,7 +806,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		switch (adev->ip_versions[VCE_HWIP][0]) {
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 1, 0):
-			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
+			if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
+				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
@@ -837,7 +839,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+			if (!amdgpu_sriov_vf(adev))
+				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 			break;
 		case IP_VERSION(3, 0, 33):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
@@ -1179,14 +1182,24 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = amdgpu_discovery_set_ih_ip_blocks(adev);
-	if (r)
-		return r;
-
-	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+	/* For SR-IOV, PSP needs to be initialized before IH */
+	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_discovery_set_psp_ip_blocks(adev);
 		if (r)
 			return r;
+		r = amdgpu_discovery_set_ih_ip_blocks(adev);
+		if (r)
+			return r;
+	} else {
+		r = amdgpu_discovery_set_ih_ip_blocks(adev);
+		if (r)
+			return r;
+
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+			r = amdgpu_discovery_set_psp_ip_blocks(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
@@ -1207,7 +1220,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
+	    !amdgpu_sriov_vf(adev)) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
-- 
2.31.1

