Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D082C56201
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD8120665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWEncwk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD8120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F71389CC4;
	Tue, 10 Nov 2020 19:35:53 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145D989BF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:39 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id s13so4300588wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sa4D9H3FopQ6FC9s62hXq/PcYKcafVSvMGNnPWttN0U=;
 b=bWEncwk9wr4hyGIAHgAfJ00TYqT033OOA+eahgRfxnsKrAZROWgGzK4sd1MmNS9oQh
 GvbtKa1pabul6vB72nEB1Z1XQjiEisZrnaYbvtUmksKjCeYfi3PX/VozLIBlVh4xq6UI
 +YjwyRORt6ZobT8cOQMaNz2JFglA/Ejzl9c68LomGj22IFWO/4Db/1SoszfAvaTa87qB
 oPBDIHnaFCRn1+y7xopvEOrQtiLc1NK2o6q5Dh8Q2zED+IdMw8r0K2GXUvtuDWRQl7kQ
 QYxR62UwnGQu9x4IsWiQgF9YKl27S1i+BEnsEIBco+s4+ATFiC8qmjqgffHlEHjAGSCc
 nrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sa4D9H3FopQ6FC9s62hXq/PcYKcafVSvMGNnPWttN0U=;
 b=f26kAhY4Z951jaO+KaM56oPgiXNxPW/ebDnTvBftc4QuCntNOCZtiBh4vb3wJr2O5U
 H/9ZN7w89tPU8N2AGycrYkUFnkqSZIZcXnumiBBr9k4EfRJl4zPaCxRsfCJwIeRWWgJp
 pt1ntYzGF9cn+HR2vd/6GNEp7EZ0fXOP6Pji1tS8EnBEJVTCKK/zOyhglvDuGqTErOM0
 EFrg+QqTQzaKKItTlrjDVZNgaZCCG9TjQD6JbDqLYYbGkEwEm2Um1SMKT4sjncSXrkqq
 iGktVot/fa/65zKeco9tpBT9Ok+5WraIkWV6mspbAg94JJ0GOXMbHd286p39meISrIHS
 sAaQ==
X-Gm-Message-State: AOAM533sIgKpA4Nmi5yygDn1BzyYTrKeFrviW6AYcwXq5dyQ6hgJgfgD
 JdUvFrEIMoZgh4asvZHWvFp1pg==
X-Google-Smtp-Source: ABdhPJxMzCyAB90AqZodmMsFV4EfQEGgS+LK3ffepxG/qIDXNCwgZsjcazcENDfW54TAA65US0X6Qw==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr754555wma.14.1605036697717;
 Tue, 10 Nov 2020 11:31:37 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:37 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/30] drm/radeon/r600_cs: Fix some doc-rot and supply missing
 function param docs
