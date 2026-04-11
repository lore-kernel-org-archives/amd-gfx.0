Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A514EF3ED67
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2026 21:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AF010E23E;
	Sat, 11 Apr 2026 21:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="kTjBpvwH";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8969B10E23E
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2026 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1775943815;
 bh=vmpFuUIG85JrzAzHHnfcjONHPOLAxmZrrDlLw5twBxM=;
 b=kTjBpvwHk4ntDYPZ9UlyjrY7qwKh2DpX2f3rbRBMguWHlO0zUZzXABvXVCC63xC7SEVtLVy+D
 AhEfmticCcENGofQIRxppIGIG1AWCDuffoJKZja1mzBU89gKs0uNMlRB9RJnv+8l4ugwBAb5soC
 g90U5NM74ptF01nlSKALLHuBObvN23+0VwV811KEJ4rnKKhVOX4PA+nGTWKAmWWT7CHdZIbqW8X
 9UmgsH8oqTTjhiXtRlepY0l/woRTsDAZ1IoEixawdOsFvpBP4KcgtGgvdlmZsJws5HKC5Uyn70n
 XAiOTqm9pDkko+s0vNit06THzqT67FX41gP8eZmKgOzQ==
X-Forward-Email-ID: 69dac0849feda6061ba31b18
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.7.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Sat, 11 Apr 2026 17:43:30 -0400
Message-Id: <DHQNJFNTJ4QC.1A3ZZZLF39N0Z@ubuntu.com>
Cc: <amd-gfx@lists.freedesktop.org>, "Dan Carpenter" <error27@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clear cached EDID pointer after
 drm_edid_free()
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Alex Deucher"
 <alexander.deucher@amd.com>
X-Mailer: aerc 0.20.0
References: <20260411160539.2305517-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260411160539.2305517-1-srinivasan.shanmugam@amd.com>
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

On Sat Apr 11, 2026 at 12:05 PM EDT, Srinivasan Shanmugam wrote:
> The driver stores EDID in amdgpu_connector->edid and uses it as a cache.
>
> amdgpu_connector_get_edid() checks this pointer. If it is not NULL, it
> assumes EDID is already present and does not read it again.
>
> In some detect paths, the driver frees the EDID using drm_edid_free(),
> but does not set the pointer to NULL. Because of this, the pointer still
> looks valid even though the memory is already freed.
>
> Later, when amdgpu_connector_get_edid() is called, it returns early and
> does not read a new EDID. This can lead to using a freed pointer.
>
> Fix this by setting amdgpu_connector->edid =3D NULL after drm_edid_free()=
.
>
> This makes sure the driver reads a fresh EDID and does not use invalid
> memory.
>
> Fixes: 289479173fb5 ("drm/amdgpu/amdgpu_connectors: remove amdgpu_connect=
or_free_edid")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Joshua Peisach <jpeisach@ubuntu.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---

Thank you so much!

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
