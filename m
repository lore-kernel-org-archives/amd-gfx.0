Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 11:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFF0610E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 11:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFFF0610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0036EC24;
	Fri, 17 Sep 2021 11:31:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB556EC24
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 11:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6K+LCtPK5YtLqmlYIHn2oa8kwuYSQWtZwnC0hADMnynFga8Pa2lv/x50R4poAzK03fZgo+eURlmGjT6ReyvV3hvZLKZKHnNIEL3svekPXsWAUA8JfXa8hlIYLR7Pv1XqNVozt/DZ4JXU+STdd6wI759ZzmFWYyH0TR2aivBeO4e7CKW9zENfD9B6S6TFCu/JL4ou1VSrel24qnbebytkSlFJkmWZJtGWOlEG5Ofb473P0tavlVOAwDs5QhpbYvo9sntXhM9rm2BlZFyUXjdrg48F2t1sJITxlgzHahk1YiM5jwCxr29ADqFcR1be0sxrNlAE17EGKK6oBMuq3hX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+Q004N0jOwGmvfWKc3LbOfSlC6fQRKqNGWG9WJEqJAw=;
 b=eGebJQzip+kwWT1bJNhOx+X3OTMyo8fJBbD3QLPPEU/9AZWlJpvEzH00CJ/e5iGRT+DkFWva2KuQa5Q7zrkdeuYe4UIs8afz3+BMQJ//qOgRB0PmFYM8e4QqU1PFJAwIXXaNGXw/Bx99tkoYlEXFMj+nj/EzI0EY7N08XX8LFXYbdXqfxF2NZMfR69xgTnW44+pIBgTrjUt66BhwxHTHBJ9LjMQHjdkhoLtlA7v1I/2tyC5bSrziVsEX9TS3XoD0wuKI6WtYd6V+D/Lf8Dan1K7U4oytStQhAk5Tn7sSDuTI8o/Uat/4+9/6vAN2hUGT6LaKwa9CzhSsUjPEIuIEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q004N0jOwGmvfWKc3LbOfSlC6fQRKqNGWG9WJEqJAw=;
 b=kszVKh58dzSmDi3S0qYq4u7YaphVhPKiKK/mcV4sjV/hRlwLcRN8VFgTBHHyJCiq1qreYXgypg1JidFkfrF9aTSgFi/gBpqG4tqkvSWC4T7TcvRS1u2qMXHUM8Z51dPDlVMoLiiC+vZWRb2rCPAWknMbps2zOKdKzLQMWSm+JXQ=
Received: from MWHPR22CA0022.namprd22.prod.outlook.com (2603:10b6:300:ef::32)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 11:31:00 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::88) by MWHPR22CA0022.outlook.office365.com
 (2603:10b6:300:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 11:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 11:30:59 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 17 Sep 2021 06:30:58 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix MMIO access page fault
Date: Fri, 17 Sep 2021 07:30:44 -0400
Message-ID: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf716a75-6457-488c-1924-08d979ce9f99
X-MS-TrafficTypeDiagnostic: BN9PR12MB5161:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5161CB7CD78C7258970AC04AEADD9@BN9PR12MB5161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiUTGWi5xl7tcTsuNrqVG/0mf2+M1UuwFosFFNC0M9hg+wSZ11rKT97n05giqmtRJKugLiYO7EPYjeZAVtstscSzdcjLm2v2U3gJzAAjD9dv+pe9QZGo5P39MsYkI5gVRPCMcqem/pLywbyACrCdE/7cpwzFo5fLMgPazEHVo0okCTRvFEjgoBdpYCp224ec5IvP7DvaKYAIwqVgDxfvyi0vUGXAAOfPmiqbW/4fnZLowZ5fe26L8ZiJsjLVsVJL98i93oPZntQUgD4Ofpd80Rpx6iUQLq+bK5gaGFd/H8WByUaHDzMfpiN5vmeElSBufSUfjnfox/oMgubnsOoXTGkOChwJEpS710DY3p9k4Y/ADhCsTPtf8rBCXMPQzXJ/2mkoSlrKbkFGyZZr/HsImB1biyRYbnzDjSh06j7MTCOpkAEYQ9VOYLS4ADuCNB2DrG1tmXEBTqmCXQaSHxKLpBnb702btzQBttDFWKiRBJm8uDXehfR05eOpfArEEkSitOs6MLFTEUjHc+vU/o69Vkjc9cKPMwLGE9GVSbXuhmwAoinVas+5Q6EZy7vnjdiyDRlAfQDj74EAJvzppdSXV6ahis5egkvTgf87SWLaVqPIK9Oy8inrOowYYPUvsmhUwNcyWL69ufzi8mXrNfSn1t/54EXaQu52+60GpwtrgxE70iii2kvm+mpJH7816bMvTICkQqjkWzypkqJLzbffsRsZQKNoAxQhVvIVpGZAkIgc+ZUNtYDa9gYfUC7YrkrGmG4ggXtQD9IlfmswsvQIYzyWPWqcNLJRtSEOuM77CewWbJqgor1aBUAQlJmPoTOq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(316002)(70206006)(70586007)(54906003)(83380400001)(36860700001)(82310400003)(5660300002)(6916009)(44832011)(2906002)(7696005)(26005)(1076003)(36756003)(81166007)(6666004)(356005)(336012)(82740400003)(478600001)(8936002)(426003)(16526019)(8676002)(4326008)(186003)(86362001)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 11:30:59.6011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf716a75-6457-488c-1924-08d979ce9f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

Add more guards to MMIO access post device
unbind/unplug

Bug:https://bugs.archlinux.org/task/72092?project=1&order=dateopened&sort=desc&pagenum=1
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 17 +++++++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e6e9ef50719e..a03c0fc8338f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/firmware.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
@@ -194,11 +195,14 @@ static int vcn_v2_0_sw_init(void *handle)
  */
 static int vcn_v2_0_sw_fini(void *handle)
 {
-	int r;
+	int r, idx;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
 
-	fw_shared->present_flag_0 = 0;
+	if (drm_dev_enter(&adev->ddev, &idx)) {
+		fw_shared->present_flag_0 = 0;
+		drm_dev_exit(idx);
+	}
 
 	amdgpu_virt_free_mm_table(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2e6b7913bf6c..1780ad1eacd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/firmware.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
@@ -235,17 +236,21 @@ static int vcn_v2_5_sw_init(void *handle)
  */
 static int vcn_v2_5_sw_fini(void *handle)
 {
-	int i, r;
+	int i, r, idx;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
-		fw_shared->present_flag_0 = 0;
+	if (drm_dev_enter(&adev->ddev, &idx)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+			fw_shared->present_flag_0 = 0;
+		}
+		drm_dev_exit(idx);
 	}
 
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-- 
2.25.1

