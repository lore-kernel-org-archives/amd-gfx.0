Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09845C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 15:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BE910E34C;
	Mon, 16 May 2022 15:13:42 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A17810E70E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 15:13:41 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id i66so18916167oia.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PaxEoOpgx7zAYBu7sLmLC79LG5mhZ2DkI7r0GmL27J4=;
 b=gpeuXrH03b3i5WAyl9MAsDpR6zECDOufe1KbkIBRJ8dlMfNnjYf3hkfMdsEyYNb2+U
 QrqQCDZ6OafB25/WKem9DlAI7Vwa6zcIQu0QMEyZIycadWBE6vDad3ovgjFagEzRkETV
 WJw7KP9HQ5K2uEAD8iJkNfav0VHmH9co5W9XPJUiNxcXBbbG/xC668KEF2A6EKl+TSXv
 vVTxMNmxP3hyvUi2L6p1iah5rWgD2XWKv9ylw3O/BgIv/gmRl8i5IPmJP4Grqfr6VOge
 bWFmC9f54cbBoErmcKfpCG+WB4D7YQzRT/4vW7SujyID8fNh6H/apJekf5fAiwlo0wnd
 xLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PaxEoOpgx7zAYBu7sLmLC79LG5mhZ2DkI7r0GmL27J4=;
 b=ndT5ze6qjeUe+P5JSOdq1rbgwLL7lHQnI86MVZmiub1Vh5dY+EaInFx1SFxsL6aR0K
 kqecyEJ7LTsCg5MTVewQyP39cO/7WUwM71yModNf6UQiCHTgKHfi4ztF5Aixk62A1hCO
 8xy4QVxy5aeUwd1TB8f0PN/++s6DZ2Na4ZpfK+8UZctTpXjieRt1cA95NAdE8rsDudsl
 ZNrEFg7eaUYcRXntOxAR+lkO9OQ6yd/ByFKUnGKAotmptscyknyxOPGgFomU9KihdY1S
 eiPodbMD/bwgizsAjqATMnLaj9VBiDG4Rw2hROIZ7rs/yVLKdj1J8W6Y2I5klUhmKsbR
 USbQ==
X-Gm-Message-State: AOAM533OmSkPwzTU7XvuvzITdh3eeye8MmOVNNOYDxQ/C1GasSqvih9R
 EPn1F2p5EHHbKNkXyeJv4QMlDlg6XdDxFiK8Fe4=
X-Google-Smtp-Source: ABdhPJwe22s9RFFS+nJooi9f0gXHDA2ZlsA5S9d62EPGaZwjg7Dqc755a/oYAIjFOA8cD9QVy4NyTrFde4+c+t6kdxo=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr8484852oiw.253.1652714020489; Mon, 16
 May 2022 08:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
In-Reply-To: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 May 2022 11:13:29 -0400
Message-ID: <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
Subject: Re: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, May 15, 2022 at 11:46 AM Ernst Sj=C3=B6strand <ernstp@gmail.com> wr=
ote:
>
> smatch found this problem on amd-staging-drm-next:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443 amdgpu_discovery_get_v=
cn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <=3D =
3
>
> This is caused by:
> #define AMDGPU_MAX_VCN_INSTANCES 2
> #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
>
> Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use AMDG=
PU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?

We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it
would waste some memory in the places it is used at this point).
VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we
can't change that without breaking the firmware structure.

Alex


>
> //E
>
