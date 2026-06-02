Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D4CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 08:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B99B10FAED;
	Wed,  3 Jun 2026 08:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="d05zKxK4";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F087810EF82
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1780399442; x=1780658642;
 bh=a9fgN7nmhBc6vLl3TBFAXIuSjCzaskI50tzfoiuYcAQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=d05zKxK4I6mNSuKZe5/9uDirCkpaxM+npMK7dGREn0n2wIRn1cXCk9XgK7fPSCRty
 uejEtqudYvCl6R34paU5naihVnqGNAyBoJbfaUzkHHuXSkNNiPYm7G5iC2M/3ShEtc
 MbYsOosEDt0DSC03PgYA3C4eft9Nxk6M7xgV/PQT7DBouQV5g4SATcRCVleWTEDCHQ
 qStpqHvIf5JnFZMUYQRFGhcvoCOZxUZUdHXugzJaUtfkquW4BkFKR8QBqXX6dqEM7L
 jZ4rw6HFY7jlzNvR5lplsLdfHYFzk169tUhZtCQLV0lu+83yycLxmXtMq+SvrXlv36
 FZMDJR+d/zl3w==
Date: Tue, 02 Jun 2026 11:23:57 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev
From: Tj <tj.iam.tj@proton.me>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?utf-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [REGRESSION] RIP: 0010:vce_v1_0_set_powergating_state+0x5b8/0x600
 [amdgpu]
Message-ID: <43123501-2119-4ac6-b1cd-e59dfe6dca89@proton.me>
In-Reply-To: <59f38ae7-2d5a-4dcf-bff9-7e58c36f36d4@leemhuis.info>
References: <ah6q-k5wvRbW6k6e@mail.iam.tj>
 <59f38ae7-2d5a-4dcf-bff9-7e58c36f36d4@leemhuis.info>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 39e7211d699ec92de7dbeb1ae2dd89066f898786
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 03 Jun 2026 08:57:50 +0000
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

v7.1-rc6 +=C2=A0 "drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on a=
ll=20
SI" and confirmed resolves this issue. Thank-you.
On 02/06/2026 10:22, Thorsten Leemhuis wrote:
> On 6/2/26 12:06, Tj wrote:
>> Repeatedly hit this with 7.1-rc6. I haven't yet got time to do a bisect.
>>
>> $ lspci -nnk -d ::0300
>> 0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [=
AMD/ATI] Cape Verde GL [FirePro W4100] [1002:682c]
>>          Subsystem: Dell Device [1028:2b1e]
>>          Kernel driver in use: amdgpu
>>          Kernel modules: radeon, amdgpu
>>
>> $ journalctl --boot 5e39a2d49af2432c8f14f2a866a6b275 --priority=3Dwarnin=
g
>> ...
>> Jun 02 09:25:11 sunny kernel: Linux version 7.1.0-rc6+debian+tj (linux@i=
am.tj) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.4=
4) #446 SMP PREEMPT_DYNAMIC Mon Jun  1 07:32:2>
>> ...
>> Jun 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1=
_0.c:329 at vce_v1_0_set_powergating_state+0x5b8/0x600 [amdgpu], CPU#8: (ud=
ev-worker)/251
> Thx for reporting this. This is not my area of expertise, but from a
> very quick look that seems to be the issue
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5336
> for which Timur sent a fix:
>
> drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
> https://lore.kernel.org/all/20260525112204.12604-1-timur.kristof@gmail.co=
m/
>
> According to Alex it's making it's way through the ranks. Consider
> testing it to ensure it really is the same problem.

