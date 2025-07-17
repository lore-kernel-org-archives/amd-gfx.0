Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADFDC83F1B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 10:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A1210E7FD;
	Thu, 17 Jul 2025 10:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X0Qke+UA";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCB010E7F1;
 Thu, 17 Jul 2025 10:19:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 02F68A57836;
 Thu, 17 Jul 2025 10:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAA8C4CEE3;
 Thu, 17 Jul 2025 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752747594;
 bh=UqaanJMLK5JXW9cS5/RggIMPlM6vJBVDHyUtlI59T2c=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=X0Qke+UA/CaY4ZfEPXZ0WxZ2J2GrHfuxSCL3JVwB+QeR5Xdznqn5TMHwSZZz0t4WD
 EPJrOMp1o1rijeQl0WkQyYekixY1D49uZHqIwBV62pTKt5RfwVTuvDtAMrPuLhWodO
 0H4b2p/iXEQKkEDpLoCv4k9B+xqMkS5hyXlg3Sh4LzWag5aGM1pPPWysQnmasudKg4
 nDnSvq21RTrcmXvMUQgFJbLpQXuOjXubGAJ/n27kYOqnojCIGKuaMO4UeT17Yx4FJF
 yeFuqO3Y8tiGuGLK8gQ9Vq2yKXHMy3K7QK8PmXZMdjwgEvnKIXjMDZ7v5dkcm3KfWt
 vYtiS37lLbfmg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 12:19:51 +0200
Message-Id: <DBE95ZE9P9Y8.3FUVSD95O9CGJ@kernel.org>
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/sched: Consolidate drm_sched_job_timedout
Cc: <dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Philipp Stanner" <phasta@kernel.org>
References: <20250716144832.62494-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20250716144832.62494-1-tvrtko.ursulin@igalia.com>
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

On Wed Jul 16, 2025 at 4:48 PM CEST, Tvrtko Ursulin wrote:
> Reduce to one spin_unlock for hopefully a little bit clearer flow in the
> function. It may appear that there is a behavioural change with the
> drm_sched_start_timeout_unlocked() now not being called if there were
> initially no jobs on the pending list, and then some appeared after
> unlock, however if the code would rely on the TDR handler restarting
> itself then it would fail to do that if the job arrived on the pending
> list after the check.

To me this patch comes down to "don't call drm_sched_start_timeout_unlocked=
()
when the pending list is empty".

That's the whole premise for the early return the patch is based on.

The commit subject / message makes this more of a side note and when I read=
 it,
it wasn't obvious to me why that's correct.

Can you please emphasise this a bit more, since that's really the actual ch=
ange,
and make it more clear why drm_sched_start_timeout_unlocked() only needs to=
 be
called when we actually find a job on the pending list.

The reason you mention in the commit message "if the code would rely on the=
 TDR
handler restarting itself then it would fail to do that if the job arrived =
on
the pending list after the check" reads more like "the approch can't work
anyways, hence remove it". That's not a justification why removing it is co=
rrect
though.
