Return-Path: <SRS0=HGq7=Z5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9016FC43603
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 10:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589D424670
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 10:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589D424670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2626E0C2;
	Sat,  7 Dec 2019 10:36:36 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB0D6E0C2
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 10:36:34 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id m8so8100741edi.13
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Dec 2019 02:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RV1q7SPYYIatJwcuNdTWqTCP9MfyqlULFXqqtZpjdak=;
 b=b+AhqsoBYYpLyfMERwf0xBCmjE0SG6UpbI7umfFk7OU91G4PWSQ4+p46GlW9hfIisH
 2vxF3EXbilVOygIiRGqXrb4slnVkLrHBegSLSpd6GeuYzajW21qNrGlQ6KFMjaq5fg9G
 sgfTwJiwQbZMBpwX8FvZkP40nMZO7qvz6so4DGkoWQVVhHSStZpxL9LmsRH2EuLWZWx7
 5PgdPSXI0BSu0kwwnIk9WjlW34mhbJ/Qf2+3YFLcjaO9RyKwQin6OUxQYXbOj79+mLoi
 8pyk4sST69fsFDa/YSpJ3o0lOAzm2beZ1xmAO6u7ZnRC/kfDBR4Y+wTdIqoq743jSnRb
 kC9g==
X-Gm-Message-State: APjAAAXxHQHloyKhdJUve2N+6OrUT2ECqwJtbsbxOK9hHH/PpTueHJRq
 I0/lzhSdF10aNryM8mQ9i4g8WMFH9GEdmNcfJCGF
X-Google-Smtp-Source: APXvYqzRlqK3m707Y/64wgHc3kEI/8m1YKEy4WSzKRH6RetZ6JSzAcAU/pgMRU4SI3NoetEAIDO0sG41B/HY16+sIuk=
X-Received: by 2002:aa7:c486:: with SMTP id m6mr21376393edq.297.1575714992767; 
 Sat, 07 Dec 2019 02:36:32 -0800 (PST)
MIME-Version: 1.0
References: <CAKbQEqEE3dgcF1bi-Sh5FQoHiU2TEHYn-H5fE92g6Pa+rgXbiQ@mail.gmail.com>
 <08f54bf9-db69-ff9a-b3bb-477b2ac05eb0@amd.com>
