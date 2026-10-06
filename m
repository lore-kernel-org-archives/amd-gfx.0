Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA13CA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC04B10E3B4;
	Tue,  6 Oct 2026 18:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Stj7VHPO";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A582A10E280
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:02:46 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so10736345e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791309765; x=1791914565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D3x/aXOTd8r0Sg2aJwuUQQa8YefxoLRxPUvHub5brzA=;
 b=Stj7VHPOn2xT6igmTZ5a0wBOOaPqOFv+Y0LYGXPjK9KjP3NOQM5+tu8CSVMvbJA8I0
 wvmx0Gw/fP38OnHyx4rhRkcTfYsYAKwrhrXuBuIoHmy+v/cD+WflIVfKC44LaQidE8XO
 n+2aL1y1Mok+Tdmd4DM6DsC07sMuHrOP1WvcUJqKUFYeZWj6DgCk4+b4G+4Pdv/AzLmb
 dPOZObdv5iFP2xenmo/bWJknU0zb4HFRkCwWhdyifBKyPS2xhiO8UOwb2sVccb90+WGw
 wlR/2zc5w3JenOqkI7ftSR+9FHt7BRWWeOibgIjbjCzKuUutKkqQLhX7zSz2sL2DRhWH
 Rrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791309765; x=1791914565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D3x/aXOTd8r0Sg2aJwuUQQa8YefxoLRxPUvHub5brzA=;
 b=auxuk1gJGOGt9P4xad7VG4hv9BPZGqz1fktNUqimx+Q3hLujfdBapyCmqdH1SKIGQ/
 GgchyLYIadXoNajxi0aFdJQxIZwPkFYG6aioCeGPiCn/RkvoIefwrpb2IKXQHrFPh/7p
 Hpbq1wnLgsJXCHH3JXZ8X1l6XCE420mi24r7gEnEtLjocH1bNQZ4lM9hequKou9nv98R
 repPNMNK9OsWPFiPJE3ChkLVkF6r3WpvbCw1sdnGeO5Fuvn7mRoD0Qy97daIkF7/dEOZ
 xNefBZ4w8pJ4gEQQEQNAtJ15HhZH7EfZwOCkfiAOix+5SZ2nUKuZtIlDlyfCh+5YF/74
 qgGg==
X-Gm-Message-State: AFq9FYJEAjDF+m4/qGvSHj+Boov95BfEMU4Nw94t8NhCrtqWx3nIuS0U
 KWPGy7izNiTxdD08BEf2FWB7UcaXatieAcakYh09ZWadrh2SwLHNU4qaNYPrmw==
X-Gm-Gg: AYBFou3OTFUWUGXUKkni7hiKSoQjbC0qX4Llb30H8TEdEwl5/9pvMygUp4GlYPUxJhf
 3oVpiTGCiCAe4I+/CMOD2yM1nr/iTbdIPbFmD7TQ5BUc9+DSFztltk92SQr/W1TpOF+hBB/NcnF
 20smYFHCkF0jqIz0eYrvhdCUcCGHKpQ8NMbcCI+/TS/XXAOIX91N70mmAlcX7dXhToh2ZT1iWZ+
 lxVkT5JBET8EKIYEwTjqaOCl4zBA6gfy0Qji4SJ25KRfwiOo1NcopMezAnYnVFhT32iB5CrdcPw
 v0G7mK6+7JfVRgm+fUZeNX3lhlOougj8+SR8Rcek/Dmtq3Ai7h7Y7jH4onDR6lpvKTuELLQna8I
 O3ya+hRpCdlN/HGSbrl5F0NXg8WJRzvNKLqY9lE1mTmEvW+c6a73ccm/m+XNIIV1eng3D0k9XB8
 Ysv+WMlX65cbJowXPVI6H9Wzznwj89eLiRe2WldcmrZj5xUFXqsl/fnkLuQMctHiqHAOkJltg4d
 e8ixX95yqUIxvU7k1MutS988geXAEaA6sgwY2ZPJo1sdcQr7gQAnCxUi4KjHg5XFqFEr1Pi+6Se
 B9dAA08Q4dDN48Se5I6nr+k8i3uqxdepwz+jIJzBehOMk2bdDZ3M48+VhD2e6uifvpvI7ramcws
 pseMckWj/zmqXQGkjhS9RsBppjyyfpHUfIorAOiq4P1VlMtNpFJ35b8IaU2ZOPDBdxEl1hnYthm
 dXoIo/6J+TphWf4wg=
X-Received: by 2002:a05:6000:41dd:b0:487:27f9:82b with SMTP id
 ffacd0b85a97d-48c72886689mr406912f8f.32.1791309764698; 
 Tue, 06 Oct 2026 11:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f3f7sm813630f8f.32.2026.10.06.11.02.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:02:44 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 0/3] amdkfd: survive PCIe surprise removal with live KFD
 processes
Date: Tue,  6 Oct 2026 20:02:39 +0200
Message-ID: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v1 ran into the right question from Christian: the teardown wait must
stay unbounded, and the real bug is that KFD processes never terminate
on a physically gone device. This series answers that with a captured
reproduction and fixes the termination path so the unbounded wait can
actually complete.

Root cause (full chain captured via hung-task detector on a live
repro, MI50 behind Thunderbolt, pciehp Surprise+ slot power-off):

1. Removal signals the process via terminate event -> SIGBUS.
2. The process exits through elf_core_dump -> get_dump_page ->
   __get_user_pages -> do_swap_page on its SVM managed ranges.
3. svm_migrate_vram_to_ram submits an SDMA copy job to a killed
   drm_sched entity (refcount_t warns + "Trying to push to a killed
   entity"), then svm_migrate_copy_done waits uninterruptibly on a
   job fence that can never signal.
4. The dying task holds svms->lock as a reader, so
   svm_range_restore_work blocks on the writer side, and the amdkfd
   userptr restore worker piles up behind its locks.
5. kfd_processes_count never drains -> teardown waits forever ->
   removal thread wedges -> host dies.

Additionally, on the disconnected path amdgpu_device_fini_hw() frees
kfd.dev (and the embedded kfd_processes_count) in
amdgpu_amdkfd_device_fini_sw() *before* teardown runs, so the wait
either NULL-derefs or can never observe the count at all. Process
teardown has to happen while kfd.dev is still valid.

Changes in v3:

- 1/3: reorder - teardown processes before the early fini_sw on the
  disconnected path; keep the NULL guard for the second teardown call;
  the drain wait is unbounded again (no timeout). Fixes: tags cover
  both the premature free (28695ca09d32) and the unguarded count wait
  (d12d05c4bc4c).
- 2/3: resubmission, unchanged from the v2 already posted.
- 3/3: new - fail fast with -ENODEV in the SVM migration paths so the
  dying task's fault/exit path never submits to or waits on a dead
  device.

Validation (pvf, 7.3.0-rc5 + series, MI50/Razer Core X on TB3,
svmhog2 holding ~2GB managed ranges + queues):

  slot power off -> finishing device -> SIGBUS to workload
  ~8s later:    workload dead (core dumped), ttm finalized,
                pci bus released - removal complete
  ~60s later:   slot re-powered, MI50 re-enumerated, clean re-init

  ftrace confirms amdgpu_amdkfd_teardown_processes() runs from
  amdgpu_device_fini_hw() before amdgpu_amdkfd_device_fini_sw().

  Zero refcount warnings, zero hung tasks, host stays up.
  Same repro on unpatched code wedged the box twice.
