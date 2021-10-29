Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75815C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 22:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0E06101E
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 22:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E0E06101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA5F6EA85;
	Fri, 29 Oct 2021 22:13:28 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDF86EA85
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 22:13:27 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id u25so7311030qve.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ye/5foewYFYKizVA/YvRBJvDytPWQlTbJ88P4epIF3g=;
 b=jzeBoVsQvPazlsnPafnr4ewPbKV2RTUsA4+/iBQNKXarQ4org4MGzXR0qQaYdEqmRg
 CSOVXzyWNxMzZ0T2hs41tTKJgG3T2z/nh6WJd27PNLv6RtnVdMnE8UrKIHuAObAUWTJG
 j+aQV7+jfodqDt/qQ8WStsAD811jcKqGNQkWBKjmrkHOucLv55z+obcjT8KwWQ88g59X
 SXGmuBvyJ57q5DYMpRO7djFJ57SMEaRX1w7BGQ2tVhD7eNVbyRG79Z96QxnZtZXHdJHf
 h6bvO7k6mqtOP3uVB8xUbPRJBibMYXpTQ4AHZ0t3yhJGGQ8GLf+mv2VFZQaTn3lhUYDz
 FFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ye/5foewYFYKizVA/YvRBJvDytPWQlTbJ88P4epIF3g=;
 b=7ej5yZdCMyM3RMcxi1Z3TC/iqxkG+5tCcp9gUZcarUdJnJInwxz0BbWyJyKwF61yfU
 OizycP1bptTLsoruQjYFz1hmgdSLTjPeioh4xNfT2o6FrZvjFY6Z661RquBx1fEv5RNe
 TJ99ZvXOmZ4Z/FXBaAN7VHtClvqMSKkyswxN4/mmwukE76NK27i12stskehcMzuKRCV5
 AnGTTMJxxP3nLXilDEjq0vWNv3Ai1FLalWnHLg7J0PEqy8UguojECdTUCqIjgBdAc0yE
 FSSbb0RI4p7eT5Bk75TXmTrKOw4kFyePRNKm+mMX+H+PY84YmYThQrz0e8pUe66kQ5fX
 i2pw==
X-Gm-Message-State: AOAM530QhgiyeecVYyF77SphN0YhHIioO/9KCMm3ofArr5vi9qtu4ieG
 JT17vFeE6VAkKQOqgGnUd6Q=
X-Google-Smtp-Source: ABdhPJzaJP7HeNh3VAyDqlUlk4ZQbJpD/BIE9Yg2BQ9plKZeqMMeQb7B4hZMEXOffCJ3HiNwy7rcRQ==
X-Received: by 2002:a05:6214:29c4:: with SMTP id
 gh4mr13441140qvb.22.1635545606531; 
 Fri, 29 Oct 2021 15:13:26 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::41])
 by smtp.gmail.com with ESMTPSA id h11sm5127022qkp.46.2021.10.29.15.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Oct 2021 15:13:26 -0700 (PDT)
Message-ID: <9e964b4c-6a99-6605-63ae-f42537fd01db@gmail.com>
Date: Fri, 29 Oct 2021 18:13:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: amdgpu "Fatal error during GPU init"; Ryzen 5600G integrated GPU
 + kernel 5.14.13
Content-Language: en-US
To: lijo.lazar@amd.com, alexdeucher@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
 <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
 <CADnq5_PsKDreYH0aNNzfR_TbfMMsfVK=-hCCB0ThZ0PzcLPCpw@mail.gmail.com>
 <27b8936d-ba79-cc13-7768-692565bedc2f@amd.com>
From: PGNet Dev <pgnet.dev@gmail.com>
In-Reply-To: <27b8936d-ba79-cc13-7768-692565bedc2f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: pgnet.dev@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>> I would start with an sbios update is possible.

I swapped out the ASRockRack X470D4U mobo for a new, next-gen X570D4U.

Keeping the same 2X16GB UDIMMs, and trying 2 different Ryzen 5600G CPUs, I now see the following ...

With an NVIDIA PCIe card as primary adapter, it posts & functions, as before; no issues or problems.

