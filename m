Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6FFC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A304811B62F;
	Thu, 30 Jun 2022 18:46:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8556D12A756
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuMFbyOJj49f29VSqlO+BX5y8MQEqs/ivIYurhxdsMjRliSiDzCtdlBiubXWoSkhsWngOGCSMTD5p2lhYyOAi5uA/j8axoH5HqnMVcU8Xbb6xAFx6iA2FBOcbR9jMAJMvE2v5PjpF1dMetUX2SmS6VDWrwnpTpVAlCsAEZC42qCShxRIa358roKOthkPPQLH/sO7xNHfnrT7Z8wq95uIsm/9YzEeCbIAqikbXTGFWM4r7rttRq02/V4caDwHTbS8fo8OTOmkChd5Rbg/0Qdh0Ws8DaUw+uPTSDEl88pf1RYhzyAibCiMQCo6n3RZTPUhjYGO1r8vnsMkj+dAgPdAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WFBVdL6MtSlO+gwKzSPn219e1NRqgOhorDwSqwCd5E=;
 b=W77d5D3PHVXUh5VOUA1MCwoSh3yc1VszYd9vJp4Hm/V2+jJPykvB0ylp+xZorPf1OctsBAWXUi5ROBfOlydYdLjbbm3eoBHubIXHrmU6gOj2WYaN7/azHwe21CGhUcjdHOpoM7wwYPn5d/ImqvsUfgkUUqujLIsL2Gwhi7CLZOTKsiXgnJpn5TSWF+oOL1IsGjob/OzWaw5w0BK7HPvT8sS8N1CkAU6E2n3FsWweGHy1jsdhysGfXwcVt/X8YiQ/pOE3R0QrvrzhcluMRrhzEBS+mmJaKp0wejqvYRVBK5IDmSkdOE//zu9nMqv/Ynl7b3h5j5cnxXG6YTRcArJZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WFBVdL6MtSlO+gwKzSPn219e1NRqgOhorDwSqwCd5E=;
 b=jXkZ45b0RsICCZGg1nT9OxXPg8fTYuq4We/vj0iQnV2YlSX/87/wTj3kecjbh/jGxjAQHKoCx1mgLastFMVWcTHVc27Ul7bOseYBd5BUlwgR7ZX75pUvaoiAKBik0FkRgnaadXLFbnV/86MIk+QkpEbMvIGe42O0lK/y8vmkrIU=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by CY4PR12MB1367.namprd12.prod.outlook.com (2603:10b6:903:3c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 18:46:37 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::6f) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 18:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 18:46:37 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 13:46:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Randy Dunlap <rdunlap@infradead.org>, Leo Li <sunpeng.li@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amd/display: Fix __umoddi3 undefined for 32 bit
 compilation
Date: Thu, 30 Jun 2022 14:46:18 -0400
Message-ID: <20220630184621.874253-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
References: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f21017a-cfa3-47be-ad5c-08da5ac8dd02
X-MS-TrafficTypeDiagnostic: CY4PR12MB1367:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6r/UFNFeMFC4Ec1v3jzrodkrno48jHVpFGE2yxb4cGOiIMiH4LhDXDwT6178+Pgpju6zqgZS05IjMIR3J1AvJWcLP7dHh6IWZxoggvkn9yuSgnWkUo0W3cuqLpILZF2ZJNP5t9Xb+kPOiTKNBLA4u3dm+MKiCxFeDPpaYMEDpdrOjzwSUBQM1xvppemmRnQ2yOAsXae7dR+IMFpzdDLKm6ibMzwtgruDUV4SWTjBEiVCqU1pdscyJFzEb5B9xxhQiZFI34q6LO7lFuqQ2jNTOY6vxVQ/JvtoVR3jRtZh3FwEGSteJXaPlfD67+YsZGuySkRJ97XB/VvLNBZj+ROqyJdM8TUWWcDEGpIfjpN7fbzMaG5+DNrJeXi/a5PR585ZMeR2dHCj/qHJke4U7EUesvZUgj2B3caxN1x6p4uCyd92MHArPfJpAyhmtP0EK//VQ/pS22ZQmFcOKnvJaS4dYrokPGmFcSVyfx+F1a2VTWyD/svp+zgh8Uhl4U4NRy8i5lFuBNQ+R4112Uo/1QHvXAERxz+BrSYnJPUh4ru5nrbC7s0gDvuoPpDCKyyYuXANus9qDiXW+g0OxpvnMEEt85LSHglhvjtxPD+R30fWWh1VRmjuEl2PypkV3o/54Hg/WBlxA+YHidDwH2BVyq5YZXxEu2BDFr8toGitZn1xeT0KaINUit6xMwTodEMvwO3IQKDw1dUgqSgPe20T20nfhcgKE9pg1W/rtKyLM4h4jG0YHKBbZUg9hOQGpI9BoN8/bXDqF5HJtE09pSW+hRG3pHhK7twRS9zo25X2D1KZ/QKKUwudy0BLouX/JDENud0428DK5hWC/smLgjQeY3buCiZLPRoFRY4mP6DagGF9i4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(6636002)(54906003)(16526019)(83380400001)(316002)(36860700001)(1076003)(186003)(336012)(2616005)(47076005)(6666004)(81166007)(478600001)(5660300002)(86362001)(41300700001)(8936002)(426003)(8676002)(2906002)(4326008)(40480700001)(26005)(7696005)(70206006)(82740400003)(82310400005)(36756003)(70586007)(356005)(110136005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:46:37.3464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f21017a-cfa3-47be-ad5c-08da5ac8dd02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1367
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
Cc: Stephen
 Rothwell <sfr@canb.auug.org.au>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While we tried to build amdgpu on i386, we got this error:

ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This commit fixes this issue by replacing the standard module operator
with div_u64_rem.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/321")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index a10ec5919194..790aa2b3952c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -208,12 +208,14 @@ static uint32_t dcn32_cache_lines_for_surface(struct dc *dc, uint32_t surface_si
 	uint32_t num_cached_bytes = 0;
 	uint32_t remaining_size = 0;
 	uint32_t cache_line_size = dc->caps.cache_line_size;
+	uint32_t remainder = 0;
 
 	/* 1. Calculate surface size minus the number of bytes stored
 	 * in the first cache line (all bytes in first cache line might
 	 * not be fully used).
 	 */
-	num_cached_bytes = cache_line_size - (start_address % cache_line_size);
+	div_u64_rem(start_address, cache_line_size, &remainder);
+	num_cached_bytes = cache_line_size - remainder;
 	remaining_size = surface_size - num_cached_bytes;
 
 	/* 2. Calculate number of cache lines that will be fully used with
-- 
2.25.1

