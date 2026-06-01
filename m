Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C12CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 15:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A491134E8;
	Mon,  1 Jun 2026 15:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y78/H1hl";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EFA1134E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 15:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv3OjfMoR7I9uDXMM6Yi/3pEkOLKaA8LPegDuN8yB0H/uGmSnzDhlP4vmCKbqBd6650SLN54HY295DQii5Z7hmbk5ZXsSCHPQ1dMyCXywn5VYgETitOhldokSrw2K2AOOFWnYtZLJlhl21jUurL+H3Ir2h34zJQyZq1QWKpmv3x3M/tizveE6izSJd8D7SsxcE/YY8qYe8A0yNYtQCMFFPiJv9lGuWqlsow84Sen5blk9pbI02pOJjUutnkCo8cEcDe7piyAcM0RIpAE5KrtiHN/OwWfDWmmFMJDKhZGa26FbQZZaYM0DAj2L5jHB82wzjpP9glsOUR+ffXBCRgy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PFFwyIBDKYCmnF+ISYRpMXVWzOdlxzVSfAE7hkw+1w=;
 b=Gq2eUoxMsLwWF0IaluU4ywJ6xtFN+j1lU9vZFtTKQH0Ya+JbimgsOwtRwLb0pbV0M1jQirNrnz5TgATFGwsezM9IobTW6KnzIqO9EZBJYXvevZmhGAklNlTHEMkf/j1yk96bwkxPMFkJ+kwEp6cxGr4sCIBA7rEojNRvS3eEHe+F5lcE7luWPW1cK49OZVvZ1anDilJ3fYDXkMt4UkQ5PoGqwNpSHiV8STPpuPhWvur+3niNdO8PSKTyCv3LrL3/VSWmgqOEHsTYhUHsqCy6wwn5WI9k7jr95jqXzJXMnmD9i2ZXTAOoRMoZYe02LUCQvxTeCiDA/2FpxIes2DXE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PFFwyIBDKYCmnF+ISYRpMXVWzOdlxzVSfAE7hkw+1w=;
 b=Y78/H1hlntkizcuq+fF46tjw0jX9ozKsTD0smF8oAB0wWmlHNrsybMITCDjGWO6GNnOOxfpNDJvpv7stSCxIiGfRooI6q+Kg+3DxR6rOMwG5ezZVWFyI8oMNysLNlHN1j8Dt2eVYl3Nwbl5027QNo8DuEaTvHxHyCx6k3Y4ibec=
Received: from PH8PR20CA0004.namprd20.prod.outlook.com (2603:10b6:510:23c::12)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 15:41:57 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:510:23c:cafe::6e) by PH8PR20CA0004.outlook.office365.com
 (2603:10b6:510:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 15:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 15:41:56 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 10:41:54 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, <alysa.liu@amd.com>, William Palacek
 <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: Fix OOB read in kfd_parse_crat_table
Date: Mon, 1 Jun 2026 11:41:12 -0400
Message-ID: <20260601154112.3057426-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a78a4fb-9d29-4f28-cdf9-08debff45007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: qVLOl3w/HFe+gNPnhba2xW0bkVH4FmIzCXb2zdMTMvM1GOcB2M9tzMOzqsG48FjMIqzegbBtI8ULpMpPsQ3mvu4ZrmpV6Ll4P0aHHkfbYTFHLqDHTOlziIcd1nV768w3fSo8qNcul+4gKFLvYA6QeHXJ0KOREKLDNqa9aow/tl/SbGPLwZ8pN8G/aao3xEqsYh8Zmaw9FBVteo95g+HRJPsf7/TIWVRQiArm+rOjgh7w7k41Co74BNE8RwmNwTzTsmctaSTNHfoLSpKis0ZxclKpXe1TLZe1XQ7I49WT6+cElZKwmmG2yygrvozY6LbJ6obHwUZqIkDtBe76L32ti/dXqxBqXJINy+maE4q1gHz4MiveiwhtTnjJgGfMwAAw2YgLUWhH4Ve+uwHkfRY2O+0XwLLJFnO5j+KreMdLjfEVmnEdZz8OJfJZzGjhQvrEamUKw0R7gVJ4OeimaDgfwVDV0ZV5BxU6KnnrImHLG9jKdfvOolv246DaNO6XinUdYGlUHPos2ypNrgGIpCz2pkOVRa6oYWUHZgzqSfzyL9oV+pQInKRWdV8o2b1vSJT3lyGegvf9FcUIiOCU5Z2NLT5GtlE6SGirGcBoU10uUYF9ErZt5DVa/qCw9E6Q6xymUYwdWi04b4s6stkNe8WKrdfw/4SGge1j+Hh2DGMmeq8okJXObz3IW2tiLabZlvv6QUmex3B+24Sn97EJyQtCA8OBicUKGLtucQM9JsX3/L8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wa0TI7r+dv+FN8KRr6ya2hAERacgcu3hbWFJKgfEtAPkbVDesqtqnrVMddO31L3NVJOJjCNhvkHWHPN0CIlgjlrnN3O28C/KtaBA4rVx3vsOQwu1ZAVni2YA2S3EfA0vXQnsAUbl8vgvk4xO/dmncOc+AmeOglgR4KeH6k2SAucGlfW1/EQtP0tuUOgaOSJS9NTjsdpnZ5mdhhKZy6LH61aPnG20ZvZxxG5+0lTiMV72debNlNDgx51AfbMCmiSDnk/cI1Nmr2lJ2xaZfQGhh83/tBtcrImqxFNl+GeEPHHIe+iN1E5zkglEIRgZalajMudogCA2YS5RrtFMl+GiDPwJdwBQnbyqkZz+Z9//DmaYQN0R0+ac9/9Hma5nIyEvzwtX3tQc2am7j+E4mX672M47IjEg79pwNgh7eTZy2RnHZSFu5g4UbZYK74dmtEie
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 15:41:56.8164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a78a4fb-9d29-4f28-cdf9-08debff45007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
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

  The kfd_parse_crat_table() function does not validate that CRAT
  subtype entries fit within the table boundaries before accessing
  them, allowing potential out-of-bounds reads of kernel memory.

  This check previously existed but was removed during code cleanup,
  reintroducing the vulnerability. Add back the validation to check
  that sub_type_hdr->length is non-zero and that the full subtype
  fits within the buffer before processing.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cf7b1b038d5f..3b39acb6baff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,11 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
 	while ((char *)sub_type_hdr + sizeof(struct crat_subtype_generic) <
 			((char *)crat_image) + image_len) {
+		if (sub_type_hdr->length == 0 ||
+		    (char *)sub_type_hdr + sub_type_hdr->length >
+		    (char *)crat_image + image_len)
+			break;
+
 		if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
 			ret = kfd_parse_subtype(sub_type_hdr, device_list);
 			if (ret)
-- 
2.34.1

