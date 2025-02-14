Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A03DC021A7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4342D10EBF2;
	Fri, 14 Feb 2025 08:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1NlzGw6N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2981910EBF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oarbzbakpdL9pgelxmi8DMNKWNi0OSA1ZQmyu65VJj1+8DSJ7CJqB6pM3drRJaTjD+RKN71PRGDzlGmrFrfgwgFO4oRvf/farECLoJR0L38TG+/deOkUWzHRUS0/5QZejusTKttlFZDs//prmJRooXSAVWUVX1IJGdshMVqzwC3dGx7BPyIiJjRPhvNnAgTGklt48Kl2Gz+UlomuQj/+1T9lj2fJqhVsJdXIivwKzrVWraegYnM6sFdkQ7acaAV8JWXUlPjskPt6ddxZ6UOlxEW3j4BQFQIsK+QN4d9t7jYOZ6FsRfcEYOBvxyw58myq5iWsJ3kprXFSjySYqkdBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkU634z6//f3s2Aq6c9C8Jd9cO1UouvykdPBzh+qPtk=;
 b=D+Brk1ko8sPoTIfvWdpE7TR5oJruUxKN7oovJvUyBrLo6hy1nig2ZPGpQUcjDpr7EWzOM1iCsEnewHuVlkXV0cXQO/zhsFv+BRKnVR+n+AflTgo03DuQ7xtqb0mmYWovX1hr6Wll2Z0heJxB08jMKiFDdZSugQcUN/Nrr37C5X3WrrKO0Nn2MZXKMtYA0wz6ThGT/uilZJWZQmjc9mBgCMGo74R+pg7z2FGN0JIEYg4kFi5WKwFv0jiUV+S2/KMz301vXeW2Jj1NIRA5qaiakEoLKHBJam969yi8gKVcppvCrzV4mNmD0E3KDFEbIi+BxeWt+jI02sih/AVb9B2fZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkU634z6//f3s2Aq6c9C8Jd9cO1UouvykdPBzh+qPtk=;
 b=1NlzGw6Nh+moVEk9q3jV/SVhitwil9XWrZFdKEvYw7C5YQW30OqZ6EAA9ETpBFzFKrOkaSvNr5FAxXQ8w30YQNQL+tapubVG73tCzDMODE+2zFW3zeVuTz+BkDocxQevdp06m3Vz4xlLtScHFluPR0niM+hrquQoIdNoxeqP0O0=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 08:07:57 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::aa) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:57 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:55 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Yang Wang
 <keivnyang.wang@amd.com>
