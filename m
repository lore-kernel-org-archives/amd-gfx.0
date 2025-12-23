Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978C6E6F086
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 18:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0E810E297;
	Tue, 23 Dec 2025 18:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=glanzmann.de header.i=@glanzmann.de header.b="S+Ghrcku";
	dkim-atps=neutral
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275F310E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 06:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1766470151;
 bh=gFOwAoOWk2h+hSaCfwQjDoZMPkX64EVUkkmjS9/KLYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S+GhrckuZnjCevNSpyMe9o9Yd7XDqXcZBLxy8riJ7BONU8Ph25PZcOHN6FA5uR4t1
 gmszNk8nazjNlSDdU071fWssojg4UoqhTVi0KPeC8PGncngUvpwEGAg2LaE4R8Rdww
 5bJQhQfoHjfci4+m5YC03gxOi7UG+ivHZOFPCg6JXLPlMH9Gk7deZ75t45lMwnr8iK
 sqYBQnp9A0QBcNYt0WjvNU7VK9KICEKih8MdmhI/Z75GNQ9Wishn+VvUgophcbxQzP
 z2rHnqPebu2gegb6HHzKtg7+TzyD/nQKrqtOkKf14ICwGUHUA8m67McGgFB449llX1
 pQz3lpPQ5HC2URXa47KZf9SdUBx82Dkr/8zHPorCc2g5EMdxvm+cuSm/nx7WP1jrDO
 juT3xL80WAKZXWS4IHSobracrnGHwldGgBnAYlLwUkzd5A9JJFSjYH7EWdB3cW3Lh5
 BvrX0i0L6jYC9NLPkxCn/+BG1TzhPmJGll/3uLAD14ldCPPufuHr+aU+GK6omYLe5F
 BbYyDkKN5lA2+VTfUpmEAQh3DQY8pzRdg+GqAX6eaWjCVkIsRXYXhPMGsCpLvWvWsA
 DU4ZUfv7gcKsPhm8iwSv7BIYPb4VCQHryFAgtpQR/M4O1hXv+9Fe2Xjpq2SlzCAftz
 tEFUTKxqLjhRGGFk2qUoPM7g=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id E97AC25F306; Tue, 23 Dec 2025 07:09:11 +0100 (CET)
Date: Tue, 23 Dec 2025 07:09:11 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu: [drm] AMDGPU device coredump file has been created
Message-ID: <aUoyB1spnrj1_J3H@glanzmann.de>
References: <aUjiv4TnoVJ9LysI@glanzmann.de> <2575679.XAFRqVoOGU@timur-max>
 <aUmjEQ0a47_OeWbR@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUmjEQ0a47_OeWbR@glanzmann.de>
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
I have reinstalled my system using snapshot.debian.org to the state of
2025-06-01 which was working for sure. Unfortunately the issue is not
resolved. So after I ruled out Kernel and Userland only one thing is
left: The BIOS. Unfortunately I updated to a BIOS version which can not
be rolled back.

https://www.asus.com/de/motherboards-components/motherboards/tuf-gaming/tuf-gaming-b650m-plus/helpdesk_bios?model2Name=TUF-GAMING-B650M-PLUS

> Version 3602 17.27 MB 2025/11/27
> SHA-256 ：C972529E551DC92871B89660E3A3930F187EA6E1B718ADDD7B0E3826D79195C0

> 1.AGESA updated to ComboAM5 PI 1.2.7.0.
> 2.Improves compatibility with various CPUs and devices.
> Note: This BIOS version cannot be rolled back to previous versions.

> Before running the USB BIOS Flashback tool, please rename the BIOS file
> (TG650MP.CAP) using BIOSRenamer.

I open a case with ASUS.

Cheers,
        Thomas
