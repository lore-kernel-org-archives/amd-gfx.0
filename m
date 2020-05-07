Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B14C54E49
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 19:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C06720CC7
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 19:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPr+dIxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C06720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911556E0AC;
	Thu,  7 May 2020 19:30:32 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7316E0AC;
 Thu,  7 May 2020 19:30:31 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id x4so7813927wmj.1;
 Thu, 07 May 2020 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jGYOOG4S+IK7R44bCL3+15LUjSoFWbm06GQmQafymao=;
 b=BPr+dIxCL0jDNcVQt3hNyJAuVwcsOxXmOs9FqE3yG9VpGEq+FpKGlpRBK57fBvG6F/
 aRkKHypMvY+BP6sU6lsPSWMxsi06QS5K5OyIktWb4hy6DeiW3QuUDAtULyEBeXJPK5me
 7wG8Jc7yfrxu3A0wwnvGan/lfOm0c8l0AVO73JZqjuEIxwm2O8cmUQWFyI/sg11T7hBk
 C0QaBv4El1L/Wyx4jKks4a2Wh065ei5N4uA0YQTp97/+/xzS7m83Mojs3LjdEeispGQH
 pGR8cJb4r/XTY+FVYiz/12744k8+P1XFYEmGTrVcyWrY5DcBN7T/+WtR4h0V3ulLkz9e
 9H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jGYOOG4S+IK7R44bCL3+15LUjSoFWbm06GQmQafymao=;
 b=Qr2t4No19gZekd8jzEGf35r834/uqblrnA/Ls23rUATJxfJKCodJeL+mBREF0NtC3q
 sNcqbpuBfKqAp7Eqq6Q+Zg88+MIc2dnTMpIGvkujpGuKOhOu53ejuw4D0W1NwG+UdN+2
 suiIZAJCGk0jAowNgQnNmC1aMNFrjK3WvQBd2JJXX8LhkG7lnfisaz/lWO0muWw8XcrK
 k+Im8py9Hi+9IWgMgewL4BRNjLlw74aiXqkJS4QPjUtGreXoc1dQqloSwIeHqYEHS92O
 DQ0ZCCdnY8VPEssoNlQAAAPq2Hj5YkYPwWc7JC5EQU3EaZW/lcYyZ7ogdpkr+yg92T+Z
 g0mQ==
X-Gm-Message-State: AGi0Pua26qLDD+qZ0QHmzikroW6ddTtloFoY9CRliFT3jE2E/4cZv9ot
 WhgE0HP/qDgbbaTI0CQ1azprpIGEgtHIou9+vtw=
X-Google-Smtp-Source: APiQypLnMsHWUZ6AfhRaSweuuZ87qO7HYZJOhLG/9tAmkvJKbUc1IyeP/3LjoUiO1CfjhY1d0AEiW7yO0tQ4gRzGJ04=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr11699140wma.70.1588879829872; 
 Thu, 07 May 2020 12:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200507091311.10898-1-bernard@vivo.com>
 <462b6a26-2c25-f83a-887e-6d3a30072e71@amd.com>
In-Reply-To: <462b6a26-2c25-f83a-887e-6d3a30072e71@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 15:30:18 -0400
Message-ID: <CADnq5_NfHc0FWCcANbKmDXCxF5BjcCMM6WzJzsZr=yTnhYwxJg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Tom St Denis <tom.stdenis@amd.com>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Ori Messinger <Ori.Messinger@amd.com>, opensource.kernel@vivo.com,
 David Airlie <airlied@linux.ie>, Bernard Zhao <bernard@vivo.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBNYXkgNywgMjAyMCBhdCA1OjIyIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwNy4wNS4yMCB1bSAxMToxMyBzY2hyaWVi
