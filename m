Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D38BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EB96128B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62EB96128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6F96E2D1;
	Wed, 20 Oct 2021 13:53:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568E26E2D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 13:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmPqFrJitpjAqRtPXVpldvW950Ym/tuH7Gnm+FZJnhZAwJtm/GNlVVoRKBi0L97DBiEH5m00JFtWbwav/0FzSoudbU7TLWZp7R9bzozSnCvIFvfnMwylUEknvgTNMip76U1roFoJ7xkJ+v4DIucN2S1C/aHoqx0GGFU4XQZKekTKvY0YVH1AMmtJrfWkAyx/GLAOqW+995dJjrnEVCWH2ipo4Yi/acDhqeVJsBrS8cuUj5YDcEom/atP7gfXBCNWBAdF5fxQl2yDU9HyZz62hdjs/2FBkU+Euoj2bid0eF5Zy/YjbtOjMVncXZvw9Zn2Ais6Nhnf7uOnVV+ldZJMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja+McSOjqrj0t/dfupaZJCorXD7jk5B7CmjUDBhaoz8=;
 b=HbL2Lu8JBMtPidyBRXYxQqj38Soi7EQbG4tmPjcuc+DdoLBcSULs8EYp9TSovfWDM208vhKLCLLR8UXWUlwYMEZ766A0ENO1/OEF2jUN6mRpFx0Mb42EwSQmZjv6ZjsvbI/IvmoCHMxqlMeMucsN6r3s/rx2hnTbUYNR31v9FVxwVBoWT7fSsjWcOF/VpFfmYOfrTTHXRuLLat2l9VzXGDozg1g2bQo1LqyMT4nBUx2t1khN1loGNst2lP0C5mWBLmHzb2vyamVG1NjVUG3iVofNcXX24tT0QoCulSI199OrTjng2rLTI0kKf+QTSa5yVAyrWQ09yHS/ADWzwi4asw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja+McSOjqrj0t/dfupaZJCorXD7jk5B7CmjUDBhaoz8=;
 b=5Ck9STkbUoQNXVPJUvLo9G5Tdr6+zVvCNavroRAIH90VfwJjOwnxI0N8BIBS9xa9UrDmOZnGSDAg1OBl25lREvjtjW59mcPJCR0pzt3XpUoUP9eLh2AMqi0V51wRa7cKXxPspGw+Jsrnj+dK+TbAYkR/a3aLHED3OvZUkIlb+o8=
Received: from BN6PR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:404:b4::16) by DM6PR12MB3418.namprd12.prod.outlook.com
 (2603:10b6:5:116::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 13:53:36 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::58) by BN6PR2001CA0006.outlook.office365.com
 (2603:10b6:404:b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 13:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 13:53:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 08:53:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: add yellow carp B0 with rest of driver
Date: Wed, 20 Oct 2021 09:53:21 -0400
Message-ID: <20211020135321.1011977-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea24a20-64c3-4095-09d1-08d993d1033f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3418:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34185AB532160FCB5DB525B7F7BE9@DM6PR12MB3418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s91frEp5OlDObSK2lrlaJgetwE2ur1WZZHIhqpOmPtgNuw6kyCPiz8gsN3Q1LhI9mmoK/UhB1RymFirN6bFEjnyXQSpQegr2ZvgeDouLg9tmJBxv5giy9VDdfq5+lgR5Tc4EC8r3RF24Th4e1PujiZPYuGAb/XURUozjVcUNlSdtobWT8KkVwxSKO4cs6DgVNd3CaMGO0tH9QSmv+yPe5v2zSQXpA8ltxrRvl0mzwfy5wF8x9NK3O6b2+1O0pBbIxjTgGBr7kHlPdtvs36tOOrHhMpGwsBIrL57S+H6wb7P4jvz0VimFMTP5FSRjyCwFCsuy+zBeQvi0kUB97Fg0+bLjfWGhzVbOMEJqmVkn/3PJuvRZvZDEh5qUpBjmgXpUJcY/4l4WCgFBLlUmgZZej2uW3dR7jRcS66ttM3O0RWmte/pVSpNGLOiw07zJGVuoJG6Izo5KDwRaSkevsGOPR9bIF1+udjGSqnOrdKvBrmVr6gjMgAXSY7l2LzB0bMSQqkeSZ9G7p2RWExiKfrOEn8nkM/uG8wjEpz2QPvpYQ3BrT2Yjlzp4I2asYYMNcjL0vpgHYVXxbe1BkyODylyv6UUDRiguVlTiJvEMwmaCbsId1sBUIhNslQqrijOX+vr5WOyTgBvi4XphgtZ/BaK1xsvXZrSiT73ZaAnSSEsLhrOXH3i1eaxsWvQULh9A69mnTbNAv+rSZrn/8wWgq0gNiR5daguG9dzB1rtwZq46lrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(26005)(36756003)(82310400003)(6666004)(36860700001)(47076005)(1076003)(4326008)(186003)(16526019)(6916009)(2616005)(5660300002)(8936002)(86362001)(81166007)(336012)(7696005)(2906002)(70206006)(70586007)(316002)(8676002)(426003)(83380400001)(508600001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:53:36.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea24a20-64c3-4095-09d1-08d993d1033f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3418
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

Fix revision id.

Fixes: 626cbb641f1052 ("drm/amdgpu: support B0&B1 external revision id for yellow carp")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index a9974f12f7fb..e4a2dfacab4c 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -228,7 +228,7 @@ enum {
 #define FAMILY_YELLOW_CARP                     146
 
 #define YELLOW_CARP_A0 0x01
-#define YELLOW_CARP_B0 0x1A
+#define YELLOW_CARP_B0 0x20
 #define YELLOW_CARP_UNKNOWN 0xFF
 
 #ifndef ASICREV_IS_YELLOW_CARP
-- 
2.31.1

