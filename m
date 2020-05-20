Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC61C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 14:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731032072C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayAw5q+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731032072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EDF89CD7;
	Wed, 20 May 2020 14:43:09 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A003A89147;
 Wed, 20 May 2020 14:43:08 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id be9so3325460edb.2;
 Wed, 20 May 2020 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Zn51Qjw50L6qfT/KZBaKYispD8DfeCXpPecJzJYGIDs=;
 b=ayAw5q+kRKE/4Tp0rbymST6W/6nPoj7MUnwsnti7/pzaStkISmL+fL2Blcslev9PwX
 5pNubX9E8Za9QlUh1lOo9EfichEvwN5vu1CSxW8zBt0q4F7ZDsC/HYjYmr4Sh3Soj8ZQ
 LffaLopY/dV0pdx4Obs5/eNuaXbPRmVBpBoaLwwo4fBJergVwDkftVXDnARBR9sScgK5
 qqKY3RaEUh/WiXad2D8TIQoEXF0M0IbNB/GEH5GJxqaU+zGUk6q0fvJa/mGwDdVxjbqb
 a0EdtDDQi2GuUAP2Zg9TGonWczk3Mihb819rGbiDl6ERlnmUcEjh59k9GziBPdmUBFSv
 arCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Zn51Qjw50L6qfT/KZBaKYispD8DfeCXpPecJzJYGIDs=;
 b=FehPGEN1eWdsqZY0TDxHCs2bTD4C1NIIwhIF8GDD6NYF8xMKtYGlkCJ4UlR+19hY4H
 Uy02CQnH92kxF20D85rR81udy5RG/AvumGhl3yRKizEWUzjDoNr7A2gO3SqKykcsiSda
 O1P/a6/Xvv4jCO+wt3d+gcoFSUGj+iAxlbRfAotzKzNVEumYKiZkz5GLhdzm7MFrIPVR
 XPRpLrZq3u+jV3V+O2fROfMbGU80uG2vIUgn0X7yQvGpy5gPoNGy7d8giekLxtyeXpoJ
 UxA0FXzKTkjfxbannfl94PQKryicMe/N0Lge8UUumB0JRlj1xSF0y1lPrPXbY+7sYnwy
 a3xg==
X-Gm-Message-State: AOAM5322HKMzaAhkdn+z9VeDPEcQVyj53HG83GoxlNhEbbnIVoCwh1V6
 /KSJBBc7SmvecsPII5pEiy3QtOVr
X-Google-Smtp-Source: ABdhPJxP1ZdqrHBLmmgKtoK82Jap0BdEXdXmAm4uvWIyM8Yq6TlxtKk1Kjh7MbnAL5tZSkepv1xZIg==
X-Received: by 2002:a05:6402:1547:: with SMTP id
 p7mr3610256edx.31.1589985787126; 
 Wed, 20 May 2020 07:43:07 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a15sm2066575ejj.104.2020.05.20.07.43.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2020 07:43:06 -0700 (PDT)
