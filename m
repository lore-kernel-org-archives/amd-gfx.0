Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8052BC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 12:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C35310E246;
	Tue,  6 Jun 2023 12:38:19 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAEC10E246
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 12:38:17 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-3f812691b52so6675531cf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686055096; x=1688647096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhd8VWqt4ozQLDu9T328utc1qu/cmrxBuXUkVH+OC3Q=;
 b=bY3lzK9pRZ5fzLbzYMlqxUsYT8xwTN0ELQufN3m8NPJFs1cY8zteB0DI7wGaMd0mFm
 95ztLfw1u0ZvW9w4AVG5p4bVrbaXxhcY2EwyUYC/m4E9i4rDIZPGzD18hFlRg0OczT/W
 ZtVBGg7EDh2YojG/ehtTrIv5eLySCgQLy3zuMWE8TWlcQgvaajPZiW9kfKwSs6/QHbvi
 sDvS3BVdF4nC0udx4uxLHdRz7SfH5qJuh2cOvu8jsoyFeL79Ao7w6+wSvz1bexJmKxRP
 gvRxzXXFT1GW99sz77bGolrVaPJ9nJPyFGZKCkmfO3riDNoZ1l74rICIGjVweDV37Okh
 nkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686055096; x=1688647096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhd8VWqt4ozQLDu9T328utc1qu/cmrxBuXUkVH+OC3Q=;
 b=luQN+GbT2Ho4i6qdSt20a1EoforOOkXsPbpfMsHuGflfvbvRlN7DxhpSjzg6PKVF3z
 8Ik9efq/WdIoofXnnmtczFHIXdQ/f5r/5Zm37E0/OxygqpcJafR2SbGNLrxm1ai64CmV
 nbj1NVwudAtmqoIIDf2oERUeqDLgZy9kA9gOl+Uj3Q3TihGljIlSMGdOoFyfe8o/XfAL
 9al8g+ZKRqKLiu+FWH9kkMKe+NOS+05O67+A1coOLnXN9wbcwtvwHMX+RNU2DCTOW5iW
 nYqOuwTPy0ZLW4RIK1QfLG91PCUMAlrfvGnK9ifExkduv/dIP+qAlXYjMCT4T1TmQZcU
 Ogew==
X-Gm-Message-State: AC+VfDxNJeE/d76MgaPma37EAiRgAf1vAehW6gRGonmqd9hj9PIbcIuX
 gUKa/UL5imKwM7QgTPXTroo8e7+guG1Zhnrv9i4=
X-Google-Smtp-Source: ACHHUZ5GwR8AQvuEN2rpIKKlX3fJvdn31fvWA138R3mLyUiT+pirfKiqNev7W5b3BqM79Pl2XsRgEqFJKipnfAcBols=
X-Received: by 2002:a05:622a:1a94:b0:3f8:46d:dacc with SMTP id
 s20-20020a05622a1a9400b003f8046ddaccmr2122066qtc.2.1686055095889; Tue, 06 Jun
 2023 05:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230605091122.3363-1-christian.koenig@amd.com>
 <20230605091122.3363-2-christian.koenig@amd.com>
In-Reply-To: <20230605091122.3363-2-christian.koenig@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 6 Jun 2023 17:38:05 +0500
Message-ID: <CABXGCsObR5Ng2fqR2u4t2SOOWHmTzZS9bOjF-BBjKKDJtOTP7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: make sure that BOs have a backing store
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Guchun.Chen@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 5, 2023 at 2:11=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It's perfectly possible that the BO is about to be destroyed and doesn't
> have a backing store associated with it.
>

Thanks Christian. I appreciate your brilliant work.
"KASAN: null-ptr-deref in range
[0x0000000000000010-0x0000000000000017]" finally fixed.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
