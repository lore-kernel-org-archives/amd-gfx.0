Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF5F109C055
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 18:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB6A10E82C;
	Wed, 25 Mar 2026 18:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HK4VjQ0l";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFDA10E82C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 18:36:27 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12a70b4de9bso10875c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 11:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463787; cv=none;
 d=google.com; s=arc-20240605;
 b=UhGMndYhCfDspRntybgYY8ouflE98t267w5ZoIRzdenZadKNMC+BW9viPrrdk7js4d
 qUrvWxY3Nl32VcZtB1KIfO9FetJCQ7W4D0mvvqqRdKtPeL4MddsN8bCpE3gqFmSa4ll4
 BrTJJx+ad/6dfo8RX6XjtRbo/R0jwETxSonO28zxd75EtRJTxcuWVdW1OCaaEP6vzd7k
 xvBPkYB2A0tcg5yFv5ijDAmXq9bx4h+y3um5B5nKNBIc+8IIAQ86eMbhYiCfyddA4Hfd
 rV8ZqfCA9A23/0s9o1bTa+JlP7ql/Ct13mD0HdeAcGwKB/2R1KjQPauBpEjZyko6KOSf
 5FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NP7vIFbtnG64ERfkT7waxXuEBOIYnGcYYE0hnghEEV4=;
 fh=ajoLvz0m6jOqb0pjJXa3T4dgclqHSbzrq1AGyonDUCI=;
 b=JR+kXeBVSlYbKnT7pDnHBwwEVknxMZimhnOjmJxQDD1Zo9As7StPySvaFYt1nKlum4
 kisH2qY+nNfccnkz9dK4D5VVPQ8qcD9zYdHwnOf/gg1ZP5MadIpiQ3EK3FwyosuWo/xc
 8VDrtxocW/q+JcCW24LDvqU3veLwJ1ivMKRUWlv7dfXcq8xbkqLhVTxsbzVedsmGRRB3
 lvo9NWH+9oUZ/SyWMSC6KhzxtGoyLVcYuy9NNvGIosroIir2ptg5rwY8znfqJsJgVKPe
 iaKCvCi+0qbfYJtpIFJYgv6nCDE44xYInYDgSxffIocv2NgOgG8mO3gxl+tR4d/VPlw1
 sw0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774463787; x=1775068587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NP7vIFbtnG64ERfkT7waxXuEBOIYnGcYYE0hnghEEV4=;
 b=HK4VjQ0lTfzlhm8uVfiP9qdfC4jnyMfr+9ZsW1PdXnpmnaE6aQB6JOJgLd8yEDgk6u
 SAgM74wBacgrNwODxJlvegYy/pWdlXny1J8niNdNnJf2Gq2Qxv/bskPSCYcb+A9ifmZ1
 YHQOx/PnFyGDQR6lYHOI+M4zHQ/fQfPnRMOfD8Jm0OaXmGgsVl1BaiidrfqSu8LY1tiT
 zhE0yjmsSsB1FsKcp6rPbqWHXph9bm+94D7D/Wuhv0C3Sz+vul3MnEZrY/gJh3ZjLb3C
 L+7o/jj/rlaAjr+W+UF3u7AuIDSOvUQy0zs/t74oGVV2xUo4EMb/TqDavR+JFdcCJTsF
 IbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774463787; x=1775068587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NP7vIFbtnG64ERfkT7waxXuEBOIYnGcYYE0hnghEEV4=;
 b=I8J8s5gE278ttvjPRzsC1sdh+HVrCgiQY+affXXGlJqUOcjL2Xg7BuEQ5abS+gaSMq
 Si6Ei6jKl0N0OHAhItSxBCWVgpLmxvHyCAbGMMavB8y88gtl++pRfkjxo6OKLC3H3HHT
 qFFGTZOE4QgEjrdCAxso64IP2d3kBNtTFDRSdaH3VNXO67rG18A8S/OZGNmr3w+ITyH0
 6LlSjLQTE/1bDxXOOAnaFIOHsGYs423MOtVPrUTrJ069KYjsTAP3Vsrnlo1rgJ5PWZfy
 o6Bo5qfscFNPsYVGDZgXpoEBR4KPFv8sjkhRIn1w9oUJ3HDE4OGR3yiWgJsQ3QHjSyvU
 hZjg==
X-Gm-Message-State: AOJu0YxvPUJkSZN7aJ42i5csQe11lauES/LNUQtw1iapfH9qvwesQTs1
 YVk2DFyRK3BZOc9RiCHhpQo/Ph67ekYG2hjwSC+mdLFE6KE4NQxaFBl1N2BqrMp7+Vh3N1MiUBB
 3u/pyjhoqW7brqtiN7MWVG0womT1hZhI=
