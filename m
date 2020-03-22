Return-Path: <SRS0=k9Mm=5H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC60C4332E
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 15:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2AC20722
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5FKR1K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2AC20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369696E0CB;
	Sun, 22 Mar 2020 15:48:40 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE176E0CF
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2020 15:48:39 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d5so1188990wrn.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2020 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=svWu57RMCKaJKbTuIqGGqATPcEzG5f3YXDcv7uYzpS8=;
 b=n5FKR1K7MBkO3F3iLhMi1lB5r8B9rUfhhdfgyqA+I1Je+m48Gi7fZcG1qPN6UF+0AW
 usstSc+SeMIUPBJziAO8VWe5pFNKGaV6LaWpTXAw0bYIg5/9GbgaArW8hApqV2GBIA1X
 nSl2AZE7ULuNJKyx020bphu0coVSsl2F4HWE7G8CL2ICnzw+YGMPUQKQgdrUpOAcKDaU
 2/G4i1po+rSgitN1ILepgXlyvYXa2p9SOJFCgTpjSLY5t5z1cWnZqzYUIzH3WHyR95dB
 49zqHO4mRW6BjX994kdt/SDNhWD+LmB3LK7sKF2LHZaBwNPZGQ6YHryq7Gpaa2S3HGsh
 YQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=svWu57RMCKaJKbTuIqGGqATPcEzG5f3YXDcv7uYzpS8=;
 b=mxroAjXgLj+P1h/7zmbbFV0TNsrCUELU1IwY7NGpFFXsgCtWddwk1DjS2D+Rm86Afp
 sJ1HnXmv4SmK1FBriy04LxPH7+8/wy+xs/uitjgfAOwXivjPXK2JlIzb1sAq1ue1oW2k
 t8OPWWeZfQNFjAosOg48AX5bUqyYFDi4TE6A1ptWmzKZH9GGU2r60JmX3KctnlF6nRWV
 C+/g7uOsWaiaBSzjvb4ByOcFoVtgPFD4bkOKX2VBdV3zpbYZma2fB9W2DG6mz3tTo9S7
 vqwpCQxwyYvgVNtjoCIMoy8cgwMWaVPLH9K3tdXtp0ESZrkyEHI+THctgY42ZK9PE+W9
 lOLA==
X-Gm-Message-State: ANhLgQ0frbNXB5Oi4HoAx6fbb3U3sZDFmCE29nN9m9mc5TZQf9AxxPzm
 PDXUvxZ5Na1ngcEgJnyzNaGd0r45
X-Google-Smtp-Source: ADFU+vurmbdqO9zIIp7tLg83RHImNqj/aAliHNmW3+9sx8Gzzxz20JBenx40X7xPlyFojIAZS6Cr0g==
X-Received: by 2002:a5d:468c:: with SMTP id u12mr9306926wrq.394.1584892117931; 
 Sun, 22 Mar 2020 08:48:37 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1252:fb60:30b8:db04:7ef1:ff43])
 by smtp.gmail.com with ESMTPSA id i12sm19450368wro.46.2020.03.22.08.48.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 22 Mar 2020 08:48:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 2/2] drm/amdgpu: add full TMZ support into
 amdgpu_ttm_map_buffer v2
Date: Sun, 22 Mar 2020 16:48:35 +0100
Message-Id: <20200322154835.2702-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200322154835.2702-1-christian.koenig@amd.com>
References: <20200322154835.2702-1-christian.koenig@amd.com>
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

