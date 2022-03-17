Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA74C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 20:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF76510E776;
	Thu, 17 Mar 2022 20:24:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ECB010E776
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 20:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx+G6hK46BxoMZbF6Nr++HeXG6vKxgnrB/d61ezJ7JnjFM83VaRCRil0c1OKrqRoSkb6OcATXqiZF6om4xG79CxLchMnbR+PSNid4L12V93QOq+RgWRcYrfmjXzfzaz79IEEdnNnLpDzpbvDltjSxPc4aT+yXhCYbmjecz7hcon9p33clIEvptFRxktuqVomLbp5RUBFlZtUFUA0q5EzRbbA3ac+xQaijD1E+gW7fC690amyNA9LQusJlFP92OJT39xtHmO67MnuADsgF50+9MqZAKBr4LLB76A/dGcl8WE/bKXFDeNztkhRFAdCkAXcbrTISK1jmXMmvc/rhZ57Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+Yi2dihR+5VHUq887UiTFc6WAwG+SsBx0jdGWg9J1Y=;
 b=TuC+G0TZ5bm+Qi7qnD6z1jVqOQf08qIE591XHhRtSMQ0cSfOa8fWHMbhC5vW/Dn3rzQj2Ly0fyX6oJIgRXU4BcHbglJOxascp874H3kxNvkXLunFE5BJc9NDz/STS4GH3mB9Dh97cZHVIiVhaTXrpoW+9klcy6dh93FmKi7z6CoC1sHqQrwmIIoyMWYaH7Mo0aT1NwjbXrjmdUX8Os1uDlRVtvFQAX0E8xcctR/TFyJjNgcsdrTDWPgBRP7u9ShCNq3cB97C0Syymq4D/AkdCetcUc3x0ep7tYN7AypiI06yTMmRJ/J1AD5mMZDMhAc0c4hR2roErn1Xcxdvrsc+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Yi2dihR+5VHUq887UiTFc6WAwG+SsBx0jdGWg9J1Y=;
 b=vpMDamLp3xpUc72UiZXoFM4d0Hn1HJa1lP3ORbj4ddN3t8UxHvNIFf6+PC8/pHpyX/I1l4pAu3ZYxtxvYuD4cTK8rCZWO2pAjmjLIYt56m8ZW3lnyrZ2JMHJE4WLuDdMf2BxZyL5zQ6f+IY9VMRqZThkbHUjSW7cHNayIQeEyiI=
Received: from BN9PR03CA0357.namprd03.prod.outlook.com (2603:10b6:408:f6::32)
 by SN6PR12MB2832.namprd12.prod.outlook.com (2603:10b6:805:eb::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 20:24:44 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::94) by BN9PR03CA0357.outlook.office365.com
 (2603:10b6:408:f6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 20:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 20:24:44 +0000
Received: from tuspatel.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 15:24:43 -0500
From: Tushar Patel <tushar.patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Removed dev_error message for incorrect VMIDs
Date: Thu, 17 Mar 2022 16:24:15 -0400
Message-ID: <20220317202415.129865-1-tushar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb5e3e0-9ed1-43f3-1e07-08da08542c95
X-MS-TrafficTypeDiagnostic: SN6PR12MB2832:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB283255E827EB0D29E9CB8E9796129@SN6PR12MB2832.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wL+khPm/tPKRxupuARj4UX3e++1VVtJ0FbY9unK389qgqUg639RIknz76DqdrcgzxJPX5+awChIHDNeKXSH4EISJsx/+JCYjDVo/A8IpH0TLgfyKx1fpAVl0yVsKoV2HQNKB6BrLo9oW8BzHy/83PJ/eWQL7GkJSAcZCrc322qcWA+JoxaBZ/hfJFB7N3/t+c+IEz/Lqv/AXMd/E/fHbUXRPIbsFzFw2Uxv34s2uJIildEdDovrcf4mDJ6b5stw5u775/33dpMjxqrAPhB/hkbMJbi5A8XCEeNrAOM+h6TGkgauIzU/fyW0pL10IWgmwSgRLmgqSOIYDNNrF3m39zmSgoo+7Q2DK/L/B14d4ZcxLS7FaBNe/GRAzBRrcgKiNpcc1K9hN+JW1kx+SGsIZEIvUxR7Jgv2o8RecbEo0ae2i7dw0Yg9lp3Sd/oA3vk65tlJnuZNdCJLqVietVIHVL3nqhErc1d/M71m9N+kTJPFT6W9m1oLc2Zhducjd5C17Rsyo63y2ydh0urt/bC1Qb2cQWh4W5YzNFKlA2qs62RYPXx1fucLCfwNfHyMui5QcdbwPsEBl5l0v6ylgH75PvxURB8fWle0vuKqzXkuNzkyJ7fGObtKlZi7z+L0EtibLEWFtZmabmLOEB5l785l1ypWUJlontgNrtt7uGfmpZlaUp5EjUVwdDLmCC4eodUrVFUiCRQFh9sxfSILfrLmkzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(336012)(86362001)(356005)(81166007)(508600001)(6916009)(47076005)(2616005)(1076003)(16526019)(186003)(7696005)(6666004)(82310400004)(26005)(426003)(316002)(83380400001)(15650500001)(44832011)(5660300002)(8936002)(4326008)(2906002)(8676002)(70206006)(70586007)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 20:24:44.3810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb5e3e0-9ed1-43f3-1e07-08da08542c95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2832
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
Cc: Tushar Patel <tushar.patel@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 39073f72fe5f..f95904d38d24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -485,15 +485,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	/* Verify module parameters regarding mapped process number*/
 	kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
 	if (hws_max_conc_proc != -1) {
-		if ((hws_max_conc_proc > 0)
-				&& (hws_max_conc_proc < kfd->vm_info.vmid_num_kfd)) {
-			kfd->max_proc_per_quantum = hws_max_conc_proc;
-		} else {
-					dev_err(kfd_device,
-				"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
-				hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
-				kfd->vm_info.vmid_num_kfd);
-		}
+		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
 	}
 
 	/* calculate max size of mqds needed for queues */
-- 
2.25.1

