Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D7C55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 11:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B96422265
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 11:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMG/Alvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B96422265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C466EB6B;
	Tue, 27 Oct 2020 11:32:09 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875FD6EB41
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 11:32:08 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id c129so934205yba.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W1Gv+nJ7slRF6WAslv0cYycCZqCwIpx2s5g2fO7nTvg=;
 b=uMG/AlvtWS/ukbWDTVH2S1/obaMEPI0PyvVFYyipWzt/QwnxifEVzyD8J6piis2BMm
 O14vpT8nnLRL9Ng3YyWt9cvC6p9Rgt8XnrLNtuEPGM+6YETHROqSP3tGXWeFSHsWO/Dg
 3VuVaOsYLBGtekd7mllGKRrJwEaYmOGZf/FyHZXNnEaBq4CZedQ7LpdwrYE+Nsisntr6
 WojZhjDRyNmWt668dppCQXRnmAORoSk4maX+DvDhCP3dvhH+jbwAcDlehIGQN/YkaJ4L
 6lINNB0s+WCfNSDYGeBmtx7g8t7reBP5+Vpof+AwbqMDymAoXQ2P+AQljJVLAxlJvbAo
 ly9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W1Gv+nJ7slRF6WAslv0cYycCZqCwIpx2s5g2fO7nTvg=;
 b=nhVXn3EV6bS8SlNodvXqfKKwyJ5SRQtnRt3UZzjCtZ2EwUVFpNw3y7UN2NIFmjuDFh
 F9pY88BKM8VbOIHcy1xCN180autlJP7LG2rCG+ktjK5YGRB67KvaMCQcGbkMmh3bf8YA
 ll7Ix+e8kvpWrniDFeZEZoCGUkcOvKGjNFuiigddwU3EsXtmDxX0GeVzfgPLZVl6QEDq
 cpkY/ZoKciNB0sSVcIayPkN+25ytoYh4wKyBdKgvS+q1LbinZqRUl/pL21AM+OM0g1Kr
 aQRLiK34e4Gr59nkr6+0BVmfHcLKnJb+jCcuijD2bACYPJW0cFlWQC/WzE998ZVulSqH
 hkMQ==
X-Gm-Message-State: AOAM533NpFiEEI3S2/kNZtaPB33mQNAYtfHjSl+O1IP6xJKyEG8cbk4S
 /1oejxgHYiO2ta5wfYnJ2YHZPC8ML3wZ0pXMuUw=
X-Google-Smtp-Source: ABdhPJyYGZiZ5IbxYYzzio7/XVkmekl1xkVRYGjYSs/6MPuceIz/auWd18nZz2S2skkQmQkedZlnbSCWPzguxRYJtfo=
X-Received: by 2002:a25:2e01:: with SMTP id u1mr2564724ybu.461.1603798327625; 
 Tue, 27 Oct 2020 04:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201027024025.32269-1-evan.quan@amd.com>
In-Reply-To: <20201027024025.32269-1-evan.quan@amd.com>
From: Sandeep <sandy.8925@gmail.com>
Date: Tue, 27 Oct 2020 17:01:56 +0530
Message-ID: <CAGPDPzDniqOW7YyRQht0Fx7uqReQk3zm89rwsZJEhjtrt4WN_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============2044197300=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2044197300==
Content-Type: multipart/alternative; boundary="0000000000009c0ce205b2a56501"

--0000000000009c0ce205b2a56501
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct, 2020, 08:10 Evan Quan, <evan.quan@amd.com> wrote:

