Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1F8C0218B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2025 21:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D84510E02E;
	Thu, 23 Jan 2025 21:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1Xqk+Ur";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CE910E02E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 21:01:46 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ef79243680so334219a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 13:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737666106; x=1738270906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTGj0cXqkBQpWDwRfEb5Ug+LQsYRTrlkl7gKQhB5F2k=;
 b=d1Xqk+Urn84CKI8Mc/1xWJTwNoxwA8IVACrGoQVijhjVVBNC2AhWJUk4uN0RZh0Og3
 A0RXnMa0Qh17I7Za95uMok7EBi/fX+S/BMd5TrA8fpeY3kHVN6IYN8PJ3ztgKacyZfSM
 vY66AIlbk2grc7vd/R/AzCD5r30ZfpkUeyGJ5oz6iv9cYmrd8isie96B9RPMr+HiNPku
 Ka6rLcHzw4RvpD8ApjsrvqTrpeCHFNmF08xmAV6zlBe/ePa45crihaqPTmBU2lkODayx
 a1EHPp3I8dKCbOks5vJzHwi+jVqbUf753V4l+uflxDuzFsNN5hEaYzcZRfc24m5Bz9Ll
 bhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737666106; x=1738270906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTGj0cXqkBQpWDwRfEb5Ug+LQsYRTrlkl7gKQhB5F2k=;
 b=OlRo2WshVszmcvw6nf9iEEO45+Vv1anDcWoLrrG2f1eiyQFsRPr3o6perZwPmU7s90
 sCvBO8RWaJE47Aq822aVzhxQZs27JI7fWx7cc2WJD1ldb/sHMRKavXeTcmaQeEoxhsed
 SwHRDC/riCGuYtH9i1yjSXQgVwY8xWId3BExfdOgdOjNafDjbKAM8GAijg7MWXrRhsHR
 4q0SUosQ4aJhlfRSny+vAAOj96FgskqOCAZ8DbesuZbtflJTbkH12xpbt1om51xOe59S
 gePhtjRd22eVPeSkbk+X/X8VdvXAzgMODySthvoDwScgftvqVn2Mx1TDdpbMnOolyxPJ
 nnpQ==
X-Gm-Message-State: AOJu0Yytm28CpGWamZlhvCvn9ociMfXOMx6To+6fJbWQpKuCG5wTrBZZ
 ktBxmqB4jvAn3X91JomxUT+NX5+L1M/mrKWjv51PKI3o5TI43NerqBhrQI1a+Y4dy57ZyVt5ZhZ
 tMeocr3789RwA+7iIdyGeodCXOXkQSA==
X-Gm-Gg: ASbGncve7qoi4IPCam2u/qiqlzdozhRWCJrPOah/Y1+ctvZdhAu9oU9q6t4+wQDcMyL
 EYkO+yv5l6V0tMkJdlLWFvrV/KidybzzkL8+eIsIHsbECC5/aw3tuu3caXexbfg==
X-Google-Smtp-Source: AGHT+IENe6etMHhcVi2U2mGlO5JZfUjGHupK6kPc9T0UtdBDKJwDZQfQ59cyAn7CzYe8qZRtf8vedcpq/1tvNrZK8hQ=
X-Received: by 2002:a05:6a00:2406:b0:72a:a7a4:99ca with SMTP id
 d2e1a72fcca58-72daf973e78mr15592587b3a.2.1737666105448; Thu, 23 Jan 2025
 13:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20250120194017.201218-1-alexander.deucher@amd.com>
 <CADnq5_MhadSHG=QUFQa=aFgQCs+HuZ777hFuZN4h_dbFX6z8GQ@mail.gmail.com>
In-Reply-To: <CADnq5_MhadSHG=QUFQa=aFgQCs+HuZ777hFuZN4h_dbFX6z8GQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jan 2025 16:01:33 -0500
X-Gm-Features: AbW1kvaMNKY1dbx-Q9i7C_E-mk9QG-ffHEv2h4iLYh-u3WEHQHijjOg7nbdYl5k
Message-ID: <CADnq5_OM_yac_3i8S=NiYi+L7c3pjsP5fjqM7OOVL62rsdB6GA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update and cleanup PM4 headers
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Saurabh Verma <saurabh.verma@amd.com>
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

Ping again?

