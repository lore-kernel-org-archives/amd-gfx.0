Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A7EC433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A410410E97C;
	Sun, 23 Jan 2022 18:21:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B5D10E857
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWNbGp+Ix6rQr3zHUBVUpyAylseGYQXseCuAl6NwM7HE2j4DnGpASjeRp2UxayFYJxaBozqyLun1hH3XIUnVOpFTwi8pD24irhxPHQ8FshO22E+mpotgatk+4QLDOm2ncuywlhrf5AK2NuAhzvbsdWAR/3QpnauolR/moHAR9lO8kbfb7+UyOMQFH3VrXs70rtBqi5dVjsAdyuGhKl9eOJCWVJmOnQ7D3P+RqJU8t8PDHeNp6IWIoGB/+OqlSD8yNDcE4gk4tyw6qrtsHoVmPYle5PEtPNRZAtjO3ROb0JcrXqTIxqoYbLgGhSj2HCB3JYaOg9mzkZWgb45H45k7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A38upqLVozQsVtYq6iaBjPFMNT8yTclqL6Td/e2/SqY=;
 b=mBZoWf4+f6sXQG+yuskdP8dEqeeKlLHvgzxjpczdaxgtBcQjRg5SebkhbrzQtRHNkO4oiRO7izgYIAYj8yFF/UzuJy8xXIwWAw/Kk+o4HBe9xa8pF4mEfShrrGiGu6UkB/luNm5gyt3mNMexIte5Pp0Xh4ggYcRX9t2TUMp2X5l16obFN4Yr13An30I6LG1ULWKUhGhsCkoY24fgp7ZZ08zKfq4ozWhlGagqeAQnLybXDLfStVD7KMy+lRvb691fA1+JYR3wcqbgXVZCTv+FWfpydw0LTiY6ih7BHUgtTofb88eiSq05YU8jZJU4Mv/3Wwv8QeNttJwLprz/T/6Afw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A38upqLVozQsVtYq6iaBjPFMNT8yTclqL6Td/e2/SqY=;
 b=ZyHtkiQqmts6xsYuuGQBcacEu3KdNy/vH9ozxwvJeCjNgbLHxadssfs6qwaDDkT6xe0gYvyFDcyqqskNv1NGTmMzhazO3VFB7RbQ5hul5TFtZ3uneTg4Ig5pCtJpqPUgZTwWxegWNbEHx0ZbxZz3qURk/P2JewD66eD+6BH4SlE=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by BN8PR12MB3364.namprd12.prod.outlook.com (2603:10b6:408:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:21:15 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::4f) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:15 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:11 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/24] drm/amd/display: 3.2.170
Date: Sun, 23 Jan 2022 13:20:15 -0500
Message-ID: <20220123182021.4154032-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a287588-c4df-4fc4-e2c0-08d9de9d2485
X-MS-TrafficTypeDiagnostic: BN8PR12MB3364:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3364CB93D175F4791FEBE6F3985D9@BN8PR12MB3364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTXwYBKEQidjnile4WdoloShPZNugZ1QwGXhbifgGDwHnj6wZvr1S8UPIzQgba2TsNcDcZSVruUlrvpaote3EZAt8GZdp+jxYLvc6upyrt960N6cXufNNtFKVr9sNmGKRzs4mRtjlrektOIH9yepgiDpLppHKghhB5N6m0pZlfa9uowB6YESONJhnn33YkDFh4nrRlUKegI0Xy1VKs0nQ6uoRuOmaTkp8BAQ9Mfn83hqnObsWoP7O8EA+ofrOCSL3U8pYbWQp1fvdyohmDVJgwH/tpgMfatlxJi1VQ5eyuZCwhNyhgxBhj6cjyTRY/GG7B+UU2AVUS+VSEwEuMQMEtogBHKRtWws5FZM9127n4vvgVfbMLZZcJuHzjatQ9oOoNzqNaMgAf5qbo6/ZuQWACwVKmPfGrth53DzaYmMRQ/djrXifKreI+xVZ4UzjY4U2aod8cKuW2bIPI/BZh75V1RCAHllN91Ufq7bXEpGAZymGAZ6qkB6lO0Kx2olfRQYPGomvx9dtT5YSAfTdzPUYuxLGs1v2PAfo2jljMZUT4wIQcdlORlddy9tbzq+eb6LwjPn0bwlp9KbdefoPYpmaDNOVFzQ42j5SjboVAtEUth8lcRlqfZWR4shmzVd+3UXV1wwjZv5qNN8QVTl4aZjbzM1oMBLbYtXh/vpNYHuay8UemY2MHIaeaDk8GcAMKvugMLH++1lnaNcsHg1Oj6ivAXyqbP/htYUC+NKhranaAHTyAY4UN5SHuz+z34E4+OyaWyhd/N8R0+Q7naQh7eoWmDwQu0I2jTtp9QY7q/aoWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(336012)(86362001)(82310400004)(40460700003)(508600001)(47076005)(6916009)(5660300002)(26005)(2906002)(16526019)(426003)(36756003)(2616005)(36860700001)(4326008)(83380400001)(54906003)(81166007)(356005)(316002)(70586007)(8676002)(70206006)(4744005)(1076003)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:15.3152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a287588-c4df-4fc4-e2c0-08d9de9d2485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following fixes:

- Z9 improvements
- Clocks management adjustments
- Code cleanup
- Improve DSC and MST code

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0dc183d6af5d..69cf78fe78cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.169"
+#define DC_VER "3.2.170"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

