Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8F606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NlF4Awt2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC3311268B;
	Fri, 30 Oct 2026 07:57:52 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206B910E86B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:57:45 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so407438f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793347063; x=1793951863;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
 b=NlF4Awt2gv0Ely7SCwTKjZPBQDI4wr9rJv6/qGsj9n0NVtCm6YkvUCzoRFXY4kilhE
 LgDKlFZKUU0BZT5xALI1U4/AIldSC4UAsKZ60ImX1CmTy5+VUg/EyWAFAkML9CE3U+SH
 qDehghVv0/5StHMjiSo4hpIpy7XuN5IoJIGz1ARZur+mP3zMLGhRC5nJyniz120RFpTz
 A3wo8kcVxaAJKxfVdBdGrCaT5+t6VWoeCUE45M984//A0COklZvqX94gkhc/a2oDbYsG
 cvNeoQ6AK8BHHTBbk6HxjbQP6nhRGwU/xrNS0Q8y5iwfKZGxADBiEoIQSBPaaH+oxULM
 LUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793347063; x=1793951863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
 b=zdn7ewHMW8BQ2lReprT+P5zSrmsFlttLZVhoti0NrtZ6Q1oI0t+5efAPBiXYwuTaH+
 PvdtoJnI7qJEqyoE2xixXw5LCjIrbNrW2TNI+KmcB5HoacaKQdDPV7EzGOG5OxDwPMxN
 Nx73hShkbAaP5eNStlyJlYLHRFlfxOn57Lo5HJGLNB6ZYgmphSU4rE6YUF6qTBRCC+gp
 I0GnmKDv3YVf/OG/DBZEfIWU6KXk/nbLPHf+jBPs898sAKJdkUg2sl+0YBqeqzabOybt
 LwBZHv+HBPEc4RbueTJHsmO6Pv4kEZZQA59nSshld2JhStB5yA8/78Q5OfaW4wHyrvR9
 KKtA==
X-Gm-Message-State: AFq9FYJJ3ix5gCfYWfeNeuSTKeSaoAA2qi68OdTnRe4RJrYYikZ06QN5
 6DISGXIgqCGgMpr7e/SlfckeFuDJbpI6nP3HUs375YvJhgbSPfWOgFt87oQVa2AYuQ==
X-Gm-Gg: AYBFou1WiubAB4e+gfx8SRPCBM8cz41+RSq3ETr+uJsgUkCR75NkM42fQNc9Gjtm1iu
 vJgWTxprDGacw1OzM0h1lo+uVWt/DIotexznEL43qqkg0bNiSeVDJnTBYPY4Qhp2PTYJ9AG2cJm
 2JhAfhW+xcAQmxGcAP2PytyxeAkf8wVnblw8Q5VbzHvU9spDjh67z/CUgTgSGLjYuQOHrGqkfj5
 g95/9LpFmi0tj1w5fjXkiDNux06+8Gs6niUiNOmPIfGchLwzux2f3/I/C+osiQYiOyO/8/6UjUD
 TOk/hrfmTuXLBeHvm4OjZObVQoEnlrMf+xenrQmnRzcJCnUlX/XIS5h2WnKQJ3Bwz3lucGKxN93
 pTHC6Whnxsi6w5CgzgFO9uTv+iEHGpuc4byfj0EfVm8vGmq2kj77MBzY09T6nVqt0pmWD7zBxDk
 pw7ZgNE7VRwrmEBoOTMaYSl7WmUqqx4St0uMqZhLcg8jaCniTM762mJLwjprJ/oZaKJRM/EW4QH
 3MlkDSIUQYs72TubPI+9gj7wWwhhhs7JP53fJMm+jRsJJtoeGFMTij3BGIvgSo0kdGFoicymZqJ
 tL26SWW0z9Es3UqAXz0CpAZ3OKohiY+qtnWgMqntSb+6ZEW1fq9oQI37xEMM6StIip/AakQ6qF/
 F
X-Received: by 2002:a05:6000:4a19:b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48e6e4f4405mr3497370f8f.30.1793347063048; 
 Fri, 30 Oct 2026 00:57:43 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm1675411f8f.42.2026.10.30.00.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:57:42 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
Date: Fri, 30 Oct 2026 07:57:35 +0000
Message-ID: <20261030075735.356811-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADnq5_PbewORwc3Wsqw3VQESz3RNAKJy+KdnWHx9J1rKg35-Hw@mail.gmail.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Alex Deucher wrote:
> I'm not sure about BACO.  In the BOCO case the OEM has a mux on the HPD
> pins that redirects them to the EC when the dGPU is powered off.  For
> BACO it's usually a PCIe add-in board so there is no way to redirect
> the HPD pins.

Agreed, and I can't test BACO anyway, so I'll keep it BOCO only in v2
Mario, sorry, I'll leave your BACO suggestion out unless someone has a
board that needs it

> Mike Lothian does your system have ATIF?  This is already code to
> handle this.  It sounds like it's just registering the wrong ACPI node.
> You should be able to use the existing handler.

It does, but only on the iGPU: ATIF is in SSDT7 under \_SB.PCI0.GP17.VGA_,
and the dGPU node (\_SB.PCI0.GPP0.SWUS.SWDS.VGA_) has none

What arrives here isn't an ATIF notification either.  _L05 in SSDT9 is
just Notify (\_SB.PCI0.GPP0.VGA, 0x81), and that path doesn't exist on
this board, so the interpreter aborts the method with AE_NOT_FOUND and no
Notify is delivered to anything.  I've put the tables and the errors in
a bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

What I haven't checked is whether the firmware would flag a dGPU display
event in the ATIF SBIOS requests if the Notify did arrive at the right
node.  If I alias the path so it resolves, I can turn on drm.debug and see
whether amdgpu_atif_handler() fires and what request flags come back, and
if ATIF_DGPU_DISPLAY_EVENT is set I'll use the existing handler rather
than add a new one.  I'll report back

Mike
