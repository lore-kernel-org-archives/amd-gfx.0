Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA8FC4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 03:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0F710E188;
	Mon,  4 Dec 2023 03:02:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192EE10E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 03:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhzF4vRSmFgNhfC/1u8407BWozy9ppgTS85xXELIkQM0iBza0VKWLkpGdIl9PkRWlKhbGaUg1+6BsYOyyMR52XblZxE1/G0rGJG4Y/1eKoKJ6J0vbiHVLC4bklTvWxI4a5/tTG+mvxal+xZFDymIatEMYpgw19jDw+hOb+8DzfDzs2w16sOGT+o2SXjdgZhzY4IPdCx+2NXvnI1a+i0m26XmQpD1c4/K5NmLR9ANVBjUh7sE5YXDOfO1MDBvqeS0c1gDZHOnKx3cgigcMDZiiCntNaRhKlIj0qzz5Mr0Hr9/CL4wQVBwfb/GylnZRb3DFPN+Tu9TVJ475a3w1GH7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gToRdjVfRzfgeYSh66WVAEsQ0Xv/HzqvbKyAf5hP+Z0=;
 b=cy0KBWVnrqsrnUV8xWIynXHLhZVSslym4WO0qQdxoLSAhATahtu26s3mIjAthDI7jtfAiwSHSIVp4H/aKl3DTmzjy5504IfMnHHax+9pOUGK7EUSGmN27eVnf3koeT2v3GljRIJC/71WCF2hYpdQjmaob02SkU2BCT0g7uQqBtZzX1sfoWG7e8RRUgZs1qruSuq1ikMKB64wiqV0ngN1RLTwoh4DnAph8sDixdZQURxyNZFl9Qs1DIud01ZDGX4J4aVytFG2G4dqaJXUqY7oV1rupyEqIE3U3jMmM4evuMa/NdeIyGH1i9YDo4D9odSWw6GoV7wvQU8pJYt0Ce4uAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gToRdjVfRzfgeYSh66WVAEsQ0Xv/HzqvbKyAf5hP+Z0=;
 b=oZxqejvNgCutfkJnUXt2bo5IxFYY4+3Wlb6yrfXzZvgY0x/227rLLJcEJ9M1+BcIPZ1Z9Yp3OxLA+xC6pVOA6+fRF07KKYWPDa3194MC1kNsSXCq3kzKp3002YhNtaAs/Dkz2hfLz02bEKV08WVdZJCGcuHGjVJKqiheX2kPF1Q=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 03:01:38 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::72) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 03:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 03:01:37 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 3 Dec
 2023 21:01:35 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: optimize the printing order of error data
Date: Mon, 4 Dec 2023 11:01:21 +0800
Message-ID: <20231204030121.2862186-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204030121.2862186-1-kevinyang.wang@amd.com>
References: <20231204030121.2862186-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaf48a1-df19-4ee3-4302-08dbf47554fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hXWzwV9jSAFUSYHvN14BbBTj8/Y0Qd/xoSYLXW2ExhKd8hL6sHMeJeXI92+UqQc5Kly+vOpHxk+dyaYY/kLjaT+hLYR7/XnVe3jCBn1S6YwszSxL3zOkNxmN7QOL82Pz1B7URAEvyRhti/V1BS8Hc+HgHuQWm8+MmhXn6lE3e9IjSGEo6pToR23itEn0rTNGMseG6l4hC2TByrgpOwdj9lMN4/SO3SivigP4gROr0Dyh9EPLHDfakEP6EiOkolWxGeI4VIdgE+Nj/pvhmsSi9xt30vuWaV04lCq+CUw9R/yOOeiuvzXhSZCwlygeCG6DXILRXlYbOuvTSg2lZD2Ih432GqVgQRNswf+Y7L5VwKtKVshiVH6IKfnU3xfa/ezqLuljpOXC7P0fjA2qYisOSg8O9hGG3EKO3Ye7jYbpUbLrbCYzWXuHBY7O2DLY+P7c5tkTTfSxelPdCPrw/fmHkIbUZFmbQaW3CfAlVsmiG9Cp7PwRmptko0z/L0M0tp+z2aazO4Vw0+dCQb7UlDjrT8WWJQ+jNYzF1OLpjwAeLz1MZcc6FHs18q4YgkSMm2uO4TgyBuZ3q87GFnzua5M3aVpanOXR/y7AoOVtbM+QJyONoxRdQz76Yy5+M1/2isHlrSUuqde0dF7L1VrA46t32bW9B3Rek1CurhPKzmy9f4SrPPnI4mMtNd1v2sOo2P6/Ly1HDLMkxiYuINJY2a+lbyeYXYfQ1B7+mWr/hgXKJCeuRWcgfXWcRC62NdnxIgEBKekExAGp92VCQ5VbbnytA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(70586007)(70206006)(54906003)(316002)(6916009)(478600001)(40460700003)(6666004)(5660300002)(41300700001)(36756003)(2906002)(86362001)(4326008)(8676002)(8936002)(1076003)(2616005)(36860700001)(83380400001)(40480700001)(47076005)(356005)(81166007)(26005)(16526019)(336012)(426003)(82740400003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 03:01:37.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaf48a1-df19-4ee3-4302-08dbf47554fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sort error data list to optimize the printing order.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 72634d675e27..bacb59d8b701 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/syscalls.h>
 #include <linux/pm_runtime.h>
+#include <linux/list_sort.h>
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
@@ -3674,6 +3675,21 @@ static struct ras_err_node *amdgpu_ras_error_node_new(void)
 	return err_node;
 }
 
+static int ras_err_info_cmp(void *priv, const struct list_head *a, const struct list_head *b)
+{
+	struct ras_err_node *nodea = container_of(a, struct ras_err_node, node);
+	struct ras_err_node *nodeb = container_of(b, struct ras_err_node, node);
+	struct amdgpu_smuio_mcm_config_info *infoa = &nodea->err_info.mcm_info;
+	struct amdgpu_smuio_mcm_config_info *infob = &nodeb->err_info.mcm_info;
+
+	if (unlikely(infoa->socket_id != infob->socket_id))
+		return infoa->socket_id - infob->socket_id;
+	else
+		return infoa->die_id - infob->die_id;
+
+	return 0;
+}
+
 static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_data,
 						      struct amdgpu_smuio_mcm_config_info *mcm_info)
 {
@@ -3691,6 +3707,7 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 
 	err_data->err_list_count++;
 	list_add_tail(&err_node->node, &err_data->err_node_list);
+	list_sort(NULL, &err_data->err_node_list, ras_err_info_cmp);
 
 	return &err_node->err_info;
 }
-- 
2.34.1

