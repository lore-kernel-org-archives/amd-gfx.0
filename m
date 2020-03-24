Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC21C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 15:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DDC20714
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 15:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJrXL/iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DDC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01DD8991A;
	Tue, 24 Mar 2020 15:34:37 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED7D68991A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 15:34:36 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c81so3684646wmd.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FjQmjMPBA1WBkja8A6wE980z3EM+394AlsY3fidYN+k=;
 b=sJrXL/iYFbz/uAFUrghwnql3WGl8O28mUh4PctrHB6c1evCMcwpeyoXq1yySn+9nkQ
 /zXtz61o2c/cT+NmTT5zBppL/Jzs59FDeSXUOa96YrnPYfGDmeZUfk+zpK/8hnFpZkBF
 h+zEgts36JbQBNqn+MA1uwwXycR37B6IEtlDqhswcwVp7Srz6lQL/Go1ZS7mTia3vKva
 6rslOmYmEtRTRLAY7E7O6lQfdDicunXleC74+5+vnlN+rZPOnlqzroRpdCKfqqyRxygW
 4VwVW/jbxT9divxv3JQb4DCNNP+eaoMVYdwDXjqaNXjMJY2CVrVUHqiTyXmEg78iKmFg
 jRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FjQmjMPBA1WBkja8A6wE980z3EM+394AlsY3fidYN+k=;
 b=LHHiuWaVGPmkHQsqs5R5FTdDw09rA4GRkilJkEWFF64fXUbUYyNVU9ORv+tP7e9Z3H
 2kLixr+TkbMMDhJBnNvhMP2h1q4UsV962CsfvxtcFnH7zXDFz+/EnIslazad15zPJaw8
 w/sZUr+POYXibNEW6iyQN6KUA5L7mPFBAbxBK6f6m1FGW1svoa69pHJKVbsLO2WZvfTG
 pywH8WL6qSDnD5WHDZtMU00pkb7LTsIfZrtax6axWuV3UaMCfWesEzZIQzB7FgmcxK/J
 TavE4Kqhb3NpiTHgXreCGqsPh1BgFAVnUWYTnhr0myUhCxbTxauaT1U7eWmq0R6Hzkjl
 9z/A==
X-Gm-Message-State: ANhLgQ2EY0BO6RQALgTRUllJgAX9c1CQ7tHPOhbnSYdFsrsi+VEZCAoR
 B90GYTc+2AuaYlBt0mJJxi3E9LOZCQiMvCDQ3b+xTg==
X-Google-Smtp-Source: ADFU+vunpEm+ILiHl4QZbCuyjcUGZUm1GBXHClxmfoYzVtwKEg8EHzE8pj22s32RFKHbBGnTqlkj5+01lAbSmAGSKk0=
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr6446595wmk.56.1585064075657; 
 Tue, 24 Mar 2020 08:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200324114937.23299-1-kent.russell@amd.com>
In-Reply-To: <20200324114937.23299-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2020 11:34:24 -0400
Message-ID: <CADnq5_PnQVcx-bzVkK-yWSJ_J4OR0TgpNZxL4B24jiPcg68vug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix FRU data checking
To: Kent Russell <kent.russell@amd.com>
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

On Tue, Mar 24, 2020 at 7:49 AM Kent Russell <kent.russell@amd.com> wrote:
>
> Ensure that when we memcpy, we don't end up copying more data than
> the struct supports. For now, this is 16 characters for product number
> and serial number, and 32 chars for product name
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 6f5e98fda181..bfe4259f9508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -116,6 +116,13 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>                 return size;
>         }
>
> +       /* Product name should only be 32 characters. Any more,
> +        * and something could be wrong. Cap it at 32 to be safe
> +        */
> +       if (size > 32) {
> +               DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
> +               size = 32;
> +       }
>         /* Start at 2 due to buff using fields 0 and 1 for the address */
>         memcpy(adev->product_name, &buff[2], size);
>         adev->product_name[size] = '\0';
> @@ -127,6 +134,13 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>                 return size;
>         }
>
> +       /* Product number should only be 16 characters. Any more,
> +        * and something could be wrong. Cap it at 16 to be safe
> +        */
> +       if (size > 16) {
> +               DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
> +               size = 16;
> +       }
>         memcpy(adev->product_number, &buff[2], size);
>         adev->product_number[size] = '\0';
>
> @@ -146,6 +160,13 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>                 return size;
>         }
>
> +       /* Serial number should only be 16 characters. Any more,
> +        * and something could be wrong. Cap it at 16 to be safe
> +        */
> +       if (size > 16) {
> +               DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
> +               size = 16;
> +       }
>         memcpy(adev->serial, &buff[2], size);
>         adev->serial[size] = '\0';
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
