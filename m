Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085CCC7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9797810E39E;
	Tue, 11 Apr 2023 09:32:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F337110E39E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5hvRcrMLvYJ+2jWJSqteC55jOOjFc0mb2qmj2ypKxG6dzcjYpNnFSQ1r0u5fjsFTS0vCjDsXOT759F8Th+DnGpropf+/Fchn+IaT3M9gwh94Z4q8+ey2GksA5vvBAR9yVgjjLJxFXvWv32ngXeR4ghjg/ev2nfGR+Wf0/3S5jUscxml/U5JsYN6FJoeCXVnryO9nt+U8xcHq7SmMmP4CrFpZxmQ2I5f45plcIlG/vRb7UyadUAKWRPeEFk+QGiho0Gew4P2n2gMdZiKMXbwT5bVH4BFonHxkzsBfL/1yEte6mcRq4umKtYI8j1lfrw8LGe07pH+61VAZBOHufDddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlvdTM0MhrXYBiNqMUZmq55UqRR5IyQPiIJXi8WvqNM=;
 b=RCoIg+cF5hZNWp5Jcqok1x7o3nkTW03zzMpm3Sna62cwE33b9/2BszgQ2ZqvcJdJzSNOe0ffx4j65MCZELsU61QPhUuePDn4GH+8EcgKIBn9EXkXBLmGxWPDik5sj+OTfqTmyiYG7o2up99dRHjgTQrPNk62/+4gzhwHXzhkAysT0GNGCYwFOn3Ki7DrsqzxEiPrdsBlW5HmXP87Q7klekiYwy15etcuZSrDC/iHmkvwKTMvJ1TGRLSNuxrb5Eg579ixXIrnNi1JNdlx0wseY1W+1NDX54Z4L6VS0/gPdHuvUAd+p3dqT/CHKGOt63SXLMr3CXWcXRDPSmoRUAn2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlvdTM0MhrXYBiNqMUZmq55UqRR5IyQPiIJXi8WvqNM=;
 b=mH5Kksf73slZrP6zMrVJbzfKHgvTW0J+xGzFDKgaqGwuM9ri8j76TJpe87fGSZoR8k+1wzMWEZ8Z2U+p+EeAlaI41y3oBeGk9c4CQmF9t4nAimsieyEUrYVUmiLXuOVNuYOi2i1CzXOSEgVF2C2oBvcDXrAQeE8kvAAdY7Fx6zM=
Received: from DM6PR06CA0016.namprd06.prod.outlook.com (2603:10b6:5:120::29)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 09:32:51 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::d) by DM6PR06CA0016.outlook.office365.com
 (2603:10b6:5:120::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 09:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 09:32:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 04:32:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 02:32:49 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 11 Apr 2023 04:32:48 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH Review V2 1/2] drm/amdgpu: fix unexpected block id
Date: Tue, 11 Apr 2023 17:32:40 +0800
Message-ID: <20230411093241.4644-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2823a9-15b7-4470-31e2-08db3a6fb879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Y6D/3bA1e8fTG27ZklIrYZLYYDFH6taXcR89LkaUhLJvvFm0h9xxLVP9uHxuBpsSmecluQ7dn3g/KK4FgjWZlYMIwhOuddLEtkAF8SYB+8S1R/h2DhAXMTbCxgfgBgYoB4Im8mdpPb7z3OPb8w9g6hF/yWt590TXopBQmlKVP6BxTYouZuRtkJgyB6+80+eUaFd5jVylJAKjvdzrIww9kbmfssuMsT/fvWMMxYy+iJMB/vbXupi1wSE3MYPpr1eScys+SulkI6XPewPGcGb9PtCa4fBuCi66ylfFajmB+dvMKDjPseUzE5g5JPVWcfpDirJeB6IhzVGr2z+a0gcOzoJDZr3A3ob2iK2+ZEtX4Ldh4vEekFEy+djd+z8ucnEeDYkuOzgrtG8vELsQRiYuWSZXjAZ+2IJ51U8Bg2JBHU7CZT0/eY279mikwqklj+4inYjx3cehKHZKd85H0F+yRgsgFPyV9VbYcZScJbn2fOA3MPJXR9K4HtD77HiZsnxhEk3vtRZwQJJS8VbHxqIzQO6X0Z7bEFWc01ysOYQ6Giz2VaokZO6GVoF94MWVdXXcTUVLvBNYNAsXiW4IGmy8FgBUSKB/Tt5aFz2wQg+K7nQcNMgjMq3Yd8DXZIjrifj0cHQVmGkeqyfqWMn7zP6Pvz7ZzpX+7bV9a0GVET9UeA1vxnPd/SstCXqWHHq1NJMYfARDXnfpu5KLasAEQq8no+XQDe/+igUGjDp8kUmxWA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(7696005)(41300700001)(110136005)(316002)(4326008)(8676002)(70206006)(70586007)(6636002)(478600001)(82310400005)(40480700001)(5660300002)(8936002)(2906002)(36860700001)(356005)(186003)(81166007)(82740400003)(6666004)(1076003)(26005)(426003)(336012)(2616005)(83380400001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:32:51.3163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2823a9-15b7-4470-31e2-08db3a6fb879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Aldebaran supports VCN and JPEG RAS, it reports unexpected
block id message during VCN and JPEG RAS initialization if VCN
and JPEG block id not defined.

Change-Id: Icceb43556eec802f11c2077c1c58a1e92c9df599
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ef38f4c93df0..17b3d1992e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -583,6 +583,10 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 		return TA_RAS_BLOCK__FUSE;
 	case AMDGPU_RAS_BLOCK__MCA:
 		return TA_RAS_BLOCK__MCA;
+	case AMDGPU_RAS_BLOCK__VCN:
+		return TA_RAS_BLOCK__VCN;
+	case AMDGPU_RAS_BLOCK__JPEG:
+		return TA_RAS_BLOCK__JPEG;
 	default:
 		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
 		return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 509d8a1945eb..30d0482ac466 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -84,6 +84,8 @@ enum ta_ras_block {
 	TA_RAS_BLOCK__MP1,
 	TA_RAS_BLOCK__FUSE,
 	TA_RAS_BLOCK__MCA,
+	TA_RAS_BLOCK__VCN,
+	TA_RAS_BLOCK__JPEG,
 	TA_NUM_BLOCK_MAX
 };
 
-- 
2.17.1

