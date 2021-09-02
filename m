Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE0C4320A
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 13:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ACA61056
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 13:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51ACA61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27C86E500;
	Thu,  2 Sep 2021 13:43:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA916E500
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 13:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQuIIQUnOtiSG/suqyyBeQYBnexUM7EDID9wEMaLDEij4bpJL+7AxCWc+4zzzud78kDUIHdpSaUP0o4dzUd3j/XgAq4YCm0MUF9Xok6bIADpRvEmngXsIF/zMIUgn4fFE/YFu4UUP+I0kQD2Ed3o2ZVdBXjE3NO4AUwgppFICH98n+KFp4ndSpojOtPtdWWU+M6aExwom5HufIe1BcjuOsRGKKq+HuzPLdZSVqNbWTs20n3IpAzJ3qs580dxwC72oqfjyJvSsV79EsbRPI0HYO9K6aexyvJiwd8Slp4XWYjNefkkLEcJ7GnQLuhBF8WZcK2cZ05QB76CZkQSOXDGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Jybt/Miz902eWZ79Q/D0pW2xIPLSQblmHqmKayqY9Cg=;
 b=mA4gcBkNQv1bTNWyYA5zpcalMkQF5BuBjHxR0ZCD7ndP5931CdgbOPQXrcXUsUTCTKjkf114bi1hCj8NJ/bGpDQXd2DJnHfIxvcEmUjEBvJMqPRUGF8KnDpYnUKTif+ijckZP6LVL8O29upCMXfg2JuFbuKTsovhG0JSBMErqHPuQyMFK68a8l1psBRbWuoW6FX3w7bQG3ql8k+NjOM81AEPA35Hcy9QIXfFUqqw+nWdd7Jxv5uSQspdIRfhXIZZoTjD/grRH5T1vnYDj9XXC8Mzi0ugjT7DBF2DIRJgw7XImrUGoim29hgP2r8K5/8MvfM9Y5Lm3PdrZ1ACZ2LrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jybt/Miz902eWZ79Q/D0pW2xIPLSQblmHqmKayqY9Cg=;
 b=3bVTTD1P00sdA6jCTQF7Ji2IYVFq97Gv7gRB2m9XLDU/9yEZaNojCnvjZfqDq3Jk50I0HM69PMdjyhyF/9fhOxDcICiMJ1E6bTQjjg1ljmKuHvOf0lDRyVZRriIMbBs+EcGwFgB4Htek+xHogUbFeMK+ra1YhpBWJ2FLS4MMB9I=
Received: from DS7PR03CA0111.namprd03.prod.outlook.com (2603:10b6:5:3b7::26)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 13:43:56 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::28) by DS7PR03CA0111.outlook.office365.com
 (2603:10b6:5:3b7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Thu, 2 Sep 2021 13:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 13:43:55 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 08:43:54 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
Date: Thu, 2 Sep 2021 15:43:37 +0200
Message-ID: <20210902134337.3440-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210902134337.3440-1-nirmoy.das@amd.com>
References: <20210902134337.3440-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4484b1a3-d8fd-401e-1963-08d96e17b597
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943773B8FB2463A45CD45A38BCE9@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sL+NdXt26q8w2pWYcOCoPTDGo3ZLaVsllM/cxyEjAUCiE+QdAKnCFKmWfYFvqwue2lVokGVbLQQi/ApJCr3PrvEWcfOe+gU2zxYmUmQHMMUefB0qppkdC0v1QntqJ2Y0Zo0OMKNcuMXFt1iOSHpGwZ+qCb334hbU+IBWQokdwQjBHzVROnTLzlE7oDQEkM0wTaUpYEg4gImVy2TI7gZT5AHB0BiQxHUlGYj4KYzju90bOGsGzkmcUqA0tRIWEFj7duHI4WNkdmGblvDMjxw25ojwwwm1qs2sHsp1pbSnHRXgX3kgYNvNNcJzNGlx7WeUVqj/NWICeKj3S69rNv8dXhsMPBaY+0DFvz/CoExnOlYiXwVItVegIRxNkgWuetoD+ex0OG1mGZOapBeR9p0XI1WVtyLuC/KlqZRgzTP66uFdrQGWds1HWnu8cSGKaC5qOBkVeKxBthMx7MUef5rn4KBWvQnwHYkRHv/M991oGdGTcgAZuXLQ5CeSCMci9Q42HsTgd1C0Ef3wQEqOsTqP98wwRHWrr6nZD/Hyid0BVNRYUvUWSN1oxebrVBPCehW7QJmQtBB7vxqwYFIZi1eA+38bBNzJyZwEIk+wHbyx85WD87P/1iClxPcNJv8VZoIvCOyOpz9BJi7PeWJruRZmtt3JAVZPdmqznlfDp9ITzCgdHjiHcWIk8opCNOnEa8dtaMp3/KwiDAxlYZ4qh3yQtp5rd4/gl5Y9zF9v2Jx4efc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(82310400003)(4326008)(316002)(26005)(81166007)(7696005)(5660300002)(47076005)(44832011)(54906003)(8936002)(6666004)(36860700001)(82740400003)(186003)(70586007)(2906002)(83380400001)(8676002)(2616005)(70206006)(1076003)(16526019)(86362001)(478600001)(6916009)(36756003)(336012)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 13:43:55.8448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484b1a3-d8fd-401e-1963-08d96e17b597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 18 ++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 10 ++--------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 60f46a4b0144..97d88f3e1c4c 100644
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
index 0554576d3695..ab2351ba9574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -415,26 +415,20 @@ static const struct file_operations amdgpu_debugfs_ring_fops = {
 
 #endif
 
-int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
-			     struct amdgpu_ring *ring)
+void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *ent, *root = minor->debugfs_root;
+	struct dentry *root = minor->debugfs_root;
 	char name[32];
 
 	sprintf(name, "amdgpu_ring_%s", ring->name);
+	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
+				 &amdgpu_debugfs_ring_fops,
+				 ring->ring_size + 12);
 
-	ent = debugfs_create_file(name,
-				  S_IFREG | S_IRUGO, root,
-				  ring, &amdgpu_debugfs_ring_fops);
-	if (IS_ERR(ent))
-		return PTR_ERR(ent);
-
-	i_size_write(ent->d_inode, ring->ring_size + 12);
-	ring->ent = ent;
 #endif
-	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 88d80eb3fea1..4d380e79752c 100644
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
-			     struct amdgpu_ring *ring);
-void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
-
+void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring);
 #endif
-- 
2.32.0

