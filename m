Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1D7FD8FD9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 16:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA5410E9D8;
	Thu, 26 Feb 2026 16:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bsecA1zQ";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A82810E9D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 16:54:39 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso83092eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124878; cv=none;
 d=google.com; s=arc-20240605;
 b=jkRQ4ORfXe5jvG1hTpP88QG2MntRC8s+pWx9ONmIb3T6jIJU+HGj8718i1HbUcpJLU
 6TEG1O01Ehcv3lOSj9a4u0ovAIdjX4fQFAre+ou5Xg4U0PcTyLGZeopaJIolKvWAlwvk
 JK2U0K/JmdKAkY30O8EqkgWworxiCXwXTN2YuInP7BYgTqXPfE+cjCOr5F6t1DjtB2hz
 wmUliDCuaQKdzNERtM7HvZMFbdKVn9Dwli6an7dK7NsbG3WLY4tsch6ew5lH6vry/JV+
 GtiiMIqiCoEohtGZhF9927Xg7Eb7y8XUbSoq2CtD7RZKCUECU+ZONf348RXXVaR5xfyE
 lChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Up3sT8qjuR5kM0SPkhMO2u8EAJVJK4TECaFQv8JLTOM=;
 fh=+JyG5JBvSeunIIwyQbZAlEPaka/uc/yMgD64kkAO84M=;
 b=ksKW05a6oAIZcxFyCxiQxTvzlqpt9+iBFuqSdmjXksAfKIXkEl0rVllwTqhFu3qjKc
 wx1/4yH6DQlv9KuzJdE77u6rhasPv7fzPuPrCli2BixIroJszFZdq20XXVZy0az2wdvc
 qKkIS9IJlj2OTKltMoRSN0tXSNpuL+y52Gj5BCoHIcjaoU3lAbQJj2e8sLsweAPJOXEZ
 EjuJmMEH/J8mi+eryevvUeqKdXpsyf+umkC6oAIz5STjn+6MUR4rtLxWUWosnbiNaF23
 sUyr+S8N4qrKnTSJqKRnw7d3gcyp83FUz43UDqDK541rA500dBoCRGpxrHWbRBW6irfM
 kqxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772124878; x=1772729678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Up3sT8qjuR5kM0SPkhMO2u8EAJVJK4TECaFQv8JLTOM=;
 b=bsecA1zQKJaORF7opFUhwDHK8/F5CmhDrs4cMTf8kCB/Qd9A7IO3ubFjBuRBOk+0IE
 ETXIJ7lumShjWf0huZt4fzbO2tHzY47qsoiOXMcSWqV8LBikPRGIsqsnoRAS5koi1QcH
 onPd7O5VOlch3YfSjmt6/BZjlH7Sq711fOgeXsvueGaiYsXDOB+FTQucZGY/ITlzeihK
 M0/xlWEjJ6idR4Ecx0HDt4RQ2CDm9/QC1R4KFDVjBdJu3/dLNfNhtC3/feu+LwXwE3us
 AB/A3VIayIWQmSAYxE/SsiDLJ01DQeFcW8+3YgPOcjhWpXbhIHRIOPKer0dLB3kzITPz
 FhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124878; x=1772729678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Up3sT8qjuR5kM0SPkhMO2u8EAJVJK4TECaFQv8JLTOM=;
 b=Jqb/7AsPkmadyq55QZqcpBGJmQqdewUPBdXcTeSSBT1857jGOt0o03M2ypMtkbG3i0
 LS7GxPATafuQS7nz87BrDVj+4HgS/GVYpVW3twwMpuwfDg7pwmCPLD9zsD06buK3FzVh
 HduwgyTGds88DjGXM+UV3Ma2BDy+7v86UkadF4DkxSOeuZmvpPA09JEz1PkfHE4ybF9h
 QNyX5ytriqkdiX4wxYUe9UN/moW9O9X/HydXwtbZaSFBrOhdrBXUjQpalarF8wkXDtRV
 VuSeOLSRnxS+xtP2TmzHhZzyQWNItpIzEiNShy3r6IhhzH8/Td1UI5hBX1VfJ8k+5PxV
 f0Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3QMiHQ93eDDD6dAgCY4olJhaCd6O1mOUkOJK4e+CpTNMSRzXkfmZEeIcaAv3GOwWck2SbFTUh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWS6n92NP83AWoaqI3r6rnWV/TgEL2yuo5tF2rQSINfvWtPUG9
 E+gkQsHajCJCQnDIC8hdJbRH6h3JimmV66Eqd/HQWtokEJP4cp3jnQuuy1M7CHy0z+1iGNbmPSZ
 4YIeMrzsijsRS+EAkpj6W5FAzNRr0ITU=
X-Gm-Gg: ATEYQzzdcgnuEHAZVC+IsmpSbo3PRj+vZzCoxdcwD2KsFB0vabgTJttD++EQzl0Nmbm
 IkGu+eHc+Xzt6jwNktdKpLYpb01U8xKWbLyJCk++ubflFhwn2hG4GwW8icW1jncOeP6bpT9wWTE
 j7O4akZZNKOdzkOfGV65QJzq3QOR1mA+W2ade4q6MnmogE5McMXqdbKbP6Dyte+6QDD+o6HEkg1
 4DAW1EvHZm9CmzEFoasnBublU/DSbzH79hy4mID7q5X11nyQrEI+H84aSm9ZPRRLFMV+70UUsCy
 oNbhcvlv3FUY06aon+tmN284av7NxtK32Q8Ur6jHo5Gg0OFEiMCnyJnUfPIsUQlOBNkv0g==
X-Received: by 2002:a05:7022:f005:b0:11a:43fb:58dd with SMTP id
 a92af1059eb24-1276ad3bcd8mr3975440c88.5.1772124878272; Thu, 26 Feb 2026
 08:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20260226030038.1182961-1-yujie.liu@intel.com>
 <20260226030038.1182961-7-yujie.liu@intel.com>
In-Reply-To: <20260226030038.1182961-7-yujie.liu@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 11:54:26 -0500
X-Gm-Features: AaiRm50FIm7gW9ftKbXM9mUDFZF-JB2g7m56NgkO01zsGUV36mqPkWnCPIpQdvQ
Message-ID: <CADnq5_N819Zv-dQU_rswGDBdt7wKB+fCgFDLswbLgbwhz6J2Sg@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amd/pm: fix kernel-doc warning for
 smu_msg_v1_send_msg()
To: Yujie Liu <yujie.liu@intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
 Gangliang Xie <ganglxie@amd.com>, Candice Li <candice.li@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
 Michal Wajdeczko <michal.wajdeczko@intel.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org
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

On Wed, Feb 25, 2026 at 10:19=E2=80=AFPM Yujie Liu <yujie.liu@intel.com> wr=
ote:
>
> Warning: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:415 expecting p=
rototype for smu_msg_proto_v1_send_msg(). Prototype was for smu_msg_v1_send=
_msg() instead
>
> Fixes: 4f379370a49c ("drm/amd/pm: Add smu message control block")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index 6fd50c2fd20e..c471c0e2cbd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -405,7 +405,7 @@ static int __smu_msg_v1_ras_filter(struct smu_msg_ctl=
 *ctl,
>  }
>
>  /**
> - * smu_msg_proto_v1_send_msg - Complete V1 protocol with all filtering
> + * smu_msg_v1_send_msg - Complete V1 protocol with all filtering
>   * @ctl: Message control block
>   * @args: Message arguments
>   *
> --
> 2.43.0
>
