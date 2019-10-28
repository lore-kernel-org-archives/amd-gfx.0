Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE3CA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 20:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EAF21721
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 20:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EAF21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AFF6E9FC;
	Mon, 28 Oct 2019 20:17:17 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB9989D84
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 20:10:47 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id x14so6223483qtq.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 13:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XfZfiXb3zJ195gWPi/l/D27toKL96PSF+DrXZsTvCKc=;
 b=XdYShpqb9KnUbakmrwNDRhB9MhttfeOS1I4Ot91lu6RuSU3DtvmOMes1OXt06lRREq
 0NnfjMNU6LDgTUfXrKLuFyXvyMleob1nKFuhDXjD+8Fd9Ge45HsAjGhIIqcw0SPHFI2s
 Sv5s1cr0YqraoypkV9/h14X3X3/VZGi7ZUBF0N2TEjpO8OyY9ILCy934Y9OuT3+za65m
 NbFpSPcZcBmxLMPcGOPCRPCVVJmF0PbFfOmjJWsvvu+hXltG9yBN3HU+eWJcNztRzo09
 Mg9shlpfGzyuDXAzIgNM9Wu+1f+I/UJsXdIwkHgMDf+JzGndL8xJp2eHwtCeI5V0wgYR
 qYEg==
X-Gm-Message-State: APjAAAUYUKI3Op6lmy5NJl+hkx5MIKOs4ZfdN3lxixI6KMoVrZ+r9xqj
 lPciHpBo8WC5IiP1ZNpcdVPp7w==
X-Google-Smtp-Source: APXvYqyzwQd88COzKjNYUtUi77xt5inAXAbC04JrmAuM/rVN/+ea+Lu0JHPIt/2aFSc9iA4BmT0l3w==
X-Received: by 2002:ac8:3f67:: with SMTP id w36mr271020qtk.99.1572293446378;
 Mon, 28 Oct 2019 13:10:46 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id r7sm6375208qkf.124.2019.10.28.13.10.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iPBLf-0001gM-77; Mon, 28 Oct 2019 17:10:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 04/15] mm/hmm: define the pre-processor related parts of
 hmm.h even if disabled
