Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A3EC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 02:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2A410E392;
	Tue, 13 Sep 2022 02:04:54 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD3510E392
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 02:04:50 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1278624b7c4so28412472fac.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=SqdajUUHxfJszuNatB9wTIZksNsZ+twsX5WTO1If5gg=;
 b=e1XiBsOAsogmOHwhbjqE33H1po/O6lCuSydiuEpAn3n0Bf1TQ4TKqEpWF7Rafi+aqk
 99ZL0CDqNFwyd1FkU7p7t/GSZquz8uo+HMkWl1Ngz4Swa//A8t2NhwM+Ka7+jwac5F8s
 lDyNR4L+nYMMFMjXvM3tFeNh8Axv5t7wDsMYjg7w5Q7+UE1o6GQ6WVBhW0sQGCCaCfWp
 LiBeEzFUPwf/6wSaYRml/hGQiO+4UnDru1G+M4U+OZBX9IKeiORGEJ85WuOT4U6PzaDC
 J8gncwEEko3Ssg1RGqO8YvXZMq5MDRELVpOE7EIpAyEIsctUgnNc1pmysQ3x3Y7h4oFd
 7Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=SqdajUUHxfJszuNatB9wTIZksNsZ+twsX5WTO1If5gg=;
 b=zP+NDfE4dv+K8sUH62x1Pg90WrCPLUbnUS9xXvH3sWNpxwsHPhVZmOYJX7QzXzHIDq
 9rpItbeI4zcQHz2EW6U7vTFrrArKoXxj1CAMcS6k7MsGp/D+IrG4VYMaDNNwXbJri8VL
 mCxVIY2E416hyo1m3N2t713/K/Qn0fS/wZXA6tUUzsN6AEfLpBj7uHJ7EN0Sq9CycD+0
 a7P+P9pp/5a+ooCLA9s1w2Ff4wA27zxT3Kdu6hBNfAErE+wefcmXN0AtFTzCQmuzFPvH
 OB4Reg8w102hmio/CYWtj7XLZ7nthiWq5VjMwqHJXiLMSJK084MqmzAYSpgctYWL6a8a
 5C1A==
X-Gm-Message-State: ACgBeo3ogXITeUBelvPg0RghACspCQcFCCplPJjvFeIR7GsnRDiJZ8D2
 ny8sUh4ikXvj/DYX/UQBVRsw1e477dST/n4refw=
X-Google-Smtp-Source: AA6agR5jNkE4KVBUAyOW16rqUF2gdt1bI2TA7j9DRF6ab8oo92V5u9W8DQfl9I0kxjZg7fFBjfwZT58UAFzDV+UXBdk=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr747031oae.46.1663034689836; Mon, 12 Sep
 2022 19:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220912123640.20058-1-christian.koenig@amd.com>
In-Reply-To: <20220912123640.20058-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Sep 2022 22:04:38 -0400
Message-ID: <CADnq5_O+--mAHW+3vWkQTKsR-7DCUX2rYcxF=NmDnjZ+kaMzSg@mail.gmail.com>
Subject: Re:
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 12, 2022 at 8:36 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hey Alex,
>
> I've decided to split this patch set into two because we still can't
> figure out where the VCN regressions come from.
>
> Ruijing tested them and confirmed that they don't regress VCN.
>
> Can you and maybe Felix take a look and review them?

Looks good to me.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks,
> Christian.
>
>
