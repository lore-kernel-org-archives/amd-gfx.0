Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9059DE6FE29
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 18:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CCA10E29F;
	Tue, 23 Dec 2025 18:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=glanzmann.de header.i=@glanzmann.de header.b="Q/r+nB8/";
	dkim-atps=neutral
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0C410E090
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1766433553;
 bh=n4vV1nGpuRm9LTqM+KPrcwt37mH3VoE63k5c3/LHKzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q/r+nB8/xrL2SG0+37atlfLw++7KadiSkwxeuWm+yqPTFCZlKDT3bNIisXU4lfGmI
 rGyLYJqvTnAjEnPEb67rZUDY2bdOnBouCqCyOq/JDCKP49cbXeiKkzVobFaGrzb5ei
 nYYBeF/3RAUmmHwQ6ZTXvrv+YsU4lMr3Li5f+DCgkL58m+aHoK/jnhKPMTXkmdLssw
 m4clI17CGHschG1LpEo8EhYVP3T7L31F3NwqFzczlyNLQA9FT2xzj5kG7FeBHfWv4u
 U61nC2HztzZhJAaM8Poa9oURnLtvCjT6XnJRAQpIGuMrb9VSRme91k8rhSLkcY8Ykz
 lmd8om5GCagRbO+LxshNOR4qHSfEzFK5j5JPFwKy+sQlDKIuCbbU+LXkePNUz/vAiT
 lT2SAX+9XZdTuaGva+yM5tqgb9rQnZwaQFsHiQmjvF7K1LFhyLR5DCP+gwpY4oUfee
 rZj53Es2lKBhA9m1FXxsuuy45v1lTWOnD5ROIpCc3PE+P3CQlFLEYnhaCO4rLICAcF
 OAdzJ6/Gd+kBc6vsPrDWivR4K29hVo+/BRnhq/EQeW+JhWl3PfGn4Vz/aZq0jwNkdG
 rO1NewpTFPqRfhY/JPuFB2G3RhA7aK0Fxghvp72UAQ1Jr2/HQFfoqOXtygu/0Wt+6u
 4lFjj+GUEuOI0GvbFw5ITmYs=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id B66931EF854; Mon, 22 Dec 2025 20:59:13 +0100 (CET)
Date: Mon, 22 Dec 2025 20:59:13 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu: [drm] AMDGPU device coredump file has been created
Message-ID: <aUmjEQ0a47_OeWbR@glanzmann.de>
References: <aUjiv4TnoVJ9LysI@glanzmann.de>
 <2575679.XAFRqVoOGU@timur-max>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2575679.XAFRqVoOGU@timur-max>
X-Mailman-Approved-At: Tue, 23 Dec 2025 18:27:51 +0000
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

Hello Timur,

* Timur Kristóf <timur.kristof@gmail.com> [2025-12-22 16:36]:
> Which GPU do you have? Are you using the iGPU from the 7950X?

yes, I use the IGPU from 7950X.

> Also for these kind of issues it would be nice to mention details such as:
> - Kernel version, Mesa version, amdgpu firmware version
> - Does the crash still happen on a recent kernel?

Yes, I can reproduce the issue with 6.19-rc1.

> I suggest to open an issue in the drm/amd bug tracker with all those details:

I opened an issue:

https://gitlab.freedesktop.org/drm/amd/-/issues/4813

> Unfortunately, the dmesg log is not actionable. It shows that there was a GPU
> hang, but there is no indication of what was happening. It does show that
> there was a successful GPU recovery though. Does your system stay usable
> afterwards?

No, the sway/wayland session freezes.

> If you know that the system used to work well beforehand, the best
> would be to tell us which kernel version used to work, which is the
> first version that broke and bisect from there.

I tried to get to a healthy state. Unfortunately I was not able to do
so. But I keep trying.

Cheers,
        Thomas
