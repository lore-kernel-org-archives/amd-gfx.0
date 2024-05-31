Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6291FC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 18:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C764510E134;
	Fri, 31 May 2024 18:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHv03bV2";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1AF10E272
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 18:26:10 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-1f480624d04so20399135ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717179970; x=1717784770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qxdo/c/Mv/KtbzPGCbECZpdhhGuUksV5uAa7Xtif80=;
 b=BHv03bV29CVKDM6cMOC8sMphrhfBwnZLJqe2dPYJQYmhczot6fxZ8BruzqxFQD3QhS
 FJZ9410SvzlkbU5U5QNxOD1sQ0kjb+gXSyejaT51h9Zjx3i+/FNKbwadjuBRUW9oHETU
 tMwxOwQ5iPrmNLBfCsgMySe3TDD3MBv7rxtz+XEySi6RbVe03fJG0haiZd2XBM+6Uiek
 5dnXIrienFE3Gdfbe/nDy5DBvcoT54iHY5H891fDRo13huVJI10IwVp74dRkIklLzM8q
 NKiblvifPceSy/55I6eCuTadYmJqzOKZ2GvAYFttk8I8oK9ffY1iQMDMP0BMe61kg7O9
 66vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717179970; x=1717784770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Qxdo/c/Mv/KtbzPGCbECZpdhhGuUksV5uAa7Xtif80=;
 b=WhHKLXg5HxCcxyV6hwdcSCa55deAyW6HkYIj2rQcJ/+XYKZJCsvamsBjnMDOJHeQ53
 6h/v3oTRrMTQsrwMASOQ+MNlX8xGJidWpZe2YapLWremGCSOan6YG1EQSPchP0l6R6M1
 uAx5sALcxJSSs2mVap2VZbwueR0SkGA5EGNua1BtULA83hQ7yXD5VAyEhMTeJNh7o4Ei
 vjoZUnIfksa0StpZ/yEVTLJ11gpuRcAK7sf4SD1CgcsNRQdYjH87tdTRxyUUoiGDMvIY
 zDv+Lh1xv00jwpQOJ3nbHhx393gPGnBwusNtsWeHJpXU18ATS3Z5x4gL74iSPsfF4fhj
 Z0kA==
X-Gm-Message-State: AOJu0Yw0mx3mMe+M1+xhigDdcmji8zAqOaV4iK8TUZxEd5pSua6QUo8Y
 jBlEmezDRKNVpA79i+98Z8XKuEbxciNmNuBJPGjmUKKisYtxLgxtlqtj7cirAaHGpBsI7QU0OeS
 pxV1QoJ57bt4OC5Tz5ePZYUlJN4qcWw==
X-Google-Smtp-Source: AGHT+IF0w1DYeVmaSH9lRsw1GtXVRu+geEAQUgmhyUc2tu8mpUL9f+oKZ8iiVMZds9ze6ewGi8qswKoRUL4GA+HwK/I=
X-Received: by 2002:a17:902:6547:b0:1f6:1c5f:e089 with SMTP id
 d9443c01a7336-1f6370baf04mr24561765ad.60.1717179969488; Fri, 31 May 2024
 11:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240531162329.1343167-1-tasos@tasossah.com>
In-Reply-To: <20240531162329.1343167-1-tasos@tasossah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 May 2024 14:25:58 -0400
Message-ID: <CADnq5_NtLyPdZaKAMLFF6b34TSXdaw=JJeLJsfg616wyVOdwzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
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

Applied.  Thanks!

