Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2229AC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD0810E392;
	Fri, 28 Aug 2026 15:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hk17WWte";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B445410E392
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:45:31 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cbedf082ba2so177272a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787931931; cv=none;
 d=google.com; s=arc-20260327;
 b=bltraOpfYplZBuUT9D4BU3Gnbg8un0eQPeze4JC58idJKXSev/N7+SF0Iyvx30ODH7
 GG5OXIEvNprIRm5SJDYU/VnVKwzMx0FEdKulab8npG0NasvI/JfX8I9CoNzpnIdfsxIj
 H1qc0BUgR5Af4UsiBXhHzRLkqsx7dM9Wzhthkw2897robgoTb3dXM5L/qv+62ZJYaLs1
 vnoM7lUUaRlz6AFLgYs/Fk5AMVjYgIG7YCZJe8ETCqbL5srlTDtb4sDTKuweOv2SIqpj
 8rut1kaXW+qeszotz8hcf6e0viWdATT6apW4QSZqKoXGgoZon5wnJUnrOsYjw2exWx/L
 zIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJ5XpwnkHox6a4w3pC/S2+0qhPwO5SkHdON4Vp8od9s=;
 fh=/N7PrykyRmz2rS84BLKhE6ysYVndwvhbsrs0lo9a3h0=;
 b=QAeRgpe+SMQkv6mgIlBAK+QYFK342KRprxM4S8qA8BLkEZK/Bp0M9UaBaY0BSaogy1
 yqlhvg/xyPCIx3V6hdWGda58vTWzl+nnWwhroyfJ2pse4nFNIdKSuQnDm7IiHip9KTz5
 yhxnbhpVToKnjD6b5kP1FkW1jdpKMcBX9bwrN5C2/QFzORVI/Stnt4Qjm120FrUzaTTD
 TFSPoQcLQlPFsFIsPLs1xXmZm9WOdc/d/+FJVTyJz1KM5duRF0F5R8syzDtDXRtVZWhi
 h1lMaR+cYN+0RL4l3jmIm45olEP1h82XZ0dDqmIWVGBdJ7vkLHTCcIBzCc1rnJV9s6kU
 a39A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787931931; x=1788536731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vJ5XpwnkHox6a4w3pC/S2+0qhPwO5SkHdON4Vp8od9s=;
 b=Hk17WWtet/5p0icXdmWKbgqbmQqLxHoimr8UQ9VuZN81IpLsWB1B5FfDQN7dVCLbVW
 G48RGL3SwTxOirH4fT4EzbnFnlZcpDyfYMtsJ4g5HFnLWBFX+QItEX9MaS7PoNuqhfDP
 8VLisASxqzbFI9b39LNPHnUPB8xC9NjdYnwChdgymfidjwqid1Ck4/ynH050t1onXVdG
 Y8TJ9sSChYoW/bYkrxiJXX6Xx9ZY9U4msChIk1E46YeqXF0VjDJrj03ZFc7diCOO0OZ2
 yBXbBaXTYnpQ5nVvxqGyvDVJTB8Ty5zcnrxOQYUSgydPV/47aWxRlrzos9aegphz2tFB
 +vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787931931; x=1788536731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vJ5XpwnkHox6a4w3pC/S2+0qhPwO5SkHdON4Vp8od9s=;
 b=QTpqKTs0ZVU/rg/zLWreuPdauRW8HVGM2dniZ10Rs3ty3c7gtGONbZavjOkZ2IXf7t
 6zwUhrx1XinqZPD85tc+3iY9wgXu/XlPxkPhjORJHrx95JC6sM2s6IoNVIYJo+9c8HML
 4c+rapoNVpy54jMvI/Y0FxLQxxLpkaDt51scnLCb9RhJh8qt8i5N0/KTjONGAuAOAy6y
 qwYS2iAEtGX58G+mm8jblyLmzaWZDa5Vh5+ywyIh16NMiTyqmI/lAviXIhRjNmjlOiro
 Oj4L+WDVUzjDb00HmciX7ppXIG4SC/A3BwT1q7NbAd0PZ0wDKKrBaGnlXyOgYUX7JBxd
 jo0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnWI17biH6DndVuv2koqdaKlNnPNNWUSqjUOHrkLVO9oOB1jrowj6Q/eHNge6e/7kVEHYtuPq7@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMJ9I1XquP6dogCvt8pSjeZvlTX7yvonuhYRnvVQOnbpXM1x7m
 0bZLs/kDDNQd9ulFdRqrKCqI/aD/vz4NvZOydOtMzbglQuE9f38f/WkElOr87avkVGNsbl83Dqg
 qenv1oWMiT/wfT6+suuYtCT4lkzhHAWY=
