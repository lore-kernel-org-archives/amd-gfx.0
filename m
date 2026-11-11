Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11123606A88D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQlhtLxQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FF510F380;
	Wed, 11 Nov 2026 17:04:27 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9F110EAA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:04:21 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36ca32a0faeso93542eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416661; cv=none;
 d=google.com; s=arc-20260327;
 b=iMj63E6GpH1CrN5vhbL9DVleIXVOE0XcQdoTpK13+wXZCFclcCh8b4EHEXL6mANDxj
 YRw11WWkFfysbgYELvp5U6Mo/SJD6YV186xiOBhYldobz8QVjGiw3oaoc7+CfzQUbIdh
 a6riHECL+tuGFPE4FAmP28lHbc/q1fvdQ1hj3LdGJijLZ0IAcnONMsWQeCRrKFcRPIB+
 +uxWqcYsvAsxPwphcYDwQ/MQAcKEpefrSfAvOJZG0L2Xy50fKgoNuvbSPW8ePLFtAlbD
 Lt9uT4tjn2gJ0++i6WAGdcg/2PJbV75gqlnMG3Z4WAhyMAA7hoEI4+0j7gfvozgs2AU3
 B1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sz1fBEHUL8IGMULI0g/KGEQw0Ms9ofA5l42B+4Sj0Rc=;
 fh=2aAAWObPKeJ98uL5C8d3nHPi17RfdRSBMWjN/SNk+bY=;
 b=LqZaNq6HdYJuoIfz22a/a+4hOiJ7xGg/I8X+Jq6bUZA+QA8k6vQtefhC06RreuNrzA
 iLvopHzGkwHAWoE0A+T479PcfSUB0qE8CKIsziF5bYHFuTugyLkLPw98O4y6Bk5c07nm
 2Fe/PDNfR8+nwyV4E6gwVihBR30QxTKqkuyqNMdyDXnBNyrnxFyoWEvNvRlfU4I/qfgF
 z+e+DDIIrD05soTuFw+dUJtI0GaDn1n9X8U5Kc9LIRhMdUs2IMWNe9RR2BZ9/IwGfJPQ
 AjLTn3s0MJrhw3NKuQKoPouKXDMnehTwRR+RhEJke0Lst1duPEGxqPY8gRasbFo3dwtW
 7Rxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416661; x=1795021461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sz1fBEHUL8IGMULI0g/KGEQw0Ms9ofA5l42B+4Sj0Rc=;
 b=EQlhtLxQSin6//nTzSHvKKY5YcuhW1e8fjwzw1V0FKtlTp7Eec8ryYO7lxKOxc7Dm4
 ZQ1xIUwnK6sQKlbZtoy++AjRAmwbl9vlZmWPgPN55O9qpup8rnD2+/t0KZq4Wmgqobkq
 4PvNnofqvfj771jyVHp0R/3s9b0s+POElIdmFGmtk206AEnB2ETCxbWmFjBuN2BO5z5G
 jOk4c5nCGHlPE1R3011NMH9W3lsYOlbZ0ce47tTKsZO/9K6CHIfCqpLOxR2zaEEpAe3D
 ncactd/ITkua/x0yGX1pdeRlOkdgdfkNhznYa/ITM0t0bn2n7pFpcXqgSuHdK31Nwbfw
 bm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416661; x=1795021461;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sz1fBEHUL8IGMULI0g/KGEQw0Ms9ofA5l42B+4Sj0Rc=;
 b=ttBnPD3OVVdFAogcJBiuHJQCV+Ouaw6QnPqepjuIVuZiW+R95Oq4DmFCWz5TYS2RZL
 qmSDusGBodaPThCOLYHInaT2Q2OvyqmyDccYcOdo1MwAIw63QRvxZlGJunJpC7PtAWPE
 R1v0/dXWeL2itLoovNp+lqG1D86AmH0hkm2OVqXkf9FEuC6g1XyIcw4J9rnWlhBIAeZm
 b4V3ZYyGaMq6DS3HbXa3XZnfgVs+pjKGsz0/YOmJkJSLXAfZQgtoBF2SeqRVfJtRBclQ
 63k46tid3XoRpCF85wBblc0VAo5fbZRrRlSpmZJS5xLxK0lURDDIrvfspM3HUT/1LGk7
 UrHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGmwYZInWLLRvQmetF9OPUwodgZHfz1Dolz5pyBGo0tp1h494G+5DfAlKPltvhsTGcjTJkEtARF@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+knhXBe6EDxXt/HvHRc9FzOgvSawWpdf0Zz/aCoXq6AOMIPVEK
 gtfLS2QPXsvKI7vGF34jlDs9lEaca1MHTlwJ4yMkAPtOvSHB5Xk/iU46z66bIOAsX0O+2Op7ocM
 qrR08Edah0m/z16K6GzJ6pYcPVd9LXbY=
