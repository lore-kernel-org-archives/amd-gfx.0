Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E008CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B2510EF9F;
	Mon, 12 Oct 2026 09:48:08 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E93210E41B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIQUcbk5Q6UD6pAQsLXqI/zIUsVjAn3Lv9/Fdh3HGwIzhdiKG8byJIka9LZiZ+Eiy2JUSeaxB39t6drkMvjuSX2AwJvGjz6/eCoaIDNstQasmzT/KXBgUb8X2XLhvHG1KfkzXcPDgxfxHl9H3J3ZThVmhDv1jUOsEvbVV+PKiG486dLSfgUIIi+hCvNK4mVbg8h+eewlfaBdH3vZogXtgHB4fSygWWjQR9BKSPkKZZCi/GvA5wSS78/GVxLn5lboOm7cVPdvjuNsi3c87HQuj1KAivGpBvN8rEHfTvDnvBFdV0lTMCC6EqQDgLoxn1cWOLV9R/pHo5hRx9QE8TW/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfKbofOWMNzE914tR6YwgjCyyZpAPf7IhOLyJYJyFHc=;
 b=FKsyk5t57SqECxUs+Ki8Y4Gbo4tRsn9jKeuQzS7yDqL7nfChDXMrVD2Ya/Ug6MlZgWjKUpIWX/xpk3LJjDUGfF0cGyfBX3K8wle8fWSJm1m+t4y4g3DTHz9IQ2sXh5ZrgXvNlY/3AMacVMoxkS94ovkjE727Kx4QT2od8VJSqru7QdR0QNa21RekPfMVUB9/jU1BiUXGEO+ui2e6YZLneVXvFk03tDDrJEDq3kRl6cHfK7eystCgJ3UZprIAbI2IxqVQFC6aiXTS+XsWmKV2FhmYClCIetXZ+vITnvqskAhSH2fBIdEjbkF0uHupLGbl0Y/NJ8AKTOiIwregcfMl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfKbofOWMNzE914tR6YwgjCyyZpAPf7IhOLyJYJyFHc=;
 b=3SMUzJXiKYkcdHPoIx49vJ6XW5UX31OUM9NzJG5xu7gFAJODd8txKha1EERxzULJbMJQwBEkjjoLeBZWUq4hKC3QcCW62dfcaE+yS9WGeeNmXV3ayM6Bs9Q/hquSffp3r5nWQgoB4rxnVB/hVizuS3RFyQSgry4sfeA1KZf4S6g=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:47:59 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::91) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 09:47:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 09:47:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 04:47:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 04:47:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 04:47:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: report the BO alignment in bytes in
 GEM_LIST_HANDLES
Date: Mon, 12 Oct 2026 17:47:20 +0800
Message-ID: <20261012094754.1685828-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
References: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d05a09-aedb-4a14-543c-08df2845e64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ShoLa4Xz0Niupf/4Wa3Dcs1FuQ2rcY2Yrhf8gxlpHj/UKWEQD7eemUrMVOmGXqBbNele/XloelsruJn7ySSBMUMwS0wFp2Sgf0xA9H+gqhOXqLXv9ZXlsJyXRlr/SuPmY2OXthBLRfN1wYM7WbVHxfY1B1/SB9qmb720FoL8pNGtZZbtQBb+uees91YTPL7C1hliG+ul9YiU6+kDRmlXpW7E6ZibAov9BOfXQjosWVvjNlh1WTxnVPQI5nKZ8i2mYZAlUfsBU6DscxMLnFyhiOT/k1YKBgI75HFzLmp/h2+Bns5bFxncxFoKQhZ+jARS4zQXSdU+3hOGc9Gryt0RyWSyB8DpVIH6StOFmkPxWBzaQ5c7qNaU0QlnndYrBecTSzleM+ersTVJUUhl536s1KhGANXfWRzDVsIsxA0DKlxRPo82DS0bJHHGjoWVeYVTZDA+Z7V9vVEviiwpZoAn+KqPzi5twK5o2SGXr+25hwDcY+d8EmIUdTw8hhS9d5/arAwFzBOEnih+dIOl66QpnzSQoIyLJUKh+So3cnMHT8dDfeyL791Xe/imztUCaYI2kHF7DzrX7RNCpNInD+1ukGHUekH3o4CHs4DT4cUyMUY7G0a1v5krcus6t4oMsT1GJ9qRcwyMLOxOxqNOeB1cGy+j3GK8J5GttqMfNMFHZ4Rr1bKjuAOxiwXFu5vLyzTJ+dLYCUKGdcJBD9+PC2z2Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J7HeHQxx1grmeyY93zlJapCgaP6DhhaDmV3NS2sT/H/wlQXxzm5ST3j3MuJPwWpKfbz53O1JdVdITjTSfiDCXVKScU/OvlA0VloV6fiUTtenOI9gq4ikzcKIVk4eTS4/qZ12k/jY5YPgzQ6BWDBGdgFroWVU2LZapAeHD7wAu+7USQt/So92PYq5iMw4qTKc9hpFLgN9upUuBPimaQ28o7WfLB0vA1rP6siuCsIWlQdqKIj7QnGv3cn5SwK7NuPlUDYGCFWib8mzW0pBsJPIQp2Ggm4vAE5AyeJ/fOajGzWCPleDj/ixfklJXp2mZcE4jQ38vISkxKZnYw2BYPmN8xtN++pP4QV0VLXndOwyk2F8x/nXUR01N5lOTQUG4bicao9s7xE0hIkdpKV4G27t01UrJmDrhgr4kq4b4ykz1Av/tO6KATMdBd7LeuyNK3kc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:47:59.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d05a09-aedb-4a14-543c-08df2845e64b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

The uapi documents drm_amdgpu_gem_list_handles_entry.alignment as
"physical start_addr alignment in bytes", and GEM_OP
GET_GEM_CREATE_INFO returns the same value in bytes, but
GEM_LIST_HANDLES returns tbo.page_alignment, which is in pages. For a BO
created with a 64 KiB alignment on navi31:

  GET_GEM_CREATE_INFO: alignment=65536
  GEM_LIST_HANDLES:    alignment=16

so a user such as CRIU that recreates BOs from this list uses the wrong
alignment. Convert it to bytes.

Fixes: f9db1fc52ceb ("drm/amdgpu: Add ioctl to get all gem handles for a process")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e791d066fd47..8dbd7bb77305 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1281,7 +1281,7 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
 		bo_entry->preferred_domains = bo->preferred_domains;
 		bo_entry->gem_handle = id;
-		bo_entry->alignment = bo->tbo.page_alignment;
+		bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
 
 		if (bo->tbo.base.import_attach)
 			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
-- 
2.50.1

