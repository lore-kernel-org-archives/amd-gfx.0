Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAEBCDE009
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 18:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744F810E1C6;
	Thu, 25 Jun 2026 18:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LVUXe0ma";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B226410E1C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 18:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTRCeJoE0VgMzWWSQ/jz9woZiwFRQbWaTQsbWsGGDwtpKuE3RTV4CfBRKnGEo7jbk9uUvY3oq0RXJDEVrcmsMyouJrf75dZ+O/tIrw7GBET/7J4ZOCq96SwjC2zS6C+Vzrg3fAD8So75ptFi8eq7CnPjWN+wxO5zCed5M3dpB0p4NJBFBky4BN5gWJiMI1t8fjdLq4U6jJeTySTvmT/cpzXmkYDA53sjlX+Dyer1dBQXRVArOacFlG3jqdWME9hjzNT4I03d1U4oRqc0PGMVxPwY0sT5cUNNXurkWjXbOEcKpWtSjG9Fc5RlcvBfEDMcKH9Z6jomW2Hb5fWyTjzeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY64r92BwgvhIT/s+QWsb7tpmcDKvmOzbeThc+qHd7E=;
 b=zITtIKlYWmvjo4HLQwGeBqCaGHgFGkxBkxXO23CPklwnKGYPkXa4Pv3TYbHAN0upATL0UFx2hr1BNnUPvvOtsJ8Dy0+eiR8R2lLiv6grjDDBlvmgwI3yoyZY8S4Ybvc9iJzxEwUG2iUAIGYYG6R23Y2egn3pDUheYND8rfyVs+zlX20aoWaEz8BoUcgNSyO93k2LHyx03GhFz4veVJuKOGHUUy6tqKVVbvyqiLRWz9s0VrlGRaJtWgHa/VqNmk1D303Yj4aURN10xh0+3na62YdLmMzcyHdkFG7k0g0/fDSQ3fDGcRSA78WMZ7uJrdHmOkQ30nGmojPeeBKwxjMffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY64r92BwgvhIT/s+QWsb7tpmcDKvmOzbeThc+qHd7E=;
 b=LVUXe0maagESFCETxnOe9U0w34BWBtnNQZ262ZkSY4bYJW11Vu51uMTZOV0zL3etk3jGkufAOcFs9x2J78Ehj6aVdjynNfKOa41gujlPOcGMr4rq8mDwSg7MOWD6RJBBnElIWo+aAcT7Od+brlLvoBvROF4S3yldxSCoAarI8Yg=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:51:58 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::26) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Thu, 25
 Jun 2026 18:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 18:51:57 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 25 Jun 2026 13:51:56 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: use node XCC count for v9 CRIU control stack
 restore
Date: Thu, 25 Jun 2026 14:51:45 -0400
Message-ID: <20260625185145.733651-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 369ee3fd-b44a-433b-48c9-08ded2ead516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 6ReL3lmCtZ3r389gNsGKa/iT/zbY0CkOVPHLEaqyGsZILk0B9CYU67rzVbal/jWhZRkKtDkXpMrJb0hvf9sdEjDYbnVKs5SW1U5kh6gzTku/Ags1D9Khs6A/8tQihsz0UElhVkgH4PpbuFsGasrGWmjcRhx+4e9NRjOEnaYuAc0zxnru8CKkV3oBzwhF9OncaHPdBxqAFt01yGpAQ4YDNJF71SHFElZmazQHc8OVKYPOiM2TY2hCE6o1dMazq2g1vB2RFAivQJOilyKOW1vMwJ7ckGJ1xZLF5Nn/Ekk1P3a+mSnKczXUSfK6LDj6ecuV3eGMTpncCfZktIb4HjEz4sIzq5L0TOS+Sw8jGChzRs2jR332K/bo3KDI9e8vRWKE5e3IXxFPRVw8iYiDIEYfxBjHBis1We+YR8pvOxEnncBXJm3GGW6E9wUf0NjVeI6G598Z18pI6vPK5fizy/UhnETi67LFpyum1pdtz3GSnveLGoauzXJqwVzDnahnAew4orrTKkBLwM+C5HJG7JhswEyiJ4nCuZYtjeHy+048MaAylEfJT83Xhh00BgLI4w3/WyviR2feOzw5lX0rvTtxlZ2xE5hbdTA98FkwDYuBkSu1FhxJdOfaeVV78d46RRI+iiyBr5uDrHwJNKYJbkf/5EcgkaN3i1St6gjpesW/GjKkwyaqiTDz12fUMj2a5vkQlrZ6NwvGpEZ07aFGGcKJfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0kYfRCpn3LFNlqTq9Zd3V0ps+CiM2k0DJiSmov07e2anl8iG/BsyC4CHK6hzR3lBSGMcz8jydlgwNedNFD4S2/RS+e0YO2ywbkxVrQY8xz41AvYSU1f0csYP23CTefjU182DC3Q5DxyFwd/CyrDFmzoMY2UEJ2ZuKWZaeqjV5m7tVNiLYsscekjvRDYYE1nZuTSPNHeiiMAUwrlACOG0IT/XstcBC8CcggL9umkKyWCpyi+Ph6Rjn+rgZhtXmtpMUcFEkgZBvClnVxsNEK0R0th5UDEUlLk4w0j7ub3XoGElwWiGi7C7jZke9FRj4PdkHHs/Mlmt/4jl78tHIRw8T+MjHXDO9P8N7TKwAn/llno4g5pLz0uP7Nbc4Iz8wagaf4PKpXIH+39H2EBeff9V7y8kcYUWEGHXT+B4vkgI5GeURMNtILbfFNyYuK+/jWz8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:51:57.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369ee3fd-b44a-433b-48c9-08ded2ead516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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

set_queue_properties_from_criu() divided the checkpointed control stack
size by NUM_XCC(adev->gfx.xcc_mask) (whole GPU), while the checkpoint
size was recorded, the MQD buffer allocated, and the control stack
restored using the per-node mask NUM_XCC(mm->dev->xcc_mask). On spatially
partitioned GFX9.4.3 (CPX/QPX) these differ, so the per-XCC control stack
size used for the restore memcpy could exceed the region sized for the
MQD allocation, writing past the BO into adjacent kernel memory; it also
broke legitimate restore on partitioned parts. Divide by the per-node XCC
count so allocation and copy agree, leaving kfd_queue_acquire_buffers()
to bound the size against the node's advertised control stack size.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 071f956f183c..0a7276eadf79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1040,7 +1040,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	ctl_stack = mqd + q_data->mqd_size;
 
 	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx.xcc_mask));
+	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
 
 	ret = kfd_queue_acquire_buffers(pdd, &qp);
 	if (ret) {
-- 
2.43.0

