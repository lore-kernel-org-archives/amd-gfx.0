Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E98C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA73610E244;
	Tue, 15 Sep 2026 07:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BlpkF+5I";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65610E1C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:29:44 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a9ac6aa620so4413843a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789392582; x=1789997382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JytMekM1O3tqnBvhWTtqVwMI/KxX0kYwHkxZRtcjzKg=;
 b=BlpkF+5IKILPqw2a5pzf5ef/HMIKwPCGO7Y26L5Sj2m6lMsLWVhJojsvhxCeUF6YKO
 NyinZ0UZ6l8zNjSRYQG5ANdAeqOeaE6qryIe9pO9LaIth+F6eq8OD7rlnPmETH6el3jA
 he5aRqTe/DTMfqJRwM6RjMsM0QSOTU7V5gkf5jrWdQIO9nHmR13r0ZJ9c4jKfSbXbBsS
 pBo10U8sMI19hZOKvw0cHvFJfm+x4lnAksZgdMS/g86f7+UvEz113jbiINc1RIuwt6M/
 S6RGm2+6X9Aj3IZXaLnTFlQhE9LeeBcBDYvwlc+osxLJ2nWGy0uxdvtffSFHSxlzeOEV
 rWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392582; x=1789997382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JytMekM1O3tqnBvhWTtqVwMI/KxX0kYwHkxZRtcjzKg=;
 b=gpPQ+M1u6RiEMSzg2JJexm0Cb8QClocyJaHULD3SxxcOWHsS7BxaWK2CSdQQgXWtVf
 NfPnMJEFnYSA03gAUxFKwrp83iCwp55uECRUzmxOHQSdKIiIJx2Y3qttnGvsTatJINZn
 3Nh/VJ66ZYMSAO+DJd2bh/i/aqUsfeyA6VlHrTEGSrUVcCZ8lRrzFkaiuezWx8N+7n1G
 wtPtAiG1GjBDwdSjw0jPmF2mBxdApkhpmeFWJ+g026WeE/PTk8MfzkbPinyQahy8frqs
 /DTG3WFmDrtZdEC/vXyzoR/0w7gO1RmvXvUMaGHbeVr0VQSePDCXLWMKYepkr02PYNkh
 a/rA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPl5XooBL5S7MBEsiN5yujeKWG2oQkpIi3Prk/G1xhTZVgPMIdclHp8iTiANjuFS6pz7xFNRbJ@lists.freedesktop.org
X-Gm-Message-State: AFuF++mS4A59MbnYy+HwTU3aCLxECyJWmcrmKLh96HDA/oJ8zpSz8pOR
 MVRfmtKGqaUF9VEURiorsPHvdnNQUhfYkiV+yWamhk75EeuNZvQUmr/1
X-Gm-Gg: AYBFou0YEFR0SBQYvCMqAtQCUNO960BWB2ikXMoueWnelAUD5gy2T3K95TWW9VqwwH8
 LEmRI6H1VTYOepCZj8GPMmB2NrHtZdHUGsvjRn1hhQTb/SDHVkt8abAh3eZAiRCupF522NpJbwC
 BWI6P9tVoXfd8/LVKmXzJ4RxDJOrtaLPtKK5wZeZsnvjBw0IJAk4KkosG32wBzYYpBvHkhByto+
 VcasvDqRamCx8cz9EN1romNH/AqhauSzWsW/VuvT+IdTMrA0VJr391vRo/vd/lrJWQXrP6jABKd
 5uZbGsjOWk9m4g+Z4zWPq2LJWfgaf3tKdVZewmbg5mGpV+qOuzIG/DJXxm3xGeeQluZqK6kPoC7
 ax5Mk++xXLzJfTyfiBJvKWzVfwDHQJbeHVGbdYzsGj9yztTLIwSX78O1qXqj2d/r0SfKnow8W7F
 mNOBAELbhnkLxRxpYZcWNE4QgdlgnFOMQys3PSM8pshdkdb2VkVKbIqTCEEwN8qEDVpec1cNFYh
 5f8GEU+0ZOKuQWW66cxEsq9cV558z10R13UFSxqMLnPfk73smFyGZL+JqymMBY=
X-Received: by 2002:a17:907:3f20:b0:c26:1f8f:ed53 with SMTP id
 a640c23a62f3a-c29a4339baemr362278166b.12.1789392582327; 
 Mon, 14 Sep 2026 06:29:42 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-7759-cb87-66e5-4165.fixed6.kpn.net.
 [2a02:a463:a071:0:7759:cb87:66e5:4165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2965c4dfc7sm437207966b.4.2026.09.14.06.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:29:41 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amd/pm: bound SCLK FCW range entries to the table size
Date: Mon, 14 Sep 2026 15:29:20 +0200
Message-ID: <20260914132920.10127-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:32:47 +0000
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

atomctrl_get_smc_sclk_range_table() copies ucSclkEntryNum entries from
the VBIOS SMU_Info table into pp_atom_ctrl_sclk_range_table. Both the
source (asSclkFcwRangeEntry[]) and destination (table->entry[]) arrays
are fixed at MAX_SCLK_RANGE (8) entries, but ucSclkEntryNum is an
unchecked u8 read straight from the VBIOS, so it can be up to 255. The
destination is stack-allocated in both callers
(polaris10_get_sclk_range_table(), vegam_get_sclk_range_table()), so a
count above 8 overflows a stack buffer, not just a heap read.

Reject counts above MAX_SCLK_RANGE rather than clamping to it. Only
one version of this VBIOS struct (ATOM_SMU_INFO_V2_1) has ever
existed, so a count above 8 corresponds to no legitimate table format
and means either a corrupted or a tampered VBIOS.

Fixes: a23eefa2f461 ("drm/amd/powerplay: enable dpm for baffin.")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 4b796d60b03d..3217ad3c1d17 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1025,6 +1025,9 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 	if (!psmu_info)
 		return -EINVAL;
 
+	if (psmu_info->ucSclkEntryNum > MAX_SCLK_RANGE)
+		return -EINVAL;
+
 	for (i = 0; i < psmu_info->ucSclkEntryNum; i++) {
 		table->entry[i].ucVco_setting = psmu_info->asSclkFcwRangeEntry[i].ucVco_setting;
 		table->entry[i].ucPostdiv = psmu_info->asSclkFcwRangeEntry[i].ucPostdiv;
-- 
2.43.0

