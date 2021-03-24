Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4BA619E5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4BA619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9DE6E9C2;
	Wed, 24 Mar 2021 13:05:12 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEC36E9B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 10:36:15 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id j18so23894277wra.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=dEFFBRSXu0odutvmmG/Rwg2Sz2HimxEx+pN3ka/bnVc=;
 b=DOZKukNzPwBLODbuM7S0fhx3nEbU8wUrLkI+akr9xvK/Gn2cEkrVU5mSaLlohKzWUM
 IQkfJ4YQkOKMBazPQvbAWzdDFP3Pw6sQVJz5npSdYbHyY5D+97tiYkJ7sHJNebnH5qsm
 0tl9dSCS/MCcNsWpo95djxWqsO64QF8ensbtsRQ+wiq5hwJ8ZBDySd8GUAFJFBxdGmvR
 jEKykXmw1j4WN055zMGSRxaoUH0Mk1lSbDSTB67aaiipXHd9Df435ucMGT4YF0wFargI
 i/kPWeaegH1BvjP03zxQGdMBRdPYrgta44l0928G9W3U65Nais46ChTzh4NwrxzMpihp
 EVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dEFFBRSXu0odutvmmG/Rwg2Sz2HimxEx+pN3ka/bnVc=;
 b=Vj2cGEcLz+11RiB+9mAxsyk9zClgXe/7OjEslbWczPHwjwk0+JzVbpqLWc5X3wlCb8
 pDC+rpPllKK9euIT8Oyq/Zfr2VSwcOVF7hyflLcNrQQOtX/pykAb6OMtY+Fpw7MiWuBA
 sciKzN0t4lWWucBeKDN7PePRsNS6A/0w9w/L9VNoQamLQ+VVFAkcxrp1OO2JUkEBItvZ
 kYtInRxVpPPVa7xstjnGa9teXVGzHRKbB/1on68ybXjWRkIqUnEKOyvSRZcWO2VdA9S1
 Pg0Z2qBEi0b+YdhLqYGBiOqbknTNjPWLLrwJnIwBFKBb/bWN3KfyIey+xKAK7vkKfMiD
 ljAg==
X-Gm-Message-State: AOAM531PLl965Cu9P1WmyXHX8ZUSr+Wxx0sjDAOebxC+DVYirvOOHbMC
 87/Yf2WAkMKOMBTeY5SR/DbJWA==
X-Google-Smtp-Source: ABdhPJxI3r3iiWfvHOD+ErGz9Iu/oghrzTasZEnAeZqBD2lmagfmv90aTaU0jHjCwgR5t2MyzwXykw==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr2725687wru.401.1616582174392; 
 Wed, 24 Mar 2021 03:36:14 -0700 (PDT)
Received: from dell ([91.110.221.180])
 by smtp.gmail.com with ESMTPSA id l6sm2070476wrn.3.2021.03.24.03.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Mar 2021 03:36:14 -0700 (PDT)
Date: Wed, 24 Mar 2021 10:36:11 +0000
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Jeremy Kolb <jkolb@brandeis.edu>,
 Kuogee Hsieh <khsieh@codeaurora.org>, Leo Li <sunpeng.li@amd.com>,
 linaro-mm-sig@lists.linaro.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [RESEND 00/19] Rid GPU from W=1 warnings
