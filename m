Return-Path: <SRS0=dnVN=F7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7988AC433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Dec 2020 10:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87135207AE
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Dec 2020 10:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87135207AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A20896E9;
	Sun, 27 Dec 2020 10:53:17 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3282C896E9
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Dec 2020 10:53:16 +0000 (UTC)
Received: from [192.168.1.11]
 (dynamic-077-013-243-215.77.13.pool.telefonica.de [77.13.243.215])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C6D720646219;
 Sun, 27 Dec 2020 11:53:13 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: Fix macro name _AMDGPU_TRACE_H_ in
 preprocessor if condition
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20201226085607.155289-1-lichenyang@loongson.cn>
 <1898b3da-9958-ebd9-dc58-26168ee67653@molgen.mpg.de>
 <9dd7dbb4-cea0-da1d-042c-a2b5e69ef1bd@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <72cdedf8-8850-2ad8-b8bc-d26eb1e2996f@molgen.mpg.de>
Date: Sun, 27 Dec 2020 11:53:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9dd7dbb4-cea0-da1d-042c-a2b5e69ef1bd@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chenyang Li <lichenyang@loongson.cn>, Chen Guchun <Guchun.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christina_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBDaHJpc3RpYW4sCgoKQW0gMjcuMTIuMjAgdW0gMTA6Mzggc2NocmllYiBDaHJpc3RpYW4g
S8O2bmlnOgo+IEFtIDI2LjEyLjIwIHVtIDE0OjE2IHNjaHJpZWIgUGF1bCBNZW56ZWw6Cgo+PiBB
bSAyNi4xMi4yMCB1bSAwOTo1NiBzY2hyaWViIENoZW55YW5nIExpOgo+Pj4gQWRkIGFuIHVuZGVy
c2NvcmUgaW4gYW1kZ3B1X3RyYWNlLmggbGluZSAyNCAiX0FNREdQVV9UUkFDRV9IIi4KPj4+Cj4+
PiBGaXhlczogZDM4Y2VhZjk5ZWQwICgiZHJtL2FtZGdwdTogYWRkIGNvcmUgZHJpdmVyICh2NCki
KQo+IAo+IFdlbGwgdGhpcyBGaXhlcyB0YWcgaXMgc3VwZXJmbHVvdXMvbWlzbGVhZGluZyBhbmQg
c2hvdWxkIHByb2JhYmx5IGJlIAo+IHJlbW92ZWQuCgpXaHkgaXMgaXQgbWlzbGVhZGluZz8KCj4g
V2h5IHdhcyB0aGF0IGFkZGVkPwoKSSBhc2tlZCBmb3IgdGhhdCwgYmVjYXVzZSB0aGF0IGlzIHRo
ZSBjb21taXQgaW50cm9kdWNpbmcgdGhlIGlzc3VlLCBhbmQgCndpdGggdGhhdCB0YWcgaXTigJlz
ICBtb3JlIGxpa2VseSB0byBwaWNrZWQgZm9yIHRoZSBzdGFibGUgc2VyaWVzLgoKW+KApl0KCgpL
aW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
