Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4CE936E9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D2D10E1C1;
	Wed,  4 Oct 2023 21:50:21 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB1010E1C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:50:19 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso175505fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696456218; x=1697061018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnCRAcynVDrM4rjo4XrUjVwfKOrn/LejLiv+I6Z5VGc=;
 b=hE12dibcPLCYv0QQGJZERZm0waiN8359Yqf3HejGNCgE804o+QDdsOguSf/111Yg9b
 LMfWI+SuanuhwYau5nFvafKZwCehJVG0jdFSC22gJaBRgF5DmWrkd6hgtQCEx+3GWI7K
 2VrC3vIvxP/KFPkxF/PVlKnUrkpKS1qJUxXBiblxPggmmsYXRUWS91+Id7cjgl9khnYZ
 MJ0Ku+9usFl0huhYWnj7IARoGN2/23ot0MYugkoJl/SF/j9JSiqEiY6M+tLblT/D6yIa
 8QZ9VtIGPtOWaXiMx/1qOcvD13lgjq1hsCQxlMFySo8vF31wBuVPxLLxny9qd9+FM+2j
 w26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456218; x=1697061018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnCRAcynVDrM4rjo4XrUjVwfKOrn/LejLiv+I6Z5VGc=;
 b=gZ0C/Z1JGnfLxBfJsq85fDlAn8DosB+aMKNbrGi+S+1iCJp0N7g2EAMvapUUp/o1XJ
 RzF1juUaoC6A/1QAm5AI89CWrqYr5/hB/5o/e59nsyOBhOsA7Ovzaxlx2W8AtfXWHakc
 5z3xkBxc8hQs9Teo0F8MNn91WXlVRIOzF3jCIE3sfq0N9YRs4Y3ewzZKZK5AS8aN5dW9
 oVILTDN9HPDmENaOPAzKDrClMmPctXxJWwpHy5r623U4SNSmTLON0ErV+0SrtxC8FYoC
 7XRjVnDU8DDQnvpBkW34mD8TEc1c8INSZ4vWfRExuMGrJqhdvGhAJHucSez+2sr/h3bD
 jvnw==
X-Gm-Message-State: AOJu0YwXMVjgrLS7doNdmQ486dtvXimPHycl5hoZqgdiMhiy0MAjEXKD
 RJkC1xoNLA2dZUJO1D4uCXiOdOoLP+ecGSbdr90J7s2+
X-Google-Smtp-Source: AGHT+IEh4v2DnSA15P1QSmnpWc7x+un8CcmklSPp9DhjKXVVBKUlPiuuu9njDmAPX7uepr1AeGfZK0BjpggmMICzCv0=
X-Received: by 2002:a05:6870:7008:b0:1d5:404d:d2c9 with SMTP id
 u8-20020a056870700800b001d5404dd2c9mr512169oae.14.1696456218481; Wed, 04 Oct
 2023 14:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231004204644.182618-1-mario.limonciello@amd.com>
In-Reply-To: <20231004204644.182618-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Oct 2023 17:50:07 -0400
Message-ID: <CADnq5_ON-+ZE_Op_16ihsva-EOBtb91GZO+fepox42SS0nT1ZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris
 and Tonga
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 4, 2023 at 5:42=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> For pptable structs that use flexible array sizes, use flexible arrays.
>
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> From this bug report there are more to fix
>  .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h    | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> index 57bca1e81d3a..9fcad69a9f34 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> @@ -164,7 +164,7 @@ typedef struct _ATOM_Tonga_State {
>  typedef struct _ATOM_Tonga_State_Array {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;             /* Number of entries. */
> -       ATOM_Tonga_State entries[1];    /* Dynamically allocate entries. =
*/
> +       ATOM_Tonga_State entries[];     /* Dynamically allocate entries. =
*/
>  } ATOM_Tonga_State_Array;
>
>  typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
> @@ -210,7 +210,7 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
>  typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                              =
       /* Number of entries. */
> -       ATOM_Polaris_SCLK_Dependency_Record entries[1];                  =
        /* Dynamically allocate entries. */
> +       ATOM_Polaris_SCLK_Dependency_Record entries[];                   =
        /* Dynamically allocate entries. */
>  } ATOM_Polaris_SCLK_Dependency_Table;
>
>  typedef struct _ATOM_Tonga_PCIE_Record {
> @@ -222,7 +222,7 @@ typedef struct _ATOM_Tonga_PCIE_Record {
>  typedef struct _ATOM_Tonga_PCIE_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_PCIE_Record entries[1];                               =
                       /* Dynamically allocate entries. */
> +       ATOM_Tonga_PCIE_Record entries[];                                =
                       /* Dynamically allocate entries. */
>  } ATOM_Tonga_PCIE_Table;
>
>  typedef struct _ATOM_Polaris10_PCIE_Record {
> @@ -235,7 +235,7 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
>  typedef struct _ATOM_Polaris10_PCIE_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                         /* Nu=
mber of entries. */
> -       ATOM_Polaris10_PCIE_Record entries[1];                      /* Dy=
namically allocate entries. */
> +       ATOM_Polaris10_PCIE_Record entries[];                      /* Dyn=
amically allocate entries. */
>  } ATOM_Polaris10_PCIE_Table;
>
>
> @@ -252,7 +252,7 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
>  typedef struct _ATOM_Tonga_MM_Dependency_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_MM_Dependency_Record entries[1];                      =
  /* Dynamically allocate entries. */
> +       ATOM_Tonga_MM_Dependency_Record entries[];                       =
  /* Dynamically allocate entries. */
>  } ATOM_Tonga_MM_Dependency_Table;
>
>  typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
> @@ -265,7 +265,7 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
>  typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_Voltage_Lookup_Record entries[1];                     =
       /* Dynamically allocate entries. */
> +       ATOM_Tonga_Voltage_Lookup_Record entries[];                      =
       /* Dynamically allocate entries. */
>  } ATOM_Tonga_Voltage_Lookup_Table;
>
>  typedef struct _ATOM_Tonga_Fan_Table {
> --
> 2.34.1
>
