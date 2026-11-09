Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEE606D837
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=apT/I5X8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D182B10F33E;
	Mon,  9 Nov 2026 14:09:37 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F93910E55E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 01:49:57 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso555079eec.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 17:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794188997; x=1794793797; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bWqnOxZVfuZbyPbSFQZbitavJOjkRpGgRKNzw8RjBj0=;
 b=apT/I5X81PobcQkp+6uut9Y158YtfT9/VhNe6ZviYO64xwduQRoQME9Fzq88R0wMfd
 5CKeIA1zfA2TBRsGnB0DyjiGVMxuEOXn77QOu6Haaye2Z1SivOzK7OHbnOvDWZbfWbof
 +1QeyUR9Ok04GuTbGoBZRL43jctVMZVSRlBEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794188997; x=1794793797;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bWqnOxZVfuZbyPbSFQZbitavJOjkRpGgRKNzw8RjBj0=;
 b=1c7uNmSyJoyqda/R9fOU/1zMvprzIBrhS8SJ+PtGC0OQ1qjTq0Sky0qwGsXsVBwcFa
 i2HqVcZGCgCkF3mzu3MhMmk9nwDY/eGYZPMcFk1W6ZwA6uBa9Q6LnO6YPsJKJ4G4UG6l
 FAsO5Ubql2TGyPrYxxLA1QtGqdqtDekQGAGiVjL4XKQwFdRokPvWgN36CnPSiT6IcfAW
 n0LpKu4PZOVez4wqiTKkwYJYLFxBe+dSFonHHyF70D2wJJrI8q8tITZQN0+j9p2V/8PW
 gM61tk4x6LIDdbKK/oScraPhdvBn13tCE5lh3rNGqJ497yGlgO+YX+qFzA9PQN/hQXMN
 9gGw==
X-Gm-Message-State: APuU4Z/3yHUgIm5q5ZO4QIdDVQQ4xpYK42EXlJGEFJdmjdDD+JT2TqzP
 +RHCvPXU+cfFnd7N2RFtvoiJb/m4ZkIuiRNB84EZ9Gytx6pg6yp/prTyjiOFrm+uU18=
X-Gm-Gg: AYBFou1//Ip1te74dKwUp/LgnX/oqIABlIueWZFMh1J6ssUlkUVIkVejeq2X19joaW0
 BB8QkbHk3KgxwVPcaP+dVZuE0iXJjAZVZ5PO4zK6Pxsif5wZJcseEcbrBn1FCbWeG8n4brMukSp
 6Rl0+cv6NNySuwTCN+UCmiPilB6SDsB0CCASbjuv44raFSaqgsSdEBccNMd6BO3GeTZxKX6cQBq
 4Dyk2lisPUundYDNyfSFSz/vIgExGw5KOtfso+rvNWB7ZF6oKK7Xpc68taHEXlIxUoFt3L46yez
 6/V+38lEf5f7n/f/vYkbbTER8/q5N/DSg8/YPdO/o1wPDTsteob1lAkD41X8n6kqmptrm/Ar1eI
 zNRtGv9k17v/CCfXs7yf6XybYlHhjIFrqmSugTK2XTBIUsEADJZoENf+bsuTydjrgphqMXN/HWc
 g9Z957ECzB2NslikowK0uHmSghOC5duL3obmIYqqJE7hG2V7dW3/YRihJr5yrBxHZC23lzuBdVV
 VZQWLMt+AwQFyEa7lbcM7hZqfQNF1pKtYcyrOleq9kCl+5AgzTcrjOnt8Bfy87lh9wY65cn40OI
 7Jgg+hyRBxrxyB7PN55D1HoQVkKkTLu4OWGflUdc1L9k1t0lbE9OjE51vCyuYAdn7ljXb1O6Ygl
 kTbE/4jlPf0tr
X-Received: by 2002:a05:7300:b296:b0:36e:dd5:fb08 with SMTP id
 5a478bee46e88-3725670f4famr5119010eec.40.1794188996697; 
 Sun, 08 Nov 2026 17:49:56 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372631df629sm8829844eec.1.2026.11.08.17.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:49:56 -0800 (PST)
Date: Mon, 9 Nov 2026 10:49:46 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: Re: [PATCH 4/7] drm/sched: Remove the single scheduler special case
Message-ID: <avEmpPCAQJhoId6M@rock-5b-plus>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
 <avA9ACE9ar1MEdtD@rock-5b-plus>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avA9ACE9ar1MEdtD@rock-5b-plus>
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:09:35 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 06:12:40PM +0900, Sidong Yang wrote:
> This breaks rocket.

Sorry, please disregard this. I was looking at an older tree. In
drm-misc-next rocket already keeps its own pointer to the array since
91c7da1f42ca ("drm/rocket: Keep scheduler allocation in
rocket_file_priv"), so this patch is fine for rocket.

Thanks,
Sidong
