Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E655FC5517A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801512087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjBsI4km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801512087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A196EB40;
	Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545236EB1E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:49:55 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 10so2073881wml.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atRaJCXFVxAlihI4r4ojii808StzDT60z5Ec9SQAR/c=;
 b=AjBsI4km7LOdpe3juQ0sb1PHk/smmBYDMBsiL8eKHCnqoSJbL14NUE8SdDRfeZgPkZ
 +DxjrVqLYfdQ0RUisTVflMg4C+aK/13Y91yRQNt2TRkZa19sIVT0k9UG106xPxHr6j7u
 yn20MAvlzzXtrV9HRoflVyWEBTeSdPv5cyZTveSv2dOvhkfAkOWkFbygv3qVFTMMjxy/
 52UcUdPLLPv8JITzUPM4dNiblkAqiuytJJE/0W4mNpW0bhv8k+sQE+MplDFJdyAjcc3S
 woDB1b9+/GwiKQm9qX3IEGWBR8b2Cqs2XAwypLa7SZ34SqSlqqYer1GahSbc0rV+0zfI
 MYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atRaJCXFVxAlihI4r4ojii808StzDT60z5Ec9SQAR/c=;
 b=lRw+uy31Knu7wrPU/zE8nqOlsz1rCvH7FqMNKq9IKHG2/xeS4s56wTfovYm93XCvwI
 KEgZzliy36ABA+Ezz/i1w5/D17Xvui06O6UiwCNjJmTTHzJGsp8NIDpE62GNfoVbqpbX
 QhwLuanKpRO4nckGHTgnCP41YLt8yEpiHPzcJgKMo3WE1WF3dGp1u0NMqN4MmRX8cfQN
 IW/49gsYSMIoNUkI28RpNx+2phBOKY6whixcXhmUQZ4/cmo2AfhdErT27xhOd3XDds1F
 N9g3xbSEc+omChDN0CA1T15yiSyCVn/ZzJdqBF5X6T2qEQidu1170RYzCq3Ogdk3OxYa
 KrMw==
X-Gm-Message-State: AOAM5321f7/JpD04WSGdpCBObuE8eynTHtZNshf0X2H4BpZp/dSty3O7
 i3s0KuW1rxlzgz4Lk6b40BgfZjHV1nOY8Ifn
X-Google-Smtp-Source: ABdhPJyxSilLymaZgbLjfvWQZDTgj2OWOjONwp5UO++dwOgGyrFaukmAGiTHKU2EcOOknhLQDmeuVQ==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr1515570wmj.109.1604699393111; 
 Fri, 06 Nov 2020 13:49:53 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:49:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 00/19] [Set 2] Rid W=1 warnings from GPU
Date: Fri,  6 Nov 2020 21:49:30 +0000
Message-Id: <20201106214949.2042120-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Eric Anholt <eric@anholt.net>, Huang Rui <ray.huang@amd.com>,
 Rob Clark <rob@ti.com>, Gareth Hughes <gareth@valinux.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, amd-gfx@lists.freedesktop.org,
 Rob Clark <rob.clark@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Keith Whitwell <keith@tungstengraphics.com>, Andy Gross <andy.gross@ti.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-media@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Leo Li <sunpeng.li@amd.com>,
 linaro-mm-sig@lists.linaro.org, by <jhartmann@precisioninsight.com>,
 Jeff Hartmann <jhartmann@valinux.com>, linux-kernel@vger.kernel.org,
 Faith <faith@valinux.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzZXQgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0byBjbGVhbi11
