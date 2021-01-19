Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1638C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 08:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73E522241
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 08:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73E522241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D1C6E846;
	Tue, 19 Jan 2021 08:37:39 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0338989FCE;
 Tue, 19 Jan 2021 07:34:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56BDE2072D;
 Tue, 19 Jan 2021 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1611041692;
 bh=IHictolKla5yDu5FZfUO1rh8bRpb2Cxn0PR9IXxBXwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pJKRUktF0pMQuMXzTCJGj7MDGmt/AtfrCiFcDtu5XCvqdrT91p/6j4CVfFcreyO9H
 7mFm5luE+1mPdszP4lE09aW/dhF6tvRNrp8g2mrMvhdHgbTCuYvUyIlILY+lfoi4jK
 wV47cLYq5Tw4FYaWLBZMtvLaxw7n7ImDGvXZh9tA=
Date: Tue, 19 Jan 2021 08:34:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v4 10/14] dmr/amdgpu: Move some sysfs attrs creation to
 default_attr
Message-ID: <YAaLmBMlDRr56erH@kroah.com>
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
 <1611003683-3534-11-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611003683-3534-11-git-send-email-andrey.grodzovsky@amd.com>
X-Mailman-Approved-At: Tue, 19 Jan 2021 08:37:38 +0000
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
Cc: robh@kernel.org, ckoenig.leichtzumerken@gmail.com,
 dri-devel@lists.freedesktop.org, eric@anholt.net, ppaalanen@gmail.com,
 amd-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 Alexander.Deucher@amd.com, yuq825@gmail.com, Harry.Wentland@amd.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 18, 2021 at 04:01:19PM -0500, Andrey Grodzovsky wrote:
>  static struct pci_driver amdgpu_kms_pci_driver = {
>  	.name = DRIVER_NAME,
>  	.id_table = pciidlist,
> @@ -1595,6 +1607,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>  	.shutdown = amdgpu_pci_shutdown,
>  	.driver.pm = &amdgpu_pm_ops,
>  	.err_handler = &amdgpu_pci_err_handler,
> +	.driver.dev_groups = amdgpu_sysfs_groups,

Shouldn't this just be:
	groups - amdgpu_sysfs_groups,

Why go to the "driver root" here?

Other than that tiny thing, looks good to me, nice cleanup!

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
