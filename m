Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B01C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 21:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2439B610CC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 21:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2439B610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCCC6E156;
	Wed,  7 Apr 2021 21:50:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC95E6E156
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 21:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz/OfciJsYzj6lcFzUcdDSDPykAACxRKgpq1CNfbo0fasdo3tCZ0sD146ZEf5t/tqVU9vQYRS/YnfaWtpcZ7pQ+hiW8Pu7P5LBX0+ugrHHyNA+w18KyPYGR2NBwwJqid8i55N8YcOj7NSTe87BO6Hx5PEH1a6reF7hp7ftm4w5QvGQa9dvhUOcnVsV2hWcLFp8L7hM6GSP0WYS81gF7ivBz7HWrNNZDzCu8NpNMU68MUc0yvIrPe+dT2NyBN5nMsTSmuR5+4Os+zOMNYTc7gw2PCbpMJPC9HCyP3ZiPTf235xZ8sTWa9Sjm6Ys/nsk8dEnkrQ/nva2/Ys35fPIiuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HB4jJj7Vz6sleyGFlfX03x7KARG+Ntsw4G6fLKE8no=;
 b=gzh5OJhCkbIWBHBmtZuNoxyBEFAjf/DOpEgCdPPhMqDZ7l3Yz8Xu9Hfmao4Q1m9TrP8FnlNBr3ZKsI+GTGpQ1NNIzSwqI0ehiHjUhofGxbxFWTDNJn/Hr2qNIJAvwg5LFGq36ZDVf2cwLdu1lsq2kO975Xit/p2yqJjBxfIcmccfpKiT1qkf4Em/XBY70DxkNej4mlUSg8ItlFfPRFHQXcvjRI7a/4EHQMp5wmayO0EAT6zRMyd5+L4WoH7TsZiKpaik8E/1jnMzlWaWl02LuSpUv9MVpHS1YBMie4uc2Ct/CO0bexw9x03YEEQP7zikZmN/96V9dJTwCbnssDB8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HB4jJj7Vz6sleyGFlfX03x7KARG+Ntsw4G6fLKE8no=;
 b=vl3FxNIfzyRmNv7jbGcGtSVmuZuVZTkpJ1qNQYc0lyB7F2x+OvzbyzARBW6A+oBjQBGnQM1yc6hgcn+avVldDIsUuDvb6l4VCehaHaC4flURgTWAuysTQUYuNEC5cb1BNS1RURj1LYVgHDK+VHoMRuTyAUO6Q3kMESm4zYvwZug=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Wed, 7 Apr 2021 21:50:13 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 21:50:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix two cursor duplication when using overlay
Date: Wed,  7 Apr 2021 17:49:48 -0400
Message-Id: <20210407214948.879763-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:588b:b417:efbd:a0e]
X-ClientProxiedBy: BN9PR03CA0978.namprd03.prod.outlook.com
 (2603:10b6:408:109::23) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:588b:b417:efbd:a0e)
 by BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 21:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62b6607e-80c9-43b0-1588-08d8fa0f1f35
