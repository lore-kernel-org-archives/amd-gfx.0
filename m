Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216D0C98317
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 13:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9733010F580;
	Thu, 24 Sep 2026 13:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hlcddSIq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8372F10F580
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 13:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GashrTdLY/soh6GhPCzs4lqFwWXIqaxslKURNhVVRhVnJvTOf/3DlOr2htTR8T4H5RAxIu9y0wFJrRRgwe4jhwhPKYLjJxMYKO7yIgvm+kGOjK5HnASUSVcaDuxqaNkzjtTPClrUlAEM8E0tJG6pgA+xkAz0X8EtaB7jG5w79tNBf8Qhy4q904IIu6xEiKK8QXfI3KBNiMPnRpCg3OWFSG/zbGgHIqb4JbktWuLb9UI2kPiyndGTJfOA5vxDdvpT9iACr1QbPCwKi9g1bj+gssf5l97rQU8aoMSN/KumrcmPw1+SNtHcSMF4g0CIoOli6QYpzOzsSeqkjF3iDiFMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjN2FWD6HJ2fskAEomnM8ukCCyqClgCPvtBcmkugVY8=;
 b=KyZyGsmKu95GmJc06GKK7I+SSJQHyk2G0UjoqZYRQXwSoRXonDdYT5vHJc0D78eCmaAxOklq2huaJJajBQAICHColoV5V810Ir6MQTzPR7HR20QQ7ky6FhVDYUUtwQbBDwEL3pImcZhazyZURfaYVvDN+PGcgf99UvlSvlCKyKJJj0xiTSwzza7IkidKAm5JJ9sQO1rTyIwFJlzjs59/MFzPtbQvShoZcYG6/3ZB47ST4BU6+9ERU/ZaHmXNflBnWCLQQIy0PpHKy+DrB19qBOMFEQPJ1uLWlK5pgvjZuF5p6+VZrk8MgkkdPhXVVbbffy+yX+rkz8PuoyQKgb1BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjN2FWD6HJ2fskAEomnM8ukCCyqClgCPvtBcmkugVY8=;
 b=hlcddSIq2t2nA8TNhVaYuG1yZhUqSM2fnCX7YxG76Gkh5Bxdx+8Ps8KNkmg0N5rEyVEV914/cEIFrsvP0H0fwoQqYpNIsciLlI49P5klnszo9m9casQH0cDXV8dj5pIFUEsdKlauIvziEsTsGjlSXvtLqkEAnf2vLmceJ2UPOCg=
