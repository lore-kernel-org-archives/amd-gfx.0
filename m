Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2EDC56201
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AEE20665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWC66NBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AEE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDED889C6C;
	Tue, 10 Nov 2020 19:35:45 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C6589BF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:40 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id r17so10093384wrw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Cw+c1bijBRNEJBNcuwyoDPT+QgFeRvOvo7TvhybLeo=;
 b=PWC66NBKBqbAKeaPvh+fIwPsUTrr77JZ5lJi/VUiSXJz+i6RhEnKMMZYfcZ/G2UmHS
 a+YlBfDGygGt7q/35lioOB52huJFQ/4W9ARw4RzVniBughzQAP5QgMHLhRrq49dkGIZQ
 mrepcU/Fv2c8lxZAr8DKuEPWqETk1RPZplypE7HhSn+lhM5ghhYl6M7bZ4qm3m1/kyOX
 ZhiIum/62edwMQSW1uEp2T+OvozCXyvm6gkVMi+ecPlH/CDWgw/452hJo0RsadXjeS8O
 7o3rXLRHMKFP34+OMUWPe7ofQIIgEZYs93wyJzCrnPT1ezVxMW9/AgiXTgoXrIqC1yNL
 57Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Cw+c1bijBRNEJBNcuwyoDPT+QgFeRvOvo7TvhybLeo=;
 b=fZVHIiS0sOewPMf/D1IeHhjGIFbIkNWudhfDH9t+nEN1wcg7XU7PpHIZ/Iw5oMmdxG
 1THAqO/pnhylVimmQMdOprQSf2skuhq2LXIaz5xxDMm0hQ+NKSltWS3tJc3jyx9rqcrn
 qIos/ZwgZe+l5fFse1ejgmO8xB8XkaMDVc6Dp3YeFXCq1m4bz9RlJHZo+k9NmiWMYYns
 drr7Adpve6Ro4HP/vsizW287BNWMAuYvQpAMkUjZUjW0BnODy9f0AAzfnjXEDsRnO8YP
 yGoVRp84e2VTHMBarUl4emSh97yUE8N/xNJlHa7nwDATeQ4DdhREdd5P59JK6peackpM
 PRwQ==
X-Gm-Message-State: AOAM530rMyA1dgzeYgBrJHgi8ePJtta4OdcN9+RYituI78uh91hvPro7
 U/aByapBUY8/xQg1dUHEWdl/pg==
X-Google-Smtp-Source: ABdhPJwObJNUH9bI5UnaQ5h1STq51/iqMrbw6I4FyP3eBEcoNXfxnJeJsn/CCHYRK5M0Re6eIDZ8gg==
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr25343044wrw.125.1605036698892; 
 Tue, 10 Nov 2020 11:31:38 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:38 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/30] drm/radeon/evergreen_cs: Fix misnaming issues
 surrounding 'p' param
