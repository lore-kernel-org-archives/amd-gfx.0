Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEC4C5518C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 19:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F34E20644
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SYRCFRSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F34E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A79A6E0D9;
	Wed, 22 Apr 2020 19:09:12 +0000 (UTC)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CC36E0D9;
 Wed, 22 Apr 2020 19:09:11 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ea095e20001>; Wed, 22 Apr 2020 12:07:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 22 Apr 2020 12:09:10 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 22 Apr 2020 12:09:10 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Apr
 2020 19:09:10 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 22 Apr 2020 19:09:09 +0000
Subject: Re: [PATCH hmm 0/5] Adjust hmm_range_fault() API
To: Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <17ce2fdc-4f9f-7772-c10c-6f339a4183e8@nvidia.com>
Date: Wed, 22 Apr 2020 12:09:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1587582434; bh=Ibr26mSSlFN5k8tPbVlsbPzYkk2ONJQVn8RAtNIyK9E=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=SYRCFRSghsuA1oPUGpaSrThd5bs4yjq3+gWlxe7OKwNdoqB2UOa004VsS8/Lr697y
 CWlieyjD7XPQ253DIjhDdL01VtVsGtzGEvoQqDO6lPiZ5CYv0eWmptUvjs6CnBqvRa
 4hoTO4QeEmS2vafuYzVQSMQMrQxnk3yoAyIRHCI99P9Mgj2uvXuKNUDzqFBGyVCZml
 JGQm9m8ACFaaebFyqUIUXiOiwj4oGw/DQEJJc0XtF3If903YGzmV0z3IE+sqd6zM9+
 KnxSL5/RF+iYX9gU+gjf3WtClWhx9GpAdGYAifxagOljqMjx/EX9krpg30i0tS21KU
 UXh/u9XgjPkgw==
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 4/21/20 5:21 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> The API is a bit complicated for the uses we actually have, and
> disucssions for simplifying have come up a number of times.
> 
> This small series removes the customizable pfn format and simplifies the
> return code of hmm_range_fault()
> 
> All the drivers are adjusted to process in the simplified format.
> I would appreciated tested-by's for the two drivers, thanks!

For nouveau you can add:
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
