Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35162C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 09:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FA510E15F;
	Fri, 10 Jul 2026 09:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BT3EJKZg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CEA10E15F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 09:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWopGoWwu4E1ss6iQxh6Jn1TQgGCT3k61UsmOn4UZ5xxpIISNOdM0SDX6F5fih44lRrtxCZY9cZL47erQCZFHlcimxOCsrQ9UgnVDIBYN2Oaq7aRaVd03ngwDc8XJ64VTro6Bj5JZ5DxhoTG81tflZxaWtQSgdexXGS1mtCdm6rz42IJDCgZdbX7m6Iwn6ZwNCt/aZvvc6TgE7XCNXJ/AQBmhNHYS0JK/HablcMWXU9VzDhOQkI5lbgpKma4IOCh6mZYUqtunI3xkqJMADsIJoLmYL4CVCMzgYIe+FtF2MJqmjtUtsTQtQ8Vgu14sGdLk7nTT3HZG/uPFnvVOQIJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C+7MURGSEfcdlPvGH32itgYMx5slb3FNhodFoP1THs=;
 b=g1mcNTtQycWYdlPy1iLJ6JUof0IDVfBHO2YMciipFyxnFOlJnAKpHibMXmksO+Q8nFbicNEYJP+Fl2VpJi6kOmNGpnsOWg/qT2QsTOzxz6hjO0kZyIbqAw+Ue66jXig6gPhpjSS/cyHyNCs/eQl70ZBEShcdyJ8TW1RCS88aTaJIHljh4AlpMsQVmWm92RT92CyGK7H9l9AxgMWtBoHAb8df2ECIqTEoDHzD2QnEnbUKHGpsOMH8Ld5m2YPABZQtt/7OSVHJu5UOD/DLR9fprv4ur0+g5gyqd0+OjVvXkm26LQSZ+CSm80OXcc/ltO6QV/LQpnPiT7s+9ntcM33Dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C+7MURGSEfcdlPvGH32itgYMx5slb3FNhodFoP1THs=;
 b=BT3EJKZgCjfzAWs1jvuGQNop9HVnhw5Z4XA5WxO3p/ArgSuoeVjyQikCfYi07aRRoKtekmnVxQ3OCGxBqqz36bTF6tyVus9vacqjsXx0xOR0y3a1jvRrXSuZzs7ztTNlcGEjL3eslAzvvF/FeTSPZ45JCLhr455u7AKue5jVglo=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 09:16:35 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::63) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 09:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 09:16:34 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 04:16:32 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Ray.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved
Date: Fri, 10 Jul 2026 17:16:17 +0800
Message-ID: <20260710091617.156343-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6467af-5ce5-4c94-aa47-08dede63f065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wNgAA2W8NXsUSYl/OF9v6/6bksExM8mD8TXPiz1Oumtt814MddFYAd3jY3MPRHz8A5FAqRTKu1PRp7TfXFNAe5eMKupInA4+wYnJRpfU9RfQIL0A076nu9fRRpVL3LCNJUoGOoTTOfyWUlhDCPqKKnTDXso0dM5Y6XrN46oBS5tg2YkH25hLpp4NYS6qeRL96Z7w2fZYQWv8DB9dvLpnS3OzJ/tPxMSaJk8PaEr1k+r0Scnzkc5fr/qXaZvjLCmcfUUl2mpb6ml3CYKSQVU7uOCANmmWVHclPe9Eexfg+9nnOpiF7pJVT27gCpru9PF/BZNCYe0WGKKhHXWWFuFVmNGkrU2EYzeTbbzhwjMxbiGnpRWzBu9ukwc70MnpaiVvv2K5xy5PDv+wYLpk1g2DjiZts6aaR8YybpAx5fGnXZu5bH/9n4D+Q69uWt8ECEMgybD75t5l2SAU+m51fLXdhDsWjSQEMiuZmpQRqzYDdTdn0Q7Wj3OUiDPYO6CEPBGeJ7xEIBzM20TUc+DUl5t7oc66VIUK/pZuLjTS2+dWqa2bnroqRGe7ZmxKkcogPrWuAC9q/vrSGlYDf3uxrhAvkva9gp8beFSvwDqP8NBWBYTZ8tqBPr4/PKS9Ur1hxRRev9wU3qfCG099BwUs4BrI0sGS3zf0nBIan8q5u1oR/EMLsrTwlAuWAfHzsapIV9mNxs+1kwfAse10/X6EQzYTDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n07RH99dO7WBjwo8/URoMib6cytoXGuEz2oIuvIA5pH/jFuDDzkK6ncEjBeiJGruEiUEOXDe5nNUM2+3RrF7pAE364pd8mUlX+w8VOE8T5AWaANXqxVJ0az90drnfnkMLKxvb9hxB7CZRTP7PxkE8pqNMYr2p/vxW9847BX8Ak1tHIQ+4IYwHd8155ltcXUJfp2uqlE7+fY4lLAmzDodPXauUOnbcf4dRsQe37O/34AT+ORGLBwwiceo2hcX4NHmFC7QLZh+qvbjploeAcJXoDMvlyXLSkhiJdh17QPNjbjc8HeicnNoVqbOxgvX6OJHY1usi3FGn863X+0rrJbWSYz7B+o9bDfeHWL84Et94ZPny8Ha942NIbnGQxZtbNAgMVHkNMV4ubAx5NLHPGkBcdwxd3X6+2UBR6mxnm7Po9/7cMNf0fTCM8IcX9sNDRFf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:16:34.9149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6467af-5ce5-4c94-aa47-08dede63f065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

amdgpu_bo_create_reserved() only allocates a new BO when
*bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
NULL, it simply skips creation when *bo_ptr is non-NULL.
But it unconditionally reserves, pins, gart allocates
and maps the BO afterwards.

When the same non-NULL BO pointer is passed in again,
for example firmware buffers that live in adev and are
re-loaded on every resume / cp_resume / start
under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
pin_count unconditionally, however the matching teardown only unpins
once, so pin_count never drops to zero, so TTM is not able
to move, swap or evict a BO, causing BO leaks.

This commit fixes this issue by only pinning the bo
once at creation, and repeated calls no longer
take additional pin references.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..7ac3b8fd963a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -276,10 +276,12 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 		goto error_free;
 	}
 
-	r = amdgpu_bo_pin(*bo_ptr, domain);
-	if (r) {
-		dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
-		goto error_unreserve;
+	if (free) {
+		r = amdgpu_bo_pin(*bo_ptr, domain);
+		if (r) {
+			dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
+			goto error_unreserve;
+		}
 	}
 
 	r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
@@ -302,7 +304,8 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 	return 0;
 
 error_unpin:
-	amdgpu_bo_unpin(*bo_ptr);
+	if (free)
+		amdgpu_bo_unpin(*bo_ptr);
 error_unreserve:
 	amdgpu_bo_unreserve(*bo_ptr);
 
-- 
2.55.0

