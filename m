Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEEECCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3A210E4CD;
	Thu, 15 Oct 2026 19:30:31 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A62112458
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:21 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso689186f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092620; x=1792697420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1G/eUwD30xxoMe4AQ2K1ZMXk6ZWhWz37kjvYHLoKtb8=;
 b=mu5bueGnLdrafVjooDCUYKannXSkvBEVlyvNexfrR/DcW/vCdISO6aH6q8ipw6d+38
 JIJdKlMC/8PrtUJyNARch6Yi3zPzj3NALZu8xPLU9Cg/Rd1NFO1mxEgheNuBwAY4PXWG
 2OCJ33DYuIg64/MBAqyfUjjAQRzzoJqqGHKXcvKkq1yN8e0hSB5c/+MQEgZb28h4Doge
 bDPeX1CshYn+oCPE4rRrR/YEuIQPX+q1spddBYGn/l+dZv7Sa5Y/qlqNiJ4k+6nI7QW4
 46VwfiIiiblzT9tXIIAdbVCtJe5go+pUlTLL9eARwVXeFl/flKlxuFoY+b2w4tj+ob2v
 q04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092620; x=1792697420;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1G/eUwD30xxoMe4AQ2K1ZMXk6ZWhWz37kjvYHLoKtb8=;
 b=lEmpQX/CsvdNjSgzHg9R3zcT6CC1HBKf8oICfP0xtFg0aU1w3DZ/qdFIq2VUZpL94W
 MKWM3QkiXklG1kSHXrKRbY4vME2Pe3mM8bN7gOIC/CcvF6mmwvmLhvFATK6ebGFqS202
 ffz53kcZ4lYqZp17YeTg+gFxSA7YqFwbRqSbpeo7433LiBPcUHkXhcbikckqOQKnDfPH
 QJjC6rtLK38jIzYBd7hRpi2djJxcsGAbToX71SvkvLj8OLjCKJ6u3vcm1SetfrYMjrFq
 FD31NjRwzdAnphqtw+RPvxUO+IsQQZoiYd0BpmN9yOKHyfPfa03LSVq9pH3i9A8w7l7D
 UQgQ==
X-Gm-Message-State: AFq9FYK794kw7fp64xUBPKr02w/yIGRM73yonTuGgKMYHF/C/rK2UkBc
 GJQi/fONMQb6De6zJnguvrq/H6oA5686zPj6ud7Yianu4BTUbuiEXqyEIdzEuQ==
X-Gm-Gg: AYBFou12ehV9v/eEhegRc6+GzwKYNhgQIGULiyft+ObNgK3pe847a+3G7iQJmS7J9gq
 1W5n4urA9XFcFwiCsTbEhoW7gmr7d7M+JN+rFffYPyLI0LCu56gK74NZEZ2W1LNtx+O36AvkFNX
 4sHrpQDot4MfNuOHMgg/l/NfRs1dE8xacVW1Ud5TndgRxM+greGQ+bMObxfXOsaE68sfS5Zok18
 cAAJyGB2Qz+MHzSV1JZRhnf71K7DfnLqasPuhuRCn/7+Gl+ttoMRoYY9quR8wqd0dhlc9ZFDMgK
 oIjMpQEOkSTXwz8NF4kPAHOabBHuSs8s6JUNLjNJjbAK+I7KdZVerB/6d1ty5Y3F9QzPEnDQpPz
 aSjTlfYILn6oHVPD4TXMxwEdGEwyyPZZMcrcxJwXK036qHtK8LvvDw7+bcJ6RZolFVebipMv8op
 lUSoMAloO3mdPjMgu+6eEZJCrnp44faBH6e4WkZKnWwIu3jWn9ShgjeEvwNo0ocJ/EkEkBIKcUA
 5wB7qSPTpTFa6FlcTwqCSiTvertbGJkHI7BAv9on/+x6Vm1cCOGmHjVed6t5EpeyoPjWiDL2Eq5
 Rl8Dw3wFGTlFKhRUKBT3h9ztnMPKDBsNId7V1iLag8YUqFLKjWodaiaSixYJ/ETZ1D4widywVEp
 lqrD4+H2V++KeaVhJH+6Rw+7L0AxDx7W9RHsG5mrSpuGWXMWpNNiVcYn4okXs1gbEvLghbP9jsA
 OYVGsbtCLG+SJYLD0ReRlYHq9n0Xk=
X-Received: by 2002:a5d:664b:0:b0:48d:b940:af7a with SMTP id
 ffacd0b85a97d-48dbaaee955mr30915304f8f.55.1792092620106; 
 Thu, 15 Oct 2026 12:30:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e28bcsm75303f8f.23.2026.10.15.12.30.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:19 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Thu, 15 Oct 2026 21:30:18 +0200
Message-ID: <20261015193018.86178-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9f7f2076-7306-4f42-87ff-3f51ef5144bd@amd.com>
References: <9f7f2076-7306-4f42-87ff-3f51ef5144bd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