On Wed, Jan 22, 2025 at 10:41=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Ping?
>
> On Mon, Jan 20, 2025 at 2:47=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Consolidate PM4 definitions.  Most of these were previously
> > only defined in UMDs.  Add them here as well and sync with
> > latest packets.  Also no need to include soc15d.h on gfx10+.
> >
> > Suggested-by: Saurabh Verma <saurabh.verma@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   1 -
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |   1 -
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   1 -
> >  drivers/gpu/drm/amd/amdgpu/nvd.h       | 208 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/soc15d.h    | 139 +++++++++++++++++
> >  5 files changed, 347 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 070b4d6bd9c59..63de78060d679 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -40,7 +40,6 @@
> >  #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
> >
> >  #include "soc15.h"
> > -#include "soc15d.h"
> >  #include "soc15_common.h"
> >  #include "clearstate_gfx10.h"
> >  #include "v10_structs.h"
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 52c571b134fd0..89d17750af04d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -42,7 +42,6 @@
> >  #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
> >
> >  #include "soc15.h"
> > -#include "soc15d.h"
> >  #include "clearstate_gfx11.h"
> >  #include "v11_structs.h"
> >  #include "gfx_v11_0.h"
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 2a71998800414..e425b87078d7d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -40,7 +40,6 @@
> >  #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
> >
> >  #include "soc15.h"
> > -#include "soc15d.h"
> >  #include "clearstate_gfx12.h"
> >  #include "v12_structs.h"
> >  #include "gfx_v12_0.h"
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amd=
gpu/nvd.h
> > index 631dafb922990..56f1bfac0b208 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> > @@ -64,6 +64,24 @@
> >  #define        PACKET3_INDIRECT_BUFFER_CNST_END                0x19
> >  #define        PACKET3_ATOMIC_GDS                              0x1D
> >  #define        PACKET3_ATOMIC_MEM                              0x1E
> > +#define        PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x7F)=
 << 0)
> > +#define        PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF)=
 << 8)
> > +#define        PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) &=
 0x3) << 25)
> > +#define        PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)))
> > +#define        PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)))
> > +#define        PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)))
> > +#define        PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)))
> > +#define        PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)))
> > +#define        PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)))
> > +#define        PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) =
& 0x1FFF) << 0)
> > +#define        PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
> > +#define        PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFI=
ED 1
> > +#define        PACKET3_ATOMIC_MEM__COMMAND__WAIT_FOR_WRITE_CONFIRMATIO=
N 2
> > +#define        PACKET3_ATOMIC_MEM__COMMAND__SEND_AND_CONTINUE 3
> > +#define        PACKET3_ATOMIC_MEM__CACHE_POLICY__LRU 0
> > +#define        PACKET3_ATOMIC_MEM__CACHE_POLICY__STREAM 1
> > +#define        PACKET3_ATOMIC_MEM__CACHE_POLICY__NOA 2
> > +#define        PACKET3_ATOMIC_MEM__CACHE_POLICY__BYPASS 3
> >  #define        PACKET3_OCCLUSION_QUERY                         0x1F
> >  #define        PACKET3_SET_PREDICATION                         0x20
> >  #define        PACKET3_REG_RMW                                 0x21
> > @@ -105,6 +123,38 @@
> >                  * 1 - pfp
> >                  * 2 - ce
> >                  */
> > +#define        PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF)=
 << 8)
> > +#define        PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) & 0x=
1) << 16)
> > +#define        PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0=
x1) << 20)
> > +#define        PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) &=
 0x3) << 25)
> > +#define        PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x))=
 & 0x3FFFF) << 0)
> > +#define        PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) &=
 0xFFFF) << 0)
> > +#define        PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)=
) & 0x3FFFFFFF) << 2)
> > +#define        PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
> > +#define        PACKET3_WRITE_DATA__MODE(x) ((((unsigned)(x)) & 0x1) <<=
 21)
> > +#define        PACKET3_WRITE_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) =
<< 22)
> > +#define        PACKET3_WRITE_DATA__TEMPORAL(x) ((((unsigned)(x)) & 0x3=
) << 24)
> > +#define        PACKET3_WRITE_DATA__DST_MMREG_ADDR_LO(x) ((unsigned)(x)=
)
> > +#define        PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(=
x)) & 0xFF) << 0)
> > +#define        PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
> > +#define        PACKET3_WRITE_DATA__DST_SEL__TC_L2 2
> > +#define        PACKET3_WRITE_DATA__DST_SEL__GDS 3
> > +#define        PACKET3_WRITE_DATA__DST_SEL__MEMORY 5
> > +#define        PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTE=
NT_STATE 6
> > +#define        PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS 0
> > +#define        PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS=
 1
