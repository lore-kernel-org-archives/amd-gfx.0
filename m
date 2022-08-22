Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459B9C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 07:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164A39A93D;
	Mon, 22 Aug 2022 07:18:46 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A28997B5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 03:40:30 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4M9ymm08WXz4wgn;
 Mon, 22 Aug 2022 13:40:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1661139625;
 bh=VKTUo2W4RNc2LDslDMcLOnHhdlFBjvbL0BUKEgnwbho=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Je1l+Xpf0IQX7/cqLqeVKhTFzln629PFhZPHnimgYEZfZglpmJOAXo6zZ3qqLhZaf
 pTCMCKJNyh1BWnCZeF0hO5SpcKNefkyzqjvwSQSbB0Q9p4wyY4mxq13vFYf00xpcbr
 xzuVuyPEnHozay6S9HX2w6LkAycpVJvPeR7oLAITkfkdIucCbL9dApvTjnXqw0Xk73
 7cI6LYa6l3ecozrENJFNG4Kt7ornODrTsmYmlmdbec7ns7F8/FpSHkUiBLALBeb+7m
 8ZXm3JZUDtz306E+p2oj6x37piBTa3oKoIdFKPIktfSUup6WZ2toUR+qoAlwz7y2Qs
 AO9ZaxnMzKH8g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
In-Reply-To: <20220819210112.7924-1-rdunlap@infradead.org>
References: <20220819210112.7924-1-rdunlap@infradead.org>
Date: Mon, 22 Aug 2022 13:40:23 +1000
Message-ID: <87o7wdkkt4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 22 Aug 2022 07:18:35 +0000
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 amd-gfx@lists.freedesktop.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@lists.ozlabs.org,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Randy Dunlap <rdunlap@infradead.org> writes:
> Fix build error when CONFIG_DRM_AMDGPU=m:
>
> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> by exporting 'cpu_smallcore_map' just as other per_cpu
> symbols are exported.
>
> drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> This is an inline function on powerpc which references
> cpu_smallcore_map.
>
> Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
> Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")

That 2nd commit is not in mainline, only linux-next.

I don't mind merging this fix preemptively, but is that SHA stable?

cheers
