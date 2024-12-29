Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29053E7718F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 14:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8A210E501;
	Mon, 30 Dec 2024 14:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Me7UDwpl";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFA310E0E4
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Dec 2024 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735477105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l14OkEJSbB2lQ6HRsz+CfVgzE+8xh7m2DNAoRxRsLF8=;
 b=Me7UDwpljSPxE5LV4IUVjdziXnGMR6A0PlIyK0gZHLsmtqiTdN7vts/8zv2C5mTSQUOfN9
 4g1uFAcFaByIVOc5kGYGBvbMf6UlYzFIe7s1CyhweWaTZsrLuHAmrUy0+gRJoHCvPtY35l
 1ONdC8xNmni8iSRQkY2S2rqMGmWAFYU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-MlQ0NX7lO4-T1Jv7OuZXYA-1; Sun, 29 Dec 2024 07:58:23 -0500
X-MC-Unique: MlQ0NX7lO4-T1Jv7OuZXYA-1
X-Mimecast-MFC-AGG-ID: MlQ0NX7lO4-T1Jv7OuZXYA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa683e90dd3so701750766b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Dec 2024 04:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735477102; x=1736081902;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l14OkEJSbB2lQ6HRsz+CfVgzE+8xh7m2DNAoRxRsLF8=;
 b=ig2KAwEdZVBnyrxNjeWTJ3jfE6f5pEKzlkOWssI99CpNm/QNVJ0dQ5G0CKsfO+Rbpp
 NlLpGipwzco9+0uWIrsR1vV8YXzeursDtRMRv8/Pp26Ni44lzK8ImR9A34NkxqW1yaVI
 VB/NUP2/q4IakUDAbU4MViJtXQ/fh8jswJotmxrNjey+oqP9vyh/AYiA8WARDW4hENSH
 4m7BCQegNE21uJMKZtA0rZNXvZNsiRRR235+6F9F6FLB76vHC1tnar4+ke4O+ElSZ05X
 tzgJEzQo44gb1+7EeTImwX+FceKKkWMLOhM+4zakZZOC8V4pg7Q7lNpEoDJVVZhgTXlW
 udgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX4E/p9Tkdj/37OFeUuKO1sLFmVLpihOqBAONzzK5PWPqEia8gNOFJ4fezZfRa8s7iLLnrYMWs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKtu1QlQK8LXhNKjC87bLgEYg3Csfbj7yYTWJkJUS7dZPYoGpT
 Nzld/km36X0sP6UMz4xfFimWNo2y8zzj06uzPdhLhixv12xlWD+JO3qbEvX/XJdfObkVlv/TJVr
 HPD+I5vIbBFBu5OcfwSMdl6UoVTUnlWZelDFZLzo4EhulMYyJLnLRKcjf2PSPIA==
X-Gm-Gg: ASbGncsiXH0JG8Lxdtgb5JGJqkdmaYC6Yv5yn0zpfMsQ4bCudzpsJwZmUp5SChA5Db+
 cj9/ei5nGbgI0mesVxJJJmXVJOuxlRlJZGbkW7lsULmS5vX96pLueBp2Zd4ykDAHFBkalRBut/m
 xGBAnLepZOQjAAI5w1y6q6vd8TDyGqK2PTm7Jij3BcM8a07mjUSmUOhJooUQWiis3dtFnf6Z7Gi
 pn1CAvBW65RppjR1LENg85klL6Zc0gWSX/dFcfpjSaAPzidyaosPA6Ksz8Q6fBD7O9eozRDXc7Q
X-Received: by 2002:a17:907:2d8b:b0:aa6:6e41:ea53 with SMTP id
 a640c23a62f3a-aac271316a3mr3275091866b.7.1735477101881; 
 Sun, 29 Dec 2024 04:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5WcMKb9KoHZScLGl440Om+DdLYKGQDDOkHuv9hHp+lBTr72kpE0uwz6aQinwzNqD+D8dqMg==
