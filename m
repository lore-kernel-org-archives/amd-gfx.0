Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C80606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=LGMzw5wf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E11112586;
	Fri, 13 Nov 2026 13:44:25 +0000 (UTC)
X-Greylist: delayed 350 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 20:55:03 UTC
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC3710E6D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 20:55:03 +0000 (UTC)
Received: from relay12 (localhost [127.0.0.1])
 by relay12.grserver.gr (Proxmox) with ESMTP id 8D0E9BC45F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:49:11 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay12.grserver.gr (Proxmox) with ESMTPS id 23AA2BC5D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:49:11 +0200 (EET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 90FCF1FF203
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:49:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1794516550;
 bh=9ma6amb3jVGx0bKJXzm3aPnEA8Ez1v4zIZS13LyEIGc=;
 h=Received:From:Subject:To;
 b=LGMzw5wfLgAf6Uku+US6Vm3b+iysZtzTUPsGNxGcsBaCdUnafHkWf7fXTJFhxDBCh
 NLMje34OkDgO6oyQV9yKMQN5YUIuF8ORQbd/CZpZ6SLanH2qlHxXh4fdPG6UC1uhRV
 9Jd7SS+oQnwezk3hv0DBkr7eFGauXwICp/86h4o1SD3UmI7mFgfh6+wUVChTC9Alow
 NkKEsCwOB50dgv4lL63W+3C6KY+SWipdLz6qtzt1uH60Lodw23oLjZAGiNmlNN31/M
 mqLVvp+4XtrebThC2dhS9Zmv2LoWCFBV+y0gPiu2AdfslLyUR0NIpb1x3jONI0qZI3
 xP9k0iyHLdhvw==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.214.179) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-pl1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2eb18f4da15so1369155ad.1
 for <amd-gfx@lists.freedesktop.org>;
 Thu, 12 Nov 2026 12:49:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErFHmd19xsSMcL6RVG4/rZ5Qn/2GN/8d2V5aqP1DYT7Wp/0vDTpSoR1tPdMJ6ukoxeFII8YME7AT@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/oZLcKm7pR1og72NaiMnGe6FQOX4zE6569x/Rfe9+j1TUFeipH
 22hroUM9jf5CA3nnf2k1D6xIFgnGZU6lGlxqmwC2m4TxD/LHmgEJfouzF+oJY6rq5DMusqZoBe0
 fbzScaxtce2BcSj8uoY3CS9LLFqODmSY=
X-Received: by 2002:a05:6a21:6e8d:b0:3eb:5240:b62 with SMTP id
 adf61e73a8af0-3f7a8cd6faemr250802637.78.1794516549069; Thu, 12 Nov 2026
 12:49:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-dg310-pcon-vrr-v1-1-4888b7097218@gmail.com>
In-Reply-To: <20261112-dg310-pcon-vrr-v1-1-4888b7097218@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 12 Nov 2026 21:48:56 +0100
X-Gmail-Original-Message-ID: <CAGwozwFhgPDdjYba7+dWNK+ny6AP9fcKtatjng+AQoyOWuZz2w@mail.gmail.com>
X-Gm-Features: AclHuK_xIPmQ2z2HO_DxO1WqNN4hcRgv4_7ApKQev4NGykxq_WmKXFHFinV8QNg
Message-ID: <CAGwozwFhgPDdjYba7+dWNK+ny6AP9fcKtatjng+AQoyOWuZz2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add ASUS ROG Bulwark DG310 PCON to
 FreeSync allowlist
To: jkpair@gmail.com
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <179451655080.1500951.13605205427223573225@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:44:24 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 21:46, Jameson Pair via B4 Relay
<devnull+jkpair.gmail.com@kernel.org> wrote:
>
> From: Jameson Pair <jkpair@gmail.com>
>
> The ASUS ROG Bulwark DG310 dock exposes its HDMI 2.1 output through a
> DP-to-HDMI PCON with branch OUI bc:be:fb. The PCON sets
> MSA_TIMING_PAR_IGNORED and ADAPTIVE_SYNC_SDP_SUPPORTED, but it is not in
> dm_freesync_pcon_whitelist[], so FreeSync is never enabled on sinks
> behind it.

> Branch DPCD 0x500-0x50b: bc be fb fb 48 44 4d 49 62 01 40 84
> (device id "\xfbHDMIb", hw rev 0x01, fw rev 0x40 0x84)
>
> Tested on an ASUS ROG Xbox Ally X20 -> DG310 -> Samsung S90F (AMD VSDB
> v3, 48-144 Hz) with a 7.3-based kernel that also finds the AMD VSDB in
> every CTA extension, as the common EDID parser does since commit
> ac10a874fc8a ("drm/edid: Parse AMD VSDB for FreeSync refresh range").
> With this change VRR is reported capable and works; without it the
> connector stays VRR-incapable.

Move these 2 paragraphs to below the trailer

> Assisted-by: Claude:claude-opus-5-5

Remove this tag, it is not used anymore

Wait for others to chime in before sending v2, your first paragraph
might need some tuning as well.

Best,
Antheas

> Signed-off-by: Jameson Pair <jkpair@gmail.com>
> ---
> One-line allowlist addition for the DP-to-HDMI PCON in the ASUS ROG
> Bulwark DG310 dock, so FreeSync works on HDMI sinks behind it.
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>  drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3067ac5bb0cd..0c0d7b850c04 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1712,6 +1712,7 @@ STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
>         DP_BRANCH_DEVICE_ID_90CC24,
>         DP_BRANCH_DEVICE_ID_001CF8,
>         DP_BRANCH_DEVICE_ID_001FF2,
> +       DP_BRANCH_DEVICE_ID_BCBEFB,
>  };
>  EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist);
>
> diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> index 827e9bd7c5cf..dafecbd606a5 100644
> --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> @@ -37,6 +37,7 @@
>  #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
>  #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
>  #define DP_BRANCH_DEVICE_ID_001FF2 0x001FF2
> +#define DP_BRANCH_DEVICE_ID_BCBEFB 0xBCBEFB
>  #define DP_BRANCH_HW_REV_10 0x10
>  #define DP_BRANCH_HW_REV_20 0x20
>
>
> ---
> base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
> change-id: 20261112-dg310-pcon-vrr-427977a452ff
>
> Best regards,
> --
> Jameson Pair <jkpair@gmail.com>
>
>
>

