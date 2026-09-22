Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB3C982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DFE10E708;
	Tue, 22 Sep 2026 14:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKxt8fQ5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD3010E6FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wziFHEknm2znRivjj0bPmgXqx6N0vtBSjCS32pnq2UrNIzbOAkY+GkwStYMDbk54dGIARgNaOneEQVUh8bhnrfH/3qNcove2+eHQYH9bP3jX98SRylTOQQUrXsgWMFLIdNZOexu2tvWYQ0KmioTrPgfvEWTUaDl5V6FkOxLHFB+AWOE+mLM2xzAwV2whVMcYVeqOt1E/+glnwQ6vHiwOzzV/+La+OPRjESjVoP7iVEpLD9I3ni+E9lLThDJzrzkFUSp6L0go9CKvaiEZdpcQz2ZAyDACA00o5657Y9wnx/0ORU1V+RWLG4mckDQg0hlSrWT9GeUMLjo6xku/1dPFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ptb4EJk1G15/ufEmnCP1I0BVGw7QjLecB/9GaR/jXE=;
 b=vDDTrTOHg2gqjsHcskZwfNcY0j4bTfoz/5U4KxfM6o8SRkkDRSo4J6Zwdz56Vti36kgkaQhK6Gp8F70kK3OuiXVmc5IIyDkGSVHSpfW2Dwoyxmmrc39eQfjxPeruVAkzQR8eGmaejmgHdF5vdck2RL7v2pXljCr5mdW9vtvLDpdy4k3gZmjfZayYjfDC/pe+v5KKDmNqWoHS9Tl2cOUzuexUb+/QKENk8FuQNrqbECIr1z8AaSbyXoUs6cHhHcb12nw44IcxgrIx61bQa/YanBJKu02ZaSHK9eg2uK2TkD+IB8fL0EAra1bhotEIKqt/fIAZNu/jss2TWqZ9MlUB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ptb4EJk1G15/ufEmnCP1I0BVGw7QjLecB/9GaR/jXE=;
 b=GKxt8fQ5CNMuoQ3NDZpj1rTnBO4zHL8N1refwE194ykyWFkvDEWXhJ0gVLhOIX7xoJ1PptxQa73YbUDGT9V0QPfu9kKWXwr3CFZKfGzZ0LSNDjXPfYxLQRigFd0SravD9v3oGEJYx8NydYeIliyJSuPSnzLY5IPMzD6NW8FcqTM=
Received: from CY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:930:1e::19)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:57:07 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::42) by CY5PR04CA0010.outlook.office365.com
 (2603:10b6:930:1e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 14:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 14:57:06 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 09:57:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>
Subject: [PATCH 2/3] drm/amdgpu: Fix BO reference leak in UALink export error
 path
Date: Tue, 22 Sep 2026 10:56:52 -0400
Message-ID: <20260922145653.1207241-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922145653.1207241-1-mukul.joshi@amd.com>
References: <20260922145653.1207241-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 214bb7d7-b467-4bc0-87c9-08df18b9c572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: C+2KmkN12HeEgq53QJ9hQ5+pjmiwXj1zAOMJIEzFqzMQrYXRroOhWsoANyI/KiWQopSdK5HLuhdcSplE8/No/y7VrqEfhwkHoV/R1Eb/Pk2ehSXaj/kMY+aw7q5DVwCCslTEc5lmmaJBBHom9nVPMo1arM0lOWswHtojgo3oblGEmAryp0W3flToqWpjg/KrfcCY+jAwHuiMvH+LQYNzc0Nsw+4zBurHJCsWFjunJQvUm7gfJkOIyk1RMCyax/eumMPGOn3JPvjQMozAsIgOX2H22BFyZuAfridFWhYGB+SXDB9Z30skoJlD2juwGWkzruSL2KbEs1gn96x13fs19VYqmviJBAatzUYuUGOTtbC62XbyXaBd9eMnqElTsWqhuvCgGh4ZDiKFyd/y/0P/6eCvG9QRjZHrBQf4oMUh/YWNo4Z92KAARdShXENtYJTOEhhbr+wy+thUAICy2XuCuMoOYidoq/Atgp6tdU5VSoe4hMp0l13ecwEjQC3nyoUt+xcMpjQchD9FhJZ2i+RYmMREgKr+oPQRxZlWhR5JIX+MOJ0LTsRoQtg8wNzc/z6+zx0XjIkA9XJ9981ieCqav0+4txSuPHNJvgVNMr9I35hvobeMh77BCay47SbCAvDYfmwwpPgN7BP+6AGcyj+qAw9daSzwTkumAQ/xr2oybdjxbPqRu+gDFP0mQ2ccS8jK4iD7Uoz1DDL0bkpPchCOuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fh7VczlXqpO9EHE/lD87M9sPbMpcQPb90SP3EoZlfmY9s0qFPwC+Mqx8sGU1mLwyDbKLhaGt4oXTfEAH8v4h19xOjdNsu0BCUoI7vq8tzO8U9Y6Ry41ytTp06i3pe9MzG1KqiGHT9v86FtlpEuGRUmt4dlbbCj//k7nDhqNyav3dyCSqBxiYWRYuKALNjuXhmANkN1rhNDicQK4Lz98eAK2U2JytKL9t8w94HB0cDTnj9XzR9gaKtj6+mWQ4Opo4h2SJA5jVcZWcklH/XVOMr0dQsOuw1/8O/msmQ0XFDoD4jizk8Je5XMicdPlX43Pt61fG+7oCy0XnkQJEXlE5NmfUxvsVIYBfDq8Iy+4BNIsdCVzdhkr1/esX9XmHSUtCsBgnmEkKvJwQS1MWrpmDsam603X7VHAWHIfAPXKE7ETFelnq0jAs9AxV9+3Vxg66
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:57:06.9243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214bb7d7-b467-4bc0-87c9-08df18b9c572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

amdgpu_ualink_export_handle() takes an explicit amdgpu_bo_ref() before
building the exporter node, and the out: label only drops the reference
from drm_gem_object_lookup(). The xarray insert failure path unrefs the
BO, but the drm_gem_prime_handle_to_dmabuf() failure path does not.

Userspace can hit that path at will, for example by exhausting its file
descriptor table so the dmabuf export returns -EMFILE, leaking a BO
reference and its pinned VRAM on every attempt.

Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3d84f5a7a34d..a7ae9ffde1b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4023,6 +4023,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (IS_ERR(exp_xa_node->dmabuf)) {
 			r = PTR_ERR(exp_xa_node->dmabuf);
 			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
+			amdgpu_bo_unref(&robj);
 			kfree(exp_xa_node);
 			goto out;
 		}
-- 
2.55.0

