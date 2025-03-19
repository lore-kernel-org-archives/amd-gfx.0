Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F88DC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 12:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8006610E353;
	Wed, 19 Mar 2025 12:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NbySL0WD";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AED10E2FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 10:49:09 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5e82396baaeso820942a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742381348; x=1742986148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTgikse23GyGclN40fXjI2agaY8948pyCHv3GZdkAVo=;
 b=NbySL0WDylqb5oIZ46RzKp6LLCnrRdLYzxN8+IrP56PWinXfPVdCHNNyVTiMhhJtGh
 fplvOgZFObIPX0Z8eUdg1+PGkQCd2pvpLFOJE82/S8/Lv26iU7uTt8i7PW+jYwPFtshi
 dHMrN+KSFMQSEOHxJsc+8DAF4qtQ7gVpLBCtoFHKwbJN0WmYdjQbgLLtT0ZMbk9i1S04
 6O+U6Jxg8geOHY+TEkWNP0M0b+lOrnGF/kcsBjK4PlhuhaleIdZB3ql5VoJqx8mCd9mb
 ie6Go4M0D6RUlnUpXpPCGnZHU8kYCHAhkIMwapklzcKPiEt31dxmtPdN3YUGjmF3Yrig
 y94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742381348; x=1742986148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTgikse23GyGclN40fXjI2agaY8948pyCHv3GZdkAVo=;
 b=tsZSaIeCjA1SKJSuvQryF3KIFDrRX0m2IOF66xuEhThM4ZhjtdpGo1gHzMXfEXpxIm
 dFmhIL+NoYctb3KOmOxB2Dpt0EAbn7dof+ZQoQq1J7xhj0DpntwYKLCu3CytnvoL9RnX
 1Ib+rBGcYduPNN6Kh6hIGgxoZBIgdm8PlqzD7yUWczAigNEeGywrEvgmVNoYlaF1XdP/
 UqJoZF4315VvplmNhZMZvMX3S/m201g6o1lGbF3uiWqIupH4melBcqY11p22j9/zKqm1
 kR205CMwsL5ZMLqnb1c8NPWV6jyAzjEoIoxNHuupjWADZYtkTLS5wgPu+B2AZUqhpG97
 zO2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtFwuKrzmNHxMXtdTSEmRp63vJCy9HBl9JFxZq632LTuxEk28w+tupch61+VpTI9J4X+DVckMy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAw0Ugxifd0NS1gBucggr2AzMlmoKOKkvtgoxnCLJo8X99aoFa
 iJgi+ovxBbKi5O+e5Gy79hb/PegQJHbinTUlP+IyQ8qf/hAlZN5bhFTGqPMNofQJs2uhbN5b1KP
 0C3TyefYd3X5eTSpKAqvc6aYXGck=
X-Gm-Gg: ASbGncsSsobGGyWsUpJ3jZY7ByZPI1NHvdJgmjqsQzacVTgjfjMsohuh8ZeIri423oM
 dSCqs9SdI2V6rQmC2PC3hUNWq/dkO6dPW80zpE1rimLoVEesF7WK7LkRVrEsyz1UuOu9dKEuqW5
 YVKcsl6AgJRq1FQS2ULmCfk+MZeBQ7q3wSs4w=
X-Google-Smtp-Source: AGHT+IHpN5xfuZTVQB/m0CRWe9Jw4VfJBkZIA1xGe63C4z3vPd5vaVyx7aI71r7Cju7F7Y7Vf0/ZQ4OXUpAkB8DEa/c=
X-Received: by 2002:aa7:c982:0:b0:5e7:898b:249f with SMTP id
 4fb4d7f45d1cf-5eb80f93874mr633888a12.8.1742381347375; Wed, 19 Mar 2025
 03:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Wed, 19 Mar 2025 11:48:56 +0100
X-Gm-Features: AQ5f1Jr4OKysNT1Aw9ZSku-L0GYX5JBmW1fSSiPu7ldN4nP3GjMGjovkbu5Ufj0
Message-ID: <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Mar 2025 12:46:31 +0000
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

On Wed, 19 Mar 2025 at 03:19, Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> Sent: Sunday, March 16, 2025 4:16 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kennet=
h.Feng@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting suppor=
t for SMU 14.0.2
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Hook up zero RPM stop temperature for 9070 and 9070 XT based on RDNA3 (sm=
u 13.0.0 and 13.0.7) code.
>
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  3 +-  .../drm/amd/pm/sw=
smu/smu14/smu_v14_0_2_ppt.c  | 50 ++++++++++++++++++-
>  2 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> index c2fd0a4a13e5..a5eba7b91e2f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> @@ -846,9 +846,10 @@ typedef struct {
>    uint16_t               FanTargetTemperature; // Degree Celcius
>    //zero fan
>    uint8_t                FanZeroRpmEnable;
> +  uint8_t                FanZeroRpmStopTemp;
>    //temperature
>    uint8_t                MaxOpTemp;
> -  uint8_t                Padding1[2];
> +  uint8_t                Padding1;
> [Kenneth] - This change on this file is not required. The latest version =
on drm-next has the change.
> Could you please confirm?
> Thanks

I just (19-03-2025 10:48 UTC) checked against the current drm-next and
this is still needed.
The last change to smu14_driver_if_v14_0.h was made 5 months ago by
Kenneth Feng.
It's the same state against which I made this patch.

Tomasz
