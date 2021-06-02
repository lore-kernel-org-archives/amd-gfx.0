Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B381C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8B2610CB
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8B2610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFF36EB52;
	Wed,  2 Jun 2021 02:10:40 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9848B6EB52;
 Wed,  2 Jun 2021 02:10:39 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id x15so1249523oic.13;
 Tue, 01 Jun 2021 19:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NcO1usTOKbaR3rWsTNsRVfXwWTgve8HOLpfInMO7jOg=;
 b=stwjulCJ/ezQ81/3ev84sUD1Herx16tkPjrGfAC4klYBObtf4nW6dsCWcWEVmHOEQM
 9C/nt8fTtGL0ylO2WX3SHUzzQert+vvwvA1QE3RoRzzYgnOh9LThqXneewVZQJzmIe9A
 +pfn5eBJDHpeKyoapttvmYrhPXW2eSDA6inwlTagJ6KipEXaCKbasMUncoTBEDdPuB7v
 7+gC2PHJIyjhqklE0wodXnQ1AY5h/HuczYbrLoYZ0fMcFZipJzI96klhjGQQxgWdFmpx
 QCW0M+A3mIArXSbsQaNA2V+7NRvJaZ0juQtoyO9+BP0FSPRo+m0ot+LvdoY3E42/Lgau
 7i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NcO1usTOKbaR3rWsTNsRVfXwWTgve8HOLpfInMO7jOg=;
 b=RuOICVupnodear++q9OZXW0nynxJLZmvV1B9oMImSGsaLEiu50rGf7949jx7WRRnUt
 kvdT0Lb4siTdYDj3XmPDl6Rg/0dr+3WKI0nfhFwEfJEy0FrH9kLa1TEhpQBdbkAmMePQ
 PjqpaxKgc4LM9UJmMWEeMniiq/8EFWDopIlQLMEV0TJSYRzvsuNa74n0ioXJUkW/UOms
 JrudN2GliMusKCl3DoTDCU6ZkMtYtKpkWqMFk/GiD7riHjZsvMIa+kjub+kzbUgt8/KE
 fg7/9EBtH4vzeAMJFDYAh7y2sQgy/N0OoIEzsWKYoFANtOjEk6gKT9YSNWz7GYt6+WQL
 qPyg==
X-Gm-Message-State: AOAM532lWPBc3F8PkJvBpr5tCMkBiatcdvvmz6tJbpo9D7OeDjgoSG5M
 MxvV9By16ZuYpfjAuLAF21EWoRSzFdSuJDDBhV67J2TZ
X-Google-Smtp-Source: ABdhPJz5WcC84uOEnyxWV+Hz6xl4AOEOsIx+R3/ZGWzYiqB/HKGc6k5jSWbYXvnBwF1Su+E93seRlnSt/54viidHYSY=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr19934254oiw.123.1622599838843; 
 Tue, 01 Jun 2021 19:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210601081400.123089-1-libaokun1@huawei.com>
In-Reply-To: <20210601081400.123089-1-libaokun1@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 22:10:27 -0400
Message-ID: <CADnq5_NuuogmYcmTDofwt0txUHJhx1EJvseeUWwQdq39z74MCw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAtbmV4dF0gZHJtL2FtZC9kaXNwbGF5OiBmaXggd2FybmluZzog4oCYdQ==?=
 =?UTF-8?B?cGRhdGVfZHNjX2NhcHPigJkgYW5kIOKAmGFwcGx5X2RzY19wb2xpY3lfZm9yX3N0cmVhbeKAmSBkZWZp?=
 =?UTF-8?B?bmVkIGJ1dCBub3QgdXNlZA==?=
To: Baokun Li <libaokun1@huawei.com>
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
Cc: Wayne Lin <Wayne.Lin@amd.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 YueHaibing <yuehaibing@huawei.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 xinhui pan <Xinhui.Pan@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>, Dave Airlie <airlied@linux.ie>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Wei Yongjun <weiyongjun1@huawei.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, yu kuai <yukuai3@huawei.com>,
 yangjihong1@huawei.com, Nikola Cornij <nikola.cornij@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFR1ZSwgSnVuIDEsIDIwMjEgYXQgNDowNCBBTSBCYW9rdW4g
