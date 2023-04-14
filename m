Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BAAC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0ED510EDCD;
	Fri, 14 Apr 2023 15:54:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9345210EDCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT/oG+8ZCJxZL29CVgwLAJroLZkzVaufXM+ze80scyr/erHMS5xbOGy7BcGzshPzLSErxo4H+1wDE+4kSE9idLahwRVGIHo00AeG3CfyjDPItTTq4g+OFhmfDGVATTrU930/78YhJfpCB0DRbO9UceBtuYS21xVlknVzUV1EkKNiiu6D3mh8w53DHgALZLdEDAMbp4upoXVB69B2zT57X6If31HN36w2IHHL537L/0IXIJX+wtVpDQQimHTOUuf88J/UDKtHiFRdZInmphOTaymXQ7nXLRp03eTHaaoiUCQkxlu2qnw+LPId767eC2Uq3yVoJyCUPOIcXKG8Fxmo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBiRaFCHL9jf1niFSexmomsEL4EgMIjCwsoeQT5pDL8=;
 b=d/Y6j1/EGkwBqYoagN4iG7QUhkOSjn/+LCvaEVq5EdgFdjfYqlnIFUFOtzUjrIp4gCvx9qGezFM5A/R5HrNbFWzZx6uybFpBwITxaBTLFOtLdwzfoquhewr6TVFK1OTKainSJ0B+5pFuFm6CdsoGekJ+ZyoggkBTXXYJq3D7zZq/OoNiKiYYPuw0kgBpvRwG8WxOD11vKPAlQCqF7T7z8ubHXaxC3HNFRNTtrjGBNJDFlKtWMiUTEodAt1MFqKl9OHiOI3UmFj182dGZYVB5wpNjK3UkPdg6wIvVvFh+sdOzFDfYkCMJ34Qsh/qlhR/QsghUZMoebbRs7lBmYyM7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBiRaFCHL9jf1niFSexmomsEL4EgMIjCwsoeQT5pDL8=;
 b=ls96Hvjij7aGk+43z326XrB2jD2wBsvOCCYC64BLDVGlOy7KANhmVKlD3SCuMD10NwpGB6Mz7H1km1f9E8WS/BtwgmoKKPFvbmZPAmadxlAaYe+WgZjjQVUmfdT1FFuovSkYxloQoLUaZVEp6gzD1lxn4aZxsJE+kR9BCWrnTgc=
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:23 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::c4) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 15:54:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:21 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/66] drm/amd/display: Add FAMS validation before trying to
 use it
Date: Fri, 14 Apr 2023 11:52:48 -0400
Message-ID: <20230414155330.5215-25-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: f9618665-0c6a-4d3d-e31b-08db3d00842a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHKuMzvfEpOkVJeia3VvhEhJKmdPk8ZbSVWv0phWptq+Ljwjk43R21EPZ87ClFvneitcC9gcQzW9aWlcw7DI1O8qHmDPB48sTfC7/6AVtghivDRwKr4vMyULetI8uuW0/WF5dGO/h7MrEKXMp4yQ26D3yKmCScOjI4D4vtM2I4DPYN5UU08fTOcmZKg9pMbuGVeSTqbxP3wJO0IfZAm/GAiaI+lOYwxkVVrOnVvKvkB3bRYYDdS8e9/6LQry+zxCe8m78h+LWZ/vDnEzvLV2AAk7kgkW8bnh4z5Ys2WG7MHFNJ4334zoVq4bLiMY9OmN6XDMmjYxEOOUdDh/mDNMBDx/kj3cJ/Qf20dP+iYHQzFvAanOyz9yNifO6gruATlBaUTNWRBcDJ5PBuVrgqBE4XrJ0lFS8wr62MCFSWdcSku+scK5UzhEohtNV0CzjGa0HPu30J2OS0lQmjWT4cNGO36h6CKugT0Es5tx8cShb8FXz/ZSeyMDcvPjp7R2ppagwr/qLMwUK7cR5MWfqTB0BuaBEw/aMgR3ZZ608BcPvu6V+BU7VsU5pUTXguZQDnC7V3cyr3d8wVnaaSi+EnUMSCekT1N6n+AAEVmd0FnMfS2nR808KypjrLfPxjRYk/Suubn0JN868/TH4F2Wt0KRd9nQkvFO5yZJwdyLIkNcRowXFc1pOMP5KF7i383B9hbdnHZXJWgx8NLSV+wa+owEsbJ6oD6QNjFXJ3xoSaFQFpg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:22.9285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9618665-0c6a-4d3d-e31b-08db3d00842a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

To ensure that FAMS can be used, DC must check if there is VRR support.
This commit adds the required configuration to ensure FAMS can be executed in the target system.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h        | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9b2003a497b4..da6cf3ca372c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2604,6 +2604,12 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->mst_bw_update)
 			su_flags->bits.mst_bw = 1;
+
+		if (stream_update->stream && stream_update->stream->freesync_on_desktop &&
+			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
+				stream_update->vrr_active_variable))
+			su_flags->bits.fams_changed = 1;
+
 		if (stream_update->crtc_timing_adjust && dc_extended_blank_supported(dc))
 			su_flags->bits.crtc_timing_adjust = 1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 25284006019c..270282fbda4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -131,6 +131,7 @@ union stream_update_flags {
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
 		uint32_t crtc_timing_adjust : 1;
+		uint32_t fams_changed : 1;
 	} bits;
 
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index c95f000b63b2..34b08d90dc1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -301,7 +301,12 @@ static void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *o
 
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
 {
-	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
+	struct dc *dc = optc->ctx->dc;
+
+	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
+		dc_dmub_srv_drr_update_cmd(dc, optc->inst, vtotal_min, vtotal_max);
+	else
+		optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
 }
 
 void optc3_tg_init(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 598fa1de54ce..1c55d3b01f53 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -360,7 +360,7 @@ union dmub_fw_boot_status {
 		uint32_t optimized_init_done : 1; /**< 1 if optimized init done */
 		uint32_t restore_required : 1; /**< 1 if driver should call restore */
 		uint32_t defer_load : 1; /**< 1 if VBIOS data is deferred programmed */
-		uint32_t reserved : 1;
+		uint32_t fams_enabled : 1; /**< 1 if VBIOS data is deferred programmed */
 		uint32_t detection_required: 1; /**<  if detection need to be triggered by driver */
 		uint32_t hw_power_init_done: 1; /**< 1 if hw power init is completed */
 	} bits; /**< status bits */
-- 
2.34.1

