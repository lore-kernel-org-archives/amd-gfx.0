Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC82C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4AD10EE27;
	Wed, 25 May 2022 16:20:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F08910E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNNqnhfO1xzPX2DG8UoZtAAPl0jbKltwuGUQST6iCGvW1DOC7JhYBsYAaOsqVWk4hqeId2q0hbyLabEouxNorrPi/i4UhCkSSrUhKIPoG26E2wq+/pSmwsUaVhncGZgFn4Q0IZ7d0MP9yiE11QhBeAipi78rZaKYwbKIOuFzoAwHO6+GTGuI3HoC6DklwerJPWFAKQbQ91EFnZpg0iU7TgmNMqYyax2A8KubkTxtg6pDBle0wF8geIc4AQBp/XVAtVvvCq2j8lutcZxbUWQqgmHTJnHQllEjwMNjk2gK6P8UCrxLE2z1UcxopCB/WX81kQC4CsLU5pmMZyL1NSnxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40nwGyMm4c2Epsi6URk/ssj+0ILIrn6nDhYi1aNWq3Q=;
 b=kuHFsimnvUyEoR7GWEdUhmrSaZMhF/RjWK/Pw73GnqV2ZgubTJc0S1NQvOsxBLwJ5TtKWY2Dy6CR3HQoy3Ii8m8eJQumFGFF0IsWMsBnmgsPvD7Z/T131/0+t0IHgQsCT+x55z4XE/ISN+QDwp0+eJ98wPkVexg5IXomdoC6qMnaaEUM+P1n4NL6bmc8Gr/is6e0eFce7+uElyBNHfmcM5BYQODRBxjp3TkRtpnbI18K2BmyNzTcHnciEGtztQuiaYl+PpiAroAPGDFnNjfTzPD7LJFGAxe7QUagnqBd4pU18aRdcA9n8ZJbPjXXXL1iUoQxasto/aPkuC90eJ/0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40nwGyMm4c2Epsi6URk/ssj+0ILIrn6nDhYi1aNWq3Q=;
 b=O4MB0iGd8eXP/7ipPZxEIBc6c8rbXdSls1CGr6Ejnm1wupgmQiGk2OgA/spexajBPBjLzH5Q6yeT+NQVoYDXvpQTN/SQrqAzQM9/P/p2G3VhtWIhEiHpGc5K0Y9juaaFbRQYWHQOOMbyIMxjXo45iM3c1oeiP5xrq03/c7beyME=
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 25 May 2022 16:20:14 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::36) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/43] drm/amd/display: Add missing instance for clock source
 register
Date: Wed, 25 May 2022 12:19:14 -0400
Message-ID: <20220525161941.2544055-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c52e643-7618-42d1-5b56-08da3e6a72bf
X-MS-TrafficTypeDiagnostic: MW3PR12MB4539:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4539F3F976FE9BB841159E0DF7D69@MW3PR12MB4539.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0afhZhLzGouO1Q6x7wCKo/+CrlyLOqQq3sI6jxBbPheqXV8KNJy+rSafAtxdBh8Xg852YrwpWhfPSGpe1wPdevThbUfBKD5L7g8dbm+kNUFMKGZVrFyJbErfMJDxSzUA+JCDuOcrGmSu2U11kiDM8wpmcPMRQ0sZWFMP5UsXmm36EW9qhn2SXw8Oy82aWsRqHjaD7NqsI8cb60XGtwWg6QzM934Gl7e1+bElEh5VMCQIq7brfq7CAYVLIFqt7i78caC3cByUVPfIecVTPVJotzueXKlR5pC6NPkW5iLkZQZIFA7FjtpDax79bLnmnrvFJMtni0A1S++cMGSeKgoAhT6s3y3Pj68UXp/M3vPFNpjww9bfhY6roNC20S6dr+V9/ye8HX1Wb7JwiZi7qUFFTl6Yg7bjngq64ZvrPeiC4Xb36AHKhqyePEeKfbrlz3uEGmEZAM7L8j/omK93cxVgkKwcdkF5mii2UuFFwRE8vpXx/40lwnnRgqiY9YN7xnOXBaaRSmnZgginoDpmiPtNwLcXiUpky3hKKxJsxkhrd733zhHLtfRAtxc4av2BWa/a49yqM4HpN07QejhkItunVQgiNIMvY1JRju6SvCAya3DKkdnsIVbASjFQRFOb8adyF14iWI8QjNS9VnpxcrwMwQ9o5nI4ft+H3zSAow+HOaNae2LQbUFgS+xCyoAch2fDAAVZ9Tln8YzhGg0jehAQGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(40460700003)(8676002)(70206006)(1076003)(70586007)(356005)(316002)(16526019)(4326008)(8936002)(426003)(83380400001)(47076005)(26005)(186003)(86362001)(2616005)(508600001)(36756003)(2906002)(6916009)(7696005)(36860700001)(82310400005)(81166007)(54906003)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:13.8007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c52e643-7618-42d1-5b56-08da3e6a72bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Need to add inst 5 for clk_src_regs because
there are 5 PHY instances in DCN32 & DCN321.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 7ac6428aae52..ca9da3d4b1b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -330,7 +330,8 @@ static const struct dce110_clk_src_regs clk_src_regs[] = {
 	clk_src_regs(0, A),
 	clk_src_regs(1, B),
 	clk_src_regs(2, C),
-	clk_src_regs(3, D)
+	clk_src_regs(3, D),
+	clk_src_regs(4, E)
 };
 
 static const struct dce110_clk_src_shift cs_shift = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 4db2cdf7c9e5..28e4d7904d54 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -333,7 +333,8 @@ static const struct dce110_clk_src_regs clk_src_regs[] = {
 	clk_src_regs(0, A),
 	clk_src_regs(1, B),
 	clk_src_regs(2, C),
-	clk_src_regs(3, D)
+	clk_src_regs(3, D),
+	clk_src_regs(4, E)
 };
 
 static const struct dce110_clk_src_shift cs_shift = {
-- 
2.35.3

