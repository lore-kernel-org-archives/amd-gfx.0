Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD7FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 15:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96C360FC2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 15:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D96C360FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744716E437;
	Thu, 30 Sep 2021 15:50:45 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B302A6E437
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 15:50:44 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id y1so4321644plk.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=Gr6m8FAVtsMMSPoeltQEvBWJnX5jY3wuUND7H9rlWaI=;
 b=ixvb71JYpFHJhasqmuGaGvzOxk8ZLPQ/lsxpflNgvpSRozpbieqXKsozQTVEcTY4P1
 GArXFLK6fx3brVSa7KmIpzdrKwDUfJt+ULMmhmo5PFVojURSYBOrA9PxTZf1FWs36iGG
 S2HRYBcudxJZnrj8QnYod15v6h3EIzbG+Bjgb7fgF23T8tXNzV8jZNQPRZ7q0kHpCoki
 LvDwYD7oyhmCAmrDCN7BWCvfCWc2TKfyfPCE6n5hE1NOudK2zrsQpfXVI5hCQ3mfet+c
 FvAUj2uRirXi5HmyYrbeV902RfYCI0cgX5w/6XXbvP6zqQWR2OkFQb0tlfW4gwcXKKuQ
 YCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Gr6m8FAVtsMMSPoeltQEvBWJnX5jY3wuUND7H9rlWaI=;
 b=lya3p1CdTPQiKRxp5uyoxSwKWrUvejXBdzhLfmWzICtdvAxYQiLGoLsA+Cz8jLdkxs
 mtuo+OB9uxfDzqtx4xS5JHXfRXQ0YNlzviMYJrWAE64te80dDTuVl83RpPJZnjZZ/SsX
 w5XvLFa8FWSszhaEhBzC4dewuF310OEIo2iiJn3Cj+RnfzDBkHlEY8go/Qek5cQlMbiP
 gqixi586SBUG5QF+cfbN76bk5sEN5o4uxM9ZxMErxLAiucyphJQCj4YdBtPDNrrHM8ov
 sMVJxMXy3irMbLDHeEoKNgVp1gaENkiEmLp9Yz7CtPsC9RYi25cakwszo77x2Ad0fDHs
 YsUg==
X-Gm-Message-State: AOAM533NIuNv+XBazhQQnruNjtyB9zYaNwCbp6fcGtQu4gz4P4+Mrlyv
 NtU4GF7DP/04CoFD/B18nCK1tzDx+3Cuo8x/K5enSOWl
X-Google-Smtp-Source: ABdhPJx3CcNQQi3oixSM12ItAqCK1T3F1nj33LrGHsZ6GPuSDFuilQICAE4snZaH6aMpSNtgVHTcefaFNSJnuOA4TjA=
X-Received: by 2002:a17:90a:7301:: with SMTP id
 m1mr7205240pjk.164.1633017044090; 
 Thu, 30 Sep 2021 08:50:44 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 30 Sep 2021 11:50:07 -0400
Message-ID: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
Subject: [PATCH] drm/amd/display: fix DCC settings for DCN3
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="000000000000d3633205cd386857"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000d3633205cd386857
Content-Type: multipart/alternative; boundary="000000000000d3632f05cd386855"

--000000000000d3632f05cd386855
Content-Type: text/plain; charset="UTF-8"

Hi,

Just discovered this typo. Please review.

Thanks,
Marek

--000000000000d3632f05cd386855
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Hi,</div><div><br></div><div>Just discovered this typo. Please review.</div><div><br></div><div>Thanks,</div><div>Marek<br></div></div>

--000000000000d3632f05cd386855--

--000000000000d3633205cd386857
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amd-display-fix-DCC-settings-for-DCN3.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-fix-DCC-settings-for-DCN3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ku74426o0>
X-Attachment-Id: f_ku74426o0

