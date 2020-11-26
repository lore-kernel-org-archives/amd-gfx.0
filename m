Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DABC71155
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B185B206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcPofYX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B185B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357E26EC11;
	Fri, 27 Nov 2020 10:15:08 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42926E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:13 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a3so2446956wmb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ldaBPFUn0rO8pzl0GTJMRaUTSpPfHm0TP7NYAeN6NJM=;
 b=GcPofYX9Qv1V/2JRRf6eBMcmKMvq/1Y31zzXUpFv5WiZOV9yJh+i6XHPOojgh//o24
 KG7wZ049wcgMys0vZlZPxdX+UUR+E7ss+DRmBqf4q8VM0UmyhYYehvLzU79YMDMvLfh4
 beMPEE0h/cHkQRbNEH+m4dUgZ+FiqFn8GubSAKi1eSTWQtQTfJxpSQXt14tg5Sx92KxE
 oewKv4hUveIzavl5EUkEqL2xkXlqMmFvlo8xkY9ps7OQrqk2IhlcI+6mYMWNRcAYqo2w
 1lvd3wlv9+U1TYKUBGDlKd+SVhhuTxlUdeWrZxDiI5sno5LOEGLXlYrmRi1Lo/VZcd48
 zD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ldaBPFUn0rO8pzl0GTJMRaUTSpPfHm0TP7NYAeN6NJM=;
 b=Wm+oUGPXoe/QbidJgwR2p58GRnlT3EA+cGzzMZNlQQN6urzxb++zblsyl9XsJ9Nv2R
 hkf8niy2Wydpw9fRaOVFTwgCBL2LyrSlU/2rxgAwhporR80leJ5Zj0iDw9rJelGS/AES
 WeglFnBzTrctpkxj7TGlw21CS+y1msHOOQl/6cof5TrZND+WYCg7dYzJ5JkBdCbM3gbj
 TH1K4Vmbfr7oZaNE61trSz6xjc4IsUMiOeSQoQf0MUwXtbzU0/bp04QBzqG49uFWeU5Y
 7qpGkeowumSaLFTD2qKWsmoqMTwHgtJN0jtwATf+w6LLmPfEMOBorzYvMwjmnO0qyLI+
 91kQ==
X-Gm-Message-State: AOAM532QJp+WmuGnm3VG+CmP4NDnr0O1Y5x+ZGcRT1rKPsCo+uG1hQPd
 iSS75Hw0s+zMHQpIfrhF+7OL5Q==
X-Google-Smtp-Source: ABdhPJyWKnV2DhTA2r066q2RHLN02VvLUP5QFDe1g7IHNygODIp9z4dzgpApqqaGBMVlgJ29TUexGA==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr3459206wmb.101.1606398190290; 
 Thu, 26 Nov 2020 05:43:10 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:09 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Fix
 function header related formatting issues
