Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F31BC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 00:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8C461246
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 00:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8C461246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DE76E41D;
	Wed, 14 Apr 2021 00:06:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ACB6E41D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 00:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu1ln691+jNmucXCy9zWtZtwAnuzPKvY53/eJAzK5lSmXvC+5tWbbTPGnDEjBM7LSSAis9nme38FuMuLiN/hqWTwfv2p07fa9RJQ9cwCb0I3VZzSEhNNsg8n/gYiobyCvnmaTAP/Maqffw6mF8biMG8Ouos2sqFJWVSb73oMVLHKl+6t37YhYDATNwjtRvqDamleCcbbfd4QOoiDjhC6u0GKKyGlkmGKtN+awoJIhTQsR3NADs5qpEi+4HRefTybSzoUcvu+zJpAFosmB13MAJcHtbIDkAwo1DFjBme8Bv+4o1XgIFlEEfdt2Fyo+Kv8hj1Lu1vvLaBNKmNfXzyGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSYTQncEvxaJ/Q3OqwribAXn+296nd19usRUBDUXptc=;
 b=AUVNuvuZGtIj9jbtxbsai2YiNB0neAC2ROtK9uJhLDLkkRhlyj0BO5hSQUuM5NpNanzOdsOiL58QHIX44NHjJxJcnPBATd8EIXzMoY/r7Vzn9g0SF+nuehYk5K7g7IOIXgAsEN56e/Mw7oq7MZ5HCmgNA3BRWB3ZObhdg4Oj6Rbf5ELkO2ZnGPr6bwfxbbDWahSxQ9eQuAbTYnHqigaBWzoUp4WNkU3CDllY3xwtWyV4UwHGHtWjUk8zTyLLXS2Z/EjhG56ezxZ0eEJSlwPWl4kjZwagvNR0NZvOOGnAR0oFN6YCB7lBfL3GZZ1a6jGX9gCoc9X+eC/OhUxX+umqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSYTQncEvxaJ/Q3OqwribAXn+296nd19usRUBDUXptc=;
 b=p0TV45oyhgw6jZb7/7u65FFEb0a0s8WToZymdjD35Xt/sSICDkwOBJFRmaxRpbb9vf9EV2Muqt5+vWy6ROZ33eeolf2vwyl4XPs9cNkr8G16GwP12Dt6vzGh87S/TRXjf+goYNNGuexX4aP4xF3bTm2zC7seWHV++NgshORpscA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Wed, 14 Apr 2021 00:06:17 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 00:06:17 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
