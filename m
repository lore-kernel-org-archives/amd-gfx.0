Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C53DC88E45
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CEE10E4E6;
	Tue, 27 Jan 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyRuREVb";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5500110E135
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:47:58 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso51746695e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 12:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769460477; x=1770065277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLh/0068cEe1jqjjDyTpmEQKYSn3p5Mvjg19MdpSAs0=;
 b=EyRuREVbsl2J4BccLpl7FpNWZVhejTh9Mu8fP7Z+UmIEOfYEyftgN6KD9ojSQfWx6r
 BaZRbLSJJkKNsFZWCfn2WseQLgPHLdzolTKuWv5xPbb9Lk9CQrU5/Fd16YZKUXVK2z+p
 1/SgFsfdpKwsvzXYYeLgA4AcVvUYNMXsGmAW1FFBqor1RFNTui40JKgctV88tBaP/6s7
 v1Edp8taBg+PTaVrk/NZ8A93u4n78Sbuq9+ETHcOx7iPWsVuanPCdRHMcWfMCRt/T2Pw
 dqLNuukrVmuDx1PBhyj1Dkr+ZTdRJGgc5/zdz5hwmaLT/pVmm2Um/12PT9GTNqJ6LTun
 uUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769460477; x=1770065277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pLh/0068cEe1jqjjDyTpmEQKYSn3p5Mvjg19MdpSAs0=;
 b=qs4TLxZMzIEDUrIT9vWwHd+nN6ONNv2HuNK4RfmBgPOjecSUJFSWxeIHo8NJs5hRLQ
 DebplIQ3mazDyTowjA0cJdWpDYXSnJRWH0Sm7Sas2gRQqTxKVCo+vOPqRoEjXwccu79T
 HTz6aJzZjsoMhxakvoQFJdSnltkohKpQ+dHfOtbPkFIl2fL0YsbZCdxktinq9opnvHos
 Ru5LycGi8ZoyPRFzjvDPcPTYGxFh06m2SY9exHTb+B39vhiqYyl+xuYIWi+nlZ8O6kis
 WOQ/rFPQHAnqlnACBgKzeKxi5RUNlit4bPtI8ZGg4qusQtvBPZg02mhmr1Q6p3dco7qA
 VYpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+XWeBgRSjCsnKbdajI8Ctvbg8JSGBh4erQ2NCqS0a96w9iU7fFHKY0SDdKYc6u3s6u7sF/a1D@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx/8QQVVGwlbwT4AunMnXX7BQrryGS5xLlBUBGTVqu9t1T5IWc
 +Jdx7urQ4M23yPUUsSXRpqYn73EuxkoGbpL5IsSi2edVIYhhDSRrm+kc
X-Gm-Gg: AZuq6aJu886iBO1yf5HwNyT9yL3/AX/6UhVvMW76WWM6Ts+1y34fTGq3RZ47JTTSxh5
 iwHbvPNYZis8p+FCmpLIMVpu1cZrS+c9PUoEz5CMsgXi7s6lc9ix+dlR/l3z4x6fyj+F8hNr8yJ
 rOttnoQh3RaZ3YUHdF8kvkgBIK2oiKu6vl6fXru9x4PpnP1KQnorzERLJ1X1CJZ2a0cyRs1bw0Z
 AZs4YaR9g/kUSaI0NA3gek2Ryqq8Gsu90rCS2ppxXZ+GIKosGiI4ookzrCXrd9bh8oGUX5ZKaeR
 qlAMaTXSwt1xBFCzYWp01sHaOvzXtAiUa+AkKSDqPggA9alNP4WWP7E5uTqmBFBMdH9TC2aMmyF
 n45imP0WkkqyC4G07DfEA/0PSP7FpI/ZZ5RNZJiyLjPNWSRfU6vLDvBPh08PqwZJNF3M3jrApXn
 7ikd9UFZtBjkrXZ9syoYQmCX8bVsjf4XV3On1kmg==
X-Received: by 2002:a05:600c:314f:b0:480:3b4e:41ba with SMTP id
 5b1f17b1804b1-4805cf669b2mr78025315e9.18.1769460476713; 
 Mon, 26 Jan 2026 12:47:56 -0800 (PST)
Received: from ionutnechita-arz2022.local
 ([2a02:2f0e:c30b:500:c472:222f:bc60:d893])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm13275975e9.14.2026.01.26.12.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:47:56 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: superm1@kernel.org
Cc: alexander.deucher@amd.com, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, ionut_n2001@yahoo.com,
 linux-kernel@vger.kernel.org, sunlightlinux@gmail.com
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
Date: Mon, 26 Jan 2026 22:46:04 +0200
Message-ID: <20260126204603.18124-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ad3e0556-385b-471e-bb1c-43bd043ecf47@kernel.org>
References: <ad3e0556-385b-471e-bb1c-43bd043ecf47@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Jan 2026 08:19:15 +0000
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

Hi Mario,

Thanks for the additional context about /sys/power/image_size and the
GitLab issue reference.

My platform configuration appears to be well set up for hibernation:

  - 30 GB RAM / 30 GB swap available
  - /sys/power/image_size: ~12 GB (13033648128 bytes)
  - Not using secure boot
  - Swap partition is adequately sized for VRAM eviction

Based on the GitLab discussion you referenced, my image_size should be
sufficient. So the known hibernation limitations shouldn't be blocking
factors on my system - the TLB flush failure appears to be the main
remaining issue.

I'll capture stack traces as Alex requested and follow up with the
debugging information in the next few days.

Thanks,
Ionut
