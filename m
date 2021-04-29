Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBFBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6E06145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6E06145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D718B6ED83;
	Thu, 29 Apr 2021 07:54:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770048.outbound.protection.outlook.com [40.107.77.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277A36ED84
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIG5vap7DaYjYZspp3KbKPdK9HeVhoOpL0FofKRadDkZ3R0DasyOtwr43hJloVopxHCdTywGxs4+pXSkBlh2a4w3JEaFJjocfd+azSDNit8ZTh1vCAN/oGEG17a3JFL2XMT3QHSV6uM44YfUEjFMAfU2izN5sp6ry6RikvQe4SQcqI9gnLKHdafraOlH8iqLddfF3Y2B6oHxnnXbS8ItyPC5LG7gLJfmxiNH1yJhylEpEhUNdZ2aG7UezoAGNWdCC1RuPSE9g1s2Ojuv+aS1XwZJTK2/igWBur99aqDsnKh618LKKfAlA4wN0GuZI9LzeJs4Q4EmvGY2is8xtiW4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PArxou80ZSJr850vY2RogvpSFg48cVHUawYSxzZ0khw=;
 b=RlKd9NdTVs9kGIb/pWtRYUH9SeTtkf/AoAfflFEzy05qSLofWyT1Zr8icIff49g4jnSw7m+0maeEwC/ZQBo0x7hcaxoi7Kr991sc/Ucv1kYcwd7C9CbFjEJ6+REKbM1TQ0m0qqMAFzG5XNy+hYYrR4pRKKv4AkHg3LbLhCFBJjeXogy/us53/wq6vYJ+bhVpy2pD8TSjqvUxTLsrzR6LDJQXzKBfTivZckFt3OAlOWyQ8O19q9wGSaaTt37djHvLbPcEH1V+xHDgo2h4QOBnA6uk2LCfQdwfsot2g7Ryl3ADWrW+2qEnmRVNmUBoPOL8kPhHFO7oOE8WYm7Ut0LXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PArxou80ZSJr850vY2RogvpSFg48cVHUawYSxzZ0khw=;
 b=OGR1m0uqIld7FYuqkXKrx4fGC1xfamnPCyxJZQdKNcH090B3vWr/oW6qtt4Almpu5dO8fPkvo2wdqK1oBvvLnutGSyhnGUSdxJRSbL9ckp6ffcMwNP0A3TvUzktrUk6F5h7CEtzCsfS60PXXEFJ0CUqjRAYYGQwiQMebOpMriSc=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 07:54:36 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::9f) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:35 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: remove checking sink in
 is_timing_changed
Date: Thu, 29 Apr 2021 15:52:00 +0800
Message-ID: <20210429075206.15974-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac625bd8-ae64-470a-e025-08d90ae40880
X-MS-TrafficTypeDiagnostic: MN2PR12MB3853:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38533FED8C8B089097276C78FC5F9@MN2PR12MB3853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh7Dwv7R88R8lJcEIRnkOS37huxRQa9ZtgLE39aIB/bJlTnJAPhSwgTyru7/5bSBC/zW/l/ISxtQ9oK3BiiaFPpkeJCOC4+tYGsHw4vVLQAyY711/gecTd8V7nh+9yAbtoPkxpoBN+bObjcH6yZfCOncBliryWMQQBg0v6JNG0tGmaCCku/Qww4fsT4KcbRufbHiNC2uCn3vZ4a8OGQgPxAWw869xZqCUVrDyp+pmfz8s9GrS45oSJ4kep3YkSDq7Y7rSX36746QCDTkJOM1RgaeZ37fTCit+9Bqc94amID+HMC92rde0uHxPS+y1QL5/FX3gVbRptwfifiacbVcWU9d5e0Yqfhpg87B3n0fBBSuNuuTA3IOw6A6XAy3ySINH9PcnMjOZ5DsNmHeKXgt7i5wnAOvTDu47ldJ9cyqu/B+Uo5ANgNzu0ufj702qnVjK33ogAEL7CK2jm97r0bDu8eMgMebVIyVwuAXqTW9FfFU6GvQPIU/35SqhXVpJoKOQh4hiyPe5A8fLYiSbVvZNBxIa1oCVk3S5yoMDG9PvrOZ7qPEo60BqMyTTCUmLM5AesdCigUWBq9uwBX9o27SNN9toM+XHyLxadnmtZ1PrP2LxeEh/kgh3VoasP0DKjDvIYklHpVq9lUTpRC/sFsg+a7QKUWGb/GDBQOrhIolGAawTt+QRs+qGRqbcObs22UP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(36860700001)(70206006)(82310400003)(82740400003)(6916009)(478600001)(26005)(81166007)(316002)(8676002)(356005)(86362001)(1076003)(336012)(5660300002)(186003)(8936002)(83380400001)(2616005)(7696005)(2906002)(70586007)(36756003)(426003)(6666004)(4326008)(47076005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:36.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac625bd8-ae64-470a-e025-08d90ae40880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Calvin Hou <Calvin.Hou@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Calvin Hou <Calvin.Hou@amd.com>

[Why]
Sometimes, such as sleep wake, the link->local sink pointer changed,
but the dc_stream_state->sink pointer is not changed. The checking
of timing_changed reports wrong result, lead to link tear down
unexpected wrongly.

[How]
SST compare local sink, MST compare proper remote link.

Signed-off-by: Calvin Hou <Calvin.Hou@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8cb937c046aa..9fb0930f977b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1706,12 +1706,6 @@ static bool is_timing_changed(struct dc_stream_state *cur_stream,
 	if (cur_stream == NULL)
 		return true;
 
-	/* If sink pointer changed, it means this is a hotplug, we should do
-	 * full hw setting.
-	 */
-	if (cur_stream->sink != new_stream->sink)
-		return true;
-
 	/* If output color space is changed, need to reprogram info frames */
 	if (cur_stream->output_color_space != new_stream->output_color_space)
 		return true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
