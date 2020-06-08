Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05703C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 07:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF245204EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 07:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sxZKgnjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF245204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AED189DBA;
	Mon,  8 Jun 2020 07:24:45 +0000 (UTC)
Received: from sonic311-25.consmr.mail.ne1.yahoo.com
 (sonic311-25.consmr.mail.ne1.yahoo.com [66.163.188.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0CD893EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1591591333; bh=RqDVXMk2zbhGaupskbSW8PxEx/t2WAObK/Z6yh1Zlr0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject;
 b=sxZKgnjhn2Ed7klHtIZ4JEdTJxUL+9z4+rnGVVsaHb6dBUe/1ZKOmdzgdrHg/OhO4lOvFgcGe4goFYSddcRhmgAvQhavirNPsquGNE+812E7Ud7CmMtjU5HRDugfFCU3a8KeBm21scwf/ctasWigSa9C5IrgZf3h2cm7DkiV+YppPSByz3VJRWPtYHFKA1/AX4nV9OmHIOV83JilPN5Yman9gpaK4Bdxn1abTT9HC21UanZJWf2wIjzU589Wu3zls9C+2IuABHxRdtX+ZEZlQZMI/dKHj0oJRrhiGs+hSiJmgc+gXKRB31Zzw+YqtJxVixttvGLuVKCi1lF93Shfwg==
X-YMail-OSG: ._5dIpQVM1mNgsZWLMXsXtaRyZJtqvj3_lqQGM4qfnE9zcg1hTMlowrC0diuq6X
 7sNfXHCB00uvhLWwdCq1jgOYTJPnO3aRABSeEmr1yaN72hbQSuD26Pb8RKwBxS2hSHxvm6XwN14_
 UMfJCh8hXHT8UFBwTLICyAESM_mwuPp1BAanHHuMdV4UFTJ9p25H5X5039YBLIzXWQovJbR_z1N4
 WVi.5lFjplRZ8YGJ0zshxjDdmiyWXEiVJBlarJbTfLo8KOQ3iN0tGSkXG5a.Hz6JePSapAaUs_EW
 bU1wKhf5cvcCz2NwWrmWsBkF5RC4as90D.yUOkv8nNO3UouJzCPMKf5TJ6uvBWtnbLUB0tmPUxji
 10JqEwDLudIJZWzxFdsAGkCetrq_tBLPh69zpBl153z2ua5AmabK890gnnn0BetpNs4QbDOEtjNN
 V.aetd05quXNO0DBS6j1Y5eAUKPcFg03yDQC_qi_EJXafrLM4Y8gpK0gJTiIX3i0fL5pN.xeoQ65
 mh4pUOimYpZJ4muvGh.efOZsUsearcZuteoXE4DhNj4jF_9GGhesq2hi3FVOFjsSI2iSa27rhmHR
 O1piqYyiljf6IG26SngxTeX4CeAOMnULTX8fQnuHs1_fNazhHJDUzRXwqY3oq1mt5UwfmNik_Xon
 JAZXr4SAGg9WjvsXdRplKwfR1uslP.mwVLBJ2Atd9dmD8fVuddDvapeQ.cb3PwRwakBcwZ4s7wzD
 0kd_4zWCT3Wg7Qj1yz9yfe2MK8iFBclxLD6pVQFZOJ8OohFJYmErSMCiIRGFsikaqr0Oluqi19L2
 LYKWkPxUx03ntnB_rscaRVCYU1aaIihr2KBGiSdGQBx2ZsW57wGS7d._tKQ1oG4_XMpwllYbL7k0
 m4llNpQwtYviExewBuf7Cj22_oaEgkja3dIJmTPcXxM9E2RXoViQQpmeMYITsAE3csW5lJvEv94e
 SkKrPX7211.Gxa_6C_7xIgFpGv2OFE0PN20FbuEe0gMIHG.3nQok.SVf4Od0etNkQLJMEw6DzwS5
 ZbbdPfoP8ftw.YJ_8w4vRmmVw7ICa0hKlSzWpEjxXGzPkPgY09ImTaBJ.CKmfRmJtYVmxkppvyP2
 IUTmD.T1GaSlAFKlemFty6BUTRcL0_JaAWthxm05Y1.irJl.wclh1hkvO_rkU4Unf8E0DVV_Wdgc
 e_4fbXYLokbfYEcPJFPK4oIHcpwnWa3B6ErviVxQj57G97U1WJiAecLoOs8lUymQkR0Oz2Em58JJ
 _zpSA1Uvr4xdj3bbdUsdjPDe8645T78wQq9Nq_PaMEOwanxq_XwqMFufVaCRW3UiTxBAbDQg6KEh
 RKUKiMu5M_A--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jun 2020 04:42:13 +0000
Date: Mon, 8 Jun 2020 04:41:31 +0000 (UTC)
From: Ian Rogers <gruffhacker-insta@yahoo.com>
To: Alex Deucher <alexdeucher@gmail.com>
Message-ID: <1604567744.748054.1591591291556@mail.yahoo.com>
In-Reply-To: <CADnq5_N_3QepQBn9cHq5yk3og6tGFNRgV1Rye+0Z0B+7B3okPw@mail.gmail.com>
References: <91667893.917091.1590651127476.ref@mail.yahoo.com>
 <91667893.917091.1590651127476@mail.yahoo.com>
 <CADnq5_N_3QepQBn9cHq5yk3og6tGFNRgV1Rye+0Z0B+7B3okPw@mail.gmail.com>
Subject: Re: using amdgpu headless (no monitor)
MIME-Version: 1.0
X-Mailer: WebService/1.1.16072 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
 x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61
 Safari/537.36
X-Mailman-Approved-At: Mon, 08 Jun 2020 07:24:43 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIG11Y2ggQWxleCBmb3IgcmVzcG9uZGluZy4KCk9uIFRodXJzZGF5LCBNYXkgMjgsIDIw
MjAsIDA0OjI5OjE2IFBNIEVEVCwgQWxleCBEZXVjaGVywqAgd3JvdGU6Cgo+PiBJIGFzayBiZWNh
dXNlIEkgd2FudCB0byBiZSBhYmxlIHRvIHJ1biBhIHN5c3RlbSB0aGF0IGlzIHNvbWV0aW1lcyBo
ZWFkbGVzcyBhbmQgc29tZXRpbWVzIG5vdC7CoCBBbmQgSSdkIGxpa2UgdG8gYmUgYWJsZSB0byBh
Y2Nlc3MgYSBjdXJyZW50IFggc2Vzc2lvbiAoZWl0aGVyIGxvZ2dlZCBpbiBvciBhdCB0aGUgbG9n
aW4gZ3JlZXRlcikgYm90aCByZW1vdGVseSAoc2F5IHZpYSBWTkMpIGFuZCBsb2NhbGx5IHZpYSB0
aGUgcGh5c2ljYWwgZGlzcGxheSAod2hlbiBpdCBpcyBwbHVnZ2VkIGluKS53aXRob3V0IGhhdmlu
ZyB0byByZWJvb3Qgb3IgbG9zZSB0aGF0IFggc2Vzc2lvbi4KPj4KPj4gSG93ZXZlciBJJ3ZlIG5v
dGljZWQgdGhhdCAoYXQgbGVhc3Qgd2l0aCBhIFJ5emVuIDMgMzIwMEcgd2l0aCBSYWRlb24gVmVn
YSA4KSBhbiBYIHNlc3Npb24gZG9lcyBub3QgbG9naW4gc3VjY2Vzc2Z1bGx5IHdoZW4gYWNjZXNz
ZWQgcmVtb3RlbHkgaWYgdGhlcmUgaXMgbm8gbW9uaXRvciBjb25uZWN0ZWQuCj4+IEkgYXNzdW1l
IHRoaXMgaXMgY2F1c2VkIGJ5IHNvbWV0aGluZyBpbiB0aGUgYW1kZ3B1IGRyaXZlciBidXQgSSBo
YXZlbid0IGJlZW4gYWJsZSB0byBmaWd1cmUgb3V0IHdoYXQuCj4KPkl0J3MgeW91ciBkaXNwbGF5
IG1hbmFnZXIgKFgsIG11dHRlciwga3dpbiwgZXRjLikuwqAgVGhleSBnZW5lcmFsbHkKPndvbid0
IHN0YXJ0IGlmIHRoZXkgZG9lc24ndCBkZXRlY3QgYSBtb25pdG9yLsKgIFlvdSBtaWdodCBiZSBh
YmxlIHRvCj5mb3JjZSBvbmUgdmlhIHdoYXRldmVyIGNvbmZpZ3VyYXRpb24gbWVjaGFuaXNtIGlz
IHByb3ZpZGVkIGJ5IHlvdXIKPmVudmlyb25tZW50LgoKWWVzIGl0IHNlZW1zIHRvIGJlIGFuIGlz
c3VlIHdpdGggZ25vbWUtc2hlbGwvbXV0dGVyICh0aGUgc2hlbGwvd2luZG93IG1hbmFnZXIpLCBy
YXRoZXIgdGhhbiBYb3JnIChteSBkaXNwbGF5IHNlcnZlciksIGJ1dCBJIHdpbGwgcmVwb3J0IGJh
Y2sgaWYgdGhlIHJlbGV2YW50IGRldmVsb3BlciB0ZWFtcyBvZiB0aG9zZSBpdGVtcyBoYXZlIGFu
eSByZXF1ZXN0cyBmb3IgYW1kZ3B1IHJlbGF0ZWQgdG8gdGhpcyBpc3N1ZS4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
