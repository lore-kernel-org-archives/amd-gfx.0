Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53435C001DE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 15:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E421D10E1FC;
	Tue,  8 Aug 2023 15:03:34 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DF210E1C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 15:03:33 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso1306495f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1691507012; x=1692111812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3oM+1JjsUNvxYzfC/psgF3Ty7RKKZPwvhCbylD1OT8=;
 b=A615WQryW0ZNMBRlpDkWu0Qd/ZoDkoQ6QarlLEDF/XiFWE65R+pMaz3tPnFWsYOA4u
 ixX6u6Y5uNbXGY0kRJcOsuh5ALWD26qo24nenZ2HTNOylqMy8uTzW5xqqPjbtmKRvdnx
 8Ch5ijWC980pvKaqTzwXhuI1IfAI9yuu7w5YAAAa9yBoSeUPW+WYYZYn3S7mIWUv/m7F
 DlCS7z+A0pntlUCciyJfMnnNccXdNPdB6kmN9uMPt4BZfGTM5Edig/x2Nitbk1asrc8D
 OU9PjybyMBy1BCY2ajdqHwNKSLqKCWLvhRuSlf0fctGHUIcE3jj8eFYaglP1YlHz1JdH
 rSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691507012; x=1692111812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3oM+1JjsUNvxYzfC/psgF3Ty7RKKZPwvhCbylD1OT8=;
 b=WCmWLY24yXsOmjTd66CtYKSzixqzJa+CCXyVKuY9eqA2JExHbQBkv6tlL+QpLFpK9z
 tYEGcf0oE8nEOQGtMd9Jkj15gIjKR/StLIdAGGtlqZ3X2VcxBmfe39rwAsmF9NoTn5+v
 PJOQf4PAaUFBACi/z1X2F+cDKLz+IKjphAhREVTqnV4H08aeCQ3qUB2X0b9PSPncouaD
 MMQWE9xflD3nES0R+vxR7npPPDuI35qji80M4tyMWPAXQ0Pxb0MRFnVqvyT7XzOwHJx2
 xrvZKi7CiQ1cY44KQU3fap8aY84JmMasLL/yJDKMqUc6dfIWh5X/KgiOaCKKyjLg3Xc9
 xuAA==
X-Gm-Message-State: AOJu0YwQx8snVVo0CEoaHMZNyCSvxiGVY/KcmIdGVubasRJeKz/y6rsn
 9JX48pyPvqf/0oD5r2UTmPXfwP+TFW2F3cTK9Jah/DyxGV+qeCpAp6E=
X-Google-Smtp-Source: AGHT+IHATrbUOuncjqTBT09QEfYdVtsWb8iWTmW64ZtJHT3YehW9WbKGDCrhGse62ObPFOSRBRCUBaPU+RxFgtCb3ig=
X-Received: by 2002:a5d:484b:0:b0:315:998d:6d25 with SMTP id
 n11-20020a5d484b000000b00315998d6d25mr8507875wrs.1.1691507011573; Tue, 08 Aug
 2023 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
 <c6866c85-34ab-7e4d-dbbe-5b21c5b29df2@gmail.com>
In-Reply-To: <c6866c85-34ab-7e4d-dbbe-5b21c5b29df2@gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 8 Aug 2023 16:03:20 +0100
Message-ID: <CAHbf0-HcH-hxtkKXdZnHosnupC-j+gLkNDxn35vf-A6eiDg+ZA@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] drm/amdkfd: ignore crat by default
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 8 Aug 2023 at 15:59, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 08.08.23 um 00:05 schrieb Alex Deucher:
> > We are dropping the IOMMUv2 path, so no need to enable this.
> > It's often buggy on consumer platforms anyway.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Bye ATC, it wasn't really nice with you :)
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the whole s=
eries.
>

Tested-by: Mike Lothian <mike@fireburn.co.uk>
