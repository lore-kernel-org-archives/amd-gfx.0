Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540D6C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 04:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7B010EA13;
	Wed, 15 Feb 2023 04:30:50 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AAF10EA13
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 04:30:48 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id n132so14821472oih.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 20:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1d60u7YEjkTeP8+2D2K7gcDl+TepA34p4AvDhtH/crg=;
 b=WBVX94ND98D2JnCAsIJYOaCzpS0I9lirKMpGsd/MT4iXo2mK/L69AvTjHsE3eTMxuh
 C/PlNgYpxdfH4LM+4v6OjjNGVWd7VS0lW/lFrXD2u2Gog+jLXXg1Op9gcKRB4qemY0sT
 0N9uZoLgQWV8mjSqgNAksZLu8gSXWRoeL2XVLB4trmzdoOpHGiBe3XCLASLCMeNZqfaV
 AA2MnlJEMOEs5Pcuk489aWIy660Xn+XG9kdXsggJSyGWfaohBgaHaTCLzle8FtN5CRha
 I8r52vn/5CqXCdPdGKAxFhnusYHgqROdt4q+jgMRgbGdL8MRGDPeOPbHU5EJ19NfrDWt
 QCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1d60u7YEjkTeP8+2D2K7gcDl+TepA34p4AvDhtH/crg=;
 b=INeCmq+zpeBT/gHI6QhxKBkdNRdQMtldsQwxXNuZQilUt7Nf2nZMKoovISN9/OzRso
 iDgQWyyMb7rjz0a+dbrEdRd3weFJsAb1aC8wzBqd1qmChoAMblMlJpLpVKCWVYy95Yj4
 B3ecErAn1Gkxz2Iz2wbue4916niXN1rqx+sFbpQEXpVdZclbslwKVOa3qrwzGEg6VTuL
 VqvUGyXH/I7mkslHPAJ+taBp8uxzHeU+KjJd81CrJtLxdjWiaI/rmiszeupcZrVlys2O
 gxpcfVUsnlJi0mMGnl8qAucfjRu1RQPiOdjfr91ZO00/9uHd+o0+PkshDBhorArvd1TZ
 mOlA==
X-Gm-Message-State: AO0yUKWbNQPFWxG/rpMDEcF/DuD+InQNCNvYQv04QGEO7EQ0U2PXBLEh
 WyaPDaHyYbiZVjAT+gqfmhsKXcD4bdoYJondDUM=
X-Google-Smtp-Source: AK7set/GHwygC/NcvjZzjIQft6KOf/0L+2nLZhqIy/f+B7Lc/tYblMu2VTqzpIZW7aD/6JD+/LS6UkcOjweS1JxyNSg=
X-Received: by 2002:aca:ded7:0:b0:35b:d93f:cbc4 with SMTP id
 v206-20020acaded7000000b0035bd93fcbc4mr97421oig.96.1676435447835; Tue, 14 Feb
 2023 20:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20230214065212.90625-1-jsg@jsg.id.au>
