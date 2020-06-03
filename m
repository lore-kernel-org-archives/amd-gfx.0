Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F59C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 16:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889E220679
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="JobeiE/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889E220679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B9689D79;
	Wed,  3 Jun 2020 16:57:17 +0000 (UTC)
X-Greylist: delayed 1701 seconds by postgrey-1.36 at gabe;
 Wed, 03 Jun 2020 16:18:33 UTC
Received: from ale.deltatee.com (unknown [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C35E89CB3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s/3cif5BlN62hb2u8FKCLlui3t+LBxgibxTY9R0DUY0=; b=JobeiE/aQY/hFK18f0/kCLZl/Q
 f5tI3ez8btiFjstzvfU5trH1/n5vzf3FXMsBbFCijmoEHQYke/Ds14OucL8VYkuDwl4WkUEB3/eGO
 kBcSg/Pdi67EPy9gVQkpPelF8TZhoLvMlEH+tq66pvI+2l04A6n3WEd1pTzj6Iy3iis9MJF5CVHZF
 /y18aTSYr+TY1Kr4sI4g9DqayzPiE9uQcPN9x1y7G0K+jS2723f6v/oqbXyCx8kRaj2ROH0WeqAyg
 SVgnEkDJWQOL1PmyAWDGeK6zKt8P3bQYQJwI0tWyyFgCfwplH1rkyFqj4fqbus3YgTnP0IXRIPqOT
 q3nrFLug==;
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165]
 helo=[192.168.0.12])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1jgVeY-0001wZ-5y; Wed, 03 Jun 2020 09:50:07 -0600
To: Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
 <20200603114553.12866-1-piotr.stankiewicz@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6d95be2b-017b-4558-190b-c6a252d5be7d@deltatee.com>
Date: Wed, 3 Jun 2020 09:49:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603114553.12866-1-piotr.stankiewicz@intel.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: efremov@linux.com, hkallweit1@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, kw@linux.com,
 rafael.j.wysocki@intel.com, skunberg.kelsey@gmail.com,
 andriy.shevchenko@intel.com, amurray@thegoodpenguin.co.uk,
 yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, dmaengine@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, pv-drivers@vmware.com,
 jgill@vmware.com, martin.petersen@oracle.com, jejb@linux.ibm.com,
 brking@us.ibm.com, salil.mehta@huawei.com, yisen.zhuang@huawei.com,
 irusskikh@marvell.com, kuba@kernel.org, thomas.lendacky@amd.com,
 ulf.hansson@linaro.org, adrian.hunter@intel.com, gregkh@linuxfoundation.org,
 arnd@arndb.de, mchehab@kernel.org, jgg@ziepe.ca, dledford@redhat.com,
 mike.marciniszyn@intel.com, dennis.dalessandro@intel.com, daniel@ffwll.ch,
 airlied@linux.ie, David1.Zhou@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, vkoul@kernel.org, dan.j.williams@intel.com,
 gustavo.pimentel@synopsys.com, davem@davemloft.net,
 herbert@gondor.apana.org.au, antoine.tenart@bootlin.com,
 kurt.schwemmer@microsemi.com, axboe@kernel.dk, corbet@lwn.net,
 linux-pci@vger.kernel.org, bhelgaas@google.com, piotr.stankiewicz@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 02/15] PCI: Add shorthand define for message signalled
 interrupt types
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Mailman-Approved-At: Wed, 03 Jun 2020 16:57:16 +0000
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
Cc: Krzysztof Wilczynski <kw@linux.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Igor Russkikh <irusskikh@marvell.com>, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Jim Gill <jgill@vmware.com>,
 netdev@vger.kernel.org, Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 David Zhou <David1.Zhou@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 linux-media@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Antoine Tenart <antoine.tenart@bootlin.com>,
 linux-kernel@vger.kernel.org, "James E . J . Bottomley" <jejb@linux.ibm.com>,
 Salil Mehta <salil.mehta@huawei.com>, Denis Efremov <efremov@linux.com>,
 dmaengine@vger.kernel.org, Brian King <brking@us.ibm.com>,
 VMware PV-Drivers <pv-drivers@vmware.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>, linux-mmc@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
 linux-crypto@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Kelsey Skunberg <skunberg.kelsey@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-06-03 5:45 a.m., Piotr Stankiewicz wrote:
> There are several places in the kernel which check/ask for MSI or MSI-X
> interrupts. It would make sense to have a shorthand constant, similar to
> PCI_IRQ_ALL_TYPES, to use in these situations. So add PCI_IRQ_MSI_TYPES,
> for this purpose.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Looks good to me,

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
