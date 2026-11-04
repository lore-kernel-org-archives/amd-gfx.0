Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B5606AAD0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S0GVLFjO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E28110E404;
	Wed,  4 Nov 2026 16:23:38 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC89F10E404
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 16:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJs/BznHm8XxHkkZvbhnrT88OUdlT3v/l7/9wlIl9bAznr9UyK4UrpHnZgo2h4R0tE5daRiUCBMTuJvVSTi0igmw1tTMzRy8uhvuAwDPZCDEoeBwrVyDlAaHiwoqj3HVrWC4RS+iju597xTkkqNTxGiS46RpLuEqOA+FzFhwdfXHB3GPUnpPHTBdP3UamC2DPSJUX2YUApEuVWOl9d3+iqPwZq7LM6YIApTHgobuzSX+DG3cY3NXmm1L2dM7wWeSAVnX1NuZiYuRQjfZLoi/TqtOuJRs+s1HpeHZJuwuu2GpGT+lXfvuxYXesL1E+D1d5t7+xoT2XJFRV+9haFy6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtPoDIIV9rdVuJ23BeCjg2w/4A4z00iOC/8W9e0HVLk=;
 b=m5im1ID8EWo2WkxjXfWcqijnUWtSRv1VQ42VYSy1/NnjwPOlweUQUUm0OTCNisbzVmAf0bbZ2+u2sjK0sAWoembS0B70hz7Fn87LK40tttJmAsmQzVQcKuCehGwFPkuYU+J2PqYOI7iZwhtQGWHqIUn3bRDBdVmfiTVLXw/NCf9Is8+JYYZGt5ldaauMJfGPBuooRjSk9U2SDjBWyYpbl160eER1dnRzMXhv3zitz+sIk4vyNmYLkCu4EoPciuR5jwVrjBk9W+bJA1ZpEqKq9jw29mMfvCn7xM/myD4kOqm6NSHKIjRwovWR7C+faBJ8wccp+Gg13hK8yDUu2Ok0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtPoDIIV9rdVuJ23BeCjg2w/4A4z00iOC/8W9e0HVLk=;
 b=S0GVLFjOAAqTC6nRYEtd3/fJTMKac8KJ0Xq8HkCujKy/FInkAI9Xcxcegr42Yi0Ug49o/mjw53tClP1pOlwSe9hfJTbjJieRegJelHD8Pn7DPlDLu3HmZWthUM10gm4DFC9gAlBSLreYQ72DYHJb1rsQXokeKt7j8miBDbbuGEI=
Received: from MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:23:28 +0000
Received: from BN3PEPF00022BC5.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::3) by MN2PR05CA0052.outlook.office365.com
 (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 16:23:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC5.mail.protection.outlook.com (10.167.248.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:23:27 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 10:23:27 -0600
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Victor.Skvortsov@amd.com>, <Zhigang.Luo@amd.com>,
 <Chenglei.Xie@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
Date: Wed, 4 Nov 2026 11:23:20 -0500
Message-ID: <20261104162321.75300-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022153132.211631-1-Chenglei.Xie@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC5:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 610156bb-a44f-4079-0cde-08df3a8ff528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261009220027099003|261009221227099003|261009223327099003|261009221727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8aQ2e2U5r1tMJ2o5KcOqAG6A5uMhhKKjufBLSsidpz+RoT4E0BYFrJQiZBDs2zzKJtfgFLmbd9czLcrFrTGt0zpaeHjVsUd/3xNu79WmSt7nkAR7k4MaIeGp9Rz5UoaaCO6TlRGlqgBIjGRdeR+ydVvwRKXM8sRF9sfyRByobcGdyLaZ8jyrren6cf/hWNDhj+bsfSZToOzazZkfD9OGm6GKe+Qdt9bT7/Vmtl89oaHC8vHM6xEvP6CcS3god9uI8INWFi2bEuZWPyFOeCGU6298IbaVebvjiBn7KBp5YI1dS0x0/hiubUPfoWCar+ItuP6CReMcrWz2dPlQdIV1pC4+zP4ZDf4fT3pI0lQAzpAta7LVka7ggtRvFH0Th+XOOts2XVhevC6JD0EBfY2QudUVXK7cwxeFVkPoTGdDscgMc3i93GWdOEhs4pPjMfaYmCPFgVTcEFYL+BuhwhN8Gvf0B5ivOQcTkfQcru51GqxpMfV4A3cxLZXWVf3IxVQk+gFo6J1OFpjVax9mJq1MsL2bh1kjJAVvABE9xLIB3TrNbCY72XXqJh8EXRfvdex0Rbg22tAOQVaFz1B0/+hqVPRrBogd1hI0ROnT/uGcPv8UlM47gZujHyX8NZRN9UPvAFdXDN2W3fXUM8NjPY1lpzA7IvdXmDDrCEEvSkT3Jl286gd/zfC8H87EKBpCBPeJER22X089xwKopCYrHC03zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sxu9uCTzsOJeSGFOze4zxH5kqQKMjf5NedKJVEVSI6nM+OB0CX2hXnRt2I1+4+vURhWfjMBVrjkujn5Y0+o+nLrMDiXdyEg4O0TjrOKV6/3pmi4iqTQo0z2PM222V4vA6n4ajoMq8+Ai99DSI5VYljmq53JavJ2JROA4pQbur+pMEBrxpjE6tD6z5vFoTct2nhb483HA8dS61WygFIUxs42LFR/Fl7q+gCUOJkhQklNwzPjAw5asQxtW2f1pDga2cYUJGAhvqBQeYrPi3D47QzK2I315I5J9nm05MBlMxSc/fS4PCUGmMhDU3H1O/t5EM6ZHgE80YP2IIFl0+F9Y9jyXezqWKWsEa2lqpMOZUaprXTDuWiwcROTckS5m6gbDKGUp68ehqp2okjyj3XwO64jslYKUyLqmsI0463XwxAaQytFonl9UswpZFuec7roO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:23:27.7224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610156bb-a44f-4079-0cde-08df3a8ff528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vf2pf delayed work is only set up on the ip_init path of
amdgpu_virt_init_data_exchange(), which also schedules it. But
amdgpu_virt_fini_data_exchange() decides whether to cancel the work from
vf2pf_update_interval_ms, and the early init path fills that in much
earlier through amdgpu_virt_read_pf2vf_data(). When init fails in that
window, teardown calls cancel_delayed_work_sync() on a work that was never
initialized and trips the WARN in __flush_work().

Initialize the work once in amdgpu_virt_init(), which runs before early
init fills in the interval, so the cancel is safe on every failure path.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
v3: No change.
v2: Initialize the work in amdgpu_virt_init() instead of
    amdgpu_virt_init_data_exchange(), per review.

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4b1b42fee6b4..576a818db522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -838,7 +838,6 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
 
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
@@ -1249,8 +1248,17 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
 
 	is_sriov = amdgpu_virt_init_req_data(adev, reg);
 
-	if (is_sriov)
+	if (is_sriov) {
 		amdgpu_virt_init_ras(adev);
+
+		/*
+		 * Initialize the vf2pf work here, before early init writes
+		 * vf2pf_update_interval_ms, so a teardown after a failed init
+		 * can cancel the work safely.
+		 */
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+				  amdgpu_virt_update_vf2pf_work_item);
+	}
 }
 
 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
-- 
2.34.1

