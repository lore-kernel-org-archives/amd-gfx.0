Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24ACEF99F9
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5BD10E474;
	Tue, 17 Feb 2026 08:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KMPUsgY5";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6606C10E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:26 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8f7f7a1b80so42151066b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260325; x=1771865125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zE1wS+bzyklMWC6UGg3g+8h32nwAI9MGCOjGOVsA3s4=;
 b=KMPUsgY5b9mp2Y5O/Q/s6PjEiEtdfuIcH1b0moiC9qyNFoec5r/o9gBzqNBypo8VZg
 L3fOWWs+MJ8Lizd185iScNm1TP8B5sOJWyRz8kHfCWaxleR7Gr5YVVaY6cSMUiQmUQWg
 kslS46suTDKbkwrCUY9rf23wdtn/sRv9iJWf0NQkKy6TY7pJV9vrrvAs/2LbwphH/69A
 YmJ/W4PrF30bg5t+06UBUSf/BtZe3rao0i9/GRprhaCEk46eO2rhWCAg3MnXLJSw6jji
 hxZXy+R5FiIjtV16VpEDzWVuTrB03qcoPfySzFQr+j8SOLrQQPFC25enD+xFlf1UkHU/
 zLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260325; x=1771865125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zE1wS+bzyklMWC6UGg3g+8h32nwAI9MGCOjGOVsA3s4=;
 b=mU5HQqQfQxZurbANNupN829TsZKfFGZg8G6Ee38qJuyjz6nq0KqZe9xM2EKL/svMYj
 Hn0lutfcOs+tDw8IT4fsNCkYoBz4Ag0ugEgyKYk0w3hedjIfpFIG1dstGi8YYSjQouhW
 RUWgNo/J2IW5YALhDJeh/6ssi2xglnmRkPavU8IVJKyxLlL75lXZAH3yL20A8hQtpTdW
 zLteg7HvXRnFiqbOBmCXhySDZ02an/wn0u+ORsAVt+oFNDTURLmMhnDeL02QXbsukRi1
 zSDH4tvjVM0KGPrLAqZoxu7lEFIRUciNAzBJ/a//DmMVTTy+CstO8e6ao0RTSsAL3+ka
 MqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZESSWEDqOE1eSZHgqG2ISdJ0sww6W4OtBC2uc6Z5uomQ0/1N5EryMXUMx5kWFrAOVZwMPcIOg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3MrgmHhTdbVCsafZuIvL3R9RXvK++Ii32oytCuZ3ddpFOlf+s
 dtGMh0IckgMYlLzwdXJDtvdbuNi3RK2vMTKDlF27OizjFG9zOVnb1ewW
X-Gm-Gg: AZuq6aLwXYgufvObaJFkvMej918N2DLpnDpovHJJBco7aYC4aVVIL6GUniEL4vH6ulN
 gQxzpJv4tol/zQPpbCL5hjgOrkI/L+3FYxjk8FE/YVvQlQUQmMxgtcl+dG1lUpB0CfdtzFwGf13
 Pe/vBckgeegSRiGX3Dfel4b7f8/kZ2e3fUj8r/to/xe8NQyYhuCVT1DOL389iPcB0knqpfcnlg1
 f8Ep0g6GM/9pby9+TItAPGu1z74PBN7svWN1oB8fwoeCphb6C7nUq6B5cGD8kh1k4JOtrQv05ai
 HRSC4DxBhy9XiJqhIXDyHy0pCaXwi+L5pEn9TgVbhLJQIMm227a8b2bVgr/8JdB7tK3y4Hn+tW7
 qhAj0kHNVjSm6Ipx7wlYTxNvbxWylrlF1badAfz02r7ibsh/x5HDT5gWdMkugakXGrJzDK/8Jcx
 wPSP9v7efnQYMVxFxka3w5atjbsnGmGfeXtMfpDY8BP4bRYE0Xqb/L2VGb/SZsmYruGc0FqVGVd
 zIj
X-Received: by 2002:a17:907:6eab:b0:b87:1eaf:3762 with SMTP id
 a640c23a62f3a-b8face929c5mr359565066b.7.1771260324718; 
 Mon, 16 Feb 2026 08:45:24 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:24 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 04/27] drm/amd/display: Move DisplayID vrr parsing
Date: Mon, 16 Feb 2026 17:44:53 +0100
Message-ID: <20260216164516.36803-5-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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

[Why]
DisplayID vrr parsing was always attempted, even though it's data is
only ever used in the DP/eDP path.

[How]
Move the parsing to where it's actually needed

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 903264b26d1f..be3bb5a86959 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13326,12 +13326,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link)
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
 
-	/* Some eDP panels only have the refresh rate range info in DisplayID */
-	if (is_monitor_range_invalid(connector))
-		parse_edid_displayid_vrr(connector, edid);
-
 	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+		/* Some eDP panels only have the refresh rate range info in DisplayID */
+		if (is_monitor_range_invalid(connector))
+			parse_edid_displayid_vrr(connector, edid);
 
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
-- 
2.53.0

