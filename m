Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB66FA372C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 01:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941412178F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 01:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941412178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9436E0D2;
	Thu,  7 Nov 2019 01:53:15 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B72B6E0D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 01:53:13 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id f12so205651qvu.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 17:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QER9t+uZk+ou5f6HTsJf2mvbwnuy58f6vnyQtoww2UA=;
 b=PsNy1iOVXME+KHC3JILei2P5wQG4t9C2a5zw6jMRi1C2Yjkrh4PzcCNHvCbA9WddMT
 pYEdH9rUrNMm/iaPZw6CzXqUpNfdU4SpUXjZvDXzJOmFQX8EqGgC+fGp3Vu9YRtLy4ig
 DS54GvsBg5PDmFRXV/yhYaVDU0eerT4iDCEdRDkI4I6lqePCBsQZPcnuF3gKdzIQdlve
 SPyRSYBK5rWN0yrfCTlKRxDabo2WqfyZpCRFhS0mWzYA/VIumUgpU4YjSs+qTQQn/R/x
 G2h5RApMg+nhnCm+ABgHEGClsimmlPB9QRgQE8rXF0qzE06o+g5f+nilen5siy/eRXkl
 CF+g==
X-Gm-Message-State: APjAAAXb2HH578tvg/VBt9/nGOKgmAvpVQuNFihKA8X+QB7mobIctLRo
 n86+lOiN5p69qlbBahUqQ/F3+oDQ
X-Google-Smtp-Source: APXvYqy4XwzEn3ZqoWJJo3HpqBxBwRnJD9yS5HLD2HpOq6DEdpSiGqpbprpe8kfF9Mr6e4I5c9tlvg==
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr1126937qvu.4.1573091592263;
 Wed, 06 Nov 2019 17:53:12 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id u7sm303478qkm.127.2019.11.06.17.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 17:53:11 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix the build when CONFIG_DRM_AMD_DC_DCN
 is not set
Date: Wed,  6 Nov 2019 20:52:58 -0500
Message-Id: <20191107015258.807545-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QER9t+uZk+ou5f6HTsJf2mvbwnuy58f6vnyQtoww2UA=;
 b=JyXokWPA7cPnZEdXmJAG/q5fV1vTO/3d/3tiQkzgNr95SQ9DI/S7g1vhnpyR4NasV5
 TY/nz7HWB5/Ms8L1D2w6MsBx6UrIYTRRn2bEwshD2I12zCGZvUIex5VJGV3tj114Mdy1
 nGXHMH0SxvZoYolxn36FzSXxd9qaCqiu8tUlyuZuMk3X8a8Kl0+6C0wEslCxvQX359B3
 TLBGl1+UAYN4jD2PoRew+UorrYssQyj9AGcHfK+8OZxtx8Wpo3AYUU7njkPnk6orlqto
 e4W80DsPP0cpF/DHB/0bx1FQOcO2dpSaakpVmpOU2d4Noqt0/hS5voYuTDCy+PKN97ey
 z3gw==
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
Message-ID: <20191107015258.d3LWjob_OOwxbJxexjLg0wWM5W6IihpFdpyzUo1POGE@z>

TmVlZCB0byBwcm90ZWN0IHNvbWUgRFNDIGZ1bmN0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCBhMWJkZDUxYzUwZjcuLmZjYmNmNTJhNzdlMCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jCkBAIC0zODkxLDcgKzM4OTEsOSBAQCBjcmVhdGVfc3RyZWFtX2Zvcl9zaW5rKHN0cnVjdCBh
bWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAogCWJvb2wgc2NhbGUgPSBkbV9zdGF0ZSA/
IChkbV9zdGF0ZS0+c2NhbGluZyAhPSBSTVhfT0ZGKSA6IGZhbHNlOwogCWludCBtb2RlX3JlZnJl
c2g7CiAJaW50IHByZWZlcnJlZF9yZWZyZXNoID0gMDsKKyNpZiBkZWZpbmVkKENPTkZJR19EUk1f
QU1EX0RDX0RDTikKIAlzdHJ1Y3QgZHNjX2RlY19kcGNkX2NhcHMgZHNjX2NhcHM7CisjZW5kaWYK
IAl1aW50MzJfdCBsaW5rX2JhbmR3aWR0aF9rYnBzOwogCiAJc3RydWN0IGRjX3NpbmsgKnNpbmsg
PSBOVUxMOwpAQCAtMzk3MCwxMiArMzk3MiwxNSBAQCBjcmVhdGVfc3RyZWFtX2Zvcl9zaW5rKHN0
cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAogCXN0cmVhbS0+dGltaW5nLmZs
YWdzLkRTQyA9IDA7CiAKIAlpZiAoYWNvbm5lY3Rvci0+ZGNfbGluayAmJiBzaW5rLT5zaW5rX3Np
Z25hbCA9PSBTSUdOQUxfVFlQRV9ESVNQTEFZX1BPUlQpIHsKKyNpZiBkZWZpbmVkKENPTkZJR19E
Uk1fQU1EX0RDX0RDTikKIAkJZGNfZHNjX3BhcnNlX2RzY19kcGNkKGFjb25uZWN0b3ItPmRjX2xp
bmstPmRwY2RfY2Fwcy5kc2NfY2Fwcy5kc2NfYmFzaWNfY2Fwcy5yYXcsCiAJCQkJICAgICAgYWNv
bm5lY3Rvci0+ZGNfbGluay0+ZHBjZF9jYXBzLmRzY19jYXBzLmRzY19leHRfY2Fwcy5yYXcsCiAJ
CQkJICAgICAgJmRzY19jYXBzKTsKKyNlbmRpZgogCQlsaW5rX2JhbmR3aWR0aF9rYnBzID0gZGNf
bGlua19iYW5kd2lkdGhfa2JwcyhhY29ubmVjdG9yLT5kY19saW5rLAogCQkJCQkJCSAgICAgZGNf
bGlua19nZXRfbGlua19jYXAoYWNvbm5lY3Rvci0+ZGNfbGluaykpOwogCisjaWYgZGVmaW5lZChD
T05GSUdfRFJNX0FNRF9EQ19EQ04pCiAJCWlmIChkc2NfY2Fwcy5pc19kc2Nfc3VwcG9ydGVkKQog
CQkJaWYgKGRjX2RzY19jb21wdXRlX2NvbmZpZyhhY29ubmVjdG9yLT5kY19saW5rLT5jdHgtPmRj
LT5yZXNfcG9vbC0+ZHNjc1swXSwKIAkJCQkJCSAgJmRzY19jYXBzLApAQCAtMzk4NCw2ICszOTg5
LDcgQEAgY3JlYXRlX3N0cmVhbV9mb3Jfc2luayhzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAq
YWNvbm5lY3RvciwKIAkJCQkJCSAgJnN0cmVhbS0+dGltaW5nLAogCQkJCQkJICAmc3RyZWFtLT50
aW1pbmcuZHNjX2NmZykpCiAJCQkJc3RyZWFtLT50aW1pbmcuZmxhZ3MuRFNDID0gMTsKKyNlbmRp
ZgogCX0KIAogCXVwZGF0ZV9zdHJlYW1fc2NhbGluZ19zZXR0aW5ncygmbW9kZSwgZG1fc3RhdGUs
IHN0cmVhbSk7Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
