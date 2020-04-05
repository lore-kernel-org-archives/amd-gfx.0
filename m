Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE0C2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA95206F8
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dFoE9BZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA95206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1A189EB1;
	Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FC489EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofJy1feIQ6nRtsRHjr+CwY/tFxN5oZV2hn4tCou8QPvVSnqbM43IcwoG5F6TMopmvKi+eB4bthEos/aJZ8yTG1opt/wXpvu6JUNW1Umsp2mldn7U7WswqNhYHVs2iytdXT52RZzyRvffrEPWSvK/3neMcSXjtRuw4nGcJghwryVagcwx5X6JU4SiOVJgEs8ACEqD+ssF0H8JZ6VUqoVI/v0c2ilPglH/MAIhDWepn583vv6R4SqdOjc2IKKPCB1M12FIOBT+CxuNxfpW2RQRBcEljH3KArwYAZzLxcX6DmG+SH/nPbdmEjetfgxmf28ldTjCHmkC2MAhp+fCBC91FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n/pgZnpKLqVfa8c4w7Ht8tmmnIKQ8qStWPrk1F0USo=;
 b=iUaobtmHeiErCdFIBHSL4tItS4QFOAB/FN2xG5ZipwbmrKGb3Nue3+8J8kEnU7CeIX7mLHtzq7m6T5b6KBIRL1rJOdFDvFCjzpt3jAT3ADjzTeFqZK5rPtKLfV8dSDCvF0vih0mkIHyAEKr4s4YxwEg3YAiAuO9y8/ZT5L16gaG+qtU8ZyJ0ZOGTL8ZzQ07sJI6qOxrpEHIAFZFjEAX2wPAfNJgFLmX7ZMeh9sfRCkJ/N//b7Mjd5pAky2eN8/5Er3ee1MkYNH4JXx6QvEWj8F0YVahp7n31jTolwV/aWNZgI7r+FacuzPFba79CfiO4E5sLTf7o/dK46AHsNrtRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n/pgZnpKLqVfa8c4w7Ht8tmmnIKQ8qStWPrk1F0USo=;
 b=dFoE9BZheAo+3cXP46TmnFgwxGrl0OJ14ZOJ7WxoLChw2w3B9SK9ASMVAIsx+ocz7cKyrZMP8DDoxx+wuqCOqcRl9mMRkSx3jZinvq2vtbN0FqQLYTxME3PJyVLjIsFqJbXEe56ODNR6doXdYq/LOJheT+Q4CfQhGuEn0hvtBH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:38 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/36] drm/amd/display: Avoid create MST prop after
 registration
Date: Sun,  5 Apr 2020 16:41:09 -0400
Message-Id: <20200405204115.683559-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:07 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fe8d63d-3ba4-4e9e-0586-08d7d9a1cec9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555A64B49F6FDCC85FDC7B698C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeq7cDhxZsGbhhYPbND/jO3dUh9i0/98GGrQeDBLUjuXjVVTBG6CrEwUBJF6BNLKaNkgKflwtjsJyua2tdgDLsQnu4CEafekq9jIrRKVOShYpFOX2bFOqt7AqUk+lzLp+FttrL8gh2qFPQ5iblxSjtslTR9QgCFNM/FCxM3X6v3ey7L51skL09Fy1APuBAFDsaFM/yWwkJ944ih1kOTC0ghDXjQF3+1DdVJjfrpLBwRRsHMqZRLi/rmWoILf1NG6MnVMuos5qrizdZRw51ra99hQCG5MkGNsnG3vjdsLTNjkZ94898K6RCNQvCIJexW2lRxFd0LUNUX6VUmyN8F/AXcoWmIO5tixcqRb0kjmVmyaZoawZ7+NTJsFL0F1mWY3a/DQaSVoNR167/nixOWZSbV6WAlLIn8kgdHzjyzXeyWsZjfQBmjFd71cWrxCuJq7
X-MS-Exchange-AntiSpam-MessageData: ce7pKGqsMND6FWwjSzlaKqJ3dL9Fo/GMzB8Pd53y0Jow3/48Wntxd1U3+oPzmaYrEkFPLyfRQIHBTCJgHBzk1gb2pTLmZYBzn1tSxQrrmrgMLJo0M2+6UzbEe94rjU2C6B16yooUBpu96B5eWZ/qIbMGI7Ijrrj4smV1oTh+EME=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe8d63d-3ba4-4e9e-0586-08d7d9a1cec9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:08.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFOsoxx+CErttSgyE/l4hj6fRMC1R+HLpOR4hwoBK9WSAcoRrEQ/MVdRNJYxJ6kblXTfc3OpZccDt8MjLmdgsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, Harry.Wentland@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>

[Why]
Prop are created at boot stage, and not allowed to create new prop
after device registration.

[How]
Reuse the connector property from SST if exist.

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 +++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 8 ++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b791e6909c4..ca7489cbba94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6024,7 +6024,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.underscan_vborder_property,
 				0);
 
-	drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+	if (!aconnector->mst_port)
+		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
 
 	/* This defaults to the max in the range, but we want 8bpc for non-edp. */
 	aconnector->base.state->max_bpc = (connector_type == DRM_MODE_CONNECTOR_eDP) ? 16 : 8;
@@ -6043,8 +6044,9 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			&aconnector->base.base,
 			dm->ddev->mode_config.hdr_output_metadata_property, 0);
 
-		drm_connector_attach_vrr_capable_property(
-			&aconnector->base);
+		if (!aconnector->mst_port)
+			drm_connector_attach_vrr_capable_property(&aconnector->base);
+
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cc1b52b72c0b..b401dc44ff1d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -410,6 +410,14 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	drm_connector_attach_encoder(&aconnector->base,
 				     &aconnector->mst_encoder->base);
 
+	connector->max_bpc_property = master->base.max_bpc_property;
+	if (connector->max_bpc_property)
+		drm_connector_attach_max_bpc_property(connector, 8, 16);
+
+	connector->vrr_capable_property = master->base.vrr_capable_property;
+	if (connector->vrr_capable_property)
+		drm_connector_attach_vrr_capable_property(connector);
+
 	drm_object_attach_property(
 		&connector->base,
 		dev->mode_config.path_property,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
