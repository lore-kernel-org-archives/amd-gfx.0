Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81164C3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC4320732
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3TUOKS+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC4320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E317B6E3F9;
	Mon, 24 Feb 2020 10:06:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6276E3F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCSvxA1UMLLWIpPUF64E2g+GjONKB9eoI6VbDPee8BfuApD5N9RZ70y75ReVrjlLS1MSTs0/jApaEg7jlBQFopMqWw0M4u813f6bik9AXd7u5FQ64kIf2cJKHF7I57/D7nHIt4IhoTqvDC1RYDyIcvNfchWftAvO28qvBBt0PrsVAQq8M2qfnChaovbUfWeHcokGNKhdL9i5sWejscqqXMjc8AYPtYP5RP8PyjpG5kgrR5RJ1uMM/P3+e1en0JAsCvYNNd/2JTw4FjnsyrM2EyYkindLjtnfBFCDU7raRW+/nLNWRTbQ0OXlhRtgAVLpSwFQ8IV2Tlf8jDHRYX7n3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDbKMBkgJ5GCkdtpLhUovF3aVYSH51Fp5/1y091j3Bk=;
 b=axpFW2BWvviq+QwxXt8HjS8SPBTtkB/YYKxXnaPIiAmc+O5gCyx/ItBNPV74QX6x89uwXHXwOKS7C3UKeKnOloEVB01jlJ55z0IdhictbXl7trc+QYkTa7hh0/j4aFgK7Wxrl0eN+ImmyjjHDUxaRCpdcrHDmMHNK/1hGwRZYZqhOWRGyBRkEvQSuCiN72AnH63CMIKui8myPQvYlcjjHS3s0Cyzxt8I1GT7Ijdkd4oEh+sSuW/Yz30/RNmZdBpfpVDyEK/PIOk6n/wJwhz3JJwJD6FJaR0iQeEB0lNZR2yVZwN3WOcZ79i4R9OyzGBfuHD5QSJ/I/mW8nPC1LjHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDbKMBkgJ5GCkdtpLhUovF3aVYSH51Fp5/1y091j3Bk=;
 b=3TUOKS+qkK12knuYDP3mVxXf1Z+4mVjuDYCXBX7LL/Y1d4xkBNZL3GN4eliwDMJoD0+AkTIFo4RL3hTJui+88ugiv/ariAD4otJZq0VoxosUWLbMSLKCirt0g4kKF8K4fxMcgIKd9vmsoi/VA1QKq4qAZaHU+T8rhLNmbJI8XAk=
Received: from MWHPR22CA0026.namprd22.prod.outlook.com (2603:10b6:300:69::12)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 10:06:09 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::e6) by MWHPR22CA0026.outlook.office365.com
 (2603:10b6:300:69::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 10:06:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 10:06:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 04:06:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 04:06:07 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 24 Feb 2020 04:06:06 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <Kenneth.Feng@amd.com>, Evan Quan <Evan.Quan@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: toggle DF-Cstate to protect DF reg access
Date: Mon, 24 Feb 2020 18:05:50 +0800
Message-ID: <20200224100550.13722-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224100550.13722-1-Hawking.Zhang@amd.com>
References: <20200224100550.13722-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(428003)(189003)(199004)(2906002)(6636002)(36756003)(2616005)(336012)(8936002)(26005)(186003)(8676002)(356004)(6666004)(316002)(110136005)(7696005)(426003)(70206006)(70586007)(478600001)(4326008)(86362001)(81166006)(1076003)(5660300002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3944; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a46db26-1362-4d9e-c024-08d7b9112b92
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3944394D44832FEC5430B05FFCEC0@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7Bx52QPRyxWA0iN+TGIiX4VwyZC3n0kbavjHwOKHZOktcO009T8kreSvE8XM3d/DSUEDZTSJpdQvFFP7QfDMnnp5V588Fuk0IO5xe9DCb/GA03Q38wWPIz5ADZaIFr0aHzFRlDHxU9Y2tlgwQQGbwq25CHvhwg0ahY+/8zQgKWNVil2eR4E6RJskUDet+hdxy2jESl9I3ZkRxZ+bas6A2Es9SDT2MKiLltOP+A34sa8d9h9C75G0A1oTE7ZqrsCAbgpegcbaP2CtY/Fn8CSM28yV595EyUDK5bhkzGvvQsetSy5/LTIeA2CUjWBpBJUCeZYS8SW0441ZHP56bTinS/Ku/L0oB13Wdu3/usvF1h4tzYgDPylSXPFLvT/KFC+t5m6hOK5GyQivsmBDwIwm+SizYk9IZxp6gdFvEoE8K9+x+QejBETfaKHqjju+as4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:06:09.1235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a46db26-1362-4d9e-c024-08d7b9112b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
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

driver needs to take DF out Cstate before any DF register
access. otherwise, the DF register may not be accessible.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 8edd1db0d1ce..856dd22465d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -535,13 +535,28 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr)
 {
 	uint32_t df_inst_id;
+	uint64_t dram_base_addr = 0;
+	const struct amdgpu_df_funcs *df_funcs = adev->df.funcs;
+
+	if ((!df_funcs)                 ||
+	    (!df_funcs->get_df_inst_id) ||
+	    (!df_funcs->get_dram_base_addr)) {
+		dev_warn(adev->dev,
+			 "XGMI: relative phy_addr algorithm is not supported\n");
+		return addr;
+	}
 
-	if ((!adev->df.funcs)                 ||
-	    (!adev->df.funcs->get_df_inst_id) ||
-	    (!adev->df.funcs->get_dram_base_addr))
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW)) {
+		dev_warn(adev->dev,
+			 "failed to disable DF-Cstate, DF register may not be accessible\n");
 		return addr;
+	}
+
+	df_inst_id = df_funcs->get_df_inst_id(adev);
+	dram_base_addr = df_funcs->get_dram_base_addr(adev, df_inst_id);
 
-	df_inst_id = adev->df.funcs->get_df_inst_id(adev);
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		dev_warn(adev->dev, "failed to enable DF-Cstate\n");
 
-	return addr + adev->df.funcs->get_dram_base_addr(adev, df_inst_id);
+	return addr + dram_base_addr;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
