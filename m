Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A18C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787F061949
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787F061949
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1DC6E4C1;
	Tue,  6 Jul 2021 14:13:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A53E6E4C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 14:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiJHFP+sf1P+dcUujIO/WdMJINyo4LTBQ4kubSnNny1gXoFJ3J4CwyMhQ8R4dYBcL9gHXrdm9D9/R3mZsmrLuFRD7UBlNl4miIsbdIpz5+rAfUexY9RSZeb+/VgGPysz2K/GFdg7w0G36vd6h3La5dGV3z7TN1aweYgO0rFKKVELzd+jAtZAx6CglqZhuk6VRicFcoJJvFcGDRrvO5b/gli/x66DrasH9si4M/OkDepxWvGLi2K4Rc7V8DrIsaMaUCZpeJYE0VzqgDt/d3I3uDNGHIdOM47F5gO9FTy892WWXNh57zyR68owBSGiinWjg8BLTBHjRzDE27xctBygzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWo6sEttAkmrGRO2uMmjfLrRryU0GXnORmXATCySmxI=;
 b=mzT96KpZp9cHEyvpBJWfvnxBoriZrxQAAzwYKy3OZw+FWI4mKDJbN906RiJBs81TjvjXAdQ9HHqIq9Eh4UvGfcgh3a5SZeyl5RsKQ32IG2MVpn0RURsQBtG3y6YiascpaBrMb/G7iMT/MCoTWnN/rXNBzaXHHgmtEw1Pw/FPvkTXtWZKxMtWk8W1LP3xX2xphwYO5ujRhOY2jLyo5rOHwXfqaNh1cXquD8L/na9t/Vi4kFsGWig5pbQ4sj425I9mYZhDJBudV4v+LHhcBBdwNUCXgnr5zRTxJuSVB2Ro2Hx/7M3+SPq+wUQHsH+cG8JibCRm71VxDPSDF0Oi6gr8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWo6sEttAkmrGRO2uMmjfLrRryU0GXnORmXATCySmxI=;
 b=lsscY72B/TSPvQd3d4qtPaYlDsxBhknpI1vytXMeTBeFE6N9ap9W1fT8oFXurVIk93wb82KcT1cbj7vSokNgAfzyhWOENghUrOKH/jVIuZHzcRnsGPTWfh+TglFmLMoL9WfKS7DvvFVoM14LwGep2ghKvasA2fT/lUOgfJ7IgAM=
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by MWHPR1201MB2541.namprd12.prod.outlook.com (2603:10b6:300:e5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 14:13:40 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::2) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Tue, 6 Jul 2021 14:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 14:13:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 09:13:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 07:13:39 -0700
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 6 Jul 2021 09:13:38 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual crtc
Date: Tue, 6 Jul 2021 22:13:35 +0800
Message-ID: <20210706141335.2494-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25430bde-ebbd-434c-fd14-08d940884154
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2541:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25411E9B27171C5CC41855C18F1B9@MWHPR1201MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/lxhMv/63Bsnw+MA0XkiSXc1h5Ig9aJFAKndV3ScXhu0s1n4ZGuD18QDWXSpfFKvq/m/JplBIbt/OTUOm9j6Md2fXkfAv402fhPP9Mx8b3lhgOvu7aXeqLRIWxNfT0XcPY6EwuSGSFufbyY41fuEbYIK/0VyaLLIRRBtLzeoxwzxYSRsoul0B2JswAPXVbmEXLyGVyJJyYHvjBuPGP0HX/RCzkKl1sCM9maf4V2JL2yvJFlZ0OeJ8OmLuTqkpGrHh0vocuE69sd5a2BuDUcYYg5jDitEKTyEbTkwcyKE5xOpfZ+kHbIK3jagjDzwF1UtPCJXiME1NLTsYP10zyTzpRgVBesymJi7AFYIYtsvqIoVh2W2d+NZdwVZLuJALwx0uPQ0Ye2tatFsRUu/FvdRLrrgBamT1nqlcVMppfQh8e0dG+QMxhFpx6DtFTEiOTDPnpoySsZ+NHVqKeXmWaBEZmQZRox+gLV+4SWydsfXU6k5sfOBFZU/BepQiBYOaxfs62iGneToWRZQ60X/biHXxKStbDOVSxS4FNcCoxZvxZsc5o4Me+rvahgL3Qe4ZLxyaYjAj9774kEs6EA3+TgbHfHUKW2zCiD5y0xj6rTsWf8e0hzxyepvUMKK9J+dHIyNr5Gl5KIc3s0nj7C2yb66KWLEGDkrLSuqr8657ntwP22LREGt7KH4Ovo58YpzrWfMyPG3FN1pROcqdF5quO9x7VjInmQkujmNENHbkRwA5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(2906002)(478600001)(70206006)(82740400003)(5660300002)(4744005)(316002)(1076003)(36756003)(4326008)(70586007)(2616005)(36860700001)(186003)(426003)(8936002)(47076005)(26005)(356005)(83380400001)(81166007)(8676002)(336012)(86362001)(82310400003)(6666004)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 14:13:40.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25430bde-ebbd-434c-fd14-08d940884154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2541
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The irq number should be decided by num_crtc, and the num_crtc could change
by parameter.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 33324427b555..7e0d8c092c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
 
 static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
+	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
