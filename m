Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A55C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB2410E17B;
	Tue, 30 May 2023 15:24:16 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C4710E17B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:24:15 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6af6ec3df42so4361475a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685460254; x=1688052254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpS+AJJuD+xejcu1mPqYQo5uqXh9WCa9BTe4j7vL30c=;
 b=AFqy7hDWysMmvrAZzbnuoMqFYE8OetVDI+E75L5US8WPncxnjDHDZHVMitbx/WT+rA
 93Ml17Sn2eavhZ2tq3NyaeiE1QUWF3qVYlDmo3dI/HA5gJNZaJ9FWJo0Z9gbPOIcbfap
 FHR24+72iN2DnsFoJsXX/ysojyrHlSAC7+V8CYNgaG/h6WSVIDPpzPO9rlNBnZcJWLm9
 DiHsCnzIb0Qo/hkO6bWTy/QN8S7jpDbqdb2XbYQ0JYd6vY0tTlH2Id+FkkXmFo7pnCvY
 nbzSdw6Z3T18jAFHTLtAOfd6p0bkZ7Fa9HAXBdcAI9lr+wZsMfCxijJC3XCnqgC5iFFs
 ZLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460254; x=1688052254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpS+AJJuD+xejcu1mPqYQo5uqXh9WCa9BTe4j7vL30c=;
 b=HCeVb/DcXLlD0U6CU/uOI8UeEp/GCvAKWw2z4Qe/X0OHwuAzVAH2yURefAXNXRi+iO
 oXpXaxGuu/P1/IjjCu/3C6z6HWq4TN8Fv1daqZVj5cMLkWOxhbu84WlcN4Yrt0vTBwV7
 UfXohH7N/UKvRTNQeNq90WRS+qLrpri4znc+x3Ig+LPA+93/s1DdBMbrrmzfHPqVEomH
 KBDSRkxgFk5j5Jf/aPhEtW2d9JoYCZqLAUMtiDZ6QYQCgLyDRx2M4N8YTyFr1GY/95/+
 bH1xbs/zpYWbS73h39+Zn9m3c4nBfd0banhJI8S01RJsquKMhjNAWi9MscTWIwu/gWdB
 4/uQ==
X-Gm-Message-State: AC+VfDycU/mcC4MOaprniSIrgse4ZW1WmwHHE3d4keOMGjCGmCZASWXl
 +/kd5uAs1/gPGGIERkdSwqC56RKECNTufD3nPJFWPxQ2UNc=
X-Google-Smtp-Source: ACHHUZ6P6iCZX5r6GAWrx0zfoML9pBkW+L75BCkWsuTyqQlJHPYgmaq816lQTfWV9eNoaGDF/v9cMDIbQDo5+94zjWI=
X-Received: by 2002:a05:6870:ec89:b0:18e:db44:b81b with SMTP id
 eo9-20020a056870ec8900b0018edb44b81bmr1585284oab.46.1685460254424; Tue, 30
 May 2023 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230530091734.2336424-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230530091734.2336424-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 11:24:03 -0400
Message-ID: <CADnq5_NMKh__Udag4d_uOjvHTVU-XtBGCrKY8d-EfHX5HiiKTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix up missing parameter in kdoc for 'inst'
 in gmc_ v7, v8, v9, v10, v11.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 30, 2023 at 5:17=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix these warnings by adding 'inst' arguments to kdocs.
>
> gcc with W=3D1
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:428: warning: Function parameter or=
 member 'inst' not described in 'gmc_v7_0_flush_gpu_tlb_pasid'
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:626: warning: Function parameter or=
 member 'inst' not described in 'gmc_v8_0_flush_gpu_tlb_pasid'
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c:423: warning: Function parameter o=
r member 'inst' not described in 'gmc_v10_0_flush_gpu_tlb_pasid'
> drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c:328: warning: Function parameter o=
r member 'inst' not described in 'gmc_v11_0_flush_gpu_tlb_pasid'
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:950: warning: Function parameter or=
 member 'inst' not described in 'gmc_v9_0_flush_gpu_tlb_pasid'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 01bd45651382..1f9313298030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -414,6 +414,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>   * @pasid: pasid to be flush
>   * @flush_type: the flush type
>   * @all_hub: Used with PACKET3_INVALIDATE_TLBS_ALL_HUB()
> + * @inst: is used to select which xcc's register to program

Update the documentation to something like:
+ * @inst: is used to select which instance of KIQ to use for the invalidat=
ion

With that fixed for all of these, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>   *
>   * Flush the TLB for the requested pasid.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 4bf807d825c0..8e78bcd92b59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -319,6 +319,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>   * @pasid: pasid to be flush
>   * @flush_type: the flush type
>   * @all_hub: flush all hubs
> + * @inst: is used to select which xcc's register to program
>   *
>   * Flush the TLB for the requested pasid.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 6f53049619cd..4d4a6957ea00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -419,6 +419,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *ade=
v)
>   * @pasid: pasid to be flush
>   * @flush_type: type of flush
>   * @all_hub: flush all hubs
> + * @inst: is used to select which xcc's register to program
>   *
>   * Flush the TLB for the requested pasid.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 48475077ca92..a5d47e4d0a8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -617,6 +617,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *ade=
v)
>   * @pasid: pasid to be flush
>   * @flush_type: type of flush
>   * @all_hub: flush all hubs
> + * @inst: is used to select which xcc's register to program
>   *
>   * Flush the TLB for the requested pasid.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index be7823d82150..5200303e63de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -941,6 +941,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>   * @pasid: pasid to be flush
>   * @flush_type: the flush type
>   * @all_hub: flush all hubs
> + * @inst: is used to select which xcc's register to program
>   *
>   * Flush the TLB for the requested pasid.
>   */
> --
> 2.25.1
>
