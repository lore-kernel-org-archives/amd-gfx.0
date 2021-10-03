Return-Path: <SRS0=HyUd=OX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E3AC433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC8E619E5
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EC8E619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C326F597;
	Sun,  3 Oct 2021 04:47:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E426F592
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Oct 2021 04:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prq8PpfbY+kp/C7MrHwOZzlRzQt3kM444p6iwo4pQ9dJZkpG6FDC8mF23CL+pRB4S6UfL84QnA+tsqw+V8n7fNCxKKRdxBHyIXKdIiguHXVl61adgIG2M28aft5XOS2FogjWvrpXuQ6EBTnLxJkmmr1tQmmailJVutX9qT8eQw3D9Bw77Pfv7fxxtvFS2tZViEGmlwSD2M1EAJXIVL3K3Ktj867mzanqOSme612Z+eYS6Cog0c3Rt1C3mAG+tfX4IPNFxTF5Ty3/AJEstXkzodeKuBq9BuZ6uohtGJOPhl1H4OJw9SHVxF9hy04AlumOU3dsJK3Wh7UgVLWCSG0a+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbNHFKyJCPAC2U2ivjYvxnRF2cxw4vdvC4j3Dbr3TOY=;
 b=G9vyS8PTIx5/bUVNMmfWD0hExlSGVjzFysalPcKOFZAbHnZ+UanIVjC01ZJBjJcNwYNejOZj/ZCRZvmi6FFESGv7urDVTtBj9Uzuz9n40jvGn3Fq85EL4VxcCbqe8eIXXl20Mjssetmk38d+KOuVDB85jB+CSUZxpGR0y1ZWS1o1tZzs2U37W+V2Tc/+NFNWCV2Y1+UKmji39rpRlLzfWLblY3k01Zn69Tk4cc0+xZ5+Ocy0FxRwZ88soynupdvsGLNPxjnsHjwGAXLFV7nAPvjHqG2qS6kE9+SZYHYunC1DoPLr/cr9S09AbxVJenf0Vz3DOL0B1fK+/SveaAzqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbNHFKyJCPAC2U2ivjYvxnRF2cxw4vdvC4j3Dbr3TOY=;
 b=jsFdwGbgf1QjDWvR5XO8slaxAq49D9hBjdkMlYkY1cNZmhFIalD0U5uPnBeQmnc7rZEhSHj14fuW10e/uEg8JN3Bh4dDMmqWUOG7Ydt73/YHPRBdQyRxaWaWyJKtgcChSfDOEVCd1Y6Iq5TpYac2YVuPYmnCrxLlz4Xn5Y5MiLs=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sun, 3 Oct
 2021 04:47:28 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::56) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend
 Transport; Sun, 3 Oct 2021 04:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Sun, 3 Oct 2021 04:47:28 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 2 Oct 2021 23:47:26 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Fix incorrect power limit readback in smu11
 if POWER_SOURCE_DC
Date: Sun, 3 Oct 2021 00:46:57 -0400
Message-ID: <20211003044658.29238-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003044658.29238-1-darren.powell@amd.com>
References: <20211003044658.29238-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588fecbf-7177-4c4f-14d1-08d98628e6fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-Microsoft-Antispam-PRVS: <DM5PR12MB245644DF4A9B0429FB21F9E0F0AD9@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/pcyYDpCfaDl1UnwzBsvPywit47aj7hrHTnc3Ud4Y0JcjUHQBWVfJpvO7yhWFmi0lXmDyTpUJvTJkIz50+Al56mr4x3KD4yNms4O8ZvOXYr7Deve9dhG49V5iCLv0L4JcfEyK0BiHm0hUZVa6/YbIDn+yCNdacRNtnH/m01hyeN5g+0ED7Sj4aEhTBXAMAPR/BbuHfK4p6WUZ2BoMx4ncEaUWVxfGuu5YwEhQ1ojAzpEOCPawe86w594EVZCQxjTIkxfaNYvmb+3OaLQli3KJz6WpS7qTCO+Qwl/MOdvJ68np3V13Dtn+RzS2OjRZQpmUfwShauQ1mUeliubA+zrlee/hiSZUOTEIldhxOeC1VThbCCt/BOS8zDS4rQQ1gftHms1JuGjuAGwu6AZvRk14EQ47y+rkT4hVZm37nOTx5EFS+p32CKzaUDpgSUgDqEFEF4mLjzSzsTYCkrKDrT/HZCiltyz9OguZUPRJIVOsWfiM8xiado1EpCywdpmeH/DE/y2KrpcdTSFnQLFD3gWjN9MOCkZ/+KeGZub2JGCk2ETT7Njns7SkSntAwPbcWISj6FBRp78Tznm9gpIcaH6pUzAMUESqnHHL4a4T3vr+7Ts4AI7bK6gHKihdOoKKOhiUYfg9lMpZSIE0NzGzOoMz5emb8IdNaRKPcTsxHOydNXWN6JL6iLP2oThwmhXsw7NJdgISu+rWBhnDHJw13IlDFu6D19PMMSfiIozPV/fz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(316002)(356005)(36756003)(70206006)(70586007)(1076003)(508600001)(81166007)(6666004)(86362001)(2906002)(5660300002)(2616005)(7696005)(82310400003)(8936002)(83380400001)(8676002)(44832011)(36860700001)(16526019)(26005)(426003)(336012)(6916009)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 04:47:28.1289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588fecbf-7177-4c4f-14d1-08d98628e6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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

 when smu->adev->pm.ac_power == 0, message parameter with bit 16 set is saved
 to smu->current_power_limit.

 Fixes: 0cb4c62125a9 ("drm/amd/pm: correct power limit setting for SMU V11)"

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index aedaa4bb15c2..9bb6da99d5b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -984,6 +984,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 {
 	int power_src;
 	int ret = 0;
+	uint32_t limit_param;
 
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
@@ -1003,10 +1004,10 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 	 * BIT 16-23: PowerSource
 	 * BIT 0-15: PowerLimit
 	 */
-	limit &= 0xFFFF;
-	limit |= 0 << 24;
-	limit |= (power_src) << 16;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
+	limit_param  = (limit & 0xFFFF);
+	limit_param |= 0 << 24;
+	limit_param |= (power_src) << 16;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit_param, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
-- 
2.33.0

