Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DAECAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D3710E8BD;
	Wed,  8 Oct 2025 18:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="KGATDjkr";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63F210E8BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1759948285; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BscNQKanofZ5lwG3BGO6vS/Qz1naKrt1SIV2MAE4Q0TIFp+WQTEnjSUCEcGbdQ6q4hExBr5eeoWVQgQq8GeA3YHV/QVSvOJMuDfuonpx32Sejt4Hm4hyAABHCOAYjVEn21VEporLfKnx8lFSLl3HSOEhJoJgEBFZm3MZNmTnxG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1759948285;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lvXGdnVgonOgdLvbhWQEUEgbN6LIn7iY2LpSfjGokF0=; 
 b=IxXPGfe4jxyoi4ktcpeo9ZDk0Ka3eP0hqW1XMnicIUNSsg46Wkdp2uB/eeMRgDSpkfbm5Eqermig182sesZwJEQrqsDWLaFUDgbmpSIjYFhe8rR0WXhbktxlHRzDXYLTOAQT7XgCouED3EY19UngI6i8YH8xLAmEyBzGwOI6moU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
 dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759948285; 
 s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=lvXGdnVgonOgdLvbhWQEUEgbN6LIn7iY2LpSfjGokF0=;
 b=KGATDjkrrXUzDHnA/G2uVFE1nHenxiXQcXKmaKoFeX9dvC0OmetWwk4vAiHFy6LG
 CCLyenf+xNjSlBaqI1hrdKV5KaCxF/ZNYiRutGpbDRlNDlMBn6xdkXSOp/tYLCcOEcc
 U3XI3PKeEUL6rPLCsWGK8PWuU+wDg6/sHqL+mpnE=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1759948253449207.8309816630358;
 Wed, 8 Oct 2025 11:30:53 -0700 (PDT)
Date: Wed, 08 Oct 2025 19:30:53 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Mario Limonciello" <superm1@kernel.org>
Cc: "amd-gfx" <amd-gfx@lists.freedesktop.org>,
 "Lijo Lazar" <Lijo.Lazar@amd.com>
Message-ID: <199c51728f5.778006f5430494.3779269787170457909@collabora.com>
In-Reply-To: <76272528-5167-445d-9a71-5c693323da8d@kernel.org>
References: <20251007164116.371340-1-bob.beckett@collabora.com>
 <20251007193110.763709-1-bob.beckett@collabora.com>
 <76272528-5167-445d-9a71-5c693323da8d@kernel.org>
Subject: Re: [PATCH v2 0/5] Adjustment to power limit setting
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
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


 ---- On Tue, 07 Oct 2025 20:40:43 +0100  Mario Limonciello <superm1@kernel.org> wrote --- 
 > On 10/7/25 2:31 PM, Bob Beckett wrote:
 > > --- quoted message ---
 > >> From: Robert Beckett <bob.beckett@collabora.com>
 > >>> Lijo pointed out to me that
 > >>> commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
 > >>> commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
 > >>> both should be unnecessary because smu_restore_dpm_user_profile() already
 > >>> restores them.  However in looking at the code there is a case that isn't
 > >>> properly restored - the FAST PPT limits supported by Van Gogh. The nuance
 > >>> isn't immediately obvious because the limit variable is overloaded with
 > >>> limit type.
 > >>> This series attempts to address that issue by passing limit type around
 > >>> and saving/restoring both types.
 > >>> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
 > >>> Mario Limonciello (5):
 > >>>    drm/amd: Remove some unncessary header includes
 > >>>    drm/amd: Stop overloading power limit with limit type
 > >>>    drm/amd: Save and restore all limit types
 > >>>    drm/amd: Drop calls to restore power limit and clock from smu_resume()
 > >>>    drm/amd: Adjust whitespace for vangogh_ppt
 > >>>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 > >>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 > >>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 > >>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 > >>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +--
 > >>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 40 ++++++++-----------
 > >>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 > >>>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++---
 > >>>   8 files changed, 29 insertions(+), 42 deletions(-)
 > >>> -- 
 > >>> 2.51.0
 > >> entire series
 > >> Tested-by: Robert Beckett <bob.beckett@collabora.com>
 > > 
 > > apologies, I need to retract this Tested-by.
 > > I inadvertently tested v1. v2 looks like it still has the restore issue.
 > > I'll debug and get back to you.
 > 
 > Oh thanks for getting back.  Let me hold up our merge on the patches 
 > then too.
 > 

The issue with v2 turned out to be quite simple in the end.
You dropped 

drm/amd: Drop superfluous call to set_power_limit()

from v1.
picking that on top of v2 series makes it work again, so assuming v3 adds this back, have another:

entire series
Tested-by: Robert Beckett <bob.beckett@collabora.com>

