Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D6FF886D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1086710EC09;
	Tue, 28 Apr 2026 12:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tennr.com header.i=@tennr.com header.b="ZyrjZyNn";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3993B10E997
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 22:58:47 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8ef45a6d9dfso754990985a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennr.com; s=google; t=1777330726; x=1777935526; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:from:content-language:subject:cc:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tTpdXP31L/w3dxQzZkwmCqv09pS8R5zE05I+AiYdQk=;
 b=ZyrjZyNn3ABt3/p4NWXBbNd04lYE0+0jyeIPKvenHpZ9iCeRAYr4W4GNXY/547JpJi
 H8uaVyf4FNFuBCKlwjCm+lZk0gqkQHFKn0q7PATaQvYgwfEBT8fKKSRhVtlcniZkP87T
 r1/GZjICSDu08x01ZsGQ8zwzJJnlko/4P1eLQ32JU1jL6j2aYvYrtbKq1M1sVMsWoYNy
 v086Kt/FQmGY2e/skbHcAJiMqNHPtjslJTIfQC1IRA1K9mcV+TSScVMsHhd8joLOd76w
 9iiainnGLj3e/+bw/wBG+LHeIFnQppcV179NilQSywwh73/oaw/bUDcdz0wM62K+pS17
 KEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777330726; x=1777935526;
 h=content-transfer-encoding:from:content-language:subject:cc:to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+tTpdXP31L/w3dxQzZkwmCqv09pS8R5zE05I+AiYdQk=;
 b=BHBy2K9byKFBqEGwcwAxLuqha3FOmsWRCgSqDxkbMJTKLaEzHHX172WpUamThc6fqH
 qrY0kxJNxInLknZZeZmVvUZFeb+H+jDHBqE3HI01aNePXr2NFNhA6rV2rR2uy8ovmfER
 sKLFjDe+BurgagV+MBYyrFfGRQwzTPoOoFRrYmRkFiM1y+pB4Bqu9LW60HOuHe9dhjqa
 vmmwBKX4na5jaQB2qgyAUCle6n9JBg7LqI9MORFMtuqeAsZrlszIvQ36uEpc7sbNGhun
 fj2FdeJFVUXhGgIAY+bF5ofhLtokb9ec4wvoLMbvuy0fsMYO280R4WZNDQF1tL5gacMw
 7sFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gDZ/oQVYeT6FHLgx+FLr5LrgcQq+r11jxJTNl0/uySJrt2HvZbaQwWGjHICqaO4MZZDFDa5j6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVkBWKTDrEGxAHwoty7hFSofB+eu2pMWUPOdN9rQFW+K0Ddij3
 WihwdGEQgrRKjD2bISJgQJxNy3KjDh1MD3b9lzGLTgcZsdYA1ani0OpU8Dd3TkTNx9A=
X-Gm-Gg: AeBDiet+sXGKeyJwKq9WuxWeOVOqdy4DnL118XPrmTjxhxTiwEnHwVwhIJYfxSQSO2K
 viEsT1eTEvKo3a+nRkU2/o0OnAzB82AYV7pzNUxQ0ukkjG4emP3dt/muXom1xsEuqGRe8juaRF0
 Xo2j5tVzaBm8kEuZ8SZhrcsaAZGHp1hFqCfkxyU/B/fugcOxga/ylmBLm/Xq2PZ7SdIc1rSirEY
 MxXO5R0Rxst4FRDpViJ6DmwSAvhL3MvFWTx8UMNYrnD4/q7J9zJM2eKFNMZnvZF4v3da3OXiOOj
 2mmRyq07HMed1vFssx5+YRnbxgAaXWxoOn+2GdXiNbIlu6jbLacY/9IwAVlWbDMbNJ9Y8Zz927t
 16Rohw4bodxYQ0qL9EzCpgaABMfwIr8rYObXpRdL22cMvCLiFMt/5PHbuRAvHlSvzKeDFHN8cUK
 5sekWxqHQHk/pjBpnvnj7LoQ5QObnr8ra3tjwaJA4RM57WTqZWn/FZkFoCZEnlFrdbGmM=
X-Received: by 2002:ac8:58d6:0:b0:50f:b81e:c655 with SMTP id
 d75a77b69052e-5100e1fbae3mr7673691cf.57.1777330725738; 
 Mon, 27 Apr 2026 15:58:45 -0700 (PDT)
Received: from [172.25.10.5] ([104.225.247.194])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3e2976bd6sm6538126d6.35.2026.04.27.15.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 15:58:45 -0700 (PDT)
Message-ID: <986650a0-2035-4082-9867-9c5ecd8dbc55@tennr.com>
Date: Mon, 27 Apr 2026 18:58:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/display: simplify FreeSync MCCS capability check
Content-Language: en-US
From: Avi Radinsky <avi.radinsky@tennr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 28 Apr 2026 12:54:20 +0000
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

Simplify the FreeSync MCCS capability check by removing a redundant
freesync_vcp_code test. The expression matches Coccinelle's
!A || (A && B) to !A || B simplification without changing behavior.

Fixes: 6f71d5dd3206 ("drm/amd/display: Read sink freesync support via mccs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604270741.pABgRDTb-lkp@intel.com/
Signed-off-by: Avi Radinsky <avi.radinsky@tennr.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e96a12ff2d31..b7fa74a87c1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13436,7 +13436,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
 		(!sink->edid_caps.freesync_vcp_code ||
-		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
+		!sink->mccs_caps.freesync_supported))
 		freesync_capable = false;
 
 	if (do_mccs && sink->mccs_caps.freesync_supported && freesync_capable)
