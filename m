Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035FDEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 02:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5789410E3A6;
	Wed, 21 Jun 2023 02:55:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFEC10E3A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 02:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dctmpVf1cvLFh7Vy8VrLJ3nZKhdcng0On6BBv8nMnIuZq1Q+olXcysd6NQQLdiOi7dUUtOwa1epJVQvktK18XRhb+72TBFOhpQL+NBCDwKvIn3+D7u6pXwTOelD0HHJrFWMPnrd8lF9hHCd4xV/fbGwLqaDRLVQgoNEoJpaXEfwpwHGu7TuFkiYJCwzcgSloDf5AGlWT7hMXv5zSzBfzyLzAdU5wqNrlwKk60TMSQNLYpF7YPhx2AknTRFnOFCmqX9YXEVSVG//ooZQZklPFJwJQSqqpir+B/AgVU1cFa83q8N5p4DWQznSOm7Gnes1rt1XbOlZTF83xUzJeBKglUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUfEjDdW53AvAU6NCPml8aEOgBcamxL2SzBVA8768TI=;
 b=Qzy2X03kSbnHnfoa6Uf9WnSy6Ky+YADsPslHb6Z5OiCiHkIWXjZKcyghiE8TYilQC8HOFKR/KqweO/MPwgnqX9tvKxLoe98UDq0YuAxQnB1LThPc3AFc91KMwdl6R9b4Uda2XSjL2b/427b4oQtdJTJx8bl5mirtaTmrCHEduHtpIv/esTWA2GEEJIaeH6Au3ES5hbUyRXAK8KE97uVdHDPmJC7toQztMc7ucJ+bNgLT+Kz84hB/7p5PQoio3HaefSOtKb/aaWD8mDKmeNTIofbo+W305J+184Vxix5QV/Z+O0UHwPdinOCIL2rbvXAcNx5w7n//UUwUk06rRkd5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUfEjDdW53AvAU6NCPml8aEOgBcamxL2SzBVA8768TI=;
 b=aEHUb6wsN0iz3s4EofAwTXOJnIAuoJxvMtBltObmb9CfvyjWBYLsTDW3yy9rfwWQVp5HXOyl78D5mQwrmTtSg7dGZLjsO5450t3SL6mtgl9GcOoXcaUa4nYjN45uZaFDd0ISPWLeAHn4gG7RBA2bgRkhuoTedUW/Srv5yVOk8OI=
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 02:55:29 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::64) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 02:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 02:55:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 21:55:26 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Stanley.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: check RAS irq existence for VCN/JPEG
Date: Wed, 21 Jun 2023 10:55:16 +0800
Message-ID: <20230621025516.19690-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 12480926-e597-44ec-1166-08db7202f8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEZG4BDKQLqFSADsOCCE7kONtoIH6BAQvHIFg44ANIQUpY2w95r7DKCqDcgaUCVj+ywII4ZotakXWzG3vnXulGI6BAriFhDjvk7NSVPBdxXK/pQNuZjwYhKgfx+vH1dewniTY5DPalgrT1mQwZwPKFlz6Q8JtfipkneJf/hnmF+GIT2+uOBjJWOxoP+b45Cxt/52hASbmYpRMBQJCrdig1Ce3t+ZwKLrHbHYBc2gy5bGCtWUXrtTnOMsMtwy6HkAIiFW5b2atPPfY8ibmJPoGcrmyqZHNYkzF8oYeAJ8E1rJmj2qdkUOVSQNnySZ+QBfcoYhVngbNfC+00dszRNwKaxJrgaop+uYaU+f/w3R6o0O5PCtXQPkr9r2nGIIMc2rlxRPkerdVybQWtKCMrsWUZ4W2Patq8MM8WCQC8Bx8VJQT0o/iZ0wXBRlrGC0uPk5qedSvhKcgmgONYBoQpDAZeX5GwvcSi1+R40p4tZjP4oWFGakhOhYowVBiOjOZ6GUPzr5INKTSs9d7mMnSpnnz1V/WQG3O4UZo4MjetXOgJjVA7eQuQjTsRs7advHDFcehzAmcjOK5g0kJLIzsWYE3OU1EoPvNDTWnEYQDjujpCBkr4/0jIYSN4LgHfvwgXrNkbt9WKTkd6Bv4v0X7zVVzvhnzPZx+tmMaleqyHdE/mQoNajqZPIgA6jPCozWXG4A0KK8QQ+DLDcXrIbqpYorD+acDxoZ/zstr1rC6SMMZ/2MIijohqTH1KOKOUk+AkNgjWhQXaR8dAdHboQ7x3ghKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(426003)(336012)(2906002)(186003)(16526019)(47076005)(36860700001)(6636002)(4326008)(70586007)(6666004)(70206006)(7696005)(316002)(110136005)(2616005)(26005)(5660300002)(478600001)(1076003)(8936002)(41300700001)(8676002)(40480700001)(81166007)(356005)(82740400003)(36756003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:55:29.1456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12480926-e597-44ec-1166-08db7202f8ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No RAS irq is allowed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 3add4b4f0667..2ff2897fd1db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -255,7 +255,8 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-			if (adev->jpeg.harvest_config & (1 << i))
+			if (adev->jpeg.harvest_config & (1 << i) ||
+			    !adev->jpeg.inst[i].ras_poison_irq.funcs)
 				continue;
 
 			r = amdgpu_irq_get(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 19a3bb5dd29a..d37ebd4402ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1216,7 +1216,8 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
+			if (adev->vcn.harvest_config & (1 << i) ||
+			    !adev->vcn.inst[i].ras_poison_irq.funcs)
 				continue;
 
 			r = amdgpu_irq_get(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
-- 
2.35.1

