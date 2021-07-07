Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F75AC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B4961CB9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B4961CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EF289EB8;
	Wed,  7 Jul 2021 09:05:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4BF6E852
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 09:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krIbGLRFsSpJBwzPNVxNUxzU9lYp9VUJRfHinPT3VNrL7bEEdCunQzXChK2QERwUUHWlkydUNXH5VfMbFftTH3DXrcyeCjCjCPDdKz6/yQrazk9BZpMS/H+8eHfiLUuPMi0MipD+kbuTr2Ps2WGnPd2RHRwi+PPXgpq85JH6JN/5iAYHtMM2fzlKjWMAkTunQeCj9/eBG1qhqeK4Rr66xtkMIQ7l8lW5fbVCHQWfgiNF1DH/Tm6vfdYa7gH5sDirKD9sTaZs6LQh6dhqJFi5/ZfO6wGXWJeB9vVKl9HotLHLTbRMxpdUj+hWprOeyU/l84CB+QETzNs9SuEQr3b8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkSwD2dQygFIjCw2EWLT0q8ARDRM88vjJx5//fIbNhY=;
 b=S0trOXL3TmermkvgEfGxeFWoxw1jcv5a8nVLyd7MesfTrOwNjcCD14ODy4aR9TmO0mZUOyXNpw2cAiTRPUB4TZa89Zl1V/kbTl2rds9TT34xLTWikbSVhEIedH9N4a2SsBwdSnCrm0K6N5fQz2eKOOgU/EueRRABHKvrO/N7yUOhC+t6y70A3HfYyyMXksk+N1IZ+0vEz9ntfV+SFt+zc1KbaEJUsg229msskN8akKi+eRNrSCA0boOIVXOoAA15XnBT5KJPQg24LwPcctp1krrMqAyDTaNvaFdWa8KddR7yByIoom2HJ+Qt9YKQE7yA7dfJ5KOFf1KlYZgVvbJHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkSwD2dQygFIjCw2EWLT0q8ARDRM88vjJx5//fIbNhY=;
 b=pIMmdiX6jWIb3+pKdm41XL8gLS2SlUmh02A87hazjXoMIDWeMN6q19GTpDrX0lxpqs3JUG3IsDd2oFFBQYC/QBB1LuxiszVDfKDRGDjr80KUTCFk12h6Y8xrhruVkijD7NKTffVhfGj41njWACzGZpcSdszYe1yDmDbfVQK4RTg=
Received: from MW4PR04CA0306.namprd04.prod.outlook.com (2603:10b6:303:82::11)
 by CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 09:04:59 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::46) by MW4PR04CA0306.outlook.office365.com
 (2603:10b6:303:82::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Wed, 7 Jul 2021 09:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 09:04:58 +0000
Received: from code-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 04:04:56 -0500
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: update header file name
Date: Wed, 7 Jul 2021 17:04:40 +0800
Message-ID: <20210707090440.30958-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b9f820e-0019-4c0a-aa29-08d941264c0a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1352:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1352B7FD71867A353FF5E2C39F1A9@CY4PR12MB1352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlgTlXs2HF/gRzFnqc4DzHYTacajTIHZDkJ8Nk981UM1Gw9SdKcCmkcMtTvT2kaY5VDFXZVtH2ASM6DhsW82/8QyVliFWaUegSqrRqKQgzdXeMqpfmR1H4bbDrt1GhC/tIkrMOYuqE+xcDn73hRHdpN2rHZiHa640KiZJdEYY4IiL8U9obw8tzitAo3AEUuyb54Wj4ouHLGYBr1WZdeiT7VOzRx9JWpQ1PCb2HKh48cu+ilV8gGjbCh+rJPQRVOeIRgEO+fQVMAgmTCZhzatS/rk9ZqcjHYJ5hAdiaSz8xWWCHMxyG+HuSFGNhcr5Hu4jxoylHA3hNA/bmH1xbvvDFDfDrt4Qiu6sEMl65W+4gZX6Y/O8+j3qg7jl4s6moD3GzFfx6JzF4gag5zVypOwFTw9es/IE6Bw1AIcK822ooOaboYvLVo7Z3PpsgCaNM4dEddznFvlVbt47g2H9+Ac1EGtLFFu/zTFpYGLck+eMTQ5l2IXznaGaaVc9r525MK3aMex7uupZTNxczEMV1KdmiHCw0sgJNJ5eF+F8NzlkUPiUVzWrFlP78NNyf8CtDgxc3BLPAYoe8nm/XyhYMRaPx4Lliux1MUpmef5wFoIJRUkoMPpwZ3+K1RmNxy0/dGp3ef4h8m+U8Xnazc5rOWJ+XlPKRvP/L6zkJ7HQbCOce0eWlqjVp8UBwSVfdE82Sjw9oBTFQGUeI28rUytl2zvC7pyBQh5U69M2OdOWKGzlk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(478600001)(16526019)(26005)(336012)(2616005)(186003)(4326008)(7696005)(47076005)(83380400001)(1076003)(54906003)(8676002)(4744005)(426003)(6666004)(82740400003)(8936002)(5660300002)(316002)(356005)(36860700001)(70586007)(70206006)(36756003)(82310400003)(81166007)(15650500001)(2906002)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 09:04:58.8286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9f820e-0019-4c0a-aa29-08d941264c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1352
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Aaron.Liu@amd.com,
 Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the register header file name.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index beea961749e1..8c2b77eb9459 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -31,8 +31,8 @@
 #include "dcn31_smu.h"
 
 #include "yellow_carp_offset.h"
-#include "mp/mp_13_0_1_offset.h"
-#include "mp/mp_13_0_1_sh_mask.h"
+#include "mp/mp_13_0_2_offset.h"
+#include "mp/mp_13_0_2_sh_mask.h"
 
 #define REG(reg_name) \
 	(MP0_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
