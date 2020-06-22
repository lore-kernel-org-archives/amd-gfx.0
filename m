Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85208C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59243206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smq94pcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59243206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136776E5C5;
	Mon, 22 Jun 2020 13:26:08 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320A36E5C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 13:26:06 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g75so6783125wme.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=VDodAlwychbfLxmfRjRTI7xwLg/A/SA2sJS9DmDx6l8=;
 b=Smq94pcnzcraLkBcQ+hEHChl/x+v9GFK9Xrke+tAPcA2IUQauOIAQFBvdSjfscqiHY
 yzkbJsW+IeSDOfIREjdFqtr3byXd5RkZzeeI3Eab/Dn07IVZzyqh0aVS+a8GZxn0Nqnn
 a85AaESjpBDPX5NtjQ8BvYWsHKSQltUVAPsfZRabkl6Pvf2/IscNGdQ3HfxSQzhVWq5A
 RNC/TH1jKNHVUoNo39vRAgjR9uYVNRZts2E+1VkgTa1TeuDmTF0YIBY20hH8XyKHWr30
 peqHEy45QufzlrPpg333dY+IaS+VYFMcOKgaiHohigcqrR9YLmMuh41TUO1mCeiCa06s
 576g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=VDodAlwychbfLxmfRjRTI7xwLg/A/SA2sJS9DmDx6l8=;
 b=jBaGt3i1vVGTnNrMwbSRgYk92MH+qJgWD4e8tffzU4xrumBsBium0NkJjTfthKRgG7
 RjWpgUTw2xaqwrD1sxJvUIfCME8gxEa+N5U59R7IKDUyUN7jHsUm15j1166LFlVw2o9r
 UHKQDoVIpYoFQv4649ePGPsvXPOx+PHiO5NJHx55HtuFsV8pZsFMRDe78wydoBoS2Rm1
 uOTAGNRGtdKI9X7vYdtrWFNUXVSStl1yGIj+J8oXdfmKMhpvlr4HaENXE+MMY3kozRk3
 pNkz+W13RwV+Ejiiu0j5npCDfDH6QnnvAcKbAJBmTUPscDzKFwiIV86tDzLJieETIZ8l
 iTFA==
X-Gm-Message-State: AOAM531XuiPXHJtBCcImNbL0WpPsn1NnQj80lzwjQbH4yk89J6sdK1jN
 OCYzDqotVz4sYyY3IGMSF+s=
X-Google-Smtp-Source: ABdhPJxC/GF73eG1W2Uod5ZUlU2ECiWJZDTVMiYEH1YiNZX0WfgxGPIgtZflQeHbwiA6AUfyDh9IXQ==
X-Received: by 2002:a1c:61d7:: with SMTP id
 v206mr15774599wmb.173.1592832364864; 
 Mon, 22 Jun 2020 06:26:04 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id m65sm16478010wmf.17.2020.06.22.06.26.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:26:04 -0700 (PDT)
Subject: Re: [PATCH] Revert "drm/amd/display: Expose connector VRR range via
 debugfs"
