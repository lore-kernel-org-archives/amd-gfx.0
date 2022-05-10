Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B98C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F3710E920;
	Tue, 10 May 2022 20:46:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C7310E920
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8SkbZyGazG3yNn9nYwVPRHsK1FOpTOznnoAbWaGudiWMAPDyY+PrCq5/SfXactXEgkSwPj6inPiQ5JiRgOf4ILOTZzWlNj1Ygy4LmNUKrYhHpb2+WtWRMjpgjrAX7rqx/7fjinbpB7Lrr6Ifvw/9YRvetZ+ZeWauXT8mhGH+qU+qfQC6Rnx5ofLbmwIqFyjPnKjqsQ64q7EcMmxdljquCG1FJ3/13GFPjroP0ypUkS4RnQoaNzxJWio+bL7u4ggUTViz/OqQjGIqlffzEZNGYhYnVWBhUnH1okCDHRHTfdsEat098wv+cgiycM4NkPxmPpVEf/Jw89r/Y/JgurDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqk9cAc04WneJ8717MCQhu2Xksog/6PiKyEzJX4zOBg=;
 b=fkBx1fa6dc7Su6S/IwyqLAK/UhKfouxNTyLPJJUrOx0a23L/BGwYQHUDQN2Q2j8dKPJcWUXU4Dab1uE0MrwIuJrADMT7aE3o/QiLH7PFyjx7r+x1dS5JdsumGfZnhbEZNxA+Mzc+5wwSN2zAaxbsmvhtj9oM3WOiX8LxKhUdHOTxOhnD6tp+askN4uHaiqGlJVujmvXFWQYiYPlWDbkiLcSyC4BUNgZ6NTZ3LiJQvAPnZMPnxF4uN530Uqts+YBzAMBVOYq4KF0MJWNBcgAqWIddQCVllgYeGWVsPiB8CdIlYBSTMobjEOA6DGbTU19EsMukKtEta1tbUlfiYv39YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqk9cAc04WneJ8717MCQhu2Xksog/6PiKyEzJX4zOBg=;
 b=c6m/O5x+FeTOHYsAbbpF/s29E2NpaTvJyaLGGW8GKVyvnHbpcBYZ08ZMO92HApCM/SZk/OP9aYuBCwPGhUhkg6n0+hTVKxL3hdOVPs+Hix7JJE4VdI753TkagFx4aMGbLxf7d0yLHFULD5YqhWCfB0tNS7GLyzM6qE0HPDovLPE=
Received: from BN8PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:60::26)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:46:16 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::71) by BN8PR12CA0013.outlook.office365.com
 (2603:10b6:408:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 20:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:15 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:10 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/19] drm/amd/display: Set PSR level to enable ALPM by
 default
Date: Tue, 10 May 2022 16:45:00 -0400
Message-ID: <20220510204508.506089-12-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afc540cd-8c4c-4caf-c783-08da32c620fc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2514858BB0E7DD97D37013628DC99@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D46v1KseLNdNteSkbURBAk0BaYq8g79MfxecrydwowCMs4MHKzaXvsV/q7zGbksLTuQqdzUAFgQzXH6XqycrwXOQuyIFyhdgURuPc1718d/F9PGHzhph5s+2WFIzDjGSyeooRR5ysYWSDgroc8wdlGc32EpyHu8XuVUaPN7+bIMVAS1cloJ0Rl/OnUy5GUcw6nHAASEXtmlW7CF8ZRpAjx2nJyJ4VV1XgZarfE0MU/CJpYu+1P+lmTs7VP6kbH/oH+iRKbLAnnh/ba4eAruPySxtJAnd+HF2v4fTaVmaN99ferWBSzP+jeUIDa380SIVErxqUhlVt/LWvDgyikebzcmqSgCPmzf7f4JuvWrLyOOXMhGd/e+zmOdd+nKmoLDwVu3DmsJN8Z5uQrcV7pHlh6tuDW2NjGvk19oaFjsHOiYqEq6IuhzB9CtEq/6ydlLaJEWzCNnn3MCr7MmmRq7D+ft6VIXqQ/bJNwvR9iKfQjgeS6bKta8CZ7l/eMq9fErxdolt84g3NVDabHFt+ll0ZPH3/WA0mCODRahgUCvPosCvMowJ2UHWLSZHHoZoOKU7oGxwUItGK8dgwOxabOXY2T19OV3cz1WKJPzmOV785/+XSR1inQpWmxC4N4d3O/cRi0Xzd7cbaT+u3/HPm4EgOBftXrto1JopGZVn5LkrThps/OhMKSck7C5JWDPHpEiMy8keT6GAWWAnP6fOsmrQlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(1076003)(4326008)(426003)(40460700003)(336012)(86362001)(82310400005)(47076005)(186003)(316002)(26005)(5660300002)(8936002)(36756003)(36860700001)(81166007)(2906002)(70206006)(70586007)(54906003)(356005)(7696005)(83380400001)(6916009)(6666004)(8676002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:16.4071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc540cd-8c4c-4caf-c783-08da32c620fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
While support ALPM, do ALPM state transition while PSR entry/exit.
ALPM is needed for PSR-SU feature, and since the function is ready,
we'd enable it by default.

- Add psr level definition to enable/disable ALPM and set ALPM
  powerdone mode.
- Enable ALPM by default

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1ae48fa65e64..259745074ebb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3333,6 +3333,10 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->psr_level.bits.DISABLE_PSR_ENTRY_ABORT = 1;
 
+	/* enable ALPM */
+	psr_context->psr_level.bits.DISABLE_ALPM = 0;
+	psr_context->psr_level.bits.ALPM_DEFAULT_PD_MODE = 1;
+
 	/* Controls additional delay after remote frame capture before
 	 * continuing power down, default = 0
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 144c387010c2..26b62f50ac4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -698,7 +698,9 @@ union dmcu_psr_level {
 		unsigned int SKIP_AUTO_STATE_ADVANCE:1;
 		unsigned int DISABLE_PSR_ENTRY_ABORT:1;
 		unsigned int SKIP_SINGLE_OTG_DISABLE:1;
-		unsigned int RESERVED:22;
+		unsigned int DISABLE_ALPM:1;
+		unsigned int ALPM_DEFAULT_PD_MODE:1;
+		unsigned int RESERVED:20;
 	} bits;
 	unsigned int u32all;
 };
-- 
2.25.1

