Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D75C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865972076E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehw74WGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865972076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB1B6E527;
	Fri, 13 Nov 2020 16:10:33 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5836E52E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 15:45:59 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id u12so3170606wrt.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=8040h1823exCptt290K2ZbCgSOfnPZC+bX9ayz7h03c=;
 b=ehw74WGQ3oAIgY9VTlCTqruI7XrRb+WbqPc8h7DTtqmbllTVLXzWmuz2tJiQjVfM32
 9BIK2RP0OEnRMrRqSrOyBigqDMVsYzpPPF/s6jrIgtWBofOCXSDzATo+SikKqe7POokl
 cen2S84YqJEyHOMFPfsXIBYUsu3D8luDEBBA2zim1n0sYnAUTLVZeqK+R2PV5coO6z+e
 UknNcWbaJFvl4h23tHWJhaaP0IikyYjm34xWGEeBGZdcYSPIssyn83QaV59qfxpNRAA3
 wXkOAQLvx8/mfVpzkBGpnOFqYL96K9kNkLlSKsMQ2WEXrR6t11ltbeZo422Q7mKKzJlf
 j2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8040h1823exCptt290K2ZbCgSOfnPZC+bX9ayz7h03c=;
 b=mjIAEFex0nh4TNfOVGVc6h4ueXTsEu5ke8H00zHfhAheiTXWACrd/0CBlFYjOp7tAN
 WdEmeHVAdL21CdAn7KAqdMDavULhr4SgPPgBxd19Z1rgBo99VA5jAcPNCxT6wimpbXLf
 18KS8dKNQuuq0hjJwZrXZjrveFtA3+TRvulBo/PMq0VeCrGDx+oKlcwI29JlgEx3INwG
 yMKfZqJT2n2UTS/asOyg/A55cv7ZmDB5R5i/LI7aXjhqP+n/iSO9oes2/KFk6l5FOSqa
 hdcI+Zdie8eB5yRdcfr7Euvd57nlpsyGv6oR2ZNQHKDCH2KNalUPc7u8jDF2fm2BCfeJ
 zsYw==
X-Gm-Message-State: AOAM533j07D2fi6zY7jtgjuisDNjfejoNhny9jaP6qXVF/uEq6JZleHQ
 tXT/qOXwVTLktr308qtHJcif5w==
X-Google-Smtp-Source: ABdhPJyiqhGILQ5wz3/bpboCSgRPXWW77kAhTnJTpNJP/Za6YqeYLUABaQ6YWDwE2o+MkrcH9VnNvQ==
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr4337524wrw.104.1605282353498; 
 Fri, 13 Nov 2020 07:45:53 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k20sm10457006wmi.15.2020.11.13.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 07:45:52 -0800 (PST)
Date: Fri, 13 Nov 2020 15:45:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/display/dc/core/dc_link_dp: Move
 DP_VGA_LVDS_CONVERTER_ID_{2, 3} to where they're used
Message-ID: <20201113154550.GK3718728@dell>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-3-lee.jones@linaro.org>
 <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
