Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106E2FEDA10
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 19:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95E110E5DE;
	Tue, 17 Mar 2026 19:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mB3n68Fu";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D4010E5E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 19:26:31 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-128d600ad25so352030c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773775591; cv=none;
 d=google.com; s=arc-20240605;
 b=RE3aeCC6J/P92bymXT9nS48TuiwdniX+/6K8Ca24aB29++qZkIDiWezaXmSBYytZ/F
 dqSJSG0ocgr1uWW5syul4pnn7eE5GsNwgSE2WWPyoztxSUEMWMR2ZBf+M2ARnzaxmCsH
 VXBX20o7KXivQD9srhyuSyzIDdBH0Jkt9vDPeSmvWrDSHEE6gGgEVEg1PUhlBoDANROg
 3S75dSyHIB5ItMBQydio3jKh/LzkkorRbxXhj9Sf9kqdwsHk0R5VYkfOpTMOtXWTC9I9
 gCESlJPJaOWaPHK/eOCxBszLaJkWzJoY8/s3Kr/U+A99B4dkZllStNqhyDUzsCR6x/fC
 E6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v/qqkcjWxAT1BP4Oe26tlDpbbc2ZBX/lN25rud4FenQ=;
 fh=ekekTOFdBTVYdCKypfFAZ0LnENf/Ix83TmJxOiw2IKc=;
 b=ZJYt2in1nNwIx0YWs1WLdVKn9DeTOMxKFfH4C3EL4n4ION2ZGpTMyhHNeUbBubx76s
 bsQZ5dRzcQGB6O+xyXNoGXD6g2ZabnOARp/Yd1eKBEokhGekYRmrrIJwewjCdkk++R0N
 pjl8l2LvZVVoocfwISxAwW691Ci+7+MiuU1+9Fdg/XdavuOMpITnnolqmKuI4QffEV3w
 WQimz8GVTKs+Luy4qLU9rceOi0jKZkBuEBSdlVHRLRFbDDl2pO21Y1MEU2z6Ga7aPbeh
 6M38vBzrhAcp9KoukCeAMi7aorx+JMbJglGmWzbJcbR/nuVcPIY45t7ns47t+jZPungQ
 ykXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773775591; x=1774380391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/qqkcjWxAT1BP4Oe26tlDpbbc2ZBX/lN25rud4FenQ=;
 b=mB3n68FuL5ZeiEo7WuPWYq7XyLeR5qpCx9lvZo7/PXLgPiF7FV+wlXwDnMzfVeBd9P
 AzSIcmgYuqgWK9ZYdGpB+ZWo/Vt3fBKn9sUlf9/isnzlJlb0sfkxa8p63J+3VX8Ur5hX
 ghfo+PYMXhc1B2GGwqcQtIEuXZlzgsXzQJH5Ac38UagkYMY3/nuaVptYFPZroELk704f
 1CbyiIE3NRDqWOJd/GLoRB0Dn1Vrxj2VfDfzf+ucHYVcEbkUsCcTwRzmjYHZf2ExrLUc
 12zNRuU8brCTgzDNQyz6VSYohJj0OJmlEP4gR+lpaEyvFHYDRpqi3gXnkT7FLQ4wJZT2
 7TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773775591; x=1774380391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/qqkcjWxAT1BP4Oe26tlDpbbc2ZBX/lN25rud4FenQ=;
 b=Wuha+tVL4+pbyfuhKHyKeqidgGopRAjBI7WJUyAhVXulYnK7Tlu8lmyk9HgvHqH1vF
 KWvC6T6eDg2PXstqqfB/qMHDxH53v0Lr1Y1gi5i9cAwWFdBniCd18S4Rdi0tuChLIuID
 AtyXLHx3DHGVgOKUWxmx14nFklHdki0T51ZaIavj2+gYNWuTWk3lLzzHOmfk51K54mwy
 ngno7oFBmpI7cX+U4hM7Ud0mfZJBSw3WT/ltEVcpaSyEyoZ22rsCnHYhy0ippQR+L2Ph
 g/PP8VtsAPeE6+21/aq+a4RuN+WTMxZfTE08bHDsxwcnLlo+8AIiBjqio0fiOjzlPxwX
 enkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/27NKIBs0IKXgnAnWTeV5kjB0edL47vP+6oUDgL398FTPFcchyEBljR+i2W8UxzxQCEdYM1Iq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/dMFP3fuChK4O66KJlkpSmKTFd3kSYaLDgPAvUhrjjf8VhThs
 W6BIR4A5ZHEt/qv6KFcLokovd/fTvFmsibJH/TFDarUf42k54aF/QMuZPpr1epjWchs9Rq2N35l
 M9hygILMxx3HEq2cvbJWnfIgF6uHObDo=