Received: from BN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:e4::21)
 by PH8PR12MB999273.namprd12.prod.outlook.com (2603:10b6:510:425::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:37:10 +0000
Received: from BN3PEPF00022BCC.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::6) by BN0PR02CA0016.outlook.office365.com
 (2603:10b6:408:e4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 13:37:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCC.mail.protection.outlook.com (10.167.248.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 13:37:10 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 08:36:56 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, <Christian.Koenig@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCHv2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
Date: Thu, 24 Sep 2026 09:34:57 -0400
Message-ID: <20260924133644.1541887-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCC:EE_|PH8PR12MB999273:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbdb983-bf2d-49a7-a60e-08df1a40ef22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: C4IaEWXrYE/vQKLvKbXmcky2vlkm2YzrFLChIlMT987p9apleIxR/52e4WPDKNXI51fpVrjMs0O0TICdX6eSP5G7yGBRI2ZXLI+1ljPdlD+Q/2h8Cdu7OnPaDDMrV2Vi7KTXkSBrGR3suOkzw3/EJdRL0fXTcsKmoJjdlv5jm2ErUJYV56q/FI37VF9yOzewMi3lt5q9+2JMd7d97j0ozfazp78n5RahgXWe+6IiHNqfhYZUWKbxGtK8WDTeo7ZUqAsUr6EEGzypB921l1BlVKdrEuUpfe6cgml7t1JhbR0SL5HcopVJa/PgYQE7jIAuWb9ioUvfkcKWSyJKs14DbxFhUvTnaAQS2Yv1PI/OX/qKqIJvIZY1GYaqw5Qnq0llEHMGrx2Z07myE5a7RDH0IcgjUPYd+cte853BIPAkvGRG0jxvDiZyuvQiGx/ie5MjHJSMzsBo3P6ny+Uhasn3CuAhV9F3eL233bhyc6A1OuqywCJ4qDAQ5FBxPmBkogUMy7hsAy5keJoRWkkgf02GkXBlLabz1KVKLsaG+Z988j+GBgw971Rji7xE8OphbyUeJQ1OiUmeQmal7thAFGaIIDy18U6dF+WM8vJlePYOSBmAEmZqrzIZXGZwLfXqe7jK/zdMmUZkaJUWn4Cw70JpfRvCGg2PnInUa1TqAxkAhI5GBAs4vCgcZsmaoLpAmurqcXx5dMjvdemhE+6bH2Dg9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7j3AydBGsvdpkeWuiCu9MjnFnMgnJYPCpCFdYzDQzL0IBppvZbW65Ai3RBWJiAB/pRwTxu5g+5AokKGilPGj7zRo70/HGPtIN5kCLmYowLRkS5onWvlKASmyJXfPEkYmEAMSTxbIqsi5EZVkKkwcx5brMVVUKWaQ4Urb99jOrfPitFjrKc3SU6bufDm+U/GGW85bZpO5wvoVt/AefIsYw17lr614IV1xq3rsknmvLEAmIcjM0K6cxKs4Wtst3zHlWoghsSBldssNVzBgM8KbKxAItrCusOZr68JeTsCTVYmvDMPPhyXG7V2cVU6qqotf7BhyBlKE6xHncZk3mOpenyiXB/YYRZ2TAhG42Z00TDOY048Jn1Yorx3kLwZq5T28wCI+GiKnjIkNJNozo186QLs7u/xV5DnYQkwCBe1+RmrrF1E08LQQmD1pSghRxVx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:37:10.1709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbdb983-bf2d-49a7-a60e-08df1a40ef22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999273
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

An imported dma-buf BO backed by a VRAM-capable exporter holds no host
pages of its own, yet when validated into TTM_PL_TT it is charged against
the GTT page budget; importing many such buffers can exhaust that budget
and fail with -ENOMEM even though no host memory is used. Set
AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
domain instead, which is GTT-like and still bound (keeping the exporter
resident) but carries no host-page limit.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
v1->v2:
- Check if p2p access is allowed. If not, clear the PREEMPT flag since
  the BO will be put in GTT domain.
- v1 reviewed by Felix.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 4031ebe075d8..bbe518757907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 					 AMDGPU_GEM_CREATE_COHERENT |
 					 AMDGPU_GEM_CREATE_EXT_COHERENT |
 					 AMDGPU_GEM_CREATE_UNCACHED);
+
+		/*
+		 * A VRAM-capable import is backed by the exporter's device
+		 * memory, not host pages of its own. Place it in the PREEMPT
+		 * domain (GTT-like, but with no host-page budget) so many such
+		 * imports cannot exhaust the GTT limit.
+		 */
+		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
+			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
 	}
 
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
@@ -618,6 +627,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 		return ERR_CAST(attach);
 	}
 
+	/*
+	 * The PREEMPT domain is only correct when the attachment actually
+	 * resolves to P2P access, in which case the import lives in the
+	 * exporter's VRAM and consumes no host GTT pages.  Without P2P the
+	 * import is staged in system memory and must count against the GTT
+	 * budget normally, so drop AMDGPU_GEM_CREATE_PREEMPTIBLE again.  The
+	 * BO is not published yet, so clearing the flag here is race-free.
+	 */
+	if (!attach->peer2peer)
+		gem_to_amdgpu_bo(obj)->flags &= ~AMDGPU_GEM_CREATE_PREEMPTIBLE;
+
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;
-- 
2.55.0

