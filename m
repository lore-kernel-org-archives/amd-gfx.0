Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D183D49C83
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 09:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BCE10E9A0;
	Fri, 30 Jan 2026 09:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="Wm1XMogD";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9534A10E8D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 21:57:06 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 5CD30323FC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 21:57:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1769723825; bh=tCPe1r1yufyWwEYzedivPD/WCN/MHHue2oFjcOB+g6g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Wm1XMogD2RmUAA/VHltJGfMihdHR+cUTTBffmqQ39Cx/yR8aoGdNtccgWizOr1Pz0
 BsbbqpnhqlbGFCTTXjLVnjOepQYx+ZKV3h2VkNPo8wn7hkKOkFBk4Z75Rp9Yk91YWe
 m/BE3BMcGsXc41Qjp8kiIUQwA+1+FzMD0ImeJoSp9n5CMy/wsAtVNrSBCLGPvydS9K
 IIc3eUXDHFjSscOmSyNzRgx2zeNaKLGjihcz8vUL4zqy+8tyE5cWfARFfd/Po6lYR9
 Ljg6uXyr3miSd96dHWABxsxdhcPOUhMbp1wx1yKkl8PW1MhCP6BmBg4xDQ9P/iS8ly
 wUK+jD0Kz5ZyA==
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6494a3d92f5so1626141d50.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 13:57:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWdZV9yjoCpkKrFgqaNT0L3sItTJe29UgMfn1VOhiqCQfbxaVgn+e2B/ZoLUurbotKE8D0h/oMR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2zX7B4et9C0H3ZJkrd35Bv3Yvwg6bCo+p4QAinyJ1e+HopTbU
 xXILFAG+T6q1tZqihAx8VqNkMHA0nYl0o4fdLVmcwAV64IyJiNYuqGFrlg7gJE3oOWno/TV/6QN
 +pSeZ0U7zUpACJGMk7er6xfwJH26R0eM=
X-Received: by 2002:a05:690e:bcf:b0:649:5176:137b with SMTP id
 956f58d0204a3-649a84a4be0mr793461d50.53.1769723823608; Thu, 29 Jan 2026
 13:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <17cd6378-e3fa-419b-90d3-7e0549817110@amd.com>
 <f71df23e-f267-46b7-8fd8-4235e9a7a7fb@mailbox.org>
 <2203806.9o76ZdvQCi@timur-hyperion>
 <eef1982a-ddff-4aea-8ece-5aa1995cc2ec@amd.com>
 <ab52825d-8f26-4b52-af5d-4051760b2aa4@mailbox.org>
 <6f1239d2-eec3-40b6-aca7-5b278350dd04@mailbox.org>
In-Reply-To: <6f1239d2-eec3-40b6-aca7-5b278350dd04@mailbox.org>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Thu, 29 Jan 2026 22:56:52 +0100
X-Gmail-Original-Message-ID: <CAFZQkGz54fuprfAwT1BiadfrqJu7PWHNmFGkFzAYacVqPq-vZA@mail.gmail.com>
X-Gm-Features: AZwV_QjGs1gsWqksnCPJJYDN74_QLdugrEf-tBl706rp-yGiMjQqEbYSaX5D8cw
Message-ID: <CAFZQkGz54fuprfAwT1BiadfrqJu7PWHNmFGkFzAYacVqPq-vZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Deucher <alexdeucher@gmail.com>,
 Hamza Mahfooz <someguy@effective-light.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 30 Jan 2026 09:22:26 +0000
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

> Another possibility is that test-only commits with the DRM_MODE_ATOMIC_TE=
ST_ONLY flag (which can happen in parallel while the kernel is processing a=
 "real" commit) accidentally have side effects on the current kernel state,=
 resulting in the "real" commit failing to do something it should. There ha=
ve been bugs like that in the amdgpu DM code before.

Some users reported that GPU resets on dGPUs happens way less often
with legacy modesetting than atomic, which led me to the same
conclusion of possibly missing locks in the driver.
To test that theory, I recently gave some affected users a patch to
lock KWin's commit thread(s) while doing atomic tests on the main
thread, so it never does two atomic commits simultaneously.

Testing on APUs showed that it did not help there, but as I haven't
heard back from any dGPU users yet, it's still a possible factor.

- Xaver
