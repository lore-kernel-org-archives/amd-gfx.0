Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E663CC48BEF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C4610EADC;
	Fri, 16 Feb 2024 15:13:58 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35B010E4FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 09:21:01 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-dcdb210cb6aso1901718276.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 01:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yonsei.ac.kr; s=google; t=1708075260; x=1708680060;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pCrAiFZrMJSXyid8fyIo/iMdjd+//f3ehOBrSVjtAG8=;
 b=bxiRNLg1baLmcKpi1Ew4Im2zKg9N7/DC4c8PyqtcGZndUjcVS1MWOET/rZlRNnLkQQ
 RkyLgnSGeTsy2OKIdUmJthvwimK2/maiMIiCor2GAT3m+yHRbP2w6VcAZT2S8wPBbt7z
 pok7f2TCUB/ABrpm86VVzo8sElqBr/58NeIbqS9c8HHfGs1IXe5962O0PaAQzOyZNgLZ
 KTI7RGhG8qjQgJm2D3uTEwwKFnRyBWhhQL8B3fH68fDYvigHKPmwW9zF0fAjgXZ6MOk6
 JanWaWYFKugEcNlFnAZPBBTPk4SH2BpJud32ohUbB6DFKRoSmQL3HUcz7rrs0JV1msWx
 L4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708075260; x=1708680060;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pCrAiFZrMJSXyid8fyIo/iMdjd+//f3ehOBrSVjtAG8=;
 b=MMJy0Q0U65OHAqAuth0DncLLno9t6E+MCw27P1Nv8CIDPkYIkk2i5FyiqtpbT2mXP0
 vUzp+cAHH+9bqxqcAsa5D1gSaacoFRmhIELzve59L1x6dZ7qUTtpQyPYDV45/PcIac6g
 ERBW1B/f9hTSHFuKVWiJlaJPbh748vHvB8+mtJrSPjRBUzyoCzgDNmJS7BnbTrjrcG2q
 JiimNDV3CmDPlL6M/MaJgholQs957sE8x+/86GI18UuArhsH/of9YqVpYCYk3laqwmiL
 bxW7o3ULylXdDyKy34rETJkuPXCIqQGWGzou3qMWC1/f+E4viRZbvQgUHWTwK+EMff+0
 EjeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRxa8FrrlTnun7w9MG/5jRPAjQmVnJhM9Bx5y7TOPIGB7xpBSRfcNmSpuv+TtfvLKkrLDgtFIy91kqMv2YmsNLCxFqfqz82pz1p8NL0Q==
X-Gm-Message-State: AOJu0YzpAQWz4G4KTjMpX2cR/rFz4n4WQ+4QUc/v6aWVHTTlkOU7Tl9S
 fiGZzuY1NguHK7zMcWGglQUFdD7OVbTdvPDxIGFIncMuhzM+qfEj8lojdnQNpCU3BH/A6SX6ALS
 GCDyCgMEx+vS+aWympzr8g8H0//udCq3hs15EyQ==
X-Google-Smtp-Source: AGHT+IHxlIZxY7zGT+vSMeQsXoIojkZERyHr872cnkvcwv3LQu9H5wsNsUBTWsv4GzeFuVozShFnKuqDzk9du8bRRh0=
X-Received: by 2002:a25:2fcc:0:b0:dcd:26a8:7f84 with SMTP id
 v195-20020a252fcc000000b00dcd26a87f84mr3900918ybv.47.1708075260250; Fri, 16
 Feb 2024 01:21:00 -0800 (PST)
MIME-Version: 1.0
From: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Date: Fri, 16 Feb 2024 18:20:49 +0900
Message-ID: <CAKc8oVX8ymfw864dFC9zQzD=JwsQCApKukrf6hXKKnRo7MQFAg@mail.gmail.com>
Subject: Reporting a null-ptr-deref in amdgpu
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>, jisoo.jang@yonsei.ac.kr,
 yw9865@yonsei.ac.kr, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000023218206117c43d3"
X-Mailman-Approved-At: Fri, 16 Feb 2024 15:13:57 +0000
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

--00000000000023218206117c43d3
Content-Type: text/plain; charset="UTF-8"

Hello,

We would like to report a null-ptr-deref bug in the AMDGPU DRM driver in
the linux kernel v6.8-rc4 that we found with our customized Syzkaller.
The bug can be triggered by sending two ioctls to the AMDGPU DRM driver in
succession.

