Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848AC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8006320657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j/rULc6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8006320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 493BC6ED28;
	Fri, 15 May 2020 18:14:02 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFED66ED24
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDnI0EkZBP+dJxLQGaYuV76wNvk7z+tAzRMQOAcyGqz1A13ymb7o3Zh147/KU/YHdvRP/BByFU6buaNow/Fi/Mz7fJZDKHxYID+8FHpd9qr8gE3GXPfVxSiFdVj3ygdPWGz5QZiomMrSAJwWqnDQXfGFIOjtVOCpNzMrajICB7lEJ07Z16Ay0Lv7IoPv/Pq2MRIvbqeSLqjN/ooMnVhZoqywiVXV3L+7h4zRLvxRv3yK9omxYQtqRMunkcuR3vOuGxw7jgUV3KgBsr9Am9NtwmExj1mHV2RsAylpgQDT1FE1JkDlxjciy6kC322YFOdIN4M2QV6DGgBRAgD5fVitxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGOIdW6oWBAiDVWtCwZeEBXbNw6TbvoPEh5ecYKNTPo=;
 b=nWDLGJlDn2YOEKvSzsoogp/sI9Z1RUa5mcn9kLSReHqyl09bwOw3i13r+l35Af0llb0JG6guCKh1BGEr4ImgD1LsvS3fgOgT4VLbK2K3B8GGa30qGEEEaBECglhS624KQnN+gXl07u2Po+rp7tIRQUYsMnjE7NAbDFg/ZpBKoKPSSiKQXqjq1779YQJHT+ETKzein612uq0n3lRNho7kMvOEhqX9PtaPImOwTn+5ZPDhqBvYVy712NVzZgkRT8H/zTvdZmPzH8XdTuXOZA691z90Qb77phbp/gf8ESPnMD/zsVV09z1nWgMPKqbf+b2PzsZ6nKzkAY7AxujfS5+h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGOIdW6oWBAiDVWtCwZeEBXbNw6TbvoPEh5ecYKNTPo=;
 b=j/rULc6Dc7MntOwBVBG3mfNLPgzFC6PV4ycZTqFWcsNMYSv0mUZZsSJB5AZokLIbLni447htvpoyZ3S/6wWbaNQccJf8U6QzklzJ90PHwu/4PWdUJ5jOO/elODIUZ2+qJcUIol+aCInOc6CFQIT07jRhvQGKg16sWnGhEOmIWXs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:59 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/27] drm/amd/display: Add DMUB firmware version helpers in
 DMUB service
