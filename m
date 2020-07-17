Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66781C433EA
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9BF20737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jZh3PaGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9BF20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822056EE1D;
	Fri, 17 Jul 2020 17:38:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629656EE1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnomd4CjAfD5DQsmrvZQ5+/McVFp0VnCMV1Zgcr+exgJoFAJmVWcVZ4PWFpQJJQGPwMf3SqY7ec5/rqxKQrrK1V3QlluZr4evRd1WhTgPFen+Sgwn226LY0y549s0vd9ptB6CcfFYRjlMy9SymFCa5QAXmLMH7ZCvpdpTyfu1/AZABb2FQ9pTaw5o3pf+vBjgmtdEOhz8LYhqyuEpo5DUV2G7et2Vr1/o0BFLVLfwuwlnHIdUTMW7UjzrcCslQ45jFxD8T/p1F0VACQjo8I0qrSEjXiFwAJO+Gr3Qd3Un7BUS/Dg0coTyut1TlAlRhXiNzpBFE9jZCx3VbYJen1kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1Qb3d/pBj5bjszZiyfYSA36tt8nBmWutIwTnw6+78I=;
 b=QoTYB3SOEYS3EX5BlgSff6bpgTBchrARXKiTdODua61VHzlPSJU4ARYpTStMLqLSHXX4oCAtgyujRoOFyhBJkJmk8eMpjfw6u5cbaEVQ+I/moFLHR8e780uYM3UJOWCEaALGHZ1Kx9n2g4QJInlL4R/v/frewET48L5Dqu76E3HoS5RNsjxsdpK5ir5gav+qC4k6JEbKdO/YHLGeV+CYE6vJIywLoNE4oJTdWJboldqvTZMauEandQLfv7D3F+3r9/twEajh5jbaOrKIH1PB0fJisnT4bnm1Z74tw9Alae3xnGZKqSDtfoONBuJmUl6wSx/cZTHfGmOz6Vg9YD6FFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1Qb3d/pBj5bjszZiyfYSA36tt8nBmWutIwTnw6+78I=;
 b=jZh3PaGwKH2rSbC7Rc/5k3E1voWi+E3mTg/fVizyO26umXB08nY7JL83y540ZlH/eRsx8znee6mrCjEvOKnIdytCeZf5vtxOJN8aIbu/ZLYseAPYWO9uskMopR5I0H2XuvAun8jjdM9HwTQa+ok5uud5cTNaA/l5Ug17dKzFavA=
Received: from DM5PR1401CA0021.namprd14.prod.outlook.com (2603:10b6:4:4a::31)
 by SN6PR12MB2813.namprd12.prod.outlook.com (2603:10b6:805:69::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Fri, 17 Jul
 2020 17:38:27 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::b5) by DM5PR1401CA0021.outlook.office365.com
 (2603:10b6:4:4a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:26 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:25 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:25 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: Add additional config guards for DCN
Date: Fri, 17 Jul 2020 13:38:11 -0400
Message-ID: <20200717173813.11674-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(1076003)(8936002)(8676002)(2906002)(82310400002)(356005)(6666004)(4326008)(54906003)(83380400001)(478600001)(81166007)(44832011)(36756003)(186003)(26005)(70586007)(6916009)(70206006)(82740400003)(316002)(2616005)(86362001)(336012)(47076004)(5660300002)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df24dc83-b777-4f39-e629-08d82a783645
X-MS-TrafficTypeDiagnostic: SN6PR12MB2813:
X-Microsoft-Antispam-PRVS: <SN6PR12MB281374870D67D92445C89050FB7C0@SN6PR12MB2813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:168;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfWd+O5T3g6Beu8gLku3K4z4+48+4veAdY0Fr8uqewVYIjOyaEAVsiKyQRXEWs+voQ54bjscV6EQa/6AVL+QvzUbXNaQMpmGNrmBPe6kh3rux953nLLNTMPIul4uaGKGKedsBAipf6XAHZvTEDkoU9DmWAkvK6jSE7wf5afmfpa44gdM27lkKGZyofmI3tmgweGpGRPc1clGS9fZekWRDMMKBMep8sB5WRv+f650rRmxGsguwJFXC19WsWA27sX01DCe7QZecGrbWsghHg4DGLebwjq/D7PJ+4HZaHm6Gv0Kq6gOfDrCdIWvV/8Tg0zKCmeVieXbbdtp640nbsw0nInIcZz1A/2yEER/Gwd2A2m8p9UABsKyYYv7KBPMDxF8tQTnSDuJPEfUlN3WlzRoZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:26.7088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df24dc83-b777-4f39-e629-08d82a783645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]

Fix build error by protecting code with config guard
to enable building amdgpu without CONFIG_DRM_AMD_DC_DCN
enabled. This option is disabled by default for allmodconfig.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7d78205d3604..e97f317179f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8564,7 +8564,7 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 	*out_type = update_type;
 	return ret;
 }
-
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
@@ -8587,6 +8587,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 
 	return drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_port->mst_mgr);
 }
+#endif
 
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
@@ -8640,6 +8641,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->asic_type >= CHIP_NAVI10) {
 		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
@@ -8649,7 +8651,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			}
 		}
 	}
-
+#endif
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state) &&
 		    !new_crtc_state->color_mgmt_changed &&
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
