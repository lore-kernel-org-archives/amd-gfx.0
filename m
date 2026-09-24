Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E8DC98328
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0862710F91C;
	Fri, 25 Sep 2026 07:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ox+HGiRp";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE04610E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 22:50:21 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-3411e0ace19so124149eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790290221; x=1790895021; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iN3QgyvzfZDTdr6KkDKa56Csi5I9mIhZDrQiq00doWs=;
 b=ox+HGiRpqvObPGjsLaOxejdT54AmjEra4YKyvn2EuckmVoWtGB9/ZuSELsksbWVOC+
 PUfY2D21gOQempIdTS0M8LVJO/e2CkcQCyPZ0e75sNymdI0EYcY1fRzJLN0TJHlTdwaM
 DYPasXk0XxQtZlvHVJC72+eJf33yLIUwye7hbGpweZYP9UMK+gW1mM9Fu4eBbD5YuVSl
 j+5ut17BP7aFUiZNHQb54S9pu6q05HMzD8v+PhXEYxIJyO6DXvr2qPpl6wp0QJFvDLIw
 lSWcdq8vwbvyFVheuISwUPKNhVKVuE94KRDL7TlMemnvpKMuqArFj9qahv+dOJHV9avJ
 rmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790290221; x=1790895021;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iN3QgyvzfZDTdr6KkDKa56Csi5I9mIhZDrQiq00doWs=;
 b=ER69a+PU5PVm/KLQnDQ18nVv1i841ZHrMDeolqWqZmLm8jdI1haI9a4z4pi9L9jqtM
 yhSKsqGQsTbGGbzPqAmlQhfAWbH6616m6HgMWUJc51z9gWoom1GbvlreqSm7SL4sZn1C
 kn6MgFUT0Mhwe2plbn7n5hKgJVE1ddESH9A1yooKkT/gccA0iuLsTNSeHJLaG/0FQ6Uo
 qQ5EqYa3Ugk6F4dIXGdifqIQl+xTHiRjHN8qP7vsy98G7Ge4cVROGgH5gdhFGTzc6iO1
 WSqlRObbZEEFaJ0lD7vYXqNixx4MsYJxb05pPIi3Ln2/1YkPoQEwnJfnuUkNVbUwfb4H
 2UHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDhf9/bvfptUCFywTMjPvB+A55WFC5bg5/Ds/gA8BhqCrmtDR/2pumCd6IS5nY4InnwJ98SWxN@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAnTeKxRa2n+T35QrrcRSsGHNOH3mQxPUlUwpAenX7QfYAgsUZ
 tYTLM+VrshRYgkWvyD4Fr2OqAOnNPjM6VPFHqdm/4FMqzR7oGvXwo40uCLOtSLxzW7c=
X-Gm-Gg: AYBFou0AQrjWqW6lXCA22RgMwlZ2i9LFES0rKjZmRJwTAAo+YRmVU8bHD4QSIElhbdD
 mriIkR1BdJ/HwqHxRQqzJntgOBVjodt6RwoVLEmzgMi9oV85SyyC8k51OQZncDO2vZDMA2Yw1Tm
 OfQagUef4G71eCDFoBitKNl0N6Gw7ggOEPazH14rxicHsatvX4R453o3SHlnzb17LDXipDGSFlV
 Bp86AQ9WPLZzGG4OaGQ2m2/B+2X5RiHZEfWVN23eDaiJCtR+CreAt2GnyKuNtht8YzgMr9N0tdV
 gw1xQ9F4NO9mSxkKIqOfj6NuCENc3S1h1BFcCfM7mSqzpyECgPJR2WPNYtADLY+IG9pKc6DWOz7
 Ux8aOWTozVg0UvnUvTDW7V+tDXP7R28dER/RUq4sKB1xREJNmXk2BWB860RUQYzP/H66lXuZ6EV
 8BOWKKxgSUmPBry1Dx5fM/wfRCqrMV6w0RCjvSkJQ6YdHU
X-Received: by 2002:a05:7301:18ab:b0:33c:3134:1055 with SMTP id
 5a478bee46e88-340032c267emr3017847eec.12.1790290220645; 
 Thu, 24 Sep 2026 15:50:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144173a2asm1592472eec.6.2026.09.24.15.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 15:50:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9sGg-00000000eVK-3LHc;
 Thu, 24 Sep 2026 19:50:18 -0300
Date: Thu, 24 Sep 2026 19:50:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260924225018.GB16465@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-2-mario.limonciello@amd.com>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);

Last time we hardwired the GPU and IOMMU drivers together it was a
huge mess to undo.

Why does the GPU driver have to request this? Why can't the iommu
driver know that this is a special device that can use this magic fast
path and then auto set it when identity is asked for?

How does the GPU driver even know it is magic special?

> +	/*
> +	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
> +	 * identity domain with the flag cleared, so a later bind without PerfOpt
> +	 * sees a normally-capable device. See the locking note in
> +	 * amd_iommu_enable_perfopt().
> +	 */

And this is sort of a wrong thing in the driver, it shouldn't have ATS
turned on for identitiy mappings, and it certainly shouldn't have PRI
turned on until a PRI capable domain is attached.

Jason
