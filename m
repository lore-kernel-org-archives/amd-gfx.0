Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3496AC2BA1A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 23:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED52220768
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 23:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlLvIB3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D146E4EC;
	Mon,  6 Apr 2020 23:08:10 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D10D6E448
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 21:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586209782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5SWgl8zk71PwxPlmcjKsJSCMep7OVdR5coFmBqc/+Y=;
 b=IlLvIB3MZGs0UPzkNLhEUr0Iwu6xUMr6SOsxA+Timk9m3pfzuch3wYqMML/X3JAN0nSODl
 sBtaoYR8Lf+e3LAcmOfXWxPqdZAuJT4HkTW/+b90YGNxcnQ1VOr5RJANMXyKJuWpTID8BG
 cDcREKMqUgv5EyNotH/eaUfqdziF5uQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235--lEzRBGfO0O-m3CwB9GEiA-1; Mon, 06 Apr 2020 17:49:40 -0400
X-MC-Unique: -lEzRBGfO0O-m3CwB9GEiA-1
Received: by mail-wr1-f69.google.com with SMTP id o10so599250wrj.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 14:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kIXDxUjS2HMskB+mPSwuv3yFtOM4CbvksE2h37nZI78=;
 b=TDb0GcrnEnhhMDVvTSrVnC4YwvaPXgqfud7FM9aO/2tJxmjqWKMF/A/AtxdiD0XxZx
 i3jdxqkYeMIItmCXlPHYrFGNdA6VUIZsui66j41zK4wKeJ814i8Wb6XlrDQRivKmHIez
 59n8b8Lsz5i/4svtnfsaL9qRsaGdTbXaxRpyZi7s1MvxrpWUoVMd4F3vT0+YKYPa5vnS
 4D54as3JmpNmVHTBJTrmWuqDorxIJJpHdfmJ95KJ8j/F4Tg2cDQOeQ/Ka8jGXokxfzM0
 G6MeQEgTafMl71wMVVBVPUpEqj/uaFnvSfCTgK6OCC8qVfRvKXH0HG8huj1ERfqpcz6y
 z5MQ==
X-Gm-Message-State: AGi0PuZMbN3uAzYteIbNiXUNJXS8CLBLRZOdYoeI2b5in4aYNkYyIOWn
 7KQZDs2KVEYohYKfcLoEAddo4axnw4minmomqll9AMc5sBFk8Pk6+jJecNyG3GuNUmzxMZfBKI2
 cxXkOKQopC60AeUuaivxwWOad2A==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr1340792wra.15.1586209779344; 
 Mon, 06 Apr 2020 14:49:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNgJ7eiNVOi5WqhYdhc42FjdejCWO6/Y8fkLNs2CGrGBsCWnbC9H2zd2UGSvXrNhDXRVbxFQ==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr1340765wra.15.1586209779132; 
 Mon, 06 Apr 2020 14:49:39 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id n6sm1057944wmc.28.2020.04.06.14.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 14:49:38 -0700 (PDT)
