Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47685EE6456
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 11:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE82610E179;
	Fri, 15 Sep 2023 11:07:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904FD10E179
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 11:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpxK7SPhe5faqBz+wJq5EtQeaZtVyNDWWtr4lpvSw5Rc4I4V2kGku983m2NLte9WwR/gnGIa6HdpFbHRDA/uXVoY028iNZV7fBMBJeBa1wtIkbfnAO2ru0xEIxoUSXYDY/9E5x9SwkQHFPsJJmEnT0HzIFz+/2EfD/b7rZyG4OECdqa7ezs/P3JTI24AlJ+Chzzws7lwRWsK+ItMowDXuuLygO8JMuAWd0DCrgdOi1X4tAckmosLzhOaSCGVxGZpb2hRiZbWGpMULHBLnPWZaYSRsZ4rVCgOtnqTtbMSWWbv8TMcyoTqy5FwtY1o2s2Up3oSgSHCSmyPVlfWkncpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu6KNwU3GuQtKIFdd3N69ZIxNMw9Srf4cpR8fT8BO2M=;
 b=ijjlxW5vyQ4Z0zgvKD5C2GlcCwvcALCz2yoIhLKejSzT/3700TJJIHhsoErbqcVr4VjaXuTjLb+NvX9jcAnJ8L3x/pMY0hFcNOpXMR3vZxUVZt/hWuZkK1bnyC8ILd5J7Smh3+vi9jxj95PC8eHrXPdwzM4EVF0spEZULY54jIbotJf9K46wFDjysO6i11oxxSmyfAE6w0fRImuStlNVHO+3QgVIJQzCjca/Y0GKVUuketZYWYixRpRqEuI+7m396JxQJYmNlbLGD6hvyqArys7JQSqJ4zmAIR70CUMkrOs4s9BIt5i7NjmjhaybnhbVKtrlN0DVDMAryUIUjdhS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu6KNwU3GuQtKIFdd3N69ZIxNMw9Srf4cpR8fT8BO2M=;
 b=NaFuVDBGk4OygP9gIS4McjBPDlkrrmv1txyBmqxEuyr4smsvQyh/8113Nw+7ZLiTawv718wwwWY8hVcIm3U2ECJBujW5nnwPbKPx7tQO3PeUO2dDd6oIE4ploKpxBWLFjmD9FBl4u9Km1/IoXFFJ1pyT4Ck1WPPw2gQO54tNYXM=
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 15 Sep
 2023 11:06:59 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::1e) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 11:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 11:06:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:06:58 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 15 Sep 2023 06:06:57 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix false positive error log
Date: Fri, 15 Sep 2023 19:06:51 +0800
Message-ID: <20230915110651.1849740-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f929275-3b22-45d4-06f4-08dbb5dbe1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INehxJfhy9+N4/FBsLD5i0vnWQUTpIeUcabcZSnlXC+S87FM8TnfK7e2SXJAYfV4Rcv+ii7o1FcBEkTvsxCHD4uZBPJke+BgXteqwIzljJekjU9jHicDsnADP8156lmY8CtYaNpbsqPgGTj7uVHuQe2riJeQrp0kqZC7vGFUv5Eey2bwSwYRy/CiNiquV8vq+QxKCgZbWHk6jEp2T7khtycJT4HTzu444MhQVq/KTo/yBR/hr4rTpjx+8ct/3A0fKoNkpkXrHJ36lTuazkEw7txCC6xZivb811zIIbSQ2fDzWCfYOoIcb5TD4bSj+4YwtqbaRdmvZbhOe5xCRdsRzC4IIGbWZcMW7lN1DJRJgf/J+gf6yHydSHNYgt2KB6Gmfq3OQ40RuPEFteao0vxFbg9iH5svj0UhkboIPwjab54VAXeks5gjPcTakVE7t9zyAnZ6IQwFpdk1+u4WySxlCo9OoLKZGVPpatOnuVQoMIr4LlvxXjNyEYmQWHf6iKV11LN4ML+TRfmAxbkA4T7+nwQv8iKIVi3O9pZxWQKydErBlJ2JOirRJ8QzMBkqpcKWzsXGSNlSBBnqsQgWVZqa6jiqroqSLm7zvsrQvo19OiugPyh+wA+AoVfebtmUTNbVHJbAxTZctfl+Wl/DOIUF0RCIrpRreOTZ8B5VrAWn9x8cu5mtqkOVPY9tOKYEvQNGf2L/58XQj7UJYySjej8wqYcXe7Uau6T9x/O8u4kYx45SxI+LK5EOUdm5Rapo+uvM4y7EtCd7IInGczGkQjmPjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(36860700001)(70206006)(356005)(70586007)(36756003)(81166007)(47076005)(40460700003)(8936002)(8676002)(4326008)(6916009)(5660300002)(41300700001)(82740400003)(2906002)(40480700001)(316002)(2616005)(83380400001)(7696005)(336012)(6666004)(426003)(86362001)(26005)(478600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:06:59.0561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f929275-3b22-45d4-06f4-08dbb5dbe1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should first check block ras obj whether be set, it should
return 0 directly if block ras obj or hw_ops is not set.

Changed from V1:
	return 0 directly if block ras obj or hw ops is not set

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4a6df4e24243..25514af6cf8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1105,15 +1105,15 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 
-	if (!amdgpu_ras_is_supported(adev, block))
-		return -EINVAL;
-
-	if (!block_obj || !block_obj->hw_ops)   {
+	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
 			     ras_block_str(block));
-		return -EINVAL;
+		return 0;
 	}
 
+	if (!amdgpu_ras_is_supported(adev, block))
+		return -EINVAL;
+
 	if (block_obj->hw_ops->reset_ras_error_count)
 		block_obj->hw_ops->reset_ras_error_count(adev);
 
-- 
2.25.1

