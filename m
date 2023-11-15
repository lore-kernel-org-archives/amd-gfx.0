Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34523C5AE5B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D7D10E585;
	Wed, 15 Nov 2023 19:44:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3095A10E585
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUIAEpMZLwSfstxW9GMbOgndDtaoxKDAxepFRLuSxWpxgokhv1vWlSo3jeZc8vt3bJXKb13dJ7zcP2ONbiXwlocG+N+S71fQlt0ECly/2Qn+VzVnGkUF8ikmm3YV6zVrqErotZC/5UXgppclgDEtYISpCQEWv4KIZEN7odlipBoizhvWw/bJ8zEJO50vHTOyRFYo5sFpHOKtvPul4RGPm2R0xdwiRWEEZpX2ChD1szyys01GQVUtec+zkTPV8iyiVRDDVyixdN/UlE+WZraOEaGxuqzy/VJSbssqKr7y+32nc8PZXtSHVMVnrLiBA4eWhRb6xyS1aZw0WWe7YxMF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TByGcxzfBYPeAr30F3KEkawj7uW0MjrK8p92vEn7Pyk=;
 b=EyTwk/Vt3gArSSUsWLpopGy4ebICmhc+P5yM7LtA7FU21k6xwpA78GF5mVrYYI6qKs9nBJDrCi+f6F7dHqWbzEpsk5Lu7CweFbiK6KOm8wFdKZTMVARNV9dr3WRu4JT+zA3mAkCSPLVPUvioVP5DiyjaXIz8+P4PzOBLoCTiPFLu5Eztsp94ZP5qc9S9hufXafs5dNKY3ljVSj9AiL2HmYcxmOj77mUufJdjsbnPC9Vn0wO0yNaN2lRx9N8cnbMFKNPmJtKVAA1FgqrYn7/6NNw7bmceMx5IAXqwBsYueSJ8FkFspbtH2zgpSV5SMA2aGyZOF2E+2z8yw5YF4kW6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TByGcxzfBYPeAr30F3KEkawj7uW0MjrK8p92vEn7Pyk=;
 b=BfQAaIiZu8bPgMO7/GgIRkhOb12DARmKxsO6ER938KwZdDqV/j18OaRS2cwzkykHTpayr6YHc9C2HxK1FyG67gfXSZzAfYzQ01ynhlKDLCRJXAliuMNSCyN4++Ha+qdEplz+qwRV1ciUBh5UxNnMHD7dNmq6spHfxoE4YoKz56I=
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 19:44:35 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::82) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:32 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/35] drm/amd/display: Fix tiled display misalignment
Date: Wed, 15 Nov 2023 14:40:35 -0500
Message-ID: <20231115194332.39469-23-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b174272-785e-4e12-ed82-08dbe6134bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLdjvKz+TadEvjhh1kR1YsF9r6kDnKgmFqHzvzmQLkyqw7OLrTsn3M2OPTvZf64Y/yY7rRUIHIMxYJl5LxKQhH4qtR60IFP57aVPn7laSJ9Af7FX9gwZYeQq+5gsSCg/IBo60nbZFDMYtVS7aKO88ZpP1m/U+NFyB1WqB/bywrJ5iwuKk3NQfm40dwUNww7hodSPO6tTy221pHM5gVPDv3W55rTiiV+QvAwbiUkOTeVQhUeLHMLtnuZQhC/5vHu/3gJdIxdV/zszyPWgzd+JAUtG/lvZyBP/YIhh3QimiVV4DpgTYWQnqGjCGBorrEgu98sLLxIYnZZWlYEiDaKtd87vps1mOM3sDEKXCnG9yjLqvA8xGnU6wlhD3e8/rAa6OaR/ebAaoLgzTejTrdAkcUd8XQVYsuaZVeBeXrDyIx7DMHN491C4B3H6nRF9mAh7p0LDnskQPqYTP9t9xMdv89V1w1nIi57cl64HP4YgFLJoxDnkKlt4yop32+2doqgFtUgzsc5kwcrSFhATRn1eFTPNv7xoiJECVYgV4LWu2y97Okx5QEiTVUj0tyMXGGvJaPr2wrQqsoHm69bI3FoCgL/Uze4J5MNKaeuuvSEmxElC6C3Dd9Z/Rhff8eJINTEgAIIxby6ckq19swQx2U8YF6XyvLnXiLPVoQ4ZHdIiGUxDUroULgMdXtAYMhsXCNk7n5WFq6UluiTRuK7OTmGAhqBxcLn/NBcmmxWmJ+bSvViwUOte0hGilYPsjSTuB8SGyc4g9KDSSYF6Pwc/j4cIZ97IYoAqyGnv2fRZVamitKgqydqfuoYCVMNSNddamLFr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(70206006)(54906003)(316002)(6916009)(70586007)(83380400001)(16526019)(82740400003)(356005)(8676002)(8936002)(40480700001)(4326008)(478600001)(36756003)(81166007)(44832011)(40460700003)(86362001)(5660300002)(2616005)(1076003)(36860700001)(2906002)(26005)(426003)(336012)(47076005)(41300700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:35.1937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b174272-785e-4e12-ed82-08dbe6134bbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas
 Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
When otg workaround is applied during clock update, otgs of
tiled display went out of sync.

[How]
To call dc_trigger_sync() after clock update to sync otgs again.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 76b47f178127..eab713c0da0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1964,6 +1964,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	if (dc->hwss.update_dsc_pg)
-- 
2.42.0

