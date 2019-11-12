Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70382C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1352067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1352067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038856EBD4;
	Tue, 12 Nov 2019 20:46:44 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F676EBE1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 20:22:54 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 15so15687891qkh.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 12:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=msUbALhd2xtO/lF1E2JMgXZu+n1aQVj3OW/hKQoForA=;
 b=Uedxbywp6L+gttQknKgfOp2b8z+N0vx9opbQSJAeMAft1M9m8/XZKQGya9/6QBQkE1
 klrC72vIXXT93iG0I/f20yFo5WDh/SVEgwUkEWmlMzVkSFL8u46FkGUT9d/qQXRa2ob6
 aKZzaE4d1Q9pzel1RCPLVzNlLZlzY7kYzLFdVEu/AJ7PrD6WUbuPyS3NmteH22aWesP0
 iF5bzJ1Z+Nm/fLk/QFGhZXHAWfR/GFZM8GeI5BS8GpKtkYMZA6ySeoL/5gpl0s37i+p5
 C+95fHe7ojZ/suvod1rB7LdIw8HdZNzqfdWEFv+wOqD7F5VaEUD2Y1JmyCx/G/U5ffK0
 RxOA==
X-Gm-Message-State: APjAAAVrzLH44a/UeVm4X49+HHyiFAA43nQtDfFjDj9cTYps782I7ZP7
 mRY64bH696Sbx6ryEQj2afFFYg==
X-Google-Smtp-Source: APXvYqwTjQHMd6Wnulr6l6RAuSHWZi+1OAZIts410/rBP3+s9ZvtJbjVwjBC9m86HVn1dWXuguyRLg==
X-Received: by 2002:a37:388:: with SMTP id 130mr17246331qkd.378.1573590173939; 
 Tue, 12 Nov 2019 12:22:53 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id j89sm10542127qte.72.2019.11.12.12.22.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iUcgZ-0003js-9n; Tue, 12 Nov 2019 16:22:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v3 04/14] mm/hmm: define the pre-processor related parts of
 hmm.h even if disabled
