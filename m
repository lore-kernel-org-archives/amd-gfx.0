Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12DC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 08:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB1420661
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 08:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfb1lFFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB1420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA8C6E82B;
	Wed,  6 May 2020 08:11:48 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7BF6E82B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 08:11:47 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y4so1018871wrm.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 May 2020 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fLWFoCgQj22FKrTMM9R9C4pRZ5WG1HBhcRZK3Xfv7s8=;
 b=hfb1lFFmZdLE7P5luZj+H+NhkbOhPM9pNIP36GlZdDrNgvicJN99gnMG3A/COTa9AA
 Zhx47AKr+1kibyUJda2+HjIvyAKfu1XCKWXk9hOJCkTeZo3TGIn2oRaqj0hAxV85fJr3
 J4sMMz7k50RNJF+r1HdUrlIvPXFv+u2MkrRhKLVvCfWiZ/yOVSvwU+EuZ7SoddBg5K+7
 4o6oh2jEUabdggcUnOGPov8c5kL5iN2WmXZ8KAuzKT7gONq1RJ5vHx/IKmWgwnhOrBXx
 6gZ9EPEVC6MgJMHgUoDgRIHbKqrEd10JLHKXrLEN7JdvRwzhx4fvql3oBbiUz2mpwAcF
 E4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fLWFoCgQj22FKrTMM9R9C4pRZ5WG1HBhcRZK3Xfv7s8=;
 b=jUQ/NW59LpYyrZLnVf2xrAPA+6aUjxYs4og2vaZM7A8yzt8ufkUSKYXkgiXdOWd03H
 PDHRlafsVmwmh0OexKFjXakr/Xy58K1rz70ijZtvXPz6y6BEjHShrXHVv0TztAtoYOti
 VfNzrdXhNrE1983bOCl2GkRSqFd1+zbVd7yncBzR3y1VpxqueeA+8YvDnHxO+MgTa+I9
 wE1EP2w1nRmk3zgQiUXAXUDJXS3QvwcPM/CeVbUmNH2HEpgkdIQipXWOWb+TjW1Wi/S1
 a2rT4nbH4BNwKcz6XsVSZRxhva0x7g7v9aCGWJEcQFcc5oxgyHzt+MBB8xCq/pH2wTM7
 SiTw==
X-Gm-Message-State: AGi0PuYjRSf/BgK99UIewHjyqrBl5B2mnnfzyuwfxBfA7fh+1KTGLXJL
 n9xGnfgCqxtt58oiR1xm6yH7oaWT
X-Google-Smtp-Source: APiQypL78W1YTAkhomr8T95/9KZEhTbuY4kgRvzrtj626EnkDazb7j1x/O+GfM9RU2Kkq9QF/I6yCQ==
X-Received: by 2002:adf:e812:: with SMTP id o18mr8472913wrm.185.1588752706061; 
 Wed, 06 May 2020 01:11:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r2sm1709447wmg.2.2020.05.06.01.11.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 May 2020 01:11:45 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Use GEM obj reference for KFD BOs
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200506005911.21544-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9871d538-dbf9-0ed5-03ef-b2232cc83872@gmail.com>
Date: Wed, 6 May 2020 10:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200506005911.21544-1-Felix.Kuehling@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDUuMjAgdW0gMDI6NTkgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBSZWxlYXNpbmcg
dGhlIEFNREdQVSBCTyByZWYgZGlyZWN0bHkgbGVhZHMgdG8gcHJvYmxlbXMgd2hlbiBCT3Mgd2Vy
ZQo+IGV4cG9ydGVkIGFzIERNQSBidWZzLiBSZWxlYXNpbmcgdGhlIEdFTSByZWZlcmVuY2UgbWFr
ZXMgc3VyZSB0aGF0IHRoZQo+IEFNREdQVS9UVE0gQk8gaXMgbm90IGZyZWVkIHRvbyBlYXJseS4K
Pgo+IEFsc28gdGFrZSBhIEdFTSByZWZlcmVuY2Ugd2hlbiBpbXBvcnRpbmcgQk9zIGZyb20gRE1B
QnVmcyB0byBrZWVwCj4gcmVmZXJlbmNlcyB0byBpbXBvcnRlZCBCT3MgYmFsYW5jZXMgcHJvcGVy
bHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KPiBUZXN0ZWQtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgoKQWNr
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA1
ICsrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1
dm0uYwo+IGluZGV4IDEyNDc5MzhiMWVjMS4uZGE4YjMxYTUzMjkxIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IEBAIC0xMzU0
LDcgKzEzNTQsNyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUo
Cj4gICAJfQo+ICAgCj4gICAJLyogRnJlZSB0aGUgQk8qLwo+IC0JYW1kZ3B1X2JvX3VucmVmKCZt
ZW0tPmJvKTsKPiArCWRybV9nZW1fb2JqZWN0X3B1dF91bmxvY2tlZCgmbWVtLT5iby0+dGJvLmJh
c2UpOwo+ICAgCW11dGV4X2Rlc3Ryb3koJm1lbS0+bG9jayk7Cj4gICAJa2ZyZWUobWVtKTsKPiAg
IAo+IEBAIC0xNjk5LDcgKzE2OTksOCBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9pbXBvcnRf
ZG1hYnVmKHN0cnVjdCBrZ2RfZGV2ICprZ2QsCj4gICAJCXwgS0ZEX0lPQ19BTExPQ19NRU1fRkxB
R1NfV1JJVEFCTEUKPiAgIAkJfCBLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19FWEVDVVRBQkxFOwo+
ICAgCj4gLQkoKm1lbSktPmJvID0gYW1kZ3B1X2JvX3JlZihibyk7Cj4gKwlkcm1fZ2VtX29iamVj
dF9nZXQoJmJvLT50Ym8uYmFzZSk7Cj4gKwkoKm1lbSktPmJvID0gYm87Cj4gICAJKCptZW0pLT52
YSA9IHZhOwo+ICAgCSgqbWVtKS0+ZG9tYWluID0gKGJvLT5wcmVmZXJyZWRfZG9tYWlucyAmIEFN
REdQVV9HRU1fRE9NQUlOX1ZSQU0pID8KPiAgIAkJQU1ER1BVX0dFTV9ET01BSU5fVlJBTSA6IEFN
REdQVV9HRU1fRE9NQUlOX0dUVDsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
