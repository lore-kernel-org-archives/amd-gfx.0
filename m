Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F3C43462
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3067661453
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3067661453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720806EDEB;
	Thu, 29 Apr 2021 10:27:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CB36EDE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMLW5rgdnBV/sNwYLfuvblf0+HFf52mGjl3GJORqQ6KQE0184dT3wxQ7dk0GPQF8Y+bboiHSzZ+QOxAkkJt4cvZAIhn10UVy9nFQRERqPEl314/QhvSEVGtb5zgYJVIyZURB2eDyg8yAx58fc5gj2ArctjvUu7y/d28UWoVszfRKFqeOARD7gLPiru3ksNt2s4+WgzBirT3d1ksnJIgpGA12g4ls7XA2vaHz0W+4YMFFn6n3Z2ZAeAlEFLvVGLkxtzknM8SvbyncZAAkO3B6ASi2j7bw6QmLCb8LiRBaSwICm2ZpolcZSVWIsNo+K3Sg1u8sX/lqmFvbFcPkoIYH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU8IqCuEJC9KjfjkNlSE2zCL5Gq8u4H3woY9JVBWvQ8=;
 b=KQK2Mez+op9Ti2h9Kzuwf62tRtfpbnTV7cvgQjI3wx6PCbd09T5KRc0yAvag9dbpozLV6t2pwAx7uIpCin5zDZIBnqCmIoYNR8+73jBG6OZ+Tpj5Iw2E59mvPsH03k7dkSGqySvY0NvospMOukJxPQUkMeXLoEzJ0CuLdYdZL9pSftXsbWtJlp/yvMJ4oOTsYlesR0vxbr2c2op2pjqqAFEjBB8VmjFDy0tUCz6yNvzvMeE3Cz8aa9ynLNtUt6vBE5W7XO7WNAscD5avZAhdguscW36jSHeomI2teN9eKDIx9FYI+Wo029MwedDDwA8sq/G/9TdSF5C7mK0vOnaoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU8IqCuEJC9KjfjkNlSE2zCL5Gq8u4H3woY9JVBWvQ8=;
 b=yLgPbe4Wy917oluJlBWXy1UzM6H45eBVrtOWkKVTi+Ud88GcktxngEZmlNyRprao7aT3gPkaH270jh079dNuz1Nru1NEaTjVszByKqHPb29ABYRbzEG0EXVwpLPv5cInW/z6pFAuiEJcnA0CvfHpAc7zqrsxF5Fhi5n9weMBVCM=
Received: from DS7PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:3b7::11)
 by DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 10:27:18 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::d6) by DS7PR03CA0096.outlook.office365.com
 (2603:10b6:5:3b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 10:27:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:17 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:16 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/12] drm/amdgpu: Skip the program of GRBM_CAM* in SRIOV
Date: Thu, 29 Apr 2021 18:26:43 +0800
Message-ID: <20210429102644.31172-11-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40737484-2344-4d69-f9f1-08d90af95d9e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2376:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23765B88AB6552E482345552F85F9@DM5PR12MB2376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLpfXZxYWTuv1W607FiBIETtO/6/IXSJmNoP87lXCwn3wEPwqCjqS6t0sooKmIXGM9E+RSOCKUOIdhx0/fs8tAJxQPV8dVsBFpAchCyeZA0OzPl4DLmjDwx82VlIxMKduDQ9tFbx2jfqBW80gVpNnZhgpff9ahRyObOt8RHd9X7LjVOgGeUiPVFkh3eqGtjtAgWL60s8Pe1f/VUU9kmQjGKBKH6EnUdxwDo/2E/XDbp7L5AQCM+AcWP/Ho2IDlv2hUEA+3Ke1+HKY6/8c2t0/fmrxp6xVxwzTpb9HcjnX3Mi0mlW2fDXprqbcFtw6bDOWcGy8mBUOxFS+VqJ5QIHEMwQMKD88l5TWBoVTVmmneYT7iGv7vQIaZQTOiUYQjH/EBPWwgZezTNKRYHu7NpA22OjblHEsM7IxY1pzQTEA3n6CBqw8iV3MGt7GaIuEvVdi+KSAwzI/VFXQxdsV33zVEgSAT9hiZ4JXM1lHupwgywpub+gj9oU7/J2LOJw4H/ctXeYx74GAcwJLBUlNe+TT/nfUQuLjk6QB+tT3iMzdLJDjylEJetJDnhfSaB5EuHjyP/tEbdSq/EmwElw7ihOiRD3FgFL4k5ZH2pfGuqJfx83jJWpCWjicz1diQOT2sHBm5kE5oEkVNyyYAqDeI8mbX5ZIQQ7RLlGruHKblrIuVFqrPV8cPXVCK/3/8J55DBV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(81166007)(8936002)(336012)(426003)(478600001)(2616005)(82740400003)(2906002)(356005)(186003)(26005)(6916009)(4744005)(316002)(1076003)(4326008)(6666004)(82310400003)(36860700001)(36756003)(47076005)(8676002)(86362001)(7696005)(70206006)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:18.2540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40737484-2344-4d69-f9f1-08d90af95d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD should not the program these registers,
so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dcef4be66f07..88d0828a6cb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7090,6 +7090,9 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* initialize cam_index to 0
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
