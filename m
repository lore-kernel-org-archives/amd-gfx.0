Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543E3C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 05:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CC0214F1
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 05:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd2yo1NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CC0214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6254F89F41;
	Mon, 14 Sep 2020 05:16:02 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B5289F41
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 05:16:00 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d4so3973151wmd.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2020 22:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QOgD2K6RgFVtdn+pi4DRvNJal9NI3iSeX+M3t6zDXGQ=;
 b=dd2yo1NO5UZeKkA4zO6rEfObNc8gdaZXXku5u+VXkaD0Ob2hJeNCudHJsm+nYQ6gCP
 BP1AWDlPiSaDNkQfeD9+EJi6pJ9I+/NYzPuWbbbVh50zCu2Gg4HTnzURlSSB87yHDhVt
 mZ5LIKElUGIwfMIrSawu09+paVYKPl/EUQhZFeGfQzeHM5gcEQCaLoliSjbJqxOg3DXx
 8W9FPNUtPbpjyF3ZCHHYWo0WIechB8OmfKSVFMMLC0/8GD60dF8cAuhrIgcVbkSR3lDl
 KJSN2A18ED9W5yYCTVfS9zWs4nutSrFqvBcducVWCnCD/6lLLWWW4UCDz8w3b64obvSn
 KzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QOgD2K6RgFVtdn+pi4DRvNJal9NI3iSeX+M3t6zDXGQ=;
 b=LC/CC9eL53X96TKGd35GfGxMPjBgWZw3twV9gsUwUssbFgSng8eeQxDnGpyr1sAHIg
 M5MElNF6fQWvCCbXY98t9vU1otU55UwrW22vIB/0W1IvnI7R7pHm2DnYtneELdeyulBF
 ZBCEaGWmyaMXiAtStJbk4ZiMrJtRs/KWvLGvSUv6uzngtEsVzOg5eSPiY4H3wPe0sb9v
 y6Lxj5U5BOdpYQ8BwMI1JrBgZ8+26JrdD+LLMStBXZ2jxiuIzx9oKsYXzKdCQ0aSAGTv
 8FSDbMdKIFmbZOjvtpIE1rPrEMfg35rs3plU2QzTWnjFmnw9vRTwFhhlq1VQvwI35eja
 SQEA==
X-Gm-Message-State: AOAM530wti1odirNWHke9IKN4TDoLGuE0GbsS3J6t6YPPshx3ojbNlR4
 kBhS5vbVSY3Sl4sk8pqbhJa5w+ggZViwJWBFvxk=
X-Google-Smtp-Source: ABdhPJyzll/7gAu9Fkda2d/gNB35pAd3c6ORdpgZHmnZNxAnleyxXMMtKZssAw4SRiabC/ic4S3GK2fKuLBexg/Rdsw=
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr13148336wmc.39.1600060559552; 
 Sun, 13 Sep 2020 22:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200911220240.2848-1-rohit.khaire@amd.com>
In-Reply-To: <20200911220240.2848-1-rohit.khaire@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2020 01:15:48 -0400
Message-ID: <CADnq5_Mhid2qV+cq8ywjrBSoKedjdf1gnMO13Wv+8JBWK0FbZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue
 for SRIOV
To: Rohit Khaire <rohit.khaire@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 11, 2020 at 6:03 PM Rohit Khaire <rohit.khaire@amd.com> wrote:
>
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 7429f30398b9..fdfa075e6d5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -51,8 +51,20 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
>
>  static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
>  {
> -       u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
> +       u32 tmp;
>
> +       /*
> +        * On SRIOV VF RCC_DEV0_EPF0_STRAP is blocked.
> +        * So we read rev_id from PCI config space.
> +        */
> +       if (amdgpu_sriov_vf(adev)) {
> +               pci_read_config_dword(adev->pdev, PCI_REVISION_ID, &tmp);

This is not going to do what you want.  The pci revision id is not the
same as the ati rev id.  If you actually want the pci revision id, we
already have it in adev->pdev->revision, no need to fetch it directly.

Alex


> +               /* Revision ID is the least significant 8 bits */
> +               tmp &= 0xFF;
> +               return tmp;
> +       }
> +
> +       tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
>         tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
>         tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
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
