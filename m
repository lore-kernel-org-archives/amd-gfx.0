Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62977C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22CA60720
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E22CA60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59936E14F;
	Wed, 11 Aug 2021 14:55:05 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979AB6E122;
 Wed, 11 Aug 2021 14:53:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215164148"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; d="scan'208";a="215164148"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2021 07:53:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; d="scan'208";a="571158048"
Received: from watoney1-mobl.amr.corp.intel.com (HELO
 skuppusw-mobl5.amr.corp.intel.com) ([10.209.129.121])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2021 07:53:40 -0700
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
Date: Wed, 11 Aug 2021 07:53:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 11 Aug 2021 14:54:58 +0000
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



On 7/27/21 3:26 PM, Tom Lendacky wrote:
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> new file mode 100644
> index 000000000000..f8ed7b72967b
> --- /dev/null
> +++ b/include/linux/protected_guest.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky<thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _PROTECTED_GUEST_H
> +#define _PROTECTED_GUEST_H
> +
> +#ifndef __ASSEMBLY__

Can you include headers for bool type and false definition?

--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -12,6 +12,9 @@

  #ifndef __ASSEMBLY__

+#include <linux/types.h>
+#include <linux/stddef.h>

Otherwise, I see following errors in multi-config auto testing.

include/linux/protected_guest.h:40:15: error: unknown type name 'bool'
include/linux/protected_guest.h:40:63: error: 'false' undeclared (first use in this functi


> +
> +#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
> +#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
> +#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
> +#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
> +
> +#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
> +
> +#include <asm/protected_guest.h>
> +
> +#else	/* !CONFIG_ARCH_HAS_PROTECTED_GUEST */
> +
> +static inline bool prot_guest_has(unsigned int attr) { return false; }
> +
> +#endif	/* CONFIG_ARCH_HAS_PROTECTED_GUEST */
> +
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif	/* _PROTECTED_GUEST_H */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
