Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DB1C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 18:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B1510F9E0;
	Mon,  7 Feb 2022 18:44:19 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD01410F854
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 18:08:40 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id m7so13617012pjk.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zYdhIytWWvNZPQpgxc7JanMz43mOjz+UXOqpB/Si8gY=;
 b=R93xjTEs3HgPo29762m4uqHy6DgEIiw341Wvf7q57zjQt/fMOf/vIggnLWq+UIkvE2
 ItYfM1ocg4jOoHter+LGmVVn+56WIrTresjlRqOzDpxhR2gE2Z7XKfivMQnYws3oBpcN
 Wnp4OjEX2kVSHOm5wWUaWUQHoBL2pZOajsCNpVYP+2s7M4Pt370NfYYH6tCLMb0ePa8z
 HUeyronXi33SaNNHMgqIF/E3v+pRpLWgtLiP7uZ593CHEdxKAHCZRXlItwp/sNFJZgmH
 Q6m9V+2GxeMGSIE/EyF8AlQqUfCTIeQOL4NCF8eo53fHgen+/6rfpdiFIvCtnwfrEBzm
 8haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zYdhIytWWvNZPQpgxc7JanMz43mOjz+UXOqpB/Si8gY=;
 b=VT3AOCHHrmSI8vP5ihnE3Hf+uEVCiC3b6H3pKlniwFupoqiTFRkTQXncqmyGAr8HHn
 /ljVvRVtRi8wgt8U699HnoMd+smusIRtVxQL/QEDIJDfwuSrZIY7OZDum1ll+rBUUeeO
 ZFWKAW3Rn40m2NzsIAOXaxoeYVnHpHHklPhNAvgoByDGJyUDwbmzCuGhi8Ysz8gGBf2u
 VRKMh/bxfdIOPg4JhDEia9vRXWoyYzpGKcDCs9H1CyvI9SOfqYQAUZpxMFpvHx0TWdPn
 I4fR7EYcm5sTVPcZp2F0zv/g36vkqRKxUAH8LntnYUY0MG0kHcaRjREJhoiV35EXusid
 W/9w==
X-Gm-Message-State: AOAM531TTioktVmliFHxFfPVVUxc6mt1DHlMISdrsr035oJXluY+guIp
 rLJIZlVJViTSAx0vUUfrmyQi3vs1wnzcYFA6/74g3w==
X-Google-Smtp-Source: ABdhPJzkFzzjmqODkvgrvwQLNfbzdHBUvOVv75drXwoWtoHzOi4Qr8amdduzRjHB4i+xpu3YrgRs1ma/CEMYchNDNj0=
X-Received: by 2002:a17:90b:1bcc:: with SMTP id
 oa12mr121877pjb.93.1644257320409; 
 Mon, 07 Feb 2022 10:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-3-hch@lst.de>
In-Reply-To: <20220207063249.1833066-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Feb 2022 10:08:29 -0800
Message-ID: <CAPcyv4i3hJR9WBh6PFN9VgA0p3x4Vvgdy6T3b-3_bP_LaPK9fg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 07 Feb 2022 18:44:17 +0000
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 Ralph Campbell <rcampbell@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Karol Herbst <kherbst@redhat.com>, Linux MM <linux-mm@kvack.org>,
 nouveau@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> __KERNEL__ ifdefs don't make sense outside of include/uapi/.

Yes.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