X-MS-TrafficTypeDiagnostic: DM6PR12MB2604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB260491CEC9E0786B2E1F31C898759@DM6PR12MB2604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PhkB6U6LfNnpqKfUAK0ysBfWPnd6DhdG9vFSI2wuFcf+m7kNama/Y4gqz9AZ8RPztJMdsDrqm0BxGNdhlJvKh/qcaht0qJvxdgLuRkJGjBkkS7LF+4phh1ew9ikklC9cuDHsECba1K4PpTMIKUamk/vKjTcQ1rcBduruklRpNnvQk4bISDt4inIZdTcqtAphqXGWWm7KTPsTlybXkRQxd7OSM+/C2f0el6z9zmkhd+bLfT/IgpfKZed6QyKkC/x7K/C6o84uA2lHIbLI3N3TEkD5e1ZgGHRxvlR1oVlwc/zRnBH8lNuwBtMbv0qyzZe3Ps9hFgsOQyIfOJWXb0L2vFIiqdzkV3Nbocs9/UW+Lg2ToiPKgRSn2XtKOZwRSRfuzP6zBWuVpe5TxBEE6fikX/D7Hf09de1RPt1M1QqquMvmXYY380BgEI68NqdA6EjM2sAPI0vvX4DrmH0/FvLYd8+d11vpUHbR/KG+JetLSWD+vRdc9hk3X0bCQlr8tdvrJ2Mfe1cpT2dS4tKPh0rgxmDxBYVZ84TzgfpvsQvsS8MYQ9A8j1qfZWJWqpvvaycx4g+p6NAdB6+Sz8HMqiAYwcjA94pbgDN+qC4nrwVS2J5xH7v6ldnPWuAtYqJ9txh+DOmyprTuAG6BZ7KXR7ZTjmjL5uA4ksEr2Wgu9fLE38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6512007)(8936002)(8676002)(186003)(83380400001)(2906002)(38100700001)(16526019)(52116002)(5660300002)(2616005)(66476007)(478600001)(6486002)(66556008)(1076003)(316002)(6666004)(36756003)(54906003)(6506007)(66946007)(86362001)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TQs9K4YubpWut7JecWpM9XncDlWfjCkCe0RIh4GmVFA0VR93H6MJXOkENlXs?=
 =?us-ascii?Q?AB5316ftiJ85En3TEIAqquVWHVNKLiMrJiMnFeDx3eOp/E1GoNLPqZoncc/J?=
 =?us-ascii?Q?bkt9jxl9dt8aDvY6qPncjYyXpSNiSGOOvcbIz4z+wcjt+MAzaZFSRF3PI07P?=
 =?us-ascii?Q?XYmPCS6JiRFQaYjYqHC+bBa0BlcYhUEmKLP661OYODECnOVO9Dr3ABZhM3x+?=
 =?us-ascii?Q?8L9QFunp3JyQvwdqRi/+la/tCtL/+WpuPk0p3q1jjDzlQAh/LmyrRUtWEXvl?=
 =?us-ascii?Q?hiPMm6rKeKbjTJvDwJ6fd5EBfxSAAaQCzbk3NrbpAixPgm1rM09nhZL91QVC?=
 =?us-ascii?Q?ukajVRtsrdmSVYCFidwP7ki49RotJm/h5Bf2bTHoEXWmRVoD+xSrt9ZVC0FD?=
 =?us-ascii?Q?3FCKmm6v3eVw81BuMwkyRQ6BpYbULFt61qmwAy8Pl+PUHk7zTqnXd6mRCYyg?=
 =?us-ascii?Q?qxs9lq9pQS922+dNvuB6ps/a1W6WSUHEKK79jzPdaYbfokjDJMCXp/932+gI?=
 =?us-ascii?Q?Dj87IiVbzzeM4VHFtIv9pMPUXxh8KMwb/Y9ng5uIzaCPnVtxPm10J2YrZ7g3?=
 =?us-ascii?Q?qHYaaS2p/H6v1N8mdCkKMGalARzXaOUJnBkVyZHeF0SmRlYrxzZC2bFXvMYf?=
 =?us-ascii?Q?7ty3hARbdrBmSayRKWX98I3oQBN33FoD1sR9r/vpvPhPtoYZyKEicN/x6bVO?=
 =?us-ascii?Q?ydj8ZQYuXkddWquiZLEeVqEVB+sn+XAuElSYB3JVJyYGILZ8kCQ/yfM0/J3F?=
 =?us-ascii?Q?uXE+J8o26U+EpYKeLykKgXw3MUkOsOC6+SxWKNaFlsbrM8L8TiIX1g/nTgeq?=
 =?us-ascii?Q?o7UdTSsATu1M1ofihwlOkeK6mqJSikKzj0AGwtuyuQISgjH1neRt9UQ6U+C2?=
 =?us-ascii?Q?iq4aEZqtGmaOjyGqFE6piaceCL/G9cjxFIA9iuEUuVM0KwUAjHBApxz6H99X?=
 =?us-ascii?Q?xKTlDJWjaDLCFwP/VEyveCqKzdO9pqjgVRwTST9HY4YODkD+qjGRXFTWx5FI?=
 =?us-ascii?Q?Nbl4zxY7LoX5LnbzTImUBJSBRThpB6kP7/lSEBRs66Y2zWsiyj9oOma50bnS?=
 =?us-ascii?Q?MEliRHLSdLV19ilgwFaIQ/0NyUIUiyuzQWdT3zYIqJnj7uBck6qBknIxURVP?=
 =?us-ascii?Q?QsUe++mXWHdpXgp2EqJd/rl4p++r00jnZaCOyVgOFZ0ZgIfyPcEKA5yeLfuZ?=
 =?us-ascii?Q?sf1x0hCms2Zai3lU46VsSV53LExHPcOON4QQZabxgQS5ZpcIe3XVLJIO2enI?=
 =?us-ascii?Q?N903lCiCnjHJaJQmEPf9BhWdxIScXEVl/FC+dqYdbUNqIic9UsU7fBOR1ypA?=
 =?us-ascii?Q?8bKr02KecrSlXjD2AuNYzZx1mzwxuSDa+jCOXgtNthMaiovi/CeACcEq9Mvs?=
 =?us-ascii?Q?jHaonsibGsSUdujT4fhhWUaPXh7u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b6607e-80c9-43b0-1588-08d8fa0f1f35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 21:50:12.9900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBBxzobtrN8pPMxUym91iAXqQ6ncWr5JrNEitJqjY1SGw90161jP6HZTAdZFrwsFAQpP3MPBKNIwdu1x3Jw9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Our driver supports overlay planes, and as expected, some userspace
