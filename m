Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3FDC5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED22F21882
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED22F21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8526B6F9F6;
	Fri,  8 Nov 2019 16:24:36 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968036F9F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 16:24:35 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id q18so3013334ybq.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2019 08:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xGgSaRzze/l68w+4sz3GZ4ldI0bOHuUHKLqh39FDzQA=;
 b=EY6KzLE56HmLvyHkViMFr8UriHu+VTwid7ykjCkXSqLcFKlZwuvY8esVAGChk3oChJ
 XHL7ebrCLyjYi5q02m90C3WqOs5q2/+kXcyMARSi89ylN6n5Z0R5xUgf1w4r1/4yS/F7
 l+hOyUN8tur661o7qmCUZIkJg7THQkUXfNYbgu2Wa0rdXCktdrl58gw2V564XHLz4WlP
 Ij0h1MXJ3ud0Omau1diiqwsBv9rrVan1zFc/sEOOQrQnb6g7erQQ1l78aPEi7AY+2cwW
 pMGHNVaxWdjMcPkrj87+BtuM60SqHMRes2lqqAnZK2coKwEhrXQ9moYOD3UQAu52PQJa
 1QwQ==
X-Gm-Message-State: APjAAAW8DcpOLyXBi3wp9yKioIHSYJb5sH60fdrVkypTX+fAlNF3OQVZ
 EPbDv1S2Rb6JaR49v6rDzg13wL5n
X-Google-Smtp-Source: APXvYqwftHSRw5fqoXkg8zs5EadQEZFl0YEDPnvH4BFBVQVFktv9xrxXI4GT8gFhqhXNPozq10I7NQ==
X-Received: by 2002:a25:bccd:: with SMTP id l13mr2432657ybm.240.1573230274317; 
 Fri, 08 Nov 2019 08:24:34 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w66sm2946361ywb.62.2019.11.08.08.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 08:24:33 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix warning when CONFIG_DRM_AMD_DC_DCN is
 not set
Date: Fri,  8 Nov 2019 11:24:25 -0500
Message-Id: <20191108162425.2150451-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xGgSaRzze/l68w+4sz3GZ4ldI0bOHuUHKLqh39FDzQA=;
 b=tgJ9tzKAjO5k8Jxed4TzIQxOO4VwXt0Nsz+5FM9W3IMBXKIvrwW5gGPaM75YgfcEE7
 m9njjSmhyZ4xIE7aL8WDBAQeUjEhBrM7wWGLcP9lJd5tv8+PXJgRUg43CgyHTXuE73bF
 hdchB/HUTqHft//JvWofOK5EZXHIalPwAspD76bj6VDkRvCVIuVh0NsmntkH7oEF64Nv
 zSO7UnZ+FwJj8PpCWLgUH2rfOk1tgl6kgOxxrSuUuaw03oi7rDpLZAl/4aEn6U1TXQxP
 PwI1cIZPOJrYvSujRh3FjDD/OW2RcZX5D4pwlaUfUzDN+y4Gr0j8hL5cQoN5OcPpoegx
 yFoA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108162425.yrueRzSKuJ3gIZ5VRAhIbHhK1k-rRWUUggE3rzwa5XI@z>

ZG1fZGNuX2NydGNfaGlnaF9pcnEoKSBpcyBvbmx5IHVzZWQgd2hlbiBDT05GSUdfRFJNX0FNRF9E
Q19EQ04gaXMgc2V0LgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jCmluZGV4IGQyYzIzNjk0NjkwOS4uZWY0MGFkZjE4N2Y2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTQ4
NSw3ICs0ODUsNyBAQCBzdGF0aWMgdm9pZCBkbV9jcnRjX2hpZ2hfaXJxKHZvaWQgKmludGVycnVw
dF9wYXJhbXMpCiAJfQogfQogCi0KKyNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikK
IC8qKgogICogZG1fZGNuX2NydGNfaGlnaF9pcnEoKSAtIEhhbmRsZXMgVlN0YXJ0dXAgaW50ZXJy
dXB0IGZvciBEQ04gZ2VuZXJhdGlvbiBBU0lDcwogICogQGludGVycnVwdCBwYXJhbXMgLSBpbnRl
cnJ1cHQgcGFyYW1ldGVycwpAQCAtNTQ3LDYgKzU0Nyw3IEBAIHN0YXRpYyB2b2lkIGRtX2Rjbl9j
cnRjX2hpZ2hfaXJxKHZvaWQgKmludGVycnVwdF9wYXJhbXMpCiAKIAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZhZGV2LT5kZGV2LT5ldmVudF9sb2NrLCBmbGFncyk7CiB9CisjZW5kaWYKIAogc3Rh
dGljIGludCBkbV9zZXRfY2xvY2tnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLAogCQkgIGVudW0g
YW1kX2Nsb2NrZ2F0aW5nX3N0YXRlIHN0YXRlKQotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
