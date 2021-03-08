Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA9BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A1A65100
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A1A65100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF4A6E3EE;
	Mon,  8 Mar 2021 13:40:55 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F63889F8E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:40:50 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id p7so9035333eju.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7m6hZlZLnPHQecg0SJQVwZKR6RoYNpHN+dTjwWbeBxA=;
 b=OIo1PsU1bp846ka5G7HJGRAvMMa+/3lZBO5uaJYHXB8vBNlnNrVCZjsiC0HvxizJZe
 W2pZp4yO6NbywXB5pJsQ/QntuhvDpl8iu/q/uvnxmynPQkZKow7gPj4WByIvBSg0BMhG
 GAQrXzGJwIz7s8u3xbgpFIA36miVks0JzH9GtlS24XBxEn45YTBJMJBhRna9UHRUJH/e
 0TsD104AR1BMtYf0GWJiT2r0I0CnFDoWfbIIHWCXE3cu2C/66un6kdXP/C9lRRWvXl/N
 4PgWClnHCduNV6RPxsbC0TOBqQr2bdlp9TvtshVqhgL5O8zWcW2vjOMYvFif/x1mU8iN
 fQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7m6hZlZLnPHQecg0SJQVwZKR6RoYNpHN+dTjwWbeBxA=;
 b=p69B9EQkSwCjghGsywvrKjtH2c3tq79KF0jRVVtekVabABI6clT2Q/N5DFkyRaBYok
 /G+d4mzS+6luyriLm8aovPvgpHJ4dM+Qp83nGLx3Pjwgkvg+kmQNBjk35S+jkO6qm8AH
 NYrx33KqHqbogYvpFbr2dMzer5l9KmvB/fARPrC4rmtjqgenwZwJonSQzLnG/ARME2PS
 iLELwdHiw2uHsspXHm/PI3F6OO1NKlqegqtMTXMza6/kPhzmsqlQsFmZgRT1Qyih/UyL
 mfKvBfVoWasUyzGGcTlC3/iVZsmTGQ0SjitVKLMPwMipJUMQ1uu6UEPNapslffJ3iZRG
 7mUQ==
X-Gm-Message-State: AOAM531a1xcUcZIHpRew4pOjqF5iBshotxINV6bTzgd6aW2Oge8pBA+6
 ckUZjuq94GnF/FX4YZgRThYQQOZqlUFs6w==
X-Google-Smtp-Source: ABdhPJzSP+rh4T0w9LKewfN1Bdy5T86u8PlcsTBeHtTGaElAticyC1J3gRQPF8vQGa8pXLhp7EkLmg==
X-Received: by 2002:a17:906:ae88:: with SMTP id
 md8mr14583015ejb.264.1615210848980; 
 Mon, 08 Mar 2021 05:40:48 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f480:31ac:e949:bf58])
 by smtp.gmail.com with ESMTPSA id s18sm6655701ejc.79.2021.03.08.05.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 05:40:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: use the new cursor in amdgpu_ttm_access_memory
