Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA3CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 17:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF2910E3BE;
	Tue, 19 May 2026 17:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4TUOhtp5";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C1A10E3BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 17:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvnCH23Ol8Txu3XWeHTEnpD8wiPkYBYMKTxjY5MtGrOmXoMnrpOPMUVfkASknenP/RA6vc3jPdxLTmDw9+LMm8l35+VYECZxR/v8ZXIqEJiHVukRDffNlshuCo+alLGNwj2utvELCm+bjpWJEMN9uStUSYckPOSLfXad3NGok5MN9G6M6I5xDpK63L/H9Ctf1LAzhgqK5svlWEvBZ9Rl1w0MZJEVu10etlFfo08zdeLht6DHl8kyVtAdTkKvnxmw8vjStJ87RraquvM5Gi7DHUSI4eHE0+pCNHEEVcOy9Qhqpv2HdohLNnMhpUCXL6oVvBGLjp2s77mQFt9gJztlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWI2sgrd5IdRS5mxtTgzPzuALdi2XsXxTtax32CIAf8=;
 b=nmtS5/BVnMRInyfXs4wXiO8t3jEvbmWB4UmHPD9SOhssitSXi772Qib4yf/dllyhuLeix5U1RdFhOmbb2IKV3GR3LS1ChIjtk7NTFlckWSRXKlgfUUlaGTLSfgx857HQJ5OSv7py/dODikkBF7uHRqYKN434o+kIJUPLw06cIaZsN2DmEoXVO2uf2BwkomO5BzR5+w7983tJvc5kRU9fvuAYNS/oadws48j/OEJ1/6lv0AiOf+jsXs10TjZvstoitpmqPYKZncYGhUysK8jZE4JRFaJM2uDzeZxFfeiSA2sJETatgQXIi+7t9wHDy1JZLXUpk4z7f6StgV7iivduYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWI2sgrd5IdRS5mxtTgzPzuALdi2XsXxTtax32CIAf8=;
 b=4TUOhtp5ljKcjv/D3P2t4ppg3saOQHruNpN+6hljwoGLju2inAx/Bh4g5XMmE9UhHuJg9tpL0ATmCIjX/Y8cj7TD9zIcG8Kd3Jgp9gP/WTWrAJpnV43VFsFRjl9YVYybQp7sY/u/htgBUgOmhDmJy6TaCerlavhjUs8DEKGh0ZY=
Received: from DS1PR02CA0014.namprd02.prod.outlook.com (2603:10b6:8:452::17)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 17:21:52 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::80) by DS1PR02CA0014.outlook.office365.com
 (2603:10b6:8:452::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 17:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 17:21:51 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 19 May 2026 12:21:50 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn4: Fix TOCTOU and overflow in ib parsing
Date: Tue, 19 May 2026 13:21:35 -0400
Message-ID: <20260519172135.635237-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4e2aa4-e97d-4652-cf73-08deb5cb1da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: KMAX0a57b+k58oyY5CfPbltGGYNMAuMzsu8jAbBrR3aciYQoWFFz1SjIDBG/Fo3C5nDkJxKonSNG8MBpvS9Iioxe0JgsUwh4yPEu2wTkn9p4Nnt6pZAbiQnqvQE3dAAn45rF9eiNc14iFD9CDaEw4rIKoJvSa/E/MMhnJIUoiklM8C6BT9g7Lm6on/NMl0fZtrsDr5WdAHGCESbUt7nGbPKJg9Ygu83cQaQcTeHiSlpwfTqHSAST4WSRiFAI6qk5qlQiOkYPOiM2HZ0Ml0D69EFMtwaH4DekMx/3XxkprDAMkQe0BB00aiAiiHPPTnWxoUzvGl1FxkqlK+z+WQiTvm4Rqi8olAwo6UAOBHDwzCQw2at3P2uQGBysiOknLPy1/P7kzSV3wquQcDC5OK53L03uRlRU+t5bLVhp+1OcW/bT/FM3xLIsI3A5HPlLM60qRTjRJtofZIvYr3D/oOJPaG2bL4cawZ51xe2i9E8w4QWnsxpvON6Z/QWXkz1enEGVQ7UtPuRWAvVKm9FBr13amDqBhWCy8uZJm19oGMqeevy5RqOOrK1n9j45EODerLNR5wQenTEgVg+1OrDxB2C5NLeNK0/zqV6vM1FUJscM2SzW29ixKawfEFhtz5hxVVFejEsoqutdDsWZemobG640EVc9i4oZ9pxkF9odXeFeTmbdpzkRsOExYjv0GO3UZslq+HJkk64Fwji55robRoj2EX4bQPi6O1oOu3C6lOKNHvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M81fBvMsMq7upbgdS2hUWExqzkdQiG1FJlK6nKXKDIiaAEsUU6bAgr10qZvAo7HEQ5Ghu7ClZD8sJPBVZ1eoVnZrtevpOMao/CMCBxtucI2s+zGLSfNzeZyQUdojYoUHtiFszYfh/bpTtoq6a6emlqIWT+h80jQshgQR7evbbeaUnwe4pQafg2fVCWA1FSi3eVyXlbezWysNgP6X4vFxQugWV0jANCtC9Yc9Ua5dwgwKZxrQb3vgrQiEjs/pNPYvJzZhuTv5FDXK7WqeWEHpOHqkQQdaoJu/GsTiWa3wGAqPVAlzrNfy6/Ffi9runXNxReTjaVAMRapOxLY9d76RZjiY2zd9zu18JmX5C50RE7N/TksCftJmiSL7kXV3dBvqlZ6unvK4cnoO5FC2Q3q4cTZyBROrMvOj4vGJkjDS4Z+0NcHiS3wMWrvlmmspiJgQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:21:51.2976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e2aa4-e97d-4652-cf73-08deb5cb1da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Fix security vulnerabilities in VCN 4 encoder IB parameter parsing.

With userptr-backed IBs, userspace can race and modify the length field
between validation and use, causing an infinite loop (i += 0) that hangs
the kernel with VCN lock held, resulting in GPU-wide DoS.

Additional issues: out-of-bounds access when i reaches length_dw-1 but
code reads ib[i+1], and missing validation of the start parameter.

Fix by validating start, using i+2 <= length_dw loop condition, reading
length once to prevent TOCTOU, and adding comprehensive bounds checking.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff7269bafae8..f27f6cf5749a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1932,9 +1932,19 @@ static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int sta
 	int i;
 	uint32_t len;
 
-	for (i = start; (len = amdgpu_ib_get_value(ib, i)) >= 8; i += len / 4) {
+	if (start < 0 || start >= ib->length_dw)
+		return -1;
+
+	for (i = start; i + 2 <= ib->length_dw; ) {
+		len = amdgpu_ib_get_value(ib, i);
+
+		if (len < 8 || (len & 3) || i + len / 4 > ib->length_dw)
+			break;
+
 		if (amdgpu_ib_get_value(ib, i + 1) == id)
 			return i;
+
+		i += len / 4;
 	}
 	return -1;
 }
-- 
2.43.0

