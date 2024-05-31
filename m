Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F77C41513
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 13:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802B010E2CC;
	Fri, 31 May 2024 13:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kiPyYXH2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9BD10E587;
 Fri, 31 May 2024 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717156853; x=1748692853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Aoz9xxl1jj3vFykAzZra3s2mxNHH4CUCLaRPrtRLCX8=;
 b=kiPyYXH2HBgOTWsodeUL+RC23txlDZQAAO5jghS45klIKlBYv5tdgkPf
 1X5BEAwB4W1LArRJHgMqk/QP4nUrE8b5BEgGulqciEgtQOZtHD9vmbFmj
 P2e1xIhAdRRAlTSvLDzALwUcRSHkgqXQ8/K2Ns1FwoHv2uEILqSD6VKnb
 IcjzXv+iBNxFvCt5rOqoWIx7WqI29ak/7EylnUQw+puqXJT5zxaK4Mske
 kMvaWQtNGHBE7dBE881nBSJrZRKZibBLVMmLI27PiSgei6yHKKt/82Ki2
 KW1joCS4ClW+uO99b7prb0wmmAS/ibTSS14koDGD+yoMJvqw4GzT9EphG g==;
X-CSE-ConnectionGUID: GGWQD0N5QCWJCfWmGLoWDQ==
X-CSE-MsgGUID: VDlzrD6LRgipKzlI6G7XlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31223867"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="31223867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 05:00:52 -0700
X-CSE-ConnectionGUID: SkssAbomQNuQIE9Z4T+aTQ==
X-CSE-MsgGUID: /RApilQeRKW+11wVfRwADw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="36076206"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.190])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 05:00:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, jani.nikula@intel.com
Subject: [PATCH 2/3] drm/mst: switch to guid_gen() to generate valid GUIDs
Date: Fri, 31 May 2024 15:00:32 +0300
Message-Id: <2eafa23584c76f83e9e61da8ce7bfe6e54f2f3ca.1717156602.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1717156601.git.jani.nikula@intel.com>
References: <cover.1717156601.git.jani.nikula@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 May 2024 13:36:13 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of just smashing jiffies into a GUID, use guid_gen() to generate
RFC 4122 compliant GUIDs.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 9b1f35b1a2da..1cb071daab8f 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2698,18 +2698,10 @@ static void drm_dp_mst_link_probe_work(struct work_struct *work)
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
 				 guid_t *guid)
 {
-	u64 salt;
-	u8 buf[UUID_SIZE];
-
 	if (!guid_is_null(guid))
 		return true;
 
-	salt = get_jiffies_64();
-
-	memcpy(&buf[0], &salt, sizeof(u64));
-	memcpy(&buf[8], &salt, sizeof(u64));
-
-	import_guid(guid, buf);
+	guid_gen(guid);
 
 	return false;
 }
-- 
2.39.2