> > +#define        PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_C=
ONFIRMATION 0
> > +#define        PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMA=
TION 1
> > +#define        PACKET3_WRITE_DATA__MODE__PF_VF_DISABLED 0
> > +#define        PACKET3_WRITE_DATA__MODE__PF_VF_ENABLED 1
> > +#define        PACKET3_WRITE_DATA__TEMPORAL__RT 0
> > +#define        PACKET3_WRITE_DATA__TEMPORAL__NT 1
> > +#define        PACKET3_WRITE_DATA__TEMPORAL__HT 2
> > +#define        PACKET3_WRITE_DATA__TEMPORAL__LU 3
> > +#define        PACKET3_WRITE_DATA__CACHE_POLICY__LRU 0
> > +#define        PACKET3_WRITE_DATA__CACHE_POLICY__STREAM 1
> > +#define        PACKET3_WRITE_DATA__CACHE_POLICY__NOA 2
> > +#define        PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS 3
> >  #define        PACKET3_DRAW_INDEX_INDIRECT_MULTI               0x38
> >  #define        PACKET3_MEM_SEMAPHORE                           0x39
> >  #              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
> > @@ -135,6 +185,42 @@
> >                 /* 0 - me
> >                  * 1 - pfp
> >                  */
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)=
(x)) & 0x7) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned=
)(x)) & 0x3) << 4)
> > +#define                PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned=
)(x)) & 0x3) << 6)
> > +#define                PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsi=
gned)(x)) & 0x3) << 22)
> > +#define                PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigne=
d)(x)) & 0x1) << 24)
> > +#define                PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsig=
ned)(x)) & 0x3) << 25)
> > +#define                PACKET3_WAIT_REG_MEM__TEMPORAL(x) ((((unsigned)=
(x)) & 0x3) << 25)
> > +#define                PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((u=
nsigned)(x)) & 0x3FFFFFFF) << 2)
> > +#define                PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsi=
gned)(x)) & 0X3FFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((un=
signed)(x)) & 0X3FFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((uns=
igned)(x))
> > +#define                PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((un=
signed)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(=
x))
> > +#define                PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
> > +#define                PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsi=
gned)(x)) & 0xFFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE=
(x) ((((unsigned)(x)) & 0x1) << 31)
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE 1
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_=
REF_VALUE 2
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_=
VALUE 3
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VAL=
UE 4
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_R=
EFERENCE_VALUE 5
> > +#define        PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_=
VALUE 6
> > +#define        PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE 0
> > +#define        PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE 1
> > +#define        PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM 0
> > +#define        PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG 1
> > +#define        PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE 3
> > +#define        PACKET3_WAIT_REG_MEM__CACHE_POLICY__LRU 0
> > +#define        PACKET3_WAIT_REG_MEM__CACHE_POLICY__STREAM 1
> > +#define        PACKET3_WAIT_REG_MEM__CACHE_POLICY__NOA 2
> > +#define        PACKET3_WAIT_REG_MEM__CACHE_POLICY__BYPASS 3
> > +#define        PACKET3_WAIT_REG_MEM__TEMPORAL__RT 0
> > +#define        PACKET3_WAIT_REG_MEM__TEMPORAL__NT 1
> > +#define        PACKET3_WAIT_REG_MEM__TEMPORAL__HT 2
> > +#define        PACKET3_WAIT_REG_MEM__TEMPORAL__LU 3
> >  #define        PACKET3_INDIRECT_BUFFER                         0x3F
> >  #define                INDIRECT_BUFFER_VALID                   (1 << 2=
3)
> >  #define                INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) <<=
 28)
> > @@ -144,8 +230,94 @@
> >                  */
> >  #define                INDIRECT_BUFFER_PRE_ENB(x)              ((x) <<=
 21)
> >  #define                INDIRECT_BUFFER_PRE_RESUME(x)           ((x) <<=
 30)
> > +#define        PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)=
) & 0x3FFFFFFF) << 2)
> > +#define        PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
> > +#define        PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) &=
 0xFFFFF) << 0)