Date: Fri, 15 May 2020 14:13:08 -0400
Message-Id: <20200515181315.1237251-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:58 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e32c9281-54db-482c-ed7b-08d7f8fbbcff
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB397475E8A05AC63000EA0B8898BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wfW1yAZuYMdz9ahBZMNAqMlXZY4J2uApGkVr3Y/mSckXn/kzeMAlzl0UFi4O+suRuX5z23nQU1hvStulFHX70kHDpCj3DuPnGqURBOZhKmDi5q2GNUKSlh0+vpvK6itduwVpoJmsQcmIhBnUc8kZBbriK970d5SboXBk+u8aHzlYya4v4GqJuvQuqNI7iLBO8HoSPeO6mIsYKpullEW6SmeX4kyHzP8OG/PZ2rgwmLBbiGciXD8ce6L2iXc4I2wcWJy2JdRN3ZFafCMMrwiQ1gCkgRv04GL7TRD/mav3XyszxbivBhXgQyfRRONB/kRqZ2vQ5LEpzjnxl/0ZRM24gRsXrfmIlnsSp/Hu8B+GQm4yaE5u4c8tSXxVnF4KMoXRTifYlFkJ9jnFCOe24lN3s3Sj0uA/xyxzBmrfWUQqXWvAYazBLgj7qwgAdntKuw1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qjJDta5oHq8FlwFKlX0dLyQHJDBYa1QXf+Hv+W4YSzXsgGHJPjEc2+1gfNDHMjJ5yjcdmObfDK46DrZq/fd5JAI/EczbzO6mjVXC4h4RizQC5x0wa/VoOMbKuzF/Rr1wOzg2L/rzB9+GsPLAAw6gbesknvLOtxe/fV4Evlw+9amAaRCQZi7cIv4qt57sFaS5XrIWiBOGpFJHb8J9fN2i9gQyawq/FzVNsvMNhhrbaaD/f7D02psELWTk0dxjT6FCc6/cGWxr0aSkUfZpFBsu2K5Tx6VKEGTjvSU5NA7qgc4rowvN31RJY7Tb/ZyOQc3p68ZHtk/ln2tZrUYoU6fzGnH9jssRdDiIeUbFvQ8AUPjG42MKgOZNs+6Impf5cz5WgGNqZB50pNGDVkdURFElJwC5pkpH2Y1jeiO7SxF5LNs3Uiep73NyI0+OhcabdFB5jkyXUTk4KjLv2Gcw+HT/UzQqLS4fFw70qwh1R1XNaDSBjuKzDiP5Lpb16Tzy8xT7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32c9281-54db-482c-ed7b-08d7f8fbbcff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:58.9480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsH91k+11b2phDf0UHXHJZsrlLkWYWK/XkS8hpVI1ZUi4SrFu1JMjVure80gXsFdLGWytb1WSxceZwe8T6lmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
In order to switch over the inbox from region4 to cw4 we need to know if
the firmware is capable of properly invalidating the cache before
reading the commands.

Easiest way is to just check the firmware version, but we don't have the
helper macros or a way for the dmub_srv to know what version it is.

[How]
Add a new fw_version field to the creation parameters that driver can
optional pass in. Assumes a version of 0x00000000 is invalid.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 11 +++++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 26d94eb5ab58..73b5d500ccf6 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -280,6 +280,7 @@ struct dmub_srv_hw_funcs {
  * @hw_funcs: optional overrides for hw funcs
  * @user_ctx: context data for callback funcs
  * @asic: driver supplied asic
+ * @fw_version: the current firmware version, if any
  * @is_virtual: false for hw support only
  */
 struct dmub_srv_create_params {
@@ -287,6 +288,7 @@ struct dmub_srv_create_params {
 	struct dmub_srv_hw_funcs *hw_funcs;
 	void *user_ctx;
 	enum dmub_asic asic;
+	uint32_t fw_version;
 	bool is_virtual;
 };
 
@@ -310,12 +312,14 @@ struct dmub_srv_hw_params {
  * struct dmub_srv - software state for dmcub
  * @asic: dmub asic identifier
  * @user_ctx: user provided context for the dmub_srv
+ * @fw_version: the current firmware version, if any
  * @is_virtual: false if hardware support only
  * @fw_state: dmub firmware state pointer
  */
 struct dmub_srv {
 	enum dmub_asic asic;
 	void *user_ctx;
+	uint32_t fw_version;
 	bool is_virtual;
 	struct dmub_fb scratch_mem_fb;
 	volatile const struct dmub_fw_state *fw_state;
@@ -335,6 +339,13 @@ struct dmub_srv {
 	uint32_t psp_version;
 };
 
+/**
+ * DMUB firmware version helper macro - useful for checking if the version
+ * of a firmware to know if feature or functionality is supported or present.
+ */
+#define DMUB_FW_VERSION(major, minor, revision) \
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+
 /**
  * dmub_srv_create() - creates the DMUB service.
  * @dmub: the dmub service
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 3cfbc27f3eab..3559093027ee 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -172,6 +172,7 @@ enum dmub_status dmub_srv_create(struct dmub_srv *dmub,
 	dmub->funcs = params->funcs;
 	dmub->user_ctx = params->user_ctx;
 	dmub->asic = params->asic;
+	dmub->fw_version = params->fw_version;
 	dmub->is_virtual = params->is_virtual;
 
 	/* Setup asic dependent hardware funcs. */
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
