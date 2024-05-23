Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE7CC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 14:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAB010E1DE;
	Thu, 23 May 2024 14:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KveSsWZa";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAF810E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 14:52:56 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso1819167a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716475975; x=1717080775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VJpauHz0A9lgl/b4R6t56S3JVN3+TokVvJNOt8o6s4=;
 b=KveSsWZaYFf3w0RMghkPrslr5VMJkuG/cdL2M9IhELjfRKQL+0fReiITl9P0s6Qod9
 +7FdsnCH5iQ5w8p81UYB+iByyh4fyM/adPcwbxHuq0kOAj37niiDBeXmtVL0BNQTmRW5
 qfDUaU3iUbWqE6pw9uIkU5Nq2JphIi1XqVEmY/iZ98sIWpyNejlw6cE+D2Nuqqun43sy
 +ipGzoSdOhZVFypDp9fXgcPZ/RLuULgcNyiEQWxAtCia4HwH024iHQfWkZkobfD1GSqI
 TemW/pGl4FqzyCVzuyj+IwL72hKdd9uRkdCXPofM9RRFqOG4LzrijeKGEDwhV0MFi7Cs
 bxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716475975; x=1717080775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VJpauHz0A9lgl/b4R6t56S3JVN3+TokVvJNOt8o6s4=;
 b=dTUcjd6qp07Ky0QN54Dgm4j4kE28UOMOXANV1yeHdbZPaKZNqsC3Yrt0UhM6iw0Dh+
 CHe0xc2lE4XkaLt7QkmUW2BeKTE8B+qexaX7Avte9IXNkzemvaxfW/D7Xy9pqHyLGOO2
 9//WNDNG7+7uJyr/b/0Xx0Dq8xsCfCvqw7WCX9Xr3HUwBoGvJo4aHhEOV0hMEPde623u
 5uuBsPOyQM+006HPd+KcyQgp1rtQIWdd2LTArLN0bDkpKoorjhY6XqUyXBZOx0SKlWI3
 wo0dbY2QFGsEomcQ7OdCrj78JYZtmLTUcQEi37DyuZs1cw+CZ7IFVZxAQtt1OAupaYLr
 oBKQ==
X-Gm-Message-State: AOJu0Yxpn+LwU4xsPDtFXUH9jIvW72E0IwFlTyXkzbdrqi95d0T/47Eu
 EyQ/A+PwyUnV6KLfBT2h0Vr3naObN8TROiev4hHNYG0rUWtguMMWZIV3KSUcJXuTkzcgHVDJLXO
 GosNaBriDyCUwEXGndeUMfmHcymX9HMWR
X-Google-Smtp-Source: AGHT+IGVOafBkTN5+OQkij3uljdLLPPg3YSp0MbIJHo/gY1l7FQSbIbaqMopc8+Rf7O7zYmZv2XJ/iOdUKG/h0YuF/g=
X-Received: by 2002:a17:90a:77c1:b0:2ac:40c8:1ed3 with SMTP id
 98e67ed59e1d1-2bd9f456775mr5542818a91.5.1716475975488; Thu, 23 May 2024
 07:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240523071637.1114898-1-tasos@tasossah.com>
In-Reply-To: <20240523071637.1114898-1-tasos@tasossah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 10:52:43 -0400
Message-ID: <CADnq5_MAPCEO4mNouRHnPMy5-OPXyN1cjy4Ub_xVip4m8x4OZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
To: Tasos Sahanidis <tasos@tasossah.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, May 23, 2024 at 9:05=E2=80=AFAM Tasos Sahanidis <tasos@tasossah.com=
> wrote:
>
> Dyanmically sized arrays used [1] instead of []. Replacing the former
> with the latter resolves multiple warnings observed on boot with a
> BONAIRE card.
>
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> ---
>  drivers/gpu/drm/amd/include/pptable.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/=
include/pptable.h
> index 2e8e6c9875f6..d1dec880d2d6 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -480,7 +480,7 @@ typedef struct _StateArray{
>      //how many states we have
>      UCHAR ucNumEntries;
>
> -    ATOM_PPLIB_STATE_V2 states[1];
> +    ATOM_PPLIB_STATE_V2 states[];

Can you add __counted_by(ucNumEntries) to the end of the line? E.g.,

ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);

