Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5076C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 18:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BA6207DA
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 18:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfkjGTp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA6207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66ED46EAD5;
	Thu,  9 Jul 2020 18:52:33 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B05B6EAD3;
 Thu,  9 Jul 2020 18:52:32 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id e11so2863627qkm.3;
 Thu, 09 Jul 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VsRubMwkm5N8B9pGE1CMG+iqiqWg8gI0YSv0AW7qGVk=;
 b=CfkjGTp+/FvKKjjyGr+QjsI3PNkLNPral3Yq7WjZ0Qpb4KRW4CtNoRQ2e1Uv3R2YI7
 T7WBmXxiGBBnZobDZVcpcGU4ZxL1GFMY7mm3QDxoGAVdUp3em1/rmMru3pKDVtTiMydD
 5GvZ2su8f6zOM2E1pRFOOAtMckHLN2TfbkMwwmEd+S3X4+G73FPPVqhyjTkcrrlFexSl
 SCLsZeJOFudBuzafxypKJU1jQQvR3iC0ZEIQFjWP8QOf4h3gMr/Jm6d1OpCYf6nY/Xx2
 XIGTftc+UHHPX+WmrM12s6RoZUCkSHBs/PT4NORG9Q7LeIa7MTrlVHsRINYKh2+7vNHH
 oVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VsRubMwkm5N8B9pGE1CMG+iqiqWg8gI0YSv0AW7qGVk=;
 b=KNC6n+mJM0kJc6ciWMSY5/aAszZRceFICzmSaFee9wYOIDR0Vf4W0QXb6ZFJOKNDpE
 54nmM3wW/U86zIhI8+3IP+NuHEL4Gox/FLx2OS4jnuP3ZqHAPB8zv9fpAqq/F42bezUz
 GZLoYoY9Gad0h5cpPG3sndXXeQY/qPKrcNewc0DcgCsSdFQPzRj9o8csl793n9JW1KO6
 UiGAsrGrNLhHDothU2wWxy67xqzYCGxhcenjDE0M6SmwbmVMoKV/i5TDN/hwQ6IsbmxT
 04QqOm/yor258p8gC3IIQtyqgDDJi0LBkqPvRv+3/W4/7lrZnRNmnuoCnTJwrhnsBai0
 PUWg==
X-Gm-Message-State: AOAM532Ji1Hs8xpxAsNUcwG6vfFhdd87NrwMahjh581KixkFp+6B7mI5
 1aYtNQtyCmwEWefQZGFYnFkdAROp
X-Google-Smtp-Source: ABdhPJzA4kVMlidJPnTOF0BtF/0wCuvBYEuF+udGXm35197Z5eENJGZoxn7SuNVM6CW4Q7skWnwVfQ==
X-Received: by 2002:a37:6449:: with SMTP id y70mr65218847qkb.435.1594320751509; 
 Thu, 09 Jul 2020 11:52:31 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id g145sm4750036qke.17.2020.07.09.11.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 11:52:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu and radeon drm-fixes-5.8
Date: Thu,  9 Jul 2020 14:52:21 -0400
Message-Id: <20200709185221.44895-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRGF2ZSwgRGFuaWVsLAoKRml4ZXMgZm9yIDUuOC4KClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBz
aW5jZSBjb21taXQgZGNiN2ZkODJjNzVlZTJkNmU2ZjlkOGNjNzFjNTI1MTllZDUyZTI1ODoKCiAg
TGludXggNS44LXJjNCAoMjAyMC0wNy0wNSAxNjoyMDoyMiAtMDcwMCkKCmFyZSBhdmFpbGFibGUg
aW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6Ly9wZW9wbGUuZnJlZWRlc2t0b3Aub3Jn
L35hZ2Q1Zi9saW51eCB0YWdzL2FtZC1kcm0tZml4ZXMtNS44LTIwMjAtMDctMDkKCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBmNDg5MmMzMjdhOGU1ZGY3Y2UxNmNhYjQwODk3ZGFmOTBi
YWY2YmVjOgoKICBkcm0vYW1kZ3B1OiBkb24ndCBkbyBzb2Z0IHJlY292ZXJ5IGlmIGdwdV9yZWNv
dmVyeT0wICgyMDIwLTA3LTA5IDE0OjQyOjQ5IC0wNDAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQphbWQtZHJtLWZpeGVz
LTUuOC0yMDIwLTA3LTA5OgoKYW1kZ3B1OgotIEZpeCBhIHN1c3BlbmQvcmVzdW1lIGlzc3VlIHdp
dGggUFNQCi0gQmFja2xpZ2h0IGZpeCBmb3IgUmVub2lyCi0gRml4IGZvciBncHUgcmVjb3Zlcnkg
ZGVidWdnaW5nCgpyYWRlb246Ci0gRml4IGEgZG91YmxlIGZyZWUgaW4gZXJyb3IgcGF0aAoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpBYXJvbiBNYSAoMSk6CiAgICAgIGRybS9hbWQvZGlzcGxheTogYWRkIGRtY3ViIGNoZWNr
IG9uIFJFTk9JUgoKSHVhbmcgUnVpICgyKToKICAgICAgZHJtL2FtZGdwdTogYXNkIGZ1bmN0aW9u
IG5lZWRzIHRvIGJlIHVubG9hZGVkIGluIHN1c3BlbmQgcGhhc2UKICAgICAgZHJtL2FtZGdwdTog
YWRkIFRNUiBkZXN0b3J5IGZ1bmN0aW9uIGZvciBwc3AKCk1hcmVrIE9sxaHDoWsgKDEpOgogICAg
ICBkcm0vYW1kZ3B1OiBkb24ndCBkbyBzb2Z0IHJlY292ZXJ5IGlmIGdwdV9yZWNvdmVyeT0wCgpU
b20gUml4ICgxKToKICAgICAgZHJtL3JhZGVvbjogZml4IGRvdWJsZSBmcmVlCgogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jICAgICAgICAgICB8ICAzICstCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgICAgICAgICAgIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaV9kcG0uYyAgICAgICAg
ICAgICAgICAgICB8ICA3ICsrLQogNCBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
