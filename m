Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6537BE7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 16:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC0F10E53E;
	Mon,  9 Dec 2024 16:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OxRx3Ltq";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668FF10E53E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 16:02:17 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2e9ed2dbfc8so789169a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Dec 2024 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733760137; x=1734364937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6Nr0zuZfaWoH+ODIpEvbEZFxAAztb9+QthaBGh/Mxk=;
 b=OxRx3LtqwXVTMwsrS85wMMThwkaUmP9U5Nz8WcTqhxqxwADS8gvO3zy0wx+Vr0iFKB
 0czoBQ8ftu9HmE7WEF9Kr2Z7PNbCexuvveS9TaGnUkJc6wBHN8YLhXdaMIlsh+oL8Rxl
 wGbSkfD/wy0f/NuYyJTr5NbYn0LQDKZYLyWds8YP+9e8r0gEkvqmuU7z9giEVSHYDF7Q
 O3mPnMZc2r5Vl6gQFrZhddMlX5m2H3P745vTAODthMOZRNWdUKq6FP7ACFuYJ5Emm9dT
 F7Nh3lJHoAk9SlG+CnBT/Lvgie9gkWLcnrr48vDDPf9d/T0JAM/yuN/Te0SbuxsnGB6/
 NMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760137; x=1734364937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6Nr0zuZfaWoH+ODIpEvbEZFxAAztb9+QthaBGh/Mxk=;
 b=GkLEuCEIyLAjliedDYpA19Xe5+ah2dyFc0bujHz65OpCSDhLpKG77FJmw8tJuiZNFL
 eK+mz/TW/Q8L+/oaNGYmVqnewD6UMSHsOsCGLZamki4W1uTp73jabsbvAMotRVNlNJpT
 SWDN+rJvWoPrEYOapxLzPN3XvL/6tlu+T4Eud7VkMSk6M7mlPHyn+xYvQcPVSo9MgXgO
 GYW94Umujzbwd5M2DDjj85rsmlK25EMDrlXyLfsZqFczVL1CU20BwDixiPQbMwoO5B70
 gwySJDckKCJn5NX9nCnRLZ0Fslj6ARuJpprfCzbMxg0/v4nYneh0gTabOxSWBO+sUm5O
 OLbQ==
X-Gm-Message-State: AOJu0YzdZSNxnqnQpIeMnk/3WUnxgC64SNJzW4xGt27wiBGm5nNsYoN2
 w1xtbYEa29W7shWCdOpmfnbKa5mK8wypm2RhgKo9b/Tqdzxjk7HGmW6f199s2F2FKZ34aQA768x
 H9us508ZUJz+Ayu9UtE2lGRJvteNRzQ==
X-Gm-Gg: ASbGnctpQEJIopfTW0xQQGxCZOSB7K2PXN8AhobelizUb2FkMdsEQl8l9kaGSZHu+z1
 4ZHUwVUTpN6LcY3+xDMlAV8GbUBroxfg=
X-Google-Smtp-Source: AGHT+IGNn1PlzecRNcPxFJHIp9uDiluNQIRCDKCT0ps2xibimhbSAt3uZvxO1xdWdU8yTpKkv3vZ2Bla9SY/PZBQ/2M=
X-Received: by 2002:a17:90b:4c04:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2efd4a18c7dmr11681a91.5.1733760136800; Mon, 09 Dec 2024
 08:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20241209154423.1861675-1-aurabindo.pillai@amd.com>
In-Reply-To: <20241209154423.1861675-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Dec 2024 11:02:02 -0500
Message-ID: <CADnq5_Nifrmt-7tLwE_rbHFzAenwuz-qs1nMYxVNWwr8v07wMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: rename register headers to dcn_2_0_1
To: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Tom St Denis <tom.stdenis@amd.com>
Cc: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, harry.wentland@amd.com, 
 alexander.deucher@amd.com
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

On Mon, Dec 9, 2024 at 10:44=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> They were named with the incorrect dcn version.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

+ Tom for awareness for umr.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 4 ++--
>  .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c    | 4 ++--
>  .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 ++--
>  .../asic_reg/dcn/{dcn_2_0_3_offset.h =3D> dcn_2_0_1_offset.h}   | 4 ++--
>  .../asic_reg/dcn/{dcn_2_0_3_sh_mask.h =3D> dcn_2_0_1_sh_mask.h} | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/gpu/drm/amd/include/asic_reg/dcn/{dcn_2_0_3_offset.h =3D>=
 dcn_2_0_1_offset.h} (99%)
>  rename drivers/gpu/drm/amd/include/asic_reg/dcn/{dcn_2_0_3_sh_mask.h =3D=
> dcn_2_0_1_sh_mask.h} (99%)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index 7920f6f1aa62..76c612ecfe3c 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -34,8 +34,8 @@
>  #include "dm_services.h"
>
>  #include "cyan_skillfish_ip_offset.h"
> -#include "dcn/dcn_2_0_3_offset.h"
> -#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dcn/dcn_2_0_1_offset.h"
> +#include "dcn/dcn_2_0_1_sh_mask.h"
>  #include "clk/clk_11_0_1_offset.h"
>  #include "clk/clk_11_0_1_sh_mask.h"
>
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201=
.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> index 4fb9cd6708d5..1d61d475d36f 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> @@ -30,8 +30,8 @@
>  #include "../dce110/irq_service_dce110.h"
>  #include "irq_service_dcn201.h"
>
> -#include "dcn/dcn_2_0_3_offset.h"
> -#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dcn/dcn_2_0_1_offset.h"
> +#include "dcn/dcn_2_0_1_sh_mask.h"
>
>  #include "cyan_skillfish_ip_offset.h"
>  #include "soc15_hw_ip.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> index d3d67d366523..9f37f0097feb 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> @@ -59,8 +59,8 @@
>
>  #include "cyan_skillfish_ip_offset.h"
>
> -#include "dcn/dcn_2_0_3_offset.h"
> -#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dcn/dcn_2_0_1_offset.h"
> +#include "dcn/dcn_2_0_1_sh_mask.h"
>  #include "dpcs/dpcs_2_0_3_offset.h"
>  #include "dpcs/dpcs_2_0_3_sh_mask.h"
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
> similarity index 99%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
> index cae1a7e74323..73c5dd5e83d4 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
> @@ -19,8 +19,8 @@
>   * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFT=
WARE.
>   */
>
> -#ifndef _dcn_2_0_3_OFFSET_HEADER
> -#define _dcn_2_0_3_OFFSET_HEADER
> +#ifndef _dcn_2_0_1_OFFSET_HEADER
> +#define _dcn_2_0_1_OFFSET_HEADER
>
>
>  // addressBlock: dce_dc_dccg_dccg_dispdec
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h=
 b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
> similarity index 99%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
> index ca1e1eb39256..290d807800a6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
> @@ -18,8 +18,8 @@
>   * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>   * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFT=
WARE.
>   */
> -#ifndef _dcn_2_0_3_SH_MASK_HEADER
> -#define _dcn_2_0_3_SH_MASK_HEADER
> +#ifndef _dcn_2_0_1_SH_MASK_HEADER
> +#define _dcn_2_0_1_SH_MASK_HEADER
>
>
>  // addressBlock: dce_dc_dccg_dccg_dispdec
> --
> 2.47.1
>
