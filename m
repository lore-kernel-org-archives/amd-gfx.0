Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B797606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=to6Ubkei
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8825510EBF1;
	Mon,  2 Nov 2026 08:06:55 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4A510E214
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 16:58:49 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1017584f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793379528; x=1793984328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=puKOIvaW71S4PGASNevTK0iC6FA0A428gnXHwfGAl+Y=;
 b=to6UbkeitjC1Qtq9LQvTn0pkhT4aEIU6A8QA1e3EDhE4WU5062aZOqy2Y06K2RvUBn
 KmfqEEidu39fja3Jhg+ytg16lbJRels1wMWhwKltsEPjwT/TgT/z2D/gz4e/01JkvLZ9
 aVEieHrKVfZL20uYj5KBNhO+KzlzdoBR0xF3dSYngnc6dMtktH6O0H4bmO0LFNmF+s5Z
 DJqJF2kyg3Jv67qehoNor13Q/jYPLrRhLWnCKANFkltJEFtLRpP3VcHzaEXoQF6VV6Ph
 TSVZQkOWMh18BFmNHm66+Wm8XlkgeFraVnkxBDTLfeFhYH4OwA7S2IborShtNj+jFwjH
 ULwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379528; x=1793984328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=puKOIvaW71S4PGASNevTK0iC6FA0A428gnXHwfGAl+Y=;
 b=zDVkrVs3JNUMjebUOMjgKIO1s1KDDEkc/jZGpmLKRoKZ3CD7jMzNGSttQlD7HBYVBl
 4zy6GxPK+2E117RqcvPhUvLqQiU2lJGYDdX13O7xS1oJNe7m0H3XILMedZdCl2VpK0Lu
 9MC1dGwqcbCeCVw7eF1NABMzon6jv9hnkWzvLG8/DF8mbhohq1f+JmpPh406UuieJYOl
 fPOYCRF0HDniCrXYCgCqjMu7aNdxSCIQwyH52fNCgiOLAEG8mfmEYQF2wUayq1B1GU64
 Meb4NZAIdXDW8Iza4oCWLDO2bUY397wKTxX5dJgej16UEntNKjg5zhLXvzqoche+7Td5
 OBgw==
X-Gm-Message-State: AFq9FYJ5TPy3doEwHVpqYoMYGyirbIatHNLLhx4ykxwSNV2acVxprsPM
 0dRS6t7KxUD2DMtlfbJ1X5ElxYt3UwukVWFUfdvbwggEcqBOfmcZ84RdvC0Ifr92EQSC/w==
X-Gm-Gg: AYBFou1klYTzb+zXDWpf9RYpBV7xGUS9tYT+ZQYQ8IsMH6fKrrrVlIE9beD45X7ic1C
 Vfclq5PkMXuvxNoKuDmic4N3uLduuCQzCy3IiC1PfdE/js3uqn3N7ocJhjVCFSDU0jo40CUjmYM
 faRSqtDcJeb/983Fv4xTvY9JbAG+Gibw68hJxNx3/lQUR//aZ36KRDxDr7RZ3pPYyjPVWUsDI+t
 jWsfAi7takywrxBJKS0sQyq+xqb7w2nE2EzTFlLiT4JIOnPxl4tKAw6UngX+33Hyia+DkzSi2kX
 DyD0iPdH5E3eJmD82olU385abYfdD8WROHxJBU2iQ5sdod98wsIc5Bl0ig705I++w7TNngIHhtC
 uUMBiWy3DSGAK9K0M7Ev4W9E9lTu3ILn+CURxeKdEW68w8xEkWCARw2Ff+ZF6n3IYQxPY9etCYv
 IKg4EceUzA/TZ2149lCnsdHEAjiTmOkHd9eHFzmcz29x056z1txCx7LPmQ//tXFLrCP/bvK1p2G
 ICm4KiboiNnrkPdpi2+pmzRdtpZlfA39bp7C/JviYmXfSK6OJr3KcThWVLYQjt80wLL+oA6kMkr
 QuIGn265Atmdx1vclqURJ7Us4NNpm9WNHIpHRLS4sQj16nfMV2UMJxKwVpJVoOKmzSIXADLAAwx
 v+h69oCMnYK6iOzOy/Uuh60g=
X-Received: by 2002:a5d:64e4:0:b0:48d:fbf4:8961 with SMTP id
 ffacd0b85a97d-48e7377d134mr4069494f8f.23.1793379527518; 
 Fri, 30 Oct 2026 09:58:47 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba24f6sm4033465f8f.51.2026.10.30.09.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:46 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Kevin Wang <kevin.wang@amd.com>
