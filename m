Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC3606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=plpvbbjT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0663210FFC2;
	Thu,  5 Nov 2026 00:05:03 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A284B10FFC2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eignUX4JdAYyD1Vq4ZqmhDPJTHZN1y1O851D5gKyaMYUT2vVHcqZf0NHvG8lTMvfHJ7YbZmOdENA14KFp2Dgd8wJFyTRoZC65x1Ce2MeGDuIvFUArAwj5DQVTFS39HQ9S9KGTZnOkSoYaHb+gWKQ4n4DdFcFnLyutu3CzG7OD2LN7KIGqEm82K7sUocprocG0E/ZcGjl8HPs/pDIN6unVEgZo0oTFFDn/2sCMV0iJnwTiIZi3SBDGKDLLsbTUmVkWesRCClUrI/Z70gQ5jy9IhPyHh4KzKXyJMJo+E3Uk34QgrBvei0qPa76ZE9IoAl6YSg4nuSPAyUpgA8G6l3tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOn3Ji7+VQXlAYFGTHLYQGXNM2u0AOyic2g4Ck6rz48=;
 b=c7op0raraK7dP0Bcf7+1Q1cURdaUuKAxH0k5sOEtSnCzx1s7XDpJACbZsXnF02pgUIiCsLjbC9EbwJMkJL0vJAX3Q9/v+3JX8iLe4Ji09VLBRtikTWk62c//oVw43TfC4Lkg7hL/fYhcjdOwd69HxOio3Y32wWSZMiGLx+jXSZjhY4MsCGSeWynVlW+mQZn3EsavTJb8alEjy7YSXtlR8EOsrwsdr61UubJWgT+eKlbyEX0ryWDSEdcvM5OzHxGvHgcLw6ZIZaZKG2ISY3vQGxSkhCRP5MbEqECVEZvNgjv8Uh+4SvZT5JkRg/v/OdGny6Yb3u+24RsRnDRZTt6A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOn3Ji7+VQXlAYFGTHLYQGXNM2u0AOyic2g4Ck6rz48=;
 b=plpvbbjT3C2mMpHZM9E3c0P5oByucOsw4+uhgWbp/BmhqE8ILB1P7JGR5wZ86CYeLGRIkbwDHiz8gI87//H+VhnasEAlui3+OkRcdH0tppRZOBbXPKgBp+/9iS8w9HbxOSyVE92cXh3G3FWMX3gX5qE/SovngESeV4n68b+CulM=
