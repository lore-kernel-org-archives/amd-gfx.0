Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F8FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 14:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E0910EBD1;
	Tue, 28 Apr 2026 14:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UpNvYXdv";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD4310EB1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 14:30:35 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12db2e9b5a7so412841c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 07:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386634; cv=none;
 d=google.com; s=arc-20240605;
 b=LRCllNRCCgZuhuvoTdRdPI6QflWgZIsDtIb7ujqeWoUdNVqHzP7veYqtxQiJjnk4S4
 Zmuy3gzQhy3rRezaFbJrN2u+hFT7hAeDJIY8FvPu9F1XW0zv8SwAPaxKdDK6FDIOkvE4
 ycz+FvTJlLD9ez3luuJzBdBja9LFkuqk6j90l3QZaik0l5u7ruuoJ6UUIMzHANsNqtLR
 ZNfhRJt7Wf8vmR909wE46LfqTFz8lafOze2yRnprD8Kud1fEFKbOoooglPwI2/VDcTKT
 S/FUWgZBkZDJifPqGfJ4QtB31bu9OOc9uxzjtojUS2xEFVMYuBAoHAG2Zs22TjiDwOER
 88pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mhJ0rsbgpKdN9xRBdPO4qGQxRdlZh6yNC6k39eXiAj8=;
 fh=yHFYpFndtpdPEIg7fV37Vod4i/Y44VDVqnexdcURHTo=;
 b=W2yUho9QBmGP9KpFAQOmgpFV1c2ij7f2plhLMZhX7epvfLVZXHMCR9BeiWQt2idZS+
 Uwe/nlkUQVPC+4PDz/sObTdF1DhiIfBq16gY5EdtQsf6Zgbo8iIB4dOJAdPEFKPP3hQW
 fmW4KY+D8jyCZ/pvF1gnOTDIC7QdUciwX+ffFRPpbkOgKKMHf7zEQqlgWLGkVWyTwT98
 nxr+3PYZg5OVfOjaC9tSsVbfPlFJONzBogI0dv7gdLz4hkJduq/28O1OgL2OBmZsstnj
 q4mnidhHmZuKQOWopRSVtp1OtxfuHhXCUSSJiNiK2dBFQul9/fboDGfhGoCImC/0hSHk
 uUsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777386634; x=1777991434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhJ0rsbgpKdN9xRBdPO4qGQxRdlZh6yNC6k39eXiAj8=;
 b=UpNvYXdvZfjItuY07Nk2el91OPGm45eT9gHBmqDTB/T9x/fksGcaA2DIqxL0UEr4jq
 P1Tg7Laiq/aRo3qSXnrgY+8L9IqRp6fl8FfUd85NTFS3vUTDp1tg7CW/fjAX4WHbC77A
 orKlqAQIZ1QW1ENr91s+tq1A6TDEoCrtcNBRj2+c3FtODMebLF4uXMYuTCzqiBVsZlg7
 17Yg309k8c+yt4QyWBbhSRUTxIc7f40X3I7sNTmnq4jJP9BS0YaUW00Jpoz4syazc0HP
 NVODJiGca7YrI4Pc261m9t1/YlK7aAz/kExzlbBdn+OflmwzzzF1crjDY8suMfWI0uLW
 cOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386634; x=1777991434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhJ0rsbgpKdN9xRBdPO4qGQxRdlZh6yNC6k39eXiAj8=;
 b=M0JG5NcITlErvTrp3sl/V+vsDUXm7/8l9ol0P8qkeJtf1dKGZ/LGmRoyag5XS/IsjQ
 TVI7xlS911jRh+CdL81sBdzETU+UvUYLgmeJWPJ17jvfZPAMfI3yYnJaPWfJfcboN0a0
 Lfkw3kNi6jBuGMZ4wPjrNEZaDi9k1wjEi26XU9p5prKoECqLhvxDmFBxb8IMkfj2/d4Y
 zZU06fNHT1ZIVy3Hl20A5bUFY5rp+GnC/tbwqeScBGrqZglxWmAa14ptO2W7mdNGx6o4
 j1fpXpuJEMmswPMoDg+t9+1vlApnJ5D2lxXTW6yFK5OlENgagX+Ee8GYVwrhdveu5Oll
 qpFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9S2h8/nfIzaoNMvsZdcExd752f0sONBMFnKZntQOs23mfQ6TJuhCeCKwoXHxW/6+ANgu39n8fG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOCE1PZpAmQqLnBljvH+zCZqbcFrPVPGOZ86N2ZAyV8fY4e+Dr
 LFSUQr4IRw31WfnhIIW+N00fSD8NJagRarxRf/LumORXvaQnTVi6csqd3bdfw/ly+b5kYhzTatX
 l+wR7XKwmhPXik0ThBudWYYEtakwNXaY=
X-Gm-Gg: AeBDieutp3C7YvhX07bjyZdKjc847uJjLgFZXL9Ov0qmroxyhpJ2dDJ2rUyXvE0FnI7
 sCacqb8vZS2AwlXOC4Hi+7//uAel/YmKYdHHRe/gLZDTn4tDjvdABOB0ttQwcVGE55Gxn7tg/Jk
 yGEhtaNK59SrOaTFIh/2Qv3l9AzXkiA7MdGcn8il2YkKAXx8vRAIdzSyyiHtG+IErWzKOZeAiCk
 S9nvH9rYIOvKKKFq9Fbfb+aQtTqkXwJsSTSM6ZyHn118DStHzQnHS9ROMoaDesmOaMfmcOZ+5vS
 JFZvQbxKoyWBkQveKAKspYuYWCNlRkcCBcxanTPsTrhOXzhL6znp/Y4HaLSNqzXYIbTGw8mVPks
 p31JVzgyFOFtdG4E=
X-Received: by 2002:a05:7022:2383:b0:12b:f616:1a31 with SMTP id
 a92af1059eb24-12ddd54063emr841603c88.6.1777386634082; Tue, 28 Apr 2026
 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260428030238.1012922-1-nichen@iscas.ac.cn>
In-Reply-To: <20260428030238.1012922-1-nichen@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 10:30:21 -0400
X-Gm-Features: AVHnY4Jy7n89_YBurjUKgHvfb7bYf2ARJpn_E1kgV-_zmnuaR81OWOt52reW4aA
Message-ID: <CADnq5_M4SO0b6GDfDTOy+hsV4PahyUBRFdXDJ=824DV7=NjPQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate include of
 dce/dmub_hw_lock_mgr.h
To: Chen Ni <nichen@iscas.ac.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Alex

On Mon, Apr 27, 2026 at 11:10=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Remove duplicate inclusion of dce/dmub_hw_lock_mgr.h in dcn42_hwseq.c to
> clean up redundant code.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index 46f2f9833d9e..3c28a840c17c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -35,7 +35,6 @@
>  #include "dc_stream_priv.h"
>  #include "dcn35/dcn35_hwseq.h"
>  #include "dcn42/dcn42_hwseq.h"
> -#include "dce/dmub_hw_lock_mgr.h"
>  #include "dio/dcn10/dcn10_dio.h"
>
>  #define DC_LOGGER \
> --
> 2.25.1
>
