Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB18BCAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 08:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518C610E5A2;
	Tue, 23 Sep 2025 08:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uz4sypnU";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5142510E397
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:17:19 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-46c889b310dso21963505e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758611838; x=1759216638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tk1KTmjEF/StHtYaAYWhX1PfLqSHlgVwzyClU3JT/gg=;
 b=uz4sypnUfBH1NoJVF9wnipPHFaFY/tXXogPaipUll8/iPjkc3pKU7uEnt+6p6I/G4G
 aKFmtuyl3Xx63sOjhrXrgbQBoFt6p9p/UBz7Ux3EgevNtL5pBuzB4UMZsPPgZIXvTCO2
 7h9/ht1V0zTiiyUDClpsPLnHALA5joyDwXb/vLXfdYNVlzEHx/9V+vMqarIs63uJfMAi
 kQDTVNKG10VgmOBXLfVvF01gRfmDpvpI3zttDZbCAIRp5Os1d5mjsI17wOsObtQ95+sh
 fuJ2AgWKgQLb9IkBzYDDYU159b+9g3pBRdiLSI0NsZV6rqA2BJSDOtr/+jD/ZQgbQIGi
 zcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758611838; x=1759216638;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tk1KTmjEF/StHtYaAYWhX1PfLqSHlgVwzyClU3JT/gg=;
 b=h0Z/xZBVvpsB4FKMkDl2qYDdMunbntXkQ28NsSXr+QENmh/WxcGH7tM8w7NqZlDJz4
 jt7PR2gSQ+ASHnhGm0WA0jUDQ3xwh5KsGmsitq8oQZAwJRW5u1ylFyCzVAX8rYq07P9t
 D8T99quMjE8eNj4BWCrMfcKr6M6v1edOpyxj6l+XxHEVWJMF5xoQtgJuV9U9ixrgRMmC
 Na1dvfRcN5MJuTQX1oitC+0fcFye6eMkb+nuV8P5M53GtetszY8rqRXMfnGK/IF6VqXc
 ERL+S6ja3XuEHcQI9ASrq/W1fTemDiDC3OYVpsdoH0FRcKQbFgxdSbuPkdJR+BjsnZHE
 Qnww==
X-Gm-Message-State: AOJu0YzufB417FujoEV74e+ws+ihpmy4RETtFF0vlz8lgA5rMOROOuOs
 S41naivjncTiicc0BtMDPfERNaaEP7b6I5ETaRZfu8eZR5TVUozmyjj7z/7AUBPHYYA=
X-Gm-Gg: ASbGncs4DbXEKW4ga7lIB9junz4wNTuDOk9cQvdsnrggp7cHY6qwdj6ASBTuSlEyxWN
 is0wEmz3q5//YuCseM7m+ttZtvrWaG2W8DzdRAO725hmw/r/07blbjXTNrpL5G6fd/iLfZvSaLX
 HRLidRMiA5WHrh6S0sF5rcCFJPCiUSbOX7y02/kbH0gun8TWtQst0DNVXchvPgyD+e+Hb8WzTz3
 nYq5UENYqSIHzxWQlQHymzoFT/gBeW5BOJmLXViHITClwE88b4/STVKFhqGgPz+T43cpeNUNj5t
 jmOPtlUrReYhs3nFY8FDCwQ7DupRDtSUbs+M9Kurw8uX5Y1N5bEcSwPa+dYTpjwLjQdL1Xz7baM
 WM2VTZSxXbKyghP6rAlg+PlJ2hTxmRWGqTfjRFdM=
X-Google-Smtp-Source: AGHT+IFAUtJd8NiOdlEVrwVQcpatUx15uopcPJTVP1bCIm7iZyssgPHWNf2VYqBMiJtjfGmTLM2SvQ==
X-Received: by 2002:a05:600c:470f:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-46e1e120c41mr13913665e9.6.1758611837595; 
 Tue, 23 Sep 2025 00:17:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3ee0740841dsm22760340f8f.23.2025.09.23.00.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 00:17:17 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:17:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: revert to old status lock handling v3
Message-ID: <aNJJea-N2V4p-r3z@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Sep 2025 08:54:52 +0000
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

Hello Christian König,

Commit 59e4405e9ee2 ("drm/amdgpu: revert to old status lock handling
v3") from Aug 27, 2025 (linux-next), leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:310 amdgpu_vm_bo_reset_state_machine()
	warn: iterator used outside loop: 'vm_bo'

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
    300 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
    301 {
    302         struct amdgpu_vm_bo_base *vm_bo, *tmp;
    303 
    304         spin_lock(&vm->invalidated_lock);
    305         list_splice_init(&vm->done, &vm->invalidated);
    306         list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
    307                 vm_bo->moved = true;
    308         spin_unlock(&vm->invalidated_lock);
    309 
--> 310         amdgpu_vm_assert_locked(vm_bo->vm);
                                        ^^^^^
vm_bo is an invalid pointer at this point.  We exited the loop without
hitting a break.

    311         list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
    312                 struct amdgpu_bo *bo = vm_bo->bo;
    313 
    314                 vm_bo->moved = true;
    315                 if (!bo || bo->tbo.type != ttm_bo_type_kernel)
    316                         list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
    317                 else if (bo->parent)
    318                         list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
    319         }
    320 }

regards,
dan carpenter
