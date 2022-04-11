Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B93CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8CF10F2AA;
	Mon, 11 Apr 2022 13:52:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9577310F299
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 13:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8UryixEVfvBlvVNoOCVAX0XeXJilgO+//NRhJfcSpOfZhq7Zv3px/B3iAwamcdWLt9xAuSVsMCyjDIlqaqR9fRQQKrd9W3CzmbYHAozOkAX0IWKAYc4t6nrZ2C2kp9JfXXDyBtm63c9FEQs7V6SM+ahJGWThzJBCK2LJiOOuUZkE+3en7jgm/gH1h/ujqlqTRDYur1azfi34jlV3//fXUexYSYf07FZApGRi2pkw1Mv2e234ps5u56dguhxa8qRPzcS84P5/WC5k7wQAZxPYMVs6/gwelH3rLRX7KvAFH9aWFaPfBaehCY1XxSL5y4YeZp011z1TNRBoQB7ejeGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbyrM5dk+G30IKzFMbhQzcXCMQIvn8eIT9w4x6o3Mvo=;
 b=cfSVa5zheVSB+oR5SizizWxnrWlz6gHXhVh05DRZ1ylADhAQFjqoPNtLpQWCKV5BKd3TbkdnIRKcBlB9Nsq0b15c9dBrVTEQzLi2C1lTHosxgOES8FB7mCezXF+Mfg+TCqRFBiT0Wnml1XjSWUZBEG3xKwQTyf/tvVI0Movbino2c1xIfxlOFwcMs9iN0PbSdcIy/0iHOI/7TCyPtWB8teuNW+JleGa4cLaqDWYd4pBC/ppCMV1ZeGfOMO9Jk34PVMqBh6tXyaLN3dtcTWyOuFmgXR+VtByqFehFJqgn/dV7yvfhR1zYwsTWiTO2Mo1TVlNF94jakKW4ZMoCAzTRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbyrM5dk+G30IKzFMbhQzcXCMQIvn8eIT9w4x6o3Mvo=;
 b=ibfc1DoWDDwaEmdXxTR4f8VZTdeJETyf9KN1LTjzueDFFdBXqPtXwLxStO4U7B7vo2GlF1+b62jvrKByVP3EbQinZrXwKeoJe2/RPFIVfKqmsS+epkdVg655M2P0QPQnwN6KQXvqXdms2IKdvJuBgUT7Iyyc1k2xc+Q5KJrkpj4=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 CY4PR12MB1319.namprd12.prod.outlook.com (2603:10b6:903:41::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 13:52:35 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::9d) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 13:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:52:35 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 08:52:34 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jingwen.chen2@amd.com>,
 <monk.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Date: Mon, 11 Apr 2022 09:52:09 -0400
Message-ID: <20220411135209.905421-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe02e77-a7ab-4b18-be85-08da1bc28882
X-MS-TrafficTypeDiagnostic: CY4PR12MB1319:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13192233B574E6DB7CC36A75F4EA9@CY4PR12MB1319.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYvIHvopn26f3EtNhcckRKFOFDUH3jGgHyxYAIi2hBAZx7RuuGQmrXOZuMKmjTbnct0AVAqErykuuk2P0SxnJGD74iy5XgCwqfXYH2W1x5KmIJUkbAQOFBGJCYTRUpUMadjG8Yg8ZvhBSMtogEw74Tj8zkIycXpQdwK0WDiyiz7mmIbjylthvmOAMT0qKTUY9SJ6KU46oiq75M4vXYgng62OjUOM/4nx0r1MPE0GzMv7w6yC+w9mZK9OUL2gfxVcbX8NAeH85I1+vz+1bXBgMAm29yfwDeZELPWLWAtlr5JY8+Za8fhtQcCLtCL/1/JdWpa+VlpSgLpUyN5l0eAT38cMEa7RvvjDHVHvK18peF95T8ISqTtkVZ9jst3dYXn8A8tw+FH8BpqnU9QyjJrg0FRzJBjVT8FRjW0FqbAxGf0sFz/KDsWleGThXZTHuGilbsMNL9h50Cr0UYYu2N6UbcQPzUhsIEFReJWD4yl9iaOtnBe8XbtbVHBWEpGRo0f7ha/DAlfjo+UdoMLPRhzy7Qi10pkOdXNYr+hFoak2WeJslFaNpFqYboRxm2XQkRbnTNFLJQWm52PCKs3BU8HaPPLFyitLWtpmqYKXKJ4tp+ohqZ3uwSFV4sWiUbBd4NoG5Nqn672UHZ1aD3NbGcAbmKv+RFCCfu19jRfDsW/gutNuvXbHAO/lwv0KNTqUoTeDR+IAIvVjM7Mz+bsix72QxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(44832011)(316002)(7696005)(36860700001)(86362001)(36756003)(6636002)(6666004)(16526019)(186003)(26005)(336012)(47076005)(426003)(5660300002)(8676002)(4326008)(40460700003)(70206006)(70586007)(110136005)(356005)(2906002)(81166007)(1076003)(82310400005)(2616005)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:52:35.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe02e77-a7ab-4b18-be85-08da1bc28882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1319
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MS_HYPERV with vega10 doesn't have the interface to process
request init data msg.
Check hypervisor type to not send the request for MS_HYPERV.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 933c41f77c92..56b130ec44a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -23,6 +23,10 @@
 
 #include <linux/module.h>
 
+#ifdef CONFIG_X86
+#include <asm/hypervisor.h>
+#endif
+
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
@@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			break;
 		case CHIP_VEGA10:
 			soc15_set_virt_ops(adev);
-			/* send a dummy GPU_INIT_DATA request to host on vega10 */
-			amdgpu_virt_request_init_data(adev);
+#ifdef CONFIG_X86
+			/* not send GPU_INIT_DATA with MS_HYPERV*/
+			if (hypervisor_is_type(X86_HYPER_MS_HYPERV) == false)
+#endif
+				/* send a dummy GPU_INIT_DATA request to host on vega10 */
+				amdgpu_virt_request_init_data(adev);
 			break;
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
-- 
2.25.1

