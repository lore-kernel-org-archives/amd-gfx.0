Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB00C2BB55
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C331C2078C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQbCUAmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C331C2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA896E0B9;
	Tue,  7 Apr 2020 14:27:29 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34066E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 14:27:28 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id e26so1935834wmk.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Apr 2020 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EybpGQhcwTEzZW/sLd148FJ1boM3MavSaWmk2rf0G/c=;
 b=JQbCUAmJCThal7B+baMFjCRSIBBebiPLtjS2lSUyRlRpvluPVCllT0OMLpbxphriaR
 vtxlj/xEz1kkImhgN/Hp3R7srG0PX1vhdlMATLArGkp+QSnOLXjcWw7ZDcspgmMFBA5+
 A3PyI5m3Got9khrGGDlnqPMmAPAHcg/Nr6oF2DNuNPsqLhJ1vCmlBMv4L3RnbeazF814
 NDL80n7fK52YtUtX1+cX1HXeEDr+mcggVXCRBorqcmD3nnmaE/T9w1v6XYQtuz+/4or/
 iAut1Nj8FHH2/937ZnFywehNpY+MPXSyVp0krsAYNtLKrz2nPE3ObDhRTR5ianBfbJBN
 6MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EybpGQhcwTEzZW/sLd148FJ1boM3MavSaWmk2rf0G/c=;
 b=UjdBjWHZxdjlxew+0IrvAtgzMlIXjYA6OPrPE4fo3B+8n86YuwzPLRkL54FFg5KhYY
 1AXxaB9QtS0Pitm25E1dYgEx7Yjy00SL29GMUA5fPzpLxMJkQmdjcDiBzCgxcXZxTAA1
 iD5LUdpBW8HsgD1+sd4kMLEjs9g/cNacISHpxCZfU3BxJV633CwQH7kSAre9AGSFYeJB
 4INICyROSL/MyHSBV1OsLA5+RjVIDe3tIjHoIctqHh+9xfrs3UR5NI/WRTZjSVGEAoNK
 QAtk2MI25e+pe1ofNiQoIGQYbqOdi4pNkIlg4unWUN34ZeDEE1kV/+5ETDeOMwUVcQ9N
 6ipQ==
X-Gm-Message-State: AGi0PuY6JOIdKii1fA/fprKMFNrNVYqbGOXIT9WQSz+ldiKLohaKy06N
 BXwaglKYx2l8Ug9vANQGUU21u7Ya
X-Google-Smtp-Source: APiQypIxJ23YNLPkcq4eBlMp4b37/ZFl46nkKoIfoSfdDvYMNqnlPI1o4fGlrkHN7IXprc7BIXfOtQ==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr2399666wmf.189.1586269647076; 
 Tue, 07 Apr 2020 07:27:27 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cb4:6800:b8cb:179f])
 by smtp.gmail.com with ESMTPSA id r4sm2733782wrj.57.2020.04.07.07.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 07:27:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, Alex.Sierra@amd.com
Subject: [PATCH 1/4] drm/amdgpu: partial revert VM sync changes
Date: Tue,  7 Apr 2020 16:27:22 +0200
Message-Id: <20200407142725.17668-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2Ugc3RpbGwgbmVlZCB0byBhZGQgdGhlIFZNIHVwZGF0ZSBmZW5jZXMgdG8gdGhlIHJvb3QgUEQu
CgpTbyBtYWtlIHN1cmUgdG8gbmV2ZXIgc3luYyB0byB0aG9zZSBpbXBsaWNpdGVseS4KClNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgNSArKysrKwogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfc3luYy5jCmluZGV4IGI4NjM5MjI1MzY5Ni4uYjg3Y2ExNzE5ODZhIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKQEAgLTI0OSw2ICsyNDksMTEgQEAgaW50
IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRn
cHVfc3luYyAqc3luYywKIAkJICAgIG93bmVyICE9IEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklO
RUQpCiAJCQljb250aW51ZTsKIAorCQkvKiBOZXZlciBzeW5jIHRvIFZNIHVwZGF0ZXMgZWl0aGVy
LiAqLworCQlpZiAoZmVuY2Vfb3duZXIgPT0gQU1ER1BVX0ZFTkNFX09XTkVSX1ZNICYmCisJCSAg
ICBvd25lciAhPSBBTURHUFVfRkVOQ0VfT1dORVJfVU5ERUZJTkVEKQorCQkJY29udGludWU7CisK
IAkJLyogSWdub3JlIGZlbmNlcyBkZXBlbmRpbmcgb24gdGhlIHN5bmMgbW9kZSAqLwogCQlzd2l0
Y2ggKG1vZGUpIHsKIAkJY2FzZSBBTURHUFVfU1lOQ19BTFdBWVM6Ci0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
