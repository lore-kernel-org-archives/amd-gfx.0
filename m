Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38221C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 14:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92D364DF4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 14:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92D364DF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8A76E8C1;
	Mon, 15 Feb 2021 14:54:30 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBAF6E878;
 Mon, 15 Feb 2021 14:39:42 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id fa16so3854210pjb.1;
 Mon, 15 Feb 2021 06:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4k/YlfJBwWB/CB9z3j4IwxeWRKuiJsOpEaK3C24WkHk=;
 b=k0cKC4YN6xyUE2B/OZFXTOW9hvFzaOa/URb+GHSCBxTTmvHlMC9Eta86bh6fCS9h2p
 y66p0KfJrrfzJdHwjKlIKVB09VTVbd8uO5LXSTfEckTSNA43ibpSr8FxWBvDdzmW/BWP
 D111hPR6Xc8SNuwH0bo7QeN6FPMIDV5Y47SI04WrnHpsqUW7Pn19GxIBUPAD78SOfWtE
 LysnRjPtGWRF1ja99qJEZ6qCT91Y+1p89jqnovBYM8L3YBS6mmwrAIHWcWUHvpfD2Por
 THlYbftsWLvbsoIK6qHMb55DNXsFpGqLgZr/IxGSdJOXdfxUNuqxPX8Wt22SgCOeFLSW
 hJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4k/YlfJBwWB/CB9z3j4IwxeWRKuiJsOpEaK3C24WkHk=;
 b=huG5sf5ReJ9801xVyMp8Ap0zEFHqepsB7SBWbnRGk8KChZC4AAd1O2fh2ehMe/eTV8
 wiV1/aU7twXaYDujnIsiCGADXyPaMnuif3AJu4zcM/SxTITxalLWd17QuRbGcUdDsW12
 EnslVZs9fCktVkl1nANlhN2ophpCrTunrWdcaxLIk9kfyxLKMoy9OIHEjRBt6884xOqH
 9cM8sx/madmb1/0IUz/maZoqtzrvhuOk5UqyZzFfvWDsqJN2plxONSAoCwvPKqvlAoO6
 gQ4wws3zvmYZoEO8gIPAlDDtrraTbBG985Fl/DeFEkFdSrqsg2ajuwTQYWj9PpWuyC34
 Lghg==
X-Gm-Message-State: AOAM5333wNrFvuCDeZENOG+iOaZPzHwRZQI0AIvFkMHYzVL7w1X4SUSL
 6ofaxEup1cEUEMjse7G4FOPCvvAyWftSAMco1JI=
X-Google-Smtp-Source: ABdhPJy9SDAXtfrqtid4Hgf/WmX56bcIzMX0hLwcVyFTihSbcDK6SFjwAfBNq9cDuyKpg4C7ydYrGf9glnfzwN5MZwk=
X-Received: by 2002:a17:90a:1b23:: with SMTP id
 q32mr16831579pjq.181.1613399982663; 
 Mon, 15 Feb 2021 06:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20210215142137.64476-1-andriy.shevchenko@linux.intel.com>
 <43456ba7-c372-84cc-4949-dcb817188e21@amd.com>
In-Reply-To: <43456ba7-c372-84cc-4949-dcb817188e21@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Feb 2021 16:39:26 +0200
Message-ID: <CAHp75VfVXnqdVRAPQ36vZeD-ZMCjWmjA_-6T=jnOEVMne4bv0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] string: Consolidate yesno() helpers under string.h
 hood
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Petr Mladek <pmladek@suse.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Approved-At: Mon, 15 Feb 2021 14:54:26 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Francis Laniel <laniel_francis@privacyrequired.com>,
 Mikita Lipski <mikita.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 Jakub Kicinski <kuba@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, intel-gfx <intel-gfx@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Eryk Brol <eryk.brol@amd.com>, netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Raju Rangoju <rajur@chelsio.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

K0NjOiBTYWthcmkgYW5kIHByaW50ayBwZW9wbGUKCk9uIE1vbiwgRmViIDE1LCAyMDIxIGF0IDQ6
MjggUE0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToK
PiBBbSAxNS4wMi4yMSB1bSAxNToyMSBzY2hyaWViIEFuZHkgU2hldmNoZW5rbzoKPiA+IFdlIGhh
dmUgYWxyZWFkeSBmZXcgc2ltaWxhciBpbXBsZW1lbnRhdGlvbiBhbmQgYSBsb3Qgb2YgY29kZSB0
aGF0IGNhbiBiZW5lZml0Cj4gPiBvZiB0aGUgeWVzbm8oKSBoZWxwZXIuICBDb25zb2xpZGF0ZSB5
ZXNubygpIGhlbHBlcnMgdW5kZXIgc3RyaW5nLmggaG9vZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KPgo+
IExvb2tzIGxpa2UgYSBnb29kIGlkZWEgdG8gbWUsIGZlZWwgZnJlZSB0byBhZGQgYW4gQWNrZWQt
Ynk6IENocmlzdGlhbgo+IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB0byB0aGUg
c2VyaWVzLgoKVGhhbmtzLgoKPiBCdXQgbG9va2luZyBhdCB0aGUgdXNlIGNhc2VzIGZvciB0aGlz
LCB3b3VsZG4ndCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8KPiB0ZWFjaCBrcHJpbnRmIHNvbWUgbmV3
IGZvcm1hdCBtb2RpZmllciBmb3IgdGhpcz8KCkFzIGEgbmV4dCBzdGVwPyBJSVJDIFNha2FyaSBo
YXMgYXQgc29tZSBwb2ludCB0aGUgc2VyaWVzIGNvbnZlcnRlZAp5ZXNubyBhbmQgQ28uIHRvIHNv
bWV0aGluZyB3aGljaCBJIGRvbid0IHJlbWVtYmVyIHRoZSBkZXRhaWxzIG9mLgoKR3V5cywgd2hh
dCBkbyB5b3UgdGhpbms/CgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
