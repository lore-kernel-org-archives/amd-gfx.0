Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72682C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E2010E345;
	Mon, 21 Sep 2026 20:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a7fLput/";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2AA10E345
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:52:50 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dfcef2896so449800a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 13:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790023970; cv=none;
 d=google.com; s=arc-20260327;
 b=HNKCCGSJSHd0FehGOOt5BcgMxWjq3wcda+HSG3kDzIS/8GJArPpx98roICv9pOxVZR
 DRDIwMm8NtiLnOD1aB18RI6sHMnjJKqxTs5EJR9JVy/XzJAVa9ZSQZV/9IT1U88qc7Nf
 7o+G0dEfIu3CRDsGQnS6/klFsjhZR4/cHAtwKjPzLRsiLk4Kdj5bVL0f1K1DZwvkUK/P
 CAGN6H/LBta3Nqdas6QkiWUdULOhJXa/JvXbI6QlrL3kqdGojZTteOA592hWdzFMZ+GU
 oXZ1hP69kL/agtQxkxHggAbLksURg/qjDRTIdzJ8Io/KYE3GK6talVRWqs2zgulJURCQ
 iFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fE9UeThI5LasTmDMAGdf9v0RO2cGZVfo9qxRh77NQts=;
 fh=oMMMDebRp9w0CfcRt0o1NBWCB4Y+Bmun2RSL+5wk2mI=;
 b=SexGLc3HE4Fm6PVk+nCVdMC6vIsnaAK3L5I6YNMtgAZZy15s8pNCDMfMPu2yJWwson
 RAcF3PD5dMdL14I7MJHJOb8nxnsAtPtBTw7cEuNm80jr+xT7F1l7WlfOD7kX+mMGo/LH
 FlaMzORz8wGhBbglpkKdj/sc7JXZHhNwEOwwbvi3K7+evTqhvcAFOII/KyF0Cw+GMlNC
 FE/2WwNqiRTuLCI/pu/hMlD/hEKlXAw9G+62hH5OPgIJgRGnFqqIvylbNi469hQEj9sf
 Qb+bA/MLqG+qqGwyZMIc0oMdZoJlL63kEdyzpDrpFbdUluZ0szUt80i8LSph11cKcpfr
 vRQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790023970; x=1790628770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fE9UeThI5LasTmDMAGdf9v0RO2cGZVfo9qxRh77NQts=;
 b=a7fLput/u0mHDNWS7KrXsQuy0rjF8TX9NS3mh5MzzuYdZCpFVoNI2efcQSLpA1zUSi
 WiTqHm7GeLS4rzMuidcR7ZlJGSi35KST1esWXzMekDxvX0aeIT5iUWNdWqk9n8gWR1xb
 6iRRiXZmgbNrSBF8s0IIM9GtzPJ9GxSIfIOkSLVYTGtgwrEtdwcVqkh2mhb2whw9YQsV
 sbwb3vCZj5bvFM/Qq/oUHSvzKOCCckkFoQDCzxHK2boTRmqAK0AczIEbj4k4nDwDeRH7
 pCZv7cKf5kuWabvNH1NJUOlhwryUm+QNZtdyGhH4Cf7PRyjgK6ZnR8V0UBkrm2Nhl6jG
 WHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023970; x=1790628770;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fE9UeThI5LasTmDMAGdf9v0RO2cGZVfo9qxRh77NQts=;
 b=TJ1Yq3EPaIlqZU+XfuITVJ24yCI83a1F96emKc/hs62hBicrx2nOYETg4uRmMEDWUW
 Sp5bzcAhOarfs/wQu8gzJH7d8kDmyGAUDGM2QVFqxpOTGdXPaImbIQfbrCV5GGj6l00w
 8m2rPaO/TJA/BMYD5aMstlMZ7Fokpr32xhLQj0JFjw2m3q91fFXuqzCsDmuWksRl/f+7
 OxQhZwx4bquZDXtXzM+eibEA9RLlaguSulB1c+P5a6ouw0vxku8/AYZDoFlJvieuwgag
 UMtdbIafcCQBdxvOzoVPn3Iaj/k38znrSdgOKpX99BL2xGylv8z0ZK9JuCt4lZ9ZhIZ9
 4ttA==
X-Gm-Message-State: AFuF++mKF93e5MPce1rNUanwGt+UUeS2sOyemBmf/WZftGu3qdde4dwk
 ygKPUAWXNsykRKk0wv4G7Ui11K95Pbdd2QOpzkxDHHE7CiLHFE5PiMLHYFRUvLH0ZRNZT1f4CNJ
 LLjhK16CNtRQnBoqFrwWgSM4bKnsyihw=
X-Gm-Gg: AYBFou1irQ3IwsZsuJABBNGPidwbpgEfQd7n7gomxnxF112PyQZb+CZQK34OQ/pBxq7
 7m0K+mHYx8xW+sFkqcY6KvFqX3kxEW/50mGpsLJ7WKrP3I103wtKPXm8aGv45K21a2gbztO3LdN
 Ft0ypZA+p0PnVm6VFtbLqFO7aHN6+lW/SlvcKb7thsyHgFTB378nlFDAIShmV85cSnkD1Jdbxuu
 TdbgaIq2CHa601TtkSJrbtwR4GqalFTZ98p66MTv6PVPuahvsaTCVmppZJMhgyqGYFBWlQf1R5L
 LHXAtWz5dEDhZJYjjBoVL77Pqkf2mByQoHnr1md2z9gPZYA+nETXoEX5yIEJ7zvCpm7uBctdMBa
 l3iHjNVkhiwtHY5wWp0t2VHEiW84xpp3AsAYWdaMuiA==
X-Received: by 2002:a17:90b:1a92:b0:39e:55ce:af15 with SMTP id
 98e67ed59e1d1-39e599fb4d1mr22238438a91.5.1790023970255; Mon, 21 Sep 2026
 13:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260904183409.571117-1-timur.kristof@gmail.com>
 <77bd73f2-3e33-4c78-adaa-634b381ea5b8@amd.com>
 <RY2IRd_oQXa3Lr23bQzSrw@gmail.com>
In-Reply-To: <RY2IRd_oQXa3Lr23bQzSrw@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 16:52:39 -0400
X-Gm-Features: AcwNN1X8a4YV3oHmJg4Ia64DDqgpWPgamzVOiynDVvy9rZT2ycdVJ92OK22sG1Q
Message-ID: <CADnq5_Nxt4SvOexDX2gT4DTfK0qomujhU9YDpU9uVSv_UEU9rg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Delete SI/CIK/VI IH soft_reset() code
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Alex

On Mon, Sep 21, 2026 at 7:16=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Monday, September 7, 2026 9:43:55=E2=80=AFAM Central European Summer T=
ime Christian
> K=C3=B6nig wrote:
> > On 9/4/26 20:34, Timur Krist=C3=B3f wrote:
> > > The code for SI/CIK/VI IH (interrupt handler) IP blocks
> > > has a soft_reset() function for each block.
> > > These functions are not called from anywhere and are
> > > dead code. It's unclear what the original intention
> > > was or why the IH block would ever need to be reset.
> > >
> > > All SI/CIK/VI GPUs have been working well for
> > > 10+ years without ever resetting the IH block
> > > so it's time to just delete the dead code.
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the entir=
e series.
> >
> > @Alex do you pick them up or should I?
> >
> > Thanks,
> > Christian.
>
> Hi Alex & Christian,
>
> Ping. Is there anything I need to do to move forward with this series?
>
>
>
