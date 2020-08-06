Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED44C433F1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B551722D06
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ0XPspg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B551722D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613636E161;
	Thu,  6 Aug 2020 07:08:13 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F096E161
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 07:08:12 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f12so7075997wru.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2020 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1Zl7T0esuBFnNTI4MSMIey5F9+ZI9M5OA2mjgbgFMDk=;
 b=kQ0XPspgISOnMqiQisCX3YW2XB6JCZNrvKevJFxHCTUwIWtQ3TB2w6dXeVv4MNaj04
 E19Eq3m/0aJivkUondO/qFwJ+pJWmtGxNyftTSxJau7kXdUPtATA9B4iffai4BQjGKQS
 rFVsIfyYiMggZj/O72iltcG5sJ1ova+Ot3oqInQgRxHyxrHiZR04WNBeTSbvUm8AOf9r
 9iS+WqZSVEUbj3TpAqoGK3Y5/AmVeuDj2L0566fXdGAZ8vaztP6UZSLD0NYsfBO/FOm8
 jXW8NIZnIdvfqXHPoLa614Hc1aeRqOLHMtEIZB81Z1b/ktkB2M8hAkijQaBX8ZazpgFi
 AFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1Zl7T0esuBFnNTI4MSMIey5F9+ZI9M5OA2mjgbgFMDk=;
 b=K/CypZYyZgW+2dii0KukcQFyfjex0pmMc7xkJYJ1GVZk7HrOuh2k4S6nskzVyYWVZu
 6c026AK5lcMd91jLegrg2tpOqBKOokv+KFO+yTNAEe7WMHXfvXgqGRKA7c1A/eXIk4Ti
 j89TFbGjrRCqywEFpyJ/EX8bIscyeVn/74gMz7K5rzDaC2DXqOxCKrPVwwOqOirnu8kA
 iL3dJhqegDXgcpS6FrrB4teq2WcFUMWd4n+4M0nWZHrZFFghAz7HiV1gIFMlOGTbGUey
 xfqTJDRn2PkxLx9CEVCH2sBOFPjUzbZjYg5heGkSyjBVpq9sPDR9VJF0vITPk7HgCWvd
 Pefg==
X-Gm-Message-State: AOAM531V646/iDNK8BGaS7iFHDTwiFdbsPwSdHxSzotpsVDAxHCPEw+O
 107KaS+fC36x0KPe05Mn60wSq1/P
X-Google-Smtp-Source: ABdhPJxXIy5aQbT6Gft1+QP85Aw/vHsXzQmc+kQCHhisTnjSclJ4a9HjUgWD5x2I/k6t9YsTALHcIg==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr6445365wrm.301.1596697691242; 
 Thu, 06 Aug 2020 00:08:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p22sm4960347wmc.38.2020.08.06.00.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 00:08:10 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: annotate a false positive recursive locking
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com
References: <20200806070230.21457-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <84678659-b4a6-8332-a71b-28d1b412ae16@gmail.com>
Date: Thu, 6 Aug 2020 09:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806070230.21457-1-Dennis.Li@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.08.20 um 09:02 schrieb Dennis Li:
> [  584.110304] ============================================
> [  584.110590] WARNING: possible recursive locking detected
> [  584.110876] 5.6.0-deli-v5.6-2848-g3f3109b0e75f #1 Tainted: G           OE
> [  584.111164] --------------------------------------------
> [  584.111456] kworker/38:1/553 is trying to acquire lock:
> [  584.111721] ffff9b15ff0a47a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.112112]
>                 but task is already holding lock:
> [  584.112673] ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.113068]
>                 other info that might help us debug this:
> [  584.113689]  Possible unsafe locking scenario:
>
> [  584.114350]        CPU0
> [  584.114685]        ----
> [  584.115014]   lock(&adev->reset_sem);
> [  584.115349]   lock(&adev->reset_sem);
> [  584.115678]
>                  *** DEADLOCK ***
>
> [  584.116624]  May be due to missing lock nesting notation
>
> [  584.117284] 4 locks held by kworker/38:1/553:
> [  584.117616]  #0: ffff9ad635c1d348 ((wq_completion)events){+.+.}, at: process_one_work+0x21f/0x630
> [  584.117967]  #1: ffffac708e1c3e58 ((work_completion)(&con->recovery_work)){+.+.}, at: process_one_work+0x21f/0x630
> [  584.118358]  #2: ffffffffc1c2a5d0 (&tmp->hive_lock){+.+.}, at: amdgpu_device_gpu_recover+0xae/0x1030 [amdgpu]
> [  584.118786]  #3: ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.119222]
>                 stack backtrace:
> [  584.119990] CPU: 38 PID: 553 Comm: kworker/38:1 Kdump: loaded Tainted: G           OE     5.6.0-deli-v5.6-2848-g3f3109b0e75f #1
> [  584.120782] Hardware name: Supermicro SYS-7049GP-TRT/X11DPG-QT, BIOS 3.1 05/23/2019
> [  584.121223] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
> [  584.121638] Call Trace:
> [  584.122050]  dump_stack+0x98/0xd5
> [  584.122499]  __lock_acquire+0x1139/0x16e0
> [  584.122931]  ? trace_hardirqs_on+0x3b/0xf0
> [  584.123358]  ? cancel_delayed_work+0xa6/0xc0
> [  584.123771]  lock_acquire+0xb8/0x1c0
> [  584.124197]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.124599]  down_write+0x49/0x120
> [  584.125032]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.125472]  amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.125910]  ? amdgpu_ras_error_query+0x1b8/0x2a0 [amdgpu]
> [  584.126367]  amdgpu_ras_do_recovery+0x159/0x190 [amdgpu]
> [  584.126789]  process_one_work+0x29e/0x630
> [  584.127208]  worker_thread+0x3c/0x3f0
> [  584.127621]  ? __kthread_parkme+0x61/0x90
> [  584.128014]  kthread+0x12f/0x150
> [  584.128402]  ? process_one_work+0x630/0x630
> [  584.128790]  ? kthread_park+0x90/0x90
> [  584.129174]  ret_from_fork+0x3a/0x50
>
> Each adev has owned lock_class_key to avoid false positive
> recursive locking.

NAK, that is not a false positive but a real problem.

The issue here is that we have multiple reset semaphores, one for each 
device in the hive. If those are not acquired in the correct order we 
deadlock.

The real solution would be to move the reset_sem into the hive structure 
and make sure that we lock it only once.

Christian.

>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
> Change-Id: I7571efeccbf15483982031d00504a353031a854a
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088d03b3..766dc8f8c8a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -967,6 +967,7 @@ struct amdgpu_device {
>   	atomic_t                        in_gpu_reset;
>   	enum pp_mp1_state               mp1_state;
>   	struct rw_semaphore	reset_sem;
> +	struct lock_class_key lock_key;
>   	struct amdgpu_doorbell_index doorbell_index;
>   
>   	struct mutex			notifier_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6c572db42d92..d78df9312d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3037,6 +3037,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->virt.vf_errors.lock);
>   	hash_init(adev->mn_hash);
>   	init_rwsem(&adev->reset_sem);
> +	lockdep_set_class(&adev->reset_sem, &adev->lock_key);
>   	atomic_set(&adev->in_gpu_reset, 0);
>   	mutex_init(&adev->psp.mutex);
>   	mutex_init(&adev->notifier_lock);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
