Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86EEC4346E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FF8216C4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQG+l6Ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FF8216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242BE891C0;
	Mon, 21 Sep 2020 19:24:33 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9533B891C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 19:24:31 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e11so631276wme.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=yvNOVtaN14VOzVfbmBlvKbX9aumJmwPSPtUs4fVu3MM=;
 b=oQG+l6EaxselLTsydIrdjbNqfcpx7deWalcqyh+r9xonZWMI18DaaQHSkejWabIh1Q
 3cnJFJh7kmE5qb0MCzfICKU3jYr5Cd+FsncEwhaASsG5ediNEpEAFDA1x/pGzpraJv18
 bTNtKD/nOvuRCMIzopbXlhQEgyzwEKYRQV6yF62OdtWi+RSsIC9Bj2tlYybRG6B9R1ry
 a0DUd+5EWNdVociS2FdS/4NaTaa/iiZitUq2f84p3tCIE7XBppTcLxvwqoH6mZLG2O30
 Au4cJ2lhUjX2NUjtnKCA9H1m+i08vvFIy4yS235YzwADI39StfYisDo8xs5dHQq45NhT
 lL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=yvNOVtaN14VOzVfbmBlvKbX9aumJmwPSPtUs4fVu3MM=;
 b=KYAm+ec8fiQ0rRlFRMe537ChHx7gcbMkZoGlOoYG3YtFUug+sZWbZJe9QZK8tXvY7z
 3H1vbieYTN3m88X6P/vfc++/hoVnNWYJoIcNsDZ6JeSy/EJC56AVoD6f8wIr5Q/8/8TF
 6iMvHc0fnbETKh9mN0kRIVG3LzrUIt0opglWLZpRN0ejQAoNCHH+joHT6Oyo1lYyJPpO
 dUIEw5KRNBb8Nud9ImYwoES2qX8BvpNbR/3mY42q+bkjEgCzUdBNIOaEJAW+d6wAZG1C
 vxm5p15yucWECNGVCFPCyLthNEI0rDijJ9sp6LOxi26p/l2w6cnuZVPjBewAbSIfyAyq
 G0vg==
X-Gm-Message-State: AOAM533OhjDbaPRzsaML8wZ3L4/Ayx4RhcC7H+vrWfboLeVx+sv8P53M
 9lXyg7ZAazyJyka1JVxAjvmFMpWLZ88=
X-Google-Smtp-Source: ABdhPJw3EEzqEIOeBXw6N1cGJ6zimQyol7WeqSr8DmJfawP12GhiujXoW2Evtodm+f+P46/BuKWWOQ==
X-Received: by 2002:a05:600c:4149:: with SMTP id
 h9mr857150wmm.86.1600716270143; 
 Mon, 21 Sep 2020 12:24:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i3sm22025553wrs.4.2020.09.21.12.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 12:24:29 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add uid info to process BO list
To: Madhav Chauhan <madhav.chauhan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200921191803.18549-1-madhav.chauhan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <be158145-41b9-c319-8e46-cda88d5cb9c2@gmail.com>
Date: Mon, 21 Sep 2020 21:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921191803.18549-1-madhav.chauhan@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, kishore.surampalli@amd.com, mihir.patel@amd.com,
 athar.saleem@amd.com, shashank.sharma@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.09.20 um 21:18 schrieb Madhav Chauhan:
> UID is helpful while doing analysis of BO allocated
> by a process.

Looks like a bit overkill to me, why not get the uid from the process info?

Christian.

>
> Signed-off-by: Madhav Chauhan <madhav.chauhan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f4c2e2e75b8f..c1982349ec7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -892,6 +892,7 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
>   	struct drm_info_node *node = (struct drm_info_node *)m->private;
>   	struct drm_device *dev = node->minor->dev;
>   	struct drm_file *file;
> +	kuid_t uid;
>   	int r;
>   
>   	r = mutex_lock_interruptible(&dev->filelist_mutex);
> @@ -909,7 +910,10 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
>   		 */
>   		rcu_read_lock();
>   		task = pid_task(file->pid, PIDTYPE_PID);
> -		seq_printf(m, "pid %8d command %s:\n", pid_nr(file->pid),
> +		uid = task ? __task_cred(task)->euid : GLOBAL_ROOT_UID;
> +		seq_printf(m, "pid %8d uid %5d command %s:\n",
> +			   pid_nr(file->pid),
> +			   from_kuid_munged(seq_user_ns(m), uid),
>   			   task ? task->comm : "<unknown>");
>   		rcu_read_unlock();
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
