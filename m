Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B2606A31C
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Nov 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlVhCNmT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE5010E538;
	Sat, 28 Nov 2026 16:27:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C46310E538;
 Sat, 28 Nov 2026 16:27:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20DFC43DDC;
 Sat, 28 Nov 2026 16:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C518B1F00897;
 Sat, 28 Nov 2026 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795883255;
 bh=CXil4VOGraqpZ2eYEMoRrcRFtM4DvIVOojFMGlNJIgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NlVhCNmTRAo8Is2lVf2sYoWmEGH4Vl1WQzbhlW2T5CP5pBgy/6b9gD1q6BXhkrg3p
 ECPVCvQs16eRCXpVqNIVsAiPSeazrsVGmdNEnCW7UH3nqH7h/HmsaA803zYN3EzO5L
 /FDtFhBIzBR0VhVp2HLyVlEjJrEViR+Do460RfmtgHKedwTbZt88AFP9Rmnj5J+Agv
 CN9+4Wq/vRW89EIszaqnrNNyKlGMG57iZkLmldjy7D+enKRjK1G0KWo3ykVUr8XYa3
 oGkO/xizV9+ZJzwiclD4hPImPCB6TS0WXoc6SEF2OWq+K3wTVuZxM9xxKXhIJ87uDf
 QpReqaKkEeWzQ==
Date: Sat, 28 Nov 2026 09:27:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch
Subject: Re: [pull] amdgpu, amdkfd, radeon, PCI drm-next-7.5
Message-ID: <20261128162731.GA2970083@ax162>
References: <20261126142342.1491061-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126142342.1491061-1-alexander.deucher@amd.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

On Thu, Nov 26, 2026 at 09:23:42AM -0500, Alex Deucher wrote:
>       drm/amdgpu: Add imu v13 ip block v2

This patch breaks the build:

  https://lore.kernel.org/20261128-amdgpu-uninitialized-data-imu_v13_0-v1-1-e2c0ddb75ee7@kernel.org/

-- 
Cheers,
Nathan
