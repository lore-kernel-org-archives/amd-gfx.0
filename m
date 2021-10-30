Return-Path: <SRS0=zsti=PS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF76BC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 14:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A903C60EB8
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 14:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A903C60EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65C16E044;
	Sat, 30 Oct 2021 14:41:20 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD266E044
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Oct 2021 14:41:19 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id k8so4727912oik.7
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Oct 2021 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CEuSTg/bdf73waQUw/2crk8IK/rKRNrhyX3VUnwoWRk=;
 b=lQ3dE+8+dF0unUvENMHj1dY9N1SSehE8B0tY1Qz4XOgBAFu0m/tXmLUJwvfg94RPsj
 Jv5dWzch9uPyudyzQL70ziS9LonEh9EdOWjn86HYTC4fDF7mxxBGGf6wrByRWLPJ0SiD
 GvZBhuHTENDTj5p+iMVWdr04WKUvsMJEwz7BXVB5Le33SMOLFNSziXchjhHPaDPiV/XD
 G8xWO6fUq/kEzWNLRgjaMaE6oxBpLQzxYgyxxohb8j9T3NV+bss4XLajvzRJFIjF5gKl
 QykOkeFW6mz1/YTeYeB288Fb6j980x3YViLwEmcGGUAzZEEojPL/mx55fgrF9P2HOwmI
 7yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CEuSTg/bdf73waQUw/2crk8IK/rKRNrhyX3VUnwoWRk=;
 b=P+Ciz8aUVAhKzsVrJZHUqGTlCvIw2Ncc0bBnoDwukebSb482meJBy9rwsCc7MuXnfy
 WN3VfCq1cLVqN67wZSHZWkkkpyzQ2wwiK/bLWMLnhtyl04rCTzOg5LF9DNhI07mNd9mN
 hp3p47w+yXL0LlTJDxsQefA/QzAAry+8Mu6zZiOFaNhEv4Jfa4tSaywmPiI2zvdsIujJ
 7xqUSz9006QqBqtPeSzHGjRmt4HqdpDSXKKXtSuA/lJajOs/kjrR3CnbhAJgX+U1AQ8S
 epZd8DOiRKyN2xTLtU07+hjMWOGAyGvYpRhBgKcUE2yFjSindfxXc5Y+7/LPAgWaHwAa
 h0iQ==
X-Gm-Message-State: AOAM533gDOVow7e4WcyGd93aHuY9MXBDn6TgnVZdf9h5gGJ2x8DzqpFG
 1LwtC1aFihOPeFfecdFL3amSChvQglA33e3epCTTQUqV544etw==
X-Google-Smtp-Source: ABdhPJwDruMIHXtK19xRtMP+B660p4bx74+0yI1CYEmOWZlac0ZLS5VZJ/cXrrSZL1TIGsgJF8+XKzOC5cWRrmRFkjk=
X-Received: by 2002:a05:6808:1527:: with SMTP id
 u39mr12614116oiw.123.1635604879024; 
 Sat, 30 Oct 2021 07:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211717.28519-1-mario.limonciello@amd.com>
 <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 30 Oct 2021 10:41:08 -0400
Message-ID: <CADnq5_PDhA61gJYTPg3Dn=zy0hrt2ZJJN4TYm5WJRQfACrjDbg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 29, 2021 at 11:49 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [Public]
>
>
> Instead of ASIC check better to do the check based on ppt_func->get_power_profile_mode. If function is NULL/not implemented, drop the attribute.
>

The pointer is always there at the subsystem level.  E.g.,
smu_get_power_profile_mode()

Alex

> Thanks,
> Lijo
