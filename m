Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7E6CD4F3D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 13:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0608810E515;
	Thu, 21 May 2026 13:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="YsiG0bFL";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A4A10E515
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779370514;
 bh=nBXvH65bSDvTzUusVoqYNSv8KKfXMMlUYoFSTBRSyV0=;
 b=YsiG0bFL5BGtfai8CJRK7zTk9mfk1CorgurYrgPRO/BxAVfVElBWOuLpmz3n/mdgVa+2qhsKX
 gJOyBwXTeQ7cvvGwEaYjSZNhUehYb18YvMOvKvGvBfLSHf8rvByHNkjPJpNoaxyKl6I/3urQhzh
 MRE7nW7gRci9e4b0gL6+GkO3rNHhve87sS3+G51rj7TMdLsWb+Q+vXej/qSehXvJNe1NEHiq48r
 H1jBh/2iTUU2t7IznoQyWdoTwxg0ZLMCKeUUHTjDjIUYeOgvNgVa13nSVZMrmN746liJVOnEnPl
 T4FcpaDczP5Te3cL9alE77O+xzKPuZR4HgAzFT6kMqfw==
X-Forward-Email-ID: 6a0f0a0f9736d7b331651bbc
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Thu, 21 May 2026 09:35:08 -0400
Message-Id: <DIOE7AZKC8F4.2NUZMXFHO4L0W@ubuntu.com>
Cc: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "David Francis" <David.Francis@amd.com>, <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260521132854.1016622-1-David.Francis@amd.com>
In-Reply-To: <20260521132854.1016622-1-David.Francis@amd.com>
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

On Thu May 21, 2026 at 9:28 AM EDT, David Francis wrote:
> The valid event ids go from 0 to signal_mapped_size / 8
> (usually 256).
>
> allocate_event_notification_slot has an option to specify
> an event id to allocate at, used by CRIU. We weren't checking
> the bounds on that value.
>
> Check them.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index e9be798c0a2b..5a4fe68a7986 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kf=
d_process *p,
>  	}
> =20
>  	if (restore_id) {
> +		if (*restore_id < 0 || *restore_id >=3D p->signal_mapped_size / 8)
> +			return -EINVAL;
> +
>  		id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
>  				GFP_KERNEL);
>  	} else {

This may be a dumb question, but the use of the * means "restore_id" is
dereferenced. If the conditions are evaluated, either will result in
restore_id being dereferenced, even if both conditions are false. Then
can *restore_id still be safely dereferenced in the idr_alloc call?
