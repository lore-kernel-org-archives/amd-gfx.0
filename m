Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591ECDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 09:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50635890BE;
	Mon, 22 Jun 2026 09:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J2dd/pcR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D7A890BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 09:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOIGBsbrLtiwVOQM9SKL6VGkMFw6ajL8vfr+X/wVIQ/bB9AqQs8pcaEae55jULAm90NRsisWW1yFyj33945QzKYErdM/P58FCCJlgBYEBUucxuPRXFT3tvL7tsxUC0ugy/TcPrjjisXRtuSV3z8lYB+z/ujsuCdRKWgbkxb1h+ZtovMLLSVU3ypmZxIwlbWhMXJ4TD3avE88W906IrIY8zre8X2w4rsoSVZSMrHU9iLMlyIL6CJzW0KrSBPl7nsoQYdkLvDlDdRIQTLSUbADWsKSO9KBfikKhTM1wEgsieJt47/s2VN4PbritD+01LXXEALeoBhfFe0YyFtHdCoIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSj6HbsjwmqPsTSK0bgDp5xqNZA0XOia08stWx667ik=;
 b=fSWDOjPq+jd+oP7CFcl5f4Nl69JTqXa206L61YzEwr4p2cLgXmP+UKqrrNkBPrbxiZwr2orBAc03fKCC0ipJEYqxHZ/GJuMhb7YesMRJWDD/WWCoK6voeJ12vnT0QtgNRDLPWG6CopgDlGLvVnDsISjxAkaOcXkZrxj5jpdzWWBkmQ1Q/iB7qmmQiKGfE8LPmU2zNVO895iJsIu1NkaT2LulccYk/79LHtcfvdy09gav0JvF4hkNN3cb4pxTc0w8/J/36xTHttnW2BVgw9K8zKe/GlU4Q2rQPOOoUl7dTFOu+axPqVhIVriTdUmGwoxOiB1XCAN6TdSUL0FpBZCcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSj6HbsjwmqPsTSK0bgDp5xqNZA0XOia08stWx667ik=;
 b=J2dd/pcR2Wds7gIis4Dbj4XB3/LJjobNyQx1mzXH5wMhi3wfwBY4fJqAitUCHf68oHGPjtTpqe8bFtFtXoWNVjmN3y1FLVed0+/xIk6bBWG0Q9PwbyFrf+laU3vtu4VaBqFswzOtDzSCT40qK9Ql0srjuVbpUlTR2f8bQvrh4z0=
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 09:54:38 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::a8) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 09:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Mon, 22 Jun 2026 09:54:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 04:54:36 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check VBIOS name extraction
Date: Mon, 22 Jun 2026 15:24:04 +0530
Message-ID: <20260622095404.1317549-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: bc83d509-1be2-4738-609c-08ded04445b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: eC/7NkI45OB/i7xyg9/Zl7Z1zly0qPr9E3rq7LUvZZ/TjhPZoKoPMSg6Us1h0kgGrDrp3kZDp7oF/gPS6rKEkzE3iD2DSRbhyOtcd0E+dySH2GZlNF5Sbge8pNJ4Ca/HLSKqN1Jf7wPWTr2E18bGxNn0KU9WhSFkv2IJ7Gy85MD5CTYHssxDbogverDz/5OFWH6U0TNT1z5wosJqP69RdsbyIqNn6zZtuxrWR2a/wRoyxv3/glqqO7PAzPsaNrK7XT7LeeK07L+Xj0Uho+ONikNlhRhMAFf3o/y4nDV/jnS+95aKIbESqZwjYEwt7ggjcuDZS7xO2ZJrZA/+R6h7lhInLXWQuNN/+2+nnY9Woet5Gp8DNLd4dAOvp9bucQhaFDw1ZawT4AQ/JaouBaCfK489/5B/6i6OAN6pYmT01cDDwc4pCvmEgLMye9lQAcswoBgfdE6Y4NAVrIWX+kIpUBHKhEglOlMpVL4IOiTMyGcuEytmKfjqz2THW5Xoz6MRxGNOpPdTcvDyp51ykbTGlBvJbT0IpuUV8h1d9INw6vtHosnZoY4BKcTtenIoJv5v/zK8jiKQ75J6vq4s6FKUubUftHOIdqh+PIaR5uOrUbCjO5+g/C1Mg0lTUhGtble4LtJpLGpZu2oBhN7gdwRH+ngdeMtuOHCSw6HGfWbvDun9bMkXc8dbu1Q6bDFPvC23BENnrxeFztjepzU5BxbTOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kGf+YIyWEEJa7moAOJp8Z3m7zR05aU5sYOvDslLUiKi8Xg7uvwuihYLQDiriMqqxsPL9ftlbQ91on9fjfz59krRM+yoE5OJCCRzQpt/IeC3TkM4EaIc92hXu69hAeteIjN4tRot6eA9XB7LPJSQj2NguHV1hoUGfFS12xpb0wwTjN1DBxRhvpnKwoejR6+kVazAzTHbl44xFsMBxatbAUDQ2tzs/tXCGquwzR8Qy2Tc3jse/KJes9dGllPlndMaf2IH5a3ptMoSQjFWYmZcxUjMqSiqxnCAmr04b4Tl6Ps6PzoT4rsqALKPHGO5esVNGfhHe737A3ITAqc0dR5nhE+OJ0Vk44p9Vv1De5o9ucCjSt0H8cfU8L//B113MBB9JK2gafvJWR7wEEs3EY5MS/oF/Ks0CMqcGqKy5ZBR+xznC4o6zAU5sHnISixjAyBbg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:54:37.8924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc83d509-1be2-4738-609c-08ded04445b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774
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

