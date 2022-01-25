Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C1DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 10:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0354910E243;
	Tue, 25 Jan 2022 10:46:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03F510E243
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 10:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmiS/TRfXE47jbvCwUI973rFiMXVoAN7Vgq/VgPKzF8tKCWj/MbYYmcp2BE6KYSv5t1paBOqVkHxsst74HR7h8IYXSrneF7OsJs3bm859myBvk3rXq0QCZ7xEJHi+e0xQzs/SWm6SzLEE6YWfOwtECpu5ubaBS+qU5xLMwsjN9qRpXEec2x+IB7CW95BV25vOf9cUkjygXABlNrfODwHEKtS2pV1KKy0q/SoAqJbglO/1LMpRhEeCbwW27bHa79OhImwD/b4Zia+Mn8o06he73VF3zA0XakzL4qVSoN/9gN6x6jCQOQepKzHvIwjEKJtdKkZNyPn1CAYG0zxRU1PBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D44Z7NNOtSsyZq33T4CFFCGOKyQzlmVI9FakiVSfDPs=;
 b=Y1Lzq2VdaBroIAKLtfKJvUeWDJEpHoeOiwEBMX/7+UVZA3IcY5kekxda4oAGD8+4rAmY1HcN+H5o9hNf1U7MysE9NlM6VQIkwM/rAycTRUEmCSCYPx7k5LtkDCSuL144oOmuPV+/iU7KfHDdftA8TMGE0Ss9sYJz8U+h+Gp+sK0Bv5/RkNb1OW3EKO7mVdZ0I3WM9KDnFfnvptessevAUrAjnPczsQPzLcSmUSBn0PJvdroZJLeU+4bCBEywZ1cP1cj1VyJ6ImqJq6O7Y2sCQwzcyBcqSbwBNrQFjOG0zvsN9+SiXeUPdoDP+vXwvXHCQRPjm6bfj2Zvocz4eXYU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D44Z7NNOtSsyZq33T4CFFCGOKyQzlmVI9FakiVSfDPs=;
 b=bCRYoHuhNCO+KxILMTP7e76rjvDuMYmhTeajLz9KEtik8lJ0WaNQ2oygIBzQjnIjZmfUgl7M1aeMpVsxZsjktRvHqm/cJJVjNe+ioQmDW6fprjUFoPQcz5YjQfUtehMBLsCridlh0P6ccsWiVuXtWYcsJRGxwM9eDsfhEBP4zuA=
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Tue, 25 Jan 2022 10:46:27 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::d5) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Tue, 25 Jan 2022 10:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 10:46:27 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 04:46:24 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: increase bad page number for umc ras query
Date: Tue, 25 Jan 2022 18:46:10 +0800
Message-ID: <20220125104612.27050-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125104612.27050-1-tao.zhou1@amd.com>
References: <20220125104612.27050-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cf1d5d-74fd-432a-3082-08d9dfeff077
X-MS-TrafficTypeDiagnostic: CH0PR12MB5331:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5331AC922A78FF387E088DFDB05F9@CH0PR12MB5331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TG8Ojur9vN0jhMcr8/6HAkzhgBnIcxSKFbNOI3N+arqfkoDec4HrLDVu8q3zitVAWfDsJawQyBtuKrI2nDvG8RB62VZbNiyBQVLqsKXjrtyDBKMP2xEaZIWnOxzIh775MBDbTs0dlFH2zeakbCTE9H2FKnxLK9yRbAN6Od/dCsSLU8Jk2kp5Xm0GYQw92mAU7TjdixlpknJ2/2kTlKe7zdXiduZJuPrIh2t0JTUFEIV6bbBIH7MiyEh3XZHT0UQwbgT48qnQZhrAx7eQsjcOAMVYf5uAiWTeFJCaKO+LSIVfX0CDa/w+t71oPBtJ1L4vzF07/EZsfaBoz/sAqqBsCSgPKEGt3w8u0iB5ZFtbZO7sNiXWimBhNKuAR60qYZz6jqZM4Fzuskfy7ni1s7TlDYaMwIewnZOVTu52bcJlpWZIUznLbXD33mir5J2C9eAb9mp2E1UcXEqLh21q3mlGfeAfmr+uW9lyyfuikU/jMsG1SM+0NYwfzaZ3AyLXKHuGHsaLLwxbSmZZt/W9nIcoz4moogsbMCoySlqbpRvHruP3znyaVtPeLJ+PKi1HtTjb/HXhDXG7Fu9c6M140ytFEG+8iINKVHdC1Ku6dlEBww7N3Ij/lH1ID5uC20KCD5mncMFdIM71/lRw6N5fmSQpoXSSWCiFJw0/AvpsusRSp88J13viargRxWHbQLKM+K2qdU3GFfjTrSkqeZn1TSQwWfi/TNh01+DeYv0xYZ2H7iPffFO8MlIJd7wcbZlgM2F0cZDiWFVbEatfTmH6n1sDnlNOo4MOwDYbI2qlvxapJY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(83380400001)(1076003)(508600001)(36756003)(186003)(47076005)(81166007)(6666004)(86362001)(82310400004)(36860700001)(8936002)(356005)(7696005)(40460700003)(2616005)(70586007)(70206006)(426003)(6636002)(316002)(26005)(110136005)(336012)(4326008)(8676002)(5660300002)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 10:46:27.3375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cf1d5d-74fd-432a-3082-08d9dfeff077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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

One piece of umc normalizing address can be mapped to 16 pieces of
physical address in each umc channel on ALDEBARAN.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 600ff658ab1b..4595027a8c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1213,7 +1213,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.ras = &umc_v6_1_ras;
 		break;
 	case IP_VERSION(6, 7, 0):
-		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
+		adev->umc.max_ras_err_cnt_per_query =
+			UMC_V6_7_TOTAL_CHANNEL_NUM * UMC_V6_7_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 1f2edf625370..9adebcf98582 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -41,6 +41,10 @@
 #define UMC_V6_7_CHANNEL_INSTANCE_NUM		8
 /* total channel instances in one umc block */
 #define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)
+/* one piece of normalizing address is mapped to 8 pieces of physical address */
+#define UMC_V6_7_NA_MAP_PA_NUM	8
+/* R14 bit shift should be considered, double the number */
+#define UMC_V6_7_BAD_PAGE_NUM_PER_CHANNEL	(UMC_V6_7_NA_MAP_PA_NUM * 2)
 /* UMC regiser per channel offset */
 #define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
 extern struct amdgpu_umc_ras umc_v6_7_ras;
-- 
2.17.1

