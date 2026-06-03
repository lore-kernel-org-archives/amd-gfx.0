Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87889CD6E60
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232161120DC;
	Wed,  3 Jun 2026 16:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KWmnzwdp";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44711120DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjuLDSSMGxPXuUGcjbtdXkl/1+Iwjy15pXjquJT3Z+KKxxNY5jxtAJPeB7uTCaswK9iIzjdf62EpuGWF+cdPO8o212eIN7GUXheYR27FQad83DbPO5Zg1gjuzUbcS7Lp4jP4F1b4cITYqf2v6TiZ+xkw1KAQmq6d4wCFSF5+wi/ACVMTNHYmC+J3VEkJbua03ZU23gsnM1en4zi8+u8AtyQmfsIsdfASNsv3ZAGOS4cIm+Ra6ban9/mbBGcqMglyGSTt1a8pI59C/LtOM4vAMgiXfvb/hFSeCl75oOpVAoVNghq3Pbf6jY8XW0aOHi2PBhwKT3BDPUAj3kYnvZ6gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bhmuzUicmWTyiwSnzedeY8zaiBMYwcjZyY4j+kViys=;
 b=BPMXiZkm099Ke+t1r4KXtj1wxqRfE3XSdGqQtwn6wupkXsv74qSSSKBk8nax9LGj8JtsVKaj8b0ZcSlyKLnjuqFSh5Dfcjvn5HurZyJzJBQ9Xk096zu3nw3trfg009MFuDb9kY6+O3NS2ojLyVReLcJdFuqMzSDxjgE31aBs+4IGlJhRE2dF1R8qALkjxIsPBpiLX2EaB/7sy8edpVcYIH4WziFF+mRNMQaQ3HP3z9b+thZwTVqHXkPgVxA3fve76yKF7wm5/c+DX139U6DMeGCA5qQd9MkUAAKYaoB0Jl5+9XV1522RbP2fc7G+YMZY6+8OhUI17xUZQoF/WGfUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bhmuzUicmWTyiwSnzedeY8zaiBMYwcjZyY4j+kViys=;
 b=KWmnzwdpUeB+/uCUMgYpfGDbOaEYolOnWnkYUkMsNdACdDT33kBi5u6BUVxUnJ2rrzMUr7eqRkUe3PucCDnkkF3Na1QjbJeQDhVPINtUTeskAZukAWgK8cPIzBaMgSYbeba5VOmmZ9lGrNzRVQpEOhAWSAWWNuCgzSeOjN4IOQM=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 3 Jun 2026
 16:35:26 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::35) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 11/11] drm/amdgpu: Add scratch records to WAIT_EVENT
Date: Wed, 3 Jun 2026 22:04:50 +0530
Message-ID: <20260603163450.2678374-12-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 1236ffa1-c3f6-4b50-7f9c-08dec18e1dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ih6zqegW7a3rlNvE5s+0doJfxA113GQiBguxIeON/CHFbds3xOEDyDwhYkRf34/rhCjRrZywjNzFOiIxT/qolJW1fGkloiKlm4PRqtw03oVVfExByZyGpaEBJmin1Vazxq+OQ4cMr02pXQ6nY1z2o//1zvqreSUHO5y+42CCpeBhfIVDvYW2UKnpMu1pAia3HwpHfhh1OIeHTruU+1Ligxd91W7b4Isp7kaXCTFAPOuK9VC3j6ojyvzng6kk5xWKFRxcCRIEbppEC1BdV5AErN0Vgy3sKJUm4WrYPwUEc1kXw+VJSqrfP4Q+O3M0fAvEMR0Jb61UEwre/dDtNAuFcyIFQZWxDKgQqI/qCbUmgicxKVrFgpHNekCxqK4gsg8imRCJ6biOSKx4B/1ek2EzeVzGmXwpEeo5ArdmFd2KplV+y5xcB7SpGYhHJh2Pj4wqX+4KAE+kYVugBX2prMbqIxmTqUNAfMVfg/R93RjzZ4CIEIhsan1RiMuumo3OA9Xxww2vEQ/17pgfXn6m+vyxf6GTDdroQvT/hvPQWRA8toxq9/SHsvpEn3XVxF76buOLwXkvUkvViCEvcs3XSwc9s0wCOy7awuhjTx8EIE5RChteeEW1SwQ6gFmzo4uPonQGspGMri+WykkhBSO+t1jY+krlfTKLVqyz2plStZjt4O/7p4yvMMxyJ2P6yP0y0oCVItbq1cpuJ27B5en8+Pyqbod15GEo5iRknrpUAFEEobw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gs4VBetYthJZ4kzZ79CrPPG4b8waBiG27UG7Xy/tmiTgk0o1nYlV5xuBi0zKaTcM6lKWdYvgR66CXaL1fKqhX7sh0K66o25CAJWFKJWQEhVZxUi2QGAJ5xIDy/Jf4SB6ufUcGJ/er+meaIf5alIJYYkG2hfziVCCXaJ/aUYnmkyy0k42F3QfuKYKmnll3qvTvC9CJWDT5BORpz4xoKsUJYCaAcvR8360LBswyF7fOzhV10z5VAw0kruKT1YxxAf5PRHjvdugo6QGgc8O+rh/5RRPV6y4Btso/ug3PmiHZl8V6F9AfRQ1e4R6yw7ISZ1HxAACxmA2r4fJMRxhGS4Trwv43fA7ks9wo9OF8sfo2ACCWnPvNXo30rZLmfVXQuq2REcgSoDblWGEJ8P0UwqgYxYVNVyGxR59U1Az4/J9Gz4tauqZmccgYl9jIBjYsSTW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:26.2817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1236ffa1-c3f6-4b50-7f9c-08dec18e1dd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Queue scratch/runtime error records into the WAIT_EVENT path.

The INVALID_VA queue state is set when user queue restore finds that
required VA mappings are no longer present. Reuse this point to emit
a WAIT_EVENT scratch record.

The queue doorbell index is used as the queue identifier.

Changes in v5:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1dd0d5f152af..8237e74d1c7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -896,9 +896,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
-	if (amdgpu_bo_reserve(vm->root.bo, false))
-		return false;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
@@ -916,6 +916,16 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 					DRM_AMDGPU_EVENT_TYPE_SCRATCH,
 					queue->qid);
 
+			if (queue->userq_mgr &&
+			    queue->userq_mgr->wait_event_mgr)
+				amdgpu_wait_event_push_scratch(
+					queue->userq_mgr->wait_event_mgr,
+					queue->qid,
+					0, /* error_code */
+					0, /* requested_bytes */
+					0  /* available_bytes */
+				);
+
 			continue;
 		}
 
-- 
2.34.1

