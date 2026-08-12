Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC4DC5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 18:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6EE10E2AF;
	Wed, 12 Aug 2026 18:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HnOqHnx+";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16B510E2AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 18:04:37 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso257154a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 11:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786557877; cv=none;
 d=google.com; s=arc-20260327;
 b=Zu6oi6/SipT3hKUEhVKwB7tCTqz1xHJLBm5ntoz2NL/86AAMkoOTw5weNYHrtbTWdE
 anGVAYy5ZRiHzgRzQRJoBPs4ov4aHZFoeiAhD6DZd1jNFBGUW8CVWNPXkV5RR3UmQTYq
 6v8amHixuiy12nDxrjggoNLYEzDpi2zx0QZKyrKIF39UALqTY0VCvJrRKwm0PEF/5LSy
 8YuvLGT5AAyAeMkK6Lu0O8CfEyM/Q47F4dvu5Iqo6aqWgrxYoUiVytM0/HrSqpsC2cpH
 AF08j/criszhoCQ1cSKJMmIvXESdBf5cSv8Beeb+w7mqeNtCitOlCBgS4FIKQkdRcDpV
 IaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fAwYnwI+iWLzM+NS5sOqmOoXB5NjfiBli0Dy+4D6dqE=;
 fh=Gz/Xb2/sum+uTy0yshHmXhaz7heKZnhj9g7yDriPtN4=;
 b=dBQbz+1XZWsCRbuVLTNwxxR35waofoQNCq0hWBkRsafOkYmWS8cTyAaVDGTY7M+qHA
 VPUvvj4eIBLAK+prICRTirXoJVCXfhHrZ3I+OlabV0BleJtwBWAxt3EHErtKhJkyQ0Ra
 op5gs7iuryFsNHSMwREzJZ+rCVp/8c3o4ybL5Wd21CcKngHgm81wlIf7CBbjjrl7SgC2
 0GIGsxUB5VyUrlL/5t8aDPql7+8AKjaKc4+zXKsSaBgnLTTrE0dDsLatKFWaUUorIayv
 jkJpC/Ii/IsEl8FTIXWi/CHGxIMgwP7/PprRd7lw4QqtkS6IqiCz52oikqn6ARoDt22Q
 AT4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786557877; x=1787162677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fAwYnwI+iWLzM+NS5sOqmOoXB5NjfiBli0Dy+4D6dqE=;
 b=HnOqHnx+tizWdzXfooLogKFMknV0gqO55v3U4FBrKG6PreO1SVNLCjrkETFKgOtzcX
 Y2OQjaRordiJEYNa+uvVA5C2Pq6wOCfmnoNn+VNny0+/0SHpGv7D/N5QCwJr0vjQKRoj
 FdvMYz7DY7pv8ej34EwK4HPsvZfSW8VNmVa+F/g66tDnplNr8BXwUEcmw/heiX2lEkYV
 XHTs7iAx1C6wFjF/y3SQPTV4qCHVN7H5QhL7mIHg9AQ4o+CY5BwHiAo3Gjq3iCfwhBWi
 XkRZqVi1NyzaQYX4U5+vYU9yMQJEiyC/cDGWWaH3xdk5i8k85Pvie4DoGZLj3aEureEn
 1nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786557877; x=1787162677;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fAwYnwI+iWLzM+NS5sOqmOoXB5NjfiBli0Dy+4D6dqE=;
 b=CDKFO0s2VxX23ftQqrBSJwUNHRff1Fd35+8dRrf59vNYdj89wT/ljAefBe23DcglIV
 WtntdjDz+hvxFFRldWJtMfYKSnBrwWEw5cdI+dGCifpMlJ2SCvZraHZ6Z2eujVdl5XS9
 GPRkBr+S6LjTYyV3KlcPRGbGbox80VOhMdyphpE6PdsBWOLStkTLv6g5xp1aTW5EVny7
 p0+QSLUBDohTNx7t2pZoLUlkzX/2FThBl962OKeLQZi1/d3y+P78UE2W2poIVrn4PtPi
 cael4KioOPVBz3YVjMyFiTS4vS4j+p7/5TG+sxb0pPJWL3o2v/xLYKveaiz6B3OcgtqG
 75/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcAsWgIsjXTnrrcWdx9SFW9cA2Jbd/UdUNiSzVSafdOmDd2zZhDumVBiNieFPfXhCHfmZY8ZlW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQBfUi5jKmY+KMiKaDE2njQtVSC3QviZtVK7aTBv7rl6zlD9lI
 GMVrAl5DLmZcIjBY19wCz45yQbhyu7Fy0jG8sATv/wu3XJCvfJRoLXFr4hmPxk7VJSU4G+Z6bqe
 0octF7AwEhQRIsPJ0zIxD4mORii90d2M=