TGkgPGxpYmFva3VuMUBodWF3ZWkuY29tPiB3cm90ZToKPgo+IEZpeGVzIGdjYyAnLVd1bnVzZWQt
ZnVuY3Rpb24nIHdhcm5pbmc6Cj4KPiDigJh1cGRhdGVfZHNjX2NhcHPigJkgYW5kIOKAmGFwcGx5
X2RzY19wb2xpY3lfZm9yX3N0cmVhbeKAmSBhcmUgb25seSB1c2VkCj4gaWYgJ0NPTkZJR19EUk1f
QU1EX0RDX0RDTicgaXMgZGVmaW5lZCwKPgo+IGhvd2V2ZXIsIGl0J3MgZGVmaW5lZCBldmVuIGlm
ICdDT05GSUdfRFJNX0FNRF9EQ19EQ04nIGlzIG5vdCBkZWZpbmVkLgo+IFRodXMgZ2NjIHdpbGwg
cmVwb3J0IGZvbGxvd2luZyB3YXJuaW5nCj4gaWYgJ0NPTkZJR19EUk1fQU1EX0RDX0RDTicgaXMg
bm90IGRlZmluZWQ6Cj4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYzo1NTcyOjEzOiB3YXJuaW5nOgo+IOKAmGFwcGx5X2RzY19wb2xp
Y3lfZm9yX3N0cmVhbeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25d
Cj4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYzo1NTU2OjEzOiB3YXJuaW5nOgo+IOKAmHVwZGF0ZV9kc2NfY2Fwc+KAmSBkZWZpbmVk
IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dCj4KPiBUaHVzIG1vdmUgdGhlIGRlZmlu
aXRpb24gb2Yg4oCYdXBkYXRlX2RzY19jYXBz4oCZIGFuZAo+IOKAmGFwcGx5X2RzY19wb2xpY3lf
Zm9yX3N0cmVhbeKAmSBpbnNpZGUgZGVmaW5lIG1hY3JvIHRvIGZpeCBpdC4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEJhb2t1biBMaSA8bGliYW9rdW4xQGh1YXdlaS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA2ICsrLS0tLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gaW5k
ZXggZjBhZGZkYTMyMjEzLi5lMGFmMzk0MTAzYWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtNTU1Myw2ICs1NTUz
LDcgQEAgc3RhdGljIHZvaWQgZG1fZW5hYmxlX3Blcl9mcmFtZV9jcnRjX21hc3Rlcl9zeW5jKHN0
cnVjdCBkY19zdGF0ZSAqY29udGV4dCkKPiAgICAgICAgIH0KPiAgfQo+Cj4gKyNpZiBkZWZpbmVk
KENPTkZJR19EUk1fQU1EX0RDX0RDTikKPiAgc3RhdGljIHZvaWQgdXBkYXRlX2RzY19jYXBzKHN0
cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRjX3NpbmsgKnNp
bmssIHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbSwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkc2NfZGVjX2RwY2Rf
Y2FwcyAqZHNjX2NhcHMpCj4gQEAgLTU1NjAsMTIgKzU1NjEsMTAgQEAgc3RhdGljIHZvaWQgdXBk
YXRlX2RzY19jYXBzKHN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAo+ICAg
ICAgICAgc3RyZWFtLT50aW1pbmcuZmxhZ3MuRFNDID0gMDsKPgo+ICAgICAgICAgaWYgKGFjb25u
ZWN0b3ItPmRjX2xpbmsgJiYgc2luay0+c2lua19zaWduYWwgPT0gU0lHTkFMX1RZUEVfRElTUExB
WV9QT1JUKSB7Cj4gLSNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikKPiAgICAgICAg
ICAgICAgICAgZGNfZHNjX3BhcnNlX2RzY19kcGNkKGFjb25uZWN0b3ItPmRjX2xpbmstPmN0eC0+
ZGMsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY29ubmVjdG9yLT5k
Y19saW5rLT5kcGNkX2NhcHMuZHNjX2NhcHMuZHNjX2Jhc2ljX2NhcHMucmF3LAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWNvbm5lY3Rvci0+ZGNfbGluay0+ZHBjZF9j
YXBzLmRzY19jYXBzLmRzY19icmFuY2hfZGVjb2Rlcl9jYXBzLnJhdywKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRzY19jYXBzKTsKPiAtI2VuZGlmCj4gICAgICAgICB9
Cj4gIH0KPgo+IEBAIC01NTc4LDcgKzU1NzcsNiBAQCBzdGF0aWMgdm9pZCBhcHBseV9kc2NfcG9s
aWN5X2Zvcl9zdHJlYW0oc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IsCj4K
PiAgICAgICAgIGxpbmtfYmFuZHdpZHRoX2ticHMgPSBkY19saW5rX2JhbmR3aWR0aF9rYnBzKGFj
b25uZWN0b3ItPmRjX2xpbmssCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkY19saW5rX2dldF9saW5rX2NhcChhY29ubmVjdG9yLT5kY19s
aW5rKSk7Cj4gLSNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikKPiAgICAgICAgIC8q
IFNldCBEU0MgcG9saWN5IGFjY29yZGluZyB0byBkc2NfY2xvY2tfZW4gKi8KPiAgICAgICAgIGRj
X2RzY19wb2xpY3lfc2V0X2VuYWJsZV9kc2Nfd2hlbl9ub3RfbmVlZGVkKAo+ICAgICAgICAgICAg
ICAgICBhY29ubmVjdG9yLT5kc2Nfc2V0dGluZ3MuZHNjX2ZvcmNlX2VuYWJsZSA9PSBEU0NfQ0xL
X0ZPUkNFX0VOQUJMRSk7Cj4gQEAgLTU2MDksOCArNTYwNyw4IEBAIHN0YXRpYyB2b2lkIGFwcGx5
X2RzY19wb2xpY3lfZm9yX3N0cmVhbShzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5l
Y3RvciwKPgo+ICAgICAgICAgaWYgKHN0cmVhbS0+dGltaW5nLmZsYWdzLkRTQyAmJiBhY29ubmVj
dG9yLT5kc2Nfc2V0dGluZ3MuZHNjX2JpdHNfcGVyX3BpeGVsKQo+ICAgICAgICAgICAgICAgICBz
dHJlYW0tPnRpbWluZy5kc2NfY2ZnLmJpdHNfcGVyX3BpeGVsID0gYWNvbm5lY3Rvci0+ZHNjX3Nl
dHRpbmdzLmRzY19iaXRzX3Blcl9waXhlbDsKPiAtI2VuZGlmCj4gIH0KPiArI2VuZGlmCj4KPiAg
c3RhdGljIHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICoKPiAgZ2V0X2hpZ2hlc3RfcmVmcmVzaF9y
YXRlX21vZGUoc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IsCj4gLS0KPiAy
LjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