Bound atom_get_vbios_name() by the BIOS size to avoid out-of-bounds reads.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 34 ++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index d4a652d2b453..ebb4ac279393 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1358,6 +1358,7 @@ static void atom_index_iio(struct atom_context *ctx, int base)
 static void atom_get_vbios_name(struct atom_context *ctx)
 {
 	unsigned char *p_rom;
+	unsigned char *p_end;
 	unsigned char str_num;
 	unsigned short off_to_vbios_str;
 	unsigned char *c_ptr;
@@ -1368,39 +1369,48 @@ static void atom_get_vbios_name(struct atom_context *ctx)
 	char *back;
 
 	p_rom = ctx->bios;
+	p_end = p_rom + ctx->bios_size;
+
+	if (p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START + 1 >= p_end)
+		goto no_name;
 
 	str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
-	if (str_num != 0) {
-		off_to_vbios_str =
-			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
+	if (!str_num)
+		goto no_name;
 
-		c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
-	} else {
-		/* do not know where to find name */
-		memcpy(ctx->name, na, 7);
-		ctx->name[7] = 0;
-		return;
-	}
+	off_to_vbios_str =
+		*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+	c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
+	if (c_ptr >= p_end)
+		goto no_name;
 
 	/*
 	 * skip the atombios strings, usually 4
 	 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
 	 */
 	for (i = 0; i < str_num; i++) {
-		while (*c_ptr != 0)
+		while (c_ptr < p_end && *c_ptr != 0)
 			c_ptr++;
 		c_ptr++;
 	}
 
 	/* skip the following 2 chars: 0x0D 0x0A */
 	c_ptr += 2;
+	if (c_ptr >= p_end)
+		goto no_name;
 
-	name_size = strnlen(c_ptr, STRLEN_LONG - 1);
+	name_size = strnlen(c_ptr, min(STRLEN_LONG - 1, (int)(p_end - c_ptr)));
 	memcpy(ctx->name, c_ptr, name_size);
 	back = ctx->name + name_size;
 	while ((*--back) == ' ')
 		;
 	*(back + 1) = '\0';
+	return;
+
+no_name:
+	/* do not know where to find name */
+	strscpy(ctx->name, na, sizeof(ctx->name));
 }
 
 static void atom_get_vbios_date(struct atom_context *ctx)
-- 
2.49.0

