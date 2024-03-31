Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65350C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B91310FB7C;
	Tue,  2 Apr 2024 08:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=msys.ch header.i=@msys.ch header.b="MhDXmoaE";
	dkim-atps=neutral
X-Greylist: delayed 328 seconds by postgrey-1.36 at gabe;
 Sun, 31 Mar 2024 16:53:26 UTC
Received: from mx.msys.ch (hq.msys.ch [46.175.8.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A546710EC6B;
 Sun, 31 Mar 2024 16:53:26 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msys.ch; s=dkim;
 t=1711903675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaN+o+c6PopybeUgoomEUf/7EPalUAG6zQAbhrx7NpU=;
 b=MhDXmoaEPeUrgIT+8/JBR485GwX7FWwF4cRfth/ZeMYkzyYw14tK+w4HXP65bB+Dws9uC8
 zKt1nABzvkTCtGS8uV2hbixfT5QNARywXej4AvW26XoPPes74NPNln9Ek7EyauEX5zrzoY
 cAZZ12BHyGMb4gE+sJZr111hW1o/a4w=
Authentication-Results: mx.msys.ch;
	auth=pass smtp.mailfrom=marc@msys.ch
Content-Transfer-Encoding: quoted-printable
From: Marc Balmer <marc@msys.ch>
Mime-Version: 1.0
Subject: Re: 2024 X.Org Foundation Membership deadline for voting in the
 election
Date: Sun, 31 Mar 2024 18:47:43 +0200
Message-Id: <0A85708F-4DEA-4967-B135-9C1FCB2BDB41@msys.ch>
References: <0a816356c382e4377953bba256e1275c779b220d.camel@igalia.com>
Cc: events@lists.x.org, xorg-devel@lists.x.org,
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 libre-soc-dev@lists.libre-soc.org, elections@x.org, members@x.org,
 xorg@lists.freedesktop.org
In-Reply-To: <0a816356c382e4377953bba256e1275c779b220d.camel@igalia.com>
To: Ricardo Garcia <rgarcia@igalia.com>
X-Spamd-Bar: --
X-Mailman-Approved-At: Tue, 02 Apr 2024 08:51:16 +0000
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

How often will you send this spam again?

> Am 31.03.2024 um 18:46 schrieb Ricardo Garcia <rgarcia@igalia.com>:
>=20
> =EF=BB=BFThis is a reminder that the membership renewal period ends in 2 d=
ays,
> and elections will start after that. Please register as an X.Org
> Foundation member to be able to vote in the upcoming elections. Thanks!
>=20
> -Ricardo Garcia, on behalf of the X.Org elections committee.
>=20
>> On Tue, 2024-03-26 at 11:42 -0400, Christopher Michael wrote:
>> The 2024 X.Org Foundation membership renewal period has been extended
>> one additional week and elections will start the following week on 01
>> April 2024.
>>=20
>> Please note that only current members can vote in the upcoming election,
>> and that the deadline for new memberships or renewals to vote in the
>> upcoming election is 01 April 2024 at 23:59 UTC.
>>=20
>> If you are interested in joining the X.Org Foundation or in renewing
>> your membership, please visit the membership system site at:
>> https://members.x.org/
>>=20
>> Christopher Michael, on behalf of the X.Org elections committee
>>=20
>>=20
>>=20
>=20

