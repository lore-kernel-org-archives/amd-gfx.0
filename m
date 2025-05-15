Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB13C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850A710E207;
	Thu, 15 May 2025 09:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="LDuEZ8Qu";
	dkim-atps=neutral
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4365210E220
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1747301446; x=1747560646;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=LDuEZ8QuNc64e4a2XfphIbyrOwDLWKCIMf9cYvWvw2Jv/E3nUsAyqKsNfim2p9j5l
 DzjGicG10/HBNpor9OsLEy2+CgCM8fxOQKkkBVtwo8vR0ySp/VTSP0fbDpuTdqBBMl
 vGVRl+YJvYNzlU8eTs88T/fl8RcrPQ/9S/eX05Ug0cTJcy3xBWGORQJFSI61+rJ4Bl
 GxF6Z3sZq3VUB92x1Vzux6urF4tI8FdrA5xyboMJc/2jPfaF7jlk+Xg+MzBXdPpGxC
 pauFbNk47nRMkvYM2muzQUZYRRrJSPatNwYmR/xoGd8hvpd+dowe/KTjN8hMvs/NUS
 43twFNMg+Npmw==
Date: Thu, 15 May 2025 09:30:41 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com,
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, mwen@igalia.com,
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com,
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org,
 xaver.hugl@gmail.com, victoria@system76.com, daniel@ffwll.ch,
 uma.shankar@intel.com, quic_naseer@quicinc.com, quic_cbraga@quicinc.com,
 quic_abhinavk@quicinc.com, marcan@marcan.st, Liviu.Dudau@arm.com,
 sashamcintosh@google.com, chaitanya.kumar.borah@intel.com,
 louis.chauvet@bootlin.com, Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH V9 03/43] drm/doc/rfc: Describe why prescriptive color
 pipeline is needed
Message-ID: <20zKjcJZzrPPBvQPqfSipG5vOLLKux9Rzy8_hJE3Ukfnxzcdrti9S5NPVZN8iM52qD3OEQ-2R5rH_uRvA8XRl1tbPUB-PPZFvTOgYETqbQc=@emersion.fr>
In-Reply-To: <20250430011115.223996-4-alex.hung@amd.com>
References: <20250430011115.223996-1-alex.hung@amd.com>
 <20250430011115.223996-4-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 9e5219d5fb00eb9d82d8685d2d340850e56b0be4
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Simon Ser <contact@emersion.fr>
