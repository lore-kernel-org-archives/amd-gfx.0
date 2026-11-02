Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34391606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlpN/sOU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824CB10F4A1;
	Tue,  3 Nov 2026 09:36:48 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FC010F019
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 15:35:27 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dd3367198so377196f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 07:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793633726; cv=none;
 d=google.com; s=arc-20260327;
 b=Zmidnvfx8F443ZwKzXYZfYjaoSkkuuR2CM+nHm2vDkm+YSdkDYnZJhT6PBAXQLI7ML
 fsaYGS3r0rH8F7I1DxKnJjENyzNiV8h8TKHGtu6Veda/KfqyA1Jk/4CVCzPEs0huFSVL
 BJ/YPA8FT4Li8IunuawACgHCpRtphLHUi1Gi4P5T2HJ+MedduUevyDXmM2f3TEdYIORT
 rcC1nB9/UE60MZ262a79TYJk5Smqj1qgvvI5/3ouzdqKqtc+RnWQrIYthhAnJeJcJ9qu
 Qcl3i7AJ1hhLAF3veM4+Y/+c9r5srNfBI+OyZFmiZyRBSvx7qMOoBzC2RGl4Rz9Art+C
 X/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1VmlI/ur8pujk541VodzhFgp6hX5xM0UtNlOZvLTJKg=;
 fh=P+YzHGYFBOeiUIvBTSiASDyrTZYYX0wLZ8zpeSXiGVo=;
 b=m7YIW1umk2Z+b2WsiIue6Ji+xhJaC5+rl6ExCPVT+M1HodlKZuL7PGpjbPS1JQEgDD
 YZFFF8r6oPXzPt3/o8iBX39/vRmWJ8T7FyzVoZ/e/q/69+3wwBn5LhYyhqNVLu5jsGQr
 6YwjTcXhHX4rjxzlAeIpQM0xtiSjhK3seFneuoaDejtOinBorT0wAZZ0SLmoNpZlCrJ3
 QuR3EGT2qS3QLn172GKRRow41lcD6v2fElkoK2ZXqhA6QL3Bl3U8JPCSpMiCC2y44VkA
 Hjnr9L5ez9dCgPRzyXvfYYsnJpHduZQVbBdb8hG0W/gBJoDAfP7jYYwWnFVS8JtIO2LR
 GlTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793633726; x=1794238526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1VmlI/ur8pujk541VodzhFgp6hX5xM0UtNlOZvLTJKg=;
 b=IlpN/sOUfE8hnS4SwOXvVpk+qQKp6ZRYvVS7UH+THFjoaOVAErAtEE7MFdDzGQ0Oam
 cXg6LqvU4yiB2Oj6S+M6h3CFEBs4A83R1yYqO9aEu6xQkEgankCQvmJC5sVon9UkI5zq
 GwLAK7fc1PJuomGlpuXTOYnqbBfrjj630vcUCe2U8XQ4dJ7G3Kek+e1ifLoTyKC06qmo
 d4rUID7SH1IVXmTTojnp/dpHaEZcS1BXu2fg/M+hlp20n7tVBweFgiF4oiXuSvcIsBSP
 74Sfpf2GUiNkCU5SK58f4VXcw4HsP7X/vz0hCDuWq0NL1bdokuaq5w5MQuliF3ZiYCCv
 ETVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793633726; x=1794238526;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VmlI/ur8pujk541VodzhFgp6hX5xM0UtNlOZvLTJKg=;
 b=hMd4qJg7DwE97xzUCxe8S1wqvQup2Z+SvbQVNDkAC58XSFFil8pnfueBOOgvk2qrDX
 h4Y5Olp1OtC5KlBSwh7EbQEwJBPt+ciFBRoyXLYQM0fJZvIDuE/66Mw6ffHrhY3b4aM2
 HOT1uQtE4Cs1OSY148672O/U80+h4rIR2HgVl13W8MXBmoT4M8WuCPlj28ZtfXgNHg5q
 2Spfs1p5rLNVKcD3sR/Omm7kEn+WY9+t7Au3PqnoS2OhhXc60DoREB1eVNZVMHWd6WK5
 J1EmAsaJcgv/S3YUfNoDokeYP5i7tmmcgtkkhRvMI669TTwUNafYN7I7O88d4VBI/FA0
 NzlA==
X-Gm-Message-State: APuU4Z+BDWpoJ/iTe4eP6Pm2Z/d0qbTIjai7s6uTwSX4Bn05KW+6JWdJ
 4D8va8fH/R6jCaeek1j+V2W7SjzvX9Wsnj8ApTHqttuRDEhRujKH4VeZMIGr6VPGsUJP2s+3/Kb
 i6AIQlhniR1RMsYN4GPt7XLq+x/zQChE=
