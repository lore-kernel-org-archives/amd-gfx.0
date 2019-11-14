Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A2C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A682072C
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A682072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE316ECBB;
	Thu, 14 Nov 2019 16:42:02 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0243E6ECBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 16:42:01 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id q18so2797136ybq.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 08:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sOPf8vYGNZxM6vt4LXejgzz3I0xdpCH7kv4bGExG5sg=;
 b=JjFkp6Ziu6zd3u3O4q35P2PRf9CZmVor8PEXgMTZvi6JynBDyIthpYY9LOHwD5xsdw
 3nuH0hgq3MZ2IE+nk5SomCMQgqrmN8UWE9Ot+MZl1+SjeZ10mwiXSnb/QE3XdqyXPsSr
 ETSljIIOCLyDQ29kzZNRXQdpCiK4vDbLFtbiSYWLnqdl/TAu/D6eM+2QbNESDoV2NT9C
 1QnAdE7fjCXU0IiDphtYK/ydd+DANpl+Myr1OS8udexK35ICqGesscmYaXjIKypnFDwM
 pSkF+Gt9gjYrzCujaf+7X0oKQEJYCWc6lZgpO1GARpvnHo3G+jeDuQXQRHeALLzvPG2a
 /QGA==
X-Gm-Message-State: APjAAAUZE4G1S1YKq1kfLsQyGYikKiRQBzaThc09x46GMuXVxzp6zNgk
 YTG0mfngqopKpUsqOiLxnxuSnV4E
X-Google-Smtp-Source: APXvYqzkffZFF8QlyKGxHz+ExphdiKGfo1AHT68I+HLoHXeJUukTUCe9gasSBiZ4/NIcSHTDEMHXkQ==
X-Received: by 2002:a25:d0d7:: with SMTP id h206mr1117371ybg.315.1573749720620; 
 Thu, 14 Nov 2019 08:42:00 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id b63sm2200275ywc.94.2019.11.14.08.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 08:42:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Date: Thu, 14 Nov 2019 11:41:48 -0500
Message-Id: <20191114164148.2304223-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191114164148.2304223-1-alexander.deucher@amd.com>
References: <20191114164148.2304223-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sOPf8vYGNZxM6vt4LXejgzz3I0xdpCH7kv4bGExG5sg=;
 b=BiVoNf1ArcIveqyvaDTob4iURSnA6zPBmVJyCvYnTH6epbGdTS6/mJ/2KKOH0QMH6A
 R8p+e4OFmckUCtL1ZrcsMPlwj3MJvbJfsfniP9x8ZcCqVFylcMvBy2ovvqgf5FW3vEwX
 v9eN9H4m8uIT64UaJPU0f91HQn6OwzkPKjkL1Sca1PbHC3uyH8ZOLf4LpjN3PT8jjz3A
 SRgfJGqtXtPLXoSVQSih9GI/CAYQT++/yl3f3n35+ghXv3e/C8oMND+IIbnYMvE0yb4U
 +YmBqU+ambDoq2mCFJdsdRYhqFAnk19H/dv32k6UC+92WKoJWxTCRQy8cSQlx6kuZefB
 9iqw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191114164148.7cokg1_fcsnOS2T_mdAu5639GfnZkxf9IoVBVOPYVSs@z>

V2hlbiBnZnhvZmYgaXMgZW5hYmxlZCwgYWNjZXNzaW5nIGdmeCByZWdpc3RlcnMgdmlhIE1NSU8K
Y2FuIGxlYWQgdG8gYSBoYW5nLgoKQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTIwNTQ5NwpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ttcy5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
a21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggNmRk
ZWE3NjA3YWQwLi41ZjNiM2E3MDViMjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfa21zLmMKQEAgLTY1OSwxNSArNjU5LDE5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2luZm9faW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlCiAJ
CQlyZXR1cm4gLUVOT01FTTsKIAkJYWxsb2Nfc2l6ZSA9IGluZm8tPnJlYWRfbW1yX3JlZy5jb3Vu
dCAqIHNpemVvZigqcmVncyk7CiAKLQkJZm9yIChpID0gMDsgaSA8IGluZm8tPnJlYWRfbW1yX3Jl
Zy5jb3VudDsgaSsrKQorCQlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKKwkJZm9y
IChpID0gMDsgaSA8IGluZm8tPnJlYWRfbW1yX3JlZy5jb3VudDsgaSsrKSB7CiAJCQlpZiAoYW1k
Z3B1X2FzaWNfcmVhZF9yZWdpc3RlcihhZGV2LCBzZV9udW0sIHNoX251bSwKIAkJCQkJCSAgICAg
IGluZm8tPnJlYWRfbW1yX3JlZy5kd29yZF9vZmZzZXQgKyBpLAogCQkJCQkJICAgICAgJnJlZ3Nb
aV0pKSB7CiAJCQkJRFJNX0RFQlVHX0tNUygidW5hbGxvd2VkIG9mZnNldCAlI3hcbiIsCiAJCQkJ
CSAgICAgIGluZm8tPnJlYWRfbW1yX3JlZy5kd29yZF9vZmZzZXQgKyBpKTsKIAkJCQlrZnJlZShy
ZWdzKTsKKwkJCQlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIHRydWUpOwogCQkJCXJldHVybiAt
RUZBVUxUOwogCQkJfQorCQl9CisJCWFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7CiAJ
CW4gPSBjb3B5X3RvX3VzZXIob3V0LCByZWdzLCBtaW4oc2l6ZSwgYWxsb2Nfc2l6ZSkpOwogCQlr
ZnJlZShyZWdzKTsKIAkJcmV0dXJuIG4gPyAtRUZBVUxUIDogMDsKLS0gCjIuMjMuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