In-Reply-To: <08f54bf9-db69-ff9a-b3bb-477b2ac05eb0@amd.com>
From: Christian Pernegger <pernegger@gmail.com>
Date: Sat, 7 Dec 2019 11:35:56 +0100
Message-ID: <CAKbQEqH5tes3Nf_RaDavb0+z_r5ht=wZjXhZajaQVQNRg1pdZQ@mail.gmail.com>
Subject: Re: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for
 fences timed out or interrupted!
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RV1q7SPYYIatJwcuNdTWqTCP9MfyqlULFXqqtZpjdak=;
 b=EuGLVYp5JmXkJKjo074pG0XzwIndA+bxRvvIb+v3Dg4HWkrB+196yg99b5Dm/qRcrY
 ggSzQdvvQzZrrCPpqfNXYRZ3VPgpHmzbCKsaZJ2jesmScqaPxHI3nbtT8TxEYHuiWRyB
 7d2JTP1fNM75hXkAj2GRS1N9DLpgyW/ZptM4sJVTnN07p6CxlMimz4UfbcN4+LvD2PJV
 dHgoLLDLlB24b7EQolU1ZbuqigGNPzZFQx/QmeOUxK6BzOJ2/5/C/pBHJwxYGqdsNxru
 LHFGUjjvEgEIHf1czIOr1tO+45okko7J1lEnZ9Oqm/pODtMjmIPvZXnxHMEm5+zo7cT4
 bKcA==
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U3VyZS4gKEkganVzdCBob3BlIGl0IGRvZXNuJ3QgZWF0IG15IGRhdGEgYW5kL29yIHVuYm9ybiBj
aGlsZHJlbi4KU29tZXRpbWVzIEkgcmVhbGx5IHdpc2ggb25lIGRpZG4ndCBuZWVkIHRvIHN3aXRj
aCBvdXQgdGhlIHdob2xlIGtlcm5lbAp0byBnZXQgYSBkaWZmZXJlbnQgdmVyc2lvbiBvZiBhIGJ1
bmNoIG9mIGNvbXBvbmVudHMgLi4uKQoKQW55d2F5LCBJIGhhdmUgaXQgKHRoZSBuZXcga2VybmVs
KSBydW5uaW5nIHNpbmNlIHllc3RlcmRheSBldmVuaW5nLAp0aGUgZmlyc3QgT3JpIHNlc3Npb24s
IH4xLjUgaCwgd2FzIHVuZXZlbnRmdWwuCgpJZiAmIHdoZW4gaXQgY3Jhc2hlcywgSSdsbCBnZXQg
YmFjayB0byB5b3UuCgpDaGVlcnMsCkMuCgpBbSBGci4sIDYuIERlei4gMjAxOSB1bSAxNjo0NSBV
aHIgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreQo8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT46
Cj4KPiBUaGUgV0FSTiBzdGFjayB0cmFjZSBhZnRlciBHUFUgcmVzZXQga2lja3MgaW4gcG9pbnRz
IHRvIG5vdCB0aGUgbGF0ZXN0IGNvZGUgLSBjYW4geW91IHBsZWFzZSB0cnkgcnVubmluZyB0aGUg
c2FtZSB3aXRoIGtlcm5lbCBhdCB0aGUgdGlwIG9mIGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5v
cmcvfmFnZDVmL2xpbnV4L2xvZy8/aD1hbWQtc3RhZ2luZy1kcm0tbmV4dCA/Cj4KPiBBbmRyZXkK
Pgo+IE9uIDEyLzUvMTkgNjoxNCBQTSwgQ2hyaXN0aWFuIFBlcm5lZ2dlciB3cm90ZToKPgo+IEhl
bGxvLAo+Cj4gb25lIG9mIG15IGNvbXB1dGVycyBoYXMgYmVlbiBjcmFzaGluZyB3aGlsZSBnYW1p
bmcgcmF0aGVyIGEgbG90Cj4gbGF0ZWx5LCB3aXRoIGtlcm5lbCBtZXNzYWdlcyBwb2ludGluZyB0
byBhbWRncHUuIEZpcnN0IGxpbmUgc2VlCj4gc3ViamVjdCwgcmVzdCBpbiB0aGUgYXR0YWNoZWQg
bG9nLgo+IFNTSCBzdGlsbCB3b3JrcywgYXR0ZW1wdHMgdG8gc2h1dGRvd24vcmVib290IGRvbid0
IHF1aXRlIGZpbmlzaC4KPgo+IFJhZGVvbiBWSUkgaW4gYW4gQXN1cyBQcm8gV1MgWDU3MC1BY2Uu
IFVidW50dSAxOC4wNC4zIEhXRSwgbWVzYS1hY28uCj4gVGhpcyBvbmUgd2FzIHdpdGgga2VybmVs
IDUuMy4wLTI0LWdlbmVyaWMgW2h3ZS1lZGdlXSwgbWVzYQo+IDE5LjMuMCthY28rZ2l0MTU3NTQ1
MjgzMy0zNDA5YzA2ZTI2ZC0xYmlvbmljMSwgdmVzYTIwXyogZnJvbQo+IGxpbnV4LWZpcm13YXJl
LTIwMTkxMDIyLCBydW5uaW5nIE9yaSBhbmQgdGhlIEJsaW5kIEZvcmVzdDogRGVmaW5pdGl2ZQo+
IEVkaXRpb24gdmlhIFByb3Rvbi9XSU5FRDNEMTEgdW5kZXIgU3RlYW0gUmVtb3RlIFBsYXkuIEkn
dmUgaGFkIHNpbWlsYXIKPiBjcmFzaGVzIHNwb3JhZGljYWxseSBldmVuIHdpdGggNS4wIFtwbGFp
biBod2VdIGFuZCBsaW51eC1maXJtd2FyZQo+IGNvbXBsZXRlbHkgc3RvY2ssIGFuZCB3aXRoIG5h
dGl2ZSBnYW1lcyAoZS5nLiBDcnVzYWRlciBLaW5ncyBJSSkKPiBydW5uaW5nIGxvY2FsbHkuCj4g
SXQgdXNlZCB0byBiZSBtYXliZSBvbmNlIGV2ZXJ5IG90aGVyIHdlZWssIHRob3VnaCwgdGhhdCB3
YXMgdG9sZXJhYmxlLAo+IG5vdyBPcmkgdXN1YWxseSB0cmlnZ2VycyBpdCBpbiB1bmRlciBhbiBo
b3VyLiBUdXJuaW5nIG9mZiBBQ08gdmlhCj4gUkFEVl9QRVJGVEVTVD1sbHZtIG1ha2VzIGl0IHdv
cnNlIChub3QgYmFkIGVub3VnaCB0byBtYWtlIGl0IHRyaWdnZXIKPiBxdWlja2x5IGFuZCByZWxp
YWJseS4gdGhvdWdoKSwgZ29pbmcgYmFjayB0byBrZXJuZWwgNS4wIGhlbHBzIChhcyBpbgo+IGFu
IGhvdXIgb3IgdHdvIG1pZ2h0IGdvIGJ5IHdpdGhvdXQgYSBjcmFzaCwgYnV0IHRoZSBwZXJmb3Jt
YW5jZSBpbXBhY3QKPiBpcyBzZXZlcmUpLgo+Cj4gQWxsIHZlcnkgdmFndWUuIFdoaWNoIGlzIHdo
eSB0aGlzIGlzbid0IHByZXRlbmRpbmcgdG8gYmUgYSBidWcgcmVwb3J0LAo+IGp1c3QgYSAiaGFz
IGFueW9uZSBzZWVuIHRoaXM/IiBraW5kIG9mIHNob3V0LW91dC4gSWYgaXQncyB3b3J0aHkgb2YK
PiBmb2xsb3dpbmcgdXAsIEknZCBiZSBoYXBweSB0byBwcm92aWRlIGZ1cnRoZXIgaW5mbywganVz
dCB0ZWxsIG1lIHdoYXQuCj4KPiBDaGVlcnMsCj4gQy4KPgo+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5k
cmV5Lmdyb2R6b3Zza3klNDBhbWQuY29tJTdDYmI3MzA1NTFjOGVmNDA1NzQ5MTkwOGQ3NzlkOTBh
OWIlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTExODQ1
NTE1MDcwNTAwJmFtcDtzZGF0YT1SaXNMNEhCcXkzNXAyNUZPY3A5N0VVJTJGNExkcTZXMUdKdGtW
QU55eno4QlklM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