X-Mailman-Approved-At: Fri, 13 Nov 2020 16:10:33 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCAxMyBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBGcmksIE5vdiAx
MywgMjAyMCBhdCA4OjQ5IEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgPjIwMCB3YXJuaW5ncy4KPiA+Cj4gPiBGaXhlcyB0
aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPiA+Cj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9pbmNsdWRlL2RkY19zZXJ2aWNlX3R5cGVz
Lmg6MTIzOjIyOiB3YXJuaW5nOiDigJhEUF9WR0FfTFZEU19DT05WRVJURVJfSURfM+KAmSBkZWZp
bmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ID4gIDEyMyB8IHN0
YXRpYyBjb25zdCB1aW50OF90IERQX1ZHQV9MVkRTX0NPTlZFUlRFUl9JRF8zW10gPSAiZG5vbWxB
IjsKPiA+ICB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9pbmNsdWRlL2RkY19zZXJ2aWNlX3R5cGVzLmg6MTIxOjIy
OiB3YXJuaW5nOiDigJhEUF9WR0FfTFZEU19DT05WRVJURVJfSURfMuKAmSBkZWZpbmVkIGJ1dCBu
b3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ID4gIDEyMSB8IHN0YXRpYyBjb25z
dCB1aW50OF90IERQX1ZHQV9MVkRTX0NPTlZFUlRFUl9JRF8yW10gPSAic2l2YXJUIjsKPiA+Cj4g
PiBOQjogUmVwZWF0ZWQgfjEwMCB0aW1lcyAtIHNuaXBwZWQgZm9yIGJyZXZpdHkKPiA+Cj4gPiBD
YzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gPiBDYzogTGVvIExp
IDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgo+ID4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+ID4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiA+IENj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiA+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
PiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4gLS0t
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jICAg
ICAgICB8IDUgKysrKysKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9k
ZGNfc2VydmljZV90eXBlcy5oIHwgNCAtLS0tCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYwo+ID4gaW5kZXggNmM2MGMxZmRlYmRjMS4u
ZjIwMjNkMmI1MzIzNCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCj4gPiBAQCAtMTUsNiArMTUsMTEgQEAKPiA+ICAjaW5j
bHVkZSAiZGNfZG11Yl9zcnYuaCIKPiA+ICAjaW5jbHVkZSAiZGNlL2RtdWJfaHdfbG9ja19tZ3Iu
aCIKPiA+Cj4gPiArLypUcmF2aXMqLwo+ID4gK3N0YXRpYyBjb25zdCB1aW50OF90IERQX1ZHQV9M
VkRTX0NPTlZFUlRFUl9JRF8yW10gPSAic2l2YXJUIjsKPiA+ICsvKk51dG1lZyovCj4gPiArc3Rh
dGljIGNvbnN0IHVpbnQ4X3QgRFBfVkdBX0xWRFNfQ09OVkVSVEVSX0lEXzNbXSA9ICJkbm9tbEEi
Owo+ID4gKwo+ID4gICNkZWZpbmUgRENfTE9HR0VSIFwKPiA+ICAgICAgICAgbGluay0+Y3R4LT5s
b2dnZXIKPiA+ICAjZGVmaW5lIERDX1RSQUNFX0xFVkVMX01FU1NBR0UoLi4uKSAvKiBkbyBub3Ro
aW5nICovCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1
ZGUvZGRjX3NlcnZpY2VfdHlwZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNs
dWRlL2RkY19zZXJ2aWNlX3R5cGVzLmgKPiA+IGluZGV4IGM5YmU4OTljZDI1Y2QuLmI0NTNjZTVh
OWJmZGIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVk
ZS9kZGNfc2VydmljZV90eXBlcy5oCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvaW5jbHVkZS9kZGNfc2VydmljZV90eXBlcy5oCj4gPiBAQCAtMTE3LDEwICsxMTcsNiBAQCBz
dHJ1Y3QgYXZfc3luY19kYXRhIHsKPiA+ICAgICAgICAgdWludDhfdCBhdWRfZGVsX2luczM7Lyog
RFBDRCAwMDAyRGggKi8KPiA+ICB9Owo+ID4KPiA+IC0vKlRyYXZpcyovCj4gPiAtc3RhdGljIGNv
bnN0IHVpbnQ4X3QgRFBfVkdBX0xWRFNfQ09OVkVSVEVSX0lEXzJbXSA9ICJzaXZhclQiOwo+ID4g
LS8qTnV0bWVnKi8KPiA+IC1zdGF0aWMgY29uc3QgdWludDhfdCBEUF9WR0FfTFZEU19DT05WRVJU
RVJfSURfM1tdID0gImRub21sQSI7Cj4gPiAgLypEUCB0byBEdWFsIGxpbmsgRFZJIGNvbnZlcnRl
ciovCj4gPiAgc3RhdGljIGNvbnN0IHVpbnQ4X3QgRFBfRFZJX0NPTlZFUlRFUl9JRF80W10gPSAi
bTJEVklhIjsKPiA+ICBzdGF0aWMgY29uc3QgdWludDhfdCBEUF9EVklfQ09OVkVSVEVSX0lEXzVb
XSA9ICIzMzkzTjIiOwo+IAo+IENhbiB3ZSBrZWVwIGFsbCBvZiB0aGVzZSBzdHJpbmdzIHRvZ2V0
aGVyPwoKSSBkb24ndCB0aGluayBzby4gIFRoZXkgYXJlIGNvbnN1bWVkIGJ5IGRpZmZlcmVudCBm
aWxlcy4KCk9oLCBvbmUgd2F5IHRvIGRvIGl0IHdvdWxkIGJlIHRvIG1hcmsgdGhlbSBhcyBfX21h
eWJlX3VudXNlZCwgYnV0Ckkgb25seSB0ZW5kIHRvIGRvIHRoYXQgYSBsYXN0IHJlc29ydC4KCi0t
IApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVy
IFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29D
cwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
