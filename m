Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D58C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D626F6101C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D626F6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0F089939;
	Wed, 25 Aug 2021 12:51:39 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522CB89939
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 12:51:37 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 a20-20020a0568300b9400b0051b8ca82dfcso33799621otv.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Km6z96HKcihhVRwjBvPg+npjimGsn5+b1uaLo4P++ws=;
 b=G5+gmdEHPohEguLKd2mCQ0oEzDQYbcJ+4uWCIXZ2tpTpAKVQiGDWkYrxvxe120JssU
 f7KykahmXBpLClaD30E0FVm+AxIEPViaNAMCtb/rB7N7ONr7fUOXarzQlXnDydE+DMDw
 MSL1YmuJfWjm0Qtxm8rj2YFGGH9ZjbbGgzXyRISu1ufhVCxc0ShSmkpRwLexynPuHCgO
 v2MTw+b6U1kPjm7gq+rJk8taZAMJOreexsUvtyNCBu7cNMa5FrEC9HKXkNSNaHErV1sp
 /97t/899aoP2vfVw3V+WpQwpzkvZw6YIgCynoJSKETTMSJjfZvgHxcpCcPeDi8pqdujM
 f84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Km6z96HKcihhVRwjBvPg+npjimGsn5+b1uaLo4P++ws=;
 b=oo5K6AidPRwRLK6q0o42m/g55lR1UKhcgAtA3YL/YWncLWS6Vlh9FSp6pC8WtM69yU
 ERx28UM4BffdhG3JVmOhwZg8DhFRJqGcCFV3+iLPFXlbBRkh7dnAAjThsAD5rRi87910
 cXxswq5HMuWQbBL+itqiKJ5gHjNhUphdLwOfNxLyunkPDFlojK5xqW2IGEIQwO+lTlM5
 gHSSwC5AR7mHyGVKN4dIsgdzSm3hNdSv7xvpbgckxcQIPmZlrfDQkPsr8nKbXjUT3X9w
 iGotmWeQwcvf3KmZC41VkpiRDgEhkmWTQ8EDXFCw0ash8iDy9714rtIUuhebGgsZ24Nb
 PYgA==
X-Gm-Message-State: AOAM532oyDor3swuzp7WYq+K4SrUasPrsbbcLhnwF4O+UoRRRjwmK6tc
 BGhiYLzr1BZbfN/rqGVMKbmzlCLWLQ9Cz7rexNc=
X-Google-Smtp-Source: ABdhPJzG9U4oSbomAfuk/gmr0FTIz5MGnIJzmDLxZVTdrElk6kv1BR0V4nSPlIIjl0XEDrk5kn+NcVZpNv+A7CPBk9A=
X-Received: by 2002:a05:6830:1c69:: with SMTP id
 s9mr8819172otg.132.1629895896614; 
 Wed, 25 Aug 2021 05:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Aug 2021 08:51:25 -0400
Message-ID: <CADnq5_MxQc_+tWaGK2wUquh2ftzjg87GDsJc1mAOBgJF72xCJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation(v2)
To: Monk Liu <Monk.Liu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

Please cc dri-devel on all scheduler patches.  It's core functionality.

Alex

On Wed, Aug 25, 2021 at 12:14 AM Monk Liu <Monk.Liu@amd.com> wrote:
>
> the original logic is wrong that the timeout will not be retriggerd
> after the previous job siganled, and that lead to the scenario that all
> jobs in the same scheduler shares the same timeout timer from the very
> begining job in this scheduler which is wrong.
>
> we should modify the timer everytime a previous job signaled.
>
> v2:
> further cleanup the logic, and do the TDR timer cancelling if the signaled job
> is the last one in its scheduler.
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index a2a9536..8c102ac 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -305,8 +305,17 @@ static void drm_sched_job_begin(struct drm_sched_job *s_job)
>         struct drm_gpu_scheduler *sched = s_job->sched;
>
>         spin_lock(&sched->job_list_lock);
> -       list_add_tail(&s_job->list, &sched->pending_list);
> -       drm_sched_start_timeout(sched);
> +       if (list_empty(&sched->pending_list)) {
> +               list_add_tail(&s_job->list, &sched->pending_list);
> +               drm_sched_start_timeout(sched);
> +       } else {
> +               /* the old jobs in pending list are not finished yet
> +                * no need to restart TDR timer here, it is already
> +                * handled by drm_sched_get_cleanup_job
> +                */
> +               list_add_tail(&s_job->list, &sched->pending_list);
> +       }
> +
>         spin_unlock(&sched->job_list_lock);
>  }
>
> @@ -693,17 +702,22 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>         if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>                 /* remove job from pending_list */
>                 list_del_init(&job->list);
> +
>                 /* make the scheduled timestamp more accurate */
>                 next = list_first_entry_or_null(&sched->pending_list,
>                                                 typeof(*next), list);
> -               if (next)
> +               if (next) {
> +                       /* if we still have job in pending list we need modify the TDR timer */
> +                       mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);
>                         next->s_fence->scheduled.timestamp =
>                                 job->s_fence->finished.timestamp;
> +               } else {
> +                       /* cancel the TDR timer if no job in pending list */
> +                       cancel_delayed_work(&sched->work_tdr);
> +               }
>
>         } else {
>                 job = NULL;
> -               /* queue timeout for next job */
> -               drm_sched_start_timeout(sched);
>         }
>
>         spin_unlock(&sched->job_list_lock);
> @@ -791,11 +805,8 @@ static int drm_sched_main(void *param)
>                                           (entity = drm_sched_select_entity(sched))) ||
>                                          kthread_should_stop());
>
> -               if (cleanup_job) {
> +               if (cleanup_job)
>                         sched->ops->free_job(cleanup_job);
> -                       /* queue timeout for next job */
> -                       drm_sched_start_timeout(sched);
> -               }
>
>                 if (!entity)
>                         continue;
> --
> 2.7.4
>
