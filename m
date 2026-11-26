Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F469606A32C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xv6NgdYJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50E4112431;
	Thu, 26 Nov 2026 13:48:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB771122D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795689695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTXpIfLZ2+j1ow8NmZB6JM/DU4spl29LunD6FR84AzA=;
 b=Xv6NgdYJNl4EH1DzKAF+Z8SVTsfFT74WwhR6Pcsq+y0YXBVzLprPdmVX+sVruwI3sNJZEO
 uxjUJw1SbjFSlpEsoLHcSspVdxNutMcmdBZL8TZ458bRLR6xMHqoyNktJeci2HyoKHJbqZ
 uV9FF1uCMVSxcHtJIcN3TbHpsaxMA+E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-lMvtIMLzPdyH0WJF2oslow-1; Thu, 26 Nov 2026 10:41:33 +0000
X-MC-Unique: lMvtIMLzPdyH0WJF2oslow-1
X-Mimecast-MFC-AGG-ID: lMvtIMLzPdyH0WJF2oslow_1795689692
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c4d34d6082fso519507966b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 02:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795689692; x=1796294492;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTXpIfLZ2+j1ow8NmZB6JM/DU4spl29LunD6FR84AzA=;
 b=CM5kdYPv00jcer7zCsQ4GuHZZIXcT7DzHN506Dgx3BmmFIy04NSohivxY2Uj69UeSz
 rbywVq+18nzyYalpbiJKwCfs6qzmQf2Q0dqMKGlrcCf6zGbE0OpIvYcnmFbT4a0KJ2bd
 0w6FUaMJ+2EyoJhH7vVj9g1SN6cvOqhEhLGOYXjdyO62UFe8/rSZogV00wEHRHHilA75
 m7Fcov9ycr6QS2vrtaeoVR7xSXx4gBdJeq0uQNAi9b0lF0srOBb9VrYu3ZmEd4CIq5Yw
 KR6ow7J0fXqDjqsfsouF1wib7isqVdpTJXMC6Jjp6hJwlCBhD3X8TjJx8EC/7uuVGK91
 Rz4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGXmNa9/1TD2hCzOkv0q2NanxpR1jQ2UjsjY/Hba1k6CnFgg3m2PBYdENAZ73+tQIsC9MsrtD9e@lists.freedesktop.org
X-Gm-Message-State: APuU4Z83VNR8LlafNufG/RNxgszZ4L4cj44DT/3GB76K6B5Qed+UHfJF
 MjHd9h3xJTGFzNDTYz5dUT51vYZaCP+2Z313k2bmlli6Xnpwm4B9iotqgT0mhq7a9IahX6+z6hZ
 G42Vf0T+O9iS+umKG2IBzxK3LB9/PT4RxyDxFfHQEv6SChkdq6Sy8ylVMOb56DRRkYDWGQ33+sG
 xst3PS5ZmjlPdACj3ZYOWf++mLzMqT+n4u8U0VUanulA==
X-Gm-Gg: AZFdTZeWeMYhVbUa3KWBAxOcWjMRjzmYbjm7jB/nBjXKy/b/dczHAsYeWizpqLf1cgy
 39y8oBbEna0AATnY2YDDU/tF+43I1/aueRd11SzSfIANZx4eywuFmX6bWMJ94P49mAn4/dpLD2t
 iZJsWiRC+FwqjfnqITXygohe5qI7YdpaTL5DL3dJC7TqBGuz5H8C3e8A==
X-Received: by 2002:a17:907:6ea9:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c513a3a6598mr1792624166b.1.1795689692538; 
 Thu, 26 Nov 2026 02:41:32 -0800 (PST)
X-Received: by 2002:a17:907:6ea9:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c513a3a6598mr1792622666b.1.1795689692194; Thu, 26 Nov 2026
 02:41:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119054917.184758-2-ltao@redhat.com>
 <85438483-9843-4b14-b3eb-57a074275911@amd.com>
In-Reply-To: <85438483-9843-4b14-b3eb-57a074275911@amd.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 26 Nov 2026 23:40:54 +1300
X-Gm-Features: Aa3M54qXSxe4Tv3kJZhv4-GTyuCU96H140dAQ2Bw9YC_NOs4WSOucEjet7OYzYQ
Message-ID: <CAO7dBbV5Baw5SRCNCys21u0NwJ2CCJWu2Av9wzGUHUmMxaE0bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix pdev lifetime in
 dm_test_conn_init_ctx_alloc()
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com, 
 ivan.lipski@amd.com, george.zhang@amd.com, adrian.betschart@cinemaone.ch, 
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CSv-Qr8n-Hc_H1AaSYDxslLT4_MQJB8ZT-jAzvqs4j8_1795689692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:48:49 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chen-Yu,

On Wed, Nov 25, 2026 at 11:31=E2=80=AFPM Chen, Chen-Yu <Chen-Yu.Chen@amd.co=
m> wrote:
>
>
> > Fix this by allocating pdev with kzalloc() and freeing it through
> > the device release callback. This ensures pdev's lifetime is managed
> > solely by the kobject.
>
> Hi Tao,
>
> Thanks for the report.
>
> The lifetime problem in dm_test_conn_init_ctx_alloc() is real, but it has
> already been addressed in amd-staging-drm-next by commit 370bab028b38
> ("drm/amd/display: Add more connector KUnit tests"). That commit allocate=
s
> pdev with devm_kzalloc() on the device and registers the unregister actio=
n
> with devm_add_action_or_reset(), so devres releases the i2c adapter befor=
e
> pdev is freed.

Thanks for the info, I didn't notice the issue has already been fixed.

>
> Your patch no longer applies to the current tree for that reason. Could y=
ou
> please rebase it onto the latest amd-staging-drm-next and confirm whether=
 the
> issue still reproduces?

I tested the latest amd-staging-drm-next, the use-after-free issue
doesn't reproduce, so my patch is no longer needed. Thanks again for
your review and comments!

Thanks,
Tao Liu

>
> Thanks,
> Chenyu
>

