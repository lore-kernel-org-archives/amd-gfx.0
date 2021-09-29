Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692ADC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 08:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21882613C8
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 08:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21882613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6586E159;
	Wed, 29 Sep 2021 08:20:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3956E159
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 08:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJLptHOyXkfc19sPFbMUtjiOEwt/r7FcHajts9+K8EwK3xRsQPWJx6vLMVlP5I4SJPU86eOr0Bb5mKZtDtVCNUZQ5qFK3J+x7BVj82NH4VUdMFE8howHfci0ky67p4pJ1iJsWT0gTsS9pY6R2+aDMzWqCXzjHGSgV+fjEAAvilvfDghfVQ4+EVhDl2flLAoCUxjaTtjc/sOSlempvc0Pwp6n0/0ya5b0F8ZVVbOOamkVY0/VSRRemp/rAdPq3K9ZSK/R4JlSN5VaIFMyf9CxNlSNl2y2h3lD6iAfg9s2B4CahbwLsw5cfRS7up3l5DIkVEzFTUtdvNy5UMUthcsGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Ua2Ljt83hsOqJnfQxwBVFzyKDocGxL6vTtZx0sTNkUs=;
 b=eM7HU/mXUa24ktDkp+O0o4TLuHO55+a0m1Hi1406CeDAQENCkCflxTvdOcLftUDw5p9gbLizk6WtAlz7A4EOdhe3I8TllLXOGhUuPb9602vhGwciwd+MXFqo0I6t3B867rrcCZKQI4m9ruCkSW2htK1/QA00kqU4iRq6lr7miYZRAcmjbUec1r7M13bPsj1WNpyI4v/PW/2IJ7HZjPZFBwgCZO+BOvEue3J51548uTIaQAnhj/l2Ifv9qBWSQ6cOqEveSUdykxGN/u+bghYEE+0SCyxGqLr417w0tiHJkeuf7YfqJOx0P8/ClmRm0shTogzoTMM5oNprcENdwrckbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua2Ljt83hsOqJnfQxwBVFzyKDocGxL6vTtZx0sTNkUs=;
 b=wsKcf6tIqTYugv16jSEU7HLK7G3OLO5sym2dD0fAJdGp+XP0zXokhDy/XnpcuKK3WjNWlD34ciWeREHRUjF9mvf/UlyZpUlwTTPBh75cSqIoVOdep63bmZuelQyx+s3IwbMG5ZcANF5TGKiFZUfvjlcjhNmwo9vPaFipCdvnWIo=
Received: from BN0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:141::12)
 by CH2PR12MB3975.namprd12.prod.outlook.com (2603:10b6:610:2f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 08:20:16 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::68) by BN0PR07CA0001.outlook.office365.com
 (2603:10b6:408:141::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 08:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 08:20:15 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 03:20:13 -0500
From: Lang Yu <lang.yu@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: fix a potential ttm->sg memory leak
Date: Wed, 29 Sep 2021 16:19:59 +0800
Message-ID: <20210929081959.1805447-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa7de7c5-255f-4fa5-fa44-08d98321f74a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3975:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3975909C1CAD6CE125E00F7FFBA99@CH2PR12MB3975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+j5aohzoBy12DN5mqvuehhwSFyFx9w0uhBkLky9KnFVCDZ3mvHzb0EJUPCKZW9ERcBIhmqlidLqgzcnHOuXHq1uVtGf2sN0cWvVNb16VwjS+G4JnzAyDOukpGjBXQnkrtXp7ZOLIbbG+xn4aahvBb+EZft13+NzIdZPkl0ZmLkNqNSSwPRBAiVE1R9Vz/5klAJCInOl9El7JCjN+uHTyk4yyK4Zwjw1uTKb6ThwKllgZC6ch1DLI2wb8GWzStsDJDI444Sr/1ZJqDeORGLXhZAaN3zKiPKXxSKu2UdJUvUnAzPHQBLIHdPWYNiD1xyTBqix0Qyj7qtUPHjI4xUGXdOCjeprm67nSDKMGVp1cDm9uCxZzFAYznDj8+Iv4bxAz9E0ez55NvkCFaEO8DPYGIINJXiBXDLaYSto/aFFjexNz2xWkQDqDFQ9uGlEiSn3Gnq+ZZFlQlJZ0j/r6TD7aFTm/YmHhf9pXpQE7VZ2335iqy6iFKgCZqt8Csn0PEikX6EOXAib3ZDHcTqfXgRTalwifYzzDCHbNXFgelQEBR8wDFEs0yQe2y5TOkhfo0WuX4cPMLLSHXR3YglSw8USi7WO0l6iPa25cUwyvBZJuJabq+zZputjCwb6biFCbMITJDDvWnmXr7kqSGYysmi5PY4bAAaSBEuxuSVP6I5ZbvHCCZOxZsZLD/KulEwUTR5E9wlAaWzCsGbEoGSTFba0LurZm7LNLcBJr7lSbzT5r3Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(4326008)(316002)(5660300002)(2906002)(82310400003)(86362001)(36756003)(26005)(186003)(8936002)(16526019)(81166007)(508600001)(7696005)(426003)(70586007)(54906003)(70206006)(110136005)(8676002)(36860700001)(356005)(44832011)(47076005)(336012)(6666004)(4744005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 08:20:15.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7de7c5-255f-4fa5-fa44-08d98321f74a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3975
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

Memory is allocated for ttm->sg by kmalloc in kfd_mem_dmamap_userptr,
but isn't freed by kfree in kfd_mem_dmaunmap_userptr. Free it!

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2d6b2d77b738..054c1a224def 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -563,6 +563,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
 
 	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
 	sg_free_table(ttm->sg);
+	kfree(ttm->sg);
 	ttm->sg = NULL;
 }
 
-- 
2.25.1

