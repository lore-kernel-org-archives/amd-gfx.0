Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA548C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B9910E4EB;
	Wed, 19 Jul 2023 18:36:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C06710E4EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbXX5er64oCLUcerXW7BnLNGwyG6UZkAa9tSmFECi6SZmf6Cyxaf7fK/sdqchZ0/3LXgzNp/oN52nHUy0FpungS7PD6pGpB+A/dflFQR2TBDuAEpJ9DzLUia429NPBGRlVQHa1Zvz1M2ND0UCl67qCCFaPO/CAeVTOPbfnb4iq8tzT2dr0qOr5y0PLceodq8VNyHKmbJlguvNrgVXfxpIKTq9DnD1+tHwL8eOt/hD7Pgy+a6YTHe94deuJy7hN0BAzABH5EgHe4TIvPtpMrhsQcPBsiZYsvZsZCs7pYatuWH2M5+e0h32IemSHUWiTvkwOHJ7NjaQP7kMldMKlQMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqfk+1YGkHmDqLdz2l7g/zVUgBkO+tlZ9uYwYZJf+XM=;
 b=Tw3sFTLwXQmey7FCjpaTAbOy/yKyu1MlRVEqV6tsxZ3foMetKJF+9MB272uoKxs+cXefnw7O0wUUyZKeiif3noB870NqC66ToeRd50WsJJUwmHUjzVw6vAy/yl8jkh4MznWJnXRYDQeGfG/ecr6aIUb7F81JbyQn9KeA9eDt0gvBQDkbyZOmZGDMi8jwpoVCIMZTGQjPn+YG8YL6LfCWzSZ/uEyMQiKDJL7nj+tmQSSuYgN4ujUvowmqG4zwZM9+U0tV24ptArjEhEBIEFZM/KY9V7K3a/cf0WqSD8ARv8OYyz5aayFQxXhXErE3+tFWqR1Z/2MbsRhtDbNXnQoLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqfk+1YGkHmDqLdz2l7g/zVUgBkO+tlZ9uYwYZJf+XM=;
 b=uqaegUCfM7m9TRBrGpMFPSi0+pTz5ngt7T7YFJ77UCf0BfV8UGviBttvA45kqKqJFtWNWPUJPjJAkuV7Bz5sVrYWngqfFQD3SxVSeBCnfV/UwNCF8PlYHN3PfZGhIpzobiYuLgK0GAKnwwDavl37AgTLl9mfTjsBF7MLr2dcwv4=
Received: from BN9PR03CA0170.namprd03.prod.outlook.com (2603:10b6:408:f4::25)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 18:36:33 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::fd) by BN9PR03CA0170.outlook.office365.com
 (2603:10b6:408:f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 18:36:33 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:36:30 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.244
Date: Wed, 19 Jul 2023 12:28:06 -0600
Message-ID: <20230719183211.153690-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea08d6a-64c1-4d02-5679-08db888713b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLaSMRbgE+XqB+oCPl+AETxU1zUjayEJDhgLksyRy25YVaxS+7QLtj90fdB0szBQ9kuVzQS5hM13o9kP8k9I31yhIgs1B4WdvJUb2KLcIgsRWN1iI4sSE39qKwkrdtSlMb1RCoBArtO2LH7yHKf4xQl5ItwrvxWzmv52md9vw2aPz0YcQoKQelD6A9jcEr9roUJwVXnW6doDaNy2EJTML4dkYgh+bHNd5DBCQakeWFeAgo9qenqT+ceIzqYkTazm0BgkPO+1pjnWc6BvkTz5XqlguSoYxEoulgwQ1sFL4UO8aIMal1BT9Nv/em75gP2zest1PhATlMdZT9QIo6jCPD7Ui9Y/UqA/95yXwnvt5v0dUQKQ7ZQaRNCNwRJEKUi1V7f+S2lcAK+2lmZ0L/iHBjVkAfZVpnTunutbiJdOwP5A8eD7B1gYZQf7aiAusBCnXBaCEA+2EKqT4vVdQ6MepwC+mkYfBgTPGmjS7wtpEpwA/t2i3LfiT9BSDjWZHK6hS+4ux7HtsAJ+3sVDCZgrckxFikJEdYYDrpAtya5paKV3ATIbIE5NqpAp74Qv/D0D5lskWGRjIHJVjUl/uE6LQG2O0FA9Jg/Uom8xWtCgekjdY+D/NQhLK1PrAxmNfqFsauWilgg1/i3hv000C9V7iT73iYWs6aQgmisTmUECq34OetT+FbJqDE139IyZ5LO2tpjxe+7tUTy7n76pz9BZ9v38YTtxJVlH2tRagRmE2EpGcYLqw+Is+kQIqos9Q8GNTa+LhttHbmyCFkCDjaS5SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40480700001)(82740400003)(83380400001)(16526019)(1076003)(40460700003)(186003)(26005)(336012)(478600001)(54906003)(8676002)(41300700001)(8936002)(2906002)(70586007)(70206006)(6916009)(316002)(2616005)(4326008)(47076005)(6666004)(44832011)(5660300002)(7696005)(426003)(36756003)(36860700001)(81166007)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:36:33.5620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea08d6a-64c1-4d02-5679-08db888713b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix underflow issue on 175hz timing
- Add interface to modify DMUB panel power options
- Remove check for default eDP panel_mode
- Add new sequence for 4-lane HBR3 on vendor specific retimers
- Update DPG test pattern programming
- Correct unit conversion for vstartup
- Exit idle optimizations before attempt to access PHY
- Refactor recout calculation with a more generic formula
- Read down-spread percentage from lut to adjust dprefclk.
- Don't apply FIFO resync W/A if rdivider = 0
- Prevent invalid pipe connections
- Rearrange dmub_cmd defs order
- Add VESA SCR case for default aux backlight
- Guard DCN31 PHYD32CLK logic against chip family
- Correct grammar mistakes

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 41e68d694c17..eadb53853131 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.243"
+#define DC_VER "3.2.244"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.41.0

