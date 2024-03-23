Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C102C47DD9
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Mar 2024 14:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E0510E058;
	Sun, 24 Mar 2024 14:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mfrEyhHM";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B4C10E541
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Mar 2024 14:52:58 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-69629b4ae2bso26633056d6.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Mar 2024 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711205577; x=1711810377;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PQy0LgbNRS2IUlbgbrbirFDizWSucGasGxIZDrnu8QQ=;
 b=mfrEyhHMk2ojiwFiBd0KfwefIhiSc+2mfbA1yD+TnwWNP16E1qJYNa+ht0fTD+BKUv
 2pisD68T7Az/OTr1s7ZWnsRHKNPl/gsZzvGYO9tpQR/o+XO0a2XZYwAD9WaoiG3Loohj
 Kl+xG0jADd3atlbu349O6myW4Bd1ggd9bnoJdUW2E1cigPTflAEwY8oVlCbHHen1zDg/
 oZhlPead63vw1b2fwen1klRu7lnCRfCWQIRfHeDXZ1CPbksifgl1c7uEmA1s/zg7oBp8
 YXEAFVV6DvxGjKTfBvsyw34Ie9Qnv61AKaKu7CSFgYmDPYmKuPOjbZTbTFkd22ZhOHxW
 pI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711205577; x=1711810377;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PQy0LgbNRS2IUlbgbrbirFDizWSucGasGxIZDrnu8QQ=;
 b=CgQWBHoQCQJT0oUJMsSRYgrvh8e5FCsTr5V+ajPX5skTaLNqL+zRngw1zDVPQ4QMlY
 m/mLbuzkYWbkYqbBStUxgYSqeBOUAStWXLtUqPLXLm/I5fKQrE2xlANsDVv/7WTb/h8Z
 oW94J9u648rzR9ejXbOKoJtrKvCIHK7+X/QyMy8M1RSGG/DeUchoe1ZZycRXud9IfQG9
 4Z2Yvwuc65/dSTDFHdCC8HAf8aWAs7WyPlMLbvhfbxYxNKTHy3rdnaRWgBiTJQEadMUd
 oAVm0Qths3gJaZcOkjLDRPCEP62qgY86v4PU6ApOGh95p1iG/1e+Xof6LeftnCccHshA
 BKAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmQP3mFmhwZTecgionJGuFRs0+mjXvbtI5VraZwu+wrmYi42La13sGHCfbTfgHqjG6BBIB6OEUo6dqDjYIumoJK35yRpmSfYOQfuH0Sg==
X-Gm-Message-State: AOJu0YySacxkjOG3syiVp6yleVatMOkaN36kgAGJ3krSA3BTAX9nJnu5
 YVLPvQVcERn7yRlDOvlXSmqdIZ5pF6/0KD+JSlN/fGsilN0H7mEKrugFaK2D4UA=
X-Google-Smtp-Source: AGHT+IFLG11WgqsbhoxFVFpmyCIi7a1JxwIH7NvINLJUVPYcY+qqhDilTzhgQ5CdvjOQ3ISsPU74LQ==
X-Received: by 2002:a05:6214:4017:b0:696:8505:1947 with SMTP id
 kd23-20020a056214401700b0069685051947mr20765qvb.30.1711205577232; 
 Sat, 23 Mar 2024 07:52:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a05621419e100b006968077890csm298604qvc.118.2024.03.23.07.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 07:52:56 -0700 (PDT)
Date: Sat, 23 Mar 2024 10:52:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix deadlock while reading mqd from debugfs
Message-ID: <20240323145247.GC448621@cmpxchg.org>
References: <20240307221609.7651-1-hannes@cmpxchg.org>
 <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>
 <20240314170948.GA581298@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314170948.GA581298@cmpxchg.org>
X-Mailman-Approved-At: Sun, 24 Mar 2024 14:17:26 +0000
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

On Thu, Mar 14, 2024 at 01:09:57PM -0400, Johannes Weiner wrote:
> Hello,
> 
> On Fri, Mar 08, 2024 at 12:32:33PM +0100, Christian König wrote:
> > Am 07.03.24 um 23:07 schrieb Johannes Weiner:
> > > Lastly I went with an open loop instead of a memcpy() as I wasn't
> > > sure if that memory is safe to address a byte at at time.
> 
> Shashank pointed out to me in private that byte access would indeed be
> safe. However, after actually trying it it won't work because memcpy()
> doesn't play nice with mqd being volatile:
> 
> /home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c: In function 'amdgpu_debugfs_mqd_read':
> /home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:550:22: warning: passing argument 1 of '__builtin_dynamic_object_size' discards 'volatil' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   550 |         memcpy(kbuf, mqd, ring->mqd_size);
> 
> So I would propose leaving the patch as-is. Shashank, does that sound
> good to you?

Friendly ping :)

Shashank, is your Reviewed-by still good for this patch, given the
above?

Thanks