X-Gm-Gg: AYBFou3ogJwaslfG5zn3NzR/XJageOVNVA357dqyv3V5kwT4G3E4mq3D5UUPP6Zk+Uv
 7Helh83RX5HsCwqmOi86Q9blNYekClCA/2m/bmq2ZTCQzS0mrwsrcR9o9drutHht1OIIyH5l2Wb
 6Y73ASV1PTOe+vUa0GLU4ENIN4+pgcS1+f8vyT6DJoH9+9uW+gU4HSrwr6AB5z+Oz77qSvJMyig
 ns5DQl4ln+Qpce9okUzL+w05z5hvLg9hopSg7QSx+1psPD41ankL0HGoBbXR53mUKMcNMiKxXPu
 pTsBIvdeLMWJqVKD1KzS0ODRiQk8AhwuzIzCmfqBJnEVm2PG1GtcrusZuvqJg41qW5A87+izVWs
 XaEFONO4wufk/FH3IzW+7DQmDqBmrOU0Yydh6po+YtOiaHe8zSqQsLA7CeYinlcJKWg2JhGpG/l
 sST0enOt+Li7Pck4A=
X-Received: by 2002:a5d:5d84:0:b0:48d:f4e6:7b2 with SMTP id
 ffacd0b85a97d-48e6e2ef836mr26445121f8f.3.1793633725752; Mon, 02 Nov 2026
 07:35:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CACOV87VBmya0PKjni5xEYxUaEczk9X_UoUHXSR_HDS2kSJnM2g@mail.gmail.com>
 <CADnq5_MzmNYq0WA5HFaOp6E3WO82YqTT5opCgkAbvv=9Q8AQnw@mail.gmail.com>
In-Reply-To: <CADnq5_MzmNYq0WA5HFaOp6E3WO82YqTT5opCgkAbvv=9Q8AQnw@mail.gmail.com>
From: Nathan Blomquist <nblomquist@gmail.com>
Date: Mon, 2 Nov 2026 10:35:15 -0500
X-Gm-Features: AclHuK962Noi3LW7yElw2uoZtZQY-4IYY24WlF4N7jEb4zcw_35WPIcdhBVu4mU
Message-ID: <CACOV87Wp8a8v_tn_UDD8mF6mo-ToSUMPefRT=RVbC-uQuZyqoQ@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: Navi 23 passthrough fails after ef5fcf2a6c32
To: alexdeucher@gmail.com, lgs201920130244@gmail.com, 
 Mario.Limonciello@amd.com
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev, 
 alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Nov 2026 09:36:47 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

On Mon, Nov 2, 2026, Alex Deucher wrote:
> Can you attach your kernel logs to the bug report?

I've added the dmesg logs to the freedesktop report:

https://gitlab.freedesktop.org/drm/amd/-/work_items/6076

Thanks,
Nathan



On Mon, 2 Nov 2026 09:09:44 -0500, Alex Deucher <alexdeucher@gmail.com> wro=
te:
> On Mon, Nov 2, 2026 at 3:16=E2=80=AFAM Nathan Blomquist <nblomquist@gmail=
.com> wrote:
> >
> > Hi,
> >
> > I can reproduce a Navi 23 / RX 6600 (1002:73ff) passthrough failure on
> > unmodified upstream Linux 7.2.10. It happens during the amdgpu-to-VFIO
> > handoff, before any guest code runs.
> >
> > Revert/add-back tests on Proxmox kernels isolate ef5fcf2a6c32
> > ("drm/amdgpu: fix autosuspend cleanup during removal") as the trigger.
> > Removing its added call from -20 works; adding it to working -19 fails.
> >
> > Tracing shows amdgpu_device_baco_exit() returning -ENOTSUPP (-524)
> > during runtime resume: the live BACO feature reports supported but
> > not enabled. The exit sequence is skipped, and a later bus reset
> > leaves both graphics and audio inaccessible.
>
> Adding a few people. I'm not quite sure I follow what's happening.
> Can you attach your kernel logs to the bug report?
>
> Thanks,
>
> Alex
>
> >
> > The candidate below keeps the autosuspend cleanup and allows the exit
> > based on the selected runtime mode. In two clean baseline/candidate
> > build pairs on upstream 7.2.10, the baseline fails and the candidate
> > restores reset recovery and guest graphics/audio initialization.
> > Sustained rendering and repeated-reset stability are not yet tested.
> >
> > Is the selected runtime mode the right condition to use here?
> >
> > Full report:
> > https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
> >
> > #regzbot introduced: ef5fcf2a6c320676bf8be2dadac93d9023b468b7
> >
> > Candidate patch:
> >
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6412,8 +6412,16 @@
> > {
> > struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> > int ret =3D 0;
> > -
> > - if (!amdgpu_device_supports_baco(adev))
> > + bool runtime_baco =3D adev->in_runpm &&
> > + (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO ||
> > + adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO);
> > +
> > + /*
> > + * Runtime PM selected BACO while the device was active. Firmware can
> > + * clear the live feature bit during D3, but the matching exit sequenc=
e
> > + * must still run to restore the runtime D3 policy.
> > + */
> > + if (!runtime_baco && !amdgpu_device_supports_baco(adev))
> > return -ENOTSUPP;
> >
> > ret =3D amdgpu_dpm_baco_exit(adev);
> >
> > Thanks,
> > Nathan