Same comment for the other changes below.

Alex

>  }StateArray;
>
>
> @@ -514,7 +514,7 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_R=
ecord
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
>  {
>      UCHAR ucNumEntries;                                                /=
/ Number of entries.
> -    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             /=
/ Dynamically allocate entries.
> +    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[];              /=
/ Dynamically allocate entries.
>  }ATOM_PPLIB_Clock_Voltage_Dependency_Table;>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
> @@ -530,7 +530,7 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
>  {
>      UCHAR ucNumEntries;                                                /=
/ Number of entries.
> -    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  /=
/ Dynamically allocate entries.
> +    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[];                   /=
/ Dynamically allocate entries.
>  }ATOM_PPLIB_Clock_Voltage_Limit_Table;
>
>  union _ATOM_PPLIB_CAC_Leakage_Record
> @@ -554,7 +554,7 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPL=
IB_CAC_Leakage_Record;
>  typedef struct _ATOM_PPLIB_CAC_Leakage_Table
>  {
>      UCHAR ucNumEntries;                                                 =
// Number of entries.
> -    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           =
// Dynamically allocate entries.
> +    ATOM_PPLIB_CAC_Leakage_Record entries[];                            =
// Dynamically allocate entries.
>  }ATOM_PPLIB_CAC_Leakage_Table;
>
>  typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
> @@ -569,7 +569,7 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
>  typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
>  {
>      UCHAR ucNumEntries;                                                 =
// Number of entries.
> -    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   =
// Dynamically allocate entries.
> +    ATOM_PPLIB_PhaseSheddingLimits_Record entries[];                    =
// Dynamically allocate entries.
>  }ATOM_PPLIB_PhaseSheddingLimits_Table;
>
>  typedef struct _VCEClockInfo{
> @@ -581,7 +581,7 @@ typedef struct _VCEClockInfo{
>
>  typedef struct _VCEClockInfoArray{
>      UCHAR ucNumEntries;
> -    VCEClockInfo entries[1];
> +    VCEClockInfo entries[];
>  }VCEClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
> @@ -593,7 +593,7 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Re=
cord
>  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
>  {
>      UCHAR numEntries;
> -    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
> +    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[];
>  }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_VCE_State_Record
> @@ -605,7 +605,7 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
>  typedef struct _ATOM_PPLIB_VCE_State_Table
>  {
>      UCHAR numEntries;
> -    ATOM_PPLIB_VCE_State_Record entries[1];
> +    ATOM_PPLIB_VCE_State_Record entries[];
>  }ATOM_PPLIB_VCE_State_Table;
>
>
> @@ -627,7 +627,7 @@ typedef struct _UVDClockInfo{
>
>  typedef struct _UVDClockInfoArray{
>      UCHAR ucNumEntries;
> -    UVDClockInfo entries[1];
> +    UVDClockInfo entries[];
>  }UVDClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
> @@ -639,7 +639,7 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Re=
cord
>  typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
>  {
>      UCHAR numEntries;
> -    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
> +    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[];
>  }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_UVD_Table
> @@ -676,7 +676,7 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Recor=
d
>
>  typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
>      UCHAR numEntries;
> -    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
> +    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[];
>  }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_ACP_Table
> @@ -745,7 +745,7 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
>  typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
>      UCHAR revid;
>      UCHAR numEntries;
> -    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
> +    ATOM_PPLIB_VQ_Budgeting_Record         entries[];
>  } ATOM_PPLIB_VQ_Budgeting_Table;
>
>  #pragma pack()
> --
> 2.25.1
>
