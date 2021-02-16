Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89D8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA5C64E02
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA5C64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A5C6E42A;
	Tue, 16 Feb 2021 14:41:26 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8246E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 14:41:24 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id 6so1483089ois.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X29xc5XEWoXK8eVJGRdRZXJ/BjEeXhj4HcfC6C0hVP0=;
 b=ZS9l7OwmbrvD06tGy+BsSThnwFFUhRrHLe04Rp7zvHnfbmJbEHNotJ6/HUWoEV9GOT
 NErb+JIiiN/QvbeAHECiih66N7L1K39YGH/rtS/1TJ9O/Q2WPPFApL4upnUwQszNsYCs
 JSX+ZWoc1dj5ECi4MDO8SsrAMK+H1UGbwEf/pZxUhkyNwDfCllNLNj14WbH90XQfJ2fH
 t7k5v9n6qTU8dkkihkOabgYi5xbV084LIjk9l6X9dHLaNYlP9ptAg45w8GaaXew5mOFg
 wyhrYe57FNBTbgXMkPuY17yASjOZyMl777FNViKPtn/r8a5PRa8ot0iPCd3inVRGyFSp
 GJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X29xc5XEWoXK8eVJGRdRZXJ/BjEeXhj4HcfC6C0hVP0=;
 b=UktAxd/8NsBYsSgu7lWo1Lhxojd8GbLHn62YZ0sAc7TTMYnESn47DKAXdMp34QQnGA
 +e5KzTcZQFNU8/ClA4p0po/wpNtrs5MwPfPox7XoduWwlZ1CA2l/7598wT31PBNSO0fy
 /t2e6tGSSuy6dZw1dtn+RJ4ATG4jflcpYTqj5RS5RfM8labNDekKp3MkOW4N2HuXE4P1
 2YIWsSgBErJHIefzSLc16wnsw2sGjFN+fAdEPHSfXBIODpy0gj7b8o+1nrUvskYPEpBS
 Ue2WIya3te/al90zXCdQvMat4YcPeqNQEUvqTaGAk1cB2P5PtW9igqvzvdV4JPlZe5uf
 EQVQ==
X-Gm-Message-State: AOAM531EWNyXuDalATjADA1TdVVy0fqtsyU/g21ivxGlzBuvFyuu3jBz
 0b6xTo5491vBSfQgCpmj+nZH+iQnJB4jARFPW80=
X-Google-Smtp-Source: ABdhPJw+VtHXHkCmgb5wE6SaMm4+HeEpttMEj+paWjyjspPbPEpFpUVdIYt5W7lrN8wLmNukPDFbqNPENQOcOzx8OIY=
X-Received: by 2002:aca:c786:: with SMTP id x128mr2754856oif.120.1613486483834; 
 Tue, 16 Feb 2021 06:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20210216143946.38861-1-nirmoy.das@amd.com>
In-Reply-To: <20210216143946.38861-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Feb 2021 09:41:12 -0500
Message-ID: <CADnq5_M0FNdMVEVq9X8uhoF5EbsmEQLwk=GM5ieaP10xHcuTMg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: mark local function as static
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 16, 2021 at 9:40 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Mark amdgpu_ras_debugfs_create_ctrl_node() as static.
>
> Fixes: 0ec7b4385 ("drm/amdgpu: do not keep debugfs dentry")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b504914519ce..93699ea4860c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1137,7 +1137,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
>   *
>   */
>  /* debugfs begin */
> -struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
> +static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>         struct dentry *dir;
> --
> 2.30.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
