Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D79FD5F8E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6106510E544;
	Wed,  8 Apr 2026 07:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="dgeGbjWo";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB8310E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 13:00:05 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so4465787a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Apr 2026 06:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775566804; cv=none;
 d=google.com; s=arc-20240605;
 b=c9TOMKkqo1ZRJISCEBaXqPKb1s2hwBXCK4kmeXT93hnpJIczY65bHVRVHCj27quCZ5
 /C+1fmV4B/ZoCeK/Dko3xvSH5T0xFK62NmQ2FhAHAyxYJTtZMx48vw7PVFtWTrBmT1To
 FPid98j+xUJBoELg7ZvYJrWYO4QcyUIsYbi0M8XtJkBOr044QHG0M1dFKNHcCNOfhA2y
 9pdnMpYgIH2jsqRMuBUXbfFzgrJDHBAhyi94lSndbHQd7DQ0kncIbZJPjbneDvwpIeCA
 6YByFtrzjupswLCXJsYnC5Cl0wjfGv7z0+lq1BSmV8RPAoZUtGB2ao60jIZDEXGno1Qx
 b/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kL2sSGAkL4PZPcVc5FJ4HxqW1Olr8C1QXuJ6qTxnTUE=;
 fh=S0Ot3F/q2aBowlmfrD4JD/IJ9XTvkQMJpekIXoNKGhE=;
 b=CVv5xTdq52Z7Vgi+zdMydwg5hlLXvpEXmf/NCBk3xwLGsl+vmcCmvKL7EVhglQQtim
 Hxbv4KurHAs81vcLfrszM9S7CM77Qz+JvjkyT59WNlkBunkJalInG1XGBQ7zvxI0Eo9Q
 fcHpO5ledABPRiKTj0lEB+3pkun56lOXEp6j4dlysUY0CncEByBajnnv/oMtlHQfOUNp
 LOXd+CvbKNES2bMA3KKPSdFT+HweaXwl4qqEc+BNRItdal8Vsr6Gmd7q4qDofeqRudZw
 06UkQ8t8G5jvCgM+/ymgMiA3OLIFh9SkeCostgtLX0hRF2OTPzHhTocesMMIC348iS40
 Vt+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1775566804; x=1776171604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL2sSGAkL4PZPcVc5FJ4HxqW1Olr8C1QXuJ6qTxnTUE=;
 b=dgeGbjWoS4oAQo0gcd4WP1DtkcGR2Ou2o4+qPUjCDGig3AP5FQFI304iRA8uKFRHAU
 H1VeUi4bMWBDGOdQ5AcEUgkreWcei2hZn/CeYVWcEBYjTTVk1Q5AbapfTRqSxA8teS5y
 5YDbNA4OcN47QOcZ6h42IWgxy/PNZn2uIFz3LyEheJIHJhmSbi5ZRPHys9j+nGIVXdPR
 FMIN9v9cpbHn7oTzxK1QBiXG+TEPnUXBIHhk22WbKDfVmc84NpaaAW5y8WCYqb+O2d/t
 Y6eHVNamNeQsSI6dNKii9PZ2gyz0sKu0Ka+CpS7ghjGQxK521Aw2tRhB9qw7g4ONkr5Q
 /9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566804; x=1776171604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kL2sSGAkL4PZPcVc5FJ4HxqW1Olr8C1QXuJ6qTxnTUE=;
 b=mHB0cA8PkbCtvcv3almQCXei3OKfevfX14oFhZzfDq005iURHJSiBA+5e66T1Buyp8
 aGrbFBPxPVz6O5TAl4SewMoy1g7wwYQ/iyyDRBABFJnMPYLwV9UljkcGBLySHrUvzlVO
 Kgulxe7sMg6ycjTQS5gIk4bTT9RHxAnOFtdy5GW7rt/ww2CRbRdGTyrYdMDUH76VXmOF
 yw95CjwoRt/Mdq06Ymiso4XsoLRcAQmqLka1ehuIVfXP4cS+lFnrGhRdyIqpyzybNE+S
 enLYE/+G5dm4cyd9YLgVCrANlGYlgylF9PU72YI3A0OdHSudXyoCnmKq1zI9oneCSCfE
 uM6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUFWdMxr8yTaH7wWy7erAao9Y6mSh4dhHNfNb4WSYDdJW81VOrubeOhGpOjwdJjubvGZpJIom5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsmLp0zlxRhAbTyzhYcgtxY0xZVoetEg4jCK5rrfkBjcBmzLtj
 +HDtmGuLg/+IhjuS3OGRr3GVUMkWQymNQ+1kjvCYEb68SHCfeZetFvAJcOIfkIA7z2R0LUUPltK
 r80Z2aeFYzH5smYCTqU3xmW0kq1UtfpDBOVnTQ9r5fA==
X-Gm-Gg: AeBDiev9gyBIfbRvMrwweI00dRhC6RomxMCGBcEX3csbHXg51Fdd5vFDjwa+r/CQV5W
 zcQLuq+mHsnd+/m/l7tusNQgYjSptvOzmHJqKqy1lxpU2vNl1kdJNLIhGT1LQohk6D0KzxR5O3A
 Lj0y22BbFzSl7zVVI4/By1o7vI7ig4oi4rozu7U3bZoaRi8MeyESr1WIngUVDqNY+upDhnsXBt8
 uOxBRGJ7/VG763/H2rzclLrw/9E1KkEhFqIO69CIgg+3CKi3567jknBjo7qseE/R/zbm9mAOUWM
 +ltM7eqjqPKu605tBvZZdleVByeHobtyVwi7A2+JyvludTL4QSih6JYoqxISenjminfVYX2qn12
 17Gb4HAhx+PvK4vJzVN/QAeZJRQ==
