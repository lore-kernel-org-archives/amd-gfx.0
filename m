Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E399BC369B5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DA010E7AD;
	Tue, 15 Apr 2025 14:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40DyTpH/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BC110E7AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4Ja1EvaXwCwVlFE+u7WzJJAxqrbOnE6ZvQtk5VwiznNfIicKR1te03LIsLiIEtYJQi1vS+gEQ0Orvf3mkycUpXaIDQ84KVebUrgOkYoyxYAGc73HTUp+DOIfMiOy7A1qf+vgx0e/0bpyOxWEF0meSp4RPV+NDqpre0eS2/rsMdEeXSVBrgtfILW1mJcIg7HClP8XuOkZTcoagvqIpqFb13hXA0yByTWJBJ346j5G98vu7smrTwugcqlbGdxUB23ijS0Avf8pLykXrPI0aBZOlV9FKrJQ71VnZ2OlJ3XIblvRaL6fxl0ANOUxWhljwvCV69USJggQymXm4PAHNUO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYuIfrgZze2Okwy/geDRUCwDQoKy+BKlNee+zlC+aQc=;
 b=L7mtQk1F0E000B/nzeLl0imt+IdqsrvQe9ULB0SxHSTUfi4S1TR9zhD6lmdHAJVcKUQx9IQCtqANExKadmgf04rzOAQ8lmOSNRq8Cs8wBqWPKy02eiwVapmrJL6OkUEDJnGxyvQvw2ak1ov+fRM7Usv4a2f/5YV31247XBVa2W44tQy1OK+RTsj+yfO8MBMJ/ZeIb3tKcDwHxfdYOaLkCrMzVg7gl3fqpbveY7ekIDbcYBeQrOljwtN6XjUqRoH4ArZ5xUg6VPxMDwz+hPp4JHNUvIm7qmYWl6wMkbSZcjZ4b3i3ngPuNslAK462ku9ffM8rQp+AAuC3ZaBIvaN5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYuIfrgZze2Okwy/geDRUCwDQoKy+BKlNee+zlC+aQc=;
 b=40DyTpH/4RzmeFI2hiF6W5LK7kqQ4UI9k7DyTF5Y/YQe3Zo3OzUt+UuM08NeY+S1X/oZzwFxBXXbvMGAApXkiL8Ttt+xw+zQcIa526NKSXWs8G5hT2dNk01OdpjyI/k2qA4VVigY3HHq4rzrwu+TR3RSbgCxG2ziS07LfZzOqeg=
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 14:35:54 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8f) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Tue,
 15 Apr 2025 14:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:54 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:51 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amd/pm: Add voltage caps for smu_v13_0_6
