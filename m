Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AC0C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 15:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAB810E5E1;
	Mon, 24 Aug 2026 15:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JidSNZyy";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386D310E5E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 15:07:45 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so8366586a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787584063; x=1788188863; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8v2/DaCI9UvXB/CcYza0w+uM4IOo6hAq4Iz9PwHN7mY=;
 b=JidSNZyyAolyIVLI1aTf3l9G+26bayQzKpXu8N/787DkfVJRmJO5FEfNt1kkU3dDJG
 ucBSBfeB9v1X8AkauOEZJY8R91porWpuDqHnhQTmNp5F0Rjb8phzERAPgie5aXirFgHs
 jwTNAXP6XQg8b1WyVCSS9aIQlLWzr6/8vfEi5RpFt0+XiuxE1UkJqtgapi3OUUMcOesh
 JsOEvxcJXf570M/kQyJMNrUEX/pwCCxFRucjy2TpWsFUFmJ1oJDwvQ1YXb3YcEIDFPkN
 AhqO7PsmV7QD7xB6VBaM7wZ1On7OiIhUt+x14S56cnZ6zpN6zUg1DFa33TodYdH+12bM
 A2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584063; x=1788188863;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8v2/DaCI9UvXB/CcYza0w+uM4IOo6hAq4Iz9PwHN7mY=;
 b=nQ7XOZ39FjxIgAamEX4pM+nXayYH7fhSlspw0x8ZPsAZnv8wN1QcF472es9RRYxtmd
 9iz1WcrsbghY7d+WDSaYvKvX2xA+9QivbMp5jdx0eqCEVkOzz8xc718SOArErz+MH33K
 ifcKTYkThFdBcJ6XuK06q07TA/XQDV2X7JjxcWb6zr03PEKLynniA0eYAhTBkUi/zV70
 4Ybhb1DKTi230WJpf2BzxfE7XXcI4t+nrfATZ1/5oARDEaEzVQ0alK6GfTTYXRni2ed7
 p8Q/GwGKGAGOaom47Bh8f2gdu80LVzR3hK3hTc7zS5rVAb6eAa90mtVFU+AeIeQeya6J
 gVCw==
X-Gm-Message-State: AFuF++meozypbEMpX8jS0dzdsG9lJRs1Z8XtYwXhA4MESxFy2QPVh3im
 K+aepubyt2mOKEARiIJMHzpHJZufrNMRBgzs/3nTgl8cEc0Wb7NGQt81rp2E8A==
X-Gm-Gg: AR+sD12wPKmFbKPM6x1qOxHldY/ugMNOfCSpDKDxaZ4q5f/rfUZNgsG7kEHK9YnmxwG
 2r59zaGOtQH62gBsU4Jx7jMgvNY6hEtyB0oyp0S47JZT5+4Um+/iUyQTRspheqOq/XfBthpxcDN
 ysPga0VE6dYRWrbgZwr3kJmDe3yxrh2sniKFUI+UUTCpv98iCNN0IMe0omQtU7uIoWxv83FQMLM
 MBLwNgyEikOTgYNieulN6YbKHYV+EnpgEECLOWj/JZbsOHFt6UJyemsrRPCw/9DXUK9f4LkpoMm
 E3wLbVY0y3MpUc0HnlLu6s+vGx1tx+68F/Vr+UknDu54A6RSqVGd1/K7mOPUWwOKtkjlvkG+NNL
 OFSTb660TgAPunqi3RB26PFw7F6rLcEST2WcABOJkWrT1sTtc5lGc5fEWpyYjK1MjmK7vnvSVgL
 1/HsDsnqLyQXyn0WziY3tddeCVF7Ssj/S3QjtjvrgBpOxOukaQXsuMPq0wkHnJBWwksbxsAwn2X
 KszX8EzxZ1nnbqYRhN3OqPzuajlKDhNVmOT
X-Received: by 2002:a17:907:ea8a:b0:c21:3c4e:cb9d with SMTP id
 a640c23a62f3a-c244d7e3862mr2899250566b.14.1787584063179; 
 Mon, 24 Aug 2026 08:07:43 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B960C.dsl.pool.telekom.hu.
 [94.27.150.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24d6f203acsm279822566b.24.2026.08.24.08.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:07:42 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Petr Belyaev <upcfrost@gmail.com>
Cc: alexander.deucher@amd.com, Petr Belyaev <upcfrost@gmail.com>
Subject: Re: [PATCH] drm/amd/pm/smu7: Don't send VddC_Request on CI
Date: Mon, 24 Aug 2026 17:07:41 +0200
Message-ID: <GoS-FsT8QACGf_8gWuUlnQ@gmail.com>
In-Reply-To: <20260824144714.182835-1-upcfrost@gmail.com>
References: <20260824144714.182835-1-upcfrost@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, August 24, 2026 4:47:14=E2=80=AFPM Central European Summer Time =
Petr=20
Belyaev wrote:
> smu7_upload_dpm_level_enable_mask() calls
> smu7_apply_minimum_dce_voltage_request() unconditionally, which sends
> PPSMC_MSG_VddC_Request to the SMC. CI SMC firmware does not implement
> that message: it is only defined in smu7_ppsmc.h, tonga_ppsmc.h and
> fiji_ppsmc.h, and there is no CI equivalent. The SMC therefore never
> writes SMC_RESP, PHM_WAIT_FIELD_UNEQUAL() spins until it gives up, and
> every call burns the full ~1.9s response timeout.

Hi,

I'm sorry but this is wrong.
I added the VDDC request specifically to solve an issue with a Bonaire GPU.
That system will boot into a black screen without requesting a high enough=
=20
voltage for the display engine. This patch would regress that.

>=20
> Nothing downstream notices, because ci_send_msg_to_smc() returns 0
> regardless of the outcome. The only effects are the delay and
>=20
>   amdgpu: failed to send message 15f ret is 0
>=20
> in dmesg. On a Radeon R7 260X (BONAIRE, 1002:6658) this is 40 messages
> per boot: 32 during the boot-time modeset, which becomes ~59s of blank
> screen, and 8 more on every DPMS wake, adding ~15s before the display
> comes back.

How do you reproduce this issue, and on which kernel version?
I've tested this patch on two different Bonaire chips and a Hawaii chip, an=
d=20
haven't seen this error message. In fact I am running an R9 390X right now =
and=20
I don't see this error message in my logs.

>=20
> Commit 0138610c1413 ("drm/amd/pm/smu7: Fix SMU7 voltage dependency on
> display clock") extended this feature to CI, which the previous
> implementation had deliberately excluded -- the old call site was
> guarded by pp_table_version =3D=3D PP_TABLE_V1 with an adjacent comment
> reading "TO DO for v0 iceland and Ci". That commit was verified on a
> Radeon R9 M380, which is VI, so the CI path went untested.

The CI path definitely did not go untested.
R9 M380 is Bonaire (it's in an old iMac).
You can see all the details here:
https://gitlab.freedesktop.org/drm/amd/-/work_items/3425#note_3338643

Best regards,
Timur


