Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A2606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qH7lI216
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D23A10F17C;
	Tue, 20 Oct 2026 11:28:57 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E60110F468
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 11:28:50 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2409856f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792495729; x=1793100529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w3kFDA56iQLj2j/WCvnGbNZD3Wrho8r/a+e31nFm0PA=;
 b=qH7lI216rX1d0niuxEdlWYxeFQ4k9DRYo7butytdVP+8S2AFuU5gTWxWqUqRi+t4yE
 GbV3TQSoVKd/NbiMifrI7l6wcwqZVg4gHafcMShcMqjg2FPcCZhKzt8bg5R/qlk3zZ4i
 VVCa/W1P/3X8JQAL8u+2+4O5fOa2Np1U9VyJd6Gds81a+qqHwGzntLnJBK1AIEwto+n1
 cOIGi09356AwARRYg2AhDsNud60WVBBEjYbz1qXmt32RdiDN7Dx/Cz2fo9yklEjC1U1v
 PvFa7DIpRxTPOQXSU9l3k5jiR9Fqh1MtvOHXLRL7wTjudZl/2ja8c3Rik2BoBX/g+ObR
 I4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792495729; x=1793100529;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w3kFDA56iQLj2j/WCvnGbNZD3Wrho8r/a+e31nFm0PA=;
 b=cK2y31p8cv6rIu4IrUjjzx76C+xj5UjIGfssLsHqsMPwGb8LftnBONldgB5TeBOPS/
 d+3gMzidIBqFRjGF7UoSHzCq22pv/DffUbgAXdmP0gggQWWyRckP8XdtsBqrxGNY1QFO
 eYMjHrt0hIiE/imVwcllceN3yLQgT98hAKbZqXZM7c8X8jvwroy6Dsu1Ej8r8WonMe1G
 vr66shwrziay3eTYKTi4dIuA320iRHZhsuuCRtp0rCP950V0yaCmnC/LbqLveCtgCe02
 HwtaGCAAJsUStoP5Y57t9OBeLsz1s0s6Sui4uo0qXHp+NK1scWjOypgtdhDeW3WifqGr
 L8Kg==
X-Gm-Message-State: AFq9FYKV7XljdsaDDjYCEKdt3kRaQvPGA97FXJZLUbBnEh1/slM626je
 k6iaICYvTi+5FM4P6E5We6a0MAfGhjhN6ahE8BuQNaFAKSpQjJGyI+ZD5imVFA==
X-Gm-Gg: AYBFou2yhxrgh2yPwI5CuInln7mMzslyEbpBCeHlm3MlLHYvxaDgGuOhYkW3E/ZpzSF
 81tyYjfZ6DWuZa6k+Gcrm0FsNdE6Tw15NvBfQ759GvyMJLcEusjLOjkpLwKEjuD8w57xKNaDkAI
 f1dHAEs7AohF0la5loh/X8d3jLhZglg3AlfuV2IBdOnftLkojHvM8CAWLWegwBQdxaq0cRGcCWw
 kQIdsMmIgI6qR+Y3CgessuD2tOd3+WsEdqL4S1iWf06kfBtQa1RSBCqcgGPXV5nM9VMF+Oy6U3b
 4eLxPp5S+K/e0BQQmBgEpDl1T/NcfXiVPYwA1URGcbGD7GiWK8ezNfmWnoKsssMBN/3B64unIbl
 6GPVvdWp1t1wJXJY17NHdo5wIq4599TL0gxpxyJtusZeYHGe0b0hdhPHOkMdHKow+WFjHjiyGJK
 xcAauPG21yMBXpVHC484txw+XCBKb6k3ymh+Xslxs6c0j1xEgB4wdY8IJkbkOsLmPEpa+/yR82T
 t+4YgZKSXKdQg//iPn3E9tkBh1KQifsxrxAEYuIhxft9ygLOpVOrN7D/765t5QYFTQDW4Mpl4+r
 RoQka35rWa0zvI2TeXMOgv70NLAhUzhbO6PaSjCbsd68Qwg4t4oXEYfy6FnPNhmHQ4hqmNgCcy8
 3/AhYsDXkVKBV280gsHNyP7pNLEjYMDxnVIrEG2LUeuTsIFLzL+rhdWwVAj/o0ZhU+cGiSwEVIU
 nGWzcS8Go2lKH0FMR0
X-Received: by 2002:a05:6000:5ca:b0:48d:ff06:c626 with SMTP id
 ffacd0b85a97d-48e07f9eacbmr20935275f8f.35.1792495728593; 
 Tue, 20 Oct 2026 04:28:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413d:d75e:785b:a7e0:9200:4038])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208b1sm5821007f8f.33.2026.10.20.04.28.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 04:28:48 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com,
	christian.koenig@amd.com
Subject: Re: [PATCH v6 0/3] drm/amdkfd: fix wedged teardown on surprise removal
Date: Tue, 20 Oct 2026 13:28:46 +0200
Message-ID: <20261020112846.89321-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0737e039-b4f6-4675-b50e-bd2937375e5a@amd.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Felix,

> Patches 1 and 2 are
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Thank you — yes please, go ahead and take them independently.
They're the uncontroversial half of the fix and they unblock the
drain path even without p3.

> For patch 3 I defer to Christian's expertise. That said, if we don't
> need the dma_fence_wait_timeout there, then we also don't need to
> complicate the error handling/unwinding in the migration functions.

On the timeout we agree — it's gone; the wait is unbounded again.
But I'd argue for keeping the error propagation and migrate->dst
rollback anyway: with the orphaning fixed, a fence on a killed
sched entity completes with an error status (-ESRCH) instead of
never signaling — so the error path is now genuinely reachable,
and your original concern still applies: a failed copy must not
complete as a successful migration.

The reworked p3 is: unbounded dma_fence_wait(), return
dma_fence_error() of the job fence, both callers release dst
pages and propagate, drm_dev_enter()/exit() still guarding the
submit window. I'll post it as v7 3/3 once the entity-lifetime
question Christian raised is settled — separate reply on that
thread.

Regards,
  Olivier
