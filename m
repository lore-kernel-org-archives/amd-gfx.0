Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D345C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 15:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1534461CC6
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 15:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1534461CC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982DB6EC40;
	Wed, 12 May 2021 15:31:43 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E92E6EC3A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 15:28:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 708DF6144A;
 Wed, 12 May 2021 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1620833328;
 bh=FRkQPcqugX+6ff7elCcjNy1RfpURRUKUKdRS8baywzc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lttqmn75OUyr0tSX41GQor+8/8f4shqGPzE/ETjJwZwfLIfIOM211hNaoO/+vWfL9
 90AqzMYYzUh3pO2OvOb1ypDcCRwC8oehya1d7BR6LxFYxnJ8gSEvCIPry+AOvh6851
 cXGvl2H43ysmN85mgHrVIas7RsEODOXXnD4rZfMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.11 071/601] drm/amd/display: Reject non-zero src_y and src_x
 for video planes
Date: Wed, 12 May 2021 16:42:28 +0200
Message-Id: <20210512144830.163388620@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144827.811958675@linuxfoundation.org>
References: <20210512144827.811958675@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 12 May 2021 15:31:41 +0000
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roman.Li@amd.com,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 danny.wang@amd.com, hersenxs.wu@amd.com, stable@vger.kernel.org,
 alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cgpjb21taXQgZDg5
ZjYwNDhiZGNiNmE1NmFiYjM5NmM1ODQ3NDdkNWVlYWU2NTBkYiB1cHN0cmVhbS4KCltXaHldClRo
aXMgaGFzbid0IGJlZW4gd2VsbCB0ZXN0ZWQgYW5kIGxlYWRzIHRvIGNvbXBsZXRlIHN5c3RlbSBo
YW5ncyBvbiBEQ04xCmJhc2VkIHN5c3RlbXMsIHBvc3NpYmx5IG90aGVycy4KClRoZSBzeXN0ZW0g
aGFuZyBjYW4gYmUgcmVwcm9kdWNlZCBieSBnZXN0dXJpbmcgdGhlIHZpZGVvIG9uIHRoZSBZb3VU
dWJlCkFuZHJvaWQgYXBwIG9uIENocm9tZU9TIGludG8gZnVsbCBzY3JlZW4uCgpbSG93XQpSZWpl
Y3QgYXRvbWljIGNvbW1pdHMgd2l0aCBub24temVybyBkcm1fcGxhbmVfc3RhdGUuc3JjX3ggb3Ig
c3JjX3kgdmFsdWVzLgoKdjI6CiAtIEFkZCBjb2RlIGNvbW1lbnQgZGVzY3JpYmluZyB0aGUgcmVh
c29uIHdlJ3JlIHJlamVjdGluZyBub24temVybwogICBzcmNfeCBhbmQgc3JjX3kKIC0gRHJvcCBn
ZXJyaXQgQ2hhbmdlLUlkCiAtIEFkZCBzdGFibGUgQ0MKIC0gQmFzZWQgb24gYW1kLXN0YWdpbmct
ZHJtLW5leHQKCnYzOiByZW1vdmVkIHRyYWlsaW5nIHdoaXRlc3BhY2UKClNpZ25lZC1vZmYtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZwpDYzogbmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tCkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogYWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbQpDYzogUm9t
YW4uTGlAYW1kLmNvbQpDYzogaGVyc2VueHMud3VAYW1kLmNvbQpDYzogZGFubnkud2FuZ0BhbWQu
Y29tClJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2Fz
QGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+ClJldmlld2VkLWJ5OiBIZXJzZW4gV3UgPGhlcnNlbnhzLnd1QGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgICAxNyArKysrKysrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMzc0MCw2ICszNzQwLDIzIEBAIHN0YXRpYyBp
bnQgZmlsbF9kY19zY2FsaW5nX2luZm8oY29uc3Qgc3QKIAlzY2FsaW5nX2luZm8tPnNyY19yZWN0
LnggPSBzdGF0ZS0+c3JjX3ggPj4gMTY7CiAJc2NhbGluZ19pbmZvLT5zcmNfcmVjdC55ID0gc3Rh
dGUtPnNyY195ID4+IDE2OwogCisJLyoKKwkgKiBGb3IgcmVhc29ucyB3ZSBkb24ndCAoeWV0KSBm
dWxseSB1bmRlcnN0YW5kIGEgbm9uLXplcm8KKwkgKiBzcmNfeSBjb29yZGluYXRlIGludG8gYW4g
TlYxMiBidWZmZXIgY2FuIGNhdXNlIGEKKwkgKiBzeXN0ZW0gaGFuZy4gVG8gYXZvaWQgaGFuZ3Mg
KGFuZCBtYXliZSBiZSBvdmVybHkgY2F1dGlvdXMpCisJICogbGV0J3MgcmVqZWN0IGJvdGggbm9u
LXplcm8gc3JjX3ggYW5kIHNyY195LgorCSAqCisJICogV2UgY3VycmVudGx5IGtub3cgb2Ygb25s
eSBvbmUgdXNlLWNhc2UgdG8gcmVwcm9kdWNlIGEKKwkgKiBzY2VuYXJpbyB3aXRoIG5vbi16ZXJv
IHNyY194IGFuZCBzcmNfeSBmb3IgTlYxMiwgd2hpY2gKKwkgKiBpcyB0byBnZXN0dXJlIHRoZSBZ
b3VUdWJlIEFuZHJvaWQgYXBwIGludG8gZnVsbCBzY3JlZW4KKwkgKiBvbiBDaHJvbWVPUy4KKwkg
Ki8KKwlpZiAoc3RhdGUtPmZiICYmCisJICAgIHN0YXRlLT5mYi0+Zm9ybWF0LT5mb3JtYXQgPT0g
RFJNX0ZPUk1BVF9OVjEyICYmCisJICAgIChzY2FsaW5nX2luZm8tPnNyY19yZWN0LnggIT0gMCB8
fAorCSAgICAgc2NhbGluZ19pbmZvLT5zcmNfcmVjdC55ICE9IDApKQorCQlyZXR1cm4gLUVJTlZB
TDsKKwogCXNjYWxpbmdfaW5mby0+c3JjX3JlY3Qud2lkdGggPSBzdGF0ZS0+c3JjX3cgPj4gMTY7
CiAJaWYgKHNjYWxpbmdfaW5mby0+c3JjX3JlY3Qud2lkdGggPT0gMCkKIAkJcmV0dXJuIC1FSU5W
QUw7CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
