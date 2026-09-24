Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC5C98321
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A11F10F922;
	Fri, 25 Sep 2026 07:39:29 +0000 (UTC)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1CD0E10E492
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 13:50:14 +0000 (UTC)
Received: from 8bytes.org
 (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de
 [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id EB1931C7465;
 Thu, 24 Sep 2026 15:50:12 +0200 (CEST)
Date: Thu, 24 Sep 2026 15:50:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, 
 "Hegde, Vasant" <Vasant.Hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, 
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>
Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
Message-ID: <arUqeEMMaqtJhery@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <arUMU5QGhb34exFV@8bytes.org>
 <BN9PR12MB51460F3605E485C66760735CF7812@BN9PR12MB5146.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51460F3605E485C66760735CF7812@BN9PR12MB5146.namprd12.prod.outlook.com>
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

On Thu, Sep 24, 2026 at 01:01:59PM +0000, Deucher, Alexander wrote:
> IOMMU tree is fine with me:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> For the series.

Alright, this is now applied, thanks!
