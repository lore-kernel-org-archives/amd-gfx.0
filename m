Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9855CCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 20:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEC221721
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 20:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC221721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36CD6EA0F;
	Mon, 28 Oct 2019 20:17:18 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913A889CDB
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 20:10:51 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id c21so16476359qtj.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 13:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F2P8/bWutEEexpXtgY3Ri54G2hYwzd51MYRSkoxVUFY=;
 b=qA9IOfmB0e5ZPYaKjMJYkM8EdY8stTYLL90mJs8vTnDywuVtxfxbbiW62JFXM6dUtt
 bp2Vf/4jGC/evg9kZF1Ja7Psa4wf3WmTnbaFbe9NSUPsBt/1YQX8TFvi4l9eZ8tkcYvY
 pH3CX52NQP9xQoudmIgmhMBF3AXJDcZfce+PKp2Our/7z6s1HsRGNchB7hNwI3LdFuaC
 /EywAvbR7TWAnL8/6T7EA3Hj/dEWzWlubQa6MsXTBBFVzTmVxq1BsEiJkoIFmkscMoay
 gLHmT6aMOJT4ytdyj6DsR6/Hu948skIF+6fvbjsTPp4N879DfbZ83fhejo9+AcKuFIy/
 3LNA==
X-Gm-Message-State: APjAAAWkuLvmvGjmWTtUOVp12t4KLxT6sNsGAPkLYzP266dUjx5cpkkX
 sbkVFVJNRrfoB578gEHjfiGNWQ==
X-Google-Smtp-Source: APXvYqwTcskfH9Xiak0a57YVk8h4p5RuEjqynPFL5VtkKYVgvqVrkyouZ1IxJ09RUdRPaJJt1AiVUg==
X-Received: by 2002:ac8:6783:: with SMTP id b3mr300845qtp.25.1572293450670;
 Mon, 28 Oct 2019 13:10:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id y33sm10527481qta.18.2019.10.28.13.10.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Oct 2019 13:10:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iPBLf-0001h9-Ir; Mon, 28 Oct 2019 17:10:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 12/15] drm/amdgpu: Call find_vma under mmap_sem
