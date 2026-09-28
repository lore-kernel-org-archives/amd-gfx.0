Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46505C9833F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 10:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65F510E943;
	Mon, 28 Sep 2026 10:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X94vwDYk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533AB10E943
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 10:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzeWGyZW88zzmHrBDsa1W2cB3r4h0je9yAqxrpSwoqi8LevucNyB4FQK98URIXFjidY2Kw3HRgsK0JLNMAVkxqfRQj+3vAuG/2W6VcnBMFmfWM70BGO1hUocOFfA9AgjfisPNUwO/+v8GYy9+t9iDonBFcV1yY8wmOTaK5H4bP/Ze5s0KRuEgZHgsL5V+GQXvKj1tp3KI7dP6nncUkIlksqVr4N8k7T8FrAq6vuYMMHb9+i/WOvwjxTdaGgP72uf9/yA+F2s9uPqUGN7ZNoCm3J927ZsPUhV921sEXXIty4KoXb+wVPEeOdjPVApXrrHf3NnjAhjl3lLLStHWa7wMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyWmm3TNwJf0NXeD8VNLwqIxO3ZhrOK1yXB2272Tb74=;
 b=rQF80V+rz8Bx7Gr9AdPFBNYOCex1/JNW3MQh6DkRutKSp63m1+aAbF/b8NVHues8lPMNr0i24VSkmUg0c5yCwGd+pDR+WwwBrU5bNnsIThg26oofqbCf4dqxuhoiNZ3MN30gehLXlwiJ+vtwtzWlf2V+KXxhv5TIVkdLvk9qEAlYCvpSa9MBc1utGTFytCiwixewPrj82d4XgHEi5e9gWXJRap3+WEsTC6QD4tQzo3GjqBlvxPy1aQLHjUrfh//y8DtkjgB8Whwhp3NZ1RWiYPK1YibXh/MvCjPqtgTjH75v2Q+e1OSegTFySdH14/52tM2DZNL5T6zVHTYLGZP4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyWmm3TNwJf0NXeD8VNLwqIxO3ZhrOK1yXB2272Tb74=;
 b=X94vwDYkb7ru4GxSlCq7RB7dHOdcVlfHgQX+q5HRNrMYVOOKJH6sBbavkjZi9iCVxpYZI2iVJ8uRe2GT+r/Bo27y0Swvs2jxCbdQGoQ5wyC1YenweyLje0MwylfOVkA0IO1pA7Zi6IVsWyweYUGq3ZS4LDdTyC0k/AxSCCDBCXg=
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 10:29:52 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::9c) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 28 Sep 2026 10:29:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:29:52 +0000
Received: from f9br11f2r-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 05:29:49 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <HaiJun.Chang@amd.com>, <Frank.Min@amd.com>, Yiqing Yao
 <yiqing.yao@amd.com>
Subject: [PATCH] drm/amdgpu: guard against failed kfd node init
Date: Mon, 28 Sep 2026 18:29:23 +0800
Message-ID: <20260928102923.1929335-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef68d83-bf0c-4413-f687-08df1d4b6ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: bEaWp2NhZmHSWTdR48fXxbUZ84UluxwLv2bLm9D4DWGohdln4lz7o5CnI0ZXDE0o2z0KVs9Uh1YhlnsCFliYPBF92QTX7ro4QZgW+XAp8HPhQFbVfpAk+MvAd5n2ARK02MQ3mfej8zgJX+OEjzUOsfa9tEbJyuW8rtA754w1/s1UqJT8riu6tLzTJ/P9C4u4i1wGXJ3JzILTUulUNoMSd+OC6H79bUbrdnkoPN7WItU4uZWVrhc+jZFBUivQzyD6GrJs+2MLOV/GJRhY+tVG3PnCJEArAJtfv6l4X1aLB1GYUlHP1Nny9m5x+TCh/MzPXwdElImVWVov9HevEiZxOvbwh7wVJIRq9fWqhcb45BXSn+/7sL8Gl/g4K8Y4iKHDRu4WHCHt8XcrP/WubpxMMFTGGipzpnAOmSzNtZMjKuP/G7mvGgPzBmX7PwB+44/qaihgoWMVvhEtdJYPU57QWBlzyLXTVbbHFzkR2ZXpQejNVGBCYNKj31xESQaHP24XfK8gqEhZJB9bto6xxxAwODb/T+r9yxb5wjOgcW/RApSfiPEwIw5nit8ZZ47IkTbJvbSar857rpi6yDYR52c9+lzFUw06m44UOBcbJ9qLYr2GcBxXSUkuipadZGqEabnMZcgALtLfBEANK6AymcNZMcHL6OYXVrErAHNFUyuJUXoLF8XZXbcKDO1cttgrfdboLvThGZO8W4UNbw2EGO5cxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TkxLlgTEwyk+g2iqWMH0JOomiB588TmuZzPjTb2lH+KZe3SGavgMTzsfFYfH8m3Lb5Qxq5OiiuomA/KUolL3ctIwtrkRc5ytalsmH62cHfRhtvq9WsGmEHVqBqnY5KezfpxthYSWi5KPOus8YVRKnlu0Qp+a0e4ndIXLrZ1Kr4qc5VXrSO/nmb+/yxEPWuC7/x+rMf2PHQ8XJeWc9th5FA8nsQ7mJMINxal0QAF/NGmQc68bYx5Jy/axs0O3QHApwRTAd+K9gsTkDTK7gm5d65i6MwFSPyPsasl+evcUiZGr2XT7egOWifF39G7AVXkKmuC1orHwi6+1aXuSNRia8KbZOCd3BMTs2mM/z5C++AmsNHMmjoX4xTMbKpIUb1EgCghdJmUhMlO2QPiZ1bi/TlRlr9erSHj4YrJdPTyEGgvmBE0rJ5V/QOMDi+mF85ND
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:29:52.4419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef68d83-bf0c-4413-f687-08df1d4b6ea0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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

before kfd_dev_unmap_mapping_range check ptr to avoid null pointer
 from failed or incomplete kfd node init.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 09feb45584bab..7256ec1290bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -330,11 +330,16 @@ void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
 	struct kfd_dev *kfd = adev->kfd.dev;
 	unsigned int i;
 
-	if (!kfd)
+	/* kfd->num_nodes is set before kfd->nodes[] is populated, so a failed
+	 * or incomplete kgd2kfd_device_init() leaves NULL node pointers behind
+	 */
+	if (!kfd || !adev->kfd.init_complete)
 		return;
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		struct kfd_node *node = kfd->nodes[i];
+		if (!node)
+			continue;
 
 		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
 					    KFD_MMAP_GPU_ID(node->id),
-- 
2.34.1

