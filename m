Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 07:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AFE208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 07:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DPnx2FG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AFE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CC36E4FF;
	Thu, 28 May 2020 07:45:19 +0000 (UTC)
Received: from sonic304-20.consmr.mail.ne1.yahoo.com
 (sonic304-20.consmr.mail.ne1.yahoo.com [66.163.191.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF836E3DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1590651128; bh=KcM3yCwL5SWyWplC7ioXTuBryhjb0RzSeQSPGcn7xXY=;
 h=Date:From:To:Subject:References:From:Subject;
 b=DPnx2FG/C1bMQXDdG7np43kTXBZlnQxLgRqY7uw5I5H3Mwx+j24Z6ukr4yIoMm68ivKwkqDfiwjDk5RgOwLZ02oX5oa2ZNQ/UeIukDPx0FrtMFNsbVMLfazg9X0nGV9cdDU2Ls8KJU/PdJ3sqqJTTWnkH9Cgr75Pw6bHppnKho/yGOK6xg+H1Mj7jsXfceKoDlBg8O/Lx6heeNW8vf0v40Nt1tRRYCBJmfmwRK4866GG03xLry6w7QHwaF0X/TEXu4pHdmndJWgTC8L3VNsQJPckdkOBKW0hECF2CU5ukNphj4j0EcwBRRoa354eRZf0U5MI31WVXf/qiduJ5QcCgw==
X-YMail-OSG: gvePjp8VM1kM0H3OY7pweW6MLsS4pXbGh7SAjJdzMBjqHtZqD3ooCBAgigpC708
 PafGbnvkSk3I4L1nAtAZX8_DTIrQ8YMIpkPIPCrFah9tpa4wnwAmk1mZUPl.injsrq8EOktCUFDX
 E.woyKigS0qHJltVf92V70DWUFf7hei6mQ8ZllLSGNjkyejobD5hTK8PbV_czBFYiKTOSsq41GPF
 Mh7AlEDv0NUwjoK_WY3JhjxBlph1zh82j6N9PwarDn7K1BndeHPlK4kIf.g6mw24BnTCt5nJwCHa
 ETp_4XTwr6SwNH3NvSeJCD034IodImI1QPmXwSzpaRUaqNTz7gVLPOiDEEl5yUkbMJuKGFw8BOMU
 ggMJgTjrKIimBfWwv1AXxaOYvFMDBEI5MkgO2HAez8NsKC6PQVgju_uvHJD03FyQPAzweUFDP6gn
 Eecp1Lr2Jch4VhvDr3RC2NGeuBoI8ncwBTPxBqVLDDHar1DaUC99LPFM4eLDLwx8Mx2NMjc_pGO.
 irqTzH8RIYmIgJVygKgVppWTcF.C1sK1xRMhLGgw2rivz7zTK_Q5_mydtnC0t9chDJWYC7wW3Yqr
 258zjgIQJ0ci5WtQHGpaUqQ3IjP207Qg..GAmAjam1ts7NF.QFJgSRE5Mk2bysaSjdH2JQq.v9Rh
 HdCCYAQRmW1kJPBs71VpM1Tw8YlPwgRmjHjnt6lf6gMn2H3kce_0UB9J0vhrgi_jOfZKMMKj_uEn
 hp2vfiFQwAhbmqBJ.OOTjiKvt1voGOS1VWysQ3C89cCX4ssm0EqDvQvA1zP7NlhPSJr0rDOzVjAd
 XPH5N0rA_XnfvE_Cdw9HO_nM0ryuWmPv0vpOKByaq3XddXTYBZcjCR26LFj5CYRj84Aq9HXD8T7H
 0OAGw4WbQErtATa0HDKcmXPhEwPmOCGrQBoDMNGDN.R5xxiUtsAnyJYsvP9fawEgfyC5kRrixGwL
 vftjhlzvMoCSKOFIdOUsHHMt1vf.U5Bh0sncwLuzxYfT103sugFAtLXs00K8YZ.YxwhBKqZi8VeM
 Nz7R4bNckMkEKRS386ZlV8Tah_EX57Ed8oKjX0DqDXMBWwKIMf29MmYIEx4DKn39jbqBTIBDWWEQ
 7PeyStn_KkE.DPen5diwAKC9l2h0HQSiTqftt2QuRJ2eo7OleApMyXzINJP0dPl2QNfBxwCSp6dh
 fQGdfl2b.vDf8LHP_nU9uP.f_vRjEAvAgVIlseSU8z30IDcmf_KO8QnZmZcqDy0cl81WgF5RadVf
 ETN8YldpzgeF_QJ7xBoNWOwS.kj7TxEubIDy3vKWQw2HxMIteqmtNukj0.JhlGyrxWOUrpFn6
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 May 2020 07:32:08 +0000
Date: Thu, 28 May 2020 07:32:07 +0000 (UTC)
From: Ian Rogers <gruffhacker-insta@yahoo.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <91667893.917091.1590651127476@mail.yahoo.com>
Subject: using amdgpu headless (no monitor)
MIME-Version: 1.0
References: <91667893.917091.1590651127476.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15959 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
 x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61
 Safari/537.36
X-Mailman-Approved-At: Thu, 28 May 2020 07:45:18 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksCgpXaHkgY2FuJ3QgdmlydHVhbF9kaXNwbGF5IGJlIHVzZWQgYWxvbmcgd2l0aCBhIHBoeXNp
Y2FsIGRpc3BsYXk/CgpJIHNlZSBmcm9tIGhlcmU6wqBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTIwMzMzOcKgdGhhdCB0aGUgaW50ZW50aW9uIG9mIHRoZcKgdmly
dHVhbF9kaXNwbGF5IG1vZHVsZSBvcHRpb24gaXMgdG8gYWxsb3cgZm9yIHZpcnR1YWwgZGlzcGxh
eXMgYW5kIHB1cnBvc2VseSBkaXNhYmxlIHBoeXNpY2FsL3JlYWwgZGlzcGxheXMuCklzIHRoZXJl
IGEgdGVjaG5pY2FsIGxpbWl0YXRpb24gdGhhdCByZXF1aXJlZCB0aGlzPwoKSSBhc2sgYmVjYXVz
ZSBJIHdhbnQgdG8gYmUgYWJsZSB0byBydW4gYSBzeXN0ZW0gdGhhdCBpcyBzb21ldGltZXMgaGVh
ZGxlc3MgYW5kIHNvbWV0aW1lcyBub3QuwqAgQW5kIEknZCBsaWtlIHRvIGJlIGFibGUgdG8gYWNj
ZXNzIGEgY3VycmVudCBYIHNlc3Npb24gKGVpdGhlciBsb2dnZWQgaW4gb3IgYXQgdGhlIGxvZ2lu
IGdyZWV0ZXIpIGJvdGggcmVtb3RlbHkgKHNheSB2aWEgVk5DKSBhbmQgbG9jYWxseSB2aWEgdGhl
IHBoeXNpY2FsIGRpc3BsYXkgKHdoZW4gaXQgaXMgcGx1Z2dlZCBpbikud2l0aG91dCBoYXZpbmcg
dG8gcmVib290IG9yIGxvc2UgdGhhdCBYIHNlc3Npb24uCgpIb3dldmVyIEkndmUgbm90aWNlZCB0
aGF0IChhdCBsZWFzdCB3aXRoIGEgUnl6ZW4gMyAzMjAwRyB3aXRoIFJhZGVvbiBWZWdhIDgpIGFu
IFggc2Vzc2lvbiBkb2VzIG5vdCBsb2dpbiBzdWNjZXNzZnVsbHkgd2hlbiBhY2Nlc3NlZCByZW1v
dGVseSBpZiB0aGVyZSBpcyBubyBtb25pdG9yIGNvbm5lY3RlZC4KSSBhc3N1bWUgdGhpcyBpcyBj
YXVzZWQgYnkgc29tZXRoaW5nIGluIHRoZSBhbWRncHUgZHJpdmVyIGJ1dCBJIGhhdmVuJ3QgYmVl
biBhYmxlIHRvIGZpZ3VyZSBvdXQgd2hhdC4KU28gSSB3YXMgaG9waW5nIHRoYXQgcGVyaGFwcyBh
IHNvbHV0aW9uIHdvdWxkIGludm9sdmUgdXNpbmfCoHZpcnR1YWxfZGlzcGxheSwgYnV0IHRoYXQg
d29uJ3Qgd29yayBhcyBpdCdzIGN1cnJlbnRseSBkZXNpZ25lZCBiZWNhdXNlIG9mIGl0IGRpc2Fi
bGluZyB0aGUgcGh5c2ljYWwgZGlzcGxheS4KCkJ1dCBtYXliZSBJJ3ZlIGdvbmUgZG93biB0aGUg
d3JvbmcgdHJhY2sgYW5kIHRoZXJlIGlzIGFub3RoZXIgc29sdXRpb24uwqAgSSd2ZSB0cmllZCB1
c2luZyB0aGUgeG9yZyBkdW1teSBkcml2ZXIgaW4gYWRkaXRpb24gdG8gYW1kZ3B1LCBidXQgd2hl
biBkb2luZyBzbywgSSBjYW4gbmV2ZXIgZ2V0IGEgcGh5c2ljYWwgZGlzcGxheSB3b3JraW5nLgpU
aGlzIGlzIGFuIFVidW50dSAyMC4wNCBzeXN0ZW0gd2l0aCBrZXJuZWzCoDUuNC4wLgoKSSBjYW4g
cHJvdmlkZSBsb3RzIG1vcmUgZGV0YWlsIG9uIHdoYXQgSSd2ZSB0cmllZCBhbmQgbXkgY29uZmln
IHdoZXJlIG5lZWRlZC4KClRoYW5rcyBtdWNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
