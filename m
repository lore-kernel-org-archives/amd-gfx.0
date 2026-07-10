Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CDDC44508
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73EB10E4A4;
	Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVnFU9G7";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033C10F90E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 14:12:33 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso961351f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783692752; x=1784297552; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xhl6wcIfeq3/MF7j47x/uRNfsJyo1U6JRMUP7xPRhDU=;
 b=lVnFU9G7/OOXvka44En+CtDpGbHnPZ4sxbbOuxLKwJm9qAAkq6zb7lDdBUrV0SGM54
 CSXMrWJv6+1Wmc8pMpn8kMljEqUBjM0e2Zix4aWBxotiBQNcoU403hpexLOgKqD6osjQ
 tbmH7TJltA0Yq1jdN9etgVPn3DhZLy/Gkp7W/98DEpsfOvTbeg68u5pxNQKWfbdRpWDF
 DpZjKRQZax7q7gWCrm8ctk9w6Am8qO2wfCwZwfS/P35H3MBAHQqD9vd5xG+STSITmvKh
 +PvIB+QOqhUP04Hb1PYXdAL0Pv4PQk7LcYjE04n1WMLG3NTi7hghvO/leyFdXsiU25Ox
 1rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692752; x=1784297552;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xhl6wcIfeq3/MF7j47x/uRNfsJyo1U6JRMUP7xPRhDU=;
 b=Kzer6geQFxLlZomuq6XyOnUaCFkEbqL9SfXMIrGIh+Xptkgzb4CswC+NWEQFS1m43i
 ieITrbngE8SyrS/9Empj+LwPh8wHsrmQWoQhBXupHkiRyjunLwsGEy8cCUHL/tEKgakH
 0Rv1NO7/FKP5l2AvJV1rSORs8kqITlGGiTC81SxXoA1n7/j+4RuDvtIqrg/6yFT/SoXn
 KCvmIWpjHov/oA6Rxta66a/4PN+D6sWkhG1xr1qbqWVXcY2DMhCaRmCRMFr9P32aEt4Q
 kpAXTmtAAUjmEvMRdwTNpZA/F/kEjO7GV11OOfkklMMphpBwiZnDzciVcX9eJQjfcqe1
 7Emw==
X-Forwarded-Encrypted: i=1;
 AHgh+RomKU2JwsajSwQxWLBNgO9brbUML8NK4UrBvi76N03vH8Zp3Z60QN1KchfqBO1TpGNSiRXeVIfe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqlxcZayE25GB4OA1H4WqqC1awBQW3gzh8eRxzplBofdBQhAg3
 8X1dpg3pS2+7ElBXGI5rpA4VJH8Vb4B73h6sSDWV7WzoQ3DDL4F+4Ba0
X-Gm-Gg: AfdE7cnKRZc/K7cWRmuRekEMYV3+qzW0g5vVXzbuja8GyK52VoSwau+d37Ooko0u9xu
 4a7IuHmOFZy19Cdqh7KqK0pgJwcHP4cSSsASu4dDZbGtstcyUsENxptH2SxqmU0CpgdE3szO+Ir
 Fjq0OW3iU5XEePDocrDDhU5DPzQY3mSWklkZfBLQyqjMKZnyADeJw2nwmGI3U+RhkxfM0gwEl/X
 nPTSgiMNnKNph8oJRxxSZBWxgC0b09KK9gWtU212aNUuI35PZA1A84GVSwZlYWZBY9VgkLBngRZ
 jnPBjxt0xDjenNJJ8X7xOncJaQR24YHRnPlOCHTl1YLWTV8zp6fDByiTSZvyPzBaCqU/XgDKrna
 iqu7OBbiL7V1/piAIbsfDVKdLzqLW5QQB4SpmfLhnXYxPMPLOC6UAO3QmwqrOHw74R9hUHDQzkG
 RdugpYRxXP4sdAWnNXm2k=
X-Received: by 2002:a5d:584e:0:b0:474:64bf:8fb6 with SMTP id
 ffacd0b85a97d-47df0762073mr13286605f8f.39.1783692751669; 
 Fri, 10 Jul 2026 07:12:31 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6da9sm59788170f8f.12.2026.07.10.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:30 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:12:27 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
Message-ID: <alD9y0YBjo5_pJnh@stanley.mountain>
References: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
 <04d7a46f-3bba-412d-bfd4-89292d11e1db@amd.com>
 <alD6PcLowqjVBnSl@stanley.mountain>
 <a44c0a8c-e3b1-4013-8a36-4fa3f44d023d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44c0a8c-e3b1-4013-8a36-4fa3f44d023d@amd.com>
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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

On Fri, Jul 10, 2026 at 10:08:11PM +0800, Zhu, Lingshan wrote:
> On 7/10/2026 9:57 PM, Dan Carpenter wrote:
> 
> > On Fri, Jul 10, 2026 at 09:47:32PM +0800, Zhu, Lingshan wrote:
> >> On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:
> >>
> >>> debugfs is intended for debugging only, and failures to create debugfs
> >>> entries should not affect normal operation.
> >>>
> >>> Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
> >>> If debugfs entries cannot be created, continue without them instead of
> >>> reporting an unnecessary error.
> >>>
> >>> Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
> >>> Reported-by: Dan Carpenter <error27@gmail.com>
> >>> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
> >>> Cc: Felix Kuehling <felix.kuehling@amd.com>
> >>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
> >>>  1 file changed, 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> >>> index 02673f01b448..7c5bc9c4559a 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> >>> @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
> >>>  		entry->proc_dentry = debugfs_create_dir(name,
> >>>  							primary_entry->proc_dentry);
> >>>  	}
> >>> -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
> >>> -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
> >>> -		goto err_free_entry;
> >>> -	}
> >> We need this check because debugfs_create_dir() may fail.
> >> Removing this check leads to entry leaking when fail.
> >>
> > Debugfs functions aren't supposed to be checked.  Drivers aren't
> > supposed to rely on debugfs so it's not required.  If debugfs is
> > failing then you are pretty much screwed anyway.
> >
> > I have a blog about the history of this:
> > https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/
> >
> > This code is inside #if defined(CONFIG_DEBUG_FS) so the check
> > isn't harmful except that it sets a bad example.  Back in the day,
> > this used to be a source of pain for me so Greg made it hard to
> > write a correct check unless you have the #ifdef.  It's to
> > discourage checking.
> 
> Thanks Dan for the background, then how do we prevent the entry leaking if we do not check debugfs_create_dir?

We just don't worry about it.  If that happens, you probably are going
to need to do a kernel upgrade or replace your ram or something.  A
small leak is the least of your worries.

This is the answer that Greg told me back in the day.

regards,
dan carpenter

