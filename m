Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212FC79F8B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556F710F8DA;
	Fri,  4 Sep 2026 07:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jRSezTb+";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A7910E0FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 00:28:08 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-848643382fcso429546b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788481688; x=1789086488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vdciKuRG0+7QLWnNTuz0uUlNSW+MdYxW4lgr+x8s4hc=;
 b=jRSezTb+gcXIkNtD6ah5kdYEqSTBuJYqtfgmlJ1O/NAtMA3o86/GZSH4hnWsaaeUtd
 qZWmj46nxi9cDAPsqa4AvjGJ7KQNFW+q6GUyzcLwlTeeLZjX9XCZPXh8NG+D/vSR1e0y
 BzPyui4vuiCXrEA8B8Xk/zjb14xIrnHxfPVhm5L6l0i6ta1OdnqqrirLKG2Dx4fLyuDa
 tFkF39MX3oh/c6ufonqeTC87TULhfzjxxuMNgJwnn3NZJ6iVdvYleLlow59yt16puThg
 oidUUYyNLkK9ywEPo9UHTyPYOPFagGBNg0rnHqNG044m7rIjfsb83pE7xo67fu7w6gIJ
 dsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788481688; x=1789086488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vdciKuRG0+7QLWnNTuz0uUlNSW+MdYxW4lgr+x8s4hc=;
 b=FNttCJkZGGPFKsAcMA86ig1lpGsP9B5QdA0K1eaQje73Tzt4Ob4g1FyhKHYnYA5Il0
 LxnHvGwF2b/ibJtRAhfTp+HF3I/EhNIGiFiZ58yHwgYzcrYEQu2XGE5zFVvzglPLsshH
 UIeSgJ3B0lPCh2P2RZN5PnKqhZ1V7Xd63aFufjY5qKk83qYbIGgVXZgxi+CQ85VKJ9FN
 +p3Cy7HPLDx2u9YVI3QyPqC19TqZi3vVTYVmHajeZVwwES3u4q/dFkeqrzYEMdjXDJCw
 carz3uUNFhKAlF/5TT0vNbithYkR53914qEv7uvRjipP2TKgPl2Q5v36M3gGGVM2tx5q
 fL/Q==
X-Gm-Message-State: AFuF++l0VmsjCgCUw6pdRz/idlxK+PKp5rQPThIN0AeEJiHzs+87G+D1
 +xQMSmoHywfeQzt9OJsLLpMHdybitoBxMjzB1p+S1Z8bTYyZZNVm4nYlYtVlS9ipjyg=
X-Gm-Gg: AYBFou2EDz7zuPmOUp9zpogTOhWt8UQOOwqmxIKlWg1hY6jnCZ4Ea6i0t2loaMJDHLu
 dgrJcd/F5nd+V6qWYfN9hhy4HH9BMzmh0hWg1JZGAstugC4m4C/B+TN4edE024j+ge/DiJVwc3p
 Bop4Vmb/A1LYfsx3exhpk+OAb/Jfr4bHBIsEH24xFizOrY9r/qnqm0mfKLhC73p05WDrjeg5jYl
 LNuIJPMV39BSC1KehezsBTYuGHKJKu/263hvA3qA6CN/H+TMBxzJt/++h17zN7s6tneUexvYV6q
 voxfvs+JE/QOy/fFPYUrDrh1fqlVgdXLlewJXU3Q9s6xjEyq70XDOl3hZlYJKUp2OgGQ/xi5QH2
 slcN+fw9pMa+f5LVhQe3aHUXFIiB4+9hAHMk71H4R1XpyshkdF4/7zypNgwVCKsGsuZAXg6+r58
 4q/XOAikPdX7JUnWKuleZ+L8OewV1sfXrmIVWNG+h/c1gAP1VUg74lja3NtyLP5GVQToUEVM5p0
 qQMlVqAV8Lux/+CajBtF6KgaeuEiFWQh+kp07Xfeq5spNrTahxAe+i5nr0L8n6IZnGLsXp0cEGP
 a6La
X-Received: by 2002:a05:6a00:3ccd:b0:847:9015:e68c with SMTP id
 d2e1a72fcca58-8616ad5265dmr3163594b3a.17.1788481687881; 
 Thu, 03 Sep 2026 17:28:07 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614f875047sm490595b3a.3.2026.09.03.17.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 17:28:07 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: sunpeng.li@amd.com,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix MALL hysteresis timer underflow
 at high refresh rates
Date: Fri,  4 Sep 2026 08:27:53 +0800
Message-ID: <20260904002753.10277-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904002021.9883-1-pacaro.francis.marlou.n@gmail.com>
References: <20260904002021.9883-1-pacaro.francis.marlou.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:30:06 +0000
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

v1 for context:

  https://lists.freedesktop.org/archives/amd-gfx/2026-September/152278.html

Leo's Reviewed-by from that thread is carried in the v2 commit message.

Since sending v2 I also retested 280 Hz, the other mode that reproduced
on the unpatched build.  Both modes above the ~243 Hz cliff are now
confirmed on the patched kernel, each with
/sys/kernel/debug/clear_warn_once reset immediately beforehand so the
negatives are independent:

	mode      unpatched   patched
	280 Hz    WARN        none
	360 Hz    WARN        none

Unchanged otherwise: no WARN across three boots of the patched build,
and 240 Hz still idles at 96 MHz memory clock and ~5 W.

Thanks,
Francis
