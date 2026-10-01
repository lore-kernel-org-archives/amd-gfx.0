Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F14CA5FCE
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 20:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7668610E3FF;
	Thu,  1 Oct 2026 20:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aOZ9jwGj";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B774610E3FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 20:30:44 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso44032865e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790886643; x=1791491443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PNaQ2W8K/y5lL1V2uucAf6kHmyLzeuzW6lid7hRlfz8=;
 b=aOZ9jwGjJWPs324ET0PvycWuRV7n9YennVUEKmL8/uqKXemnIbH81FZwwtLGUJQD1m
 ZTbA1rZxD/ZEVsReJgHZba2g3j8VVXkzWZ1lnq+zVLnPnx/Ua9d3vPb9iGI3YtABoMRX
 k0LY3jh2W0TlAr/eZoxlHqWyk336a0hJfuagVFiakAfW8RC3nBtRKHJ/Ei5SaoSRe1dh
 YvRpdtSZecVRLEsb+aYUXWMNaykT7ddUu9vYKbDXnN1/ibk/Yod2HG0th4dcY/RMvEtA
 VW059AOFywvWk2qXN0PxsAe0stIJdPZybLE33EyAgeegqHUr1ZLmetPRFKCtprqIvhPa
 NzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790886643; x=1791491443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PNaQ2W8K/y5lL1V2uucAf6kHmyLzeuzW6lid7hRlfz8=;
 b=hmgVoHw8LPAMlcfqDLgPRtMjAcN1JhYt/Wv1BhMwd5PV7mV97lyUVVGXrzeuXt80xI
 63YAEWLkiFmJVfcbi2tgttMSdRTbsnKlqwkkqpZmK6vqBEm7MAsCyZS9e1oUpFLPXau1
 W6huT5G0iHbvykR7aFl2s1xsqGZ6m1ZnyLSgeEm2D49/YA3qmS4gyHfN5qUmE31C4l40
 CGm1HlYjkYxBkXbhqZiA1bfJyxcv8W7jMcHcpMqv44qeoeJBsZJbA2gkAazIAelFLMS1
 uomWv5V046JLuZ12MC7KynmB4yz9rW5dIXAxgeoDsRlodjblecO9JBXTY6aGeJnPlLZi
 0aWQ==
X-Gm-Message-State: AFuF++kp8Tn5uHyj7zhqRMIfrHrj6tyO8gsJOiCBbKiv6opELqyxFg6D
 9Xgse/WxBOzaHIROXacHonjlmNimpHq3zYzxvORDbSevaJVobPnhR9Rot4bdMg==
X-Gm-Gg: AYBFou2r4L8CD/eIdmXPUXgsyMZBDOraRoDThYMXc06CRMD8mIyxyg4q8UDBykxVsHj
 GAsIbxjS2fnXgOyoKWwxUN2YnLf/Wn/T9nLv9inIQeFkVemzrLmJbdf3bVG0ZzwFfjRbnOFByMZ
 pHfLglTH3Wqz9+JJjmMMXPZXP4o4Tz70gqVenKbzST7HqJzSKbOjiw+fCOARyixtR8W/qWyO0AC
 qHbUSxtHxOCXffw1P9h5FDRTnAWIt1Vb/WjRPZbI67gvlJY2I7dj67KIgvacR6bxLjWEgslRbPD
 t1OD+h0uHrQyuJUZQBO5zz0ZppZc0wNBLlQ+Tfug4wPabxhiAP3q/WcG50MT+ZXEx7v3F556WwN
 roTEvkUY7qQ9WH0Mw6P/NS+H+oojYSPiMu8IBQplDuXSNMzZpfKdqOz6skybyAVC7Aco9t4/mQE
 kFc4EtqBLwL3C/8OSAXfwggakos5ifQ4c/f48x/qY5HvK3xwJU5wTc3ZVa0Ptm2IUj+fvyaFmtQ
 rrJg9Al588OcdsnQS0LZrJ61I+ztl6B3ao/nCdVzshSHrcREua0dDIBenhJ59kDZ6Tj8wHif+8f
 VvJZesoF52Ah6MC4orjOQ4qpxgOT+dXiZJyfRN37MHik+0hqK4L8IVHGM0IOhVivRw+UtyOzcwc
 LX1DUg8UqW0tyHeug2VhNK2vJPlKxyTrW86ekUFctzMP+WGlkhblPDaR9AYs+FKZR53GPabNMWN
 O1q1BrBaRqz6eOhNWO1kFugg==
