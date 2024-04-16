Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B53C04FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51A5112C5D;
	Tue, 16 Apr 2024 12:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="D7clTNir";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0878C112BBB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 10:59:54 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-56e5174ffc2so9609a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713265193; x=1713869993;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2UKnSt+Ra3Khe460qU7BpUfj0krwGdar8WNFFeRSsk=;
 b=D7clTNirqbIQvLpp9v5NHLEo5TXp1YsLzr3NyDRxywzZ5O+sFsLZJqyrACBI994SZw
 +yMhMlHw0YVeXksWPeF0iePi+oQHQxc5kPx4738E1LBqessN2tfINMZOhNnADfhHn1ZK
 SS51fqXk+F2g95WqAnpR/nWU4tiY3Tl77/BvKW/fpobfoP6lrcYnsTRkVbYpvocIumyQ
 7n5elmb6UKu7JbmOTo9W7VHZW1QVHbaJVPZqFlhRjat7ZZlPjr3Rx3C+P/T0kDjmVNLn
 UhHNF+hA4I+rBsSR/VZf87d/JfWGa4sL3VFKRfKBdD9zzaN4FSVpUQHC7w5CjAs5Iavd
 hhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713265193; x=1713869993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2UKnSt+Ra3Khe460qU7BpUfj0krwGdar8WNFFeRSsk=;
 b=iyn6UmbEns4FoPqOknRG/6t9PxUXUf3XGKgtRUFZ381zJfqHgtpGzjQPDaS86twfFK
 LsbyJ7mXSyRfgGRd5XSyCRFK9AiAF1/X392KoZlkur32I2GC2BBuo1Pi+Y4GXpEsEh9k
 wblUdgQqbUyHeQfoNMI1K3K2VOy3WVuQbyTjLMVQA35TVLZAtq77H/BDgka/NXhoD8cY
 JrFjUxMVUA2P00+HGSdJM++leb/o/LvFk9rrg5G+DMjbU4OJvRyp6INBAZZV47KCKTLH
 hX6fJVyumhM5NhsOwtCUL0ruhN259nr4eDQnyNAlDXPH25Yr2se7l9a14pgD96a1dAFe
 cu1Q==
X-Gm-Message-State: AOJu0Yw+V+gqXsRbeNgyATwpkViN2Z8ZSa02a0MySCFKBaPhhD2onzs5
 CVvKNA8J2bMQgB6VEa2zmdBiBrLZd/MBSkFpYxQA50XPwCSCIEji3qHvKYSb8jfxgTECHB4VLGa
 a4iASIxmG4s+Gl1zUZbTYGcRSV8a71aH5zeFw
X-Google-Smtp-Source: AGHT+IEsnkTZ4tRTKb8xdTMzjrb5hQabnQvJuGETU6XSXxHy6+cdCEWGRrFD60VBm50jDApquNZqfgPjxkpFLd9J3AQ=
X-Received: by 2002:a05:6402:6c6:b0:570:49e3:60a8 with SMTP id
 n6-20020a05640206c600b0057049e360a8mr40697edy.7.1713265193034; Tue, 16 Apr
 2024 03:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240412073544.10008-1-xinhui.pan@amd.com>
In-Reply-To: <20240412073544.10008-1-xinhui.pan@amd.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 16 Apr 2024 12:59:15 +0200
Message-ID: <CAG48ez2vqxbyepVTTCEYxSmBEH+c9vLUc77DCKPgNvb6LA1Z3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of bo mapping
 operations more clearly
To: xinhui pan <xinhui.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Vlad Stolyarov <hexed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Apr 2024 12:58:46 +0000
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

On Fri, Apr 12, 2024 at 9:36=E2=80=AFAM xinhui pan <xinhui.pan@amd.com> wro=
te:
> Verify the parameters of
> amdgpu_vm_bo_(map/replace_map/clearing_mappings) in one common place.
>
> Reported-by: Vlad Stolyarov <hexed@google.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Please add something like this when committing the fix:

Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR v2")
Cc: stable@vger.kernel.org
