Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869CAC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 19:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E187610E542;
	Wed,  7 Jun 2023 19:52:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC2C10E540
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 19:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNfjpoWQ6kEXA3Z+KYKUOD7LYuLGHHm8gaBAJqmXesBRWk3y2zPJPWOCrhRvnnTiwak2aGlnSRs5qxy7ylVixb3Eb+KX7X+nfFtWj2ujpkQImUo5oapnIkViJ7VBUMUBTAz185HlJXckesd9RS+uBRoHMpia1q95zFFpBEtIJ++qUr0IAWIlzrriN5DJlKPHxbt7LBjynfY6PrN83DpWZKW581M/QLNFbdhr5QEdqBptQWolaJxPPLxwTXeHPqAqyJ19YhE90B2ypTkbn6iKRVK9DrmPqTudlPDNpFOo/qAvreDqiYuKt8qzs/PYt9vitz/HKPqWifJJbnA3lCKlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eUh29b3Eh6R5pINI2hxv3GY4ENizhnk+hDeNGS6AwU=;
 b=bvfnX2SzVEHW4VRShxWwF92O6g3qQbYDm4Mbn8ke08YIrccHy4FXeNDG5ZajdZRivrXX9rQySXoA5GpI1kekdReWOpxLIRsywWqUye/+dtqKpMLLPcxqE6pqd2t04eVN9KRhZTN48dTvPtTQ5QPZddukjK+9re4nQGTl+yVzr+ZtFsSroLKfMShU4fr0fu7ekRrOw2JJi2WqcjsWQ6UEql+Jzn+ok4obKjKjWSbAHcEhqIPbBq7VynWNSqjuI8OSgl8gOdvW9yy7+M980Zu5RmE6s/ZHiOSGYYThNj7tSeBnq9fn5D8jOQ8fDu3ss90odTqmVMxK4tbl1mz8YiebOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eUh29b3Eh6R5pINI2hxv3GY4ENizhnk+hDeNGS6AwU=;
 b=eZWgyE2XVAYNWVGnAzKggvnER7XLqR0U5PrJRlh5cJJ8P6Cf1/MkHBuUsAhVJPsWid2dUwGiRzKWQWo/UxhxTw5l4K2YP/56GSd0IE2wx8dWSP0l2BDTm0YE7aI4W8srBDMq/9sANCLIrUpuc6g2aRh8zCK/uU89UNudZcTOVGI=
Received: from BN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:ee::19)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 19:52:54 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::6d) by BN0PR04CA0014.outlook.office365.com
 (2603:10b6:408:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 19:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 19:52:53 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 14:52:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Tighten permissions on VBIOS flashing attributes
Date: Wed, 7 Jun 2023 01:52:59 -0500
Message-ID: <20230607065259.48516-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607065259.48516-1-mario.limonciello@amd.com>
References: <20230607065259.48516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 08078eab-c090-41d3-f865-08db6790c854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNE0UFWJVOw5dIBLInJyVU3YIxK2PY+30xmxZcMybp/yJxEfW5HfwduJZrbPMnH8zp3fOVMIo1ysWmbfGKiCrUj7AATO9gYDzisCLXze+fBSv9Vgh+4ew0AKx5FQ6P1Ue6w5T9RwVuvOqlwkyep5spQMkh3+JQB96KMHNACS34QHpy39P8caBWxZQiIebuc5tctZPOqe7JbWeDKEdZ7DenPvQrL/HWHt6g5inyxd962jtHXa4rJloYDX2B36uYBHtAqQ82Uqpwffhj040JkliqpFk8qP+gXvjUed87GfzFREacF1EXvGO293c1cP1iR0hyvszhi/prEuEvDbWtkw7bciApxBu8kVZS/bWXqBXJXK0Bq/p3MfJFNlNHLPRg4xgkoERkcDkYfem6OmmtOPZ64j8bKnnywnikLtGk4w25dhfb6AZbINPlu3fBR3Hq1H/KOipLZZ32bcbf35dJ4NPyl+nTSkfQuq2q/uCpYW7XVXPkEbr8Kzbzi+dB/Xw8T3b4NjL0X/6cm8j5wY5jQduPVxVx8l7JEfDc96JGfRTq+XT+6JoZ/1YXCU0jyEduDC3bU6U/T5oE0aCCmLXblohjVNqQC3SAEKxiITbOSqIKnsskB9XYNt6kN87JoBrA/30yeuwYLIbpLN4ZA/l0HX6v2QEDszrpoU0/PeSNF57hDXatq8lmSXjeP595YByS81IMvXahlQ0PCCOMUYpZzsVKm2+GMMMJGeHvSZsESQsFvagsWLNx/m5zG4KNRUapimgNCTJTZv9RJGKXW1TuRzEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(26005)(1076003)(186003)(41300700001)(5660300002)(426003)(82310400005)(16526019)(36756003)(44832011)(36860700001)(47076005)(4326008)(316002)(70586007)(70206006)(8676002)(8936002)(83380400001)(336012)(2616005)(478600001)(86362001)(2906002)(6916009)(81166007)(356005)(82740400003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:52:53.6551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08078eab-c090-41d3-f865-08db6790c854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

Non-root users shouldn't be able to try to trigger a VBIOS flash
or query the flashing status.  This should be reserved for users with the
appropriate permissions.

Fixes: 8424f2ccb3c0 ("drm/amdgpu/psp: Add vbflash sysfs interface support")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8c60db176119..488d5b7ab97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3671,13 +3671,13 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 }
 
 static const struct bin_attribute psp_vbflash_bin_attr = {
-	.attr = {.name = "psp_vbflash", .mode = 0664},
+	.attr = {.name = "psp_vbflash", .mode = 0220},
 	.size = 0,
 	.write = amdgpu_psp_vbflash_write,
 	.read = amdgpu_psp_vbflash_read,
 };
 
-static DEVICE_ATTR(psp_vbflash_status, 0444, amdgpu_psp_vbflash_status, NULL);
+static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 
 int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 {
-- 
2.34.1