To: Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 amd-gfx@lists.freedesktop.org
References: <20200622144225.16549-1-bhanuprakash.modem@intel.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a8d735f6-4f9d-ae5a-af86-9cae189e4f18@gmail.com>
Date: Mon, 22 Jun 2020 15:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622144225.16549-1-bhanuprakash.modem@intel.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, manasi.d.navare@intel.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjAgdW0gMTY6NDIgc2NocmllYiBCaGFudXByYWthc2ggTW9kZW06Cj4gQXMgYm90
aCBWUlIgbWluIGFuZCBtYXggYXJlIGFscmVhZHkgcGFydCBvZiBkcm1fZGlzcGxheV9pbmZvLAo+
IGRybSBjYW4gZXhwb3NlIHRoaXMgVlJSIHJhbmdlIGZvciBlYWNoIGNvbm5lY3Rvci4KPgo+IEhl
bmNlIHRoaXMgbG9naWMgc2hvdWxkIG1vdmUgdG8gY29yZSBEUk0uCj4KPiBUaGlzIHJldmVydHMg
Y29tbWl0IDcyNzk2MmYwMzBjMjM0MjJhMDFlOGIyMmQwZjQ2MzgxNWZiMTVlYzQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBCaGFudXByYWthc2ggTW9kZW0gPGJoYW51cHJha2FzaC5tb2RlbUBpbnRlbC5j
b20+Cj4gQ2M6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNv
bT4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogTWFuYXNpIE5hdmFy
ZSA8bWFuYXNpLmQubmF2YXJlQGludGVsLmNvbT4KClNvdW5kcyBsaWtlIGl0IG1ha2VzIHNlbnNl
LCBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KCj4gLS0tCj4gICAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9k
ZWJ1Z2ZzLmMgfCAyMCAtLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCj4gaW5kZXggMDc2YWYyNjdiNDg4Li43
MTM4N2QyYWYyZWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCj4gQEAgLTgyMCwyNCArODIwLDYg
QEAgc3RhdGljIGludCBvdXRwdXRfYnBjX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpk
YXRhKQo+ICAgCXJldHVybiByZXM7Cj4gICB9Cj4gICAKPiAtLyoKPiAtICogUmV0dXJucyB0aGUg
bWluIGFuZCBtYXggdnJyIHZmcmVxIHRocm91Z2ggdGhlIGNvbm5lY3RvcidzIGRlYnVnZnMgZmls
ZS4KPiAtICogRXhhbXBsZSB1c2FnZTogY2F0IC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL0RQLTEv
dnJyX3JhbmdlCj4gLSAqLwo+IC1zdGF0aWMgaW50IHZycl9yYW5nZV9zaG93KHN0cnVjdCBzZXFf
ZmlsZSAqbSwgdm9pZCAqZGF0YSkKPiAtewo+IC0Jc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5l
Y3RvciA9IG0tPnByaXZhdGU7Cj4gLQlzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5l
Y3RvciA9IHRvX2FtZGdwdV9kbV9jb25uZWN0b3IoY29ubmVjdG9yKTsKPiAtCj4gLQlpZiAoY29u
bmVjdG9yLT5zdGF0dXMgIT0gY29ubmVjdG9yX3N0YXR1c19jb25uZWN0ZWQpCj4gLQkJcmV0dXJu
IC1FTk9ERVY7Cj4gLQo+IC0Jc2VxX3ByaW50ZihtLCAiTWluOiAldVxuIiwgKHVuc2lnbmVkIGlu
dClhY29ubmVjdG9yLT5taW5fdmZyZXEpOwo+IC0Jc2VxX3ByaW50ZihtLCAiTWF4OiAldVxuIiwg
KHVuc2lnbmVkIGludClhY29ubmVjdG9yLT5tYXhfdmZyZXEpOwo+IC0KPiAtCXJldHVybiAwOwo+
IC19Cj4gLQo+ICAgI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0hEQ1AKPiAgIC8qCj4gICAgKiBS
ZXR1cm5zIHRoZSBIRENQIGNhcGFiaWxpdHkgb2YgdGhlIERpc3BsYXkgKDEuNCBmb3Igbm93KS4K
PiBAQCAtMTAwMSw3ICs5ODMsNiBAQCBzdGF0aWMgc3NpemVfdCBkcF9kcGNkX2RhdGFfcmVhZChz
dHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPiAgIERFRklORV9TSE9XX0FUVFJJQlVU
RShkbXViX2Z3X3N0YXRlKTsKPiAgIERFRklORV9TSE9XX0FUVFJJQlVURShkbXViX3RyYWNlYnVm
ZmVyKTsKPiAgIERFRklORV9TSE9XX0FUVFJJQlVURShvdXRwdXRfYnBjKTsKPiAtREVGSU5FX1NI
T1dfQVRUUklCVVRFKHZycl9yYW5nZSk7Cj4gICAjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfSERD
UAo+ICAgREVGSU5FX1NIT1dfQVRUUklCVVRFKGhkY3Bfc2lua19jYXBhYmlsaXR5KTsKPiAgICNl
bmRpZgo+IEBAIC0xMDU5LDcgKzEwNDAsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsKPiAgIAkJ
eyJwaHlfc2V0dGluZ3MiLCAmZHBfcGh5X3NldHRpbmdzX2RlYnVnZnNfZm9wfSwKPiAgIAkJeyJ0
ZXN0X3BhdHRlcm4iLCAmZHBfcGh5X3Rlc3RfcGF0dGVybl9mb3BzfSwKPiAgIAkJeyJvdXRwdXRf
YnBjIiwgJm91dHB1dF9icGNfZm9wc30sCj4gLQkJeyJ2cnJfcmFuZ2UiLCAmdnJyX3JhbmdlX2Zv
cHN9LAo+ICAgI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0hEQ1AKPiAgIAkJeyJoZGNwX3Npbmtf
Y2FwYWJpbGl0eSIsICZoZGNwX3NpbmtfY2FwYWJpbGl0eV9mb3BzfSwKPiAgICNlbmRpZgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
