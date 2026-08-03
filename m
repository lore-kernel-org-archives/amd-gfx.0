Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C0CC55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 07:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D527A10E89E;
	Tue,  4 Aug 2026 07:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UewXnZrO";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C7310E78E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 19:14:07 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c74722e27so3234001fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 12:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785784445; cv=none;
 d=google.com; s=arc-20260327;
 b=ld5gUr8DOV13bZmWSDwZmloDZTV10C2JtnzNpk8ATtCSO0j6niMILNBUPxJfk+Uigf
 4syAOhjORMtGZ3RL8VuZHHf+3/psOa5FE5UcxauC9Rt6thacDSUBc+V+1V9DGmYXYIzy
 YC2olEIHjBgwRRVrcY9EioSPjeCbi96q0lQppedybG6rKfGfs6R+iWoYudsKmzNc7/u5
 wPJ4Ji0DuarfZzlo+OglMPMQYCu/WQYdDxpcK7rXsVd8ZEmN+PPKdWJkZsomR0ORAV38
 PsAyPlSw81bJyhiKH9GB/Tpkk4s22BLxnpOuzxo2YdzgBeGDkDD5Kb9pcbHhiZFCmNST
 koqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=tpsxoydy4sCKczsgkcPQalcJBeSRT7RdjZ9uW8qiINo=;
 fh=PEERZuh4Yetnp4UITlV9U2qacneb7tIeTgg3afsQkx4=;
 b=XdlE30s0ohCcRsGChC78WMiFqBJpJffIOu6cegS+2zJE35Qf9vwqwbvfCGAuGtp8wF
 OYWxvTHqBPnSMWv/wfbHa4T5U37LtvTy1R0Ie/flcrGxvmLOecYs6dPsBj3uolzjm81z
 5QyGV0slBlysvtdUgICqwCD56g5Cis5fplI5vhzFbrK/cPVil1KrU6AvVhZtVS9qyJD6
 4LbIbgEBKTNdXn1FTSMXINIRlw1+5gCdMipFTldrrZ3AAykM4DwmIyRUExbhsPj12IEl
 S1D1NxhP7CSMHLRyrmxy/SHRKxR64IkGDXg/58KXG+hu37S9gVfQvPIN4AI383hxFzqO
 G2Cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784445; x=1786389245; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tpsxoydy4sCKczsgkcPQalcJBeSRT7RdjZ9uW8qiINo=;
 b=UewXnZrOqiV26foEIEfzyNwtfDNs9wR7eOVyyud3MWaBuGH3bHeq1agPZHqSDxV8PG
 ydevgGhYPpW9Rsqim28/S867Qww4ofy3uM6WTmkiSu9C2juAn+lgXxpNMNw6bYGZl9A5
 YjSKUgJ4Ft4lJ29Xw/rL8+I0JnPdba7c9UeiAquzg8aKEEFwBuBBZ9m8jldiiD2Bh4l1
 MNfHL1mpE9WtTxhceCFoagnqVqQPAcgIUWkx0XHtkr2+jHnVL1RcCmkwWjVnwPUiKXOP
 oW63AyDZ63lGfak6Yvnv34h2u4xbbatRIcpt0w3elxSA6vCQJgOmCdYXGTVe9J7RzFkE
 jsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784445; x=1786389245;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tpsxoydy4sCKczsgkcPQalcJBeSRT7RdjZ9uW8qiINo=;
 b=AQ1Tgxtxf3vrVu76dK76URkfoXzhhJCy4FeftRi51aNSMq3nXJW8eiKr4DbWri8ai0
 8AN0yk66peoew/SDzQcm3dwvbgon0+pyf04tKSmb8q446uO+NTxeX0ZGkmbqIUl8RUHu
 IMHAqH3m5iKAT/wKiE5B/Py12xVP0PqfN7GCM1Rz2attwghwNGsmjXdAcHhZPUWUSbrf
 W87287Wrh2KJsozbLFSpVlKyDRErkBQF5mhhSG1HqL2H3NknW0RZBjDcKtKzXI7GklVy
 NuAO6c+RyVYiyYmDmE70F3s5Oo/jMIXhkt9hltqxX3SJnzAgYFWT+sr2BIAT5n1oFHi8
 Ur8Q==