X-Gm-Gg: ATEYQzxCA2tFc2fblsC8eegeu6TCIYXosSFSfibEJkUIkwJW8gtHfd8rCrgjuG90eO5
 F8eYzMwzwGU6y3Rmc9AuzQO0a0fhzsi5GJcjhQmO0HRUH30LtqmAhWFW+7TFbI3OJFv2Sx8u1kL
 8ZdbK3EmzkQR4uvGuGeVdCaFD+A7BdUhoZXGEJpTOpLNrhrubHuJfKabBTcoLxxKao5dYhM6TWv
 IixmqHCpNSad16MQI0UrYZLDsOjs16C3S3huWkiJq5h4yhAgrQt5kMhkOB9quJx1AFR6foa3d4i
 8bjja6pLPA0rv/9YH3odT+XI393p7zj+UX345S/T1TI4mPL59Ju01LqqG3QUT8+IXe+ioQ==
X-Received: by 2002:a05:7022:660e:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-12a96f1ae6bmr1097943c88.3.1774463786740; Wed, 25 Mar 2026
 11:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
 <3a5ed765-3a50-446d-bd26-aa09dfe3d6a2@amd.com>
 <CADnq5_Mc5TEBXD+sTLmT2ew6KKH++=8YjN=3N9d_bWUqqKgMRA@mail.gmail.com>
 <5cad327b-55bd-4cc9-96a4-54318f1b4588@linux.ibm.com>
In-Reply-To: <5cad327b-55bd-4cc9-96a4-54318f1b4588@linux.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2026 14:36:15 -0400
X-Gm-Features: AaiRm50SVQin5X9rTE83HV9sXzytFJ7VxDn1vsTHg24ZnpGNzEuz9STG7W80-p4
Message-ID: <CADnq5_PU7U4=iHB912=uLx-BfB3s+3HFWjBjzzFRg5-jWt_rEQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults
 correctly on non-4K page systems
To: Donet Tom <donettom@linux.ibm.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>,
 David.YatSin@amd.com, 
 Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>, 
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Mar 25, 2026 at 2:05=E2=80=AFPM Donet Tom <donettom@linux.ibm.com> =
wrote:
>
>
> On 3/24/26 6:40 PM, Alex Deucher wrote:
> > Applied.  Thanks!
>
> Hi @Alex
>
> Thank you for applying this patch.
>
>
> I am planning to send the next version for PATCH 1/6. For the
> other patches that have already received Reviewed-by tags,
> would you prefer to pick them from this series, or should I
> include them again in the next version?

I'll pick up the reviewed patches.  Feel free to include them in your
resend if that's easier for you.  I'll pick up whatever the delta is
once those are reviewed.

Alex

>
> -Donet
>
>
> >
> > Alex
> >
> > On Mon, Mar 23, 2026 at 9:04=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> On 3/23/26 05:28, Donet Tom wrote:
> >>> During a GPU page fault, the driver restores the SVM range and then m=
aps it
> >>> into the GPU page tables. The current implementation passes a GPU-pag=
e-size
> >>> (4K-based) PFN to svm_range_restore_pages() to restore the range.
> >>>
> >>> SVM ranges are tracked using system-page-size PFNs. On systems where =
the
> >>> system page size is larger than 4K, using GPU-page-size PFNs to resto=
re the
> >>> range causes two problems:
> >>>
> >>> Range lookup fails:
> >>> Because the restore function receives PFNs in GPU (4K) units, the SVM
> >>> range lookup does not find the existing range. This will result in a
> >>> duplicate SVM range being created.
> >>>
> >>> VMA lookup failure:
> >>> The restore function also tries to locate the VMA for the faulting ad=
dress.
> >>> It converts the GPU-page-size PFN into an address using the system pa=
ge
> >>> size, which results in an incorrect address on non-4K page-size syste=
ms.
> >>> As a result, the VMA lookup fails with the message: "address 0xxxx VM=
A is
> >>> removed".
> >>>
> >>> This patch passes the system-page-size PFN to svm_range_restore_pages=
() so
> >>> that the SVM range is restored correctly on non-4K page systems.
> >>>
> >>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> >> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
> >>>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm.c
> >>> index 6a2ea200d90c..7a3cb0057ac5 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -2985,14 +2985,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_dev=
ice *adev, u32 pasid,
> >>>        if (!root)
> >>>                return false;
> >>>
> >>> -     addr /=3D AMDGPU_GPU_PAGE_SIZE;
> >>> -
> >>>        if (is_compute_context && !svm_range_restore_pages(adev, pasid=
, vmid,
> >>> -         node_id, addr, ts, write_fault)) {
> >>> +         node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
> >>>                amdgpu_bo_unref(&root);
> >>>                return true;
> >>>        }
> >>>
> >>> +     addr /=3D AMDGPU_GPU_PAGE_SIZE;
> >>> +
> >>>        r =3D amdgpu_bo_reserve(root, true);
> >>>        if (r)
> >>>                goto error_unref;
