Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10EA6126A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B10EA6126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC5F6EB38;
	Tue,  5 Oct 2021 07:53:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFCF6EB38
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwensMZh62BPd/kQTg5X3dRVgep+d+R19hrez27nqrni8A700CpjE1w/XPogospaiDaD8CxX4dqOzXwEYYOWUescmwkEbF0FGoUfWQDiKNcD7T8JLeRD+iFMBFEq9NSuNPWtGMOCTMRMPZEhhOJzPtELm1Hz3yS89YXx7V9A6BA9ADGhYxu7FVdlCKiLFBEadR/d4DUQCamNRsubumHurlcpO1ypntI0p6Xy0AaBTFe9t0oB3/royB+deOpcZLfieeLH7ZtPGxS9vqYurGVl6vObgiFduJHJm0TlnXUgRuARXoQ1s7CcWrZ7YnJsHslAnA3Ek/mUYXzH/iul8O0TZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1svnd2+ZSEzyKrJiUueTfGWsZQhTcP3g26WMMBK+6PM=;
 b=VTjIdHKuwRs3Pgw3eD8HHnqIPwQi913OtEbDXafw9F4lXo01Mg4Z3akJNDe4cxNw8zuxM2V+NlGdgvxMf385yQDZpOs31W9iKA7AmR5Xe5MPj0o9mMLwzBD45ImAr2Hl+1mUk1jIkYkVw2zvvJ2GBWrN0qNYtHKrYaoF3kQujfuaixoFIjJzTVurFmSBVo6b1NQQp8w1N4G3UJLOA8PGUXjRfD4/BAbzPuqQzSZch949Y65ckHQ8GcAP0mllFUnqWFQ3q/6hgsrfnxzEMINIYH2K/LcisRxp795EBByQXA9KL/5nXII90XzFG1QbYV+uAzZsWLxX7Hsvh6eUE9o8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1svnd2+ZSEzyKrJiUueTfGWsZQhTcP3g26WMMBK+6PM=;
 b=1D7WBnOTpxhhgEVQzNUDNpO+PcoAawD9DgIVDbmoO3HCOhoD/5UjKXM0H4+uGe1rUojPdztO0flG0pr3lp/7X1u/9Zy5u7TR0wwuZubvGolRWbYT4CDndC7e0/fCjbwXbK4ivVzhs2FluvLnYLeyK3Rlulq5gMH4K229haKnz+g=
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Tue, 5 Oct 2021 07:53:21 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::c1) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 07:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:53:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:53:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:53:19 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:53:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 04/23] drm/amd/display: Support USB4 dynamic link encoder
 selection.
Date: Tue, 5 Oct 2021 15:51:46 +0800
Message-ID: <20211005075205.3467938-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a44eb46-d740-4af3-faec-08d987d533a7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5463:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5463EB2A3497DC1DAEC042F7FCAF9@DM8PR12MB5463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:179;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yud7uphrV+R6YeFzJkxUskh1FPg2rtrwSy45v4B+ISwlVLZSa2LYv+Bohf5DkTWMisS23AxSnTUPUVq2+43m43fyAIxVqlYisZOFWOTBOJRSD9lsrl42eb/B9B0dZ10kiID/Zk82wHYZlGo/ppOFKLFpXHwDgsSw+E9OUqG3mHd44ozrO5sCAr1NewzH7dRUin+ya6euI7c6YalGUXB6PeZWec2dNStVJCPRDf8t+iNFyL2rDY1xJDWue3wLRziK41fEntyzqB4Mp5nY7oebDnsaxnfxYR7YeU/2x4vqTwU8RlO72ckHwADo9JZXswszt3IKAw6s3icrnhAeNiI71dy/dhJY118u4rDy6dQAsUDlRnWbIGR98QWA7aTUlEEwKcMwE14su+wSRlaqN0pLpwU2efsyv3f1PFxo/iKre311zudtp1BBAgtKy92R7Zs4DPbIGu/2h247iI4kF21tAOVfV9GpWCTY3BIUNSb1V3qT6aWSmTliHFmiXDiyMxAorWq4fVdq74K48ykNYLXkPaKpBXLFfHUi6nOVozkArTc4B6LzjcOQ2KbxDk6IQ2MrvgRktNFiTzPY7fx46jBTzf0nKkbzxfkgCU+qV5xM0ms1Ohv7VvEo800zBOACBgavsiL805+nHZjzACkP4qPn9gklOq+sQZ8d5mFr304pgawGVpsdC+v8cT7eB1i97Iw5LDQzToacaeYWxXdijPrHzuh/qwvJbm0mkldGna3pFeY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(426003)(508600001)(5660300002)(86362001)(82310400003)(81166007)(36756003)(8936002)(1076003)(26005)(70586007)(70206006)(7696005)(2906002)(316002)(2616005)(6916009)(36860700001)(356005)(6666004)(47076005)(54906003)(8676002)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:53:21.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a44eb46-d740-4af3-faec-08d987d533a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[why & how]
Add codes for commit "f42ef862fb1f drm/amd/display: Add dynamic
link encoder selection" to support USB4 DP tunneling feature.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 20b4819b73e4..66182b8c217b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1732,6 +1732,8 @@ static bool dc_link_construct_dpia(struct dc_link *link,
 		  init_params->connector_index,
 		  link->connector_signal);
 
+	link->ep_type = DISPLAY_ENDPOINT_USB4_DPIA;
+
 	/* TODO: Initialize link : funcs->link_init */
 
 	ddc_service_init_data.ctx = link->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 3c109c805447..15c353c389d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -955,6 +955,7 @@ enum dc_psr_version {
 /* Possible values of display_endpoint_id.endpoint */
 enum display_endpoint_type {
 	DISPLAY_ENDPOINT_PHY = 0, /* Physical connector. */
+	DISPLAY_ENDPOINT_USB4_DPIA, /* USB4 DisplayPort tunnel. */
 	DISPLAY_ENDPOINT_UNKNOWN = -1
 };
 
-- 
2.25.1

