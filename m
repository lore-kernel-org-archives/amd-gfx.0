Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC61C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 14:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E141D22EBD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 14:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E141D22EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848116E452;
	Tue, 26 Jan 2021 14:34:13 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418016E452
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 14:34:12 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id i25so7237604oie.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aDMY+beqlEr6rMqiE+ja9oJM163Ye1IJcudntU9hq8U=;
 b=tCzhOmnqly0p+hH26Tzm9zFDcGDUYGxRbLjXWmVM5TeQp1TIWr2uICALN9LSIlp+/1
 OMAeA2T2WxOerAsOAGWmLwPfjz9QcYQgXP3BRVpekHQzyVkXEmE50GW9D15s3neQswB/
 Alu4tvFR/YZZ48LSSQBFvdnN8uDdEnLy4INc5OwA18VvfeY6EINI3rX15UGPwFr16dzG
 LstEYClx5mmjqsaPse336YwojdTlha1+GFug/ew+KWdwRDGZb3MFWEBBx2EobWT49Swq
 U1VeITHKS8nqR0Qe0BgRshoc+j86I+LKD5EDnIyvOdSH48XJcgAldB40s5rJbtbdD2gn
 8rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aDMY+beqlEr6rMqiE+ja9oJM163Ye1IJcudntU9hq8U=;
 b=UAoXjpxTx8EDJEf4394da9HloxeZPUfsPaag2XhP+ei3D/wiiaQ5A/QXM2QWE+MUFX
 6sjcyPPXDVbhcl529qs+IzWxYlZG3FVj58eiA9ZAuJyiyiox4nTKRLMYgePgRJt4+XNC
 8TPfuxDR/ASqeae+0C5v8JVf5CilHyiR6sicCjjWbGBiaKrd1h5zMogvFicYCXZzMO0c
 IPnKPRSvCHrp+C6opTl2dd+RzRVBfo4YvC3sRxHuegnpD576TYGpMmKouW3OtvDPG4We
 M7h9DgUsBwAytMOJ+relvl2IYfJei6Ca9xB/miUHh2Idz1KiIPZHbxip1EfaydzSs+Rm
 pz+Q==
X-Gm-Message-State: AOAM533T1VcUC2/LXtn2cM2/SJ8uSgMysn08pujahHgFTm4D6i7h8l3E
 62J7UbUoMCI0R9PUpamA+Q3prusg21Yu5Vfddz8=
X-Google-Smtp-Source: ABdhPJy4eGGyDwcxBN/3QboqG1PY2I1FnRaEVcJ972yl26St2Gbpa1VXZKLKOSAlbWCIUGtKA9FqsFTC2Rs8jVcwvMA=
X-Received: by 2002:aca:b755:: with SMTP id h82mr3280602oif.5.1611671651524;
 Tue, 26 Jan 2021 06:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20210126143155.16479-1-ernstp@gmail.com>
