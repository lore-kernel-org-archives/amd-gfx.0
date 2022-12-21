Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39543C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Dec 2022 14:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BABE10E040;
	Thu, 22 Dec 2022 14:51:40 +0000 (UTC)
X-Greylist: delayed 2840 seconds by postgrey-1.36 at gabe;
 Wed, 21 Dec 2022 21:59:58 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056AF10E429
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 21:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1671659990; bh=9rewaK9ZAsG8JOUNoPV+KJ7eJcL5xQAqhOngCk7ongU=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=VEFWfjjsF8oWdtNXgF2fhgirPLJAUKaLVI2cNUMA8vWJIcfN2d1PlzSm7URYeieRf
 Sy2eduyLELESUNfV2NXM4BWGi+VcB28QV04edBnYmq6GQazwOqw2N3C2aO916yNZUn
 tfQiA0Sj/2DI4poP/fWFw/koP9/mIsfV7op7NLj4Z0V2s1PRmdvXD1XTVBwc3rR4S4
 j++G0UKlxdtYXoOign8GtqNIuzu/Fs+vt/5ocfm0NiCav6NyrnrYbqRiG2UKoybuab
 kiXEZBHhuGTt8FgJweW5p5s+FDZh0MdbQhGK8UarPgV24XKcyPgPQUQn8xTnmXaOho
 MDTUYVq/xjOCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8Bw1-1pBhtF35Gt-005DCf; Wed, 21
 Dec 2022 22:59:50 +0100
Message-ID: <5689088a11f6b2f4b15cd09a73b09c1aeff9f878.camel@web.de>
Subject: Re: [PATCH 10/13] drm/amdgpu: use scheduler depenencies for CS
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 21 Dec 2022 22:59:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:F1y42t6XhqjGF6ONGXTP090JLiZyxvLhs1d0jyTJIH3mJC3jYr0
 gfG323sSuEuTEgbkjP1Lh59CeksPnsDIp1hrHeOwiqcjOLGN5JZu+BbM7fMpP8T37w9MSH1
 bO3Tt2iEq8JxT+8Z6Wrqmb9p1AVulHfFUWcWWy0EHRX7KkhbcqX5xJhCgtu0tVc1YXJFCUR
 TVKgahErSeWLLHtFapnYA==
UI-OutboundReport: notjunk:1;M01:P0:m0HTN3iJP+Y=;FALBlE1EB+j6JW+GG5qOtc6Ksx4
 qRetmv+a9TgbX2woKIF8I4ntytjSwqMsJ/en4w7etE2fxGKsIF5uLkPzgV7w7ImqUXp9APZe0
 ex5PXxdVE3DJOESDWtWaC0n3XEuUI2ou6cs+XeNmEuh0OCTh+nKvfe+eMfuRaiT81WIS/xQU4
 37qw7cyhFLy6IEXsGNtwbXDzlEjFG/6l0PKDKnQaHkCrimppRDcLpZMJ+YljgwzgOVxfEfCq1
 r/Szzs2tHkFi34x8Sxh1QAtpM8+g71bX0AUFbjVexUc288kOUyM6lStE7Q9jYdVN8iBynl+3M
 /PQXLRrMe5F58hGE79Xg6AcKo1qw/YTMhDED2yushotqn+xylIUZAu8yBg/RFA7xTAuXHsboa
 qdT2XK8XY0sdpSmRzYEVFL7x/zohJhBZwFQxtOi8GbaPm8UeJE3Axkq6sXMsaTt53rClizvfr
 gcchlXUYxlJ7mWge5vDI0w7MB58h0MTgSDm93YT5CZPCk/rVhEi3jDbqGpeLhVTT77LBbNIzI
 9vQAvWhi3sQ81BPlCtF009ULOEBnFK1MaXmxY3MCIUv4hBQKbwsPqk5Q3qPExrjiCTIjTP9gq
 ByY6XQnb//NIR9QadCTm40uU6isUr/2k4nG3KPuIE+hiEcfDpsD2vEPTUIR5a53lZniLT7URR
 ufVDstPvWaRPeGxHcTAhWzCVkhvxfJQMUA1fsXi3mwkKBJO6IAs7kFAxsqh1jqse9awL7F/oa
 FP6rj7T+27Zs40vaIFrOKNUchZxMid8MuY11pE7QmNVHK3C9tghkOyxvMRbGNK64/mAIp2xSS
 T+yXlotdCC8KEI0wUoqAFBS9TCbvHuMTC71QzvMldDuDu9oEBTLk1361K0S0l0kk6Z8AHa2U1
 SZE1NZt+PDMDGWVrRfqcK7093VweE74nH6j+oRmLUkC0Q1ri2tLHOjp0hZn1KXcrWZCRabMtH
 V/7PM3EQ04lxGQhj0IcW1J5CZX8=
X-Mailman-Approved-At: Thu, 22 Dec 2022 14:51:39 +0000
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
Cc: Mike Lothian <mike@fireburn.co.uk>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2FuIHlvdSB0ZXN0IGlmIHRoaXMgc29sdmVzIHRoZSBmcmVlemVzOgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmluZGV4IDkxOWJiZWEyZTNhYy4uNGU2ODRjMmFm
YzcwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC0x
NTA2LDcgKzE1MDksOCBAQCB1NjQgYW1kZ3B1X2JvX2dwdV9vZmZzZXRfbm9fY2hlY2soc3RydWN0
CmFtZGdwdV9ibyAqYm8pCsKgdWludDMyX3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfZG9tYWlu
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LArCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1aW50MzJfdCBkb21haW4pCsKgewotwqDCoMKgwqDCoMKgwqBpZiAoZG9tYWluID09IChBTURH
UFVfR0VNX0RPTUFJTl9WUkFNIHwKQU1ER1BVX0dFTV9ET01BSU5fR1RUKSkgeworwqDCoMKgwqDC
oMKgwqBpZiAoKGRvbWFpbiA9PSAoQU1ER1BVX0dFTV9ET01BSU5fVlJBTSB8CkFNREdQVV9HRU1f
RE9NQUlOX0dUVCkpICYmCivCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX0NBUlJJWk8pIHx8IChhZGV2LT5hc2ljX3R5cGUgPT0KQ0hJUF9TVE9ORVkpKSkgewrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlO
X1ZSQU07CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGFkZXYtPmdtYy5yZWFs
X3ZyYW1fc2l6ZSA8PSBBTURHUFVfU0dfVEhSRVNIT0xEKQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7
CsKgCgpUaGlzIHNvbHZlcyBhIGxvdCBvZiBzZWVtaW5nbHkgdW5yZWxhdGVkIGVycm9yczoKaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjI1NQpodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8yMjcwCmh0dHBzOi8vZ2l0
bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzIyODEKaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjI4MgpodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8yMjkxCgpCZXJ0IEthcndhdHpraQoK

