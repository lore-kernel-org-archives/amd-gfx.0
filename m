Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C4606A332
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6WwBuWc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6014B10EDEA;
	Mon, 23 Nov 2026 13:54:53 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C7110E76D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:39 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so1832111c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436559; x=1796041359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2brmbtPSn0eJYb2F1hknHyThriPLBF9yzs2QocOyug=;
 b=t6WwBuWcGEOmEpYjA13Lkjuv763XcVkTCo4X8iskDVHxsqdvgGsE3j5mfzg0RUA1FO
 33fw+4T0lTuRIbJ1RTswGoSJBiBMaT7kglmfH+G2e7GlA6PDZ9rL5n2l2M++qKqrNM2b
 C21RUr4degxt/wec0M0u5N34jkGyuFWtnwoIIVwm3kYbO4IcX9jo6XVqNtseAa3h3IN2
 yF3aqolLkilGyVj8SlcptXdLbrEA4QfbxZUG+Qe8GrvM5Od80K6lEAcRXymelsewyqel
 u0xfSKKolu5UN4xrgyWZmxYT93o3NJT7EeA+j5U0hQo9UEmPBDiAj04/soB1LbQY7qIV
 Yqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436559; x=1796041359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2brmbtPSn0eJYb2F1hknHyThriPLBF9yzs2QocOyug=;
 b=Z0OTzHaEmuTlvmwXcg3vULehB74jDjklYe9AXd06wZsROXYHlv+kTou+2chP4UXYG0
 cy/ZQlHhtw+qZgjOG6UnSoMVpEyLJxrUmpFpspWiMPdZfF45zMYK8tk7nuFOjmlCpO6E
 TLuC0dyT8Uazs+Yxh9A5qAoMJb7XDuqBGNUb63M/uuMXKLLLxwpv10R1Jz8FbMW1dV1j
 b/1u63Vmpn/AAhdUXe1sW0LIhcsO4JUOZJWRCW9RIWV3e+lreZkcZbi4UiDHv+386cyv
 MCxcI+n3xrNM5khGjGaTpZxI9doTaLvZJ9qxr1UOur0LreQac/GG1a8/8AR4gHSWNOHI
 JPlw==
X-Gm-Message-State: APuU4Z+LAGgatHwZojp7tez0FfwbHSeRrgQlGMNmthhq5hfsu9mcQ2S9
 1VF+yZOO6uAGWIMMrQ5bB4SUZXkrNhrWA9jpzxWvZR1SRIL9gThfRgI6
X-Gm-Gg: AZFdTZfPB752Dumds2lsRS1eT8StiGga7VT5O7nNt0M2in60B31S6U4qN+W9IkcsIMs
 xZvXa64UN1fkeAyzIeSZw+dwzRExmWbEICIMrWPoNGNUvKh6QE50LBaRMru/ULNVkyUxWe2ZQjP
 jJxvJoMm2AUPjbT+NNzb9MTZnVFcAN9wFEzketVxkjCBoxsCanUcYQUqSaIN1eiUhs4OXGOb//U
 YQq8YDg+3axXdnuGKOOL4IuqoNvTXQNKVGzpf9YuqLzj7DeujysVuGyoxTWgLjOBkGjjS5xy4Ei
 sxqY46s029oKOZFlLYUULV89se4KR2H7OWTdJsX6of2PbXY/LFYGXqXFbbLEIYAgsTqUPQj+lxW
 8gE7h7/NoCcGLCAW6vrXTHUNbUjay57pjdS1RhibfxVx9GooGT9qfv73Zes2Qy3XHexKosmyM8V
 cr3eT41ZWFrHZP4f6gloiK8m3HIWfJg4+b+J79U6dCMPdI+frK7TkRrOcKfsbVSHd0Gh8hIrAT6
 CEeOCLs3dgc54+IoLIH2RcyeXAIRXKd1+0pSdK4bw+zv2rvX4s9QCW0yfe0Id2oTNqIgEa3aT7e
 OhBQKe1tZC6rRyqNy0v7EVguBg==
X-Received: by 2002:a05:701b:450f:10b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b56f87ae87mr4215314c88.27.1795436558585; 
 Mon, 23 Nov 2026 04:22:38 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm27463157c88.2.2026.11.23.04.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:38 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Document the union in dc_probe_status
Date: Mon, 23 Nov 2026 12:22:35 +0000
Message-ID: <179543655559.4100066.12937692101747026786@gmail.com>
In-Reply-To: <awO-665NEGdZtq1z@wyuan.org>
References: <20261121041427.1743954-1-takano32@gmail.com>
 <awO-665NEGdZtq1z@wyuan.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:54:41 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Weijie,

Thanks.  Moved the AI disclosure below the --- in each patch, so it stays out
of the commit message, and put it in the cover letter too.  Re-sent as v2, in
a new thread ("[PATCH v2 0/2] drm/amd/display: document two members of dc.h");
the diff is unchanged.

TAKANO

