Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5CEE784AC
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 13:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC3010E2B6;
	Mon,  2 Oct 2023 13:02:24 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACDB10E287;
 Mon,  2 Oct 2023 10:58:16 +0000 (UTC)
Date: Mon, 2 Oct 2023 12:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1696244294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SIaU2SlajoANn1BXd4v4it917t2DAcZ+U6il8gtD5Q=;
 b=S2R3Q5R32gY31z6sRRUxKA2N8vf5LTAnYIJV0X0L8zPg24jY3/tqfGXePwXrFryfItHaLg
 CON5Ex9mjFI63MKJJEAP3+Tj+sdeRr33Rytjq+OakzJOvJsLdhHGw3sxtsNx9oriFvS3s9
 JM/uN/huHbRcc3FrbFSWV8bjWJYVNKsWagB48Gk25IDD8O17D1YLFZnne8bILzlAr5DOnG
 c7HyydIel8foQWvAm6lJxNcBoLZm19cJUsICId8C0bd2C4Hy0tSh1rgB49vIoOqUR+yohB
 WCvyyFw+oj1TV6dLRgZ1cTDjliWynqxYYQRaX9qgAH/qkjcuxZYvHJxhkoyzTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1696244294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SIaU2SlajoANn1BXd4v4it917t2DAcZ+U6il8gtD5Q=;
 b=Hf6JfRzjS4oa2tJ7CqaS3/mAd8t2+1YKnsXRzjrtpz7j5GZ46ZjAouQx919LqeiyHD94zn
 0qPD6qLDxwtoe5Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/display: Remove migrate-disable and move
 memory allocation.
Message-ID: <20231002105813.NrEGqSCY@linutronix.de>
References: <20230921141516.520471-1-bigeasy@linutronix.de>
 <8be685cb-f44a-1143-60ec-d1073fda8e16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8be685cb-f44a-1143-60ec-d1073fda8e16@gmail.com>
X-Mailman-Approved-At: Mon, 02 Oct 2023 13:02:22 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-22 07:33:26 [+0200], Christian K=C3=B6nig wrote:
> Am 21.09.23 um 16:15 schrieb Sebastian Andrzej Siewior:
> > Hi,
> >=20
> > I stumbled uppon the amdgpu driver via a bugzilla report. The actual fix
> > is #4 + #5 and the rest was made while looking at the code.
>=20
> Oh, yes please :)
>=20
> Rodrigo and I have been trying to sort those things out previously, but
> that's Sisyphean work.
>=20
> In general the DC team needs to judge, but of hand it looks good to me.

Any way to get this merged? There was no reply from the DC team=E2=80=A6 No
reply from the person breaking it either. The bugzilla reporter stated
that it solves his trouble. He didn't report anything new ;)

> Christian.

Sebastian
