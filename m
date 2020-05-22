Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B453C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F022420723
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuaG5W5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F022420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A785F6E0F0;
	Fri, 22 May 2020 19:46:36 +0000 (UTC)
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com
 [IPv6:2607:f8b0:4864:20::e42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5930D6E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:46:35 +0000 (UTC)
Received: by mail-vs1-xe42.google.com with SMTP id v26so6745655vsa.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fICEZpw1ZzqGRCoFN+tYpLN/t4NbLeHOSKGpTMZmjg4=;
 b=tuaG5W5ZB7fKvoc0Id2lwJW6JqZBLmsjb0yOJk7u9BRr8qpRQFhhHiPgvloRpnAlms
 pDQZgmj+cDbp87qd8NPrWUtZ53mTajDhsG/EMr4gzBM5+DiRyXYBmC03/yv4wkyRIWZt
 Uzn2PrpT5b7vKX1DHdfFFb8QDwUPKSHlI98yBrLJvz9I6rXCmAlGWZjRsTgvIJu4PfUU
 QXnhw4+Efqd4Q3SAKRoLkHeazTNQjGonoRm2Tn8iE6igNgV944SfdJ7JET1Ntg7x6g6v
 77j1G4FSq3H3Iil9hnsUI8rW58Hf3gFfIBlE+5mVBpTgfOPMxSwH9DgLC3YgY87g+bAL
 jLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fICEZpw1ZzqGRCoFN+tYpLN/t4NbLeHOSKGpTMZmjg4=;
 b=fjH9KnTE+wJ9dYb4Kjgr9C6ofJM8mwVEyxsRTaFUqKixHE8hEnzzZXgGCaVpn87/Qk
 HAKBCxGkFtGOcOqVIui2nSJUz2KSiUfkIrGxp6W++QXfP9/iUnoeS1KEsfgfIEILrvH3
 0BZcoB1VRAwXU3E/+ZqbeNk0FYx/JDyiWVx+5+XdciuLQxInLZ/bpZ5r7s0avtNfEnct
 M2idGTuOkz7+eRkkHUEl39IU3O0mNCdGgofdJwLENRCFsCLLJsnEInvDbSXmAL9S258N
 s1Etyr+VwTWYe55vPNDDuUtXzCpcYBC3cY6hSoBp6W1CJj18ebJ9vEP4j18En7U9JSGp
 HCcA==
X-Gm-Message-State: AOAM531I8/VfJVa7HQ/lahe2TLY7eWrjY8Oq7hUECIPm+54nTVvbgplq
 5YwcVwJa/Mpau2qUrz0eFQNEas2p3U/mUtErxX9dU1Y2
X-Google-Smtp-Source: ABdhPJxdfe0Y6Cxl0k7LkeefJ0YHeWXX/bdjUvUfP+Fntt1RS7Pjo1e8J1cKlBFGtEcPGKDW39PKlpY3jttkJg9WySY=
X-Received: by 2002:a67:de0a:: with SMTP id q10mr12804872vsk.138.1590176794430; 
 Fri, 22 May 2020 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <yNYwUfXpw0k-V5poEVGOZXgeP4zwnuUn8MEJYolwxL7VXfEa99STFAtLPlqlbElXGpqH5a5oyozz4XfnSRg1DCFzqYFbEHTiF5UtwGAmviA=@emersion.fr>
In-Reply-To: <yNYwUfXpw0k-V5poEVGOZXgeP4zwnuUn8MEJYolwxL7VXfEa99STFAtLPlqlbElXGpqH5a5oyozz4XfnSRg1DCFzqYFbEHTiF5UtwGAmviA=@emersion.fr>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 22 May 2020 20:43:36 +0100
Message-ID: <CACvgo52rE4E+6B7NNM8=tPPsu3ouOP9MnY4CNCsDsN8U_odSeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix leftover drm_gem_object_put_unlocked call
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 22 May 2020 at 20:38, Simon Ser <contact@emersion.fr> wrote:
>
> drm_gem_object_put_unlocked has been renamed to drm_gem_object_put.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Fixes: e07ddb0ce7cd ("drm/amd: remove _unlocked suffix in drm_gem_object_put_unlocked")
Wrong tag it seems. At that commit, the amdgpu code uses it's own
wrapper - amdgpu_bo_unref()

-Emil
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
