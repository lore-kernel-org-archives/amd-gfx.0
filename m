Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84866C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 19:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3586124C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 19:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3586124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8769D6E972;
	Wed,  7 Apr 2021 19:04:46 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE4B6E402;
 Wed,  7 Apr 2021 19:04:45 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 h6-20020a0568300346b02901b71a850ab4so19111078ote.6; 
 Wed, 07 Apr 2021 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lXRiZ+z3iOclSJzumWAgMFnPzVlrJB7zyZivCDHbNOM=;
 b=EZKNQcuhQOYkIsHvz+7FEEFrVnZeI2rMaI+xzx6G5Mwqs0L+sfKCce6g33KdFacFh1
 tr0BD9bXJo96QgnXgcumWd33mYEQUeaJMbqhhl+VRYTvRD6k32ia6scxZGvcrw//+bqx
 irIpX+soGO7LwkKGMBGGfQzM4Hz6WxTWHOCwDwaWfW0qUF0BvkFJI8anVr40okDzHpAf
 lfeYr5MglvGpFkMPVV/frrOnOnzH3B2SHDAMEz0zBzUPyxvCF5INJH6k015ZQjbDKYkQ
 CMyhm6lplrUNRWYoQBDu6uqkYeRBa6DGjiV48+9radLJ1GuEP8H1jXc50pJ+d/G7BSKq
 gmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lXRiZ+z3iOclSJzumWAgMFnPzVlrJB7zyZivCDHbNOM=;
 b=P3luqu7Mrg7Cgf07jOGBOYEIOxtv/GLXGwHT2zneYH3wwgPz73FasFbkQFPMgvytUC
 bgdjdSr30wD8wTYIg21jRoxly2ivLRakhmxffeZFfjZZfalHoTSeI/XGhav8Yo2eF/WQ
 Uz6WeuZtbd8ELz7uVHKSuRXliSyJ3pV42rSTEMJR4kaGKjRMdPvc8C+4CdLjKtIMM/8N
 gMR23/hoqdwlCj9pwAVYddc5mT//HGQq8xtcndMoZ1sovqc7j+o7rJUARZiGE9+VhivS
 /TPYBqL5w8+aiyK9gl9Ww2SCKQ3sNwAggddvMR/p2FR44Eh63vgIbJ6K22HgjGo2CWTp
 uyKg==
X-Gm-Message-State: AOAM532Mc9vzImg6q0xd8luclKJBLwbn0p6Zz8sCzfE9yMi/8w7LRXza
 AIgHPfu6cWj3rhc6VuTypEa6C1LU+fZDTIPAjGY=
X-Google-Smtp-Source: ABdhPJzBdUTK7Ak+eHmperWsnUltNNKttEqhEkVByM2ik42MeHH79Ofyla1rj8qRT3VGmTULUDk1j2gpSS3/F/Ue8ho=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr4196507ots.23.1617822284792;
 Wed, 07 Apr 2021 12:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210401222931.3823-1-alexander.deucher@amd.com>
 <0fa472a5-08b4-87cd-c295-7502bd30c2c0@gmail.com>
 <CADnq5_NXz-B3BjQdP1x7P3tPC160EO906_TZObJhx85CHt6b2A@mail.gmail.com>
 <CAPM=9twymi8Emi+GpDW0Gz_OQ63BGwwzKwF_Jxq8=i_VC9U=3w@mail.gmail.com>
In-Reply-To: <CAPM=9twymi8Emi+GpDW0Gz_OQ63BGwwzKwF_Jxq8=i_VC9U=3w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Apr 2021 15:04:33 -0400
Message-ID: <CADnq5_Ored1NxmDP5=_-5BXstsTdUPB31upM2AVFLXM1EXKQzQ@mail.gmail.com>
Subject: Re: [pull] amdgpu, radeon, ttm, sched drm-next-5.13
To: Dave Airlie <airlied@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBBcHIgNywgMjAyMSBhdCAzOjIzIEFNIERhdmUgQWlybGllIDxhaXJsaWVkQGdtYWls
LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIDcgQXByIDIwMjEgYXQgMDY6NTQsIEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmksIEFwciAyLCAy
MDIxIGF0IDEyOjIyIFBNIENocmlzdGlhbiBLw7ZuaWcKPiA+IDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEhleSBBbGV4LAo+ID4gPgo+ID4gPiB0
aGUgVFRNIGFuZCBzY2hlZHVsZXIgY2hhbmdlcyBzaG91bGQgYWxyZWFkeSBiZSBpbiB0aGUgZHJt
LW1pc2MtbmV4dAo+ID4gPiBicmFuY2ggKG5vdCAxMDAlIHN1cmUgYWJvdXQgdGhlIFRUTSBwYXRj
aCwgbmVlZCB0byBkb3VibGUgY2hlY2sgbmV4dCB3ZWVrKS4KPiA+ID4KPiA+Cj4gPiBUaGUgVFRN
IGNoYW5nZSBpcyBub3QgaW4gZHJtLW1pc2MgeWV0Lgo+ID4KPiA+ID4gQ291bGQgdGhhdCBjYXVz
ZSBwcm9ibGVtcyB3aGVuIGJvdGggYXJlIG1lcmdlZCBpbnRvIGRybS1uZXh0Pwo+ID4KPiA+IERh
dmUsIERhbmllbCwgaG93IGRvIHlvdSB3YW50IHRvIGhhbmRsZSB0aGlzPyAgVGhlIGR1cGxpY2F0
ZWQgcGF0Y2ggaXMgdGhpcyBvbmU6Cj4gPiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL2Ry
bS9kcm0tbWlzYy9jb21taXQvP2lkPWFjNGViODNhYjI1NWRlOWMzMTE4NGRmNTFmZDE1MzRiYTM2
ZmQyMTIKPiA+IGFtZGdwdSBoYXMgY2hhbmdlcyB3aGljaCBkZXBlbmQgb24gaXQuICBUaGUgc2Ft
ZSBwYXRjaCBpcyBpbmNsdWRlZCBpbiB0aGlzIFBSLgo+Cj4gT3VjaCBub3Qgc3VyZSBob3cgYmVz
dCB0byBzeW5jIHVwIGhlcmUsIG1heWJlIGdldCBtaXNjLW5leHQgaW50byBteQo+IHRyZWUgdGhl
biByZWJhc2UgeW91ciB0cmVlIG9uIHRvcCBvZiBpdD8KCkkgY2FuIGRvIHRoYXQuCgpBbGV4CgoK
Pgo+IERhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
