Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FB3C43332
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AA72072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pyOPuMOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AA72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6A46E177;
	Fri, 20 Mar 2020 15:11:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CFA6E177
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8PaJB7g/l6vMecAvz2AvVZoYGCkGpUy8yox/aijddEEhWrEyxToJpd1Zrfx9ZjiRZtd5XUuhBciLtLAvs8g4XSRYY1GX1rkvN9wUu8z2rAGIdqIdN6qVrvXOj/0+g2BcVqPwDLVDiXWDZFyyySHduE3QO4kSpLJRflD4I9Fh9GuZIEzpUdUXdVvNvJumLtUI+ofLTPiZD5PwRULqjBzMSOqeEO20bchIbBqd9bGjcfvC3g6a8N2MnMAAeVFPPTUL7b2NihUOokDBRYmDVMm7Hv9pBu4srWYIBo2SKcjDtyBBNsMbdqwB8GcLACbHAnUFtbDxsQog/Sz5bVp8cGa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoRD5c4v2qqvywJZS1J+NRqA9x0PekQAHcFZzxVHj6U=;
 b=mAqts8hNmmkWNz7gXiNH0UqXVaiY02yutvzpo9H7e/WT5h9OSVM1lLHrdbv0gR9d4Y4IFud8ZPI66FJFeV9e9V8WUhHIrZHOL0VDHhssp6m7opKKqR4mnf6C26odH7eVJ66/5vCFOWnh0GjBFg/33FqSsp8f+/fJmcbW90fHr7pkMfctSeAtq53UR/1Ufw8bdw+mmEImWDoW8K/LZNOkmKM3LJvTIS0hVveYDD7tFK3s8rxfRYgDbTset4Yc7U1f3JVJg7Cx97bZFzw75TRKcaW19PxKo9pwGyg/1LAuNrgWCLcWEMTh2tJbCEYe5ECUpLelI1Wr3g0jujAtN5bl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoRD5c4v2qqvywJZS1J+NRqA9x0PekQAHcFZzxVHj6U=;
 b=pyOPuMOwoMO/JdCX6h0hrtErXxlhwPYKqRX2HBUH1bAANU5rGqzBeW3vtbGQD7267wccrLdL9zhfNGih4aPdDkBRO8nqT7to0ZkMXarPEm2iqsHyZ6PJtg+Al4hW66phxBtbt23ofcSyIpDPc9DEewT+gLLu3Nqj8T+ObI5AnY8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:48 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/12] drm/amd/display: Support P010 pixel format
Date: Fri, 20 Mar 2020 11:11:19 -0400
Message-Id: <20200320151128.2039940-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:48 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65036258-a88b-46ca-7e2d-08d7cce102fd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572DFFADEA0DC5BCCC6904198F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOe3jPCRg4KaDnOjOcWzGxGh7IE7ISbuYs6KUjcAWpiF2e5TRs1skIPfCMFedy72HFU57NdNzH3N29WvyT/SPwoG3Z1SlghqhpZSDhhBSqUYpkIoI2RNAhJ4OCu/hgH2blT/0wpR96IWHuYM82l7uObyXdib1YXPhr7vqGv5dgI0U7Z6KmufQQhsJ8i0IUFq3Ee9oDd+MZZIVtuCWBUljmueGOvlta6Ul1rSClRcKwMm7AJSe+AuFi1/Mz1zj6lvsWgv1Onay8jRUIM1LcnjqczORBHcKWDtlrow2Uk1HksAO06irIyIVInhMNzWtgaEIyzjDTJtApA3pTYwQRLehL7rIiU1jZWzJOOZVCcblU9Le0IWjoGH7QhF0MTKhmOmusjaOK16uSdGhBEXYtqFTg3rADpM1IuKxfrTz1CV4Gi3Z/hEVN9ByFQmvxPLD/HF
X-MS-Exchange-AntiSpam-MessageData: JFHMVipjeeWUC/Dz8mBI+97Z4OQbLNXEJ7mgZE3PYuIsSrXM4hbg94UKfQ1B5H39LT68r3f8qfKnmjtX+jBqkp8+P+JRgi5zIqguXTXg9pLPi5TaDHH2gO+pEQQ/IwEJaVDAGk25+9G0Faw0O7EeFvFtXdVxzWpkBvsJhA+KwIc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65036258-a88b-46ca-7e2d-08d7cce102fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:48.7578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5OUKMcFqwonTqRDBdoF0Lo/iLjD+lP6NmfgBXU38/3eiaNcZBzmRq66FK0Lwzo3NvJZBygtGGhON8U0KVIXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
 Stylon Wang <stylon.wang@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
P010 pixel format is not declared as supported in DRM and DM.

[How]
Add P010 format to the support list presented to DRM and checked in DM

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 36794f7c6232..32d946fa7d89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3706,6 +3706,9 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 	case DRM_FORMAT_NV12:
 		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb;
 		break;
+	case DRM_FORMAT_P010:
+		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb;
+		break;
 	default:
 		DRM_ERROR(
 			"Unsupported screen format %s\n",
@@ -5617,6 +5620,8 @@ static int get_plane_formats(const struct drm_plane *plane,
 
 		if (plane_cap && plane_cap->pixel_format_support.nv12)
 			formats[num_formats++] = DRM_FORMAT_NV12;
+		if (plane_cap && plane_cap->pixel_format_support.p010)
+			formats[num_formats++] = DRM_FORMAT_P010;
 		break;
 
 	case DRM_PLANE_TYPE_OVERLAY:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 261bdc3a8218..8b7122249ddc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -552,7 +552,8 @@ static const struct dc_plane_cap plane_cap = {
 	.pixel_format_support = {
 			.argb8888 = true,
 			.nv12 = true,
-			.fp16 = true
+			.fp16 = true,
+			.p010 = true
 	},
 
 	.max_upscale_factor = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index a67395208991..54e096055c6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1012,7 +1012,8 @@ static const struct dc_plane_cap plane_cap = {
 	.pixel_format_support = {
 			.argb8888 = true,
 			.nv12 = true,
-			.fp16 = true
+			.fp16 = true,
+			.p010 = true
 	},
 
 	.max_upscale_factor = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 51b5910cd05f..deda1a6b603b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -838,7 +838,8 @@ static const struct dc_plane_cap plane_cap = {
 	.pixel_format_support = {
 			.argb8888 = true,
 			.nv12 = true,
-			.fp16 = true
+			.fp16 = true,
+			.p010 = true
 	},
 
 	.max_upscale_factor = {
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