> > +#define        PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0=
x1) << 20)
> > +#define        PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigne=
d)(x)) & 0x1) << 21)
> > +#define        PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0=
x1) << 23)
> > +#define        PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0x=
F) << 24)
> > +#define        PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(=
x)) & 0x3) << 28)
> > +#define        PACKET3_INDIRECT_BUFFER__TEMPORAL(x) ((((unsigned)(x)) =
& 0x3) << 28)
> > +#define        PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x=
1) << 31)
> > +#define        PACKET3_INDIRECT_BUFFER__TEMPORAL__RT 0
> > +#define        PACKET3_INDIRECT_BUFFER__TEMPORAL__NT 1
> > +#define        PACKET3_INDIRECT_BUFFER__TEMPORAL__HT 2
> > +#define        PACKET3_INDIRECT_BUFFER__TEMPORAL__LU 3
> > +#define        PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU 0
> > +#define        PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM 1
> > +#define        PACKET3_INDIRECT_BUFFER__CACHE_POLICY__NOA 2
> > +#define        PACKET3_INDIRECT_BUFFER__CACHE_POLICY__BYPASS 3
> >  #define        PACKET3_COND_INDIRECT_BUFFER                    0x3F
> >  #define        PACKET3_COPY_DATA                               0x40
> > +#define        PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) =
<< 0)
> > +#define        PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) =
<< 8)
> > +#define        PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)=
) & 0x3) << 13)
> > +#define        PACKET3_COPY_DATA__SRC_TEMPORAL(x) ((((unsigned)(x)) & =
0x3) << 13)
> > +#define        PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1=
) << 16)
> > +#define        PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x=
1) << 20)
> > +#define        PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)=
) & 0x3) << 25)
> > +#define        PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) &=
 0x1) << 29)
> > +#define        PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) =
& 0x3FFFF) << 0)
> > +#define        PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x))=
 & 0x3FFFFFFF) << 2)
> > +#define        PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x))=
 & 0x1FFFFFFF) << 3)
> > +#define        PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x))=
 & 0xFFFF) << 0)
> > +#define        PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
> > +#define        PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
> > +#define        PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
> > +#define        PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) =
& 0x3FFFF) << 0)
> > +#define        PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x))=
 & 0x3FFFFFFF) << 2)
> > +#define        PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x))=
 & 0x1FFFFFFF) << 3)
> > +#define        PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x))=
 & 0xFFFF) << 0)
