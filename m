Return-Path: <SRS0=4Bis=K7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9BFC47082
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Jun 2021 14:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBE961287
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Jun 2021 14:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBE961287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BED6E18E;
	Sat,  5 Jun 2021 14:51:59 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA1F6E18E
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Jun 2021 14:51:58 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id ho18so8010350ejc.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Jun 2021 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UIigLj+LHZHTJ08ZnrqwvMe5ZdZgyu3VEzKCpwgUOzo=;
 b=eRNRYWn2iH3TXy50euyIgYQQz/LI/9YvFuMFn2V8n9OIrtMaiUY2Y6nCM3UAsaI2uC
 2Nm+/S2QCXMkfMlo6YjOi0It/Vtj1CJUm+udDHmIyM9MSVqioJXk4/kAcAE9Di6OwGwp
 yCBPQalh3RZp7f7igT8ZhcQAeh+PjkLrQGtwxfhUWg9t94K5Tqwk8GL1cff0R1yb559Z
 xv4gdRUIAo8HFvP1u5QyGuDvwBgZpn6cKTo6Zs9+mlYSdDQLeq93eHy2PPDEs+MfmuZS
 asuez3B9SrzBNslZiLJlMkhZHi6zUx6ON1Y+g/nlu2Fn6ocBNn1gQdE09Y2hV26EBm74
 VpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UIigLj+LHZHTJ08ZnrqwvMe5ZdZgyu3VEzKCpwgUOzo=;
 b=ekh/byDgy+vnFl1ZTPegNEvhQv5Kd9GGUHmbCxfMaBJGJIae+jcjDDCCsDWGGdxoLY
 pCeQX2ib4UBpvsmQTBTm6Ty/Gt7lxg92d5RUmknxUsKTVDrk4YKnzPfZ65XQXBzbf6kI
 vE8becju5tS1xor7Qwl0BryEnWTr7dl2121KxXcW2ULyC0bxIhAJoY8m4Ti4/XJupKh6
 ihlIEcT2obVhaZ6JZObKb49XHOkXPChPj40vFwbQ5VFI3B+ZgbcSHXfj9uyfgpiHBcaK
 EChzuffE5n/Xl6BWuXFizCrUInBgKdKi/+9hecrDBG1NmXz+Z0d/5WrZfPdG/B1JVs6A
 3CpA==
X-Gm-Message-State: AOAM530LFQ0U+hc+nkjlFA1ggALQGZbJjxfnlUD1Ad02N79Lh6syv3F3
 OTRuEDtsvdXl+IWSYJHOrbRA3zrCoSE=
X-Google-Smtp-Source: ABdhPJyCxdDamUdBUGjwQb3UW8WBlxPHUxKE/nvG5HgjJbBGnsFZhUuMfINGzPL+IOsR1u5nhCS1Lg==
X-Received: by 2002:a17:907:7808:: with SMTP id
 la8mr7313163ejc.13.1622904717389; 
 Sat, 05 Jun 2021 07:51:57 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:207d:cd7a:b460:f7fe])
 by smtp.gmail.com with ESMTPSA id v8sm431955edc.59.2021.06.05.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jun 2021 07:51:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 Agustin.Gutierrez@amd.com
Subject: [PATCH] drm/amdgpu: fix VM handling for GART allocations
Date: Sat,  5 Jun 2021 16:51:55 +0200
Message-Id: <20210605145155.1468-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

Rm9yIEdUVCBhbGxvY2F0aW9ucyB3aXRoIGEgR0FSVCBhZGRyZXNzIHRoZSByZXMgY29udGFpbnMg
dGhlIFZNSUQwCmFkZHJlc3NlcyBhbmQgY2FuJ3QgYmUgdXNlZCBmb3IgVk0gaGFuZGxpbmcuCgpT
byBpZ25vcmUgdGhlIHJlcyB3aGVuIHRoZSBwYWdlcyBhcnJheSBpcyBnaXZlbiBvciB3ZSBmaWxs
IHRoZSBwYWdlCnRhYmxlcyB3aXRoIG5vbnNlbnNlLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKaW5kZXggYzI5ZmFkOTdiNjNhLi40MzM2NDJiM2U0OTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0xNzA1LDggKzE3MDUsOCBAQCBpbnQgYW1kZ3B1X3ZtX2Jv
X3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChyKQogCQln
b3RvIGVycm9yX3VubG9jazsKIAotCWFtZGdwdV9yZXNfZmlyc3QocmVzLCBvZmZzZXQsIChsYXN0
IC0gc3RhcnQgKyAxKSAqIEFNREdQVV9HUFVfUEFHRV9TSVpFLAotCQkJICZjdXJzb3IpOworCWFt
ZGdwdV9yZXNfZmlyc3QocGFnZXNfYWRkciA/IE5VTEwgOiByZXMsIG9mZnNldCwKKwkJCSAobGFz
dCAtIHN0YXJ0ICsgMSkgKiBBTURHUFVfR1BVX1BBR0VfU0laRSwgJmN1cnNvcik7CiAJd2hpbGUg
KGN1cnNvci5yZW1haW5pbmcpIHsKIAkJdWludDY0X3QgdG1wLCBudW1fZW50cmllcywgYWRkcjsK
IAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
