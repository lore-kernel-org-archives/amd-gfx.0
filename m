Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B606FC35263
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574AF208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uM7+ovew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574AF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B4A6EB1B;
	Wed, 16 Sep 2020 19:42:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77D96EB11
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAX6fH5shBuj9EVco33iQWcAM2vz6BfK8/Tod68Yb98pyeRF48Tl323jQ14r5nqmLwxhZBPRh2HXhx72qGOLfy/bDHNjtpbdZp0p6fBerqUw0o0wJGzgMaf16BbCG0DD/vmHmTt7p3oP7kBYH1FW9DRQHCRNb5eGYjHtQymYL4Lr2s8D+Wt5fXfJN/Jl3BHCaSsXjUnN81WSQWRmf2FJgiNUBiZ8p6H6a0JX+kKTg5k9ggi4uNJwtv6XeB7u+mcmXH9z/BXEaru36rsMzR9A8+6lpv74qujcGvq5wzllkSxHdShHUc1Bar5pspWUaQo4bfRWgxoHToQFf7CmTmPCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr77ZVXBEp1I4DrlbM0NyvXw1AASPgqmhcdgx06tbSc=;
 b=cn9abjnfYnqRFg/Axb+kebFRweZnAY9iqbVV01uzbbSc0LWOp5RgFCsMAxoqv5e6uLW2h5GcsxYMVLoXZlQIYd6tDIBcBWmaCoo4xiUjMdBpKj2PPMdMBCyGGRUGKErQm4k7B8BvCPaZHDKjMkx+fwHTZ9VPDLH84ENdvFgm3ynlC4qgUBqvAcONuuHELX3hdRUtMb7coZXhvgRv9+i8aJRRR0M81Ia6/DTXac+gmEFDi+9hhGmjr+8GQVPNhgOQf0stVGOgl3ovQwI/WgGOIfIPybGhTbzdo5Dgb7TdDpQVAU9CZYoOe/A7nW693DtVKLN7Ppz19lGQpjLLByvQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr77ZVXBEp1I4DrlbM0NyvXw1AASPgqmhcdgx06tbSc=;
 b=uM7+ovewHFEpJ2U9nDWDJavW5GWZQfNTnkRdJtAmu+9KB86Nc68/fQw1vBvM+RzLXLE1qA+PSHCq8XO1SAn0qXdJkW7CfmH671u3TiMOaXdYsALrx0ue0sInuFKGvuT1LKswfqii3Rxeugcu//mxU0Xfmth2QKUHDLcUAjDR0RA=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by DM6PR12MB3545.namprd12.prod.outlook.com (2603:10b6:5:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 19:36:45 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::3b) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:44 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:44 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:44 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/15] drm/amd/display: TMDS Fallback transition
Date: Wed, 16 Sep 2020 15:36:33 -0400
Message-ID: <20200916193635.5169-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57c87fd2-bc44-435e-c255-08d85a77d8a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3545:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35455BCC857286E5DBAA5E21FB210@DM6PR12MB3545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94gS81ff3G2uALTR8zlKtHkS6hbDEwDxchL6JVbj5a9+QwhdVOvTh2j2lH9UX9YXjQgc801rVOtZdI1lam8coRBBWFYN0ex43ZoDYZ2xE52l9+nSlp/SXkgJH3OeCRdHHvziD+k4eVALdprQhAg2FlXoFTkfrvajODmSr/WgY8aVo45t78AB1HW6T5ERFGeLXHNiO03P4ATuwIfTA1V7oFu9U6ftNhGfw2WmsP3wcp58LJwj4fn62Zsn/StBVmwrMTdWxFt5hpEUh9FsA2HuaPGjoF/quKoh396sutFvQu+rOBwdN37wYO3ui3FsafduRZoqGjDzPYZQP96mlS7GThOfDUTPSwohCQ5HB7O1yYByVYdguwCQmei1b/Y3R0+zQ9EmLz8c6bCRE1SLTUmX1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39850400004)(46966005)(86362001)(83380400001)(26005)(2906002)(54906003)(6666004)(8676002)(70206006)(478600001)(2616005)(186003)(82310400003)(82740400003)(6916009)(47076004)(1076003)(316002)(336012)(5660300002)(426003)(81166007)(44832011)(36756003)(70586007)(8936002)(356005)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:45.4113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c87fd2-bc44-435e-c255-08d85a77d8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
HDMI requires fallback to TMDS by redetection
in order to switch PHY settings.
This avoids black out when link training fail
during mode setting, link quality update,
disable driver sequence.

[How]
Allow driver to redetect HDMI displays
based on retraining or fallback mechanism.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h            |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0b9a4fc642ae..98b4d5e2e336 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -158,7 +158,20 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	u8 dsc_caps[16] = { 0 };
 
 	aconnector->dsc_aux = drm_dp_mst_dsc_aux_for_port(port);
+#if defined(CONFIG_HP_HOOK_WORKAROUND)
+	/*
+	 * drm_dp_mst_dsc_aux_for_port() will return NULL for certain configs
+	 * because it only check the dsc/fec caps of the "port variable" and not the dock
+	 *
+	 * This case will return NULL: DSC capabe MST dock connected to a non fec/dsc capable display
+	 *
+	 * Workaround: explicitly check the use case above and use the mst dock's aux as dsc_aux
+	 *
+	 */
 
+	if (!aconnector->dsc_aux && !port->parent->port_parent)
+		aconnector->dsc_aux = &aconnector->mst_port->dm_dp_aux.aux;
+#endif
 	if (!aconnector->dsc_aux)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e002ef706e1d..266b93a705d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -237,6 +237,8 @@ enum dc_detect_reason {
 	DETECT_REASON_BOOT,
 	DETECT_REASON_HPD,
 	DETECT_REASON_HPDRX,
+	DETECT_REASON_FALLBACK,
+	DETECT_REASON_RETRAIN
 };
 
 bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
