Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B71606A334
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWuJtjM2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB7810F126;
	Tue, 10 Nov 2026 11:44:03 +0000 (UTC)
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDE710F446
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 17:01:42 +0000 (UTC)
Received: by mail-pj2-f2.google.com with SMTP id
 98e67ed59e1d1-3b1478f06e3so282140a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794243702; x=1794848502; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b/pzLwZr61TwH4Z8hnWdS9fb2v4tophLaBPLYRGm3iE=;
 b=yWuJtjM200e+eCQ/oe0UEQjI3M+nPrh0aRiaS9cnLf/l/nMdA1A5C2qswFczRMEUqy
 bwKn2RY7B6sjlpduCY/pgpoNZRC0eh7JIddYLO4HZjUY2PMXIc4+MeQSbPur+ubzdCuR
 NCsLPp3HfnNH0J0t9FGcAtrh88gEFt/Gn5C9FeYpeeNsNXGL/rAbt5sEzi6LZ783RKwS
 6ohlEe4dDWmNZQJJsxrkSgan7blsiKqUCVxml6HxOxBX9nMaP0iqmUoupS27epKZTDNQ
 RZrq4bXbPXxxzcsF2VShP4sFlu4SL5ATYem+GvK7dSdvhVUYu6SCfpbpr8Q/vNePm1cB
 4ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243702; x=1794848502;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b/pzLwZr61TwH4Z8hnWdS9fb2v4tophLaBPLYRGm3iE=;
 b=AcYauMRF/NDR34KqLbGAc6053f/1yYr7bLk1W8fkKK6or4hFs5eiNVCR37x/IIowMO
 HiNefiFnv7w0Ss5FmgpnTZ9rmHef3J8xKvIPKQMl/5DcxBNdXpvekzhm/qw8pmEhhMqC
 iviZXE8vY9yHFXT8wZD+ZM6VSGkHhQEUGaCdTgc9lPvvNOJy7dKg9AXjdidvywLC0EGt
 D5tRMH0pYjhPCMycDpOokQsLX+vuTeHvnMIMiK00XjvEnTitglGDOaON1wGKnx3tgoEt
 sT9k1jnANz3RGZeOH2YtE56Cr7bmfjBndlK3t+qG8z3Nrp6pJO9nRMTfkme8txkJwN+n
 jmyg==
X-Forwarded-Encrypted: i=1;
 AL+hErFcg0e+uTAnWz3UFEJhYBeoUT2A8JTs5vsDicV6dpWquRp3NcjCHeExctdOyVFC5jLzPFNFE65R@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YJu9g5DpVddi9BVWkDtTUwCnwfBxkV01jNTCpHAgkfPVbdNGW
 JMWqV0+7w3+Dl8ci26/hUAdNwWeBZIgJHU9kPFnKt0AHA9JZyDop9PR+
X-Gm-Gg: AYBFou0B3Q82olRJHxopMYqIX7d/l+gHJRppDZs/u/XSMskcY1YDbffTmWIeJioQqEb
 LRCn7zdgrVCWEhe9QIk9DCihM6yNkJfTL4qxcbN0A4EetfwJP/HzpuMhqK80raXDiBtxYsHOfBx
 g2ZyWqCpq2ci705QIKsb0WC9eHwAwtWq5zCLezcK8TFw6GpjW0FYtV2YsPtHb1sr3AnSURQ7FXN
 8+k9HBnkrYWBLN5bK7um+v1KYV4M+nq8RSlaibCC12B0aqf1d5Nm3sdMF35RaHYJ+d3BXoTWOKt
 VBm1e1hRG2t+9n/3uaVpQquGW0LoV8azWZ4ClrTb2/v16egmSE2oli7oFZStxx4wSnAN5uQd788
 nZaedC6ir+DmrhS9gh5wYiIVigi5AcD9SQADA0dCHW/USqYQoZvClDgB+5OD3KbmoWAdBeXt+Gd
 SeXKBIkdUOzW9N5DR4uSkNCfkyLGB4bq9ci0D/2814ssjFM3DIEWVqPQKGphfJFGetKPilHqLGR
 y+lqQiklr7Cpme8VmxhVz6Q8EaNTOXbz6wvOo9u2wfEd875fsrAt+smXr/x6RoM7wXN6l7AkL9P
 eHTKRjmFr69wPIMD/lpxrGO0+ohmuYPQgm1yCxT2t03OFO6wEMtxenYLqZXDt7zytrRR6SwtM3A
 Ftd43Bz3ih6BknujFVnWdQuN51SJzdKVS
X-Received: by 2002:a17:90b:2cc6:b0:39e:6795:f7da with SMTP id
 98e67ed59e1d1-3b166c89a19mr230128a91.19.1794243702117; 
 Mon, 09 Nov 2026 09:01:42 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16708f963sm211545a91.1.2026.11.09.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:01:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 11/22] drm/amdgpu: add SVM ioctl entry and fault
 handler module
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 03:47:18 +1100
Message-Id: <179424283809.193292.9522281129166256376.b4-reply@b4>
To: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Honglei Huang <honghuan@amd.com>, 
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, 
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
In-Reply-To: <20261021025915.2433837-12-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-12-ray.huang@amd.com>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Tue, 10 Nov 2026 11:44:03 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ray,

On Wed, 21 Oct 2026 10:58:50 +0800 Huang Rui wrote:

> +	ret = fault_check_allowed(svm, fault_addr, write_fault);
> +	if (ret)
> +		return ret;

This checks the VMA permissions but not attrs->access, so I think
INACCESSIBLE isn't really enforced. SET_ATTR invalidates the existing
GPU mapping, but the next retry fault just maps the range again.

IN_PLACE has a similar problem. With preferred_loc=LOCAL, the
migration added by 22/22 can still move migratable system-memory pages
into VRAM on a pagemap-capable GPU. Both seem to go against the access
definitions in 01/22, and the prefetch path doesn't check access
either.

Could the fault and prefetch paths check access before mapping or
migrating?

Thanks,
Aveline Noir
