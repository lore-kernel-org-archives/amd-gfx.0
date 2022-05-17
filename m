Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D661C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 13:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4632110F040;
	Tue, 17 May 2022 13:13:10 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C0B112FDF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 10:06:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AEBDF61517;
 Tue, 17 May 2022 10:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AE9C34113;
 Tue, 17 May 2022 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652781992;
 bh=HhKKBm3wiaE0xpknwdH7ZBGXkWj2DptvFeir39Hw/ek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F4nSFNRTu0P8ATljrJdxEj6spDFOWhsmBg7TkrTDh2dqNptrLPUH7PzVSw+aVXFm8
 0tPHPUBt/fc5Ue24QZByFrUBjiqMeuMx/eLrQHt5bMIT18zYXfATHho/FluGkpmYfU
 lEl1JaLzl7F1l7D07G+6GoGhkDuL5q1uj1UYXfkk=
Date: Tue, 17 May 2022 12:06:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: Re: [PATCH 1/1] drm/amd/pm: fix a potential gpu_metrics_table memory
 leak
Message-ID: <YoNzo5QonLeg9CYh@kroah.com>
References: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
X-Mailman-Approved-At: Tue, 17 May 2022 13:13:09 +0000
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
Cc: stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 05:57:46PM +0800, Yuanjun Gong wrote:
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
> 
> gpu_metrics_table is allocated in yellow_carp_init_smc_tables() but
> not freed in yellow_carp_fini_smc_tables().
> 
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e2d099409123..c66c39ccf19c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -190,6 +190,9 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
>  	kfree(smu_table->watermarks_table);
>  	smu_table->watermarks_table = NULL;
>  
> +	kfree(smu_table->gpu_metrics_table);
> +	smu_table->gpu_metrics_table = NULL;
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
