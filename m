Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A398E92FDC
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 05:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1783C10E00C;
	Sat,  7 Oct 2023 05:41:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C2110E00C
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 05:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMB6jVUBKFB2z0YBe2nRitdliuKSv9NibpYZNRGgs6FuliYttyM2Oo62wCKo/kMuMUGsmqp6GuhrAVYvsXMV8ocB0j2G+z2gE2bGlnZapEwULw7BdUIcUDvoP/9SFnKtlB4GpbcMP8DRTWQtlktAe1cWyY0FNDacsj2MK7BbHSu01fP6wReiI2OjcZGN1gwg/Uf1Vwp4dWddVaD5NypuUbD7xtuNc6IQUtGUb0jmPMlVGtFASbkjFZqheItGuxHLj5/YyAPiIHWX4wSDuE3iY+txBKMzRc/w47rGy2ibbjuq2rXfusp99cUrXTXktX4Mgvxo6EkULf4ukDPEeSxymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOjsxCVExzoqEaTE54x15qw+CYLU5Y7STQdy/7zH5FQ=;
 b=SDijWc7c3X5i5H4SzRwMWGPRiio1KhgQcE0BMNpB9bYMz/EJkgzObuJdy/rmuDFMHdGmXY4kBcvzGQQ7h3Rsvi76/3lntp+qA/KemXX6BRkztmds/UTmbLWaD9Pn2dXGMGr65DapIIYodRnIpk7YXDPR382uZ7aJuLpLi0324uVXUG7FlL8ateRd5t9C4tjrIwWR9V/Z8irAxEfh3BQNsHHiCVognmO3aNt/k0u0AU35WHa3xxvpATLIb7ngURM6dpf1+ySQawc8HvuQpy0OsZ5YxhxnrC9Vejv5huvKjE3k/7lWRLASIS72AToIg4cyyH4T2a5ORcitDu5jJEI04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOjsxCVExzoqEaTE54x15qw+CYLU5Y7STQdy/7zH5FQ=;
 b=Aqqe3MhXgo++A4PnGwKf5QoJvffaQT1G8k00dcIjznbz5JXJRQJJTT04faLwJgiuAGgKuK8Nwh99B51ChgOl1TbBNLy922w3Be2NRaxdtfEqQoup4whO0aVYFljia4Ekhf0MMWoR1oq6ZvX3maq1FOnfBEoygM/k1O7qi9atIlA=
Received: from DS7PR03CA0311.namprd03.prod.outlook.com (2603:10b6:8:2b::23) by
 DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.37; Sat, 7 Oct 2023 05:41:33 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::21) by DS7PR03CA0311.outlook.office365.com
 (2603:10b6:8:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Sat, 7 Oct 2023 05:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 05:41:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 7 Oct
 2023 00:41:32 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 7 Oct 2023 00:41:30 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Enable fast plane updates on DCN3.2 and
 above when state->allow_modeset = true
Date: Sat, 7 Oct 2023 13:41:27 +0800
Message-ID: <20231007054127.229441-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 038def37-9d7b-4750-4a44-08dbc6f81056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20429WcS7+su/hMvtHdyObsgW+LBYQAGoYlwmyYwXC0Rw8JdhofL9WMI1h6b4RDUydxxZoGmjeGL5B8Xfy3+sK79jEIV+bWQ+heCIwbxrE0PkTUV31dhFpp9/3MreB26lw4kU05s3bXIsSYlzvTfnTkgS8iA7DvnwiGKXMkNCzut//Fg5465XVR3KSqwk+4CB7VAmDaUtMBBnJfzvjTTNU9FK0UjeEQKGzjWorWxUgQBWVPnB0jQ0Y0fgM014Yv0Mrh41dJPL/8kImWk07iNsBcbM4E45w5Xh0p3wNAyFBFtmIt0614Mmak9ACr0GJIUo47tIJ0GJkeMQsVqfxeboSabhjQzd++4C+171TgWFl8Ka7vg/DnEctBxwo8Ri8Q1GF4baCoVui+RzYwgkp8PjHbGIN7yIMHL2K5vfuwBH1WQOpS3DkWgMNVrWay9CuTjCcXw/05VcsrJDW4D1R7TAFD9BTi7cp9ULDvTWiWd0DCOmoL8ITTqK5jP87mUpuScA4eKr9NE+moJLT2mLQdmB7pJtgB6AyaO9nZtoLsybabPHKQswlAgMCxSVxYw+VyLZdtftMHeGpOvBmH6k0QkR2uHl5Piy2X/Uqt4v5paDU96BGL05cBkiCqwInkT1k/arcRX390Qh9uEBZ49k9+/yr7yfbyl3Lm7ib9F5+tdjoPZKk+snLXQbPYudueu+yhfySSzxj+/iZ0LIktrmGLA69N2yhxwL+F2Hef9GLOqBEuT/nBrXj3koDiRUflBMy7r/0qPfIf5SS2ZL+vN3sQuoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(1076003)(40480700001)(40460700003)(336012)(6666004)(7696005)(478600001)(36860700001)(86362001)(316002)(47076005)(82740400003)(356005)(81166007)(15650500001)(426003)(83380400001)(26005)(2616005)(8676002)(54906003)(2906002)(36756003)(5660300002)(70586007)(70206006)(4326008)(44832011)(8936002)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 05:41:33.0555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038def37-9d7b-4750-4a44-08dbc6f81056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

[why]
When cursor moves across screen boarder, lag cursor observed,
since subvp settings need to sync up with vblank, that cause
cursor updates being delayed.

[how]
Enable fast plane updates on DCN3.2 to fix it.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c21726bdbca2..25a0bd314fe5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9879,6 +9879,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	struct drm_plane *other;
 	struct drm_plane_state *old_other_state, *new_other_state;
 	struct drm_crtc_state *new_crtc_state;
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	int i;
 
 	/*
@@ -9886,7 +9887,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 * enough to determine when we need to reset all the planes on
 	 * the stream.
 	 */
-	if (state->allow_modeset)
+	if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
 		return true;
 
 	/* Exit early if we know that we're adding or removing the plane. */
-- 
2.34.1