In-Reply-To: <20230214065212.90625-1-jsg@jsg.id.au>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Feb 2023 23:30:36 -0500
Message-ID: <CADnq5_MzbgH0ZWZQk=o8Bq+2OODNh3yxxieYbp-TrjAh5zfV0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: avoid unaligned access warnings
To: Jonathan Gray <jsg@jsg.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: evan.quan@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Feb 14, 2023 at 1:58 AM Jonathan Gray <jsg@jsg.id.au> wrote:
>
> When building on OpenBSD/arm64 with clang 15, unaligned access
> warnings are seen when a union is embedded inside a packed struct.
>
> drm/amd/pm/powerplay/hwmgr/vega20_pptable.h:136:17: error: field
>   smcPPTable within 'struct _ATOM_VEGA20_POWERPLAYTABLE' is less aligned
>   than 'PPTable_t' and is usually due to
>   'struct _ATOM_VEGA20_POWERPLAYTABLE' being packed, which can lead to
>    unaligned accesses [-Werror,-Wunaligned-access]
>       PPTable_t smcPPTable;
>                 ^
>
> Make PPTable_t packed to avoid this.
>
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h          | 2 ++
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h           | 2 ++
>  drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h    | 2 ++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h | 2 ++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h   | 2 ++
>  .../amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h   | 2 ++
>  .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h    | 2 ++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h  | 2 ++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h  | 2 ++
>  9 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> index fdc6b7a57bc9..c2efc70ef288 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> @@ -358,6 +358,7 @@ typedef struct {
>    QuadraticInt_t SsCurve;
>  } DpmDescriptor_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    uint32_t Version;
>
> @@ -609,6 +610,7 @@ typedef struct {
>    uint32_t     MmHubPadding[8];
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> index 2818c98ff5ca..faae4b918d90 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> @@ -122,6 +122,7 @@ typedef struct {
>    uint16_t Vid;  /* min voltage in SVI2 VID */
>  } DisplayClockTable_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    /* PowerTune */
>    uint16_t SocketPowerLimit; /* Watts */
> @@ -323,6 +324,7 @@ typedef struct {
>    uint32_t     MmHubPadding[3]; /* SMU internal use */
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    uint16_t MinClock; // This is either DCEFCLK or SOCCLK (in MHz)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> index b6ffd08784e7..6456bea5d2d5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> @@ -245,6 +245,7 @@ typedef struct {
>    QuadraticInt_t SsCurve;
>  } DpmDescriptor_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    uint32_t Version;
>
> @@ -508,6 +509,7 @@ typedef struct {
>    uint32_t     MmHubPadding[7];
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
> index 43d43d6addc0..d518dee18e1b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
> @@ -464,6 +464,7 @@ typedef struct {
>    uint16_t       Padding16;
>  } DpmDescriptor_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    uint32_t Version;
>
> @@ -733,6 +734,7 @@ typedef struct {
>    uint32_t     MmHubPadding[8]; // SMU internal use
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    // Time constant parameters for clock averages in ms
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
> index 04752ade1016..c5c1943fb6a1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
> @@ -515,6 +515,7 @@ typedef struct {
>    uint32_t BoardLevelEnergyAccumulator;
>  } OutOfBandMonitor_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    uint32_t Version;
>
> @@ -814,6 +815,7 @@ typedef struct {
>    uint32_t     MmHubPadding[8]; // SMU internal use
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    // Time constant parameters for clock averages in ms
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 351a4af429b3..aa6d29de4002 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -599,6 +599,7 @@ typedef struct {
>    uint16_t Fmax;
>  } UclkDpmChangeRange_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    // MAJOR SECTION: SKU PARAMETERS
>
> @@ -957,6 +958,7 @@ typedef struct {
>    uint32_t     MmHubPadding[8]; // SMU internal use
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    // MAJOR SECTION: SKU PARAMETERS
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> index 7a6075daa7b2..90200f31ff52 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> @@ -267,6 +267,7 @@ typedef struct {
>    QuadraticInt_t SsCurve;             // Slow-slow curve (GHz->V)
>  } DpmDescriptor_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    uint32_t Version;
>
> @@ -448,6 +449,7 @@ typedef struct {
>    uint32_t reserved[14];
>
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    // Time constant parameters for clock averages in ms
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> index 4bc7aee4d44f..b686fb68a6e7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> @@ -1347,10 +1347,12 @@ typedef struct {
>    uint32_t     MmHubPadding[8];
>  } BoardTable_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    SkuTable_t SkuTable;
>    BoardTable_t BoardTable;
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    // Time constant parameters for clock averages in ms
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> index 48a3a3952ceb..4c46a0392451 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> @@ -1380,10 +1380,12 @@ typedef struct {
>    uint32_t     MmHubPadding[8];
>  } BoardTable_t;
>
> +#pragma pack(push, 1)
>  typedef struct {
>    SkuTable_t SkuTable;
>    BoardTable_t BoardTable;
>  } PPTable_t;
> +#pragma pack(pop)
>
>  typedef struct {
>    // Time constant parameters for clock averages in ms
> --
> 2.39.1
>
