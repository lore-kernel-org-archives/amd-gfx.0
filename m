Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0126C43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C4A2068D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C4A2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C316E61D;
	Fri, 15 Nov 2019 14:51:56 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C00B6E61D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 14:51:55 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id e2so8291228qkn.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 06:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iDOGe5YmbulTKtBAEN5lOVUgZJUdMLY7TVpIXd9q50E=;
 b=kkMIh3loU4scxXsTo/9i5oyE5cavrEC78/rX7ZGNaR8gJMdDagOtjUf77qNQDV/Wab
 MhjpTHlH+w+lHSzUGv+PKNSlZuY9uoaxN1Qx2Pc/+5B9VY1Jb7rcLvHSwl5iI/4OMP9r
 vs9MSW1z5xHTQonCRSHrcH9lCHwF22w1VKAMiP9+vaKvQ4vSVCMnjhUSyOz7DnJ7FHa/
 mqsjEkZrCXP9mnvoqg84pg1u/OtX62d9REYJJa5NrlQlvYDVb5PAoF29n4JqUIvefx9q
 KigrldZiiG279pxjx5PHsbCHFe5/xIEAH751xWHa1BmH1CUaKNP2CIPv28AKR/vYntnC
 5Djg==
X-Gm-Message-State: APjAAAV3SPrl/oy001/JDm4DcXFkLuRVhDU+gvixCNw2x75DgaWOKhLZ
 tAKbqzDSrED8JZLxzivlJ1hy6tGO
X-Google-Smtp-Source: APXvYqyliokh4g7YM1mfLlNUfmUjY+fi6NzBuvoW1qEsAGtdH167H310qhMrFqeXYBT//RVw8KtDDA==
X-Received: by 2002:a05:620a:1282:: with SMTP id
 w2mr142772qki.161.1573829514194; 
 Fri, 15 Nov 2019 06:51:54 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id n21sm5474717qtn.33.2019.11.15.06.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 06:51:53 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove experimental flag for Navi14
Date: Fri, 15 Nov 2019 09:51:46 -0500
Message-Id: <20191115145146.387393-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iDOGe5YmbulTKtBAEN5lOVUgZJUdMLY7TVpIXd9q50E=;
 b=EhfGGlQQiakvuHxM2CbvbGIsO7LJsiyNqhC2UFZOjETCZvhZjQYgpZoNpZtCibVNtg
 0/D6s1e5N8b6+Ki6//hc4bdsCVnQsh7eT61jrdbFZ0J+JqzGwu1Kl7HYNosCfXb8xJ6n
 1dm/YYWSjoe/Q08fssAxrVq0eANNgL5rZLSweMD6sHW6OF0eIMXLjUohx2c8yZ7ombzY
 /w85ypoIFBGr8s38IcqaphkMDEK6yrHtd63qTIWpeiwqJkLp882iHipTAuxwtGyMQ+tc
 e2zFiIJlX1ykAg4dkQ9fY6k31ew7EjKoyz/vyxF6TJ11MKkG9ce0w10RhpFo2eIzqXIr
 j/xg==
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
Message-ID: <20191115145146.yiO-4wZuS9u5u1PLwyPv4eURRkJhKjA8UDBVqvDe4vg@z>

NS40IGFuZCBuZXdlciB3b3JrcyBmaW5lIHdpdGggbmF2aTE0LgoKU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jCmluZGV4IGUxYzE1NzIxNjExYS4uYjE5MTU3YjE5ZmEwIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCkBAIC0xMDEzLDEwICsxMDEzLDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwY2lpZGxpc3RbXSA9IHsKIAl7MHgxMDAy
LCAweDczMUIsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfTkFWSTEwfSwKIAl7
MHgxMDAyLCAweDczMUYsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfTkFWSTEw
fSwKIAkvKiBOYXZpMTQgKi8KLQl7MHgxMDAyLCAweDczNDAsIFBDSV9BTllfSUQsIFBDSV9BTllf
SUQsIDAsIDAsIENISVBfTkFWSTE0fEFNRF9FWFBfSFdfU1VQUE9SVH0sCi0JezB4MTAwMiwgMHg3
MzQxLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX05BVkkxNHxBTURfRVhQX0hX
X1NVUFBPUlR9LAotCXsweDEwMDIsIDB4NzM0NywgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwg
MCwgQ0hJUF9OQVZJMTR8QU1EX0VYUF9IV19TVVBQT1JUfSwKLQl7MHgxMDAyLCAweDczNEYsIFBD
SV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfTkFWSTE0fEFNRF9FWFBfSFdfU1VQUE9S
VH0sCisJezB4MTAwMiwgMHg3MzQwLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQ
X05BVkkxNH0sCisJezB4MTAwMiwgMHg3MzQxLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAw
LCBDSElQX05BVkkxNH0sCisJezB4MTAwMiwgMHg3MzQ3LCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lE
LCAwLCAwLCBDSElQX05BVkkxNH0sCisJezB4MTAwMiwgMHg3MzRGLCBQQ0lfQU5ZX0lELCBQQ0lf
QU5ZX0lELCAwLCAwLCBDSElQX05BVkkxNH0sCiAKIAkvKiBSZW5vaXIgKi8KIAl7MHgxMDAyLCAw
eDE2MzYsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfUkVOT0lSfEFNRF9JU19B
UFV8QU1EX0VYUF9IV19TVVBQT1JUfSwKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
