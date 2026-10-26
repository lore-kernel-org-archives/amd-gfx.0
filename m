Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386F606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AkmM/X18
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E93E10F358;
	Tue, 27 Oct 2026 09:34:24 +0000 (UTC)
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com
 [74.125.225.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D432710F1B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 22:49:11 +0000 (UTC)
Received: by mail-wr2-f10.google.com with SMTP id
 ffacd0b85a97d-48df0245ce6so1570693f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054950; x=1793659750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kKstMhy7XYdWlOxfLVVB+n9yotypUq8kAPAlGnHm/EA=;
 b=AkmM/X18/GcI0rTLzX73RgSrogQEgwkaWkcvu9vTcVD77Rg8sjQMCl8o9/gjHwIftb
 JL/3UU3jpXHCbgLcU+gJqt8U77DU3VYL6PdsEGa1DP85WO2D4IcG1r0F7tMijuHvNabI
 pWVQowPmnvo5leDRF2h5iIJzfkUovcQQAPJHv9X8o1/5g664UG71ZjPvmxqzPHJmhjFK
 SawbVTBeKISrAueGEl2I/pGZ0xFt7TDSHWPYYb60G2kNiAOBIilGsnoBYy9Oww48Ux3O
 OHJIkLDQYppSLvomBmk3pWy95jDYvrMtUzhecmB/HzyzFH87i7k/ll+jZvKWlbyQFhVk
 TbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054950; x=1793659750;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kKstMhy7XYdWlOxfLVVB+n9yotypUq8kAPAlGnHm/EA=;
 b=khLDh9YhS+iMv1K7D8Uv9hxgvZGZvgLoD8WhUj9pyGRAA+s2E2OB85JJoBQpQFtS4T
 yBdkcpHxMzqEu75B/FC/IgiNHIuyCiVGDZqqgavW/emOVEmyM4bRm5BZes9V1K16zjIO
 WRemLAA+zGnRPVWL/zuAiqoe9nXRLno4K+Nb2EFRmPypljj2fTZqEvvXxozd+BDSiwla
 P1Rjuul3f8h/YkH0nWs2ZWZWW6pMx3OEXfxBeY0z7MbIyXEHkEfobPm9J05psUH9VUCA
 OMxNjjq5H36Hesx7wOLKlIwh7DBq8N9VMYxtRqjzBzm9Lbmy2PuZF7zjrLQXtdrNLnCA
 pq2A==
X-Gm-Message-State: AFq9FYKTs7ZF1wPfM+i6/0seo4Y6jdVQOWmkF1AYUnYNj6ZG/WIg2p9a
 RvfiX6u5zheR+lJzFuV+fZn1r6DN4Zqm0L/QqGIiARmQo4UOlh5bVc4jH8ft7WXIRh0d/2HG
X-Gm-Gg: AYBFou1GKsr5mS34YK5pPdzlBRM3HFm6c9dkfF7gpCT7jdnvtggiktq/Wd4pFwiXpmJ
 XQZ58QtLH32AtfuUvLkik0UOgDu7GuTTa/NpP/WPLpP1CpxSfnyi06c0ZaSJDeRofhthynJkX5n
 vgacppD23FAPr+eiGEW3hwDoIypiPohCsLReVOEdwzIYwTrQ/721ZjNljkiKyw20xGxxba557J9
 uwVpyjSJUZjc5VAfY/LNRLUBN1xABaHLWbmjwGfgwoE9Fo00eegmhAfigd2ig4oFW8VRpeYFl4r
 zkIOcOafmFx4Mw09y4q5dNTVRPJzngYOEm53AwmK+O27I3lU34dgOqeR8KC49LChyqBwk8XVmAU
 1zZ8rWIkyUQvnrz4/Ja3noNadwNbyFbzz3n69dB0CeWB07UVTUruZk5be0lfB0r7I73QniuRO+x
 NRwtOmXAWvWUiACet+1CpL4uKDMqUh55j7eUiAqf//w2R7k5Aqk1zTf7tS7OVcPwwa5kmRY5cAc
 SS6Zr1BxdEastKCRAJvrs0i5cQ/7FRA04nE3lHXJaUqBew2
X-Received: by 2002:a05:600c:8114:b0:4a1:dec1:4e1 with SMTP id
 5b1f17b1804b1-4a35aca4ab5mr129489045e9.22.1793054950146; 
 Mon, 26 Oct 2026 15:49:10 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm587066755e9.1.2026.10.26.15.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 15:49:09 -0700 (PDT)
Message-ID: <3ff4ef96-9c59-4e8d-a0da-92a1ac6f5ba1@gmail.com>
Date: Mon, 26 Oct 2026 22:49:08 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Richard Lane <richardlanedev@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: report synced Apple 5K tiles to
 PowerPlay for MCLK switch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:34:11 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When driving both 2560x2880 tiles of an Apple 5K iMac panel, Display
Core's program_timing_sync() already aligns both CRTCs in hardware
during dc_commit_streams() because the two streams share identical
timings.

However, on DCE < 12 (iMac15,1 through Polaris-based iMac19,1), Display
Core leaves pp_display_cfg.all_displays_in_sync unset. Because PowerPlay
is not informed that the two streams have synchronized vertical blanking
intervals, SMU7 prevents MCLK switching at idle or causes modeset
underflows.

Report all_displays_in_sync = true to PowerPlay after committing both
tiled streams so SMU7 knows the tiles blank simultaneously and can
safely downclock MCLK at idle.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 548f975c7324..384a81371f80 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4788,6 +4788,19 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	mutex_lock(&dm->dc_lock);
 	dc_exit_ips_for_hw_access(dm->dc);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
+	/*
+	 * DCE < 12 leaves all_displays_in_sync unset; report synchronized
+	 * Apple 5K tiles to PowerPlay after commit so SMU7 can downclock MCLK
+	 * at idle without modeset underflows.
+	 */
+	if (params.stream_count == 2 &&
+	    params.streams[0]->link->tiled_peer == params.streams[1]->link) {
+		struct dm_pp_display_configuration *pp_cfg =
+			&dm->dc->current_state->pp_display_cfg;
+
+		pp_cfg->all_displays_in_sync = true;
+		dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
+	}
 
 	bool frl_stream_found = false;
 
-- 
2.55.0