IEJlcm5hcmQgWmhhbzoKPiA+IFRoZXJlIGlzIERFVklDRV9BVFRSIG1lY2hhbmlzbSBpbiBzZXBh
cmF0ZSBhdHRyaWJ1dGUgZGVmaW5lLgo+ID4gU28gdGhpcyBjaGFuZ2UgaXMgdG8gdXNlIGF0dHIg
YXJyYXksIGFsc28gdXNlCj4gPiBzeXNmc19jcmVhdGVfZmlsZXMgaW4gaW5pdCBmdW5jdGlvbiAm
IHN5c2ZzX3JlbW92ZV9maWxlcyBpbgo+ID4gZmluaSBmdW5jdGlvbi4KPiA+IFRoaXMgbWF5YmUg
bWFrZSB0aGUgY29kZSBhIGJpdCByZWFkYWJsZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBCZXJu
YXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+CgpBcHBsaWVkIHdpdGggYSBtaW5vciBj
aGFuZ2UgdG8gbWFrZSB0aGUgYXJyYXkgY29uc3QgdG8gZml4IHRoZSBidWlsZC4KCkFsZXgKCj4g
Pgo+ID4gQ2hhbmdlcyBzaW5jZSBWMToKPiA+ICpVc2UgREVWSUNFX0FUVFIgbWVjaGFuaXNtCj4g
Pgo+ID4gTGluayBmb3IgVjE6Cj4gPiAqaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGcGF0Y2h3
b3JrJTJGcGF0Y2glMkYxMjI4MDc2JTJGJmFtcDtkYXRhPTAyJTdDMDElN0NjaHJpc3RpYW4ua29l
bmlnJTQwYW1kLmNvbSU3QzA3M2I5MDQzYmU1MzQ2YjNjOTBjMDhkN2YyNjZlNmZiJTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzI0NDM5NjA5NjczNTIyMyZh
bXA7c2RhdGE9UGpGc1l2bXcycHZWaXNaNlR6TXFPeW9TcjBtM0RzRk4lMkYwcSUyQiUyRmZCeEFD
ZyUzRCZhbXA7cmVzZXJ2ZWQ9MAo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92cmFtX21nci5jIHwgNDMgKysrKysrLS0tLS0tLS0tLS0tLS0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4gPiBpbmRleCA4
MmEzMjk5ZTUzYzAuLjU3YmJjNzA2NjJmZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+ID4gQEAgLTE0OCw2ICsxNDgsMTUgQEAgc3Rh
dGljIERFVklDRV9BVFRSKG1lbV9pbmZvX3Zpc192cmFtX3VzZWQsIFNfSVJVR08sCj4gPiAgIHN0
YXRpYyBERVZJQ0VfQVRUUihtZW1faW5mb192cmFtX3ZlbmRvciwgU19JUlVHTywKPiA+ICAgICAg
ICAgICAgICAgICAgYW1kZ3B1X21lbV9pbmZvX3ZyYW1fdmVuZG9yLCBOVUxMKTsKPiA+Cj4gPiAr
c3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmFtZGdwdV92cmFtX21ncl9hdHRyaWJ1dGVzW10gPSB7
Cj4gPiArICAgICAmZGV2X2F0dHJfbWVtX2luZm9fdnJhbV90b3RhbC5hdHRyLAo+ID4gKyAgICAg
JmRldl9hdHRyX21lbV9pbmZvX3Zpc192cmFtX3RvdGFsLmF0dHIsCj4gPiArICAgICAmZGV2X2F0
dHJfbWVtX2luZm9fdnJhbV91c2VkLmF0dHIsCj4gPiArICAgICAmZGV2X2F0dHJfbWVtX2luZm9f
dmlzX3ZyYW1fdXNlZC5hdHRyLAo+ID4gKyAgICAgJmRldl9hdHRyX21lbV9pbmZvX3ZyYW1fdmVu
ZG9yLmF0dHIsCj4gPiArICAgICBOVUxMCj4gPiArfTsKPiA+ICsKPiA+ICAgLyoqCj4gPiAgICAq
IGFtZGdwdV92cmFtX21ncl9pbml0IC0gaW5pdCBWUkFNIG1hbmFnZXIgYW5kIERSTSBNTQo+ID4g
ICAgKgo+ID4gQEAgLTE3MiwzMSArMTgxLDkgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3Jf
aW5pdChzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXIgKm1hbiwKPiA+ICAgICAgIG1hbi0+cHJp
diA9IG1ncjsKPiA+Cj4gPiAgICAgICAvKiBBZGQgdGhlIHR3byBWUkFNLXJlbGF0ZWQgc3lzZnMg
ZmlsZXMgKi8KPiA+IC0gICAgIHJldCA9IGRldmljZV9jcmVhdGVfZmlsZShhZGV2LT5kZXYsICZk
ZXZfYXR0cl9tZW1faW5mb192cmFtX3RvdGFsKTsKPiA+IC0gICAgIGlmIChyZXQpIHsKPiA+IC0g
ICAgICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIGRldmljZSBmaWxlIG1lbV9p
bmZvX3ZyYW1fdG90YWxcbiIpOwo+ID4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gLSAg
ICAgfQo+ID4gLSAgICAgcmV0ID0gZGV2aWNlX2NyZWF0ZV9maWxlKGFkZXYtPmRldiwgJmRldl9h
dHRyX21lbV9pbmZvX3Zpc192cmFtX3RvdGFsKTsKPiA+IC0gICAgIGlmIChyZXQpIHsKPiA+IC0g
ICAgICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIGRldmljZSBmaWxlIG1lbV9p
bmZvX3Zpc192cmFtX3RvdGFsXG4iKTsKPiA+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsKPiA+
IC0gICAgIH0KPiA+IC0gICAgIHJldCA9IGRldmljZV9jcmVhdGVfZmlsZShhZGV2LT5kZXYsICZk
ZXZfYXR0cl9tZW1faW5mb192cmFtX3VzZWQpOwo+ID4gLSAgICAgaWYgKHJldCkgewo+ID4gLSAg
ICAgICAgICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byBjcmVhdGUgZGV2aWNlIGZpbGUgbWVtX2lu
Zm9fdnJhbV91c2VkXG4iKTsKPiA+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsKPiA+IC0gICAg
IH0KPiA+IC0gICAgIHJldCA9IGRldmljZV9jcmVhdGVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0
cl9tZW1faW5mb192aXNfdnJhbV91c2VkKTsKPiA+IC0gICAgIGlmIChyZXQpIHsKPiA+IC0gICAg
ICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIGRldmljZSBmaWxlIG1lbV9pbmZv
X3Zpc192cmFtX3VzZWRcbiIpOwo+ID4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gLSAg
ICAgfQo+ID4gLSAgICAgcmV0ID0gZGV2aWNlX2NyZWF0ZV9maWxlKGFkZXYtPmRldiwgJmRldl9h
dHRyX21lbV9pbmZvX3ZyYW1fdmVuZG9yKTsKPiA+IC0gICAgIGlmIChyZXQpIHsKPiA+IC0gICAg
ICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIGRldmljZSBmaWxlIG1lbV9pbmZv
X3ZyYW1fdmVuZG9yXG4iKTsKPiA+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsKPiA+IC0gICAg
IH0KPiA+ICsgICAgIHJldCA9IHN5c2ZzX2NyZWF0ZV9maWxlcygmYWRldi0+ZGV2LT5rb2JqLCBh
bWRncHVfdnJhbV9tZ3JfYXR0cmlidXRlcyk7Cj4gPiArICAgICBpZiAocmV0KQo+ID4gKyAgICAg
ICAgICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byByZWdpc3RlciBzeXNmc1xuIik7Cj4gPgo+ID4g
ICAgICAgcmV0dXJuIDA7Cj4gPiAgIH0KPiA+IEBAIC0yMTksMTEgKzIwNiw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3ZyYW1fbWdyX2Zpbmkoc3RydWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4p
Cj4gPiAgICAgICBzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKPiA+ICAgICAgIGtmcmVlKG1ncik7
Cj4gPiAgICAgICBtYW4tPnByaXYgPSBOVUxMOwo+ID4gLSAgICAgZGV2aWNlX3JlbW92ZV9maWxl
KGFkZXYtPmRldiwgJmRldl9hdHRyX21lbV9pbmZvX3ZyYW1fdG90YWwpOwo+ID4gLSAgICAgZGV2
aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX21lbV9pbmZvX3Zpc192cmFtX3Rv
dGFsKTsKPiA+IC0gICAgIGRldmljZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0cl9t
ZW1faW5mb192cmFtX3VzZWQpOwo+ID4gLSAgICAgZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRl
diwgJmRldl9hdHRyX21lbV9pbmZvX3Zpc192cmFtX3VzZWQpOwo+ID4gLSAgICAgZGV2aWNlX3Jl
bW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX21lbV9pbmZvX3ZyYW1fdmVuZG9yKTsKPiA+
ICsgICAgIHN5c2ZzX3JlbW92ZV9maWxlcygmYWRldi0+ZGV2LT5rb2JqLCBhbWRncHVfdnJhbV9t
Z3JfYXR0cmlidXRlcyk7Cj4gPiAgICAgICByZXR1cm4gMDsKPiA+ICAgfQo+ID4KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
