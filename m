Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48036C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 12:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C47160C4B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 12:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C47160C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5376E162;
	Thu, 14 Oct 2021 12:48:39 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00096EC31
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 09:00:42 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0c72004cd8e1678c0b16c3.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0c:7200:4cd8:e167:8c0b:16c3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BFA11EC051F;
 Thu, 14 Oct 2021 11:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1634202040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=uSz2rZqEKZN/XdUySfMH+peSlaVrF7M5smPXGUk4r04=;
 b=py0fiiXqmN4jbKVkmkgXgCjskD/5/p9CDRsJlpMaz9oqtYXNXNUsNehQrYc48UOPDwzUEz
 jBdJHy8+T7bSJqN9Rab31QNGnNChHOiW2EPvJ11ToTdZxLRfc2eVRje4E/vjnc9FxuGyqs
 43/6QqBPR8VM/LPLAs3OrDmgrv6u+5Q=
Date: Thu, 14 Oct 2021 11:00:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YWfxtUusQ5w/1agx@zn.tnic>
References: <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
 <YWamNaMAxaw+/9Az@zn.tnic>
 <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 14 Oct 2021 12:48:37 +0000
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

On Thu, Oct 14, 2021 at 02:02:48AM +0000, Quan, Evan wrote:
> [Quan, Evan] Yes, but not(apply them) at the same time. One by one as you did before.
> - try the patch1 first

Ok, first patch worked fine.

> - undo the changes of patch1 and try patch2

Did that, worked fine too except after the first resume cycle, the video
didn't continue playing.

Then I restarted the video and did a couple more suspend cycles to see
if it would not continue again. In the subsequent tries it would resume
fine and the video would continue playing too.

So I'm going to chalk that single case of halted video with the second
patch to a resume glitch or so.

Btw, I don't have pm-suspend on that box but I did suspend to RAM
assuming this is what you wanted, which is done as root with two
commands:

# echo "suspend" > /sys/power/disk
# echo "mem" > /sys/power/state

If you want me to do more extensive testing, just shoot.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
