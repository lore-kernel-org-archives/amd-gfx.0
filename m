Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF219C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 23:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339326E115;
	Fri, 26 Nov 2021 23:58:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA2A6E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 23:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF3XXK9tWfT1xtiEzCHRoUb27Qc1iXdWsCbKIxtOI7WJlHdsf+DbnUM4+ET0BLdR/aQiZ7yNvt1cLte0YnkmxpB7OrAnWles4WjyJeFgfpz6QrSAR3d/MBzGHpW9qodU8/CxUNGeIVrcODuOmefUz5whMG1ElANr4v4xGQ6IwWuzBL2ZrYf0J4WusjE0rLHPCBG4hK8M+2Fp2xIJKyXoXdRPwnhefuv5s6NxX6/oXkXAmWhQ2C5PHwPFeyBuKbfwBbElf79Osl853LF1+Zo04qK2PyYMe9fmeIGEW2fUNw2+QXUd57i1nv4nYFuF4TtkZfX9j2zFf5XvuiXmK49K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KBXXT6rW3r6HWV0WMBWNoJpRPZpPU3qfj5CiKSp9Xg=;
 b=WgbCU12cBHA43/7vGVR4E6KThjOrWjTnbyQdx89+MrtFKLVVSoAuHWiFxjXHWswwXLaV0LTgOI9G6rMG+4LzVi+RVSSXpznAXh+5fc+wy1YpAWPR5Ms6wk/9/jtHji0wZwAB0MK+S0DTpFtf2dHsMAezid55MFjvc+Guk0dIC/pfapaTEnD/YgpKjl3w+z9tD+mkKT5FQ7TYhf2qGqLk5efEQ+d3fGcsCa8FPZhclA3vYZ+Bd8mufMFjNn+klKfMWBcKsdFcmE6aAWfUWuyV00i4tRQCVrjV5VwYmj7Qw9RmjZs+XdeJ+19wyyADKfNJGmGpyo/p9/WiPweU92B4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KBXXT6rW3r6HWV0WMBWNoJpRPZpPU3qfj5CiKSp9Xg=;
 b=g8nr4IXGVHumZK7+pIsH4gJfILM/cZ0A0GXpA0MvoPXrqEslyIsJ6TywJlDfG5gddn9otTd1XTkxPrkYmMRRCAryxX/eke+EY+YOuZ2WZX9UtmAbpjAn+ZpNQl8g1gHXHAh0ziM2yQHEpxRaPatGtMwlbj/OsIHCmb+9sTKjChk=
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by CY4PR12MB1143.namprd12.prod.outlook.com (2603:10b6:903:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 23:58:51 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::1b) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 23:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 23:58:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 17:58:49 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix double free mem structure
Date: Fri, 26 Nov 2021 18:58:37 -0500
Message-ID: <20211126235837.11229-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9a6ae40-74af-465b-0ac3-08d9b138b1c5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Antispam-PRVS: <CY4PR12MB114324A7EB22DC5B8B6BE954E6639@CY4PR12MB1143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/XP6DjN4jQkoGKTQ1ZvlXhI4KQbKsFibj8BWwqYU1qgTvfMB0d9mbjBDRsRTM04dhzkZDnb8LRnGm6FmRyV2MFHiMUOsgCN9PhCVzQaPB1/femiSFWLqYiBV/yvxeZSPTiABA2p/3EBBGOiZtfy9YWKaa8L1/FyAlU8rNti2O0jfE9bw5yMWDR6/SHwj+tDtxDHXeyM1ACb6VpKVwRJP9w3Xo9j5T/yH6GBkaz8CTbVM2EtUmwBD2OU8JKLy5j05MeNIY/cVPq6Uqrk9vOZoUnjgaC3rfJ1s/gLP0e5osJ8uixl7nGLpjpeKOBNbjd8NM4WXmPTUCQpgxzWmtAKhkRwLczmpqd2Fg3+CnxuCQuTCTr9j+/geyBm2AXvFnp1RwGMH6FRdKCxXOvkD2AHlGZ0yEnByYsJSTonT5vwdetCxCh438dKok47kqF+dWoEv0NFw/OE/owbPS3NdgIVXIGGkUjCfWrYMw0w1s7WkAemgs9zJkAqlCyNLRtjVBCwtRNUv7sHzodc85U0PZ/5ATrs1vydKb91l5qrIv1ZTL3ATgfCZHH6kUBB3A0U20LAdSw/dN/YrTaRpviXRZsGKCBfmBAJbJdyAcZ8uP0V8iW/yzezIlIkqEbZn4Ae0CX3LIRnwOjpQhMuCJYukJtc/kcR40rNGzBaBJppnAwU8V2vyU+/4bcaQdw29nwm5Lsl25bBpOGQTA8F0fpjul0CK1qsfqlJnBzkufX5saXiRos=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(83380400001)(1076003)(47076005)(4326008)(16526019)(426003)(316002)(2906002)(70206006)(2616005)(8676002)(508600001)(54906003)(6916009)(26005)(36756003)(86362001)(5660300002)(82310400004)(7696005)(36860700001)(356005)(336012)(8936002)(186003)(70586007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 23:58:50.7341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a6ae40-74af-465b-0ac3-08d9b138b1c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_gem_object_put calls release_notify callback to free the mem
structure and unreserve_mem_limit, move it down after the last access
of mem and make it conditional call.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c5362c23e687..e592a2067133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1582,14 +1582,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_pin_bo:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
-	drm_gem_object_put(gobj);
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
 	unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
-	kfree(*mem);
+	if (gobj)
+		drm_gem_object_put(gobj);
+	else
+		kfree(*mem);
 err:
 	if (sg) {
 		sg_free_table(sg);
-- 
2.17.1

