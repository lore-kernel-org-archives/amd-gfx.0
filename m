Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2FC98328
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBA310F93A;
	Fri, 25 Sep 2026 07:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWkewzZC";
	dkim-atps=neutral
Received: from mail-dl2-f22.google.com (mail-dl2-f22.google.com
 [74.125.229.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A2B10E1F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:05:14 +0000 (UTC)
Received: by mail-dl2-f22.google.com with SMTP id
 a92af1059eb24-14383fddae4so219715c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790283914; x=1790888714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1NmZmhgLOy/YmQC3GmGsf1VOw7I8/+ySPDXRuFIlrI8=;
 b=QWkewzZCsM1B0X4ITFkRYAO0dfNWysEX/cxDNn2oREpKquzfdtIYVjxBlyePn4e9ky
 P8y2d+mB4Hx9JApWK27xGYSS/oVa2mqNj0jS6kDtkqO6zYVvTImJeCZ5oOP1EYTVIYd1
 6aGoPRNv2GFAYI+XZyofl/GWnk7aPqoRIgvyvvxG2bpoOKD8mBnEowLpgRPFSuMLFyED
 S5eFKdBaQIi/1XUkBF30PlhwnMrVIguJ9am06UvGAnbV4YViYaLJ0DLJAOpM09ekHnUs
 kaxOkgN4Bm3nWro//CPqTdoI05MuED34ZjF4HdHb5BZweW1llKJFjrzsmB6aoa08RjWH
 eHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790283914; x=1790888714;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1NmZmhgLOy/YmQC3GmGsf1VOw7I8/+ySPDXRuFIlrI8=;
 b=n4P0sEsjZ/95WGSfD8OJKhQDkXbqvGsPweEeZ5FHw49FCnq+rhmtT5oEsr0WlPMOTB
 FqzdEGN/y3sfEnWcrxnsji+PbGqjxI4k0bsMRS+Xiyq5RO2NFn3goWmQIiSqEl2uatR0
 GdfayJje8LQeDVMmeHGbJnPqNaWLhod2Dkztifvf2Oc5OjMSsTIp36lMr2d2VjaXhXNw
 gj/c8UqrWmhZ+Z/+SRqdE5Aq8O8mf9jPcz7WJl/Q5yIoUU8go7nudoQUkVI9vE+hObum
 rQDPeb5vHdpFqT/fz3bFBsnk0CshMuBZJFanuvY1Fv3l6a//0vm4Pl2/Zo/2mKrpa1lZ
 1nmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdR9YbM42Ip1GtwtopHZp4hAT2JR7khVFoUs7Jzr53kZmrU3ChiDaYjEJx5C1XxG5Ns1xcB9dN@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNF1T+LDiHXxvhaq7gR+Xr1DU7lME4BZiEwQMVrEqk9yQrBO/X
 hGqa4zdd2SN6+ODnPsIcYBqACyqAVLkAUXJX6ltBsXn9uYeXPMquQkHj
X-Gm-Gg: AYBFou19fjLKxCvVnbkr0jMMfufwn5Wz614i9afWf2XyQweXl+gzzC04Be8cl5dXptZ
 6Fpsoc4klCifHHC5ie+YA886pfi4TgNB2+lmItKsMMbKeehMvTWrkYYy0J7U0ot4Q1BWAmge4Og
 mNrB48Qmywll+jUYeylh+eCdOHKEVCaUjxope08w6GbN4PbJaRwIYkfG3NxKguOjD3boktE2v3Q
 4pZclfP0BczDkG14sz9nr1g5Ucv5KY3+E8ZfJPY4Dnr26IyfeJaFy4z4h3VCWUqZWgPWRTRuJ7b
 m61n9/O6NxC9F7U187EtP2gjS4z1uK0XFkT1naUwbo1jB3IVCQByf8/fosd1yDY0oLOQmG57BEY
 A15RIU/1A5SjGu1jGl5l0H2Jasy6SGHuTDTOiqhMe0WDmdJIQg524khgnnZMJ2umzh5yvEyW82U
 O+FQLkPx8ufFXDXsWGrs5SVkhvRuBMj0eAjTcPPxcwO8Il5rhC3wX3Il42woLtpoikCFAHr0cY5
 RSDL1KJIjERdpZ0keY=
X-Received: by 2002:a05:7022:fd09:b0:13d:974:a42d with SMTP id
 a92af1059eb24-14503fde9d8mr4585588c88.22.1790283913457; 
 Thu, 24 Sep 2026 14:05:13 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c0ccsm1054300c88.4.2026.09.24.14.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:05:13 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/gmc_v8_0: restore the FB location after a
 re-POST
Date: Thu, 24 Sep 2026 18:04:57 -0300
Message-ID: <20260924210457.13100-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
References: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

On Thu, Sep 24, 2026 at 11:21 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Thu, Sep 24, 2026 at 11:06 AM Christian König
> <christian.koenig@amd.com> wrote:
>> On 9/24/26 15:29, Francisco Beltrán Millalén wrote:
>>>   cold boot:   MC_VM_FB_LOCATION = 0x007f0000
>>>   after reset: MC_VM_FB_LOCATION = 0xf47ff400
>>
>> Mhm, interesting I'm really wondering where those values come from.

0x007f0000 is what amdgpu finds when it loads after a cold boot, with
HDP_NONSURFACE_BASE = 0: the framebuffer at MC address 0.  That is what
the platform hands over; I have no trace of who writes it before the
kernel runs, so I can only say it comes from the Apple side.

0xf47ff400, with HDP_NONSURFACE_BASE = 0xf4000000, is written by the
VBIOS ASIC_Init table that amdgpu runs on resume and after a GPU reset.
I traced the register writes across that call.  As far as I know it
is the usual 0xF4_0000_0000 placement of Polaris boards elsewhere.
(The "0xf400_0000" in my commit message was wrong: the MC address is
0xF4_0000_0000.)

>> I think the more defensive approach is to do an ASIC reset on driver
>> load and use the values the AtomBIOS init function comes up with.
[...]
> I agree that running asic_init
> on boot for Macs would make sense.  I think we already have a similar
> workaround for some other mac models, probably to work around a
> similar issue:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5be7ad8f5f0e067613e9197638f216f46252946
> Maybe add your device to that existing quirk or make the quirk generic
> for all VI boards with apple ssids?

That works, thank you both.  I backported a5be7ad8f5f0 to 6.18.49,
added this board (106b:017a rev c7) and dropped my gmc_v8_0 patch:

- On load: "PCI CONFIG reset", "GPU posting now...", then
  "VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF", after both a
  cold and a warm boot.  With a debug print just before the reset,
  MC_VM_FB_LOCATION reads 0x007f0000 before it and 0xf47ff400 after.

- S3: 9 suspend/resume cycles (lid close and rtcwake, one of them with
  the lid closed for about 7.5 minutes and a USB-C disk attached), each
  followed by a few minutes of 3D load.  MC_VM_FB_LOCATION stays at
  0xf47ff400 and no ring timeouts or VM faults were reported.  In 4 of
  them my old patch was still in as a detector and never fired; the
  other 5 ran without it.  The kernel also carries my unrelated PCI and
  ACPI patches for this machine.

- Cost: the reset and post take 20-35 ms, and amdgpu init up to fbdev
  takes about 0.23 s longer than before.

So please consider the gmc_v8_0 patch withdrawn.  I'll send the one-line
quirk as v2 in reply to this thread.

Two things in case you prefer the generic version:

- The GPU here is a Radeon Pro 555 (2 GB), not the 560 I wrote.  The
  MacBookPro14,3 was also sold with a Pro 560.  pci.ids lists 106b:0179
  as a Radeon Pro 560 and 106b:0160, 0166 and 0167 as the Pro 460, 455
  and 450 (the GPUs of the 2016 MacBookPro13,3), all 1002:67ef.  I have
  not checked those IDs on real machines, and I only have this one, so
  I only added 017a/c7.

- From reading the code, on VI the reset on load is always a PCI
  config reset: the BACO capability is only known once the PowerPlay
  table is parsed in hw_init, after the reset.  That is also what
  happens here.

Thanks,
Francisco