X-Received: by 2002:a05:600c:3e1a:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a027559e29mr10937485e9.16.1790886642847; 
 Thu, 01 Oct 2026 13:30:42 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413f:30f1:9466:ed6d:7fbe:54c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280c8bb0sm13085425e9.11.2026.10.01.13.30.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:30:42 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH 06/13] drm/amdgpu: add amdgpu_vm_update_leaves()
Date: Thu,  1 Oct 2026 22:30:39 +0200
Message-ID: <20261001203041.59923-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <da65b814-7c7d-4efe-9db9-8fe42d09b57f@amd.com>
References: <da65b814-7c7d-4efe-9db9-8fe42d09b57f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Christian,

> It's based on the latest amd-staging-drm-next development branch. I
> have no idea if that will even apply to 7.2.6.

It did, with a small compat layer (begin/end_critical naming, hmm_range
field plumbing, trace arg order, NUM_LEVELS). Re-test results on
gfx906 (MI50 32GB, Vega 20, TB3 eGPU), kernel 7.2.6 + your Sep-30
8-patch set including amdgpu_vm_pt_leaves() v3:

  - The gap-slot overshoot regression I reported on 06/13 is gone.
  - The previously *deterministic* reproducer (vLLM/ROCm staging a
    10-shard GLM-4-9B, i.e. heavy SVM map/unmap/evict/restore churn)
    now runs to completion.
  - Sustained sessions with llama.cpp (qwen3-32b, 2 parallel slots)
    plus batch inference workers: zero "STALE PDE", zero
    bo_update failures, zero MMHUB faults.

So for the series:

Tested-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

The one remaining crash signature we've seen since is unrelated to the
VM rework: the TB3 link drops under sustained ~100 degC junction load
(Razer Core X thermal/electrical marginality), which is the surprise
removal path below.

> If you could give a bit more data (e.g. what timing) then Vitaly will
> probably be able to create a CI test case for that.

Here is a captured timeline (EFI pstore, 7.2.6-k726). Two independent
drops produced byte-identical stack shapes; this is the cleaner one:

  t+0.000  amdgpu 05:00.0: Failed to send message 0x19, response 0xffffffff
           (SMU already gone - link electrically dead)
  t+0.001  thunderbolt 0-2: device disconnected
  t+0.11   "finishing device", amdgpu_job_timedout skips recovery
  t+0.44   thunderbolt 0-2: Razer Core X found again (link flapped)
  t+1.21   thunderbolt 0-2: device disconnected (gone for good)
  t+9.38   qcm fence wait timeout -> GPU reset begin ->
           "device lost from bus!", reset ret -19
  t+9.63   ring kiq test fails; WARNING in kfd DQM uninitialize
           (queues still attached to the dead device)
  t+9.63   kgd2kfd_device_exit() frees adev->kfd.dev
           <- amdgpu_amdkfd_device_fini_sw
           <- amdgpu_device_fini_hw <- pciehp_unconfigure_device
           <- pciehp_disable_slot <- pciehp_ist (irq/39-pciehp)
  t+9.64   BUG: NULL deref at 0x1b4, kgd2kfd_teardown_processes+0xde
           same pciehp_ist thread, ~3ms after kfd.dev was freed.

So no race is needed for CI: within amdgpu_device_fini_hw(),
device_fini_sw runs kgd2kfd_device_exit() (which releases kfd.dev)
*before* amdgpu_amdkfd_teardown_processes() runs - it dereferences the
already-freed pointer unconditionally when KFD processes are attached.
An igt-side equivalent would be: open KFD queues on a device, hot-unplug
the parent (or kset unregister), expect teardown_processes on a live
kfd.dev. In our case llama-server/vLLM held the queues.

Local workaround we carry (happy to post properly if useful):
guard adev->kfd.dev for NULL in kgd2kfd_teardown_processes() and bound
the "wait for process count" loop (30s) so pciehp can't wedge forever
on a dead device. Same spirit in the userptr/VM update paths: fail fast
with -ENODEV once the device is unplugged.

> Yeah that is already very well known problem. The old KFD SVM code has
> a whole bunch of design bugs. Because of that we are working on
> completely replacing that with a new implementation based on the
> drm_gpusvm component.

Acknowledged, that matches what we see. Happy to keep exercising the
interim fixes on gfx906 and to run the drm_gpusvm series once it's
usable - this machine produces SVM invalidation churn (evict/restore
under real memory pressure) more reliably than anything else I have.

Regards,
Olivier
