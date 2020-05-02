Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F09C3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADE62072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="taRuLtM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADE62072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5E76E1BD;
	Sat,  2 May 2020 21:35:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23666E1B1
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auvfHLZsfcV/AgC7d+bFd5d0tfiSJa3a4uSZPMQIMDfHgoYQYI5/kDf8vhrry0gHtOv4xJS1CLxiPlKaqnQppkyY8i9OGxb7BJD1HaPAVAspTJCycJaGEzFldMZ3JF6sX3PHsyCTqLKWTapmPwzcygpXAYY9Tx0UFHJsuSpbmOo4c9jFd5eV+td+QFA879V9F+uFbx8nQW3AxTtPZp16QjeNaUVo5nsMUIV1QZtUPXUtFYWBRhJZowxRO59X6PNvrgN9RT4opg28s2nTKPN0iZ1V4gwQoqxuqiSqYQ28ADLvcxXMuT/Zul/iijX6eUyl18Fs7LH4JVxQLw2Ffuse0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiSJOmZGj9KpWPd6V8dZT4Mroe15uE/rpVaI46monVQ=;
 b=SZBSnZxdjOnRi9xx+Yd+fGQDw9V3aS5af7ZL8KA5400fAhOBAFP4eiXfqaBPHcyY02mYwJvclJXWfLevjniGn8py9dFvyXWPjRzAUQ7ks6B9lw8W7r6+L+V3tnKhgdObuAenwV+/2oqnh5dFoVAH6IE+5v0youRsI08G9sNIiLWBW4zFnaMgRNuxygkPgD/6D6WqCPvl46GGkAN3vE+B6ZeIIC7ob0N4nJTgubOf0F/kShJtrxh7/8g2+uBnNI5kpyAKKvB89qborTTv1IuhlXqg4ZPlhR41SzS5VPeZeZYuty84vY2wncMpWD1dKUtqcwhb1VWm9WZHzXU/S7PmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiSJOmZGj9KpWPd6V8dZT4Mroe15uE/rpVaI46monVQ=;
 b=taRuLtM5K9GexAmamcWdQvzE9MDTLLNk5OEKgELW5sBFI1s9DNGLi0vltCoABFahhloa/hufE6K+kVGhvBd3CybV31nBVQSAV6ojN9VXp6V122Mf22yO/XBxM/4amib4eZj7ZBS8dJXeRMmnLL07xH8xYlzTA3bT6SqIPJXxIpg=
Received: from MWHPR1601CA0005.namprd16.prod.outlook.com
 (2603:10b6:300:da::15) by MWHPR12MB1694.namprd12.prod.outlook.com
 (2603:10b6:301:11::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sat, 2 May
 2020 21:34:57 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::3c) by MWHPR1601CA0005.outlook.office365.com
 (2603:10b6:300:da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 21:34:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:54 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:53 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: add addition dc type to translate to
 dmub fw type
Date: Sat, 2 May 2020 17:34:35 -0400
Message-ID: <20200502213443.39232-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(2616005)(44832011)(426003)(316002)(54906003)(70586007)(2906002)(1076003)(478600001)(7696005)(336012)(6666004)(70206006)(186003)(5660300002)(4326008)(47076004)(26005)(8936002)(86362001)(82740400003)(36756003)(356005)(82310400002)(6916009)(8676002)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 466a3c27-b852-4c78-2646-08d7eee0a914
X-MS-TrafficTypeDiagnostic: MWHPR12MB1694:
X-Microsoft-Antispam-PRVS: <MWHPR12MB169478416FE41AEF96C4E9338BA80@MWHPR12MB1694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIUGkCxmNkRe/a0dQFqQAY5dRXGr3hAkYc0KBOqXWlRuI+ajM5q18dfNwtvF3dhH53sAuHMTabZMf3yqjE5j9k60zLdWPnC5r0G8L8P7CTeDpznR3SffFhdaJaERZfaMMX25brrlp9jEenHSOe4+EETvDwre00QQXNIEPPEgRfE37SwW7ap8Ha945IU1UHwVYz7ULTi4cMCAFCYnbpOYSIdkvVuwBSttT27VnrnMLgqwcnrYJce9nOfaUzT8Hr+Eni22H+7t5ydtXSv0LDiaC1dUkbx6qK36REzF+ZQpnImGym3BakIrWgVHKGQKHWptJYhsqqBqy2wKYYhn6cs4RrvbLIGxJ/Wyuo7+R+qa77GfK2SOn6uWOGPOE92ajmy9cvN2FK1mchRiORmDZEWChYGtnBYxN9mgw3TsDHH0s+2x92+MOK5jYqonRaECTIaU/plh53ztfyhQpOX51UAY1xw0xQyw47fMCOMan0KCf/FCAlK7a8KULmn2LURHv0YiUsUMP0IbfH0SMTH5tYXUzg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:57.1250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466a3c27-b852-4c78-2646-08d7eee0a914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1694
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
For a type like PSR version, it makes sense for most of the code
to include a dc type, instead of having this a fw type define since
this is a capability and type exposed by dc.

Especially if it doesn't even need to communicate with the fw.

The code that is packing the firmware command message
should be the one who needs to translate the psr version
into a command that the firmware understands.

[How]
Add a dc_psr_version enum.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  6 +++---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c        |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h             |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h            |  5 +++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c        | 12 ++++++++++--
 .../amd/display/modules/info_packet/info_packet.c    |  2 +-
 6 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 98446372c3b2..2b92f07e4bb9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6962,7 +6962,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 						     dc_state);
 
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_version != PSR_VERSION_UNSUPPORTED &&
+				acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
 				!acrtc_state->stream->link->psr_settings.psr_feature_enabled)
 			amdgpu_dm_link_setup_psr(acrtc_state->stream);
 		else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
