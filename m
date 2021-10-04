Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283A26138B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 283A26138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31126EA87;
	Mon,  4 Oct 2021 18:22:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263406EA87
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 18:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWAeaU97pVEMEex7i5qJd/Pq1MhABBqVz3iHQVktJngRyfmGPmyrtpYEtnGHe1uoTys+YnsT5SNOtEJUVvZfJ+G9pz86og9Q2V2LO7oC5rUjK1TfrDhYfsYtffSQPBm2CU3bjp4L4eizAnRzSYnTSulAe9oRTpc3R0w4Um+5i+qVu3dQ8tx5tQsp/W3by+DacbuCws+7L0/myxLZ+gKi6gYAkv4bwEVSSyHBb8ao3AIASxN4tMX6x4ytyHLn8tudh9Pxd+ofWIlKtBEMfIWgKpUd1dpyjm/hPGRMkt5J1NzV1F52CSGvVtjp4oK+jXiNR2QM7tlxybaAGzaqQfxQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0yp68qSxi7m9xKfenyes8yUOAxwt4gaRysGdrRCN74=;
 b=CJzDpaG5Bzr/nIHAIG7kIuAMsJedYSZeFS2MIEH+qiOgRL2x9VzOEIw6iI04jeyvZwxPgYKCO1+SmqqJpzKmDr4Qa4TzhCeD0GqYLgKLBgXltAaY1UvdcmvE1DmNYqff1FYjmdzjbqtSbHefvDEdc9eE1AbL/LL4vW0IUJxCEW69Rv/wuKCL/pTJL99N3+dt6u7cjfT7UjDkEsnePeKBYUeuDQYhNTYwcPuHYxuPlawlLzwO+VV8/aLQWqovap9fipkkMGOqOXCST0C2Iy5mMrscBMKELkMN2fNrdCuXRgfslN1ouoXyt2aHClFp9TireujV9M8qH0Kb5RRyPqpnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0yp68qSxi7m9xKfenyes8yUOAxwt4gaRysGdrRCN74=;
 b=NNpOdHM4xqV6OYMqkXaVXBHeZXaRT57adk8eYil61Vivs0qNQVuf2HZsBVM1CdM4a1a99NS+TQv+uR617/lFBMpfAJdxbHmzLxXRUFAA7GJYiNBy5h6La9/VJ7+43i7rLgP7zkn2zeqqCmFp6+lZG6YfZG6eJSFY3vNsxSrMhho=
Received: from BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Mon, 4 Oct
 2021 18:22:34 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a3) by BN6PR17CA0059.outlook.office365.com
 (2603:10b6:405:75::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21 via Frontend
 Transport; Mon, 4 Oct 2021 18:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 18:22:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 13:22:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/amdgpu_smu: Fix IP version checking in
 smu_set_funcs()
Date: Mon, 4 Oct 2021 14:22:20 -0400
Message-ID: <20211004182220.2385965-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d5e5768-4f75-4a4b-e07d-08d98763ef7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4636:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46362D1FC772DDD3B60CED2BF7AE9@DM6PR12MB4636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znq7gYwjdaostSdxqvbf/5QdwFWwf/b1aV/OyOMAyVTK5zBx2wpDiWhy0TGGEkr0NupFeyha5bRhfhzWyfYXPbnthodZK0i99HrWRK9EEX2/HL1O06HhMbZS/8ZRL6dQDf7IK++7sewMm/L1sjUN9rcYtGXznTDqQ7Sx7h97M4jacpcAJMBlDPOVjPmQKX2Df9VKAwN9+LHtt70EV7Bd2F5UMORkPvMMeIhmCgmTY5pl4X36OzkTog4cjoOYK0GkRMHrDi6eSYqQVYc+mneMTOdoTb6TP5OyGgOtte4iT+zN3cnsRo1U9TZ0501cBTomaPgQ0WW/amT/nC07Vko5Fs+c/LPmEUJ/C1pmHp/qpGSzUL5Llx+dJHj2PruecndEyflVaBJA3O9H7HG30R14giCuXHQ9tFTLLhfJPFNROXhBayQy7iwCTHifkwiu/MhUyp9B4BwOMuRmd7lLrS87RXpuvrdSSkqfawz9c8VLxA7Wdh9ZgG9t3tgttcaLmgx9mKFstQdwz8hXCprCqffbr5XzGooFwIXykL7GoKlqgSsA2NEcqtNjKEbKmJc3G9DsPRzFyHncRYv4Ioo2G4p7zfLhGZ/o0j73D6fVXp4wqDFrXF22jqGUjhzO2/Gy7d6o0ygo5UAYP9WaSWuD7iiuMa4x9mHkQL0ac+jorzDTLwptZC4G0RR9HfHbzjkUW/vjRbGRt40PQTIx5IDdWPZxlMp0ioHgcaPIn+JJa5F6BgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(84040400005)(36840700001)(46966006)(2616005)(16526019)(508600001)(2906002)(70206006)(426003)(336012)(70586007)(5660300002)(26005)(36756003)(4744005)(36860700001)(6916009)(1076003)(186003)(8936002)(356005)(86362001)(4326008)(316002)(8676002)(47076005)(7696005)(6666004)(81166007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:22:33.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5e5768-4f75-4a4b-e07d-08d98763ef7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
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

Was missing the IP version check for green sardine.

Fixes: db95b2bd598d1a ("drm/amdgpu/amdgpu_smu: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b633f202b466..4ea7e90ef60d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -588,6 +588,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		sienna_cichlid_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		renoir_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(11, 5, 0):
-- 
2.31.1

