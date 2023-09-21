Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08BEE7107E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 14:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4B210E5CC;
	Thu, 21 Sep 2023 14:34:44 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C81310E5BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 14:25:12 +0000 (UTC)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1695305724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Kdi0A6/rK+Ep3LvvFNYZbipzuoG5coyIRlqyQNpvFw=;
 b=zZ09UGsxiVnj6qUWu3BqMx/BP0ztYTTRcJ0m51WB+0V2fRbpQnzf1+upXvadozQWuaKC3s
 MD81JkwThCeZtSDZk9lCUqdmwoBlEU67CBd/fJJbqrWtiNNZF7v5wcJWUyG5CVQsYFu3+F
 jl8agq3MawwwVtMaOtR/zbBabFryFWwxf/6btI3e9iHjA/I4QWtL+6oT9UUjjovL7jydEY
 09+zsF9Bhc+bp4W24EZ4NTdePFF7yy6OkPflvIZDipQqym3vNaNVB90yjpYpZ0aF8R4QnV
 dVmteKjilYTCyi1UJ/HScc8uxZ91CSL0uIQxPBGOr9gJMuu6OkCxoWz2EJkK0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1695305724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Kdi0A6/rK+Ep3LvvFNYZbipzuoG5coyIRlqyQNpvFw=;
 b=7XsQ//Jju63rVjCThepadMrVHbUDSt+N5TqNtqbzpoUWy5NGMX52VrxG3zpKa5EnSYtMhE
 w68339nCORhdGzBg==
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/5] drm/amd/display: Remove migrate-disable and move memory
 allocation.
Date: Thu, 21 Sep 2023 16:15:11 +0200
Message-Id: <20230921141516.520471-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 21 Sep 2023 14:34:42 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I stumbled uppon the amdgpu driver via a bugzilla report. The actual fix
is #4 + #5 and the rest was made while looking at the code.

Sebastian