Subject: [PATCH v2 05/12] drm/amdgpu: Generate cper records
Date: Fri, 14 Feb 2025 16:07:12 +0800
Message-ID: <1041cc7f576992060a96b02c9f3dd5b41bc7a3f9.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f77d63-f93e-4a6a-0de8-08dd4cceb10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hoquRHbImTDWnb/pXGsmp37KENFMiwC5Jq6enq1Y/KjSrNtOtyclm1ERfLT5?=
 =?us-ascii?Q?QLgBOMH2MiOMylE3QOeawK3S0k2OznsJZEw7xusNV07vJR4y3Ovtn/i37QSs?=
 =?us-ascii?Q?1t2CPl6tfMFPs4Y1LQGf0IGJVFenW7ioG1wlzUtpU22OmUHzVnu/sxRJiwBx?=
 =?us-ascii?Q?NzNhXbLWzt/i6ISNX3Hxw7HItKGWZ3++b0YqvirWO3Ga4ByQmaGUvw70feon?=
 =?us-ascii?Q?1ETcjslnS7/R54hH3Aa/aWSiItw2sIzDLw7eV33TNrmgzKlqzHM/ysHhuuSc?=
 =?us-ascii?Q?pa5hEiVxS6ulfuAq1f7uCZz2zmLvXHBvePRnn9D/npPtdYS5TRPGAiQzA6ef?=
 =?us-ascii?Q?wrqnMP0/zK5xkrA+0HGIXyU4f0l9jk/UqnoLcJy1wXPWJVQ1EOCMxi+Mrs3R?=
 =?us-ascii?Q?4oEJGFhZr/bK1uHhkk4js/smm5Doa3q3I2olClxBGwAyXX21f0WhOnH3IuxK?=
 =?us-ascii?Q?T9/KutwBw0REeQlvNNOm/s8VL++QAYKjUBd0Vhp2Mv3elftNc48HtHaSVV+D?=
 =?us-ascii?Q?nnDeNRDiRY08ArKsMZECE8Xk0+lYhwbLJezlbCUGFtI81EfO5Zh8dAXmUsdi?=
 =?us-ascii?Q?AoIxnSzSRfnGqMCRrcRB+rPc1xo/xpBWr4h8npugRBBnMckfGE9R4MLnfdSv?=
 =?us-ascii?Q?Q6f4wW4OtuDJD0xoEjWqBOzkcYyH5v54rV7mEE+esTOnYQ+wf34qUYX51dnP?=
 =?us-ascii?Q?SxpCQLQZ0vHc/HZheWOO93U29fgaIUbzLMNCghCXMEQ0yg+1KJld7lp5uNA9?=
 =?us-ascii?Q?TsB/0DIfU8an2h784AI5vNpieEAkFsCvs1j7cy+rTaJlKy48kNO9O6kgEgeu?=
 =?us-ascii?Q?6Pd7nN8IyfdvLysMSOnBgn5rukuCvcR/E2jN9BkCP+L5ufAEjKvqmQG1FfPR?=
 =?us-ascii?Q?5cP25Hkxo2/IczcKWPwa8094x2Lt3Xvt1Lxuz5dHqncI3lNgZqzVzjJdf7Yc?=
 =?us-ascii?Q?galLGM21m7GH+yUHYkOGPjVapKkbvOrH7CmTSx6mZMkIjOarWR4XIELQ64qB?=
 =?us-ascii?Q?O39s3lpNy+AQQnP2sBJ7kw0hHbYUIGQVT6s61cI4fhYGzjXYg4CVaOq7FLlt?=
 =?us-ascii?Q?kLPcc9j/IzCky7rwD8fadHrc+JM0ANTwmjQ77G2o1fEGojh9MOW2h6aYpX/c?=
 =?us-ascii?Q?SzTOpLZUgCtYJyo58VWlAGEV8sRo5z1ruJMhpGjU72wvnb2d5/Xp6w8m1o2O?=
 =?us-ascii?Q?Pteb3FTCiNs49Dgo2RQe1YmWHiEhW98j1quooIPF0z/lOfO/dDEp5WYEwsAV?=
 =?us-ascii?Q?lNVIZ4Fjtau7Che9Ox8gzHg0APWJB1VX5AsmRJFBmWTpvHUvxg7MVc9dUVk9?=
 =?us-ascii?Q?Dwhp/y3lb63X7EdU3SspqoRMM8a6DcnE5kGePlIDh734Ttt8EZOkDIzs4Po5?=
 =?us-ascii?Q?ssGO+iNlfo9nPxjpQJzCnuEVxRQQGRe05JATwcHmNSrYV+LgGM+ehIGv2UaF?=
 =?us-ascii?Q?6eJIac22G1I6X5s6U1ybeSwLZpEw9oIDkpS7k8/VwU2FmKLk9nTYkx+jqBvD?=
 =?us-ascii?Q?m7I8Yc/UBucmolQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:57.3119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f77d63-f93e-4a6a-0de8-08dd4cceb10b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Encode the error information in CPER format and commit
to the cper ring

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Yang Wang <keivnyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index ed1c20bd8114..c0da9096a7fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -384,6 +384,36 @@ static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_type
 	return ret;
 }
 
+static void aca_banks_generate_cper(struct amdgpu_device *adev,
+				    enum aca_smu_type type,
+				    struct aca_banks *banks,
+				    int count)
+{
+	struct aca_bank_node *node;
+	struct aca_bank *bank;
+
+	if (!adev || !banks || !count) {
+		dev_warn(adev->dev, "fail to generate cper records\n");
+		return;
+	}
+
+	/* UEs must be encoded into separate CPER entries */
+	if (type == ACA_SMU_TYPE_UE) {
+		list_for_each_entry(node, &banks->list, node) {
+			bank = &node->bank;
+			if (amdgpu_cper_generate_ue_record(adev, bank))
+				dev_warn(adev->dev, "fail to generate ue cper records\n");
+		}
+	} else {
+		/*
+		 * SMU_TYPE_CE banks are combined into 1 CPER entries,
+		 * they could be CEs or DEs or both
+		 */
+		if (amdgpu_cper_generate_ce_records(adev, banks, count))
+			dev_warn(adev->dev, "fail to generate ce cper records\n");
+	}
+}
+
 static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 			    bank_handler_t handler, struct ras_query_context *qctx, void *data)
 {
@@ -421,6 +451,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 	if (ret)
 		goto err_release_banks;
 
+	aca_banks_generate_cper(adev, type, &banks, count);
+
 err_release_banks:
 	aca_banks_release(&banks);
 
-- 
2.34.1

