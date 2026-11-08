Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56A606A320
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=D68bcTxb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F5910E4BE;
	Sun,  8 Nov 2026 15:02:43 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4659D10E118
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 09:15:58 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-372bdb942dbso2053eec.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794129358; x=1794734158; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8omgzCyD7VFzEverpSEwRPa7kgr/SLHtu8LlPuCGKek=;
 b=D68bcTxbVU/Qce1FZ1mrmhzCmZC75YxyaO0O6krvMPBZ9nkq8w8wf7giMtpn+xMB/x
 ec0EY6pFNpY9a0zT1CGPJxUbc0BY0AQxVoKU28kheQU8yCer4fDJ2QmytQLzlFXCrD2+
 P0ARNeDKAMYmPdsvEyCrI61P+9WUv3HxTB418=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794129358; x=1794734158;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8omgzCyD7VFzEverpSEwRPa7kgr/SLHtu8LlPuCGKek=;
 b=UUR2G0lU5HiZpq4K1/rSVN+ijICgOQPfoh0DW9v8AjUn7ZB9bQq+c5pNn+9ibjvQ0F
 uETA1t+XS3ABU8LfekgyRGx1S1xPWvesg/qjT3p1lq5V9lkuJEqLLqYPuJZvVq/jL9Lr
 ftsrmvrRskbG80DKXJ0xdwUcNStIGyvwwk3/S9FPvFSsgKobWwnGkCG1hRjBteQV1FQN
 NtfuCV7N4CSH4SYGL3h0FzvIhAhn2LO/m5AiQlNFdu/1/7Vz17kV8tC4+f7CwlQ9sTU0
 +v6ac2HPe+cQYokVrsjkHTGfeSvUa6v4bEaR2NM7jOG8X5ULX8TAspDhcAfje/eY6f4l
 KGiA==
X-Gm-Message-State: APuU4Z8L9bwUqS7YEfvO7FYmJVJAiisUc8V7b+dJ7QJNXkfu8YhfLDHE
 Tfo0gcK9FgjZanFmssFcLzZ946O9XqkDGop81073aHj8YDMRHsVdaF9iXQUcX4Ck2Ps=
X-Gm-Gg: AYBFou29YzRdqnyDlvrsXfEH33mZ9K86UF7v9b/fcTI3VzvylXuGkguFdK9G/q/yaM2
 sfEpaxirl7gZ2azI/F7L0PEg9eYO5r1nHE/7vZwjuGjFCCCNHpv7fHnJapbm3AMsK5qGC2d3qAd
 PK7u2zXa9q/HqfK8hCGEwR1GswRyVgL+oJQTI6xflRuNpSeh1uJMRMg/0wFCXbnOHK7v+Os7gl4
 ckBK7P/r7nuc70t770Rd41W7y8AuZYmyX8uNSnuwEEzLwobu1+pljCgO1xdN2J1ak7jpDrY+Uxt
 pnS4M1EEF8B3TaubCmfYW+GppQezk2nADsdYaLzQd9IOAEkzkP0xTXpluhEyQwh+44u8Iv8O/cd
 +eCISDkvs2slzer2R3Kt1+BemzE/jviP1o67XnynWmTo8M7PywCton/PKJHV0pgk7h2MpG8ZUKf
 SyIjaMvyJAzRKUOprIkUaDzvZOyA6sXGumFdjJM2bq1/Kbrtx3JqoSWwOP5hOOd2HP7VRzC3hX7
 Z7ulXwGSX98Ur3myEljPz2vDfz7aY6FcpfWPDRb+RZtckBt3zkxUK6cwtJTKWqK/A9bfWU9ySur
 CskGfspCV5KTAEmZ0sggqDZ2MvE6H4gyj7qEcBPHrfpsle+Fm3LANjNvxtDQwBvLcQzUuerkb4G
 lFC6Entc4vPQ=
X-Received: by 2002:a05:693c:6009:b0:36a:43d9:f2a5 with SMTP id
 5a478bee46e88-372576c22c7mr2293561eec.32.1794129357942; 
 Sun, 08 Nov 2026 01:15:57 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265a179c1sm3728933eec.11.2026.11.08.01.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 01:15:57 -0800 (PST)
Date: Sun, 8 Nov 2026 18:12:40 +0900
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
Message-ID: <avA9ACE9ar1MEdtD@rock-5b-plus>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:02:42 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 02:56:59PM +0000, Tvrtko Ursulin wrote:
> @@ -139,7 +141,10 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>  	entity->guilty = guilty;
>  	entity->last_user = current->group_leader;
>  	entity->num_sched_list = num_sched_list;
> -	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
> +	if (num_sched_list == 1)
> +		entity->sched = sched_list[0];
> +	else
> +		entity->sched_list = sched_list;

This breaks rocket. rocket_job_open() passes a kmalloc'ed array of
rdev->num_cores schedulers, and rocket_job_close() does
kfree(entity->sched_list). With only one core bound when the file is
opened (e.g. the other cores probe later), the union now holds
&rdev->cores[0].sched, so close kfree()s a pointer into the devm
allocation. Before this patch it was kfree(NULL) (and the array leaked).

I can send a rocket fix that keeps its own pointer to the array and
frees that instead, so it can go in before this patch, unless you'd
rather carry it in this series.

Thanks,
Sidong
