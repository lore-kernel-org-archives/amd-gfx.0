Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D35DEE20AB
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182BB10E7D7;
	Fri,  6 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gb0wZeMu";
	dkim-atps=neutral
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6622410E8F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:58:47 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id
 6a1803df08f44-89461ccc46eso22871286d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 06:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770303526; x=1770908326; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6paZ1/dfF6ZJkTrV436UqQ3Veg/Kl0esrhdcHdeVKCQ=;
 b=Gb0wZeMuhvGggNJtvOLX5qNFM8HEZ4zEgS71O8+VEXArvd623WtcKh7W/r9Hcbc3gQ
 ablGTnr1XXk9YcMOmUvfRk4V8T3++hsbs2dn+1mOAPxI2Qib9KsNA/RAi/rCpOAHKbfp
 /4lPBir3uIeZ3/VFyh/SEv0eWQ8+mLZWZibIO4HvCPPc61nMMvFhaQVfhcNRZ0kBq0Xg
 fHnP2Wqq6I6qLhEOfAAfak3zu/V5IiB6DWrt0tOc6qZnmwGpUnaD3EVfkOKLqzVZxEJL
 YrHmsEd53RRqUpazI90S+vrFMRPY9GcCZfwBve6npUFxQnsJVVi/3sRS2E53vcxmeiOR
 3cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770303526; x=1770908326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6paZ1/dfF6ZJkTrV436UqQ3Veg/Kl0esrhdcHdeVKCQ=;
 b=mLj0qNOz4DQly/36Bd2NNY8RZ/sUmvYWBw9YSgihC+IeJWGzq5SKBqQ+5lMT5mk8J/
 rP6bH+jUrTn3sL9dRA/rdg1ze/uVLNEXYitFZfPKBGPK3wBpLu9dk+SCqxhBxHf7IXOa
 YvqkB0fo6TheT5gdCf5fHYk3/9i9Srvuh5qf4VUvuPkVeEzC9Pi9Vp3BWJD8n9qR7zVB
 32jxaexRdoawcBpC05pnHAiQql86/sL/bleNXKdERvAF+1iTf6JVlWSXkLkLtV3GeP8E
 Xnol9rYzZJ7zwuX18dxcJptI+FDQbV+z1njTl4cU83l8Xv82Lny76HgBYsfAoE2E8H/i
 Vuiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX1KjzjAQkQqRkoen3Nt5pzMrxYviticBUEjPR5woZjo5X9tIfSmMvxwUL20p+iQqjnUnNZymw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLLx7pkOUXXMKzZsQGE9DZVggNdVLy/OwgT3ZFBktOi+CT+BG6
 ZfjnxO7N8vlEnz5hWkA9CBnAbYpl6CS4MLa9YqkwiufgE1Ap4BlNTOPRDZA8mFISCi8=
X-Gm-Gg: AZuq6aKkmRVuaUNvw/sj9XbChYiw9tdKphcOOeCB23DrfguXIrfg9xh9Ti9k6OZVHGu
 XGaDh62F5zzzis4i2mV3lt+iVp74DdNL4ufIAdtbcRBx3iFevT3T3XhJLNGhWbAYsiBj5f8yIkd
 KNEjpKNStorHwpalyBG994X3XfKf4aOgEEQ3/o+9DT99UlS0AzZZkFVBApcrz5wxcbhdDfotsnq
 WJcYXtO3q+iWEuPvDsTStFrESVs7FB4p1KuH++eQK044q/haNM3St0yMK/O/GzKGH0FyqIezpTD
 VNraECrR4x2gFdo2YcN9TiNdgQRJd5GauIIuht5ndQvzFmA4bIDNsxy4JktqoTA/nHvaoGWcBj4
 QaEW9BkR+BIAUGWpAPiKp9IGoaWzqlbLIl1AOIHYkgYmXhEPJaFsyaaV8GFV18WgvF10BzwGF1V
 M0eyl7vx3ikHxccTP7NKioBC+lrCrnY7tWIleug9w2PyUjriEQjHs/f/46ti/w8Qb1EEE=
X-Received: by 2002:ad4:5bc1:0:b0:894:6d0b:502 with SMTP id
 6a1803df08f44-895221eff32mr95805386d6.59.1770303526139; 
 Thu, 05 Feb 2026 06:58:46 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521bffb41sm43278866d6.4.2026.02.05.06.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:58:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vo0of-00000000zky-02N9;
 Thu, 05 Feb 2026 10:58:45 -0400
Date: Thu, 5 Feb 2026 10:58:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leon@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260205145844.GM2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
 <20260204095659.5a983af2@shazbot.org>
 <ac33ad1a-330c-4ab5-bb98-4a4dedccf0da@amd.com>
 <20260205121945.GC12824@unreal> <20260205142111.GK2328995@ziepe.ca>
 <f27ad57b-d935-4ffa-a65c-9f6b5d9a1f9a@amd.com>
 <1b7ee5ad-6dde-415a-8e06-93daddc9bcef@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7ee5ad-6dde-415a-8e06-93daddc9bcef@app.fastmail.com>
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

On Thu, Feb 05, 2026 at 07:41:11AM -0700, Alex Williamson wrote:
> >> From https://anongit.freedesktop.org/git/drm/drm-misc
> >>  * branch                          drm-misc-next -> FETCH_HEAD
> >> 
> >> $ git show FETCH_HEAD
> >> commit 779ec12c85c9e4547519e3903a371a3b26a289de
> >> Author: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>
> >> Date:   Tue Feb 3 16:48:46 2026 +0300
> >> 
> >>     drm/komeda: fix integer overflow in AFBC framebuffer size check
> >> 
> >> $ git merge-base  FETCH_HEAD 61ceaf236115f20f4fdd7cf60f883ada1063349a
> >> 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> >> $ git describe --contains 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> >> v6.19-rc6^0
> >> 
> >> $ git log --oneline 61ceaf236115f20f4fdd7cf60f883ada1063349a ^FETCH_HEAD
> >> 61ceaf236115f2 vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF
> >> 
> >> Just pull Alex's tree, the drm-misc-next tree already has v6.19-rc6,
> >> so all they will see is one extra patch from Alex in your PR.
> >> 
> >> No need to backmerge, this is normal git stuff and there won't be
> >> conflicts when they merge a later Linus tag.
> >
> > Correct, but that would merge the same patch through two different 
> > trees. That is usually a pretty big no-go.
> 
> Applying the patch through two different trees is a no-go, but
> merging the same commit from a shared branch or tag is very common
> and acceptable.  It's the same commit after all, there is no
> conflict, no duplicate commit.  When the trees are merged, the
> commit will exist once in the log.  Thanks,

+1

This is how shared branches work. There is no issue here.

Jason
