Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A494CA9EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 08:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDA8206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 08:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDA8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D9C6E911;
	Fri, 25 Oct 2019 08:12:43 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5126E890
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 03:38:11 +0000 (UTC)
Received: by mail-pf1-x441.google.com with SMTP id y5so625481pfo.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 20:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=9xlnRxbz5e5Gec4it5mCjsOFIOEz65fy9CE22wHzOHQ=;
 b=mKLmyiT0oXCTJ+FB0gcbKWf979WRwpAURm5uW7vJoAR4lBFWwIs62D/aZcDwCgGRrg
 YHtSNrCm8SAQnaKt3UdJgkEo+GgpWfw/W0llI7ItcRXyHZ6+kSFn5X/paAZyNCtybX5M
 1R4hXtAS0xXNrMh7k0owG2RB5joTzPgLWoDEz0ke0j0ypl3vsuspSSbhL/DiORLzwvtz
 BPY52i6DJxkMFkotE1WBWeO94in43JKVBdUfE5d2t0PCe04sJLjtqY4+/YarHivLSWig
 zqrTBSnIfHp9GXJIZlUcAbWYUUrtBeiLTjSVW2HIIgEM1rMY2c9tlE/eB12g0RgF4p+X
 0fdA==
X-Gm-Message-State: APjAAAVbU06C+Xg3au4SiVWTwrKwH67u7BrGLIJslt1FIJROAnVjmePH
 Uc+7oW9xu/4mJtS+rYp3zL8=
X-Google-Smtp-Source: APXvYqyiLM+oYDg3f2Jq7wws+N6/oo+jeyQ0Wa3flDhDafSNAtI9iFsg2mHpQeFMm1XG42nR0yF/+Q==
X-Received: by 2002:a63:5909:: with SMTP id n9mr1674233pgb.101.1571974690423; 
 Thu, 24 Oct 2019 20:38:10 -0700 (PDT)
Received: from wambui ([197.254.95.2])
 by smtp.gmail.com with ESMTPSA id p36sm489777pgm.55.2019.10.24.20.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 20:38:09 -0700 (PDT)