The first ioctl amdgpu_ctx_ioctl will create a ctx, and return ctx_id = 1
to the userspace.
Second ioctl, actually any ioctl that will eventually call
amdgpu_ctx_get_entity, carries this ctx_id and passes the context check.
Here, for example, drm_amdgpu_wait_cs.
Validations in amdgpu_ctx_get_entity can also be passed by the
user-provided values from the ioctl arguments.
This eventually leads to drm_sched_entity_init, where the null-ptr-deref
will trigger on RCU_INIT_POINTER(entity->last_scheduled, NULL);

Steps to reproduce are as below.
union drm_amdgpu_ctx *arg1;
union drm_amdgpu_wait_cs *arg2;

arg1 = malloc(sizeof(union drm_amdgpu_ctx));
arg2 = malloc(sizeof(union drm_amdgpu_wait_cs));

arg1->in.op = 0x1;
ioctl(AMDGPU_renderD128_DEVICE_FILE, 0x140106442, arg1);

arg2->in.handle = 0x0;
arg2->in.timeout = 0x2000000000000;
arg2->in.ip_type = 0x9;
arg2->in.ip_instance = 0x0;
arg2->in.ring = 0x0;
arg2->in.ctx_id = 0x1;
ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc0206449, arg2);

The KASAN report is as follows:
general protection fault, probably for non-canonical address
0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
Call Trace:
 <TASK>
 ? drm_sched_entity_init+0x16e/0x650
 ? drm_sched_entity_init+0x208/0x650
 amdgpu_ctx_get_entity+0x944/0xc30
 amdgpu_cs_wait_ioctl+0x13d/0x3f0
 drm_ioctl_kernel+0x300/0x410
 drm_ioctl+0x648/0xb30
 amdgpu_drm_ioctl+0xc8/0x160
 </TASK>

Should you need any more information, please do not hesitate to contact us.

Best regards,
Joonkyo Jung

--00000000000023218206117c43d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>We would like to report a null-ptr-deref bug=
 in the AMDGPU DRM driver in the linux kernel v6.8-rc4 that we found with o=
ur customized Syzkaller.<br>The bug can be triggered by sending two ioctls =
to the AMDGPU DRM driver in succession.<br><br>The first ioctl amdgpu_ctx_i=
octl will create a ctx, and return ctx_id =3D 1 to the userspace.<br>Second=
 ioctl, actually any ioctl that will eventually call amdgpu_ctx_get_entity,=
 carries this ctx_id and passes the context check.<br>Here, for example, dr=
m_amdgpu_wait_cs.<br>Validations in amdgpu_ctx_get_entity can also be passe=
d by the user-provided values from the ioctl arguments.<br>This eventually =
leads to drm_sched_entity_init, where the null-ptr-deref will trigger on RC=
U_INIT_POINTER(entity-&gt;last_scheduled, NULL);<br><br>Steps to reproduce =
are as below.<br>union drm_amdgpu_ctx *arg1;<br>union drm_amdgpu_wait_cs *a=
rg2;<br><br>arg1 =3D malloc(sizeof(union drm_amdgpu_ctx));<br>arg2 =3D mall=
oc(sizeof(union drm_amdgpu_wait_cs));<br><br>arg1-&gt;in.op =3D 0x1;<br>ioc=
tl(AMDGPU_renderD128_DEVICE_FILE, 0x140106442, arg1);<br><br>arg2-&gt;in.ha=
ndle =3D 0x0;<br>arg2-&gt;in.timeout =3D 0x2000000000000;<br>arg2-&gt;in.ip=
_type =3D 0x9;<br>arg2-&gt;in.ip_instance =3D 0x0;<br>arg2-&gt;in.ring =3D =
0x0;<br>arg2-&gt;in.ctx_id =3D 0x1;<br>ioctl(AMDGPU_renderD128_DEVICE_FILE,=
 0xc0206449, arg2);<br><br>The KASAN report is as follows:<br>general prote=
ction fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#=
1] PREEMPT SMP KASAN NOPTI<br>KASAN: null-ptr-deref in range [0x00000000000=
00028-0x000000000000002f]<br>Call Trace:<br>=C2=A0&lt;TASK&gt;<br>=C2=A0? d=
rm_sched_entity_init+0x16e/0x650<br>=C2=A0? drm_sched_entity_init+0x208/0x6=
50<br>=C2=A0amdgpu_ctx_get_entity+0x944/0xc30<br>=C2=A0amdgpu_cs_wait_ioctl=
+0x13d/0x3f0<br>=C2=A0drm_ioctl_kernel+0x300/0x410<br>=C2=A0drm_ioctl+0x648=
/0xb30<br>=C2=A0amdgpu_drm_ioctl+0xc8/0x160<br>=C2=A0&lt;/TASK&gt;<br><br>S=
hould you need any more information, please do not hesitate to contact us.<=
br><br>Best regards,<br>Joonkyo Jung<br></div>

--00000000000023218206117c43d3--
