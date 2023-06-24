Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF28EB64DA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 03:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F270010E071;
	Sat, 24 Jun 2023 03:50:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509CF10E071
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 03:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae91A+vbC/xWpbDvHerGd/WnNIvT7ptDRDcFj87U7mqHzmYQTgF/jftvg00+mts2ISDfF69mAPgFB86blgRqxRdhzpDXXd4b0XAS3ScuQHI3P1AAiR59SX2IyldloQ45d+WrkKJ+0KFLQX2zaax+V9tHo3ApAFJMlh0nrpQ+UwcDPCq0Ef0aP5pWrJmL5xc4moC4RsJX/0TVIli99kZu1YCgt9OpoF5jEkzZ3m2zqQueIXrVlDZE2VZdc95lvXpaAR9XKtR785u3X5F+Yb1CSLAgQOTbe9FKtOP8ibdaRwWdHu34agwAcFNthQ49wlA9EMvyKitwb6R9MGkfeYUwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNDDqNjX1zmr48FSO735Bd/mG8nwe25GXLOLCjygK3E=;
 b=LLNKwceS2gmREyqD5gOmGC5pDk5UOuIX9PESByiK/lrVDtBATpQmApPz7WdFeLZ0G35u2mA2m8PpbWDI0o7eAjpnUA2TpmRhCwT5DgCDAJFutEilDBkBQxI3cuVbv6lU3A9TqtMd4P1EQFtLekKXslcca+12CewAlwoBmOXc5OAbYtBjCUJrSK5aW0IhKnyFnf5t5Z1Jn4F3a26VV6g5Ih4+TmvUenPjLkEcyP7jsxcLSH9etCgAujD575EEzXqvlsdTVyP3TjC5mWN4dyVqQYxFihVMr7GGBvXHCL8SbPnZL0GyV+23B7n3kkfLCY6Nb/jqvA6wgAeITIWHDS4cQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNDDqNjX1zmr48FSO735Bd/mG8nwe25GXLOLCjygK3E=;
 b=45BKicV0j+LuP68wP4xYyhLPYH4HQJbBjbyv5Fg0f3+AvE1Tuo05Bgk9d6CFWxnvmG/tn2ZZveyh3xrbw/weQLXh4RZtToNZcDcpxkLh4OEoudcrIuRl+VKBobi77VT1HpPIDeQO/xQVDB0zSwGvXAGM9rSL6fMmgW5AKDgx2G0=
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 03:50:08 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::1) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.27 via Frontend
 Transport; Sat, 24 Jun 2023 03:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.44 via Frontend Transport; Sat, 24 Jun 2023 03:50:07 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 22:50:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Clean up warnings in amdgpu_dm _mst_types,
 _plane, _psr.c
Date: Sat, 24 Jun 2023 09:19:50 +0530
Message-ID: <20230624034950.1231279-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 075b4264-7c1f-489b-4055-08db74661a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqbYoENClo6uceAMIIbkTD2NArzwYbjc5R7Q49EYWZtAlr23a789XlhNdv+21ZcW9N7bGKMfwD+qDzeI78T2ZLNa4eeB4jSyJoO2qKd5DtdANG3nEfzAfS5RnGOR8nR7Lxb6BIdqn6lBoClsxnmW26DB2KJHEmh5Ie/j1IukYomIVeJ9PsTnXxnbMvMU4g0Va8VITAlfaY+NHP4uiR8HDN5G1x8gpXpJLtNw/AFONzCtfXZ9xpyVz6n4UMZr6ZeKA2Ryc9/BGUzW9tBXCgKp3Rm+s9vDFGDlXm2faP1bn0deGKkQXxXLmn7EP5tnqAVIYu3RKsEVVA8u3tI7dsQ/Wro+hWt0rR7+0Bu4dUp+BGHZoqdCmW2v9hbNmrtkatpZGvEerLQy8ltInWp3m/1sKR0vzGN14eJQr2z4QFxjt2EsSjVvc/KQXlVfyvWNGNLlp69Iovd7LnnwLtIl6zdBNoSk9RBUN+Vir4+P9S41LTVfwsF/O1sMa7Xbwlqlfi3F+5ANt7np9VwoQmH8q2urpqJYB87HlC8vQ0U+5ZGdPLqg6JaZTP71NpkhYm4rELICM3ZKt8pvy0tIRZGrBrsAPlFmoxQmSDC2aZgncqRgWfU0NvC+C9+jQ+Aipuu0dPfTmW6TcorBADfyV/v4fOPFjsqb5t/NCg20Ndf/WhBivvmV+M/Z7MsSyZuUEzBtuDd+1xX4E2QTf93tu7PU1c9iwxtZmoRgSihPzDY15szz5CtW1F85mioPDi2OTdor1juwmgICCCKRxpv1yJe/A319Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(356005)(82310400005)(81166007)(40480700001)(2616005)(86362001)(40460700003)(316002)(8936002)(44832011)(41300700001)(70206006)(8676002)(4326008)(70586007)(6636002)(336012)(83380400001)(7696005)(426003)(54906003)(1076003)(6666004)(478600001)(110136005)(5660300002)(16526019)(186003)(2906002)(47076005)(36860700001)(82740400003)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 03:50:07.6411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b4264-7c1f-489b-4055-08db74661a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following warnings reported by checkpatch:

WARNING: Missing a blank line after declarations
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 46d0a8f57e55..95eefa6b4f2f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -296,6 +296,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 
 	if (!aconnector->edid) {
 		struct edid *edid;
+
 		edid = drm_dp_mst_get_edid(connector, &aconnector->mst_root->mst_mgr, aconnector->mst_output_port);
 
 		if (!edid) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 322668973747..de1c7026ffcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -164,7 +164,7 @@ static bool modifier_has_dcc(uint64_t modifier)
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
 
-static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
+static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
@@ -581,7 +581,7 @@ static void add_gfx11_modifiers(struct amdgpu_device *adev,
 	int pkrs = 0;
 	u32 gb_addr_config;
 	u8 i = 0;
-	unsigned swizzle_r_x;
+	unsigned int swizzle_r_x;
 	uint64_t modifier_r_x;
 	uint64_t modifier_dcc_best;
 	uint64_t modifier_dcc_4k;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index d647f68fd563..be63d34400d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -165,6 +165,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	 */
 	if (vsync_rate_hz != 0) {
 		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
+
 		num_frames_static = (30000 / frame_time_microsec) + 1;
 	}
 
-- 
2.25.1

