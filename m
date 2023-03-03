Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ECFC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BFC10E6E6;
	Fri,  3 Mar 2023 15:52:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30ED210E6E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byg2T/hYPr+ZWUH7NZIXxhTibuADVoc+uhXqJ0zm/pmGM0g9hvVSxSyVxI3ssYrloGPHdbimrjuVxbHeuIw7nTaf/q9ncrAnGm1GvEnDPYks3pghRSy/9ATQeGywa+PONR3knT7ofRaKPf4si887CFAxDvAcMD6lrmgi9EGxD6QnXTf3DSPvLB88ZQ6a6FscSoN/xPCj3NzjiZ4qwy+91G4gNeErpqYJgVan20X6i/MmhmUOTkg6ocjMW6sd4ygdQTKzviO5H40KGtON7cMycdVpQ14EiQyslKl1vNQWk6Bc9MQsySamd5mB5Tw28VzfL/+MRNo2ugAt1I39WUSy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4XFx0H5Kz7nNIUZEY1540JJKqtEU02ZizR22cdNXww=;
 b=DN4re/gNG0T5+ZMliW869rx25O0NbyNBL+JhJjZ0koTCnaeCmssne1QZqlIwUj86ZmKaodKDelgZtvif83Be8a4Mzi9Tb+4hl2fp96qqduS7BQlCoiMeX12wYAYKgDv7vIlds+OoJ1J2ugDHb+JJS7+bwgYsjq4iQpp6a3cZLD5xOoQUkNhQQ1em1qjljaZpqxV26AN71BXyG74nimWH8EvoN6/eP+WiZV6Rr/FoFyDLF2umyvciY5q+RVN1NnLTR7nTTouh+taaqxvsIhvcgzAzq9sSPBMYXyTvOFgDj0a4k+DHLfGv3BgxdNH/uHZxdv0U35w0ZBuIPn6jtPZEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4XFx0H5Kz7nNIUZEY1540JJKqtEU02ZizR22cdNXww=;
 b=FGtYO7PIb0FMToY90uD+2WOwIk0vbBMcnSZ7yMQ1vuqXco/dLYr9G9K8acnwXmDEt7d/mUhlKXc6EUA5TI5CwPhqtJBTPa9Wh3dFUunYe4t/GZSBofY/wu/GV1EamOB5p/6h2XgrEhST1JZgJXnoHeRUqHjst6/bo/h/xnLQtE4=
Received: from DS7PR03CA0051.namprd03.prod.outlook.com (2603:10b6:5:3b5::26)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:52:34 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::36) by DS7PR03CA0051.outlook.office365.com
 (2603:10b6:5:3b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:52:34 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:52:23 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/33] drm/amd/display: 3.2.226
Date: Fri, 3 Mar 2023 10:40:22 -0500
Message-ID: <20230303154022.2667-34-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 482cdb86-7e2b-4b21-bb32-08db1bff4e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+vtCCpLuPuyOaoyVs5F46ErfMSJvYOWQAV81i+2DUGBsPeLfX0ZKhxoCTxu4joFHbJBL9/4NhvneczaMypcsHb2i1hXP+IjqlIMnDraNTzpOzDH0bpjXur47jka3VXXOOXcAk5tm+zDtmEPIhf8SSagoyK7uqpgLUWHMF7zdmXeCKCmnzObpc6xInqX7uSZLLjCj70x25ihnJ+tRcf42oqV+LKC6aoarS5AhZkQBLKTYWkYzgX4DZ7LC0Rn2nCsStA7QsCh8eBtEhCifMB55ysZtVrEW0SGhdjcjGDp8BaP+HTREcJHzq47VxYH3PtiMJb81o8S+DyjdEQcoXMr7vbR4FOnksh3kUp6kTyiTinanlvoOlhU8VmrmYmErigYaA1mcegF7AeWomT83BiIvJYJcGb1Mpt1DuV52kz5tYL3UpaAewYtJ2JWYamgjC1IwpDEIE4cJbZyXvmoRWqSvWirMj7FZ6KsIFWOoh35AaKk+D4hmOB2Rv/WFa5TP5oWwb4CKxREpNYmO3xE0UfLiX+zVFj8O7lNKAH88/W3MjFDTxSGva33lrk60OAzgAnUVlnrHIeO5yV+6iwjCx7dbD5kqKMH8g2GIw7XvyEYq4qqIkSX0XydYgbxz+9rUWfFKTisj8agQyZPTMBfwxorXbC88GyO9oOOzFNEhqDUMFqrDKADadTLaOpAuBkNIjBekmE9b0pvMHkyo8OzEZ4byQxLmrVo24gur8hoAX9a3HU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(356005)(478600001)(54906003)(82310400005)(2906002)(4326008)(6916009)(70206006)(70586007)(36756003)(8676002)(40480700001)(316002)(41300700001)(83380400001)(16526019)(186003)(86362001)(44832011)(82740400003)(81166007)(36860700001)(26005)(1076003)(47076005)(336012)(40460700003)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:52:34.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482cdb86-7e2b-4b21-bb32-08db1bff4e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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

In this new version there are two major changes:

1) Transitioning to the new DC commit sequence

There is an extended effort to migrate to the new DC commit sequence
that better adheres to the DCN hardware constraints. Most of the code
was upstreamed already but not connected to amdgpu_dm, and in this new
DC version, our DM finally started to use it for all ASICs. This should
improve stability and enable us to improve how pipe split works.

2) Drop old CONFIG_DRM_AMD_DC_DCN in favor of new CONFIG_DRM_AMD_DC_FP

For historical reasons, we created CONFIG_DRM_AMD_DC_DCN to isolate
FPU-related code to only be used for DCN. Over the years, we lost
control over this guard, and it was spread in multiple areas. In this
new DC version, there is an effort to remove all unnecessary
CONFIG_DRM_AMD_DC_DCN and replace the others for CONFIG_DRM_AMD_DC_FP,
which better describes which type of code this guard is intended for.

Finally, this version brings along the following:
- Enable HostVM based on rIOMMU active
- Keep PHY active for dp confi
- Improves Z8
- Update clock table
- Code and directives clean up

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b51dfe0f507c..f0a1934ebf8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.225"
+#define DC_VER "3.2.226"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

