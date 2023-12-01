Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289CDC07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C06910E8A7;
	Fri,  1 Dec 2023 13:29:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8C610E8A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na4nxLVR8i2NoKZFpFNCykLaw1ySfRfWTbvygfkv87ixzYOkrKKLPBSMyNbBok5QzgXpFMIVnG87IR0OH1a3AgaIaQTT9PnjzqS6qPZmWSZKsA3MlYqCjWNb6huVHPOlaDGDUYw5p4jg+07IspG0hyr0+PxEiSa6gpQ6j2jv/ZV0eNO+UIQ6UIxw32AXWiCsz1q7DAKwlcH84TU9PH4JyFkSrPJsusNRVEsk9kNk7wtZWSUoweOQPRcBOcyiM+tGCeMJD++4VRD+6MsbDUdE88qmCM3f8Xqeds7aeQlBXZ9clRgO9mSvZ9tC3KO+JkZENN0Cws7CPlyovglGkqjGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdeU6vPZc6WpbdEd6Byddrv9g2fMILFOw8iNi95mWJk=;
 b=hsOxKQvmYDcXBBhBuFsvPBKfEvKPngaKptHIASp29kJyotXa2d9/G9YeJA1Fgipryg5Y1xl7rpCr111t+gSyGdmbycqqG3QwyJfqNX1a/liQUnXD24wtr2Fj0Wx+PJg+KTsd+PV5jYsLpdvFy8koItjRAuAa2cncXg8xJtwhFIDKPyyJ7Gl9W94bBld/BDH6y7iZ+Wk/IDzZHV9tx+3f+2KqR6oi0cTwfZUOEvI9Kqwaf2xATNZ3todzuji6++fNfA5aQto66/uOMoz4Kqn0ULd9OJZ3eXjSSHtgXKz3UAyCyNyJnQAz9ggEwtXBJEmpaMtc+EMg0WnGXq+4OZ6LbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdeU6vPZc6WpbdEd6Byddrv9g2fMILFOw8iNi95mWJk=;
 b=0ciZ5se/NIYWQCQqdcb1DYraupOXEdWrBMHzjQ3LWMLGJmV0et24rYCDMC/EBuGJiWO6kUlncwEgFNwhYhGYgG4+DhzyLs42/J7cZD5SsV3aS0G3OlA8EC+RWH1O/X3bF2xaIVEQowX4tQpd+Ws8pyoLk1U8et4/2Sdrss30Lm0=
Received: from DS7PR05CA0033.namprd05.prod.outlook.com (2603:10b6:8:2f::20) by
 CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 13:29:29 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::7b) by DS7PR05CA0033.outlook.office365.com
 (2603:10b6:8:2f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.18 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:26 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 40/47] drm/amd/display: Add writeback enable field (wb_enabled)
Date: Fri, 1 Dec 2023 06:25:36 -0700
Message-ID: <20231201132731.2354141-41-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: bae02cd8-2fa1-460c-76f7-08dbf2718bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHuflVUJDhysxJuJj4AKBLyn9L/JjwtTpqNxSpb3EMVspvgGzfX6EAXHoJE97FRy18tkFoi2TtHxu5UN2XWDQNRQT7QZ14sHEzUN4Q8r+QiUR04+X3rsjprwk1DnBv4DoEhDOgue/l4z376xEediaxgaKWgb0X4daahzf+aJEldEcse1jH3NHtRzWET76OpxqvwUepFDc7xE2D3UyqJVn9ott+hYiYY8ZFqL0VLOenkOfYKzey2dFpQNasdlm+efK/22XDHr06zTTjjH2qZoNHyQIka5mUN5LhA6D01cuuVRzfygnlKoTUwlvdsnrV2YOnRJ1l5445eV4nJ7jQBq9+r+I+O+v2AzZ3uspE7w2S5Wl9yqzUhI695zibzBKQJWHsoL7jltq52T4Ngb/jjNRaf1aIhj0lqaTi0Pc9mdIi68Qp+OVHjJXmOolI7mh3cmlDfmB1QNJpbasKrNkyBiutioGHlP427GXOdDc5Ft77cz1BJUEauZ5VvkFoM6IxlDHHBPcEzsLQvYNKAoR0Abq9OpzACAw+9ZgqoKl383pDMuC65f3ZEqrMf7r7qySW8vKQr/WL5iIkYzFnveEZwb+6BlVq2VdvlvEyaxQYIg+aZakGGxLXsNArKCKnVkXgFPKZiYDLF0V38sOX/u3rtynpB6xfSTHwvabTEOv1fyYsfanNu+mlYRv9qzvJpTDgVnzBcJ+dske22igIzqtXd9nLOqbvAFsVXwfPMaUjfzgymQ8vlNAdXBwQNq/yzoVlGzvgXyBvZ4UQlfVYIR1d1abQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(54906003)(316002)(86362001)(41300700001)(70206006)(2906002)(40480700001)(81166007)(82740400003)(5660300002)(47076005)(6916009)(70586007)(356005)(83380400001)(426003)(26005)(336012)(16526019)(2616005)(36756003)(1076003)(478600001)(40460700003)(8936002)(8676002)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:29.3786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae02cd8-2fa1-460c-76f7-08dbf2718bd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add a new field to keep track whether a crtc is previously
writeback-enabled.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h          | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index a166d7684719..d8083972e393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -418,6 +418,7 @@ struct amdgpu_crtc {
 	struct drm_pending_vblank_event *event;
 
 	bool wb_pending;
+	bool wb_enabled;
 	struct drm_writeback_connector *wb_conn;
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 04e06665eb0d..ac9369b40191 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8673,9 +8673,13 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		if (acrtc)
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 
+		if (!acrtc->wb_enabled)
+			continue;
+
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		dm_clear_writeback(dm, dm_old_crtc_state);
+		acrtc->wb_enabled = false;
 	}
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
@@ -9253,9 +9257,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (acrtc)
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 
+		if (acrtc->wb_enabled)
+			continue;
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
 		dm_set_writeback(dm, dm_new_crtc_state, connector, new_con_state);
+		acrtc->wb_enabled = true;
 	}
 
 	/* Update audio instances for each connector. */
-- 
2.42.0

