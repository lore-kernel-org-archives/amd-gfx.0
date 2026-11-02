Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D1606DEA3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BhkpP4LS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D4B10F025;
	Mon,  2 Nov 2026 15:45:12 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9245310F025
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 15:45:05 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36a6b774d12so166774eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 07:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793634305; cv=none;
 d=google.com; s=arc-20260327;
 b=Cq96CCCGY8jrPg2f5pZgF5B9vMoqTdIx4gfOh9AFwenWhb+4zpK5E+fQV5qGmYU3ya
 rx/Gwv4Zs/WUxeduzuGxur7Zy9av9KbEBm/Rr8dFMIAtpisiLuMruaqcYCx7vHCeYoiJ
 fUJDyixDh+MSVQYd5Pu1iKNUk0adYa25cvihbOE/EXClmOI+v1fHPlHsvyJvyZOSd+Qb
 6t3tCtD+lJOJyNnrRV5UGDk+F9v+2Opuh2+lld3j729eAHIjqkqT/zDjLqUR4rQHVQZD
 IK6/K1AE7jQQFGjcOytCOccJu1fzGBnmILlG5BBw8E60vi8SVEbZ+UD9GvENGhr6y1GO
 Upsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=05IiFonSm6eBBAqgPLufvrqdzAJJzqBhzkv+n6uxPk4=;
 fh=KmEcLSoDuT/LxiUYXyu4Ih6k3bp5NcU8JznpJKfJSYY=;
 b=a+ED0oX4MJPGG6DsyvqU8GTVykeqsy65cP8qZAkGUpJtpO80nMy0xml9gCgRdKfdpk
 Oj7WfHddRfBispSSoqsbb8Tm/0VXY66QEKgijF9m2+n3Fb7li2w0UxeTqkVZUItKF61c
 /EOJt8x3RfNdS0YiONdJc5T+MaZrQnk2jkU8+WkDo54qiSmnbwb8fQMTEyg4hjuZ4uHZ
 z5grCQM5Zl9NA+YpD7vnwNERW56LDbB28fj/RrgSSia7O08J9kOTvOgdjVEbYX70SgA0
 7cUD6dZNAtMPKbHNGebEJPz5YN97oMcRtF3fiyCHpGHBppNjRMIyFvHuMpTn9tm/oqPk
 GxoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793634305; x=1794239105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=05IiFonSm6eBBAqgPLufvrqdzAJJzqBhzkv+n6uxPk4=;
 b=BhkpP4LS7GndQkmDBDpANFTwUqiq6r2fNHNEL7yMTAQKmInEvYYIOY6+5Sf9F7K7fr
 SrfLynBfi8g5IDoH7DvVlKMiXiAwDpKE4Ia1DMz0eNxY7AMFH+3J2muXV7AamRVkCD7e
 NCDyA/zojnJpC1wNYPuSsfDufEojfzYCgNttWHCsCSTNI1jJv3RH57YYIi59vwHW6I55
 /5wI3JWyI/SU5iKK3JwGlPCccaHCf6BVQsJtUuA5gAl3Odjy4pCYB+RDkkTSMF60/pNE
 kKUR7b+4mAW0st3inBFkjA+tMh4MDEkORP67dfoxN3nqvFOJF2lwaGNOXM1fgdPXh/1W
 jZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634305; x=1794239105;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=05IiFonSm6eBBAqgPLufvrqdzAJJzqBhzkv+n6uxPk4=;
 b=B2doem6K64WlLzCapToBMHGuLhCIYLU8zvoZ1npwJK1OdVUAVTgyuSOqMv1PkSOy2p
 f+Usww1UTzuRJE8gK0ciLz7P962MzGZmg1z6ocXauMqg+AaA/oFnPU84GZkBrytJh5F4
 3pPMRvjRJco5GlQgwDbLeDp/HXWmV8zauMAjEGGNwUXIkytciX3NamUjDWFXLRfpk7QM
 quRjIKI39wzvaN+fL85gBBJJGQ14Di67OnDKU5XjYhuxL4OQ5CvoPCidBcSWqEgf9phc
 6tVqobMyr4VedYHoe8I+9fuDPSvs+wGLRgcIy8PbywfQKn5nYuKy5elMCCJSeT1lLU/b
 Cw2w==
X-Gm-Message-State: AFq9FYLzR80Wp/9PmgAphixTbM8w78QF8MABSaCXTIK1paMqKxIBVB8M
 lCyE9eM8P/dYL0ybFyMophcJ7mGEFwhlRhF0mRmiMuwi8Smj0ZbohRkGZE2wdIVMRxyqiVYWPcQ
 9HHCsTDYVN+r9QaM036KXaYH2HsdvpO8=
