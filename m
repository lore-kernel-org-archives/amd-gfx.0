Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CF5F99356
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 08:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44FF10EFEA;
	Thu, 23 Apr 2026 08:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mMkEppB3";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C3210E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 06:13:16 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-78fc4425b6bso53826237b3.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776924795; x=1777529595; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U3/MOmdOLroD9p85e7US4YLluRFmhxlSnYcY4Fdalac=;
 b=mMkEppB38dNMlknZ4d4vCNCY1YKjitcrunaMh22ATcjPmr2bsg0PLEoul0NfzXD98x
 TiABNyEtCBe+VCdx62sEbxirlDptU3HxUPMccQmGO4L/2wf4rU83d2yFzedTQ7DjMwEY
 IPBntFeKBpGuaN5eJhZwZD1IrLRbNEEoxMdkIaidmlINil7LxQUBgELMG+AwYMqX6TP/
 2ROcDlBITPoTLF4YIW32qygp9C1ba9E2wYoOQdmBEAHeJ1arSwntjaMcfzvZwObb8Hkz
 YTY7VIlMBJiVx+yZjaaWcB1BFQUaVKOtYzfzIQi8N+bq2aUQlgS1NF47L9v4MtTpi/7w
 b0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776924795; x=1777529595;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3/MOmdOLroD9p85e7US4YLluRFmhxlSnYcY4Fdalac=;
 b=bzu62s7jDk3o9Q649YsaQe5yOLmX6FzblmH0SDXMdhSiKmQSHZXShHhk+y8AWyatVz
 wEth57Cydw+QkNFERo3M1cDVnZmCTnDlyiyyRINq2rqZ3VTs542HFRygpsuiuGMsCMc8
 9/Jmxmzye3sfJfWzfdLeC9cgTI4EAdJI4rDKb1jLli/WTEUNZaXlTJQezAhvV+Sk1Nc8
 zRN3scyo31ztPlqxikI1InWq12gGFvTIqGfitbrEj+kH6Wmg8Z5687pjJyVpInaeUu9E
 G8GGZHVmcxDL/u8PPQjnAEOjPGxy0uB7nGfGyr//gmhWDpNb3vNLMppCXjA2jxVogTUo
 ZXqQ==
X-Gm-Message-State: AOJu0YzfBqU3fDdVlY8Ckaj/eKER+3kKiLSzxSRV1FZvWmOy/Nb50bWd
 bAKBdpKgzxkdfSMbUNURHkc8Md1coK7vHybvsVYOPN1YvMYMa/f4Q0gl
X-Gm-Gg: AeBDiesntZT+hWE+QSkRsExhTd8wv6r7Xuum96jE6ZI2p3I34T/InjazFiqctw1MNuY
 oDy+VuUT0YazLxooNbLfuGzDUE9w5okLxlhoS4j8Oj9juKMDtIv3V3HNZFo06zb2vs3veKb/7El
 4WmisxBfRjHKcJkTenQnZtlfjU+Soidsa3fYaHs/wfLgeyoOsoSKArHBUVK4l0b7UCO1lnE0XSi
 txvwRxQtteK/DWo0Tx6Jtzg/j5IfUKisD3qeQP5+RS5BOaBef6iKE2sH0U2h1BzeqdYIptZRPZH
 esq2x9u/rSTPdZfjOU54NvGFnX5II87KfH4RUeZthddOdlbCIeWpcQVd2WIQtXNpPV0PxogpIPX
 7uyRHQkcZCFJJFx9a8wGjbu55lJBOBAAqq1DnwumZCWVJDLLXJbi23SM9maCd/eCIUYZ40jKSbc
 ziQI3U74NyjNyOIIODRbEaChrkl3Yh
X-Received: by 2002:a05:690c:ed5:b0:7b9:b31:8361 with SMTP id
 00721157ae682-7b9ece6a6e6mr270428607b3.1.1776924795363; 
 Wed, 22 Apr 2026 23:13:15 -0700 (PDT)
