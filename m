Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F32CCF2C4
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFEB10E467;
	Sat, 17 Oct 2026 17:30:59 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B0610E0FC
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 00:09:39 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-16079d54c17so917179c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792195779; x=1792800579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hdEgyaxXnBWSRhuv+q3gw3+PLLgLDUmHWnxnCGdLz4E=;
 b=XTp5RsGzYj0t4GeWcOAR9Rosnhjzkk4QMrhr3TdmAPhKNcDDzI4DacJIXMZyZz2xBW
 v+nY3NTBtJauJoB0fVLjDozEXobdSQIkx3dQ2y3kSfNOCX8OcEjn3h91xzzClZb2m6Bt
 04X2C/7KaC8e2dsaGiavETZHDuBOCGFOBe5JY9d5MBrYiGEDbTiy0f6PHs3M6WkOwFYb
 HnjR6ty0vn7m8xqG3xSeUdSwm/+n3xpspvzGlvnWqpj0bbzWIzuYYpA7K9iO/PBfg+rf
 S6y8zSFbJR0A22xO5McGLEod7dvJ847WajXewlLwnT6tT2JBLANPieRgP5ocf/1kLovX
 J7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792195779; x=1792800579;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hdEgyaxXnBWSRhuv+q3gw3+PLLgLDUmHWnxnCGdLz4E=;
 b=W/ouAOgjDRj9tOwc8lg9qeZr/5V3GRg3zGj+m0hrHrNHCNh8Dt1XpMIJZwv/a2udRR
 DJxu2HQv5tFdZ9786rGPs/M2sTQNQIAgZiDbp+6ooSqLJcVaSVDQw+6DJcOs0y7R0NTn
 +mvCcZDmGGrxcSjeAU7Yti9TkFIqSnhJA2az50hTNj/HFd0wkxpoOrdq3VaNDfwJJFUE
 gCSB7DEq4zjTW6UR3q4vNdTJ328DdC0vulWchcDkXdZJuhC4OE7gFxJ77XI+Wfse6V2V
 EkylQsG3Rbns7U3i7zg/xUvmpXYJ0n7UtVxoJBpN4ojUC1El38LUXoYKyuM9PropbR/m
 kBnQ==
X-Gm-Message-State: AFq9FYKRuI1kHivxzYIfDDOH3+3eMbnOk3tEBNNyO6nASgU7iXAs/jbo
 nuoSUIphbjiOvnLcg5/t3hCIwMVLHvo4cJsNFNlNNQjZzvC4PAM6aUIh
X-Gm-Gg: AYBFou04rLVtI3A9sBFZf//2fTMkknXhTPj/ba8Jnj2eiJdcBtOkjWJfpcoAMyolb8Z
 Do2y0ms9pzpV0ldb8XR86iN7ZyOOBcC+PEt7P6JyMd3z6eaVWN+a+5FJMbnbUmGEzYxeh5Jn1NN
 fXqKF/kVCeqp4UDOSOlA2UOcLao6qZoT+LhFXIoa7WKAQYtpU1zW7xP8VyOljUkthhaSCMoUn3N
 Ny9wj34DUF/oTKVfXJtUYaLnGkiuvW0p53ojUyJde17y4J8mpd8IbT0k3/7ZIDvEeQzRxVaLpb1
 UchkliFDvIx/YftShfpjrhHXChswsZkHer1xSkdyfhifaa1G9F1Sfh7Vnw/GOGdyBWoZH9+WITx
 d1GTSLzAKGS2s2GHZ3hNO3OEBfxpRc/ea57IyD2ea+1dhsf+6X0W8ypt//dkMxRmQkkQWr4PKlr
 gEFJlaVs4eSzc1bJYMX8i/n84+P7lgLGvms0fs2lmRb+QfbePGX/bS7R1ynUKpDEtpOEDhSuS6u
 slDNUkY
X-Received: by 2002:a05:7022:ebc4:b0:14a:fe37:cdf0 with SMTP id
 a92af1059eb24-18514bfa955mr2412948c88.45.1792195779041; 
 Fri, 16 Oct 2026 17:09:39 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fc14sm10982553c88.6.2026.10.16.17.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:09:37 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
To: qchcio@gmail.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dev@deq.rocks, me@freddy.us,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/amdgpu: reset VI ASIC on Apple boards with
 VRAM at 0
Date: Fri, 16 Oct 2026 21:09:04 -0300
Message-ID: <20261017000904.8663-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015181837.41690-4-qchcio@gmail.com>
References: <20261015181837.41690-4-qchcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 17:30:48 +0000
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

Hi Maciej,

Thanks for the patch.

I applied patch 3 to the 6.18.49 kernel I use on my MacBookPro14,3
(Radeon Pro 555, 1002:67ef, subsystem 106b:017a, rev c7).  The kernel
also carries my unrelated PCI and ACPI patches for this machine.

After a cold boot, amdgpu logs "PCI CONFIG reset" and "GPU posting
now..." while it loads, and VRAM ends up at 0xF400000000.
MC_VM_FB_LOCATION reads 0xf47ff400 through debugfs.  In my tests in
September, a kernel without the reset left VRAM at 0 after a cold boot.

I then suspended to RAM three times with rtcwake.  After each resume
MC_VM_FB_LOCATION was still 0xf47ff400, the screen came back, and the
kernel log showed no VM faults, ring timeouts or GPU recovery.  After
the last one I ran glxgears for a minute and the gfx ring kept going.

I also closed the lid for about ten minutes.  After opening it the
screen came back, MC_VM_FB_LOCATION was 0xf47ff400, and glxgears ran
for a minute without errors.

Before that I had also tried it after a warm reboot, with four rtcwake
cycles and one 45-minute suspend from the idle timer.  After each of
those MC_VM_FB_LOCATION was 0xf47ff400 and the log showed no GPU
errors.

Finally, I reloaded amdgpu after a suspend, twice, with modprobe -r
and modprobe.  Each time amdgpu logged "PCI CONFIG reset" and "GPU
posting now..." during the reload, VRAM was at 0xF400000000 and
MC_VM_FB_LOCATION read 0xf47ff400.  VRAM is no longer at 0 by then, so
I think the reset came from the existing SMC check: with amdgpu
unloaded, SMC_SYSCON_CLOCK_CNTL_0 read 0x01000000 and SMC_PC_C was
about 0x205xx and changing (read through the MMIO BAR).  After the
second reload I logged in again and ran glxgears for a minute without
errors.

Tested-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com> # MacBookPro14,3

Thanks again,
Francisco
