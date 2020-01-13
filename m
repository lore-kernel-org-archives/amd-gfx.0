Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC73C33CB0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F6221569
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1Nhu+Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F6221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D362A6E0E2;
	Mon, 13 Jan 2020 14:41:03 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7618A6E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 14:41:02 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c14so8833692wrn.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ws+lPypqL3tM5AVIlt3mDT6HQuwx14pk/6KL1Ail6q4=;
 b=L1Nhu+XxmXM2zvxbq5Rf1IUJmXAKH+Y4//L8a3b7cqz8pQgdsdarr46TdMTt8tCDFU
 A86rHpSURWk6ybP3kEOq5Z6o+JSMtuu2LnhuFo4xWpaev6dptcrs0W9ZOs4qwQmv9K18
 Gxerguj30RZYny3P+fd4gENgYjnUDeG+OBnAcXieNv4m5jZKH/37QHXkzli2Ln67P12G
 Uyt7OdVys+w8qdFH/wmHg2oVhR48PrUmjJmosMQX5mpZ9a4es+NXcNU+Dv6+IalXrGcY
 PdDLZDHvy5Cu1VWJB52b0PP9XTfgiU8Ww7stCCA8Kt8Q/l4hhUnYJDID2xzTcx15sQ9I
 r7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ws+lPypqL3tM5AVIlt3mDT6HQuwx14pk/6KL1Ail6q4=;
 b=my8+SBzeH20psK+Nym4KB83bgS4mE80SJhGaV1Vr1jxHacAgHQbiZf4jYH5cPaxwAR
 VyUqPGczFwDxqJUmsVwotQRyGdeA93DgOmNwl0joVbJ8Ctxh6m8IF3qjYL1TIZAB/3h1
 GjFA/2VU8/dXWcL2oUg17nblTbCIbXNgsqsu5pW7uu1R4ebzch1uC8TWJarITyMJnDoU
 yKpdJkP/z7SAORND1yew9k29NMeF3ypNQU2QaZ40k88ernl4+oSa7KGyhh1hCmvc2Eev
 uYUxo6rCOO+XT4S73HgV1XORS0yv43q0pA0795gif5rIHHioBCDn2tjue5afUP3mK3lp
 /7Yw==
X-Gm-Message-State: APjAAAUJBp+X7SM7gL+RUiMiAmLsevpbuhYG2VVyuAWXM8fprPNp6k6K
 gD1PkcH/rlbyYDaxhZslKRBJegGS
X-Google-Smtp-Source: APXvYqz/+oqHUaWc4US9za2WfheDGcPCycbp2kczrMt4l0+Uxu3ufPTJE0faQmq3i2GgIjAmTttdUw==
X-Received: by 2002:adf:f847:: with SMTP id d7mr19483978wrq.35.1578926460860; 
 Mon, 13 Jan 2020 06:41:00 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd29:349f:9f33:2a26])
 by smtp.gmail.com with ESMTPSA id m10sm15347802wrx.19.2020.01.13.06.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:41:00 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 6/8] drm/amdgpu: stop using amdgpu_bo_gpu_offset in the VM
 backend
Date: Mon, 13 Jan 2020 15:40:53 +0100
Message-Id: <20200113144055.3416-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113144055.3416-1-christian.koenig@amd.com>
References: <20200113144055.3416-1-christian.koenig@amd.com>
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
