Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF1E7718D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 08:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C2210E427;
	Mon, 23 Dec 2024 08:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=svmhdvn.name header.i=@svmhdvn.name header.b="trl652hQ";
	dkim-atps=neutral
X-Greylist: delayed 396 seconds by postgrey-1.36 at gabe;
 Sat, 21 Dec 2024 22:42:19 UTC
Received: from diary.svmhdvn.name (diary.svmhdvn.name [174.136.98.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAD310E06D
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Dec 2024 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svmhdvn.name;
 s=diary1; t=1734820548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h9vROm/ucFrO1Zn4KeEKv/82NzYWKSb+97vYad00O+U=;
 b=trl652hQOgNnOU5zQ6CZeRa2MYaQA3yT9JHZ+kaD5IU5bLnPZ/rD2U/ES0YvhKijfUQLdV
 UG9LahF9SPPDaX94egagfw0Rps/YtczC24pZCjpocYdf9cX0SjhqZ4CNPTVLvw0Fhc/+Lc
 5QQpA3PSiG+VY+oi2cvHY/QLDRVun0GEgfXQVafTQWQ6WqYXihLF1oLmQ9D5rqYQ/hifDT
 iJWGIaMxgzCeoNrTUOGOG1bb+vm2ykjhfpg2j2lt17d+lFaS1lhQix1OSLuhr94Yn4ZtuN
 CWs3JJ4fVV1i4e2kPREX2ZvASlvlac5fwfpeStNJzdc7e/fAh7R8cPJkkZm2RQ==
Received: by diary.svmhdvn.name (OpenSMTPD) with ESMTPSA id 5ec79cca
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 21 Dec 2024 22:35:46 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 17:35:37 -0500
Message-Id: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
Subject: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
Cc: <regressions@lists.linux.dev>, <stable@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <Xinhui.Pan@amd.com>, <christian.koenig@amd.com>
From: "Siva Mahadevan" <me@svmhdvn.name>
To: <alexander.deucher@amd.com>
X-Mailer: aerc 0.18.2
X-Mailman-Approved-At: Mon, 23 Dec 2024 08:56:35 +0000
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

#regzbot introduced: 99a02eab8

Observed behaviour:
linux-stable v6.12.5 has a regression on my thinkpad e495 where
suspend/resume of the laptop results in my backlight brightness settings
to be reset to some very high value. After resume, I'm able to increase
brightness further until max brightness, but I'm not able to decrease it
anymore.

Behaviour prior to regression:
linux-stable v6.12.4 correctly maintains the same brightness setting on
the backlight that was set prior to suspend/resume.

Notes:
I bisected this issue between v6.12.4 and v6.12.5 to commit 99a02eab8
titled "drm/amdgpu: rework resume handling for display (v2)".

Hardware:
* lenovo thinkpad e495
* AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
* VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
  Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series]
  (rev c2)