X-Gm-Gg: ATEYQzx9uMqk0N7SGB//Zdi3+qUcuFw2itJm9JP7OZn6UNxy0SGzise5xMSTcHc21kI
 BLAh3iypIBlJyYv5ZXIpNr2FaZt+LCNQ0HAS4WxZ3wg6q9BZ7dTReQRKaiLy299RLrsC9UfSqA7
 02zLFi9Wn22n/Rt6aouofXTRkFnx4KyRgs+CPhXgpTvmW3UuH6fFxx0ANW+fCjK4vFHDavxe2j3
 BKhJt5/uFIPnoEPt7cuG/1EXRzikQPxtWuIDUiFhipknYq1nAR0Fk1C6SSqm2uo2o+wedztDLW1
 YzYxTLakg75BfJyuBwa8bfbtDIAYg58g1Fc8SB36moqHPB44XCjaTxNOsxCjOZ++jKl8Iw==
X-Received: by 2002:a05:7022:e1d:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-129a70e7b23mr184416c88.4.1773775590538; Tue, 17 Mar 2026
 12:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260316214041.6275-1-litaliano00.contact@gmail.com>
In-Reply-To: <20260316214041.6275-1-litaliano00.contact@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Mar 2026 15:26:19 -0400
X-Gm-Features: AaiRm52jEQOolaGCdY9-TL50CGZmnuL6QPn0YVDIDX2_OK4FKM8bFWmsyoA4n_4
Message-ID: <CADnq5_MN=TTOHc86oxEuApUMCc9R57MxQvF82uyYh_fsMou1Ew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up typecasts and ordering in
 dcn4_calcs
To: Adriano Vero <litaliano00.contact@gmail.com>
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2026 at 4:18=E2=80=AFAM Adriano Vero
<litaliano00.contact@gmail.com> wrote:
>
> Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
> ---
>  .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2=
_core/dml2_core_dcn4_calcs.c
> index ca5ac3c0d..3e63320fd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> @@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(
>                         disp_dlg_regs->refcyc_per_vm_req_flip =3D (unsign=
ed int)(math_pow(2, 23) - 1);
>
>
> -               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigned =
int)8);
> +               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (int unsig=
ned)8);

Isn't this just doing what you are claiming to fix?

>                 DML_ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsign=
ed int)math_pow(2, 13));
>
>                 if (disp_dlg_regs->dst_y_per_pte_row_nom_l >=3D (unsigned=
 int)math_pow(2, 17)) {
> @@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const struct=
 dml2_core_internal_display_mod
>
>         out->informative.misc.cstate_max_cap_mode =3D dml_get_cstate_max_=
cap_mode(mode_lib);
>
> -       out->min_clocks.dcn4x.dpprefclk_khz =3D (int unsigned)dml_get_glo=
bal_dppclk_khz(mode_lib);
> +       out->min_clocks.dcn4x.dpprefclk_khz =3D (unsigned int)dml_get_glo=
bal_dppclk_khz(mode_lib);
>
>         out->informative.qos.max_active_fclk_change_latency_supported =3D=
 dml_get_fclk_change_latency(mode_lib);
>
> --
> 2.47.3
>
