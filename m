Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179DCC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 13:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0D52072C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 13:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv5OPPRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0D52072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C0672A58;
	Fri, 24 Jan 2020 13:05:31 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8883D72A5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 13:05:29 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g1so1544914wmh.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VF+QTW+RMV969+jpig6VUjuc8ljH0zUmIzA7bpvYtjQ=;
 b=Kv5OPPRFpHY5CGRxTm59X3K8YbcURGt/qy8M8JwBGBAqSIlWpPhYYC7n/QU+TEoNad
 q06ocuA6Q6MpW50DSE0NUOGEEvmWGTtn8Em3tsVWjtC4mZX3EGS8yD0T2svXhbywrbuK
 AxloHswyMrBFmr2YB3L+g7266Q9AvVJrHo1fHE5gy13+xZmiAtj/rKyE/4T/F7Y2i20f
 KtSFWbwUl1EF4Vgrj7Wh3ephECF3AcRb0HEyyBIY618Ac5Q1MtlnBTGdcBRzSvTlL0NK
 PkGMzokWl3WXkRuAdL46GEhOQDiML9NlMHgqEcUQb6CwHK5PFfG8CNfT12vsEBWASUFs
 9wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VF+QTW+RMV969+jpig6VUjuc8ljH0zUmIzA7bpvYtjQ=;
 b=onVZ7VVMSOQoob0DDdjWFx+TDc1hCcP15O6bDj+Ms6vOEbifMQr8wkagnmC6Z+LwAl
 OkS4a3lMBtgxdbJ6Qs37mGGtPy4WOBWr2E3yYBVXVlzPSgUdasx0QryoJ5DbMutdlsds
 T5oVmK5OgkphbqgaMnCWsf49TGDrhZ5vVFcPaz9rx5AsvJflIahS3Qbi0WzsGSZN1VTf
 etvogE5JR/8+C5VOoyqsBG7C55sr59qLGOL47EmrHZxqznSQFqx4NxFj4KbUA+7UfZXs
 Q7KZkNLi4byFvlkIswYiz4p6Ow1GW1oNrogyUm4wPpxvfccfMIgCGPr0IdOiTDemZul1
 hjsw==
X-Gm-Message-State: APjAAAWicSwLXZYVIzS7kiM/n012Ntn5e7yE0/2jgAAoFv1Nz3Yr6Cxb
 Xmbz267iBYcYnaU1PjkSjo4=
X-Google-Smtp-Source: APXvYqxpMpWBn7JW9dbLrh4r5mxP2Hgn352wU3rKXQxSXSZmCG/Qb7jJx5KYPxWZQyPLXaXFlXlX8A==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr3289715wmj.105.1579871128198; 
 Fri, 24 Jan 2020 05:05:28 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:9c03:ec12:e225:5a75])
 by smtp.gmail.com with ESMTPSA id g9sm7393513wro.67.2020.01.24.05.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 05:05:27 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Jonathan.Kim@amd.com, felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_vram_read
Date: Fri, 24 Jan 2020 14:05:25 +0100
Message-Id: <20200124130525.1800-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124130525.1800-1-christian.koenig@amd.com>
References: <20200124130525.1800-1-christian.koenig@amd.com>
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

VGhpcyBzcGVlZHMgdXAgdGhlIGFjY2VzcyBxdWl0ZSBhIGJpdCBmcm9tIDIuMiBNQi9zIHRvIDIu
OSBNQi9zIG9uIGEgUG9sYXJpcy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgfCAyNyArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IGFlMWIwMGRlZjVkOC4uNThkMTQzYjI0YmEwIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC01OSw2ICs1OSw4IEBACiAj
aW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgogI2luY2x1ZGUgImJpZi9iaWZfNF8xX2QuaCIKIAorI2Rl
ZmluZSBBTURHUFVfVFRNX1ZSQU1fTUFYX0RXX1JFQUQJKHNpemVfdCkxMjgKKwogc3RhdGljIGlu
dCBhbWRncHVfbWFwX2J1ZmZlcihzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJICAg
ICBzdHJ1Y3QgdHRtX21lbV9yZWcgKm1lbSwgdW5zaWduZWQgbnVtX3BhZ2VzLAogCQkJICAgICB1
aW50NjRfdCBvZmZzZXQsIHVuc2lnbmVkIHdpbmRvdywKQEAgLTIyNTUsMjcgKzIyNTcsMjAgQEAg
c3RhdGljIHNzaXplX3QgYW1kZ3B1X3R0bV92cmFtX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIg
X191c2VyICpidWYsCiAJaWYgKCpwb3MgPj0gYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSkKIAkJcmV0
dXJuIC1FTlhJTzsKIAorCXNpemUgPSBtaW4oc2l6ZSwgKHNpemVfdCkoYWRldi0+Z21jLm1jX3Zy
YW1fc2l6ZSAtICpwb3MpKTsKIAl3aGlsZSAoc2l6ZSkgewotCQl1bnNpZ25lZCBsb25nIGZsYWdz
OwotCQl1aW50MzJfdCB2YWx1ZTsKLQotCQlpZiAoKnBvcyA+PSBhZGV2LT5nbWMubWNfdnJhbV9z
aXplKQotCQkJcmV0dXJuIHJlc3VsdDsKLQotCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+bW1p
b19pZHhfbG9jaywgZmxhZ3MpOwotCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVgsICgodWludDMy
X3QpKnBvcykgfCAweDgwMDAwMDAwKTsKLQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYX0hJLCAq
cG9zID4+IDMxKTsKLQkJdmFsdWUgPSBSUkVHMzJfTk9fS0lRKG1tTU1fREFUQSk7Ci0JCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKKwkJc2l6ZV90
IGJ5dGVzID0gbWluKHNpemUsIEFNREdQVV9UVE1fVlJBTV9NQVhfRFdfUkVBRCAqIDQpOworCQl1
aW50MzJfdCB2YWx1ZVtBTURHUFVfVFRNX1ZSQU1fTUFYX0RXX1JFQURdOwogCi0JCXIgPSBwdXRf
dXNlcih2YWx1ZSwgKHVpbnQzMl90ICopYnVmKTsKKwkJYW1kZ3B1X2RldmljZV92cmFtX2FjY2Vz
cyhhZGV2LCAqcG9zLCB2YWx1ZSwgYnl0ZXMsIGZhbHNlKTsKKwkJciA9IGNvcHlfdG9fdXNlcihi
dWYsIHZhbHVlLCBieXRlcyk7CiAJCWlmIChyKQogCQkJcmV0dXJuIHI7CiAKLQkJcmVzdWx0ICs9
IDQ7Ci0JCWJ1ZiArPSA0OwotCQkqcG9zICs9IDQ7Ci0JCXNpemUgLT0gNDsKKwkJcmVzdWx0ICs9
IGJ5dGVzOworCQlidWYgKz0gYnl0ZXM7CisJCSpwb3MgKz0gYnl0ZXM7CisJCXNpemUgLT0gYnl0
ZXM7CiAJfQogCiAJcmV0dXJuIHJlc3VsdDsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