compositor takes advantage of these features. If the userspace is not
enabling the cursor, they can use multiple planes as they please.
Nevertheless, we start to have constraints when userspace tries to
enable hardware cursor with various planes. Basically, we cannot draw
the cursor at the same size and position on two separated pipes since it
uses extra bandwidth and DML only run with one cursor.

For those reasons, when we enable hardware cursor and multiple planes,
our driver should accept variations like the ones described below:

  +-------------+   +--------------+
  | +---------+ |   |              |
  | |Primary  | |   | Primary      |
  | |         | |   | Overlay      |
  | +---------+ |   |              |
  |Overlay      |   |              |
  +-------------+   +--------------+

In this scenario, we can have the desktop UI in the overlay and some
other framebuffer attached to the primary plane (e.g., video). However,
userspace needs to obey some rules and avoid scenarios like the ones
described below (when enabling hw cursor):

                                      +--------+
                                      |Overlay |
 +-------------+    +-----+-------+ +-|        |--+
 | +--------+  | +--------+       | | +--------+  |
 | |Overlay |  | |Overlay |       | |             |
 | |        |  | |        |       | |             |
 | +--------+  | +--------+       | |             |
 | Primary     |    | Primary     | | Primary     |
 +-------------+    +-------------+ +-------------+

 +-------------+   +-------------+
 |     +--------+  |  Primary    |
 |     |Overlay |  |             |
 |     |        |  |             |
 |     +--------+  | +--------+  |
 | Primary     |   | |Overlay |  |
 +-------------+   +-|        |--+
                     +--------+

If the userspace violates some of the above scenarios, our driver needs
to reject the commit; otherwise, we can have unexpected behavior. Since
we don't have a proper driver validation for the above case, we can see
some problems like a duplicate cursor in applications that use multiple
planes. This commit fixes the cursor issue and others by adding adequate
verification for multiple planes.

Cc: Louis Li <Ching-shih.Li@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ac6ab35f89b2..5ae6d61e83f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9939,6 +9939,61 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 }
 #endif
 
+static int validate_overlay(struct drm_atomic_state *state)
+{
+	int i;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
+
+	/* Check if primary plane is contained inside overlay */
+	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
+		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
+			if (drm_atomic_plane_disabling(plane->state, new_plane_state))
+				return 0;
+
+			overlay_state = new_plane_state;
+			continue;
+		}
+	}
+
+	/* check if we're making changes to the overlay plane */
+	if (!overlay_state)
+		return 0;
+
+	/* check if overlay plane is enabled */
+	if (!overlay_state->crtc)
+		return 0;
+
+	/* find the primary plane for the CRTC that the overlay is enabled on */
+	primary_state = drm_atomic_get_plane_state(state, overlay_state->crtc->primary);
+	if (IS_ERR(primary_state))
+		return PTR_ERR(primary_state);
+
+	/* check if primary plane is enabled */
+	if (!primary_state->crtc)
+		return 0;
+
+	/* check if cursor plane is enabled */
+	cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
+	if (IS_ERR(cursor_state))
+		return PTR_ERR(cursor_state);
+
+	if (drm_atomic_plane_disabling(plane->state, cursor_state))
+		return 0;
+
+	/* Perform the bounds check to ensure the overlay plane covers the primary */
+	if (primary_state->crtc_x < overlay_state->crtc_x ||
+	    primary_state->crtc_y < overlay_state->crtc_y ||
+	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
+	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
+		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
  * @dev: The DRM device
@@ -10113,6 +10168,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 	}
 
+	ret = validate_overlay(state);
+	if (ret)
+		goto fail;
+
 	/* Add new/modified planes */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
 		ret = dm_update_plane_state(dc, state, plane,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
