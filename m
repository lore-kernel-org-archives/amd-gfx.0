Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A496C531C7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CBB10EFBF;
	Thu, 23 Jul 2026 07:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQUPjN3S";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6AC10E3BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 18:37:44 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so17432835e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784659063; x=1785263863; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOdzn0lv5fY6bowpu7QF/TzbnQ7U67kHAAc1a4hzONo=;
 b=XQUPjN3SH+R94GDMQJRhAnmpHsBm2hrTs05BA+QAxX/jRhJ1681q97WmGorM307jt/
 FzzJCnWLzrWxnEC9LIM0XjtLsE6iWiTJn2W1KaCzLv3DpuGIT4zvhd2wu+JafkiSg4JT
 ihY0PBEg98QnRJ129aMt5+lAWnWur+m/zXLwZNbe+xz3vzyDyAA+bqOPaWhLEagqVPof
 ATHNHsDpbxaTD+gWI4YYKEQhcqe9EjjlUGJ3I3SfBDfXURWPGlysCqzNa9AMs3P5uVbw
 UlxLykYd0Byqo0kxP63/8zWYWxeLsZULnmK2MNwc3RwE9l9ja3R+K5mJ+/GzkeYv5Tle
 LCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659063; x=1785263863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iOdzn0lv5fY6bowpu7QF/TzbnQ7U67kHAAc1a4hzONo=;
 b=dTYl+PPOmvwLK5GH4YVKm1BKR07cDhuEwNWO6Iy9P2ryx7wduqUfElid0xnHb+f/d3
 4+m1QUEN81QEvrHweF5O1pq0NWdrbOYjxkp9dy/LyPyjwa0Qjko8Ufd/561jrsJl2FWX
 Nvu8aYdwJ9CeNLv715LubO/YoDoxXb2swxIznDf/TxfUVEbzOGYNrQXJZqCWY3ucRBU7
 Dww1pIPkKpKqbao8PUldNFfY7HsXcE5uTGrGMosaygc6qj2r6V3XLpYWdEBioT427F1H
 l09fSKSI0mBng0lzRVK808x66rg7XN73eity5hHAHAgBhePjewsvJOiekHrajRiduG15
 evRw==
X-Gm-Message-State: AOJu0YxoWpFD1HBx2YFGRqDKIdvbsC803J7JxgjedfLbdpLgtqdYuDp+
 tqV7KoQfa/0anDwuCX+y8rKkCiN0KKwRCgX6ABYOwYKajQp66IKremWR6kJA8b30
X-Gm-Gg: AfdE7cnA80HPPmQFfW5hZTr+24tUZ+0HGORQJGoEdJRSSs4qPA1SFQEQhq0omw6dz3n
 dX4qJ9ly3LIwY2qUQ/NCzN6EH8D472+og0k0MitZtAM0YWN5M8fdyA4n5J1O9fGOSMB1N5e8Pjj
 DODH+SzKEBqErFLSOALCxyIz/grqG2H9754LqAuZoZMcTSkggoxdb4JPaslFAmdisuq6HQcagUY
 EH+JaWf6R9DPmQWr8ZrodRNVhHDcMTV1WYcLROpxH93BBQHmmNuClOb0vbUCOOVRA0hGd4GA4nR
 sImZKph6W9/15dzaXXcNTvAFfZ1POfbZp+3AIUmMls2jIPW70kV7bUK3lNcD2eOAu7O4acBvvnQ
 s4I3AO59rBGJA0q8Al6dDuuOvHEudpmpDAi/4AISTUT5ZF+LnCzpD22Psxq8bAj56MmC9VfRTGq
 QR7YpYfMNsAgsA+68=
X-Received: by 2002:a05:600c:c8c:b0:495:6457:b547 with SMTP id
 5b1f17b1804b1-49565116dd9mr59411215e9.37.1784659062774; 
 Tue, 21 Jul 2026 11:37:42 -0700 (PDT)
Received: from tux.tail17b25e.ts.net ([77.137.71.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm43339913f8f.5.2026.07.21.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:37:41 -0700 (PDT)
From: Liav Mordouch <liavmordouch@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, Vitaly.Prosyak@amd.com
Subject: Re: [PATCH] drm/amdgpu: fix PTs flush race with pending TLB fence in
 vm_fini
Date: Tue, 21 Jul 2026 21:37:39 +0300
Message-ID: <20260721183739.231344-1-liavmordouch@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c7eef696-7114-4b8c-8b87-7d232bcff570@amd.com>
References: <c7eef696-7114-4b8c-8b87-7d232bcff570@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:46 +0000
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

Hi all,

Not a patch review, just a field data point on this fd-close/VM-teardown
race, since the discussion here (and on Vitaly's "wait for HW fences before
VM teardown on fd close") turned on whether dma_resv/TTM already keeps the
PDs/PTs alive long enough on kernel queues.

On GFX11 it does not appear to, in practice.

Hardware / software:
  - Navi 32 (RDNA3, GFX11), PCI 1002:747e, sdma_v6_0 / mes_v11_0
  - Linux 7.1.4, Mesa 26.1.3, amdgpu defaults (vm_update_mode=-1)

In normal desktop use (closing games/browsers) I hit, ~once a day:

  amdgpu: ring sdma0 timeout, signaled seq=354165, emitted seq=354166
  amdgpu: Starting sdma0 ring reset -> Ring sdma0 reset succeeded
  amdgpu: [drm] device wedged, but no recovery needed

i.e. exactly one in-flight SDMA job never signals, and it is always
immediately preceded by VM-teardown for an exiting process:

  amdgpu: VM memory stats for proc <steam/Xwayland/vesktop/...> is
          non-zero when fini

Building Vitaly's IGT amd_close_race and running only the mildest subtest
(close-race-low, 2 racer threads) reproduces it deterministically within
seconds, and on this GFX11 part it escalates hard:

  [gfxhub] page fault (src_id:0 ring:64 vmid:7 pasid:2931)
  GCVM_L2_PROTECTION_FAULT_STATUS:0x00700881
     Faulty UTCL2 client ID: CPF (0x4)
     PERMISSION_FAULTS: 0x8
  ... GPU reset succeeded / VRAM is lost due to GPU reset!   (x6)
  ... MES failed to respond to msg=RESET / REMOVE_QUEUE      (x20)
  reset via MES failed and try pipe reset -110
  Ring gfx_0.0.0 reset failed

The GPU only self-recovered after the 12th reset; a couple more rounds and
it would have needed a power cycle. The CPF client + PERMISSION_FAULTS look
like the GPU walking PTEs that teardown has already invalidated - which is
the point in question here.

Full details, dmesg, environment and a captured devcoredump are in:
  https://gitlab.freedesktop.org/drm/amd/-/work_items/5512

Happy to run further instrumentation (tracepoints, IB dumps, specific
debugfs) on this hardware if it helps narrow down why the fence doesn't
gate teardown on GFX11.

This investigation, reproduction and write-up were prepared with AI
assistance.

Thanks,
Liav