Subject: Re: [RFC] Deprecate AGP GART support for Radeon/Nouveau/TTM
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: dri-devel@lists.freedesktop.org, debian-powerpc@lists.debian.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200513110313.12979-1-christian.koenig@amd.com>
Message-ID: <9d784383-905e-59af-b17c-923c92474ece@gmail.com>
Date: Wed, 20 May 2020 16:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200513110313.12979-1-christian.koenig@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDUuMjAgdW0gMTM6MDMgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IFVuZm9ydHVu
YXRlbHkgQUdQIGlzIHN0aWxsIHRvIHdpZGVseSB1c2VkIGFzIHdlIGNvdWxkIGp1c3QgZHJvcCBz
dXBwb3J0IGZvciB1c2luZyBpdHMgR0FSVC4KPgo+IE5vdCB1c2luZyB0aGUgQUdQIEdBUlQgYWxz
byBkb2Vzbid0IG1lYW4gYSBsb3NzIGluIGZ1bmN0aW9uYWxpdHkgc2luY2UgZHJpdmVycyB3aWxs
IGp1c3QgZmFsbGJhY2sgdG8gdGhlIGRyaXZlciBzcGVjaWZpYyBQQ0kgR0FSVC4KPgo+IEZvciBu
b3cganVzdCBkZXByZWNhdGUgdGhlIGNvZGUgYW5kIGRvbid0IGVuYWJsZSB0aGUgQUdQIEdBUlQg
aW4gVFRNIGV2ZW4gd2hlbiBnZW5lcmFsIEFHUCBzdXBwb3J0IGlzIGF2YWlsYWJsZS4KClNvIEkn
dmUgdXNlZCBhbiBhbmNpZW50IHN5c3RlbSAoMzJiaXQpIHRvIHNldHVwIGEgdGVzdCBib3ggZm9y
IHRoaXMuCgoKVGhlIGZpcnN0IEdQVSBJIGNvdWxkIHRlc3QgaXMgYW4gUlYyODAgKFJhZGVvbiA5
MjAwIFBSTykgd2hpY2ggaXMgZWFzaWx5IAoxNSB5ZWFycyBvbGQuCgpXaGF0IGhhcHBlbnMgaW4g
QUdQIG1vZGUgaXMgdGhhdCBnbHhnZWFycyBzaG93cyBhcnRpZmFjdHMgZHVyaW5nIApyZW5kZXJp
bmcgb24gdGhpcyBzeXN0ZW0uCgpJbiBQQ0kgbW9kZSB0aG9zZSByZW5kZXJpbmcgYXJ0aWZhY3Rz
IGFyZSBnb25lIGFuZCBnbHhnZWFycyBzZWVtcyB0byAKZHJhdyBldmVyeXRoaW5nIGNvcnJlY3Rs
eSBub3cuCgpQZXJmb3JtYW5jZSBpcyBvYnZpb3VzbHkgbm90IGNvbXBhcmFibGUsIGNhdXNlIGlu
IEFHUCB3ZSBkb24ndCByZW5kZXIgCmFsbCB0cmlhbmdsZXMgY29ycmVjdGx5LgoKClRoZSBzZWNv
bmQgR1BVIEkgY291bGQgdGVzdCBpcyBhbiBSVjYzMCBQUk8gKFJhZGVvbiBIRCAyNjAwIFBSTyBB
R1ApIAp3aGljaCBpcyBtb3JlIHRoYW4gMTAgeWVhcnMgb2xkLgoKQXMgZmFyIGFzIEkgY2FuIHRl
bGwgdGhpcyBvbmUgd29ya3MgaW4gYm90aCBBR1AgYW5kIFBDSWUgbW9kZSBwZXJmZWN0bHkgCmZp
bmUuCgpTaW5jZSB0aGlzIGlzIG9ubHkgYSAzMmJpdCBzeXN0ZW0gSSBjb3VsZG4ndCByZWFsbHkg
dGVzdCBhbnkgT3BlbkdMIGdhbWUgCnRoYXQgd2VsbC4KCkJ1dCBmb3IgZ2x4Z2VhcnMgc3dpdGNo
aW5nIGZyb20gQUdQIHRvIFBDSWUgbW9kZSBzZWVtcyB0byByZXN1bHQgaW4gYSAKcm91Z2hseSA1
JSBwZXJmb3JtYW5jZSBkcm9wLgoKVGhlIHN1cnByaXNpbmcgcmVhc29uIGZvciB0aGlzIGlzIG5v
dCB0aGUgYmV0dGVyIFRMQiBwZXJmb3JtYW5jZSwgYnV0IAp0aGUgbGFjayBvZiBVU1dDIHN1cHBv
cnQgZm9yIHRoZSBQQ0llIEdBUlQgaW4gcmFkZW9uLgoKClNvIGlmIGFueWJvZHkgd2FudHMgdG8g
Z2V0IGhpcyBoYW5kcyBkaXJ0eSBhbmQgc3F1ZWV6ZSBhIGJpdCBtb3JlIApwZXJmb3JtYW5jZSBv
dXQgb2YgdGhlIG9sZCBoYXJkd2FyZSwgcG9ydGluZyBVU1dDIGZyb20gYW1kZ3B1IHRvIHJhZGVv
biAKc2hvdWxkbid0IGJlIHRvIG11Y2ggb2YgYSBwcm9ibGVtLgoKClN1bW1pbmcgaXQgdXAgSSdt
IHN0aWxsIGxlYW5pbmcgdG93YXJkcyBkaXNhYmxpbmcgQUdQIGNvbXBsZXRlbHkgYnkgCmRlZmF1
bHQgZm9yIHJhZGVvbiBhbmQgZGVwcmVjYXRlIGl0IGluIFRUTSBhcyB3ZWxsLgoKVGhvdWdodHM/
IEVzcGVjaWFsbHkgQWxleCB3aGF0IGRvIHlvdSB0aGluay4KClJlZ2FyZHMsCkNocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
