Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585A8C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBC510E27C;
	Mon, 17 Jul 2023 15:59:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071F010E280
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUDursZoJTY9ec+uwFGwpoYvn05a7Vp7n1qxy1FONgs8jS3p7Fn3u5lEHM0m5kKVZo/Q4Q4OTb1tdZh4nvIOiVfolD25aeW7gEJ9K1clZw+RbrPMTcN5lKvBH3FZ6N9DZl/mgEPXN17LtUQHrLkc4kNG466VQVoSS4086GahzXaVfKYiJmMVRKol62Hg2N6TlEQDPm7dQatENB2UC6k5H0KC4LJlJP9bguCzqUckasPMYzT6lVkasI1+0HX8pA2Y59Az6LR38qZUPhdsHd5kUbyJ6egj2S9ykpARRD8uiFO93qq93dUC6UuyjjYhyop+eAOw+0TPPu4VJXbPVa6Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJg+lCw6Tq4SkTwIOCnPVpe+uct7q5q4O1L/+X6reTU=;
 b=CtZhp/8p/m/q8LrJyJH29y/7zAhPKFjgnNwwv2qyqVPcLskvJNE7jcry0uWfynUMpBMGU0vYfH7H4mHdn28pRmsnfqhnuqvcINwf8SrBnVrv+ckxe2fAHU1sMrTFtKmGFYRArwlVrw1zCCtwAdhOEZgTNFCfdoNLsnghQhLO5PJkXG2nXdZXhZ5wMCnwVA72ba8+ZAnAXr0w07wuQrUZzr1ZjyOW9Cg3MXTtFSod4PyfMkfyktQRh01XBPao2Um2ozzM8Y9CMXpTfVHyjjzInov3/nY6xKrWpSsS6/utDBqMWIp+qkxQV+kjcs7HrdftpOrC0L0HZA8333n6eQSVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJg+lCw6Tq4SkTwIOCnPVpe+uct7q5q4O1L/+X6reTU=;
 b=WYGsfVwKNlKINVW9KSsecBSYZ9V4KDIxCzwuT0REL6+9eKTrwtDwt3U11mdjwO7gWXUP6jOugqwn6YecKUhyVJ+VhaJMAaDUSXvbKFvLrZKBLfLJI6YJKINo4fNmts6EZ0RBCVmLI6N9bnMz0Pj8hiSTYwHMLPnxqvaFMOdOMMA=
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 15:59:15 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::6f) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:15 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:14 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu/vcn: mmsch_v3_0_4 requires doorbell on 32 byte
 boundary
Date: Mon, 17 Jul 2023 11:58:38 -0400
Message-ID: <20230717155841.758516-4-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717155841.758516-1-samir.dhume@amd.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: f373757a-3b6e-4dfb-3503-08db86dec57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swtwiPi/9FQMZlWjSZAJW76i9qOIkXsI2yKinl99wos28NtDRCE1q/87JLtMfTGXQ5eSwnVB9wJV5w3IlvIusmu6vrJSoetcOVKU8jiXYqwDNyH0frmTOs0CRnnJTQkKR25ZvH99EdqJdX8JsQsuHXM6wEDVsJlMUyzASn6TuF0de56xjkmrS4KSJeFtQf5WHiePqgCl3CK7QbnH1NyVZwj+fLHPPOeKiYGlCwmv73jfbq540q4/YMRqlZG0+qM1WxPHwB5jIzszhJEZbsj6J5XpDfPCBqucdk5NsMWVlENkNoeO0BGcPv0GESuzRQdPAyQ06dt7tvUlsgY8CPxuedU5WxghGErVrXYpq7NkQ7zKXMcqFRSAXlTYFh+npIZfpZFdtgVwtBIq08CaQG9z2r4StQHaQheuoTyaK7aevF81vMaOC5BR7zbx7CCv6kmuZ0aEsZFuiYgFX1+5DBW+xpcRftWUSuBiJjy0e17qD4sVP7+TcKwIYYJt5wkSI/QxGXk4d8iK/6sLQhljb+ml+QB5kckqKHjt3CXcnVNuJ38EXFQYTky2pf98ypeIF5+zSYsW6bjGWAmZ41kIcMHY8aw7+TL8fIkiz5HUU14XGKqJM7JpB01Oeo4QYScc5jZZ87EhzZ7+2Acwc6K3Fz3Qw6istKVqJIxqycyMsDi5aGDsN/L6gLA3HlKnSOGWOsUG89x43/IyP5dZfVKx5+wlI7YgTZvCtpHB+FxsLwvMlGaGol3x9ZP3cvnwW3sYfjlsq4uncCNMQdquB931vS5A3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(426003)(2616005)(47076005)(7696005)(6666004)(6916009)(4326008)(70206006)(70586007)(478600001)(26005)(1076003)(336012)(186003)(36860700001)(16526019)(356005)(8676002)(81166007)(82740400003)(8936002)(44832011)(40460700003)(41300700001)(5660300002)(316002)(40480700001)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:15.5633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f373757a-3b6e-4dfb-3503-08db86dec57a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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
Cc: Samir Dhume <samir.dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ac405dfcfaf1..fa9abcb08c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -113,9 +113,16 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-			9 * vcn_inst;
+
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				9 * vcn_inst;
+		else
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				32 * vcn_inst;
+
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-- 
2.34.1

