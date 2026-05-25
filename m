Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634E4CD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 14:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFAE10E390;
	Mon, 25 May 2026 14:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="FhuKyB5M";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B773E10E390
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779717779;
 bh=0AOOOODDwHLhbDpO3b4ZhlOhN5J9lXlep6sAJmmQS70=;
 b=FhuKyB5M9ZcfGyedULDTlu2WXuIc+v1wg23wNwR4uYzAv46MkwAdgwxnYGMPSWtCmUuNf2XLu
 qWuMX/+rHKhpwn0eerQy6V94KeMB05SoCHG8jVtxl417crJ7i3EOmmrELCVGXGvPI5xGPYuaewT
 lQNCL05MX1oogiPQDf1563l7forQi+rnkSR1JcfDt9QvEO+55tdu/qPT2sKWzTpa4zxp6m2hLzE
 t0CuAAaqUNcHDds4xEI4awCYwtpaO+5isbixcyTGcI0uVGdJR8LdHf0CXZfFBO9JJouom8TcLyp
 RxEP+3RIcafENjdAfaixcDGCFD0QK18CBUeItPm/yQzA==
X-Forward-Email-ID: 6a14569101aeff7cf0a81c05
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 25 May 2026 10:02:56 -0400
Message-Id: <DIRTAROC6FYC.1K2JNELNUZA4F@ubuntu.com>
Cc: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Francis, David" <David.Francis@amd.com>, "Joshua Peisach"
 <jpeisach@ubuntu.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260521132854.1016622-1-David.Francis@amd.com>
 <DIOE7AZKC8F4.2NUZMXFHO4L0W@ubuntu.com>
 <SA1PR12MB81440D5E84BC4342650FA831EF0A2@SA1PR12MB8144.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB81440D5E84BC4342650FA831EF0A2@SA1PR12MB8144.namprd12.prod.outlook.com>
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

On Mon May 25, 2026 at 9:56 AM EDT, David Francis wrote:
>> This may be a dumb question, but the use of the * means "restore_id" is
>> dereferenced. If the conditions are evaluated, either will result in
>> restore_id being dereferenced, even if both conditions are false. Then
>> can *restore_id still be safely dereferenced in the idr_alloc call?
>
> restore_id is a normal pointer to an int. Dereferencing it should have no=
 side effects.
> So this is perfectly safe
>
> David Francis
>

Ok. (I tested this myself too with a simple C program).

And I see above the condition is a check for p->signal_page, so:

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>

> ________________________________________
> From: Joshua Peisach <jpeisach@ubuntu.com>
> Sent: Thursday, May 21, 2026 9:35 AM
> To: Francis, David; amd-gfx@lists.freedesktop.org
> Cc: amd-gfx
> Subject: Re: [PATCH] drm/amdkfd: Check bounds in allocate_event_notificat=
ion_slot
>
> On Thu May 21, 2026 at 9:28 AM EDT, David Francis wrote:
>> The valid event ids go from 0 to signal_mapped_size / 8
>> (usually 256).
>>
>> allocate_event_notification_slot has an option to specify
>> an event id to allocate at, used by CRIU. We weren't checking
>> the bounds on that value.
>>
>> Check them.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_events.c
>> index e9be798c0a2b..5a4fe68a7986 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct k=
fd_process *p,
>>       }
>>
>>       if (restore_id) {
>> +             if (*restore_id < 0 || *restore_id >=3D p->signal_mapped_s=
ize / 8)
>> +                     return -EINVAL;
>> +
>>               id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_=
id + 1,
>>                               GFP_KERNEL);
>>       } else {
>
> This may be a dumb question, but the use of the * means "restore_id" is
> dereferenced. If the conditions are evaluated, either will result in
> restore_id being dereferenced, even if both conditions are false. Then
> can *restore_id still be safely dereferenced in the idr_alloc call?

