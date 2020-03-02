Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E15C3F2D8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABF421D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ARTm+Tdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABF421D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74B76E5AE;
	Mon,  2 Mar 2020 16:48:01 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746C56E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExzJuxFhrxvSpaOHil8dwR5O8SjxTbgBSOiuWzgwBDL5c9zUvy2UZb+TfTNd9+lV4JfVVhBVBfXuG8rjWoErGSlaeY+RBqzWhKK1NQWTEVTICL5ag8oxPKcTM9NnnlbDI02Y3HwZP5SJv2Wc3NHOmQAjXF1cQjTmwfhKq0oL6TMENVbdUPvVJmWEviJzTZw79I8DfY15yhgIjr8XL6an4aKEd0APQlON+84JrPHefULSGq/dUjrYOljSqiT9MRSr6mfLdIHUzLAWdk8yULXXxtDotHN2R73FGbjj5k3/HdpceNpbu6vb8hh+hTey0c5hrUmc5JIpB3W1QMOcOSnxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEQ5uEunDhum++h6zabEAoEgTboBxjYKDjVszStUCzc=;
 b=AhcAvrQVDFD1lbb39jchtD6CMtLCPQK94BIOrLgAraKLt0Elqot5KxIpR627omNKbr9mspo9pj3Mo96iCSIBvjbZrkpSLUx8j9mt/t51QDBQ95fUpUve35MF1o41PmY7IrbPwi5H3L+7ZJP6TeKuwoIiOccRqC9wN1xdqOyTceUYcye3RnJE86E32Yy1spjWReOdUBApXDhQapmh6F67C08SVn3zC+o49t2xFg5AcrBVIYYb3/tjlZ5xhtM9N9Q+73aTZ1lU6qEo6x+RIRL8/lWqPZNqj0fMeSugAyjnpFozjL1xuj637opnMwp+VZuuTqLFGDjyRf/Q33oMBAfxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEQ5uEunDhum++h6zabEAoEgTboBxjYKDjVszStUCzc=;
 b=ARTm+TdbPDimMJyJk7p3MzlYXDeL18ZbF3lE8T22hbFcG4mkho5+xs9MxgLAgIWLZynTyiMe7kWQQnS+LlSF2UYmuNubgMCD9VPoCv8jFQWt3/OV/o0BTBUqZs1sx2V/TBxFXra3p4nEEPp5K9NYFw0NKNnBxd4o5fYVhtpy6jw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:47:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/22] drm/amd/display: fix typo "to found" -> "to find"
Date: Mon,  2 Mar 2020 11:47:21 -0500
Message-Id: <20200302164736.89429-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:55 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c138149-7b01-4ebe-2394-08d7bec9752a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24112AE7272E02D92AED0DD598E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002)(37363001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Z4TwHiuZyTSoDvL1ePf+4dRYr+6tBFv8fXKGfmN1PZX2gbKdbUUCUZ0p6I+CaFAmGDb50+MEIO0Z7knhLyedthPbPOHYt3x+9aM0sZoAOFn9k83Wgcxqx9aaGD7hy1oh/lVC3bavnbeFf+uCsBKbftdQcIs7ZhxLFj+t+iTaDyZpyJTqj0Smgl83zYea88+5Noypf8HDEs0cQD0CXVSP/MnECExg4t4HSHhjKnUjzQG3lr4FmtFOYMP8LDLFqYquDyOjr2R2wRsecF5quqQNplU/k/CJ8ojOfCmBXf+pgnYNRw4ZU8QTVa77HeP0BOYxfbhRtQ8JThOnm7rUFobba3SiEF/1/oOUJHdY2McZladjKB1241yAMt8bdYKGfiat2UldqLTbUk14bzuPbmG911xfPEcEw1heSRoC9C2kQBFoDwYdAPXJev97d/t+xO2gBOf//KCDhTuke6QOL+FXZ2qusy6DIPFqbMrxgWkMCEIzoJ/S7zaCl82/KbIfMNU
X-MS-Exchange-AntiSpam-MessageData: roNVNMBeqhhYAmBbcYEVH1kB/4sqqv7OqGARLMSnigwawh2OQqZ5oCD0OMkkoa99zG4j5XdwLs0wYChlFkiPiZMznSGNTR9G0B5EJWJPyU2Nq+W8r7+1ew95Yc5TYG+Vc+5JFGxqWWwnhjvy4YKctg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c138149-7b01-4ebe-2394-08d7bec9752a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:56.1913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v47mBWlh8/oI6+xtGNO1n4lNWEqLIQbqDRVh6gNq5A3h2Pyqrv1OPFqooQDAx1krWjJhOhx2dAfoolBCCbQ4Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Typo in amdgpu_dm error message:
"Failed to found connector for link!"
[How]
1. Replace with:
"Failed to find connector for link!"
2. Fix indentation checkpatch warnings.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 318b474ff20e..2f2b0eb4ebcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -400,8 +400,8 @@ bool dm_helpers_dp_mst_start_top_mgr(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-			DRM_ERROR("Failed to found connector for link!");
-			return false;
+		DRM_ERROR("Failed to find connector for link!");
+		return false;
 	}
 
 	if (boot) {
@@ -423,8 +423,8 @@ void dm_helpers_dp_mst_stop_top_mgr(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-			DRM_ERROR("Failed to found connector for link!");
-			return;
+		DRM_ERROR("Failed to find connector for link!");
+		return;
 	}
 
 	DRM_INFO("DM_MST: stopping TM on aconnector: %p [id: %d]\n",
@@ -445,7 +445,7 @@ bool dm_helpers_dp_read_dpcd(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-		DRM_ERROR("Failed to found connector for link!");
+		DRM_ERROR("Failed to find connector for link!");
 		return false;
 	}
 
@@ -463,7 +463,7 @@ bool dm_helpers_dp_write_dpcd(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-		DRM_ERROR("Failed to found connector for link!");
+		DRM_ERROR("Failed to find connector for link!");
 		return false;
 	}
 
@@ -483,7 +483,7 @@ bool dm_helpers_submit_i2c(
 	bool result;
 
 	if (!aconnector) {
-		DRM_ERROR("Failed to found connector for link!");
+		DRM_ERROR("Failed to find connector for link!");
 		return false;
 	}
 
@@ -538,7 +538,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-		BUG_ON("Failed to found connector for link!");
+		BUG_ON("Failed to find connector for link!");
 		return true;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
