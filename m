Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D0C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B17206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcJIRkRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B17206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89966E8EF;
	Tue, 15 Sep 2020 18:58:09 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD86F6E8EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:58:08 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id w2so515234wmi.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xvr9fTfMFVqJ/uzqd9K3LO47QcTnEFfkcTngzoFzKLY=;
 b=AcJIRkRp1Sz6PVGrHCAOk+wWHy99Izl7aw51ZjnBDttOsHsjTme39/ozOXlILo2iZC
 g+pbUonbR7DWcPpPG0hXBZ4W0w3SxCWnx3dAU04Uii40qM5iAjYa/FOIg90B2c1ewKNp
 6W4hDizc60pohWSWHoNy3BoJgKgyRDgosYM//W9BK7VEH1VAn2650TBNQXaB0zJx9FCE
 MSlliYQzJ6/HF3nbN67cAo1ofUuuG80vGhLN+dH+A37XwNziYuRh8jJ6ZvwAjtIEvGaF
 Suy60O40VMWsHiKWSb58BIGxw2SsvkOp5f0zpKOLDn5Civ434akUH6QSV/n5W9V/utMR
 EA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xvr9fTfMFVqJ/uzqd9K3LO47QcTnEFfkcTngzoFzKLY=;
 b=p8Uz1lR8vO54bR9rMqg/cokIJHbxeJEn6uTWsF1yDNKznojITZ1+me37bg0EB8sDQx
 ZbToD+zuVavzJMhE1wZf/xtG9lE7NambZGikNb/YXJ/5/waIEVgmeEJie28PiEcHi/Eo
 uNYaB8AU3z4UVbv0d0zj9fpVmTcnvymbi0S99ZcGkJjU5kP68O1Qx1PWKICaH2wKA9BQ
 w72LqZ9xKcUfPuwiE7I7/8MPn8I0I/+QMQ+8nG6T88uh2TpF1XKkWelEy5uBX5KTP4/r
 YojIs+koEJQv1X/q+F4P4jvJspcvSwtCJSi1/45p/IS5Ec/pKiseYXgHj/WGE11062mi
 /3/Q==
X-Gm-Message-State: AOAM533lC8Ww3QTusaMRqWVRZarnpFzsvX1UvBSjoBYdJAOxvRBUADKw
 ELnh5FEeoj3jSk+61d9ZNmtl4jYQCNbRGKNyB/Guk7CY
X-Google-Smtp-Source: ABdhPJxb1UkTpc/pt0qW0+G+z1Q8KrcehInqsOJEsLNjUUgjn+d+YOMswjZXSLgliKdR6PZDWAORM3bHgSDmfPw7UeQ=
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr754923wmc.39.1600196287403;
 Tue, 15 Sep 2020 11:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200903210614.22785-1-mcoffin13@gmail.com>
 <DM6PR12MB26197CFA234BDBBB955B4A69E4260@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197CFA234BDBBB955B4A69E4260@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 14:57:56 -0400
Message-ID: <CADnq5_N-k1OJJahXJFVn6EWNi8tR4+449eXWD2-W1yrfvZbTVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Account for extra separator characters in
 sysfs interface
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: Matt Coffin <mcoffin13@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Sep 8, 2020 at 9:54 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Matt Coffin
> Sent: Friday, September 4, 2020 5:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Matt Coffin <mcoffin13@gmail.com>
> Subject: [PATCH] drm/amdgpu/pm: Account for extra separator characters in sysfs interface
>
> Currently, the the input to the pp_od_clk_voltage sysfs interface has
> two adjacent separator characters, i.e. "\n\0", then we try to parse an
> argument out of the empty string, whereas we really should just ignore
> this case, and treat any number of adjacent separators as one separator
> for arguments.
>
> We do this here by simply skipping the argument parsing for all
> empy-string arguments.
>
> An example test case would be `echo 's  1 900' > pp_od_clk_voltage`
> (note the two spaces after the 's'.
>
> This also solves the issue where the written string ends with both a
> newline, and a nul-terminator, '\n\0', as is the case for `echo 's 1
> 900' > pp_od_clk_voltage` since the recent rebase.
>
> Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 65f141c777c2..9ab29c21e458 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -801,6 +801,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>  while (isspace(*++tmp_str));
>
>  while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
> +if (strlen(sub_str) == 0)
> +continue;
>  ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
>  if (ret)
>  return -EINVAL;
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cee0ba53db6a34135168908d8504d3f67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637347640051630594&amp;sdata=MPjsHvjwbERjeLSsQHWymlnqav1O9XlF8DJoGvJpx%2BM%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
