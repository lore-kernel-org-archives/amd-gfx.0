Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C05EE7D0AB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 21:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B248510E61D;
	Thu, 21 Sep 2023 21:40:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0D610E61D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 21:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDAPWKQLw+lReZE6gbuEJ+Zx8gEc17VqyOJdmJKzmhYst35dXzY4McToe6FkzkwImQJm0GnukL5q5/nJ3nTDJPV9N/Gku1LgiMgZUUBwglCye/Nhzq4QZ4EODgpzsSyefXflWn7+ryO8CbSAWflkQSUqv3jFlgu0tje3pOIKmEagPzOCcrWt/k992kP+m6bPQHITI8ewnMMWs3A05u2ua2ZN6x9yt5As6RSUPdVnzqIZNIJ6IbkiJwHS763T3vg5cjtfcGUFCbaTBW/+zRH/JcsViSuQvcUA+NxtlPSNQAaRfDh4ENnjYx6tg7F/Bs8pP8j2bjOYMkg+0S1uskWcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPWO5ARj35MlVErwa/RRG0HEvRrhP9tCxgqTwn25/UY=;
 b=OC5fvrsLlr+wJS56U5qy4frVqbk8QI9F3PxLjn4anVW9IZyFd6cNRaDHWdY/ZNCPf1tU2L+NBgyzyXy2vS2EXmebR0Wv5C0iDX0QXCfVN3XFFDo86G/V5/P20ki3nJfOZ9x5J+b8V0dn+kawXPuRJOXCzhY7aWCWNGGx2IrrND1/tDIZ216vC3n22mnq3+sgEhiJn6LGsDh7CT7NC/icwz4D4xhIFxEIqUj7X8LzHCb9VWhoPDNI2wa8mwn8Dr4ehvg+fLbe5ZDCgcCW3eNQ7KAj4jnKpwvX0gKAtZWju37hpy4r+GAmZILPteFIqdzCAwL/U8Ez1i3/c+XI6KQXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPWO5ARj35MlVErwa/RRG0HEvRrhP9tCxgqTwn25/UY=;
 b=cXfuZwHiVl6k0KwzFI3PVvGf8NTaqqnvgwZz1R4ETkCM2Q7NQPUeKd2+DsBqFcknb/K7GunN85bR/P2IudqkuqtlfYMcIMRXyyUht8BneuE4+wuXXnQo1BpTW+tIqux2faNIJfaMkeWGWoIW6lEc+LBDjUncIwVA7X4RhQQVZcY=
Received: from BL1PR13CA0307.namprd13.prod.outlook.com (2603:10b6:208:2c1::12)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 21:40:35 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::5f) by BL1PR13CA0307.outlook.office365.com
 (2603:10b6:208:2c1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 21:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 21:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 16:40:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gmc11: set gart placement GC11
Date: Thu, 21 Sep 2023 17:40:19 -0400
Message-ID: <20230921214019.926691-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921214019.926691-1-alexander.deucher@amd.com>
References: <20230921214019.926691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1793a113-79e5-46ab-8132-08dbbaeb636d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlUD7696a3fT5d3kVqKdfJsEDwrldHb7UlXWHlFhTvqu9ZMtQPFdjPFmRh+/1zkLugq0xwKYqHlmhddIndofh6151J9Ig1jZ+vPm8hbJQcE+hJGn+1esSvEhLAMi9w3k6tQlr45WdZMyQTPxqwSpqZMj2t5TDEMR/Q2sCS3fR0aKxlGewxeBmAFBlVEyAh+ZB+NaU46U9UDWUtTIyPezhdNdbbNxWtg6WIjdu2xuXwHs0J06SFhMQDRMMOAKKDp9MgFZzHdtFGsPujZK5XrPk0W537QqeTpk1R7Qzz96yqN9OQ0lTuHYOazrAj6e6J1IX3k9IVnlJGMpb+EoPbo/02g+af4aAvtjZB5pCi2Myu/bfWQN6/7DEg8t9g2WCTbqVwOdkjBnmHNzn4ogYNTWHBffQRgHnX8R/yWnnzygb30UZOJv/5EeicnRBnnZxNo95tx9lVw2jSH0C4a0Awnzv41svqNGp69o83JFk3JUUeeYH71dMxIxwCCiwexwA68tTX0cb3BnTF5Ln5es97zNSVR0GVxJN5NvAtx8l6JIQkTE0nSrYUxtL91B73XEmxmuh+vE3RISu+GHVuell/OUtFQts/wUsu4Ew9qKlAymIZaAsDzUEoBxa9DZ3AeZmI04TTXzRzhUgyiYhLwuVEorgHJJ/LSl2K6E7t84qco5gpGGh4/Iw+rLAr9dwHwX3V2YcA6clLsk6ArToEV+R+0s4N4fpOILFnPWLp6a0f2TeTWz08sDMmLcPyOI+T7PORrJSJPs2dW0rGs4ppU1uPVhK008fA7P05OPcnPZ+S2UkBmzIO+Zc6vRzH4hzp8XJe/s
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230921699003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(86362001)(8676002)(316002)(5660300002)(8936002)(6916009)(70586007)(4326008)(70206006)(41300700001)(47076005)(36860700001)(4744005)(1076003)(40480700001)(478600001)(83380400001)(356005)(26005)(82740400003)(16526019)(81166007)(36756003)(7696005)(2616005)(2906002)(426003)(40460700003)(336012)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:40:35.0790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1793a113-79e5-46ab-8132-08dbbaeb636d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needed to avoid a hardware issue.

v2: force high for all GC11 parts for consistency (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Confirmed that this fixes the issues seen on SR-IOV.

 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7d61f66625fa..2cb288517598 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -687,6 +687,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	/* force GART to avoid a hw issue in GC11 */
+	adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_HIGH;
+
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
-- 
2.41.0