Received: from MW4PR03CA0330.namprd03.prod.outlook.com (2603:10b6:303:dd::35)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 00:04:50 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::66) by MW4PR03CA0330.outlook.office365.com
 (2603:10b6:303:dd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Thu, 5
 Nov 2026 00:04:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:04:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:04:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Gangliang Xie <ganglxie@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/ras: add ras error query support
Date: Wed, 4 Nov 2026 19:04:40 -0500
Message-ID: <20261105000441.3850131-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000441.3850131-1-alexander.deucher@amd.com>
References: <20261105000441.3850131-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: c3207992-37e5-42c9-19e0-08df3ad068cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|11063799006|56012099006|261022075727099003|261102123227099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: VKkyK679w1EbP2AA/WhpHCs7CH222Ld2E+s3k66lhhP6ti2NDlDHX6+72woArt27iORsVBB0TBd0sD8IzpN0/JDgGO9gW4NfLMWZ22S4m8onmfNjKKdW4SdN4afTEbzYdm+tP9yMDBqNMPY25GIehs3Zc15/LbQoPL5UWksZy3DLmiJO/+BbLK7iMrc1Uf4hW3TmI6mo+mVOSYCWijPZf1pTKAT5u8hfE90+pOWEkyCEJHEmt2WTDBemQJ0UP2JD8BYPtp3z2/mP8JzoTeXcXd/6sLwwAUx6xsctWKqgQ60kLgbXil9ysqm8mzLvVlXYD24yKvInAxyqz06CY8gyfAILwWT9UT7qVoW4Wed/y/O5OtsZyTFTtmZfkLZiBzXQm7l6mAR8EnpzBQIC91urDppoGp7cqjAgYnQJL7lXK2y9EfGisk/UFhWn1XJAp69waYKKt9MsqyWLpAyPOO/iZvY18rxN84W2eC86bAvhZDsATn/fNdrE/dDKqF06REfTnYT93QpDS4mqdTU8G5NBeLUYmMplPG4yJ4uNu8TtcSr9DVjciOPg4LXC43cYQElalNW4ClS3nDyGJy4tcoiMaGz9JMMF1Z8g7E21zpOqPLUE7XvwsEMmoZOBIeDi5tBJCJGLG0a5puOobOw/kWeDdH+DJ0QiNLrzUfl9q7kGG19efx91VgRTmnpKDay/q1HfCmD7DbWI7Jqy/N9RaBM16w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261102123227099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o0D+jyjwoCM2OtaycDEid2Q8Uh23cT9ky7BKpAcOWq0VbfbwaJnUlqfnNfrFHn0yrK9WaI7cOhcuzD9LWgr4/rbaYtV1SoYDiUNLOngCJ+SukuOoh+R/mocSMfHAds0zRn3qPt+zfioUjtUOhlYtG9g7n9rUwC2DFi9SPAyC1VTwzgIlKmBlDQ+3o4RX4cR4JIqt5ANZWyFa2QN9GP5DxB2Dz1AusPp7XNQ7XdN6D2lFYDWI3kogtxJB7/g4LSxixG6QXwytudWl7IRsu+BDoSoBlbqf+Gs2r/w54EfU4m9Cn16b4pdo+bRu2YrRioVPZ56DOrWB0dwD+u4dGTbYzdsybvfYmEnItX7TDrSgjlLgOv6q0NSSUFnDsT32WXjuClplBQRPAMEZuZhqzQBrRJ1uFRCgbRBG2WhMmi5d58ncnmWMULGVHIfmy2uSu1sL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:04:49.5191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3207992-37e5-42c9-19e0-08df3ad068cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gangliang Xie <ganglxie@amd.com>

add ras error query support for smu v15

v2: fix warnings (Alex)

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c | 67 ++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
index 9b3c6651bb852..9975643fed891 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
@@ -41,6 +41,9 @@
 
 #define MP1_RESP_OK  1
 
+#define MAX_UE_BANKS_PER_QUERY  12
+#define MAX_CE_BANKS_PER_QUERY  12
+
 static u32 ras_mp1_msg_codes[RAS_MP1_MSG_MAX] = {
 	[RAS_MP1_MSG_GetRasTableVersion] = 0x1F,
 	[RAS_MP1_MSG_GetRmaStatus] =    0x20,
@@ -239,6 +242,68 @@ static int ras_mp1_v15_get_record(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static int ras_mp1_v15_get_bank_count(struct ras_core_context *ras_core,
+				      enum ras_err_type type, u32 *count)
+{
+	uint32_t bank_count = 0;
+	u32 msg;
+	int ret;
+
+	if (!count)
+		return -EINVAL;
+
+	switch (type) {
+	case RAS_ERR_TYPE__UE:
+		msg = RAS_MP1_MSG_QueryValidMcaCount;
+		break;
+	case RAS_ERR_TYPE__CE:
+	case RAS_ERR_TYPE__DE:
+		msg = RAS_MP1_MSG_QueryValidMcaCeCount;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = __send_mp1_msg32(ras_core, msg, 0, &bank_count);
+	if (!ret) {
+		if (((type == RAS_ERR_TYPE__UE) && (bank_count >= MAX_UE_BANKS_PER_QUERY)) ||
+		    ((type == RAS_ERR_TYPE__CE) && (bank_count >= MAX_CE_BANKS_PER_QUERY)))
+			return -EINVAL;
+
+		*count = bank_count;
+	}
+
+	return ret;
+}
+
+static int ras_mp1_v15_dump_bank(struct ras_core_context *ras_core,
+				 enum ras_err_type type, u32 idx, u64 *regs, u32 regs_sz)
+{
+	int i, ret, reg_cnt;
+	u32 msg;
+
+	switch (type) {
+	case RAS_ERR_TYPE__UE:
+		msg = RAS_MP1_MSG_McaBankDumpDW;
+		break;
+	case RAS_ERR_TYPE__CE:
+	case RAS_ERR_TYPE__DE:
+		msg = RAS_MP1_MSG_McaBankCeDumpDW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg_cnt = min_t(int, 16, regs_sz);
+	for (i = 0; i < reg_cnt; i++) {
+		ret = __send_mp1_msg64(ras_core, msg, idx, &regs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct ras_mp1_ip_func mp1_ras_func_v15_0 = {
 	.get_table_version = ras_mp1_v15_get_table_version,
 	.rma_detected = ras_mp1_v15_rma_detected,
@@ -246,4 +311,6 @@ const struct ras_mp1_ip_func mp1_ras_func_v15_0 = {
 	.reset_ras_table = ras_mp1_v15_reset_ras_table,
 	.get_record_count = ras_mp1_v15_get_record_count,
 	.get_record = ras_mp1_v15_get_record,
+	.get_valid_bank_count = ras_mp1_v15_get_bank_count,
+	.dump_valid_bank = ras_mp1_v15_dump_bank,
 };
-- 
2.56.0