RnJvbSAzYWJlZTgyNDIyM2UyMTRkOGE3NGMzZjFiNDdhMjRlNWVhOWE5YTM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogVGh1LCAzMCBTZXAgMjAyMSAxMToxMzo1OSAtMDQw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogZml4IERDQyBzZXR0aW5ncyBmb3Ig
RENOMwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9
VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKaW5kX2Jsb2NrXzY0Yl9ub18x
MjhiY2wgbWVhbnMgSU5ERVBfNjRCICYmIElOREVQXzEyOEIgJiYKTUFYX0NPTVBSRVNTRURfQkxP
Q0tfU0laRSA9PSA2NEIuIE9ubHkgdXNlZCBieSBnZngxMC4zLgoKaW5kX2Jsb2NrXzY0YiBtZWFu
cyBJTkRFUF82NEIgJiYgIUlOREVQXzEyOEIgJiYKTUFYX0NPTVBSRVNTRURfQkxPQ0tfU0laRSA9
PSA2NEIuIE9ubHkgdXNlZCBieSBnZng5IGFuZCBnZngxMC4KClNpZ25lZC1vZmYtYnk6IE1hcmVr
IE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jICAgICAgICAgICB8IDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jCmluZGV4IGRmODNiMWY0MzhiNi4uZWJkYjk1OWY0ZTFmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCkBAIC05Nyw2ICs5Nyw3IEBACiAgKiAtIDMu
NDEuMCAtIEFkZCB2aWRlbyBjb2RlYyBxdWVyeQogICogLSAzLjQyLjAgLSBBZGQgMTZicGMgZml4
ZWQgcG9pbnQgZGlzcGxheSBzdXBwb3J0CiAgKiAtIDMuNDMuMCAtIEFkZCBkZXZpY2UgaG90IHBs
dWcvdW5wbHVnIHN1cHBvcnQKKyAqIC0gMy40NC4wIC0gRENOMyBzdXBwb3J0cyBEQ0MgaW5kZXBl
bmRlbnQgYmxvY2sgc2V0dGluZ3M6ICE2NEIgJiYgMTI4QiwgNjRCICYmIDEyOEIKICAqLwogI2Rl
ZmluZSBLTVNfRFJJVkVSX01BSk9SCTMKICNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUgk0MwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5k
ZXggYTM5OWE5ODRiOGE2Li40OWJlNTMxZDY4YWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtNTEwNSwxMSArNTEwNSwxMSBA
QCBmaWxsX2dmeDlfcGxhbmVfYXR0cmlidXRlc19mcm9tX21vZGlmaWVycyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAkJZGNjLT5pbmRlcGVuZGVudF82NGJfYmxrcyA9IGluZGVwZW5kZW50
XzY0Yl9ibGtzOwogCQlpZiAoQU1EX0ZNVF9NT0RfR0VUKFRJTEVfVkVSU0lPTiwgbW9kaWZpZXIp
ID09IEFNRF9GTVRfTU9EX1RJTEVfVkVSX0dGWDEwX1JCUExVUykgewogCQkJaWYgKGluZGVwZW5k
ZW50XzY0Yl9ibGtzICYmIGluZGVwZW5kZW50XzEyOGJfYmxrcykKLQkJCQlkY2MtPmRjY19pbmRf
YmxrID0gaHVicF9pbmRfYmxvY2tfNjRiOworCQkJCWRjYy0+ZGNjX2luZF9ibGsgPSBodWJwX2lu
ZF9ibG9ja182NGJfbm9fMTI4YmNsOwogCQkJZWxzZSBpZiAoaW5kZXBlbmRlbnRfMTI4Yl9ibGtz
KQogCQkJCWRjYy0+ZGNjX2luZF9ibGsgPSBodWJwX2luZF9ibG9ja18xMjhiOwogCQkJZWxzZSBp
ZiAoaW5kZXBlbmRlbnRfNjRiX2Jsa3MgJiYgIWluZGVwZW5kZW50XzEyOGJfYmxrcykKLQkJCQlk
Y2MtPmRjY19pbmRfYmxrID0gaHVicF9pbmRfYmxvY2tfNjRiX25vXzEyOGJjbDsKKwkJCQlkY2Mt
PmRjY19pbmRfYmxrID0gaHVicF9pbmRfYmxvY2tfNjRiOwogCQkJZWxzZQogCQkJCWRjYy0+ZGNj
X2luZF9ibGsgPSBodWJwX2luZF9ibG9ja191bmNvbnN0cmFpbmVkOwogCQl9IGVsc2UgewotLSAK
Mi4yNS4xCgo=
--000000000000d3633205cd386857--
