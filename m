Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F63EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 18:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA03D112A4E;
	Tue, 14 Jun 2022 18:16:00 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F715112A4F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 18:15:58 +0000 (UTC)
Date: Tue, 14 Jun 2022 18:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1655230555; x=1655489755;
 bh=xYiKi5p+TLev+LpsdYCXOyvNkBXwLXU4fCKf4lY0+EA=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=rIAy44xpwoeDiY2lqUvVdFxly/csUqbEVt30LMfQ37yEvQLX+8cdl9HceThxbA7CY
 fSkIs1thOqZ2PN8londF9a3MIDatNQYjA5+W6nesmkPimn6WnhX6xvc0um4hdOCdvZ
 3/+JxMYIWA6EicABhUDgAdMH9T+ZNRXNvjitGaycr1sEL0L4E9FnReckVygUS+0HI9
 zvjnOktMcCz2sEvqQh3Yf0AQsilnyVjYQ96TV4IYiiRLtHuopNXfMvjox02oRyOSok
 8+xywW8dJsvFC78N5tu0iA+r2ivMU8gNyuLhIMxla/hYUJRNeQp4WsgCYzIBQ7B1u3
 Lj5BBCN0I+CCg==
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
Message-ID: <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
In-Reply-To: <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, maira.canal@usp.br,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 tales.aparecida@gmail.com, Sean Paul <seanpaul@chromium.org>,
 isabbasso@riseup.net, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Monday, June 13th, 2022 at 22:01, Rodrigo Siqueira <Rodrigo.Siqueira@amd=
.com> wrote:

> Amdgpu driver is used in an extensive range of devices, and each ASIC
> has some specific configuration. As a result of this variety, sometimes
> it is hard to identify the correct block that might cause the issue.
> This commit expands the amdgpu kernel-doc to alleviate this issue by
> introducing one ASIC table that describes dGPU and another one that
> shares the APU info.

Nice!

Are there plans to keep this list up-to-date?

FWIW, my go-to reference tables are [1], updated by Alex.

Would it make sense to add a "GFX Core" column?

[1]: https://www.x.org/wiki/RadeonFeature/
