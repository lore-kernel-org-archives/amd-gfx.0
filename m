Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58128C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19F810E3D0;
	Wed, 16 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4121310E3D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr7CmQkcHKlrMkDoJCrW6ZnBtuh+ZZxIzeasooHjtBze9qaaA17UyMSqGJH7hlta3mch6UD/jQsllDyqrvaOvau1FLWxVs0D9HMgLN5OT9C11erSTrx2F/lwzseRfbtgFmC8XPQZYbGvrclrnNhcLeVnGNoDUAqoqxwDSO5Z5wbOPEOu/zlewCVEhgMV3e9qin9DGEVjuFWrhvUnGHl2U0GZQyM2LxmdgW2ls3nQksE/Xan+IlUVkmy36RicV5deMWRsOiWzlps2FKcDhsRoyqGFBc0M0yBcBHWR7KMbVV8ID+G5Uz49Udu9FI1Adyd0TMNsdTauSm3EUkqhHaFerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEMSHe7fqMqQx8FZo+W/kNfL6qOKWn8kQ65A+e3Rzgc=;
 b=N0Hg+dSLp6AGdDhsk0PINflUqvSJy4vzqCIfek3T8ovaqTjd6UlYyYBfiaiMOjK57jYcWVLIqtuGFUN8W5cA1BC3TYrCvxO0X9EIjyt4YTfJfk5GHV/VtVM0VVWi4VgdvkKT3DE1otXq65VwE6n7++ENpHQxjIjLgNxrtYvMpOmMxznurdb1f004ai07aWMFsMNKvYqPD5JB0fA/IYZ/pTvwAied/IWNStdPKb2oSqumd2iYeCR7mp4KWzP+ZnTXlCW2gMsvwgENvj5/uJepdubHkg26stXqDSx0BJZgd4CLgclIAWKPP9sG7gDLht7ykIgcHE5tw+Y+Tbw/q8pVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEMSHe7fqMqQx8FZo+W/kNfL6qOKWn8kQ65A+e3Rzgc=;
 b=lvOeStcHKU/DOn57GumvxJgJowpDqapDKh61bgKoS+BTtNvdQIMg3hf8jII/k95YOYXKS3NFCljLXryMFfTwWN3JAKG4vDBdDPY973WqzCOrATY8JNO4tpd19fZw2eNZBnxH/gmU0UkIiHCqZMGFI3tI+m78iqKRFdDQ/QO4Urc=
Received: from CY5P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::16) by
 IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 21:31:55 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::a) by CY5P221CA0016.outlook.office365.com
 (2603:10b6:930:b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:31:54 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:31:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/18] drm/amd/display: Setup for mmhubbub3_warmup_mcif with
 big buffer
Date: Wed, 16 Aug 2023 15:26:24 -0600
Message-ID: <20230816212626.987519-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: a941fc1b-aed5-4c59-d516-08db9ea0367f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1TISvoRhwmnCewBi5m+XEQVTET8UptlZYCT+XTBkdG25GtgzmSpm8pZKxzdO+Edgoit/jzGJj7P9oEy0tfHOotvQu/H5/WOu+Di/rQEh7AKOLTbLoZwEQk5d0WyHaD2Vk5Lwt6i8V02j+flV0QtTeIuU8kUXydsZuV+GwF2IJOq8Ru8hFLpjByY6YJrPlpx+5lMuDtj8dJv7EeuVUD64f4ufIWEeKLSgYLNbnKhV+xuXY7SFu8X6SawHr/igxkLPuB+Livn32PYm8AtKXeWK7dYYBvg5XjjbpD6YoUtIguF7Q22nN3SY0gYVVqLvRqkf+RAgyOmji+eH6z7cuByndvriMRKQxyM9Gh9+OnIgyAov+ZzHLc6yttZVnKaCaoJ2KbWIvJ/S3I1Fsn9ytG8cPDduNZySSg/b7OfxZFODIjwd8qDLOm80AiTzuJo6dqYJUjTpK56AdzRp4avZa+Gkr9tnVrlyJIsbjTSrWSiJ4VhvD7MuDFgxMVAvco4FW1nrv/3WBxSpJ1Zjk5lGfXevS/XuReHwUXbfvDHY4R3Qn2Syu9bY5LKrNf++iTdBG3Ewuzxp6bVNWgL1Dejkb8fdckd4yr3zw6ndRoHggbCNg811B+6CG3Gvjm2+heTM66IBqIjEgIop+0eQ0rHBQgmtBt7f6Su5/o4Q3NZ7GAIK0EW9rp0c74wlsVaQ7A+H/CdK87u25PaFX/MGh3fx3+W/eQhVMVSIHtXplJn8sereUIrGT7ywcZj3hSq/fUlMq6cJcGlfyrncufAkNlq/2rEKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:31:54.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a941fc1b-aed5-4c59-d516-08db9ea0367f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
Hardware may require different warmup approaches - big buffer or
individual buffers.

[HOW]
Setup warmup for big buffer when it is required by specific hardware.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e9efeb62d6b2..9051497eeed9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8718,6 +8718,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 			      struct drm_connector_state *new_con_state)
 {
 	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
+	struct amdgpu_device *adev = dm->adev;
 	struct amdgpu_crtc *acrtc;
 	struct dc_writeback_info *wb_info;
 	struct pipe_ctx *pipe = NULL;
@@ -8793,6 +8794,11 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	}
 
 	wb_info->mcif_buf_params.p_vmid = 1;
+	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0)) {
+		wb_info->mcif_warmup_params.start_address.quad_part = afb->address;
+		wb_info->mcif_warmup_params.region_size =
+			wb_info->mcif_buf_params.luma_pitch * wb_info->dwb_params.dest_height;
+	}
 	wb_info->mcif_warmup_params.p_vmid = 1;
 	wb_info->writeback_source_plane = pipe->plane_state;
 
-- 
2.41.0