> > +#define        PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
> > +#define        PACKET3_COPY_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << =
21)
> > +#define        PACKET3_COPY_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) <=
< 23)
> > +#define        PACKET3_COPY_DATA__DST_TEMPORAL(x) ((((unsigned)(x)) & =
0x3) << 25)
> > +#define        PACKET3_COPY_DATA__SRC_REG_OFFSET_LO(x) ((unsigned)(x))
> > +#define        PACKET3_COPY_DATA__SRC_REG_OFFSET_HI(x) ((((unsigned)(x=
)) & 0xFF) << 0)
> > +#define        PACKET3_COPY_DATA__DST_REG_OFFSET_LO(x) ((unsigned)(x))
> > +#define        PACKET3_COPY_DATA__DST_REG_OFFSET_HI(x) ((((unsigned)(x=
)) & 0xFF) << 0)
> > +#define        PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER 0
> > +#define        PACKET3_COPY_DATA__SRC_SEL__TC_L2_OBSOLETE 1
> > +#define        PACKET3_COPY_DATA__SRC_SEL__TC_L2 2
> > +#define        PACKET3_COPY_DATA__SRC_SEL__GDS 3
> > +#define        PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS 4
> > +#define        PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA 5
> > +#define        PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA 6
> > +#define        PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0 7
> > +#define        PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1 8
> > +#define        PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT 9
> > +#define        PACKET3_COPY_DATA__SRC_SEL__SYSTEM_CLOCK_COUNT 10
> > +#define        PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
> > +#define        PACKET3_COPY_DATA__DST_SEL__TC_L2 2
> > +#define        PACKET3_COPY_DATA__DST_SEL__GDS 3
> > +#define        PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS 4
> > +#define        PACKET3_COPY_DATA__DST_SEL__TC_L2_OBSOLETE 5
> > +#define        PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC 6
> > +#define        PACKET3_COPY_DATA__SRC_TEMPORAL__RT 0
> > +#define        PACKET3_COPY_DATA__SRC_TEMPORAL__NT 1
> > +#define        PACKET3_COPY_DATA__SRC_TEMPORAL__HT 2
> > +#define        PACKET3_COPY_DATA__SRC_TEMPORAL__LU 3
> > +#define        PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU 0
> > +#define        PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
> > +#define        PACKET3_COPY_DATA__SRC_CACHE_POLICY__NOA 2
> > +#define        PACKET3_COPY_DATA__SRC_CACHE_POLICY__BYPASS 3
> > +#define        PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA 0
> > +#define        PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA 1
> > +#define        PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMA=
TION 0
> > +#define        PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION 1
> > +#define        PACKET3_COPY_DATA__MODE__PF_VF_DISABLED 0
> > +#define        PACKET3_COPY_DATA__MODE__PF_VF_ENABLED 1
> > +#define        PACKET3_COPY_DATA__DST_TEMPORAL__RT 0
> > +#define        PACKET3_COPY_DATA__DST_TEMPORAL__NT 1
> > +#define        PACKET3_COPY_DATA__DST_TEMPORAL__HT 2
> > +#define        PACKET3_COPY_DATA__DST_TEMPORAL__LU 3
> > +#define        PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU 0
> > +#define        PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM 1
> > +#define        PACKET3_COPY_DATA__DST_CACHE_POLICY__NOA 2
> > +#define        PACKET3_COPY_DATA__DST_CACHE_POLICY__BYPASS 3
> > +#define        PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
> > +#define        PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
> >  #define        PACKET3_CP_DMA                                  0x41
> >  #define        PACKET3_PFP_SYNC_ME                             0x42
> >  #define        PACKET3_SURFACE_SYNC                            0x43
> > @@ -160,6 +332,23 @@
> >                  * 3 - SAMPLE_STREAMOUTSTAT*
> >                  * 4 - *S_PARTIAL_FLUSH
> >                  */
> > +#define                PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned=
)(x)) & 0x3F) << 0)
> > +#define                PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigne=
d)(x)) & 0xF) << 8)
> > +#define                PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) (((=
(unsigned)(x)) & 0x3) << 29)
> > +#define                PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsi=
gned)(x)) & 0x1) << 0)
> > +#define        PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & =
0x1FFFFFFF) << 3)
> > +#define        PACKET3_EVENT_WRITE__ADDRESS_HI(x) ((unsigned)(x))
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS=
 8
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS=
1 9
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS=
2 10
> > +#define        PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS=
3 11
> > +#define        PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__LEGACY_MODE 0
> > +#define        PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE1 1
> > +#define        PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__NEW_MODE 2
> > +#define        PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE3 3
> >  #define        PACKET3_EVENT_WRITE_EOP                         0x47
> >  #define        PACKET3_EVENT_WRITE_EOS                         0x48
> >  #define        PACKET3_RELEASE_MEM                             0x49
> > @@ -304,6 +493,12 @@
> >                  * 2: REVERSE
> >                  */
> >  #define        PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
> > +#define        PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
> > +#define        PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x))=
 & 0xFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
> > +#define        PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x))=
 & 0xFFFFFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x))=
 & 0xFFFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x=
7FFFF) << 0)
> >  #define        PACKET3_REWIND                                  0x59
> >  #define        PACKET3_INTERRUPT                               0x5A
> >  #define        PACKET3_GEN_PDEPTE                              0x5B
> > @@ -330,11 +525,17 @@
> >  #define        PACKET3_SET_SH_REG                              0x76
> >  #define                PACKET3_SET_SH_REG_START                       =
 0x00002c00
> >  #define                PACKET3_SET_SH_REG_END                         =
 0x00003000
> > +#define        PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0=
xFFFF) << 0)
> > +#define        PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0=
x1F) << 23)
> > +#define        PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) <=
< 28)
> > +#define        PACKET3_SET_SH_REG__INDEX__DEFAULT 0
> > +#define        PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
> >  #define        PACKET3_SET_SH_REG_OFFSET                       0x77
> >  #define        PACKET3_SET_QUEUE_REG                           0x78
> >  #define        PACKET3_SET_UCONFIG_REG                         0x79
> >  #define                PACKET3_SET_UCONFIG_REG_START                  =
 0x0000c000
> >  #define                PACKET3_SET_UCONFIG_REG_END                    =
 0x0000c400
> > +#define        PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)=
) & 0xFFFF) << 0)
> >  #define        PACKET3_SET_UCONFIG_REG_INDEX                   0x7A
> >  #define        PACKET3_FORWARD_HEADER                          0x7C
> >  #define        PACKET3_SCRATCH_RAM_WRITE                       0x7D
> > @@ -369,6 +570,7 @@
> >  #              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0=
)
> >  #              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4=
)
> >  #              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5=
)
> > +#              define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 2=
9)
> >  #define        PACKET3_AQL_PACKET                              0x99
> >  #define        PACKET3_DMA_DATA_FILL_MULTI                     0x9A
> >  #define        PACKET3_SET_SH_REG_INDEX                        0x9B
> > @@ -462,6 +664,12 @@
> >  #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) <<=
 25)
