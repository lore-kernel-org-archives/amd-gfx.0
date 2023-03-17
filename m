Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E39C74A5B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0472210EF60;
	Fri, 17 Mar 2023 17:43:43 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059B010EF54
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:43:06 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id h8so23347758ede.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1679074984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juFDL1t+0yx3APjFMS4e9m1CxbDK324iou62xX9HrZ0=;
 b=DFZzzPAyJAYvlD6woenrhLCRDHe10jh8cepP5HhgW+UKoO5b+2qIguQu5fLCDcRFvC
 pCDIPRn3ETZSZOqEwPgPx0YbzzegbeuxWus8PUEAF56hn0AKm9AQgGfVTPYtXBiH0K6b
 Y5ATjCAbYgY+QxopJgiP9gxDyOIEMRrPf3V6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679074984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juFDL1t+0yx3APjFMS4e9m1CxbDK324iou62xX9HrZ0=;
 b=XUztcSjeISVGHI1cbFYQhVYhP/JTf06qlm7WblhEIqzejkGnuh8kaDoMdHO5TJGawA
 nxEUIK6Ki4plmh1k7+y7dbpZc4ELH2dmHhVB1M6jsYHwdfCrXXW9LshQZ+SMpMa7iIpp
 i2P/qrBtShkwVTXKqzC/Rn1ROTI00GzxX9/wUf4v/c6oWB1SLd+VlNMMzftntNe1aElp
 Yut9TONF3TOFDoE7vpe8UoSGUY6ovT3Zn9mNhvIBVtaE2Fows5QA7YALxudq7W1K2K9t
 ko6k8X36Wq0zlld8O+I85mHoksbOFpD26dN14IHcELqdUqyF7AptD7wrxAiMsgLpUYKB
 iaDQ==
X-Gm-Message-State: AO0yUKVmMbDnG85kYUXqsQle3sHBSv2nwyrUrNVVo+HVtc+FnqiWJuhD
 8Yn3bhszJvNk2srFPlgUdD2BnpH3qDLXyyH9tKwGKw==
X-Google-Smtp-Source: AK7set8xRlWBUVvn7xW9POUDSF5IyAxWCQr6aSqRXDj9zy1+PT6gOoLFLXQ5OIB7vrsJQTdd524cIA==
X-Received: by 2002:a05:6402:1b0e:b0:4fc:8642:ce56 with SMTP id
 by14-20020a0564021b0e00b004fc8642ce56mr3898820edb.25.1679074984426; 
 Fri, 17 Mar 2023 10:43:04 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 m10-20020a50998a000000b004e48f8df7e2sm1361149edb.72.2023.03.17.10.42.55
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Mar 2023 10:42:58 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id er8so11653539edb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 10:42:55 -0700 (PDT)
X-Received: by 2002:a50:ce54:0:b0:4fa:794a:c0cc with SMTP id
 k20-20020a50ce54000000b004fa794ac0ccmr2222273edj.2.1679074975032; Fri, 17 Mar
 2023 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230307212223.7e49384a@gandalf.local.home>
 <20230307212615.7a099103@gandalf.local.home>
 <b919b550-6da8-f9f0-a0eb-0fd8af513817@amd.com>
 <20230308074333.49546088@gandalf.local.home>
 <980021d5-09f7-9fc3-2726-44884a57822f@gmail.com>
 <CAM0jSHPf5u4=GGWm6x-zVkLA_LScAxq371ny2NoozuNjHfQefQ@mail.gmail.com>
 <2b7fe203-82f5-2726-cd64-01c7421560d3@amd.com>
 <20230315162011.351d0f71@gandalf.local.home>
 <20230315202133.7cb1a0fe@gandalf.local.home>
 <20230315202242.581c67bf@gandalf.local.home>
In-Reply-To: <20230315202242.581c67bf@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Mar 2023 10:42:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH83GOhjDaVnTUYfSf0XOLp-jpFACLSd8Uc59GzaCZug@mail.gmail.com>
Message-ID: <CAHk-=wjH83GOhjDaVnTUYfSf0XOLp-jpFACLSd8Uc59GzaCZug@mail.gmail.com>
Subject: Re: [Intel-gfx] [BUG 6.3-rc1] Bad lock in ttm_bo_delayed_delete()
To: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 17 Mar 2023 17:43:40 +0000
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
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-gfx@lists.freedesktop.org, Matthew Auld <matthew.william.auld@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 15, 2023 at 5:22=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> I hope that this gets in by -rc3, as I want to start basing my next branc=
h
> on that tag.

My tree should have it now as commit c00133a9e87e ("drm/ttm: drop
extra ttm_bo_put in ttm_bo_cleanup_refs").

                Linus
