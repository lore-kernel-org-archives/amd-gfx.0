Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E0DCE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 14:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D467A10E02B;
	Mon, 25 Sep 2023 14:44:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B00310E16A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUHgkTwgcNvaouyPlrewfsGl84Oq6iF8GVLd/jse58PW1bJ1jW3y6g/NjkhTM/QNFczU7YFW5NcvqOgxN6sraOHZCJDDt1llFUlRp3xDENH53Kk8WECLRvY2WY7xyNvm4FR6x0yy1VC+qrII+X1LWgh6/EdM1hlGj4PY5d4db7F6T3+rLHgZLMGALb7UP4t54Br09eZrJwfEXPWQGcviMU/bxTflIoRFgigeztL6R9HkU0EjYziqQsTbtWTKIJ73fmzpEYdaWNR760Fi2ckhp2EA4QgHr5UCz+TWUTQPksi/akJzuN+aO3FopU56yAoVWEdgRmNk5mpNQZz37z8Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cABMod3h17A+rzYbuGjFrKMXk8vOHHsQEm6L/E/iTQ=;
 b=dvmCp46w7hocR9P5DHiUd7UtHzAKVdGqhaXxNmt6ZQ+rsMniWjR405fFll8Frx2/BFiMtkmfXbLYKr/yRSDTKubXBvhbMiA1o1NAjJ8Joim1SKyN9BBy58NtsdM6JFmPEcAcE4D/UDWUM27p/MfB0RYlb7wXMMdYmQlP311UQzLnf8Lug5Fq3LpvdpelwwEofTuC6L5LhSdg6yDBroQbUtBPaadH0wAJf5Ue8R7ta5CxOrSbVpc+ugjh65CVewjCd82VFJw47okyjo2PjvV1ONAn/6eCdQ5RlLBLzgccHzPQZVV/iYuW8Juv20YOcJJr8a+0Wz56eWoKbkh1TzMWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cABMod3h17A+rzYbuGjFrKMXk8vOHHsQEm6L/E/iTQ=;
 b=0LmfmmTtbbR7jPgKv6ytBsjXDaukQDB5AxAjpKtMQNBex6HB9B6ywYS/44q1i0JtRg0Ns2iO+i/EMARttQOvS5FJlqOLcfqFN2uWm4iBf6zmA6OxA0FOcvg/zrCWQLlXsoB+Ojjwq3CzsMeJucnDl/1rljga5bC8Hhw1pkUFGoQ=
Received: from SN6PR04CA0079.namprd04.prod.outlook.com (2603:10b6:805:f2::20)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 14:44:22 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::9) by SN6PR04CA0079.outlook.office365.com
 (2603:10b6:805:f2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 25 Sep 2023 14:44:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 09:44:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/radeon: apply state adjust rules to some additional
 HAINAN vairants
Date: Mon, 25 Sep 2023 10:44:06 -0400
Message-ID: <20230925144407.972554-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BY5PR12MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: ea57ae65-4653-4e54-e763-08dbbdd5e7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rt81gIZ2gfd2XgTskwXkhCHD89XjUHKCsY5CdnqZwLxmIAauv799YKiavdrxnErfSpiJ1YnTER1BBgJVEayxIEa3Yr1t0LGPusrdLq7yeD9QTL0Mw8jHJ2VfB324mnoYJNXT+3p0qLiBbp1mHzYVwAPkLVznVaQwvvFOkD2w5yW6P5uKoNdFr6TyP7/XRGQtBQtkUNKdSF4RZxeCmnw+D5f2FYle8APzKN4SLYCtL/vH23WxbUhXXI3Va3uvNgyyZTroVTCGWn+ir3YKlioJk242igTHzy6NOU9qsPLYjGY0ZmBQPZyJcQKProynQyGmFpGcbh/eZKekMI0VSZoH6OBNucqwEYwnFQI/bOidqBvlK02btX1gG6d+tWDw0I6gnglBhwNJES8n8nbUme39PVSTeMozgqF43ys4tRkeASwhNhj+nquyqBwmdd6pGp96CX1XJ3Tc3O+CcinsLZg5fwegwD64eLwpGKqoVRcNfZxu9mDfnW18cdyqXN+piPBq+bJMmwnIJEWEUS222jNq+WkQ3Ade4/QYH8UXW/Jh7qDB2UMpTd24H9yDylRq07Jrgrtrqk8N2hEZKPkc2ydIT/5jikkGWM9cubBJgbgg0wI4IfHYbyySoR60oATfZ9oEVwhxScbl1QXvYZj/mzdhB5V736i/6GIsqlYhLg9rkTzQr9Zs4fiOBbvpD7CjaZZUGupSER2/SSqjUsmFj1n/WAqCcRAJeW9hTfN4CMeXgX2VzEvLuijW9yqrmO5cIADAV8ZALhxrO9Mq/5z8vOw3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(4744005)(2906002)(5660300002)(70206006)(70586007)(478600001)(966005)(6666004)(2616005)(7696005)(1076003)(16526019)(26005)(336012)(426003)(4326008)(8936002)(8676002)(316002)(6916009)(40460700003)(41300700001)(83380400001)(81166007)(82740400003)(86362001)(36756003)(356005)(40480700001)(47076005)(36860700001)(80423002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:44:21.5508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea57ae65-4653-4e54-e763-08dbbdd5e7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

They need a similar workaround.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index fbf968e3f6d7..8afc4fa73101 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2959,9 +2959,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 	if (rdev->family == CHIP_HAINAN) {
 		if ((rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6660) ||
 		    (rdev->pdev->device == 0x6664) ||
 		    (rdev->pdev->device == 0x6665) ||
-		    (rdev->pdev->device == 0x6667)) {
+		    (rdev->pdev->device == 0x6667) ||
+		    (rdev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((rdev->pdev->revision == 0xC3) ||
-- 
2.41.0

