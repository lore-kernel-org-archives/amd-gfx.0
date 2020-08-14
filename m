Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 17:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B961D20768
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 17:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B961D20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0786E252;
	Fri, 14 Aug 2020 17:35:49 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114126E252;
 Fri, 14 Aug 2020 17:35:47 +0000 (UTC)
IronPort-SDR: rKnEBeJoCath3+wuLsUJ98CKVyYX+e8CpyWwb4+3RbRwLBo9ErLsjEW/VLavTbg7JwXKiss8xT
 zXPyy01YSlvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="134522128"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; d="scan'208";a="134522128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 10:35:47 -0700
IronPort-SDR: +OGBLPdXdXocbiQnT3aExpIW/Ziy5o56irUSj9MVfTSkgx06uG2m53oBD6QWCxj7dImS4SKeUH
 67eOQP2MoFhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; d="scan'208";a="369959534"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com)
 ([10.22.229.85])
 by orsmga001.jf.intel.com with ESMTP; 14 Aug 2020 10:35:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 10:35:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 10:35:46 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Fri, 14 Aug 2020 10:35:46 -0700
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "mikita.lipski@amd.com"
 <mikita.lipski@amd.com>, "nicholas.kazlauskas@amd.com"
 <nicholas.kazlauskas@amd.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>
Subject: RE: [PATCH] drm/dp_mst: Don't return error code when crtc is null
Thread-Topic: [PATCH] drm/dp_mst: Don't return error code when crtc is null
Thread-Index: AQHWcly455mb73kXNUO9IVKY5gIB3qk33AFg
Date: Fri, 14 Aug 2020 17:35:46 +0000
Message-ID: <97348c62b6024e0aa8f8d537e3ec50b4@intel.com>
References: <20200814170140.24917-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200814170140.24917-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Bhawanpreet Lakha
>Sent: Friday, August 14, 2020 1:02 PM
>To: mikita.lipski@amd.com; nicholas.kazlauskas@amd.com;
>alexander.deucher@amd.com
>Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>; dri-
>devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
>Subject: [PATCH] drm/dp_mst: Don't return error code when crtc is null
>
>[Why]
>In certain cases the crtc can be NULL and returning -EINVAL causes
>atomic check to fail when it shouln't. This leads to valid
>configurations failing because atomic check fails.

So is this a bug fix or an exception case, or an expected possibility?

From my reading of the function comments, it is not clear that pos->port->connector
might be NULL for some reason.

A better explanation of why this would occur would make this a much more
useful commit message.

My reading is that you ran into this issue an are masking it with this fix.

Rather than this is a real possibility and this is the correct fix.

Mike

>[How]
>Don't early return if crtc is null
>
>Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>---
> drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
>b/drivers/gpu/drm/drm_dp_mst_topology.c
>index 70c4b7afed12..bc90a1485699 100644
>--- a/drivers/gpu/drm/drm_dp_mst_topology.c
>+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>@@ -5037,8 +5037,8 @@ int drm_dp_mst_add_affected_dsc_crtcs(struct
>drm_atomic_state *state, struct drm
>
> 		crtc = conn_state->crtc;
>
>-		if (WARN_ON(!crtc))
>-			return -EINVAL;
>+		if (!crtc)
>+			continue;
>
> 		if (!drm_dp_mst_dsc_aux_for_port(pos->port))
> 			continue;
>--
>2.17.1
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
