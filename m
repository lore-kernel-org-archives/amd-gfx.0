Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3DC17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 10:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023542196E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 10:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023542196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A088B6E3F9;
	Tue, 12 Nov 2019 10:25:22 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1E26E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 10:25:21 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id s5so6776012wrw.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 02:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=Mk6dFb9/pJd0UP5k0AF2KbHaDFy6ZxNbIkbNhhv4vzA=;
 b=jpzC2xUvt1ThvZIjZX7aKhaZRVeaHs28ztMis71RCPFKIQZGmZkZc8EW8AmML+nIu1
 ALFoxwg26Dgja/ws/mUGbTBe5BQA4DpZJu27t90eD+bLWrrN7OCT/BiX3+m5nWZT+FkS
 6yX04jqc4DxgTBQDe4oYXzeyZtQUXuYznG/P9ujaqI36r7npI4ZiUFwzE0eZwKS/ay7X
 1ALwPOuvXzjVvX9PdsAknsGou0XIfiXa3zUUB3NFWW0RcfYVzHUC914PYlhqSdC+kaS8
 kJHYd/Ebh6LldsBqZmb9X+tNuc0rah9Uf103Mbn19KGQBCowHAPnkdyhwzNkuOOB9tl/
 ApHQ==
X-Gm-Message-State: APjAAAVkCNBGPunNjd2BSVjbpAHbLwvZsC/LaZaiWdjatKkaw86ZImFs
 ogIxJDzDiKTa9VbM2PldoXEY8w==
X-Google-Smtp-Source: APXvYqz7n1u7/NVrftcrdHatXUEakeJUwfaVv4vvwsCLQjU5aRKh4GyPqffrJGIIQj7nSNlCy4B6yQ==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr11791046wrj.334.1573554320362; 
 Tue, 12 Nov 2019 02:25:20 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net.
 [212.51.149.96])
 by smtp.gmail.com with ESMTPSA id m25sm2186392wmi.46.2019.11.12.02.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 02:25:19 -0800 (PST)
Date: Tue, 12 Nov 2019 11:25:17 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/4] drm/ttm: refine ghost BO resv criteria
Message-ID: <20191112102517.GI23790@phenom.ffwll.local>
References: <20191111145832.37320-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111145832.37320-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent;
 bh=Mk6dFb9/pJd0UP5k0AF2KbHaDFy6ZxNbIkbNhhv4vzA=;
 b=VSLjAbBEC/revxRGe/X6ZP80Yfeenq0fbAYdsEe0Ia4b432gbA1JfFXBSJqjnptST5
 fqcJjOqwkPNwKpSV0wopskHHUXj9jbeMdjxJuCsNnH9jEFPd0EgCoNBmXba2DDBg1+dg
 HeecFAVS5fxjUWXGhPCQbkusj9cbXYaUSfITQ=
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
Cc: Kevin1.Wang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112102517.foe-g1FPZ8x_BLB0QMcv3SFz5PXNMMYB72Jdj1TkU0A@z>

T24gTW9uLCBOb3YgMTEsIDIwMTkgYXQgMDM6NTg6MjlQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBHaG9zdCBCT3MgbmVlZCB0byBzdGljayB3aXRoIHRoZSByZXN2IG9iamVjdCBv
bmx5IHdoZW4gdGhlIG9yaWdpbiBpcyBpbXBvcnRlZC4KPiAKPiBUaGlzIGlzIGEgbG93IGhhbmdp
bmcgZnJ1aXQgdG8gYXZvaWQgT09NIHNpdHVhdGlvbnMgb24gZXZpY3Rpb25zLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkkg
Z3Vlc3MgSSBzdGlsbCBkb24ndCBnZXQgd2hhdCBnaG9zdCBvYmplY3RzIGFsbCBkbyBhbmQgY2F1
c2UgLi4uIEhvdyBkb2VzCnRoaXMgbGVhZCB0byBPT00gY2FzZXMgd2hlcmUgdGhlIGV2aWN0aW9u
IGNhbid0IGZpbmQgbWVtb3J5IGFueW1vcmU/Ci1EYW5pZWwKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvX3V0aWwuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3V0aWwuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYwo+IGlu
ZGV4IDJiMGU1YTA4OGRhMC4uODZkMTUyNDcyZjM4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvX3V0aWwuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2Jv
X3V0aWwuYwo+IEBAIC01MTEsNyArNTExLDcgQEAgc3RhdGljIGludCB0dG1fYnVmZmVyX29iamVj
dF90cmFuc2ZlcihzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAJa3JlZl9pbml0KCZm
Ym8tPmJhc2Uua3JlZik7Cj4gIAlmYm8tPmJhc2UuZGVzdHJveSA9ICZ0dG1fdHJhbnNmZXJlZF9k
ZXN0cm95Owo+ICAJZmJvLT5iYXNlLmFjY19zaXplID0gMDsKPiAtCWlmIChiby0+YmFzZS5yZXN2
ID09ICZiby0+YmFzZS5fcmVzdikKPiArCWlmIChiby0+dHlwZSAhPSB0dG1fYm9fdHlwZV9zZykK
PiAgCQlmYm8tPmJhc2UuYmFzZS5yZXN2ID0gJmZiby0+YmFzZS5iYXNlLl9yZXN2Owo+ICAKPiAg
CWRtYV9yZXN2X2luaXQoJmZiby0+YmFzZS5iYXNlLl9yZXN2KTsKPiAtLSAKPiAyLjE3LjEKPiAK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKCi0t
IApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRw
Oi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
