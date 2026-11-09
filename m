Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64A606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eTgtmA8M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD0910E3AF;
	Mon,  9 Nov 2026 18:41:46 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863CE10F465
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if/iuXAz5/xVh23tfTuIJklYPg8dc+xgfyVl7vxQ1uvumeB8wwK4YBRrqG9yemX2nNI7DAJrAq5xhBd8rRh8zRiQj+mFHnrWw9WswWC2yPISxv1t1YbmYQMXLpBiu0Sl6zYwxvJ26XdBwb/otRg4I0uzrA+LJ0pfdd11k/VISTdEttiuvGBVUjSUPFcCSITL4nKHfJ6zSz1MghjsROAsSEajK3mh6lhZHufOuaQyQnWRyarBJ11srABpUMMBAVI4vvnxvrEHyrZEY5FMT9n3EVpxItgCZDa8mbfJkw/aWr2lICsdaYXtbc7qyT7g23bD21Gwo/JQFlsSv19myOgdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgfuKipohkT7DI2mF44NCU8IXmXIsxuUdxpxZPiHtpQ=;
 b=xr03FNmZpzLAjuFZXN8KTYRo+M+FQ6UfHvISVV280JFZ5t12SDdnW07vJ/AqAYwUj0HyFt/OfH0jXSR3dHocHATZFccU85qN/MfIb8PTa+QCbWtChU9+0VbwhhbJk+2AiYUUFC61vCPkZDeca7jgsZoOOGyUZj3Xy6l3QRvo9+DrnCwsB8nUkTsgDVVUYi2z2B3Y2LJxyV1kU8Pnx5pWuyvMU0LKAXfJ4/NJ/FXejzPMSIyLj3P/dVuYqQYOJogb1qVdhbmHOQ2tq0Qu0QaYsA87jVaabrRYUVTJ6KtodTHgOoAZWQd5/RPe/KgrOP2bPHew4G26tcYV5sLg4SyTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgfuKipohkT7DI2mF44NCU8IXmXIsxuUdxpxZPiHtpQ=;
 b=eTgtmA8MkWMxybaSmJN1IETxSKmnlpt80RdwqDsE7iHN2ZTV3dQDjHFMsCCXcnbMqD1gKURlgg312w+3xTbLCZxzVmZBPUDIDDOk8RVgivQvEhGlpNnzTpjWHsCMcINnIOto3UKHLQ2Po8SHacOtZChbIlg4CXxPYljJK/pf4gg=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:41:30 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::76) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:41:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:41:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:41:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:41:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <lang.yu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add a helper to handle IP version specific client
 id
Date: Mon, 9 Nov 2026 13:41:13 -0500
Message-ID: <20261109184113.3656539-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184113.3656539-1-alexander.deucher@amd.com>
References: <20261109184113.3656539-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be92f66-6fd0-4969-f482-08df3e911219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003|261102123227099003|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: d95R65vnNoQSiptr3oTJJKUYcik4W9l4TNdcuVE3Oa8XpLha9XCwl5Lfo26GbF3H8Wq0Wq+hUtNzouJxWHvgEKvPqpJkwLaz3mId6ulDhoB0cP7aG3kRWulT5Ng1eApxZjKGbui71DkHSIW4Sk990aUe8U/IyVoj6b232IhctstPMyXzFAkalrGlpC56Aj56lgy8lWpIg8GG9oRzbwitsL+yq8wHF49Fa8Oi+pmB4B8nqr889WXLzhctpnWisqSIKagR3r0vpqIKMu8utH1TKyWKWivM+6KVuUAjndU8/59imENMbSA0oGxJvUqKh9vCjIKl/72Vr0TiOcePzo/ta3+x1LKcov20BhXy83KyKyNEeciCzzIzJ5GgvhpIL/VC9JbTIlSEvwQGEqrdFMyEjp2ITvBbLJsWrZfnP5HPLtqxpvXWFbKMch8fhVaYBtROwc4xlwdbUjGz0vmkoeJsjb/sXoS5hvgae5IeSykJActnj8CSSbbfL/oPvlhfWSUoL+Nk5TBDaEpbhubtFsJR/98kmVpbaihtjaY6EyjK+P/0VWUcLl/UuCvG7Yvrkukx1ZCNknr7oFPNGG9OFlz3/7VczfMOWg7nI9tgBHy+6UJmHa4jWZ0dja9DP5TIUg/0nBWupU7Qc7iXU7gbqRzo2tB5c1yTl0yMgLWs/k2FXKDQa31ty7qPSb+a3AW+/k6liXvK0uK9ikkhc+hEoIUzqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ku9vJcdCXN2ZJiYdwUVMBnCyt42qk1mI3yoDUdDGipaVPok1lfPE2KPuqcOFsHxXP6ONLEYUEBkhx6z1rJsxynsvmn8CBnO9h1qSq8dh7brAYDknRUKv5Pvb5RB86n4JuuHRB+PeBKErEye9po8vEBrqYoXBJQy3p+oiEty5xk6FivmvTa8XdTIAE3X8sq+nMGZe3IaQZb6qqnrrG79WoKiJZarA1owOYVakr77TAuNCxryhsRIP0qI9DgTOOManjyNmNB1u447D+16Nfk8sDHpePAtGM5aZJRaa3yPEpffWO6eZWBuDOQVH7t3+RCftp3FzPVzReiytYQzEZU24JpB3LS8iMW3BlDpAz7lORXRpTcHjj4fLl3u+nzJfS85hI5ptj24vbpgBoSfFWLFoPYMXRIKZ+x+apZ1PjBMsb0lTYjjTBJ9hnF9+yxRZWK1f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:41:30.3419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be92f66-6fd0-4969-f482-08df3e911219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

From: Lang Yu <lang.yu@amd.com>

kfd_int_process_v11.c is common for gfx11/12/13,
while GC VM fault client id is IP version specific.
gfx13 uses a different GC VM fault client id -
SOC_V2_0_IH_CLIENTID_GC_UTCL2.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 24d13a74a181a..224b0e1e38ff5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -255,6 +255,16 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
+static inline u32 gc_vm_fault_client_id(struct kfd_node *dev)
+{
+	switch (KFD_GC_VERSION(dev)) {
+	case IP_VERSION(13, 0, 1):
+		return SOC_V2_0_IH_CLIENTID_GC_UTCL2;
+	default:
+		return SOC21_IH_CLIENTID_GFX;
+	}
+}
+
 static bool event_interrupt_isr_v11(struct kfd_node *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -299,7 +309,7 @@ static bool event_interrupt_isr_v11(struct kfd_node *dev,
 		source_id == SOC21_INTSRC_SDMA_TRAP ||
 		KFD_IRQ_IS_FENCE(client_id, source_id) ||
 		(((client_id == SOC21_IH_CLIENTID_VMC) ||
-		 ((client_id == SOC21_IH_CLIENTID_GFX) &&
+		 ((client_id == gc_vm_fault_client_id(dev)) &&
 		  (source_id == UTCL2_1_0__SRCID__FAULT))) &&
 		  !amdgpu_no_queue_eviction_on_vm_fault);
 }
@@ -323,7 +333,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 
 	/* VMC, UTCL2 */
 	if (client_id == SOC21_IH_CLIENTID_VMC ||
-	     ((client_id == SOC21_IH_CLIENTID_GFX) &&
+	     ((client_id == gc_vm_fault_client_id(dev)) &&
 	     (source_id == UTCL2_1_0__SRCID__FAULT))) {
 
 		info.vmid = vmid;
-- 
2.56.0

