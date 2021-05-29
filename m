Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B106C47090
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 18:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D803A61005
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 18:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D803A61005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B4F6E5C3;
	Sat, 29 May 2021 18:44:40 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04AB6E5B6;
 Sat, 29 May 2021 18:44:38 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id g12so785410qvx.12;
 Sat, 29 May 2021 11:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=W4sY0Wie0MJZ2Hwlpjip2gvxEcx/kwsNggyPuijsEJY=;
 b=L/PqxFagH57z0outL+L9mEEONORYFl4Vmx7Bfhh/0qE4XudCliCdiyCUr48VscD/d9
 i6d282R+j5Vp1NReTrsmu7AAQ6CIiiSKjWpbk7l03pqpKUUQnzt34h6/dEQUB0q7N/hX
 iFY70t3h9VcGey9vxoc1+AI49QWxEGMo4TxIaVjUNp+Yy6jlKg8ca6FBtBR1SAijc+CV
 2hbj4PoQ5f5BZJac8UMtb872y6fEeeNxtX7jVq6hzvyGD2QKwCvvcxSRDu/u8fU5mTZt
 vUZp027RUC06J89CuEEJ0t2TRmnoPRwu0E2L4vqR4ng7wM984rE268ULZAssJ4oh88Bb
 aRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=W4sY0Wie0MJZ2Hwlpjip2gvxEcx/kwsNggyPuijsEJY=;
 b=FHurzCymn3X983g18AlvKvTelXVCt5R7SadNJqqKvpHuua1S6VfeDfdk5s5Z+EHcON
 Xn7RO0FtyfrF+SxPlTKxy7mufo3eeciILDCSsS+uWKNInI8K3mwTMjZnYArDXNIoyEds
 MsiKBS5Pv28OdW1+mRHKEEHdO3YYJ4KgKuo66XpglLj2GeI3g1IgsTAgF+rSwtzfJry7
 c/eazngHBMwDpThHkgKLI+XMvyzBdPFi8HU1vszFsXgufh1vFeqM+G1pF/0ZXdqDdNQm
 xn9IeerM88e5BxEe7UFbzYVmcO8PfY26/CclWF+U5x1+booL8dhkbHYtn3REdEtSoPSa
 hASA==
X-Gm-Message-State: AOAM531Bn1zBURItrSyRfy0KeD+HoxhUh2FpIGCDD52+9UOiD7JnxNDj
 tynWDj9y7LC0+QDNPYT8V8A=
X-Google-Smtp-Source: ABdhPJxt4OrKu6VD+FgQYyXRlz8i46KZUPGzP/9eoAqtoqVIT4pASMrzimWB98Y2KLatv5Xk1MkL3Q==
X-Received: by 2002:a05:6214:19ed:: with SMTP id
 q13mr1852035qvc.13.1622313877892; 
 Sat, 29 May 2021 11:44:37 -0700 (PDT)
Received: from [192.168.2.100]
 (lnsm1-toronto42-142-116-203-225.internet.virginmobile.ca. [142.116.203.225])
 by smtp.gmail.com with ESMTPSA id 90sm5785231qtg.9.2021.05.29.11.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 May 2021 11:44:37 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] mm: changes to unref pages with Generic type
To: Christoph Hellwig <hch@lst.de>
References: <20210527230809.3701-1-Felix.Kuehling@amd.com>
 <20210527230809.3701-6-Felix.Kuehling@amd.com>
 <20210529064227.GD15834@lst.de>
From: Felix Kuehling <felix.kuehling@gmail.com>
Message-ID: <b4405335-80c8-3691-f9a8-93642f495f96@gmail.com>
Date: Sat, 29 May 2021 14:44:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529064227.GD15834@lst.de>
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
Cc: Alex Sierra <alex.sierra@amd.com>, felix.kuehling@amd.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, jglisse@redhat.com,
 amd-gfx@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org
Content-Type: multipart/mixed; boundary="===============1182782387=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1182782387==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G3x3cxLwvm5sc2boVqly3ItrkYb9GqxBZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G3x3cxLwvm5sc2boVqly3ItrkYb9GqxBZ
Content-Type: multipart/mixed; boundary="jrXdr3e58CvRgT6KVy1fCOy9S5n1wBl1G";
 protected-headers="v1"
From: Felix Kuehling <felix.kuehling@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: felix.kuehling@amd.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 jglisse@redhat.com, jgg@nvidia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Sierra <alex.sierra@amd.com>
Message-ID: <b4405335-80c8-3691-f9a8-93642f495f96@gmail.com>
Subject: Re: [RFC PATCH 5/5] mm: changes to unref pages with Generic type
References: <20210527230809.3701-1-Felix.Kuehling@amd.com>
 <20210527230809.3701-6-Felix.Kuehling@amd.com>
 <20210529064227.GD15834@lst.de>
In-Reply-To: <20210529064227.GD15834@lst.de>

--jrXdr3e58CvRgT6KVy1fCOy9S5n1wBl1G
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Am 2021-05-29 um 2:42 a.m. schrieb Christoph Hellwig:
> On Thu, May 27, 2021 at 07:08:09PM -0400, Felix Kuehling wrote:
>> From: Alex Sierra <alex.sierra@amd.com>
>>
>> pages in device mapping refcounts are 1-based, instead
>> of 0-based. If refcount 1, means it can be freed.
>> This logic is not set for Generic memory type. Therefore,
>> its release is threated as a normal page, instead of
>> the callback device driver release it.
> So we really need to stop this magic one off refcount.  We had a WIP
> patchset to do that, and we need to finish that off instad of piling on=

> more hacks.

Sure. I'll be happy to help with that, if I can.

Thanks,
=C2=A0 Felix




--jrXdr3e58CvRgT6KVy1fCOy9S5n1wBl1G--

--G3x3cxLwvm5sc2boVqly3ItrkYb9GqxBZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABEIACMWIQSF9iw3xYpcigJ58/LWGSsMBQyTdgUCYLKLlAUDAAAAAAAKCRDWGSsMBQyTdjwj
AP0ehjdAXulaksrA6QcEpLPvPkwAgJ6/sP8IH2UwLePEegEAkJ4lZc22/kA41GXHo0JfTygUH6ww
FLXRuBcMwz0nzPw=
=cNv8
-----END PGP SIGNATURE-----

--G3x3cxLwvm5sc2boVqly3ItrkYb9GqxBZ--

--===============1182782387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1182782387==--