Date: Tue, 10 Nov 2020 19:30:59 +0000
Message-Id: <20201110193112.988999-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmM6NzkzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0
ZXIgb3IgbWVtYmVyICdwJyBub3QgZGVzY3JpYmVkIGluICdyNjAwX2NzX3BhY2tldF9wYXJzZV92
bGluZScKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9jcy5jOjc5Mzogd2FybmluZzogRXhj
ZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAncGFyc2VyJyBkZXNjcmlwdGlvbiBpbiAncjYwMF9jc19w
YWNrZXRfcGFyc2VfdmxpbmUnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYzo4MjY6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3AnIG5vdCBkZXNjcmliZWQg
aW4gJ3I2MDBfY3NfY29tbW9uX3ZsaW5lX3BhcnNlJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
NjAwX2NzLmM6ODI2OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdwYXJzZXIn
IGRlc2NyaXB0aW9uIGluICdyNjAwX2NzX2NvbW1vbl92bGluZV9wYXJzZScKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcjYwMF9jcy5jOjk2ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9y
IG1lbWJlciAncCcgbm90IGRlc2NyaWJlZCBpbiAncjYwMF9jc19jaGVja19yZWcnCiBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYzo5Njg6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBw
YXJhbWV0ZXIgJ3BhcnNlcicgZGVzY3JpcHRpb24gaW4gJ3I2MDBfY3NfY2hlY2tfcmVnJwogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmM6MTQ3Mzogd2FybmluZzogRnVuY3Rpb24gcGFy
YW1ldGVyIG9yIG1lbWJlciAnYmFzZV9vZmZzZXQnIG5vdCBkZXNjcmliZWQgaW4gJ3I2MDBfY2hl
Y2tfdGV4dHVyZV9yZXNvdXJjZScKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9jcy5jOjE0
NzM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ21pcF9vZmZzZXQnIG5v
dCBkZXNjcmliZWQgaW4gJ3I2MDBfY2hlY2tfdGV4dHVyZV9yZXNvdXJjZScKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcjYwMF9jcy5jOjE0NzM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBv
ciBtZW1iZXIgJ3RpbGluZ19mbGFncycgbm90IGRlc2NyaWJlZCBpbiAncjYwMF9jaGVja190ZXh0
dXJlX3Jlc291cmNlJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9u
ZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYyB8IDkg
KysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9jcy5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmMKaW5kZXggMzkwYTk2MjE2MDRhZS4uZjIwYjYxOTQ2
NjgxNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmMKQEAgLTc4Miw3ICs3ODIsNyBAQCBzdGF0
aWMgaW50IHI2MDBfY3NfdHJhY2tfY2hlY2soc3RydWN0IHJhZGVvbl9jc19wYXJzZXIgKnApCiAK
IC8qKgogICogcjYwMF9jc19wYWNrZXRfcGFyc2VfdmxpbmUoKSAtIHBhcnNlIHVzZXJzcGFjZSBW
TElORSBwYWNrZXQKLSAqIEBwYXJzZXI6CQlwYXJzZXIgc3RydWN0dXJlIGhvbGRpbmcgcGFyc2lu
ZyBjb250ZXh0LgorICogQHA6CQlwYXJzZXIgc3RydWN0dXJlIGhvbGRpbmcgcGFyc2luZyBjb250
ZXh0LgogICoKICAqIFRoaXMgaXMgYW4gUjYwMC1zcGVjaWZpYyBmdW5jdGlvbiBmb3IgcGFyc2lu
ZyBWTElORSBwYWNrZXRzLgogICogUmVhbCB3b3JrIGlzIGRvbmUgYnkgcjYwMF9jc19jb21tb25f
dmxpbmVfcGFyc2UgZnVuY3Rpb24uCkBAIC04MDEsNyArODAxLDcgQEAgc3RhdGljIGludCByNjAw
X2NzX3BhY2tldF9wYXJzZV92bGluZShzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCkKIAogLyoq
CiAgKiByNjAwX2NzX2NvbW1vbl92bGluZV9wYXJzZSgpIC0gY29tbW9uIHZsaW5lIHBhcnNlcgot
ICogQHBhcnNlcjoJCXBhcnNlciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQuCisg
KiBAcDoJCQlwYXJzZXIgc3RydWN0dXJlIGhvbGRpbmcgcGFyc2luZyBjb250ZXh0LgogICogQHZs
aW5lX3N0YXJ0X2VuZDogICAgdGFibGUgb2YgdmxpbmVfc3RhcnRfZW5kIHJlZ2lzdGVycwogICog
QHZsaW5lX3N0YXR1czogICAgICAgdGFibGUgb2YgdmxpbmVfc3RhdHVzIHJlZ2lzdGVycwogICoK
QEAgLTk1Niw3ICs5NTYsNyBAQCBzdGF0aWMgaW50IHI2MDBfY3NfcGFyc2VfcGFja2V0MChzdHJ1
Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCwKIAogLyoqCiAgKiByNjAwX2NzX2NoZWNrX3JlZygpIC0g
Y2hlY2sgaWYgcmVnaXN0ZXIgaXMgYXV0aG9yaXplZCBvciBub3QKLSAqIEBwYXJzZXI6IHBhcnNl
ciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQKKyAqIEBwOiBwYXJzZXIgc3RydWN0
dXJlIGhvbGRpbmcgcGFyc2luZyBjb250ZXh0CiAgKiBAcmVnOiByZWdpc3RlciB3ZSBhcmUgdGVz
dGluZwogICogQGlkeDogaW5kZXggaW50byB0aGUgY3MgYnVmZmVyCiAgKgpAQCAtMTQ2MCw2ICsx
NDYwLDkgQEAgc3RhdGljIHZvaWQgcjYwMF90ZXh0dXJlX3NpemUodW5zaWduZWQgbmZhY2VzLCB1
bnNpZ25lZCBibGV2ZWwsIHVuc2lnbmVkIGxsZXZlbCwKICAqIEBpZHg6IGluZGV4IGludG8gdGhl
IGNzIGJ1ZmZlcgogICogQHRleHR1cmU6IHRleHR1cmUncyBibyBzdHJ1Y3R1cmUKICAqIEBtaXBt
YXA6IG1pcG1hcCdzIGJvIHN0cnVjdHVyZQorICogQGJhc2Vfb2Zmc2V0OiBiYXNlIG9mZnNldCAo
dXNlZCBmb3IgZXJyb3IgY2hlY2tpbmcpCisgKiBAbWlwX29mZnNldDogbWlwIG9mZnNldCAodXNl
ZCBmb3IgZXJyb3IgY2hlY2tpbmcpCisgKiBAdGlsaW5nX2ZsYWdzOiB0aWxpbmcgZmxhZ3MKICAq
CiAgKiBUaGlzIGZ1bmN0aW9uIHdpbGwgY2hlY2sgdGhhdCB0aGUgcmVzb3VyY2UgaGFzIHZhbGlk
IGZpZWxkIGFuZCB0aGF0CiAgKiB0aGUgdGV4dHVyZSBhbmQgbWlwbWFwIGJvIG9iamVjdCBhcmUg
YmlnIGVub3VnaCB0byBjb3ZlciB0aGlzIHJlc291cmNlLgotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
