Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FC6FD065B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F9B10E83F;
	Wed, 11 Mar 2026 08:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fl8IzYhT";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C378910E2CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 18:40:50 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ae88e16485so25594615ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773168050; x=1773772850; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
 b=Fl8IzYhTIHy16Q7wx9gCET+sngq1nVTg44hY9uKGjmPm5ZHg2GOBjTf191Hg9ThwyW
 uXkaIrFtuyed53h9xo4bKHp1hZ84VoPvLXFSyBuy3sPpS3oA2F54IY6Wmna71J+frNt9
 wnOLMWFkqZN3Kptf5O1JxkJExArGcG1kONk/bTqw3JDzETl+cdH1jbvW2K3wIIeTxRj0
 tZYIBRICV5XCGRHR+jbQKlDVIdM1WaAYOP2sTkTCFLnPXSKNuH1zd+OSrcnrZe2GTrzU
 T5s+hpI5cQj6uXg9NK+Wii511DYLJIURi/WwmNGo4KOP9PlsNZCb/se8mpkGT+luubBQ
 tL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773168050; x=1773772850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
 b=tYlSBIbK8n3oOAEm626lnBp0CdUn3KVGMdUXJTecpM5VXITqfZWSNg6ZBE2ZMn2CZI
 SnHdLsK/d5B6nm59RBxCKtZ07oA2Y9gdcYdWrAhzVffPVKDCKF9qzgBvnYzSqfGk2k2H
 OpdhdgqaD8ZLvPspQY53LfYEhJ//f7D5hl+bNDfxYmXXKKmlqHYTeIbUvvDartksCz0I
 o+X7T3kxCaI18ocwTjPALbtNEuMozYNZ7f06F/2sYpIoOtsWuxrNojbuVcb6cx/dMRzH
 GcZb3Y/URqMnYQIVOWfSiABKOwfJJmmvQfpSR3XAyg73M9Yt8uYeHKms5zITZ8SXiyAv
 pGKQ==
X-Gm-Message-State: AOJu0YzVvCwfGZID6iYH1KaQf0ugS76NTG5QKsCs+QuVEi/uDMrfIXQv
 havq+FnOy0AIxM24Vx1kZ7NsIhCZ33bFmvwmVcpLkUoCPJLEx2R+iY0R
X-Gm-Gg: ATEYQzyspI9KOOvJiJD53x6QmTfHiTI4aJ3MJOcV2AaoZUgzPW9MPnUN8yxk2v8RAga
 ASZkVU+mYBJ5DLXAwTzF7t6ajGBbW4Zf3MlYE3x90YSMhudtv1JvUoBpxV5cHniojbiHXaSzAGD
 9dNrL/VJFu5I/ORCiwwLhHzP/6GDKz1b/I8H+jD3jwL4yZs/tt7JESv11riAKTZkGOEcqh4swfB
 /BeRBpZSUrN2c1jPnLZo1vMACGTrZGL9rGgW8Q0mOfGN+mtwRO2JgvHP5WihJjU7xqIzP9Y9tj2
 jlCxbsjA3DsrOZFtSda+42jR+vgIvCA4OeQYk0HfDamdgaPOXivEgcqLZBCw52NnNkC/P+GTIuD
 a2a1r59ZhGRNo1DJqT4AM/jZyP2IczmrgQknHGHo8UZ3CoakUcr+Y8/tORm55wcVmUPKpzVCcIn
 1Fsh+Ag4sgiIjlg+Z+c5tF8PUpzbWoAovIM33PNXWvtz8Thw==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id
 d9443c01a7336-2ae8252cf0fmr96662285ad.43.1773168050081; 
 Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:2953:97d3:b283:95c3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e58592sm220535625ad.14.2026.03.10.11.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:40:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <abBlpGKO842B3yl9@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:09:27 +0000
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

Hi Philipp,

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.
> 
> Patches 55-58 may be dropped as they have a (minor?) semantic change:
> They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
> for the NULL check. Iff it is okay to print the warning also for NULL,
> then the patches can be applied.
> 
> While generating the patch set `checkpatch` complained about mixing
> [un]likely() with IS_ERR_OR_NULL(), which already uses likely()
> internally. I found and fixed several locations, where that combination
> has been used.

Thanks for the patchset. However, I think we need a explanation for why
switching to IS_ERR_OR_NULL() is an improvement over the existing code.

IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
flawed API design. It usually implies that the caller is unsure whether
a failure results in an error pointer or a NULL pointer. Rather than
doing a treewide conversion of this pattern, I believe it would be much
more meaningful to review these instances case-by-case and fix the
underlying APIs or caller logic instead.

Additionally, a treewide refactoring like this has the practical
drawback of creating unnecessary merge conflicts when backporting to
stable trees.

Regards,
Kuan-Wei
