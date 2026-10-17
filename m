Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BB7CCF2C4
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F9510E422;
	Sat, 17 Oct 2026 17:07:52 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A7D10E422
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 17:07:46 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso670299f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792256864; x=1792861664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzUR4s1SjmcfQnwChERnzeBd2SyoR/60FRqLysjAHcg=;
 b=NTXl4MrjCDlrv47SbLhAVEXayhrkq/Bxc1FrxFbi5bGnsPnBAew9hgHL7jkRJtADMH
 F/ic3Ri55Bt6j67VMwUvblhv+mHCDLQp09GkTJF3UmGiRW4nQj3Dc8jNRb/hCPTn7EO6
 LG9rZ68jZLV+SzUHSZLf2QoVc/WgEwPulvEDyy4oXzXaWkGx7siuLplHCqEOed1+s9t1
 qdavWaqYVG/aWnEhq9rEZOGk3Da4d13Llquh8zXbjqK6+6Ckf4+2xsihAyf/1yBf7KBz
 XK+Q9v1I4bV0ZFkFrqnBu6OegT1xGidOeYnDy0qpTNzFZky2ZThzyv6ZRcsGG9NnzCed
 7vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792256864; x=1792861664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzUR4s1SjmcfQnwChERnzeBd2SyoR/60FRqLysjAHcg=;
 b=wUjUiayGlM+sRi05xbU7ifjux76vD9AJ1/aKREmtUL6gqRXXYQjwVVMDZ5IJXY+saO
 eV02tl6cv8AW1hs2AY3vv5Hu3WiYSvDQhI4voRf9Ug7CJmmhNjulQvGh0l6EbH68ekNW
 9zp+jxK0EgAZf5uDbt5zgv8Nh2yQ2xpsMCGJzNe5SAeA6vVv2DqhNx4mCwft6IlN+PB3
 faZC1tR50Chzf798zlo++I9xzUlk1CYZVx2+shpg2NOgCXm5YwRCrzqV45ntuvCfgg8H
 oZv9HlvZn3A/m3vLECs0FM7IGrhF0nRch5XTEa9vtE49Vj9FJivkA3XA1ee0jnGmH7rH
 4fGw==
X-Gm-Message-State: AFq9FYLsxizi/p/aesOdcAKadY9nXSWl7NKN4t4l2e+fRH6Lwy2g0kyD
 3snLn6ngXYUn6Ciw9adwS9sh+BM7yB8Z3K8hYv9vQVT20IQ+tyy+0bYL
X-Gm-Gg: AYBFou31tdpu6H1kt+zevu1ggYPFm+AdwxA8CiN3gMHI+jwGigxj42Be+hbjx8Zkos3
 OGt6fggknc8eK0P7S/ffYbN3IoBBLYRqKgDazHkkCyfvpg3FJNKqu7X3XQojidGVDbaWZdLnE1B
 nK2+ACueopyHaSkzzCrFkRVjVp7O+0ef1wA6YUmaiuH3ysCrmehO8SIL8J7qU/2xqQcln4EP89h
 +Kz1se0eEbkl/h9c6fzC4pAnzou+r9aKZeyqCTElX3PTN98cW4gtjCQOsAVGI3+SjlYQbz1AeBZ
 JjiC+PWtVqLXG+P8y0AUUhKHDmiIBtBFKJttIv4Qt4ebEjBHkFG4V14B88kct7yGox4CG+5AMgY
 bo6G5ouijLIUkU3pohZ4+fN5Hx6bJOUPGmsy8Dn/seTF+lcsb7379KHLRBbs/+TYTainbze2xDN
 PKKQF1maPcwoN3ijLHYooob0dYf0PZYtF8csEP5kqPSm+k3NMtakDpkb2KCf98cwYM0hsG5mYYQ
 MbheEB89uHBQ4ribEIH41sh4bmITKeEXu0To7A1zNFZ/80/hv9Y
X-Received: by 2002:a05:6000:2508:b0:48d:f865:c44a with SMTP id
 ffacd0b85a97d-48e07fa74b2mr5718293f8f.39.1792256864157; 
 Sat, 17 Oct 2026 10:07:44 -0700 (PDT)
Received: from cachyos-x8664 ([2a01:e0a:899:6110:90de:8744:7ad5:471e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm12596421f8f.55.2026.10.17.10.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:07:43 -0700 (PDT)
From: Julien Le Bourg <julien.lebourg8@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
Date: Sat, 17 Oct 2026 19:07:30 +0200
Message-ID: <20261017170730.56023-1-julien.lebourg8@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823115200.12502-1-julien.lebourg8@gmail.com>
References: <20260823115200.12502-1-julien.lebourg8@gmail.com>
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

Gentle ping on this one.

Since v2 was posted, a second user reported the same regression on
https://gitlab.freedesktop.org/drm/amd/-/issues/5628 and bisected it
independently to b96150a70696. Their setup is a Ryzen 3 5400U mini PC
driving external monitors: an ASUS VG248QE is limited to 120 Hz instead
of 144 Hz, and a Dell S2419HGF to 60 Hz instead of 144 Hz. They report
that the patch fixes it.

So this is not limited to 360 Hz eDP panels. Ordinary 144 Hz external
monitors on DCN 2.1 APUs (Renoir, Lucienne, Cezanne, Barcelo) lose
their top refresh rate in every release since v7.1.

Could someone from the DC team take a look? I'm happy to rework it if
you'd rather fix the check vs commit_tail mismatch differently.

Thanks,
Julien
