Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2040C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E7A2075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC3VR2QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E7A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1B96E488;
	Mon,  6 Jan 2020 15:03:48 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385AF6E488
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:48 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c127so12133078wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ws+lPypqL3tM5AVIlt3mDT6HQuwx14pk/6KL1Ail6q4=;
 b=nC3VR2QRgcZhwzVbm/KG2vhc9ZxU2tc4qcqm8z9eY+kQWn/8KP2wKU7mhLz2yKRwoT
 YA3H0oRmlm3nsQDWQMrel9GZO+ypY2340KBLqHdXNMyTcf/dresrl8IXQLXasUogF+Qi
 prZ9ZfyDYr6kGbuIOJHKVhl7AaYcsDlPWeqAhFv9qmPOYy181bG9lkJxpOR11uXi2fGM
 0Laltml4t2xU+iO/ACwdR8mq6frKqrxZ0n8fZLmHbTRkNnzP7oEItIpIu1Gz4dj5kTcH
 FN8y47AzuQDg0GjmlbuTkgYy9IqCALsxIQnWBPWgWuHMuapx9JK/tDcy1tcy4F2dz9Du
 0v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ws+lPypqL3tM5AVIlt3mDT6HQuwx14pk/6KL1Ail6q4=;
 b=ptK5rTtW3XEv5crIVihdbamqPcp5qosnnAeLI0+Elkiv4UsEXQDNtIJuKwDCpLGCgo
 l0rSCKHl3HrWa+aaMq92PXYbzCqpwu2LbyCdSg1ouxPEbIFCZL2PPDexXFCIPLZysuao
 cSqoNXPDioGn+O5NUy47XMggJftT/G19zdQnb73HJVk4xwicjcZP+lNj5jFAoAkXpiHk
 3xP07Du/UvS2gnYSGBwHzuIMf1WdmbPJ9x/o71r5NLS834Di7/+RYGNYC2PdvwXVlLI2
 WvIFUNSFyLtaJXmyBpruj6qSE3V/CX1dt5r2mbDuVwPiZEau04jI7/PlnjFa8lPxFpMn
 iOLw==
X-Gm-Message-State: APjAAAXIxjFzFoWy4roowGSa+MNDR17fxb+PNbVjKiPgGAuBXVYjUOll
 m5DAQtO5ADOAc/HqxD5uZnM=
X-Google-Smtp-Source: APXvYqzEnswEnyMYIyQZKmmPlyYmRMdBlSiiCvTYgACNTrVa6o+o0IF6HA7gxEBcaKLuYQf6jAcjNA==
X-Received: by 2002:a1c:6389:: with SMTP id
 x131mr33960629wmb.174.1578323026936; 
 Mon, 06 Jan 2020 07:03:46 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:46 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/12] drm/amdgpu: stop using amdgpu_bo_gpu_offset in the VM
 backend
Date: Mon,  6 Jan 2020 16:03:32 +0100
Message-Id: <20200106150335.1738-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106150335.1738-1-christian.koenig@amd.com>
References: <20200106150335.1738-1-christian.koenig@amd.com>
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

V2UgbmVlZCB0byB1cGRhdGUgcGFnZSB0YWJsZXMgd2l0aG91dCBhbnkgbG9jayBoZWxkLgoKU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMgfCA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKaW5kZXggZTdhMzgzMTM0NTIx
Li40Y2M3ODgxZjQzOGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bV9zZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
X3NkbWEuYwpAQCAtMTQwLDcgKzE0MCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9zZG1hX2Nv
cHlfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCiAKIAlzcmMgKz0gcC0+
bnVtX2R3X2xlZnQgKiA0OwogCi0JcGUgKz0gYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYm8pOworCXBl
ICs9IGFtZGdwdV9nbWNfc2lnbl9leHRlbmQoYm8tPnRiby5vZmZzZXQpOwogCXRyYWNlX2FtZGdw
dV92bV9jb3B5X3B0ZXMocGUsIHNyYywgY291bnQsIHAtPmRpcmVjdCk7CiAKIAlhbWRncHVfdm1f
Y29weV9wdGUocC0+YWRldiwgaWIsIHBlLCBzcmMsIGNvdW50KTsKQEAgLTE2Nyw3ICsxNjcsNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfdm1fc2RtYV9zZXRfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wYXJhbXMgKnAsCiB7CiAJc3RydWN0IGFtZGdwdV9pYiAqaWIgPSBwLT5qb2ItPmliczsK
IAotCXBlICs9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KGJvKTsKKwlwZSArPSBhbWRncHVfZ21jX3Np
Z25fZXh0ZW5kKGJvLT50Ym8ub2Zmc2V0KTsKIAl0cmFjZV9hbWRncHVfdm1fc2V0X3B0ZXMocGUs
IGFkZHIsIGNvdW50LCBpbmNyLCBmbGFncywgcC0+ZGlyZWN0KTsKIAlpZiAoY291bnQgPCAzKSB7
CiAJCWFtZGdwdV92bV93cml0ZV9wdGUocC0+YWRldiwgaWIsIHBlLCBhZGRyIHwgZmxhZ3MsCi0t
IAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
