Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCFDCD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D183C112E86;
	Wed,  3 Apr 2024 19:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QLjxSyyl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A715112E86
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djOuFD/aRR6vK616m3Ip5dH7c+dq5zq5DODPBWvjCq10eEvjm6aBWL8rhQHo7KYwaTDTku47XSeEzA183yHY4f45T22SRMX5Skp50a8UVSITbV4L7JGnSDfUTXY+4zM+tcHoD7S0hHPYxR5VHTmUWVgVgF/3HOBNfP+1DxdXwuB8gA856ockPRAaCsRgY2SB8OoLtte91V+uf4NuVeEVXCx2U6NTrM9+Gbh2DjHhj/zrr5ZFjXo2eXTAZ9stYBVI2iw3aXsqY2gmO7Ewk46mFi+mKW5eWb9yLFYTVSwcPTsbmUvmbor1ytq3WIrv+cTEx2gf5Su2sKaN2WSA/ENfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8TblJOqsHrr1k2nBD6eCeeO3qf1mjWw8uv6dEjZKdc=;
 b=RlvrlYBybAFrPxI4nOH80kjHqNQ0nXF6Sbih/w/uAORYCI/tO9qElFLNO8TGQM8PYTw1bgYGAVJtAkOwTyCO8ju4zyYr/LbO6GM3LpHu14n/IL6V6uM4Es+OTcmG0373dDD1yX1wfF53C+GlWawtJ/3O7wTdqeCY0RplDoWOFCXXp2S2hQE9cKBGvjwtFSFYG0ljwnYBKovzSDEwOQeD4VlaCIMmwt1mbsC946lEOx/wBhXZJ5cQb9W9P2o0rXPSNBOALltosKv0oh8GedA60sMuJELcT2t+HgFDvMwm+SwwbBqoc4yhbXbJiKwA4p+fm9Yy5v79wXNItUWiakN5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8TblJOqsHrr1k2nBD6eCeeO3qf1mjWw8uv6dEjZKdc=;
 b=QLjxSyyl5ytE+Hl8vHM978iNK4sAt7wWRcWUHxt+IR7Rqj6eVw3iEhhLFdRiGGiUBxxuR77cGB+kLWR10uo9TG51jbavrbKG9/9bX3HUaabHMQPFDRxA+Pyr5OLMK8mKPza+D8BrsDRfq+PyYtctZowK0RtJU9vfbQa+xq2fJXI=
Received: from CH2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:610:50::30)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:52:01 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::9c) by CH2PR16CA0020.outlook.office365.com
 (2603:10b6:610:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:55 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:54 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 28/28] drm/amd/display: 3.2.280
Date: Wed, 3 Apr 2024 15:49:18 -0400
Message-ID: <20240403195116.25221-29-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f79a60-4558-4ec9-33f3-08dc5417843d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HQPQD6gsVnZaM0LR6jL8SWBwNwXT7aCT1zUWgJyT6o7O8zAh5Cg8VRdNdFbOGOGrfn974SiJftqpXhLrPqOmE81pk6I/xheI47GsOHJOsiyXwZW7UFwBVSic+JV9hlVjCvlFDghA5neXiXm08LPHf642oonvHikIz/Jx3Ez6dnhBAwqzitkVMPDQ4QfIfLCxwzKFcLRQkFIfetCez8ZxbZww2bLimLxBDZNsyF6xRQ/NE3kP8bLRroKaRuWWKrYyUoB5eW419KN06iVefSv6caj06CsOEz3/SMVy194CS235iNg5pb99JvEdKysdBCXqJTs41HgKA+NdZwnbck0oSronBE20bh994hn2kf6uDsIdlnFkCbRk4GD7JzeIyGRjIPBclRdSATL9Xez6dH4f0aIbLPQuRaiigfoZtaar+NGtBIChG2NVC32FbtoWNR4B1x55oaFPq7Ef6RF+P8t8D/KzXqJw/dUygL7g3utav1NnQGnWZ0OZOEHhPo1T54CvkjyJ+5997WlhTL9j9l2iyv5bCMuBn/BI45yjx6iU3vPqidNoEK7RfNUV/psKURPAIaOFUJFxFtGIVmW7yXRBwdzosS1KNTtUY+pkMHOz1jNbDy9XHMp+jehw0YJ5iG5WnOxy0te8CR2QB2rNXNN26uVSxGtx7/kFs+4Kl7naOeh6r2B0LKlOMr4a5sBtDZXohkIdpAPBD6PaSyGxMM3hYyGrbEV19pi2QbvwykANhfenMjJ1pPy/SiWskBxG1If
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:55.8727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f79a60-4558-4ec9-33f3-08dc5417843d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- DCN10 fixes
- DCN316 fixes
- DML2 fixes
- DWB fixes
- Expanded FAMS support
- Misc code style fixes
- ODM fixes
- VSC SDP fixes

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 54534df73e83..db64b0061d70 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.279"
+#define DC_VER "3.2.280"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.44.0

