Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED7606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gr4eAt7W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D1A10F356;
	Tue, 27 Oct 2026 09:34:18 +0000 (UTC)
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDFB10F1A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 22:45:18 +0000 (UTC)
Received: by mail-wm2-f6.google.com with SMTP id
 5b1f17b1804b1-4a1d25d7d5dso13787105e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054716; x=1793659516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J+L7bw3dA5fk3lxjoeNRPOpOrA1fQj1+m6AAzdxl9Ok=;
 b=gr4eAt7WTP/j4c8RnR1I5GEpRKFtoE3AukrcN5vH67RAbvCxE6l0ATiJG1QGWY9jFV
 aQpNSu4Yfps+ctaZq8koN/sOb8RbF+sS0whfKVT0KsPql4bKdPRWU2Zz+3qMG+rBSsUr
 ElQbYPpPNTuM2wHIK0OqkbaI9+2gs6k3BIzeptR/S2247cF2ZDUDQEix57GSHwOv/itt
 6kJnqK7Kvd9I5bFbhwB3vKVv0aqSMgxdQh8LdncKHJ62BAT/+viVC/lW6UbhMPhUJ/Oc
 7Jpv6QxukRY/hge/X8ysheITkaLkW3OKuSivw+VkbhCSoBp3JqWg58TQwyt3/rdY9XZW
 Q8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054716; x=1793659516;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+L7bw3dA5fk3lxjoeNRPOpOrA1fQj1+m6AAzdxl9Ok=;
 b=Q5JI+kZ7aEQgH+RUKlIT9rXakTIZBrfG77YX04WE6gangSgZEZZAyPjJXjswW65hGQ
 2WmqqLmVU6sS/U8rI2F23ehMiM68wKhV7VnPh+IvKEChUWWgmpQL7ikQdBxIbult1I7H
 OsvfG8gX61hN4Y7pTIR3EhzEstAwK8Pevf7bv4RJx+sNDj6ywwZOaJAkGgnLnbwEeOnA
 HbvkFgSyPcQnmN8EJcdByjEJ52vhDtbgFG7bCBqvDC512awdxAe+n0jEw3tIyzbQPOrC
 wcgB/2hg5/7VtmGEJcJTQMlcMsH1f+88hdJcQQg1wWu9oi4dQimBhNTUO7uKkva3KugR
 hAww==
X-Gm-Message-State: AFq9FYKEWEx+JQny30hNQ3th90R1g//RaWNAY06dMeRexPo7x0rZRt66
 7PC1PraMeMnFMOaWoGff8nuOz1B97dHWfAvpXPo1frIAX5T4RIiQwLBUT5Lo/babiTBVHDP6
X-Gm-Gg: AYBFou2IyRvGnQHQ0Vt1EENj+0Kg2w99KQwyjeQzrs4BesfytrarlAzljCzM3WUbX+X
 DqbGJmYN7AuflDFIkOfz5bOqoz3Pb2ztZ0As3RiHdPXJ212JGQJw2zIyja+NyghbYNyHV4j2I4i
 gQrIo4ZNlue8GTv9UioRPvLhZVrVpTDsviL2EFwtfZCTDlk6/q+MmamZGrwATuXPT+S3r7qnVup
 Wruljx/M+IemJ1Gfx+fJCjOjFgzk7tkUMIRbTxvnt0fJgbYZXlqQ3oaIoQZbOmdGhASlqnRfYSB
 q1HwvSuprGrEZUVL5GpXziAJX0DNL4DNVspjfgeQiC4YkUdCKKghPs4vsfE5ebZYicHD5MDThKS
 /w6r7avvGIVkS+MNyMmgf+qYSm5uNYAbVQ/lCqVsoctEbgx2/sSoQJgckW+PFIrHP99TpflYWmF
 UDhokXNSYfWtBEKROkul6aOtVnz1DpxeqOsMruPoER4JWBraoaLLlGm1XmFjKvVVmO3Rj1ohsTR
 D6tPEGJG970spjfkG9shjC6Jp+dpCwZ+e8hI0AtYDUzDZftW8BD63euku5wM/0KUiHVMQ==
X-Received: by 2002:a05:600c:530e:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4a35acbee85mr151336425e9.26.1793054716377; 
 Mon, 26 Oct 2026 15:45:16 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a58a0e2sm276910045e9.13.2026.10.26.15.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 15:45:15 -0700 (PDT)
Message-ID: <9045e8b9-2634-476a-b765-c42fbbf44d85@gmail.com>
Date: Mon, 26 Oct 2026 22:45:14 +0000
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
Subject: [PATCH 0/3] drm/amd: Enable 2x1 tiled display support on Apple 5K
 iMacs
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

Apple 27" 5K iMacs (2014-2019, iMac15,1 through Polaris-based iMac19,1)
drive their internal 5120x2880 panel as a 2x1 tiled display using two
2560x2880 streams over an internal eDP root link and a secondary DP
link.

At boot, the Apple EFI firmware initializes only a single 2560x2880 pipe
and leaves the secondary DP tile unlatched with HPD deasserted. Because
the secondary tile reports HPD low and requires a vendor-specific DPCD
handshake before it responds as a DisplayPort sink, amdgpu currently
fails to detect the second tile, leaving Linux limited to single-tile
resolutions.

This series enables full 5120x2880 dual-tile operation on DCE < 12 Apple
5K iMacs so that the internal 5K panel behaves like a standard DisplayID
tiled monitor:

1. Reserve the full 64 MiB stolen EFI framebuffer region in GMC when
   handing over from the relocated Apple EFI framebuffer.
2. Pair the two internal links via an EDID quirk on DCE < 12 (covering
   iMac15,1, iMac17,1, iMac18,3, and Polaris-based iMac19,1), latch the
   secondary tile via DPCD 0x4F1 on the root eDP link, write the 3-byte
   Boot Camp source table (0x310) on the secondary link, keep the
   secondary tile out of D3 power-down, expose both tiles as
   DRM_MODE_CONNECTOR_eDP for userspace compositors, and unlatch the
   TCON back to single-pipe mode on suspend/shutdown. (DCE >= 12 support
   for Vega-equipped iMac19,1, iMacPro1,1, and 2020 iMac20,x is noted as
   TODO)
3. Report the hardware-synchronized state of the two tiles
   (all_displays_in_sync = true) to PowerPlay after dc_commit_streams()
   on DCE < 12. While program_timing_sync() already aligns both CRTCs at
   modeset, DCE < 12 leaves all_displays_in_sync unset, preventing SMU7
   from downclocking MCLK at idle without modeset underflows.

Note for review: Excluding explanatory comments, this series is ~ 47
lines of functional code. All added code comments are intended to be
removed before final submission, except for the comment starting
"Workaround for..." in amdgpu_dm_helpers.c.

Regards,
Richard

Richard Lane (3):
  drm/amdgpu: reserve 64M stolen memory for Apple 5K iMac
  drm/amd/display: unlock secondary tile on Apple 5K iMac panels
  drm/amd/display: report synced Apple 5K tiles to PowerPlay for MCLK
    switch

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 10 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 44 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  6 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++
 .../drm/amd/display/dc/link/link_detection.c  | 14 +++++-
 .../dc/link/protocols/link_dp_capability.c    |  7 +++
 .../display/dc/link/protocols/link_dp_phy.c   |  8 ++++
 8 files changed, 133 insertions(+), 2 deletions(-)

-- 
2.55.0
