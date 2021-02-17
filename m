Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAAFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA6E64DE0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA6E64DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD1D6E558;
	Wed, 17 Feb 2021 19:00:35 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562BA6E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 19:00:34 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id v9so13494055edw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MxtDzVk/CshUD+41osHg47YZ7FX1pB2Mk3TBP2kOADw=;
 b=o/R3vjAZuoixLn6Pt5186Ii01Z58/mO37c2lCmuQr+hfPPyvcsQPagZdYuFsKBPG0q
 sGodv69zEi/CNDpClYB5Ge/Xbz6MeicgqF9AJ4K44gOGU464H9KjTgivoDQBFkpqw21u
 lCA+JZOn+zbLD28zwJrfdl/6MoRMEfzLFLar49WEHF64ACIGwZ3Wdok/y208kQz4WUzC
 yUgwQ01MU1++PdQ4RgY25ybmq9WI0sA69AbeEwq1fqt7/6qVb/DYaOV2K8Agu73s6SIz
 x6u3Zp7JhzG2YjJdHFKOmC79Av75qTE9nqmVpvjrHc9d6lzoXPa6ZECDyVh1g/abcsq3
 +XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MxtDzVk/CshUD+41osHg47YZ7FX1pB2Mk3TBP2kOADw=;
 b=NfG/LCiCb/4VDNVSqOJbt1aKWlEl8s5fv1Ug1LwiG8mpYetaqqDKjIf0aBxVmEUpOb
 7dDQIJxV5VmexxiafJyMP6XM7+39G8bW/HnC8+TecwSRc9crm3yB4lPmSsHsEOZfVDQN
 +8EoybIbry36l9aA+ViBEDPeslKHFzmHFmYiZkvgGosd4iTWcxWIuLYLclm+kPtAbbJU
 9F7tsKYsRrvxFjfX/EpeQwvkiB1WwdeU0dIzejT0ypRlTzHOx5Efj+bcNCU8phylkG21
 z2aDLCtcPIuQ3lO6PX4vHLnapRhYRssmH1Jpps0JtR49vikYq4fwojHDl8fPrJ1Ic/zM
 VlZA==
X-Gm-Message-State: AOAM533J6UY57BS1jcj+SIFHnhvkCA/yCPxClLaXlDlV2UVYfbyeShvR
 slsIEx/NkRBNELHVELvslRfABF3N/BJcFw==
X-Google-Smtp-Source: ABdhPJwDLTS+JAvJnqVil/Zpi8bBET5lvSCZFb0ogY7cgsZoLQ4qKyA/RDAMxV2oqhdgw3qXikfvFg==
X-Received: by 2002:a05:6402:208:: with SMTP id
 t8mr243058edv.189.1613588433059; 
 Wed, 17 Feb 2021 11:00:33 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b7c6:d2d7:631c:11b7])
 by smtp.gmail.com with ESMTPSA id r4sm1562710edv.27.2021.02.17.11.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:00:32 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: use the new cursor in amdgpu_ttm_access_memory