X-Gm-Message-State: AOJu0Yyk5gXiZyd4kJfCPy0OVXsb+yiWYHmh/rmYrjphRuozP/NemyRK
 BFrqJgYyBC9vdwGHi8T4BZNZuAEXjrLHzSdIYZzRNEG/BFQRV/8YBO47EFZ+DK5lfL7wkIi4cU4
 b0CWXcc7hFQheeeRKXISPEiCI244aB67sDQzX
X-Gm-Gg: AR+sD13KOzqC7HLX+hftXYhIFpu71fIpY0QQTm83HPhRN3smCwinDG6daeq+LGGVvBg
 YekXLk3Ayw3RfJyXA7Z3tCA32X1pZ6TSV7AfTAF2w4HF9XSV5e3EY3ALqlyQW/o2jd+EmH5EA4H
 HYIAuqewT49PlvbaKPLRJbabZ/EdIOrT8/ZmIScgCK4GseegzKLa3fcRNMWnlkLKYKxWDqRnUZh
 728SeLAXcLwjoFmxIHqDT3iQrHXbbQJCyCH1H1EJ8p0ZbQbihkgZ1wg72ZnQ9SsrArbkEpljPFr
 SE5HdvC8t0b7DmZl5xXfIdAp54plxHda45dN23tL2ZwGnzZW3xldAWm+SQ==
X-Received: by 2002:a2e:a99f:0:b0:39c:7425:59ac with SMTP id
 38308e7fff4ca-39fae8e32d3mr1205701fa.18.1785784444785; Mon, 03 Aug 2026
 12:14:04 -0700 (PDT)
MIME-Version: 1.0
From: Travis B <tbangs89@gmail.com>
Date: Mon, 3 Aug 2026 15:13:52 -0400
X-Gm-Features: AUfX_mwJ64exxyG8S2Nv1oZR4rlgtMEnODZDYSPlNzyH-cm_WjVLN22NFrHqRLE
Message-ID: <CAHSgyMMBq9zbcAgiFz75vM0_oJRi+YkKap2W9=L_Na6Yu39zNA@mail.gmail.com>
Subject: [PATCH] drm/amd: Disable DP audio spread spectrum for Cyan Skillfish
To: amd-gfx@lists.freedesktop.org
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 harry.wentland@amd.com, "sunpeng.li@amd.com" <sunpeng.li@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:18:42 +0000
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

From: Travis K. Bangs <tbangs89@gmail.com>

The VBIOS for Cyan Skillfish devices (DCN201) indicates there is
DisplayPort ref clock spread spectrum downspread, so the audio clock
is corrected for it.

However, the clock source in this hardware does not seem to actually be
running with a clock downspread, so DisplayPort audio desyncs with video
after several minutes.

Ignore dprefclk SS downspread on CYAN_SKILLFISH2 asic.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5429
Signed-off-by: Travis K. Bangs <tbangs89@gmail.com>

---
Submitting this patch as requested by Alex Deucher.

The system with this problem is the ASRock BC-250, which to my knowledge
is the only GPU which uses DCN 201, so this should not affect anything
else. I have tested this patch on my system.

Some relevant register reads:
dprefclk is set based on the value of register CLK4_CLK2_CURRENT_CNT
which reads as 6000.

Without this patch DCCG_AUDIO_DTO1_MODULE gets set to 598874.
With this patch DCCG_AUDIO_DTO1_MODULE gets set to 600000 and audio
stays in sync.

I am in contact with about a dozen other BC-250 users who have also used
this patch and reported that it solved their desync.

There might be a deeper underlying bug here but I think it takes AMD
insider knowledge to fully understand what is happening. I am glad to
provide further info or do further testing if needed.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1820547b1dde..941c1a312824 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2189,6 +2189,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
         init_data.flags.unify_link_enc_assignment = true;
         init_data.flags.usb4_bw_alloc_support = true;
     }
+
+    /* DCN201 audio desyncs using DP SS */
+    if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+        init_data.flags.ignore_dpref_ss = true;
+
     retrieve_dmi_info(&adev->dm);
     if (adev->dm.edp0_on_dp1_quirk)
         init_data.flags.support_edp0_on_dp1 = true;
