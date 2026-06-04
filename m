Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE3BCD6E60
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 00:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEB81124CF;
	Thu,  4 Jun 2026 00:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QwjD/ni0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5531124CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 00:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55BEB601DD;
 Thu,  4 Jun 2026 00:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4F1F00899;
 Thu,  4 Jun 2026 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780531554;
 bh=AJVNEQcpf+g9Bn42mYSJGxbotg4f5LlVkQBVtMJSEdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QwjD/ni0GjaPfop3VpKjqUwgDeHPz1Gow6/PleVlw/2ZW5/16i81HEaw5+Ds3UJSb
 pxlLGZra4ntLqVmLmafar8zO5w7Rt0cbmTQlMca6Ba+jdtII+lEjnYP2SeeaDyfdpZ
 IeIuZO/URX3cUQEM07uy8tW7PP7Xe9imXj2cvAtg/M1/L/nlX/UDnkqPEHx/EW9aeH
 EumEyhGnmOJH51od4uLve5HoBHiLGQ4kMzuE2O0h6byqxKdoe0RhuiGxzyBaH2xvxM
 TTim8hPP/9VF7+sV12XG4PMbckxDUBUtyRa5kPPWDwYiO8c2xQZ440J62iboS9z+fR
 e0Q6bmAGHJtTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML
 to DC
Date: Wed,  3 Jun 2026 20:05:40 -0400
Message-ID: <20260603210831.item005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to DC
> Rebased onto 7.0.11.

Thanks for the series. Unfortunately it doesn't apply to the current
7.0.y tree: patch 3/8 creates dcn42 resource files that don't exist in
this tree, and patch 5/8 depends on dml21_wrapper_fpu.c, which is not
created in 7.0.y either.

-- 
Thanks,
Sasha
