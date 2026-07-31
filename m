Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66460C55177
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55BC10F3F1;
	Fri, 31 Jul 2026 21:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qeR/e8c";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8B810F402
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrFSy4SRYnU9j8XGw81QwO/rGibhISJ5wbRJ148UBm4CiY2Hi4dkjQsfdEu+rLp6LVVnjOpDYJx+ePO8NfcgMNIej3wK93aZ/FJlIzScTiwwgh9G91CdrVUxWGlR0uoQGRS8WBFYNhOv/0q8Zm/NXdOnBi9eV+SfQxahsk7Bh6CR44m5OvhEX5XUxlxyC3O1lOxhbXrAmYkd8TAS0wgnhwqiLx2LQHTZ1d7yWw+Yp/s9KAIolB0TZlAZcdftWX8lpb2enOudW1QyK2ANhOtlDGGccgztZDelJnI+PouIKlOyVWozKGY7rsOpnFin5j7geIpuFLi/yMbwelLMHgZuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiM1QbqeBRbZu3Oi2Fq/6Ad7hb/kMXiKcnktjB2gs2E=;
 b=LdPBR4R83MUZOALITs55Dlw6ALxH4y+SLsJSXPrevWzLCJjOChFrNFVfcWLxmtcgKtXJmweBZb8/weIeIi+1rEXYmC3ubdKywDWajzR7FJju0fMQLhseY/xBaQoBxtsuQ3nTwuXrdUWqHL0wd7qmfFWm5YRrXQKEim41AP/4JCORcaX6BSjxa6Xd9bEoEWjLr8TnE/ysTc+ftjyp4XXyPWMs1VyNjaey6mLw9YkvM49NW4fvhymVFG3jtmrcsMLV8tk2MMU9sPuoP47G07yvqyRih0SxnyETHxkEFiKHPmL+8Gubv53M/wu37sQgoBe56nXlP9nbkOXXFQMH1xSjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiM1QbqeBRbZu3Oi2Fq/6Ad7hb/kMXiKcnktjB2gs2E=;
 b=0qeR/e8cI27g71tRbMLx54ggf5VcF26LSotDdCcPnuujdxTeSU9wIOMYZYpqHS5m0x1xUruQGny98zVgCOw7QqWBIDrlYLyheXYeiHO3AlbPZ/7jXaiOBYGaQfWv3AopZ4B3LJjHrV02UGHLUXjTJiqws6uQRd1ejCV2tvXJJIc=
Received: from CH0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:610:e7::17)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Fri, 31 Jul
 2026 21:15:40 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::8f) by CH0PR03CA0222.outlook.office365.com
 (2603:10b6:610:e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 14:15:39 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:39 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 11/41] drm/amd/display: Gate HDMI FRL status polling on active
 FRL link rate
Date: Fri, 31 Jul 2026 17:12:32 -0400
Message-ID: <20260731211302.3040343-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: f318c103-76ab-49c1-7a45-08deef48dfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: EYcopNHxnTnYE/6Reib19ZwCklbrdtgo1oWpFJ/7IWu6XdSI/LBbM1b/jiUo0xvCM6sotNapSJ+VwNDsVE1oMxmdY6/89bcmd5AumglMFBtv7d6QYjQyXB2+G8yAhE8euFuSABSoLYIhGrM1wNiQxNkkxKJIvfaAJValbVqlJMJPrtgpP0Tb9FQE6Kxag7Ai37ZqfQ7hrTveDCJJyl4WO9t3OpE0KhCHrcsiZMAD7XwlotRofGDYkB4JmDrYLffKV1zLTHKK5XxDKTHJ4b6vZG9BymqIk6M/EzFsc/pVMB0W+CZ6qJoES2Uj9URd6PCLdgkhZ/AlxOB7uTC6uK44BeZ2f0/Xa7oKdSoj2KTj69pydyy0OtHBQHK2zfWtFOj9XlMF5nQvuu6ZUm5P3xUxGVlpRDHebDzg+PGFy816FmouJATqo8G6NcA83TdmdO4d43IoiO4SNcDyrXgR0lLPhtwSra7DQrMVhcD+pZb/CunqBDkWneIubp8Rhv5IWGPXUod6onuU5O/sCieuDabX+o8YAO9iJDCbMf9TaRWPLulwpliofhc8Q+auubE+V0BklXVarQwHBTtFBWUj6EMUCSz2Xs4msCbm0NawRQ+wUWl/uLUNY2R27Xrp6P2hsj5+VbiCP2CIAzev4ViXoTubfgA1Op5Wzn6fHE2P+xdM5eo9nFVKEqxJ0h7o6CQU0IGWLYjIwf8nakkm1mqZd22R2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v0jsAzmA2WZk2gQVmesDOq49Y5uDMtqJxi8gQQrXP+SGWMHmX1szyOU5qIOnUXItIRCtyZNDeb0cL+Q7BQSK9Nj1CtCBjpFhl8YaG5QNwe/owyUOJHvEfdrjDTYD34KV6oPV8hdJ5wfHD9iZSt5O0jiryhO9KtW7MVtcaShUtbaQgHJjXWJnw8OJmpNU23BQUeUSwk7hW/BTDvjZYCq2xx3WJvqcUPLr/J83LEvTr/y73uOjw3L1sbt/gE2CncJ25fQ945hTqPywzR4V/MjgVVAxEK3+VCcADcRQSF9chNFvKnXZQPzzWwpcAupVn7BXHxfGhtBwfrVnMslMsB4XpPi5Ndk0sAUWMfSjqplIYzWlbAt5lXGjavgcDLXV9hEd9I1hu8er/oVXDv2+brbcZEmNLeJtGgIlOL7XkbUjSq95IjM12HyxaOVBMTTt9gIF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:40.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f318c103-76ab-49c1-7a45-08deef48dfd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why]
hdmi_frl_status_polling_work() skipped any link whose connector_signal
was not SIGNAL_TYPE_HDMI_FRL. connector_signal is not reliably set to
SIGNAL_TYPE_HDMI_FRL while a link is actually running FRL, so links that
were operating in FRL mode were skipped and their status flags never got
polled, missing link-retrain events.

[How]
Use frl_link_settings.frl_link_rate to decide whether a link is running
FRL. A non-zero rate means FRL is active, so only links with a zero rate
are skipped. This ensures every link actually operating in FRL mode is
polled for status changes.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index a8f089d4fb72..e637db2723c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3009,7 +3009,7 @@ static void hdmi_frl_status_polling_work(struct work_struct *work)
 		if (!dc_is_hdmi_signal(dc_link->connector_signal))
 			continue;
 
-		if (dc_link->connector_signal != SIGNAL_TYPE_HDMI_FRL)
+		if (dc_link->frl_link_settings.frl_link_rate == 0)
 			continue;
 
 		link_update = dc_link_frl_poll_status_flag(dc_link);
-- 
2.34.1