On Fri, May 31, 2024 at 12:31=E2=80=AFPM Tasos Sahanidis <tasos@tasossah.co=
m> wrote:
>
> Flexible arrays used [1] instead of []. Replace the former with the latte=
r
> to resolve multiple UBSAN warnings observed on boot with a BONAIRE card.
>
> In addition, use the __counted_by attribute where possible to hint the
> length of the arrays to the compiler and any sanitizers.
>
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> ---
> V1 -> V2: Added the __counted_by attribute where possible and reworded
>           the commit message.
>
>  drivers/gpu/drm/amd/include/pptable.h | 91 ++++++++++++++-------------
>  1 file changed, 49 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/=
include/pptable.h
> index 2e8e6c9875f6..f83ace2d7ec3 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -477,31 +477,30 @@ typedef struct _ATOM_PPLIB_STATE_V2
>  } ATOM_PPLIB_STATE_V2;
>
>  typedef struct _StateArray{
> -    //how many states we have
> -    UCHAR ucNumEntries;
> -
> -    ATOM_PPLIB_STATE_V2 states[1];
> +       //how many states we have
> +       UCHAR ucNumEntries;
> +
> +       ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
>  }StateArray;
>
>
>  typedef struct _ClockInfoArray{
> -    //how many clock levels we have
> -    UCHAR ucNumEntries;
> -
> -    //sizeof(ATOM_PPLIB_CLOCK_INFO)
> -    UCHAR ucEntrySize;
> -
> -    UCHAR clockInfo[];
> +       //how many clock levels we have
> +       UCHAR ucNumEntries;
> +
> +       //sizeof(ATOM_PPLIB_CLOCK_INFO)
> +       UCHAR ucEntrySize;
> +
> +       UCHAR clockInfo[];
>  }ClockInfoArray;
>
>  typedef struct _NonClockInfoArray{
> +       //how many non-clock levels we have. normally should be same as n=
umber of states
> +       UCHAR ucNumEntries;
> +       //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
> +       UCHAR ucEntrySize;
>
> -    //how many non-clock levels we have. normally should be same as numb=
er of states
> -    UCHAR ucNumEntries;
> -    //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
> -    UCHAR ucEntrySize;
> -
> -    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
> +       ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries=
);
>  }NonClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
> @@ -513,8 +512,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_=
Record
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
>  {
> -    UCHAR ucNumEntries;                                                /=
/ Number of entries.
> -    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             /=
/ Dynamically allocate entries.
> +       // Number of entries.
> +       UCHAR ucNumEntries;
> +       // Dynamically allocate entries.
> +       ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[] __counted_by=
(ucNumEntries);
>  }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
> @@ -529,8 +530,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Recor=
d
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
>  {
> -    UCHAR ucNumEntries;                                                /=
/ Number of entries.
> -    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  /=
/ Dynamically allocate entries.
> +       // Number of entries.
> +       UCHAR ucNumEntries;
> +       // Dynamically allocate entries.
> +       ATOM_PPLIB_Clock_Voltage_Limit_Record entries[] __counted_by(ucNu=
mEntries);
>  }ATOM_PPLIB_Clock_Voltage_Limit_Table;
>
>  union _ATOM_PPLIB_CAC_Leakage_Record
> @@ -553,8 +556,10 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PP=
LIB_CAC_Leakage_Record;
>
>  typedef struct _ATOM_PPLIB_CAC_Leakage_Table
>  {
> -    UCHAR ucNumEntries;                                                 =
// Number of entries.
> -    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           =
// Dynamically allocate entries.
> +       // Number of entries.
> +       UCHAR ucNumEntries;
> +       // Dynamically allocate entries.
> +       ATOM_PPLIB_CAC_Leakage_Record entries[] __counted_by(ucNumEntries=
);
>  }ATOM_PPLIB_CAC_Leakage_Table;
>
>  typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
> @@ -568,8 +573,10 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Recor=
d
>
>  typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
>  {
> -    UCHAR ucNumEntries;                                                 =
// Number of entries.
> -    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   =
// Dynamically allocate entries.
> +       // Number of entries.
> +       UCHAR ucNumEntries;
> +       // Dynamically allocate entries.
> +       ATOM_PPLIB_PhaseSheddingLimits_Record entries[] __counted_by(ucNu=
mEntries);
>  }ATOM_PPLIB_PhaseSheddingLimits_Table;
>
>  typedef struct _VCEClockInfo{
> @@ -580,8 +587,8 @@ typedef struct _VCEClockInfo{
>  }VCEClockInfo;
>
>  typedef struct _VCEClockInfoArray{
> -    UCHAR ucNumEntries;
> -    VCEClockInfo entries[1];
> +       UCHAR ucNumEntries;
> +       VCEClockInfo entries[] __counted_by(ucNumEntries);
>  }VCEClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
> @@ -592,8 +599,8 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Re=
cord
>
>  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
>  {
> -    UCHAR numEntries;
> -    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
> +       UCHAR numEntries;
> +       ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[] __counted_by(=
numEntries);
>  }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_VCE_State_Record
> @@ -604,8 +611,8 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
>
>  typedef struct _ATOM_PPLIB_VCE_State_Table
>  {
> -    UCHAR numEntries;
> -    ATOM_PPLIB_VCE_State_Record entries[1];
> +       UCHAR numEntries;
> +       ATOM_PPLIB_VCE_State_Record entries[] __counted_by(numEntries);
>  }ATOM_PPLIB_VCE_State_Table;
>
>
> @@ -626,8 +633,8 @@ typedef struct _UVDClockInfo{
>  }UVDClockInfo;
>
>  typedef struct _UVDClockInfoArray{
> -    UCHAR ucNumEntries;
> -    UVDClockInfo entries[1];
> +       UCHAR ucNumEntries;
> +       UVDClockInfo entries[] __counted_by(ucNumEntries);
>  }UVDClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
> @@ -638,8 +645,8 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Re=
cord
>
>  typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
>  {
> -    UCHAR numEntries;
> -    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
> +       UCHAR numEntries;
> +       ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[] __counted_by(=
numEntries);
>  }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_UVD_Table
> @@ -657,8 +664,8 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Recor=
d
>  }ATOM_PPLIB_SAMClk_Voltage_Limit_Record;
>
>  typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
> -    UCHAR numEntries;
> -    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
> +       UCHAR numEntries;
> +       ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[] __counted_by(num=
Entries);
>  }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_SAMU_Table
> @@ -675,8 +682,8 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Recor=
d
>  }ATOM_PPLIB_ACPClk_Voltage_Limit_Record;
>
>  typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
> -    UCHAR numEntries;
> -    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
> +       UCHAR numEntries;
> +       ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[] __counted_by(num=
Entries);
>  }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_ACP_Table
> @@ -743,9 +750,9 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
>  } ATOM_PPLIB_VQ_Budgeting_Record;
>
>  typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
> -    UCHAR revid;
> -    UCHAR numEntries;
> -    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
> +       UCHAR revid;
> +       UCHAR numEntries;
> +       ATOM_PPLIB_VQ_Budgeting_Record entries[] __counted_by(numEntries)=
;
>  } ATOM_PPLIB_VQ_Budgeting_Table;
>
>  #pragma pack()
> --
> 2.25.1
>
