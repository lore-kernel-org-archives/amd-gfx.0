Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B85CC433F2
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 20:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044B8208D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 20:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SI+A2Elk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044B8208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D4989711;
	Tue,  7 Jul 2020 20:13:11 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A04889A86
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 20:13:08 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l17so484049wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8vhBO2QXji8rIT2yf3WDABSBN2A7UpHMa5cTtCVfx9g=;
 b=SI+A2Elkc84jnDWNJKdyIiWg94QLHhdHfRic7YA64NrB2zUjcHaawvIqElpfiGS5UF
 vFS/cvCNncCF3VRb1GLb2SQUTphEzGthiR0Q3gqWonj/oSVCvkQT/b8Q7NKuEISQBx4V
 XZfDuKa8LNkQLyxNGvqdeV8x2KvGAtj5Li8Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8vhBO2QXji8rIT2yf3WDABSBN2A7UpHMa5cTtCVfx9g=;
 b=hULV5YSg2mLRyo8l/N6KsxXiICUNTBEjmLpb4Fu4D/kaaFf4ugUQXDu1z9JLJXbe5p
 eFi1FLaIh9u7xjodVukjT/5XHe/Tf8aHk8LEJU119nrG4ysSlUSksXPLXFQY2+NYN4o/
 kl23PrMyAJ/rbKIBZD2vqPZ3FnGhF3QNvotD8BCnNg0+tmlYIO8hCLPPpZICwdXxhLk+
 WwEHE0Drku1FkY3A7cu5I75iSgX1lQ2w8C6FblTmZCccQnIaPN6mRW6Ag/Qq9QsRQZe8
 cZu5qveHCtHmnpb/rgRllhTE49pp4tWmA2D3L59e01M0+9PNcdXWizh5iiKm/IMBunDQ
 384g==
X-Gm-Message-State: AOAM53240zwqEGJEmkP/9MFTou3EU+qkCSDZoqbPxFaW+SYufOaUTpvW
 FzylRTu6AjxLIFaTedYkssLXlQ==
X-Google-Smtp-Source: ABdhPJz3xBYLJDOwYA2n2XZ64XK2kngCSUfd1JWeXQJzfB/NbmdXimIF/UOKC7vdM6lhx0lkZoAdKg==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr5594163wmc.76.1594152786931; 
 Tue, 07 Jul 2020 13:13:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 13:13:06 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 21/25] drm/amdgpu/dc: Stop dma_resv_lock inversion in
 commit_tail
Date: Tue,  7 Jul 2020 22:12:25 +0200
Message-Id: <20200707201229.472834-22-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VHJ5aW5nIHRvIGdyYWIgZG1hX3Jlc3ZfbG9jayB3aGlsZSBpbiBjb21taXRfdGFpbCBiZWZvcmUg
d2UndmUgZG9uZQphbGwgdGhlIGNvZGUgdGhhdCBsZWFkcyB0byB0aGUgZXZlbnR1YWwgc2lnbmFs
bGluZyBvZiB0aGUgdmJsYW5rIGV2ZW50Cih3aGljaCBjYW4gYmUgYSBkbWFfZmVuY2UpIGlzIGRl
YWRsb2NrLXkuIERvbid0IGRvIHRoYXQuCgpIZXJlIHRoZSBzb2x1dGlvbiBpcyBlYXN5IGJlY2F1
c2UganVzdCBncmFiYmluZyBsb2NrcyB0byByZWFkCnNvbWV0aGluZyByYWNlcyBhbnl3YXkuIFdl
IGRvbid0IG5lZWQgdG8gYm90aGVyLCBSRUFEX09OQ0UgaXMKZXF1aXZhbGVudC4gQW5kIGF2b2lk
cyB0aGUgbG9ja2luZyBpc3N1ZS4KCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6
IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5l
bC5vcmcKQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBpbnRlbC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlzLXdpbHNvbi5j
by51az4KQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRl
bC5jb20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNp
Z25lZC1vZmYtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxMCAr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IDNkNDFl
ZGRjNzkwOC4uZDZiYjg3NmE3NGU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTY5NDksNyArNjk0OSwxMSBAQCBzdGF0aWMg
dm9pZCBhbWRncHVfZG1fY29tbWl0X3BsYW5lcyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3Rh
dGUsCiAJCSAqIGV4cGxpY2l0bHkgb24gZmVuY2VzIGluc3RlYWQKIAkJICogYW5kIGluIGdlbmVy
YWwgc2hvdWxkIGJlIGNhbGxlZCBmb3IKIAkJICogYmxvY2tpbmcgY29tbWl0IHRvIGFzIHBlciBm
cmFtZXdvcmsgaGVscGVycworCQkgKgorCQkgKiBZZXMsIHRoaXMgZGVhZGxvY2tzLCBzaW5jZSB5
b3UncmUgY2FsbGluZyBkbWFfcmVzdl9sb2NrIGluIGEKKwkJICogcGF0aCB0aGF0IGxlYWRzIHRv
IGEgZG1hX2ZlbmNlX3NpZ25hbCgpLiBEb24ndCBkbyB0aGF0LgogCQkgKi8KKyNpZiAwCiAJCXIg
PSBhbWRncHVfYm9fcmVzZXJ2ZShhYm8sIHRydWUpOwogCQlpZiAodW5saWtlbHkociAhPSAwKSkK
IAkJCURSTV9FUlJPUigiZmFpbGVkIHRvIHJlc2VydmUgYnVmZmVyIGJlZm9yZSBmbGlwXG4iKTsK
QEAgLTY5NTksNiArNjk2MywxMiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1fY29tbWl0X3BsYW5l
cyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCiAJCXRtel9zdXJmYWNlID0gYW1kZ3B1
X2JvX2VuY3J5cHRlZChhYm8pOwogCiAJCWFtZGdwdV9ib191bnJlc2VydmUoYWJvKTsKKyNlbmRp
ZgorCQkvKgorCQkgKiB0aGlzIHJhY2VzIGFueXdheSwgc28gUkVBRF9PTkNFIGlzbid0IGFueSBi
ZXR0ZXIgb3Igd29yc2UKKwkJICogdGhhbiB0aGUgc3R1ZmYgYWJvdmUuIEV4Y2VwdCB0aGUgc3R1
ZmYgYWJvdmUgY2FuIGRlYWRsb2NrLgorCQkgKi8KKwkJdGlsaW5nX2ZsYWdzID0gUkVBRF9PTkNF
KGFiby0+dGlsaW5nX2ZsYWdzKTsKIAogCQlmaWxsX2RjX3BsYW5lX2luZm9fYW5kX2FkZHIoCiAJ
CQlkbS0+YWRldiwgbmV3X3BsYW5lX3N0YXRlLCB0aWxpbmdfZmxhZ3MsCi0tIAoyLjI3LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
