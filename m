Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABDCC4332F
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Nov 2022 21:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC07C10E131;
	Sat,  5 Nov 2022 21:46:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9253D10E131
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Nov 2022 21:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggehtfoLylJSm+RvqhyLwsARJJ++GiTwy0v6AsydUAvWcoZhxTD7/V5PsUTDIg8Vm5C3X+WRJHPmmR7jFKx1bA+9bo9ag2FE2MQ+VjEgzEmfYXMTatCS8fIlUnJ7wqk20VP/LBa4bHkyRbQJk02DGqwYpXh1+7pudsia1Ju1inep8GY55pzi+7UP3h3AZmR0nHYSYivsJJhrFmYYEKdKLYJsH3esh/72UOh5EwiAaBy0Lk5lq8IHFQ2H2Bv5xhn7c+oENTiLriHcI4dMJ+7LlBoudDmNb81QNIBg6vyZgwl+O/6OUjM9JLsu1VFwcP7jA+OmiXU1QtSy67Q8MqwMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL0mPm+ttyj6GPQ0jrgHsy2g/NcxVbrjLNNe1xBU4uQ=;
 b=AZe/e9OSz/WFGoz72aH2kQUMz4vhIP+9iu40PPBVSpxiffhFw4BNTP4YZY+Hd0WRI+JAuUASZb8NTUIBgvdpxtTdLSUVVc7uxF1JGg9j4nxqaU+zEXnCpuXYTiL1URRJeKsqgXMGQ8ABxSjmtHi+M80Ca5Vjw8cvYISSLoy/szlVUnSf6W6zttTE8xSwYYPt7I/SlI/Kvws9ZxDOirt47j+f1SldFpOcDrzh0vEfFCwud81KNGc/VeVO/AjwypsoP3dnx+h+Z1jc6MjtXbRuzpuzegsE+ZAJx4C579RH/RVlxihLtRBzOQpHMyGq8uEAMpTmZVDvIEy2WbBCEcP+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL0mPm+ttyj6GPQ0jrgHsy2g/NcxVbrjLNNe1xBU4uQ=;
 b=qIGvxgn0GkRhVHUGrNPFX+PFv8BRjHWJiSkpe4aEH1Q9GOpJhv1+xOVFqBD4bYXjybIWABKfg3UdXSJwiO0gNqKM/senOseJjG9bl9h6axfsGoyi76KSAVDyjlVgAFH1ZOI6rAnD8pTunKMo1khkb3UbthTyJzjMRP8LsVRbF7g=
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sat, 5 Nov
 2022 21:46:29 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::78) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Sat, 5 Nov 2022 21:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Sat, 5 Nov 2022 21:46:29 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 5 Nov
 2022 16:46:28 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the kerneldoc description
Date: Sat, 5 Nov 2022 17:46:06 -0400
Message-ID: <20221105214606.14892-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 702f185b-3759-4b4d-85b5-08dabf77328a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOfLGi4pTpwF1PBTAv/3GFq6zARwNsZJEGktGACCWU12+Sbf1XEIyXYC0tRjndz6KZ7zLY+2t3Cq+cGWdq/OOK45MpLTbNgi0be/DQETLoHdwq0PHFQAyu+5u6sF+ZqQzJjEpby2rdVBj/APGUhmEqT3mb9ZcU28EWkdCKizgeY/EQ4/CAuT7IIxZTbTYlNUwynkEwGzr5WFQ2CyzuCrcvLzGr3upN3kN91/bkgarmnfS9goo5BPy06LBijUrdzmKU/BK3n681AODwOf0s/T2PkUQxsipy2ybIfhmWGixdVWLsO/xDVZYeovBqJnP0t5S6JaeYYPjWft9SQUGBnpbrOLVKAGY3tSCIMKeu7vnq8pLpu7VMpSUmUt77Tavd1rF67X62sK/0a3LwxsIgdRdQggVRl8WZHYOeL54AMnQvaY3UMp1XLttqLKes2QwKWEyITHfewmWZimwwOvNnespe1gnzEtJJ7Nowm+wwmeIaQm2M+djKKOmXKgUeysF9iFXFEo0cAUryE5Db6DN7GOm34Ou7+/e1knNUc7ZL3HnjvsyUftOFiI/VZNqcjZkauslGRRpb7LO5gXcNl37D6KgXziy2zbv6g7P5e0QHbzBf0CSHmNUTA4kYyB3fTiKNzkmnShfMDDoNyBYNgVwYaCKEz+WBeJa+FQyW64uUNZB4Gck5pqD6gt65PJKFguw9g1q5iL4b2nEYZYEbbvZCzacn6tOZjDSUOZPXqJoy1we8jzqwN4mydBio9DnSrq8qzZf4gVzUnsit17er89ime5aE2b7XZnIhrVRnr1OlbJL7i5FRsAAQF1m7yYLFRwi5y2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(316002)(6916009)(54906003)(82740400003)(2906002)(44832011)(36756003)(41300700001)(70586007)(70206006)(5660300002)(8676002)(4326008)(40460700003)(8936002)(47076005)(336012)(426003)(36860700001)(2616005)(186003)(1076003)(16526019)(83380400001)(81166007)(356005)(40480700001)(478600001)(7696005)(26005)(86362001)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 21:46:29.5830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702f185b-3759-4b4d-85b5-08dabf77328a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ttm_tt_set_userptr() is also called by the KFD as part it
initializing the user pages for userptr BOs and also while initializing
the GPUVM for a KFD process so update the function description.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ada57a37a020..bcad26a3b009 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1409,8 +1409,9 @@ int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
  * @addr:  The address in the current tasks VM space to use
  * @flags: Requirements of userptr object.
  *
- * Called by amdgpu_gem_userptr_ioctl() to bind userptr pages
- * to current task
+ * Called by amdgpu_gem_userptr_ioctl() and kfd_ioctl_alloc_memory_of_gpu() to
+ * bind userptr pages to current task and by kfd_ioctl_acquire_vm() to
+ * initialize GPU VM for a KFD process.
  */
 int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 			      uint64_t addr, uint32_t flags)
-- 
2.17.1

