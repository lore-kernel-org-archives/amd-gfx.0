Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE93CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 01:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D8161073
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 01:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95D8161073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B71C6E96B;
	Wed,  3 Nov 2021 01:34:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA326E96B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 01:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nThYZXVGnnpa38hUJzjU4J9BSFokTJIXi/WNvqIrRq54N/pDZYzt2y99g6f32gKvRoIuDt/p+U51V1zCo15ahzgy6vYjrshAnNT4OVwPmoWfHLHVPVIp2KW99zYrDEN9JXQtwVd7X8BDBuJx1ikqO7vxJRgnj9ZadzALtLWnJhqjfSFkAgpGWyk+iSuLLhIweFo9cMdVtWxfjlRYsNhwEngfnk/kocPwq6IPTJiGrwfuNscpGVCU6TCvy7shEPoflfSAqVwNrsSsEDcr1aSvnkxADlXIyoZ63Xhq5Bx4s8V6KY1w5MFxM6wCR+CCQW1N0t4geI0RUSE+OUYoGtlbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ahq/mj+B0U9lwleiO2nYp1CCjsq8fkOSGXWcR02sI0=;
 b=enA7xKS9iSht59g5nsLpJ+AXShRM/7TengruUgAa7XY4X+O/TTPAAJGBpMectGD87DgW8XflPbqD1Gremwltbbe92QAiZtfkImcYBtZjx2Q+UFIDnjpcOO5oXtvM7LG/w6HhFWEF9FqQDECQY4mvbhcgu5CznCG9hRl73z0tdRwAVvxggvp7B9JF2gJXIx+jpeR06bdp4oS9rNDeWo1xzBCdZPCkF+KZLI8paPpkylQEm2oAMYW/rmOIxRO9MVAVnZ6Y2FnsflpRgD3GrUN+1XtmiFfHvdgNJLr489mHsk/cO5woMOYNcQv84Fnsftsl8+TMJ+Gkh+vEEBEvymbfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ahq/mj+B0U9lwleiO2nYp1CCjsq8fkOSGXWcR02sI0=;
 b=LEoRVBA8aDRpIE6Su8X8Vd0b7pGXXm5GQFQFtmLNa9m0uAi8qwDdd2VgxQDBL8N09rttyJEABxdM1PtUBoIF/lbNvYGdIQIyf52tCEa4sqZuY82OMps5lLl55b8t0pIiy7pPKOwXscSXQcAbCA/6d4MwvnMq5ucS2J1cUOr79gM=
Received: from BN6PR19CA0069.namprd19.prod.outlook.com (2603:10b6:404:e3::31)
 by MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 3 Nov
 2021 01:34:07 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::de) by BN6PR19CA0069.outlook.office365.com
 (2603:10b6:404:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Wed, 3 Nov 2021 01:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 01:34:04 +0000
Received: from jz-tester6.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 20:34:03 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove duplicated kfd_resume_iommu
Date: Tue, 2 Nov 2021 21:33:50 -0400
Message-ID: <20211103013350.6015-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cc61ba-e61d-42e6-5490-08d99e6a059e
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2909B90E5C57AF7AC562D369E48C9@MN2PR12MB2909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wi3kX6kvbmPPjdiLO9UlBRnZJ7p65iC4p4Qno/j1osVWyb/Qp46n62lZL8lDqDl9PhcIlzgtTiNGkOlrF5wDVrq7ZBgxFLCqmbf/jMsrGmayLjcIe1mgqPcqicXYmt/HSte43VaHF106nJxRY5TktTug3Rb+I3gExzcdpEJ2s9uOJCP8ZLTyGJ5ABktYBFUDGiXRznc9VOSGd6oa9p9075ijxCI92MTJbg8VFPlrofKkwwUnrEezKKWAb4R4VUXtG/nE8AQlH1MKY3NBGpNmUmyNwTz+mpotUH7M4i7B34EiMm25ARLx1U8y8l9N5Sy2OKIZF6QQVSeWUXQB7KbAj0Km6fudYiNOJhj9IuWPHbcQGba6ooM+ZUBM/mAC0pzPJG6MopgJX61zZOTi/eE2Ds6k7M7v+69xhUZ2Y+oJyNqDuuvKvddwsKC3TfFkus+WnpBTxF/59JSIbzmZtwwxh1k7rkGuFOLM58QVYy+W1+IZUXQmRAs+nhpjrnCcn3dx9X153HUIo82/MUMxl3/U0lh7YaoGVw1XLotIsPyuTibtTsWk0Uqp0SLI0CcR98bj+NqhrNJntpRuAXHUnUyxn5ZwIyhWpscifPTP7/gFGPmqjka3a8HoY1iLppRnCHvHh8OhpZH5jIY8OJ/Ppad1ve7htb3HC711VxVPPZTmmnHrhl8JOvxzvi7g5xbnufJ17QNMrKIi08qwz16SbnLSxG8V7V9iwjm8Et3Lr5zQ5U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(82310400003)(7696005)(426003)(70586007)(2906002)(70206006)(36860700001)(186003)(8676002)(81166007)(4326008)(316002)(54906003)(36756003)(83380400001)(336012)(26005)(4744005)(1076003)(16526019)(6916009)(47076005)(6666004)(2616005)(356005)(8936002)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 01:34:04.7170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cc61ba-e61d-42e6-5490-08d99e6a059e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, jzhums@gmail.com,
 zarniwhoop@ntlworld.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove duplicated kfd_resume_iommu which already runs
in mdgpu_amdkfd_device_init.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e56bc925afcf..f77823ce7ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
-- 
2.25.1

