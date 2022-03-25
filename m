Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB867C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 14:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E9710E409;
	Fri, 25 Mar 2022 14:24:00 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F0810E409
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 14:23:58 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 w17-20020a056830111100b005b22c584b93so5574148otq.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XxomRDYpp0CEAlwmC50/bOBHtB5U0plwq2TXuHs+pgM=;
 b=RyK/0xXpG60xSqH97NWPfmr5NU02kxTnffKJo3OvKg/SrVtpIIp0VZg06DYUvJC8lk
 YIrf7DkQ3+GsXu8gASwljb/zo5Bv6I5KivIjff7ufZ7R6HbuUurgzt6E3td64HX1eMLs
 7NLo2Cfz+m9XCK97N0TlIeJ4ukz32FWoFHEal922duUkcL1bs+M+7LOZlP+ip7TA3Qsp
 oKb4ZwUANn8qYSv79xEAJhqKmxrl1FHidjV52mFzT6WlDvOoPhriChdEGCmgWy7FnLpz
 1HcD6nMaqEgp9HwIcmw0wwT27/Wt17iMjKq64oVEwDRhMNLx/ACXAC5PpHzlnYzUNAyM
 sblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XxomRDYpp0CEAlwmC50/bOBHtB5U0plwq2TXuHs+pgM=;
 b=KPSpfiboJLebssvcvV05wmI75uSp3R/6Dd6Kb9QXHoAfBPjxSjUE8qd4xarXFl/XAm
 CXStzJz/WqYkw6GtG6IBYxwabrvLGDFY36gv0dG5JBrLfScl6I6Ko/IKb/VKkFq8YLfG
 EpbV7qD5HLRL6F+wTzycw98bzk3s7o6ZGwIWdUCQGiTpJp4yjIJc0BOBtqRsxcvWwPb/
 LnzDNeIl/B1lwD8DJYXf0xNXQlMdyUK1/Z02dnk15ZHrP9a8V76Z3iJmfzt7iM9E4P/9
 AjL09qyCCipl0ChXCwlUQuy0w6pRKNvx4mg5k+vYd/HXeNbBipJcY52VUwgVISUEmvEe
 Glug==
X-Gm-Message-State: AOAM531zoK/O1DFKS8GmqGwE3QF5g062LqL+0ux+1K89i7EpG776RyB+
 tw2yEmVALM3J/Dr/oRRH/SKvc1HA16wt7vvBgcE=
X-Google-Smtp-Source: ABdhPJxN7oDWHFWdRiTo3kLVJKUbvsoMlJeX5sLxJmkghGNzf58smZ8LO5s2SsGpmHIZJeQofMbxjdA24W4V1+hs0QQ=
X-Received: by 2002:a05:6830:10c3:b0:5cd:481a:148a with SMTP id
 z3-20020a05683010c300b005cd481a148amr4408585oto.200.1648218236623; Fri, 25
 Mar 2022 07:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220325094145.311420-1-christian.koenig@amd.com>
In-Reply-To: <20220325094145.311420-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Mar 2022 10:23:45 -0400
Message-ID: <CADnq5_PqtD_pf_yWdHztKrnh6ORg_Qxqo8LwdJ=aCgsTrjUBbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix some kerneldoc in the VM code
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 25, 2022 at 5:41 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Fix two incorrect kerneldocs for the recent VM code changes.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 48f326609976..fa4def290dec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -89,7 +89,7 @@ struct amdgpu_prt_cb {
>  };
>
>  /**
> - * amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
> + * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush seque=
nce
>   */
>  struct amdgpu_vm_tlb_seq_cb {
>         /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index a821ada5f8ca..ecd8a3d60803 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -620,7 +620,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *a=
dev,
>  }
>
>  /**
> - * amdgpu_vm_free_table - fre one PD/PT
> + * amdgpu_vm_pt_free - fre one PD/PT

typo: fre -> free
With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>   *
>   * @entry: PDE to free
>   */
> --
> 2.25.1
>
