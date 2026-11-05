Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA6606A334
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NAnpLSlg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33946112C9E;
	Fri,  6 Nov 2026 09:26:03 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956C310E293
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 19:25:13 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3ab4c608a6dso28375651fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 11:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793906712; x=1794511512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pK7uBulsQM5HxeaDcs0VER9nyKXu9clIhlJ8nf2FkJ0=;
 b=NAnpLSlgXqgQ3FRYZRHHfOHDLL5qYm4i9Q1O1b5eDmLCx/f0u6AzR12cdlAXAW/x3u
 vVwPGl7lpNolkD2A2s34+2hboWVock8fSBMlDTTNPTGuAjT+xKZTr4Wp7Y+fnqbjjfvK
 qrX25B1tY6nKBEna80zAloUceqVVhIsOYJ5uS0U/m7MTwQsGaP7DukAl2KXMRvOUfiDE
 Okm/rUlwDJ1YoYIjCZsFHp76EKvFvWL/QwJYFzFNqA0Z81mMfZirx13DPJDqcb8haBCV
 WPCZe/2M7p7PiyX69hqK0SQLrywkGtkdTDNjQ/bb1Ib+AFpiSHIPL2wGL7GtXooD23mX
 Bqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793906712; x=1794511512;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pK7uBulsQM5HxeaDcs0VER9nyKXu9clIhlJ8nf2FkJ0=;
 b=v4LtqfeqFYuN0JakmDgyNsW04suvB9GaTFE4uSRmE6aTv8arVSpAcnLKgOZAQOWihh
 cwLryICGrJMF2KbOy3GmIRICEmoNTs65LfK6rRkOfIow5QTJmVnztw6SkU07OHn1pXjg
 5YJJqHpt4mhEMceOJjj6sABcBJCMQrs6l0uOddwTTbEk6gGG28odfAJbUn30QhaHvclm
 ZHE2txfBllgsy4yAvvdih6UUELhBRMSbB4udeWOkkS9UmQ4eka+UfEy2f2Fw48fE2mjh
 /ITOCU3jI6f45ET18a2clnl0HkS1rPCla/6jTX042M+cNUCXai72FJTp6D2JilTdjUbM
 a+KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1O8pNWNd7ZiJBclzM/8D/JjwYpSEP8qA0bIcES8WjuAG06zvIcSGoEd82w0M1h8vxKjV4TWsK@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ladt17qCHRW8i2drQW3kd0N1fDwQ8hzqfqIXD88yXJMmS42Lg
 s0GynzIXWyxB/nMfd3XJIN+U0TFTx0qi43fB6F/RBNb5On8vMmK9MHwM
X-Gm-Gg: AYBFou2jzLgOpxkXTPDz2Xry8dC2qsNa5/QEnajs1niUm7sTWfWnldQD2PcrYGsgHY2
 Nwvz57ORXpp3Iru4zvxDCtHQv7iBhx07DHjDTJzdFSEUabhhfgCNmZv/vQyOxWWr8257uGh0ojq
 qTUK9UvGcsJlq2YFsZ/cmlyTwKBq2a77YwkpzLPrxHdiM+0Ae8foUhgqYmFEn8ky4CK33pju23Q
 u5gRI5LLsBfM6+EYKLyNJow4RGvTUZHyWQX15eCdtV9us6eDw8KNFW5DfDugzwi5Ml6qXA77FmR
 PU+qAqcEqp4zE4nfzv3fpI9RijAkYxySHGS2YGptc53YpqbxMpowcg7trdOwZ5IDuklWChJw5kx
 nl9XgNxbfJgflsFzuFEMIT0+fnmSgKwbFVB8j+GjgXhrRM0PHkvEQ/gr+4/IixiKyEUuvg1dBHW
 YTBOUqW6P+6btx7KTBa70/c8Q4STXsbNiNS7QZaO5pohJn1YTltsguG1Qj08ZluRnEA0jS1NMnm
 Q0h5Cmgi58e1bjF4kW2u0Rtn3bYOzbBjLHSZHCXZA+HW88h8GK2s14d0DoeatCZhq0/pNwkcLEf
 5gcGNjcxFk1yUIasjNWrimRDUPraLWb8KzF4OI/5vnk=
X-Received: by 2002:a05:651c:1614:b0:3ac:974c:64f3 with SMTP id
 38308e7fff4ca-3acf3e57dcamr438661fa.22.1793906711385; 
 Thu, 05 Nov 2026 11:25:11 -0800 (PST)
Received: from localhost.localdomain ([185.65.135.248])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6ea213sm12015791fa.34.2026.11.05.11.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:25:10 -0800 (PST)
From: Trace <tracekotae@gmail.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Honglei Huang <honghuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [REGRESSION 6.18.y] Please backport 342981fff328 ("drm/amdgpu: drop
 retry loop in amdgpu_hmm_range_get_pages")
Date: Thu,  5 Nov 2026 20:25:03 +0100
Message-ID: <20261105192503.228363-1-tracekotae@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:26:02 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

please consider upstream commit 342981fff328 ("drm/amdgpu: drop retry loop
in amdgpu_hmm_range_get_pages") for 6.18.y, 6.12.y and 6.6.y.

6.18.57, 6.12.114 and 6.6.160 took 962d684b5dc0 ("drm/amdgpu: fix
amdgpu_hmm_range_get_pages", cherry-picked from c08972f55594). As the commit
message of 342981fff328 explains, that change leaves the -EBUSY retry loop
spinning for the full timeout. 7.0.13 and 7.1.1 took the follow-up. These three
branches did not, and it carries no Fixes: or stable tag. It is not in 6.18.60,
6.12.115 or 6.6.161, and is not in the queue as of 2026-11-05.

The cost on a Radeon AI PRO R9700 with ROCm, a PyTorch speech model loaded
from safetensors:

  6.18.56 and before:  model load 6-7.5 s
  6.18.57:             model load 507 s
  6.18.59:             model load 514 s
  7.3.0:               model load 16 s with a cold page cache, 8.4 s warm

With the same 679-character text and voice on the same image, it renders
at 0.11x realtime on 6.18.59 and 0.73x on 7.3.0, against about 0.9x before
6.18.57.

The loading thread sits at 99% system time in kfd_ioctl ->
svm_range_set_attr -> svm_range_validate_and_map ->
amdgpu_hmm_range_get_pages -> hmm_range_fault.
https://github.com/ROCm/TheRock/issues/9257 reports the same stall on a gfx1100
card.

The patch does not apply cleanly. On 6.18.60 only the first hunk's context
differs, as hmm_range is still a pointer there. 6.12.115 fails on the same hunk
and 6.6.161 on both. I have not built or run a backport.

#regzbot introduced: v6.18.56..v6.18.57

Thanks,
Trace