Selecting the on-die AMDGPU, via the board's HDMI connector, now also posts & boots; No more OOPS.


Booting, now on

	uname -rm
		5.14.14-200.fc34.x86_64 x86_64

dmesg @ boot is:

	dmesg | grep -i amdgpu
		[    1.623977] [drm] amdgpu kernel modesetting enabled.
		[    1.627731] amdgpu: Virtual CRAT table created for CPU
		[    1.627738] amdgpu: Topology: Add CPU node
		[    1.627782] fb0: switching to amdgpudrmfb from EFI VGA
		[    1.627910] amdgpu 0000:30:00.0: vgaarb: deactivate vga console
		[    1.627972] amdgpu 0000:30:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
		[    1.634655] amdgpu 0000:30:00.0: amdgpu: Fetched VBIOS from ROM BAR
		[    1.634656] amdgpu: ATOM BIOS: 113-CEZANNE-018
		[    1.635463] amdgpu 0000:30:00.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
		[    1.635465] amdgpu 0000:30:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
		[    1.635466] amdgpu 0000:30:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
		[    1.635504] [drm] amdgpu: 512M of VRAM memory ready
		[    1.635505] [drm] amdgpu: 3072M of GTT memory ready.
		[    1.639127] amdgpu 0000:30:00.0: amdgpu: PSP runtime database doesn't exist
		[    1.667936] amdgpu 0000:30:00.0: amdgpu: Will use PSP to load VCN firmware
		[    2.469604] amdgpu 0000:30:00.0: amdgpu: RAS: optional ras ta ucode is not available
		[    2.477996] amdgpu 0000:30:00.0: amdgpu: RAP: optional rap ta ucode is not available
		[    2.477999] amdgpu 0000:30:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
		[    2.478948] amdgpu 0000:30:00.0: amdgpu: SMU is initialized successfully!
		[    2.530805] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
		[    2.758719] amdgpu: HMM registered 512MB device memory
		[    2.758741] amdgpu: SRAT table not found
		[    2.758741] amdgpu: Virtual CRAT table created for GPU
		[    2.758942] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
		[    2.758944] kfd kfd: amdgpu: added device 1002:1638
		[    2.758958] amdgpu 0000:30:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 18, active_cu_number 27
		[    2.949242] fbcon: amdgpu (fb0) is primary device
		[    3.052240] amdgpu 0000:30:00.0: [drm] fb0: amdgpu frame buffer device
		[    3.061026] amdgpu 0000:30:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
		[    3.061030] amdgpu 0000:30:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
		[    3.061031] amdgpu 0000:30:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
		[    3.061032] amdgpu 0000:30:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
		[    3.061032] amdgpu 0000:30:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
		[    3.061033] amdgpu 0000:30:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
		[    3.061034] amdgpu 0000:30:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
		[    3.061034] amdgpu 0000:30:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
		[    3.061035] amdgpu 0000:30:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
		[    3.061036] amdgpu 0000:30:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
		[    3.061037] amdgpu 0000:30:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
		[    3.061038] amdgpu 0000:30:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
		[    3.061039] amdgpu 0000:30:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
		[    3.061039] amdgpu 0000:30:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
		[    3.061040] amdgpu 0000:30:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
		[    3.209226] [drm] Initialized amdgpu 3.42.0 20150101 for 0000:30:00.0 on minor 0
		[   13.749477] snd_hda_intel 0000:30:00.1: bound 0000:30:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])

However, now, the output color registration is wrong.

After grub selection, boot shell background is pink/magenta everywhere.  Screenshot here:  https://imgur.com/q2JJ4n6

If I continue from shell to launch a desktop environment (XFCE or KDE), it reaches runlevel 5 with no problems or errors -- EXCEPT the color registration is still wrong.

Switching back to the NVIdia cures the issue - back to normal black background @ runlevel 3 shell, and correct colors @ rl5

The mv from X470D4U -> X570D4U apparently 'fixed' the problem with NO video output from the on-die GPU. BIOS, or other board issues, I'm not clear.

Is this color issue *still* likely a BIOS issue? or the amdgpu driver?
