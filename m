Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8BC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 09:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E68233FD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 09:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E68233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AC76E14C;
	Wed,  9 Dec 2020 09:47:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CD06E145
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 09:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVI22/4YG7Ipf2mBGyxOlo2UwYGtsglKg8N+xGtHKjym27MnadaHSLOFuZUpnVBp334u6zmnP391MLtC/A1UfGdrJQUl1guGIiCdDIrN1oRya/gZVhTOQhaS90DM9znjsXGjt8RWpP2o51FpVRBKsjO5wdCbs2zi4s/SXdyoEcVf059MWqTXSdjaqlXNJJ6/0S+M51SCCMHoUCpWQY/Wlri6KLU6g8yBhfLKg4Fd2Hq0XBF2TIgzfXszfqtQ1UKhqN124Mu2Ei3f5nsFrcwlbG2fBdF93JJT6ULA0+5+/wEfosAmkiWWJwNZPHBSn2nS4fAdviJqjODndPCEvcf1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IF/IgC7LMpD/N3DGxqbQ6O2LR5Davf4pEYq72g98qQ=;
 b=RKFLQiFlbL2CW5jrEvayH8jaKClFSXQYebK5bzZp/9GXwe9c2kJjFhfI378Bv89M4AbHPXCf/+E3Kko2HaSq/KGyyXJvm561qBEYuvBS51y6cfi/qW8vl784z8wvBS3bbZXUKmRdpNqxVZCOZZ8rgjnbgu3uNYH6DkyTCsOjjQ2qPSJ2FLfx53rVa+wddF2TZ82JsSW8ynNRoPU5bjKmSv9VbXTjeGFKfgsqFu3Twj5zPJE5Qoq0F6wHSCuhx+B4kA+6AR1kQG9eGPV0GWOIpnoicJ3diIokN7zEGw470Zh3fLU+UmYK7RvAWmSbjXSNMuWy9/IZS6WhX0A6KggnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IF/IgC7LMpD/N3DGxqbQ6O2LR5Davf4pEYq72g98qQ=;
 b=YWGbSUlYhgdh2JhqtSClTk0Xip2SjALBo74gzhYFLmlGjEwnUYTTt7D1P4+67KawpZFLbEAfz68ffTUJ5m072aHoHsZttUIn6yOjwp7Uq4N0mLcmTR2V0n9tLdMhmjZsnWGcg61VBVjyc6ItSrDB7BYSg25fbkZAmlVHCqRegx4=
Received: from DM3PR08CA0013.namprd08.prod.outlook.com (2603:10b6:0:52::23) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (2603:10b6:4:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13; Wed, 9 Dec 2020 09:47:01 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::ab) by DM3PR08CA0013.outlook.office365.com
 (2603:10b6:0:52::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 09:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Wed, 9 Dec 2020 09:47:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 03:47:00 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 03:47:00 -0600
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 9 Dec 2020 03:46:58 -0600
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
Date: Wed, 9 Dec 2020 17:46:52 +0800
Message-ID: <20201209094652.192633-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c880d757-562c-484e-f60f-08d89c2760e1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01727CEE0508F2F1D86582A693CC0@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ/AhEYVBWgjUdjKOcWRxlSVkgNhlhMpQMSvv7iHAbAdOAJOl07xd9Jzs49LmWb93p4857j3IXZmjfqEaA77gRI2VXUrvx3IB9G48Lqk8U0RNA1KC5en/xtAm34hujZltslfYnmRN27kBMFR98+Q1ErFYpjTMPiZjehoZDhw4lzfDYJK4OJZPuXqJVUqQGI1rh/UiYlbz13kPsUqE5TOdagqGh8QsixBPHGLyPUTPnkwnef98LYYjYW4KSnG3BJo2IMhAdg/QSRuQPoJOHUFc6/wMcZtosgxQ0Qnqxe/x0Whbi/DHgPDr1UC8qAPCb4HOoXS6OJyoWxfzC0YIGtuahFc+UAcD2uXKKwpVax+iULJi/eyN2oqkY/DiltdjrYHN00eC1LB9Qh1d3mzE7GpJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(86362001)(81166007)(4326008)(5660300002)(83380400001)(6916009)(54906003)(6666004)(36756003)(8676002)(2906002)(186003)(356005)(1076003)(7696005)(82310400003)(2616005)(47076004)(508600001)(70586007)(336012)(8936002)(426003)(70206006)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 09:47:01.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c880d757-562c-484e-f60f-08d89c2760e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0172
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If CS init return -ECANCELED, UMD will free and create new context.
Job in this new context could conitnue exexcuting. In the case of
BACO or mode 1, we can't allow this happpen. Because VRAM has lost
after whole gpu reset, the job can't guarantee to succeed.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 85e48c29a57c..2a98f58134ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -120,6 +120,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	uint64_t *chunk_array;
 	unsigned size, num_ibs = 0;
 	uint32_t uf_offset = 0;
+	uint32_t vramlost_count = 0;
 	int i;
 	int ret;
 
@@ -140,7 +141,11 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 
 	/* skip guilty context job */
 	if (atomic_read(&p->ctx->guilty) == 1) {
-		ret = -ECANCELED;
+		vramlost_count = atomic_read(&p->adev->vram_lost_counter);
+		if (p->ctx->vram_lost_counter != vramlost_count)
+			ret = -EINVAL;
+		else
+			ret = -ECANCELED;
 		goto free_chunk;
 	}
 
@@ -246,7 +251,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_all_kdata;
 
 	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
-		ret = -ECANCELED;
+		ret = -EINVAL;
 		goto free_all_kdata;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
