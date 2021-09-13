Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5824AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A38360F12
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A38360F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E196E14B;
	Mon, 13 Sep 2021 08:28:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362E56E14B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 08:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqDyUd1FA7dUv/r5hef4wOZS8R69wThVTAYq7lsfjtJuc1DA8Vt7Ullvz1hsc8PRNnqOcDlVuQK1yaEMvfX7cXR2EJ9V6JHTlKrRt21NdXudsgShOGnVwUuAaXgaux1cSp8X06faS3iBeqLrxtXnc8j2/U45LekNEhCOZzG1gBgZ1XL8rDVBQBkojfcn9oY48JoWtAQufKjyB+PP6Ff5n9oM75JBMYqyIn+V2dGWBzmBdaPhYsD5futYdsvGtUMyl+gj7Q1XIXgEAEkgPdxDWtoHRoxkALvdib5IuvvQuAD5r0zCi/a1l2mAgGRxSKH4CzeaWgYf8gU2ts5a7eEEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JXLKeahV+YQv+Y4LwvrCJTadIEMNedIqYSo/B782nQ8=;
 b=X6UufL0/LeIU8CC/jkju+7L1bBadNBZQ3XO+SCZIeOxVPTcZJT6pEB6LFNz7m7RRppy3758dO91Zh2JinMkEl4OpqAfg3I53WX6FLS0LbTTwA4LHJrS7u/uyokQhSJt+2sYibLa8SC04aHtCkTk7Xim0Ti+Ja7xDK9Bw1TdBBkAxxNSZO1EkA/XPG0JyZ33pVEyzD9jk5q/HNCDiAt721kCHNtmqm7Hh0TfgkCdlztJhcaLD4aicKcKbgW6bp1Q//UR8TfeSrUalbx1Ia0dNAy29DK4s4kw7xs5YYKPdRlbImN697cZ797D84roF9QtmDG+9aDYLzw2qVPfyqf18EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXLKeahV+YQv+Y4LwvrCJTadIEMNedIqYSo/B782nQ8=;
 b=uxsF9axxg0qiq5oYErEXTyp+fy48VDGDOF42clmUyELNTuMniwaxps5zpoZH03tjjlBsjf6wgasok5aq2wWm1NsXqUHDONu7XrYDmBxbecSOl6S+I2Pbq6hThOgbE5u211ehPFlnbHB0Jd+8IpjyQL+azMzpQOuCJ5rFf9sNjfw=
Received: from DM5PR22CA0014.namprd22.prod.outlook.com (2603:10b6:3:101::24)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 08:27:57 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::47) by DM5PR22CA0014.outlook.office365.com
 (2603:10b6:3:101::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 08:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:27:55 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 03:27:54 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/radeon: pass drm dev radeon_agp_head_init directly
Date: Mon, 13 Sep 2021 10:27:42 +0200
Message-ID: <20210913082742.20002-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1285601b-6ee3-4566-bcf5-08d976906323
X-MS-TrafficTypeDiagnostic: CH2PR12MB4956:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4956F4FF83BA4448C41BC7C88BD99@CH2PR12MB4956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmC00uLzRCeCYk7ZBtD91a0jUn8sWXuyyaucYEql4h7UgWMMw60zuPE68b9/pi2yr+HPJ1jpOCMNhaRMOSv3ZxXawWTXyNmRRcr+K13TlZ2cCkRS6WyOoWNKsKOuwdZ3wSjV1Wo60G3NFDkS+ElSOqUACPsH2QGcPCtxETzs109Zg3G9oiQvxy5JtqRYz1OZxEUzIuV6TGF/nXfjjMrHPhGUjBARq+zaJSlO0R1BgSSmLC3jSkkP1e/MiGioP97FOpVeHUsSzvwxArez++igN+H+3nnj53WI7ldY5nbd5ZH19HjR38jIGCh+f1KFxfDwZhS/kxinG2e3l3J5yWq59M3u3MUs+sxZVLCiZ1AZNp/+WXgYdNjegItQa6Rcq0/0ZwvxBbQI/f6AtHqlsN95XJxruBPJV+mK1r6CaiUIhKPPfKgtG7mAKW2GdzafA9L29uS1hLyyEIHLoAgBM4QDpWkb8yl/NzroNVSvQYFhfn9Zda35/81GMpioWp3YCzds66OHs9ls0JfHGbjkMuuPHVmqS6iab5SI8yvtcSZH2HXgdPiV6IJcexbrMdQiGyNNyOYkbNo2K38+XVdCQuLcOrAugScQDMsopPm5Wk6nHuVBzt73cYJxkaZQTWKpeUhh9WiaynpasFnpQ+V3HuFRPAo/0DYpystAYSBPgIZUyYXBsHKfYcw8S1BKyN64UFzVx2lm+KZb+mDJqfoee8p/dcrIE+PYQqXIdkgoGhhwRNKCzkcHlkE1dHhah/ARaHSBwjcry02eimKJgh94xmBUhUFy/TEQaXuXUUaQS7kR20stEV009pqldVzA06z3pvow
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(36756003)(2616005)(478600001)(8676002)(70206006)(83380400001)(6916009)(86362001)(966005)(1076003)(336012)(44832011)(316002)(8936002)(6666004)(426003)(5660300002)(2906002)(7696005)(26005)(356005)(47076005)(16526019)(186003)(4744005)(82740400003)(70586007)(4326008)(54906003)(36860700001)(82310400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:27:55.9371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1285601b-6ee3-4566-bcf5-08d976906323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
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

Pass drm dev directly as rdev->ddev gets initialized later on
at radeon_device_init().

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=214375
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 0473583dcdac..482fb0ae6cb5 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -119,7 +119,7 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 #endif
 
 	if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
-		rdev->agp = radeon_agp_head_init(rdev->ddev);
+		rdev->agp = radeon_agp_head_init(dev);
 	if (rdev->agp) {
 		rdev->agp->agp_mtrr = arch_phys_wc_add(
 			rdev->agp->agp_info.aper_base,
-- 
2.32.0

