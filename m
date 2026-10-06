Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC91CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 17:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14B810E811;
	Tue,  6 Oct 2026 17:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cv2PdGP6";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598AC89207
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 17:51:33 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6afb0d2a586so1875433a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791309092; x=1791913892; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AeKo+tCwWM+g/8PcvSIlM1LfD29KvUBtvbtFvUjy6ck=;
 b=Cv2PdGP6wz5Ilu8NQdVab1QKHekg6LTJmpqRuVMXMqQMl+mvCebvhCOkdpyRO9FjwK
 /TkxlglGlDulMn2vzSQu68DNIv9Ujar3kLfvsF6L+06EP1xwjJg1HVZnHRQlAW7aKxTT
 9VOU9gFlFga2GjhrztsH3wcVBB5F46bzYYRPHNm8W4E9eegE9ZsVCocFY2OoTH/VAJOK
 vpeFXQLzzhlg9K0gq09cwnpzrQUOqLhYPUuQe9ZG5Zdaiy9rNBb8k0N7A+YdeR6CEkoS
 25//qbTuBEkv39nIXpDnRfhCdagybb2Y9TeKmV8xvwa3Bq+dpGQ2IPiVyQyQBwTIGnJt
 HNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791309092; x=1791913892;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AeKo+tCwWM+g/8PcvSIlM1LfD29KvUBtvbtFvUjy6ck=;
 b=eCk3ha5p6WxzPDmraQK78ya8vL9jekrOm4V8zhkWletZSXEXIr88dWztPbsE5bzlVM
 DEoOSpqiqDidEReIFRWRgTk4gGguIpVI78XuCT1+mJ41eCgkRK+bPOenXLDQ15M076n7
 dqpTlxsVm5gJZsxtN0AoTk0wyyYLuTOVNZS2lToJiSV2qwv4fBuBcNlB3kEdC/6hj/ym
 HPai9Nhzl6EO8qSI24PGvdPcX7qFlskDAfLLVKhDljwFug75MXiU+DCyGbwH1eWtmerz
 QWu6QW4nXhEEFJwyM3AuM9UWjZnwxPU1WT/KacMsnvpZY3QOYW7bZTS2qIE/M0ASQ64t
 0h7g==
X-Gm-Message-State: AFq9FYLAODxTQNNdfHrbwCX7YsGwSPk5PSk7nzaSjZ29VIPgv8t+eZjk
 7TrrcUlautvkZ3z5vtCn8RQDk62y/4BihYQeJDDJlr+3UNfs+Ii4a0ff
X-Gm-Gg: AYBFou026+GRjZOC/EPa/CUCh4zxM0t/udZ/OI6g+x6VozehjMrdRJynANSaZ6yR8yv
 wd6/Wf/2HQARlgbgiFVxYvWf3PwdI4KWvNIc74FPCMrlN+GGYamE3QEGZPOdEtXFBl8bmhUn3pi
 HFvZiHQKVVEicgX8FMVqie87B9L2ZqlxHlFugvk9jkFINhfQYy+2rMJKNutBFO0/dewwSi9l/cN
 1Gzu4L5QOw46yJxrIb9x3hlFWIC1T4qIqZgEotQuXACS69P6IkGdfi6so4Vs9Wd3CQeOThEqLRB
 T1K0ej4R4UMgqv8H7lhQexJCw/8vGdUcvpzGbXhXD4tiDCx8dNTZZ//1K/PCnUroS6Hz8y8u7Dg
 OHiBvST97oxF8SfFITLJbFkZYa/0Im/HLWikZU5uLXuWpHgMNURn5g268XSVv9gWZ+XX/V0zdUo
 aFfVQLg7kJS2IsklpPQzkxDfqjXeCqSt7nU6ynQVSHWJgrkTlwPgPkcQi9HnHcqwR5ztYo8WjHm
 bpsT2WgKb/IpzKbXCWDHkTXxs/Ysn6OCIHNZanTiWAs3u5j
X-Received: by 2002:a05:6402:42c9:b0:6a7:ee55:dcc9 with SMTP id
 4fb4d7f45d1cf-6afe29db759mr2299515a12.24.1791309091564; 
 Tue, 06 Oct 2026 10:51:31 -0700 (PDT)
Received: from timur-hyperion.localnet (86FF63C5.dsl.pool.telekom.hu.
 [134.255.99.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6afb0211013sm5049079a12.27.2026.10.06.10.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:51:30 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com,
 christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/8] drm/amdgpu: add amdgpu_vm_pt_leaves() v3
Date: Tue, 06 Oct 2026 19:51:27 +0200
Message-ID: <8sm4C_zRRSWvGVYa3WR82Q@gmail.com>
In-Reply-To: <20260930133315.12270-3-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
 <20260930133315.12270-3-christian.koenig@amd.com>
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

On Wednesday, September 30, 2026 3:33:09=E2=80=AFPM Central European Summer=
 Time=20
Christian K=C3=B6nig wrote:
> Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
> on page faults.
>=20
> The idea is to only update the leave PDEs/PTEs to let them point to the
> dummy page.
>=20
> v2: fix of by one, rework the function to work correctly on PTB as well.
> v3: use NUM_LEVELS, don't overwrite vm->last_update
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Hi Christian,

I just tested this again and this patch still regresses retry faults.
Please fix.

Thanks,
Timur