Date: Mon, 28 Oct 2019 17:10:29 -0300
Message-Id: <20191028201032.6352-13-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Oct 2019 20:17:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F2P8/bWutEEexpXtgY3Ri54G2hYwzd51MYRSkoxVUFY=;
 b=f9VJ69PD3RaUkbEbccVYeRFDh/thjTQCzF5PuJ+gvt+IG6OkssL4Za0EKWGJI3j+0E
 HLSRRQqMXLrz5Gxqj9/Q7HBPvcvH4eX8f81f9tWwJzMf/Kvz1p+RSsKPa8Aqw6sRhOF1
 Ci6tCvrYka+pGRB45g/D9/kkwjGtIvI70tHdkxrH/C2yY97y+krIusL/sDyIaNisQg6v
 qVOhr1RtmNaMOuz4sPbCR/gy0XgHfVy8Z38tgeJWChrZRpsSaK+vcI6dRNWyH4tJvL8A
 b5RnhHZBFnkXiK2WV1K4WPo4s9VnYg1eiHNZQ2qUzq0o8pj/0x8HMVMYPMRl0Q10ejMR
 z6Rw==
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
Message-ID: <20191028201029.-KpR03J93Wh_Y5svm6bffXLsE1yKjX5PE5Pp3UaZKLM@z>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKZmluZF92bWEoKSBtdXN0
IGJlIGNhbGxlZCB1bmRlciB0aGUgbW1hcF9zZW0sIHJlb3JnYW5pemUgdGhpcyBjb2RlIHRvCmRv
IHRoZSB2bWEgY2hlY2sgYWZ0ZXIgZW50ZXJpbmcgdGhlIGxvY2suCgpGdXJ0aGVyLCBmaXggdGhl
IHVubG9ja2VkIHVzZSBvZiBzdHJ1Y3QgdGFza19zdHJ1Y3QncyBtbSwgaW5zdGVhZCB1c2UKdGhl
IG1tIGZyb20gaG1tX21pcnJvciB3aGljaCBoYXMgYW4gYWN0aXZlIG1tX2dyYWIuIEFsc28gdGhl
IG1tX2dyYWIKbXVzdCBiZSBjb252ZXJ0ZWQgdG8gYSBtbV9nZXQgYmVmb3JlIGFjcXVpcmluZyBt
bWFwX3NlbSBvciBjYWxsaW5nCmZpbmRfdm1hKCkuCgpGaXhlczogNjZjNDU1MDBiZmRjICgiZHJt
L2FtZGdwdTogdXNlIG5ldyBITU0gQVBJcyBhbmQgaGVscGVycyIpCkZpeGVzOiAwOTE5MTk1ZjJi
MGQgKCJkcm0vYW1kZ3B1OiBFbmFibGUgYW1kZ3B1X3R0bV90dF9nZXRfdXNlcl9wYWdlcyBpbiB3
b3JrZXIgdGhyZWFkcyIpCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCAoQ2h1bk1pbmcpIFpob3UgPERhdmlkMS5aaG91QGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0Bt
ZWxsYW5veC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
IHwgMzcgKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2Vy
dGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwppbmRleCBkZmY0MWQwYTg1ZmU5Ni4uYzBlNDFmMWYwYzIzNjUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTM1LDYgKzM1LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9obW0uaD4KICNpbmNsdWRlIDxsaW51eC9wYWdlbWFwLmg+CiAjaW5jbHVkZSA8bGlu
dXgvc2NoZWQvdGFzay5oPgorI2luY2x1ZGUgPGxpbnV4L3NjaGVkL21tLmg+CiAjaW5jbHVkZSA8
bGludXgvc2VxX2ZpbGUuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGlu
dXgvc3dhcC5oPgpAQCAtNzg4LDcgKzc4OSw3IEBAIGludCBhbWRncHVfdHRtX3R0X2dldF91c2Vy
X3BhZ2VzKHN0cnVjdCBhbWRncHVfYm8gKmJvLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzKQogCXN0cnVj
dCBobW1fbWlycm9yICptaXJyb3IgPSBiby0+bW4gPyAmYm8tPm1uLT5taXJyb3IgOiBOVUxMOwog
CXN0cnVjdCB0dG1fdHQgKnR0bSA9IGJvLT50Ym8udHRtOwogCXN0cnVjdCBhbWRncHVfdHRtX3R0
ICpndHQgPSAodm9pZCAqKXR0bTsKLQlzdHJ1Y3QgbW1fc3RydWN0ICptbSA9IGd0dC0+dXNlcnRh
c2stPm1tOworCXN0cnVjdCBtbV9zdHJ1Y3QgKm1tOwogCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBn
dHQtPnVzZXJwdHI7CiAJc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7CiAJc3RydWN0IGhtbV9y
YW5nZSAqcmFuZ2U7CkBAIC03OTYsMjUgKzc5NywxNCBAQCBpbnQgYW1kZ3B1X3R0bV90dF9nZXRf
dXNlcl9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgc3RydWN0IHBhZ2UgKipwYWdlcykKIAl1
aW50NjRfdCAqcGZuczsKIAlpbnQgciA9IDA7CiAKLQlpZiAoIW1tKSAvKiBIYXBwZW5zIGR1cmlu
ZyBwcm9jZXNzIHNodXRkb3duICovCi0JCXJldHVybiAtRVNSQ0g7Ci0KIAlpZiAodW5saWtlbHko
IW1pcnJvcikpIHsKIAkJRFJNX0RFQlVHX0RSSVZFUigiRmFpbGVkIHRvIGdldCBobW1fbWlycm9y
XG4iKTsKLQkJciA9IC1FRkFVTFQ7Ci0JCWdvdG8gb3V0OworCQlyZXR1cm4gLUVGQVVMVDsKIAl9
CiAKLQl2bWEgPSBmaW5kX3ZtYShtbSwgc3RhcnQpOwotCWlmICh1bmxpa2VseSghdm1hIHx8IHN0
YXJ0IDwgdm1hLT52bV9zdGFydCkpIHsKLQkJciA9IC1FRkFVTFQ7Ci0JCWdvdG8gb3V0OwotCX0K
LQlpZiAodW5saWtlbHkoKGd0dC0+dXNlcmZsYWdzICYgQU1ER1BVX0dFTV9VU0VSUFRSX0FOT05P
TkxZKSAmJgotCQl2bWEtPnZtX2ZpbGUpKSB7Ci0JCXIgPSAtRVBFUk07Ci0JCWdvdG8gb3V0Owot
CX0KKwltbSA9IG1pcnJvci0+aG1tLT5tbXVfbm90aWZpZXIubW07CisJaWYgKCFtbWdldF9ub3Rf
emVybyhtbSkpIC8qIEhhcHBlbnMgZHVyaW5nIHByb2Nlc3Mgc2h1dGRvd24gKi8KKwkJcmV0dXJu
IC1FU1JDSDsKIAogCXJhbmdlID0ga3phbGxvYyhzaXplb2YoKnJhbmdlKSwgR0ZQX0tFUk5FTCk7
CiAJaWYgKHVubGlrZWx5KCFyYW5nZSkpIHsKQEAgLTg0Nyw2ICs4MzcsMTcgQEAgaW50IGFtZGdw
dV90dG1fdHRfZ2V0X3VzZXJfcGFnZXMoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHN0cnVjdCBwYWdl
ICoqcGFnZXMpCiAJaG1tX3JhbmdlX3dhaXRfdW50aWxfdmFsaWQocmFuZ2UsIEhNTV9SQU5HRV9E
RUZBVUxUX1RJTUVPVVQpOwogCiAJZG93bl9yZWFkKCZtbS0+bW1hcF9zZW0pOworCXZtYSA9IGZp
bmRfdm1hKG1tLCBzdGFydCk7CisJaWYgKHVubGlrZWx5KCF2bWEgfHwgc3RhcnQgPCB2bWEtPnZt
X3N0YXJ0KSkgeworCQlyID0gLUVGQVVMVDsKKwkJZ290byBvdXRfdW5sb2NrOworCX0KKwlpZiAo
dW5saWtlbHkoKGd0dC0+dXNlcmZsYWdzICYgQU1ER1BVX0dFTV9VU0VSUFRSX0FOT05PTkxZKSAm
JgorCQl2bWEtPnZtX2ZpbGUpKSB7CisJCXIgPSAtRVBFUk07CisJCWdvdG8gb3V0X3VubG9jazsK
Kwl9CisKIAlyID0gaG1tX3JhbmdlX2ZhdWx0KHJhbmdlLCAwKTsKIAl1cF9yZWFkKCZtbS0+bW1h
cF9zZW0pOwogCkBAIC04NjUsMTUgKzg2NiwxOSBAQCBpbnQgYW1kZ3B1X3R0bV90dF9nZXRfdXNl
cl9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgc3RydWN0IHBhZ2UgKipwYWdlcykKIAl9CiAK
IAlndHQtPnJhbmdlID0gcmFuZ2U7CisJbW1wdXQobW0pOwogCiAJcmV0dXJuIDA7CiAKK291dF91
bmxvY2s6CisJdXBfcmVhZCgmbW0tPm1tYXBfc2VtKTsKIG91dF9mcmVlX3BmbnM6CiAJaG1tX3Jh
bmdlX3VucmVnaXN0ZXIocmFuZ2UpOwogCWt2ZnJlZShwZm5zKTsKIG91dF9mcmVlX3JhbmdlczoK
IAlrZnJlZShyYW5nZSk7CiBvdXQ6CisJbW1wdXQobW0pOwogCXJldHVybiByOwogfQogCi0tIAoy
LjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
