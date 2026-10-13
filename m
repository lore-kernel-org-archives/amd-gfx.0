Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF774CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BB210FD7F;
	Wed, 14 Oct 2026 12:47:49 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A1B10E9AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:53:29 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2058705f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917608; x=1792522408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1G/eUwD30xxoMe4AQ2K1ZMXk6ZWhWz37kjvYHLoKtb8=;
 b=oWVZ9PZaMMzrORAriGultEB4vYP2zH3kQ4FYlbHGNcd13cyv8n+YCqLYGPdWFOeMXc
 5vSIDTOIn0koY4oAwTnjZk/M8I+NWaTor4mgPiuyDkXYHXkVphVxnZq+9+KOI0JVjW6R
 NdvlqNUiHwPBXfpVNjDxI3sNaFEr3wo9GiSrmK+9en9pexTb9t0EK/s7VFT0jDzFXhnI
 XvKkCDlV1oWtRn2S8KNNLZsNNg7vvvpILv9vh13lRSPcenK7I7I+uJmEYQX4P8oRIf98
 RaMDkv2qJJtrkShkaDsCvF5Oe2KS6o+dbSDJEPGNcloq5mDgu3v5bAuQ1ZYezi5ltNi5
 WKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917608; x=1792522408;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1G/eUwD30xxoMe4AQ2K1ZMXk6ZWhWz37kjvYHLoKtb8=;
 b=lU4XbClOpNqccsnbrf8yQogjTH60iR73fRgfxfvzS6ZekS2sT6OZiD6cAOgn7BFLgL
 FdGBP6nrZQJCCyyqr2DlhMUC47HdVHMYIz9Bovf5BTtZ/21rxL74gvegtBWhyK1iKjDa
 f55dfxdPurVQ11uLCBkT9NtEGKE0UabyAnduEkkiL1Iz2s2BzNCJMNLGEN3cV8TNcdNh
 4XglUQ457x8vvmvG8zM8z+5FDgYnz7JtnCNEtQSFCJQw6L6y0BL0TH2mGDzN+vXJJT0F
 AhCNCU6RP71J+8+KRj0GANOXBYdu521cA5KxkYpw3wmUY6VW77KBWKmqgbXXO+KeuLum
 krKQ==
X-Gm-Message-State: AFq9FYLgVezd2lv4iMcE0E/d8kcDmLpnImEMU4baeOszODvX2JXFZjzm
 NEQN8nwaKzgjIfJveHlNiYVK8llYhpU/wxdSOYSuzUPH14vMmVkNFzskZ6V89w==
X-Gm-Gg: AYBFou03rBJogfy15bVTuHjWYyoYWvzGTYT8ZYCSEZmyLjGuB2osh7DVp2xT6E3w8Vb
 sA3pv4Et5dyCV7uE4Qbz6YyCoHy+snFHWIXlEduoOAq6Ptxz78WSCqENsE+0fyrN0zon2nmcRd/
 OEpPOGoqxtDsmPvfhlBl3d7N3kenCaXtnLx12wTRnPVzYDli0oSGHnB2LS+9Wsjmn9/yKord2eB
 DuDHc75/yCRNRkBCt81ohmYPwQ9jHinlSz23yfZJrJIYuzEEKsiu+5uhv4AxnMmw0LhlVdVFBoo
 xNlS1jBkzTgguHaupd5NuvJGWYYhllcpV/U9Jvs5AfnvP7fxuGG1bKf2j+ZbpMEquxCkxV3sCBX
 k0g4Ogc9+k9d+9CEHeu27y74ZBi3r8CyZwsGr6/BaLP+Th/wT7uBo3b2oA+qx4G7/SaRRH/JeLW
 Xaa/54ZRDi04hmh71P62wTE9iTgxNCsxsjeakGcOxXaz0KzLuNwdq9TiXiQ26P7Egnvd9i9Vk/H
 IyJTF2OnA+RRSpqeSNzl82+GRuYll057PX3KicIQxhRGwRIupaodRwngJpOGnok72OprfdDwrb3
 I//sWL2LXt3yUWqISKOvDIHsh1zkEX2wyMG8u/6X06g06GN+oFPEY1FsAMHQZo9BD6GM+Pg9Pav
 Aa0L1eNtAI+p9oZ/3ifWw+e6VmRcX2LARYZAfOfRJ9nClpMDcGeuE/UR+ENn3Obn6G3ozmouSww
 2O9Xpj/mQFek5mxw==
X-Received: by 2002:a05:6000:2589:b0:488:80d0:873a with SMTP id
 ffacd0b85a97d-48dba7b350amr23656919f8f.5.1791917607685; 
 Tue, 13 Oct 2026 11:53:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de77b35b5sm983016f8f.21.2026.10.13.11.53.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:27 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Tue, 13 Oct 2026 20:53:25 +0200
Message-ID: <20261013185325.33682-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9f7f2076-7306-4f42-87ff-3f51ef5144bd@amd.com>
References: <9f7f2076-7306-4f42-87ff-3f51ef5144bd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

Hi Felix,

> You're adding more failure cases here. But the callers of this
> function currently don't check for errors. We'll need to fix that.
> If the copy times out or fails otherwise, we should not pretend that
> the migration succeeded. [...] We'll need to put all the migration
> pages and clear the migrate->dst array before calling
> migrate_vma_finalize. Also pass the error code back to the caller.

Fixed in v6: both svm_migrate_vma_to_vram() and svm_migrate_vma_to_ram()
now check the copy_done() return. On error the dst pages are released
(VRAM pages via svm_migrate_put_vram_page, system pages unmapped +
unlocked + put) and migrate->dst is cleared before
migrate_vma_finalize(), so a failed copy can no longer complete as a
successful migration. The error propagates to the caller.

The cleanup loops are the same logic the copy functions already run
on their own error paths, factored into helpers
(svm_migrate_vram_pages_put / svm_migrate_ram_pages_put) so both
error paths share them.

Re-verified on the MI50/Thunderbolt repro: SIGBUS, drain ~9s, clean
removal, re-enumerates on re-power.

Regards,
Olivier