cCBXPTEKa2VybmVsIGJ1aWxkcywgd2hpY2ggYXJlIGN1cnJlbnRseSBvdmVyd2hlbG1pbmdseSBy
aWRkbGVkIHdpdGgKbmlnZ2x5IGxpdHRsZSB3YXJuaW5ncy4KClRoZXJlIGFyZSA1MDAwIHdhcm5p
bmdzIHRvIHdvcmsgdGhyb3VnaC4gIEl0IHdpbGwgdGFrZSBhIGNvdXBsZSBtb3JlCnNldHMuICBB
bHRob3VnaCwgKCJkcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2ZpeHB0MzFfMzI6IE1vdmUKdmFy
aWFibGVzIHRvIHdoZXJlIHRoZXkncmUgdXNlZCIpIGRvZXMgdGFrZSBjYXJlIG9mIDIwMDAgb2Yg
dGhlbSEKCkxlZSBKb25lcyAoMTkpOgogIGRybS90dG0vdHRtX3JhbmdlX21hbmFnZXI6IERlbW90
ZSBub24tY29uZm9ybWFudCBrZXJuZWwtZG9jIGhlYWRlcgogIGRybS9yMTI4L2F0aV9wY2lnYXJ0
OiBTb3VyY2UgZmlsZSBoZWFkZXJzIGFyZSBub3QgZ29vZCBjYW5kaWRhdGVzIGZvcgogICAga2Vy
bmVsLWRvYwogIGRybS9zZWxmdGVzdHMvdGVzdC1kcm1fZHBfbXN0X2hlbHBlcjogTW92ZQogICAg
J3NpZGViYW5kX21zZ19yZXFfZW5jb2RlX2RlY29kZScgb250byB0aGUgaGVhcAogIGRybS9tZ2Ev
bWdhX2RtYTogRGVtb3RlIGtlcm5lbC1kb2MgYWJ1c2VycyB0byBzdGFuZGFyZCBjb21tZW50IGJs
b2NrcwogIGRybS9tZ2EvbWdhX3N0YXRlOiBSZW1vdmUgdW51c2VkIHZhcmlhYmxlICdidWZfcHJp
dicKICBkcm0vcmFkZW9uL2F0b206IE1vdmUgcHJvdG90eXBlIGludG8gc2hhcmVkIGxvY2F0aW9u
CiAgZHJtL3JhZGVvbi9yYWRlb25fa21zOiBJbmNsdWRlIGhlYWRlciBjb250YWluaW5nIG91ciBv
d24gcHJvdG90eXBlcwogIGRybS9vbWFwZHJtL29tYXBfZ2VtOiBGaXggbWlzbmFtZWQgYW5kIG1p
c3NpbmcgcGFyYW1ldGVyIGRlc2NyaXB0aW9ucwogIGRybS9vbWFwZHJtL29tYXBfZG1tX3RpbGVy
OiBEZW1vdGUgYWJ1c2l2ZSB1c2Ugb2Yga2VybmVsLWRvYyBmb3JtYXQKICBkcm0vcmFkZW9uL3Jh
ZGVvbjogTW92ZSBwcm90b3R5cGUgaW50byBzaGFyZWQgaGVhZGVyCiAgZHJtL3JhZGVvbi9yYWRl
b25fZHJ2OiBTb3VyY2UgZmlsZSBoZWFkZXJzIGFyZSBub3QgZ29vZCBjYW5kaWRhdGVzIGZvcgog
ICAga2VybmVsLWRvYwogIGRybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvZml4cHQzMV8zMjogTW92
ZSB2YXJpYWJsZXMgdG8gd2hlcmUgdGhleSdyZQogICAgdXNlZAogIGRybS9yYWRlb24vcmFkZW9u
X2RydjogTW92ZSBwcm90b3R5cGVzIHRvIGEgc2hhcmVkIGhlYWRlcmZpbGUKICBkcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlOiBQcm92aWRlIGRvY3VtZW50YXRpb24gZm9yICdyZWdfYWRkcicK
ICAgIHBhcmFtcwogIGRybS9yYWRlb246IE1vdmUgcHJvdG90eXBlcyB0byBzaGFyZWQgaGVhZGVy
CiAgZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttczogUmVtb3ZlICdzdHJ1Y3QgZHJtX2FtZGdwdV9p
bmZvX2RldmljZQogICAgZGV2X2luZm8nIGZyb20gdGhlIHN0YWNrCiAgZHJtL3JhZGVvbi9yYWRl
b25fa21zOiBGaXggbWlzbmFtaW5nIG9mICdyYWRlb25faW5mb19pb2N0bCdzIGRldiBwYXJhbQog
IGRybS9yYWRlb24vYXRvbWJpb3NfY3J0YzogUmVtb3ZlIGRlc2NyaXB0aW9uIG9mIG5vbi1leGlz
dGVudCBmdW5jdGlvbgogICAgcGFyYW0gJ2VuY29kZXInCiAgZHJtL3YzZC92M2RfZHJ2OiBSZW1v
dmUgdW51c2VkIHN0YXRpYyB2YXJpYWJsZSAndjNkX3YzZF9wbV9vcHMnCgogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgICAyICsKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyAgICAgICB8IDEwNCArKysrKysrKystLS0tLS0tLS0K
IC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2ZpeHB0MzFfMzIuYyAgICB8ICAgNSArCiAu
Li4vZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2ZpeGVkMzFfMzIuaCAgfCAgIDYgLQogZHJp
dmVycy9ncHUvZHJtL21nYS9tZ2FfZG1hLmMgICAgICAgICAgICAgICAgIHwgIDEwICstCiBkcml2
ZXJzL2dwdS9kcm0vbWdhL21nYV9zdGF0ZS5jICAgICAgICAgICAgICAgfCAgIDIgLQogZHJpdmVy
cy9ncHUvZHJtL29tYXBkcm0vb21hcF9kbW1fdGlsZXIuYyAgICAgIHwgICA2ICstCiBkcml2ZXJz
L2dwdS9kcm0vb21hcGRybS9vbWFwX2dlbS5jICAgICAgICAgICAgfCAgIDMgKy0KIGRyaXZlcnMv
Z3B1L2RybS9yMTI4L2F0aV9wY2lnYXJ0LmMgICAgICAgICAgICB8ICAgMiArLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9hdG9tLmggICAgICAgICAgICAgICAgIHwgICA2ICsKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vYXRvbWJpb3NfY3J0Yy5jICAgICAgICB8ICAgMSAtCiBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJzLmMgICAgfCAgIDQgLQogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb24uaCAgICAgICAgICAgICAgIHwgICA2ICsKIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2RldmljZS5jICAgICAgICB8ICAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kZXZpY2UuaCAgICAgICAgfCAgMzIgKysrKysrCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgICAgICAgfCAgIDQgLQogZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZHJ2LmMgICAgICAgICAgIHwgIDExICstCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kcnYuaCAgICAgICAgICAgfCAgIDcgKysKIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2ttcy5jICAgICAgICAgICB8ICAgMyArLQogLi4uL2RybS9zZWxmdGVzdHMvdGVz
dC1kcm1fZHBfbXN0X2hlbHBlci5jICAgIHwgIDExICstCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9yYW5nZV9tYW5hZ2VyLmMgICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS92M2QvdjNk
X2Rydi5jICAgICAgICAgICAgICAgICB8ICAzNiAtLS0tLS0KIDIyIGZpbGVzIGNoYW5nZWQsIDEz
OCBpbnNlcnRpb25zKCspLCAxMjYgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmgKCkNjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogQW5keSBHcm9zcyA8YW5keS5ncm9zc0B0aS5jb20+CkNjOiBieSA8amhhcnRtYW5uQHBy
ZWNpc2lvbmluc2lnaHQuY29tPgpDYzogQ2hyaXN0aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0PgpDYzogRmFpdGggPGZhaXRoQHZhbGludXgu
Y29tPgpDYzogR2FyZXRoIEh1Z2hlcyA8Z2FyZXRoQHZhbGludXguY29tPgpDYzogSGFycnkgV2Vu
dGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBIdWFuZyBSdWkgPHJheS5odWFuZ0Bh
bWQuY29tPgpDYzogSmVmZiBIYXJ0bWFubiA8amhhcnRtYW5uQHZhbGludXguY29tPgpDYzogS2Vp
dGggV2hpdHdlbGwgPGtlaXRoQHR1bmdzdGVuZ3JhcGhpY3MuY29tPgpDYzogTGVvIExpIDxzdW5w
ZW5nLmxpQGFtZC5jb20+CkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKQ2M6IGxp
bnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5n
dXRyb25peC5kZT4KQ2M6IFJvYiBDbGFyayA8cm9iLmNsYXJrQGxpbmFyby5vcmc+CkNjOiBSb2Ig
Q2xhcmsgPHJvYkB0aS5jb20+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8u
b3JnPgpDYzogVG9taSBWYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4KLS0gCjIuMjUu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
