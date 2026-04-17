Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3339EF8D74A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 08:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA8510E294;
	Fri, 17 Apr 2026 08:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csWpib2b";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86E110E294
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 08:23:09 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d4be94eeacso388648a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 01:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776414189; cv=none;
 d=google.com; s=arc-20240605;
 b=Y3VVJp8GO4+GrISdjPUWrRjY3aICZNDpmfLcoMSgNqHMV2/OdHHc9lOXoax/HmVg/K
 CldIH/87fcD/D5dQP1m7o4SsfJDhe5DP46UYjbqNbatLoU67sN0AJNKuPZUv2OgS3S89
 E+d3ficbMddLZp3kiKb1o+FaZ0BXzdQTiNG1i71hrfPSG1LwafDjaMIjiWucq61mgoQH
 ulbvDPyBKUNkc91GaPjdFSiIA3dR4o5PmfwIqXJz37xVJdeVAlkcCn0ErgQDcakniB48
 UPpN3B5O5LkGXlaei3y2NXrpa8DN8evx1lJXildwS5XEkbzxYx5DQ8I1A/C1ma/cvnWn
 PKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=woDoqLHIajnMivWv45ENu9wE6nY7bLc4DhmibJPzpDk=;
 fh=mXNh0Y2CHCVqKIfZtL4i8/6nmS/RV/UTQma14wqsO3o=;
 b=dOv1R8P3ELv0cbZpWkV3z8ZFWAeBPJq/0h4uir6lKZsOL68Vv6lqmQlo5f56s+65u+
 6a6hMg9jg/PA39G0PhrkPA3OC9UL3imAFAYpTd7Z5AJJt6k/+CFuXPFHVS3KnCytORMW
 zml7PcQVmcg+WZtKhRMePqMrCMJu9rG+bql11gYbmS6i/5oZ6aQtOPfMshH8C70Av39A
 mQM5SBhl4TAxjH79eefD5kN7y/jqFWM+Ri2+YIbIAswwm8HpH8pBD4F4ufCreQReXMZp
 Guc6aVZHZwikzXxtNNkRK8k/pxlsrpa/Trw6Wap5axIMvJCrLDC0eAxmeHpYo0+Vsj6z
 tuZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776414189; x=1777018989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woDoqLHIajnMivWv45ENu9wE6nY7bLc4DhmibJPzpDk=;
 b=csWpib2bR9AQyUw0JLB1H6xKcrZa4FzbQxxo33sSY15yffkKxlSyWip58tJFrQWSnF
 hAefpS0YqTrTROsSArUGf6IsFr4yNwXoA1gwMmTUiXNA88gyQReL491/lsoiGtr1f0oc
 kYqk8gENygZ3tteLJ21obxPyAOuzuR1VxnDKdvNXha6WKZh6ubyRsNt0kWxYfOxk1SDX
 Ia0BN7yjiZzDGs2St6sTfwjZQHAJiXKDNsMZ0acSe4dKQAad+/IyDfc+FcjGziSV1Rk+
 O7NyRCYp8xfZT/btLmb4s4TeCQw/Va4gn5NQwsByZBlewZ2eEA98R53M9N5cWKvWQqzf
 oR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776414189; x=1777018989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=woDoqLHIajnMivWv45ENu9wE6nY7bLc4DhmibJPzpDk=;
 b=behY8LaXGym11l5HljmErF+X86GyKdssHugsCmZS905UlTaa7MWqmiD4mp7nZoQodx
 te4q8Rs97uZXlkyoYvLZKN3f1d4c8R3i719XCiCrJJJ/HUSJuK0UykcQQuc7njyWoE3l
 zWQBAa4pEbWOdNAIYzEzldsSKiOls1UuDUEIZb7GWK+20lznpvf6ZEAhXgu8mrImtgWV
 +VNBd1z3tiLlCDWibCODzcNc0r6Kb26R3YXrYObuiWHpu4cU5g+93eluMLv2yO2mw9Q0
 MsuAgaajL7ikPQBevxKo4cGk/Ab6kgWUyf/O+3f1TXeCB1ntdBNPSePZUm4guT/7+YUf
 OMUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ923FQfVV6htLvTUOM/7cgqvFNvtt5WF5+27t0s1otlb8JW/M6caMczuSwwUO7KLJfUKfVZ2S8n@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgd0KBvOah6iuWTZE6vvQEnMuyRiYWcicvfgvyxVxw2YM+2pVZ
 CxsnXY/4ihIY9Ln/kee+47JvfwsMWNNxxuIcw7pZTRdejWWTaJ+Vy7nwueWqzoOG+r5KPZClUIB
 o52OK+kclzvj9Wx1z/Zi6Rfvt3GIoxC0=
X-Gm-Gg: AeBDieuGuspmPpGKv/4CGZkp3TJphG1bOEqC//dt7iv4Tg8apC3TdJb+7wjHFoFd8mZ
 Sg3ok4jw+5Om1mYLa8PIU4PGRbYE/8S45a7VIX+4CuEgw7Zq0GNjzG2Lk083WwMTOsReyyiHcHc
 m/rMQor5zjeTSdjy36fEqOPcSXPBVptDs3mP24AVq7L8/7L0zeW2W8il7c8C4HWtCH/AZwOHPV/
 aJLsp2mtMzHN3XplS/sTytEAJyC9N62J08GozaC54zzksZ8MPCxI1fHVuk0nozKb7Y3McLJN+Sp
 NTZ+JNUm9hLNfGO/5Tvu/w/L0Uq4gSI=
X-Received: by 2002:a05:6830:81ed:b0:7d9:b58e:55ed with SMTP id
 46e09a7af769-7dc9522b228mr1064055a34.25.1776414188878; Fri, 17 Apr 2026
 01:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260417001503.26147-1-mikhail.v.gavrilov@gmail.com>
 <IA1PR12MB63074B99C20B81C7D5DFD7C5F8202@IA1PR12MB6307.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB63074B99C20B81C7D5DFD7C5F8202@IA1PR12MB6307.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 17 Apr 2026 13:22:56 +0500
X-Gm-Features: AQROBzCXwvgzZjV7RJEnXadzoOfi3sm37MeeW-RH5FptvuaBgU_TAR3aHCn8pW4
Message-ID: <CABXGCsMnz+m3cHSQMAjOsGEz35u4usQ2TJuxSwZHQuSBEThF-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add FPU guards around dcn31/315/316
 update_bw_bounding_box
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Zheng,
 Austin" <Austin.Zheng@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Varone, Dillon" <Dillon.Varone@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Apr 17, 2026 at 11:50=E2=80=AFAM Ostrowski, Rafal
<Rafal.Ostrowski@amd.com> wrote:
>
> Hi Mikhail,
>
> Sorry for problems that occured on your platform.
> This issue is correctly fixed as part of this change: https://patchwork.f=
reedesktop.org/patch/718415/
> Your change seems to be duplicate of above change.
> Please retest using mentioned patch. If it works correctly, please discar=
d your change. If problem still occurs please share me details and I will w=
ork on resolving it.

Hi Rafal,

Confirmed =E2=80=94 patch 718415 fixes the warning on my hardware.
Dropping this submission as duplicate.

Tested-by sent to the original thread:
https://lore.kernel.org/all/a59292d686e3d5c17fe36e20b55996208d36a6fb.camel@=
gmail.com/

--=20
Thanks,
Mike Gavrilov.
