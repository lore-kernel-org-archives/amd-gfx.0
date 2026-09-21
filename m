Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B64C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A4610E597;
	Mon, 21 Sep 2026 07:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYlVb0W0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFB510E597
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ06tqj3Fofzuz/P92Vz3FTnZAHXpFYkuqjkQUOvOIVRxCvfC4yDg33y/yImZI6w2QUZAGVP/17d97/QwKoyFLIlc6zPlWHoJBhu0pTJbTGrA1gKJbnEmaff8NsK2JPs4ekbIbmIKNaxfbWkvvCO33QfaKkX6b+s5yxZ+v86rbM/Vj4OT5rWyKjm1pxc5iZ8EKF5pttE4xoFUhs2fPnVvaB5Dj09V98Z7dNkOP8NozKzVeY8ruYTXAo1WL1yywjwZ8XRPJuoAp+0ua9WekfUczC5XkLxveza/jfBR/cfK6Ds20y7ZjIhZKuQ8ld7ksMo/5gC7roBfhfYeehHdkrz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD1yIU3rQ+UDgu3tw8iwovT0EJI3LHKycPHPPaZWpXs=;
 b=KHu2mkPUML3NpNWuGrxHHJDhu7YP87c9hsntwsJMOD9eNkHD2RV4bdlprBSUYM+O3Bp0ydgojAcIk1Hjqy5MHw6+YjcfwVAeV4h1YrvBL0A9raOzU4y2c85D7nixUdGd8Z/WQxKDKGuLC8BbFZN7N55MAe3ehw6tpExM591En/gq2swQuTH+o2xS4oSATFre++AUAKd1P4+L/qiu8QbpO5gDs7rxYsgUcUUW/m+yZE7qcbUxSiWSYpBH51TPyI804U0lZL3Rd/9VsCjKZE+Tdza7ggd1YvDKCmbsEpgVx3PtfxlK71agifKAEVipFN7/nnc5Uk7JuRgvLmgRhbykjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD1yIU3rQ+UDgu3tw8iwovT0EJI3LHKycPHPPaZWpXs=;
 b=RYlVb0W0flOY3BJ6l9RWN1FbLIQSVDtvLBbzpusEEaVOgplLqb341cIUeWTb9SRqaqg5s2z5bkOefXgTXvnP5PLod8//+RWNBXCAidoi0yy867naNT9leJPhTHO1GNtFmngPxGRZqR04HNNKJIx8mjD+V5Evug+z7s0PNPlXaaQ=
Received: from BL1PR13CA0155.namprd13.prod.outlook.com (2603:10b6:208:2bd::10)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:20 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a1) by BL1PR13CA0155.outlook.office365.com
 (2603:10b6:208:2bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 21 Sep 2026 07:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:15 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:54:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 21/21] drm/amdgpu/gfx12: defer gfx pipe reset enablement
Date: Mon, 21 Sep 2026 15:51:28 +0800
Message-ID: <20260921075326.2409021-21-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ee80d2-3f86-4a33-07c8-08df17b58ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: NCJmacSoH8EFzijxbwQEcPilNA7fjRt9UKhYlmAYUys9JEc4tsv0ZQgBsfCZn/O04hzPfbl1bthBdT1YE25kZ/rTjizdSaNoEvuRuuaeKGkqLuKm7ypZd1t5iIHH0GlTQavUiMEjazm3R1fK8LNdwb7AoaN19HTO3F3HjjqWe/TLCY9i61yZa9xDn4c/LLCjfL1TETnXcxPzynl8tAPDCkTbnU8nvYudKjfhBmtlllhWvi2+UcQEkS65BbCBHJkunjFiICT+XVdqM7H7oBJxunEiFRRgihuWlUQ2sVn5jSNfdhJXecqVsc1R2AqfqQsgLqYwoub/Wz0MBYN8G89uCBkFreOWzE8UxpX0WFYNJ2L6ADNoeex7TW3Yh6/xGSqJpwtaKYcdtHMpECcT9CuoHK1S/SsOfytPXcA1eHz6ixewQfmcGxDxrL71T6eDRjzxYHA29DGbIe21F/sMArXLSifITGmoYD/mNwu1h7ofJkgNP4QFXaujnxBQUT5mpN7y6WvgAJnS4VO9UtMZQgUTcmkWfRiFsEQAm0znZPz7a3hprYelP6C0VbhwIq/shBF/Hi1jvcLveuXM4H3SRzTMBTOQH1TZd+m5GU94TY5lcUuFuX0TUqEVjWOw/XC4Ux1L9EotGTEhrnoQkR9J6HROG4sVDDNX9olbuYcd/iOyOb9Y2PwqpSIchigDe+OkS/1o3WPDge3NG7in4C/9MUNLxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gqZkkDpBnT54Ziy9s3v2jw+HbtTD/DVtf/rwb9xuS1v/ptM7SnHj7Qs8sDjlcrAsNwmDBODn608GKgQ4DTA1hmROXZyp8a8x9yWilmdN2N6pOM5qfkaXbkyC768d19t4x7dlKYbxv80T+eM1HgCdwXffZLnmNrLjbPU28zwkHq0nRjR51w40QR5uzQUXkPDt+6L3jFnTpkkZzVoSwtH7iXzBXLGu/BfwoSmCNJt3z5sNgrl0XMnmBBcPr7pgr8ehY2uISLSwklGgkaovmyNSCwnqrj1nxfqhlThEC3YvQFIwm2RK5+JMPfvizb+SVJG552RMY83gCLoD9dN8Uq9Qr7ht1UR6rIsSZjrfLqx/o5DgISv+sW94nJue7oFpMdlOndVEOAODTY89VkjzwJB9lKoqEQtaJiQ30bxfAl3mwlVqL1E+zsel6Q3sOcYlUqPk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:19.4152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ee80d2-3f86-4a33-07c8-08df17b58ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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

Keep PER_PIPE disabled until the minimum CP firmware version for
warm reset is confirmed.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c559b355eb49..1b9a4e7ea833 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1575,6 +1575,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			/* TODO: verify CP warm-reset support before enabling PER_PIPE. */
+			/* adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE; */
 		}
 		break;
 	default:
-- 
2.49.0

