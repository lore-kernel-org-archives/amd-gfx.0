Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764FC432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 11:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40317610CD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 11:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40317610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F413F6E504;
	Thu,  2 Sep 2021 11:45:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920676E504
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 11:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eByhvfe4wJO2Y71CzN60Z/DFTlCchoU5mCAToStjQC2jmALuODBBJz/SyV6Yw5gbwDwWjPHtTMc4vG5Z4b3cHSUADHjJN3mZPczJz/E23rR4YR+VdsPigkvL/TaTEsDZoJDvBFKjjIBV38WOijzvsckKSXN71zs4VPJioc2Mi67SnecYvrKC/g+JbM1YXm14NPmolx9+VfgTQjX3QDqBmT8mgtIZdiCf2fk7VptU+iP1/91aamjfwBfmxjk1bDhky9sZzJNR/5MG7Ql7DTqtDBvOeSZ93AgaoiIeU0gOUpOax2VT1zdmSSloJ9+TTOwYbYnWcAjvuFnoCDEYdiyxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0aDlnXFpo9WN1Na+XhQKK4HR/q0VGMUQa/WW1VOXd4I=;
 b=GRb9yWZLXfqKH7cbkd4O+dUGQR9b/zGHhtP58ZwFGxSErh7KX4epnvoqKfIwdvrLBURAFNwY6GFxa+SedytK+zQ8lZG8VXn1aLLNpGimLEdoNGrDm5TQhEzOrAXN9fRFrWTzLzJdD+FJD44m6BcaAsIdfB0UgByRSGEpjFnsTYX3x4ni4dit/cvCzhlvR4QdGC3gn4Nr8QHZo2czkKVQlFgpxOovsytrwfFFPbNCL/k9gkBEVvgbB2ubpDvQoLPyeg2rCIgmJvCWsUrmg6gQKd7z+OfDWuFTKLC8GhIszOytZsyb/OybiTdq1noyxn9oJGHqojVN8zBoeW39vZGCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aDlnXFpo9WN1Na+XhQKK4HR/q0VGMUQa/WW1VOXd4I=;
 b=SyMWlWUO6hp/TM+wzNk04dtgB1nqqhvo2T0CiacFuu5wuMIT8uu3v48zDD+1eRF2qMqW9QDt3gkshBEe2blB0J96fUS/D3uAXhPYHU7t4Zfj+OYmLYM26HqJD/ebIvSs5nz8lX7QFBuH0cRAbOxAAUM/ViHJ54x7Xx9z/MPrlv0=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 11:45:12 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::b6) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Thu, 2 Sep 2021 11:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 11:45:12 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 06:45:11 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
Date: Thu, 2 Sep 2021 13:44:59 +0200
Message-ID: <20210902114459.3866-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210902114459.3866-1-nirmoy.das@amd.com>
References: <20210902114459.3866-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a3fc3f0-1a02-4e86-c791-08d96e071fd8
X-MS-TrafficTypeDiagnostic: PH0PR12MB5420:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5420D7AA468CF96533D1C1688BCE9@PH0PR12MB5420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0w4zkDchYld/do7zIdF8o9gZ3GnvC5iz35mjv4R9WxaiK18DVkoRr93GqghWWeKKj2IJaY/4v1Tmf/M13ziAicN/xKWuvklVjD9mdPSr8e5jkpo+u2yJ9BtJdVqdA21epo4HR7tHnfrtCOF0bglhTYoKQtmpHM5RKrkAfi4Va9UNcx39lGpF3l7CdN/v35Cc370Y4szaWPG6IiVkzt8NkTG33YfIavK73G1WUEi/sntQl9ViN4uiHO5oU05bRvxudSjut3YJEAu5NGWtJ2ykUjkSLqK3jqxSXTtxeDPpglA3Ja9LQHcoucOy0QLCDgD9shgw+ubSQaoICbu6vU19w6MJwCiFJ28e6AnWDubo074wLHTpCO8fb/Y8ZsVvTwIv2Vw394lX9IWx/KH8BbgtPIumXpgB1H5tiLoW7LbpvcdB6LuDB/eD7vmKwq+oNQZXRS9+h6nedtfrHODtDkrId3evVU4r89FS/XTGhHPl5FrxbJPIV/3YtjYR7moew82I9pP/Hh4wBnJl7Jt9dOFSjIoKXsmQnw2l15Zr9QvBNJhRXl5L6intZV7htzrE44U+lZdu+lm/Hc/HT3/AN1Bmd2m+8ZdC4zMksvFkwMCPnv0fmgmxHnXr2HNvbFOsBKq9r/7InudEIvEBPcrKo77sV2adif4CijZEXLb7K3b6Uuv1OT37nEVl9b8Yi1UIsQHAk1T4y/LTYcXdgeWmawTuGvtyOKRKQL00Ek/P8qf6viw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(82740400003)(81166007)(4326008)(54906003)(356005)(36756003)(7696005)(6916009)(36860700001)(478600001)(316002)(26005)(8936002)(2906002)(44832011)(186003)(16526019)(5660300002)(6666004)(2616005)(83380400001)(8676002)(336012)(426003)(70206006)(70586007)(1076003)(47076005)(82310400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 11:45:12.6823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3fc3f0-1a02-4e86-c791-08d96e071fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
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

Use debugfs_create_file_size API for creating ring debugfs
file, also cleanup surrounding code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 077f9baf74fe..dee56ab19a8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		if (!ring)
 			continue;
 
-		if (amdgpu_debugfs_ring_init(adev, ring)) {
-			DRM_ERROR("Failed to register debugfs file for rings !\n");
-		}
+		amdgpu_debugfs_ring_init(adev, ring);
 	}
 
 	amdgpu_ras_debugfs_create_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index f40753e1a60d..968521d80514 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -415,26 +415,20 @@ static const struct file_operations amdgpu_debugfs_ring_fops = {
 
 #endif
 
-int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
+void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *ent, *root = minor->debugfs_root;
+	struct dentry *root = minor->debugfs_root;
 	char name[32];
 
 	sprintf(name, "amdgpu_ring_%s", ring->name);
 
-	ent = debugfs_create_file(name,
-				  S_IFREG | S_IRUGO, root,
-				  ring, &amdgpu_debugfs_ring_fops);
-	if (IS_ERR(ent))
-		return -ENOMEM;
-
-	i_size_write(ent->d_inode, ring->ring_size + 12);
-	ring->ent = ent;
+	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
+				 &amdgpu_debugfs_ring_fops,
+				 ring->ring_size + 12);
 #endif
-	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 88d80eb3fea1..c29fbce0a5b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -253,10 +253,6 @@ struct amdgpu_ring {
 	bool			has_compute_vm_bug;
 	bool			no_scheduler;
 	int			hw_prio;
-
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry *ent;
-#endif
 };
 
 #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
@@ -356,8 +352,6 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 
 int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 
-int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
+void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring);
-void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
-
 #endif
-- 
2.32.0

