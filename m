Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08D7D1625F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 12:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA41810E25E;
	Mon, 14 Oct 2024 12:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Ac/Mr6jH";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="gq8bRrxB";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6872F10EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 03:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1728618844; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=UiCljemeMgCdPUs2LOsRJrup3bkfI7rwwjcWMOrW+89zkzJ6VrGxNTOhRGCHzWPFce
 W70kopLomdhX5KRMPImd64yyC5ys5FpZ5R2t4rK0SSERe7VDFOPxukFPl7PnrMrLIXns
 vt4xMrvpncI0z7fSFmBlEgK3naie1DrZijIMmpQnbdnTkhu5joAKevYW5+xxRmAjaiXx
 xG+j7lwB8TskQheAUrM4/Dhidp/rtQP/XWzFkb0obpdHj2ne4E3FAZIo90Tt4rkv1wA9
 8FduEJvtXVweASfT9RLQgbtIaWuLHRtba0y9OkXcIdqbvyoN8AKxmhDo/+7i1z9mrqW9
 kFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728618844;
 s=strato-dkim-0002; d=strato.com;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=Sw5kvAhQnV+uYxbzFDKschXQBdixLP9VwVOC5axrod8=;
 b=C3iaajA2e5kdq6A/v64H37z3SJeh+esfn8atx1FIxW0Q2cihgqKxtv3T0ryFYkwDFS
 3gkNsycb12e/yvn8RW9bVDrKcl/MrvXVN1M+YdGkq3XhFumP8D/94cPmlgUtyHnh5tIo
 KaK7F505urv65G9Yy3z5p+w5Cvj+OxFn7LuGZahmZxzkLhKGQjpyWoSteJoVZPQFynXB
 fY0HX5oTQDsNfKbo7IGpBVfGM1h2yIAb4dBKXBIYI4rPCX3FlAsBIHbCV0bIUnpPmZ4s
 zkIt0iaCO6hNq0O8+GM2YZfOqY/0PiBGiYldjqmvxn3N9HaCQQj0gYcbWB56Uxr8ybuX
 EDvg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728618844;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=Sw5kvAhQnV+uYxbzFDKschXQBdixLP9VwVOC5axrod8=;
 b=Ac/Mr6jH/SZwQXsnC26RqtCEQvjfa+EvFyOsBAQZFlSsbdFmG+LdcXBOGuJaz3qwAt
 WdowTPWtdQIBLTbjM5JcAJU2G2rDUBuH8t4l/O9FwlAMatoSiZYcgyHIqGO6nBqszf5n
 QMGQtZpadKg1L8Dv4trcpSF+9uonOTn5q4sGve1sv4nX7mtwl+xFolcWo0CJdyl+CrRL
 /2XlzmSzGHxnJyFR09YcjDrIV36h5cEb+UvNQGS1j+OZGJBmSFf39usHGCnd5oUWkGj2
 o2iM3TC7sm2Mx0dKVmJdFEZ9H168bCTIxlEu9sfmJ2OjAtBedLrHNf+V+Qh2E6vtXjae
 Wlew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728618844;
 s=strato-dkim-0003; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=Sw5kvAhQnV+uYxbzFDKschXQBdixLP9VwVOC5axrod8=;
 b=gq8bRrxBanOYS2JJnQjyc23TjbXS02K3w8jBe+jzvZehVp7IB8zQEnnsShXQ5+l+XE
 jrfDIVPteDS0SLEeBSAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5i8sy+VWyhJ8tyaNDmc6CleQOst1T66EaU95I4="
Received: from smtpclient.apple by smtp.strato.de (RZmta 51.2.8 AUTH)
 with ESMTPSA id e0da1a09B3s3wbG
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 11 Oct 2024 05:54:03 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: [PATCHES] drm/radeon issues
Date: Fri, 11 Oct 2024 05:53:52 +0200
Message-Id: <14691DD3-987C-4CC7-AA58-D3BF952F6224@xenosoft.de>
References: <b7abd0b6-ac96-48ca-8165-a3b408137007@quicinc.com>
Cc: "R.T.Dickinson" <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>,
 alexander.deucher@amd.com
In-Reply-To: <b7abd0b6-ac96-48ca-8165-a3b408137007@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: iPhone Mail (22A3354)
X-Mailman-Approved-At: Mon, 14 Oct 2024 12:50:04 +0000
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

On 11 October 2024 at 01:49am, Jeff Johnson <quic_jjohnson@quicinc.com> wrot=
e:

Can you provide links to all 3 patches?

6.12-rc2 was back merged to my ath.git project, but then my laptop
stopped booting correctly and I discovered a few Radeon KASAN reports.
Based upon my search of lore I found:

20241003060650.18454-1-wuhoipok@gmail.com
[PATCH] drm/radeon: add late_register for connector

20241007183241.1584-1-christian.koenig@amd.com
[PATCH] drm/radeon: always set GEM function pointer

But that is only 2 patches.

- - -

The third patch: https://github.com/chzigotzky/kernels/blob/main/patches/X10=
00/radeon_encoders.patch=

