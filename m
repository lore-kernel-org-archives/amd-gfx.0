Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F3C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDE210F260;
	Tue, 15 Sep 2026 07:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iZu0Qpbh";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BC810F260
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv3VivgEm/1IvJZ+pi/vIjNPuQssIJ2Ieu+K8Hd6hZn6r6RVycw/MwJFNv+HytjzDN0dAHaPeG22JhEXJfRUMgdXt26ThThheLy2+w9lRQBEOOosPfgEaPpn0IKxra1XUHR3FungiXV9tr3osKcBksh+0fGFYKLTWeIYff/+CEdlWjKTxBuMPh62tVE0pvucINcHXnGb+RYUitxVew8pZmIjSnfV0S2WbyWl43CxrAd3hAxfMkg7Dt5wZIwVOrjwviKAoQ9tgebCtbmvCMniUnAo5qRG7nOHnd/wOTLyukhBHDKRiyYc0o0+c5b7CDdEOeqc5VTBwXB7ZY3nLi8rKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAvbvAcu2tvwBz5n18Q/r/rYUPVKkFP+ZLuI9hFQrKA=;
 b=GgnHEeXvHssUX3uXbrf68EbwacpCIcJmhgAOXEZFl9wAQ+7X70YMwSLnqTfE7A3hhntD5gIoMxEjf1wI8FW2Eecuo08hrRxDel6SuGtOesooYIur80uM8bWv/BKtZVcXrxz8b8GrvRpveIalcuqe7hbeKkHZBzOdNOF7zXyp/RXfWOfGJFQcrxVVCsRxNUvpB0dAcUbYLvkiJ2Q/fQeffW87qk9FEcV9DVMDtWIQ3qwvWvD2B6EcuV43A/FmcWTkljd/me7P0DHeQQB6yVfgr6AEYajgMPSntcbvmyjjIagImYWYAq2XZhHmLZb5Eyt1OkLZXp+VedL+N9QaUXnkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAvbvAcu2tvwBz5n18Q/r/rYUPVKkFP+ZLuI9hFQrKA=;
 b=iZu0QpbhQvlDc8IPUUlLJL9yz7HJdkso4kJlGJ1xe4jg+e1FsCfh9JJ7OVpDbs4pEyRUMhLnmKSFXAX8qRquYNYKR7CkhmDJl/ush11x3twFhF7fGPLsG8t9ZKdSy0Tu6NFSyvDn0rSgQvAspzAlh/8JeOwwmO3wK5Tud8sTWyQ=
Received: from BL0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:91::31)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:25:26 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::8a) by BL0PR05CA0021.outlook.office365.com
 (2603:10b6:208:91::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 07:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:25:25 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:25:13 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] drm/amd/ras: use __le32 pointer type to resolve the
 sparse warnings
