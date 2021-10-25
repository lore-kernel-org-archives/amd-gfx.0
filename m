Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA56C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 11:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51ED60F46
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 11:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B51ED60F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382CC89E15;
	Mon, 25 Oct 2021 11:38:44 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7623389E15
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 11:38:42 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A558B61EA191D;
 Mon, 25 Oct 2021 13:38:40 +0200 (CEST)
Message-ID: <5bba36e1-6dd7-8c29-1ec5-97815c8d7dc8@molgen.mpg.de>
Date: Mon, 25 Oct 2021 13:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: I got an IOMMU IO page fault. What to do now?
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 it+linux-iommu@molgen.mpg.de
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Dear Christian,


Thank you for your reply.


On 25.10.21 13:23, Christian König wrote:

> not sure how the IOMMU gives out addresses, but the printed ones look 
> suspicious to me. Something like we are using an invalid address like -1 
> or similar.
> 
> Can you try that on an up to date kernel as well? E.g. ideally bleeding 
> edge amd-staging-drm-next from Alex repository.

These are production desktops, so I’d need to talk to the user. 
Currently, Linux 5.10.70 is running.


Kind regards,

Paul