X-Gm-Gg: AR+sD13pkShS9h1/zYqdEdq2NA0xr5B1kc5n5q8vH56gd2pekzvgA4+lCoEdxVGTQh+
 eLEaUvg2gNg4+Ybesh+bjzVMPsRZJ67xh8fWQC12DESsxzU6gwpyHkpjXqZUcuoEYln/i+axmpx
 un7bua65QBlOuhIm7CY4juhpebftC6fL8hzEP9x00bfKtxHmsWHV80G/PKODrsJD59Aj5dDFPlw
 8MtnCHcJQ+y1PIc4j+Awg60a28kwzPQq4Pal4PiMBppv5qxn40A+HvnGbqjc3SLiEsvW6rhAKSD
 9HlZlKV5gntzKo5yCZqfWfmI/6JNk7gpGmBfv6B8Y0B+I6xUVCy0vHX8rvBhEeH5p0OZU76/1Tg
 DhnIBsaDIz02UKFzT6/i4CBJuCMhF6U0=
X-Received: by 2002:a17:90b:5107:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-3931e03ddbdmr42863a91.1.1786557877360; Wed, 12 Aug 2026
 11:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260723082334.606456-1-lingshan.zhu@amd.com>
 <c2a5fb47-d8b8-44c3-ab16-3538e7925fc8@amd.com>
 <8987dfbe-65f5-4652-adf6-710269d85a08@amd.com>
In-Reply-To: <8987dfbe-65f5-4652-adf6-710269d85a08@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 14:04:25 -0400
X-Gm-Features: AUfX_mxETVBz7jFGvDRKBGrd9UqLIMCaq4QcvnJ02n7q0iTHIcoYNQ3JrI2ZH-E
Message-ID: <CADnq5_OAft6UEdb-OwmjZpQqZoCrq4ZjNKJMONOE8itqhkOk8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: ensure all userq VAs mapped before restore
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Aug 6, 2026 at 3:53=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> Ping Christian and Alex
>
> I may still need the maintainer's comments to merge this patch.

You can go ahead with Sunil's RB.

Thanks!

Alex

>
> Thanks
> Lingshan
>
> On 7/23/2026 7:17 PM, Khatri, Sunil wrote:
>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> On 23-07-2026 01:53 pm, Zhu Lingshan wrote:
>
> amdgpu_userq_buffer_vas_mapped() checks whether all VAs
> of a queue are mapped before restoring it.
> So that HW won't access any invalid addresses.
>
> Currently, this function assumes all VAs are mapped if
> any VA of a queue has been mapped, which is wrong.
>
> This commit fixes this problem by examining all VAs of
> a queue and reporting false if any of them is not mapped.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af757..2b3cb4ec4835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -280,22 +280,24 @@ static bool amdgpu_userq_buffer_va_mapped(struct am=
dgpu_vm *vm, u64 addr)
>     static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_que=
ue *queue)
>   {
> -    int i, r =3D 0;
> +    int i;
> +    bool mapped;
>         for (i =3D 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
>           if (!queue->userq_vas.va_array[i])
>               continue;
> -        r +=3D amdgpu_userq_buffer_va_mapped(queue->vm,
> +
> +        mapped =3D amdgpu_userq_buffer_va_mapped(queue->vm,
>                              queue->userq_vas.va_array[i]);
>           dev_dbg(queue->userq_mgr->adev->dev,
>               "validate the userq mapping:%p va:%llx r:%d\n",
> -            queue, queue->userq_vas.va_array[i], r);
> -    }
> +            queue, queue->userq_vas.va_array[i], mapped);
>   -    if (r !=3D 0)
> -        return true;
> +        if (!mapped)
> +            return false;
> +    }
>   -    return false;
> +    return true;
>   }
>