Date: Tue, 15 Sep 2026 15:24:32 +0800
Message-ID: <20260915072432.1751101-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
References: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: dfef5010-a3ea-45e7-2ea6-08df12fa828d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: AkVmv8xZwjSalDea+Sipt42l5hl1ris7XPsM7GzwsaMa3MgKBuZlonw9TMiHI+qpm8g7hdRmU52hrFwI3m73ios1Uf/sjg/qE6r4i6DTz8PFF581qpZmfN0vPGJgm/ULYXMzYy8HNeS1GH8hO9GXhWylZbPIMZhmfFmtw+0jHF//4DHgjRpxg+nK60FTrZM6I31HpZRI+udWiwjfbttCMLKHuCl1Y0MpbN/F6V+W3X0aQ9Q/4iMYW+TfifNFH0tBE7+TNYHYFXYek767PV8JhLjF1yd5Tp6tLlhp6otqDVqw2RQ6WkJuD+r9POetRmouL/ETjFE+tQ26xXPju3iXNP7U7+TGkpWS35c9PlYYE0hT1LuvFmpxGe6i94Yz5cJeWkM428HBkYUp2/7ZZK91OYgNJRokMd6UJlDCTwjIeISBr4ae1hJWq8SWy74/Dr2EHJreT7hLUsMwyUgMr2FphVvP0+M/OADW6UIlH3dSj1Gj/VwRkFuNaZlDkne1dugmswqHCL+ucwphytMXURfE7+SgB/DwZCYS243JIIFxbpsQ1vgeYCrt4O2xDH05XmNVACj0RfF+/KDyhNsLSyEwfXy+EakkJrXQmYO8ABRNBbEKczBdmWbPDPhJ+VKa4MHcbN50sIL3QFvazgB3UevNTqmO4j6imkrXID05CqkajP6CLjfnKLeZGyayLf1KMNvO9tUs8EiWV732ymZcG9HFEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JSCedim19DZ5DpiU7F4gEU2pVoAKq8oA3XnmFTfMU6T49m9CwQ5mkv86BVUCI9lJfUzunYsNAjn0kfRV12zPBeYXjHGOIypmdKGTpbmn5ghlh25T+nGvcDGXuOoKYkSQhN+qLUANcwKEYi5FZG1VfvR4dVaD7XblI2RZnyF5cgcBt/J8Lz6JVnmlGTaqOsgLAlwsOlye1w0wWoZAY9WQjghwSntuqM9Zr9cO80lq9VyMEE3CzjnlZZS7KgiPHOMdKiE6opZN0Ma1moX6nBKsTJeEPipq1Ve7tlHP94bi37cy7RsCogpnuTDhfMMqokBlUNUcOp3vyivtiLWESPGCQaEGj/uhkxzOHDU82aWYAbELi3HdW1MeXIwuXdVGIPg3whOCcQQ5m5mpgkJLP0Y8gjRppu/uo65H4XoFl4V1O/vYA0LkQtP1UMgEfrkhYhnH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:25:25.0873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfef5010-a3ea-45e7-2ea6-08df12fa828d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

Use __le32 pointer type to resolve the sparse warnings.

sparse warnings:
 ras/core/eeprom.c:275:15: sparse: expected unsigned int [usertype]
 ras/core/eeprom.c:275:15: sparse: got restricted __le32 [usertype]

 ras/core/eeprom.c:277:15: sparse: expected unsigned int [usertype]
 ras/core/eeprom.c:277:15: sparse: got restricted __le32 [usertype]

 ras/core/eeprom.c:288:33: sparse: sparse: cast to restricted __le32
 ras/core/eeprom.c:289:33: sparse: sparse: cast to restricted __le32
 ras/core/eeprom.c:290:33: sparse: sparse: cast to restricted __le32
 ras/core/eeprom.c:291:33: sparse: sparse: cast to restricted __le32

 ras/core/eeprom.c:333:15: sparse: expected unsigned int [usertype]
 ras/core/eeprom.c:333:15: sparse: got restricted __le32 [usertype]
 ras/core/eeprom.c:343:15: sparse: sparse: cast to restricted __le32

Fixes: d95700604fbc ("drm/amd/ras: rename core ras_* files and update include guards")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609101657.kczNjTnY-lkp@intel.com/

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index e7aad113b98a..efa04cd8fbe0 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -260,7 +260,7 @@ static void
 __encode_table_header_to_buf(struct ras_eeprom_table_header *hdr,
 			     unsigned char *buf)
 {
-	u32 *pp = (uint32_t *)buf;
+	__le32 *pp = (__le32 *)buf;
 
 	pp[0] = cpu_to_le32(hdr->header);
 	pp[1] = cpu_to_le32(hdr->version);
@@ -273,7 +273,7 @@ static void
 __decode_table_header_from_buf(struct ras_eeprom_table_header *hdr,
 			       unsigned char *buf)
 {
-	u32 *pp = (uint32_t *)buf;
+	__le32 *pp = (__le32 *)buf;
 
 	hdr->header	      = le32_to_cpu(pp[0]);
 	hdr->version	      = le32_to_cpu(pp[1]);
@@ -315,7 +315,7 @@ static void
 __encode_table_ras_info_to_buf(struct ras_eeprom_table_ras_info *rai,
 			       unsigned char *buf)
 {
-	u32 *pp = (uint32_t *)buf;
+	__le32 *pp = (__le32 *)buf;
 	u32 tmp;
 
 	tmp = ((uint32_t)(rai->rma_status) & 0xFF) |
-- 
2.43.0