Date: Thu, 26 Nov 2020 13:42:17 +0000
Message-Id: <20201126134240.3214176-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdl
ci5jOjIzMjogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnaHdtZ3InIG5v
dCBkZXNjcmliZWQgaW4gJ3BobV9zdGFydF90aGVybWFsX2NvbnRyb2xsZXInCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmM6
MzgzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdod21ncicgbm90IGRl
c2NyaWJlZCBpbiAncGhtX2dldF9jbG9ja19pbmZvJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jOjM4Mzogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc3RhdGUnIG5vdCBkZXNjcmliZWQgaW4gJ3Bo
bV9nZXRfY2xvY2tfaW5mbycKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2Vy
cGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYzozODM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ3BjbG9ja19pbmZvJyBub3QgZGVzY3JpYmVkIGluICdwaG1fZ2V0X2Ns
b2NrX2luZm8nCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdt
Z3IvaGFyZHdhcmVtYW5hZ2VyLmM6MzgzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Ig
bWVtYmVyICdkZXNpZ25hdGlvbicgbm90IGRlc2NyaWJlZCBpbiAncGhtX2dldF9jbG9ja19pbmZv
JwoKQ2M6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2FtZC9wbS9wb3dl
cnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmMgIHwgMjUgKysrKysrKysrKy0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFu
YWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVt
YW5hZ2VyLmMKaW5kZXggNDVkZGUzZTc0YjU3OC4uMjViNTgzMWExNWNkMiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5h
Z2VyLmMKQEAgLTIyMywxMSArMjIzLDExIEBAIGludCBwaG1fcmVnaXN0ZXJfaXJxX2hhbmRsZXJz
KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB9CiAKIC8qKgotKiBJbml0aWFsaXplcyB0aGUgdGhl
cm1hbCBjb250cm9sbGVyIHN1YnN5c3RlbS4KLSoKLSogQHBhcmFtICAgIHBId01nciAgdGhlIGFk
ZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5hZ2VyLgotKiBAZXhjZXB0aW9uIFBQ
X1Jlc3VsdF9GYWlsZWQgaWYgYW55IG9mIHRoZSBwYXJhbXRlcnMgaXMgTlVMTCwgb3RoZXJ3aXNl
IHRoZSByZXR1cm4gdmFsdWUgZnJvbSB0aGUgZGlzcGF0Y2hlci4KLSovCisgKiBwaG1fc3RhcnRf
dGhlcm1hbF9jb250cm9sbGVyIC0gSW5pdGlhbGl6ZXMgdGhlIHRoZXJtYWwgY29udHJvbGxlciBz
dWJzeXN0ZW0uCisgKgorICogQGh3bWdyOiAgIHRoZSBhZGRyZXNzIG9mIHRoZSBwb3dlcnBsYXkg
aGFyZHdhcmUgbWFuYWdlci4KKyAqIEV4Y2VwdGlvbiBQUF9SZXN1bHRfRmFpbGVkIGlmIGFueSBv
ZiB0aGUgcGFyYW10ZXJzIGlzIE5VTEwsIG90aGVyd2lzZSB0aGUgcmV0dXJuIHZhbHVlIGZyb20g
dGhlIGRpc3BhdGNoZXIuCisgKi8KIGludCBwaG1fc3RhcnRfdGhlcm1hbF9jb250cm9sbGVyKHN0
cnVjdCBwcF9od21nciAqaHdtZ3IpCiB7CiAJaW50IHJldCA9IDA7CkBAIC0zNzEsMTMgKzM3MSwx
NCBAQCBpbnQgcGhtX2dldF9wZXJmb3JtYW5jZV9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdy
LCBjb25zdCBzdHJ1Y3QgcHBfaHdfcG93ZXJfcwogCiAKIC8qKgotKiBHZXRzIENsb2NrIEluZm8u
Ci0qCi0qIEBwYXJhbSAgICBwSHdNZ3IgIHRoZSBhZGRyZXNzIG9mIHRoZSBwb3dlcnBsYXkgaGFy
ZHdhcmUgbWFuYWdlci4KLSogQHBhcmFtICAgIHBQb3dlclN0YXRlIHRoZSBhZGRyZXNzIG9mIHRo
ZSBQb3dlciBTdGF0ZSBzdHJ1Y3R1cmUuCi0qIEBwYXJhbSAgICBwQ2xvY2tJbmZvIHRoZSBhZGRy
ZXNzIG9mIFBQX0Nsb2NrSW5mbyBzdHJ1Y3R1cmUgd2hlcmUgdGhlIHJlc3VsdCB3aWxsIGJlIHJl
dHVybmVkLgotKiBAZXhjZXB0aW9uIFBQX1Jlc3VsdF9GYWlsZWQgaWYgYW55IG9mIHRoZSBwYXJh
bXRlcnMgaXMgTlVMTCwgb3RoZXJ3aXNlIHRoZSByZXR1cm4gdmFsdWUgZnJvbSB0aGUgYmFjay1l
bmQuCi0qLworICogcGhtX2dldF9jbG9ja19pbmZvCisgKgorICogQGh3bWdyOiAgdGhlIGFkZHJl
c3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5hZ2VyLgorICogQHN0YXRlOiB0aGUgYWRk
cmVzcyBvZiB0aGUgUG93ZXIgU3RhdGUgc3RydWN0dXJlLgorICogQHBjbG9ja19pbmZvOiB0aGUg
YWRkcmVzcyBvZiBQUF9DbG9ja0luZm8gc3RydWN0dXJlIHdoZXJlIHRoZSByZXN1bHQgd2lsbCBi
ZSByZXR1cm5lZC4KKyAqIEBkZXNpZ25hdGlvbjogUEhNIHBlcmZvcm1hbmNlIGxldmVsIGRlc2ln
bmF0aW9uCisgKiBFeGNlcHRpb24gUFBfUmVzdWx0X0ZhaWxlZCBpZiBhbnkgb2YgdGhlIHBhcmFt
dGVycyBpcyBOVUxMLCBvdGhlcndpc2UgdGhlIHJldHVybiB2YWx1ZSBmcm9tIHRoZSBiYWNrLWVu
ZC4KKyAqLwogaW50IHBobV9nZXRfY2xvY2tfaW5mbyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCBj
b25zdCBzdHJ1Y3QgcHBfaHdfcG93ZXJfc3RhdGUgKnN0YXRlLCBzdHJ1Y3QgcHBfY2xvY2tfaW5m
byAqcGNsb2NrX2luZm8sCiAJCQlQSE1fUGVyZm9ybWFuY2VMZXZlbERlc2lnbmF0aW9uIGRlc2ln
bmF0aW9uKQogewotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
