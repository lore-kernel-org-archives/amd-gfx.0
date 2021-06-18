Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F92EC48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CA360698
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CA360698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245806EA50;
	Fri, 18 Jun 2021 17:35:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626786EA50
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4kzQmTeHALPNNPAwfdEEplNsW8CkY4IdUf1BCK3Ox+gmT39wg/cFLpo5SKIgqM4p6MlOx8AWMjb+idmwrJivaJYMoqi35BHdGDXCddwejmShs0ZeAjbhiAEguIpYGUWZWpq6KL4oj3+LjPiALuYspGO+oR9sERgz47sDqFPKa86HDIqfIiYNFgHoNllik0NSlbb7MtGrHeIOsj+x8qlGX02mWuFKw9wwvoMpG86Gch1H8skqaeXwlLH8i7GgA/ohAqBGzSsGIYOVUy3ds6JNmdVJ/r96YL65UqsOPYfegUxIr4RG3NWnypVXxnIu+x/Wv8sJnyspHx2MADuiHkoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzrm+8+i7rXzg9VcDndGF8jHftUgTZRNoj1wo+iBZws=;
 b=ISfcaIw63kfg/6OBKNLMageV7JiDioFAIN+3deeIQuUpyKueWuMLNAYcn14nB4DG9oWouOz4i3rvUJdSrMSo6XCO9rPvdAOo3xchoVh9dlpMud1hyKVKByUlO4nR08HVghEibwKk8/cJ2geZfcx6+YRSjH/oEHskjTbn+AtkIpSmjXSwYmBxHfEdjJSasHq21Rlsbqf8XU8/vtVQkf9OjFf4EnNDcSvsI3n7Hntqism6R8ky60jYKawluv52kqG6Vs8S3pFJt7/THzJFS7IUKxijjZqlHm5YMVMU18JL1Qe8USO49U2N6mB9/nXLLXuMNCrh5ADw8+QLqSMt+jwZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzrm+8+i7rXzg9VcDndGF8jHftUgTZRNoj1wo+iBZws=;
 b=VMrAzPnG+l/ePU4hrbcL9OqqyY4PwzBOEju+EkAWRuQKj6Ae/2EtIxKASI4cec8Bd4XxhwJjxevPwPvyWYusaEoIl5GJWNEEPnO5A8rPmncfro/PxTXVLYi36VFdBCt7ldPKMhc5FoooX9Hf2BiwY9ucyzGbvAxz2J9tNrsE2yk=
Received: from BN0PR04CA0143.namprd04.prod.outlook.com (2603:10b6:408:ed::28)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 17:35:47 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::7d) by BN0PR04CA0143.outlook.office365.com
 (2603:10b6:408:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:39 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:37 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Delay PSR entry
Date: Fri, 18 Jun 2021 13:35:08 -0400
Message-ID: <20210618173514.430647-7-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6533613-4a34-415c-bf80-08d9327f8258
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:
X-Microsoft-Antispam-PRVS: <MN2PR12MB28638D8786B3539C9D1AC652F50D9@MN2PR12MB2863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kJV4fNm8d5YwU1l7S9fOIRU+r3eOh71fn2DlYW0wINbWAd8G/8YV4MBUwFl02NywtJ7Z5vcO9RtUkbNWKFYkJKhIOJ0EsT+SkPNn5rTmKiCQNeAlsqx+mrIszX/MJ1DKaqtb4J5VoDjBVwUfjGfd66bgXge4L90VqC4SF/buElC142Sky2RNP24v5ERQUfkA2uDABcWDnXE+yEcv6njAJB214E0elxUWuMmsLItsnWnpjkfuoQmBylXex8tg83EE+g8kTAZf5gLyiNjCv/OIePqigowxhm6SjQ7suBEwpekBdPt2r+FrFqV/GvMHT3MHnb2QuSACeJwl5uO+VxKsvXFFm+WjsQMBdmf5j6jziAFis5343slci36ogOEd4CUb3+w8Ik2QKdA2y0JxzP6iRAGxu2jlN11gVUTA+5Cgf4lk3ya9+MJpGRCX92pnEnvRxSd/mbLVGHhvYSRHVJwKZ6G4xWdHkIPAcNfQv7y4gssKnn2JsA0Yvl2KnhXEa407o/ejKyELmJUMGkjSPckzWcQRly9upXvd28fsR0tlq5EqKV1p8IxDwy4xrjc9gRI/4bK09e0UOHoPISoOfBCyninyq0FJbLDoXqN+HXzXiihcCOW+PEuThx820nZp7kg1q3NPvoJje46cnJOvlKJaW5XhPwQm0Pi06LhlUvEsUrTBjM8Wlxpwo2MfX5WW7ec
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(426003)(6666004)(7696005)(6916009)(336012)(8936002)(82740400003)(186003)(1076003)(4326008)(2906002)(36860700001)(47076005)(36756003)(478600001)(70586007)(26005)(81166007)(82310400003)(356005)(86362001)(83380400001)(54906003)(2616005)(316002)(5660300002)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:47.8295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6533613-4a34-415c-bf80-08d9327f8258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
After panel power up, if PSR entry attempted too early,
PSR state may get stuck in transition.
This could happen if the panel is not ready
to respond to the SDP PSR entry message.
In this case dmub f/w is unable to abort PSR entry
since abortion is not permitted after the SDP has been sent.

[How]
Skip 5 pageflips before PSR enable.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 10 +++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h     |  2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c3fbe35f07b9..0b21d011802e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5967,6 +5967,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket);
+		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
+
 	}
 finish:
 	dc_sink_release(sink);
@@ -8814,7 +8816,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
 				acrtc_state->stream->link->psr_settings.psr_feature_enabled &&
 				!acrtc_state->stream->link->psr_settings.psr_allow_active) {
-			amdgpu_dm_psr_enable(acrtc_state->stream);
+			struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
+					acrtc_state->stream->dm_stream_context;
+
+			if (aconn->psr_skip_count > 0)
+				aconn->psr_skip_count--;
+			else
+				amdgpu_dm_psr_enable(acrtc_state->stream);
 		}
 
 		mutex_unlock(&dm->dc_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 64cf5afbde6a..57996c364940 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -509,6 +509,8 @@ struct amdgpu_dm_connector {
 	struct dsc_preferred_settings dsc_settings;
 	/* Cached display modes */
 	struct drm_display_mode freesync_vid_base;
+
+	int psr_skip_count;
 };
 
 #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 57bbb80421e8..6806b3c9c84b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -28,6 +28,9 @@
 
 #include "amdgpu.h"
 
+/* the number of pageflips before enabling psr */
+#define AMDGPU_DM_PSR_ENTRY_DELAY 5
+
 void amdgpu_dm_set_psr_caps(struct dc_link *link);
 bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
