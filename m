Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CEEEB48F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 10:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0197E10E245;
	Thu, 12 Feb 2026 10:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P/IKtvn9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0F10E245;
 Thu, 12 Feb 2026 10:36:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 22B0A60053;
 Thu, 12 Feb 2026 10:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914CBC4CEF7;
 Thu, 12 Feb 2026 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770892203;
 bh=ZCM9xpPU2kD7F6TSBvtSfvV2kHjO3+wswcwEoR1Poac=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=P/IKtvn9dFrhJUoeMZlWmQpQm4hTnofOic9konPvy4fcOzk5h7klacTfBXBe5b2s7
 WZcNu+DW3dmqmBT3wQ0L217Baly+AjXcCB8CJRy+MOV94ac5I9U10OPlCeToyi4WP0
 dbCCrnrTz35Na+QfHODzp1HxTxIJcC2YxwLrZ7Soq3fGUsQY3QXcSpTK8Xt7r+ah2A
 WskwjCLD8eMYtdijgbqyK87NyUZTJivHcu1qNLUXkMcFl1483X+3vSuEYL3P6kIMDb
 /yNZLkYc4iN8sTUV134BLQrrmGHNa4mz/eWAXB+OZ6Qgwm1Z2EhMVlSwOCpnt4CKy/
 oFyzVtOAW2QBQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 11:29:59 +0100
Message-Id: <DGCWW5ME9V8N.2C22CCX8Y3469@kernel.org>
Cc: <phasta@kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Leo Liu"
 <Leo.Liu@amd.com>, "Lucas Stach" <l.stach@pengutronix.de>, "Matthew Brost"
 <matthew.brost@intel.com>, "Pierre-Eric Pelloux-Prayer"
 <pierre-eric.pelloux-prayer@amd.com>, =?utf-8?q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 00/31] Fair(er) DRM scheduler
References: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
 <7fcca1f49427e0279a740b6c1b9bb072eabc2c35.camel@mailbox.org>
 <12fc3ede-d9af-4d32-8ea4-822a9b93627d@igalia.com>
In-Reply-To: <12fc3ede-d9af-4d32-8ea4-822a9b93627d@igalia.com>
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

On Thu Feb 12, 2026 at 10:56 AM CET, Tvrtko Ursulin wrote:
> I am waiting on Christian to merge the first three patches via amd-next.=
=20

Let's take them through drm-misc if the AMD folks agree, otherwise we can't=
 pull
in this series without backmerging, etc.

> And based on the past experience you will not be merging it any time soon=
.

In our conversation in v5 we been discussing about the maintainance concern=
s and
seem to have consensus that subsequent work has to focus on locking design.

Also, thanks for the detailed clarification about the accounting of the ent=
ity
GPU time.

Given that, for the DRM scheduler and nouveau parts

	Acked-by: Danilo Krummrich <dakr@kernel.org>

One more request: For the future, please send the full series to my inbox.
