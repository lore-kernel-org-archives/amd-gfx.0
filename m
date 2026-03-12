Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEE9FED2FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32B110E9BB;
	Thu, 12 Mar 2026 10:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qwEuovAg";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEDA10E9BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYEYhKmiYx1vrf0d/l3EmLZ8t08ixHA70jBJ6izHroPXrQXDFq91mmI35bBnYREL4KgV4UOZ41s1mF1x8NAYTTm9mW8bPO3VGxqmNL9JyfbMDrp/jWMthUnQw3r0hf23CKQJms2zS4pikia8mCRLCt5LfF7INoGx32MGVgWVoS9UEoYci4pO4ww2RLYY1Uq1ITYWfztsk0sU/jo2N7LNCFu4hygMSxQwUD9x9gAoJbFzWL3X7fcR55PcQ3NnlBU9qdMzwhLeniMjsxKjizJWWdPoAzdcgRHbB3fCYjEYr4KTcKHxWzWqbWElOIHa6o3RINTKMrXqxeA8/nInlR8QcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+XgWGtDbWYrKrXSeXSSUSA0+5Qbomm7XEToJSQSHaI=;
 b=qCOH4NV3nLdFJL1zg4cQzQ+f5/Jx9cZAfP1P8fM2ce1M+daEggq9HIjwzBCmT2D2QNkl6ByBcb6F2bYHnKzGijsIngvZeWuu3DUsSP37ZK2KN9+Q6fjmSfObxRa9ltwFsgC9M1d8YUcLSpAKCkElj0P7bk8iDBdp7U3yWn8krF4lA4zD72YyolJWfVm2SCQGXP1XO9T+Kh1R95WrRNqYvYeYtljYtqTUbk7/AKQqaHSxFXn4zc0341mhHnfxZrrMLCo/DwfSpqCt/owFGjc4hC+RDwxFB+n/Us1SeQiAHSPc1JsuBbrUw5dQYEhswKZGnkciphZqb8UaKFMYnve9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+XgWGtDbWYrKrXSeXSSUSA0+5Qbomm7XEToJSQSHaI=;
 b=qwEuovAgDZ0H/z0QnzUbh5AXRhe//FGzztnMa8N3IAxhnU5k/ozIYWvvS9E77Ia/bQZcaoTzeaQYER5abCuX9DzyVqVQV7zRucElsLXhhc6rJ1vD1K4Zh8h7KisCwAzj/KpfgaOIuH7B/q2+w5E6S6omNsQ3IUVtS7AQ6B8C1Ao=
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.3; Thu, 12 Mar 2026 10:13:42 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::9) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 10:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 10:13:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 05:13:41 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 12 Mar 2026 05:13:34 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Limit BO list entry count to prevent resource
 exhaustion
Date: Thu, 12 Mar 2026 18:13:24 +0800
Message-ID: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f0db4a-0724-476b-4641-08de80200975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: bo8OQjmd4IlHn+m77iCLkOUvp2xYgGoPlRQpiJnC19B4cXFwDn17lqI8up2l2SLn1kZ/d64HVPcSBfSIPX1UcmwqVR4A7zwaUGBMlBjXh8ovKp04oe7ccVZ3JoiDHVOErcfItIkmo2OIIKlqLLRZaVOgQEbczxw4r8CScnTWNRZ2SqDx4LfViCKjtDHfYBPtEa6GkVAVaEM8J61Fw26CXs4auYL8MPdbSQMgti3O0sw5WV1V+jzbNAg80dboTNFD5/SxM2AyupGHLm+aYkr8RqHg0Epejxes5QMgrLFy2BfL/5lvquBpHPwLB0XA0gKyWi6IzIVk3Jz2TsqU135aY24uUAHQiZVpwcdbajo4/dECks71IrAzWo4i8jAkb1EUXNISdbRIFTzZPIR0hoFlw2nxztJpKaRRscJwTA07w+XWA5ltDWhGED4KARl5cWI4CifpPlhiFBSJyZ0JiN1hIzi7LdE3GgXkhI9Tg3+PDIyiyCqiFi2QHiDZdlAzOeJSmiSYnSFt0JSM2hLaaQJ4yTfBhJhvkTmnI3isFeufd4Ck+6QcQmfM6SOmxXUbDyF3x69FWXG6RXiX51HmE6n7DDkDn8OKKTsjZDDQ/DxCXCumk2FXXQQMeZ3R5J7G1fD+RBtKtasIt/SGmQT/RAKgsv82AJwkK29HTmFeYlNHSY652n/wQwgdHYqFUNOoSjdLCor3riEfzo4cCxgua3RnfIywRZYt6n+yhmn3zmvtIXqR92a4Kwht7m1NiMp2RRQ8b7XMTDYL2nn4TWW19GElOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MaRX/EgFVF2veuWgoxNIa36xGsmVkDpKTccXh2O8WpRQEG2mE9WAznmp7vgamyYm+BkvH6whF+8usqWFDpAGCkOFhcXRoPh3f37of0X6WY0kVZ7dmVg37k8K2pZ9bYo6mwwbQSrz9WYaz/HeaBqmgjAQFd+35RGOYwKpq9X8FzrOMqr4VokM9eLMw+GlIaPMzCdQRwhW1N6MwH4Qm0IKYen/qahvFgHCrjOoMl8nJVWcBq+k5PP7of9LySSd5TRmBdrPdMr/K9iw5ujDWlZznavyp3+QIrwfBndFvXG7cEuyVlY6sOXu4T96jkpqU60BkAJSQGN2dBthQbI4iTyWUOvwNS5BiikMYrlV+toTUT5TvJGobGA/VFg5nxo4xO1CRgLBO4rTKOMc4ArpqsUAXsG7CY6pfgvpg7E/DCUMFKiTeTs83YmQYETtxnt4/Kai
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:13:41.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f0db4a-0724-476b-4641-08de80200975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 87ec46c56a6e..3270ea50bdc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -36,6 +36,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -188,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.49.0

