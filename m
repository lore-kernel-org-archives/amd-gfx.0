Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5CAC43461
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7451B61369
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7451B61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939DC6E9B5;
	Mon,  3 May 2021 16:40:59 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692CA6E9B2;
 Mon,  3 May 2021 16:40:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA05B61244;
 Mon,  3 May 2021 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620060058;
 bh=RuguGrEi2naplWY6aytjF5jxaCLPOSg2TBV/f+Jxa3c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GtevQr2UOQSGms6BbkWIucvn8J3WPMQvcEbdqCwLKG7FlcUIEpPWSXizEvf/RvmJ3
 HzKtTY89Rnr8NtMtNDhAzl+w//7bKK7ZwSFwZXeXhjqRtBlmsjMNrFEyPI3po1JmNU
 VFC4nZNT0wUXSZyqEGrSEVXeBZEmqxiCWwvlitdEfypbGx1AsWAVQVGSpZDGTiASpY
 Q1FGQ+JghjHbwaaCI4nLeN+66FvuxMj9wKJlkoyY4bqQmjxafujrxAmxcWn9HLZGKV
 fuU3brjDOH+CmYa5pbF1ADjNRs9kKrRa6zkLVOhkNVCDtKaN6BXfqTVOO9+6/SdhgE
 Ncu0P4RuvFZMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 50/57] amdgpu: avoid incorrect %hu format string
Date: Mon,  3 May 2021 12:39:34 -0400
Message-Id: <20210503163941.2853291-50-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163941.2853291-1-sashal@kernel.org>
References: <20210503163941.2853291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tom Rix <trix@redhat.com>, amd-gfx@lists.freedesktop.org,
 clang-built-linux@googlegroups.com, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KClsgVXBzdHJlYW0gY29tbWl0IDdk
OThkNDE2YzJjYzFjMWY3ZDk1MDhlODg3ZGU0NjMwZTUyMWQ3OTcgXQoKY2xhbmcgcG9pbnRzIG91
dCB0aGF0IHRoZSAlaHUgZm9ybWF0IHN0cmluZyBkb2VzIG5vdCBtYXRjaCB0aGUgdHlwZQpvZiB0
aGUgdmFyaWFibGVzIGhlcmU6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZk
LmM6MjYzOjc6IHdhcm5pbmc6IGZvcm1hdCBzcGVjaWZpZXMgdHlwZSAndW5zaWduZWQgc2hvcnQn
IGJ1dCB0aGUgYXJndW1lbnQgaGFzIHR5cGUgJ3Vuc2lnbmVkIGludCcgWy1XZm9ybWF0XQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmVyc2lvbl9tYWpvciwgdmVyc2lvbl9taW5v
cik7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+CmluY2x1
ZGUvZHJtL2RybV9wcmludC5oOjQ5ODoxOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnRFJN
X0VSUk9SJwogICAgICAgIF9fZHJtX2VycihmbXQsICMjX19WQV9BUkdTX18pCiAgICAgICAgICAg
ICAgICAgIH5+fiAgICBefn5+fn5+fn5+fgoKQ2hhbmdlIGl0IHRvIGEgcmVndWxhciAldSwgdGhl
IHNhbWUgd2F5IGEgcHJldmlvdXMgcGF0Y2ggZGlkIGZvcgphbm90aGVyIGluc3RhbmNlIG9mIHRo
ZSBzYW1lIHdhcm5pbmcuCgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPgpT
aWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgpTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXZkLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMK
aW5kZXggYjJjMzY0Yjg2OTVmLi5jZmE4MzI0YjlmNTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXZkLmMKQEAgLTIzMSw3ICsyMzEsNyBAQCBpbnQgYW1kZ3B1X3V2ZF9zd19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlpZiAoKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX1BPTEFSSVMxMCB8fAogCQkgICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1BPTEFS
SVMxMSkgJiYKIAkJICAgIChhZGV2LT51dmQuZndfdmVyc2lvbiA8IEZXXzFfNjZfMTYpKQotCQkJ
RFJNX0VSUk9SKCJQT0xBUklTMTAvMTEgVVZEIGZpcm13YXJlIHZlcnNpb24gJWh1LiVodSBpcyB0
b28gb2xkLlxuIiwKKwkJCURSTV9FUlJPUigiUE9MQVJJUzEwLzExIFVWRCBmaXJtd2FyZSB2ZXJz
aW9uICV1LiV1IGlzIHRvbyBvbGQuXG4iLAogCQkJCSAgdmVyc2lvbl9tYWpvciwgdmVyc2lvbl9t
aW5vcik7CiAJfSBlbHNlIHsKIAkJdW5zaWduZWQgaW50IGVuY19tYWpvciwgZW5jX21pbm9yLCBk
ZWNfbWlub3I7Ci0tIAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