Date: Wed, 17 Feb 2021 20:00:25 +0100
Message-Id: <20210217190028.16409-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
References: <20210217190028.16409-1-christian.koenig@amd.com>
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDY3ICsr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCA0OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
aW5kZXggZDY2ODhhMmU1MjVhLi4yMDQ5OTlkNDlmYTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE5MiwyNiArMTkyLDYgQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X21vdmVfbnVsbChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCW5ld19tZW0tPm1tX25v
ZGUgPSBOVUxMOwogfQogCi0vKioKLSAqIGFtZGdwdV9maW5kX21tX25vZGUgLSBIZWxwZXIgZnVu
Y3Rpb24gZmluZHMgdGhlIGRybV9tbV9ub2RlIGNvcnJlc3BvbmRpbmcgdG8KLSAqIEBvZmZzZXQu
IEl0IGFsc28gbW9kaWZpZXMgdGhlIG9mZnNldCB0byBiZSB3aXRoaW4gdGhlIGRybV9tbV9ub2Rl
IHJldHVybmVkCi0gKgotICogQG1lbTogVGhlIHJlZ2lvbiB3aGVyZSB0aGUgYm8gcmVzaWRlcy4K
LSAqIEBvZmZzZXQ6IFRoZSBvZmZzZXQgdGhhdCBkcm1fbW1fbm9kZSBpcyB1c2VkIGZvciBmaW5k
aW5nLgotICoKLSAqLwotc3RhdGljIHN0cnVjdCBkcm1fbW1fbm9kZSAqYW1kZ3B1X2ZpbmRfbW1f
bm9kZShzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0sCi0JCQkJCSAgICAgICB1aW50NjRfdCAqb2Zm
c2V0KQotewotCXN0cnVjdCBkcm1fbW1fbm9kZSAqbW1fbm9kZSA9IG1lbS0+bW1fbm9kZTsKLQot
CXdoaWxlICgqb2Zmc2V0ID49IChtbV9ub2RlLT5zaXplIDw8IFBBR0VfU0hJRlQpKSB7Ci0JCSpv
ZmZzZXQgLT0gKG1tX25vZGUtPnNpemUgPDwgUEFHRV9TSElGVCk7Ci0JCSsrbW1fbm9kZTsKLQl9
Ci0JcmV0dXJuIG1tX25vZGU7Ci19Ci0KIC8qKgogICogYW1kZ3B1X3R0bV9tYXBfYnVmZmVyIC0g
TWFwIG1lbW9yeSBpbnRvIHRoZSBHQVJUIHdpbmRvd3MKICAqIEBibzogYnVmZmVyIG9iamVjdCB0
byBtYXAKQEAgLTE1NjksNDEgKzE1NDksMzYgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3R0bV9ib19l
dmljdGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogICogYWNjZXNz
IGZvciBkZWJ1Z2dpbmcgcHVycG9zZXMuCiAgKi8KIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9hY2Nl
c3NfbWVtb3J5KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCi0JCQkJICAgIHVuc2lnbmVk
IGxvbmcgb2Zmc2V0LAotCQkJCSAgICB2b2lkICpidWYsIGludCBsZW4sIGludCB3cml0ZSkKKwkJ
CQkgICAgdW5zaWduZWQgbG9uZyBvZmZzZXQsIHZvaWQgKmJ1ZiwgaW50IGxlbiwKKwkJCQkgICAg
aW50IHdyaXRlKQogewogCXN0cnVjdCBhbWRncHVfYm8gKmFibyA9IHR0bV90b19hbWRncHVfYm8o
Ym8pOwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGFiby0+
dGJvLmJkZXYpOwotCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZXM7CisJc3RydWN0IGFtZGdwdV9y
ZXNfY3Vyc29yIGN1cnNvcjsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwogCXVpbnQzMl90IHZhbHVl
ID0gMDsKIAlpbnQgcmV0ID0gMDsKLQl1aW50NjRfdCBwb3M7Ci0JdW5zaWduZWQgbG9uZyBmbGFn
czsKIAogCWlmIChiby0+bWVtLm1lbV90eXBlICE9IFRUTV9QTF9WUkFNKQogCQlyZXR1cm4gLUVJ
TzsKIAotCXBvcyA9IG9mZnNldDsKLQlub2RlcyA9IGFtZGdwdV9maW5kX21tX25vZGUoJmFiby0+
dGJvLm1lbSwgJnBvcyk7Ci0JcG9zICs9IChub2Rlcy0+c3RhcnQgPDwgUEFHRV9TSElGVCk7Ci0K
LQl3aGlsZSAobGVuICYmIHBvcyA8IGFkZXYtPmdtYy5tY192cmFtX3NpemUpIHsKLQkJdWludDY0
X3QgYWxpZ25lZF9wb3MgPSBwb3MgJiB+KHVpbnQ2NF90KTM7Ci0JCXVpbnQ2NF90IGJ5dGVzID0g
NCAtIChwb3MgJiAzKTsKLQkJdWludDMyX3Qgc2hpZnQgPSAocG9zICYgMykgKiA4OworCWFtZGdw
dV9yZXNfZmlyc3QoJmJvLT5tZW0sIG9mZnNldCwgbGVuLCAmY3Vyc29yKTsKKwl3aGlsZSAoY3Vy
c29yLnJlbWFpbmluZykgeworCQl1aW50NjRfdCBhbGlnbmVkX3BvcyA9IGN1cnNvci5zdGFydCAm
IH4odWludDY0X3QpMzsKKwkJdWludDY0X3QgYnl0ZXMgPSA0IC0gKGN1cnNvci5zdGFydCAmIDMp
OworCQl1aW50MzJfdCBzaGlmdCA9IChjdXJzb3Iuc3RhcnQgJiAzKSAqIDg7CiAJCXVpbnQzMl90
IG1hc2sgPSAweGZmZmZmZmZmIDw8IHNoaWZ0OwogCi0JCWlmIChsZW4gPCBieXRlcykgewotCQkJ
bWFzayAmPSAweGZmZmZmZmZmID4+IChieXRlcyAtIGxlbikgKiA4OwotCQkJYnl0ZXMgPSBsZW47
CisJCWlmIChjdXJzb3Iuc2l6ZSA8IGJ5dGVzKSB7CisJCQltYXNrICY9IDB4ZmZmZmZmZmYgPj4g
KGJ5dGVzIC0gY3Vyc29yLnNpemUpICogODsKKwkJCWJ5dGVzID0gY3Vyc29yLnNpemU7CiAJCX0K
IAogCQlpZiAobWFzayAhPSAweGZmZmZmZmZmKSB7CiAJCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRl
di0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOwogCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAo
KHVpbnQzMl90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwogCQkJV1JFRzMyX05PX0tJUSht
bU1NX0lOREVYX0hJLCBhbGlnbmVkX3BvcyA+PiAzMSk7Ci0JCQlpZiAoIXdyaXRlIHx8IG1hc2sg
IT0gMHhmZmZmZmZmZikKLQkJCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKKwkJ
CXZhbHVlID0gUlJFRzMyX05PX0tJUShtbU1NX0RBVEEpOwogCQkJaWYgKHdyaXRlKSB7CiAJCQkJ
dmFsdWUgJj0gfm1hc2s7CiAJCQkJdmFsdWUgfD0gKCoodWludDMyX3QgKilidWYgPDwgc2hpZnQp
ICYgbWFzazsKQEAgLTE2MTUsMjEgKzE1OTAsMTUgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX2Fj
Y2Vzc19tZW1vcnkoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAkJCQltZW1jcHkoYnVm
LCAmdmFsdWUsIGJ5dGVzKTsKIAkJCX0KIAkJfSBlbHNlIHsKLQkJCWJ5dGVzID0gKG5vZGVzLT5z
dGFydCArIG5vZGVzLT5zaXplKSA8PCBQQUdFX1NISUZUOwotCQkJYnl0ZXMgPSBtaW4oYnl0ZXMg
LSBwb3MsICh1aW50NjRfdClsZW4gJiB+MHgzdWxsKTsKLQotCQkJYW1kZ3B1X2RldmljZV92cmFt
X2FjY2VzcyhhZGV2LCBwb3MsICh1aW50MzJfdCAqKWJ1ZiwKLQkJCQkJCSAgYnl0ZXMsIHdyaXRl
KTsKKwkJCWJ5dGVzID0gY3Vyc29yLnNpemUgJiAweDN1bGw7CisJCQlhbWRncHVfZGV2aWNlX3Zy
YW1fYWNjZXNzKGFkZXYsIGN1cnNvci5zdGFydCwKKwkJCQkJCSAgKHVpbnQzMl90ICopYnVmLCBi
eXRlcywKKwkJCQkJCSAgd3JpdGUpOwogCQl9CiAKIAkJcmV0ICs9IGJ5dGVzOwogCQlidWYgPSAo
dWludDhfdCAqKWJ1ZiArIGJ5dGVzOwotCQlwb3MgKz0gYnl0ZXM7Ci0JCWxlbiAtPSBieXRlczsK
LQkJaWYgKHBvcyA+PSAobm9kZXMtPnN0YXJ0ICsgbm9kZXMtPnNpemUpIDw8IFBBR0VfU0hJRlQp
IHsKLQkJCSsrbm9kZXM7Ci0JCQlwb3MgPSAobm9kZXMtPnN0YXJ0IDw8IFBBR0VfU0hJRlQpOwot
CQl9CisJCWFtZGdwdV9yZXNfbmV4dCgmY3Vyc29yLCBieXRlcyk7CiAJfQogCiAJcmV0dXJuIHJl
dDsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