Date: Mon, 6 Apr 2020 17:49:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] kernel: set USER_DS in kthread_use_mm
Message-ID: <20200406174917-mutt-send-email-mst@kernel.org>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-7-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200404094101.672954-7-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 Apr 2020 23:08:09 +0000
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
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 intel-gvt-dev@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-usb@vger.kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jason Wang <jasowang@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Apr 04, 2020 at 11:41:01AM +0200, Christoph Hellwig wrote:
> Some architectures like arm64 and s390 require USER_DS to be set for
> kernel threads to access user address space, which is the whole purpose
> of kthread_use_mm, but other like x86 don't.  That has lead to a huge
> mess where some callers are fixed up once they are tested on said
> architectures, while others linger around and yet other like io_uring
> try to do "clever" optimizations for what usually is just a trivial
> asignment to a member in the thread_struct for most architectures.
> 
> Make kthread_use_mm set USER_DS, and kthread_unuse_mm restore to the
> previous value instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'm ok with vhost bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ----
>  drivers/vhost/vhost.c              | 3 ---
>  fs/io-wq.c                         | 8 ++------
>  fs/io_uring.c                      | 4 ----
>  kernel/kthread.c                   | 6 ++++++
>  5 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index d9e48bd7c692..a1198f4c527c 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -824,13 +824,9 @@ static void ffs_user_copy_worker(struct work_struct *work)
>  	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
>  
>  	if (io_data->read && ret > 0) {
> -		mm_segment_t oldfs = get_fs();
> -
> -		set_fs(USER_DS);
>  		kthread_use_mm(io_data->mm);
>  		ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
>  		kthread_unuse_mm(io_data->mm);
> -		set_fs(oldfs);
>  	}
>  
>  	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1787d426a956..b5229ae01d3b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -333,9 +333,7 @@ static int vhost_worker(void *data)
>  	struct vhost_dev *dev = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
> -	mm_segment_t oldfs = get_fs();
>  
> -	set_fs(USER_DS);
>  	kthread_use_mm(dev->mm);
>  
>  	for (;;) {
> @@ -365,7 +363,6 @@ static int vhost_worker(void *data)
>  		}
>  	}
>  	kthread_unuse_mm(dev->mm);
> -	set_fs(oldfs);
>  	return 0;
>  }
>  
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 83c2868eff2a..75cc2f31816d 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -168,7 +168,6 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
>  			dropped_lock = true;
>  		}
>  		__set_current_state(TASK_RUNNING);
> -		set_fs(KERNEL_DS);
>  		kthread_unuse_mm(worker->mm);
>  		mmput(worker->mm);
>  		worker->mm = NULL;
> @@ -420,14 +419,11 @@ static void io_wq_switch_mm(struct io_worker *worker, struct io_wq_work *work)
>  		mmput(worker->mm);
>  		worker->mm = NULL;
>  	}
> -	if (!work->mm) {
> -		set_fs(KERNEL_DS);
> +	if (!work->mm)
>  		return;
> -	}
> +
>  	if (mmget_not_zero(work->mm)) {
>  		kthread_use_mm(work->mm);
> -		if (!worker->mm)
> -			set_fs(USER_DS);
>  		worker->mm = work->mm;
>  		/* hang on to this mm */
>  		work->mm = NULL;
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 367406381044..c332a34e8b34 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -5871,15 +5871,12 @@ static int io_sq_thread(void *data)
>  	struct io_ring_ctx *ctx = data;
>  	struct mm_struct *cur_mm = NULL;
>  	const struct cred *old_cred;
> -	mm_segment_t old_fs;
>  	DEFINE_WAIT(wait);
>  	unsigned long timeout;
>  	int ret = 0;
>  
>  	complete(&ctx->completions[1]);
>  
> -	old_fs = get_fs();
> -	set_fs(USER_DS);
>  	old_cred = override_creds(ctx->creds);
>  
>  	timeout = jiffies + ctx->sq_thread_idle;
> @@ -5985,7 +5982,6 @@ static int io_sq_thread(void *data)
>  	if (current->task_works)
>  		task_work_run();
>  
> -	set_fs(old_fs);
>  	if (cur_mm) {
>  		kthread_unuse_mm(cur_mm);
>  		mmput(cur_mm);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 316db17f6b4f..9e27d01b6d78 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -52,6 +52,7 @@ struct kthread {
>  	unsigned long flags;
>  	unsigned int cpu;
>  	void *data;
> +	mm_segment_t oldfs;
>  	struct completion parked;
>  	struct completion exited;
>  #ifdef CONFIG_BLK_CGROUP
> @@ -1235,6 +1236,9 @@ void kthread_use_mm(struct mm_struct *mm)
>  
>  	if (active_mm != mm)
>  		mmdrop(active_mm);
> +
> +	to_kthread(tsk)->oldfs = get_fs();
> +	set_fs(USER_DS);
>  }
>  EXPORT_SYMBOL_GPL(kthread_use_mm);
>  
> @@ -1249,6 +1253,8 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
>  	WARN_ON_ONCE(!tsk->mm);
>  
> +	set_fs(to_kthread(tsk)->oldfs);
> +
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
>  	tsk->mm = NULL;
> -- 
> 2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
