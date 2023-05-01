Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F78C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 15:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED57910E30C;
	Mon,  1 May 2023 15:13:44 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C2510E319
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 15:13:42 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1924a23ddb7so8927416fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 May 2023 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682954021; x=1685546021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6m/m74VYmUJbxc6nm83NUZt9ODLQoCkEXKwW63POkA=;
 b=iUxvFXefltmSmE0D41JkV4a+2mEBIam1jp6hGZE6sZmbpLTH01DPCZ7MokR5GATQ2L
 p9Esh1nv0iqIZb4O72vI1uEt6WIgLqxdxlWd0OBl4/KpL3Fl4fHd0xNw/l/0ZQGT3WDX
 6UryB4KQkKS0wdnLcy94aKwz9llo8F5malVv40HfuPP1X9eU0ABa+H5a6/ZHRS5G2mWw
 hJ6lgbvFLpbPcryTgaoLWOozU0H7tuis4n8qWKcM4DqYhksMeQKeQuvLMUROIGIX2gwT
 kpVv76T6z09pwcYhwxNjSLi8xUlTvXr2mpWIBh9RSMeZuwjEyE10NVtUuSu+WOh4k/0k
 bFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682954021; x=1685546021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6m/m74VYmUJbxc6nm83NUZt9ODLQoCkEXKwW63POkA=;
 b=NyUnxfkHaIuiAYid6iGthF4qEoqS0wkOKhHGlT/US4iUxAdsagHy1HvBBF2tSCwXQ4
 yD9OSzg918bfikHia5Cm9RWht71zWA0CWezSy97Zgve3z466Epi4UNozjouKf4nvR5Y+
 ObAMubxf9vV8Qzxby2gQ1VOaoWhjQr+fGOlWmFdePkSwdf/qZCmeMzbmX8eWePTq9dSJ
 Wbn5uX+Z8qiVQ6BLCYTUt44AfCugsojDNuHcS/TdGhcOc6wueWh/cpjLcDUFEC2NnHos
 Ncf1hI0Ar99WvsqJpUzYT05sHqrCfMUv9OFWO23lcKb1pytYZayhU7WrVGzSWIavJIhv
 iM+g==
X-Gm-Message-State: AC+VfDzxFSMVTn3ZdZVWaJd2KQ2R3SNMA4HKpgruXyQ5qJWTRgKG9T6n
 hscaknv4OhfxrAPQsAN95javCeak5+7PtoT+Qp4iwcgt
X-Google-Smtp-Source: ACHHUZ4KB9lZiTAup3dvZskJbf/PDl1DR/eno+InBxqE0V4aPdwnKilMUL9MQHe7Iwede/JHcqrQaFQTgW22+Dg8CHQ=
X-Received: by 2002:aca:3403:0:b0:38e:628d:a127 with SMTP id
 b3-20020aca3403000000b0038e628da127mr8746472oia.14.1682954021284; Mon, 01 May
 2023 08:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230428214459.1237-1-mario.limonciello@amd.com>
In-Reply-To: <20230428214459.1237-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 May 2023 11:13:30 -0400
Message-ID: <CADnq5_Pa2YmuQXwbPukqoPTtv2XtLWBy8Bm12wUX0cuyoMA14Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Downgrade message about watermarks table after
 s0i3 to debug
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Apr 28, 2023 at 5:45=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This message shows up on s0i3 resume for DCN31 and DCN314 platforms but
> it has been decided that this flow won't be changed and the message is
> expected behavior.
>
> Downgrade the message to debug.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/d=
rivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> index 0827c7df28557..32279c5db7248 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> @@ -130,7 +130,7 @@ static int dcn31_smu_send_msg_with_param(struct clk_m=
gr_internal *clk_mgr,
>         if (result =3D=3D VBIOSSMC_Result_Failed) {
>                 if (msg_id =3D=3D VBIOSSMC_MSG_TransferTableDram2Smu &&
>                     param =3D=3D TABLE_WATERMARKS)
> -                       DC_LOG_WARNING("Watermarks table not configured p=
roperly by SMU");
> +                       DC_LOG_DEBUG("Watermarks table not configured pro=
perly by SMU");
>                 else
>                         ASSERT(0);
>                 REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b=
/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> index 0765334f08259..07baa10a86473 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> @@ -145,7 +145,7 @@ static int dcn314_smu_send_msg_with_param(struct clk_=
mgr_internal *clk_mgr,
>         if (result =3D=3D VBIOSSMC_Result_Failed) {
>                 if (msg_id =3D=3D VBIOSSMC_MSG_TransferTableDram2Smu &&
>                     param =3D=3D TABLE_WATERMARKS)
> -                       DC_LOG_WARNING("Watermarks table not configured p=
roperly by SMU");
> +                       DC_LOG_DEBUG("Watermarks table not configured pro=
perly by SMU");
>                 else if (msg_id =3D=3D VBIOSSMC_MSG_SetHardMinDcfclkByFre=
q ||
>                          msg_id =3D=3D VBIOSSMC_MSG_SetMinDeepSleepDcfclk=
)
>                         DC_LOG_WARNING("DCFCLK_DPM is not enabled by BIOS=
");
> --
> 2.25.1
>
