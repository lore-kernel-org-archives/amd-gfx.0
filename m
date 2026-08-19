Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF62C5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 07:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD1A10E529;
	Wed, 19 Aug 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cSPbPCrM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B47810E529
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 07:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVBJ7oxS4fG0l1+FdTtKG7eIWQEj9FaUTGYlIcQUVPzb0SbMHHPR4yXGEjzDu4gfwjCkgGRlb5IBai8v2fVzEBbi9r0Db/lC+XpIjkKBB2LNw9iXfoYYPLW2n2ND7MApPljC8hyYv4TvDvGsWHyLYfWnjq04NMJHGgtPwPh5nUN0Umw2jm5JTcBVHOOGu24ldBaA0Tp8UQbN9KH4nYz/rCthwYDE9+zhxJe6LoQBJrAcNhzinNo08bbtoCW5m1/bk5GjXyU6lOiIKDl00kiX6NGmIUUrgT482TxwBTxZ7m9uX+wjSq8iQj6/8EyXyTZg4n3m+LUI2WeUj74qQVSEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZHUFinQp+MEd2ecwSuhV8NC6OnXxH1bk0yBGayG254=;
 b=b2whCbch2hfN7U+SybtmSUJA0KXWEZRZOipDzxSmj3RoKdV1Gxxth/8Y8U62WX4wM5XlZ8D6/UGkjQKas6LHEad4hCosOIZ9ILQTQRmDerkdj/oP7M14eV+/8xJkauFF70rX0uhs2VPDvmNk+S32pUADlPZlJc5BcQdNu7W4+0dpwCdqPQ1/PzGQHLa96DvtX4gs9TkhlqYN/+I71mMk9KT3FB5b+j+KmTWoWA9u0uDM97O+b2+yjmPqKoFgUsU5uw+02BpSu1Li523sr+NhPkgEBgxUw7ylCb9g3/4mGAw9riQzrjBdE9hJlyZ5X4NkJj3wcAyFfv9NxaTgimJyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZHUFinQp+MEd2ecwSuhV8NC6OnXxH1bk0yBGayG254=;
 b=cSPbPCrMSI1C+0WmgcJ5kqEBpxcaelU42mRhx3p+j9tzl/cqMOKv+9BqoxPYOUkzH0dyRKWAfaFX4ZfG5Rq8biqeB8B4h6075moUDkDVAYDnRPZgELZuuhDoGNAubgfwnMgD5/q5hUf021Er0DMZ2/XalkJDKso/+PU4VMf/ui0=
Received: from CH0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:610:b1::19)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 07:33:09 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::16) by CH0PR13CA0014.outlook.office365.com
 (2603:10b6:610:b1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 07:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 07:33:08 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 02:33:06 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amdgpu/mes: fix the inconsistent indenting for
 mes_userq_map()
Date: Wed, 19 Aug 2026 15:32:57 +0800
Message-ID: <20260819073257.428030-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: d87bda17-14b4-4932-20fc-08defdc41dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ArCjSNGr4kSQN2/a15Undf/fWZ8vsvPxBeCB7GyoitxgnQ1BKLJIjPoCGpHlCseXxZ5ao2B37ddTLTcWNUQuyRg8hTQoVYeLB9SsSQBGKlWHARDEEqFCb7SF/Jv57RlDA92fd8ThKlKVOnaPopsfb2bDO/NB6rDH58gQxJBL1c8tByGyOGJ1TOjF2XAEUdIONS5s6iRfWcWwEqZ71Cxa5yg4x7R/jn9CtmxvYSitVv2MAGNd653Cn2ich+zUp+Lm2hvHGMj/aRw05d/NUjNVLQZwy2Ylg5QXb5eCdizWKdK6hMiEPi/MJjrFLZPNTcbtbDnreMKbi85bPmKzW7uUVNUAoFjdBValp6tVh2F9rH4L+lg31mZsJ92G3qwyzlqpMmaaw1MfK2OBjTRKykvR6weaYfPGlEqyqTomw8ccX/WEMITr9ibu0arxArbsKWq4KTGAT3jch01yLRmJRIo8tJ6BSsIbtei4PAC6M+aQch6KNyqI0IxHBbjTx5Q3sRmB9qf4EMOb6DrskkHwkI+rueK6uz8B+p5qU/KvYSMRs4uMG50+P3tjT/h7dv5vV0mcHgk1x5gzwuBT48/0DR7Un2xB0deXutGoM6aN4NY8OPhdTt8ErhKzHV9moSvTizhPsN0QPXxZ4Ukm2lwkcqmW53IBSZMJn6WGy1ABcpci7a0pc4WPUJWB+xGh6fkDS+994v9PQY+n6IT3u+C2TomQCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Km0qfvRlDNdgVAwps3bYwjDQLLgw/oudSm2qPjsskAueo/BUvyAICQp9KHicy6bvRDsFftJBrQ+ntJbyHgtImT1A7N0fYBfVrRLnrGVhk8Q5YX1+PtvzyoV+tB2UbI+pqA6vUSxSR+ANK/w+SwM72LJzxHLaR+7pveTZYco50IEJgv0Oe+UCNT8w38ww724EF2OtYHywy7pti0tr6bbBdoHmD7BdPF6Sp/OdWkhBbV6oM1gsR46zgjrv0jMtEGp1Hqt3PiPXyaQXJqgHRGfKoJYUGOswXR0ltQ7vhaCu3SSgj/RPhPiyJkBOlkzHzwl/hiHhpZH9N+W3OwYDa95uO5N4KR2LSj0mMdIpNq+de0pGXSZZDogC8TsY1t0rxzQORhT6MyKLhVeXEjJD1r8JkTXMq3c/3AEKotwRXRFxg7jZFsyxw0uGgJG3rSJzW1H5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:33:08.7273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87bda17-14b4-4932-20fc-08defdc41dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
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

Fix the inconsistent indenting warning for mes_userq_map().

Fixes: d0827dda8fa7 ("drm/amdgpu/mes: refactor the amdgpu_mes_alloc/free_proc|gang()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608190252.8XCa0HqR-lkp@intel.com/
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 80f84bc56664..cfee0a8a4b1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -146,7 +146,7 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
 	if (mes->use_rs64mem) {
-		 if (!uq_mgr->proc_ctx_allocated) {
+		if (!uq_mgr->proc_ctx_allocated) {
 			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
 			if (r) {
 				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
-- 
2.34.1

