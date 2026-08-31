Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5094DC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB4F10E5CF;
	Mon, 31 Aug 2026 04:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0x/4A2S";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C357810E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1y+Zgfm8Gmt1mKQ20CqRUOXSFlRgXfQ233BlPKwhuHKbqcz3LqUYE0F+rnV0pvdyQ9UjO2+EWWwvhY/HbeCdjO735nDr50+MeoDVNS6qsIoCcyZi7HgWy1ZUcyx6GuB310tyUmpwaKeSMQ7DGg1ShH99K6x/p82SLaSuK83Hwv7E20aFoxTfLBgwvi/jN8GdqaqX1rdI7uQGxSnWIuXL1FPG/GhJxVlo0siOJlIhZ7YEHZCKdDBz/nLhMv8hZJhkY6uJQ9aNor3QLUGH3zJSjdWDKxazJMF/NqfQ9hiZ5ghbxGjAObFY1TDxdPEBsvDYJp+pxBvzrN52FgPzet4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/To0UczMs/fM1ypT5Y5yrq8FTbdjHTywrB8lqrCYHrg=;
 b=Fr57toIi+OTclyDvkj1jS2vftaeuqYqQhDRbWrSxtr90fESVYX7eSti160omHdafQBxvzPumrWqlrqjvCtKA3E6orqJVRBlNvC36zA3FHdPG9EhMA3DSKGZ2mkp1Bmy19XyBw53F4yO/0EJIgxEclD5XPE3K8FAJrWKqycEdu6X9btjXUze2CaFuli//MiVoWGX8a5pOqZY09EMzg+Jr6kdbnTUv+PalRrhNqP3dBLLKXNva0NGk2Lhqw8uSZVPDSxFDe2Wm9XxrJW+n+tZ+7PLpJqw4e/ScgiTUOhrd3m8SL+fbWOkH6c33CTre4H1PISWpiqZBRQNrTaw8to4hLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/To0UczMs/fM1ypT5Y5yrq8FTbdjHTywrB8lqrCYHrg=;
 b=I0x/4A2SgtUh+kJie9nKVrPC7pDfIIFcE5pAsG3uOLyLFCtvxTnj2Kk6M8V0pkth++ozNT9q1dUmFnjCOJMZUI9rcM9iSK6SdVn/VjAjG+lmxtgypaWhqDXljUYAH7AVake9/4jrmcSToSQzsBr39nvn0NqR/n/iKHAueBlzanM=
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:29 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::7b) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Mon,
 31 Aug 2026 04:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:29 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:27 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 5/7] drm/amd/pm: stage od reset for smu 14.0.2
Date: Mon, 31 Aug 2026 12:35:05 +0800
Message-ID: <20260831043507.523599-6-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e52aa9-d613-44b6-0994-08df07194942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KdwNindnf4uGNYb3o/ikzaIiEYUmMrZGllPfyQKEnkvxiD4xyeo4XPNcvvpQQhJ3PGiz6ySdcDLhkacObWzQ8DFe8pL1EZr1N61r+MXeJgAr8XEMWt3RSu/zA8HHff0CyTX1w3v3wQBEuoyZRJWcT7LJdkedXnC50NQeArsnagOrTJB0MJo7nznwSADjxGSu7KKgN9c9lMllonM+/gldkop1sUov/Or3u0AYyi3YPmEybtLfKE7uv5vXqAykt6wY2BStthUGMxeT67voIHCgc7JhNIMy0X+sAAb6uNw+eJ/XrruJSq08wEpY0xMoEle6x7i/eHtpe+InQMesSn3kLtt2XbV6ZpKvFWAYwczMTcRW1FzdyWmkEKFCHb03BJW9MaOSrQAMAOfZ+6Ws6yQEwbuwMKqjXL0N5hV7z+l7u+cMMqmGlJoU9TTKqGJsjWnNN3vcgptDIJwuKGUQcnNwiR/+w3p7rt1eBt6Dlp3KzPZRpcU8xcQ4ZeMXMUYmObtvVCbbfER3wnuOgqw+7zBeNB4N3XEyDrVVU7AHQ0qw/T7lb4WPENM6NliFU+GDQZiQ8QXkpdq8oivfhVuVz9bRfkMLXRJDGeF+ZiaJ8Zt7MdSzD2l0uJ9zlleHSr5lw3omKTqH5W+n3U2jdCzvQ0bLeBX80j8IRaaeSYVvx3p7FHAvXqRV69B3azH72sTSvhjM9h9n1aA+gWCYkkKtcxwf7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CA6ZB1tL3EmPc+k2yLhYlOvCEgWyeQHAPR8Aw/cHYOFLPtsdSZN1zDSjsO9C5GdH/wE/hCRiIZn52TbuEACDbVyucSfVOOcsX0TIZwsDM2X2t14sycVD7MV73j/a1IoWETfclKpAG0Yurqnsa1KLApScLh5w1JYKk9hdPZ3UaFJF4ABCncB1WZxvdUWd5xI9BizW+jBY64Oe/pZ9WJnnXLdg4N2QjlxZrmYnm6jYvNpwRl8eAZy0tqobfb8TAcAHY9sqdOkn1hZxk3Qv9MbUliL6vod4XYTcfybkeBfkbwUpdrf2eBq7fqTaPnsceX6DmFkp2PKf0iN0DF53a5d1lrDrWg4/idNF7TWSbc9YYKUIYbPs9jpbPgV5Tb8rppkOWyZIgIe5XC7vDlmCvHsdG3xxcysL/ZUOUwMGUbe5V+Y50RpWxj91x+8BspUN+7oy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:29.4148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e52aa9-d613-44b6-0994-08df07194942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

SMU 14.0.2 copies the boot external OverDrive table on reset and uploads
it immediately. Keep the table staged until c.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 71c928e90264..8f297eaedfdf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2762,7 +2762,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		       sizeof(OverDriveTableExternal_t));
 			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
 		}
-		fallthrough;
+		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		/*
 		 * The member below instructs PMFW the settings focused in
-- 
2.55.0

