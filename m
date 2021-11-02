Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8094760C49
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8094760C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8827302E;
	Tue,  2 Nov 2021 15:57:55 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113287302E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 15:57:55 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 v2-20020a05683018c200b0054e3acddd91so30619294ote.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FejIW0llC6SXnex5blz4Cm4Y2+G3K3d8q3QkjhxD0+I=;
 b=p4l5JkmFwHJN8Yql9oBXiGr5ExFPXdqwZmjEs4hOwmD8Q1oR567g5CRa6i39GWHfoh
 YSSM8RZr9KO3dZ3s+lY5QUX3IegJ5mra3j/E5nJ8jdrZsRFHvcpp3Id+UNsR4sJxPXdJ
 Wa+/4cYg/Qpll2f1Hr3c8AE/GBUNm46qQ9fjf19V7U6hR6jUYFy86jfUWP3ms4NJ9yPn
 /+T2WS07ic1jcxZbv+F/8KleaaDwLuNsuvnigiLm23FhJJC85X10v2O3CH5BHvlkR9lT
 l4x4/Eq3kWD8JL/DSF/zVTsQmywE5svQJgPPVngw4B/k523cz298vV630bv07fDdC8TQ
 SGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FejIW0llC6SXnex5blz4Cm4Y2+G3K3d8q3QkjhxD0+I=;
 b=pgQeDMQ1+ZBYjHFoYSld9mNUMfwn99TarjCEmdHOi138M7NZVE/qIOKLmCSrTcKZtY
 F5WwoJQ9GwlVi1LhvRYl+W6gF5DYHLv2jKovA0XgwFQUfv3ifCfbQYa0+mlNvcczRb8p
 UR060Er8KBMhR1OpGpU7RXXG1MgIyFziFwisCjZ4SLQ365RfiqDmVgKT0ce0I2gTGGSP
 ktEofrU9JWFSR8TdkoieRIsLn2FVgYfwGXnB65J3i3UgGKBk1DhdDJ5vPu3QUF7r+ZOV
 6L4X5KumMt3AUhlejwpSDISp0PuOeu8F2XD+34rKH/R7hl7qDE1KBranK1weGGAPBT8r
 WvGg==
X-Gm-Message-State: AOAM530ZrlYDmAq0rEEA1hh5etxVJ0eBSwWSBpxL+TbslkmcUQNOBtbM
 uI9AfF0va5Dz+zrHvS7w/jELHhV/f1G3DsmE+DOM2pXJ9TY=
X-Google-Smtp-Source: ABdhPJyar6LX8Xw7Auxg63GnYv4P84GhypRJ4dUC01HjmS/nd5q9JUOQCaK048xZlQitoBoil8DcATgfjiy0qPUddXM=
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr28345564otl.200.1635868674356; 
 Tue, 02 Nov 2021 08:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211102150437.19370-1-mario.limonciello@amd.com>
In-Reply-To: <20211102150437.19370-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Nov 2021 11:57:43 -0400
Message-ID: <CADnq5_P6osKedfyZoENxx471hg7jbsjEfP=2n7rniDq2+fHp3A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Roman Li <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 2, 2021 at 11:04 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
> asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
> implied a new dependency on newer firmware which might not be met on older
> kernel versions.
>
> Since sw_init runs before hw_init, there is an opportunity to determine
> whether or not the firmware version is new to adjust the behavior.
>
> Cc: Roman.Li@amd.com
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
> Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> Changes from v2->v3:
>  * Don't special case Green Sardine / Renoir anymore
>  * Special case the two Renoir firmware that have this problem
>    (that weren't released for green sardine)
>  * Special case development version of ucode version
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b48f3cb5ddeb..dcc97ef28c50 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1410,7 +1410,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(2, 1, 0):
>                         init_data.flags.gpu_vm_support = true;
> +                       switch (adev->dm.dmcub_fw_version) {
> +                       case 0: /* development */
> +                       case 0x1: /* linux-firmware.git hash 6d9f399 */
> +                       case 0x01000000: /* linux-firmware.git hash 9a0b0f4 */
> +                               init_data.flags.disable_dmcu = false;
> +                               break;
> +                       default:
>                                 init_data.flags.disable_dmcu = true;
> +                       }
>                         break;
>                 case IP_VERSION(1, 0, 0):
>                 case IP_VERSION(1, 0, 1):
> --
> 2.25.1
>
