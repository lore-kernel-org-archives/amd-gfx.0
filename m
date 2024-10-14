Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803E4CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0778410E530;
	Tue, 15 Oct 2024 08:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="JjribVjJ";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="UxzzAx7P";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C630010E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 13:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1728911489; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=sC21/wmfDMp305L9jQP14kr9E+u8s5PIhCfiYWFAQ16Ub9pPVASHT4BJXytfgjEPlb
 CsP781U+1p8gKAvZNfr02nxwT35YW8lwmz57LUVl3jsm/Uc9+8admTuGNrconVYisWIC
 7IxWuWZcOhqnykD/ZIGwUYqxjMVYIqQRsQZRV3dZMp48qknq6SKwpCfdUiy/knRVx1KP
 fRQov2omUOnr3KQU5waYafXNZIYQ6jABRmGZXBQ3VuDmLsxLNojCml6T7UxDfWiyAC9i
 UCxVcME0XpDTDtycEXJh/Sff7l3U6NYcyclfH/8WAHEqFEmfqAfoJ4OwRtzske0Ho7fx
 BNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728911489;
 s=strato-dkim-0002; d=strato.com;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=x1Qjpspgumz3VePVNJKzrHQe41GIS6QOcZEIs3MBhOg=;
 b=CIlOUKwxWf8NUbeuG+u9jlEB4YbJnVtjJLx2Fawt2BWyma9VHeCWtcYkSniCAbmOQl
 xbBtRac3iquzcGF/xY//J593HYr4ObfIlZqYJLowazPt20NEd69VKTB+qQkp2KdKK26x
 PLkyVUpY60rVlMshx0fzljpas5zAcVozhyUr44M3yQfCoqArZn5DWCzYtO87i3UN9x7i
 YO+4BRapx+CaYJa/41Zuq5JE4bkQpUU/MbAMftOIYEAaEaIek5nR8pvKP+OMn+ykjtND
 GV72ZxAPrQ+RIaNaQwHxNVvzTZ9uD8tHvAFAF1jXxSmx97wK7OxGYSFNQCYNRv93g+QG
 QCig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728911489;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=x1Qjpspgumz3VePVNJKzrHQe41GIS6QOcZEIs3MBhOg=;
 b=JjribVjJR5Rshr3DNwzGE1nSepomeSCC4k/xuvB1o5hLRpJRJGlPEUzCz47O2keqOy
 jQqckjgKxQvF9d2srVmLg4EOBaj+SdVvqsA+csr0JYiV+o42HeDjJdKC5YmJRWEGtRFr
 /hPd/GgQas3K4QZ7mD+LuY5WVbvR3QMIgTOpTG+xaovhSJfxn3R+71rLqBDmwPW9Byrw
 +SmKvPF5ZHEPjEam7toNtcCLuzviKhLzq8igbu700V1EMu5bNspqBub+suTVmnQD+QXW
 RXi+05nObrAa3qW9BVpPgMfDbU7BSWqcfbO+kyutTdQnPPFRjOwVRLKRjZpMyazBpNJS
 vhQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728911489;
 s=strato-dkim-0003; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=x1Qjpspgumz3VePVNJKzrHQe41GIS6QOcZEIs3MBhOg=;
 b=UxzzAx7Psbzzt3T9ENpW2YG/P/ebdoOtnjLk0Ih2wnZsq6pAhJRfSn+y9uBSEU7Pno
 njiO68YE3IviSnVQ7qCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7Vpmys3mVCXrTP7vRMbGZpP32uUiO4WGM3yoRXUc="
Received: from smtpclient.apple by smtp.strato.de (RZmta 51.2.8 AUTH)
 with ESMTPSA id e0da1a09EDBS3rK
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 14 Oct 2024 15:11:28 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: [PATCHES] drm/radeon issues
Date: Mon, 14 Oct 2024 15:11:16 +0200
Message-Id: <87F47F04-EBAC-48D6-AD0A-4BBE39DF43CE@xenosoft.de>
References: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
In-Reply-To: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailer: iPhone Mail (22A3370)
X-Mailman-Approved-At: Tue, 15 Oct 2024 08:08:24 +0000
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

On 14 October 2024 at 3:00pm, Alex Deucher <alexdeucher@gmail.com> wrote:

Can whoever wrote this send it out as a proper patch?

Alex

Patch source: https://lists.freedesktop.org/archives/dri-devel/2024-October/=
473314.html=