Date: Tue, 13 Apr 2021 20:06:04 -0400
Message-Id: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:409d:ee13:4da:2761]
X-ClientProxiedBy: BN6PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:405:70::18) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:409d:ee13:4da:2761)
 by BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 14 Apr 2021 00:06:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4402536d-43cc-4ce4-4404-08d8fed92006
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB244059C556D50CAB88AB2054984E9@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPRYnieB9t12L4eUkCEYW7S9s6/lFJ7t1N/gRwBYBoUPx3tGSvrh571HseZ0lJB7YEkI4CsDBEal2P6E26HFzkqoAyfS4nGbncPV5jCAYSYmrsSk1wV/Q/YGIF6EZP2vTPRFAdJeEWZa2P7T3vmZUV1pNIuGcn92SJJzt/1Gge+yNLolJxFDJJwz/czT7YhK6L4Vr36sQN5iOStxrnrrUcQQNfXY+2IaQMAm/BUNmYDCiwNMmkHKiGd6i/NEV/GhFXX4pD5B/jKOwrsbt5ETudftz67djSdvfYH4+1c4fcnNF+Wg4Be7cAyOnlKvaB5rKGQmWuLUG/ahVZ+HsyGoDOgXDHGLW5IBg0buUy0aCpc5ry95dhFDcjTTGSlWDtamdmUtXcnSt4asGNf9WVtBhJk1PJrkK5SdqOygThQEyZicKtjWdW0E44LEyX/KsNlXwbGClL9I7oOXccU4/4SZwrBL2EJGdCmSdWtNbkr8eDQYb6TkUAQHMD5xOYPNJBm49+JgjOmxtosbl1VQk6K3dah9Tkt9PgiIx+lesmAmvLkgxzQTQILcRfVGsJFNT360V4l1/I8qhxot2H7Pav5SAidqzZjp4H6/cQggf2aLyPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(66946007)(478600001)(6506007)(66476007)(8936002)(16526019)(186003)(6666004)(66556008)(8676002)(52116002)(1076003)(86362001)(6916009)(5660300002)(2616005)(316002)(54906003)(38100700002)(4326008)(6486002)(36756003)(6512007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8DxYh2C0eGqk/hOqgfwKsvZehRmUnkkoK0M2HBk/XYJj9WRJyOt9o8t8wFIt?=
 =?us-ascii?Q?BDeweO9beHhJ6FFarWs9tKxse2FIRlGcFLHCVcfyIw+9Pd+g/BtVGUXd08S7?=
 =?us-ascii?Q?95tbskkethF8ujr1uyqVr1otYWt2C0SHTWm2OGHnSuFRIiKqsnd7My8+Ehsd?=
 =?us-ascii?Q?S8S7cY1REMXrRGABy3G3MSBQyiS9pSj0KiCkQXtQbFfZOcBJ95z49xDq/dVf?=
 =?us-ascii?Q?eTxHryxZ52zg3/6KbCpvRT4+95tfC0kbCvgokdbA3DxFAhuxa3hhEW68pzuT?=
 =?us-ascii?Q?+gCy506j4cVpZmVMNO99cxnstqRXfYbAB8hC/djppEbo9g60HEqK0d6YSz1z?=
 =?us-ascii?Q?BWAFgmuVqnVg6d5Qa0kRWCf4oSmWbfTPxkSVuNJ+V2bMkKHs2nagV2GAiMP9?=
 =?us-ascii?Q?mZfPO1icOgYkzLX5ziC5esRoFIKYFqAZ8vrjDqfW/aI4OKAZOuXQzIMURQU+?=
 =?us-ascii?Q?/Gb1zDu9uNrzsZGBdMli5FdyegRvZTKPwg16jut0NK9Y2LEsqtYkvLj936M4?=
 =?us-ascii?Q?yl9quQmBc/mR1YZjJe6qW907soQw2okUhWYR8PhqGlmzOKQp7E9hov5sgGat?=
 =?us-ascii?Q?HdJ/MYsjovMO4nav9X+GprQLk5dMRAsOTF2opiZdd86lv0dIGlhi/JivgU5F?=
 =?us-ascii?Q?Suff6b86blf8wOWmN5ChEE7U/jFXd33iqblAZ+RRG920uweODj1xhevahayf?=
 =?us-ascii?Q?X9pu8kG2vbQTJaUyw9Xu9C6vHDaaFUG2IkMW3JoSkjdhCYKPG9wK+DtdizKK?=
 =?us-ascii?Q?HIJg7uohs22WrpldxdmMyHSgOatrA3VZY7gSnPn2U3qOX63MIegM9CQ8+xme?=
 =?us-ascii?Q?BWroia67PWMDO73GHrW/FYtJkmX59QX8lpnlKfDEIRQ0dvbxgSAta/zdVeQ5?=
 =?us-ascii?Q?G+E9cxxtq1ewCINEelvNbHE1um/S8t8OoEd2zpFiBPrBYV68eeGubSgU5Y84?=
 =?us-ascii?Q?Vu+vQlSrXX5QOsqSDVawcuQmYdleg9KkJwNPYdC0SCGdehr9X2ACYXsqTS5v?=
 =?us-ascii?Q?TXBDBVzSi+PMs+7jXiBzLnrxS5X6ZPuYrSp7Jj7rr5cLeb+mpQTlZHvWl/pD?=
 =?us-ascii?Q?fHrRiptfNURuYZQnyOh9uSyi61BMhRdhZet9yKU3vIl2MmwPu2pOVcGPYgFA?=
 =?us-ascii?Q?EjllYSkbzGUrvTYheGyaJdojKqxo88upOhOb38xDe4/PBgT7BP1e7VdidvZ1?=
 =?us-ascii?Q?TSIxBprG+K64zsTelzoU6IPm08ahs8qvcJiTSwjoy+UM3wR9hc88RyuPar9D?=
 =?us-ascii?Q?4bVxIY9ZNqB1dRrT+zNttOQEZzQLiw+YcBbcmrVGSuzdhUumvgKX5dR9lr43?=
 =?us-ascii?Q?HDEbEDUXJnPzHPOIfmBPLlYHh7VKgS0ZbOS3Mm49ANrNB1kv/nlnlZYffL15?=
 =?us-ascii?Q?XZuhJJGdHKWynIbfXVcVLGjqgm5/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4402536d-43cc-4ce4-4404-08d8fed92006
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 00:06:17.3274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kax25C5EufVARREd8vNQGuYlTdlNicZgxKpuGFXDH2FyqeLwAKtW/J9dQD9VA0Ydl9TJpuuL7GuZiLg0q7sXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sean Paul <seanpaul@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
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

Change since V1 (Harry and Sean):
- Remove cursor verification from the equation.

Cc: Louis Li <Ching-shih.Li@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e29cb2e956db..ac1408d52eff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9946,6 +9946,53 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 }
 #endif
 
+static int validate_overlay(struct drm_atomic_state *state)
+{
+	int i;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *primary_state, *overlay_state = NULL;
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
@@ -10120,6 +10167,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
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