@@ -8737,10 +8737,10 @@ static void amdgpu_dm_set_psr_caps(struct dc_link *link)
 		link->dpcd_caps.psr_caps.psr_version = dpcd_data[0];
 
 		if (dpcd_data[0] == 0) {
-			link->psr_settings.psr_version = PSR_VERSION_UNSUPPORTED;
+			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 			link->psr_settings.psr_feature_enabled = false;
 		} else {
-			link->psr_settings.psr_version = PSR_VERSION_1;
+			link->psr_settings.psr_version = DC_PSR_VERSION_1;
 			link->psr_settings.psr_feature_enabled = true;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f895412538c0..6ed67e6e8739 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1552,7 +1552,7 @@ static bool dc_link_construct(struct dc_link *link,
 	 */
 	program_hpd_filter(link);
 
-	link->psr_settings.psr_version = PSR_VERSION_UNSUPPORTED;
+	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
 	return true;
 device_tag_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index eb5d910bffb6..859d254c0e3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -72,7 +72,7 @@ struct link_trace {
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
 	bool psr_allow_active;			// PSR is currently active
-	enum psr_version psr_version;		// Internal PSR version, determined based on DPCD
+	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
 
 	/* These parameters are calculated in Driver,
 	 * based on display timing and Sink capabilities.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0d210104ba0a..f236da1c1859 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -862,4 +862,9 @@ struct dsc_dec_dpcd_caps {
 	uint32_t branch_max_line_width;
 };
 
+enum dc_psr_version {
+	DC_PSR_VERSION_1			= 0,
+	DC_PSR_VERSION_UNSUPPORTED		= 0xFFFFFFFF,
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 9f12c76f21ab..3c6606e0532d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -94,12 +94,20 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 
-	if (stream->link->psr_settings.psr_version == PSR_VERSION_UNSUPPORTED)
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED)
 		return false;
 
 	cmd.psr_set_version.header.type = DMUB_CMD__PSR;
 	cmd.psr_set_version.header.sub_type = DMUB_CMD__PSR_SET_VERSION;
-	cmd.psr_set_version.psr_set_version_data.version = stream->link->psr_settings.psr_version;
+	switch (stream->link->psr_settings.psr_version) {
+	case DC_PSR_VERSION_1:
+		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_1;
+		break;
+	case DC_PSR_VERSION_UNSUPPORTED:
+	default:
+		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_UNSUPPORTED;
+		break;
+	}
 	cmd.psr_set_version.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 22a5484d9f28..20c30daa374c 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -145,7 +145,7 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/*VSC packet set to 2 when DP revision >= 1.2*/
-	if (stream->link->psr_settings.psr_version != PSR_VERSION_UNSUPPORTED)
+	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
 		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
