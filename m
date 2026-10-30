Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A36606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aIpfe/Dj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4827B112652;
	Fri, 30 Oct 2026 06:31:29 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B3E112649
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+u4UVe+9i/GQJmw56T8M5JOFAK1nYTRUCw162vaKSI3LvcQAdcWtSwGMJq+mUoEs/u/c9ugzJLad3rjKwvTMo6btUxmatAYWpdfwK+h/wOJGxjE5dLuW+seFW/i9ekfSviYOGDR57+pPJt1GpWKHMJRxFMYXBwhejDMJM9jcAsIjEJu8hngRgDH4FnP5LFw/mMXvtIblAtbJGqJFHb6xb6r66ht2j+oRPR5Zg1sbKyzi0MNi1l9a6V0YXu24wxVpSv3LNb+DAUTlzcgDbGbhfsJOoISMMUvtIzWphF6+McIRgQQsy/prw4pWHpRmAPLlCZYZ6IkOevyjrJJFjr6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOEKJXJ/XpZ4NUgcaxwzGLacvFN4ycG3gV+AWhFfVIk=;
 b=GE5xVF7WLXgrwbODz1s2ByDEoclvTas7B0wEdNnudVbM1xXrHEcBE2uh0CybESKrct97OyC0vff3IAPLsZShElA9QG6Sch1yorqIyBDu6M3dJ0XhpH5ygnBB2PEvIBKrdSd7y526tV0HbwFyDEn39MT66DdOn5eSY7odevVa3tthKbGw+5ZeGBklcY8w9fAVRx4c/o44zRsevZe84LoiHWiogul6tgtcnbQVegVpOo4UD+FPEjr7wabtzpR3Lzb44yksk7QOfg0cQ3yMcZgurAyjDL0m0eYhhWpOl3+O/XR+djyz3yPv006+kv4QL7vJAqBEOuixdtH0dRui2nMX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOEKJXJ/XpZ4NUgcaxwzGLacvFN4ycG3gV+AWhFfVIk=;
 b=aIpfe/DjDAC+LsdLpEZkPIugkhMnm4XAb6yerv8hvSuHcohBxLSgzNG0pBo+nuZC/Tex0kHOS7XOc7hClHoatC98sN5KWnvpYreOJZ09KcOI/0IjvM2I1amJpL4Y3Z8U49qBFAJYNTIHTqsIOwm7ApWvSs0HSAAt5Z7fHlGgb6I=
Received: from MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:31:18 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::90) by MW4PR03CA0161.outlook.office365.com
 (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 06:31:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:17 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:15 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 08/13] drm/amdgpu/gfx12.1: set mqd->perfcount from
 mqd_prop
Date: Fri, 30 Oct 2026 14:31:36 +0800
Message-ID: <20261030063141.2773032-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eff4d8a-725d-4baa-9ff2-08df364f67a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yFdeAyqw/I/yZG6+jCqMeyVOUu4TxZaJ77AYmm5EwDL3wqI+kmKz29tAQ20jAufDUhhVtW+pHFTh4LysmWaVbxBlYBZ06QQ3yHy3UF88528+OjgLGNwtD5YuNNPM281HJQeOcviIYYaLnFxG3tMfJOc6Ah6++L7UyqdVyIIcWzJAUzhkOYwCqTYNMjuAbSXlwjNoI3e7fJgbJwfblxtllaGtQrEC2PgPec2qvxlxliZrDwfHzsKpmrVscpmLXb88NA/rXW0EiVj8GVhLgAHn3zh5fn9HHvbRJ9OKtlTyGBZzNTYN7QLNUJthOvKihmZSOUYlmMfX6m3gpCMuTKTO9yjYAyDBK4jVaHbbk4H8WCK5s+lGAxleiH6LZAMpCfPGWfG277/AH0CF35lfU/Iw6ZwwpJH9KpY0JdNLy2/u9ftF1SClvV5fFtzpL5MKcftgosMK08EFA3yt/vMDRvC78fI4kY8uSra37uX4Mm3X8wDn7WUx7YLvIgRbtblJo5IewTAUYgucrEdBKdnVZwgvgKxvCZFzw4kS2jwejLpGiy4nzneeLlC8/QSTw9sj17I6VDHtSunVfsewt4GOFwFpRpb2xCvlLKWepcGOF2Bmjb8Bg3C42JKnpAAoqjEckcNrIf+uPONxcmb7/TLChlC8yByyXK7M/0Wv9YtYZGBgkCaUS9hJsaDf2eMwEkW7TDoifIJ1A6TsHa2LZ/l8yvzwpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jbsifcU6LrEcF0W2v4o5kwoQw9DD0/W3+zrWcPnywjXCEvJuccnrFkjnds7kg0oVoE2BF5RWkfy7GS9TCgK7Nol/fW20nj+20HpQSqhOinAqm3b+7ww8vQV9nGwAJepYveCKIk2FFTIuMmwcx4cHkOV1Tck2/NMO9RRjzu4MtIaBYza2073o9fsxu1+ClqCijqgzkT8saLMtiwHi3TGoPW5qfRawVQERV8yejaCHdevITCjFLSQ515BSrkHE5xVGaECMe7im60SYVsJpfapMUCo2bWR6XBZ0bJAHyNV77zAPAric2o+9CXhj9dMm8790vyR3lGb3g5ERK4LjdxbOgSStRcVcYqRqyikFgpeFYH9qMBlbCZ0L/3C8y3Bq0RO5a8598wORD7duj9Y8Qc68hVCtqVkrqCf0tPVWrt34XyvflGXSiziOlP4rNVc6yIRq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:17.8448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eff4d8a-725d-4baa-9ff2-08df364f67a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit sets GFX12.1 mqd->compute_perfcount_enable
from a given amdgpu_mqd_prop

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b19a4956c222..b1caf97f4166 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2170,6 +2170,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
-- 
2.53.0

