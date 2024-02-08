Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0035C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 04:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236A510E0BD;
	Thu,  8 Feb 2024 04:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c2QaBw5B";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E68510E0BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 04:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVdi1vayXd+xxlvA9xu3pXXIr853Vw9RIUlRNsES135KdHCvBFWuNmSCDtlDwwvt6GLZ9VCTwwJdA02FtFCoEXRVg/4t9WkM/b7V+dR0Llk9AJ+iZij9a4J98E2LhI4uusMNYITok2yvD1KH7HaP6Cwdl0eqFKHi1R0RZy55THyBeN2d0UcT8CcIhobsEnW04OVauqmmX6/cMjOW3+llzfrduyQyAcKq35U3+FPL5PrdW86DjXwx6OIfU08Lzsg9btEyPV7IEAgLq5amwQNxCYRPptUTMkzZU7G0Z63eFFl9io7eFVsk8XChjH6q2xHX5lYtvK2v7X/VqkMu+EEJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuKwZKkzS86faJP0CLVmUOILv06Tj6E50TXX4OCaMrs=;
 b=I/baDL6B+OE9iZ8I6kTMilCOE/8Y9jaNqTnw0zhRmK0Sk6GEasmNNbAyZrpLTQlrgBdvBYXciBD0VDeqLf3ONwIRluafa9Im4wfZ5KnLGbyxznfQJsritKtp8XdNv5nAh9SBxFYuiIT5F3DGtHmsRZVIZ+Uonxf6VcS6YoOIlIXZXyKlIAsjbnqXejdXT2LAu6LkZdykYvOZTsyzL/3zpCbm5Jy+SBNXTblL7TIw2pV8J9A1GaG3LNWt7al8cyndVcPRTl8KOg8W82WJ33SN3FUVZSx5yJNLDUFcv7Gx4j9itiDxXdjNw2hZbgX7anW2hmRcxv4XqvwNEn+rNJOOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuKwZKkzS86faJP0CLVmUOILv06Tj6E50TXX4OCaMrs=;
 b=c2QaBw5BR3+MxToMkc6n9SGKEH87W+QIssdzgLlEDUvFfUVM+CccSvByud+y3mFgPJ4TfhNbluEOl68hPpmzdUJ1kYK4Oite7H2hArmTZ+5b7IB2ubJ3Jq3edvYB6brludHLwHdrbHMt0N4zIOHM0oa7Wk9+CxdKDFpmJKokDuE=
Received: from BN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:e6::25)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Thu, 8 Feb
 2024 04:14:24 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::c9) by BN0PR03CA0020.outlook.office365.com
 (2603:10b6:408:e6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 04:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 04:14:24 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 22:14:23 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Joseph.Greathouse@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [Patch v2] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2
 onwards
Date: Wed, 7 Feb 2024 23:14:01 -0500
Message-ID: <20240208041401.1870940-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: a694b42a-fec8-4dce-d73e-08dc285c6ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9p2xQlRkOH6FvJELpRsxngsXGWia2mbh81SNA7+Ly6IRMsBz9z/55NKK/Rw3cS1j0DG/sQZ7NMMqcJqfdg/HNzT7Qv0MYWoEJYI5vntO4d4Pg1I0wVyDgpULgmFtaLwdoiUqfqWMhy0OmQbP0bQNcHUxS9NlwQHGoCZMqhvdD9ENc5OT4X3IN4xxiqYOURIL2G52Zfk/NNPi4+BaNRes9i/CZeVm4Cn5Jq9KFnupFivaYerPzhfdwkoWZTjhgeGlD3GmQdGYm8NDda0nHwGdDUpudL9escwnwaiV1ISohUyHVfZifRgmHX8+10CRPrOjs2p+AJNhZNScWghR6KyNHrmt1U+JIuAZ5sHIpIKzfEGauHI3Jk27MWzjuc7UwWPPKJySc/vf4l/xAs5fkcKiCVoA/C8pi948ArhaXuZRT22IqxbCxm2lK4379DyzInkzwY/+b0CixNCxR/wOqMkeh0CUP/Xti62+wohg1kExAFsHHkLCM/fS1e80v6HXgm1sUsszDGI3dZk+3pDXLvgwbagg70tPPLJmzwzmiXXhtzbQOCAnfeYyXPC7UFQ3GZEeH4pRVLfIqN8YNSjb8wjyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(5660300002)(966005)(15650500001)(478600001)(356005)(8936002)(4326008)(1076003)(83380400001)(70586007)(7696005)(26005)(336012)(86362001)(6666004)(82740400003)(36756003)(54906003)(6916009)(8676002)(2616005)(70206006)(81166007)(426003)(16526019)(41300700001)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 04:14:24.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a694b42a-fec8-4dce-d73e-08dc285c6ee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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

In certain cooperative group dispatch scenarios the default SPI resource
allocation may cause reduced per-CU workgroup occupancy. Set
COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
scenarions.

Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
* Found a bug in the previous reviewed version
  https://lists.freedesktop.org/archives/amd-gfx/2024-February/104101.html
  since the q->is_gws is unset for keeping the count.
* updated pqm_set_gws to pass minfo holding gws state for the active
  queues and use that to apply the FORCE_SIMD_DIST_MASK.

 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 42d881809dc7..0b71db4c96b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		update_cu_mask(mm, mqd, minfo, 0);
 	set_priority(m, q);
 
+	if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))
+		m->compute_resource_limits = minfo->gws ?
+			COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 677281c0793e..f4b327a2d4a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -542,6 +542,7 @@ struct mqd_update_info {
 		} cu_mask;
 	};
 	enum mqd_update_flag update_flag;
+	bool gws;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 43eff221eae5..5416a110ced9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 			void *gws)
 {
+	struct mqd_update_info minfo = {0};
 	struct kfd_node *dev = NULL;
 	struct process_queue_node *pqn;
 	struct kfd_process_device *pdd;
@@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	}
 
 	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
+	minfo.gws = !!gws;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q, NULL);
+							pqn->q, &minfo);
 }
 
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
-- 
2.34.1

