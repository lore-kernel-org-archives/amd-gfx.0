Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0A4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B669D20776
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B669D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC0B89B84;
	Tue, 19 Jan 2021 19:09:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955926E896;
 Tue, 19 Jan 2021 18:26:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E36238E4;
 Tue, 19 Jan 2021 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1611078438;
 bh=FPeoowi66cuYEM/QvCnN2TnGE7q07HMQ+jS58RGVzfo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LwEjkVXdjL/u6RJPhBOU66lJZrOZ2/wWTWTSt5QhD+gr3FAp7J38T+CLQ67iuRK/n
 QTYC23YirgfOp2kvApTeDKagS7ox7IBWI7UkZ3cs7f8HZuY29NawhhsfWYFnZoOClh
 TocnYyWH88JIhjod99iKbv2cMcjoVKnHS/iEsHeM=
Date: Tue, 19 Jan 2021 18:47:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH v4 10/14] dmr/amdgpu: Move some sysfs attrs creation to
 default_attr
Message-ID: <YAcbIF8xaMcuSWG3@kroah.com>
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
 <1611003683-3534-11-git-send-email-andrey.grodzovsky@amd.com>
 <YAaLmBMlDRr56erH@kroah.com>
 <3650d98a-2d73-06b8-7f06-ca7728b5c4b5@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3650d98a-2d73-06b8-7f06-ca7728b5c4b5@amd.com>
X-Mailman-Approved-At: Tue, 19 Jan 2021 19:09:34 +0000
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

On Tue, Jan 19, 2021 at 11:36:01AM -0500, Andrey Grodzovsky wrote:
> 
> On 1/19/21 2:34 AM, Greg KH wrote:
> > On Mon, Jan 18, 2021 at 04:01:19PM -0500, Andrey Grodzovsky wrote:
> > >   static struct pci_driver amdgpu_kms_pci_driver = {
> > >   	.name = DRIVER_NAME,
> > >   	.id_table = pciidlist,
> > > @@ -1595,6 +1607,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
> > >   	.shutdown = amdgpu_pci_shutdown,
> > >   	.driver.pm = &amdgpu_pm_ops,
> > >   	.err_handler = &amdgpu_pci_err_handler,
> > > +	.driver.dev_groups = amdgpu_sysfs_groups,
> > Shouldn't this just be:
> > 	groups - amdgpu_sysfs_groups,
> > 
> > Why go to the "driver root" here?
> 
> 
> Because I still didn't get to your suggestion to propose a patch to add groups to
> pci_driver, it's located in 'base' driver struct.

You are a pci driver, you should never have to mess with the "base"
driver struct.  Look at commit 92d50fc1602e ("PCI/IB: add support for
pci driver attribute groups") which got merged in 4.14, way back in
2017 :)

driver.pm also looks odd, but I'm just going to ignore that for now...

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