Date: Mon,  8 Mar 2021 14:40:41 +0100
Message-Id: <20210308134044.133658-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308134044.133658-1-christian.koenig@amd.com>
References: <20210308134044.133658-1-christian.koenig@amd.com>
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

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpBY2tlZC1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+ClRlc3RlZC1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyB8IDY3ICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggNTE3NjExYjcwOWZhLi4yY2JlNGFjZTU5MWYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE3OCwyNiArMTc4
LDYgQEAgc3RhdGljIGludCBhbWRncHVfdmVyaWZ5X2FjY2VzcyhzdHJ1Y3QgdHRtX2J1ZmZlcl9v
YmplY3QgKmJvLCBzdHJ1Y3QgZmlsZSAqZmlscCkKIAkJCQkJICBmaWxwLT5wcml2YXRlX2RhdGEp
OwogfQogCi0vKioKLSAqIGFtZGdwdV9maW5kX21tX25vZGUgLSBIZWxwZXIgZnVuY3Rpb24gZmlu
ZHMgdGhlIGRybV9tbV9ub2RlIGNvcnJlc3BvbmRpbmcgdG8KLSAqIEBvZmZzZXQuIEl0IGFsc28g
bW9kaWZpZXMgdGhlIG9mZnNldCB0byBiZSB3aXRoaW4gdGhlIGRybV9tbV9ub2RlIHJldHVybmVk
Ci0gKgotICogQG1lbTogVGhlIHJlZ2lvbiB3aGVyZSB0aGUgYm8gcmVzaWRlcy4KLSAqIEBvZmZz
ZXQ6IFRoZSBvZmZzZXQgdGhhdCBkcm1fbW1fbm9kZSBpcyB1c2VkIGZvciBmaW5kaW5nLgotICoK
LSAqLwotc3RhdGljIHN0cnVjdCBkcm1fbW1fbm9kZSAqYW1kZ3B1X2ZpbmRfbW1fbm9kZShzdHJ1
Y3QgdHRtX3Jlc291cmNlICptZW0sCi0JCQkJCSAgICAgICB1aW50NjRfdCAqb2Zmc2V0KQotewot
CXN0cnVjdCBkcm1fbW1fbm9kZSAqbW1fbm9kZSA9IG1lbS0+bW1fbm9kZTsKLQotCXdoaWxlICgq
b2Zmc2V0ID49IChtbV9ub2RlLT5zaXplIDw8IFBBR0VfU0hJRlQpKSB7Ci0JCSpvZmZzZXQgLT0g
KG1tX25vZGUtPnNpemUgPDwgUEFHRV9TSElGVCk7Ci0JCSsrbW1fbm9kZTsKLQl9Ci0JcmV0dXJu
IG1tX25vZGU7Ci19Ci0KIC8qKgogICogYW1kZ3B1X3R0bV9tYXBfYnVmZmVyIC0gTWFwIG1lbW9y
eSBpbnRvIHRoZSBHQVJUIHdpbmRvd3MKICAqIEBibzogYnVmZmVyIG9iamVjdCB0byBtYXAKQEAg
LTE0NzgsNDEgKzE0NTgsMzYgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3R0bV9ib19ldmljdGlvbl92
YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogICogYWNjZXNzIGZvciBkZWJ1
Z2dpbmcgcHVycG9zZXMuCiAgKi8KIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9hY2Nlc3NfbWVtb3J5
KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCi0JCQkJICAgIHVuc2lnbmVkIGxvbmcgb2Zm
c2V0LAotCQkJCSAgICB2b2lkICpidWYsIGludCBsZW4sIGludCB3cml0ZSkKKwkJCQkgICAgdW5z
aWduZWQgbG9uZyBvZmZzZXQsIHZvaWQgKmJ1ZiwgaW50IGxlbiwKKwkJCQkgICAgaW50IHdyaXRl
KQogewogCXN0cnVjdCBhbWRncHVfYm8gKmFibyA9IHR0bV90b19hbWRncHVfYm8oYm8pOwogCXN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGFiby0+dGJvLmJkZXYp
OwotCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZXM7CisJc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29y
IGN1cnNvcjsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwogCXVpbnQzMl90IHZhbHVlID0gMDsKIAlp
bnQgcmV0ID0gMDsKLQl1aW50NjRfdCBwb3M7Ci0JdW5zaWduZWQgbG9uZyBmbGFnczsKIAogCWlm
IChiby0+bWVtLm1lbV90eXBlICE9IFRUTV9QTF9WUkFNKQogCQlyZXR1cm4gLUVJTzsKIAotCXBv
cyA9IG9mZnNldDsKLQlub2RlcyA9IGFtZGdwdV9maW5kX21tX25vZGUoJmFiby0+dGJvLm1lbSwg
JnBvcyk7Ci0JcG9zICs9IChub2Rlcy0+c3RhcnQgPDwgUEFHRV9TSElGVCk7Ci0KLQl3aGlsZSAo
bGVuICYmIHBvcyA8IGFkZXYtPmdtYy5tY192cmFtX3NpemUpIHsKLQkJdWludDY0X3QgYWxpZ25l
ZF9wb3MgPSBwb3MgJiB+KHVpbnQ2NF90KTM7Ci0JCXVpbnQ2NF90IGJ5dGVzID0gNCAtIChwb3Mg
JiAzKTsKLQkJdWludDMyX3Qgc2hpZnQgPSAocG9zICYgMykgKiA4OworCWFtZGdwdV9yZXNfZmly
c3QoJmJvLT5tZW0sIG9mZnNldCwgbGVuLCAmY3Vyc29yKTsKKwl3aGlsZSAoY3Vyc29yLnJlbWFp
bmluZykgeworCQl1aW50NjRfdCBhbGlnbmVkX3BvcyA9IGN1cnNvci5zdGFydCAmIH4odWludDY0
X3QpMzsKKwkJdWludDY0X3QgYnl0ZXMgPSA0IC0gKGN1cnNvci5zdGFydCAmIDMpOworCQl1aW50
MzJfdCBzaGlmdCA9IChjdXJzb3Iuc3RhcnQgJiAzKSAqIDg7CiAJCXVpbnQzMl90IG1hc2sgPSAw
eGZmZmZmZmZmIDw8IHNoaWZ0OwogCi0JCWlmIChsZW4gPCBieXRlcykgewotCQkJbWFzayAmPSAw
eGZmZmZmZmZmID4+IChieXRlcyAtIGxlbikgKiA4OwotCQkJYnl0ZXMgPSBsZW47CisJCWlmIChj
dXJzb3Iuc2l6ZSA8IGJ5dGVzKSB7CisJCQltYXNrICY9IDB4ZmZmZmZmZmYgPj4gKGJ5dGVzIC0g
Y3Vyc29yLnNpemUpICogODsKKwkJCWJ5dGVzID0gY3Vyc29yLnNpemU7CiAJCX0KIAogCQlpZiAo
bWFzayAhPSAweGZmZmZmZmZmKSB7CiAJCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+bW1pb19p
ZHhfbG9jaywgZmxhZ3MpOwogCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQzMl90
KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwogCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVY
X0hJLCBhbGlnbmVkX3BvcyA+PiAzMSk7Ci0JCQlpZiAoIXdyaXRlIHx8IG1hc2sgIT0gMHhmZmZm
ZmZmZikKLQkJCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKKwkJCXZhbHVlID0g
UlJFRzMyX05PX0tJUShtbU1NX0RBVEEpOwogCQkJaWYgKHdyaXRlKSB7CiAJCQkJdmFsdWUgJj0g
fm1hc2s7CiAJCQkJdmFsdWUgfD0gKCoodWludDMyX3QgKilidWYgPDwgc2hpZnQpICYgbWFzazsK
QEAgLTE1MjQsMjEgKzE0OTksMTUgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX2FjY2Vzc19tZW1v
cnkoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAkJCQltZW1jcHkoYnVmLCAmdmFsdWUs
IGJ5dGVzKTsKIAkJCX0KIAkJfSBlbHNlIHsKLQkJCWJ5dGVzID0gKG5vZGVzLT5zdGFydCArIG5v
ZGVzLT5zaXplKSA8PCBQQUdFX1NISUZUOwotCQkJYnl0ZXMgPSBtaW4oYnl0ZXMgLSBwb3MsICh1
aW50NjRfdClsZW4gJiB+MHgzdWxsKTsKLQotCQkJYW1kZ3B1X2RldmljZV92cmFtX2FjY2Vzcyhh
ZGV2LCBwb3MsICh1aW50MzJfdCAqKWJ1ZiwKLQkJCQkJCSAgYnl0ZXMsIHdyaXRlKTsKKwkJCWJ5
dGVzID0gY3Vyc29yLnNpemUgJiAweDN1bGw7CisJCQlhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNz
KGFkZXYsIGN1cnNvci5zdGFydCwKKwkJCQkJCSAgKHVpbnQzMl90ICopYnVmLCBieXRlcywKKwkJ
CQkJCSAgd3JpdGUpOwogCQl9CiAKIAkJcmV0ICs9IGJ5dGVzOwogCQlidWYgPSAodWludDhfdCAq
KWJ1ZiArIGJ5dGVzOwotCQlwb3MgKz0gYnl0ZXM7Ci0JCWxlbiAtPSBieXRlczsKLQkJaWYgKHBv
cyA+PSAobm9kZXMtPnN0YXJ0ICsgbm9kZXMtPnNpemUpIDw8IFBBR0VfU0hJRlQpIHsKLQkJCSsr
bm9kZXM7Ci0JCQlwb3MgPSAobm9kZXMtPnN0YXJ0IDw8IFBBR0VfU0hJRlQpOwotCQl9CisJCWFt
ZGdwdV9yZXNfbmV4dCgmY3Vyc29yLCBieXRlcyk7CiAJfQogCiAJcmV0dXJuIHJldDsKLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