Subject: [PATCH v3 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK (VRAM
 overclock)
Date: Fri, 30 Oct 2026 19:58:35 +0300
Message-ID: <20261030165838.248622-1-shidlovskiyilya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_Pv0wkPx9AzooUf=dyWgQuneMc6K9-qcT6PW53Gg4L5rg@mail.gmail.com>
References: <CADnq5_Pv0wkPx9AzooUf=dyWgQuneMc6K9-qcT6PW53Gg4L5rg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DCN3.2 (Navi31, RX 7900 GRE here), raising the UCLK max through
OD_MCLK makes the display flicker (full-width stripes) and eventually hang
the whole system, if the current mode does not allow memory P-state
switching. DC reads the UCLK DPM levels from PMFW only in init_hw, so after
the OD commit it keeps asking for the old top level as UCLK hard min
("set UCLK min = max"). That is no longer the top level, so PMFW switches
UCLK outside of vblank.

The series makes DC re-read the UCLK levels (bounding box and WM ranges
included) after an OD commit/restore that changed UCLK, and on resume after
the user OD settings are restored. It also refreshes the SMU driver's UCLK
DPM table, so pp_dpm_mclk shows the real levels.

Bug report and review of v1: https://gitlab.freedesktop.org/drm/amd/-/issues/6009
(v1 was posted there as a comment, not to the list.)

Changes in v3:
- Rebased on top of Kevin Wang's "preserve committed OD features" patches
  for SMU 13.0.0/13.0.7 and 14.0.2. v2 was based on an older
  amd-staging-drm-next that did not have them yet, so it did not apply;
  sorry about the wrong confirmation earlier. Only patch 2/3 needed a
  conflict resolution: the UCLK check now uses Kevin's next_mask, with the
  same logic as before (details in the patch notes). Kenneth, please
  double-check that your Reviewed-by still holds for it.
- Added Kenneth's Reviewed-by.

Changes in v2:
- Only act when the user has customized UCLK (user_od_feature_mask &
  PP_OD_FEATURE_UCLK_BIT), instead of on every OD commit (Kenneth).
  PP_OD_FEATURE_UCLK_BIT is ASIC specific, so the check is done in the
  smu13.0.0 code, which sets a flag that the generic code reads.
- The SMU patch now comes before the DC patch, which depends on it.
- Rebased on amd-staging-drm-next.
- Added Leo's ack for the display parts.

Testing:
v3 is build-tested (W=1, no new warnings) against amd-staging-drm-next
ba496bb83, which includes Kevin's patches. The hardware test is on
an equivalent backport to the Ubuntu 7.3.0-9 kernel (same code, plus a
small local backport of the user_od_feature_mask tracking, which Ubuntu
7.3 does not have yet).

Hardware: RX 7900 GRE (Navi31, SMU 13.0.0), 5120x1440@144 (DSC, ODM 4:1)
+ 2560x1440@100, UCLK OD max 1124 -> 1300 MHz, toggled via LACT.

v1 results:
- On OD commit, DC logs the new max UCLK (1300 MHz). pp_dpm_mclk shows
  1300 as the top level, and the current level stays at 1300 (20/20
  samples, no drops to 772).
- About 4 minutes of heavy window switching on the 5120x1440@144 output:
  no stripes, no hang, no amdgpu errors.
- 3 OC on/off toggles: one short flash exactly at the switch (memory
  retraining during scanout, expected), then clean.
- Same scenario with the stock module: stripes, then a full system hang.

v2 results:
v2 hardware test (same RX 7900 GRE, 5120x1440@144 + 2560x1440@100; v2 backported
to the Ubuntu 7.3.0-9 amdgpu, LACT applying power cap / voltage offset at boot):
- boot and login with stock VRAM: no "DC memclk states refreshed" at all, so
  non-UCLK OD commits (power cap, voltage offset) no longer touch DC; the
  short login flash seen with v1 is gone;
- VRAM OC on (OD_MCLK 1300): exactly one refresh, "max UCLK 1300 MHz";
  pp_dpm_mclk top level 1300 and current level 1300 (12/12 samples);
- VRAM OC off: exactly one refresh, "max UCLK 1124 MHz";
- desktop stays clean, no stripes, no hangs.

Known limitations (unchanged from v1):
- The OD commit itself still happens during scanout, hence the single
  flash at the switch.
- Only DCN3.2/SMU 13.0.0 is handled. Other ASICs with OD_MCLK probably
  need the same hook in their ppt code.

Ilya Shidlovskiy (3):
  drm/amd/display: dcn32: rebuild WM range table when memclk states
    change
  drm/amd/pm: smu13.0.0: refresh the UCLK DPM table after an OD_MCLK
    change
  drm/amd: let DC re-read UCLK DPM levels after an OD_MCLK change

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  8 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 30 +++++++++++++++++
 9 files changed, 125 insertions(+), 4 deletions(-)


base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
-- 
2.55.0

