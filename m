Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC69C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 13:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5572510F5A0;
	Thu,  3 Sep 2026 13:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e42yl5o2";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CBF10E4D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 07:56:15 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-398c1101c1bso2385000a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788422175; x=1789026975; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRqkFHuZea5AlRR5uQ7C1BJC5FSBvAR65ffCkEIt+cQ=;
 b=e42yl5o2aKKOa7TvT9NccvaFIWuFr55GmuRNf1WjMCXrj6YEnLJeeYTQSdCAv7HOvd
 a3kr9ygXkEQNIcvxY9rCRILpwQhCX1MA75AoNxfgdAcTdDL3YaZL7fTyL1XdhaIwJbg/
 8Js6w8284bNxvKVFtZYK3RhPtivd3v7TjCk2McMh4y5MOPRjTA5yyIMhLKIiSXWr3Oj0
 ZwWU3cd4Js0Uu3YZ6KVeYeXmTTc8nCR/L5/+YancBs+a3l1ae0s9AHtYAzt7u6hJ3tPX
 n0QJuUqYfhGZuusdQ5/Aoyh0aC2GZvFWYvX3hrJfYAzEKTlS7ai0FSvNPZr57feTHdJk
 Mpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788422175; x=1789026975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRqkFHuZea5AlRR5uQ7C1BJC5FSBvAR65ffCkEIt+cQ=;
 b=QNIMm3w7s4QAnaI8KfX6ubQc6XufjG4EeIfBEYuPtk47dhsmNOb/91if0om57CWXk2
 syBh6K506Rg8DW7O/qXBDy62AT7S37d3TGmPnN53gTGnzsYTl1u0GITVrIRS14CgqjmG
 GhccnF0QPDD4EPF1Zu2Ic0R+j/idxVeki4ov596ZcIqOpQu2BtCGpVcnqbgy+3KS8Oqy
 h3k1qlre51ntQ6IIoG3o2jkC73dSL+ZsCh+njPUwPauNOZYoJkCSsc4ODu5tEOerNKSP
 Vq5eRFH0GLb1DU9mqPU8Js6UORo7uEJvCvwd8oKSdXrIFiwLyQPwEHMaATnacrhHwPJm
 ypOA==
X-Gm-Message-State: AFuF++mopQr+ZX/jZyxqioxBKTPP/zIW+2T4rwkEqBSteeq91dUurSSc
 GfTf+sEBQ+kx0LYC2HaBdDLdCHa9rW5yzPl8nschv/pYnEQiQTWbS+6HZpQGvCCK2T4=
X-Gm-Gg: AYBFou1wr+SanE3eEYAl3OVu7o1VzYPQI2OFmzntG4C8bFv3r7on/P3XSJUoGUaJSWX
 IFhg1XMViS4Url3lW+MqCsDGjKjdQswUKXk7e6yWtAPJatvJ71/j/Qt2O00Tr1KYcQCvWFW5865
 A4zNYiH0xEVInETfCFeFRwEAMtzdcfuKft76M37NrEP7Cza2C4RrZ56QvvhPwr0vpqTccwHwe4K
 TsRGa64d4PJAQxuRYOIkH6MSvuIT5aODj86bJO6Mw+NEvj8fGZCNfA43dN/84laMjL39PweR6w2
 KuSzi+7GStrmpLFV9XGn6YtrMCfyQ0wqY96BycwN5B7zc1jR9iZO0lhW8RD43rlJNg1H2Ffett/
 GWpxQ+XjHOAcYkgnglr2D71d3CCzNtcXqKTVo+vma8a7oVlgTWrslw5Z1apcoNlY2NZgEN458nM
 Bkf5/sWdrQ7n17Ay7jngoty9tJBdrfIVwSxg/zqqMET1kMPVokY+rqUEo6zvm1ijaweNa7EJ0dE
 /AZ6FRmxiLnjpZmwvPDC2Y7wqm4zpb6hTY+SNAGtV5XWhIxm3jc7rj3Kglz07KywQD53g==
X-Received: by 2002:a17:90b:17cd:b0:398:9beb:5c19 with SMTP id
 98e67ed59e1d1-39aee178f15mr12943740a91.20.1788422174836; 
 Thu, 03 Sep 2026 00:56:14 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm3771943a91.1.2026.09.03.00.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:56:14 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, sashiko-bot@kernel.org,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
Date: Thu,  3 Sep 2026 15:55:23 +0800
Message-ID: <20260903075523.5182-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074152.456231F00A3D@smtp.kernel.org>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
 <20260903074152.456231F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 13:03:07 +0000
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

On Thu, 03 Sep 2026 15:41:51 +0800, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but could this calculation trigger a division
> by zero kernel panic if denom is 0?
[...]
> Would it make sense to add an early return to check if refresh_hz evaluates
> to 0 before proceeding with these calculations?

The arithmetic is right: refresh_hz == 0 gives denom == 0, which divides
by zero both in the div_u64() and in the 100000/refresh_hz check a few
lines below.

As noted, it is pre-existing.  The original code divided by the same
denom, so this patch does not change that exposure in either direction.

For it to trigger, refresh_hz = pix_clk_100hz * 100 / (v_total * h_total)
would have to truncate to zero, i.e. a mode below 1 Hz.  This block only
runs for a single active stream that has already passed the MALL
eligibility checks above it, and with VRR the v_total used here is
adjust.v_total_max, which corresponds to the panel's minimum refresh
(48 Hz on the display I tested).  I could not construct a case where a
live stream reaches this point with refresh_hz == 0.

I would rather not fold a guard into this patch: it carries a Fixes: tag
for the underflow, and the two problems are independent.  If the
hardening is wanted I am happy to send it separately, something like

	if (!refresh_hz)
		return false;

before denom is computed.

Thanks,
Francis
