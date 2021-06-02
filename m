Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65014C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 17:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5B061D57
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 17:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5B061D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34856EE2C;
	Wed,  2 Jun 2021 17:44:28 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952F96EE28
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 17:37:55 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id f2so3097500wri.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=+yaTa+zDqmDiAibU5zoH8Z7YnQKRwY03Jyu/LIqtjEI=;
 b=NweQXUximI5ePuS0XoWrWeT2EWTWo74GFJr3gtWpYr4cBa/glGPCN1MFlztMmepXSt
 Vd+fbZUDe+a5tB+iB/Wbapbm2KVoW96cmcBe8F2P0kkPLtsDvIfcmdGfmbO7fJzG0Zk7
 QOp0ET0vMmsIhYhJXvLtUv1MsbC5taoVQH0DQSDnPGXzEZfKkR6aT94XYk0vILzdgB7Y
 q2SIEJmDPMsjAC2BXzw3yhqibiLA3x+sDITaR01MOpDdMA8usM26KGz0DbZQtDnJDFTV
 4PhF3is4/MZo9nsFotUgEtsFiBRan+5V8KpuZL2r7CB9s38/kYvyhEd2xo5DwkArz5Ua
 cbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+yaTa+zDqmDiAibU5zoH8Z7YnQKRwY03Jyu/LIqtjEI=;
 b=Wq00yrzAhcixfercMPUIsckW0Rs2K5nkKRLHqQ1gQsSZ1OPqxl5jaia4QBm/Go/b/w
 ob6BA0ecTuUS9mGNiblpanmkdSawqZRtJxTkX46Nnm4B/rNk/V6k1d3Fy4vEsImUQUDz
 XxHiHOqlViFnd8XXpAUwsZS/A1hrTnocPH+y8JyN8T4fpgjKWYTOcHWaBYjPozWUHVj5
 y70xPDt0bP2guk2KA9nK7CXZpEvXsFNoxT3eZ3bxzgBh3AiDH97w+u1WWGsdmRJR23OP
 URu2LnRBV+w3WunoV7deRUKTOBXa262/0L4TUGRawvev6NLlsWqc9gJXv3YnJhAx358W
 nwQA==
X-Gm-Message-State: AOAM533egJBnlnhDsMvQ+wZWmFjALVJnQIr6D3cX8LTmEYZgxsroiO0l
 gHukOAJJFhcwf64xF7PNcT6mzA==
X-Google-Smtp-Source: ABdhPJweKZb3mxKzWSBDkCYDSjNL1O4y6OXQiFdyWx0qycUJBjK5T89gdX9sOaxWit8bK7NhrooxDQ==
X-Received: by 2002:a05:6000:186a:: with SMTP id
 d10mr35384063wri.41.1622655474277; 
 Wed, 02 Jun 2021 10:37:54 -0700 (PDT)
Received: from dell ([91.110.221.214])
 by smtp.gmail.com with ESMTPSA id i34sm788478wri.3.2021.06.02.10.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 10:37:53 -0700 (PDT)
Date: Wed, 2 Jun 2021 18:37:52 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove
 superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
Message-ID: <20210602173752.GK2173308@dell>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-17-lee.jones@linaro.org>
 <CADnq5_MHcth1p_00d=0ey+kg8o=_ZQk4t-RcU7zx3fb+35uy+g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_MHcth1p_00d=0ey+kg8o=_ZQk4t-RcU7zx3fb+35uy+g@mail.gmail.com>