Date: Fri, 25 Oct 2019 06:37:58 +0300
From: Wambui Karuga <wambui.karugax@gmail.com>
To: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: make undeclared variables static
Message-ID: <20191025033758.GA3201@wambui>
References: <20191019072426.20535-1-wambui@karuga.xyz>
 <0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Mailman-Approved-At: Fri, 25 Oct 2019 08:12:41 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9xlnRxbz5e5Gec4it5mCjsOFIOEz65fy9CE22wHzOHQ=;
 b=CDIFeZOvtLPMpAoNRpBSSxesK+l4qgc4U4YJQyQQFRn+kMT/tvB+L9xj4psbgj2sDo
 jvOyeTnKCY5Vdkg5ynMXnsCtSKfprt3GCdB2NRnSoe2T+IxxvwlLyHXqHj3uvjvAW4F5
 ExGae8XSp41dxXQYNOqY6m2LQCiWzwvNniKSNN5qH6deGsbFfUlkcIRXEmg+mGxtKF82
 d1dxKP+ae6/4tChL5rR4QPJdUUQczwdtcNxy06WIyZet1a5+MyprNMT0ETqgWRwc/w2w
 WhQXeaeDtgGzZ5CJxDdVnzIHgWKhTxUugvVNzldb875Rv/64nZNe2emrO5YznZ5wltgZ
 8LFA==
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
Reply-To: 0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025033758.PWXYlRvggHK12NJZq58IO_FjxS8YwVI8O18T7dWmb2o@z>

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMDM6MDk6MzRQTSArMDAwMCwgSGFycnkgV2VudGxhbmQg
d3JvdGU6Cj4gT24gMjAxOS0xMC0xOSAzOjI0IGEubS4sIFdhbWJ1aSBLYXJ1Z2Egd3JvdGU6Cj4g
PiBNYWtlIHRoZSBgYW1kZ3B1X2xvY2t1cF90aW1lb3V0YCBhbmQgYGFtZGdwdV9leHBfaHdfc3Vw
cG9ydGAgdmFyaWFibGVzCj4gPiBzdGF0aWMgdG8gcmVtb3ZlIHRoZSBmb2xsb3dpbmcgc3BhcnNl
IHdhcm5pbmdzOgo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jOjEw
MzoxOTogd2FybmluZzogc3ltYm9sICdhbWRncHVfbG9ja3VwX3RpbWVvdXQnIHdhcyBub3QgZGVj
bGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/Cj4gCj4gVGhpcyBzaG91bGQgYmUgZGVjbGFyZWQg
aW4gYW1kZ3B1LmguIGFtZGdwdSBpcyBtYWludGFpbmVkIG9uIHRoZQo+IGFtZC1zdGFnaW5nLWRy
bS1uZXh0IGJyYW5jaCBmcm9tCj4gaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYv
bGludXgvP2g9YW1kLXN0YWdpbmctZHJtLW5leHQuIENhbgo+IHlvdSBjaGVjayB0aGVyZT8KPiAK
SGV5IEhhcnJ5LApJIGNoZWNrZWQgdGhlIGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5jaCwgYW5k
ICdhbWRncHVfbG9ja3VwX3RpbWVvdXQnCmlzIGFscmVhZHkgZGVjbGFyZWQgYXMgZXh0ZXJuIGlu
IGFtZGdwdS5oLCBzbyBzcGFyc2Ugb25seSB3YXJucyBhYm91dAonYW1kZ3B1X2V4cF9od19zdXBw
b3J0Jy4gCkknbGwgZG8gdGhlIHNhbWUgZm9yICdhbWRncHVfZXhwX2h3X3N1cHBvcnQnIGFuZCBz
ZW5kIGFuIHVwZGF0ZSBwYXRjaApzZXJpZXMgZm9yIHRoaXMgYW5kIHRoZSAiX0xFTlRIIiBtaXNw
ZWxsaW5nLgoKVGhhbmtzLAp3YW1idWkga2FydWdhCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmM6MTE3OjE4OiB3YXJuaW5nOiBzeW1ib2wgJ2FtZGdwdV9leHBfaHdf
c3VwcG9ydCcgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KPiA+IAo+ID4g
U2lnbmVkLW9mZi1ieTogV2FtYnVpIEthcnVnYSA8d2FtYnVpQGthcnVnYS54eXo+Cj4gPiAtLS0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCA0ICsrLS0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gPiBpbmRleCAzZmFlMTAw
NzE0M2UuLmM1YjNjMGM5MTkzYiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jCj4gPiBAQCAtMTAwLDcgKzEwMCw3IEBAIGludCBhbWRncHVfZGlzcF9wcmlv
cml0eSA9IDA7Cj4gPiAgaW50IGFtZGdwdV9od19pMmMgPSAwOwo+ID4gIGludCBhbWRncHVfcGNp
ZV9nZW4yID0gLTE7Cj4gPiAgaW50IGFtZGdwdV9tc2kgPSAtMTsKPiA+IC1jaGFyIGFtZGdwdV9s
b2NrdXBfdGltZW91dFtBTURHUFVfTUFYX1RJTUVPVVRfUEFSQU1fTEVOVEhdOwo+ID4gK3N0YXRp
YyBjaGFyIGFtZGdwdV9sb2NrdXBfdGltZW91dFtBTURHUFVfTUFYX1RJTUVPVVRfUEFSQU1fTEVO
VEhdOwo+ID4gIGludCBhbWRncHVfZHBtID0gLTE7Cj4gPiAgaW50IGFtZGdwdV9md19sb2FkX3R5
cGUgPSAtMTsKPiA+ICBpbnQgYW1kZ3B1X2FzcG0gPSAtMTsKPiA+IEBAIC0xMTQsNyArMTE0LDcg
QEAgaW50IGFtZGdwdV92bV9ibG9ja19zaXplID0gLTE7Cj4gPiAgaW50IGFtZGdwdV92bV9mYXVs
dF9zdG9wID0gMDsKPiA+ICBpbnQgYW1kZ3B1X3ZtX2RlYnVnID0gMDsKPiA+ICBpbnQgYW1kZ3B1
X3ZtX3VwZGF0ZV9tb2RlID0gLTE7Cj4gPiAtaW50IGFtZGdwdV9leHBfaHdfc3VwcG9ydCA9IDA7
Cj4gPiArc3RhdGljIGludCBhbWRncHVfZXhwX2h3X3N1cHBvcnQ7Cj4gCj4gVGhpcyBpcyBpbmRl
ZWQgb25seSB1c2VkIGluIHRoaXMgZmlsZSBidXQgZm9yIGNvbnNpc3RlbmN5J3Mgc2FrZSBpdCdz
Cj4gcHJvYmFibHkgYmV0dGVyIHRvIGFsc28gZGVjbGFyZSBpdCBpbiBhbWRncHUuaCByYXRoZXIg
dGhhbiBtYWtlIGl0Cj4gc3RhdGljIGhlcmUuCj4gCj4gSGFycnkKPiAKPiA+ICBpbnQgYW1kZ3B1
X2RjID0gLTE7Cj4gPiAgaW50IGFtZGdwdV9zY2hlZF9qb2JzID0gMzI7Cj4gPiAgaW50IGFtZGdw
dV9zY2hlZF9od19zdWJtaXNzaW9uID0gMjsKPiA+IApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
