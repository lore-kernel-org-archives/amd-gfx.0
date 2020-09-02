Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A04C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 19:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3B6207EA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 19:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3B6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A733D6E0DF;
	Wed,  2 Sep 2020 19:20:13 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0696E500
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 19:00:11 +0000 (UTC)
IronPort-SDR: 0FBjtnJ9yTLJEVlRtt2IPD5PGJQJwdeVgfXQGjDf/KFRZQjcekrLI2nTMhldojUw0cKRiK4xKQ
 bNrYiF/LSvrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="175512367"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="175512367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 12:00:08 -0700
IronPort-SDR: j7OW7/avDkeZ25iDhgtv9HUhGze9v/ClP85tjLQYiuYANapdL8uJ9iUaxLxJo5mgXkSezY4yb4
 jb3gCjapUwPA==
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="325895891"
Received: from acduong-mobl2.amr.corp.intel.com (HELO [10.254.87.179])
 ([10.254.87.179])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 12:00:06 -0700
Subject: Re: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
Date: Wed, 2 Sep 2020 12:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 02 Sep 2020 19:20:11 +0000
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
Cc: nirmodas@amd.com, bhelgaas@google.com, luben.tuikov@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/2/20 11:42 AM, Andrey Grodzovsky wrote:
> This reverts commit 6d2c89441571ea534d6240f7724f518936c44f8d.
> 
> In the code bellow
> 
>                  pci_walk_bus(bus, report_frozen_detected, &status);
> -               if (reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> +               status = reset_link(dev, service);
> 
> status returned from report_frozen_detected is unconditionally masked
> by status returned from reset_link which is wrong.
> 
> This breaks error recovery implementation for AMDGPU driver
> by masking PCI_ERS_RESULT_NEED_RESET returned from amdgpu_pci_error_detected
> and hence skiping slot reset callback which is necessary for proper
> ASIC recovery. Effectively no other callback besides resume callback will
> be called after link reset the way it is implemented now regardless of what
> value error_detected callback returns.
> 
	}

Instead of reverting this change, can you try following patch ?
https://lore.kernel.org/linux-pci/56ad4901-725f-7b88-2117-b124b28b027f@linux.intel.com/T/#me8029c04f63c21f9d1cb3b1ba2aeffbca3a60df5

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
