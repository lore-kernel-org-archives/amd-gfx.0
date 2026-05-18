Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE19ECD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147A810E329;
	Mon, 18 May 2026 14:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaarwUzN";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D6010E329
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:23:21 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f24905306dso163517eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114200; cv=none;
 d=google.com; s=arc-20240605;
 b=lxOeYJ7CZDC4zbY/quwxPh6OEaNhEHBGSKR1gqV7quRJCDSzcDBwMvHlZnRjo7g96J
 X4lb1tWJsEZkrgxAHNU8qHL0OuFVZdxpkFxMmoYWeJVlrNvnwH7NE7ScVGWAFaQkXO1S
 WXm6A+F/eWQSg1SYQGiNFJ3A73bnItnJRgEHx231CCIS4CICA93us4bsbFQXlQ21YMcg
 5OdkqhHW6O7UHVr358qEj31SeAu3Q9IBb49BHX7iRDvFCU+UeloNy185HLy6HvSZ9My7
 BnU3oVBpCLMNx0QugFp+0HMaCRkE5ei9pmDr6TR4edJcH4iQK0fBOBVSmbUl7y+navIS
 uZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zwu0oRHpCCQfq/phaRSC6OzwRfYGO4XIvJ0p97gM72o=;
 fh=HvLMCjlYAuZwbmOI8Oo+vDJ7d+p26BxKsyHiyd0mNtA=;
 b=AUj0G9QkIWIEu2N9DP7u8gGYLKw+yy2mtltnFYESYNlWOSQeeEY073EP+DQWjGwb3A
 unhVhFEMsDyx81K46hRFr8IxMkvgjET8pE/QwMs5oFzl5cMQnKB2mqM+STeSkLkfAdBy
 IvS88hxtOtqEP+Cz4eZYawnTgRbdywBfdohqWhWv9/7H2z90j9dDspn1cPex1ACrFR3d
 X0TsWBDT1LTxF2iYmfgI7ul316iCe9KOCYLqiOb92Q975k+eHL5FEJZftmnR+INGrOPN
 DZSNrFR2RsypqLz7sFhFDUYmGGua18HQeJ2FzTMGnNqhHofVPxp1h6Kc+bMJb3oYdzYp
 PrMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114200; x=1779719000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwu0oRHpCCQfq/phaRSC6OzwRfYGO4XIvJ0p97gM72o=;
 b=UaarwUzNh7QB+jH3ilEyprAaOh5qVtbBsuehhbSYo6Dbt0aibPK71dtHg5zrUi6dbx
 ROvG73xxi76OY3nZ4OzRVYnjXPUl/nmY9/+NACA63jT2/QIYl+nuImriZofHw97Kne7H
 XXFLYv6kA37zqjbhWCv2RzXmXD+3oPO0qXxeKsPxnt+PQpnfm4pX52kJ8JyTc6L6uSZK
 JeoZ/6t1djG77nPvuglBmMH6tcaO2INiSXLf2VMjXnGcjk0t6NYuVY8LUy2eVigTUsUO
 H1qr44s7+jbcNcuHc0c55OYsyZjbokvyS3O5jK4LFv909jlFO+j7QiRHN3u0HFcyf5Ba
 wyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114200; x=1779719000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zwu0oRHpCCQfq/phaRSC6OzwRfYGO4XIvJ0p97gM72o=;
 b=Tvirfx40ilnA6hnb3lCBtFWw5tx28hsYcFi9YF04qe1ie/c+aq5WcAbHX/JBleikbJ
 NwEcoBienEs7pmnEqbYxrU4Mb4DeJLMB5oNbWXVHkX7XvkzflPt6KYjRYxQiATwNR54L
 2o9sRImO1MI/KAXfhProI7LE0GJD/l6rDqsjOM/enLEd/lc7ypVKgMSPWDBh2g3unhFc
 JV+azCY5iP9URjU14kXxKVjiIaUgC6gXhF8Y1qr+TkZoQ8mNf0QII+tcTcu8VLvpfT3V
 FaTNA+dYKFUlMvQMXfB131S/5lMvGm13ocZfnVdquGdVgiMgGkO4TAAZBNGQyODxXOJB
 0ygQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QguFYK0XOzeU2yFECc90otIvYMfjc5h/Z8x35+O97goVEpw2FncM9jZB+ORE3VZJbVjwFlXcX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzWwuqybhc/CeSaXVS7G4r8DXv1FgvBK5An3uTZ+pgbpzwcWak
 8ygF+4OPtiOulBayC92/OfeMN+qW5bOwf+qo2odmN3lZcDR/ZfbfhRfJq83DLdzm4D+68Jm9/I+
 qZe6GvkAW2+H82gWi0CZFutMrS4roQPU=
X-Gm-Gg: Acq92OGK6jsw0K+kDu3WtHe+uF6EciSxcLwGQ5OFpoQZ4Rfn0TszXNPSgG/kQqLAnAK
 UXNt+8vBQObrMF+u+Cfb+FK0KqQU9+Zn5sznuqlKckab6xoMS4WP/Rn8yIQxdaNskk78rrzAUZQ
 OeM6hp9SH/aEywZJxvN01MQnh1P4q6iL5gfC+rjD8uxbTcPMxTG/XimvTnbnfTodXV9MpNo006/
 7CEOpWjBD6/6rJXqPrpPkyIrlWBRlz8McIaR+bQobdfNVCFjsEQ+xewlG+67YZqINrKTTNKt8gJ
 MDdC4N8yhiJAPRkLs6KFYYvArNVeAYGRR1bRAeAaodk7/QW6gEn4KRLg50TxFEi4KhQEpw==
X-Received: by 2002:a05:7022:f8a:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-13504525046mr2894588c88.2.1779114200472; Mon, 18 May 2026
 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260208000255.4073363-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260208000255.4073363-1-n7l8m4@u.northwestern.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:23:08 -0400
X-Gm-Features: AVHnY4JUU7D5KQcWeSUQF6foLgyk3bLCNxbtKBkEADllVhBA3EuS8e9rBkuwdko
Message-ID: <CADnq5_Nn69ZYnyPrvRdP_jn7XiG-850nC0kSTi=m6ZecMUsXVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Mon, Feb 9, 2026 at 5:37=E2=80=AFAM Ziyi Guo <n7l8m4@u.northwestern.edu>=
 wrote:
>
> kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL) at
> amdgpu_gem.c:1050 uses the user-supplied num_entries directly without
> any upper bounds check. Since num_entries is a __u32 and
> sizeof(drm_amdgpu_gem_vm_entry) is 32 bytes, a large num_entries
> produces an allocation exceeding INT_MAX, triggering
> WARNING in __kvmalloc_node_noprof(), causing a kernel WARNING,
> TAINT_WARN, and panic on CONFIG_PANIC_ON_WARN=3Dy systems.
>
> Add a size bounds check before we invoke the kvzalloc() to
> reject oversized num_entries early with -EINVAL.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioct=
l")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 3e38c5db2987..ef5d8bd216b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1047,6 +1047,11 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>                  * If that number is larger than the size of the array, t=
he ioctl must
>                  * be retried.
>                  */
> +               if (args->num_entries > INT_MAX / sizeof(*vm_entries)) {
> +                       r =3D -EINVAL;
> +                       goto out_exec;
> +               }
> +
>                 vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_ent=
ries), GFP_KERNEL);
>                 if (!vm_entries)
>                         return -ENOMEM;
> --
> 2.34.1
>
