Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4CC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB83206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qqK6khIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB83206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0086ECDF;
	Fri, 26 Jun 2020 16:19:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8CC6ECDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k91UTQV34O481r17KaDi2SoL7p153e4nFa+hliqedCNliio1+luHryGFWCExWTcYIWrHOsk5mW0E0Lz6gwPXAI06gsZTJ9ja94P2BbKiUoWqowFOAhF+yPR+pR73pA+hjQt32fMQKkpzNkt7fx8Hvy0ZOYAAIORoskPyZThc2yLu02nx61nx+tKDtyhDqTssGXwROd4HCKlzB8NDn08I9SUixd6AWAf5g0DyaoyUeBr9BN1azRRhY5ppJ5s/WG6326Af5fvt2E2sxa0XQ4Ao2eP6cmnr2bjB51or5HT/rWSYE7ZLQIIe2qG5AniEKSL8m8RKbGrXGgqzKsOE9KfxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGDqqucdTJ70M26p0fB7QcvUV1+KRO7jupkI3U0IEhE=;
 b=J973/ulLAev++QarIU1YJVg5dVNduavZTBLKNBLwPOa2823mhX+OmiyWTvlZVggcLo816KpCs/W3cgmgE+BwvDenVmg44IYVGiPn0Sm49qNpTRQU0IN6V/HCR1hy/cgsAmf9FkCj92FvNiNbVaRa/PlJrn4tMaucobrcpVRgKZhs1srPB18jsRoYC09p1ltLbtgeGiedCR2BVjYKBqBeUttSntExaHXlaSNouF73N6XhU/6joc/qC13NMU1StEPq3SGbsydI0K85cVg0Uu3lYORSCaiCLDKK2stDhpiF7fY/3wwo6aKC/hfbRzqzqMelwYTleqNb0ga3rBeJvQzJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGDqqucdTJ70M26p0fB7QcvUV1+KRO7jupkI3U0IEhE=;
 b=qqK6khIE5RUD/7HeJTMLBuuHN9Ycj/SLTwZqllEbWxS2m6yDD5wZKU74vxBJvVLE3Ot4S/jFNdgZFobuQloxqTqrXiGFDV/Wmrx5LvnUFinN3zNRC2Hgg3hNHreeaj7COP52EEg+o3zjiq5pAOLKceO72AgbVsuozXAVqAvBnUA=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 16:19:54 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::dc) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:53 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:53 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:52 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amd/display: Add register key and status for edid
Date: Fri, 26 Jun 2020 12:18:45 -0400
Message-ID: <20200626161847.16000-10-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(4326008)(478600001)(2616005)(8936002)(47076004)(81166007)(8676002)(5660300002)(83380400001)(316002)(54906003)(70206006)(70586007)(82740400003)(44832011)(2906002)(426003)(356005)(1076003)(86362001)(26005)(36756003)(186003)(82310400002)(6916009)(336012)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41296e4a-75ee-422d-c70a-08d819ecc28e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4257:
X-Microsoft-Antispam-PRVS: <BY5PR12MB425718DCB2771B81E3740A84E5930@BY5PR12MB4257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96+115qFqPl+t14OHP0OkgNxfMHcE2s3I0lrfnpmx5ONxNYGz5SPfpyStAsFZsri5Aj5yd02BROUlgBraVVv5AUm406S4NGCOJZu5WrxkDcsO1O8Eigt0w2FJsFtgvFv6BuF9JmBC/xW0a2Cp7Z+UKEPdZ/veaXqDlVsNGTvH8AiRLqIc0lwQLGj3wJWc+ns2FQSJE0lPJPMuH0aoo7MHNE8YlYyCLPxwacgc1hdQwuICic/YDOsDlncESknZFdXllIkYuItNvU/HeLW4Hc4MZ4oTEXEvevQBryldriayVaNJlJbuxMJXdnbI788RPFj34h/+bpus938s9pD2MytWX06kUjqyiWLSIA+awIIoILZucg+85L0uo1claZsFsbfD8UwK+Mkcg1tqBqc0mEF1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:53.9218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41296e4a-75ee-422d-c70a-08d819ecc28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, eryk.brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Jing Zhou <Jing.Zhou@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[Why]
Register key for AE or QA do regression test.  New edid status for
check.

[How]
Add register key edid_read_retry_times.
Add new edid status EDID_FALL_BACK.

Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h       | 1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f7cb1354a635..01ef2a3c1f3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -466,6 +466,7 @@ struct dc_debug_options {
 	bool scl_reset_length10;
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
+	bool edid_read_retry_times;
 	bool remove_disconnect_edp;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d64241433548..29fe5389f973 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -177,6 +177,7 @@ enum dc_edid_status {
 	EDID_NO_RESPONSE,
 	EDID_BAD_CHECKSUM,
 	EDID_THE_SAME,
+	EDID_FALL_BACK,
 };
 
 enum act_return_status {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
