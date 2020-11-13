Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7702BC63699
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187932224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pOCvFKZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187932224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75ADB6E83C;
	Fri, 13 Nov 2020 20:58:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B0C6E83E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7oSMh8sstEMxKkT0BPLYdLqpq8yfuCBDuBeaCyNpYE8QQPtu69caULwxuH/zGUfP5pJvL0ojmkc+/82B70FbFbMY8Exm6duK3cQBUve9HP4Ue17xYH75pOY+6o/56CbDvyI/rWr5VQUDVNfLvAu6KG//UXgrriIkrmchV/JP47iuYh1r3xncnyU7YUUShZro2aW0bextGG1T05lhuOXLGwO9bFFmbLnKbGe5Q2/Lmyc3Dq70rCOzhKTOYrCM3OIC6AUMX3rmWt9x84ZBX2cajW+SlWtujuGMNjLcKjXjLWdVjIW6dCi+5bEtIcAZ97c5HiYwunSe/oTYCFkq2iiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ29hfk+vrOAVKlzpgzuvWyyhrMM9Y9vdYdrIEDfEak=;
 b=eIF6SzNhJzz2fxasYTyIH0u8f9h77K5A5GtGhHFPNwaH/aOJa35Np2s+FS80VVJpLS1BwlDyNhPwpy9XNry47QcD2K0+mXeFge00BrMqQySVn9fFfVI09kqcH7NMeAthyvZBTmX4TpJcVCPmzW5KdIEpMPIkyCs/NcdE0QOogV6Lb00osAhvq5qGQIaQ59iRuSffCYJEsR6vCYJnVQxlvav3ufLVUgfwMt0znSdFgSBEaCXQK/hNhwIy7eyDhir/ZjhfBdPVzUgNfTr38bQ1HuDnmo0t5EGbNmtJpaOaKCQfiHItCTVMuQfBjbK9aDh5ve5iJcKWpj4Ek3kc20BtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ29hfk+vrOAVKlzpgzuvWyyhrMM9Y9vdYdrIEDfEak=;
 b=pOCvFKZYAGtQGZuIW97/oTTe7HkyeNQ1lMmEBvPEZtmDlfF7Weq7dkURPeXhRKjUvzJ7ybz8VF7/J8qaY3UWQkRVAW62DVRMtjt7QE81PXOOsD0i+lS2N/aOAuM3K6ORiO1XB9LIwKcG2wIkmsaXHy0Xxeqv8vXchFwT9tbh6Do=
Received: from DM5PR2201CA0015.namprd22.prod.outlook.com (2603:10b6:4:14::25)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 20:58:04 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::38) by DM5PR2201CA0015.outlook.office365.com
 (2603:10b6:4:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:03 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:02 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:01 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/17] drm/amd/display: Detect dynamic backlight support in
 eDP sink
Date: Fri, 13 Nov 2020 15:56:36 -0500
Message-ID: <20201113205645.640981-9-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2ba3ac3-2125-43ed-ec71-08d88816d02a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13099FA65DEA8040532598C9F5E60@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqNysZyvK83XxBdiQnI6cn/MeqIfr6cy2+6nfSnPhohJeGl9ZV6cc3tr6mddrhikWQLv3WXGh+UJLNmmUTL1AnloBkNjULDUWZDILUKS4RgSreSqwNPzYi5GGJxNH/8AqAEE6OSBe9Xf37VgIsPgdZAMWppnCo+EYoNHsVLcAGu60J/C9a4kq2nlfQUqd36C1UNiLCJ+XZipYuL2tSa1F94DN0Af8Ro2mIX5473I+WfJUBVxYtEA3+0dzmicpgaa2c414KP8sSzJ3SS+la87ibod9Zkps3+dfiMN9eeqZQwyTL+rimduUpOaU/qcRJ3tFnzYMbc5uInSJG1fUGZjOhfs//QHPl2XtiPj993JV7Z+Qbfxns5L/cOnMXRGN8Obb9/PewtceFP5UVgHjcMI7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966005)(356005)(2616005)(8936002)(82310400003)(316002)(1076003)(2906002)(54906003)(82740400003)(478600001)(86362001)(6916009)(47076004)(4326008)(81166007)(7696005)(36756003)(83380400001)(70586007)(8676002)(336012)(70206006)(426003)(6666004)(5660300002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:03.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ba3ac3-2125-43ed-ec71-08d88816d02a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Roy Chan <roy.chan@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roy Chan <roy.chan@amd.com>

[Why]
Check if the eDP sink supports the dynamic backlight control

[How]
Query the dynamic backlight capability in DPCD (eDP case only)

Signed-off-by: Roy Chan <roy.chan@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6c60c1fdebdc..c9f4f2d3bed6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3740,6 +3740,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	uint32_t entry;
 	uint32_t link_rate_in_khz;
 	enum dc_link_rate link_rate = LINK_RATE_UNKNOWN;
+	uint8_t backlight_adj_cap;
 
 	retrieve_link_cap(link);
 	link->dpcd_caps.edp_supported_link_rates_count = 0;
@@ -3770,6 +3771,12 @@ void detect_edp_sink_caps(struct dc_link *link)
 	}
 	link->verified_link_cap = link->reported_link_cap;
 
+	core_link_read_dpcd(link, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP,
+						&backlight_adj_cap, sizeof(backlight_adj_cap));
+
+	link->dpcd_caps.dynamic_backlight_capable_edp =
+				(backlight_adj_cap & DP_EDP_DYNAMIC_BACKLIGHT_CAP) ? true:false;
+
 	dc_link_set_default_brightness_aux(link);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c57cf099b5e..52e819678ecd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1091,6 +1091,7 @@ struct dpcd_caps {
 	bool panel_mode_edp;
 	bool dpcd_display_control_capable;
 	bool ext_receiver_cap_field_present;
+	bool dynamic_backlight_capable_edp;
 	union dpcd_fec_capability fec_cap;
 	struct dpcd_dsc_capabilities dsc_caps;
 	struct dc_lttpr_caps lttpr_caps;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