Date: Tue, 12 Nov 2019 16:22:21 -0400
Message-Id: <20191112202231.3856-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112202231.3856-1-jgg@ziepe.ca>
References: <20191112202231.3856-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Nov 2019 20:46:43 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=msUbALhd2xtO/lF1E2JMgXZu+n1aQVj3OW/hKQoForA=;
 b=Ud3HNeMvcBpWwpT3gZXaL68W5jc4GRJ5drmnCYR67cEqOCjBlZs5P2wDSQe6CODuSB
 J1EAZioZQ9rcwECNjBjxhvN/h7A8p86VQI+/cscWfNwd3d0hIbRq/S2rxZ3SgPq3SQsh
 IC5AA3IVMduEINV7agpnd2NheQMqXocW+A0dljsNBHcTFpF8kfqMqZZ9OeN7jjwlh7Vu
 +RMljsG8VsNCOP//jt8ErHFHC5yQyz4YCmqouEU/yr/aAtN1riu5Te8FNu87M6hJsHPz
 F2H3fOv/F0OG7KYT7tZbF/C2LTE0BLosUZkpzCl4MCjvJ2aFpMdhYX7vyVQP+AuIs2dr
 1tcw==
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
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112202221.dRAVIOmn81Fqj00aczCYMFAs9OFpRNtQWnTScY0P4yg@z>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKT25seSB0aGUgZnVuY3Rp
b24gY2FsbHMgYXJlIHN0dWJiZWQgb3V0IHdpdGggc3RhdGljIGlubGluZXMgdGhhdCBhbHdheXMK
ZmFpbC4gVGhpcyBpcyB0aGUgc3RhbmRhcmQgd2F5IHRvIHdyaXRlIGEgaGVhZGVyIGZvciBhbiBv
cHRpb25hbCBjb21wb25lbnQKYW5kIG1ha2VzIGl0IGVhc2llciBmb3IgZHJpdmVycyB0aGF0IG9u
bHkgb3B0aW9uYWxseSBuZWVkIEhNTV9NSVJST1IuCgpSZXZpZXdlZC1ieTogSsOpcsO0bWUgR2xp
c3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogUmFscGggQ2FtcGJlbGwgPHJjYW1w
YmVsbEBudmlkaWEuY29tPgpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxs
YW5veC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9obW0uaCB8IDU5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQoga2VybmVsL2ZvcmsuYyAgICAgICB8ICAxIC0K
IDIgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9obW0uaCBiL2luY2x1ZGUvbGludXgvaG1tLmgKaW5kZXgg
ZmJiMzVjNzg2MzdlNTcuLmNiNjliZjEwZGM3ODhjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L2htbS5oCisrKyBiL2luY2x1ZGUvbGludXgvaG1tLmgKQEAgLTYyLDggKzYyLDYgQEAKICNpbmNs
dWRlIDxsaW51eC9rY29uZmlnLmg+CiAjaW5jbHVkZSA8YXNtL3BndGFibGUuaD4KIAotI2lmZGVm
IENPTkZJR19ITU1fTUlSUk9SCi0KICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KICNpbmNsdWRl
IDxsaW51eC9taWdyYXRlLmg+CiAjaW5jbHVkZSA8bGludXgvbWVtcmVtYXAuaD4KQEAgLTM3NCw2
ICszNzIsMTUgQEAgc3RydWN0IGhtbV9taXJyb3IgewogCXN0cnVjdCBsaXN0X2hlYWQJCWxpc3Q7
CiB9OwogCisvKgorICogUmV0cnkgZmF1bHQgaWYgbm9uLWJsb2NraW5nLCBkcm9wIG1tYXBfc2Vt
IGFuZCByZXR1cm4gLUVBR0FJTiBpbiB0aGF0IGNhc2UuCisgKi8KKyNkZWZpbmUgSE1NX0ZBVUxU
X0FMTE9XX1JFVFJZCQkoMSA8PCAwKQorCisvKiBEb24ndCBmYXVsdCBpbiBtaXNzaW5nIFBURXMs
IGp1c3Qgc25hcHNob3QgdGhlIGN1cnJlbnQgc3RhdGUuICovCisjZGVmaW5lIEhNTV9GQVVMVF9T
TkFQU0hPVAkJKDEgPDwgMSkKKworI2lmZGVmIENPTkZJR19ITU1fTUlSUk9SCiBpbnQgaG1tX21p
cnJvcl9yZWdpc3RlcihzdHJ1Y3QgaG1tX21pcnJvciAqbWlycm9yLCBzdHJ1Y3QgbW1fc3RydWN0
ICptbSk7CiB2b2lkIGhtbV9taXJyb3JfdW5yZWdpc3RlcihzdHJ1Y3QgaG1tX21pcnJvciAqbWly
cm9yKTsKIApAQCAtMzgzLDE0ICszOTAsNiBAQCB2b2lkIGhtbV9taXJyb3JfdW5yZWdpc3Rlcihz
dHJ1Y3QgaG1tX21pcnJvciAqbWlycm9yKTsKIGludCBobW1fcmFuZ2VfcmVnaXN0ZXIoc3RydWN0
IGhtbV9yYW5nZSAqcmFuZ2UsIHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IpOwogdm9pZCBobW1f
cmFuZ2VfdW5yZWdpc3RlcihzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSk7CiAKLS8qCi0gKiBSZXRy
eSBmYXVsdCBpZiBub24tYmxvY2tpbmcsIGRyb3AgbW1hcF9zZW0gYW5kIHJldHVybiAtRUFHQUlO
IGluIHRoYXQgY2FzZS4KLSAqLwotI2RlZmluZSBITU1fRkFVTFRfQUxMT1dfUkVUUlkJCSgxIDw8
IDApCi0KLS8qIERvbid0IGZhdWx0IGluIG1pc3NpbmcgUFRFcywganVzdCBzbmFwc2hvdCB0aGUg
Y3VycmVudCBzdGF0ZS4gKi8KLSNkZWZpbmUgSE1NX0ZBVUxUX1NOQVBTSE9UCQkoMSA8PCAxKQot
CiBsb25nIGhtbV9yYW5nZV9mYXVsdChzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwgdW5zaWduZWQg
aW50IGZsYWdzKTsKIAogbG9uZyBobW1fcmFuZ2VfZG1hX21hcChzdHJ1Y3QgaG1tX3JhbmdlICpy
YW5nZSwKQEAgLTQwMSw2ICs0MDAsNDQgQEAgbG9uZyBobW1fcmFuZ2VfZG1hX3VubWFwKHN0cnVj
dCBobW1fcmFuZ2UgKnJhbmdlLAogCQkJIHN0cnVjdCBkZXZpY2UgKmRldmljZSwKIAkJCSBkbWFf
YWRkcl90ICpkYWRkcnMsCiAJCQkgYm9vbCBkaXJ0eSk7CisjZWxzZQoraW50IGhtbV9taXJyb3Jf
cmVnaXN0ZXIoc3RydWN0IGhtbV9taXJyb3IgKm1pcnJvciwgc3RydWN0IG1tX3N0cnVjdCAqbW0p
Cit7CisJcmV0dXJuIC1FT1BOT1RTVVBQOworfQorCit2b2lkIGhtbV9taXJyb3JfdW5yZWdpc3Rl
cihzdHJ1Y3QgaG1tX21pcnJvciAqbWlycm9yKQoreworfQorCitpbnQgaG1tX3JhbmdlX3JlZ2lz
dGVyKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlLCBzdHJ1Y3QgaG1tX21pcnJvciAqbWlycm9yKQor
eworCXJldHVybiAtRU9QTk9UU1VQUDsKK30KKwordm9pZCBobW1fcmFuZ2VfdW5yZWdpc3Rlcihz
dHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSkKK3sKK30KKworc3RhdGljIGlubGluZSBsb25nIGhtbV9y
YW5nZV9mYXVsdChzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwgdW5zaWduZWQgaW50IGZsYWdzKQor
eworCXJldHVybiAtRU9QTk9UU1VQUDsKK30KKworc3RhdGljIGlubGluZSBsb25nIGhtbV9yYW5n
ZV9kbWFfbWFwKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlLAorCQkJCSAgICAgc3RydWN0IGRldmlj
ZSAqZGV2aWNlLCBkbWFfYWRkcl90ICpkYWRkcnMsCisJCQkJICAgICB1bnNpZ25lZCBpbnQgZmxh
Z3MpCit7CisJcmV0dXJuIC1FT1BOT1RTVVBQOworfQorCitzdGF0aWMgaW5saW5lIGxvbmcgaG1t
X3JhbmdlX2RtYV91bm1hcChzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwKKwkJCQkgICAgICAgc3Ry
dWN0IGRldmljZSAqZGV2aWNlLAorCQkJCSAgICAgICBkbWFfYWRkcl90ICpkYWRkcnMsIGJvb2wg
ZGlydHkpCit7CisJcmV0dXJuIC1FT1BOT1RTVVBQOworfQorI2VuZGlmCiAKIC8qCiAgKiBITU1f
UkFOR0VfREVGQVVMVF9USU1FT1VUIC0gZGVmYXVsdCB0aW1lb3V0IChtcykgd2hlbiB3YWl0aW5n
IGZvciBhIHJhbmdlCkBAIC00MTEsNiArNDQ4LDQgQEAgbG9uZyBobW1fcmFuZ2VfZG1hX3VubWFw
KHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlLAogICovCiAjZGVmaW5lIEhNTV9SQU5HRV9ERUZBVUxU
X1RJTUVPVVQgMTAwMAogCi0jZW5kaWYgLyogSVNfRU5BQkxFRChDT05GSUdfSE1NX01JUlJPUikg
Ki8KLQogI2VuZGlmIC8qIExJTlVYX0hNTV9IICovCmRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5j
IGIva2VybmVsL2ZvcmsuYwppbmRleCBiY2RmNTMxMjUyMTAzNi4uY2EzOWNmYzQwNGUzZGIgMTAw
NjQ0Ci0tLSBhL2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpAQCAtNDAsNyArNDAs
NiBAQAogI2luY2x1ZGUgPGxpbnV4L2JpbmZtdHMuaD4KICNpbmNsdWRlIDxsaW51eC9tbWFuLmg+
CiAjaW5jbHVkZSA8bGludXgvbW11X25vdGlmaWVyLmg+Ci0jaW5jbHVkZSA8bGludXgvaG1tLmg+
CiAjaW5jbHVkZSA8bGludXgvZnMuaD4KICNpbmNsdWRlIDxsaW51eC9tbS5oPgogI2luY2x1ZGUg
PGxpbnV4L3ZtYWNhY2hlLmg+Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
