Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D75AC44506
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5546610E4A5;
	Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIygsfmA";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911E110F7DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 10:06:27 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-44d2204d195so224521fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783677987; x=1784282787; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j4QdItyj/tw3kEX2YxwFoyu+/+p7aPl0/TpuZahyyCE=;
 b=YIygsfmAb8fte/BKa0uaxmWjn/hcg41naxwyWkk3HF5t+WHDNdSseXfgkoKe+vHemA
 subQiamAhr72ynP/0i2ItPOTqjs7c+nloytYbzxhjr8IRUEQHqezlXutYfzHbS6EYCc6
 9J7LXaLWkuOAQSu7OK602rlJIHkhafCBRPIU1qIK0jQdkb2xm9LI7S7ff0keefIdHsr9
 D5eAhkOPjXpeeZASYhlJX71ud974oiCMfj3kVYFJNPV4s4yJaVjmDgSCdbUiaTEmEP0d
 dURpBtU6KgQkpodwae2IkHMxbTgR+h/S6aHlyo0sxkMX7r9XD2VzreD+/nZG8E1KqP47
 VahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783677987; x=1784282787;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j4QdItyj/tw3kEX2YxwFoyu+/+p7aPl0/TpuZahyyCE=;
 b=OKbYA/Va9/R4o4k0cXg+out2vCEx47vKFZu24Tzkm9ys0pKpJaX+qyyEQSjAcVk7sJ
 e1nHOt70A+z2AVvhtWScxCHU9b9Q1a4esgAvA2/HQ4HV6zfjAPN13tpiEONW94QZqYlt
 JzDSqpseqfp5IB3wZZvlT+1da6uV3k521QMPo/1yFXBHIEx70D0N++C3+AiI89UhbX5t
 XYPIsoGVW0J3AizJd99dsQMQIIdZghx0+H82mJrPqJURgbt20WjZ0nCLrZ8F13p9J5hg
 67K0nkFFRSHBghphJEyK6m3fVGCWjbaZTNeXkDPfHO1AcQGfzBmxS6zv07va/Vvt99Gj
 mFCA==
X-Gm-Message-State: AOJu0YyqqUgdN0RjSAnW90kHTTsU9XswaOX7idv3QbqaL3s4LIj5ENiY
 pCwxxweDJ+N/qs3kKhcFtZdfqMnO9ID4+lxBEdmcekXAXho3HA3JiAtS
X-Gm-Gg: AfdE7ckjiy6ITenhQx2lmDt9OCW22clBhtN8K5a6TPcopPaErFm/t/waoeR1LhHbIL1
 O8fDVimnOAnHpIAXeDU66Fun/Msrbl5mvHOjZlymgaisSEq6ZfzYnPNb7v7rfmIU2S1bZfOC6N6
 lWEiE8DKPs07EcQJMoQ0m0fGyqsTMVm8/EM7akUnxJhEeRhmOZe4tAN3CY9aSqngS6Sy9+DXQ7L
 HyiZ+TJSS2GbLkIm5R0sTpuViTl5AIACALPZjwkuvGdNcAFMgpkwHHVoTv0GOWysp7SyqLPgDrP
 oOBK0DuxmfTIvptQwSeo6n+LWMrjxItoBPnCd0zwLLIY41qDpkwtfs7+JKPmM9ic8eyUcCNQ9Sd
 Yk26lA2NZCVtD+rEmQG9/wEDVt9Bk7vNJS7cLxPWd5rQIEg95xiGZz7nBdgm92oSGUz55RHlKqy
 KiWwVK
X-Received: by 2002:a05:6808:15a8:b0:493:a860:5809 with SMTP id
 5614622812f47-4a201c02a11mr9635461b6e.4.1783677986771; 
 Fri, 10 Jul 2026 03:06:26 -0700 (PDT)
Received: from localhost ([74.80.182.70]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4099ace01sm2072278b6e.18.2026.07.10.03.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:06:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:06:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdkfd: expose pasid of secondary contexts by debugfs
Message-ID: <alDEGwPXIuUae3Rc@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Zhu Lingshan,

Commit 325de6bf3328 ("drm/amdkfd: expose pasid of secondary contexts
by debugfs") from Jul 1, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debugfs.c:215 kfd_debugfs_add_process()
	warn: 'entry->proc_dentry' is an error pointer or valid

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debugfs.c
    174 int kfd_debugfs_add_process(struct kfd_process *p)
    175 {
    176         struct debugfs_proc_entry *primary_entry;
    177         char name[MAX_DEBUGFS_FILENAME_LEN];
    178         struct kfd_process *primary_process;
    179         struct debugfs_proc_entry *entry;
    180         int ret;
    181 
    182         entry = kzalloc_obj(*entry);
    183         if (!entry)
    184                 return -ENOMEM;
    185 
    186         entry->process = p;
    187         entry->pid = p->lead_thread->pid;
    188 
    189         if (p->context_id == KFD_CONTEXT_ID_PRIMARY) {
    190                 snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
    191                          (int)entry->pid);
    192                 entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
    193         } else {
    194                 primary_process = kfd_lookup_process_by_mm(p->lead_thread->mm);
    195                 if (!primary_process) {
    196                         ret = -ESRCH;
    197                         goto err_free_entry;
    198                 }
    199 
    200                 primary_entry = kfd_debugfs_find_process_entry(primary_process);
    201                 kfd_unref_process(primary_process);
    202                 if (!primary_entry) {
    203                         pr_warn("Failed to find the primary debugfs entry for pid %d\n",
    204                                 entry->pid);
    205                         ret = -ENOENT;
    206                         goto err_free_entry;
    207                 }
    208 
    209                 snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "context_%u",
    210                          p->context_id);
    211                 entry->proc_dentry = debugfs_create_dir(name,
    212                                                         primary_entry->proc_dentry);
    213         }
    214         if (IS_ERR_OR_NULL(entry->proc_dentry)) {
--> 215                 ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
    216                 goto err_free_entry;

This check should just be deleted.
https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

    217         }
    218 
    219         list_add(&entry->list, &procs);
    220         kfd_debugfs_create_pasid_files(p, entry->proc_dentry);
    221 
    222         return 0;
    223 
    224 err_free_entry:
    225         kfree(entry);
    226         return ret;
    227 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
