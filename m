Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1808BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 15:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E2423AC1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 15:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E2423AC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652336EA01;
	Fri, 22 Jan 2021 15:06:21 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB06B6E9FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 15:06:19 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id gx5so8093796ejb.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TbxKy+jCWmqkl2QSpm+qJC+FeEgfl3xQ59nOTsT/E7Y=;
 b=uUOsQ5fsVQd1TuUujLXH4GAF2RUFhgUA1N2pf9iaS6YLgxY3SAhGNhHclQN9kcNY+5
 UuPVN52Qdt2mshuu2gyPW5LKBVSUrpBqgalJ4/ohk/ovmdb1ePsBgsS0Zsi2L2Q9EP+L
 kkCWP5lJg+rz1lyld/ndl1LrO9l9P6BC33tMjrHvT7UtWIxzhPGgcDDO6XcsGf39Cd0H
 OhZ+LWq1dkfoZBjUPAlFk6LwpoWNlg8zGa2xsf0n9w+hJrJc+bkfJmD8ME7EeVGLMLj6
 LJyAihO6paZ6MSs0AeKdfz9/ZgCb8A2Nbi18bCcI9EvicP9WTalZqG9TVNk2vfNQUTZP
 s0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TbxKy+jCWmqkl2QSpm+qJC+FeEgfl3xQ59nOTsT/E7Y=;
 b=jSwoYW4DYkbBQ+Xh36Ouidy/0kbkbe3FbUGjDkag3lpSTR4Kw6H5ign3FHR5hp1FZR
 kBZLi2UDIyyvyj3jPHoeeWrK/LaNh/hKd0YUrGfwIMLX4Gttcwh9I4ITc30O51RqcGW+
 nOs0HrvVKGDfn3FTs8NRmUDVCmYWz+zAKWfmEAtuw8ZvlkNtbK8d4orn1IqvaQotimry
 4MxcTYur7fUc0lKFICrCm8saMzLKPUEj7IHy8Bu8dtEgOeprqRRIUVxg7h86aWIUSfoP
 td7lYvfEZVjGJSVBL3AL49GXsEeh9j7oB/Jf2miabofVKtKNo6yRMoPZ3GlkIS5auJhu
 X54w==
X-Gm-Message-State: AOAM533ubWMLqD/Uebpb4R7HV6440gqFcc3LGmmRAWRkghrTiW+VlkXx
 k/TyNfKq/w867pW1cSnC0iqn50L8NM4=
X-Google-Smtp-Source: ABdhPJzgb9J8gPMCnmYebpDdihewxV5u5qvdvHgwcK+f+4VHVjZDS8Vc1stgEOismoqL//mNxk00uA==
X-Received: by 2002:a17:906:bc5a:: with SMTP id
 s26mr3130668ejv.327.1611327978386; 
 Fri, 22 Jan 2021 07:06:18 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k21sm5576514edq.60.2021.01.22.07.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Jan 2021 07:06:17 -0800 (PST)
Subject: Re: [PATCH] tests/amdgpu/vcn: clean abundant codes
To: Sonny Jiang <sonny.jiang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210122150439.15911-1-sonny.jiang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8c3e7533-6470-692e-d7d4-6962ae07b283@gmail.com>
Date: Fri, 22 Jan 2021 16:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122150439.15911-1-sonny.jiang@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDEuMjEgdW0gMTY6MDQgc2NocmllYiBTb25ueSBKaWFuZzoKPiBSZW1vdmUgdXNlbGVz
cyBjb2Rlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFNvbm55IEppYW5nIDxzb25ueS5qaWFuZ0BhbWQu
Y29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KCj4gLS0tCj4gICB0ZXN0cy9hbWRncHUvdmNuX3Rlc3RzLmMgfCAyIC0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUv
dmNuX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUvdmNuX3Rlc3RzLmMKPiBpbmRleCAwZjViNDI0MS4u
MWNhNjYyOTcgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvYW1kZ3B1L3Zjbl90ZXN0cy5jCj4gKysrIGIv
dGVzdHMvYW1kZ3B1L3Zjbl90ZXN0cy5jCj4gQEAgLTEwMiw4ICsxMDIsNiBAQCBDVV9CT09MIHN1
aXRlX3Zjbl90ZXN0c19lbmFibGUodm9pZCkKPiAgIAkJcmV0dXJuIENVX0ZBTFNFOwo+ICAgCj4g
ICAJZmFtaWx5X2lkID0gZGV2aWNlX2hhbmRsZS0+aW5mby5mYW1pbHlfaWQ7Cj4gLQljaGlwX3Jl
diA9IGRldmljZV9oYW5kbGUtPmluZm8uY2hpcF9yZXY7Cj4gLQljaGlwX2lkID0gZGV2aWNlX2hh
bmRsZS0+aW5mby5jaGlwX2V4dGVybmFsX3JldjsKPiAgIAlhc2ljX2lkID0gZGV2aWNlX2hhbmRs
ZS0+aW5mby5hc2ljX2lkOwo+ICAgCWNoaXBfcmV2ID0gZGV2aWNlX2hhbmRsZS0+aW5mby5jaGlw
X3JldjsKPiAgIAljaGlwX2lkID0gZGV2aWNlX2hhbmRsZS0+aW5mby5jaGlwX2V4dGVybmFsX3Jl
djsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