> >  #define        PACKET3_RUN_LIST                                0xA5
> >  #define        PACKET3_MAP_PROCESS_VM                          0xA6
> > +
> > +#define PACKET3_RUN_CLEANER_SHADER                      0xD2
> > +/* 1. header
> > + * 2. RESERVED [31:0]
> > + */
> > +
> >  /* GFX11 */
> >  #define        PACKET3_SET_Q_PREEMPTION_MODE                   0xF0
> >  #              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) <=
< 0)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/=
amdgpu/soc15d.h
> > index b9cbeb389edc1..a5000c171c02c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> > @@ -93,11 +93,25 @@
> >  #define        PACKET3_DISPATCH_INDIRECT                       0x16
> >  #define        PACKET3_ATOMIC_GDS                              0x1D
> >  #define        PACKET3_ATOMIC_MEM                              0x1E
> > +#define                PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x))=
 & 0x3F) << 0)
> > +#define                PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)=
) & 0xF) << 8)
> > +#define                PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigne=
d)(x)) & 0x3) << 25)
> > +#define                PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x))=
 << 0)
> > +#define                PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x))=
 << 0)
> > +#define                PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)=
(x)) << 0)
> > +#define                PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)=
(x)) << 0)
> > +#define                PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)=
(x)) << 0)
> > +#define                PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)=
(x)) << 0)
> > +#define                PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsign=
ed)(x)) & 0x1FFF) << 0)
> > +#define        PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
> > +#define        PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFI=
ED 1
> >  #define        PACKET3_OCCLUSION_QUERY                         0x1F
> >  #define        PACKET3_SET_PREDICATION                         0x20
> >  #define        PACKET3_REG_RMW                                 0x21
> >  #define        PACKET3_COND_EXEC                               0x22
> >  #define        PACKET3_PRED_EXEC                               0x23
> > +#define                PACKET3_PRED_EXEC__EXEC_COUNT(x)        ((((uns=
igned)(x)) & 0x3FFF) << 0)
> > +#define                PACKET3_PRED_EXEC__VIRTUAL_XCC_ID_SELECT(x)    =
 ((((unsigned)(x)) & 0xFF) << 24)
> >  #define        PACKET3_DRAW_INDIRECT                           0x24
> >  #define        PACKET3_DRAW_INDEX_INDIRECT                     0x25
> >  #define        PACKET3_INDEX_BASE                              0x26
> > @@ -132,6 +146,28 @@
> >                  * 1 - pfp
> >                  * 2 - ce
> >                  */
> > +#define                PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)=
) & 0xF) << 8)
> > +#define                PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(=
x)) & 0x1) << 16)
> > +#define                PACKET3_WRITE_DATA__RESUME_VF_MI300(x) ((((unsi=
gned)(x)) & 0x1) << 19)
> > +#define                PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)=
(x)) & 0x1) << 20)
> > +#define                PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigne=
d)(x)) & 0x3) << 25)
> > +#define                PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsig=
ned)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigne=
d)(x)) & 0xFFFF) << 0)
> > +#define                PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsi=
gned)(x)) & 0x3FFFFFFF) << 2)
> > +#define                PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsign=
ed)(x))
> > +#define                PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTE=
R        0
> > +#define                PACKET3_WRITE_DATA__DST_SEL__TC_L2      2
> > +#define                PACKET3_WRITE_DATA__DST_SEL__GDS        3
> > +#define                PACKET3_WRITE_DATA__DST_SEL__MEMORY     5
> > +#define                PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_=
PERSISTENT_STATE 6
> > +#define                PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRES=
S        0
> > +#define                PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT=
_ADDRESS 1
> > +#define                PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR=
_WRITE_CONFIRMATION      0
> > +#define                PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_=
CONFIRMATION     1
> > +#define                PACKET3_WRITE_DATA__CACHE_POLICY__LRU   0
> > +#define                PACKET3_WRITE_DATA__CACHE_POLICY__STREAM       =
 1
> > +#define                PACKET3_WRITE_DATA__CACHE_POLICY__NOA   2
> > +#define                PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS       =
 3
