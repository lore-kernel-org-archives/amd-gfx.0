Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA33C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CED610D0
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85CED610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EC86E5A9;
	Thu, 26 Aug 2021 09:59:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E106F6E5A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV3fPpOtkY55wfKLm91A9araZuuCgiLXXXd56nnpZxsxcPZB+Jp8Pz+KhfQruEHzdKZk6hDmEF0mnrt52j/Smbf1jplpE93YpLvcmuROArY6Z7Uob3qwfsj6LRhionepo0/FASWlAhSQJn0d0YNkPRFu9iFL8zyIgKNNkoiiA/kU4Jd4w7+n1sWB6y6KP/ovcHmtN8c82ieuEP6uimI2ZTQDJ6Ll8YNqGXHoFABTRiZ8qDwb4TBcL0Xy/LzCLYxiS+jVgkc5y4mKISAU9VhCKX/P8WrMcZtXc9w0cbOQXY9S7L+AsKbzvMGZlCGXGYNjSMVWD2twMFidhSSeYIQy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSgJZ+0BYp5XnBPrJVybqXJTjUmqZ/W/wL+sFI49PB0=;
 b=a5NLUejPZ7iqABtYnb1O4OnBPWp6C7gjIfpvaC4kK4B4Jr6PuBLUONMpgWpjBZx0golnjswDz6diPb5PsC7tkMDJ13AG3CACE6XOKDivdlpHtZC8b9C6dxEgJdK31wa9ky9CpAGK3te/XWjFv6AA+mQpfJGvztfwWu9H3FNiTQg51Hsrv0yHtZCjm9Y0Eeoji3zQejrFvxYEdTt3zoCzBTQiItbWreoRZ8AlSgCj97ilK9kmr0LlVhDP6LCX8G64XNyCNYhUb2hXX4fyd7iY5FOQcS+nAcOyOESFpUPQ6Qhl8Z6PX/x/Qmz0yr9frD/3xcSisWAhgesKpGXf1Bf4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSgJZ+0BYp5XnBPrJVybqXJTjUmqZ/W/wL+sFI49PB0=;
 b=c8EexaLpL38O3pYVzAcbf6os5aQmNSvrFwucWZgz6+fupSnVjR1f0aPSStuXCU4xczeIAZ0m1B1Dp7H3p0rd9zd9Y8R2zp/bRv2aBT0hKQj6wwPLk2fw/qlpUIZCn8uxUNYm5ddsL1+E7E9FFFitYZx1Ie3I49j8U6czWVotgJk=
Received: from BN9PR03CA0951.namprd03.prod.outlook.com (2603:10b6:408:108::26)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Thu, 26 Aug
 2021 09:59:41 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::f5) by BN9PR03CA0951.outlook.office365.com
 (2603:10b6:408:108::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 09:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 09:59:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 04:59:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 04:59:39 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 26 Aug 2021 04:59:38 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct comments in memory type managers
Date: Thu, 26 Aug 2021 17:59:37 +0800
Message-ID: <20210826095937.1150894-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d892c3c0-73d8-4613-3778-08d9687838f4
X-MS-TrafficTypeDiagnostic: DM8PR12MB5480:
X-Microsoft-Antispam-PRVS: <DM8PR12MB548016937815FBB7157DA151C1C79@DM8PR12MB5480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQWdA2E4TtVdNOfAvyE4315aAiHZdEg5n+0YJICC26MpYjfGBSeeHoxsbmrTkAODI0AwdoJ+8VCf3yWEd5mwkGkxPJQalYrKycA8MJS66LKKaK3MsnsVUO6VDvQdGLUBSuePvwrcS7KtSf+6GJ0mityBVVAzPQIiK85m/ctyHH/8Tau9D9Ss6rHJDuzWOpb26h4jhe8h/WSHL2dlKopAbuo7sHGXRNmaGsWvi0q5l0AN0S7J7u9F1H92w+xvsw59G7+el3h463mevdZkgi3Jm83Kcrt43zkhP3wToqC/C9BTwIYtI3FvAhsWc7To9sC7IP4ErdbB/MYEx7Len2w7L7Xqp3tx910KEqZGuuW0biK6E8F/s7rRSzTouzlmNTntErpBD6UWawmBHUv1+FP1QvU3ghHZzyqTqTcPL9GFpSZ4R/u+lT88hHgjqNWqASymgg9op6Cpo8gVuqDJiJU3mWQgH2dvo/PgboRKK/iEU9p0d5Hi4Bwx49eFHR2KOZMb7ueRFUtW3JfRBzIUSHxpGeqEMkqFtZLnGzDiztTiEcmQE6aBwJ+JzFPOdiAaPmb7Cgg3+zE78pl8ikYUg3KFY8xyySRxbkPhEplxiirlIa10hyMPquoxAFB3njSMtxuoA71gSnx60aSLiq5BtsIjcjoc3ok9skYOQQDkns9DLHMyO/vqqjB9OujLUITMbCJMKurJib7eiUQan3EcjWXLiWIG8/R+fkRaJTmmxDWzk30=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(82740400003)(70206006)(7696005)(81166007)(2906002)(478600001)(336012)(6916009)(426003)(2616005)(83380400001)(70586007)(47076005)(356005)(4326008)(316002)(86362001)(82310400003)(8676002)(5660300002)(36860700001)(1076003)(186003)(54906003)(26005)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:59:41.0099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d892c3c0-73d8-4613-3778-08d9687838f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index ec96e0b26b11..c18f16b3be9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -118,7 +118,7 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
  * @man: TTM memory type manager
  * @tbo: TTM BO we need this range for
  * @place: placement flags and restrictions
- * @mem: the resulting mem object
+ * @res: the resulting mem object
  *
  * Dummy, allocate the node but no space for it yet.
  */
@@ -184,7 +184,7 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
  * amdgpu_gtt_mgr_del - free ranges
  *
  * @man: TTM memory type manager
- * @mem: TTM memory object
+ * @res: TTM memory object
  *
  * Free the allocated GTT again.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2fd77c36a1ff..7b2b0980ec41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -361,7 +361,7 @@ static void amdgpu_vram_mgr_virt_start(struct ttm_resource *mem,
  * @man: TTM memory type manager
  * @tbo: TTM BO we need this range for
  * @place: placement flags and restrictions
- * @mem: the resulting mem object
+ * @res: the resulting mem object
  *
  * Allocate VRAM for the given BO.
  */
@@ -487,7 +487,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
  * amdgpu_vram_mgr_del - free ranges
  *
  * @man: TTM memory type manager
- * @mem: TTM memory object
+ * @res: TTM memory object
  *
  * Free the allocated VRAM again.
  */
@@ -522,7 +522,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
  * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
  *
  * @adev: amdgpu device pointer
- * @mem: TTM memory object
+ * @res: TTM memory object
  * @offset: byte offset from the base of VRAM BO
  * @length: number of bytes to export in sg_table
  * @dev: the other device
-- 
2.25.1

