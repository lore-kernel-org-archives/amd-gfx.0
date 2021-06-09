Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3114EC47095
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 07:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77E161351
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 07:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77E161351
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884D46E3D8;
	Wed,  9 Jun 2021 07:42:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDC66E3C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 07:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1bpsKZJ/teqghdHRY0k05vQ3XMSQCxrG3GDa78p0Ybg564/LrK3eQlX1K+EBUQm24uGDT/leZQFjUsyH0/hw3ERlwrajzJ01y6Jgn89Dn60kWq4Javs/NS17WacJtD/+IHhbvk90a/Z142nzdP3Mz8xWXxJ4/wRojpbCJHnH69ArZ/54lzCWo7CUZIhUDKEOZZyjpvK6hJdOj7aK1kusehft4esCm4NVx8TdWua+KsUkwMsW/y+0Z3a+7MYZunNX46y6Xoe0S/mOOasP50e9NhCZD3JPmPvlKP7h1GPD116RpQEgVmD81OhO1h4bb1nqqS4OGiNJ/kmuri4M/tUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfjCBcZdbg8W9vrfAF02gflTo0GgxKq/CdfeWaaPS3o=;
 b=Gr05y51uC1iXBV0WJYk7xC/L6S70xktvn34LkdaZmbHy6dtvhaFLatPWhLl2UcOIFkVXhs9i5kixKw3IBc0t8+BS3unnCLnm76WvD3jIjxdlmd972/PkBC+gND9wFlugooOS4lBr3WATmg7UkKhnc2Fnom4TuCPcvU85dO539ob6l4nctknP0baTRGd29q3gdwqI5RcPHRedl0DZ8mDnYf8o7TASjsTSiZj3EX8u6puDT5+FMrjRR1DrjNhe+C4dkO4EHCKfcyjGlqPoRZANsW4ZAVrbjKYCEBZk15D4lAmnytkdCpLNlX530Icq9x7Zp+6NMg2p0NLpkIxjJUmwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfjCBcZdbg8W9vrfAF02gflTo0GgxKq/CdfeWaaPS3o=;
 b=j5cqv0ioIJR4aZKGk9MNQ5HYE2ABdi4TeqpLK7BUplcfSgkMxdLlspz5/W0CfpdftM3OU2Kl9m1MZ63LsQsk9K8rpSTo6GdjP2Pr3N+Xq1f2Jxc0SwGEs5AwClb1KGP++N6Aku+wMQYtQVESvz/S3NU5hD5D21f/CH/J8XrWL3U=
Received: from DM5PR13CA0071.namprd13.prod.outlook.com (2603:10b6:3:117::33)
 by SN6PR12MB2606.namprd12.prod.outlook.com (2603:10b6:805:6e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 9 Jun
 2021 07:42:25 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::96) by DM5PR13CA0071.outlook.office365.com
 (2603:10b6:3:117::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend
 Transport; Wed, 9 Jun 2021 07:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Wed, 9 Jun 2021 07:42:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 9 Jun 2021
 02:42:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 9 Jun 2021
 02:42:24 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Wed, 9 Jun 2021 02:42:23 -0500
From: Ashish Pawar <ashpawar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu:MI200 PWRBRK Driver change for CRB
Date: Wed, 9 Jun 2021 15:41:48 +0800
Message-ID: <20210609074148.2497241-1-ashpawar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db10b169-e689-4deb-69df-08d92b1a1fc9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2606:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2606FDB21BAF0374ECDE2BD38E369@SN6PR12MB2606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJ8VdB6/4Y1ccU+iWlJKYhZRGaBa9lQkCNqoX0WwP+1CMIv/GpGjtzyH5gSm/DSnk3T390V1yBfx85o+a0fCZEG6ZPrX+zvc+/qUMPintvh93onl0AN1q3NGozm6XEnwBuuYUTCdKQysDYulrlDNzBwD30ncOdLgS1xu+I55s9etGDmM6KXHIP45NHOtMfNbM8cSfMGhxdyi2eRhmcv5IoPSvWYN5SuEranVghaR9da9rQYsP3/kvh22hpm8uK06yroj7F3ju+mvU/UfrN8/Hnju8mNjmauyBnoDq3Tu3dYJ6wrV3c3WxCfIkotGO4CsqlO3fAFqf8GLV+XCBXN588DB8bZGDj9pwBmTCT+mbVcY7nARI2zlHw0Vb4Hia493oRzUZahxfjmAf81doEbmOfLe5NN7PReSkfJc48ihoKMpDGfVUuiTViO0I4mPl5nlzKGy0mCoMYX5wMwzMrvM8QBpgWMOcB2QN+g5A1iMV58krZyTPR3kS5eAUOTOWXUe6NdJ6DpAsJiUyQrUhGoBuhDKvZ/Fd9oDqc4PeWKCJBhBs9cdQYXwzOZkgpdyNsUCid7f0L8e5OGSXi6voURxgKdR6ByHT3OWw6omoP6E14DBLHXxBTCBtmaADESqZ2Zp1IHxQSq/lsyUmTdTOQiGrq1UMuVIl3jau7XgugSjYXrTcl3k3yw9WUeRZzfi6R/f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(316002)(7696005)(82310400003)(54906003)(70586007)(186003)(1076003)(8676002)(5660300002)(70206006)(6916009)(83380400001)(8936002)(6666004)(47076005)(36860700001)(26005)(336012)(478600001)(2616005)(36756003)(4326008)(81166007)(356005)(82740400003)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 07:42:25.1083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db10b169-e689-4deb-69df-08d92b1a1fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
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
Cc: Lijo.Lazar@amd.com, Ashish Pawar <ashpawar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initial changes were made to add PWRBRK sequence to driver.
These are modifications for CRB

Signed-off-by: Ashish Pawar <ashpawar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index cea641727e17..2641e1b2a8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -785,11 +785,6 @@ void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GC_THROTTLE_CTRL1, PWRBRK_STALL_EN, 1);
 	WREG32_SOC15(GC, 0, regGC_THROTTLE_CTRL1, tmp);
 
-	WREG32_SOC15(GC, 0, regDIDT_IND_INDEX, ixDIDT_SQ_THROTTLE_CTRL);
-	tmp = 0;
-	tmp = REG_SET_FIELD(tmp, DIDT_SQ_THROTTLE_CTRL, PWRBRK_STALL_EN, 1);
-	WREG32_SOC15(GC, 0, regDIDT_IND_DATA, tmp);
-
 	WREG32_SOC15(GC, 0, regGC_CAC_IND_INDEX, ixPWRBRK_STALL_PATTERN_CTRL);
 	tmp = 0;
 	tmp = REG_SET_FIELD(tmp, PWRBRK_STALL_PATTERN_CTRL, PWRBRK_END_STEP, 0x12);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