> Which can be used for S4(hibernation) support.
>
> Change-Id: I6e4962c120a3baed14cea04ed1742ff11a273d34
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik.c                 | 4 +++-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 03ff8bd1fee8..5442df094102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
>
>         switch (adev->asic_type) {
>         case CHIP_BONAIRE:
> -       case CHIP_HAWAII:
>                 /* disable baco reset until it works */
>                 /* smu7_asic_get_baco_capability(adev, &baco_reset); */
>                 baco_reset = false;
>                 break;
> +       case CHIP_HAWAII:
> +               baco_reset = cik_asic_supports_baco(adev);
> +               break;
>         default:
>                 baco_reset = false;
>                 break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> index 3be40114e63d..45f608838f6e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> @@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>         { CMD_READMODIFYWRITE, mmBACO_CNTL,
> BACO_CNTL__BACO_BCLK_OFF_MASK,           BACO_CNTL__BACO_BCLK_OFF__SHIFT,
> 0, 0x00 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL,
> BACO_CNTL__BACO_POWER_OFF_MASK,          BACO_CNTL__BACO_POWER_OFF__SHIFT,
> 0, 0x00 },
>         { CMD_DELAY_MS, 0, 0, 0, 20, 0 },
> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0,
> 0xffffffff, 0x20 },
> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0,
> 0xffffffff, 0x200 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ISO_DIS_MASK,
> BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },
> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c },
> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c00
> },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL,
> BACO_CNTL__BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0,
> 0x01 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK,
> BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },
> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK,
> 0, 5, 0x10 },
> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK,
> 0, 5, 0x100 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK,
> BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },
>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0,
> 0xffffffff, 0x00 }
>  };
> @@ -155,6 +155,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>  static const struct baco_cmd_entry clean_baco_tbl[] =
>  {
>         { CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
> +       { CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },
>         { CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }
>  };
>
> --
> 2.29.0
>


Not sure why I'm cc'd on this, I'm not a maintainer, nor does this patch
seem related to any patches I've contributed.

- Sandeep

>

--0000000000009c0ce205b2a56501
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, 27 Oct, 2020, 08:10 Evan Quan, &lt;<a href=
=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Which can be used for S4(hibernation) support.<=
br>
<br>
Change-Id: I6e4962c120a3baed14cea04ed1742ff11a273d34<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" target=3D=
"_blank" rel=3D"noreferrer">evan.quan@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/cik.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 +++-<br>
=C2=A0drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---<br>
=C2=A02 files changed, 7 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c<br>
index 03ff8bd1fee8..5442df094102 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c<br>
@@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (adev-&gt;asic_type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_BONAIRE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_HAWAII:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* disable baco res=
et until it works */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* smu7_asic_get_ba=
co_capability(adev, &amp;baco_reset); */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 baco_reset =3D fals=
e;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_HAWAII:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0baco_reset =3D cik_=
asic_supports_baco(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 baco_reset =3D fals=
e;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/ci_baco.c<br>
index 3be40114e63d..45f608838f6e 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c<br>
@@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__=
BACO_BCLK_OFF_MASK,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BACO_CNTL__BACO=
_BCLK_OFF__SHIFT, 0, 0x00 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__=
BACO_POWER_OFF_MASK,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BACO_CNTL__BACO_POWE=
R_OFF__SHIFT, 0, 0x00 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_DELAY_MS, 0, 0, 0, 20, 0 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_=
BF_MASK, 0, 0xffffffff, 0x20 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_=
BF_MASK, 0, 0xffffffff, 0x200 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__=
BACO_ISO_DIS_MASK, BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_=
MASK, 0, 5, 0x1c },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_=
MASK, 0, 5, 0x1c00 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__=
BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0, 0x01 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__=
BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_=
CONFIG_DONE_MASK, 0, 5, 0x10 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_=
CONFIG_DONE_MASK, 0, 5, 0x100 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__=
BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MOD=
E_MASK, 0, 0xffffffff, 0x00 }<br>
=C2=A0};<br>
@@ -155,6 +155,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =3D<=
br>
=C2=A0static const struct baco_cmd_entry clean_baco_tbl[] =3D<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }<=
br>
=C2=A0};<br>
<br>
-- <br>
2.29.0<br></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Not sure why I&#39;m cc&#39;d on this, I&#39;m =
not a maintainer, nor does this patch seem related to any patches I&#39;ve =
contributed.</div><div dir=3D"auto"><br></div><div dir=3D"auto">- Sandeep</=
div><div class=3D"gmail_quote" dir=3D"auto"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
</blockquote></div></div>

--0000000000009c0ce205b2a56501--

--===============2044197300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2044197300==--
