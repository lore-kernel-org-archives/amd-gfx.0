Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88173C2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 20:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A72110E18C;
	Wed, 15 Nov 2023 20:08:58 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E83510E18C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 20:08:57 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5af15c3f734so5434577b3.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 12:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700078936; x=1700683736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dudJu8bqmoA0uQm5mbpxz9Q3fjggrbI693boctNIlwg=;
 b=ELWJNRIGRyT5t+88Wb+K4Xai9qXNw1OuvOKH/8ZCU2uZT769zAw+vDkIQITEuWatNt
 ywsHkP+aYa5/PJiOva2FclEw4UF86jayZp3fZ6/cOEgfjL4ZQzCEanMs1p+mMFdHg9eW
 UbrxhaYuYJx2T5RftGhEI0p3EciLLEBQvwaF6fiaACKl95DBaAFh8go8S2sk+CoFl1YW
 mj2CZY6P5QV8BNflj6kaNqT10dAfPiopsOeQwfFWFGZ5RCZ8btQo+/BZPdIuCyHxVKfX
 lQ9WKg/9XiuwyV5MflUjvhl6QRvAeX2oWth/OBTGbEt1z2kv63Hg6k3khPtxjh1kuCVB
 hoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700078936; x=1700683736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dudJu8bqmoA0uQm5mbpxz9Q3fjggrbI693boctNIlwg=;
 b=MI/T+ZZUgTEit2e5Vl7hXGZcTPfkfFMWVv216egJd7Ra2MtQYqYsBnluYG+lCiYVlX
 6Ppgtbaq9ofAzLMtB0MKbJHt8q7GB6ZtrtFw8JHrk4J/jUtKksjAv8+pno+YGu30l4ve
 UDm0GA/4FIYQPqpj2nnSBe1C5yEK9ekTMAWhyNiRXknGn3k1lxE/OaUVw2cPqBOH2g4a
 9y6TBXxVx24YgH1S+yjvLISd96guT52dJhuP84gJunIoKVfd+IYtME9QmnnjMSJJt6Tu
 dc/f89HzlTRpjJ4NGJb49N5sdTWDvJ99/Rg3nDWjobzfDXDhDXZh/u85wdppklQ96+F+
 DSIA==
X-Gm-Message-State: AOJu0YxT31GpGLtnR3TfNWCQUf6VkaO/aW8R6kS+PRsebdkBMQ/R6wAI
 0/kbbsa8vFgcaTkLFXFFGrFc3ysBLEcf4YaEcgE=
X-Google-Smtp-Source: AGHT+IHRkkHlie4UQ1NReHZ8gGxmxQucffqCVtYpZbaibyoZxtH1P8lpv4HNZVkT5YfCpALDmktBsBV2BTTL3WdoRvk=
X-Received: by 2002:a05:690c:4887:b0:5a8:9e9:e661 with SMTP id
 hd7-20020a05690c488700b005a809e9e661mr4614841ywb.1.1700078936216; Wed, 15 Nov
 2023 12:08:56 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 16 Nov 2023 01:08:44 +0500
Message-ID: <CABXGCsNpEh7GjFPvx=rz6ZeB7Kx4iqV-e8HyFKyhNau2S5gENw@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: "Lee, Alvin" <Alvin.Lee2@amd.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 15, 2023 at 11:39=E2=80=AFPM Lee, Alvin <Alvin.Lee2@amd.com> wr=
ote:
>
> This change has a DMCUB dependency - are you able to update your DMCUB ve=
rsion as well?
>

I can confirm this issue was gone after updating firmware.

=E2=9D=AF dmesg | grep DMUB
[   11.496679] [drm] Loading DMUB firmware via PSP: version=3D0x07002300
[   12.000314] [drm] DMUB hardware initialized: version=3D0x07002300



--=20
Best Regards,
Mike Gavrilov.
