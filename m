Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033D3C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7EA10E211;
	Fri, 28 Jul 2023 16:41:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B9B10E1A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5P1pLL4tCngvCY0mM2C6awZxy48mCTIGmZTULCiSDImYqk1fgaKHWMhm3sCVSL6SLiPnOrJSOcfzmgsxCh3DG3N3TDSHrFKemADxIXQjBe44XIMs4EVWVlK7lL/0vGXygmJy1TTrrmwZw4mOieNT2PbQhQJtrmdt43ILwWEc+r8w5ViCTPz2zMMf3NiwfBK6BIOlXUQriPx8LH6HqLT9zs7MGiUgRIenjZMg1SruDaLnhO8yy1eXeucN9CZJ306LDD5Z34QSsgaPiKoqoJQ2cnX7QEIzag7mUM49VvkUh7jehIocMMLEm5MddtICepVw53rG+xayX6WZjaqNIzVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AqVagB2Z8MOrSBYW8emRHmoYS9QGLEOoUYddBUYtzQ=;
 b=eX8JcGzZfDmPppjApRa3Pk9jhO6YvyTKo5Hpnf2wu0Pbbe10YaAl1PcxbRcj0LGtrcTau850a5VLB83bYNgH+ySe6FNuF8Ds5dhofk6RMUlnXa6MJ38z68Uw8ztQpwLBfR+0hF8dqwsf3ORETV5uuWKKjU0YEmcB86mtC6yn3cc2t2HTFnT8rMgvfj5CZ2d26uST6knTLbLHRdKFLIrEghUqQQQvzJCfrMZ4flYRY57RdiKKzVxq1s9MKU57qCv3bCr3jqt9DHDGgYYfgQd8HfRlAmz+D7XVDqpBn7fzf0QVk7A7dN/QQGadeoUgESNPJ9UUNd6UUQx3j8WM/wBjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AqVagB2Z8MOrSBYW8emRHmoYS9QGLEOoUYddBUYtzQ=;
 b=XVLF1GsQuOCntPZhlYVekZRFmQjYM6TQUZ04jFgCGKgwWM8eLwiGuGmPOr7jZCqixs/INsHnL78axibP0RGs7/jSR7NOTGwb6F3q4mKyVys9V3gfbVrLjk9b6Pysvg2siK/dqdP4ummZJxJHdET+bLxDEuL7f4H+ZvQEYJoj0zA=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:41:18 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::88) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:41:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:41:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: disable IOMMUv2 support for Raven
Date: Fri, 28 Jul 2023 12:41:01 -0400
Message-ID: <20230728164102.3327956-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728164102.3327956-1-alexander.deucher@amd.com>
References: <20230728164102.3327956-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 264ea9c4-d3f7-44fa-f214-08db8f8977ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Cx31a8ugTUw/RyPSKuOlGlUIAN91kmYdETg9QrWe97u33gl0LOTPB82daxKXAL4ml5+ul2IHc+lMuHZQVFlZRLghOmaEw6eLKS1SPB18PgQSL6jJ87CeWFkLMqI6YH88lA3Y3a8Fi/raCGm8Aw5pW57obp32eMBYfLb7KN09dOZ/uQFnyoEC4OrzSrP21xa9yT+dWlXC1IjOR0o4coubyVyVXOz3oMfoTvO+ud1oA4fsDYcU/ZqhW5urZiGgT7tlrORpstS8ULRGTYBosaNjHH6QdUe2OdvetN0oqHnT7KBp5cMpR7cDmxWMCsUUVzjm2IHbTWQTkLCPUGOpYleegnD4Nz01MV7mQBGB2QTalyFfflo+/zqlEmM9epy/P0gKt2ArvJ06iq6fvYxHpPc0hbc9Y+yrXCBy9ONZorZ6PoP8mfEGpz8Em0HVwAjE74ZpvwSg5JSj/UZdO2Gb97m4nWSUNL0FqiKMu8iX+LbNde5JYDaAcSSv9H3e/xwkzywLJ/+4/FVaw3UixQT3OzhaZgjA8iSmpTJxrSrkKGd+iK6CVl4b/7ueyLHZkWhgNM1oQPszbyJLLEtG+X4u2KCrG7mzf0EsqdCP+QZOeie6plne10h+jARKxCUaxwWSpX0NTkp080O+obloUVFVGxC00xet/hd38KtLbjNZhJ+ng5upoG2WHw5L6EoK1kY+Ki3DzAcDA0fmJjR9TUg3iyrfraNiHQmlYgR/Wi7MPiXHskL787iJg06DRKASt5XKBYX1uatQaNNuiGqzZe/uT8fLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(478600001)(7696005)(6666004)(336012)(2616005)(6916009)(70586007)(16526019)(26005)(1076003)(426003)(2906002)(70206006)(316002)(8936002)(356005)(5660300002)(8676002)(41300700001)(82740400003)(81166007)(36756003)(86362001)(83380400001)(40480700001)(40460700003)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:18.3299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264ea9c4-d3f7-44fa-f214-08db8f8977ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the dGPU path instead.  There were a lot of platform
issues with IOMMU in general on these chips due to windows
not enabling IOMMU at the time.  The dGPU path has been
used for a long time with newer APUs and works fine.  This
also paves the way to simplify the driver significantly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 814a6116ca9bb..80362074f9796 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -195,11 +195,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 
 		kfd_device_info_set_event_interrupt_class(kfd);
 
-		/* Raven */
-		if (gc_version == IP_VERSION(9, 1, 0) ||
-		    gc_version == IP_VERSION(9, 2, 2))
-			kfd->device_info.needs_iommu_device = true;
-
 		if (gc_version < IP_VERSION(11, 0, 0)) {
 			/* Navi2x+, Navi1x+ */
 			if (gc_version == IP_VERSION(10, 3, 6))
@@ -293,7 +288,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
-#ifdef KFD_SUPPORT_IOMMU_V2
 		/* Raven */
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
@@ -301,7 +295,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
-#endif
 		/* Vega12 */
 		case IP_VERSION(9, 2, 1):
 			gfx_target_version = 90004;
-- 
2.41.0