Date: Tue, 15 Apr 2025 22:35:20 +0800
Message-ID: <20250415143521.367895-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415143521.367895-1-asad.kamal@amd.com>
References: <20250415143521.367895-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 07aebf01-fd60-4b2b-4a23-08dd7c2ad3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YD986CBh8gR3pS+PqtKKvvmHGig+MfIymjnbI8kk6BheLJDGpw4emBcOHZAN?=
 =?us-ascii?Q?G6zyGeQlDsJ2IgeRkiznbdf4xZ9KgWCcCvncuN3U4ErRoiQJv6BIGq7+Y75T?=
 =?us-ascii?Q?1s6kMTo5SYX+n4R4Zs6A03eZkfTfglWqT1KIrlmav/NL+cTmqTE5mtKdH6oB?=
 =?us-ascii?Q?hH+HnqgcENCEN3ea5Ltu2PO7uoWPSk6yseKBbdYvWOLX/+AjUaL5cbg9ek/n?=
 =?us-ascii?Q?z2W1Vop7TLv0em66Jr78bgSEjIgqQ1g2vnTOCFx2hPS7f23Snj7PW6mbd4pu?=
 =?us-ascii?Q?161V+PRbDa53p/PzzW3ZhF4+ANpUKzYnDh5APdhLZNxq/ByDA+5g5GN4z26H?=
 =?us-ascii?Q?486VGmS9mq2b+TGdzJm2HVSDJKbxSCorU5XJf5C0ARB0VXa7ANDGn1HLdijO?=
 =?us-ascii?Q?7oQEh8v7r0Ek2SfEekk5EdBqoOl6hMQ2LldftbYNGPlG20srhuexyN+8p03p?=
 =?us-ascii?Q?ilOd5FjNtGWqbQ49Nvj+byUt51KBLOsysgdXuzr2fmIaeSUcRl6LhbW7X+WF?=
 =?us-ascii?Q?cCYfvOhY7xb3xq+Z/ZlrhCj0ZYd++/WxK1B5Xq4A7GoG3RBqZUG5+0yu8grW?=
 =?us-ascii?Q?evr8XMqB6p8hcsP3AbznmDGhm43M5lcw4HUZ0tQerPwiGZS9+pb+b6yT4lGD?=
 =?us-ascii?Q?xl1xI1Z4uQbjohTR/3WAdoFL4SxRALczt7sUyv1mAQAQIomWJZtXliOGyEKr?=
 =?us-ascii?Q?GBnSdp4u1AVUMIHDZr3HBVs/rGi2p5RU5dTiqwIlhW0oQziG7W8pTOfz74XA?=
 =?us-ascii?Q?DV3+hDUmluhbaiWNBS7lSwvu3ukTsho/hWcvHgiwyphpgdN5BtLQnznkh7ey?=
 =?us-ascii?Q?C5egv0XKKT9imP3SQfR90PefXQ8XOKVqP48AMdPFScUairCQqR2SdM7CmthE?=
 =?us-ascii?Q?wSUbrvtO4dtFD3L9uGMUKGKoaRd3lU6qTs+Lh0fIce3KLvQpSZVxSB3PW3XG?=
 =?us-ascii?Q?3JXy++ntqp+pxXWWu6UG766KBnsbFVHpzrZvCMXSanVh2bqmqU9+y/t1ANkZ?=
 =?us-ascii?Q?6MOOqNhgbfBzDo/9Hx5DStUC4cICpzUuh0grqV6wINIESdnLcy0fEPEFJd9z?=
 =?us-ascii?Q?/Ncmu+cUeriRh/WKfMbzqEMDRoGKw65Q89od0S1oX3hUrAwJvUcicucbUueG?=
 =?us-ascii?Q?X2DXBLduQxkzib6GisckO7ejAFsDjiZSsKl/cZ9VNXEkK6drL1bJ0nlpGm/H?=
 =?us-ascii?Q?kFGdgRmUcfOfranIRnr6q8A1tHsTUQcwUONyVHO19Hh2r4VfqxVHEoQZeP05?=
 =?us-ascii?Q?oPPD5AbPnil/1NaHDB+vqwkP0p9PnotwS+8/TrLO5OzP4MUP2IeaHvTaJt76?=
 =?us-ascii?Q?JRfG0xqfXimtUu6G6uLlO6QNRKStRRXfbSdx6yC8sdXGilmZbGguCktuA7yy?=
 =?us-ascii?Q?9noCF2TaXi8c7okjkDdl4QJNxrMxoExO+EuDHtcmDfvUij17hxagkk1TiGO0?=
 =?us-ascii?Q?FGp6e9e3Ep0GaDMnNR5fan1HG7+aJA71Ixg8Oh4J/47bvU5eRajIlRnk+eda?=
 =?us-ascii?Q?ixdDmavzXQKhV5Jnt6MlGVQJT9v7lk8i8nV4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:54.1807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aebf01-fd60-4b2b-4a23-08dd7c2ad3f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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

Add & enable board voltage caps for smu_v13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a6df07890f8c..8c4672c3a028 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -392,8 +392,10 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
-		if (fw_ver >= 0x00557E00)
+		if (fw_ver >= 0x00557E00) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		}
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index c7a07aa5ef14..5313206ae4bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -66,6 +66,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(SDMA_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
+	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

