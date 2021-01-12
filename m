Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC9C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 14:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E412B2311D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 14:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E412B2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0D36E24D;
	Tue, 12 Jan 2021 14:18:51 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCDE6E221
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 13:43:31 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id 91so2540676wrj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=7GPaHBbgnyk5B3N5fI+9q+MKf1p8x47yjYJoIegUJJE=;
 b=T0X7tbY2aa3ykx2c3EoOKFFN975w4TkCn4oK8TOIwtqXxVudL1OJaJ+cg2vjxG8mwN
 GofBdRyGaZ4y5Gd3vxwsigr5+FZA8wi3W5mOBbhaATFC/gVgf7+EscxFQ4Sj2ZLR88rR
 NVlJaHKlMmGMB13G23xEISd67laLcqzvwgyL8qP0zesmcqjSC5DTehToKlfqAID7zRQQ
 +5/04pzaCpIIqYkPqGsVm+e8T8UfX3e3pKkrXS1emn/Ri42Jt+8dhBkZ8xw6FoQKk5tR
 pjEjoTPD4Hp2ywks+xsjWhqYGZq2Q4NLbp0GFFp0iilLiIK/AQm9BDoKUvPtYq6rISAA
 JgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7GPaHBbgnyk5B3N5fI+9q+MKf1p8x47yjYJoIegUJJE=;
 b=YsGJYRIOr+1RpCjGy25MdSQ5nCyUN0in2yikorzAGT2RF6g6HterqbiIb9n3fomBDj
 tnsZZSOsvUUnXB8DM1TghL1ONSH6VHDq5CugRqXhywbuV+YOLtsKULkVBNYBvs3gvuUG
 vedxo4idboGtfTIflRDeYHS60KtIFvIZkKndnIDSGe4RO7+DUdNi8uf6Xiv3HReUtPKt
 1+d1ymYVEicWyUWN1Ynht36bLScUQ5uDApk9Jme6WT8/f9abbKwAb74kCua6/hJXTnhY
 8bdL6wWfSZGyWBP4SqDRCeL16f9eTc3GiCjHctM2w6siwoeWQ1i+D/ZcsKNeyMkq3+cb
 UgCg==
X-Gm-Message-State: AOAM530X6trF/D10DuWJhhN1DIby9agHWygd/jskFFYoneN/E7SpjCKR
 W5394PJWpq16gKeY6fU1wp4+Dg==
X-Google-Smtp-Source: ABdhPJw5kBWvWbhmvaWdRe/7kzStPjXQq/PxsdoyNcKzNP+Z+LDSIlF/LpVp1cQg7r47k3Cb+8STSA==
X-Received: by 2002:adf:e406:: with SMTP id g6mr4433015wrm.255.1610459009830; 
 Tue, 12 Jan 2021 05:43:29 -0800 (PST)
Received: from dell ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id p15sm5033694wrt.15.2021.01.12.05.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 05:43:28 -0800 (PST)
Date: Tue, 12 Jan 2021 13:43:27 +0000
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/40] drm/amd/display/dc/calcs/dce_calcs: Remove some
 large variables from the stack
Message-ID: <20210112134327.GC3575260@dell>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-15-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111191926.3688443-15-lee.jones@linaro.org>
X-Mailman-Approved-At: Tue, 12 Jan 2021 14:18:50 +0000
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

T24gTW9uLCAxMSBKYW4gMjAyMSwgTGVlIEpvbmVzIHdyb3RlOgoKPiBGaXhlcyB0aGUgZm9sbG93
aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPiAKPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYzogSW4gZnVuY3Rpb24g4oCY
YndfY2FsY3NfaW5pdOKAmToKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9jYWxjcy9kY2VfY2FsY3MuYzoyNzI2OjE6IHdhcm5pbmc6IHRoZSBmcmFtZSBzaXplIG9m
IDEzMzYgYnl0ZXMgaXMgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBbLVdmcmFtZS1sYXJnZXItdGhh
bj1dCj4gCj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENj
OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICAuLi4v
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYyAgfCAxMTE1ICsrKysrKysr
Ky0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1NjAgaW5zZXJ0aW9ucygrKSwgNTU1IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y2FsY3MvZGNlX2NhbGNzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3Mv
ZGNlX2NhbGNzLmMKPiBpbmRleCBhMGM2OWZhZTQwY2VkLi5mNjljMmI4NGQ0MzJiIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYwo+
IEBAIC0yMDM1LDcwNyArMjAzNSw3MTIgQEAgdm9pZCBid19jYWxjc19pbml0KHN0cnVjdCBid19j
YWxjc19kY2VpcCAqYndfZGNlaXAsCj4gIAlzdHJ1Y3QgYndfY2FsY3NfdmJpb3MgKmJ3X3ZiaW9z
LAo+ICAJc3RydWN0IGh3X2FzaWNfaWQgYXNpY19pZCkKPiAgewo+IC0Jc3RydWN0IGJ3X2NhbGNz
X2RjZWlwIGRjZWlwID0geyAwIH07Cj4gLQlzdHJ1Y3QgYndfY2FsY3NfdmJpb3MgdmJpb3MgPSB7
IDAgfTsKPiArCXN0cnVjdCBid19jYWxjc19kY2VpcCAqZGNlaXA7Cj4gKwlzdHJ1Y3QgYndfY2Fs
Y3NfdmJpb3MgKnZiaW9zOwo+ICAKPiAgCWVudW0gYndfY2FsY3NfdmVyc2lvbiB2ZXJzaW9uID0g
YndfY2FsY3NfdmVyc2lvbl9mcm9tX2FzaWNfaWQoYXNpY19pZCk7Cj4gIAo+IC0JZGNlaXAudmVy
c2lvbiA9IHZlcnNpb247Cj4gKwlkY2VpcCA9IGt6YWxsb2Moc2l6ZW9mKGRjZWlwKSwgR0ZQX0tF
Uk5FTCk7Cj4gKwl2YmlvcyA9IGt6YWxsb2Moc2l6ZW9mKHZiaW9zKSwgR0ZQX0tFUk5FTCk7CgpQ
bGVhc2UgZG9uJ3QgcmV2aWV3L21lcmdlIHRoaXMgeWV0LiAgSSBtaXNzZWQgc29tZSBlcnJvciBj
aGVja2luZy4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRlY2huaWNhbCBMZWFk
IC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
