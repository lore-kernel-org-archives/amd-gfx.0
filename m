Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC834C4724C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 16:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13DC20873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 16:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6C6/q0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13DC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498B46E932;
	Thu, 30 Apr 2020 16:24:04 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83CC6E406;
 Thu, 30 Apr 2020 16:24:02 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id o27so2394003wra.12;
 Thu, 30 Apr 2020 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YFGPGLfKT/E9pikwTEzWHQ0mcATOmX08Qba74yi41YA=;
 b=E6C6/q0HMBip3pBrCu8xPhNcd+MV/jG9JwiMrIDuuAdgQ/fhYsszVuJXIwXHWLaRsm
 /7hoP0LA0YZ0j4XmyxNaCx8SI/M4Gt2Sjlm+ps4eYbDUxErrv9PBD6zJBzz3++MVmRnD
 W3MHaAMxWDEbUh5/0ZSXPI3Fhot957x6M3+5Ok2KlM0Jri7/46oIDprAm9f31EIUlQes
 8TBAEpfLb6DopM5htclCnjhpjEwlShu3i/sZRl3N4bG6iKLmQy6pqG7r2sKOoMdfOLQo
 wGrmiKMthu/uLRkxDzSq4g+seKiaXSrLl7W46DlX5ec1o9yNU1otshf73wRgX23OhObT
 BZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YFGPGLfKT/E9pikwTEzWHQ0mcATOmX08Qba74yi41YA=;
 b=J1UX8rkzk5tWOkJYPGeuraaykqgruQ6hQWpPCpNsZYavFv33naOE81eeZVeX+42Mzt
 qMVey7nMzhavUarFrzPnuLorQWHKHmFo74jhRo6ILNG3vLicUStwT5tAhxPZ/3vhUY9O
 zZPLgV3+P/tug4/gZkvvoGihLIRo+HDx8U1CTg1x9ifHc1rVj2LlVj18CdFGIZf2Md3U
 xNozlcnQNJoao4C54m22MDua9CqO2DGKY4sKLyJqF3baZnc8VAjcXYJ0+H3EMYVaScto
 G8JsSwQExcM8et3gxYuvHBBMaHGwvX1KCE3MJpJuuomsLGxfT+8gaXDZhnmpl3sZLi6R
 JKsw==
X-Gm-Message-State: AGi0PuaMjVuo6hOLVHpuOxuqboeP6LD8Ra1qx9dfmVAQVdc7qBsm6Sjs
 MVETcZS58u5XWOt0542kBFZ75P6jPdB5qpSTlws=
X-Google-Smtp-Source: APiQypKZAXuhkZZKYGww0ATDLql2Szu8lyueXbB7YVBSVUEI6wF8eSJc4F6ASnlHilZyzBkjojUTv1Sq/XAr9582L3w=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr5329114wrs.124.1588263841603; 
 Thu, 30 Apr 2020 09:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200430034034.106824-1-zhengbin13@huawei.com>
In-Reply-To: <20200430034034.106824-1-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 12:23:50 -0400
Message-ID: <CADnq5_N3ur5kzKyUqRX5P2=+=wb=yhstmf1cmUPsuoOY-5Yk2w@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: remove set but not used variables
To: Zheng Bin <zhengbin13@huawei.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Apr 30, 2020 at 3:32 AM Zheng Bin <zhengbin13@huawei.com> wrote:
>
> Zheng Bin (4):
>   drm/amd/display: remove set but not used variable 'dc'
>   drm/amd/display: remove set but not used variable 'pixel_width'
>   drm/amd/display: remove set but not used variable 'speakers' in
>     dce_stream_encoder.c
>   drm/amd/display: remove set but not used variable 'speakers' in
>     dcn10_stream_encoder.c
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 2 --
>  drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c    | 2 --
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c           | 7 -------
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c    | 2 --
>  4 files changed, 13 deletions(-)
>
> --
> 2.26.0.106.g9fadedd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
