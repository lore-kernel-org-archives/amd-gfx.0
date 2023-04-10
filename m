Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC36AC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 14:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E76D10E397;
	Mon, 10 Apr 2023 14:38:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB88E10E397
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 14:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjH+0L9aulv+erSc/ijWVtSMu4kdgwlKbf2suA6jQ8eGn+UOXx5x0MdRCbNd7ANMo7cvDylV11M7LSUezAwL9EdBUldcy++h/QM14BBZvey9Y98ZxAmc+Bsb5qpw9GIi1gGvBkiTvsfVeGJpnePRvVgnb9kWdasC+KlpH6DGQ7ni6yhM2RStat75vjnskhdsJ1BHw5BB9DBbxG0S8fxFeabnjNS2w6ZzmtupLJO9MlTEOc65jLjayZ0LliOCAWfsR57TJXfjGgQj35mFJl+RBAW1lt2P0QhVpzqPBEAo9wKpQwT9Y+JHmmLYu3pRySJYmEjo7PqR4JZsSCTVCg4mIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN/tR21e+jtjbdegH/zneE0KVjnwZ5YsIozIUmKw8Wg=;
 b=gQWHKcCgdgnBARY80Hc53wNYUHoUfNWSiWkATQyfZ+WcSdnzd3GokF92L5wvPX/Ymc2bY5fM1sfm1kgm2agRnrEXq6WDCKacpStrE9zNN1XYT+X1ocHOlr4FVg+FwpgmLwmbPfGI42kG2IG35lFuq0NNpkiNxKdH9Mcb0W+Gu8EBKhthC6RhgFCQr2peGEYrswFL2L0LxQkOt/q0oOYp+CTzgpbxmSxFZNoHug7EYomFXSafOrWJRl4C7E4A7FeW2uxHpKJexz+Zi8ItWUEYNAiZYk6Nu4L3JBmPgeYhuLLoGzJ9BB2BLGQpfPoDGdU0ZSTaPV8uwoFviUnpSkfORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN/tR21e+jtjbdegH/zneE0KVjnwZ5YsIozIUmKw8Wg=;
 b=G4aSW49N+8uNwVhQSVg4aMJpQm+3bH/BdaGsZxMOuH7RzkVDOKM8cNFqZHn4GOmn6XWIaUu6MrGt01upMsIw0cRaYSs657K+7NbpHym5CImYibR/PQ4urRUB1/cU0NrSVoeXW/Pvke8n+tUPcqll2VQfFNYzqF6K9m6Y+e0ZRsM=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 14:38:02 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::8b) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Mon, 10 Apr 2023 14:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 14:38:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 09:38:01 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 10 Apr 2023 09:37:56 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Change WARN to pr_debug when same userptr BOs got
 invalidated by mmu.
Date: Mon, 10 Apr 2023 09:36:05 -0500
Message-ID: <20230410143605.334232-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fbe483-9492-466d-bdd9-08db39d13025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pttxfn86Ounj+t5End6cC1thZd0Ju8hjExiT7MTAjNL2vQFLJN8tSyDacUV1Xh+UV05YdpNB0hEO0K0a4+upp5/EKICB93FVDER//36+dbApjq9gFYb1RQ4rVg1obgv3CQRItCJoGUsWZNZ9nRYQF4F8INvVwLi9SPEXl951XbNVBfkV/PPIM7LJa2c+CfstbjCQtItU6yjHHvB1XckL7eO+H5/ee3fAOQvVeT0uLD3W7ypb3433WRsq24OCz1aWk2Y6a9ZilEr1BaUoCJHtLHWqf5UsKqP1NOVN0ehmK+idVv+9izYmYqKYUv3F/4OwaY66tvcASRgkqBrUXd6gQZWAd3kaxMbjfDBXBPWuzD1/q7pVTjxha2fcg5kXzRL+6Bnt7HttFCN/49vbBXbK1dOuasRiNJL1hNbRx7t3tvZhomKiUSSQ1Klq0pnrDDq6C++cVUtt2p2qjKKWLfxQSjneTRo/53UFh74NnpLhpuLmceq1+r1TQhfEOJn6g08uigd4QJ8U/TzjZ6etQZSCIDK5kSvx8MRgs1+/Z6nCv9TGtVYrrFRTLZZZbHBGKPzZlu8C/8INOQksmgLa3t0YdhMEhBstKlSn+U1W+ltwBvLeFzkxSFPlJL5DthhBkkgyqKKJxDxY/gXQTFeEz+gySUdT/XTXyf6xCWvlzqH7QsmERVfReVLvfNwkpL8RvuagCqvBOv6C2ybeUqeyAbnDYXHDMqCa2uOhAIpaSLjsls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70586007)(70206006)(6916009)(4326008)(478600001)(316002)(54906003)(5660300002)(81166007)(41300700001)(356005)(82740400003)(8936002)(8676002)(36860700001)(186003)(47076005)(83380400001)(336012)(426003)(6666004)(2616005)(1076003)(26005)(86362001)(36756003)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 14:38:02.0378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fbe483-9492-466d-bdd9-08db39d13025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

During KFD restore evicted userptr BOs mmu invalidate callback may invalidate
same userptr BOs that have been just restored. When KFD restore process detects
it KFD will reschedule another validation process. It is not an error. Change
WARN to pr_debug, not put the BOs at userptr_valid_list, let next scheduled
delayed work validate them again.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7b1f5933ebaa..d0c224703278 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2581,11 +2581,18 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
 
 		mem->range = NULL;
 		if (!valid) {
-			WARN(!mem->invalid, "Invalid BO not marked invalid");
+			if (!mem->invalid)
+				pr_debug("Invalid BO not marked invalid\n");
+
+			ret = -EAGAIN;
+			continue;
+		}
+
+		if (mem->invalid) {
+			pr_debug("Valid BO is marked invalid\n");
 			ret = -EAGAIN;
 			continue;
 		}
-		WARN(mem->invalid, "Valid BO is marked invalid");
 
 		list_move_tail(&mem->validate_list.head,
 			       &process_info->userptr_valid_list);
@@ -2648,7 +2655,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 		goto unlock_notifier_out;
 
 	if (confirm_valid_user_pages_locked(process_info)) {
-		WARN(1, "User pages unexpectedly invalid");
+		pr_debug("User pages unexpectedly invalid, reschedule another attempt\n");
 		goto unlock_notifier_out;
 	}
 
-- 
2.25.1

