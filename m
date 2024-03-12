Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4131FC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A405911218D;
	Tue, 12 Mar 2024 09:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="crZk6hQK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B22D112399
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTdm0xaUJMyerg8qKseXkOFTYEF4rOJ6IQqrVSL7YKcXFgaEbw2pA6lsKmNOZ3qmMkjYGYNXF8UZ1DD4gvjWzSXsyuvyXqgANx08UkEsrmQFLHl0kLJaDJwN9bhEzFMbH23WQgGX1sP5bZGsk4i4X/p0HflL8u8bPhjppzPNnWhjBFXsuG7rzqV9IHZSQtveClTPGFTAy9L86iWoAlu89YnwLZuI/4/j13AiazUbV35EVZC9CYZcT7k36Cz0tlfbgBlnKtkbG88sbrLHIR+ARP64B24JF50CBq0IWQEwuLmjUdjnv//lBgtSGjrRkTM38qdExrlEICCLlaMp7L7KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPl4OwFjdIlN1lso3DuBce4sNuOC8AAbSsCSGbcMLO0=;
 b=iW3AX3equs9wxQlQTUYXFIqMaYMlTDgC/EkcLoJAsGdIOSVp8rD+yme+eUV9qhsMdIfgJ4U+JcFDmsCB2IRRvdOYTv7DDXX6dSuUO9Mr53sl8ke8pmpsYZpDDVLEjxvYPSE6aYLAK9vteoOXZvUlhdiMzqNTnikGH+cVp5gaHjQ7NVzay69tNW7r0jXEYy5qXyD47wFsDsctKS3Dqzabb+xOGu7iKYinZiCTWyhme8+OIfxpBcde5BPgBpeTtNADldV1PArpPLs27D5mSAjyRW5aUwpvAYUcElesEP/UUTodRbfMGV8UB3xm6SKP1M6lQr8m3v1jkCoxX5HSpeBibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPl4OwFjdIlN1lso3DuBce4sNuOC8AAbSsCSGbcMLO0=;
 b=crZk6hQK5839DY1LByjxQStm5H7qJxEPdsxNxHomJjZaRwNyULKrDX1KmIP98yvhIddBMFf3GOw5fPuoKGvOXmeCH3PIM3sQ3NByFVDe5DHm2OWqCismF8xk+yRy24atTLxan20awPlJEGBTb/6hFrReeabqFtxIjJM4kW+sRiU=
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:21:03 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::a7) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:02 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:20:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 01/43] drm/amd/display: Remove code duplication
Date: Tue, 12 Mar 2024 17:19:54 +0800
Message-ID: <20240312092036.3283319-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d2afd9-fd85-4410-e3ed-08dc4275bd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aazfEXGQzk5Wa1NG/t6UJQULMPl9Z41ZvNyWbi9piV3tT6TbfihNN3k6phhKv5qMN/QKHFpofm5dmfFyizQB4o9mMM08Pbf9cVJ8Dti1a0IzWsJ0txvkqq0bemsgi/K38QecJxSk7K3G6mBmh9+qmdJO/IABr/gSsnWgR1nhBoRJ6Sjp9TFPhbfc4YT7ZHt/pTvzt8vC/CDYLUU+R96ND9oEl/G+WT9gkPmvKdOrSH6jG2GvWqz3rDzaxqTbF/nhwxfcde3HrYw4ffbL9yvuxWaLTC1I0qsmu9bnMQaEiCn/Vq6ydMUL0ZxLUes9kfm2nMrH77O1IpmG7BCYOdg3GWbx9MGPxA3i9MjDr7BTL35mCs1M76SR9njE9MqAYIg/cpjBj6OweHt3fZNkx9KWawp0NO3PGapXWG2nl8Ob9hnEgveqEK/4ptQqpHhV9EtcxeuMs23wh+pzs+u8spFVK21rbn8TJFRY57MlFOjDYKyhhe0d4rJDdkZVUZYyON3Xzk6sMUpmJIlHo5/GVTcWxFInZQBdvVcoQS1ZKMNBULQEIsulWTs9GTI2NhDws//gYPDImkO5aOSVbF15Tg6GuXCGh/5ALYDue5dUtVTgJ7zxUNPIpM/wR8NbBAbGCF41wNb4dJ603LUfE+uKQQarD0xASvQKmX/2JbAAfpngVzim+V/pQaGn/tzgQlxEYVmh8tGmLXPz4Bay8dAJnJaggkBsduuHaR4/mY0UfcWAmmTEnUIE6nnUfmxoH6NGEYLF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:03.3531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d2afd9-fd85-4410-e3ed-08dc4275bd58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
Remove redundant code

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 738ee763f24a..bb9f39bf5b5b 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -539,8 +539,6 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 			mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
 		break;
 	case FREESYNC_TYPE_PCON_IN_WHITELIST:
-		mod_build_adaptive_sync_infopacket_v1(info_packet);
-		break;
 	case ADAPTIVE_SYNC_TYPE_EDP:
 		mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
-- 
2.37.3

