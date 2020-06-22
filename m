Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAFAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F90206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k8sCtVsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F90206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5F36E5CD;
	Mon, 22 Jun 2020 13:31:25 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9B56E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 11:46:20 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id l6so11463087qkc.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NBKzXepzy68inRcMiAHpgcaZ+EYis2uiV6fI4xhZtmM=;
 b=k8sCtVsIXQZTIM44uTx5XoGTEDbrW/uXOY8fvY9Nd/4DXh4saPSxYGA0cCfUbnlyLl
 tHW4PMUz+IUIg6iJElEk/IVvMc03r9mZCDo7PkP58fQDAGJJHKTvWbHlwGlvSkCSJBE9
 Ppej67LhjF9DHjvuE14BQiJBd6KnkgcnIxlNFcmKmCUHQqePe85Gy7qlE4M8VsBeHKUS
 yKX1U0jk0j5Ks8Y76HvcbvQtdxXTdUE006wQlY/5i2fjpanXsf+qNhaiup+oN8Qg8/ox
 /U6VE787P4r0dXZDbqERqe83AX626e55WkuKobSm/QiJ7uDeG7xH7wfc6SCv8Inqo2Uq
 QFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NBKzXepzy68inRcMiAHpgcaZ+EYis2uiV6fI4xhZtmM=;
 b=kGLynzw9wz0XCDHqMQVaXBpsKyT/jobnln2sRqbg8fx2nKvM5FP6K/mm4UK5ZQvVcq
 CVK/mHEBVx/n1JhEXfkUkfSeIL5cozjqyaWOy+8Q/IV+z60QoSBenApBnLPdUMCGa3Et
 Gm2UMruDnDvwmyz1yl9u1ycdOX/GBq6l0T78WpkVmCe7JvSPkyx/ltq97LXcC6J4L4Zg
 tsMRcHlFG0yiP33rcipQsI8QfQwsD+Si2qp7zmz9eoWqZGgp4J5SYgEIZoP0d7r5Kd2/
 s06aU9kVCBVg88ql8LjbJHIU7Da6GBeCMyz+DX4+VQvtBEBPl5zu8LUO9JUJeClB4j2U
 MaIQ==
X-Gm-Message-State: AOAM531XXMd4DN7OZf6vRGDjOXy/OgRvSgxeEyUPvr59wRh3OtoaAjIY
 4dXH2HEaWFNXgVRAFdizmX/+6g==
X-Google-Smtp-Source: ABdhPJxthYjyMVCe6ZAxMUNKsmIMBTQD1YPg4YWyLhscgW6iJ+jy7QK2ERT6it0ZxPEWrnvgAqzIOg==
X-Received: by 2002:ae9:c00d:: with SMTP id u13mr15622504qkk.434.1592826379164; 
 Mon, 22 Jun 2020 04:46:19 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id r37sm14964604qtk.34.2020.06.22.04.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 04:46:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jnKu1-00Brwt-CA; Mon, 22 Jun 2020 08:46:17 -0300
Date: Mon, 22 Jun 2020 08:46:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200622114617.GU6578@ziepe.ca>
References: <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
 <20200619195538.GT6578@ziepe.ca>
 <20200619203147.GC13117@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619203147.GC13117@redhat.com>
X-Mailman-Approved-At: Mon, 22 Jun 2020 13:31:24 +0000
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Vetter <daniel.vetter@intel.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 19, 2020 at 04:31:47PM -0400, Jerome Glisse wrote:
> Not doable as page refcount can change for things unrelated to GUP, with
> John changes we can identify GUP and we could potentialy copy GUPed page
> instead of COW but this can potentialy slow down fork() and i am not sure
> how acceptable this would be. Also this does not solve GUP against page
> that are already in fork tree ie page P0 is in process A which forks,
> we now have page P0 in process A and B. Now we have process A which forks
> again and we have page P0 in A, B, and C. Here B and C are two branches
> with root in A. B and/or C can keep forking and grow the fork tree.

For a long time now RDMA has broken COW pages when creating user DMA
regions.

The problem has been that fork re-COW's regions that had their COW
broken.

So, if you break the COW upon mapping and prevent fork (and others)
from copying DMA pinned then you'd cover the cases.

> Semantic was change with 17839856fd588f4ab6b789f482ed3ffd7c403e1f to some
> what "fix" that but GUP fast is still succeptible to this.

Ah, so everyone breaks the COW now, not just RDMA..

What do you mean 'GUP fast is still succeptible to this' ?

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
