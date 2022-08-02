Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2D4C00140
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Aug 2022 15:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4A690A75;
	Tue,  2 Aug 2022 15:58:25 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9FD909C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Aug 2022 15:58:10 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ly05C1YSQz9sbf;
 Tue,  2 Aug 2022 17:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1659455887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJqOYs0GHxSFTqQfPfg3KuMTkufHrRfiISdJws+NYds=;
 b=h7kTuMhRDqegUuyYTlPY36fHK9mWVaS+ukadPgQAUzk5bmrtPHBGicUMRwK3ijysnFXV1D
 8C5WqZshI/R9KN9In7sZAff+UQJF6BM4YIIuJ4J+X7FmsoduMNVDb3USPCfWUXmoSrl4vI
 StlIk9kAY7j1u6YGHxUYFxUkTcL8a5lHSGHsbm399GDKPuA3OTPVMuYD+oPLMx5aW/cEir
 1MNhVJF9YtD4cBVFkAV15jZVGU5x1CDHR6i5DsYCrO+tyI6Xcxjn1frPcPczqYAv5mhebL
 OOzBDXDSf/N2d+8hmrf8/VBa8FxbmVN7pWGc2TAjQ838mA5663Krizb5wSJ2Xw==
Message-ID: <9e342f6f-cfac-83df-3b03-ee1d095d27ce@mailbox.org>
Date: Tue, 2 Aug 2022 17:58:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] amdgpu: add context creation flags in CS IOCTL
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20220802135558.6324-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220802135558.6324-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 55df6e19b7f0057d5ef
X-MBO-RS-META: jprsc7hk3rfkd8aasqqzfetfgagcto4m
X-Rspamd-Queue-Id: 4Ly05C1YSQz9sbf
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Marek Olsak <marek.olsak@amd.com>,
 Amarnath Somalapuram <amaranath.somalapuram@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-08-02 15:55, Shashank Sharma wrote:
> This patch adds:
> - A new input parameter "flags" in the amdgpu_ctx_create2 call.
> - Some new flags defining workload type hints.
> - Some change in the caller function of amdgpu_ctx_create2, to
>   accomodate this new parameter.
> 
> The idea is to pass the workload hints while context creation, so
> that kernel GPU scheduler can pass this information to GPU FW, which in
> turn can adjust the GPU characterstics as per the workload type.
> 
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marek Olsak <marek.olsak@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Amarnath Somalapuram <amaranath.somalapuram@amd.com>
> ---
>  amdgpu/amdgpu.h          |  2 ++
>  amdgpu/amdgpu_cs.c       |  5 ++++-
>  include/drm/amdgpu_drm.h | 10 +++++++++-

See include/drm/README on how to handle changes to include/drm/*_drm.h .


Also, libdrm changes are now reviewed and merged as GitLab merge requests: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

