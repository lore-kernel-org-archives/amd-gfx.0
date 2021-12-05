Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16484C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C217B7B7D6;
	Mon,  6 Dec 2021 10:22:17 +0000 (UTC)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8937322E
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Dec 2021 20:18:30 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp6-g21.free.fr (Postfix) with ESMTP id 7C6207802FE;
 Sun,  5 Dec 2021 21:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1638735507;
 bh=S2W1GOl7Wfwiv5Xe9e+TPClWk+KffDc79gFcp8tmrms=;
 h=Date:From:To:In-Reply-To:Subject:From;
 b=iB34Zx6wdv/qzyY8x9rdoNYif7381rTC7L1KARqHdjFzsQBHUhtny4mf1u4IjW90s
 /gYCU+Ih8PBmwE+cYgiZLX8QIWp55hxhsD4NgQDCnQpu3ip7U7igWis5R8QCdsbrh9
 9vrJxBpPdoe0YemIyERlw1dcOqw05dvRxdkBaSSoMA9+8TGn0FZJ2+gDAqF6krfzU1
 p0xpL67LTfUhXOYjCK8DcM+RLuqd2J2Ksl7Hx0SMUJ7yO+Uhoy9wTQ0An1CtOdxHMz
 Ygh1PriuF0fick2hGY+mg1vcPpgqmkHcHMafzOBT00dchOiPg6UoyRph2mTWivnewA
 4CG5qfjFVrpvg==
Date: Sun, 5 Dec 2021 21:18:27 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Message-ID: <1064509373.27600770.1638735507175.JavaMail.root@zimbra39-e7>
In-Reply-To: <1473700406.26541073.1638716639650.JavaMail.root@zimbra39-e7>
Subject: Looking for clarifications around gfx/kcq/kiq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Hello,

Context: trying to understand what happens with my Renoir passed through
to a Xen domu [0] (starting with the "VCN disabled" because I don't need it
now (so let's postpone the problem with its _fini) and with "PSP disabled"
because the alternative issue seems easier to solve -- so ip_block_mask=0xF7).

I'm slowed down by a number of additional terms:

* KIQ: we have the acronym, but a few more words about it would be great:
  it seems to relate to a ring buffer provided by the GFX IP, but this one
  does not talk much to me (e.g. it tells me less than the names of the
  "gfx" and "compute" ones)
* "me", "mec" = ?  In some places at least "me" stands for "micro engine" but
  what are those ?  A "mec" contains pipes which contain queues.  And in
  amdgpu_ring the "me" field seems to identify a "mec"
* "mes", rather looks like an IP/block family than the plural of "me".
  A specific list of those IPs / hw blocks would be useful (maybe with
  a diagram showing how they interact, much as what was started by
  Rodrigo for the DC pipeline, but a first components/subcomponents diagram
  would probably be helpful)
* RLC ?  Looks like a "micro engine" inside the GFX IPs ?
* one starting point for enhancing doc would be to start with amdgpu.h, where
  a number of acronyms used in structs are not self-explanatory: IB, SS, CP,
  ACP, CAC, HPD, ...

Do we have somewhere a description of what the hardware expects to find in
those queues ?

About amdgpu_gfx_enable_kcq():
- Isn't the `DRM_INFO("kiq ring mec %d pipe %d q %d\n"` line rather meant as
  DRM_DEBUG ?
- An error from amdgpu_ring_alloc() is reported as "failed to lock", but looks
  like "failed to allocate space on ring" ?

amdgpu_ring_alloc() itself is unconditionally setting count_dw, which looked
suspicious to me -- so I added the check shown below, and it does look like
ring_alloc() gets called again too soon.  Am I right in thinking this could be
the cause of amdgpu_ring_test_helper() failing in timeout ?

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -70,6 +70,9 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw)
        if (WARN_ON_ONCE(ndw > ring->max_dw))
                return -ENOMEM;
 
+       /* check we're not allocating too fast */
+       WARN_ON_ONCE(ring->count_dw);
+
        ring->count_dw = ndw;
        ring->wptr_old = ring->wptr;


About gfx_v9_0_sw_fini():
- the 2 calls to bo_free are called here without condition, whereas they are
  allocated from rlc_init, not directly from sw_init.  Is this asymmetry wanted ?


Maybe such info should join the documentation at some point?

[0] https://lists.freedesktop.org/archives/amd-gfx/2021-November/071855.html
