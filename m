Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4C8C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2381C10E447;
	Wed,  7 Feb 2024 20:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CDQEG0y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBAD10E447
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEf33s4OqtZax3PO0iCExBk94N81uWtAckdwR6CNY249ZKBdyr8/0kBH/jORBtQ619BleH8uthAshGed1xJR4fSybF/rn3IsBUHq3uBZBawBGisdafTvnhYJT8Uu1gwx9iS5vjkvqZ5M3pbx549W31kJ8tjpDivNiH8RiC0KII0mufHrf5yT5oYkQvnhAGxGFTl+srtABVOiVn2pUd4xfpGwwwv3zRiFS6uLWHaQmDkjRj8DZVAAdU3ukPI7ifcoJCaWrZwCshyNZp2oUX2Hq37h6x/bAgZYav1BVECtjZ5bXmZeyVMF/1V/vzXzj1HWw2ZEpyQFLjxUt1H4G2ewkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30gbeuWFZAZA/pzhhp+XW/SZtmVzMYffFho/aj7vTpo=;
 b=RRHYxYIX2EhI1tGD9/E0J53KS91O27hRkJJxj8IaOv8DrD1C4xAfwrHjO4cdhDDEcyl2RUnwl5Z4MUmUSXpjezfGUHfxvCLlSEmrBzSwcLLsxP3wPC8Jr9ySCC384u4mofBimbMk5qQefZ1ZfH8F74uyEpE0QOCJDhMyGthyPrTAbcr5sj4D1NXxB/YTuGu9tG1vIrS1MUPaw9IJaXZ00Dfh8haqDhg9p6zsGx2hmrimlm/TgKPrnT9VAGRsgCmoJt3cJF4WMjRVSqcFRymEosugDJz5+ihwqgsXT025FN821/4/qh48bqeJiPOrBE15mr6X+EPeHMR251y4Ke7v6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30gbeuWFZAZA/pzhhp+XW/SZtmVzMYffFho/aj7vTpo=;
 b=2CDQEG0ykEHFWoYX9ii8cLz/YG9JEFg5zfWpUB50gZLQG+GaioRgnW792Mgu1WePQVxaF+H3mQ8RgHoVyRugdGI0Hx4NcdSTzCH9gElQbWwqWOMmIDtBDV+zrhBwpwlo+KC8I+GDvnCH5EvyKBFQpGxLGCPFNdv3gzWMVXx8mZc=
Received: from DM6PR18CA0025.namprd18.prod.outlook.com (2603:10b6:5:15b::38)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 20:52:17 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::2f) by DM6PR18CA0025.outlook.office365.com
 (2603:10b6:5:15b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:16 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:16 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Martin Tsai
 <martin.tsai@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 12/15] drm/amd/display: should support dmub hw lock on Replay
Date: Wed, 7 Feb 2024 15:50:47 -0500
Message-ID: <20240207205200.1608684-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 79145bc6-17d9-4066-43c0-08dc281eabb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bf4Yax4pbjlW1T+w+OC6Xr93ggHJO3ZCiD0f8KrECobO/M8YdtR+O7orzyUkfzhH0LRgL4Mc8qbYEU+OE0bPcMwzAX1WNbarBUJvDU6JiZpe7c4dXbJfrUYalg+gOWSiPtg4VvzRGUUF5CqI/t84XJAMNWH0CunAYrhm5wrwUNqatBsQfpa8Llva7JWdo7wciNh7w8HvSdFFYx4WHCF6NnWBlGC/tZNtGmLg6Bj3xheIQhsjlXPvJ2zlJIAgBF0W6LsYtRKg3I7VlZj+gpTeXmKzIrn6OBz1Vx9QvTmEzrNF6DHhuGMbNMkHvGEIY4LTjrSI+eOTFMZibZaNmyuy3Dj4pKPNRu39Gl8/4S+kehfF3nvQZ+vRq3lVcEDrcNahxgQqSdVveRr2+a3Udc71ZqQB4XJM8GNuD72kQeoUmOsfHQ9j++hdirS0dk6B3eVaPP9N6n2qbRZNfYu1vJvAKvBGHCu9NZ6v3U/nOI9x7pVDNeq2VUSbNBr4jiBLMaAXqYLVmYfvjUD6rkKaZfy57Fy3PIxhDWnHUNOQlQuYGYhiO+YQ9OMPFCcr8FrJG9mCHuDUSvcnRFbByBDSQSbkSBqvqm5DY42iM9DFS09+ZdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(44832011)(8676002)(5660300002)(54906003)(70206006)(316002)(6916009)(4326008)(8936002)(2906002)(70586007)(41300700001)(36756003)(336012)(1076003)(6666004)(26005)(7696005)(2616005)(83380400001)(82740400003)(81166007)(356005)(86362001)(426003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:17.1918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79145bc6-17d9-4066-43c0-08dc281eabb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Without acquiring DMCUB hw lock, a race condition is caused with
Panel Replay feature, which will trigger a hang. Indicate that a
lock is necessary to prevent this when replay feature is enabled.

[How]
To allow dmub hw lock on Replay.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index ba1fec3016d5..bf636b28e3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -65,5 +65,9 @@ bool should_use_dmub_lock(struct dc_link *link)
 {
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
+
+	if (link->replay_settings.replay_feature_enabled)
+		return true;
+
 	return false;
 }
-- 
2.43.0

