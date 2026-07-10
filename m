Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF737C44501
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C02010E4A3;
	Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNzhuNgU";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EEA10F90B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:57:23 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so1616809a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783691842; x=1784296642; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N6W8ml1kzqknA8AQTBICl7e9cO4Osw9IzAD7qCx3NhU=;
 b=NNzhuNgUD9rjFEljzAthC2HeHIMinlhhholuErKdQjNBwyLrZd/DzP9Rm5sVEA/7Mj
 69wHMJPDwB9O1OgLtjG/bfgPLDJ+DO0Sde1jkoXg8Ej8u6c8iLlqKbxosNyyu4l2hkjb
 Lrr9Qj+mI+WlgucMtZdd6d+ApsT9mg3wKGZ3xgRKAgrka+SyYchVwNFESdadaRsXexXk
 o0jzLrxULboW3/buf0z9hWRnRzB83HcXopgxAukGdJWHJedEj758qIhVxyKaqfCYI7Ju
 JorhQ68gxHKQNDtmEQXf7Q/ij+Ct0Rb5xMXk3OGrc0L/lATk1NznWTRIZ7D56K6WHwQz
 nQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691842; x=1784296642;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N6W8ml1kzqknA8AQTBICl7e9cO4Osw9IzAD7qCx3NhU=;
 b=P3q61VJ2rkjUDL9au4iRdjOfMzuGCx9PSsCEz+GdtD5Y8ozMA4v0O4JRauArpnhTKg
 MPl/kcsqgXLNST0igrwLdtlNz8CHafLlqDD2o5NMvbWCmpc4yGU0ZyMLUooXL+wnFUTG
 OjJ4iTqd57QB6PGIgYmmu67rBscowDTVFO8XRyeKEPTjmm8/NUn1058Cs130BGZQ3GJQ
 seaiWBIB8s5POmzVJQhY+YuOE/2v/rjP/z09gesinpz5L76wAfzknH/MgWOuhV/mRlAl
 ZIuyBresENoph8Xx3xIBxfCKVzcApJvam7c4F8zhRpVibIiIuhE0jmEbjLICwaeU/R57
 rDxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCHd4gaSeVm+BlnuN8krAufukvpDGZ9qUp5uORCWKE9wXe5fhalesIGGvJnhlkluHoQtFmu51E@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzEhSbrWm5ikOLKV96drbaPlrwdRn9BfjbFoarDXx6aripc3us
 ynP7c+JsaRRJYprWViBWkT8agGTCjqBYji1tIpMaYZcBO0fa851d/xuG
X-Gm-Gg: AfdE7ckMHXINa/t7pL1C9ihhcquvSWiyBawB2POl1vH4RiT7IQMm29G2cAytvFeg9hG
 Oz4huLkK5Bfw4E2VrxzIKo9n6Q3ph4aq7mIhpcIFYYL8pbQweuUj/5us5+53i6JST3r/MA2mKgZ
 nNPG1Cjpezd140UTlgexfsnn1nSPpXbE1NVYu8LCGIJEAP8op04ePkZxdvlispCogK8U0EY6SfJ
 Fqfl1ccycTZOkyCn70xGv/0JLUMUhsj2sNM+B2DcGb8q9KwFuHNuqhHTw71Coe0YpSfsjFPkh13
 3YinrRpBhjCZaNU6L8zrTxvbDgEVQErqKee+s3ZMlHSQECaAD/qgmCwFFF2Nek+h6hCO7JQC/z6
 3CIrNWV3XTIcehQwxwGEk6I9CgBekM6mPWv+5g/f8I3VKOl68gWL5Lnj8z61UPw8/TIYVDIqEUl
 u1/f5RFF9H
X-Received: by 2002:a05:6402:1468:b0:698:3e99:8146 with SMTP id
 4fb4d7f45d1cf-69ab44dbaffmr5176533a12.40.1783691841611; 
 Fri, 10 Jul 2026 06:57:21 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d78a08sm12162434a12.18.2026.07.10.06.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:57:20 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:57:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
Message-ID: <alD6PcLowqjVBnSl@stanley.mountain>
References: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
 <04d7a46f-3bba-412d-bfd4-89292d11e1db@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d7a46f-3bba-412d-bfd4-89292d11e1db@amd.com>
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

On Fri, Jul 10, 2026 at 09:47:32PM +0800, Zhu, Lingshan wrote:
> On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:
> 
> > debugfs is intended for debugging only, and failures to create debugfs
> > entries should not affect normal operation.
> >
> > Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
> > If debugfs entries cannot be created, continue without them instead of
> > reporting an unnecessary error.
> >
> > Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Cc: Zhu Lingshan <lingshan.zhu@amd.com>
> > Cc: Felix Kuehling <felix.kuehling@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> > index 02673f01b448..7c5bc9c4559a 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> > @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
> >  		entry->proc_dentry = debugfs_create_dir(name,
> >  							primary_entry->proc_dentry);
> >  	}
> > -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
> > -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
> > -		goto err_free_entry;
> > -	}
> 
> We need this check because debugfs_create_dir() may fail.
> Removing this check leads to entry leaking when fail.
> 

Debugfs functions aren't supposed to be checked.  Drivers aren't
supposed to rely on debugfs so it's not required.  If debugfs is
failing then you are pretty much screwed anyway.

I have a blog about the history of this:
https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

This code is inside #if defined(CONFIG_DEBUG_FS) so the check
isn't harmful except that it sets a bad example.  Back in the day,
this used to be a source of pain for me so Greg made it hard to
write a correct check unless you have the #ifdef.  It's to
discourage checking.

regards,
dan carpenter

