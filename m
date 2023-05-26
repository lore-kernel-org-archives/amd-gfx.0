Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5151C7EE2F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 08:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623CE10E7C4;
	Fri, 26 May 2023 08:02:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20D010E093
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=vKzQlhcxkkMQoEfvC17xC/R7J7Er0cfz4WtFMuyrbs8=; b=dnAYnsr9eJUK36/YqKROOcjok7
 Y6ihOcpYfhW2J/pvOgP+eBXvG9Dm3VsVJhwM5Hu0S45bkXohWI7ckNFaeMdKR2h6pkvoS35pxqbYh
 0Or60z7pNg/fkozMkKVbLBxIrG6WIq8AHG5xVZAdIDfZlD7KOvGNaTdesCAx89kGB6UfrAY6YdbaR
 9movQHme2dhEi7AcAhlQZmmohz+gnzIIeTJZrQJFuDPJSw/lV0jy/z+zYdLOUXZR3+9bFOLP8u2DI
 /gLXN3AQlQHzU4Nj4aqM55x9u222DtlDzoP/bg7PHj9tVcHOIr3xiPuyZ4EPV6yOUoDwEehWMXxdP
 fYog8VpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q2RLw-001KMS-1q; Fri, 26 May 2023 06:55:08 +0000
Date: Thu, 25 May 2023 23:55:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
Message-ID: <ZHBXzItiT1+OSsjX@infradead.org>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
 <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
 <ZG8ud4JWpF7BXJ7c@infradead.org>
 <BL1PR12MB5144DDA502D52040945DFC4BF7469@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB5144DDA502D52040945DFC4BF7469@BL1PR12MB5144.namprd12.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Fri, 26 May 2023 08:02:57 +0000
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 08:52:06PM +0000, Deucher, Alexander wrote:
> We already handle this today for CLASS_DISPLAY via a data table provided on our hardware that details the components on the board.  The driver can then determine whether or not that combination of components is supported.  If the data table doesn't exist or isn’t parse-able, or the components enumerated are not supported, the driver doesn't load.

But things like module loading and initramfs generation still work
off the ID table and not your internal tables.