Message-ID: <20210324103611.GJ2916463@dell>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
X-Mailman-Approved-At: Wed, 24 Mar 2021 13:05:10 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGFuaWVsLAoKPiBNSU1FLVZlcnNpb246IDEuMAo+IENvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsg
Y2hhcnNldD1VVEYtOAo+IENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKPiAKPiBUaGlz
IGlzIGEgcmVzZW5kIG9mIHRoZSByZW1haW5pbmcgcGF0Y2hlcy4KPiAKPiBBbGwgb2YgdGhlc2Ug
cGF0Y2hlcyBoYXZlIGJlZW4gc2VudCBiZWZvcmUuCgpBcmUgeW91IHN0aWxsIGtlZW4gdG8gJ2hv
b3ZlciB0aGVzZSB1cCc/CgpKdXN0IGxlYXZlIHRoZSBvbmUgdGhhdCByZXF1aXJlcyB3b3JrIGFu
ZCB0YWtlIHRoZSByZXN0IHBlcmhhcHM/Cgo+IExlZSBKb25lcyAoMTkpOgo+ICAgZHJtL25vdXZl
YXUvbnZrbS9zdWJkZXYvYmlvcy9pbml0OiBEZW1vdGUgb2J2aW91cyBhYnVzZSBvZiBrZXJuZWwt
ZG9jCj4gICBkcm0vbm91dmVhdS9kaXNwbnY1MC9kaXNwOiBSZW1vdmUgdW51c2VkIHZhcmlhYmxl
ICdyZXQnCj4gICBkcm0vbXNtL2RwL2RwX2Rpc3BsYXk6IFJlbW92ZSB1bnVzZWQgdmFyaWFibGUg
J2hwZCcKPiAgIGluY2x1ZGU6IGRybTogZHJtX2F0b21pYzogTWFrZSB1c2Ugb2YgJ25ld19wbGFu
ZV9zdGF0ZScKPiAgIGRybS9ub3V2ZWF1L252a20vc3ViZGV2L3ZvbHQvZ2syMGE6IERlbW90ZSBu
b24tY29uZm9ybWFudCBrZXJuZWwtZG9jCj4gICAgIGhlYWRlcnMKPiAgIGRybS9hbWQvZGlzcGxh
eS9kYy9jYWxjcy9kY2VfY2FsY3M6IE1vdmUgc29tZSBsYXJnZSB2YXJpYWJsZXMgZnJvbSB0aGUK
PiAgICAgc3RhY2sgdG8gdGhlIGhlYXAKPiAgIGRybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2Vf
Y2FsY3M6IFJlbW92ZSBzb21lIGxhcmdlIHZhcmlhYmxlcyBmcm9tCj4gICAgIHRoZSBzdGFjawo+
ICAgZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX3Jlc291cmNlOiBNYWtlIGxvY2FsIGZ1
bmN0aW9ucyBzdGF0aWMKPiAgIGRybS9ub3V2ZWF1L252a20vZW5naW5lL2dyL2dmMTAwOiBEZW1v
dGUgbm9uLWNvbmZvcm1hbnQga2VybmVsLWRvYwo+ICAgICBoZWFkZXIKPiAgIGRybS9ub3V2ZWF1
L25vdXZlYXVfYm86IFJlbW92ZSB1bnVzZWQgdmFyaWFibGVzICdkZXYnCj4gICBkcm0vbm91dmVh
dS9ub3V2ZWF1X2Rpc3BsYXk6IFJlbW92ZSBzZXQgYnV0IHVudXNlZCB2YXJpYWJsZSAnd2lkdGgn
Cj4gICBkcm0vbm91dmVhdS9kaXNwbnYwNC9jcnRjOiBEZW1vdGUgbm9uLWNvbmZvcm1pbmcga2Vy
bmVsLWRvYyBoZWFkZXJzCj4gICBkcm0vbm91dmVhdS9kaXNwbnY1MC9kaXNwOiBSZW1vdmUgdW51
c2VkIHZhcmlhYmxlICdyZXQnIGZyb20gZnVuY3Rpb24KPiAgICAgcmV0dXJuaW5nIHZvaWQKPiAg
IGRybS9ub3V2ZWF1L2Rpc3BudjUwL2hlYWRjNTdkOiBNYWtlIGxvY2FsIGZ1bmN0aW9uICdoZWFk
YzU3ZF9vbHV0Jwo+ICAgICBzdGF0aWMKPiAgIGRybS9ub3V2ZWF1L252NTBfZGlzcGxheTogUmVt
b3ZlIHN1cGVyZmx1b3VzIHByb3RvdHlwZSBmb3IgbG9jYWwKPiAgICAgc3RhdGljIGZ1bmN0aW9u
cwo+ICAgZHJtL25vdXZlYXUvZGlzcG52NTAvZGlzcDogSW5jbHVkZSBoZWFkZXIgY29udGFpbmlu
ZyBvdXIgcHJvdG90eXBlcwo+ICAgZHJtL25vdXZlYXUvbm91dmVhdV9pb2MzMjogRmlsZSBoZWFk
ZXJzIGFyZSBub3QgZ29vZCBjYW5kaWRhdGVzIGZvcgo+ICAgICBrZXJuZWwtZG9jCj4gICBkcm0v
bm91dmVhdS9ub3V2ZWF1X3N2bTogUmVtb3ZlIHVudXNlZCB2YXJpYWJsZSAncmV0JyBmcm9tIHZv
aWQKPiAgICAgZnVuY3Rpb24KPiAgIGRybS9ub3V2ZWF1L25vdXZlYXVfaW9jMzI6IERlbW90ZSBr
ZXJuZWwtZG9jIGFidXNlIHRvIHN0YW5kYXJkIGNvbW1lbnQKPiAgICAgYmxvY2sKPiAKPiAgLi4u
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmMgIHwgMTE1NCArKysrKysr
KystLS0tLS0tLQo+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX3Jlc291cmNl
LmMgfCAgIDE2ICstCj4gIGRyaXZlcnMvZ3B1L2RybS9tc20vZHAvZHBfZGlzcGxheS5jICAgICAg
ICAgICB8ICAgIDMgLQo+ICBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9kaXNwbnYwNC9jcnRjLmMg
ICAgICAgfCAgICA0ICstCj4gIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rpc3Au
YyAgICAgICB8ICAgMTAgKy0KPiAgZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvZGlzcG52NTAvaGVh
ZGM1N2QuYyAgIHwgICAgMiArLQo+ICBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2Jv
LmMgICAgICAgICAgfCAgICA0IC0KPiAgZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9k
aXNwbGF5LmMgICAgIHwgICAgOCArLQo+ICBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1
X2lvYzMyLmMgICAgICAgfCAgICA0ICstCj4gIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZl
YXVfc3ZtLmMgICAgICAgICB8ICAgIDUgKy0KPiAgZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnY1
MF9kaXNwbGF5LmggICAgICAgIHwgICAgMyAtCj4gIC4uLi9ncHUvZHJtL25vdXZlYXUvbnZrbS9l
bmdpbmUvZ3IvZ2YxMDAuYyAgICB8ICAgIDIgKy0KPiAgLi4uL2dwdS9kcm0vbm91dmVhdS9udmtt
L3N1YmRldi9iaW9zL2luaXQuYyAgIHwgIDIwNCArLS0KPiAgLi4uL2dwdS9kcm0vbm91dmVhdS9u
dmttL3N1YmRldi92b2x0L2drMjBhLmMgIHwgICAgNCArLQo+ICBpbmNsdWRlL2RybS9kcm1fYXRv
bWljLmggICAgICAgICAgICAgICAgICAgICAgfCAgICAzICstCj4gIDE1IGZpbGVzIGNoYW5nZWQs
IDY5MiBpbnNlcnRpb25zKCspLCA3MzQgZGVsZXRpb25zKC0pCj4gCj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBDYzogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+Cj4gQ2M6IEJl
biBTa2VnZ3MgPGJza2VnZ3NAcmVkaGF0LmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5n
QGNhbm9uaWNhbC5jb20+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGZyZWVkcmVub0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBD
YzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IEplcmVteSBL
b2xiIDxqa29sYkBicmFuZGVpcy5lZHU+Cj4gQ2M6IEt1b2dlZSBIc2llaCA8a2hzaWVoQGNvZGVh
dXJvcmEub3JnPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiBDYzogbGluYXJv
LW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gQ2M6IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwu
b3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwo+IENjOiBMeXVkZSBQYXVsIDxs
eXVkZUByZWRoYXQuY29tPgo+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9y
c3RAbGludXguaW50ZWwuY29tPgo+IENjOiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5v
cmc+Cj4gQ2M6IG5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IFJvYiBDbGFyayA8
cm9iZGNsYXJrQGdtYWlsLmNvbT4KPiBDYzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+Cj4g
Q2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IFRob21hcyBa
aW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pav
XQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vi
b29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
