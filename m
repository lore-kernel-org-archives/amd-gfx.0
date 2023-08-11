Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C62C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 10:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DE710E04C;
	Fri, 11 Aug 2023 10:11:16 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E599A10E04C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 10:11:14 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so10740875e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1691748673; x=1692353473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7c68Ry+oVqAuw7fO572q8W4pRoYXB7KIFLG6gYSc4wY=;
 b=CB5CWv8BiLLUlt3rXGUDRfQQrFM5pisYzEfJwqdfn+1gtMbb48PF/Az2o9hDW8Tn5P
 WwuOAg+13O+3zgCuWMOIqbe2PrtoYA4mCRr6LwS15xNEKOBKEwUPOc2p1LezcXCix0If
 lbCTE+S7aP+DfF3gOWX5x737WZtO6j73Ka809m05zvnRGVMH+l85EqHVOD+TAaRj3q+3
 p7OvysWe8sLjh/Axz0gOSlap3p4tXKxgUbXaHdKLYpakzNhsaWga/eIEwOeGt9cw/3Nl
 le6dieH2V0rhXjXrsC5LgImvkou6KVtwwgMlSgbP3k0Wi2z3mpFhi2IrUfJnCncCwLzJ
 1HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691748673; x=1692353473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7c68Ry+oVqAuw7fO572q8W4pRoYXB7KIFLG6gYSc4wY=;
 b=Ca5SSbWPoyg3Kf4AMuVxmT3Y8PF09pqQ4q2eYsTNO/nu65n16RsSCMEYKIbSSBRE0b
 wbSRsDxiMlBqDPCz07J+bEakuhxRmlMcAdz4JgJHp/V/dYZEs31IteLR0F8XCUTVb5jB
 0n4N/rFErSYHDEzzye3IkQMoLn6/s3sOLJO4LqVmSvmNwhCP7l+WG6ckfsozGPDtxkft
 rmOOc2go3Bh0s5oRvK6Yq9g3K8hDwaTIGWQ6//aVWVBOauR/iK7UnSo56kJufrz1jCG9
 1LjHvVDyZnRZFRdf4EDYggJax5yeAWrKgVOEJ33E8dfW4Ra+F22waerc+QwvOpVuksJB
 CxNQ==
X-Gm-Message-State: AOJu0YxmGJw7Sq+NVp7MX5rOepHwccp9b/3XzGmLL+gC34Fg9fJFpAJM
 2HrAZqeZrYpNtqLdS4rpraq0k1oh9WtPjRyY4CWLyQ==
X-Google-Smtp-Source: AGHT+IE50FE7shNt6YXKZmpjby+CyIWnGBigktBKuwVTC6U8UavO/ObOFDxZj5Fj2Cbr2dh5E5pRkJKSLIkr6AlCYBk=
X-Received: by 2002:a05:600c:746:b0:3f9:b867:4bb with SMTP id
 j6-20020a05600c074600b003f9b86704bbmr3943423wmn.2.1691748673122; Fri, 11 Aug
 2023 03:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230719212255.30960-1-alex.sierra@amd.com>
 <11fa116f-87a7-38c4-f266-d19354bf69fc@amd.com>
 <CAHbf0-HZNEvSN0d2Ddnwg6z500WYDd5zzbTx69bBQmOc7GF=6w@mail.gmail.com>
 <844e90ef-01ec-2ccd-de37-f383c9bb24f7@amd.com>
In-Reply-To: <844e90ef-01ec-2ccd-de37-f383c9bb24f7@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Fri, 11 Aug 2023 11:11:02 +0100
Message-ID: <CAHbf0-Fm9hqvAHgVOWGFvQqt-7QyVm+LLjDUe3_h5-uXaFMQTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 jakub.kurzak@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 3 Aug 2023 at 20:43, Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Is your kernel configured without dynamic debugging? Maybe we need to
> wrap this in some #if defined(CONFIG_DYNAMIC_DEBUG_CORE).
>

Apologies, I thought I'd replied to this, yes I didn't have dynamic
debugging enabled
