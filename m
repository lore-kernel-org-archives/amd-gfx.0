Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742BCC04FDF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F113010E460;
	Wed,  9 Aug 2023 15:09:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42B710E45F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr1vSVrVD5CLG7xlXhga9QM+z+GtFevWvGDfGGG4FOK5Ip5SNO67o/Bq7l6lBLVeISqNE8TJ7fXlioDKZklrUoo8u8l1wqGKlEMeCQpyCmmrKpHAE8Oy5835hPxAGv3dKwk1ILYaGY3Boq6NoUk9LMxsQ2XU6pUrSx3YS5hrtNn3k/99YE2yApSf5KWeJaDV6NfdTgkrj7BJIsz6zbQF9a/tInOKVCqqJWLuNK+b/Jn/D7+dPFWo9bV3qRlatsd6fv87F7VWJr+5n9ZNyCVRfIjgJNEhbAYU0eZ17kMBTbfxmubG2eVklRRGhcqRKExzk/TX37ZjBeKUj37KZqVPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIeUfKNhLmyaLYIzFonwFNkFP/HTisyrscPJ87RBe6U=;
 b=higzMpK7pVZya/u4pRANTKQzTH7DBF3E2gu73FFBUutiNmRYn3W7ZsgiMXVCy3ohWHu07SZFzV+XdR/bXDnS961w6tz1ZPLM8JIJw4j6KoB3DlqYEw05BQ172rZP8JMFdY8rYBC6bKaSX/+Bd9L+JO73WI32Xg8qomJlo2Dh5PGZA0eBixggeh9ZS+O8zjPjgealgbxxW75pT8EBuFf5k9guEUIPcLFPXuDxceg3UFehPesJpMC7IBlDEr88eWqzijIrKtY+9iHwcgN8LojGYNLGbVZYFJwpij042qyFak4DB/FtmQP7jMScPu4H9jVTOobZEbDOyVh8ZJUOJgDGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIeUfKNhLmyaLYIzFonwFNkFP/HTisyrscPJ87RBe6U=;
 b=lzVzJzK865M9CT0KytP9XNdPZf9jY18qn7Hvc4N7apHYm80ky7hX5eLWIy1mXApC4ySkZ+eebkPq3UUgoSCzEzOHt2AWk5d6GZmoYrVC/Xqc9UN5Me7rrPMNggtec8kYPlYjmJQBIgnyk5nl5vXOTq0yiQgiyZeZIztkoUIw1Io=
Received: from CYZPR02CA0018.namprd02.prod.outlook.com (2603:10b6:930:a1::8)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:09:05 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::28) by CYZPR02CA0018.outlook.office365.com
 (2603:10b6:930:a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:09:04 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:09:00 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/15] drm/amd/display: [FW Promotion] Release 0.0.179.0
Date: Wed, 9 Aug 2023 23:05:04 +0800
Message-ID: <20230809150620.1071566-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BL1PR12MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb5b355-8c1b-4da3-2c25-08db98ea925b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFMXidw3OW8euxkkvehyw1w7fEouAFdo3aXCp4AS1gV47FwDtUQl7tgZJzd2fBhKFXlW48WB83LE3A7dOM1x2ZC8v53BWAlxMI4NvofvCfQGqX9Hd0dBAWVOQ8P9yL4ZQFVEiRLDg0KfVRr7sYkJSq8oHPJQsgtAVQ3MYug2AzwW4tU1cjQpkMetZtAkd4gps90CC/95X5G9LVVegiIo7/QcCcbK23p0sw9nw0MTJgOBHeowauk9V4u723MOer55NvD5nCmNrXMrIt3GvOuvD+v+ar3cKjPZD+p/apLTogqyNV8dl4hhqsNpZppFFARUZA5FWRrHaPkTVGTwaRuVWhipocIIoLOKIOpoFTUWZpygdWXgXDLHz8ENVQ+qwPAXRL/S8WABXVvCKwGoOUOA7DFdCw3RA/mG6AQ5dnFlGJquA5ZAn54Ax96xoaznFmm6/sJ1PA8wMgv1a+22U8U7Mmn+VyOaPceNp9SaPkB8kgoN69bZCtieTdHfjMTqGxGw/zTlgmX9NgeqcHfGBv55IjgWp+Sr+DfgBwq+2Pf0LMTJk3ihzUQBUHjhCDWyZusx8tivxdDGbgapuq19EUr0kxRTZUvU2fKQ5DvXIss1/0BIBqHtVtMbpHWaVap/KwcqG+Ya4WLNvq0YDaR8gPSAKeKMlLu3ZmvHvguNYEd89xCWrvq/tD3DReWA2raF/cXbH59J3GcJGv+l8xwh+PD3/cpgznhz3cWCfXt2MIUf5Bz4PStVF+FsrE7JeBAPbgY5osgWfE/MQOfi71UwyDeOUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(186006)(1800799006)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(8676002)(7696005)(54906003)(41300700001)(44832011)(4744005)(316002)(2906002)(4326008)(70206006)(70586007)(40460700003)(6916009)(40480700001)(82740400003)(47076005)(478600001)(81166007)(36756003)(16526019)(86362001)(2616005)(36860700001)(426003)(356005)(336012)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:09:04.7181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb5b355-8c1b-4da3-2c25-08db98ea925b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add defines to specify new PHY power states

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6a1571ffeaf9..7afa78b918b5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2144,6 +2144,10 @@ enum dmub_phy_fsm_state {
 	DMUB_PHY_FSM_PLL_EN,
 	DMUB_PHY_FSM_TX_EN,
 	DMUB_PHY_FSM_FAST_LP,
+	DMUB_PHY_FSM_P2_PLL_OFF_CPM,
+	DMUB_PHY_FSM_P2_PLL_OFF_PG,
+	DMUB_PHY_FSM_P2_PLL_OFF,
+	DMUB_PHY_FSM_P2_PLL_ON,
 };
 
 /**
-- 
2.41.0