Date: Tue, 10 Nov 2020 19:31:00 +0000
Message-Id: <20201110193112.988999-19-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW5fY3MuYzoxMDI2OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdwJyBub3QgZGVzY3JpYmVkIGluICdldmVyZ3JlZW5fY3NfcGFj
a2V0X3BhcnNlX3ZsaW5lJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW5fY3MuYzox
MDI2OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdwYXJzZXInIGRlc2NyaXB0
aW9uIGluICdldmVyZ3JlZW5fY3NfcGFja2V0X3BhcnNlX3ZsaW5lJwogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9ldmVyZ3JlZW5fY3MuYzoxMDk1OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIg
b3IgbWVtYmVyICdwJyBub3QgZGVzY3JpYmVkIGluICdldmVyZ3JlZW5fY3NfaGFuZGxlX3JlZycK
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2NzLmM6MTA5NTogd2FybmluZzogRXhj
ZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAncGFyc2VyJyBkZXNjcmlwdGlvbiBpbiAnZXZlcmdyZWVu
X2NzX2hhbmRsZV9yZWcnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9jcy5jOjE3
NTc6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3AnIG5vdCBkZXNjcmli
ZWQgaW4gJ2V2ZXJncmVlbl9pc19zYWZlX3JlZycKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZl
cmdyZWVuX2NzLmM6MTc1Nzogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAncGFy
c2VyJyBkZXNjcmlwdGlvbiBpbiAnZXZlcmdyZWVuX2lzX3NhZmVfcmVnJwoKQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9jcy5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW5fY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZl
cmdyZWVuX2NzLmMKaW5kZXggYzQxMGNhZDI4ZjE5Zi4uNTNiNzVjZjIwMTk1OCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW5fY3MuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9jcy5jCkBAIC0xMDE1LDcgKzEwMTUsNyBAQCBzdGF0aWMg
aW50IGV2ZXJncmVlbl9jc190cmFja19jaGVjayhzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCkK
IAogLyoqCiAgKiBldmVyZ3JlZW5fY3NfcGFja2V0X3BhcnNlX3ZsaW5lKCkgLSBwYXJzZSB1c2Vy
c3BhY2UgVkxJTkUgcGFja2V0Ci0gKiBAcGFyc2VyOgkJcGFyc2VyIHN0cnVjdHVyZSBob2xkaW5n
IHBhcnNpbmcgY29udGV4dC4KKyAqIEBwOgkJcGFyc2VyIHN0cnVjdHVyZSBob2xkaW5nIHBhcnNp
bmcgY29udGV4dC4KICAqCiAgKiBUaGlzIGlzIGFuIEV2ZXJncmVlbigrKS1zcGVjaWZpYyBmdW5j
dGlvbiBmb3IgcGFyc2luZyBWTElORSBwYWNrZXRzLgogICogUmVhbCB3b3JrIGlzIGRvbmUgYnkg
cjYwMF9jc19jb21tb25fdmxpbmVfcGFyc2UgZnVuY3Rpb24uCkBAIC0xMDg3LDcgKzEwODcsNyBA
QCBzdGF0aWMgaW50IGV2ZXJncmVlbl9jc19wYXJzZV9wYWNrZXQwKHN0cnVjdCByYWRlb25fY3Nf
cGFyc2VyICpwLAogCiAvKioKICAqIGV2ZXJncmVlbl9jc19oYW5kbGVfcmVnKCkgLSBwcm9jZXNz
IHJlZ2lzdGVycyB0aGF0IG5lZWQgc3BlY2lhbCBoYW5kbGluZy4KLSAqIEBwYXJzZXI6IHBhcnNl
ciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQKKyAqIEBwOiBwYXJzZXIgc3RydWN0
dXJlIGhvbGRpbmcgcGFyc2luZyBjb250ZXh0CiAgKiBAcmVnOiByZWdpc3RlciB3ZSBhcmUgdGVz
dGluZwogICogQGlkeDogaW5kZXggaW50byB0aGUgY3MgYnVmZmVyCiAgKi8KQEAgLTE3NDcsNyAr
MTc0Nyw3IEBAIHN0YXRpYyBpbnQgZXZlcmdyZWVuX2NzX2hhbmRsZV9yZWcoc3RydWN0IHJhZGVv
bl9jc19wYXJzZXIgKnAsIHUzMiByZWcsIHUzMiBpZHgpCiAKIC8qKgogICogZXZlcmdyZWVuX2lz
X3NhZmVfcmVnKCkgLSBjaGVjayBpZiByZWdpc3RlciBpcyBhdXRob3JpemVkIG9yIG5vdAotICog
QHBhcnNlcjogcGFyc2VyIHN0cnVjdHVyZSBob2xkaW5nIHBhcnNpbmcgY29udGV4dAorICogQHA6
IHBhcnNlciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQKICAqIEByZWc6IHJlZ2lz
dGVyIHdlIGFyZSB0ZXN0aW5nCiAgKgogICogVGhpcyBmdW5jdGlvbiB3aWxsIHRlc3QgYWdhaW5z
dCByZWdfc2FmZV9ibSBhbmQgcmV0dXJuIHRydWUKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