X-Received: by 2002:a05:6402:324c:b0:66e:df62:8826 with SMTP id
 4fb4d7f45d1cf-66edf6288a7mr2661001a12.8.1775566803791; Tue, 07 Apr 2026
 06:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgF-xs=3fbKQO5Mj=coPMXq0ecWmV0bJDNFN44coEHV3WS=wg@mail.gmail.com>
 <20260331015202.51017-1-guilherme.bozi@usp.br>
In-Reply-To: <20260331015202.51017-1-guilherme.bozi@usp.br>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 7 Apr 2026 10:00:00 -0300
X-Gm-Features: AQROBzCMYxUk4VwRBwx6RguB_k0T4nYWVxTkeiFno4LHqPyS6xqSNyRshlEpVPo
Message-ID: <CAJgF-xswWgRGJGUDFRw+q4YOz1cVc5fqXumHBGxpLE_4736FQg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: Deduplicate DCN DDC register
 assignment
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 08 Apr 2026 07:11:07 +0000
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

Hi,

Just a gentle ping on this.
Any feedback on v3 would be appreciated.

Thanks.


On Mon, Mar 30, 2026 at 10:52=E2=80=AFPM Guilherme Ivo Bozi
<guilherme.bozi@usp.br> wrote:
>
> Several DCN generations implement identical define_ddc_registers()
> functions to assign DDC register, shift and mask pointers based on
> GPIO ID.
>
> Introduce a shared inline helper,
> dcn_define_ddc_registers_common(), and convert all DCN
> implementations to use it.
>
> This reduces duplication and improves maintainability without
> changing behavior.
>
> No functional changes intended.
>
> Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> ---
>
> v2:
>         - Corrected type mismatch (ddc_shift - ddc_sh_mask)
>
> v3:
>         - Fix threading (previous version was not sent as reply)
>         - Squashed fix to avoid build breakage
>
>  .../display/dc/gpio/dcn20/hw_factory_dcn20.c  | 27 ++++---------
>  .../display/dc/gpio/dcn21/hw_factory_dcn21.c  | 27 ++++---------
>  .../display/dc/gpio/dcn30/hw_factory_dcn30.c  | 27 ++++---------
>  .../dc/gpio/dcn315/hw_factory_dcn315.c        | 27 ++++---------
>  .../display/dc/gpio/dcn32/hw_factory_dcn32.c  | 27 ++++---------
>  .../dc/gpio/dcn401/hw_factory_dcn401.c        | 26 ++++---------
>  .../amd/display/dc/gpio/hw_factory_dcn_ddc.h  | 39 +++++++++++++++++++
>  7 files changed, 86 insertions(+), 114 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_dd=
c.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> index e0bd0c722e00..905d14079b91 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn20.h"
>
>
> @@ -182,25 +184,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> index 2f57ee6deabc..f347b8c7e2b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn21.h"
>
>  #include "dcn/dcn_2_1_0_offset.h"
> @@ -170,25 +172,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> index 36a5736c58c9..25eef1ee10fe 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn30.h"
>
>
> @@ -199,25 +201,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315=
.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
> index 5feebb3b95ca..571a6f1b0cf9 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn315.h"
>
>  #include "dcn/dcn_3_1_5_offset.h"
> @@ -191,25 +193,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
> index 985f10b39750..d6e97b246bae 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn32.h"
>
>  #include "dcn/dcn_3_2_0_offset.h"
> @@ -203,25 +205,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401=
.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
> index 928abca18a18..06a4d7a8a1ac 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
> @@ -12,6 +12,7 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
>
>  #include "dcn/dcn_4_1_0_offset.h"
>  #include "dcn/dcn_4_1_0_sh_mask.h"
> @@ -195,25 +196,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h b/d=
rivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
> new file mode 100644
> index 000000000000..863177cf67e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __DAL_HW_FACTORY_DCN_DDC_H__
> +#define __DAL_HW_FACTORY_DCN_DDC_H__
> +
> +static inline void dcn_define_ddc_registers_common(
> +               struct hw_gpio_pin *pin,
> +               uint32_t en,
> +               const struct ddc_registers *data_regs,
> +               const struct ddc_registers *clk_regs,
> +               const struct ddc_sh_mask *shift,
> +               const struct ddc_sh_mask *mask)
> +{
> +       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> +
> +       switch (pin->id) {
> +       case GPIO_ID_DDC_DATA:
> +               ddc->regs =3D &data_regs[en];
> +               ddc->base.regs =3D &data_regs[en].gpio;
> +               break;
> +
> +       case GPIO_ID_DDC_CLOCK:
> +               ddc->regs =3D &clk_regs[en];
> +               ddc->base.regs =3D &clk_regs[en].gpio;
> +               break;
> +
> +       default:
> +               ASSERT_CRITICAL(false);
> +               return;
> +       }
> +
> +       ddc->shifts =3D &shift[en];
> +       ddc->masks =3D &mask[en];
> +}
> +
> +#endif /* __DAL_HW_FACTORY_DCN_DDC_H__ */
> --
> 2.47.3
>
