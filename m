Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75006C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B8510F18B;
	Wed, 19 Oct 2022 08:12:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572C510F181
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 08:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTetp3eTpWtxrfk//IdeDlXdpQneHgLyuPuHEz93Br4N9ypqaoIgEIgGBDRcmYdH39TpDElhzhbQ+sMzNoH6yt5qr/NVWxXNDrzseqDHFwpw9GH0ibo/lDjQTenPF6ckuNU0ybzcMdrsUsbB2hV6G2DufeXBCtsLMEr+UZPUqEjuWJEbwD6O7Z+26jRox2/HWxrqayWQ5M9KilgJq5whQykiTZsY00wwnLZSbIAek1A7zZvxQWajGW8bLrz26AzmsBuB4hb1MZcPK52qxBrd0THxSZ3DSGTLvol/OctIA492m/9WD+4hN4VZJWJCrhOFO8M2nWGlECDmsOKghcL9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz6v/q4K4wHqs2Xw0NJ7st6Bxvxr4Wlq2lSTA7oZvy8=;
 b=KUqt5xfnY1z6bBZGh9wqWgsHqDn40C/kG9ZCznOEbh0OeTl2OuLm213u0kVsJ6sVs1Y9iYY3vshGNbPKPtpvecgChyP/V1XV8JwjGJNtRx90s+nV4Iu39tJnJjBUz2WQKlssnAzXSkeZAuC/IoZYaBSvt3CvqseXWOdKOJUjT7ATyEXBBPEbALjkd2B45q11kY9+rr/1ZPxdV4W21dS3C3fOGKnJLdJdoSenDU+qfR5zQHV5ylmdk50SJmZMlsLfJYsiYrWqRdF+4YECvNE9phEftzOLMJMLDG6dS2mZbmUclCvLNqsTAVI/IVxIz97U6T56cU4ZwiWRsi/tmrpKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz6v/q4K4wHqs2Xw0NJ7st6Bxvxr4Wlq2lSTA7oZvy8=;
 b=Hxc5+rwI0RfkZ9SZ08TnAB7UJLgZAD8YWNkf2aoaXa8gY9PAZNsBNMB/Tek64aGlmZKQL23aMVhnGOUQIhr8El/CCZHahRKQX5U/mXvX3DF07mTKSnXdc094JJQWaP4dbBVyBa+w1Mjlm3xtZh094OdLbyCFxwmnORMe6URovno=
Received: from DM6PR07CA0045.namprd07.prod.outlook.com (2603:10b6:5:74::22) by
 BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 08:12:32 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e0) by DM6PR07CA0045.outlook.office365.com
 (2603:10b6:5:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 08:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 08:12:31 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 03:12:29 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: use page retirement API in MCA notifier
Date: Wed, 19 Oct 2022 16:11:48 +0800
Message-ID: <20221019081150.31773-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019081150.31773-1-tao.zhou1@amd.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 30402773-5476-44df-e265-08dab1a9abed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mo/yvSrR53rZDwD0fe6GJ7tXhjQaEtDjTrK+Fw62sZ6uVakTuizfdcGIcCEg3yFpgloUK5ByZFxL+PG++wSpuqubSTdfdiA1laU/V8CLiKzwqF2dxgv2LmQYPBnaCXzEr0JsbwX5wSjEWGdZEIyvXQz7US4jNQ0yVa1PMp6WjhkSws8XnjX3SyrOncoSwWNvud0uFQV/BAv71Dbp0TA2eTZ8QCQgAhIYuiXqIdm0eOVIOE/NWIthJhEwM9aq3XUCcYIekNKVA8iO9DU96f1ne7Lqfdwz2lLoG0pnpKuU4qm9qFK+lJtHkiaq+mB5GYnfz8SlEbBFvW2JYt+rSUGgc9pYsr4OhIQnBEGx4yRncTMI5+phmO0yYSvdJjr8d5z20YE+BCDoBXw2H0331eUMtwpf2icpRu4Q+PuMq+3yFnnxUH7IVgzOIRN3zYyN9Z1SVZXKzMJv1sLNee3zhM713eMel8JBJF9+83GFVUuwDyyu3xUB6cQbQ2gNq07grXzvZSJ1fitqf1bpKYHDs0od1gN4o2QwDMjpjbysr/QZEfIu5P2fyJ70eFd0sNKGTCjVItd2mSqZOl0g53H3psjQIJIDylhqN/BYOJtVKYWzuKAGbx8hNEJn6BFlmTn9jqR8QIMTMFxZoEbvP6tegt/qUFSVGD7PAu9UqP81gxE4qpGBqpvngXqmIgY+g8dRDL66+irQmNNc/+VhFMe+U2L3GubIpch/BnWL9wh8uGqMy0WifimAIt4yLw6hNN4xIiS7f1T6ubynoCkuhcs+o1d5mEvsV4hi6ZRu6I9TkokSmx1d5NH8sCuH47hQp7B7M0p+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(5660300002)(70206006)(70586007)(6636002)(316002)(7696005)(478600001)(41300700001)(4326008)(8676002)(26005)(16526019)(1076003)(2906002)(8936002)(186003)(336012)(2616005)(81166007)(83380400001)(82740400003)(36756003)(356005)(82310400005)(47076005)(426003)(6666004)(36860700001)(40480700001)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 08:12:31.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30402773-5476-44df-e265-08dab1a9abed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code more readable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 36 +++----------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 21a47f2bb87b..28463b47ce33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,7 +36,6 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
-#include "umc_v6_7.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2849,7 +2848,6 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	struct amdgpu_device *adev = NULL;
 	uint32_t gpu_id = 0;
 	uint32_t umc_inst = 0, ch_inst = 0;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	/*
 	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
@@ -2888,38 +2886,10 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
 			     umc_inst, ch_inst);
 
-	err_data.err_addr =
-		kcalloc(adev->umc.max_ras_err_cnt_per_query,
-			sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if (!err_data.err_addr) {
-		dev_warn(adev->dev,
-			"Failed to alloc memory for umc error record in mca notifier!\n");
-		return NOTIFY_DONE;
-	}
-
-	/*
-	 * Translate UMC channel address to Physical address
-	 */
-	switch (adev->ip_versions[UMC_HWIP][0]) {
-	case IP_VERSION(6, 7, 0):
-		umc_v6_7_convert_error_address(adev,
-				&err_data, m->addr, ch_inst, umc_inst);
-		break;
-	default:
-		dev_warn(adev->dev,
-			 "UMC address to Physical address translation is not supported\n");
-		kfree(err_data.err_addr);
+	if (!amdgpu_umc_page_retirement_mca(adev, m->addr, ch_inst, umc_inst))
+		return NOTIFY_OK;
+	else
 		return NOTIFY_DONE;
-	}
-
-	if (amdgpu_bad_page_threshold != 0) {
-		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-						err_data.err_addr_cnt);
-		amdgpu_ras_save_bad_pages(adev);
-	}
-
-	kfree(err_data.err_addr);
-	return NOTIFY_OK;
 }
 
 static struct notifier_block amdgpu_bad_page_nb = {
-- 
2.35.1

