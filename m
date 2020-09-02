Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CCFC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 22:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0209E2078E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAKobmUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0209E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB64F89E0C;
	Wed,  2 Sep 2020 22:07:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4991089E0C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 22:07:52 +0000 (UTC)
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6FC320767;
 Wed,  2 Sep 2020 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599084472;
 bh=ntdBgUCdPt/2RWSSt3H2PeJklgTkOWgF88Cq4uej3KE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=dAKobmUHyEDygb3Qws6xA4fXIdPQQ228nmyvq/YXQ6E4wtygeRk8fTuMx2Hw1UMFI
 EdtmiYYiaHRCvJG72/Yn+j1Y0Ug11yAqRCJRfvRbH6LGAtzhKxlcPi8lzRbRxhax+4
 UUN4V1j+r0VR4MdIoAoyBgvSK96xVpJwGPlkd2MI=
Date: Wed, 2 Sep 2020 17:07:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v4 2/8] drm/amdgpu: Block all job scheduling activity
 during DPC recovery
Message-ID: <20200902220750.GA272406@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599072130-10043-3-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org,
 nirmodas@amd.com, amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
 luben.tuikov@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 02, 2020 at 02:42:04PM -0400, Andrey Grodzovsky wrote:
> DPC recovery involves ASIC reset just as normal GPU recovery so block
> SW GPU schedulers and wait on all concurrent GPU resets.

> +		 * Cancel and wait for all TDRs in progress if failing to
> +		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev

OCD typo, s/set  adev/set adev/ (two spaces)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
