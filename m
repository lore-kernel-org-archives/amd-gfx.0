Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0169DCA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9773E10F5C2;
	Wed,  7 Oct 2026 13:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LH/b0OR+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1B110F5C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqTqRn1iqK+nE+FZ10ZvAuOEnEv5//OSd/yqHRASZFOemuAW38CTPMb3jaiLThnICs7g5QXHhA6FekaCkacvMJ4xEV7GO0edrFHX8YxSi4WY2ZTwG8drMHAol+ldxxh9eiCmtukrO7wz0ImHozKcpvblmJ5KhfK9LCUSICMTTwM/ZNa07gW5hrUNa1HMP3dc8EJBv8dXcHdZXu/SNfwXi+LzbXRCEEqnxiHNR5MVv9QH4kPdZyg2Ckk5R7umP5OB8MyA1H2vQm7fZDXb0ImJcnypflXOVpgvVmjMgci7zat5tOagictVxSLZ8TD092sqRjhFW5bnCc3PRxIF3d6K2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHUTRXGRdNbzNTel5EqtM+p2wj6o+wauZqGAo5PlfDY=;
 b=QD7MMMyNwjK1ZEa0xemCbX1kwD8bW7d2DYABMqbN921zZAADehhAQ1q93fVaeUuPrTa+LByR/wxAEluUFT47qdwpvILy4OxtQ1PheTbwlKeUFyUN/d3ie+bdV8P4BOUBhsldXRjlDahMkaQTwV5qMouQ4agB/1jXGFpNWJO9Oh4KA+vGoGRI6v4nR6VIW80YIBTUojzqZL6pw8gHb1ZtpgO+x/h9LncqNT2Qr7BQHljiqramG+kbP+QC4AmHFn9uYxkxMwQDIKzT11IfKU6/y+mycXus9lQGbdkcI/pmvbs+tX3Ou15MsprmmSb+ZcMO0uapYo38UawEWFSCFRm1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHUTRXGRdNbzNTel5EqtM+p2wj6o+wauZqGAo5PlfDY=;
 b=LH/b0OR+Yv65bKakGWo8iDjP2fmV8uldsUeezrWVyhA+RsvbjSCaRHng5ZPXJXulLteVi5HZz6so5GUwvxzIEd+cgfrJnnMq18LZAVFMqD/W7lCnuf7QQH4NWxmUY+mwq1DnGHnsNey18sPbjNidSsOFiHJFAwSXRL31wXDgG5c=
Received: from DS7PR07CA0008.namprd07.prod.outlook.com (2603:10b6:5:3af::21)
 by DS4PR12MB106381.namprd12.prod.outlook.com (2603:10b6:8:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:31:43 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::63) by DS7PR07CA0008.outlook.office365.com
 (2603:10b6:5:3af::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:31:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:31:42 +0000
Received: from MKMWIAITKEN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:31:41 -0500
From: <will.aitken@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Will Aitken <will.aitken@amd.com>
Subject: [PATCH] drm/amdgpu: Check fb-sharing for xgmi accessiblity
Date: Wed, 7 Oct 2026 09:31:27 -0400
Message-ID: <20261007133128.666-1-will.aitken@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS4PR12MB106381:EE_
X-MS-Office365-Filtering-Correlation-Id: 9121187a-3702-4b74-c830-08df24775351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: mlkn0YjHhOFjqZMb35PSIX8sbpJdk70TaUbMhmoLXXxa6Fx8bi6AiLezO3d3zXA1dkA3oEiAI/doWRSspf42tWRZQTrM60iq/n20TxdiqUOanZp5hNTiYklvhcjrvU006X5khgysIgOQ4eWGkUgiJnPaRwyihj5Y171OSyDCs5KPlrKAbybG2lojSnsad6jLCxGYzVRwupTvj5W6C+JPSdMpKRI3RZA6c3Mqf8H62FlIhPk68nmFoGxE2aM/A1bZ/GPCLEugHiNlIlaQCSiLakTkvnKVL0iJlxevziyWyon01BRG9KrefLNMtHm8KpZ5vUgFrCMdOJOcii8gKOXn2lTYSG+OLP8TTXlEl9BH8ZEOTMAp8f3R9O4htQTdOaSpNQXxmpYoENn9zCXhp2RWTvKGhLc0N52WYPY4gtBkowYPbXQ8jsKnqZz7N5/no64HHpchsz3TunbXI2ZDZMmunmp2IHMzv7fqFzEIb+v9CicFRUIfQJEyjirJRNFpRpXuqxYYR2DMmr78mh/atywtFpthaDXc3m73ZG9cphbFmY4QVrrHbc26O66MdB4lCNwWey03wzmRaS/vgo6e+D9MDejdrh0dldLxQ6azTj2qWWjjvY6key6yq5m3AdGD4SPGln2yjQ/VHWeOHa0sgTl8QJMQEAvATtybF6J+rc3k6LNhRwOQbsK+p0pA37DjGjEqFLcXNhSQuQVrQI2WPTQ/qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sYejQZBSX9z1w0VqQJBnd/2vLwT9scCGqbQGY1lpH3gQZeSZb1m2c1s0RBkbSVgiKQeSeJ9T3uGSZ1sDnhLmoiyMqnRugeuoRgyRXnpAbnSmZCFpLz5+juMp/y1GGwqMaUNia/tOyJmrs7tlAJ+a1bpy9/AirqhsGDdX+hkb0CXtYn0aDzWVzAy123HS5T9tEHQgc/XGqaFRjSTVbHJS8lBVRrrK+1wy0lui4MIdmtLDuIp/XsITkHIY7KEutnUXFskyJDzcexLdVCVEJldE3NZ9Cwt9zf93gfielJrC+ZCwcaIQujJL5NrxWLAik996juQCV9FgjvJfkzM5OKCEJT81KQ+Q4hPH31LJbMu8qY4OEoTGP6pAP5ZmWBHn7KA95qp1GFv25QDrNGr/AZRyQpMPfTEKGGCFfPCLfXZIrF4xPQljdJZi0+ILgVOZwuAN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:31:42.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9121187a-3702-4b74-c830-08df24775351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB106381
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

From: Will Aitken <will.aitken@amd.com>

In sriov, sometimes fb-sharing will be disabled. In those scenarios xgmi
links should no longer be used. Adding check for sharing-enabled to
determine if there is xgmi accessibility between devices

Signed-off-by: Will Aitken <will.aitken@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b4fbd8a407f1..d7845de4a789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -612,6 +612,7 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 	}
 
 	if (amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo->tbo.bdev)) &&
+			(amdgpu_xgmi_get_is_sharing_enabled(adev, amdgpu_ttm_adev(bo->tbo.bdev)) &&
 			(bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM))
 		return true;
 
-- 
2.43.0

