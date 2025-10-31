Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94FECCFA04
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4D510EBC9;
	Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="FEl1PeTE";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5143810E2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:49:03 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-592f098f7adso1465517e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761900542; x=1762505342; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcNQB2cz7cmMdG+LgLrQkA0i5OOSEJyUpwul2usY/M0=;
 b=FEl1PeTEJAkVEfmUvu9uPL2es7Xpz4XFyHdntup+BphQrid4w0khwRMunxDBjdH6lH
 zf3IyfmhgGdRcITzytE+uj+54NvXrGtnqoJA/hcCh2WXzGm62yYRnIFQpOdf8WIEwh6V
 ZGRHkmlI4vGjP+lHYizDlnHMJ6BfxJyb+QkJECChP1E/kSjwcPXgfzzDW+0TgPX+BJUQ
 fIYxRVR8H3KMPWNcN6UdTLjhYSwkhVfp80jPE1OBC9LspqfxpERKCKMaJGvPcf4ODTHN
 XfxyPZE0+qCzeWWkjXaUjtEQQsS7zUhQ+2yNaRkru9OkhWnHwaQqggx+TMsX3UoLr0ZS
 oaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761900542; x=1762505342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcNQB2cz7cmMdG+LgLrQkA0i5OOSEJyUpwul2usY/M0=;
 b=ubaCoHap/HA9/umT7TTFrRoRyRfjqwVyuQDzwQ00MHvtHWesbrKFFJlHERaxNozOJm
 Gv936gFIN2SjSeo4qv823ZjSwCtmcevoPyTdzOck7waEPQ7p++y7wRbRU+z67lANy9u7
 HwMWlJdUT9+LZphfmdfP7ChlUVyHUu8jTcaCM6Q2jcSQk2ev/GFEGhIIfK+Dm0De9IDm
 0D3kv75MdjJqZveIk6xHuoO09S1rPwiIPR4iKPy/OAucW2/VCsqDFAJC/NnhGnQpaQ2g
 k5AUtkiKnfTNfaot2wbuZNDEdwruKBwkWLrn+oIfYlF9WsytUETXx7aJjo/Ik835lhgV
 n+dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ORJ6o8ekUti1pRddAooHvvKqr4DQtN83rE9bPOgFs2C5wZLvhyfzN6Dl8GIZK0KNP1bMKj3B@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx55aJt86RdwT5Ub5/xBQd/LNxy5Sjk5uGxIwmdvxdK4ZdSJDzq
 EGSaSadgc7jDStBYb0TLxrRfIp4z0necSAEcMtNThNziC7J21YBUeGYRyZtsIZyaEQ0+EV4TJjm
 yyNCeUk02WWQ9BZxTlkrwwT43OWW36yzq4gu1UMT50Q==
X-Gm-Gg: ASbGnctCipQ6VUqmz29cQ1s3XKt40iV/XZrjrradUBgPOWLt6RG9yy6smG/ZMqERZRB
 3G5MhhYy1UneBnA/Fl6MYtS44cP0ztvpK/t1/kYSCpRwDVQWsnq3ySCxQax0BGWANOSbPWz0eq6
 LZ75tr2RYQ5dx2PDQjg0vqmw9bPHNm+yW7iNgO1vDfEp4PjzUwGODxOhuMVbCdzS/ogwgGbL7tE
 zBxGmDzkYobgaJIySGnfSsrgXeuCLK15/llYL1XjnjbhvuE2JvYMfsr4q5136DECfpiyu3CYk0I
 E81QwXAVRFULPvZm2Q==
X-Google-Smtp-Source: AGHT+IG5f9LrT5nyeUFiNlUT6SjibsgaFtcZ7lVM5kJmZgFZMKb75gWV2jzCfnyesEQtIpQyfU8LfCkUsKtRhTh/eAQ=
X-Received: by 2002:a05:6512:3d8a:b0:575:c6:edae with SMTP id
 2adb3069b0e04-5941d5561cdmr988285e87.53.1761900541585; Fri, 31 Oct 2025
 01:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-4-marco.crivellari@suse.com>
 <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
In-Reply-To: <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 09:48:49 +0100
X-Gm-Features: AWmQ_bn-4zPvtMBML6N9b1bZZjys-qRUhwoiBnh0rijwWGoJyeJGXQ7WQEI95VM
Message-ID: <CAAofZF4V7gN=AqgLwcva+zhJyROYfSjzJ2uLxoNeS2KLuytW9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 Oct 2025 14:16:25 +0000
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

On Thu, Oct 30, 2025 at 6:15=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>[...]
> Adding Philip and Felix to comment, but this should most likely also not =
execute on the same CPU as the one who scheduled the work.

Hi Christian,

The actual behavior without WQ_PERCPU is exactly the same: with 0 it
means the workqueue is per-cpu. We just enforced that, adding the
WQ_PERCPU flag, so that it is explicit.

So if you need this to be unbound, I can send the v2 with WQ_UNBOUND
instead of WQ_PERCPU.

Thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product