Date: Mon, 28 Oct 2019 17:10:21 -0300
Message-Id: <20191028201032.6352-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Oct 2019 20:17:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XfZfiXb3zJ195gWPi/l/D27toKL96PSF+DrXZsTvCKc=;
 b=Vc58TGVq1lmjMY4eOa7KbtL6DEqVXlgPnJsOzrFIA+Kq+VIv+n8OiCivi4cUtamTnT
 1KYSo7v2A3a+ickTwHSH38kA5tGy8OuuNpGMwWxeSjiIUwF3+ru9o9EbSpkLUVe4ONKL
 vwoevPFvTqW4AXdpTwIwYVfG1lCs2EgIFUFFard0RfJWd72B2i5FrekyEo9dDa85D8eS
 IgS1EDvxvQkqOsgxFumEvEuegOpwLnX2TxR9uWKcEKPRRgLoUO9yKB4vsfjdqKaXA3Zr
 0ht0Y4lwbn51FabpNrQPAmMzXA34J6VR9wDC/ZusGDpxulAVuNULgD/MF+Wf668IbxSy
 16vA==
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
Message-ID: <20191028201021.bBR_kvhzt2gDuMPwkTXmaN-WDMoJTxpVIGhn3beUx5Q@z>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKT25seSB0aGUgZnVuY3Rp
b24gY2FsbHMgYXJlIHN0dWJiZWQgb3V0IHdpdGggc3RhdGljIGlubGluZXMgdGhhdCBhbHdheXMK
ZmFpbC4gVGhpcyBpcyB0aGUgc3RhbmRhcmQgd2F5IHRvIHdyaXRlIGEgaGVhZGVyIGZvciBhbiBv
cHRpb25hbCBjb21wb25lbnQKYW5kIG1ha2VzIGl0IGVhc2llciBmb3IgZHJpdmVycyB0aGF0IG9u
bHkgb3B0aW9uYWxseSBuZWVkIEhNTV9NSVJST1IuCgpSZXZpZXdlZC1ieTogSsOpcsO0bWUgR2xp
c3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8
amdnQG1lbGxhbm94LmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L2htbS5oIHwgNTkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiBrZXJuZWwvZm9yay5jICAgICAg
IHwgIDEgLQogMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2htbS5oIGIvaW5jbHVkZS9saW51eC9obW0u
aAppbmRleCA4YWMxZmQ2YTgxYWY4Zi4uMjY2NmViMDhhNDA2MTUgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvaG1tLmgKKysrIGIvaW5jbHVkZS9saW51eC9obW0uaApAQCAtNjIsOCArNjIsNiBA
QAogI2luY2x1ZGUgPGxpbnV4L2tjb25maWcuaD4KICNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPgog
Ci0jaWZkZWYgQ09ORklHX0hNTV9NSVJST1IKLQogI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgog
I2luY2x1ZGUgPGxpbnV4L21pZ3JhdGUuaD4KICNpbmNsdWRlIDxsaW51eC9tZW1yZW1hcC5oPgpA
QCAtMzc0LDYgKzM3MiwxNSBAQCBzdHJ1Y3QgaG1tX21pcnJvciB7CiAJc3RydWN0IGxpc3RfaGVh
ZAkJbGlzdDsKIH07CiAKKy8qCisgKiBSZXRyeSBmYXVsdCBpZiBub24tYmxvY2tpbmcsIGRyb3Ag
bW1hcF9zZW0gYW5kIHJldHVybiAtRUFHQUlOIGluIHRoYXQgY2FzZS4KKyAqLworI2RlZmluZSBI
TU1fRkFVTFRfQUxMT1dfUkVUUlkJCSgxIDw8IDApCisKKy8qIERvbid0IGZhdWx0IGluIG1pc3Np
bmcgUFRFcywganVzdCBzbmFwc2hvdCB0aGUgY3VycmVudCBzdGF0ZS4gKi8KKyNkZWZpbmUgSE1N
X0ZBVUxUX1NOQVBTSE9UCQkoMSA8PCAxKQorCisjaWZkZWYgQ09ORklHX0hNTV9NSVJST1IKIGlu
dCBobW1fbWlycm9yX3JlZ2lzdGVyKHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IsIHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tKTsKIHZvaWQgaG1tX21pcnJvcl91bnJlZ2lzdGVyKHN0cnVjdCBobW1fbWly
cm9yICptaXJyb3IpOwogCkBAIC0zODMsMTQgKzM5MCw2IEBAIHZvaWQgaG1tX21pcnJvcl91bnJl
Z2lzdGVyKHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IpOwogaW50IGhtbV9yYW5nZV9yZWdpc3Rl
cihzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwgc3RydWN0IGhtbV9taXJyb3IgKm1pcnJvcik7CiB2
b2lkIGhtbV9yYW5nZV91bnJlZ2lzdGVyKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlKTsKIAotLyoK
LSAqIFJldHJ5IGZhdWx0IGlmIG5vbi1ibG9ja2luZywgZHJvcCBtbWFwX3NlbSBhbmQgcmV0dXJu
IC1FQUdBSU4gaW4gdGhhdCBjYXNlLgotICovCi0jZGVmaW5lIEhNTV9GQVVMVF9BTExPV19SRVRS
WQkJKDEgPDwgMCkKLQotLyogRG9uJ3QgZmF1bHQgaW4gbWlzc2luZyBQVEVzLCBqdXN0IHNuYXBz
aG90IHRoZSBjdXJyZW50IHN0YXRlLiAqLwotI2RlZmluZSBITU1fRkFVTFRfU05BUFNIT1QJCSgx
IDw8IDEpCi0KIGxvbmcgaG1tX3JhbmdlX2ZhdWx0KHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlLCB1
bnNpZ25lZCBpbnQgZmxhZ3MpOwogCiBsb25nIGhtbV9yYW5nZV9kbWFfbWFwKHN0cnVjdCBobW1f
cmFuZ2UgKnJhbmdlLApAQCAtNDAxLDYgKzQwMCw0NCBAQCBsb25nIGhtbV9yYW5nZV9kbWFfdW5t
YXAoc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UsCiAJCQkgc3RydWN0IGRldmljZSAqZGV2aWNlLAog
CQkJIGRtYV9hZGRyX3QgKmRhZGRycywKIAkJCSBib29sIGRpcnR5KTsKKyNlbHNlCitpbnQgaG1t
X21pcnJvcl9yZWdpc3RlcihzdHJ1Y3QgaG1tX21pcnJvciAqbWlycm9yLCBzdHJ1Y3QgbW1fc3Ry
dWN0ICptbSkKK3sKKwlyZXR1cm4gLUVPUE5PVFNVUFA7Cit9CisKK3ZvaWQgaG1tX21pcnJvcl91
bnJlZ2lzdGVyKHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IpCit7Cit9CisKK2ludCBobW1fcmFu
Z2VfcmVnaXN0ZXIoc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UsIHN0cnVjdCBobW1fbWlycm9yICpt
aXJyb3IpCit7CisJcmV0dXJuIC1FT1BOT1RTVVBQOworfQorCit2b2lkIGhtbV9yYW5nZV91bnJl
Z2lzdGVyKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlKQoreworfQorCitzdGF0aWMgaW5saW5lIGxv
bmcgaG1tX3JhbmdlX2ZhdWx0KHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlLCB1bnNpZ25lZCBpbnQg
ZmxhZ3MpCit7CisJcmV0dXJuIC1FT1BOT1RTVVBQOworfQorCitzdGF0aWMgaW5saW5lIGxvbmcg
aG1tX3JhbmdlX2RtYV9tYXAoc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UsCisJCQkJICAgICBzdHJ1
Y3QgZGV2aWNlICpkZXZpY2UsIGRtYV9hZGRyX3QgKmRhZGRycywKKwkJCQkgICAgIHVuc2lnbmVk
IGludCBmbGFncykKK3sKKwlyZXR1cm4gLUVPUE5PVFNVUFA7Cit9CisKK3N0YXRpYyBpbmxpbmUg
bG9uZyBobW1fcmFuZ2VfZG1hX3VubWFwKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlLAorCQkJCSAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXZpY2UsCisJCQkJICAgICAgIGRtYV9hZGRyX3QgKmRhZGRy
cywgYm9vbCBkaXJ0eSkKK3sKKwlyZXR1cm4gLUVPUE5PVFNVUFA7Cit9CisjZW5kaWYKIAogLyoK
ICAqIEhNTV9SQU5HRV9ERUZBVUxUX1RJTUVPVVQgLSBkZWZhdWx0IHRpbWVvdXQgKG1zKSB3aGVu
IHdhaXRpbmcgZm9yIGEgcmFuZ2UKQEAgLTQxMSw2ICs0NDgsNCBAQCBsb25nIGhtbV9yYW5nZV9k
bWFfdW5tYXAoc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UsCiAgKi8KICNkZWZpbmUgSE1NX1JBTkdF
X0RFRkFVTFRfVElNRU9VVCAxMDAwCiAKLSNlbmRpZiAvKiBJU19FTkFCTEVEKENPTkZJR19ITU1f
TUlSUk9SKSAqLwotCiAjZW5kaWYgLyogTElOVVhfSE1NX0ggKi8KZGlmZiAtLWdpdCBhL2tlcm5l
bC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jCmluZGV4IGY5NTcyZjQxNjEyNjI4Li40NTYxYTY1ZDE5
ZGI4OCAxMDA2NDQKLS0tIGEva2VybmVsL2ZvcmsuYworKysgYi9rZXJuZWwvZm9yay5jCkBAIC00
MCw3ICs0MCw2IEBACiAjaW5jbHVkZSA8bGludXgvYmluZm10cy5oPgogI2luY2x1ZGUgPGxpbnV4
L21tYW4uaD4KICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KLSNpbmNsdWRlIDxsaW51
eC9obW0uaD4KICNpbmNsdWRlIDxsaW51eC9mcy5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAj
aW5jbHVkZSA8bGludXgvdm1hY2FjaGUuaD4KLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
