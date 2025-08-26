Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F79CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B8010E5FC;
	Tue, 26 Aug 2025 07:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMHG5peH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7EB10E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHgtWjiNz/NTFF3CbQbRDoGdmJ8Z+0+0ZRD3vpIjHLyAhcseCO+62L4nGOIlNRmmlgudP8RmQVar8EM2bKZjgKHT1JtjBuj+97cpVqPaF7/Azgci57r+2shclO6OPzEcZJCbe5eGXXBWop+t4v+sskuT6GyiWlcIIFCoJ9H2NIb29ad0+iPZNbphYwNvtVBiwZxixP+nJlS+vnmflU1kLAvddmoIekTpWfFJdXBhKLqb2lgoZOrRgAPG17P8lt02xMqXpWgdIM3EvMmRt+wwZFVjzMCmw7XcgTkp72GyxE5H3PlxQQtT1zL+M+YEGJkt8vy1tNybSIYucwcqxTRz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rln2GpdBXqwpFo55sfp+D6/bwfDp435Y++KEGqemfLo=;
 b=DSfuVB7xXE3Aitr1m+WaFjhM6QsWCApAsTaMjDp4zpiAfQLQuWRADt9e5dNZ0nvH4pWiF2LvnS+x7XJWDbF2Bc7ci5R0g6BZJjTb7rKF2CaNFeZ/ZfitBxQqx3UnzH5toeHJIahvGzVwT9kawdKqjmILlkPMzm+AP6MCqNv8+bDnsg1JK2hcW8fDCCX6DmwL2tytR6hYKdcfvqrntVBDq3yRtvaZ1gJvFF4dv/C0Vp3eg7plo+34z/XDXOe9J4Gu6hlOSJOgym7uDKqB4RHG/WMbmnpGqCSev5JI+qGDLWJKIjCbkOKCzhg0AniXv24cRynFUgwtVai7EW5cQ/fe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rln2GpdBXqwpFo55sfp+D6/bwfDp435Y++KEGqemfLo=;
 b=tMHG5peHXfRkWz8Yg552h2MxsMwnMt+/TUyO5YIJdTEdWdMOj2K/sS+VywDz2EtaiGYUoUGWl1x7JziN+Ihmv0GsId3OPzQZB+0WbAubG+paVavznsho/QiwLdm+qsjgGoWcZHQbAh98M0N3PgWPiWYuPa9DxH5TM2Iil5/U16U=
Received: from BN8PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:70::41)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:47:14 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::6e) by BN8PR04CA0028.outlook.office365.com
 (2603:10b6:408:70::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v9 11/14] drm/amdgpu: keeping waiting userq fence infinitely
Date: Tue, 26 Aug 2025 15:46:43 +0800
Message-ID: <20250826074646.1775241-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: d39dc6fe-7a63-46e5-c85f-08dde474c629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PswDH5DUwDtEU4RrQCuWbiyv8jOIYFgLqjZUubXsTOVHpWmjrWDOm+eZwuXe?=
 =?us-ascii?Q?n8MCQdlov22gJFwGAKxnaKddaSQ9IRfE33N/zgp6bo+BT9S0vgtj///MCvuZ?=
 =?us-ascii?Q?Hbp5KzxW/vXBlNhZfWWlkczBEYT7RGOjoj5YaB+IdCFhboeBsutfPdOWY642?=
 =?us-ascii?Q?YloaEPF6v+lx8zfuJQD9MjpbYnNh0H2UJW6CJcEjqWK4hqIMKEt4cuDgJrbM?=
 =?us-ascii?Q?jszFh3HGCkRDPOeYJkICzMuixwDc1sj5+5QFhMXjlZ6q48ovONbQG2p9PLPj?=
 =?us-ascii?Q?mWmVIpurT55LZsY4m9FhghawPYJyKaWAN4vJ0nN8Jrag7Jy8rvThKs9/2k13?=
 =?us-ascii?Q?sH1YikgqTJ7G5AojhdIHtDnIBJFm7FejmEi2+g9/I7p6RxM8zN/p3Z13Q/Xz?=
 =?us-ascii?Q?uW4BwbaoNF02vIFsCg5a+xUh10XO8oXBZKJvADFpLt8uFNnlMKUZTbB6vbMn?=
 =?us-ascii?Q?nBiJBYTGLE0+Lh3cCMlFyCjhT7IG2eU1mUZf6sXBpD+IRAY9nyQusRvmNYb2?=
 =?us-ascii?Q?AJ0vqZiomoz6SraruHSQwZ4Dyho5CyZ+fFVq/M+bV/hjF6GTtEFsTgWijsK7?=
 =?us-ascii?Q?tDT0IOVaLS2V1YRx/s4/iPgYKVWDcwELWXvkCYzTWBEW1fvpWze3HnST1gW/?=
 =?us-ascii?Q?21ukVbH1QghlkAEGzetmQP/nholcpwOMxyMbpwmDeMqCPbg8zpeJ+iRKwo7Q?=
 =?us-ascii?Q?qjFZ4UgmtkviKe1MmPve+Cla7x48IMwzCivpHNwUzzrPC8kCeq7iu1nE+Un4?=
 =?us-ascii?Q?JyY89VW0Fin+5i5ISCEUNoF4Y90zzlOWXMYpSTnadHYRb/Ndvjp645lBtWsK?=
 =?us-ascii?Q?tFq62SF3RcGvwEYjqZ98l/u7vDB71DmL8VEYxMU/cYZFDnOHJl8zRkwZUJmB?=
 =?us-ascii?Q?BVtN6Q+GdtepUDUK5eBBK7LbLLiBUydDWCnlamU2G/pneSlpQ7+Zz/X6J2NC?=
 =?us-ascii?Q?90A3rUqqphejQHOHpr2SH5X7n1XaUr0qlVEefi02J3hQFd8fztl4s6p7An3R?=
 =?us-ascii?Q?viC6Fu4gMeGnobozCdxoV8fO8iQg8+TEcTyPJlpsWFFz6trplMpUwy1s/XXo?=
 =?us-ascii?Q?bOiI+Orp4p1007tenbFaYqXkNFTx3Z3mc9khJYqOMhG2oM4ByQMLYdC6pSdU?=
 =?us-ascii?Q?UsGYG1J8IkTE6vqck2Qm4392IaRPygmbIUQQ399O2XBiPLDw0noKNDEIsKqZ?=
 =?us-ascii?Q?sofgTxZOHTXFzkMFGohMmqUanyvMI8nvPaPOMTfk8d22SeIyZtE0whEZAMyB?=
 =?us-ascii?Q?EHdxxrYEltlsY4g7rmFxu5zAJaw9qn4Xn81P9zsrqwvj+BiLQUiuGXyneZjj?=
 =?us-ascii?Q?js+kYjmT5HsFCkioSGvp6Rw7wBJFUfvgEa60S+MmDr0qpcW/fB69d7ZKAfMi?=
 =?us-ascii?Q?8rKSprAbusyuriUO/PBZaYmWxN6bWl5AXxxRPySo2ghzJTXzPHwlFSD9hyOi?=
 =?us-ascii?Q?JxheZhH/LXKj+nGDN6Ewc8AyvZ1lqf2KVbH7eR9UhBW5ZonopRwUbPtoJTDY?=
 =?us-ascii?Q?rdkLzF6kmD3I+HsohPG1FK/oIXL2El7M+o0t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:14.7987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39dc6fe-7a63-46e5-c85f-08dde474c629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e5891674b4d0..a78c2caeef41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -283,7 +283,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -291,11 +291,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

