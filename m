Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1AC3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AB820732
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4FDTR88c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AB820732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A79C6E3EF;
	Mon, 24 Feb 2020 10:06:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411906E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G75n4+bUbLMj5qoKvn3SV02/9BidtDHxYmyHFkua4zKyo7v06x0jTh50+FMIZL47de1Z2tpO/XjeuXB4HIOhFEpmOCTypX18T6BVwKf5Z2BkbUSdPYMZKtF3Wx3U4MBSW2rlRHM2YO/7AA77+5WBO+3upyXTlk7qG0Ro4cperBSZUDoCsij1OHzudT8pSecj57W2JiQVpVO98d+ShrjlBOSnyevDg9Cl7lcLHMRy0KhYmmfHrcy3tS5mnIDG+ObHd8xLRbBjHE1lprwnTYjVIgnPhUa3sa8cZtZ+1aQxNLgUr5VKym+2Swh13q3mr0SICzjJ0EpuCL3A/xqqCZXMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWcFC32NSVCc/KUEQo1zWBP3bGrCg9b9wPyZahQGJV8=;
 b=OL9KeQn4MDNIj0nPLM0apEOQY2zT9mZYPx/ubYKkRG5U9B21KBtuXKg8WEgW3bY46f94WdW4aDH3hK1i3wDPrP2rq8ffH8c1dfAEU6r9AW+wgPedEDcIDi8vAY1pfkjADf10rSbTsx62ql4Ag/oudCjFSx9mz96GgGbXP5g7OmnpUt3typc7SEeRjFGA1UgXRlwmha2jKjRJZSD7qBEKkotFvDQsGJDU5iIlMTbxzvrZC+xkWnByvxwzUn+ZkvpueAmHr4z1+8W/QwyRoH0xWaB5UGace+ar2gQ8VIASSREyEmS9VzomIOqOolW0x+sgByIqmE4qgpCcS7T0p4/1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWcFC32NSVCc/KUEQo1zWBP3bGrCg9b9wPyZahQGJV8=;
 b=4FDTR88cVPi5NY9jn8nKx1S2mED211yhorlGYWY7HSV3dXoY+ucloMHXeffGfFlUg/V/29tM2lZpnCIMElTtWHSrOw9BmzwVN025U1eCg0OP8zM4CfLECmbX5+MxwzIVARoYVLbRj2OVkVtc6QlxelsqHo/44QWL7b3EaSBtLfs=
Received: from BN4PR11CA0006.namprd11.prod.outlook.com (2603:10b6:403:1::16)
 by SN6PR12MB2749.namprd12.prod.outlook.com (2603:10b6:805:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 10:06:04 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::78) by BN4PR11CA0006.outlook.office365.com
 (2603:10b6:403:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Mon, 24 Feb 2020 10:06:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 10:06:03 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 04:06:03 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 24 Feb 2020 04:06:01 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <Kenneth.Feng@amd.com>, Evan Quan <Evan.Quan@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: move get_xgmi_relative_phy_addr to
 amdgpu_xgmi.c
Date: Mon, 24 Feb 2020 18:05:49 +0800
Message-ID: <20200224100550.13722-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224100550.13722-1-Hawking.Zhang@amd.com>
References: <20200224100550.13722-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(428003)(199004)(189003)(316002)(110136005)(81156014)(8936002)(2906002)(426003)(36756003)(8676002)(336012)(2616005)(1076003)(81166006)(478600001)(6666004)(356004)(5660300002)(86362001)(26005)(70586007)(4326008)(70206006)(6636002)(7696005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2749; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b1a63f-ca08-4b4b-5574-08d7b911285c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2749:
X-Microsoft-Antispam-PRVS: <SN6PR12MB274934BCB26001B7E8FD07BAFCEC0@SN6PR12MB2749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKhrkqvkr9uDktu44oRKJYAWc4Bsy9f7nn5hF3hm3ojwLxB6rGAGbfBxWdP7WUhbNBvFWVQGlUTDLm8/ImoVT73DEi3iGWTtNhdMwDkefr8eGshrjhyiXzCPHkuM+/MWJZ6USDQs8UFR18kvC58UveLB1HbTszSFf6K3+31SlYLFVM/l7j0POBiWphu68T5zSlG/0/nEMQ/slk1l1qk3NWPLPeL8kTwvcUTmh4Ntuf7Y4GIHmkSl+Ysp6RtJckHvJnkTl1CmP5ci967tFXuEitgs5wayLIvucWD+8/yOtF6TA43HCxNY5BpMqKhuITMXzzhoieSjPtQewk+qe2Ig4jqmF/BAtNyxgkKqDYcvL7G5xGTg/AbWliPRTs/4GDXVAtkY/FOqQqavAFBVDsTNJZ9FgR+jUcRpfE8ofqPJIJGqP55y5A26CjYbHt/nBh7H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:06:03.8487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b1a63f-ca08-4b4b-5574-08d7b911285c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

centralize all the xgmi related function to amdgpu_xgmi.c

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 20 ++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 ++
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 87f57878dbd5..c1d82f545c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -31,6 +31,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 
 const char *ras_error_string[] = {
@@ -742,20 +743,6 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 	return 0;
 }
 
-uint64_t get_xgmi_relative_phy_addr(struct amdgpu_device *adev, uint64_t addr)
-{
-	uint32_t df_inst_id;
-
-	if ((!adev->df.funcs)                 ||
-	    (!adev->df.funcs->get_df_inst_id) ||
-	    (!adev->df.funcs->get_dram_base_addr))
-		return addr;
-
-	df_inst_id = adev->df.funcs->get_df_inst_id(adev);
-
-	return addr + adev->df.funcs->get_dram_base_addr(adev, df_inst_id);
-}
-
 /* wrapper of psp_ras_trigger_error */
 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		struct ras_inject_if *info)
@@ -775,8 +762,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 
 	/* Calculate XGMI relative offset */
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		block_info.address = get_xgmi_relative_phy_addr(adev,
-								block_info.address);
+		block_info.address =
+			amdgpu_xgmi_get_relative_phy_addr(adev,
+							  block_info.address);
 	}
 
 	switch (info->head.block) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fbc41926de08..8edd1db0d1ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -530,3 +530,18 @@ void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
 		kfree(ras_if);
 	}
 }
+
+uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
+					   uint64_t addr)
+{
+	uint32_t df_inst_id;
+
+	if ((!adev->df.funcs)                 ||
+	    (!adev->df.funcs->get_df_inst_id) ||
+	    (!adev->df.funcs->get_dram_base_addr))
+		return addr;
+
+	df_inst_id = adev->df.funcs->get_df_inst_id(adev);
+
+	return addr + adev->df.funcs->get_dram_base_addr(adev, df_inst_id);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index c62a4acf4c14..2aa61adee459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -46,6 +46,8 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
 int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev);
+uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
+					   uint64_t addr);
 
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		struct amdgpu_device *bo_adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