In-Reply-To: <20210126143155.16479-1-ernstp@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Jan 2021 09:34:00 -0500
Message-ID: <CADnq5_MzCdBnmZ4e8PckzK7wjA7DdsRaQ35gqi=H=TJ7_OWcmw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add DC feature flag to disable audio
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKYW4gMjYsIDIwMjEgYXQgOTozMiBBTSBFcm5zdCBTasO2c3RyYW5kIDxlcm5zdHBA
Z21haWwuY29tPiB3cm90ZToKPgo+IFdpdGggdGhlIHByZS1EQyBwYXRoIHlvdSBjb3VsZCBzZXQg
YXVkaW89MCB0byBkaXNhYmxlIGF1ZGlvLgo+IFRoaXMgYWRkcyBhIHNpbWlsYXIgZmVhdHVyZSBm
b3IgdGhlIERDIHBhdGggd2l0aAo+IGFtZGdwdS5kY2ZlYXR1cmVtYXNrPTB4MTAuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBFcm5zdCBTasO2c3RyYW5kIDxlcm5zdHBAZ21haWwuY29tPgoKSXMgdGhlcmUg
YSByZWFzb24geW91IHdhbnQgdGhpcz8gIEkuZS4sIGlzIGF1ZGlvIGNhdXNpbmcgcHJvYmxlbXMg
Zm9yIHlvdT8KCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgfCAzICsrKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19yZXNvdXJjZS5jIHwgNyArKysrLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kYy5oICAgICAgICAgICAgICAgfCAxICsKPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCAgICAgICAgICB8IDEgKwo+ICA0IGZpbGVzIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGU0OTBmYzI0ODZm
Ny4uMzIyZDk0MzliOWMyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTEwMTMsNiArMTAxMyw5IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2RtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAgICAgICBp
ZiAoYW1kZ3B1X2RjX2ZlYXR1cmVfbWFzayAmIERDX0RJU0FCTEVfRlJBQ1RJT05BTF9QV01fTUFT
SykKPiAgICAgICAgICAgICAgICAgaW5pdF9kYXRhLmZsYWdzLmRpc2FibGVfZnJhY3Rpb25hbF9w
d20gPSB0cnVlOwo+Cj4gKyAgICAgICBpZiAoYW1kZ3B1X2RjX2ZlYXR1cmVfbWFzayAmIERDX0RJ
U0FCTEVfQVVESU8pCj4gKyAgICAgICAgICAgICAgIGluaXRfZGF0YS5mbGFncy5kaXNhYmxlX2F1
ZGlvID0gdHJ1ZTsKPiArCj4gICAgICAgICBpbml0X2RhdGEuZmxhZ3MucG93ZXJfZG93bl9kaXNw
bGF5X29uX2Jvb3QgPSB0cnVlOwo+Cj4gICAgICAgICBpbml0X2RhdGEuc29jX2JvdW5kaW5nX2Jv
eCA9IGFkZXYtPmRtLnNvY19ib3VuZGluZ19ib3g7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCj4gaW5kZXggNjhiNjVhMDkwZDE3Li40
Y2MwZDIzMDhjOTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfcmVzb3VyY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX3Jlc291cmNlLmMKPiBAQCAtMjE0MSw5ICsyMTQxLDEwIEBAIGVudW0gZGNfc3Rh
dHVzIHJlc291cmNlX21hcF9wb29sX3Jlc291cmNlcygKPiAgICAgICAgICAgICAgICAgdHJ1ZSk7
Cj4KPiAgICAgICAgIC8qIFRPRE86IEFkZCBjaGVjayBpZiBBU0lDIHN1cHBvcnQgYW5kIEVESUQg
YXVkaW8gKi8KPiAtICAgICAgIGlmICghc3RyZWFtLT5jb252ZXJ0ZXJfZGlzYWJsZV9hdWRpbyAm
Jgo+IC0gICAgICAgICAgIGRjX2lzX2F1ZGlvX2NhcGFibGVfc2lnbmFsKHBpcGVfY3R4LT5zdHJl
YW0tPnNpZ25hbCkgJiYKPiAtICAgICAgICAgICBzdHJlYW0tPmF1ZGlvX2luZm8ubW9kZV9jb3Vu
dCAmJiBzdHJlYW0tPmF1ZGlvX2luZm8uZmxhZ3MuYWxsKSB7Cj4gKyAgICAgICBpZiAoIWRjLT5j
b25maWcuZGlzYWJsZV9hdWRpbyAmJgo+ICsgICAgICAgICAgICAgICAhc3RyZWFtLT5jb252ZXJ0
ZXJfZGlzYWJsZV9hdWRpbyAmJgo+ICsgICAgICAgICAgICAgICBkY19pc19hdWRpb19jYXBhYmxl
X3NpZ25hbChwaXBlX2N0eC0+c3RyZWFtLT5zaWduYWwpICYmCj4gKyAgICAgICAgICAgICAgIHN0
cmVhbS0+YXVkaW9faW5mby5tb2RlX2NvdW50ICYmIHN0cmVhbS0+YXVkaW9faW5mby5mbGFncy5h
bGwpIHsKPiAgICAgICAgICAgICAgICAgcGlwZV9jdHgtPnN0cmVhbV9yZXMuYXVkaW8gPSBmaW5k
X2ZpcnN0X2ZyZWVfYXVkaW8oCj4gICAgICAgICAgICAgICAgICZjb250ZXh0LT5yZXNfY3R4LCBw
b29sLCBwaXBlX2N0eC0+c3RyZWFtX3Jlcy5zdHJlYW1fZW5jLT5pZCwgZGNfY3R4LT5kY2VfdmVy
c2lvbik7Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAo+IGluZGV4IDcxZDQ2YWRl
MjRlNS4uMmFiNmQ3NzBjNjZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kYy5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgK
PiBAQCAtMjk3LDYgKzI5Nyw3IEBAIHN0cnVjdCBkY19jb25maWcgewo+ICAgICAgICAgYm9vbCBt
dWx0aV9tb25fcHBfbWNsa19zd2l0Y2g7Cj4gICAgICAgICBib29sIGRpc2FibGVfZG1jdTsKPiAg
ICAgICAgIGJvb2wgZW5hYmxlXzR0bzFNUEM7Cj4gKyAgICAgICBib29sIGRpc2FibGVfYXVkaW87
Cj4gICNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikKPiAgICAgICAgIGJvb2wgY2xh
bXBfbWluX2RjZmNsazsKPiAgI2VuZGlmCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hbWRfc2hhcmVkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1k
X3NoYXJlZC5oCj4gaW5kZXggOTY3NjAxNmEzN2NlLi43MjAyZDgxNmE5N2UgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKPiBAQCAtMjIwLDYgKzIyMCw3IEBA
IGVudW0gRENfRkVBVFVSRV9NQVNLIHsKPiAgICAgICAgIERDX01VTFRJX01PTl9QUF9NQ0xLX1NX
SVRDSF9NQVNLID0gMHgyLAo+ICAgICAgICAgRENfRElTQUJMRV9GUkFDVElPTkFMX1BXTV9NQVNL
ID0gMHg0LAo+ICAgICAgICAgRENfUFNSX01BU0sgPSAweDgsCj4gKyAgICAgICBEQ19ESVNBQkxF
X0FVRElPID0gMHgxMCwKPiAgfTsKPgo+ICBlbnVtIERDX0RFQlVHX01BU0sgewo+IC0tCj4gMi4y
Ny4wCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
