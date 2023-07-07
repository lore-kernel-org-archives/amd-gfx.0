Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C5EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 22:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAAF10E061;
	Fri,  7 Jul 2023 22:26:44 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08CF10E061
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 22:26:43 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-637aaaf27f1so2600986d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Jul 2023 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688768802; x=1691360802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERPvct9F+gdPXMff8zw9isxkWp5br9C2rmUHZh0fgec=;
 b=YkW+I0EPtZZH1y4qcBZkBcpiYK9+S4n74L7CY2CZ+xZveGNYPzWxMJzISKdIzKQf+c
 Qi1rJySyuwTGziqyT5iCNCNAAu36O79mDh2ocu7kAxXb2YjBvPftnv1vtmBKO1qp03o8
 ZThKoHjNQ4epnJ7sJj1A5SfZx1gqlJKyNz4IDhNHp40CYqTI6Od4Vi0BDH6GgHrPzmHR
 J1MNu/r8x3dX0ZMd7s5jqsdFqM2E5xsBHIamMCFl8FxDEyRDk1ICP6o2IdA0Gl5v2o1F
 otEoICtnek/eVZ2iGL/G4y22bwJBiclJ7rxQytZVRXtkE9F9YqthFgAFfjQp8FCPCyMg
 NLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688768802; x=1691360802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERPvct9F+gdPXMff8zw9isxkWp5br9C2rmUHZh0fgec=;
 b=K20TjQRjiODXr3K7fsqdSH4cSKGUEaKRxgGWU+aFkQ8Dqx9ZcOKKp64kI5qMHgtfq7
 YiAXXV2NE3M7DUYuSOvH0n2CZJiqvLUJ58wMVXFqxXMUnFtzABdHSYEYAuU8S4896P/9
 w7/iq0I69ekJsBKQmd9QiFqWIDox+9U4zD8o+J/Op9PFWrKmNCZk7WLIflzAMyEup2/d
 5zgo7mWH2VTuat53Sl9oYi2lZMdu6JcfbGGjSuNRxWdDasllK8BHIDcZGmiNpKp1HfF9
 2z42vMzXvPrPBCfDxR1aOjCSUzJzEJsh+8Z69rwOpZxCp2U+nZMkLa0gm4VnAmEzn0wg
 9H1Q==
X-Gm-Message-State: ABy/qLawu2uhOuj6RO8OSfvPI/wLhkCjhml3NX1ALh7AtJkXkwx24F0F
 JrxvRtVL9MXf/VwVEuj48Qyd/Mx8VOO/GwDTD/g=
X-Google-Smtp-Source: APBJJlF1jFXvxyTjjffEw9OCYrfWavrUWjtRagAx3ar4G/YT3YK9BR5srT+MOnZwvvnV6tgTBK6QNUnzBvfmpxRkmp4=
X-Received: by 2002:a05:6214:ac8:b0:621:65de:f60c with SMTP id
 g8-20020a0562140ac800b0062165def60cmr6658128qvi.3.1688768802285; Fri, 07 Jul
 2023 15:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN3LS2mvXOe5g8WFC=b3N=bF1u4RCQYJN-u+k=ZEWWrcA@mail.gmail.com>
 <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 8 Jul 2023 03:26:31 +0500
Message-ID: <CABXGCsN1cnGgMn=Jg6nYfg1GccZhPX8sa=izrr9sMxZdzLiTJg@mail.gmail.com>
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

On Fri, Jul 7, 2023 at 6:01=E2=80=AFAM Chen, Guchun <Guchun.Chen@amd.com> w=
rote:
>
> [Public]
>
> Hi Mike,
>
> Yes, we are aware of this problem, and we are working on that. The proble=
m is caused by recent code stores xcp_id to amdgpu bo for accounting memory=
 usage and so on. However, not all VMs are attached to that like the case i=
n amdgpu_mes_self_test.
>

I would like to take part in testing the fix.

--=20
Best Regards,
Mike Gavrilov.
