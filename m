Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F3AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 22:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DE610E82A;
	Thu, 14 Jul 2022 22:28:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337E210E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 22:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtV4jJveXgQGVpNLtUh/82zbxSMgPI6mUYka7BwMRxS3bNMRI3tmPXE25vKE51mapcKR8ir1mkJ1l9Ae5w4NuQWsBulQr6Ptn3XYZsA6xTFzhjPGqc69b7Uu1Oj4qhS7UNnOhHnFfwG8x68OJy+0TSb8LMO9Q1eTy9Fj+7k6DR4+bJGu3PoQqClkw/qbWcaimD92DbgznijlF5NpbIeVhqHUjhLfACx+ZAuY7v2bbDozCN8KnKUlUeW5SyN1IuEBcVFoWFe53yY6ovvagYFYpRTb0Ehm8ixUJKv6PB0ghMfNX8L7tt46xMA5aNcnzx7OopzC03O9q7LOZwG8T5qnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMhFFg5f3z1D1C8CsA1ThqccVQdd6G9Fg+bD9Xyd88Y=;
 b=DZT7kEyfdgz8bqoE7ZOj+33HK4ETyEYit8bH77w7Ss+B9XdgqXAEbGKbYByXy0lwPERm2rIhbGov6dLA+0UkcVWGztIjcytoNSoiH7ia9RUnybN2SSALBMSztLRXtKhzTz8/fdMfykHvgve2f/x+1fd56n7RZX20bgnfEuuues5KjZM+L+eDlnYc3ijzFAH6gcI8iNO4xzJ5tVjF2JeCIKy3XH2sSdxa4xMUYG3WDdVJXDS0GIG0OZeeZ/oMzESG2Krn47Ok2cNMWi3k0z5yBcEbYAut/EdOjpBODY/6JFYDWrj9wFy3Yspe8d3L3/HrcmtlPV3WaOpTPouv7q3dRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMhFFg5f3z1D1C8CsA1ThqccVQdd6G9Fg+bD9Xyd88Y=;
 b=Ut370r13oAEtMuFoU60sH/Fn27zw7hPjnt7BSqHcP+fwPIUd8Js+58oH6RtCPBedky9cBwdnskIDUd/BGknicoSnSCUaRCJyVptFmXxkwf6tXKn29ioCqExbegN3cyRMFYY8KNwS4zZfpzjIN9Vcvhdqu455HEIOUpQBK6ZnUJw=
Received: from BN9PR03CA0546.namprd03.prod.outlook.com (2603:10b6:408:138::11)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 21:59:14 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::26) by BN9PR03CA0546.outlook.office365.com
 (2603:10b6:408:138::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Thu, 14 Jul 2022 21:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 21:59:14 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 14 Jul
 2022 16:59:13 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/ttm: fix missing NULL check in ttm_device_swapout
Date: Thu, 14 Jul 2022 17:58:20 -0400
Message-ID: <20220714215820.807146-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe57848b-c4df-426d-f9f8-08da65e41728
X-MS-TrafficTypeDiagnostic: MN0PR12MB5788:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEC++gLzAFWayIpvoV/yZ/QTHMSXBEFtkpqtiHiGz30Zmv4m4c9YpCLzTxAXuHWyWKB9dc2ktLXZiRp9+GTLWd4Nm13dmj0cWzUpPtK39qpiVDILIz1BPDX3Il+Nh28GVw4kcbAk70qHa5zp3g5rcIGLxPDYfPr6uMbVuhL+lfEKHh7Bf9PbpRtBQCazGxJ58pNRER+CplGQkqPEeD3pOdTWS2QFMjoc3VbHdn2t0ox/RVEai42rSaqqfeM1GNkkdm0xl6QDUkweYit5bv9c0txVMO6i7ZyRkCAw1HRcb19RX/e77nlSgjazm+fQBhmDo1z0TmTKrlQdaRoiTRx2tx7lvu4ejKFuxqUNfzGBmhAllB1n8OTH8W06zIS9rJw7TQRFWNJjJ802VIpK7+x3+0pzTABkT3Onm/ngAUMi6uEM3UWklnQYTDEu5qlcbah+uY/vBl6BoYKsVXWDiP92reWSzG6FOHHFvVJJTZeiYahjltv4DDoGCBY0/G7MFbAdqHRs6xnZU2sf1xprIVdB4FIk+m3TtyEhKHP4tCgNKCiTLwOJjahHZKTFXwVJo9GsvMWgpKiPgY61Cm2W+d38rNU7+Mna+4lwc2OAVWCKanF5s/8tSgd5wqDl37jpTSIgbgH/FsAYhzWaCO/C0kXiyK8c8B5sn0vZJZyKvFw+J3b/93Sn2eOAtlTLTu1rwpocMBvG5a67xjf8yinLOC05ncrr8iljd41VGsl0if/71meXzqKlI75mrDlaGnDlOJU10Y2nmeycCMguHFn9GJ/JLqqFyI5vWV2/Xinhm/LiyE8yB5wIo0YvOq5PcKE+bzmFn8YaTGpq4TboNzDgldb/PGqudd0mRx6p4jEGodcfoG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(8936002)(82310400005)(2906002)(5660300002)(4744005)(40480700001)(36756003)(70586007)(4326008)(8676002)(70206006)(316002)(40460700003)(6916009)(6666004)(26005)(478600001)(86362001)(426003)(7696005)(81166007)(47076005)(1076003)(16526019)(186003)(336012)(2616005)(41300700001)(356005)(82740400003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 21:59:14.1075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe57848b-c4df-426d-f9f8-08da65e41728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Backport of Christian's patch 81b0d0e4f811 to amd-staging-drm-next. This
branch may be nearly obsolete, but this patch may still be worth
applying as it can serve as a template for backports to some release
branches. It fixes intermittent kernel oopses when memory is severely
overcommitted.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index be24bb6cefd0..165a6cbb45d5 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -157,6 +157,9 @@ int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
 			list_for_each_entry(bo, &man->lru[j], lru) {
 				uint32_t num_pages = PFN_UP(bo->base.size);
 
+				if (!bo->resource)
+					continue;
+
 				ret = ttm_bo_swapout(bo, ctx, gfp_flags);
 				/* ttm_bo_swapout has dropped the lru_lock */
 				if (!ret)
-- 
2.32.0

