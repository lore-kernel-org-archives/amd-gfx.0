Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3353C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 14:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D3D10F61B;
	Fri, 26 Jun 2026 14:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYovICW8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC24910F61B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 14:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmA26o9LecM4BdLlqNdqmOVkYOUTrzJP1T83cH0jVZ4yhx79E2NE5EzGTwRjY9NtUeg0W2rqCPJHb9tdm5SPQjLSVUf+3798Nqwh2IupUmYpfkzSl15tJyk1ZbCmmzuDV08sszzGG8sCR2ExwSsX74Pel9Nmb8YDu+ZcJN2zjmMX/D1sL5INCo9S1eCZHSN1Q+nS7BYxbq04rSR/UxLMfEZWNwMKPqE+icAYTfFYGdWzLkxOXZ3BeFfEaFrcqnnYgSdc0/A04okVoEP6GRObeyiB5ZSFpaTvWcuEeqnh7fOHxuR5ssMMZbsalHuBp252nZTZVUC7B0QxhOS0NTaAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eo8A/ySVo/4+V6ZfTs1CDMoevbMdzbPnyLUQPcwNkY=;
 b=gT/DBjDeKZkx8c5ybxqVIQXsrJ66U5drfkVDFoVGFjtaBh57zqYwC3Ym10PmrqH2i490wBKJkpTr5iOX0toFascMiyjtVJyv1TZzkPPDfVgoxYSN+HEzKdVkYlnzRAU5KAe7LuhuCLzd3+SeY9Cw0lU9AWCTQDAbIrJHVx+6Bc6VfECim9kbh2VbH+Ra8Ct9JZTxb2BY0ibEMO+tNmop5TgQPtLomC71GwKbpWd98R40ATfXuO+JDTs9fZKE6T2NwkgeontBHWPO2phVD19GTuJiBVfVaFfQaHp49VzqzBWLipl1Wy6U71Ype/Y+5rslaIBMpK0gARet7oPMCXOGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eo8A/ySVo/4+V6ZfTs1CDMoevbMdzbPnyLUQPcwNkY=;
 b=gYovICW83AM/y9NEDsYOJ5ZAfN+ZzCarcM3RsET3Ib7SjPL6elwUbW9LjkSgmmVdZaQAeWlqpSlE397fowJypTXix/x6sHPo6z/+7AxdqQvWj4PKkrbX5EsI8biI34MH27Nkr7zFA5KtW4ME76wBVBhTaJoY0YEhY7CahLcChOc=
Received: from SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26)
 by EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 26 Jun
 2026 14:43:56 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::3f) by SJ0PR03CA0171.outlook.office365.com
 (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 14:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 14:43:56 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 26 Jun 2026 09:43:54 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>, <david.wu3@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection
Date: Fri, 26 Jun 2026 10:43:19 -0400
Message-ID: <20260626144319.313979-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626144319.313979-1-boyuan.zhang@amd.com>
References: <20260626144319.313979-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: dad87a92-861e-4761-32a9-08ded39159ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: G8JFkyhv/K6jNP1TTl0AF0+47P0G/fI/fXOA0yqe8z2ceqlKx9XF4k0z4YBU29GFK/ZbjYIDm4HtwWkXx2XqcjOkJCiZrDbDj1E251YPgoDCIKh897HJ5erP1anV/+U1XAaUobMlDajz6ZzMMvNARKQb7mNgWp9S5oYJCFQP51nk0MiZsQvJFhAaq9ZGmKKCYQRy4bOtnJhosZrGDy6KEXT1jnqGFaXhkhN5agyhp2Q6uCnbKbNG5M612Zom3qZTgNFSnYMKwcuwJn0tW35v7qN/96NwJXnnqZKC+kr4EG+MbIbDuQIix0KDG/tZMKMAYBsUm2DCHXg4kYYGC2RMi8m2iu++wwXwoqSnpYN8zcmyeOijdQ9wTqN9Ojxpxt+8kwdilYhEJmWTtTqzOML50u7haKX4OjTqpGMJlPD4k/4m2sGuzg22ipQg4F/2ywIx5pqiDxG12hbAoD0NW8s22lv2cGVqZ5znAVunxHmtFhrjw8uzecDaR+e283WIWsmAaOZRA8MMa1Y0E7r9pmT1xypA6rWI+sfcg7IwCYDulGIiEYC1wcM/8msIc9AZG74Skp6cJAYbuawjaI5JzRRmnOB4hZ2RWXvPS0ybuQoTBw7SGni4bz0H9AO4OBBpSYXqKOAnbJ7h7FbfUoLY7aokQoRWwC5vkZGDWJuBmHInrNMs+8VcNBMhhR+f9Rx2PxPTL14AtZz5qoKbbyh9MEE+7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CFtBjq0yQKUTvdHVtpJWXz2TG8lI+rwyuICLcnQmDajwx4oGdloNNd0lKvXactl2oeZXWYFl2mezohNMgCR807XXqD3bCsjkPIZtdc1x5LC4Ncr/PPr3aSR4JCOgzlWhx025ezSzdUUpJz8jdZ7PBKVdJasIP0znxzMw9jZmYXt0dyr3aEC+UZLE6o9ENh6bLYYZfO7nXBZnIMJqwg9GcjtI6z/bu4iAzVp4U/LSc18NJIaI3RQFceAk9qIZuapQsNjLPE+u5qGBspT3B6OTMXrTmCifYmahohPifxxOotkJsW8HBNHj6mLXmoEeVY8srrvLhl2fN5GJZw8iqppqmTSQjlJTdrPfWcD7NlAQD8jFZJsM/cj7QjmGu1qlI+L85pUmDw6XRUr26g9aOwzy5ZJkDVCj6LtXX4srJZK2i9G3Gr7i0hzfMyA8xCJZW57K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:43:56.4348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad87a92-861e-4761-32a9-08ded39159ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

jpeg_v4_0_3_is_idle() initializes ret to false and then accumulates ring
idle status using &=. Since false & condition always remains false, the
function can never report the JPEG block as idle.

Initialize ret to true so the function returns true only when all JPEG
rings report RB_JOB_DONE.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b0bdb449538e..c7d40dfcb751 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1027,7 +1027,7 @@ void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 static bool jpeg_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	bool ret = false;
+	bool ret = true;
 	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-- 
2.43.0

