Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD0C61DB4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 09:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E3610E9B8;
	Tue, 25 Aug 2026 09:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="THa/xoPT";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650C510E9B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 09:56:24 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b14so6079895a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787651783; x=1788256583; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uoi80Db9vBcfNT5Ou3KpRnF7uuGPAOhdW1NF2x80eQs=;
 b=THa/xoPTy6HHD1MhK+o8+5k7iommO66CurVkiF75yANjGOO0MJHnsgqhMXpAzVSEj0
 7wlMK3QZOvJlgIaIHiXq2VP5EDcmY9qLBeEsnhcCNIdWH7NqD9DS3WbtnHc8I0Pn7PLI
 4oqNlIUTpnFFAHyiQK3YtJkUoYzyWEWWZ9bzWDrA8BKZQXAeg1S2FPqonLee0MCdGl5e
 ISF/S2iH4xYCbcil7TpVS1I9zUlRpWHGSRA8r0tjbLnONCioOr4kx37ZrqHUv+hYNocP
 sBi/nr35BxRwgDuUAgv866FpT9z/CSGueQlbI9tYgJINpVG8ceCcseA63M83L2DZRKnv
 rzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787651783; x=1788256583;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uoi80Db9vBcfNT5Ou3KpRnF7uuGPAOhdW1NF2x80eQs=;
 b=Kx8x1o2bOsevIT0ADULDtg6c+fxV4g7z3K+xqFt+x/75neBpXsCRvQAJq/Ti+RlAZG
 jYjA3CJmCSOGpbLdCCo6xlJP65XDW7zv6W2C4DJW4SeAzGia4NwDldwravOelrGCA96I
 /Rq+eucRMU402Rcja9QKfOcqhPODIuel/nAp6wFwZ7P+9N4qkhkzDkI0qhlZuu2Nsv05
 UGQC2DEcnjJiRfkl6EAKX4p/S2nk+bNlpWmy2mEILqxwC4e0Bl32YJR3kALwXijNl8m/
 ceXxqxcxaaJEB8Kiq6R3xBidb6eNNgKYiYqv1rSFiKAyavV/CrZiKRWdJUo9h69fAbvm
 jG8Q==
X-Gm-Message-State: AFuF++m9iS0NuP8qhibkvadcV4cL3Uaf3M8Ig8fZ9crMlEOrxUVCkhlQ
 TvSCBewBY5akZ9/1GrmWZc3kBNj7XT2FMUl2HQTRfPcQjUTB//5m8rCP
X-Gm-Gg: AR+sD11xBu7xRgu5djPMEm4KUMhl9+nhDPEgIpkRsunzuD+hrQ7rnpg7ZkTms/wP77A
 sT7urA0jDsOJ97bqVR1tQGk3CNlV96ZKhQt8VcEV2owy6q/FuHop7jP+UcB3gbUluE8his+7SGy
 63QWtdKZ8T6/Kb48e3WPfOW7x669i4Yy6bTS6NLGX31v84kyCGPjjWLylLulWtpK7rdEJT7a2d6
 Csh9+xRwm+QvgA86Qv9oQ37tbt5Sis9MpgGDQie9PzOjxiFDTczsf8qdcLrZ4TeU7I+1wOhtphC
 IhpZNdi65DnJm0Y3jUPQvgZwYXhcImaFUW4GBWJi7Tvh+acbR7DpfEhd4V7vjyxWAxUzqFpzXVP
 ZV6AijbMUtNeIAiCxy1Gj5Th0b6twlcdVF6meL4PRBMqJYj/r6kTXh9m22xui7P1cObonFz9Mzp
 oMBa51Zg35ML0uFRFOQuQcQAwCnIsVIt+Tn0Z5/azn4+uakEbGi8ZITwYtw3Q8y2N4wnMxw+lDO
 yTKNB2JylBXWZQTj0kR5chZYW9+KcyjSLZNBoWIrplpf1gk7ViiJVgxVMxsSskrHjdLdoCLTeVI
 9Q==
X-Received: by 2002:a05:6402:241a:b0:698:b6c8:70db with SMTP id
 4fb4d7f45d1cf-6a582b3c303mr29935159a12.8.1787651782490; 
 Tue, 25 Aug 2026 02:56:22 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EA4800ECF4467CC1E5F29B.dsl.pool.telekom.hu.
 [2001:4c4e:24ea:4800:ecf4:467c:c1e5:f29b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5d6499c0csm715796a12.25.2026.08.25.02.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 02:56:21 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Six, Lancelot" <Lancelot.Six@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [RFC PATCH 0/3] drm/amdgpu: Render-node second-level trap handler
Date: Tue, 25 Aug 2026 11:56:20 +0200
Message-ID: <_gzIcchSSDubFCS_oRiqLA@gmail.com>
In-Reply-To: <IA0PR12MB8208C05799E5FC8AFBE2664A90AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <fVqQkdSNQqGMlqwq2rRIgQ@gmail.com>
 <IA0PR12MB8208C05799E5FC8AFBE2664A90AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
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

On 2026. augusztus 25., kedd 6:59:43 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=A1r=
i id=C5=91 SHANMUGAM,=20
SRINIVASAN wrote:
>=20
>=20
> Hi Timur,
>=20
> Thanks for the feedback.
>=20
> This series focuses on compute user queues first.
> The UAPI is designed to allow kernel and graphics queue
> support to be added later as a follow-up.
>=20
> Best regards,
> Srini

Hi Srini,

I'm sorry but this is not acceptable to us and not what we asked for.

If you could please take care of what Natalie suggested, that would also=20
enable the feature to be used with user queues.

I would not like to agree on new uAPI without being able to test it and=20
provide feedback to make sure this is usable. We can't test this series or=
=20
provide feedback without kernel queue support. Also, user queues are curren=
tly=20
not usable on any GPU so we couldn't even test it even if we supported user=
=20
queues.

Best regards,
Timur



