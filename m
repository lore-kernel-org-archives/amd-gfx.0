Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E741ACE7B1C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3A310E083;
	Fri,  6 Sep 2024 14:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ceEAidPk";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89D210E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 14:15:01 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-7c2595f5c35so234252a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725632101; x=1726236901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yxh6nldJ02vq41lsDeKfs154pd6Iu24ffo35BPFz9ME=;
 b=ceEAidPkW+x2xBa/I9va3Kn1nCOIrOmsfCIzsaTE6MuDAccXIzM2SjadFDEl7eEkMx
 L6ur5gPqeYhGAXLnMKq1+KIJSv8OZfMGgYc0itOLsPJZLSpjlLu+vRnV39gbvO8o9GU5
 zOlAp2yuAw1zrLHeb+tzGSIPUicAxeKhcVbWOszIa+oU0ujz1iWYvIP2j6UY6/DEQWUg
 h9mgBC0eoRNc3G8ENaPAydcjgU2qc0L0P+r+BN6n/cnfyvSK2V3d8wbqru2EbiXYw53G
 BtNrS58CXBmVsr3/2yBrlKDzJ1LwcqR+n6WxmiquY6FN/FGQQkPLT0gFPZEV94BKqFkA
 GcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725632101; x=1726236901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yxh6nldJ02vq41lsDeKfs154pd6Iu24ffo35BPFz9ME=;
 b=UqdYjSSxfwytaUhONqWSLffYPGY5XtTLu3ZRDd5zuO5k7Q9RzRG22/ZsJANMxvuIYC
 ojtCBz1nD9EewZrg4j2DVFA66F9DzEMlHnSeyWc2rOFVHhOix/NRTKzSYv7v8cJ156bB
 SpJnuUEL22w1GaHsu2NvHZWC6vCIpHAYCc7mSFmItmgD83iHZWKbInyvYsJ6hbZ/RJSJ
 VDSjoIRsaqWmV9Ft8AdCeQzhFho3TxfOmtHyS7LPg/Uevi8gMggcqgJX7dxOfOgFJsDM
 cFWUSQikxKZEL8c89P+gHXGtzXKNgDeVM7/nmuaf+KCsqAdWQHRx+yUdVK85C94vYtwi
 ++Pg==
X-Gm-Message-State: AOJu0YyZ8IUf22RVU9ButWyQS7kaBwu1XyfdaOoD5VssJcP6yV6uySKm
 jLtcmoTZQ4AIHaLHsmuVjD9pPoifcV6gfOUSCjHU2f1L8E04o3qe1e47fKU72oaUCPurgCPzrTr
 XhxIAinhEwoVRhAZ1K3tcjNP+m0Q=
X-Google-Smtp-Source: AGHT+IG8BKzaRWiE/00cCGFym9oIgxCBPH7wKvxsJqygrw8Fe4qTvGHqKPAiSAjG8J0D0gbdQajYMuinpmtD40IzeTw=
X-Received: by 2002:a17:902:ce8c:b0:206:9032:5a4 with SMTP id
 d9443c01a7336-206f0605c3cmr16441015ad.7.1725632101003; Fri, 06 Sep 2024
 07:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240906055331.1271124-1-jesse.zhang@amd.com>
In-Reply-To: <20240906055331.1271124-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 10:14:49 -0400
Message-ID: <CADnq5_PVCokP-xy3JsOyebDcB6McdA=vajLf2iYbdVmv4h8tZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix resource leak in kriu rsetore queue
To: jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Felix.Kuehling@amd.com
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

Typo in patch subject: kriu -> criu

Alex

On Fri, Sep 6, 2024 at 2:03=E2=80=AFAM <jesse.zhang@amd.com> wrote:
>
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
>
> To avoid memory leaks, release q_extra_data when exiting the restore queu=
e.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 20ea745729ee..b439d4d0bd84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1046,6 +1046,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>                 pr_debug("Queue id %d was restored successfully\n", queue=
_id);
>
>         kfree(q_data);
> +       kfree(q_extra_data);
>
>         return ret;
>  }
> --
> 2.25.1
>
