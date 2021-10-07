Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB95C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C2D60F90
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57C2D60F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4BC6F886;
	Thu,  7 Oct 2021 14:52:31 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F5E6F886
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 14:52:29 +0000 (UTC)
Date: Thu, 07 Oct 2021 14:52:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1633618347;
 bh=+gIOteViXdYvox5aiR3Z14PIYT653tkbpZPNaFnUvik=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=WOfeo/4/ugqHP4nGDwe1lglZAn2N7OYSu+XDyXSUsu8IAlkSa5sfFvoopZcJcs9/u
 VSakeZS3FAQ/7R66CvSDPB5SloqZWO/CWl/NXBzepeweJ1P8kzu2AFMTckLbL0c1Oj
 u6Ol1xB+uKd+R4PvsQx1x2Pxe1NNQuNHBToRVBBmznqdC5xgi6MkDIqSf8F6of/VDi
 t7PKJWS0P8CsV/tbDncx5XEPTN+tJkj75e8A2TFANH/CNBfKhRJCRb2JEbajSzFWP4
 chZLx+J1XvzVesAq5R2CM5T+p3/TskZpJ3k9Pnwkrm8TW9FJq64kmKp8VEbx+OXknL
 P4ESryZ97MEDQ==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v4 2/2] amd/display: only require overlay plane to cover
 whole CRTC on ChromeOS
Message-ID: <MMPjMlSgVA8CA8hvNljME_QHmf4kERAyHjfgj-5K5p_0HIpnFHFYgqFQvRgkJRziBEgRN-UnUIqD4b2N5_bprrVnGxcYMXfg5aEWevTiDZ0=@emersion.fr>
In-Reply-To: <a0999a42-1e0a-0d6c-af89-f8d52d9c445e@amd.com>
References: <20211006140558.254349-1-contact@emersion.fr>
 <20211006140558.254349-2-contact@emersion.fr>
 <a0999a42-1e0a-0d6c-af89-f8d52d9c445e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the review!
