Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A479C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 23:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B199F10E174;
	Tue, 27 Sep 2022 23:14:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A00810E174
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 23:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFa2G8mvXAqL0YOwrUL6O3nHmntiL9/sq0cGjSeHjRzX4Kf6L/p1B40DiOfsePFe8oZ0zHurxdnBktV1XvSHU3G0Qx8gFhw9UjWOs6kdu9BPN+KxbohTrU2KYMK3AL+LUP/r3DK6fNl/bPciXtQiAuSeQTEIUApaEY03MduICLS/ZzuIbR3PZDPex2t8DIqWzFoMRZ+ooSImLUSrkEpsJCICoJBoGR0/r0Aajq/lacS9j+L2kuAZou7sxwslVDOJaPzmBa8fpRYa3hqs4BEuQhA58f8hQlCnNS4ozl40luNOgu3UnjhqccgValenBvP6IsflUGx9sqah/95VH+dUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ve5m8e4IL+9CReIxuhHpwQQB9Oa00B+JdlZJ8sTIbg=;
 b=W1FXZ0zycIkbh224/qADR1xVZ09TQq1aGTWWabOQ/7PKQ54GLl2m8bDdPc5h192BcXhM3GuNaAVBUECmVImfqHKzw/4cZ0xTTlav2n4ydD6k5IKi/t1eMCBBkQvzy4Hr3HldB6h9KRign2oqIktjz0rORtlJQRNUg/grOBEIZTC7579h+CBY7U5bAM6Cp4jY6vP8BLaal/eypCaSNHKg6RIoSLsGeEAsQpesDOMImTUBis4ueZAQLQwbZEYo7TRUIsS7vapU6hKGc/Pe2tFB8Wz9i23VoX7+n6lg/DIV7rixKdLDLPr2YwtbiunVENalvMnOYL0Ih4NN7nAKIwOmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ve5m8e4IL+9CReIxuhHpwQQB9Oa00B+JdlZJ8sTIbg=;
 b=H0cXjEetmp7azuzEzLOUEZk/By5iDsy+J14nxATIzR7sYgR2Izq5H6a0nb4Z4LMSdr7z+7h97z4xLk/Fsdmjjj4Pd3vWY6pvBqyC3t2R/+0SAoEKVm7mY8d1xnouZ4QF9scswf0V9a588pcBhom14HLt5XtMMKkZ33D0/Qlfhus=
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 23:14:00 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::cc) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.27 via Frontend
 Transport; Tue, 27 Sep 2022 23:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.13 via Frontend Transport; Tue, 27 Sep 2022 23:13:59 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 18:13:58 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Prevent OTG shutdown during PSR SU
Date: Tue, 27 Sep 2022 19:13:39 -0400
Message-ID: <20220927231339.187788-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8532a0-28e9-4600-c73b-08daa0ddf5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqnfU1baEOm+Uk1iJWLSd3BaxKlnsP4cNU/kz6BlDliGZ/9la1UJRbrGJiQCVQxfsm4gUIj7UefzfvLQyFMc9siMPJ5kTQ6+0hMOv2g1SC64RvexZMAOcd/l71eqCz8px+9wBaL9jji4yC5MlX66Rdwlpk2jsqFLCpKSSPAPo14q8wqXwa65HYabyACjkWgARqS+Pq/DzXHA/q4XJQ04IiatO8sZ8CJBlPNvhFofnm+R1KdfAjd0WVnKvR3LBqtiF0owJezLTUN0qdU204Vf2rmqZkf3xDXF3wzY+obTIpEiFoV2+VJlsrl/IbZXpRLXLEK3Hunw7497sz05v1AcKBgoGa18X57C2MTqpAAhyrmr4mnHiyw4RHiQwM+DwFUbuF61E8eMnNR/+FZ3JW/HniS1siVhtHE2Pfc5H3IbjHu7QGzhrSh06LNyCzlKTr0977OTHh63bu/7tvQ8jCwbgS8Hmgj4+VRMfZfd+p4BBxCu+TljKWHS38tJkSx7HTtouE0OQ4Y2/ekJsJgJHSEYygKhfZRL7V0XbearRaoYcrWYKBzoqhOBdjR/wV/Crfyr3c9Da263Vwoj7g/Gu2uO6zVcBcgJdFTSDGLgFGuDzk2MCI9dSdEpAN0D3+mdA0qcxI7gSOtpcisV2z0SRyybjaQ/yrPVluPEuNn6cdbvlQzHiNfUhUe51ASVWe27rOHuDqAWT9mFUADRgWJDSdtydHVa03d823gX3MT9xOZCERFg+7SdJK+EG5ylv3xj8leWhwL3HNhH8qlf+TAetR0a7/L09wC0kAMfTXxBwKHKvko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(2876002)(6916009)(426003)(478600001)(86362001)(26005)(2616005)(36756003)(47076005)(36860700001)(81166007)(2906002)(8936002)(5660300002)(40480700001)(40460700003)(316002)(82310400005)(83380400001)(54906003)(186003)(1076003)(8676002)(4326008)(70586007)(70206006)(6666004)(336012)(16526019)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 23:13:59.4913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8532a0-28e9-4600-c73b-08daa0ddf5b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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
Cc: regressions@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
 Rodrigo.Siqueira@amd.com, git@augustwikerfors.se, alexander.deucher@amd.com,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

Enabling Z10 optimizations allows DMUB to disable the OTG during PSR
link-off. This theoretically saves power by putting more of the display
hardware to sleep. However, we observe that with PSR SU, it causes
visual artifacts, higher power usage, and potential system hang.

This is partly due to an odd behavior with the VStartup interrupt used
to signal DRM vblank events. If the OTG is toggled on/off during a PSR
link on/off cycle, the vstartup interrupt fires twice in quick
succession. This generates incorrectly timed vblank events.
Additionally, it can cause cursor updates to generate visual artifacts.

Note that this is not observed with PSR1 since PSR is fully disabled
when there are vblank event requestors. Cursor updates are also
artifact-free, likely because there are no selectively-updated (SU)
frames that can generate artifacts.

[How]

A potential solution is to disable z10 idle optimizations only when fast
updates (flips & cursor updates) are committed. A mechanism to do so
would require some thoughtful design. Let's just disable idle
optimizations for PSR2 for now.

Fixes: 7cc191ee7621 ("drm/amd/display: Implement MPO PSR SU")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index c8da18e45b0e..8ca10ab3dfc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -170,7 +170,13 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 					   &stream, 1,
 					   &params);
 
-	power_opt |= psr_power_opt_z10_static_screen;
+	/*
+	 * Only enable static-screen optimizations for PSR1. For PSR SU, this
+	 * causes vstartup interrupt issues, used by amdgpu_dm to send vblank
+	 * events.
+	 */
+	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
+		power_opt |= psr_power_opt_z10_static_screen;
 
 	return dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
 }
-- 
2.37.3

