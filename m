Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8062FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 15:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F6E10E7B1;
	Tue, 26 Apr 2022 15:29:36 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913DE10E7B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 15:29:34 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id p12so6581777pfn.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lZlT5pXPhHWSQcE2RTzBIz/G9KbrNns2EdBS7uY3x2A=;
 b=A0wOIbREZiPNRR1QF0NoGkT8Pnea9QnGqzGpH7RIUvzWOmDWmYwlkJKTI1rYUxe2ql
 lZD0v80/AgREwqwHoiSEd253EOQEtDoScWZ64Xaw4RffpeHpTAVYLTKkTeKp/c2artXO
 sPUmXYYnIozzL2qkIO51PtOf1hj0ORfI92gpl0YPzSatmZd91Foq403vBAh288rE0TSp
 jg5UyOzadMJXLUkBEFqOp4kH+RUweDN5DcNwel6bbmsZiseFz2aEnMYrLC6DEhWXFL34
 9soNzY/U7RhrjCk0SaNDJ/gWKsROUfivZMgxNTlj/XISyzKDIDfXQ/pa/ljWTXHdfGTY
 f6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lZlT5pXPhHWSQcE2RTzBIz/G9KbrNns2EdBS7uY3x2A=;
 b=CmFHsQVvd3YOxO0H8YKtQWqCdDsINR1+nn1AqQoG2REnyB2akLiCy0WMM4zid7PMtB
 35OICBZSWh39lsUEIdDxAD/F2QKQIFWTN7eGk/m5896LDMekAhQtml/NDd1jT3fzJW+D
 /R1ycgeLgg3+5pD4jwQ25bldueZ1aog9mVgzkhE+gYB0dmSyhD7xIHDe5+9FIGOky1NK
 S/qhcWhpUqhaAX+4zAJ0aDShHM6N9LHX4aq0EZ1rQFgX5/RLxHJ8ZoIMxdL6IXAxMRGx
 u52oF9RSOWii7gc0YJH4q5++nuL+fve4HJoAi9yXluEoXFUq1PQK/VlzGrd3h9WBr0bW
 egmg==
X-Gm-Message-State: AOAM532Spfn3guvVUR5x9ExIpLMbOczIbHi9kCILpsrYctESA+0SZ7iu
 N++XU1dvF4LSpx/QN+HPVi1o0AHxxNnnY9WpzP7bJw==
X-Google-Smtp-Source: ABdhPJwqACommhKnL7qSrJ6YAagLB0IEz2Ib+KMdLue5Akk8HtOkmOAXaz5YrH/P8tuhLsjVBcrMI1BMHIjw4rYj+eU=
X-Received: by 2002:a63:7d04:0:b0:378:fb34:5162 with SMTP id
 y4-20020a637d04000000b00378fb345162mr19713715pgc.487.1650986969341; Tue, 26
 Apr 2022 08:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220407054651.3924-1-Arunpravin.PaneerSelvam@amd.com>
In-Reply-To: <20220407054651.3924-1-Arunpravin.PaneerSelvam@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 26 Apr 2022 16:29:17 +0100
Message-ID: <CAHbf0-H5uE4RtZwY0L8Wz0VG6QnU1+E3yhg3fDFVc3n__=nrNQ@mail.gmail.com>
Subject: Re: [PATCH v12] drm/amdgpu: add drm buddy support to amdgpu
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
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
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, matthew.auld@intel.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

I'm having issues with this patch on my PRIME system and vulkan workloads

https://gitlab.freedesktop.org/drm/amd/-/issues/1992

Is there any chance you could take a look?

Cheers

Mike
