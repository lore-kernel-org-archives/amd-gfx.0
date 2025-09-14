Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06322CAC58E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 07:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E0110E2BE;
	Mon, 15 Sep 2025 07:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOTj8Lbj";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFF310E045
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Sep 2025 17:25:39 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b042eb09948so728130566b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Sep 2025 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757870738; x=1758475538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1e+KbGXFu9VcGvJSdmZ1O17Fz6KR5HDN0NkR/H9+bk=;
 b=kOTj8Lbjbew5+4pc2Mads2i4CNXZ/bRcjeR+YPXcTDAcqsRAl9aTH6mqc7CWEbmBpJ
 6KeTJbdXC13YEq7nowH9/Xtab1ZVGbmTCoQwd0bXQEdoRVYrfsn5hDIwi81eE/xVIGrs
 ycDb3X0maiX2aGDebQ8YT67a5kQL+ARNy9jbntkIVGBJjtu//8rALnA0FTxFnphiCha3
 XYgTMz7d00Uzw7TNlKYlXA7ETI/bSjWrcvDPPbLHkXAORZPKGEfByYx5W06jRbd8iWrI
 9dq8GZT1WVhVbOrfZH3rq5PT31zbQ6KDQ6NvrPaXbyq8Un2OuYWTHmMvOgZTJi8QjZrY
 MfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757870738; x=1758475538;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G1e+KbGXFu9VcGvJSdmZ1O17Fz6KR5HDN0NkR/H9+bk=;
 b=GO711CDjkkOec8e5mHohk5UNAIzIMheEKKquoefND+eCsHptMoZV2+1brZzDpuRoD5
 q7z9/QZHiaj18o2eFieNjFlQhEbM3geTPResFlbdnD/Foku6qGnduQpnICTfVKaGMDDw
 Ft0txma7nwBiNg5V97JS/igMJpZouQtJ6mS81Kk7M/4NjXXqLWAjxpHB+oE/l9YkBUHj
 Z7cis4Wg+/BRfNPDLTycX+xXWrMCMyOZ3o33mwNV/Pvi8Hgw+uz4UMth6yS3RZsvOEjG
 DshjQR1adgxFo80n/PNZzyjH7bwZLjL4iTVbZ4mk42kYnjlW6yt8n+joL4YNp8HFMEpt
 8pUQ==
X-Gm-Message-State: AOJu0YyzUfk1zDtk/0qorg+HwLlvydRg4iTqWUBEWuWZv/+mhLx9jPSI
 d1d0WeTZLevFgRMQ+nuZtK4pcw1FimpMRoWI2zIw136U4liE1N76Kh2x
X-Gm-Gg: ASbGncuCuqpRd9qaE57Wn8GZ+Re/JJqAOtwlgVd9iypxnFFgn0SA1W0KuN61Q77XF1i
 3c/onKgx/9phWJVm3PI9XEidiU75KCQPQmYg/4WlMBmi14xUsLJEi9F1UVWh7GRhOgqzyKryedz
 3FJ6E/Qd3amfk1lvGBs6mC2uH45tYX51NKWiQHm+MfVnWuxVYEy7OSBKobz/dCtKI2BjAR78YjP
 S8lVa1a1PMNWMfs0gr6DsBrmEYGnDhb4b5KF8kp8Ask/uR131/5cc9xBi+kxKNtoihzck0rUDCl
 0kTEaRnIb62w6yBQgQjIbTo3MAaYol06EDyVIlkerzhBN30JeiisvbBC86r1upGmUn7DoPabndb
 3z/O5JLZ/VBQ5efp3Zp/J4wyQawXeR+c1suIzkN4CTXOPwge8bfQvprMpJ7rXJ8TswsRG2zhva5
 GwG9Ktbv3j4rOfMqkdyJrOpQ==
X-Google-Smtp-Source: AGHT+IGXXVdrVK0u4cCSFNgAfQf47ACkyGsAKEWoSv4adQsY/7oMdFXgo5U3XdkN5Q1lPFbogG7ihQ==
X-Received: by 2002:a17:907:9617:b0:b04:c7c5:499d with SMTP id
 a640c23a62f3a-b07c3833a41mr894320266b.47.1757870737739; 
 Sun, 14 Sep 2025 10:25:37 -0700 (PDT)
Received: from ?IPV6:2607:fa49:655f:db00:25c1:6b2c:46ab:8758?
 ([2607:fa49:655f:db00:25c1:6b2c:46ab:8758])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62edb7d9cbbsm5693360a12.15.2025.09.14.10.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Sep 2025 10:25:37 -0700 (PDT)
Message-ID: <12e266b6-b708-43c0-8ff3-db0058c35742@gmail.com>
Date: Sun, 14 Sep 2025 13:25:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
From: =?UTF-8?B?SsOpcsO0bWUgTMOpY3V5ZXI=?= <jerome.4a4c@gmail.com>
Subject: [REGRESSION] AMD GPU not detected since 6.16.4 commit c97636cc83d4
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Sep 2025 07:39:28 +0000
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

Since 6.16.4, I am no longer able to use my dGPU.

It is visible in nvtop for a brief moment after the system boots,
but once it is D3cold, it can't wake up (not in nvtop anymore).

Specifications:
Laptop with
AMD Ryzen 5 4600H (iGPU)
AMD Radeon RX 5500M (dGPU), not overclocked (at least manually), goes to 
D3cold often
~Arch Linux, KDE, Wayland, tried multiple kernels before and after 6.16.4.

Kernel versions:
dGPU works fine in 6.16.3 and before.
The issue started appearing in 6.16.4 and persists with 6.16.7 and 6.17-rc5.
Bisect using aur/linux-git remote torvalds/linux found: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=c97636cc83d4591c0c91b6f80eaca3434d7d3e3a

dmesg after starting nvtop:

[   32.931442] [drm] PCIE GART of 512M enabled (table at 
0x0000008000000000).
[   32.931460] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[   33.086921] amdgpu 0000:03:00.0: amdgpu: reserve 0x900000 from 
0x80fd000000 for PSP TMR
[   33.130797] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode 
is not available
[   33.136900] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode 
is not available
[   33.136903] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional 
securedisplay ta ucode is not available
[   33.136907] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[   33.167904] amdgpu 0000:03:00.0: amdgpu: OverDrive is not enabled!
[   33.167909] amdgpu 0000:03:00.0: amdgpu: resume of IP block <smu> 
failed -22
[   33.167912] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume 
failed (-22).

OverDrive is a warning. The two last logs are errors.


Building with this change on top of commit 22f20375f5b7 fixed the issue.
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/22f20375f5b71f30c0d6896583b93b6e4bba7279

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b47cb4a5f488..408f05dfab90 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2236,7 +2236,7 @@ static int smu_resume(struct amdgpu_ip_block 
*ip_block)
                         return ret;
         }

-       if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+       if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && 
smu->od_enabled) {
                 ret = smu_od_edit_dpm_table(smu, 
PP_OD_COMMIT_DPM_TABLE, NULL, 0);
                 if (ret)
                         return ret;


dGPU behaves normally now.

...
[  275.490129] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  275.521159] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  275.522179] amdgpu 0000:03:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0
[  275.525009] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  275.525023] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv 
eng 0 on hub 0
...


Thanks,
Jérôme

