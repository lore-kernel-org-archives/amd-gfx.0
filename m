Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EA0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 18:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F6710E681;
	Tue, 22 Feb 2022 18:59:03 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EFF10E906
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 18:59:01 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 d134-20020a4a528c000000b00319244f4b04so18926185oob.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VheWVj3P+wwmtx684KHC01krr9G8bdXDmB67aPVI4jk=;
 b=Utd/0qrVihuIlXANeXucOc2H1BwhnvO7cUimBUbxlu6JZM1Mr9d2gxqBknZcQXg7gk
 QD4cXrSymhgxUaczYy4fHFVt0Rfn5HjWeo1pA6ycu3/n5j0btCPBXIMoFR2F/8wr7yD/
 dSYqxjZgyN5cRgka0prDEaIYkuXtz7jJO2dCzW+HErSw1P61N3woYLOmxwz7VDI77XfE
 t/0dwjnGYuggOJBzG3ml35TFliuj6VaqwVt56929dxL5mVsr5uwdQ201OKSn4gW6qy9r
 GapD6SG0LSJ1hQY8vZb5dgjAf2K1FekHm0Le3hvIL6tIpewDNFfuxcO2wcIDar3zvdZB
 DObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VheWVj3P+wwmtx684KHC01krr9G8bdXDmB67aPVI4jk=;
 b=JQ6o3p0nW8G0dDVJT7kkX8+Rwh4moMflE/2drpJfIXwEHrO0pcDBMpUghSRXhd8J5j
 iCxKFjr/8t90pnfgHMkO32RnkL8drMwlyTnzxXy8woFGQKHc6P993hOe7e7EXFvAoYw8
 m4+GwYWJEf2wQ32HFyqQoVBDu6/JUEx31HYezbjk02rztdgR+GpHBBiw0c5PyfeYQySA
 3iiu9x4pNYvLqe20Gu7k9McihfbCE0sIldOowXWMwp2hLIhN6b7l1gFO7ttR2ijgG2v5
 eAuGE2movueajllfLXo7R6kPaTVEiOviHDBEHYlZUsgTg1Kcs9VRNtCePZc19p5oF9k8
 bsDA==
X-Gm-Message-State: AOAM531qfx9f7uZSD9qjjkdtaKyEAsOjWwkNGdNci/kmExdDo3d+f99i
 lX0ZOA2IWkgiHLGr1SjHJMjn1jQNbvkII4QjOhc=
X-Google-Smtp-Source: ABdhPJw3WpBzk4PUYJCZkjFE3uVIEtfakidFGtcni9pAvOdoID9EpRrICyEfro+mJNsyl4omXnKDIaMitZBGQ5l1cXA=
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr2334257oab.225.1645556340655; Tue, 22
 Feb 2022 10:59:00 -0800 (PST)
MIME-Version: 1.0
References: <d7422e30-a926-a723-f30c-b414f42075be@amd.com>
 <20220222185531.421535-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20220222185531.421535-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Feb 2022 13:58:49 -0500
Message-ID: <CADnq5_M4A+M7mAnO42Y7rLAsLQv4LiTYYQ6NXm=4uC6zv-GA5Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: Print bdf in peer map failure message
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 22, 2022 at 1:56 PM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Print alloc node, peer node and memory domain when peer map fails. This
> is more useful
>
> v2: use dev_err instead of pr_err
>     use bdf for identify peer gpu
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 965af2a08bc0..9141b674947d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1215,8 +1215,15 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>                         peer_pdd->dev->adev, (struct kgd_mem *)mem,
>                         peer_pdd->drm_priv, &table_freed);
>                 if (err) {
> -                       pr_err("Failed to map to gpu %d/%d\n",
> -                              i, args->n_devices);
> +                       struct pci_dev *pdev = peer_pdd->dev->adev->pdev;
> +
> +                       dev_err(dev->adev->dev,
> +                              "Failed to map peer:%04x:%02x:%02x.%d mem_domain:%d\n",
> +                              pci_domain_nr(pdev->bus),
> +                              pdev->bus->number,
> +                              PCI_SLOT(pdev->devfn),
> +                              PCI_FUNC(pdev->devfn),
> +                              ((struct kgd_mem *)mem)->domain);
>                         goto map_memory_to_gpu_failed;
>                 }
>                 args->n_success = i+1;
> --
> 2.25.1
>