X-Received: by 2002:a17:907:2d8b:b0:aa6:6e41:ea53 with SMTP id
 a640c23a62f3a-aac271316a3mr3275089966b.7.1735477101454; 
 Sun, 29 Dec 2024 04:58:21 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe415dsm1365204966b.123.2024.12.29.04.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2024 04:58:20 -0800 (PST)
Date: Sun, 29 Dec 2024 13:58:19 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Carlos Maiolino <cem@kernel.org>, Chandan Babu R <chandanbabu@kernel.org>, 
 Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] xfs/libxfs: replace kmalloc() and memcpy() with
 kmemdup()
Message-ID: <cdnpycsyf37gbcp6yxx36pxgilothhdpajmtwle5pphjxshn6o@j5enpjtww3xx>
References: <20241217225811.2437150-2-mtodorovac69@gmail.com>
 <20241217225811.2437150-4-mtodorovac69@gmail.com>
 <20241219003521.GD6174@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20241219003521.GD6174@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zJQwNN45acsFDuhojJJpeD09IM2nX1VA0BAfkKuTCYE_1735477102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Dec 2024 14:51:53 +0000
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

On 2024-12-18 16:35:21, Darrick J. Wong wrote:
> On Tue, Dec 17, 2024 at 11:58:12PM +0100, Mirsad Todorovac wrote:
> > The source static analysis tool gave the following advice:
> > 
> > ./fs/xfs/libxfs/xfs_dir2.c:382:15-22: WARNING opportunity for kmemdup
> > 
> >  → 382         args->value = kmalloc(len,
> >    383                          GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_RETRY_MAYFAIL);
> >    384         if (!args->value)
> >    385                 return -ENOMEM;
> >    386
> >  → 387         memcpy(args->value, name, len);
> >    388         args->valuelen = len;
> >    389         return -EEXIST;
> > 
> > Replacing kmalloc() + memcpy() with kmemdump() doesn't change semantics.
> > Original code works without fault, so this is not a bug fix but proposed improvement.
> 
> I guess this is all right, but seeing as this code is shared with
> userspace ("libxfs"), making this change will just add to the wrappers
> that we have to have:
> 
> void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
> {
> 	void *p;
> 
> 	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
> 	if (p)
> 		memcpy(p, src, len);
> 	return p;
> }
> 
> Is this sufficiently better?  That's a question for the kernel
> maintainer (cem) and the userspace maintainer (andrey, now cc'd).
> 
> --D

There's still possibility to set wrong length in args->valuelen,
which I suppose what this change tries to prevent.

But otherwise wrapper looks good to me

> 
> > Link: https://lwn.net/Articles/198928/
> > Fixes: 94a69db2367ef ("xfs: use __GFP_NOLOCKDEP instead of GFP_NOFS")
> > Fixes: 384f3ced07efd ("[XFS] Return case-insensitive match for dentry cache")
> > Fixes: 2451337dd0439 ("xfs: global error sign conversion")
> > Cc: Carlos Maiolino <cem@kernel.org>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Chandan Babu R <chandanbabu@kernel.org>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: linux-xfs@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> > ---
> >  v1:
> > 	initial version.
> > 
> >  fs/xfs/libxfs/xfs_dir2.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_dir2.c b/fs/xfs/libxfs/xfs_dir2.c
> > index 202468223bf9..24251e42bdeb 100644
> > --- a/fs/xfs/libxfs/xfs_dir2.c
> > +++ b/fs/xfs/libxfs/xfs_dir2.c
> > @@ -379,12 +379,11 @@ xfs_dir_cilookup_result(
> >  					!(args->op_flags & XFS_DA_OP_CILOOKUP))
> >  		return -EEXIST;
> >  
> > -	args->value = kmalloc(len,
> > +	args->value = kmemdup(name, len,
> >  			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_RETRY_MAYFAIL);
> >  	if (!args->value)
> >  		return -ENOMEM;
> >  
> > -	memcpy(args->value, name, len);
> >  	args->valuelen = len;
> >  	return -EEXIST;
> >  }
> > -- 
> > 2.43.0
> > 
> > 
> 

-- 
- Andrey

