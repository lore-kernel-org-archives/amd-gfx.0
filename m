Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB21FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 13:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4C1611AE
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 13:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B4C1611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3096E5AB;
	Fri,  5 Nov 2021 13:48:54 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94666E1E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 11:24:14 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1086009e9e3d45c680a940.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:8600:9e9e:3d45:c680:a940])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E201C1EC0298;
 Fri,  5 Nov 2021 12:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1636111452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Aqxr8Pd95kQrKyFDrBBxQT89ujoNxHPpkxPVW+mCIeA=;
 b=fuXCoGd3BbK3GEM+Kjzme6LTgOGIgKQThwcggGjgNSwmdeWdFFem2sfXrmjZ8+6TLu38o2
 uo5MIS/6DOD4baA1DnGDv93+GU39egU64JlmqaYSgLitzmV1FG2KRaQ6q5bbqJ8id2BQdI
 nX7M6Nhq4fNsLQgI35UxNDoiXhtTooI=
Date: Fri, 5 Nov 2021 12:24:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YYUUWS6vB70K2Y21@zn.tnic>
References: <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
 <YWamNaMAxaw+/9Az@zn.tnic>
 <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWfxtUusQ5w/1agx@zn.tnic>
 <DM6PR12MB26197151C642B89A9C824AA0E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB26191DEE9CEF9A1E49E62634E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB26191DEE9CEF9A1E49E62634E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Fri, 05 Nov 2021 13:48:53 +0000
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 05, 2021 at 08:05:41AM +0000, Quan, Evan wrote:
> I'm wondering are you able to give the attached patch(alone) a try.

Yap, looks good.

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
