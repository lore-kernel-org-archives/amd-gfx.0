Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE6EC48260
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 04:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CB110E142;
	Mon, 19 Feb 2024 04:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VWGrpyU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB4C10E142
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 04:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lgvf/ebTkBI0/kiFemoawdTV715Bai1lC0WrhGdo4+wBAJ8BI/sh1K4Qf8I2Qz1mPVgXApCCHEfRawwVyYYjYs57g1DDHuipzjwB7TwjQM4rf4eu9K+lVfEW6O/yUJFfpP1mG1buJ2CQjjOb3vIR038osQVnv3Tp7v4uG+7IlrTSC7cfZw8ky68bjSGTR0e9i0HVvX4wux38YN2f8lZK05A9U8x+tP4iQSlB1ksFrXwoKKEIsbWU2Uhxj7q71rEUNkzRt8tv9LmimPHwncMJiqy+fOay/RnTlfePOwTz7FVzqAiKg3CCCelaKqadf6O4vimJpG8BmoafdSaaf/ar9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdWcclCbwV1Gozt/ahgqkzsTKEqbVUFBuFFFYCGeNjs=;
 b=cCfz0oxwUXQiGruhsEgYOLNbI4ukyt8i5a0/daMK68vzcvQbOty9NByyyVpSRl4Hnui5TRi6MwuDJIeSOjqcf/D/8qC9d/FlDJG+JpSc3F/BBbt/P6WYlxDe28z2fkOvsrB118HVax6YIPEXeaPwX6M5qeX+JP3l9RpvsSo5H3XjFtCM1ns70M7iRZLXZ263bsT2KNd+AyLQKIS/fqNbZ4xBraSyX+ci9UT1nbBAlKbLqQd1jOdW9WGFDGie8mU/ylciCr0K8p88DGziwiNY0IQMatjYpuDVUzVf80CWFYAq2Lra7w5A6pn0+hMkD9BQLWR+DBXa5VAcS0xY01jNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdWcclCbwV1Gozt/ahgqkzsTKEqbVUFBuFFFYCGeNjs=;
 b=3VWGrpyUxVcYm1p+KBdPXyIxraXHp/wnY1EsfCxJ5Ubh/8PHNkqAc0mwInOzM1bvB91BoLZWyEdFvt0dK3Cp11d1uRf/4qxdUkXm12K7BlY3Je57OIvc9L606fsHYBZbJ69F3rJZSHBs0AmEv2g8QvZU0Bw+heT8SUzPWMmV4JA=
Received: from BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37) by
 LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 04:00:13 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::f7) by BYAPR01CA0024.outlook.office365.com
 (2603:10b6:a02:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 04:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 04:00:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 22:00:08 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>, "Yang
 Wang" <kevinyang.wang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix bank error type
Date: Mon, 19 Feb 2024 11:59:54 +0800
Message-ID: <20240219035955.932526-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abe3eb4-d6da-426d-093e-08dc30ff45a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q5NeSQ60pBUz6UkpeBWLr3yqifjdMOWuJ/i31WNlTyOZ5UpsyYdwRcMAIYrSPBelJss8SmsQBRsvTfyKAc5ZAA2M/xIbPR4u9miiCRCK81cQ+2+wMLUIPBnuRN5ZZetsEgflcHRohE2GgZY2oCl7VkhNeRViLhvP+ZKXLBHVzqCmsQWMN24ol4TuAEVr4gVcEVDvxTwgIa0qhs94UNOe4pYwp3VikqHj41QBKVYosnbCsIw6Ss/IX9LnZwuKZWX9cp1fy/Kwk1pL/nvIuHxjPNqfgwBEipUT0dQrX+vAqjNOMG9wQHtaGnAsm4YR6tzVHnGr8TOj50HNklwCAPqFynR6QBS6iT7J+eIqrjYgBZ3CNhwYKZP/74FcbP1/gsSL4oecb9n6H1MnZjTFZae8IDANw1h6PBUsVOiRgfK+F301WjobQMx+ZiABn5lehsusP1oqhFSbE/EjKeyJovou/Udl/JD++N3Zoc/8txfTdHiAHIMlqv95pm4bQrljlHC8hirVnuTAejOfjfV27feWPhIJDZ1DKNxe4Hl1lmRLMHlNhLPio47cM2fyt5WRKqhuRWdS2riQ5dI0S+qcuzilKS0V0PCD0KAHTqFrQHBKF6k1gE2mdzQpViP0OVL+wocwqTUsO9cX2kBVDdlVUC1z4Nz3Gr0VWxYpVwVolnSGoU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(36860700004)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36756003)(82740400003)(86362001)(356005)(81166007)(41300700001)(7696005)(316002)(6666004)(54906003)(478600001)(83380400001)(426003)(336012)(2616005)(16526019)(26005)(1076003)(6916009)(8936002)(8676002)(4326008)(15650500001)(70586007)(70206006)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 04:00:12.1493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe3eb4-d6da-426d-093e-08dc30ff45a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

fix bank error type issue.

Fixes: ecee078c8d169 ("drm/amdgpu: implement RAS ACA driver framework")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 309e73bc5ee7..8c18dfb28030 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -291,7 +291,7 @@ static int aca_log_errors(struct aca_handle *handle, enum aca_error_type type,
 	if (!bank_error)
 		return -ENOMEM;
 
-	bank_error->count[type] += report->count[type];
+	bank_error->count += report->count[type];
 
 	return 0;
 }
@@ -431,7 +431,7 @@ static int aca_log_aca_error_data(struct aca_bank_error *bank_error, enum aca_er
 	if (type >= ACA_ERROR_TYPE_COUNT)
 		return -EINVAL;
 
-	count = bank_error->count[type];
+	count = bank_error->count;
 	if (!count)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 2da50e095883..e650fed2e806 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -123,7 +123,7 @@ struct aca_bank_report {
 struct aca_bank_error {
 	struct list_head node;
 	struct aca_bank_info info;
-	u64 count[ACA_ERROR_TYPE_COUNT];
+	u64 count;
 };
 
 struct aca_error {
-- 
2.34.1