X-Gm-Gg: AYBFou1YRFlkWNQXqLshsL49txaVlu3Rwr0OvtuqjldyK7P/iYo1XiLt6fLm0YXStVd
 zjaMTsFFj+6FOwWI+kNbfc57q0dDHSWtWbl3ekeqP6xjAhGvLOTKWS8KOLxnwyDON7sM10lBYW5
 ED5dtgG5mGzMygQW6lNQyZOjVaoMnjUItYmT3notxrm+n4d0aPM4ye9oozjQZvJcEf2puxlIO0m
 gStyPwBZ3wyHmvOAu/Ekf6SDjLZ2p195yn8sOlRgEWhH22K7jnJQ297C+m8DYfGQqQ2eeTyVRY6
 eVW3iD34wTOnCL4O1JOnlqIDkjyXbQCK8F4THv/dm5riWWHtBJTP/uQju8snDyhHOuDDuMaf6CB
 p5vIXeTCBZwGWQMTHNQ4YxIssCZ5cjqWsCYFEfiqMN7DmJZNzQ0tOoTsMIwWTMs3Qg0sZOpAdJP
 qHPlqP/zpbQF5iQi4lxtHheDE=
X-Received: by 2002:a05:7022:eb46:10b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1ac4fd01362mr25263442c88.0.1793634304695; Mon, 02 Nov 2026
 07:45:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADA0SBzOP_gafy2+1r9WXx13U6aZ9LDqe76=LedgHPSdtceu5Q@mail.gmail.com>
In-Reply-To: <CADA0SBzOP_gafy2+1r9WXx13U6aZ9LDqe76=LedgHPSdtceu5Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 10:44:52 -0500
X-Gm-Features: AclHuK9WdLfq8npuOIiRJANoORyglaMUV1oYQxF-ix2yzbBA_sF2fcYjYWLSBoA
Message-ID: <CADnq5_PFVGpOnGrtLk3uuX_aHW4MM5f55P1_+ENDydBL5xsGEg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION=5D_Krackan_=28Radeon_860M=29=3A_system_freez?=
 =?UTF-8?Q?e_on_AC_plug=2Funplug=2C_=E2=80=9CSMU=3A_No_response_msg=5Freg=3A_f=E2=80=9D_since?=
 =?UTF-8?Q?_7=2E2=2E11?=
To: Ashaz Ahmed <ashazahmed72@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 3:07=E2=80=AFAM Ashaz Ahmed <ashazahmed72@gmail.com>=
 wrote:
>
> Hello,
>
> On my laptop, plugging in or unplugging the AC adapter causes a complete =
system freeze (frozen screen, no input, requiring a hard power-off). Resume=
 from suspend also became very slow. This started right after upgrading fro=
m kernel 7.2.10 to 7.2.11. After downgrading back to 7.2.10, the problem is=
 gone with ~6 days of normal use with no freezes and no SMU errors in the k=
ernel log.
>
> My Hardware:
>
> Laptop: Lenovo Ideapad Slim 5 (14AKP10)
> BIOS: R0CN27WW (01/09/2026)
> CPU/GPU: AMD Ryzen AI 7 350 / Radeon 860M (amdgpu at 0000:04:00.0)
> RAM: 24 GB
>
> Software Information:
>
> Distribution: Arch Linux
> Kernel: 7.2.11-arch1-1 (bad), 7.2.10-arch1-1 (good)
> linux-firmware: 20260916-1 (same on good and bad kernel)
> Mesa: 26.2.5
> Desktop: GNOME (Wayland), power-profiles-daemon 0.30
>
> Steps to reproduce:
>
> Boot 7.2.11
> Plug in or unplug the AC adapter
> System freezes within seconds
>
> Occurrence: most times I plug or unplug the charger.
>
> Log from the frozen boot:
>
> amdgpu 0000:04:00.0: SMU: No response msg_reg: f resp_reg: 0
> in params:00000007
> ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS =
failed (-110)
> ACPI Error: Aborting method _SB.A018 due to previous error (AE_AML_LOOP_T=
IMEOUT)
> ACPI Error: Aborting method _SB.ALIB due to previous error (AE_AML_LOOP_T=
IMEOUT)
> ACPI Error: Aborting method _SB.ACAD._PSR due to previous error (AE_AML_L=
OOP_TIMEOUT)
> ACPI Error: Aborting method _SB.PCI0.LPC0.EC0.VPC0.GBMD due to previous e=
rror (AE_AML_LOOP_TIMEOUT)
>
> The SMU message repeats every ~5 seconds until power-off. The first occur=
rence in my journal is 2026-10-19, the day after the 7.2.11 upgrade; no ear=
lier boot has these errors.
>
> Full kernel log and amdgpu_firmware_info are attached. I'm happy to test =
patches or bisect between 7.2.10 and 7.2.11 if that helps.

Please file a ticket on:
https://gitlab.freedesktop.org/drm/amd/-/work_items

Also, if you could bisect, that would help a lot.

Thanks,

Alex


>
> Thanks,
> Ashaz Qureshi
>
>