X-Mailman-Approved-At: Wed, 02 Jun 2021 17:44:28 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAwMiBKdW4gMjAyMSwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBXZWQsIEp1biAy
LCAyMDIxIGF0IDEwOjMzIEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMp
Ogo+ID4KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMv
aGRjcC9oZGNwX3BzcC5jOjM3NDoyMjogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZv
ciDigJhtb2RfaGRjcF9oZGNwMV9nZXRfbGlua19lbmNyeXB0aW9uX3N0YXR1c+KAmQo+ID4gIElu
IGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6Mjg6Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzZfMF9kLmg6NTY4OjQzOiB3YXJuaW5n
OiBpbml0aWFsaXplZCBmaWVsZCBvdmVyd3JpdHRlbiBbLVdvdmVycmlkZS1pbml0XQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3Vy
Y2UuYzoxNTc6MTQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhtbUNSVEMwX0RDRkVf
TUVNX0xJR0hUX1NMRUVQX0NOVEzigJkKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmg6MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lv
biBvZiBtYWNybyDigJhTUknigJkKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTgzOjM6IG5vdGU6IGluIGV4cGFuc2lv
biBvZiBtYWNybyDigJhYRk1fQ09NTU9OX1JFR19MSVNUX0RDRTYw4oCZCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE4
NzozOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYdHJhbnNmb3JtX3JlZ3PigJkKPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVnL2RjZS9kY2Vf
Nl8wX2QuaDo1Njg6NDM6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJh4Zm1fcmVn
c1swXS5EQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZKQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzoxNTc6MTQ6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhtbUNSVEMwX0RDRkVfTUVNX0xJR0hUX1NMRUVQ
X0NOVEzigJkKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2Rj
ZS9kY2VfdHJhbnNmb3JtLmg6MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhT
UknigJkKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYw
L2RjZTYwX3Jlc291cmNlLmM6MTgzOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhY
Rk1fQ09NTU9OX1JFR19MSVNUX0RDRTYw4oCZCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE4NzozOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8g4oCYdHJhbnNmb3JtX3JlZ3PigJkKPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVnL2RjZS9kY2VfNl8wX2QuaDo2NDU6NDM6
IHdhcm5pbmc6IGluaXRpYWxpemVkIGZpZWxkIG92ZXJ3cml0dGVuIFstV292ZXJyaWRlLWluaXRd
Cj4gPgo+ID4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+ID4g
Q2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+Cj4gPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+ID4gQ2M6IE1hdXJv
IFJvc3NpIDxpc3Nvci5vcnVhbUBnbWFpbC5jb20+Cj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiA+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4gLS0tCj4g
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmggfCAz
ICstLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkK
PiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfdHJhbnNmb3JtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV90
cmFuc2Zvcm0uaAo+ID4gaW5kZXggY2JjZTE5NGVjN2I4Mi4uZTk4YjVkNDE0MTczOSAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9y
bS5oCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFu
c2Zvcm0uaAo+ID4gQEAgLTE2Niw4ICsxNjYsNyBAQAo+ID4gICAgICAgICBTUkkoU0NMX0ZfU0hB
UlBfQ09OVFJPTCwgU0NMLCBpZCkKPiA+Cj4gPiAgI2RlZmluZSBYRk1fQ09NTU9OX1JFR19MSVNU
X0RDRTYwKGlkKSBcCj4gPiAtICAgICAgIFhGTV9DT01NT05fUkVHX0xJU1RfRENFNjBfQkFTRShp
ZCksIFwKPiA+IC0gICAgICAgU1JJKERDRkVfTUVNX0xJR0hUX1NMRUVQX0NOVEwsIENSVEMsIGlk
KQo+ID4gKyAgICAgICBYRk1fQ09NTU9OX1JFR19MSVNUX0RDRTYwX0JBU0UoaWQpCj4gCj4gSSBi
ZWxpZXZlIERDRkVfTUVNX0xJR0hUX1NMRUVQX0NOVEwgc2hvdWxkIGJlIGtlcHQgaGVyZSBhbmQg
aXQgc2hvdWxkCj4gYmUgcmVtb3ZlZCBmcm9tCj4gWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MF9C
QVNFKCkgdG8gYWxpZ24gd2l0aCBvdGhlciBhc2ljcy4KCkFjay4gIFNvcnJ5IGZvciBtaXNzaW5n
IHRoaXMuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAt
IERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBm
b3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
