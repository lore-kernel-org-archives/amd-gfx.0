Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2EFC61DB9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 21:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B8410E603;
	Tue, 25 Aug 2026 21:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpvoEyg7";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10AC10E64A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 21:24:54 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so26887766b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787693093; x=1788297893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwy9tP+PnAQKttwIkPiCEGglGcdL28/hF8XnKtMukdw=;
 b=dpvoEyg7ld2K+sPl7vCbpEU+/8p/tx71Ny6wYkTeTKHNwt/f9YHlPyMSCrRGitHPWk
 k406kCBbpKtPe4tBs8S6d9BlZm5NG4KfaGtGP3UAY6dHoWfSpo+ZI9qAp05rG4Dx9L8J
 S9ny5RPZQlaW81amZ+cExFpBnQyyMEf1zvnOkuGSVN2+zBHvNFfrJFWDSzMxlP0kRnr3
 rsZxJrUEH42K2F1AwCk8lMugnzZPiQZGbB9JpZJrI9aDFBhoJCdFg0WNNpsUfvGb/kBR
 C/l59Dl4RtxUBruikU+ZUPpxBDy7gN1+Xg1Yzyvu5TnEkKysHA0eoMyTgjuMjEazfsaS
 YTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693093; x=1788297893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwy9tP+PnAQKttwIkPiCEGglGcdL28/hF8XnKtMukdw=;
 b=Y+/aOLGvgRfXEeqm+pd/lbZ8LJZV36R3n7vq/LuFu+yVgmc585l8WWZOA2Tzj39IlG
 WFOfVseArHQJPlBDx3RMRRITQDKFrHkJf88d8a4Zn7wcOUZq6K8HevPHBJLVMe6MCvEn
 NtTmjpV5p+ozz1HAixTppzoDDlIMoSBWYd0OED7T2Dz72eEPdBWWjwfqmwdxfss6kNXm
 f0kJRBVwCkK+OF3n21E3HCGxD+FF+TIloYmJHIHcYUqzHfFY+L4YAhW/muEgW/5xeu9s
 2IBIlSvS2QfGILyA0FrGcZOMAKaxaQuV6QijYInt7GSmOoZF/pUCTqZmEMlwMJQlU7+k
 Jejw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3zQ8L7xW13alQzG899nLPFzBXyrzW5U2z/jFa6KuqSG+L8HQgRygTJyl6m/Mvl4FUOtWb32zY@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvz3T8Am7H2rK2jUgwKjbgTK90lRM4JEBe0NXeklKgD/8I0DCV
 TsaywlJSgmg0M5kCKAM7JpHwsctgF6jbDwEVdj3vjprH7Hw8u4Iwr6XY
X-Gm-Gg: AR+sD13ZhV9WNbEY5/Tcp9D+7A8dJnV72GjRknprenvDt/NHuIV5z0C4QA03bOHuPz4
 Y7+o/vFXiCmtjLeCHlJX3VTfmkQ1GnoQetbXZliKKd28UKGExBGszm42TJTOMLmaldLts4S8eut
 pFE87sHJI+Fxk7fkFlMQSYLnqwIA37MstiinHiFRxBF0RbFRI7+G4Yo+yvVJhU9QeS0Nzd/1I0r
 xuNbMt7j42flHSQVFU78HuXLK72FKC99s7HwNPHcLJJE2IiDCFhGOI4egPniunEZUxkUHP+LAy3
 ncky1TQtI5o1wDpmdXxiAu4nO5KKRP/3XlPGyjJFgAQjMSNBXnw43BBXtIuZp2mvH+lQoBfkMBn
 GOeYXaDbD/dmpys95YZjEKQDPTH/u/5oD++os+EGwI3XhMJ9FH0cxDmmyWWnEvtyZavqXLc0jWV
 Y07fQaVWyVlWgySie4Fi1BICUb3FcSm8JrmAnlV0ydESMsWxBZLi+NX0FlIgsphetRCIwdRHpsW
 W7tNfoQJx6claSlMMY8RZDsnAqx4qG9i0hi/rADyUPpKmXLnCav9W6nF5ed
X-Received: by 2002:a17:907:1b23:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c250c6751bamr144503066b.20.1787693092403; 
 Tue, 25 Aug 2026 14:24:52 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250bbc5c02sm85136366b.61.2026.08.25.14.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:24:51 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: mwen@igalia.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: alex.hung@amd.com, Daniel.Wheeler@amd.com, kernel-dev@igalia.com,
 lyude@redhat.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH v3 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
Date: Wed, 26 Aug 2026 02:24:49 +0500
Message-ID: <20260825212449.48288-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813143605.106104-1-mwen@igalia.com>
References: <20260813143605.106104-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

On current mainline every boot on my machine produces this at amdgpu probe:

  [PLANE:44:plane-0] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0xa16/0x13b0

16 times per boot: 8 per GPU, on the 4 primary and 4 cursor planes of each of
the two cards in this box. I bisected it to 860e748bddcc ("drm: ensure blend
mode supported if pixel format with alpha exposed") and confirmed it by
reverting that commit, before I found this series.

With all three patches of this series applied the warnings are gone.

Base: 66498c75b4f8, kernel 7.2.0-66498c75b4f8+ #154, KASAN and lockdep enabled.
Hardware:
  0000:03:00.0 Navi 31 (0x1002:0x744C), DCN 3.2
  0000:0f:00.0 Raphael iGPU (0x1002:0x164E), DCN 3.1.5

After booting into a normal desktop session:
  dmesg | grep -c 'blend mode not setup'      -> 0
  dmesg | grep -c 'drm_mode_config_validate'  -> 0
  drm_info | grep -c 'pixel blend mode'       -> 20

i.e. all 10 planes on each GPU (4 primary, 2 overlay, 4 cursor) now expose the
property. No WARNING, no UBSAN and no lockdep report anywhere in the buffer.

What I did not cover: I have no DCE hardware, so patch 3/3 is untested; and
since PREMULTI is present in the blend caps of every plane here, the property
default lookup added by 1/3 resolves to the same value that was hardcoded
before, so that path is exercised only in its trivial case.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

One question about routing: 860e748bddcc landed in the 7.3 merge window, so
this is a merge-window regression - it was never in a release, and no stable
backport is involved. But the fix should still make 7.3 rather than wait for
the 7.4 merge window: right now every amdgpu machine on mainline hits this at
probe. 271e90eb5f9f ("drm: use drm_warn() in
validate_blend_mode_for_alpha_formats()") is already in drm-misc-next-fixes,
while this series is in neither linux-next nor amd-staging-drm-next. Could it
go the same way - drm-misc-next-fixes while the window is open, drm-fixes
after -rc1 - instead of through amd-staging-drm-next, which is aimed at 7.4
now? Splitting it looks wrong anyway: 3/3 gives DCE planes a property with
PIXEL_NONE only, which needs 1/3 to not end up with PREMULTI in the default
state.

-- 
Thanks,
Mikhail
