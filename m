Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEA5C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 02:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975742078D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 02:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fXLR+CkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975742078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A1A6E07F;
	Thu, 27 Aug 2020 02:32:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E1F6E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 02:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJeGW+6YF/7+FBgOd1VreciEFg7mD17jY6lb7jrE3pYofZwl6V7pSlvfekFWQUOAncdblGDTxLxQBAa2Xdny5UpwyldvWh7RFUL2TvByoWr83H6yFkGej4ys6JSkiKTDS0RAkx0Leoa46eyk4ey8KJkSkh13fcDz7oCvscGBTscIQV+7doX4RCK1X0Gsww7eR4fZByJKs4m8t6dKBSCh1guXzTB7GyO+tSk/edoPG0OQxgp9GNq99fnV0sNT6ucJYWezvBBXKv8DkfWlTDgKv0ewsnPoiCMHAVCz++ZqtG58y81e2iwN2/hlT4InK01hTE+D8no+iZ1PKpaZTDZpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hBbL02kUQaOppmc3naB92yN7kOl7kgFdeXvlT6JENA=;
 b=NCrUd+JiPux4kZmtIe9uWhWyCM2Uw4aDiSlHx6Lhs70GhLiHyL9IFleuDVPsOrOIDxo9eACz35ayzKTA6UXBW0WIf+dlTWjpIWN+Y7RTWUzMt7sQoEakaN0aXkhI9dHqA7n6AgR7QK00BcHkrIUHbdoSibKNI8eHJFr6IFFQXvlaPqrXFUp91eASOIXwF36xW3n/HGsW8z2WEdzE9rzdLNLAWX0UXYon6T0GoewTkdlEj3mJ2YulXIYN2Q8EFKqpt1m2ljpMKLF4xPkaJOfsEVnmXllzyHyeEDMf8JtX7q/yBlUc+Lf0+/atmW0dyhEAnwHSc36J/+26xGG7p6joHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hBbL02kUQaOppmc3naB92yN7kOl7kgFdeXvlT6JENA=;
 b=fXLR+CkJg8OD2VwiwHfCo8GQlSVTNW0OYWxfdjE9lZMAZWCYh1T2ZPUPnlPILFWdLN7d082ETBuraHh+a79yaGV6vD08Fs8rpA9irVKUUIuSvcstnuS769ndFVS8M3QzZYQU3IQsoO0R0qxWwVk9xJNhQLoZQTOFNp3CJpFlDt0=
Received: from DM6PR06CA0002.namprd06.prod.outlook.com (2603:10b6:5:120::15)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 02:32:24 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::9e) by DM6PR06CA0002.outlook.office365.com
 (2603:10b6:5:120::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 02:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 02:32:23 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 21:32:22 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 26 Aug 2020 21:32:22 -0500
From: Jiawei <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify hw status clear/set logic
Date: Thu, 27 Aug 2020 10:32:19 +0800
Message-ID: <20200827023219.6650-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a727cb5-9b97-4566-e7a1-08d84a316e57
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:
X-Microsoft-Antispam-PRVS: <MN2PR12MB388534DB2419209FC8C71C4EF8550@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MriSP1l3cVEVvIED/Vl1wOWOwyxhdYnQ44qc+R5nWWtNQOea7EA3Dypj3Tz4+xvn4ot1tIkR1nBXa/Wfwe5u9FkUCJDlpt0wzE9ummgFJWb06LI6U4d7iWI/3822Wr7ri3JieZn9WU0IKCNvW/ncoWMMzzBAyce1zVowcFx0FnbMJUJizD14MAvzI8PIeHDzXlyOeCu0XO6NF/9/YFdUrL7SNo1sFUt+HP3yI6UFryka1h52BYF/kX71jEyPjsV5QcPuS+0mCtT4nhDcU7IlBGTO/JjCa4/jlqPQRN2aaM9iGhaNWczfO9/E8dZzU0ROoKTyiWIVumi1UMLrBwoj5nRKWqC3XrMQzLECT8auGAEtfqwggRuXwYbdURCVt193kE1E9Z+N2lAMknz+HF894g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(1076003)(86362001)(2906002)(7696005)(70586007)(478600001)(83380400001)(36756003)(5660300002)(70206006)(316002)(4326008)(8676002)(6666004)(2616005)(81166007)(8936002)(26005)(6916009)(186003)(426003)(82310400002)(356005)(336012)(82740400003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 02:32:23.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a727cb5-9b97-4566-e7a1-08d84a316e57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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
Cc: Jiawei <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize code to iterate less loops in
amdgpu_device_ip_reinit_early_sriov()

Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8f37f9f99105..696a61cc3ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2598,17 +2598,16 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
-	for (i = 0; i < adev->num_ip_blocks; i++)
-		adev->ip_blocks[i].status.hw = false;
-
-	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
+	for (i = 0; i < adev->num_ip_blocks; i++) {
 		int j;
 		struct amdgpu_ip_block *block;
 
-		for (j = 0; j < adev->num_ip_blocks; j++) {
-			block = &adev->ip_blocks[j];
+		block = &adev->ip_blocks[i];
+		block->status.hw = false;
 
-			if (block->version->type != ip_order[i] ||
+		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
+
+			if (block->version->type != ip_order[j] ||
 				!block->status.valid)
 				continue;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
