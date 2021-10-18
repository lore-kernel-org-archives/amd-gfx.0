Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 12:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A20260F8F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 12:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A20260F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C10D6ED18;
	Mon, 18 Oct 2021 12:47:55 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62EC6EA54
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 12:35:26 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0857009e2a46238f1e0c2c.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:5700:9e2a:4623:8f1e:c2c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB7391EC01DF;
 Mon, 18 Oct 2021 14:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1634560524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=vqbEF5FP9dsCXB36KEnNZeMLO2o/BCdfv2yjebkACVA=;
 b=i57NcavncIptfilfxdiCIiSABiYRyZFew47ZXLOiejlgEQQ0bdjLjHGOzx+UjFgu+yBaxo
 sPglOtFaKEx4Vb9t9yk1ErYGJpydqhH8xRUa8mF8LGR2JbNymwNJBvWyIR5fBS4jKYCHLL
 4hpsvXW1W/QYpP8nFXpvH4CTL19LRgM=
Date: Mon, 18 Oct 2021 14:35:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
Subject: Re: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
Message-ID: <YW1qC21q28NsEVgk@zn.tnic>
References: <20211018073432.1525697-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211018073432.1525697-1-evan.quan@amd.com>
X-Mailman-Approved-At: Mon, 18 Oct 2021 12:47:53 +0000
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

On Mon, Oct 18, 2021 at 03:34:32PM +0800, Evan Quan wrote:
> It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
> will power off the UVD. That will make the succeeding interactions with UVD on the
> suspend path impossible. And the system will hang due to that. To workaround the
> issue, we will skip the UVD(or VCE) power off during interaction with SMU for
> suspend scenario.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I7804d3835aadbc7cf4b686da4994e83333461748
> ---
>  .../powerplay/hwmgr/smu7_clockpowergating.c   | 20 +++++++++++++++++--
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++++++++++++--
>  drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |  4 ++--
>  3 files changed, 34 insertions(+), 6 deletions(-)

Want me to run it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
