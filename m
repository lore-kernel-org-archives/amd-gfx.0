Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3F5C32771
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Aug 2022 22:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E74110E5AD;
	Fri, 19 Aug 2022 22:19:14 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E2B10E380
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 22:19:08 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 n16-20020a4a9550000000b0043568f1343bso1030690ooi.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=ElEwhFKGd2FC/9X2FVtgbgG3kjrjD6bdwf8mmYydFDQ=;
 b=ei67oZ0P6p8YavAJDaTjRKO5rKLHeUQRVFLbCmNEvBQeWqtwEn+tWq+Nx0jpTknXaC
 AvJFSxHNKV7ad/HzmVXiqB0kpkAEicrfpo4oZ+WQJP8/06vsqWPaVx2bnY/+64p6Q/s2
 4at/0nIxIVqxdyY5Sdp0qhkabU5uJU/OUW/FYAfcojWG+VKOWC/QF4PCn1p2jsnfFVYT
 dvgW7scRxdk+Nu5aj0SMR3o1CDl+BHuWm9m9E0jQ5iC2dSWeAf/uy7vfwDnw0NL1T/Eh
 Y3ozMaePyh8/dBtDXJjK3RiwOlftBgLNXQTnQzLE0+utnxiSOUfckRZK8lxBB5fdG0Td
 Zn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=ElEwhFKGd2FC/9X2FVtgbgG3kjrjD6bdwf8mmYydFDQ=;
 b=Ayy6V9zZmUaBVOb4oiglDmpjVkWsYL9m5db7MBQ4yMS6JgqE83lTh/Rc9KlRiREN9l
 HdjQnHuvEnOITg8xJTVf1sSGhvyepcFkggTSf5RO7rNme3iPqU0+YBGrpKd6OGWWm0KW
 C9KnOpObPazSPPWA1iPzsxr0KB1SE43f4UILpOLgBi/HjGeDv+mDLN0G2hDiq+5kzMfL
 aIawT5zrYuvOyzJYon6s8XnX9hdO2rL/kxD0lXfExtOQXvAUQT7ScqRZc0xTMazZzu9w
 wCYA6yqQ98w5dCKLDPr3EwqgAQI+jhY/Pj79RXZeI5k3yKXRVVcByswCndxeJ7OZAVJ5
 sXUw==
X-Gm-Message-State: ACgBeo3aUxHOYERSR+BxX1gkQJP4jekqcdTgE+WkJjaS9Ql0oE90IqgN
 aOeuqeNFu+f4xEr3G7xah2BMVMe9Ac6M+6tr9J4=
X-Google-Smtp-Source: AA6agR42zS3VCTYuNVOWVg7wg9gxGvN0NIfERQyV6z575IK8vwHqfaqShMPhyK6yRmjYqCOaf8OpdILmvmOAyXIUaYk=
X-Received: by 2002:a4a:4541:0:b0:435:cf9f:1a45 with SMTP id
 y62-20020a4a4541000000b00435cf9f1a45mr3226037ooa.17.1660947547579; Fri, 19
 Aug 2022 15:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220819210112.7924-1-rdunlap@infradead.org>
In-Reply-To: <20220819210112.7924-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Aug 2022 18:18:56 -0400
Message-ID: <CADnq5_MesHnxboGboMy+DUYtBb-EAeApHVsqwaHOVdL7rxYwWg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Felix Kuehling <Felix.Kuehling@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 19, 2022 at 6:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix build error when CONFIG_DRM_AMDGPU=3Dm:
>
> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko=
] undefined!
>
> by exporting 'cpu_smallcore_map' just as other per_cpu
> symbols are exported.
>
> drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> This is an inline function on powerpc which references
> cpu_smallcore_map.
>
> Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm,=
 thread-groups"")
> Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same cor=
e")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  arch/powerpc/kernel/smp.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -86,6 +86,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_core_m
>  static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
>
>  EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
> +EXPORT_PER_CPU_SYMBOL(cpu_smallcore_map);
>  EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
>  EXPORT_PER_CPU_SYMBOL(cpu_core_map);
>  EXPORT_SYMBOL_GPL(has_big_cores);
