Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A4CA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 20:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BAD21721
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 20:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BAD21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72EAD6EA0B;
	Mon, 28 Oct 2019 20:17:18 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808CE89CBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 20:10:48 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id a194so9752346qkg.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 13:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H/THPQGyz40LBFYEHcweT4lmD8Nqu8ZrqzmWM4HcCKs=;
 b=Dxguwi/H5JmbXqfIB64bCtYcbx07xM9s9WnT+8VyU9vwd+/Y6WTMSMIk8VGNCij29R
 GM1/YO0prVtYkq58gnYfn/qgNpxsZdr6kDkCLTgsigRULRI31X2PGlKx8daKlpT77pen
 cRWKP/uLpNFu/zkXp5aL4l7cNwcjJrOXjmt85G23oneastAjLoh/MKR2wuJPSViKZb/Z
 6pHy0aZ7mL1GY3Axp/98Puhr0ohMfVurX7np59wgpvBFagn4J3ii9l//spCr/8JCmBJk
 g++JVyEV77C41qrOYeEq6CcGWY91BFwk3XnxGm8j0n1lZkZqmPY7i3eNZQIRs6A06vQZ
 lLxw==
X-Gm-Message-State: APjAAAXdbil/TZsuQDcVUHFg9U1/l/b4i1CxymNKXBvzAhQrB8rlnbY8
 UvSJRX9sRqXg9JM+lRn3YfM+lmMqUs8=
X-Google-Smtp-Source: APXvYqxsKzO+DlZf4GHZfVwOfUDUz0csib+6zwvHr9p6l/rK8t+hVqnPNQxoUohuqD3TYtVARBRFtg==
X-Received: by 2002:a05:620a:1410:: with SMTP id
 d16mr14987766qkj.284.1572293447562; 
 Mon, 28 Oct 2019 13:10:47 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id q44sm8677492qtk.16.2019.10.28.13.10.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iPBLf-0001gk-DA; Mon, 28 Oct 2019 17:10:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
Date: Mon, 28 Oct 2019 17:10:25 -0300
Message-Id: <20191028201032.6352-9-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Oct 2019 20:17:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H/THPQGyz40LBFYEHcweT4lmD8Nqu8ZrqzmWM4HcCKs=;
 b=Q6k/mUFVxOBv3aTuq8oo7JDrjEauKE9HcDgFt84omZdU9K/XVboyEcdOWxaTkCBJ28
 h0r5uedPPYCRhOvIEi8rMBg+LxDQ1kJy7G2KvTYOl8k1ftSUoOMiMEEi9CN59pf6OuOz
 MkDtPlTPswGrs8e2T9pzn8MdFhY0MZ1R+E+e8/2U9m/8aBR9ebJ0DsvWpb0j8hwE9f1i
 UuJJWkpCmSjN3VETuju98bl50r4w0WLDME6cbun6/34JTiAY6IEaZyv4ggnF2jWvcBtU
 qyxdFQalzd9YBNgYiQZmA0WiFjG+it9BlIMayLu3aVh2wFRpwpxXSydrKKoYGdfkI+Dw
 /p1A==
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
Message-ID: <20191028201025.BmTgRMEi5_WatUAhuehlzTrlb9UnHFLlGdpxte9GneQ@z>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKRE1BX1NIQVJFRF9CVUZG
RVIgY2FuIG5vdCBiZSBlbmFibGVkIGJ5IHRoZSB1c2VyIChpdCByZXByZXNlbnRzIGEgbGlicmFy
eQpzZXQgaW4gdGhlIGtlcm5lbCkuIFRoZSBrY29uZmlnIGNvbnZlbnRpb24gaXMgdG8gdXNlIHNl
bGVjdCBmb3Igc3VjaApzeW1ib2xzIHNvIHRoZXkgYXJlIHR1cm5lZCBvbiBpbXBsaWNpdGx5IHdo
ZW4gdGhlIHVzZXIgZW5hYmxlcyBhIGtjb25maWcKdGhhdCBuZWVkcyB0aGVtLgoKT3RoZXJ3aXNl
IHRoZSBYRU5fR05UREVWX0RNQUJVRiBrY29uZmlnIGlzIG92ZXJseSBkaWZmaWN1bHQgdG8gZW5h
YmxlLgoKRml4ZXM6IDkzMmQ2NTYyMTc5ZSAoInhlbi9nbnRkZXY6IEFkZCBpbml0aWFsIHN1cHBv
cnQgZm9yIGRtYS1idWYgVUFQSSIpCkNjOiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3Nh
bmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+CkNjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPgpDYzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCkNj
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+CkNjOiBTdGVmYW5vIFN0YWJlbGxpbmkg
PHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+ClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+ClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3Nh
bmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+ClNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3Jw
ZSA8amdnQG1lbGxhbm94LmNvbT4KLS0tCiBkcml2ZXJzL3hlbi9LY29uZmlnIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3hlbi9LY29uZmlnIGIvZHJpdmVycy94ZW4vS2NvbmZpZwppbmRleCA3OWNjNzUw
OTZmNDIzMi4uYTUwZGFkZDAxMDkzMzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMveGVuL0tjb25maWcK
KysrIGIvZHJpdmVycy94ZW4vS2NvbmZpZwpAQCAtMTQxLDcgKzE0MSw4IEBAIGNvbmZpZyBYRU5f
R05UREVWCiAKIGNvbmZpZyBYRU5fR05UREVWX0RNQUJVRgogCWJvb2wgIkFkZCBzdXBwb3J0IGZv
ciBkbWEtYnVmIGdyYW50IGFjY2VzcyBkZXZpY2UgZHJpdmVyIGV4dGVuc2lvbiIKLQlkZXBlbmRz
IG9uIFhFTl9HTlRERVYgJiYgWEVOX0dSQU5UX0RNQV9BTExPQyAmJiBETUFfU0hBUkVEX0JVRkZF
UgorCWRlcGVuZHMgb24gWEVOX0dOVERFViAmJiBYRU5fR1JBTlRfRE1BX0FMTE9DCisJc2VsZWN0
IERNQV9TSEFSRURfQlVGRkVSCiAJaGVscAogCSAgQWxsb3dzIHVzZXJzcGFjZSBwcm9jZXNzZXMg
YW5kIGtlcm5lbCBtb2R1bGVzIHRvIHVzZSBYZW4gYmFja2VkCiAJICBkbWEtYnVmIGltcGxlbWVu
dGF0aW9uLiBXaXRoIHRoaXMgZXh0ZW5zaW9uIGdyYW50IHJlZmVyZW5jZXMgdG8KLS0gCjIuMjMu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