X-Gm-Gg: AYBFou2LwVZE9uCId1No3A9Aa6R6HsKouJXvXEbHnuOT9SlZhRMwlfmNEHhIntfoyyd
 1gKHwg2VGV1RORoDYSP5cctG6MGiH0X+OHSWeXNRnzvW7DkY9fXW9MQx2hKIGbxleHC35zjPvHZ
 pU2AuYidS+wMOsW2mK2aV/S/lD9D8NMAX3Pn9kawotE10LeHBjOOorT/i1TPbXQKFyEE+14taTM
 7tp1VSGrfXB2Zn25jUK2GixVmCjtFrfE/CQru5m/hG5UCYZgEPmnu0kWVJ/e5tTjaiMQ3vikYpF
 RE9Tu5kWTErK1LaW6NHHb+jZ48Z/a0UEZg7xHKW5o3mBMLshQ680laEQ4hXfgLXW6TaPDL3zOPy
 bPVEzp2XH8pY8s5g/BxVGhlBnvnftMFVTry1hm9GnrpQQJDY9+tIiTSvPjrp3CiOXd8iwdD5Grt
 l+15xPpNTIKJfxL7m3d+NoTT4yZMAc4lTj3LsgxBJqSZYFXZiYlOyWZbhvPCQ=
X-Received: by 2002:a05:701b:450c:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b3c02cf135mr4314767c88.1.1794416660805; Wed, 11 Nov 2026
 09:04:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-smu8-sclk-fix-v1-1-47c6c0c8c2c9@etsu.edu>
In-Reply-To: <20261109-smu8-sclk-fix-v1-1-47c6c0c8c2c9@etsu.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:04:09 -0500
X-Gm-Features: AclHuK-qUsJmbGMoQgyzTNraWEn4fQl-1Spvcdq8IIpAnzBeguVmCP2_i5NrNHY
Message-ID: <CADnq5_OQfN6fqdW8OzhPAE=iOmy7OtH9VV=6-dxfwT5=R39OPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: send smu8 sclk level indices,
 not the level mask
To: hornejd@etsu.edu
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Eric Huang <JinHuiEric.Huang@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Mon, Nov 9, 2026 at 9:21=E2=80=AFPM Joshua Horne via B4 Relay
<devnull+hornejd.etsu.edu@kernel.org> wrote:
>
> From: Joshua Horne <hornejd@etsu.edu>
>
> smu8_force_clock_level() passes the pp_dpm_sclk level mask straight to
> PPSMC_MSG_SetSclkSoftMin and PPSMC_MSG_SetSclkSoftMax, which take a
> level index, as the other smu8 callers do through smu8_get_sclk_level().
> In manual mode, "echo 0 > pp_dpm_sclk" thus selects level 1, "echo 2"
> selects level 4, and masks above the highest level index are out of
> range for the SMU, so e.g. "echo 3", "echo 7" or "echo 0 1 2 3 4 5 6 7"
> do not select the requested levels. The original single level version
> sent 1 << level and had the same problem.
>
> Send the lowest and highest level in the mask, as smu10 does, and reject
> levels above those the SMU has enabled, as smu10 and vega20 do.
>
> Fixes: d7341ef66870 ("drm/amd/powerplay: add some hwmgr functions for sys=
fs interface on Carrizo")
> Signed-off-by: Joshua Horne <hornejd@etsu.edu>
> ---
> I found this while working on overdrive support for Carrizo/Stoney on my
> laptop (ASUS X555DA, A10-8700P); that series will follow separately.
>
> Tested on that laptop, 7.3.1 with this patch applied to amdgpu. In manual
> mode:
> - "echo N > pp_dpm_sclk" for each N from 0 to 7 moves the current level
>   marker to N
> - under GPU load, "echo 2 3 4 5" keeps the clock between levels 2 and 5,
>   and "echo 0 1 2 3 4 5 6 7" lets it reach level 7 again
> - "echo 8" and "echo 0 8" fail with -EINVAL and leave the level unchanged
> Without the patch, "echo 0" selected level 1, "echo 3" and "echo 7" did n=
ot
> select the requested level, and "echo 8" was accepted.
> On amd-staging-drm-next the patch applies unchanged and builds without ne=
w
> warnings with W=3D1, sparse and smatch.
>
> I used an AI coding assistant (Claude Code) while working on this. It
> found the bug, wrote the change and a draft of the changelog, and wrote
> and ran the build checks and test scripts. I reviewed the change and the
> changelog, ran the tests on my hardware, and I am responsible for the
> patch.
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 8f82d7c07e8c..5a3f697a37a2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1483,15 +1483,25 @@ static int smu8_store_cc6_data(struct pp_hwmgr *h=
wmgr, uint32_t separation_time,
>  static int smu8_force_clock_level(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, uint32_t mask)
>  {
> +       struct phm_clock_voltage_dependency_table *table =3D
> +                               hwmgr->dyn_state.vddc_dependency_on_sclk;
> +       uint32_t low, high;
> +
>         switch (type) {
>         case PP_SCLK:
> +               /* the SMU takes level indices, not a mask of levels */
> +               low =3D mask ? (ffs(mask) - 1) : 0;
> +               high =3D mask ? (fls(mask) - 1) : 0;
> +               if (high >=3D min(table->count, smu8_get_max_sclk_level(h=
wmgr)))
> +                       return -EINVAL;
> +
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_SetSclkSoftMin,
> -                               mask,
> +                               low,
>                                 NULL);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_SetSclkSoftMax,
> -                               mask,
> +                               high,
>                                 NULL);
>                 break;
>         default:
>
> ---
> base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
> change-id: 20261109-smu8-sclk-fix-2eacba2cbfc0
>
>
