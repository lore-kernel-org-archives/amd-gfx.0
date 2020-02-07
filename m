Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9104DC35250
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A66921741
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9nkZr7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A66921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8E16FD7F;
	Fri,  7 Feb 2020 19:51:18 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD496FD84;
 Fri,  7 Feb 2020 19:51:17 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id v195so243646qkb.11;
 Fri, 07 Feb 2020 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fYgUQEGMVG8JCE7r/RnH+xa7UiWLAqjsWw9UAiCffeU=;
 b=i9nkZr7JNT0yDJ9qBz6CtBu2TvvL4K9SZe9x9AWEozko5/EFPYMod9hhgZ/zewVycn
 cQiWpD0ZZ2B5TWyWaz9bElrAXRsKb1c5HDImzau3q5MPvqcmjMsF1cmDORNG78ugFDfT
 gQS6g1WVRfCNfKTqQGNJZ5OfhA9tzR2FqBwIwFufq54Z1ZQCsHcEXKaUOPj9YQyT/EVw
 9HmyAuHczaY4KgZ9Eat8fQ0PixLLppKH9If/zLTGi+U/ga8EYbWdTXlJsV4bOr3zbsmW
 veYeUGCIFX/UJYkkHWaRGfd0KsUgK5PPGH8Hzob8q96FKpft56uQ6hivdrCUX1KxYfpe
 ZeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fYgUQEGMVG8JCE7r/RnH+xa7UiWLAqjsWw9UAiCffeU=;
 b=kQufXCzuzzHsM1WAOLWbzOf2zQSuG//lyAJglZcB0aGMT3AhSEILoHkx0gSwPOOcVk
 dW2yjNRGrc0B1QzSlOk2pRXk0VPiMREDdTam5GRpMJr3NLNew9EJSyDP6mlJBYDU15Rx
 QYrPyQfv7sK8Z9e8bkxuobEHBXl+D1Lr6L+/FUpLjWdfrOSCff0awdYDT3+BdPNPucmx
 Sdr1tAdnRyyWzZEOEbDQHEPnVvCALToE0Xc+rNpblWxoLej+Aa4SyYjloNCpz9IieHxW
 qm336ggcwVtagXVO7ImkgHjkLmAxeEcgg/Rj45Zr4F1SUvMxVOikxAdrGx6/vayNx9ho
 XCcw==
X-Gm-Message-State: APjAAAVSp4gYiuKmGclzhTqAuunEEze/AIE0Y0Zvd65RkxPAc87VecSU
 UAU8KIYgc9XxJSBbkXlBRB9DBKIb
X-Google-Smtp-Source: APXvYqyBlA/KlB5rma84tYQhnbfHw6kb/y2LAkKW2RrCzJOX8BxXQKjI8F3D091GTCndZ5SDhjoiMw==
X-Received: by 2002:a05:620a:49d:: with SMTP id
 29mr551012qkr.178.1581105076876; 
 Fri, 07 Feb 2020 11:51:16 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w16sm1752226qkj.135.2020.02.07.11.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 11:51:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 11/15] drm/amd/display: move dpcd debugfs members setup
Date: Fri,  7 Feb 2020 14:50:54 -0500
Message-Id: <20200207195058.2354-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207195058.2354-1-alexander.deucher@amd.com>
References: <20200207195058.2354-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW50byB0aGUgZnVuY3Rpb24gdGhhdCBjcmVhdGVzIHRoZSBkZWJ1Z2ZzIGZpbGVzIHJhdGhlcgp0
aGFuIHNldHRpbmcgdGhlbSBleHBsaWNpdGx5IGluIHRoZSBjYWxsZXJzLgoKUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyAgICAgICAgICAgfCAyIC0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMgICB8
IDMgKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9t
c3RfdHlwZXMuYyB8IDIgLS0KIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jCmluZGV4IDgxYzhkOGM2MWQ2Mi4uYWY4MTU1NzA4NTY5IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTU4
MzYsOCArNTgzNiw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9pbml0KHN0cnVj
dCBhbWRncHVfZGlzcGxheV9tYW5hZ2VyICpkbSwKIAogI2lmIGRlZmluZWQoQ09ORklHX0RFQlVH
X0ZTKQogCWNvbm5lY3Rvcl9kZWJ1Z2ZzX2luaXQoYWNvbm5lY3Rvcik7Ci0JYWNvbm5lY3Rvci0+
ZGVidWdmc19kcGNkX2FkZHJlc3MgPSAwOwotCWFjb25uZWN0b3ItPmRlYnVnZnNfZHBjZF9zaXpl
ID0gMDsKICNlbmRpZgogCiAJaWYgKGNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RFX0NPTk5FQ1RP
Ul9EaXNwbGF5UG9ydApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCmluZGV4IGVhZDVjMDVlZWM5Mi4uNmJjMGJk
Yzg4MzVjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9kZWJ1Z2ZzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCkBAIC0xMDY2LDYgKzEwNjYsOSBAQCB2b2lkIGNv
bm5lY3Rvcl9kZWJ1Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmNvbm5lY3Rv
cikKIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3Vuc2FmZSgiZm9yY2VfeXV2NDIwX291dHB1dCIsIDA2
NDQsIGRpciwgY29ubmVjdG9yLAogCQkJCSAgICZmb3JjZV95dXY0MjBfb3V0cHV0X2ZvcHMpOwog
CisJY29ubmVjdG9yLT5kZWJ1Z2ZzX2RwY2RfYWRkcmVzcyA9IDA7CisJY29ubmVjdG9yLT5kZWJ1
Z2ZzX2RwY2Rfc2l6ZSA9IDA7CisKIH0KIAogLyoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMKaW5kZXgg
NTY3MmY3NzY1OTE5Li4zOTU5Yzk0MmM4OGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCkBAIC0x
NTgsOCArMTU4LDYgQEAgYW1kZ3B1X2RtX21zdF9jb25uZWN0b3JfbGF0ZV9yZWdpc3RlcihzdHJ1
Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yKQogCiAjaWYgZGVmaW5lZChDT05GSUdfREVCVUdf
RlMpCiAJY29ubmVjdG9yX2RlYnVnZnNfaW5pdChhbWRncHVfZG1fY29ubmVjdG9yKTsKLQlhbWRn
cHVfZG1fY29ubmVjdG9yLT5kZWJ1Z2ZzX2RwY2RfYWRkcmVzcyA9IDA7Ci0JYW1kZ3B1X2RtX2Nv
bm5lY3Rvci0+ZGVidWdmc19kcGNkX3NpemUgPSAwOwogI2VuZGlmCiAKIAlyZXR1cm4gZHJtX2Rw
X21zdF9jb25uZWN0b3JfbGF0ZV9yZWdpc3Rlcihjb25uZWN0b3IsIHBvcnQpOwotLSAKMi4yNC4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
