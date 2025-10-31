Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E410CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217D710EBC7;
	Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gfMnIMTV";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A4810EAD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:43:00 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3637d6e9923so18470021fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761900179; x=1762504979; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VPEaVnHIyEEykp68DuPbpbxptxzT5e1LgeffYCAMUg=;
 b=gfMnIMTVkrgvnIRX28I08N9wBYIbHQ3hbElE4T044H+XWUDU0UD/7bWr73EsDpwSF0
 CJ5YjHTJKNrIBXMnmjXA2le38J+Zedb53zYoGl/7tUkvimk9Zzxu0nm7EpOCD+1mkBDo
 YeBEQ3PNq0lBYsAjosw+P6aT3Rk7kZQwpsrfTclVmGgbWk9W2hzqeSidsq6Ko/QWF6dP
 k9K6p8+d2p/l3a1M5W3WlzrsfX87DXw9yISRz8ZTLXqnPvHagQxnAM3SVOGGFyHU/ATz
 17TEhwHVAIPPJeIDBkLre5GRhPyiMnKZO8dozSx+HMa1hCV3QaCBcdxIIsg/9JDNMFVN
 0sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761900179; x=1762504979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VPEaVnHIyEEykp68DuPbpbxptxzT5e1LgeffYCAMUg=;
 b=nY98OJ+XegPi3Ls7AVH/fs0KLx9F7UKdBE6t8JRL657U1gaoiG9GeFirHvSw/58XL9
 MFn22y7cPF1M/g/ynUnct0RWpfmCKxlvrYclh58fG7fcSWDvcr9oM43sR4BWL3xI/x5o
 PYVZDQ7zYczfIes9Km/4vNj37ViGA/Un0wdyNX66DIlE+6Gfk/QDdgxU4b70RnuPtBbs
 mLXgoQGduph1HvDx/7Kk3awLNWHqjt4ht01tpHawouPA13bymuWPcO6tE/sLdnGIbe70
 29AwejIveuopzux1KU83kUw8RPPv6/0yH5VVW74yMqnVpVMqjDMSJO8LFW0YTyOsrdlY
 oExw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRXTkOuxjnRh+CTzli0km5BXf0PXvPScSDSCPxLqMKafydjVODvsKuLulTyw31p9oi2WXqf1ip@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUv2u5yzzeBDzxiZS1aDCQRI/VLfIefO9EkaxwbwZO0Wg4lHnW
 B0onb/DWq/kaYUoB53NPsX33fPYDJHhbTxwz+GaAuFKolEwwUWPNTkzi+WjV+rkwVByQhEr2WAB
 VdU5MrE5CUCSyn0mjjooeSmruRvz+MmqcytJbMfNuKA==
X-Gm-Gg: ASbGnctF/VppS1xk2LkAhucuTVjB3LPub4Cj3FeOYl42WaY0stydUgZRI2c2Zi/r1ip
 gmGXPdTRA+9jU7CaP7Lq1PHgaTR8i31q6ds4RJsOUsB9cug7j7QzYRhqFN3jmjAcKMIDDP4qpIq
 cQ1/JKVrI0IyjHMfinZSQUr9lE2QPLorRjnjMImoBgxFDhpYM+sgAHCqVDyf1OeLeyWww3e9Zal
 A/0tbWwIpKf44safcvjLdo4aMcZSfA6nzlN4VkxY1VFbFh8rnIRHg8L3rJfwEJvHATO/d3tWxmG
 Wqkt7GSjEKrBikt+UUW5Umk3iW36
X-Google-Smtp-Source: AGHT+IHGJmqlIXHNOm1UUUwV1F7p+xTwNQl9Kedsi6/i4Xko3qPnKOYsj5yIF7hW0Osmxc3o0wmHJE08wvPDk4Ri8KE=
X-Received: by 2002:a05:6512:3a8a:b0:593:f74:91bb with SMTP id
 2adb3069b0e04-5941d52bf43mr870426e87.23.1761900179006; Fri, 31 Oct 2025
 01:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-2-marco.crivellari@suse.com>
 <813d07f7-b430-4c95-bac3-931188415593@amd.com>
In-Reply-To: <813d07f7-b430-4c95-bac3-931188415593@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 09:42:48 +0100
X-Gm-Features: AWmQ_bmgqax5gxHAeWzVR_zTAqsONzdP2NZEDUwQUNjiw7YBE-IHcZ7XDLkhobU
Message-ID: <CAAofZF7d+t8Qqojawes8WAR2YOWz7vMtgt2y=ofJHN6mChX6DQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 Oct 2025 14:16:25 +0000
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

On Thu, Oct 30, 2025 at 6:14=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>[...]
> In all the cases below we actually want the work to run on a different CP=
U than the current one.
>
> So using system_unbound_wq seems to be more appropriate.

Hello Christian,

system_dfl_wq is the new workqueue that will replace
system_unbound_wq, but the behavior is the same.
So, if you need system_unbound_wq, it means system_dfl_wq is fine here.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
