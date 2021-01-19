Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753ECC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210F820776
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210F820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC9489F2A;
	Tue, 19 Jan 2021 19:05:06 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9266789AC6;
 Tue, 19 Jan 2021 19:05:00 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id 15so22333247oix.8;
 Tue, 19 Jan 2021 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8oWrXLAyqhGVdIpunrbjvY9gUWmQiOo27UPmJWBQb6I=;
 b=eUqaI607pTbxlSpgOErc87Q6hpHT80J19IHyiHMxNbHDuZGOQLCI6TYBxKRMHU306P
 ldK6aHjB5uHDhnhomOXzVBco3tZdrAcq8jtEoE/zsu0Z7stcFR/locb6m6mb9gEp9T4+
 0AfiGNBN//4MyKuXp5NnarXgDzff1C07DtRpKAXM4oRXRx79OTp51W4GFJQlGI7bHLmn
 C5FUBOEyBZz8H7eR+iq0x2UxT6GoOdAWpsq3lLME75Lsp+2oTg6Rey17rK/DpB6t+x8i
 CbB7L7w+CdtLVrRpx3XoabZ4+qh757GYpVBrGcpq85pTaTlw/afZgMvF52BGBCMKSqTz
 lqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8oWrXLAyqhGVdIpunrbjvY9gUWmQiOo27UPmJWBQb6I=;
 b=MmiO+MbqenoEVaOwGsBZQXNYos5mbmruXmcPpT2NgHxN8ENEJTZD7Mpx6o5f7c/1Nw
 fOjjV5a7pd/n5hwhLogLfU/9iCsdd/vDoTQuJ3Qohl9SUwdwQ8ISsayNWI0LY2eeBAnL
 lZj7jzFdVWsmFq4f0ohBsCY1AGYjxfJM4AcVMjsdoCKjflaNBmYELtzx6sDGH09VGgLe
 KNMzm0EXJjh2Fvrd2CRPZnF8WsMxTU/dhdNsDd3AdbufS8aGB+u1pxGnyxiLPEYpYn1D
 um0ZsB+34Jq97afiJPdJoKdKnZFtTPSpwb4DqS1kk+kkcXRhqelyc3or2mWq+HuBaAVY
 xVWg==
X-Gm-Message-State: AOAM533c0biBkVR0HYYdqUvovLE8zCGRuhNigD10Prk1ebhjg+rEuSzH
 +xb6Wf3UZNa0ZwMll/HMqFZ01x0p/NfBCaoKwco=
X-Google-Smtp-Source: ABdhPJzq7v3OSZqVD4EFK4efcGkAAVb7AqcDOywz3xcUZ4LbVy+7kEYlsfY7hSxEd7YXRzoQUXeR93hjde7mCN21Fwc=
X-Received: by 2002:aca:6202:: with SMTP id w2mr732948oib.5.1611083099952;
 Tue, 19 Jan 2021 11:04:59 -0800 (PST)
MIME-Version: 1.0
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
 <1611003683-3534-11-git-send-email-andrey.grodzovsky@amd.com>
 <YAaLmBMlDRr56erH@kroah.com> <3650d98a-2d73-06b8-7f06-ca7728b5c4b5@amd.com>
 <YAcbIF8xaMcuSWG3@kroah.com>
In-Reply-To: <YAcbIF8xaMcuSWG3@kroah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jan 2021 14:04:48 -0500
Message-ID: <CADnq5_PNFQ+3tmRXjY2m22Pnx=neqMC_PTtqrObrdeg0LQUo_w@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] dmr/amdgpu: Move some sysfs attrs creation to
 default_attr
To: Greg KH <gregkh@linuxfoundation.org>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Qiang Yu <yuq825@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 19, 2021 at 1:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 19, 2021 at 11:36:01AM -0500, Andrey Grodzovsky wrote:
> >
> > On 1/19/21 2:34 AM, Greg KH wrote:
> > > On Mon, Jan 18, 2021 at 04:01:19PM -0500, Andrey Grodzovsky wrote:
> > > >   static struct pci_driver amdgpu_kms_pci_driver = {
> > > >           .name = DRIVER_NAME,
> > > >           .id_table = pciidlist,
> > > > @@ -1595,6 +1607,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
> > > >           .shutdown = amdgpu_pci_shutdown,
> > > >           .driver.pm = &amdgpu_pm_ops,
> > > >           .err_handler = &amdgpu_pci_err_handler,
> > > > + .driver.dev_groups = amdgpu_sysfs_groups,
> > > Shouldn't this just be:
> > >     groups - amdgpu_sysfs_groups,
> > >
> > > Why go to the "driver root" here?
> >
> >
> > Because I still didn't get to your suggestion to propose a patch to add groups to
> > pci_driver, it's located in 'base' driver struct.
>
> You are a pci driver, you should never have to mess with the "base"
> driver struct.  Look at commit 92d50fc1602e ("PCI/IB: add support for
> pci driver attribute groups") which got merged in 4.14, way back in
> 2017 :)

Per the previous discussion of this patch set:
https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg56019.html

Alex

>
> driver.pm also looks odd, but I'm just going to ignore that for now...
>
> thanks,
>
> greg k-h
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
