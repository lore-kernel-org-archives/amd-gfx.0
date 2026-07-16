Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835C4C44515
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 16:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171AC10E39B;
	Thu, 16 Jul 2026 16:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7Gjtsas";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E83C10F38E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 16:11:18 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca6bda96134so427033a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 09:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784218278; cv=none;
 d=google.com; s=arc-20260327;
 b=rx18/Uu1UFoqhHzSm9PR4477Q2LlSs5Vg4094/7XkF6qLrOyH6LjYHKOgRnQiHfEAL
 WFjLrN5r8t1JQ1YZHHkugwKUKkZxTDToPwpeql9ENGRMOqeFtGTbn/hSZX2QqGjSrFiu
 kECpxo5g3U0wC8gKRYs6x2C1/Br8mhLA990TYIwUQiV663rV+BL4TsTHFJyPlu7hSw6W
 3jm+RfyevWyDTxa61scrAWG5a0PJ1Rg6ApvXcyCWYa+/lbT3vIhUlQgHCWqdyuvEuURV
 Pd5H1YzE+J+LvXW6ubIr/fDXgAypdT4Sy7aiaXZFj5zcIn2qMMdeCvCJVLnze18Gi1si
 A6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eLm2bOZWqjEYnV7dD449x3+Yq/PgK0wDYTfRlxo/O0o=;
 fh=aw/8YpNNo8pQldfHtLTi4JFuH/4zlzkVW0l27pIEJRY=;
 b=YQq6TAmPDktV58FSSsw7zBqd9MsXxXTxmLwKXbPXAwUXjMjbDp7n8kGGR6/6JdLufR
 zE4kBuBrfJUAZ2Ua6PWeDhUtH9Mymdx6/lYZOpoASD2hMesMN8K1OoAUVs2QxIXPFW/g
 jZ8cq7JEDIhFwwk3OITkmTRLW9BpY2HEog9doOObkp+pp7e54L51YXU157N3uXFZ/f7h
 0+Wlw/PQYsjkLNzZhGx908lIplIbTtvT1RJ0o8611CdzHAoaASSf28nuD5WvoJIbs8qO
 tWmJSfOkibvzg+NTiLkV0mRyiZ9QpGTwmZS0/sMxJJmX5mcTTQNyWooASjAZHzV+iwRO
 ZI7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784218278; x=1784823078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eLm2bOZWqjEYnV7dD449x3+Yq/PgK0wDYTfRlxo/O0o=;
 b=i7GjtsasEVHXAiTvD9l09ncRS7r0VabQq3sTXt5uZUpz1Zam+FLJU1HmBDhmuGdqxF
 LPPM404TtR1U0vQZDlxN5Iuw9FzWwChRnJlIfTN/2Qax3YhUfXnt2pRknReB24jhsGDd
 1FxcYHmLOAEePa6BANsslsCYKxf8qQcOQ5hBEPFO9luYXXBh0L2GB9Atm2sxFMOtgPWf
 /RFqoudZvxp5HT9vklVBh83sj4pQ89Z4DD6w9uVQvDPi8XteT23gr8ZBrkqI2nwQjDu2
 fnp4VWlIsuIwcvzgrRD75ULEy0hBjWqO6EeaexDU+bOCGI2veEE3f/3EPT5fjeVwVwCn
 vaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784218278; x=1784823078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eLm2bOZWqjEYnV7dD449x3+Yq/PgK0wDYTfRlxo/O0o=;
 b=KTXeGiOeSp2xatNz0OFRYL3bQO2UaHcfwqwI5JLi1o8WCGX8EickLXq+8Tp9O65FFT
 /lLHjqZoyzaKdohKejZWeyoH/BRZR0P1o5cmkjeQt0/XFEf+GdQbJHvu0J0v2OJnPBrs
 IE47K+xUfh5mIMNEzzFh+ucnMtjbJIOrhZ1tOdH6ohUF8lRpOHXY/SDvW1uSvL2VyT33
 YqLPnqS6MUPKXOT+xW7KJYO7yFkAOzOBKHp2GWqdnRLoYy9mNsjbT7fQfYsATfB9bktQ
 zBtXMXSA0vpBa7OdKIf4K5KuyTIf/hiN7wURkL57IukdBXOdeP733jjIX7XCOhIq7YwU
 E5OQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDYcSUMoQi4UVwVwRbl9NmaqY9gVmQ0EZ8z3X0/u5P4PRIY8Po1iNIYtFSL+WkFe8ILIptOvtT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfI19vj+ERBOvvz7c/3zZxsammDdXJRwDwCG6YCB4Y0B3pSNKX
 p4cxIX3bOb7fbhlDRlGaiWIjFyvNEQuXWn+F9AaIxlzO6KuxGwDSul3FEnYD3lLGdwTld4sBvv/
 bzuFAcSiIq9OFG3xGmZyjZFyXMpqkrJU=
