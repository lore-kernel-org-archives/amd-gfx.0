Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52242C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8664D10E9B1;
	Fri, 14 Jan 2022 03:36:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01B810E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+jb4GvosvnkvMtG/pHpxvcOKXTVR9fy7KBpeWTqFuif5RhK8a/P1+Kuf0AL/DGo9/Rsve3d6nZJVDshNz2E8iv5EVmzcwb1pAUay6j7LwKCK82RbkKFm5H0rKDKpFNjUMI9dkp5PuU+r+nC3zUHbPmy/w5kLshFZb+sLzH/Lzk7dpZTmnjOIt3UOotyulLyaiYvB2kR3cfIsrjruy9ULSLOo4lewDPnE71Rf8/2PS/lFuHKIxpobm1ChTZejRaAvBZMqeKGu+bTUamaEI6PRTilt/eqjLIdF7ugihYoXWTo4m7McAwzVut66F3cPJ4X/HGUkjw1CVs/7hzQp5hwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtnlhZkYT2fd1KbEKnjHz2RzbEu3ZTk/Ge4+hwWcgQ0=;
 b=MN8RE7+7EOgoHlutD3d3W4bbxApfdo5StpRkc5yahujQZPzVstDWwoOCj9Y3gyoYNkOclHBqxCX1r9GG1GdimvdY3kOcwGDtvETfVa0CELwHTrPya6fDU5ngDHl7JzUGCDUhcKqH9VK1c2uudhQr1XNPvnO0llUYtGGs1XVtEs2X9CG38nhnYzAgRlQlgCduf9mXfgHCM2l53rl5aOWAHCnyU2EfouBUXGS2+JpW9kUWHugxWetBROjdZfAczr3ZXIg6TwntQZYqNQbp6mILvIC52V7w3ZNEs4spOWXRe3ksy5Gig8vLzlv6TVScba5nL9B3ImLRTbJf3u78VDUhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtnlhZkYT2fd1KbEKnjHz2RzbEu3ZTk/Ge4+hwWcgQ0=;
 b=RH5PCCk/OGPHazChec0Z01Hzrjv9uYG0V/f4YPOI1TKKqXqfsXZ9Ftkq0Ce6Ecjjemt9eOBei3RLu/yg2u58Ap/Vuj8q0uygleAD9sTjAzyrXfjJCljSRr7pISGjXPYAEddajh+ugTD3y6/DjFvRbng33tyDvyrQqFrY+lxjtRs=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by SN6PR12MB2783.namprd12.prod.outlook.com (2603:10b6:805:78::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 03:36:42 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::46) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 03:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 03:36:42 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 21:36:40 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: Fix the code style warnings in sdma
Date: Fri, 14 Jan 2022 11:35:58 +0800
Message-ID: <20220114033559.4009592-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
References: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca78a316-1dd4-4018-4458-08d9d70f1500
X-MS-TrafficTypeDiagnostic: SN6PR12MB2783:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB278353A5138EAF054B791DCDFC549@SN6PR12MB2783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwDR/OF0PdI5cPHq6isypZQGmHX8O1/kjXPocBm9UUpNF1U6p905GG/ZA0NJYP4VFBcMZ8zo+tpsw0zmFnXLS4sCHrrAPXVIRQw9w9KjWZyYT+8g9Oabs4Vh8XLCRFL8ovfRf+b91QkjavTc+kaDLEkE5XvixFOhezIxEhGfbO+FF6P2DfHuA8y4CgzI1p20CPlejf6nKVQczIkihw9tnFi8Kf0eEW1M8gnzDEdaM2wS1RN2UgQLjDjK3mywPCQblEXMpTas+Y9H50yTuvTtqonCIqQFrOnLVfoRYbGNY7HCX/8ny71m4DwNIWbGCMm10eqAp4fRAh1FqOZ3tv1OPpfMvGONbEZoovQ6yIrwJRA9rhUsVgxEYWpqot8kzKky93IS9ApqO9yT+YbX58ve+QgNPGbqvZEUB0m0FGTFFuS9cHbak/WHgiWuUe+Ru51uuLV9RnIwBwe5Lq0QhJsj7zmsKCLnyJC3ssx0oNofsDZYH76qRrp4XmZDctAe1QiBCl3cTvRHm5maMBwRY6VXrGciwb6vWKT4ayVb2goA8ult7ZvsmxxO6B0FB+b0myKOfcHPJq9/ldIRHDuel4QdWGUBnn2ft5RHaZzANQpW7vjyvW5sfvn1FNcBaIQA2O6y0tvxwrR1uEQGxcnTxcluQaZny7ZMJrInbfOftgxUoyevu+RvBXIkUveN5aZ5p3KJ7QKzlBar9mkOssu6hOVfXf1q5jgd8U649IcAer+Wo0tcAbBJzGfrp3DQUuUjIE6AT4G9FX25Foq2cqya2HGujZK0QbEpzhT9IsJXYOBfunXhox6byzfyWeK0vsbaEstR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36756003)(4326008)(5660300002)(2616005)(36860700001)(8936002)(2906002)(6666004)(508600001)(426003)(40460700001)(83380400001)(16526019)(356005)(8676002)(70206006)(82310400004)(316002)(336012)(6916009)(1076003)(7696005)(47076005)(86362001)(186003)(26005)(81166007)(70586007)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 03:36:42.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca78a316-1dd4-4018-4458-08d9d70f1500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the code style warnings in sdma.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3c1483dc113e..e3f00376a2b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2767,8 +2767,7 @@ static void sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,  void *r
 {
 	int i = 0;
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status))
-		{
+		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status)) {
 			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
 			return;
 		}
@@ -2814,7 +2813,7 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	if (adev->sdma.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
 
-		strcpy(adev->sdma.ras->ras_block.name,"sdma");
+		strcpy(adev->sdma.ras->ras_block.name, "sdma");
 		adev->sdma.ras->ras_block.block = AMDGPU_RAS_BLOCK__SDMA;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 5c1ba1116e5c..5c90f456ece1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -249,8 +249,7 @@ static void sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,  void *r
 {
 	int i = 0;
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status))
-		{
+		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status)) {
 			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
 			return;
 		}
-- 
2.25.1

