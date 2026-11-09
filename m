Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E960A2608
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDHAWkDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F9710F252;
	Tue, 10 Nov 2026 11:44:10 +0000 (UTC)
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923AC10F437
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 17:00:14 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2ed3c66713cso3540035ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794243614; x=1794848414; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wxnu2gHDTAVcZYWFHFKD1h1xosiRimMJGhZuilr5Ql8=;
 b=zDHAWkDai/BmFVDxwfGJi1H+jG1q/TRMbLjglyFEzjj7viDclNOPSnBB4Yxfx1vZ2r
 rAv8oSeIgPaheFHhSnCbBIoUW6FGtNht5tbY/QFaxexuuFabd7yezvdfKmWhBaEDb/uu
 hdmaa28liT4oY2dl38UjW1l2hCTY1yeronFVs2z6rqQwoIfbQRZYAIm7wlYG8NCKRgNR
 h+Aso1c3AweXMZoob8kHLPnWJRcy/WhBWhTuR0ALFAFP1euaJys6j+kYkWgqPIvtC0dj
 RNEi56tRoztdLwTHBQihngUiiGHukNz3edK5EVAUtm8Yb9Y9RM1V/bFcNKfjDM4DeaRI
 Akfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243614; x=1794848414;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wxnu2gHDTAVcZYWFHFKD1h1xosiRimMJGhZuilr5Ql8=;
 b=Uza8guKRWu+bwVECHo2vvRKPvJtVfmHIT1/d3mrS5BXsV2e63txYeuQrrQWdsjbKeQ
 t6+sd9DGb3jPsh7n3V0bH3qfXm3nrSHYXcU32NdzY2CyIl6WzGtIkV56v2FyZZUeeqP3
 +S3UZz8gDWwEXDGu9BPIdmvzOufASXKbH3D+fv1FQeh4M4+Rzhsm4fD1jGfQNhqP2s9a
 N5qO/fChKm0eSdR2mlmqfljhKwSHaFARhdA+NChyYnZKYW0TNvrF6MGHWrvzcvh0y0on
 9XKn0h0TZYpE2IVmjnJ9/BI5vYduioaariyDtOR1qbikQhGRt4jx6Dw7xu+fMCwVQwJy
 Eleg==
X-Forwarded-Encrypted: i=1;
 AL+hErFBKRjdIhOrLKivVX/x/Cd2gwvQlvRndJdPlto5y28WyLwyhhn2lSQ0qVErOEFpGenaI+kOLosZ@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+GN8sRR/H/By5aYsLGSv/5DXTle0gYcc2u6clu1PuU8utMn+5q
 YBVUhWyMqCM8Ka2N0ixRrwtL7xXzz/JwgjIBrpHmEwC5Uv3Is3PefxaB
X-Gm-Gg: AYBFou1r5SZ/zC5dIru7x3vLD+cWbnbgwQ2A1aeNd1kCI9mb07X7KZ4iYeJmm5g3Rhm
 pvAMYB3kEJx51H+vVp1oUBUhE6KMyLUbF6o6yfJIJMR6CUlDxOSIkufTSHnNMPHm9fsUtuqgSXT
 O9N39slHTJI3K3ahfpL6cGdWQOmXbcI19z5HyJCpjf23wX982eHLY66nGgfjwTQXImtdXrzi8ES
 T85XOtDZAMJdEwl/R2ujXTQFMUk1WGzdhpbYl31uoRCPi0uxOEp/lsXa+pe04WsyCY32hXa8OK5
 wwklUQMq0PXSEJSgGE0UsjxVYqE6r657Yf1RIYwEreEUnyzv4WBuo2F8EdChwvHcZuK5S+kTMys
 ObYQSMGLd020CJ4XUDGwd8XrIRmFz5YQe9tqmlq6Wmsvyp2+0tUnd/Fd2AnVfwGHwk218DoqCFs
 VebCCLYUohqYCB/c4ZKKwAKWVSz+fNSy4sBx6b8QmTBGZxH8OhQRmS/SC6zV6uOm8Y0x2qssGtu
 JyQAhRDzNW7KN4wKd0/KxuBp6gZOT5w9Dv/JTIby35ZKLetIqkRXmultZyuRg30f4ufTKxe4Yqz
 1sFEQpyAu+kwF9zD6yKMl4u/HiPwwVUcHcodm5lSawr0xhmu4h/QP/PqgPZyGiAv5eAESaZsUaX
 wtaauVbXAkext/zHgHdibVYrdEWfZuVzf
X-Received: by 2002:a17:902:e5cf:b0:2ed:3db6:2eb0 with SMTP id
 d9443c01a7336-2ed83784f45mr49805195ad.48.1794243613903; 
 Mon, 09 Nov 2026 09:00:13 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d7bb58sm325405ad.33.2026.11.09.08.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:00:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 10/22] drm/amdgpu: implement SVM initialization and
 lifecycle
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 03:59:27 +1100
Message-Id: <179424356769.208802.11801490347938606155.b4-reply@b4>
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
In-Reply-To: <20261021025915.2433837-11-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-11-ray.huang@amd.com>
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

On Wed, 21 Oct 2026 10:58:49 +0800 Huang Rui wrote:

> +	if (new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
> +	    new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
> +		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PREFETCH;

I'm not sure about excluding SYSMEM here... The proposed libhsakmt
adaptation maps a CPU prefetch target to SYSMEM. If the pages are in
VRAM and the update fully covers an existing mapped SVM range, nothing
gets mapped or migrated eagerly. The GPU PTEs can be zapped, but the
pages stay in VRAM even though SET_ATTR can return success.

Is SYSMEM prefetch meant to move pages back to RAM, or only to set the
attribute for a later CPU fault?

Thanks,
Aveline Noir