X-Gm-Gg: AfdE7clDAyjhfSrDHU+BCTwSoAOGBPQqOg3hhLWZE/T7pdiXXXiT6dM4JGnbNzj9SrL
 l8Bxs8sEHf59gdnjHAAOY2hTUNfRQ4g53Db4ySi36Fms88FWl8pke5Zy25LScLbsdy7bwhdZsun
 6oRLqGOSUhE6e0LdyXaegEMJHTJaiV9Q1y+55YKoYt76K351wcXB9Hc5RGcN+49b1wqfqydMPYs
 7vvVp7YaLEKD+1ibAZ9P15heTL621x8uE0vqbCge0sSW8vN5bQ3pHUfVp89Hrxmg6W2nJ1if95+
 nn9SsejrYU8lCCw9DF0G0QInilLUp1JMJbry3pEPSfPLHUGdorHCFXdZ/K4=
X-Received: by 2002:a17:902:e5ce:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2ce9e7a4c64mr180753675ad.2.1784218277889; Thu, 16 Jul 2026
 09:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 12:11:04 -0400
X-Gm-Features: AUfX_mwpV9nceUpdksSMUnO3amGImY2nFdKROBe010Q00qs__8qWk0A1WhefVcA
Message-ID: <CADnq5_OUy6LqBZioxrp2aVh9mGTrFQmY=MKF68VdBUbnq591ew@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] drm/amdgpu: Wire GPU events into EVENTFD
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 15, 2026 at 10:39=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This series wires GPU events into the render-node EVENTFD
> notification infrastructure.
>
> It builds on the render-node EVENTFD infrastructure by adding
> notification producers for USERQ_EOP, QUEUE_RESET, and GPU_RESET
> events.
>
> QUEUE_RESET notifications are generated from the common
> queue-specific reset helper, while device-level reset accounting
> and DRM wedged-event notification remain in the top-level
> recovery paths.
>
> Patches
> =3D=3D=3D=3D=3D=3D=3D
>
>   1. drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
>   2. drm/amdgpu/userq: properly account for resets with user queues
>   3. drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
>   4. drm/amdgpu: Signal GPU_RESET EVENTFD notifications
>
> Changes since v4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Rebased on the latest user queue reset handling changes.
> - Reworked the QUEUE_RESET producer to reuse the common
>   queue-specific reset helper.
> - Kept device-level reset accounting and DRM wedged-event
>   notification in the top-level recovery paths.
>
> Only compilation tested.
>
> Alex Deucher (1):
>   drm/amdgpu: properly account for resets with user queues
>
> Srinivasan Shanmugam (3):
>   drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
>   drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
>   drm/amdgpu: Signal GPU_RESET EVENTFD notifications
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 51 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 61 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 77 +++++++++++++------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 17 +++-
>  5 files changed, 173 insertions(+), 34 deletions(-)
>
> --
> 2.34.1
>
