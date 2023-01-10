Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C9C61DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B36810E616;
	Tue, 10 Jan 2023 16:58:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C5110E615
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVJVunxDWFl/A1EER+vlXGyB+cAOZj8E2Ryw6eIdbofxABkFq4bidQpeMqv7VDmfT7RfDYGZOrUBDuzHLfpWq521nGtEHB+3EA+alrdAqyQx6pgMrbhWl7G6GxadJoEDP+dITOZqpbTs7ktdXoWubjR1F3iYqvkPoJPJoppUGYfv9HD+kcwCo80Ee4pCx53kZjjw3tPZTNYe1xY+tLgg4+DeG99hpX10homvX4NgJxD4zV1uY23seXLxkza6PVRkz0h1nbNqjf0Ik8YRWfuYc1OMXCnj3YpPAuQ8jyIaN+O44BbQFh0haVMu33fe5RuoqWBoLGn875+TaSc/0OJAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZzYxaJO/QSncSYs1riN/Med5mGj9ZIEZwZjgnsmTqE=;
 b=P2WsL+xziaYOMtA+WPnR0vKQNTVuJ90ufj5rJakwDD20Hsb3Jl3U2ySuvEoJSOUNSprFVXPqmovVgWrsN+0+FSluRjMvdujb9UYConoZ906Mwfi+2FcNoA6AXAJF01gNDDEOdVmrqafwaYZLbRy2/qF/4J4QbnWAifJPf2pr5afIVICRir7+zCvK0dplSkHxn8f6WIypfWg9qFc5wdQhqt+N2kCy2mWBmrlYhWDJbNEBdR/AGq5bfkkuy+Jk7JBOBhRNXduLEo7cgrV36XhEYT0vbhvKL/tXSr329OSLwvVbdR00Px9/rf6Ob05mnwnPc0xuzT0HKBNRf3wj4IY2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZzYxaJO/QSncSYs1riN/Med5mGj9ZIEZwZjgnsmTqE=;
 b=cFNUatY1rxXZ8ECO5Nusqhfp8BVAdnaL7udkHdteBtp+dQy7ntGUZOivH00bQq1cM8FN08E5VZ2Ezt4fZ9NLvZ6Yp+mFuEyH+vm6/4cfqfqnTTWEVAkVfD/so+zBUc5trJgWSVX3TYGDm9zhiPzuGcSVBP1/2a87YLzwhQGuK90=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:21 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::44) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:21 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:55 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/37] drm/amd/display: Remove SubVp support if src/dst rect
 does not equal stream timing
Date: Tue, 10 Jan 2023 11:55:16 -0500
Message-ID: <20230110165535.3358492-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b73c639-0fdc-4e93-2f5b-08daf32be142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZeMJutCaoWlc9obkPjHuUcx14I28NVyKwAT5Bkl52EKMo7uS1jVfvEzggIBBDl1GWgFlaQ1ghVFUI024HeOFLyR9ch81iDjyX4YwINl+0UOrGVdtLTgS2sjf7RZaKB0k9dq3IcXQpdM0lpGvgYi+D36DhXVIWqu7Geb95rhOlZGtE3t3VFe1jfmS+c88ExoOAwRjDEv6UzRhutoyCaen8JXHiLklhYUtocGBNq15vRxPzGBPACRA6aOyeqYIlcnOrkeDXdpkA/iXLqLTuqBCnnzsMLO0yoq0p7HQIMqHdALLwsQHTZa9xlNVnTxGiBhh2qUARpvQutWDdA21VVN7W1XEPBxl/TCXryVp2lVM1SQz7XKcLZQ8Xo8GDQeNYPSzZV8Ae1TUYfUrqUvYxFrHQxM6y+06SJ4V6kienRJZTzma7x9wQSxuDjsemg6ewcye3ze84gvVbvl+2VJdO5m2HMap/KAMajkG/Y4oke43SQ+sgcBNBvvao505BKUzONuY+/rkVQvWMhdiOfimX2qAI1nGqIY/ipGHU1p6Uksu051wOFx1RKVFx/GoU9MkXA1wKJRO+muq20n0xJt2eoFik2sQ/V/1VO9QrcYE9kJLTEUeoTx6HaVNeU6bjKPIzAmM23CuXxnbj/skrF0SSDsIC+hoH/T/8G9E9NEnlg0iP3rDT72kS+X5zMTF8P9dpBiSsAnDi315klEYrPCHHdQgbfN8R+5Kx6zQGdlUfs7vKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(6666004)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:21.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b73c639-0fdc-4e93-2f5b-08daf32be142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Saaem Rizvi <SyedSaaem.Rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>

Current implementation of SubVP does not support cases where stream
timing matched neither the destination rect nor the source rect.

Will need to further debug to see how we can support these cases.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 50f20549c951..0fc79d75ce76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -240,6 +240,14 @@ bool dcn32_is_center_timing(struct pipe_ctx *pipe)
 			is_center_timing = true;
 		}
 	}
+
+	if (pipe->plane_state) {
+		if (pipe->stream->timing.v_addressable != pipe->plane_state->dst_rect.height &&
+				pipe->stream->timing.v_addressable != pipe->plane_state->src_rect.height) {
+			is_center_timing = true;
+		}
+	}
+
 	return is_center_timing;
 }
 
-- 
2.39.0

