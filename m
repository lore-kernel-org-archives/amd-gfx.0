Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C685C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 22:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD13206E9
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 22:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3XahZRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD13206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADBF6E484;
	Mon,  6 Jul 2020 22:29:14 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE266E48D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 22:29:14 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id q17so1472118pls.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2020 15:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=xnfg+gOl/qA9JvNc5A2XKiYnCBMO/6cMYGdY71Nctm8=;
 b=u3XahZRkMwG+ItQh8N3aRWE+0o0yxnhh71lZVLPuWl9ZziMPJfytBhuDk0TfIHBO2E
 caDuZ2wyDbPfhVXgFhEq48H54MMvHZxlKuskNWKXC06eP1R4ywfry0lcxo9tt9duxNFA
 W39JjAqKmRJ2pNwgP4lUp60f5rs0D36hZ0+h3PwHODE3kbmfwSsbdZ5MJ2gTe6NoLrWM
 i7q7f1uLPSyKsvYrZMbajDNxQQPPlrD7V6ku3X4CeUSz/YhyuPZUa2kHJXK1b5bZGZRx
 B3fJzcblwL+NxWgp3eLdln0cctz+/U5dHgECYfWC5YEGY6b1tGeiGV00k1N/ddbItlWU
 NcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=xnfg+gOl/qA9JvNc5A2XKiYnCBMO/6cMYGdY71Nctm8=;
 b=OY6beQQmOe/roDCqvAxlImSI1kVHoeZw326Dl+Rk+bN6Yf5Sw5sfSdAn1OIN6+lQdw
 2zmf4mvzUz9c/YUAdBMP7gaGB84n7Ik5vMExBQobjZAxI3CBdCYEpbgLg1ejM5+BsmIH
 aS5LxxDfGdksydl8J+rIzItvWmaJ++rtRoegWMJejgdlh1bsrDky6mjy9Bu9lJoVvVgT
 /pFlm++UtjkxCkLXnoechMd+ML0M9vTZ6X3jOJwUzOe6TeecsoLvzPuYEnJTwkwUJbzY
 oEiPCQI0JZaye+z8mNa3IZ5WtA20r9Y5zXesA8w7rlROMMuTHpRuwsSlJOoh/z004D1y
 wfAw==
X-Gm-Message-State: AOAM530E+v5RnaKyxLn7pSTTSkdx0H4zZugAdDknMPus3QTiK7JhFNK5
 6XMoEoKQ5PC9z5HeWhfzkL/XTLlU3KnLleyd6jeSCg==
X-Google-Smtp-Source: ABdhPJyHp90fAkj+53YKoLfKEbHP0YZYm/IWjurMdqcTPldUKcA2ZKJ4Sk1HjcYk7ufW0127c9TQQDs7kO/AaN5SRBg=
X-Received: by 2002:a17:90a:cc03:: with SMTP id
 b3mr1151224pju.80.1594074553539; 
 Mon, 06 Jul 2020 15:29:13 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 6 Jul 2020 18:28:37 -0400
Message-ID: <CAAxE2A72dDioJeuFhOeW8OovUde2iCrhFaN9VcnhcNdZEKiAgw@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: don't do soft recovery if gpu_recovery=0
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="00000000000082794605a9cd67fd"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000082794605a9cd67fd
Content-Type: multipart/alternative; boundary="00000000000082794405a9cd67fb"

--00000000000082794405a9cd67fb
Content-Type: text/plain; charset="UTF-8"

Please review. Thanks.

Marek

--00000000000082794405a9cd67fb
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Please review. Thanks.</div><div><br></div><div>Marek<br></div></div>

--00000000000082794405a9cd67fb--

--00000000000082794605a9cd67fd
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-don-t-do-soft-recovery-if-gpu_recovery-0.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-don-t-do-soft-recovery-if-gpu_recovery-0.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kcb2sngh0>
X-Attachment-Id: f_kcb2sngh0

RnJvbSA3OTRhMjU5OWU4MWQ3ZDIxZTVjOGNhNDc1ODE4MzA5ZjU5YWQ3ZTQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogTW9uLCA2IEp1bCAyMDIwIDE4OjIzOjE3IC0wNDAw
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZG9uJ3QgZG8gc29mdCByZWNvdmVyeSBpZiBn
cHVfcmVjb3Zlcnk9MApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47
IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKSXQncyBpbXBv
c3NpYmxlIHRvIGRlYnVnIHNoYWRlciBoYW5ncyB3aXRoIHNvZnQgcmVjb3ZlcnkuCgpTaWduZWQt
b2ZmLWJ5OiBNYXJlayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2pvYi5jCmluZGV4IDI5NzVjNGE2ZTU4MS4uOTM3MDI5YWQ1MjcxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCkBAIC0zNyw3ICszNyw4IEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQogCiAJ
bWVtc2V0KCZ0aSwgMCwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfdGFza19pbmZvKSk7CiAKLQlpZiAo
YW1kZ3B1X3Jpbmdfc29mdF9yZWNvdmVyeShyaW5nLCBqb2ItPnZtaWQsIHNfam9iLT5zX2ZlbmNl
LT5wYXJlbnQpKSB7CisJaWYgKGFtZGdwdV9ncHVfcmVjb3ZlcnkgJiYKKwkgICAgYW1kZ3B1X3Jp
bmdfc29mdF9yZWNvdmVyeShyaW5nLCBqb2ItPnZtaWQsIHNfam9iLT5zX2ZlbmNlLT5wYXJlbnQp
KSB7CiAJCURSTV9FUlJPUigicmluZyAlcyB0aW1lb3V0LCBidXQgc29mdCByZWNvdmVyZWRcbiIs
CiAJCQkgIHNfam9iLT5zY2hlZC0+bmFtZSk7CiAJCXJldHVybjsKLS0gCjIuMTcuMQoK
--00000000000082794605a9cd67fd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000082794605a9cd67fd--
