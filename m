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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D8FC35242
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B997921741
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7dB9+wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B997921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F476FD7C;
	Fri,  7 Feb 2020 19:51:15 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EBB6FD79;
 Fri,  7 Feb 2020 19:51:13 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id c5so302945qtj.6;
 Fri, 07 Feb 2020 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zc8VUEzmS2dq9xbEMAR/0o9h5zNfSg0c9LVevXQTLAY=;
 b=X7dB9+wfz208ZU1hKc8hEDnQ2XiWbRFTjHqMgvXtpBOZEtmwsmMCQcqoWAPlhDc96y
 DOf7t/CMXmvZ2WlW1IP6BoOHOGadrh1Fbt5N++qJci1jMpamrLggVyctsoFP7quUX6h0
 vVX03z/DN1HHFNmMlddY3RtbHeMK/6jPrCg3HX3mea4n3HEGtx7+ZRAJpoTds1tC7yUw
 3RTnf9ikiK0DZaj+XDHlg7i6OP0962HWGkfdIr3GrE8VHUA6FNondZxe//eoXxkrZxvN
 QVQgdV2P2MGYfwtgqLWwLzIGVpp3ou0rPIAG+JKWWM4dDg/bRw+VzZUUGBnZhdo16s8V
 TTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zc8VUEzmS2dq9xbEMAR/0o9h5zNfSg0c9LVevXQTLAY=;
 b=rTFWnafcosI1xUsLWv2xu1c7Jfl3c8h2hsTp6DcJPdklFJLWg4gK5yepz1jXwXGa+d
 NaLc+6GQuuCvaSrZPRaL83UqQewpvEhbz6zvYu/pkEgOSZHVlg9vmo3k6/4FrB22LCke
 kC4CkVV0A5AHSo7Y7CMUaI3Jt4yQx9U+Dg+7Xxqcr241aeAbF+EZa7tEdt35Tq96a+BP
 dBXNrWDO7aNb26/Gj4GNOKPTyEYkuRNL1473DPrznZqMck6v6tLxOKqiLkz+EaDf+LwY
 ljEXYST6mFzbr+3oRWRUgf9eQX6dqAsCDOCyxXCy+ajjTJWhBoaAFlncz2DQ7Jw1LI1j
 GdWw==
X-Gm-Message-State: APjAAAXF0HmvunT+ES/vZvB1wTfiSb0QHMEKwQIImrxhd0OthraEF25W
 65syrdKIVz0XlmaI6hq4+1W7M2xl
X-Google-Smtp-Source: APXvYqysQB8uSWghFMLXtmL5WXltjrRiGIi1I3uR0Tx+RCOsCt4ZCYP0KbcEUjSAr/qbnDTsqj6gSQ==
X-Received: by 2002:ac8:1a8c:: with SMTP id x12mr461597qtj.297.1581105072581; 
 Fri, 07 Feb 2020 11:51:12 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w16sm1752226qkj.135.2020.02.07.11.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 11:51:12 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 07/15] drm/amdgpu/regs: move debugfs init into core amdgpu
 debugfs
Date: Fri,  7 Feb 2020 14:50:50 -0500
Message-Id: <20200207195058.2354-8-alexander.deucher@amd.com>
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgcmVnaXN0ZXIgYWNjZXNzIGZpbGVzLgoK
QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrKysKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAgfCA0IC0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IGNiN2RiN2VkZmMzZi4uNzcy
MWYxNDE2Y2RiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGVidWdmcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMKQEAgLTEyNTIsNiArMTI1MiwxMCBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBn
ZW0gZGVidWdmcyBmYWlsZWQgKCVkKS5cbiIsIHIpOwogCisJciA9IGFtZGdwdV9kZWJ1Z2ZzX3Jl
Z3NfaW5pdChhZGV2KTsKKwlpZiAocikKKwkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyByZWdpc3Rl
ciBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7CisKIAlyZXR1cm4gYW1kZ3B1X2RlYnVnZnNf
YWRkX2ZpbGVzKGFkZXYsIGFtZGdwdV9kZWJ1Z2ZzX2xpc3QsCiAJCQkJCUFSUkFZX1NJWkUoYW1k
Z3B1X2RlYnVnZnNfbGlzdCkpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCmluZGV4IGM3ODdhZWJjMjQwYi4uM2VjOTVjMTFlNzQ4IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0zMTIzLDEwICszMTIzLDYgQEAg
aW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl9IGVs
c2UKIAkJYWRldi0+dWNvZGVfc3lzZnNfZW4gPSB0cnVlOwogCi0JciA9IGFtZGdwdV9kZWJ1Z2Zz
X3JlZ3NfaW5pdChhZGV2KTsKLQlpZiAocikKLQkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyByZWdp
c3RlciBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0KIAlyID0gYW1kZ3B1X2RlYnVnZnNf
ZmlybXdhcmVfaW5pdChhZGV2KTsKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBm
aXJtd2FyZSBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0tIAoyLjI0LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
