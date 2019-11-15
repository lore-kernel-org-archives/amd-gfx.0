Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CFEC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FA720723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FA720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE266E9A1;
	Fri, 15 Nov 2019 16:51:09 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055556E99F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:08 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 15so8615885qkh.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=Hm/NGs24sGV3NKVERx56bpVMZCjeUjELC0IIwCdaB5Ln+2Hz2nSl7pUgHOtauSdHRH
 m7cjCYdcbJ0RkAy8qC6O9RplxUpWBMShZ4HfHtlfVvLKM4N26fFKHQ/Q9+VZpuvV+zmw
 mmbppBje+wy1uEBnRYOU3kQtWAU8Yt65zPfBerUH/BNKkd3h8MpOVIWgW9OXm+lITozo
 CWzv987w1Zv+9q6A6Vz5Iq7N94UvrYHVPQDA62zLZXpbW9/11TF+H7/OA2CUSG0F+1Oz
 40DfodG85JxHQOgXxLjlSy7ZvMIJusZCChcG+RUbtfyQDfVbDDJTsiOofwZ3JOWnLkmO
 Tv3g==
X-Gm-Message-State: APjAAAVYV5SU09qRsjgKitCLmF4Nbjx75ngelMJL6sED88w5j9ebDsIZ
 8oVFiDbLFtq6tV9Whv2wuRNmiTS+
X-Google-Smtp-Source: APXvYqzwOaC1BQreazFbJdoMB/Qh1peQ2/5Nzj3Pqt2x/DwLRMCXnWexbVyA/MbOSh02tf21Oewutg==
X-Received: by 2002:a37:4752:: with SMTP id u79mr3672952qka.456.1573836666778; 
 Fri, 15 Nov 2019 08:51:06 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 20/20] ALSA: hda/hdmi - enable automatic runtime pm for AMD
 HDMI codecs by default
Date: Fri, 15 Nov 2019 11:50:38 -0500
Message-Id: <20191115165038.56646-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=fD6KdDrzblQcsEuIyJ/dfQ3oMe1p+l3lcCZspqseJcV1T10U64kbGEr+zjd4jDEnnB
 XHU5teDDHdOPRkXRSy7t19Bgw3WGCaqRHVWOGHnkWGWHD/grgGX4E+KMwbJuD+NG0Ubr
 qIg73018r8KCxYFwlvSm7VHgGwP44WJe66FX0oVPGzKnqf5DLTPyJLzwKrPsuMzwRtDm
 MjsZYORfzlG+94r0ZmTW/bilzqC2GnqHLCNfpneRax8msJS+lLWYB65bg0NXPq8CCgCO
 SDWN4czODqimzMQFvSBIdBgjNo7BBAcGLW8xkiuzI9iDlcDJ1TC0BHdNpFUPLBGRBxQl
 k3cQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115165038.TweWQ_89AJUszlO2HDEFlu7hd8T3HP1hKNqkzRBKaMw@z>

U28gdGhhdCB3ZSBjYW4gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB0byBzYXZlIHBvd2Vy
LgoKUmV2aWV3ZWQtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KQWNrZWQtYnk6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWku
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYwppbmRl
eCA3OTVjYmRhMzJjYmIuLjg3ODVmY2M4NTBiOSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9w
YXRjaF9oZG1pLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMKQEAgLTM5NjEsNiAr
Mzk2MSw3IEBAIHN0YXRpYyBpbnQgYXRpaGRtaV9pbml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
KQogCQkJCQkgICAgQVRJX1ZFUkJfU0VUX01VTFRJQ0hBTk5FTF9NT0RFLAogCQkJCQkgICAgQVRJ
X01VTFRJQ0hBTk5FTF9NT0RFX1NJTkdMRSk7CiAJfQorCWNvZGVjLT5hdXRvX3J1bnRpbWVfcG0g
PSAxOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