X-Gm-Gg: AR+sD12DkLs5jOtQI+oX0dw5+hqO8t1eW2PIU9FzPbwcV4EVa2DL67Pwoq5V4Tr+wy5
 dp7hDNubKzo6yK/1BGK1Nyucqhb62SgPGkUNs1/82i5Erjrn7Nykee9jrEmqEPG3urMJ8nxig4a
 40b/YfgDzDpRR462wVVEC/n01oU+gHjzBwY1f80BnCwn3+2+j8Zvxdjool7YOn+IkeEFzB83N0W
 zy2Y2ts4RXOVInSDZFEZYTYkIax82D80414hpxZfMsNhEj6BMYsW4bMRewAaeImVSGjOO1qLlqz
 v8Phzc4LniN23MnxFbmQLyYOZZYUy0/5FT35hm4VDZI3Ng7CyDbBmLxNAB7lJxB+DkOjaSDg4PZ
 J+0CZSC/IBkxLBzMA8LRygK4uOmYKsF4=
X-Received: by 2002:a17:90b:1f8b:b0:396:a47f:d38f with SMTP id
 98e67ed59e1d1-396d1042d5cmr8007195a91.3.1787931930762; Fri, 28 Aug 2026
 08:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260827010802.56422-1-yanglinlin@kylinos.cn>
In-Reply-To: <20260827010802.56422-1-yanglinlin@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2026 11:45:18 -0400
X-Gm-Features: AcwNN1UYBdRuALeVF9bH1FXOugA6dKfisK_IHiNKuZW7SAtdOSEUBOQ6I0dUBI4
Message-ID: <CADnq5_Pmd=LBP4BPD4KZCrfraKyHbB6R46KLJB4yjSiyTHJOJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix misspelling of "overridden"
To: Linlin Yang <yanglinlin@kylinos.cn>
Cc: harry.wentland@amd.com, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Thu, Aug 27, 2026 at 8:47=E2=80=AFAM Linlin Yang <yanglinlin@kylinos.cn>=
 wrote:
>
> Fix misspelling of "overridden" (missing a 'd') in comments.
> No functional change.
>
> Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 2 +-
>  .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 2 +-
>  .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
>  drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c               | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 33b5136f7ce3..75bdad22bf69 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -1805,7 +1805,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchPar=
ametersWatermarksAndPerforman
>         v->DISPCLKWithRamping =3D 0;
>         v->DISPCLKWithoutRamping =3D 0;
>         v->GlobalDPPCLK =3D 0.0;
> -       /* DAL custom code: need to update ReturnBW in case min dcfclk is=
 overriden */
> +       /* DAL custom code: need to update ReturnBW in case min dcfclk is=
 overridden */
>         v->IdealSDPPortBandwidthPerState[v->VoltageLevel][v->maxMpcComb] =
=3D dml_min3(
>                         v->ReturnBusWidth * v->DCFCLK,
>                         v->DRAMSpeedPerState[v->VoltageLevel] * v->Number=
OfChannels * v->DRAMChannelWidth,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> index 8064c4b3fd25..3f62ea493787 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> @@ -2045,7 +2045,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchPar=
ametersWatermarksAndPerforman
>         v->DISPCLKWithRamping =3D 0;
>         v->DISPCLKWithoutRamping =3D 0;
>         v->GlobalDPPCLK =3D 0.0;
> -       /* DAL custom code: need to update ReturnBW in case min dcfclk is=
 overriden */
> +       /* DAL custom code: need to update ReturnBW in case min dcfclk is=
 overridden */
>         {
>         double IdealFabricAndSDPPortBandwidthPerState =3D dml_min(
>                         v->ReturnBusWidth * v->DCFCLKState[v->VoltageLeve=
l][v->maxMpcComb],
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel=
_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_c=
ontrol.c
> index 16951a9550f2..d3fe6e024891 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_contro=
l.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_contro=
l.c
> @@ -108,7 +108,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *=
link)
>                         /* alternate scrambler reset is required for Trav=
is
>                          * for the case when external chip does not
>                          * provide sink device id, alternate scrambler
> -                        * scheme will  be overriden later by querying
> +                        * scheme will  be overridden later by querying
>                          * Encoder features
>                          */
>                         if (strncmp(
> @@ -124,7 +124,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *=
link)
>                         /* alternate scrambler reset is required for NUTM=
EG
>                          * for the case when external chip does not provi=
de
>                          * sink device id, alternate scrambler scheme wil=
l
> -                        * be overriden later by querying Encoder feature
> +                        * be overridden later by querying Encoder featur=
e
>                          */
>                         if (strncmp(link->dpcd_caps.branch_dev_name,
>                                 DP_VGA_LVDS_CONVERTER_ID_3,
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gp=
u/drm/amd/display/dmub/src/dmub_srv.c
> index 204375f1eff8..587d26c742cd 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -584,7 +584,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, =
enum dmub_asic asic)
>                 return false;
>         }
>
> -       /* set default inbox type if not overriden */
> +       /* set default inbox type if not overridden */
>         if (dmub->inbox_type =3D=3D DMUB_CMD_INTERFACE_DEFAULT) {
>                 if (default_inbox_type !=3D DMUB_CMD_INTERFACE_DEFAULT) {
>                         /* use default inbox type as specified by DCN rev=
 */
> --
> 2.25.1
>