> >  #define        PACKET3_DRAW_INDEX_INDIRECT_MULTI               0x38
> >  #define        PACKET3_MEM_SEMAPHORE                           0x39
> >  #              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
> > @@ -160,6 +196,33 @@
> >                 /* 0 - me
> >                  * 1 - pfp
> >                  */
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)=
(x)) & 0x7) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned=
)(x)) & 0x3) << 4)
> > +#define                PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned=
)(x)) & 0x3) << 6)
> > +#define                PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsi=
gned)(x)) & 0x3) << 22)
> > +#define                PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigne=
d)(x)) & 0x1) << 24)
> > +#define                PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsig=
ned)(x)) & 0x3) << 25)
> > +#define                PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((u=
nsigned)(x)) & 0x3FFFFFFF) << 2)
> > +#define                PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsi=
gned)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((un=
signed)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((uns=
igned)(x))
> > +#define                PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((un=
signed)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(=
x))
> > +#define                PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
> > +#define                PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsi=
gned)(x)) & 0xFFFF) << 0)
> > +#define                PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE=
(x) ((((unsigned)(x)) & 0x1) << 31)
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS    =
 0
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_V=
ALUE     1
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL=
_TO_THE_REF_VALUE        2
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_RE=
FERENCE_VALUE    3
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFER=
ENCE_VALUE       4
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR=
_EQUAL_REFERENCE_VALUE   5
> > +#define                PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_RE=
FERENCE_VALUE    6
> > +#define                PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE=
 0
> > +#define                PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE  =
 1
> > +#define                PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM  =
 0
> > +#define                PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG=
 1
> > +#define                PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEM=
PTABLE   3
> >  #define        PACKET3_INDIRECT_BUFFER                         0x3F
> >  #define                INDIRECT_BUFFER_VALID                   (1 << 2=
3)
> >  #define                INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) <<=
 28)
> > @@ -169,7 +232,63 @@
> >                  */
> >  #define     INDIRECT_BUFFER_PRE_ENB(x)          ((x) << 21)
> >  #define     INDIRECT_BUFFER_PRE_RESUME(x)               ((x) << 30)
> > +#define                PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsi=
gned)(x)) & 0x3FFFFFFF) << 2)
> > +#define                PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsign=
ed)(x))
> > +#define                PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigne=
d)(x)) & 0xFFFFF) << 0)
> > +#define                PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)=
(x)) & 0x1) << 20)
> > +#define                PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) (((=
(unsigned)(x)) & 0x1) << 21)
> > +#define                PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)=
(x)) & 0x1) << 23)
> > +#define                PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(=
x)) & 0xF) << 24)
> > +#define                PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((un=
signed)(x)) & 0x3) << 28)
> > +#define                PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(=
x)) & 0x1) << 31)
> > +#define                PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU     =
 0
> > +#define                PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM  =
 1
> >  #define        PACKET3_COPY_DATA                               0x40
> > +#define                PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x))=
 & 0xF) << 0)
> > +#define                PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x))=
 & 0xF) << 8)
> > +#define                PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsi=
gned)(x)) & 0x3) << 13)
> > +#define                PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x=
)) & 0x1) << 16)
> > +#define                PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(=
x)) & 0x1) << 20)
> > +#define                PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsi=
gned)(x)) & 0x3) << 25)
> > +#define                PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigne=
d)(x)) & 0x1) << 29)
> > +#define                PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsign=
ed)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsig=
ned)(x)) & 0x3FFFFFFF) << 2)
> > +#define                PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsig=
ned)(x)) & 0x1FFFFFFF) << 3)
> > +#define                PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsig=
ned)(x)) & 0xFFFF) << 0)
> > +#define                PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
> > +#define                PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsig=
ned)(x))
> > +#define                PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(=
x))
> > +#define                PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsign=
ed)(x)) & 0x3FFFF) << 0)
> > +#define                PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsig=
ned)(x)) & 0x3FFFFFFF) << 2)
> > +#define                PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsig=
ned)(x)) & 0x1FFFFFFF) << 3)
> > +#define                PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsig=
ned)(x)) & 0xFFFF) << 0)
> > +#define                PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x=
))
> > +#define                PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER=
 0
> > +#define                PACKET3_COPY_DATA__SRC_SEL__MEMORY      1
> > +#define                PACKET3_COPY_DATA__SRC_SEL__TC_L2       2
> > +#define                PACKET3_COPY_DATA__SRC_SEL__GDS 3
> > +#define                PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS       =
 4
