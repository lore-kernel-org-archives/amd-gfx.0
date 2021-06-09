Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5AC48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E91613EE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E91613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576A46E098;
	Wed,  9 Jun 2021 21:08:21 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F6F6E098
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 21:08:20 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 6-20020a9d07860000b02903e83bf8f8fcso12335817oto.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jun 2021 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7rfZBfY1zc8KULYKkCDWiEa41Bb0UK6DpT86yaIUhCQ=;
 b=MWhCUawgGy+3MjjniFznpY0f+Tak8L1e1CX0xrsEaniyKyBFpD1xmOFXmZg+dJdVs5
 3qZeL7HSKvW6vB4Hs0pmmF0NNwrtusRweR5TTYo6v/FtDhqCzoC4Oen2WfCyKB2nNPtB
 04jmveNZ+hgvwyieeZMnWo7yJxCyMsEG/XM8qSUg5Xfnmj6QbRM+aV/Os4P80B1Iyalg
 I5f3stXzkRAn5oAI++OQxK1Tof7ndDIERDYNXcDs4DNqyayRB6/eNoBrtwe5KZtqqbKN
 Sw0Wvgsu9MhqByb/QJ9c7v3x5BmGLAPjTE92ivmROwu0G1S83p/5S4wyAzFEAZM2qn2y
 kC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7rfZBfY1zc8KULYKkCDWiEa41Bb0UK6DpT86yaIUhCQ=;
 b=RztK2Zf/kJnFGiHVLYOV68rdPvFEs+/3XEcuroOhVzvURDBI79Mna2YAKl3X8u3Tp7
 dfEV37oFgxPrwmbK0ea07HGGiC82+I1yc+hPq8Z7J6W4IR4hvT01k46IVKQWLTUZcOx5
 e3quX5R5yYWF/aFlRZGZn17uSTzxJysN7ydfVyLqmkXSnjmX7jqO96GCtel0ND+UqOTF
 JljV6AEbGO+C3cbtid8Kk8hCPc65L5GKplJ8JAttQXrR2lqxti26IRu3QHEr/yXFnveW
 TbxoGdpRm1VatPvJ+6aFs7idn+mhDz5dl85bGAJPcKUvAcIMtU+dLcA6rg4rj3Dbo2Dq
 GTZw==
X-Gm-Message-State: AOAM533lbL+0GxonRyin/DEoE+ECh1a38L9HjLUC+3HbnKJmkEwLhyOx
 uX9EU8UqwJgQTUPNeKlmQp16puKjK9GSEa9+XPY=
X-Google-Smtp-Source: ABdhPJzLlROzMsuu7wrDWKhVZNOmcKLQjm6O+IN8ddUx4N6mSZQu3Ap5If0431MgouxZTquIWplDnnJ5KtjT25/TI7U=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr1134765otr.23.1623272899560; 
 Wed, 09 Jun 2021 14:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210603104208.5725-1-PengJu.Zhou@amd.com>
 <20210603104208.5725-2-PengJu.Zhou@amd.com>
In-Reply-To: <20210603104208.5725-2-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Jun 2021 17:08:08 -0400
Message-ID: <CADnq5_PCKfhUiDjLYQUkLjc79kCUZe+tpa-UT4pVCT++my45Mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 3, 2021 at 6:42 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> The original code returns IP version of instantce_0 for every IP. This implementation may be correct for most of IPs.
>
> However, for certain IP block (VCN for example), it may have 2 instances and
> both of them have the same hw_id, BUT they have different revision number (0 and 1).
>
> In this case, the original amdgpu_discovery_get_ip_version cannot correct reflects
> the result and returns false information
>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 99255c2f08f4..f949ed8bfd9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -325,7 +325,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
> +int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>                                     int *major, int *minor, int *revision)
>  {
>         struct binary_header *bhdr;
> @@ -357,7 +357,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
>                 for (j = 0; j < num_ips; j++) {
>                         ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
>
> -                       if (le16_to_cpu(ip->hw_id) == hw_id) {
> +                       if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
>                                 if (major)
>                                         *major = ip->major;
>                                 if (minor)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 1b1ae21b1037..02e340cd3a38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -30,7 +30,7 @@
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
>  void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
> +int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>                                      int *major, int *minor, int *revision);
>  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
