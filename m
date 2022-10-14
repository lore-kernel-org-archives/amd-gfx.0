Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA19C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 07:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C0210ECB3;
	Mon, 17 Oct 2022 07:11:20 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F8C10E154
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 23:06:12 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id y72so6603748oia.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=pBydm9UD129IOeeGX+/MkspdGPkcPbOeKiRleGj7zus=;
 b=c3mjrs3tKP6qdga5RssEtakxCoRUpvt3TnJZWGEFq6BUQjdjmPavTzx9+7G8H5K0iZ
 eApJ7EnPHlv26p0X2J2+GUeOXhsYVPPVBskZp+SaP7/keeu1UGQuBEPns89XcPIenk0k
 oWihOP1DbIqIAUL276Ir2j1cb3SnCjyCNWsfsw7neym0Qig+q9PP9ZjVy977ZTMHEGhP
 4kOZsefhc5JQpNf0tS5OCmpNzQNW0h4dQhcJBjWWtiArSTo2BfmNbZqUBOme0hQ2ZAf2
 qTFQbMqYfXIwWM2fRndA/93btV93GocMdjf/dj1UJVLXscocGksuqt2siXA0cdjN5yW8
 iaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBydm9UD129IOeeGX+/MkspdGPkcPbOeKiRleGj7zus=;
 b=Z8w2D9lfsGOQTKBozT1/BZqijWtmgcaMuIe7GRxlJpWXyLCMjZpcVOw3SV5fnXfsh5
 VT/Ijk7fe6/kNmN3Y2YTskyDrdU5wJF3Q5bk3Z6xzbwDWmXW5FM8E4nGovSahzYhVrng
 Xn65sNG7IFAJnsn8kLBBNO2KqTmNejgN0HhhubXIGK9x4/3eBVZASpbw9B44itrDQJFG
 nkroGaEfQzdSOhbDgy6rk6KXP7L3X7B8B7vSkjkqtrhQ2hnXsFnmwOHHl9I4a17N5wAb
 ETy4uNr+SxgGOwpcjRTQgHgnnakqScsbP4XA9rTt4MDs4lzJB0D0A1RDEsyWmk6Kj+h+
 sTBg==
X-Gm-Message-State: ACrzQf1FnW758gyUalWGcfiTOOW135qAXcMDS/STBFH9L/vVIby37kAq
 0xDdXU5bUxWj4aq14fera0A=
X-Google-Smtp-Source: AMsMyM528GLeGCIqfYOFy2VuddYF7meq2M6fmEVevMlc/b758vw60WBJPmsGKPFdYLgDHlKvX3gEAQ==
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr8327210oib.194.1665788771285; 
 Fri, 14 Oct 2022 16:06:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a9d4c08000000b0063696cbb6bdsm1729205otf.62.2022.10.14.16.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 16:06:10 -0700 (PDT)
Date: Fri, 14 Oct 2022 16:06:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix vblank refcount in vrr transition
Message-ID: <20221014230608.GA4126267@roeck-us.net>
References: <20221014141524.GA4063757@roeck-us.net>
 <BL0PR12MB2532EED10D577BC1481D2946ED249@BL0PR12MB2532.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB2532EED10D577BC1481D2946ED249@BL0PR12MB2532.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Mon, 17 Oct 2022 07:11:15 +0000
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 14, 2022 at 02:27:35PM +0000, Li, Yunxiang (Teddy) wrote:
> [AMD Official Use Only - General]
> 
> > This patch results in a large number of compile errors if CONFIG_DEBUG_FS=n. Reverting it fixes the problem.
> >
> > This is an architecture independent problem.
> >
> > Guenter
> 
> Oops, seem to be because at amdgpu_dm.c:8328 the } should be inside the #endif not outside.
> 
Already fixed upstream.

Guenter
