Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012CBC55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 14:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A80D10E12D;
	Wed,  5 Aug 2026 14:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TK2REuyy";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236E410E12D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 14:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIso5BpIyVMoHJ3c63kItg14liP/bMtBMYLn5n7HqgCqHPOwfXnLbJ81gac7wIuJF+C1lyjRLu/Lan0uQvGb1VwrsSB2Bo+3+6AOMHDYw/sloz2lGfxYSkjpPbT6ctiwVbX2xvStb/QS1uyPlUDkcWPt0HqU+bNfoA31VSjMqW5hDyYB2vpWJtWtuhWBPW39WW931werSBfUzhspjb9LIoFfKJhNVqEmBr/Yd8bUSof8InqXCcXbOLGYMrXGGMGvWYLllBTcg8/ao9HH3XWRvx/mZC72ICe7AOHm109DvvayWCSDD8dXdfQfDegO/QyFVSUC7VxvcezBO/G13YYuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/YG/sHRb+shadOxsS5cAPGmE4hMI0iG+Xd3B+yHXwM=;
 b=txw4nGsIIxMQEu6RJVB7SEs0w3SR3Vpqj6V63qMM9FH6Ra47aSbBG+LiwJQT4HHdIS8dX45J7JkQUbQoUB+gFHTr2khH6YRZZH/zrjScGSWA51FXhPjel/X20QPbBa6SAKlSepjFEWZEKtiH9ITTQRNcjKpGralX6ZlzRF1lLBsZia2ZOMAbHCDsoy/5+7YCt84/RCl0ZkIP0+BQnw3H6a+BpkYERE9gLG8kyzi8hDszGwTWWY+Fnx5TPLdBs21lw0bivBgaUasrEZGDV1RLFnYoOK3njirUgGWxovRr+dD8W4Tvy6EW6YADrehZc2hoDa17nANyNIwoEPMe1poBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/YG/sHRb+shadOxsS5cAPGmE4hMI0iG+Xd3B+yHXwM=;
 b=TK2REuyyDv5tDedrsH9fw8fc2VC+cTH2OfSyeqsnQly24HBshdrpnLLtH4/aS5K+FUGBcI+1NRa8ZcWzt3D+Eyk4aNbDWSP2tRfSs15oCJvsprfdvIl9cPWrdjan3SA+dxSFoyz5bIVTO4RaRMQX6f9NvORHxdx9qa1OUN/vj78=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 14:02:09 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::6e) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 14:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 14:02:08 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 09:02:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid integer underflow with ffs in EOP ring size
 calc
Date: Wed, 5 Aug 2026 10:01:53 -0400
Message-ID: <20260805140153.612765-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5a347a-5b49-4e02-de24-08def2fa23ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: XZHzqMnTlEtVSAybjCpC1VgLq2EZGRc2ODGIIMaKxGE9qHVMV4Ecgpz8CuPDi6CUUoDGJDrbrhThyVCyp4enTfc85Thj/+W67LKsKe7jRgaDQzzQvZRz/rqQsWSBpGoaVbavrxuOlxQo5IU1ciMhOZu9lkQWWCEB/xiYSGP/7Y4KVsJhEffbvw+pjSE2uekwMUbtFfJD8FJCCBiL4LG1PXJ1oyXZ1mp6B+NxcdwQRQcmEAgZRIThiUm7EqUVYLmtH0vAsxT4C878BS3HKX0QZgBuNiTzNgPPkNcW6Khe2nXgx5F+zksAznA28JBcjTciDzUATFMjfA3gnqnW2PA2arwh0mZ0c2gh8HdtaXZMN430RLHBtdaAq5mkFjkJ4YnF25IG7hHlpjJjU2dK84JmNwwVrdS/wN92m+Ps7965eEf1do7sw+1R6y57ILZ8b5Ep+39Atn1a060Wfh34WMcBAoYzIQixsOwzcuDjqsmAyxJzoz0OZ7PR/1sMHm2zJPyKItRgk4xLySJ0+5ggnJ2hm6+iw0GNRMpF7NfypHcqNnzSHW7FExfrmE6WjJu2Xqy7d71NHjT+tk+kKNTScpDm/+/2mSRb7zuIBY8LKyJ/P91cNtR2oslQLx3p83xbJ8sEmP/HctsQndnr7SY16izYLPXwfeIk5vL479qd8mAEGHXKVaF8dnON7PDv7Lr6APO/HTspq90iueaSYIgU5nFDUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LstZ8Rejpojux63dysicrSXSGnxycjFIrty5B4TRMfwNtr7Tj7fES3n7sTZvwoMFBg13GoVQw6l04/B1gBNTIwPZjALxfnLTbHGHQXl4YGkYN+o+97VGPuhBmfmotNJHfpJo25NTGl8BUWNVSkJb/w/QWZMR4Rc4nNAISGOIhy7SuKR0T+ifgM3VscEui+18gaIzdy+rMbez+maHIJNaknEwtG4CCpuPOy/BnUe6V9gG5ULsgRtsw66cTUdS7lmDVhWKyPMlZHio2UnwuGN4dgwe5CEdfJPm6irTV8O0487MWsNvPzaufr7+LCbAPk2qiU7rydVDg1765qrNvMoA5VxIHA4VFffFs8GEyVQyxTFcU3Mx4fzayNjCvF6zKdH3tbbDUu0MwwtYWlh6wISWPxW/AMpu00n7YVXfaYPRQNiHqIbWInRkUEAlpZxKGxqb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:02:08.6267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5a347a-5b49-4e02-de24-08def2fa23ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

The low 6 bits of cp_hqd_eop_control store the base-2 logarithm
of the EOP ring size. This was calculated as

ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1

But ffs can in theory return 1 or 0, so this could underflow
(although in practice the ring buffer size cannot be less than 4096).

Change this to

ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)

using properties of logarithms.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index e034da638c07..4f8a8a1a6186 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -204,7 +204,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * is safe, giving a maximum field value of 0xA.
 	 */
 	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 350fcbbba4b2..bf015dc5b868 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -242,7 +242,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * is safe, giving a maximum field value of 0xA.
 	 */
 	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 7c387fa90076..3942d6675268 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -217,7 +217,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * is safe, giving a maximum field value of 0xA.
 	 */
 	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 431a940f91f3..08da097f780a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -295,7 +295,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * is safe, giving a maximum field value of 0xA.
 	 */
 	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
-- 
2.34.1