Received: from localhost ([172.216.252.33]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee9b28a9sm76619487b3.39.2026.04.22.23.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 23:13:14 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:13:08 +0300
From: Dan Carpenter <error27@gmail.com>
To: David Yat Sin <david.yatsin@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdkfd: CRIU checkpoint and restore events
Message-ID: <aem4dADjR-Q7Wduj@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:52:16 +0000
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

Hello David Yat Sin,

Commit 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore
events") from Mar 5, 2021 (linux-next), leads to the following Smatch
static checker warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_events.c:110 allocate_event_notification_slot() warn: idr_alloc start value from user can be < 0

[ There are a couple older warnings as well ]

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_events.c:226 create_other_event() warn: idr_alloc start value from user can be < 0
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2367 criu_restore_memory_of_gpu() warn: idr_alloc start value from user can be < 0

drivers/gpu/drm/amd/amdkfd/kfd_events.c
   454  int kfd_criu_restore_event(struct file *devkfd,
   455                             struct kfd_process *p,
   456                             uint8_t __user *user_priv_ptr,
   457                             uint64_t *priv_data_offset,
   458                             uint64_t max_priv_data_size)
   459  {
   460          struct kfd_criu_event_priv_data *ev_priv;
   461          struct kfd_event *ev = NULL;
   462          int ret = 0;
   463  
   464          ev_priv = kmalloc_obj(*ev_priv);
   465          if (!ev_priv)
   466                  return -ENOMEM;
   467  
   468          ev = kzalloc_obj(*ev);
   469          if (!ev) {
   470                  ret = -ENOMEM;
   471                  goto exit;
   472          }
   473  
   474          if (*priv_data_offset + sizeof(*ev_priv) > max_priv_data_size) {
   475                  ret = -EINVAL;
   476                  goto exit;
   477          }
   478  
   479          ret = copy_from_user(ev_priv, user_priv_ptr + *priv_data_offset, sizeof(*ev_priv));
   480          if (ret) {
   481                  ret = -EFAULT;
   482                  goto exit;
   483          }
   484          *priv_data_offset += sizeof(*ev_priv);
   485  
   486          if (ev_priv->user_handle) {
   487                  ret = kfd_kmap_event_page(p, ev_priv->user_handle);
   488                  if (ret)
   489                          goto exit;
   490          }
   491  
   492          ev->type = ev_priv->type;
   493          ev->auto_reset = ev_priv->auto_reset;
   494          ev->signaled = ev_priv->signaled;
   495  
   496          spin_lock_init(&ev->lock);
   497          init_waitqueue_head(&ev->wq);
   498  
   499          mutex_lock(&p->event_mutex);
   500          switch (ev->type) {
   501          case KFD_EVENT_TYPE_SIGNAL:
   502          case KFD_EVENT_TYPE_DEBUG:
   503                  ret = create_signal_event(devkfd, p, ev, &ev_priv->event_id);
                                                                  ^^^^^^^^^^^^^^^^^
If this is more than INT_MAX then it triggers a WARN() at the start of
idr_alloc().  Greg KH always points out that technically most linux users
have reboot on WARN() enabled so this is a quite bad bug.

   504                  break;

The other warnings come from;
drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
   841  static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
   842                                          void *data)
   843  {
   844          struct kfd_ioctl_create_event_args *args = data;
   845          int err;
   846  
   847          /* For dGPUs the event page is allocated in user mode. The
   848           * handle is passed to KFD with the first call to this IOCTL
   849           * through the event_page_offset field.
   850           */
   851          if (args->event_page_offset) {
   852                  mutex_lock(&p->mutex);
   853                  err = kfd_kmap_event_page(p, args->event_page_offset);
   854                  mutex_unlock(&p->mutex);
   855                  if (err)
   856                          return err;
   857          }
   858  
   859          err = kfd_event_create(filp, p, args->event_type,
   860                                  args->auto_reset != 0, args->node_id,
   861                                  &args->event_id, &args->event_trigger_data,
                                        ^^^^^^^^^^^^^^^
Not checked.

   862                                  &args->event_page_offset,
   863                                  &args->event_slot_index);
   864  
   865          pr_debug("Created event (id:0x%08x) (%s)\n", args->event_id, __func__);
   866          return err;
   867  }

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
  2456  static int criu_restore_bos(struct kfd_process *p,
  2457                              struct kfd_ioctl_criu_args *args,
  2458                              uint64_t *priv_offset,
  2459                              uint64_t max_priv_data_size)
  2460  {
  2461          struct kfd_criu_bo_bucket *bo_buckets = NULL;
  2462          struct kfd_criu_bo_priv_data *bo_privs = NULL;
  2463          struct file **files = NULL;
  2464          int ret = 0;
  2465          uint32_t i = 0;
  2466  
  2467          if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
  2468                  return -EINVAL;
  2469  
  2470          /* Prevent MMU notifications until stage-4 IOCTL (CRIU_RESUME) is received */
  2471          amdgpu_amdkfd_block_mmu_notifications(p->kgd_process_info);
  2472  
  2473          bo_buckets = kvmalloc_objs(*bo_buckets, args->num_bos);
  2474          if (!bo_buckets)
  2475                  return -ENOMEM;
  2476  
  2477          files = kvzalloc(args->num_bos * sizeof(struct file *), GFP_KERNEL);
  2478          if (!files) {
  2479                  ret = -ENOMEM;
  2480                  goto exit;
  2481          }
  2482  
  2483          ret = copy_from_user(bo_buckets, (void __user *)args->bos,
  2484                               args->num_bos * sizeof(*bo_buckets));
  2485          if (ret) {
  2486                  pr_err("Failed to copy BOs information from user\n");
  2487                  ret = -EFAULT;
  2488                  goto exit;
  2489          }
  2490  
  2491          bo_privs = kvmalloc_objs(*bo_privs, args->num_bos);
  2492          if (!bo_privs) {
  2493                  ret = -ENOMEM;
  2494                  goto exit;
  2495          }
  2496  
  2497          ret = copy_from_user(bo_privs, (void __user *)args->priv_data + *priv_offset,
  2498                               args->num_bos * sizeof(*bo_privs));
  2499          if (ret) {
  2500                  pr_err("Failed to copy BOs information from user\n");
  2501                  ret = -EFAULT;
  2502                  goto exit;
  2503          }
  2504          *priv_offset += args->num_bos * sizeof(*bo_privs);
  2505  
  2506          /* Create and map new BOs */
  2507          for (; i < args->num_bos; i++) {
  2508                  ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i], &files[i]);
                                                                 ^^^^^^^^^^^^
Unchecked event_ids.

  2509                  if (ret) {
  2510                          pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
  2511                          goto exit;
  2512                  }
  2513          } /* done */


This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
