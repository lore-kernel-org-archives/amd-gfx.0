Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB19606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xwarman@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=f/9K+sXA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E1910EBEE;
	Mon,  2 Nov 2026 08:06:54 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2F410E179
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Nov 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793555311; x=1794160111; i=xwarman@gmx.de;
 bh=SQEKTQB/VcEhGto/OD1baW+4jP/O29Kc3Q7luiZoD8I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=f/9K+sXAYEOvi5tiLBPQHGe/Q3TSi9JnQV2yodCWTmeXCkIdDVkeiyLR2zx8/2nF
 aN3rjp+amlgFYh82YuEPR9aYSfHHIHW66rFfmnLaEtAIaZLgi0p+t6GVqMqxVjJ/Z
 60zv+9DVl2f6U4mcDjVl5ilaqg1VuOU1/B4rrDOG8DEByyGGDdfl/dlWw/vXeXpoV
 Htce7QFX3o3ywiL2A4qix55hpjo2svnIgbOohxN+0ZhRKXzDrGeK5zm5D4EPDaj6x
 0ruaf4vGrblorSm5ozjgESBzz6d1MdvZx2btMr2z1AwRdmVyUAN3dShR7tJQyLNdq
 oupPzc2DfFp29Rp1ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof5H-1wlyis2ozx-00p4hN; Sun, 01
 Nov 2026 18:48:31 +0100
Message-ID: <29d0a6d2-b6d3-45d4-8ee8-6ab7f0ee281e@gmx.de>
Date: Sun, 1 Nov 2026 18:48:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: xwarman@gmx.de
Subject: =?UTF-8?Q?=5BREGRESSION=5D_drm/amd/display=3A_HDMI_2=2E1_TV_on_Navi?=
 =?UTF-8?Q?31_=E2=80=93_periodic_=22audio_coding_type_0=22_loop=2C_SMU_hang_?=
 =?UTF-8?B?c2luY2UgNy4yIChnb29kOiA3LjEuMTMp?=
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prNuvOETNXfdYlfm4++w+/MQR8JukyeuhIx5U/ZxvXyIUchoBN/
 LampFzhaMdwqOT1kZExnuDOfOex5Vk1A3CdVMTENWsS1Dc1/X9V6cpKGJ3jvtQ3XK8qmjvK
 LJXam5HnaIYMrykC4y8qJ1c1TxrdPrgAS7spx3a5qx+l0/efLE9H3u/D9Rw0pzgTN8PzWEM
 WX4/weB9htlz7ZDdfSWBg==
UI-OutboundReport: notjunk:1;M01:P0:5a4P/Hk2vEY=;hAnV0D4KI6zBLTvQLTCE/7qu564
 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
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I'm reporting a regression on a Navi31 with an HDMI 2.1 TV that I filed at
https://gitlab.freedesktop.org/drm/amd/-/work_items/5840
(triaged 2026-09-16 with "7000 dGPU series" + "DC", no reply since), so I'=
m
asking here as well.

Hardware/software: RX 7900 XTX, Samsung GQ55Q90R on HDMI-A-1, Fedora 44,
KDE Plasma / KWin Wayland, kernel 7.1.13 (good) vs 7.2.4 =E2=80=A6 7.2.9 (=
bad).

Symptom: as soon as the HDMI output is enabled, "snd_hda_codec_atihdmi:
HDMI: audio coding type 0 not expected" repeats every ~9.5 s, with visible
display glitches. On 7.2.4 this was followed (after 3 min to 69 min) by
"SMU is in hanged state / failed to send smu message / Failed to set
workload mask" (786 lines in one boot), ending with a dead session.
Disabling the output stops the loop immediately.

Numbers from my journals (pooled over boots >=3D 5 min):
- 7.1.13: message 0.013/min (18 boots, sporadic)
- 7.2.4: ~1.9/min, median interval 9.5 s (~140x), SMU hang in 2 of 4 boots
- 7.2.9-201: loop reproduces, I cut it after ~2.5 min to avoid the hang
- REG_WAIT ... dcn32_program_compbuf_size appears once per boot also on so=
me
 =C2=A0 7.1.13 boots, so I consider it incidental.

The stable changelogs 7.2.6 .. 7.2.15 and 7.3.1 contain no commit I can ma=
p
to this (grepped for link_ddc, compbuf, HDMI/SCDC, SMU).

Suspect: commit 3471b9a31ce3 ("Rework HDMI data channel reads") =E2=80=93 =
an amd-gfx
thread about it mentions a follow-up "drm/amd/display: Improve HDMI info
retrieval".

Questions:
1. Is that follow-up merged (drm-fixes / stable queue) or still pending?
2. Is there a patch I should test? I can build and test on this machine.
3. If not: I will bisect 7.1.13 .. 7.2.0 =E2=80=93 any preferred starting =
points or
 =C2=A0 =C2=A0config options that would make the result more useful?

EDID (serial zeroed), dmesg excerpts and sysinfo are attached to the issue
above. Related (different GPUs, same REG_WAIT signature):
https://github.com/CachyOS/linux-cachyos/issues/1013

Thanks,
Marcel.

