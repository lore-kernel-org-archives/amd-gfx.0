Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D569BC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468AB10E30A;
	Mon, 24 Mar 2025 19:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rz/Lyscl";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C8710E30A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:32:28 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2240d930f13so9021155ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742844748; x=1743449548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uB/TK8BvD6LratAathzpQs8n2P+b0B/FTqYYY6aAmmM=;
 b=Rz/LysclXzWm4iuCbppHO5T2GhCduH8grJukxo7+zuBcDgoYBf1ioipbHDdeq0Jsbw
 5O6mvH+t60yZMf7XenR94FLUV9lfyukeFrMw9ksHNKFG7OGbnxj/5Rkw2O1b5hAnmfs7
 D8dKne3JGp8JHcSnhLnGhOA9ZXU97C7tFy0Pd3C6enl/736a2C3El7JMDnuSpDbabeRk
 42oV+jnit3GvEkOm99ybzGxRqsxHfMtWZuaDws0qtxzYcM1ei5dmJpaBqASVisjJtBel
 6nsnsO6SKLcRE/mZy5xrGAVl6T9f5NC9NaxocW66rSerLoiRodXkX46f6d9N/qkf0A5t
 dFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844748; x=1743449548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uB/TK8BvD6LratAathzpQs8n2P+b0B/FTqYYY6aAmmM=;
 b=kSpQNaBC1a/1SAxtOzqXuaj9P6opcR4KOAlSo3Vj27/u1gaCKOksqypIiZmMTSrhAs
 kpd12hjecD886tGd6paNA1Ud+f96Vmjp373WdZn/C9M0H+GIxaWlR/gZamGAs7W+nRh3
 lPQEtcUt3Apmwyl3MJ0lg9zi08m+ysY8F+wskGIZWHcCkZyCXdf8JBE5fnx6OIUYecvb
 qaEe6Y8sFEUv0Ggtb4bCIDoMGsuAKc3gXjzco/O6Je7UxzOtXHoZZ6lE+GH/ynST87ev
 8+daNtOTQQT74eaY0RFNY1tFactD8EqfaJhFq5sXtzyUqsLoABNHLnUscdiTyxHc6vUR
 RvEA==
X-Gm-Message-State: AOJu0YyFxUdgMsO8T3MyJ4d4RMrfLlxvIMi57JHkjRqtHF4QnUoEmmUe
 dGYwccyHgeyfGrgGPQ/F3O/zqH2I/5Q8MzHF7o6RD25+giYGzhFYvYqJO7HnwcjWPYKob/E0yFX
 YApbdVlkzilY7L2tpWyDIUbpDUh4/GQ==
X-Gm-Gg: ASbGncslxsolbAkYBiUcjM8PiSWaDZbczl3dpe3Qccgc7r5m7hVsd2nD45sZhkplh3i
 Cz49FHxUjFgqfZ9NygmQ7crFaPhDluMZmL36gI1rvynkmxELZ4Yi77Bpl+MrPgciYbCDgAReUSn
 yY10LGvxVue3NjnB9cMJRf6Y6YlA==
X-Google-Smtp-Source: AGHT+IEY2lBROg1TBeUE3i9FyPZeZtrucjX0FwOfH7n59og1m7u2gUjTIhVxXYrHX41V/MxAulOoSL7R9lPRC1byKF8=
X-Received: by 2002:a17:902:ccca:b0:223:5732:9e4f with SMTP id
 d9443c01a7336-22780e15573mr94389455ad.12.1742844748312; Mon, 24 Mar 2025
 12:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250324172540.128507-1-jinhuieric.huang@amd.com>
In-Reply-To: <20250324172540.128507-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:32:16 -0400
X-Gm-Features: AQ5f1JpaYG9hcmToEwvyV00TWB__wZz_0LOAegqHjywF5yyVhJB-x9Msu9y1Vbw
Message-ID: <CADnq5_OKVowRi_ivnE4O0NDPLCW3RTq4LKM-1M86hUnDcbB8fQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: increase max number of queues per process
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com
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

On Mon, Mar 24, 2025 at 1:26=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.co=
m> wrote:
>
> kfdtest KFDQMTest.OverSubscribeCpQueues with multiple
> gpu mode fails on gfx v9.4.3+NPS4+CPX which has 64 gpu
> nodes, the queues created are 65x64=3D4160, but the number
> 1024 0f KFD_MAX_NUM_OF_QUEUES_PER_PROCESS is not enough
> and test fails at function find_available_queue_slot().
> So increasing the nubmer will make the test passed.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index f6aedf69c644..054a78207ffe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -94,7 +94,7 @@
>         ((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), GFP_KERN=
EL))
>
>  #define KFD_MAX_NUM_OF_PROCESSES 512
> -#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
> +#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 4160

Doesn't this limit have more to do with the number of doorbells you
can fit into a 4K page?  If you only allocate 4K for doorbells how can
you increase this?

Alex

>
>  /*
>   * Size of the per-process TBA+TMA buffer: 2 pages
> --
> 2.34.1
>
