Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D865EB64DD
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Jul 2023 21:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A65110E08F;
	Sun, 16 Jul 2023 21:01:57 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D3E10E08F
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Jul 2023 21:01:56 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-403b0e4a567so10641141cf.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Jul 2023 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689541314; x=1690146114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7GA2pIxc3tCMB97REJHMJ4sl/a9xHf+iGcJZUZdRHA=;
 b=g3nLrD0/bVrmh0+FICTCDKq50fXeZdg2UUxsaZUaD0YMSIq8o5xjXAzAptw3fa3pwq
 ZMgexubM9e19RLxnPmvSfJG95vF1SQByINLrbnTddsrMIlIN+tgk7Vddxha7JgtFDpiz
 Tfocq+6/sfnSP7NqcmEK2Nv4DPPPgE7FogE5+JiGde6eMgL1N3pXthZJEQufpnKVVHWY
 nOkYL+fqt0w0c1QwbbDVVQuaNuY8clN90zHicLmTPEKJrQchul7B4IfrkrrHSV8lHdDm
 xSqoAcGzTy145TLVfu83GAqvSfrlxC5mdcgbgg3f6gUchFxMdLEhxqUXtqd4vcHT3EpN
 jhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689541314; x=1690146114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C7GA2pIxc3tCMB97REJHMJ4sl/a9xHf+iGcJZUZdRHA=;
 b=jet18rdTrfuZL0w128691uSDqguFNo2bVt3/zjC6p+XAL7Uf8h/dbt2fqy8dN5FD85
 9x0CVQ3j+VqWGkMaMBC/P2qVew71wPTfKxJroPNFQ0nrMeHlO+1+ugmzfHWyzf6ZXhtO
 46p6Z/gsCH9c6CMVPF6PLWyj4k6JdxTAIiqRxeH9y4CZEB9DHh5qyTDFdL2ZhzZPrcqy
 EyPRdwYTwYSL4iwLfkd3LtC+Z8KbnMfbr3RFR/xb96KiFJ3KRN6TEUeJJceeptKh2ghy
 Y7mU/N04Pnk/iDBLHb57BlKMccSR49ENZ62FFE6tPuskfMQ/Qi3HW2BYrIH1En3MvJLU
 EQ9g==
X-Gm-Message-State: ABy/qLaA2f6SXGqShlZXqLlwN5iDMmB3GYr3TjmUpL0s20CbqpKrCUQZ
 Tc7hnD1aOqBbm+wccJ9tbch2RhLet/JR/Oywr8M=
X-Google-Smtp-Source: APBJJlFnTwF5qzx8wDrMYT4xJMAfUAlb8oqK6X3ZnQMBeJaEl9CjyIA8mG9k1/s1Erhlg9HEchSVwkRe67p3a0bM9wI=
X-Received: by 2002:a05:6214:2301:b0:635:dfe1:c1f2 with SMTP id
 gc1-20020a056214230100b00635dfe1c1f2mr2424990qvb.0.1689541313639; Sun, 16 Jul
 2023 14:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN3LS2mvXOe5g8WFC=b3N=bF1u4RCQYJN-u+k=ZEWWrcA@mail.gmail.com>
 <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
 <CABXGCsN1cnGgMn=Jg6nYfg1GccZhPX8sa=izrr9sMxZdzLiTJg@mail.gmail.com>
 <DM5PR12MB246926D9E7812B792B12446CF134A@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246926D9E7812B792B12446CF134A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 17 Jul 2023 02:01:42 +0500
Message-ID: <CABXGCsN3hH0eKgep6KqTfT0VYvdv10XT8Z15ca1yZ427Eg-4jw@mail.gmail.com>
Subject: Re: [regression][6.5] KASAN: slab-out-of-bounds in
 amdgpu_vm_pt_create+0x555/0x670 [amdgpu] on Radeon 7900XTX
To: "Chen, Guchun" <Guchun.Chen@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 14, 2023 at 4:09=E2=80=AFPM Chen, Guchun <Guchun.Chen@amd.com> =
wrote:
>
> Thanks for your patience on this, Mike. I think https://patchwork.freedes=
ktop.org/patch/547592/ can help this, please take a try.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Thanks it looks good. I spent the whole weekend with these patches on
top of 3f01e9fed845 and didn't notice any regressions.

--=20
Best Regards,
Mike Gavrilov.