VGhpcyBzaG91bGQgYWxsb3cgdXMgdG8gYWxzbyBzdXBwb3J0IFZSQU0tPkdUVCBtb3Zlcy4KCnYy
OiBmaXggbWlzc2luZyB2cmFtX2Jhc2VfYWRqdXN0bWVudAoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IDUzZGU5OWRiYWVh
ZC4uZTE1YTM0M2E5NDRiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
CkBAIC0zMDksMjEgKzMwOSwyMSBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1fbWFwX2J1ZmZlcihz
dHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJCSB1bnNpZ25lZCB3aW5kb3csIHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZywKIAkJCQkgYm9vbCB0bXosIHVpbnQ2NF90ICphZGRyKQogewot
CXN0cnVjdCB0dG1fZG1hX3R0ICpkbWEgPSBjb250YWluZXJfb2YoYm8tPnR0bSwgc3RydWN0IHR0
bV9kbWFfdHQsIHR0bSk7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2
OwogCXN0cnVjdCBhbWRncHVfam9iICpqb2I7CiAJdW5zaWduZWQgbnVtX2R3LCBudW1fYnl0ZXM7
Ci0JZG1hX2FkZHJfdCAqZG1hX2FkZHJlc3M7CiAJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2U7CiAJ
dWludDY0X3Qgc3JjX2FkZHIsIGRzdF9hZGRyOworCXZvaWQgKmNwdV9hZGRyOwogCXVpbnQ2NF90
IGZsYWdzOworCXVuc2lnbmVkIGludCBpOwogCWludCByOwogCiAJQlVHX09OKGFkZXYtPm1tYW4u
YnVmZmVyX2Z1bmNzLT5jb3B5X21heF9ieXRlcyA8CiAJICAgICAgIEFNREdQVV9HVFRfTUFYX1RS
QU5TRkVSX1NJWkUgKiA4KTsKIAogCS8qIE1hcCBvbmx5IHdoYXQgY2FuJ3QgYmUgYWNjZXNzZWQg
ZGlyZWN0bHkgKi8KLQlpZiAobWVtLT5zdGFydCAhPSBBTURHUFVfQk9fSU5WQUxJRF9PRkZTRVQp
IHsKKwlpZiAoIXRteiAmJiBtZW0tPnN0YXJ0ICE9IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkg
ewogCQkqYWRkciA9IGFtZGdwdV9tbV9ub2RlX2FkZHIoYm8sIG1tX25vZGUsIG1lbSkgKyBvZmZz
ZXQ7CiAJCXJldHVybiAwOwogCX0KQEAgLTM1MSwxNSArMzUxLDM3IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3R0bV9tYXBfYnVmZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCiAJYW1kZ3B1
X3JpbmdfcGFkX2liKHJpbmcsICZqb2ItPmlic1swXSk7CiAJV0FSTl9PTihqb2ItPmlic1swXS5s
ZW5ndGhfZHcgPiBudW1fZHcpOwogCi0JZG1hX2FkZHJlc3MgPSAmZG1hLT5kbWFfYWRkcmVzc1tv
ZmZzZXQgPj4gUEFHRV9TSElGVF07CiAJZmxhZ3MgPSBhbWRncHVfdHRtX3R0X3B0ZV9mbGFncyhh
ZGV2LCBiby0+dHRtLCBtZW0pOwogCWlmICh0bXopCiAJCWZsYWdzIHw9IEFNREdQVV9QVEVfVE1a
OwogCi0JciA9IGFtZGdwdV9nYXJ0X21hcChhZGV2LCAwLCBudW1fcGFnZXMsIGRtYV9hZGRyZXNz
LCBmbGFncywKLQkJCSAgICAmam9iLT5pYnNbMF0ucHRyW251bV9kd10pOwotCWlmIChyKQotCQln
b3RvIGVycm9yX2ZyZWU7CisJY3B1X2FkZHIgPSAmam9iLT5pYnNbMF0ucHRyW251bV9kd107CisK
KwlpZiAobWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVFQpIHsKKwkJc3RydWN0IHR0bV9kbWFfdHQg
KmRtYTsKKwkJZG1hX2FkZHJfdCAqZG1hX2FkZHJlc3M7CisKKwkJZG1hID0gY29udGFpbmVyX29m
KGJvLT50dG0sIHN0cnVjdCB0dG1fZG1hX3R0LCB0dG0pOworCQlkbWFfYWRkcmVzcyA9ICZkbWEt
PmRtYV9hZGRyZXNzW29mZnNldCA+PiBQQUdFX1NISUZUXTsKKwkJciA9IGFtZGdwdV9nYXJ0X21h
cChhZGV2LCAwLCBudW1fcGFnZXMsIGRtYV9hZGRyZXNzLCBmbGFncywKKwkJCQkgICAgY3B1X2Fk
ZHIpOworCQlpZiAocikKKwkJCWdvdG8gZXJyb3JfZnJlZTsKKwl9IGVsc2UgeworCQlkbWFfYWRk
cl90IGRtYV9hZGRyZXNzOworCisJCWRtYV9hZGRyZXNzID0gKG1tX25vZGUtPnN0YXJ0IDw8IFBB
R0VfU0hJRlQpICsgb2Zmc2V0OworCQlkbWFfYWRkcmVzcyArPSBhZGV2LT52bV9tYW5hZ2VyLnZy
YW1fYmFzZV9vZmZzZXQ7CisKKwkJZm9yIChpID0gMDsgaSA8IG51bV9wYWdlczsgKytpKSB7CisJ
CQlyID0gYW1kZ3B1X2dhcnRfbWFwKGFkZXYsIGkgPDwgUEFHRV9TSElGVCwgMSwKKwkJCQkJICAg
ICZkbWFfYWRkcmVzcywgZmxhZ3MsIGNwdV9hZGRyKTsKKwkJCWlmIChyKQorCQkJCWdvdG8gZXJy
b3JfZnJlZTsKKworCQkJZG1hX2FkZHJlc3MgKz0gUEFHRV9TSVpFOworCQl9CisJfQogCiAJciA9
IGFtZGdwdV9qb2Jfc3VibWl0KGpvYiwgJmFkZXYtPm1tYW4uZW50aXR5LAogCQkJICAgICAgQU1E
R1BVX0ZFTkNFX09XTkVSX1VOREVGSU5FRCwgJmZlbmNlKTsKLS0gCjIuMTQuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
