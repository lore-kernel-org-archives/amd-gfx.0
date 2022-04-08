Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6718BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 12:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E7E10F0E6;
	Fri,  8 Apr 2022 12:24:18 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A762510F0E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 12:24:16 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id b33so4609426qkp.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8haz9lNrCzMYJFl+uLA+182ZFMIOXnM8/RRm392oPho=;
 b=A4FUn17kyBYqCNR8g2NaFlrL5gKyTS37EeJ/C0tnJUrJwJQVXyrMt3vJQzSiqVSX82
 1h8ngaWW1lEzQP3cvM8NZf47Lk9LYj24h9wpCRDBE5iFFPFAK8cxhX4XNB5NFF+XPLYV
 zLPkSVVyNL0RsrO9Ug3elsaXgOUP/fTNnXHPfkAS8hK9PgmP9KkFfSFkSu2JNzbW9x0I
 auiq/eA/ox6Mndrg5OWilIP/UoAnguOHIuZgC71iPErvRMudjrd5djFIfTNwDIsv6MKl
 VDhHdmQt4lv5IqaFef5ARHcaf427lo5ARxlhOAXTPP9nKBt6OeKGqhnf7FcsgQSpWzmE
 xq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8haz9lNrCzMYJFl+uLA+182ZFMIOXnM8/RRm392oPho=;
 b=UJ5WupNXinUwUH0Ot+v+xcCkVAUCvk3/mBHMm5I+V++vwOAXcyCs/4mSiz5i4iMi/G
 R9oTNypyrNDYp2Zg/geDvlcg27M0tWbvu/cNh+eeLU1C9xO4FDRXee4Q1VCWKuZXXrcl
 14D8jXsUjXD5ryK1S3OSCeKH3VLwx3ei2ogh8k1/hxz77z52aNzlfvyoc+XXkMrV1W3F
 q/GCQfsHMXo8UPWHKJDZswDUjP7Yv3t7WUb1rU2WJOQy40twC5aTfHXfzLP8RdCYcZiS
 vccWikTllWRhPxeAvfmS20iXuWcHbQO5Fk9SfHn7ljspN+nWq0sG1skMvex/VTsD8Esa
 JX2Q==
X-Gm-Message-State: AOAM531kaq5oFK9NH6AUOcmozhado69cndslsgFCikigQXvanwOVH9GW
 tHMHhn6Zhy7wxh4YS/OOt4Dk5atFBD1YP95h5sw=
X-Google-Smtp-Source: ABdhPJxyL5kwNwp3b/oQUiLEGUSzemWHGVaDVlrX2f62Eu8RCDrh/yRXM9YGpnx6ItoAhmghA2furFp3hZuX7EkFFsE=
X-Received: by 2002:a05:620a:1722:b0:67d:8efe:d4e8 with SMTP id
 az34-20020a05620a172200b0067d8efed4e8mr12746119qkb.327.1649420655726; Fri, 08
 Apr 2022 05:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
In-Reply-To: <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 8 Apr 2022 17:24:04 +0500
Message-ID: <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: thomas.hellstrom@linux.intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Ken.Xue@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 8 Apr 2022 at 16:13, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:

> I own you a beer.
>
> I still don't know what happens here, but that makes at least a bit more
> sense than a patch which only changes comments :)
>
> Looks like we are missing something here. Can I send you a patch to try
> something later today?

Yes, please feel free to send me a patch for testing.

--=20
Best Regards,
Mike Gavrilov.