> > +#define                PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA     =
 5
> > +#define                PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA =
 6
> > +#define                PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_D=
ATA0     7
> > +#define                PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_D=
ATA1     8
> > +#define                PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT    =
 9
> > +#define                PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER=
 0
> > +#define                PACKET3_COPY_DATA__DST_SEL__TC_L2       2
> > +#define                PACKET3_COPY_DATA__DST_SEL__GDS 3
> > +#define                PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS       =
 4
> > +#define                PACKET3_COPY_DATA__DST_SEL__MEMORY      5
> > +#define                PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC  =
 6
> > +#define                PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU       =
 0
> > +#define                PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
> > +#define                PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA  =
 0
> > +#define                PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA  =
 1
> > +#define                PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_=
CONFIRMATION     0
> > +#define                PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRM=
ATION    1
> > +#define                PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU       =
 0
> > +#define                PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM    =
 1
> > +#define                PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT      =
 0
> > +#define                PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE =
 1
> >  #define        PACKET3_PFP_SYNC_ME                             0x42
> >  #define        PACKET3_COND_WRITE                              0x45
> >  #define        PACKET3_EVENT_WRITE                             0x46
> > @@ -181,6 +300,15 @@
> >                  * 3 - SAMPLE_STREAMOUTSTAT*
> >                  * 4 - *S_PARTIAL_FLUSH
> >                  */
> > +#define                PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned=
)(x)) & 0x3F) << 0)
> > +#define                PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigne=
d)(x)) & 0xF) << 8)
> > +#define                PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsi=
gned)(x)) & 0x1) << 31)
> > +#define                PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) (((=
(unsigned)(x)) & 0x3) << 29)
> > +#define                PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned=
)(x)) & 0x1FFFFFFF) << 3)
> > +#define                PACKET3_EVENT_WRITE__ADDRESS_HI(x) (((unsigned)=
(x)) << 0)
> > +#define                PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
> > +#define                PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELI=
NESTATS  2
> > +#define                PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FL=
USH      4
> >  #define        PACKET3_RELEASE_MEM                             0x49
> >  #define                EVENT_TYPE(x)                           ((x) <<=
 0)
> >  #define                EVENT_INDEX(x)                          ((x) <<=
 8)
> > @@ -286,6 +414,13 @@
> >  #define        PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(=
x) ((x) << 29)
> >  #define        PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_E=
NA(x) ((x) << 30)
> >  #define        PACKET3_REWIND                                  0x59
> > +#define                PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(=
x))
> > +#define        PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x))=
 & 0xFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__COHER_SIZE_HI_VG10(x) ((((unsigned=
)(x)) & 0xFFFFFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
> > +#define        PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x))=
 & 0xFFFFFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x))=
 & 0xFFFF) << 0)
> > +#define        PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x=
7FF) << 0)
> >  #define        PACKET3_LOAD_UCONFIG_REG                        0x5E
> >  #define        PACKET3_LOAD_SH_REG                             0x5F
> >  #define        PACKET3_LOAD_CONFIG_REG                         0x60
> > @@ -300,12 +435,16 @@
> >  #define        PACKET3_SET_SH_REG                              0x76
> >  #define                PACKET3_SET_SH_REG_START                       =
 0x00002c00
> >  #define                PACKET3_SET_SH_REG_END                         =
 0x00003000
> > +#define        PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0=
xFFFF) << 0)
> > +#define        PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0=
x1F) << 23)
> > +#define        PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) <=
< 28)
> >  #define        PACKET3_SET_SH_REG_OFFSET                       0x77
> >  #define        PACKET3_SET_QUEUE_REG                           0x78
> >  #define        PACKET3_SET_UCONFIG_REG                         0x79
> >  #define                PACKET3_SET_UCONFIG_REG_START                  =
 0x0000c000
> >  #define                PACKET3_SET_UCONFIG_REG_END                    =
 0x0000c400
> >  #define                PACKET3_SET_UCONFIG_REG_INDEX_TYPE             =
 (2 << 28)
> > +#define        PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)=
) & 0xFFFF) << 0)
> >  #define        PACKET3_SCRATCH_RAM_WRITE                       0x7D
> >  #define        PACKET3_SCRATCH_RAM_READ                        0x7E
> >  #define        PACKET3_LOAD_CONST_RAM                          0x80
> > --
> > 2.48.1
> >
