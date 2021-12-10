Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B631BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB9A10E477;
	Fri, 10 Dec 2021 23:05:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7B210E446
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dypgd7PiHhs7vNIbpoPXDdavsW33u6GrE1NAX1soTM29fNoEKl4XYrCjdNuRSX4yQAtACM48n3niPD52t++bCapG3z/ppq0qypWtY7A3lTECTqyxjfTQf5X/FOqbxfZ84jueirndu4KFoREcv2xtzyimlTUlq/U4Bh2043VoVIHdPV8VRqeh2Ymt406RKeV1By26Q5FhI7WytRsSnHsP928KJP2w3thxs0UFQut1BOkzi22UGwqx1wXyv45q3hAC6sxaexcwS4tTSotkni+D0WAqJ85lxIPng4QI1tDqqK+nleKgwXEBhhkXcA1BRObsq9ZL1ZdJ6uzb3t8Qwx2kLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYgYJlJEa0GAmnZnorbwzU7WZpXA4NksU9N8znTRyEg=;
 b=G5P9hqo7Epq7S2x+yCnimg+s8kq0tzVkBZWXt9zJP89dBZUL0fcPr0TSUTrZIdC4IEQ8mDeYKy3YUoQMzn5+fAL+pG/j0MPJLRV6DzOHMfogRXcAzWDeFmFQt/eNq0XyC/T/TjZc53JhupUD00s8mRLqZ+ltkQ+DhOTlUlWtACqNiYrKPJDf9RqzjwA/z2mehNKI4wzgQGjl94pdZiNGxTQhdWvEFL0jqR6QPw2/9Z5+gP6b3k9om+1UTQcEhF8gc1yCyhODD3PK4IYTq9QN2Icsk21NEScTHLb2d39RYoIq8Lb5oSreMmQh/cxxt1YBDdJQ8u4Wujfee0KXoRFtsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYgYJlJEa0GAmnZnorbwzU7WZpXA4NksU9N8znTRyEg=;
 b=BlKzSJyxGX+LCtUz+aEnlEhmMlccHXYj5TARLywIMZuY9tC3Hb1SItQprI4xBR/f0ni71SBpdeKuMgMyszj5xd9T8+fcEk9g9NP3QRCRb2jVRZv/C5t3PZXWgTpqNxrUDMU4CEmW1UD/bK/hKC27IP7BKUz3lFpsHD4dJv4Lt9g=
Received: from DM5PR19CA0008.namprd19.prod.outlook.com (2603:10b6:3:151::18)
 by CY4PR12MB1893.namprd12.prod.outlook.com (2603:10b6:903:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 23:05:21 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::7c) by DM5PR19CA0008.outlook.office365.com
 (2603:10b6:3:151::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:21 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:18 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amd/display: [FW Promotion] Release 0.0.97
Date: Fri, 10 Dec 2021 15:04:04 -0800
Message-ID: <20211210230408.619373-7-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef92a258-2b57-4904-42e9-08d9bc318a8e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1893:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB189353A2601D5B27ECA6090DFC719@CY4PR12MB1893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECJE0T315YHNFUVb3Wex0p3CEOF+wShtXeA+oqDHSun2LyXhEERPO54TOX9uCnhnw+ljH6L/IOXfLDre1UQKqn8NNDw0zGc6FCyAUs5kLjfbuwtRq04rRdz3hr9LDfIDDmAAbZyPdk4u6Kod5UKGrcGVaWnSh2Pe+pxQwXUA5HC6NFwgf1hVqU9dPu8S86kZMS3kQNun53NSAp0N5lzCPGzPgmFtsh6iQ6LUlXwKJ8He5s2BoxRlr2aL9XOrVIYUFUwsLRQHlHysYP4WnYWh+VVqPHJNkYZk5iRTxlM9wPzJf5pGb23IqJG0N3Sb6RryxmXkEAug+YtiOsRuL4zpZoz/CIjvvGMtJ5S7iv88YMpzF6sO2JXagKwcmKqj6BfcIVAUofKPJouss8fcXwZEf73MS6Lqxn66bacmh9UpsHeHR8VDaTyEgXhiJ3HHzIZR0Eu4pz9WZiYZ2ofZc2xIFzaIaUFmaq1cUffWmCzd/wlMGLmaKotds1ZXDUu+EpbveBgeaWgvYbnArj+SYm8QRF4XnnWvGn9zoB44kX6bKcOcthPkwM9Psnh1w2KQWMDNVbTdR6wQHWCkxvBDGn0HwfnfNuut3XrT/2t2UUOPssq45wEcNrHygjRUT7nCdMz401zpZnqtNtLvDLYQ3af2yDnj+6KibLz54hHT2dAa8ejVKBGgVlG9L9cvr6Dqvs7qDVM7pP1YJInYA7y8ox/uVXkpswBagB4sFWvI31TnuiXXe7RwKG2Olyi9P1b81BLHkHPuNsZwN62nBbTtWncKm9FWW4XKocrh4tz5H2Ku2mw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(47076005)(186003)(8936002)(426003)(6666004)(36756003)(16526019)(6916009)(336012)(508600001)(1076003)(4326008)(4744005)(82310400004)(356005)(2616005)(81166007)(54906003)(86362001)(70586007)(83380400001)(2906002)(70206006)(8676002)(7696005)(5660300002)(40460700001)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:21.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92a258-2b57-4904-42e9-08d9bc318a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1893
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a473e17d3d3e..a4fd61609190 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xbb1f0cda
+#define DMUB_FW_VERSION_GIT_HASH 0xc99a4517
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 96
+#define DMUB_FW_VERSION_REVISION 97
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.32.0

