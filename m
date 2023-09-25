Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4864BCD54BF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767C610E322;
	Mon, 25 Sep 2023 19:52:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EB210E31B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4CEWgz+IvBGWNUdtbFGhd4wImQWPe/30g5Cc7sFGUqSB505/MYrjWdf4/WFrLuSS6Qo4KOg5tr1w3pti63zQeMPMpRt9dXo+KtQhBWiDo4F4RruOTLhiGWQ8PxhE9vuXb1kpak2/thS7nQnmT9hf9ckDDBEm+OEaOmq44hnza5+9wD8+j36cl5MJDlNLHuPw37Ri78/zdRPyJBkSL7AOy43X2tHMpsaJZaWllul3DcPRoiXNT+9iGyJ6nJCjpNpVykdxD2WjTsnnfyBEFy+F0hVU3DEx2x2ba4qU49YW+71DYJbhEud42Z6rZET8aAwD6pKHqS6iRSUdsKaPPxKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/WNVEDObypdjhV029rz7UUkvxGMrIuSkb30aG4JY+8=;
 b=X8ehsPnZIKSFhohK3JIx7o6dJgwZoHYwSP3LnDwP3VIkTd0gdQGuBaMMmRZppsdtgCSOD2nygpsBU1dWclxR0E9+L9SsqY0LRDbLHl+lQVOchcEcOuaV5OLQ8aW9CFZjvPp4q8OOzchkPDCV+d9xcpRXYeiHGP7raVD+hvO+IL3UHhilC0aqa+bteqBC1LE/7Pbpdo5daXz0cGCfbAO0BKOBMBp3DsR/0Ul+LaZEztUS4fan2KTP9qc/KqAuL3rmAdMBfOLWbKX4EqMFT2TRs4QWjkG/z9a51TQbJgM14zIq0NzPijB1Fei35z8e5XuQNHt+uQvaX8iBrOPLQe2vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/WNVEDObypdjhV029rz7UUkvxGMrIuSkb30aG4JY+8=;
 b=UI1oTXji+YrKmjR/qif1TfBQbcu2xTDPKQDwvPcS4V1sg83IAVynIMF4burQl288Web1fxY8c5eOwogNu5jQtCq9tAfQqMQrQ2pbH3IYNGiFMHXV0hIpLu2tokMPTWg+TLcjf3vS6X/NcJFfNb8s1Jr+ylaPQvl2M+otT6R2Qyg=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 19:52:51 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::72) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 19:52:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd: Move microcode init from sw_init to early_init
 for SDMA v2.4
Date: Mon, 25 Sep 2023 14:52:06 -0500
Message-ID: <20230925195207.124850-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: c0efe17c-c0e8-4ce4-ffc9-08dbbe010004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYwJsMBMSdXCXgPuT6L8kaT2iwkQ5jfP1Xvj/l7cJ1H9UB37yEdI2/I15upha0mbOTk0Y13q5LQESljeNyTRM/b6kZFVDvDa2cgWui1sDEBVtEB0CBK0AOMb5VYwoENZUzIYT0/lFbt01RCTdxf5JZOeo1C+nNfwAewnkRa0CDY9jgYPcASbmDI42mD6lsp2ahfwjSrIFTtYbyqid7CgMeqX/ND0P//swWYuJIorel6xfdbMQcUA5CYuRTM5WVX6Ly/4jYypLLauu8yo0XrEgWcTJPkiE78ntu3S52E6vzCo1yR9KEjxa9b0TUq2Vb0I1CzOmdRM5OPqcRVy57Rr/A7N00qlbGnMxz8kh+IJ4eqo3OuVxnE/PuFX15Znb4oKmG+SMjeFD0t7oaUJrhUT5HtRkmuHvZhOz5zxgBivvAAiJgkmZBgJG+a1cnP3Ij/eVvqtzfy5ObEwLqXPD7qm4PDmlHHyDzrr5zyRZaMM2ijX6FVLrcaXtNTkafceVqhMRJq/m6hmD2hInBOSzSY5mLVZM1Imq9QG1Ws8MfUz8D6+3fq+T7yyNttQ3bil5Kcqd2pCUjS4/7IgK6lEFIgrd+9A1lKEOlfqsrkTpBpbeTkjJ6WhS+PFnCUQ8IgZ7QADNWQYZtTfRRgR/bcFAVGQnRzc2xwED85cGH/EJA9mRD72otZZ+Y0FPyESZdXapQZ+ygB15ilBjt5D3wPhCBwDVjztZJaUmLftsOp1sbXiPbo0x0jPryOvC3iVeYDArfJYyLiA0SUIy8n5nw69D6HTwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(336012)(426003)(82740400003)(26005)(6666004)(81166007)(16526019)(1076003)(7696005)(356005)(2616005)(40460700003)(41300700001)(36756003)(316002)(6916009)(36860700001)(70586007)(70206006)(2906002)(47076005)(8676002)(86362001)(8936002)(4326008)(5660300002)(44832011)(478600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:50.6223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0efe17c-c0e8-4ce4-ffc9-08dbbe010004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of IP discovery early_init is run for all HW IP blocks.
During this phase all firmware is supposed to be identified that may
be missing so that the driver can avoid releasing resources used by
the EFI framebuffer or simpledrm until the last possible moment.

Move microcode loading from sw_init to early_init.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 4dd944a93cf1..b58a13bd75db 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -816,6 +816,11 @@ static void sdma_v2_4_ring_emit_wreg(struct amdgpu_ring *ring,
 static int sdma_v2_4_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = sdma_v2_4_init_microcode(adev);
+	if (r)
+		return r;
 
 	adev->sdma.num_instances = SDMA_MAX_INSTANCE;
 
@@ -851,10 +856,6 @@ static int sdma_v2_4_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = sdma_v2_4_init_microcode(adev);
-	if (r)
-		return r;
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.34.1

