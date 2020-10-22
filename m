Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E791DC388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AF322249
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfhNMyMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AF322249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2196F550;
	Thu, 22 Oct 2020 13:59:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9486F554;
 Thu, 22 Oct 2020 13:54:20 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D64E22275;
 Thu, 22 Oct 2020 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603374859;
 bh=k/96McXBUQrMgM4y/fJNrw43hXeNtSxVU6BUe2aasrQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JfhNMyMoeo79vFKGh2kPdEK6Z9KBVoCnHEiWkZoBbSOYVIyDiVjzohSe9tyINoAEu
 oQ0dY0PKFot074Qy8U0+2w1ZtMNyp1HRdU4TTmBWVu4+9DC+f2dCt3amempuKh7ErT
 xcK5tj42W5UNWipPg8217GvuzCo3QQf1TRVGoBfQ=
Date: Thu, 22 Oct 2020 15:54:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 4/5] gpu: drm: amdgpu: Replace
 snprintf() with sysfs_emit()
Message-ID: <20201022135455.GA1788090@kroah.com>
References: <cover.1603371258.git.sylphrenadin@gmail.com>
 <f6107f3e467f1906abdcc33d35f13cf54f7e5a96.1603371258.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6107f3e467f1906abdcc33d35f13cf54f7e5a96.1603371258.git.sylphrenadin@gmail.com>
X-Mailman-Approved-At: Thu, 22 Oct 2020 13:59:31 +0000
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 22, 2020 at 07:17:56PM +0530, Sumera Priyadarsini wrote:
> Using snprintf() for show() methods holds the risk of buffer overrun
> as snprintf() does not know the PAGE_SIZE maximum of the temporary
> buffer used to output sysfs content.
> 
> Modify amdgpu_psp.c to use sysfs_emit() instead which knows the
> size of the temporary buffer.
> 
> Issue found with Coccinelle.
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d6c38e24f130..4d1d1e1b005d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2621,7 +2621,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
>  		return ret;
>  	}
>  
> -	return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
> +	return sysfs_emit(buf, PAGE_SIZE, "%x\n", fw_ver);

Did you build this code?  I don't think it is correct...

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
