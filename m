Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A74C43141
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E438620878
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E438620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB0E89EAC;
	Mon, 25 Nov 2019 14:08:53 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D1589E5A;
 Mon, 25 Nov 2019 14:08:51 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y11so15096857wrt.6;
 Mon, 25 Nov 2019 06:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iNWDGc0fQ00Ye1+fTt2khUxDXRk0OG4bs4g9Ax7i6qo=;
 b=rnXqQ+7ypxKMexbBaDxRk1hL8h4ahcpb9VUgItyOazvbXH7JFqnvIaRvKnATLcNwfi
 sgj6mcGEKuhT63Zf2zkmF20Zmgh03WoJs8YLsDaL5wocWEaRu5u4j1wEmyYJnvxfBRZ3
 FGve/lLAAuXmYrV8L/NSoYBhxBTdrogqPxaiJ+p3umvtJlTwviaYIM+PhshLKobu3XnI
 ttXdTuLSBn6l+AxdbnEEF5k+izPloKLUauCtAc81Z0WJ/31hNmrw41g9c8LMjklTiDM4
 u1mwdQzaCJ/UW1QGclrp8Fkp2BC2Mqam990qm05fyq3eVnG4MVqfykRPGRLa6eCwvqNk
 SbtQ==
X-Gm-Message-State: APjAAAUB9L7bqWtI4vqLFWwxboDChloNqL7t0c0sMvDyH+W2K9vFaERE
 gWQrYWvqUalR8G8kdEf8KKuKWNMtNkeJUhXgoCA=
X-Google-Smtp-Source: APXvYqz1pQJymB1hAXfiA1XYcDD52P69YAb4gkZr7unmgvJbz4fYyaF1bNGVq89E29zTD9J5VL7DdxhiDF3l53RQSvQ=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr12042861wre.11.1574690930146; 
 Mon, 25 Nov 2019 06:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20191121132930.29544-1-krzk@kernel.org>
 <CY4PR12MB1813D2AE8B11E5F190581995F74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1813D2AE8B11E5F190581995F74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Nov 2019 09:08:37 -0500
Message-ID:
 <CADnq5_MFfCfsUiJ-jjZa-rMf1PDJ7v6jPzCXN9ZnCZEvSsU1-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix Kconfig indentation
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iNWDGc0fQ00Ye1+fTt2khUxDXRk0OG4bs4g9Ax7i6qo=;
 b=P+3KoedA/0PLaVdbPw1oFWAjCaOhzr5tTq0ZarfinP2Ypvd8W1Nxi7yybCTNLi5zzA
 vW4Qd5Lesxsgi3vla0+/c9gXMFwU9ks3J0zwZTKZOpiMZBPVsVsvdeza/41sSSjHVTid
 o3qn/xkSM+yeggFbAkSOlPHSYl19wbGt/aCJACFgNb9d68eTSu+JpPlWYpCuAcYbL6hC
 wGeqB0EaIQMAW7hMrmKbB2KRm38Df5+aCcD8yBiMuGXvM8dhsqOmDtO4z/Jj8bBpf0e9
 9i1hPhpULNpC2+vFzYDo2u+TifKgWBC9qXsZ1D6xfbmS+/UrHzgWxxLV4/TuTHyE0XnP
 Dd/Q==
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
Cc: Krzysztof Kozlowski <krzk@kernel.org>, David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125140837.X_-MnYRMOGICF9CR57TJDPj2dispLy1gj0DRhX3Aohk@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTm92IDIxLCAyMDE5IGF0IDExOjEzIEFN
IERldWNoZXIsIEFsZXhhbmRlcgo8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4gd3JvdGU6Cj4K
PiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPgo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyMSwgMjAx
OSA4OjI5IEFNCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+Cj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaG91LCBEYXZpZChD
aHVuTWluZykgPERhdmlkMS5aaG91QGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+
IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZDogRml4IEtjb25maWcgaW5kZW50YXRpb24KPgo+IEFk
anVzdCBpbmRlbnRhdGlvbiBmcm9tIHNwYWNlcyB0byB0YWIgKCtvcHRpb25hbCB0d28gc3BhY2Vz
KSBhcyBpbgo+IGNvZGluZyBzdHlsZSB3aXRoIGNvbW1hbmQgbGlrZToKPiAgICAgICAgICQgc2Vk
IC1lICdzL14gICAgICAgIC9cdC8nIC1pICovS2NvbmZpZwo+Cj4gU2lnbmVkLW9mZi1ieTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FjcC9LY29uZmlnIHwgMTAgKysrKystLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYWNwL0tjb25maWcgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FjcC9LY29uZmlnCj4g
aW5kZXggZDk2OGMyNDcxNDEyLi4xOWJhZTkxMDBkYTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hY3AvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tj
b25maWcKPiBAQCAtMiwxMSArMiwxMSBAQAo+ICBtZW51ICJBQ1AgKEF1ZGlvIENvUHJvY2Vzc29y
KSBDb25maWd1cmF0aW9uIgo+Cj4gIGNvbmZpZyBEUk1fQU1EX0FDUAo+IC0gICAgICAgYm9vbCAi
RW5hYmxlIEFNRCBBdWRpbyBDb1Byb2Nlc3NvciBJUCBzdXBwb3J0Igo+IC0gICAgICAgZGVwZW5k
cyBvbiBEUk1fQU1ER1BVCj4gLSAgICAgICBzZWxlY3QgTUZEX0NPUkUKPiAtICAgICAgIHNlbGVj
dCBQTV9HRU5FUklDX0RPTUFJTlMgaWYgUE0KPiAtICAgICAgIGhlbHAKPiArICAgICAgIGJvb2wg
IkVuYWJsZSBBTUQgQXVkaW8gQ29Qcm9jZXNzb3IgSVAgc3VwcG9ydCIKPiArICAgICAgIGRlcGVu
ZHMgb24gRFJNX0FNREdQVQo+ICsgICAgICAgc2VsZWN0IE1GRF9DT1JFCj4gKyAgICAgICBzZWxl
Y3QgUE1fR0VORVJJQ19ET01BSU5TIGlmIFBNCj4gKyAgICAgICBoZWxwCj4gICAgICAgICAgQ2hv
b3NlIHRoaXMgb3B0aW9uIHRvIGVuYWJsZSBBQ1AgSVAgc3VwcG9ydCBmb3IgQU1EIFNPQ3MuCj4g
ICAgICAgICAgVGhpcyBhZGRzIHRoZSBBQ1AgKEF1ZGlvIENvUHJvY2Vzc29yKSBJUCBkcml2ZXIg
YW5kIHdpcmVzCj4gICAgICAgICAgaXQgdXAgaW50byB0aGUgYW1kZ3B1IGRyaXZlci4gIFRoZSBB
Q1AgYmxvY2sgcHJvdmlkZXMgdGhlIERNQQo+IC0tCj4gMi4xNy4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
